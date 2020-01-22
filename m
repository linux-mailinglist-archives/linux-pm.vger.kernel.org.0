Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3583145AEA
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 18:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgAVRgY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 12:36:24 -0500
Received: from foss.arm.com ([217.140.110.172]:59070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgAVRgU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Jan 2020 12:36:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0807412FC;
        Wed, 22 Jan 2020 09:36:20 -0800 (PST)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AD5493F6C4;
        Wed, 22 Jan 2020 09:36:18 -0800 (PST)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc:     douglas.raillard@arm.com, dietmar.eggemann@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org
Subject: [RFC PATCH v4 6/6] sched/cpufreq: Add schedutil_em_tp tracepoint
Date:   Wed, 22 Jan 2020 17:35:38 +0000
Message-Id: <20200122173538.1142069-7-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122173538.1142069-1-douglas.raillard@arm.com>
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
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
index 7457e238e1b7..a3df4e915f5b 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -525,6 +525,15 @@ DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
 
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
index 9a7617ea7bf4..8909c752c06f 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -14,6 +14,8 @@
 #include <linux/sched/cpufreq.h>
 #include <trace/events/power.h>
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(schedutil_em_tp);
+
 #define IOWAIT_BOOST_MIN	(SCHED_CAPACITY_SCALE / 8)
 
 struct sugov_tunables {
@@ -225,7 +227,7 @@ static unsigned long sugov_cpu_ramp_boost_update(struct sugov_cpu *sg_cpu)
 
 /**
  * get_next_freq - Compute a new frequency for a given cpufreq policy.
- * @sg_policy: schedutil policy object to compute the new frequency for.
+ * @sg_cpu: schedutil CPU object to compute the new frequency for.
  * @util: Current CPU utilization.
  * @max: CPU capacity.
  * @boost: Extra power that can be spent on top of the minimum amount of power
@@ -248,22 +250,28 @@ static unsigned long sugov_cpu_ramp_boost_update(struct sugov_cpu *sg_cpu)
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
@@ -562,7 +570,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
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
 	}
 
-	return get_next_freq(sg_policy, util, max, ramp_boost);
+	return get_next_freq(sg_cpu, util, max, ramp_boost);
 }
 
 static void
-- 
2.24.1

