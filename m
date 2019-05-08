Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08E4517F42
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 19:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfEHRnV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 13:43:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41840 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729122AbfEHRnV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 May 2019 13:43:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D6C0A78;
        Wed,  8 May 2019 10:43:20 -0700 (PDT)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 138AB3F575;
        Wed,  8 May 2019 10:43:18 -0700 (PDT)
From:   douglas.raillard@arm.com
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        quentin.perret@arm.com, douglas.raillard@arm.com,
        patrick.bellasi@arm.com, dietmar.eggemann@arm.com
Subject: [RFC PATCH 7/7] sched/cpufreq: Boost schedutil frequency ramp up
Date:   Wed,  8 May 2019 18:43:01 +0100
Message-Id: <20190508174301.4828-8-douglas.raillard@arm.com>
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

In some situations, it can be interesting to spend temporarily more
power if that can give a useful frequency boost.

The sugov_cpu_is_busy() heuristic is reused to check if there has been
some idle time on all CPUs in the considered perf domain since last call
to schedutil's get_next_freq(). If not, it is assumed that at least one
CPU is in a frequency ramp up phase and the domain will be allowed to
spend extra power to reach a stable OPP in a shorter amount of time.

Since the extra power expenditure is bounded, it cannot skyrocket even
on platforms with a large number of cores in the same frequency domain
and/or very high ratio between lowest and highest OPP cost.

Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index ce4b90cafbb5..513b32bf14c5 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -218,6 +218,8 @@ static void sugov_cpu_is_busy_update(struct sugov_cpu *sg_cpu
  * @sg_policy: schedutil policy object to compute the new frequency for.
  * @util: Current CPU utilization.
  * @max: CPU capacity.
+ * @busy: true if at least one CPU in the policy is busy, which means it had no
+ *	idle time since its last frequency change.
  *
  * If the utilization is frequency-invariant, choose the new frequency to be
  * proportional to it, that is
@@ -231,20 +233,28 @@ static void sugov_cpu_is_busy_update(struct sugov_cpu *sg_cpu
  *
  * Take C = 1.25 for the frequency tipping point at (util / max) = 0.8.
  *
+ * An energy-aware boost is then applied if busy is true. The boost will allow
+ * selecting frequencies at most twice as costly in term of energy.
+ *
  * The lowest driver-supported frequency which is equal or greater than the raw
  * next_freq (as calculated above) is returned, subject to policy min/max and
  * cpufreq driver limitations.
  */
 static unsigned int get_next_freq(struct sugov_policy *sg_policy,
-				  unsigned long util, unsigned long max)
+				  unsigned long util, unsigned long max,
+				  bool busy)
 {
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned int freq = arch_scale_freq_invariant() ?
 				policy->cpuinfo.max_freq : policy->cur;
 	struct em_perf_domain *pd = sugov_policy_get_pd(sg_policy);
 
-	/* Maximum power we are ready to spend. */
-	unsigned int cost_margin = 0;
+	/*
+	 * Maximum power we are ready to spend.
+	 * When one CPU is busy in the policy, we apply a boost to help it reach
+	 * the needed frequency faster.
+	 */
+	unsigned int cost_margin = busy ? 1024/2 : 0;
 
 	freq = map_util_freq(util, freq, max);
 
@@ -534,7 +544,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	sugov_cpu_is_busy_update(sg_cpu, util);
 	max = sg_cpu->max;
 	util = sugov_iowait_apply(sg_cpu, time, util, max);
-	next_f = get_next_freq(sg_policy, util, max);
+	next_f = get_next_freq(sg_policy, util, max, busy);
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
 	 * recently, as the reduction is likely to be premature then.
@@ -567,6 +577,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 	unsigned long util = 0, max = 1;
 	unsigned int j;
 	unsigned long sg_cpu_util = 0;
+	bool busy = false;
 
 	for_each_cpu(j, policy->cpus) {
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
@@ -577,6 +588,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 			sg_cpu_util = j_util;
 		j_max = j_sg_cpu->max;
 		j_util = sugov_iowait_apply(j_sg_cpu, time, j_util, j_max);
+		busy |= sugov_cpu_is_busy(j_sg_cpu);
 
 		if (j_util * max > j_max * util) {
 			util = j_util;
@@ -592,7 +604,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 	 */
 	sugov_cpu_is_busy_update(sg_cpu, sg_cpu_util);
 
-	return get_next_freq(sg_policy, util, max);
+	return get_next_freq(sg_policy, util, max, busy);
 }
 
 static void
-- 
2.21.0

