Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDE5758820
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 19:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfF0RQ1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 13:16:27 -0400
Received: from foss.arm.com ([217.140.110.172]:59266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfF0RQ0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Jun 2019 13:16:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4FF0147A;
        Thu, 27 Jun 2019 10:16:25 -0700 (PDT)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4EB723F718;
        Thu, 27 Jun 2019 10:16:24 -0700 (PDT)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, quentin.perret@arm.com,
        douglas.raillard@arm.com, patrick.bellasi@arm.com,
        dietmar.eggemann@arm.com
Subject: [RFC PATCH v2 5/5] sched/cpufreq: Boost schedutil frequency ramp up
Date:   Thu, 27 Jun 2019 18:16:03 +0100
Message-Id: <20190627171603.14767-6-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627171603.14767-1-douglas.raillard@arm.com>
References: <20190627171603.14767-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In some situations, it can be interesting to spend temporarily more
power if that can give a useful frequency boost.

Use the new sugov_cpu_ramp_boost() function to drive an energy-aware
boost, on top of the minimal required frequency.

As that boost number is not accurate (and cannot be without a crystal
ball), we only use it in a way that allows direct control over the power
it is going to cost. This allows keeping a platform-independant level of
control over the average power, while allowing for frequency bursts when
we know a (set of) tasks can make use of it.

In shared policies, the maximum of all CPU's boost is used. Since the
extra power expenditure is bounded, it cannot skyrocket even on
platforms with a large number of cores in the same frequency domain
and/or very high ratio between lowest and highest OPP cost.

Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 3eabfd815195..d70bbbeaa5cf 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -217,6 +217,9 @@ static unsigned long sugov_cpu_ramp_boost_update(struct sugov_cpu *sg_cpu,
  * @sg_policy: schedutil policy object to compute the new frequency for.
  * @util: Current CPU utilization.
  * @max: CPU capacity.
+ * @boost: Extra power that can be spent on top of the minimum amount of power
+ *	required to meet capacity requirements, as a percentage between 0 and
+ *	EM_COST_MARGIN_SCALE.
  *
  * If the utilization is frequency-invariant, choose the new frequency to be
  * proportional to it, that is
@@ -235,7 +238,8 @@ static unsigned long sugov_cpu_ramp_boost_update(struct sugov_cpu *sg_cpu,
  * cpufreq driver limitations.
  */
 static unsigned int get_next_freq(struct sugov_policy *sg_policy,
-				  unsigned long util, unsigned long max)
+				  unsigned long util, unsigned long max,
+				  unsigned long boost)
 {
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned int freq = arch_scale_freq_invariant() ?
@@ -248,7 +252,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	 * Try to get a higher frequency if one is available, given the extra
 	 * power we are ready to spend.
 	 */
-	freq = em_pd_get_higher_freq(pd, freq, 0);
+	freq = em_pd_get_higher_freq(pd, freq, boost);
 
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
 		return sg_policy->next_freq;
@@ -530,6 +534,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	unsigned long util, max;
 	unsigned int next_f;
 	bool busy;
+	unsigned long ramp_boost = 0;
 
 	sugov_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
@@ -542,10 +547,10 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	busy = sugov_cpu_is_busy(sg_cpu);
 
 	util = sugov_get_util(sg_cpu);
-	sugov_cpu_ramp_boost_update(sg_cpu, util);
+	ramp_boost = sugov_cpu_ramp_boost_update(sg_cpu, util);
 	max = sg_cpu->max;
 	util = sugov_iowait_apply(sg_cpu, time, util, max);
-	next_f = get_next_freq(sg_policy, util, max);
+	next_f = get_next_freq(sg_policy, util, max, ramp_boost);
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
 	 * recently, as the reduction is likely to be premature then.
@@ -577,6 +582,8 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 	struct cpufreq_policy *policy = sg_policy->policy;
 	unsigned long util = 0, max = 1;
 	unsigned int j;
+	unsigned long ramp_boost = 0;
+	unsigned long j_ramp_boost = 0;
 
 	for_each_cpu(j, policy->cpus) {
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
@@ -584,7 +591,11 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 
 		j_util = sugov_get_util(j_sg_cpu);
 		if (j_sg_cpu == sg_cpu)
-			sugov_cpu_ramp_boost_update(sg_cpu, j_util);
+			j_ramp_boost = sugov_cpu_ramp_boost_update(sg_cpu, j_util);
+		else
+			j_ramp_boost = sugov_cpu_ramp_boost(j_sg_cpu);
+		ramp_boost = max(ramp_boost, j_ramp_boost);
+
 		j_max = j_sg_cpu->max;
 		j_util = sugov_iowait_apply(j_sg_cpu, time, j_util, j_max);
 
@@ -595,7 +606,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 	}
 
 
-	return get_next_freq(sg_policy, util, max);
+	return get_next_freq(sg_policy, util, max, ramp_boost);
 }
 
 static void
-- 
2.22.0

