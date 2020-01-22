Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04BC0145AEE
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 18:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgAVRgS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 12:36:18 -0500
Received: from foss.arm.com ([217.140.110.172]:59034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgAVRgR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Jan 2020 12:36:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED08A11D4;
        Wed, 22 Jan 2020 09:36:16 -0800 (PST)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9E3BC3F6C4;
        Wed, 22 Jan 2020 09:36:15 -0800 (PST)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc:     douglas.raillard@arm.com, dietmar.eggemann@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org
Subject: [RFC PATCH v4 4/6] sched/cpufreq: Introduce sugov_cpu_ramp_boost
Date:   Wed, 22 Jan 2020 17:35:36 +0000
Message-Id: <20200122173538.1142069-5-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122173538.1142069-1-douglas.raillard@arm.com>
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
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

This ramp boost is computed as the difference between util_avg and
util_est_enqueued. This number somehow represents a lower bound of how
much extra utilization this tasks is actually using, compared to our
best current stable knowledge of it (which is util_est_enqueued).

When the set of runnable tasks changes, the boost is disabled as the
impact of blocked utilization on util_avg will make the delta with
util_est_enqueued not very informative.

Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 608963da4916..25a410a1ff6a 100644
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
@@ -183,6 +187,42 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
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
+	 * we only trigger boosting when the "amount of work" enqueued
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
@@ -514,6 +554,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	busy = !sg_policy->need_freq_update && sugov_cpu_is_busy(sg_cpu);
 
 	util = sugov_get_util(sg_cpu);
+	sugov_cpu_ramp_boost_update(sg_cpu);
 	max = sg_cpu->max;
 	util = sugov_iowait_apply(sg_cpu, time, util, max);
 	next_f = get_next_freq(sg_policy, util, max);
@@ -554,6 +595,8 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 		unsigned long j_util, j_max;
 
 		j_util = sugov_get_util(j_sg_cpu);
+		if (j_sg_cpu == sg_cpu)
+			sugov_cpu_ramp_boost_update(sg_cpu);
 		j_max = j_sg_cpu->max;
 		j_util = sugov_iowait_apply(j_sg_cpu, time, j_util, j_max);
 
-- 
2.24.1

