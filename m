Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88A6317F41
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 19:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfEHRnT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 13:43:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41834 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729105AbfEHRnT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 May 2019 13:43:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB3F280D;
        Wed,  8 May 2019 10:43:18 -0700 (PDT)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5105B3F575;
        Wed,  8 May 2019 10:43:17 -0700 (PDT)
From:   douglas.raillard@arm.com
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        quentin.perret@arm.com, douglas.raillard@arm.com,
        patrick.bellasi@arm.com, dietmar.eggemann@arm.com
Subject: [RFC PATCH 6/7] sched/cpufreq: Improve sugov_cpu_is_busy accuracy
Date:   Wed,  8 May 2019 18:43:00 +0100
Message-Id: <20190508174301.4828-7-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190508174301.4828-1-douglas.raillard@arm.com>
References: <20190508174301.4828-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Douglas RAILLARD <douglas.raillard@arm.com>

Avoid assuming a CPU is busy when it has begun being idle before
get_next_freq() is called. This is achieved by making sure the CPU will
not be detected as busy by other CPUs whenever its utilization is
decreasing.

Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 42 ++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index a12b7e5bc028..ce4b90cafbb5 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -62,6 +62,7 @@ struct sugov_cpu {
 	/* The field below is for single-CPU policies only: */
 #ifdef CONFIG_NO_HZ_COMMON
 	unsigned long		saved_idle_calls;
+	unsigned long		previous_util;
 #endif
 };
 
@@ -181,14 +182,35 @@ static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
 	return ret;
 }
 
-static void sugov_cpu_is_busy_update(struct sugov_cpu *sg_cpu)
+static void sugov_cpu_is_busy_update(struct sugov_cpu *sg_cpu,
+				     unsigned long util)
 {
 	unsigned long idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
 	sg_cpu->saved_idle_calls = idle_calls;
+
+	/*
+	 * Make sure that this CPU will not be immediately considered as busy in
+	 * cases where the CPU has already entered an idle state. In that case,
+	 * the number of idle_calls will not vary anymore until it exits idle,
+	 * which would lead sugov_cpu_is_busy() to say that this CPU is busy,
+	 * because it has not (re)entered idle since the last time we looked at
+	 * it.
+	 * Assuming cpu0 and cpu1 are in the same policy, that will make sure
+	 * this sequence of events leads to right cpu1 business status from
+	 * get_next_freq(cpu=1)
+	 * cpu0: [enter idle] -> [get_next_freq] -> [doing nothing] -> [wakeup]
+	 * cpu1:                ...              -> [get_next_freq] ->   ...
+	 */
+	if (util <= sg_cpu->previous_util)
+		sg_cpu->saved_idle_calls--;
+
+	sg_cpu->previous_util = util;
 }
 #else
 static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
-static void sugov_cpu_is_busy_update(struct sugov_cpu *sg_cpu) {}
+static void sugov_cpu_is_busy_update(struct sugov_cpu *sg_cpu
+				     unsigned long util)
+{}
 #endif /* CONFIG_NO_HZ_COMMON */
 
 /**
@@ -507,10 +529,9 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	if (!sugov_should_update_freq(sg_policy, time))
 		return;
 
-	busy = sugov_cpu_is_busy(sg_cpu);
-	sugov_cpu_is_busy_update(sg_cpu);
-
 	util = sugov_get_util(sg_cpu);
+	busy = sugov_cpu_is_busy(sg_cpu);
+	sugov_cpu_is_busy_update(sg_cpu, util);
 	max = sg_cpu->max;
 	util = sugov_iowait_apply(sg_cpu, time, util, max);
 	next_f = get_next_freq(sg_policy, util, max);
@@ -545,12 +566,15 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned long util = 0, max = 1;
 	unsigned int j;
+	unsigned long sg_cpu_util = 0;
 
 	for_each_cpu(j, policy->cpus) {
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
 		unsigned long j_util, j_max;
 
 		j_util = sugov_get_util(j_sg_cpu);
+		if (j_sg_cpu == sg_cpu)
+			sg_cpu_util = j_util;
 		j_max = j_sg_cpu->max;
 		j_util = sugov_iowait_apply(j_sg_cpu, time, j_util, j_max);
 
@@ -560,6 +584,14 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 		}
 	}
 
+	/*
+	 * Only update the business status if we are looking at the CPU for
+	 * which a utilization change triggered a call to get_next_freq(). This
+	 * way, we don't affect the "busy" status of CPUs that don't have any
+	 * change in utilization.
+	 */
+	sugov_cpu_is_busy_update(sg_cpu, sg_cpu_util);
+
 	return get_next_freq(sg_policy, util, max);
 }
 
-- 
2.21.0

