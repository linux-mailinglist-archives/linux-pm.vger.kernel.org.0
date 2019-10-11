Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0764D41AE
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 15:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfJKNpm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Oct 2019 09:45:42 -0400
Received: from foss.arm.com ([217.140.110.172]:60928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728684AbfJKNpm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Oct 2019 09:45:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 237C21597;
        Fri, 11 Oct 2019 06:45:42 -0700 (PDT)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 733BF3F68E;
        Fri, 11 Oct 2019 06:45:40 -0700 (PDT)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, douglas.raillard@arm.com,
        dietmar.eggemann@arm.com, qperret@qperret.net,
        patrick.bellasi@matbug.net, dh.han@samsung.com
Subject: [RFC PATCH v3 4/6] sched/cpufreq: Introduce sugov_cpu_ramp_boost
Date:   Fri, 11 Oct 2019 14:44:58 +0100
Message-Id: <20191011134500.235736-5-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011134500.235736-1-douglas.raillard@arm.com>
References: <20191011134500.235736-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the utilization signals dynamic to detect when the utilization of a
set of tasks starts increasing because of a change in tasks' behavior.
This allows detecting when spending extra power for faster frequency
ramp up response would be beneficial to the reactivity of the system.

This ramp boost is computed as the difference
util_avg-util_est_enqueued. This number somehow represents a lower bound
of how much extra utilization this tasks is actually using, compared to
our best current stable knowledge of it (which is util_est_enqueued).

When the set of runnable tasks changes, the boost is disabled as the
impact of blocked utilization on util_avg will make the delta with
util_est_enqueued not very informative.

Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 44 ++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index aab8c0498dd1..c118f85d1f3d 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -61,6 +61,10 @@ struct sugov_cpu {
 	unsigned long		bw_dl;
 	unsigned long		max;
 
+	unsigned long		ramp_boost;
+	unsigned long		util_est_enqueued;
+	unsigned long		util_avg;
+
 	/* The field below is for single-CPU policies only: */
 #ifdef CONFIG_NO_HZ_COMMON
 	unsigned long		saved_idle_calls;
@@ -181,6 +185,42 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
 	}
 }
 
+static unsigned long sugov_cpu_ramp_boost(struct sugov_cpu *sg_cpu)
+{
+	return READ_ONCE(sg_cpu->ramp_boost);
+}
+
+static unsigned long sugov_cpu_ramp_boost_update(struct sugov_cpu *sg_cpu)
+{
+	struct rq *rq = cpu_rq(sg_cpu->cpu);
+	unsigned long util_est_enqueued;
+	unsigned long util_avg;
+	unsigned long boost = 0;
+
+	util_est_enqueued = READ_ONCE(rq->cfs.avg.util_est.enqueued);
+	util_avg = READ_ONCE(rq->cfs.avg.util_avg);
+
+	/*
+	 * Boost when util_avg becomes higher than the previous stable
+	 * knowledge of the enqueued tasks' set util, which is CPU's
+	 * util_est_enqueued.
+	 *
+	 * We try to spot changes in the workload itself, so we want to
+	 * avoid the noise of tasks being enqueued/dequeued. To do that,
+	 * we only trigger boosting when the "amount of work' enqueued
+	 * is stable.
+	 */
+	if (util_est_enqueued == sg_cpu->util_est_enqueued &&
+	    util_avg >= sg_cpu->util_avg &&
+	    util_avg > util_est_enqueued)
+		boost = util_avg - util_est_enqueued;
+
+	sg_cpu->util_est_enqueued = util_est_enqueued;
+	sg_cpu->util_avg = util_avg;
+	WRITE_ONCE(sg_cpu->ramp_boost, boost);
+	return boost;
+}
+
 /**
  * get_next_freq - Compute a new frequency for a given cpufreq policy.
  * @sg_policy: schedutil policy object to compute the new frequency for.
@@ -512,6 +552,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	busy = !sg_policy->need_freq_update && sugov_cpu_is_busy(sg_cpu);
 
 	util = sugov_get_util(sg_cpu);
+	sugov_cpu_ramp_boost_update(sg_cpu);
 	max = sg_cpu->max;
 	util = sugov_iowait_apply(sg_cpu, time, util, max);
 	next_f = get_next_freq(sg_policy, util, max);
@@ -552,6 +593,8 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 		unsigned long j_util, j_max;
 
 		j_util = sugov_get_util(j_sg_cpu);
+		if (j_sg_cpu == sg_cpu)
+			sugov_cpu_ramp_boost_update(sg_cpu);
 		j_max = j_sg_cpu->max;
 		j_util = sugov_iowait_apply(j_sg_cpu, time, j_util, j_max);
 
@@ -561,6 +604,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 		}
 	}
 
+
 	return get_next_freq(sg_policy, util, max);
 }
 
-- 
2.23.0

