Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B79DED41B3
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 15:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfJKNps (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Oct 2019 09:45:48 -0400
Received: from foss.arm.com ([217.140.110.172]:60978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728713AbfJKNps (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Oct 2019 09:45:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFDE51000;
        Fri, 11 Oct 2019 06:45:47 -0700 (PDT)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 16B923F68E;
        Fri, 11 Oct 2019 06:45:45 -0700 (PDT)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, douglas.raillard@arm.com,
        dietmar.eggemann@arm.com, qperret@qperret.net,
        patrick.bellasi@matbug.net, dh.han@samsung.com
Subject: [RFC PATCH v3 6/6] sched/cpufreq: Add schedutil_em_tp tracepoint
Date:   Fri, 11 Oct 2019 14:45:00 +0100
Message-Id: <20191011134500.235736-7-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011134500.235736-1-douglas.raillard@arm.com>
References: <20191011134500.235736-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce a new tracepoint reporting the effect of using the Energy
Model inside get_next_freq() in schedutil.

Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
---
 include/trace/events/power.h     |  9 +++++++++
 kernel/sched/cpufreq_schedutil.c | 20 ++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index f7aece721aed..87a14f5208a7 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -529,6 +529,15 @@ DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
 
 	TP_ARGS(name, type, new_value)
 );
+
+DECLARE_TRACE(schedutil_em_tp,
+	TP_PROTO(unsigned int cpu, unsigned long util,
+		unsigned int cost_margin, unsigned int policy_cost_margin,
+		unsigned int base_freq, unsigned int boosted_freq),
+	TP_ARGS(cpu, util, cost_margin, policy_cost_margin, base_freq,
+		boosted_freq)
+);
+
 #endif /* _TRACE_POWER_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 7c1a749fb6ef..076bbb69ff42 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -14,6 +14,8 @@
 #include <linux/sched/cpufreq.h>
 #include <trace/events/power.h>
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(schedutil_em_tp);
+
 #define IOWAIT_BOOST_MIN	(SCHED_CAPACITY_SCALE / 8)
 
 struct sugov_tunables {
@@ -223,7 +225,7 @@ static unsigned long sugov_cpu_ramp_boost_update(struct sugov_cpu *sg_cpu)
 
 /**
  * get_next_freq - Compute a new frequency for a given cpufreq policy.
- * @sg_policy: schedutil policy object to compute the new frequency for.
+ * @sg_cpu: schedutil CPU object to compute the new frequency for.
  * @util: Current CPU utilization.
  * @max: CPU capacity.
  * @boost: Extra power that can be spent on top of the minimum amount of power
@@ -246,22 +248,28 @@ static unsigned long sugov_cpu_ramp_boost_update(struct sugov_cpu *sg_cpu)
  * next_freq (as calculated above) is returned, subject to policy min/max and
  * cpufreq driver limitations.
  */
-static unsigned int get_next_freq(struct sugov_policy *sg_policy,
+static unsigned int get_next_freq(struct sugov_cpu *sg_cpu,
 				  unsigned long util, unsigned long max,
 				  unsigned long boost)
 {
+	struct sugov_policy *sg_policy = sg_cpu->sg_policy;
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned int freq = arch_scale_freq_invariant() ?
 				policy->cpuinfo.max_freq : policy->cur;
 	struct em_perf_domain *pd = sugov_policy_get_pd(sg_policy);
+	unsigned int base_freq;
 
-	freq = map_util_freq(util, freq, max);
+	base_freq = map_util_freq(util, freq, max);
 
 	/*
 	 * Try to get a higher frequency if one is available, given the extra
 	 * power we are ready to spend.
 	 */
-	freq = em_pd_get_higher_freq(pd, freq, boost);
+	freq = em_pd_get_higher_freq(pd, base_freq, boost);
+
+	trace_schedutil_em_tp(sg_cpu->cpu, util,
+				 sugov_cpu_ramp_boost(sg_cpu), boost,
+				 base_freq, freq);
 
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
 		return sg_policy->next_freq;
@@ -560,7 +568,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	ramp_boost = sugov_cpu_ramp_boost_update(sg_cpu);
 	max = sg_cpu->max;
 	util = sugov_iowait_apply(sg_cpu, time, util, max);
-	next_f = get_next_freq(sg_policy, util, max, ramp_boost);
+	next_f = get_next_freq(sg_cpu, util, max, ramp_boost);
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
 	 * recently, as the reduction is likely to be premature then.
@@ -616,7 +624,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 	}
 
 
-	return get_next_freq(sg_policy, util, max, ramp_boost);
+	return get_next_freq(sg_cpu, util, max, ramp_boost);
 }
 
 static void
-- 
2.23.0

