Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB542107A3
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 11:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgGAJJk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 05:09:40 -0400
Received: from foss.arm.com ([217.140.110.172]:47820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgGAJJj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Jul 2020 05:09:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E55E11FB;
        Wed,  1 Jul 2020 02:09:38 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2DC843F68F;
        Wed,  1 Jul 2020 02:09:36 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, valentin.schneider@arm.com
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH 4/8] cpufreq,vexpress-spc: fix Frequency Invariance (FI) for bL switching
Date:   Wed,  1 Jul 2020 10:07:47 +0100
Message-Id: <20200701090751.7543-5-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200701090751.7543-1-ionela.voinescu@arm.com>
References: <20200701090751.7543-1-ionela.voinescu@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the majority of cases, the index argument to cpufreq's target_index()
is meant to identify the frequency that is requested from the hardware,
according to the frequency table: policy->freq_table[index].frequency.

After successfully requesting it from the hardware, this value, together
with the maximum hardware frequency (policy->cpuinfo.max_freq) are used
as arguments to arch_set_freq_scale(), in order to set the task scheduler
frequency scale factor. This is a normalized indication of a CPU's
current performance.

But for the vexpress-spc-cpufreq driver, when big.LITTLE switching [1]
is enabled, there are three issues with using the above information for
setting the FI scale factor:

 - cur_freq: policy->freq_table[index].frequency is not the frequency
   requested from the hardware. ve_spc_cpufreq_set_rate() will convert
   from this virtual frequency to an actual frequency, which is then
   requested from the hardware. For the A7 cluster, the virtual frequency
   is half the actual frequency. The use of the virtual policy->freq_table
   frequency results in an incorrect FI scale factor.

 - max_freq: policy->cpuinfo.max_freq does not correctly identify the
   maximum frequency of the physical cluster. This value identifies the
   maximum frequency achievable by the big-LITTLE pair, that is the
   maximum frequency of the big CPU. But when the LITTLE CPU in the group
   is used, the hardware maximum frquency passed to arch_set_freq_scale()
   is incorrect.

 - missing a scale factor update: when switching clusters, the driver
   recalculates the frequency of the old clock domain based on the
   requests of the remaining CPUs in the domain and asks for a clock
   change. But this does not result in an update in the scale factor.

Therefore, introduce a local function bLs_set_sched_freq_scale() that
helps call arch_set_freq_scale() with correct information for the
is_bL_switching_enabled() case, while maintaining the old, more
efficient, call site of arch_set_freq_scale() for when cluster
switching is disabled.

Also, because of these requirements in computing the scale factor, this
driver is the only one that maintains custom support for FI, which is
marked by the presence of the CPUFREQ_CUSTOM_SET_FREQ_SCALE flag.

[1] https://lwn.net/Articles/481055/

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/cpufreq/vexpress-spc-cpufreq.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index e0a1a3367ec5..f2caf67d4050 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -55,6 +55,8 @@ static atomic_t cluster_usage[MAX_CLUSTERS + 1];
 static unsigned int clk_big_min;	/* (Big) clock frequencies */
 static unsigned int clk_little_max;	/* Maximum clock frequency (Little) */
 
+static inline u32 get_table_max(struct cpufreq_frequency_table *table);
+
 static DEFINE_PER_CPU(unsigned int, physical_cluster);
 static DEFINE_PER_CPU(unsigned int, cpu_last_req_freq);
 
@@ -87,6 +89,18 @@ static unsigned int find_cluster_maxfreq(int cluster)
 	return max_freq;
 }
 
+static void bLs_set_sched_freq_scale(int cluster, unsigned long cur_freq)
+{
+	unsigned long max_freq = get_table_max(freq_table[cluster]);
+	int j;
+
+	for_each_online_cpu(j) {
+		if (cluster == per_cpu(physical_cluster, j))
+			arch_set_freq_scale(get_cpu_mask(j), cur_freq,
+					    max_freq);
+	}
+}
+
 static unsigned int clk_get_cpu_rate(unsigned int cpu)
 {
 	u32 cur_cluster = per_cpu(physical_cluster, cpu);
@@ -154,6 +168,9 @@ ve_spc_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 
 	mutex_unlock(&cluster_lock[new_cluster]);
 
+	if (bLs)
+		bLs_set_sched_freq_scale(new_cluster, new_rate);
+
 	/* Recalc freq for old cluster when switching clusters */
 	if (old_cluster != new_cluster) {
 		/* Switch cluster */
@@ -170,7 +187,11 @@ ve_spc_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 			pr_err("%s: clk_set_rate failed: %d, old cluster: %d\n",
 			       __func__, ret, old_cluster);
 		}
+
 		mutex_unlock(&cluster_lock[old_cluster]);
+
+		if (new_rate)
+			bLs_set_sched_freq_scale(old_cluster, new_rate);
 	}
 
 	return 0;
@@ -200,7 +221,7 @@ static int ve_spc_cpufreq_set_target(struct cpufreq_policy *policy,
 	ret = ve_spc_cpufreq_set_rate(cpu, actual_cluster, new_cluster,
 				      freqs_new);
 
-	if (!ret) {
+	if (!is_bL_switching_enabled() && !ret) {
 		arch_set_freq_scale(policy->related_cpus, freqs_new,
 				    policy->cpuinfo.max_freq);
 	}
-- 
2.17.1

