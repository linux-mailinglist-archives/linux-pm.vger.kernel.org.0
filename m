Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165E32A7F2E
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 13:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgKEM4p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 07:56:45 -0500
Received: from foss.arm.com ([217.140.110.172]:59986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730705AbgKEM4n (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 07:56:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D28A14BF;
        Thu,  5 Nov 2020 04:56:42 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 089C33F719;
        Thu,  5 Nov 2020 04:56:40 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        sudeep.holla@arm.com
Cc:     morten.rasmussen@arm.com, jeremy.linton@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH 2/8] cppc_cpufreq: clean up cpu, cpu_num and cpunum variable use
Date:   Thu,  5 Nov 2020 12:55:18 +0000
Message-Id: <20201105125524.4409-3-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201105125524.4409-1-ionela.voinescu@arm.com>
References: <20201105125524.4409-1-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to maintain the typical naming convention in the cpufreq
framework:
 - replace the use of "cpu" variable name for cppc_cpudata pointers
   with "cpu_data"
 - replace variable names "cpu_num" and "cpunum" with "cpu"
 - make cpu variables unsigned int

Where pertinent, also move the initialisation of cpu_data variable to
its declaration and make consistent use of the local "cpu" variable.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 143 ++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 74 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 0b6058ab695f..317169453549 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -96,10 +96,10 @@ static u64 cppc_get_dmi_max_khz(void)
  * and extrapolate the rest
  * For perf/freq > Nominal, we use the ratio perf:freq at Nominal for conversion
  */
-static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu,
+static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu_data,
 					     unsigned int perf)
 {
-	struct cppc_perf_caps *caps = &cpu->perf_caps;
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
 	static u64 max_khz;
 	u64 mul, div;
 
@@ -120,10 +120,10 @@ static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu,
 	return (u64)perf * mul / div;
 }
 
-static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu,
+static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu_data,
 					     unsigned int freq)
 {
-	struct cppc_perf_caps *caps = &cpu->perf_caps;
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
 	static u64 max_khz;
 	u64  mul, div;
 
@@ -149,29 +149,27 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 				   unsigned int target_freq,
 				   unsigned int relation)
 {
+	struct cppc_cpudata *cpu_data = all_cpu_data[policy->cpu];
 	struct cpufreq_freqs freqs;
-	struct cppc_cpudata *cpu;
 	u32 desired_perf;
 	int ret = 0;
 
-	cpu = all_cpu_data[policy->cpu];
-
-	desired_perf = cppc_cpufreq_khz_to_perf(cpu, target_freq);
+	desired_perf = cppc_cpufreq_khz_to_perf(cpu_data, target_freq);
 	/* Return if it is exactly the same perf */
-	if (desired_perf == cpu->perf_ctrls.desired_perf)
+	if (desired_perf == cpu_data->perf_ctrls.desired_perf)
 		return ret;
 
-	cpu->perf_ctrls.desired_perf = desired_perf;
+	cpu_data->perf_ctrls.desired_perf = desired_perf;
 	freqs.old = policy->cur;
 	freqs.new = target_freq;
 
 	cpufreq_freq_transition_begin(policy, &freqs);
-	ret = cppc_set_perf(cpu->cpu, &cpu->perf_ctrls);
+	ret = cppc_set_perf(cpu_data->cpu, &cpu_data->perf_ctrls);
 	cpufreq_freq_transition_end(policy, &freqs, ret != 0);
 
 	if (ret)
 		pr_debug("Failed to set target on CPU:%d. ret:%d\n",
-			 cpu->cpu, ret);
+			 cpu_data->cpu, ret);
 
 	return ret;
 }
@@ -184,16 +182,16 @@ static int cppc_verify_policy(struct cpufreq_policy_data *policy)
 
 static void cppc_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 {
-	int cpu_num = policy->cpu;
-	struct cppc_cpudata *cpu = all_cpu_data[cpu_num];
+	struct cppc_cpudata *cpu_data = all_cpu_data[policy->cpu];
+	unsigned int cpu = policy->cpu;
 	int ret;
 
-	cpu->perf_ctrls.desired_perf = cpu->perf_caps.lowest_perf;
+	cpu_data->perf_ctrls.desired_perf = cpu_data->perf_caps.lowest_perf;
 
-	ret = cppc_set_perf(cpu_num, &cpu->perf_ctrls);
+	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	if (ret)
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
-			 cpu->perf_caps.lowest_perf, cpu_num, ret);
+			 cpu_data->perf_caps.lowest_perf, cpu, ret);
 }
 
 /*
@@ -205,7 +203,7 @@ static void cppc_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 #ifdef CONFIG_ARM64
 #include <asm/cputype.h>
 
-static unsigned int cppc_cpufreq_get_transition_delay_us(int cpu)
+static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 {
 	unsigned long implementor = read_cpuid_implementor();
 	unsigned long part_num = read_cpuid_part_number();
@@ -233,7 +231,7 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(int cpu)
 
 #else
 
-static unsigned int cppc_cpufreq_get_transition_delay_us(int cpu)
+static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 {
 	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
 }
@@ -241,54 +239,52 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(int cpu)
 
 static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	unsigned int cpu_num = policy->cpu;
-	struct cppc_cpudata *cpu;
+	struct cppc_cpudata *cpu_data = all_cpu_data[policy->cpu];
+	unsigned int cpu = policy->cpu;
 	int ret = 0;
 
-	cpu = all_cpu_data[policy->cpu];
-
-	cpu->cpu = cpu_num;
-	ret = cppc_get_perf_caps(policy->cpu, &cpu->perf_caps);
+	cpu_data->cpu = cpu;
+	ret = cppc_get_perf_caps(cpu, &cpu_data->perf_caps);
 
 	if (ret) {
 		pr_debug("Err reading CPU%d perf capabilities. ret:%d\n",
-			 cpu_num, ret);
+			 cpu, ret);
 		return ret;
 	}
 
 	/* Convert the lowest and nominal freq from MHz to KHz */
-	cpu->perf_caps.lowest_freq *= 1000;
-	cpu->perf_caps.nominal_freq *= 1000;
+	cpu_data->perf_caps.lowest_freq *= 1000;
+	cpu_data->perf_caps.nominal_freq *= 1000;
 
 	/*
 	 * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
 	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
 	 */
-	policy->min = cppc_cpufreq_perf_to_khz(cpu, cpu->perf_caps.lowest_nonlinear_perf);
-	policy->max = cppc_cpufreq_perf_to_khz(cpu, cpu->perf_caps.nominal_perf);
+	policy->min = cppc_cpufreq_perf_to_khz(cpu_data, cpu_data->perf_caps.lowest_nonlinear_perf);
+	policy->max = cppc_cpufreq_perf_to_khz(cpu_data, cpu_data->perf_caps.nominal_perf);
 
 	/*
 	 * Set cpuinfo.min_freq to Lowest to make the full range of performance
 	 * available if userspace wants to use any perf between lowest & lowest
 	 * nonlinear perf
 	 */
-	policy->cpuinfo.min_freq = cppc_cpufreq_perf_to_khz(cpu, cpu->perf_caps.lowest_perf);
-	policy->cpuinfo.max_freq = cppc_cpufreq_perf_to_khz(cpu, cpu->perf_caps.nominal_perf);
+	policy->cpuinfo.min_freq = cppc_cpufreq_perf_to_khz(cpu_data, cpu_data->perf_caps.lowest_perf);
+	policy->cpuinfo.max_freq = cppc_cpufreq_perf_to_khz(cpu_data, cpu_data->perf_caps.nominal_perf);
 
-	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu_num);
-	policy->shared_type = cpu->shared_type;
+	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
+	policy->shared_type = cpu_data->shared_type;
 
 	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {
 		int i;
 
-		cpumask_copy(policy->cpus, cpu->shared_cpu_map);
+		cpumask_copy(policy->cpus, cpu_data->shared_cpu_map);
 
 		for_each_cpu(i, policy->cpus) {
-			if (unlikely(i == policy->cpu))
+			if (unlikely(i == cpu))
 				continue;
 
-			memcpy(&all_cpu_data[i]->perf_caps, &cpu->perf_caps,
-			       sizeof(cpu->perf_caps));
+			memcpy(&all_cpu_data[i]->perf_caps, &cpu_data->perf_caps,
+			       sizeof(cpu_data->perf_caps));
 		}
 	} else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL) {
 		/* Support only SW_ANY for now. */
@@ -296,24 +292,24 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		return -EFAULT;
 	}
 
-	cpu->cur_policy = policy;
+	cpu_data->cur_policy = policy;
 
 	/*
 	 * If 'highest_perf' is greater than 'nominal_perf', we assume CPU Boost
 	 * is supported.
 	 */
-	if (cpu->perf_caps.highest_perf > cpu->perf_caps.nominal_perf)
+	if (cpu_data->perf_caps.highest_perf > cpu_data->perf_caps.nominal_perf)
 		boost_supported = true;
 
 	/* Set policy->cur to max now. The governors will adjust later. */
-	policy->cur = cppc_cpufreq_perf_to_khz(cpu,
-					cpu->perf_caps.highest_perf);
-	cpu->perf_ctrls.desired_perf = cpu->perf_caps.highest_perf;
+	policy->cur = cppc_cpufreq_perf_to_khz(cpu_data,
+					cpu_data->perf_caps.highest_perf);
+	cpu_data->perf_ctrls.desired_perf = cpu_data->perf_caps.highest_perf;
 
-	ret = cppc_set_perf(cpu_num, &cpu->perf_ctrls);
+	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	if (ret)
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
-			 cpu->perf_caps.highest_perf, cpu_num, ret);
+			 cpu_data->perf_caps.highest_perf, cpu, ret);
 
 	return ret;
 }
@@ -326,7 +322,7 @@ static inline u64 get_delta(u64 t1, u64 t0)
 	return (u32)t1 - (u32)t0;
 }
 
-static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
+static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
 				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
 				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
 {
@@ -345,33 +341,33 @@ static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
 		delivered_perf = (reference_perf * delta_delivered) /
 					delta_reference;
 	else
-		delivered_perf = cpu->perf_ctrls.desired_perf;
+		delivered_perf = cpu_data->perf_ctrls.desired_perf;
 
-	return cppc_cpufreq_perf_to_khz(cpu, delivered_perf);
+	return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
 }
 
-static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
+static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 {
 	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
-	struct cppc_cpudata *cpu = all_cpu_data[cpunum];
+	struct cppc_cpudata *cpu_data = all_cpu_data[cpu];
 	int ret;
 
-	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
+	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
 	if (ret)
 		return ret;
 
 	udelay(2); /* 2usec delay between sampling */
 
-	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t1);
+	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
 	if (ret)
 		return ret;
 
-	return cppc_get_rate_from_fbctrs(cpu, fb_ctrs_t0, fb_ctrs_t1);
+	return cppc_get_rate_from_fbctrs(cpu_data, fb_ctrs_t0, fb_ctrs_t1);
 }
 
 static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 {
-	struct cppc_cpudata *cpudata;
+	struct cppc_cpudata *cpu_data = all_cpu_data[policy->cpu];
 	int ret;
 
 	if (!boost_supported) {
@@ -379,13 +375,12 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 		return -EINVAL;
 	}
 
-	cpudata = all_cpu_data[policy->cpu];
 	if (state)
-		policy->max = cppc_cpufreq_perf_to_khz(cpudata,
-					cpudata->perf_caps.highest_perf);
+		policy->max = cppc_cpufreq_perf_to_khz(cpu_data,
+					cpu_data->perf_caps.highest_perf);
 	else
-		policy->max = cppc_cpufreq_perf_to_khz(cpudata,
-					cpudata->perf_caps.nominal_perf);
+		policy->max = cppc_cpufreq_perf_to_khz(cpu_data,
+					cpu_data->perf_caps.nominal_perf);
 	policy->cpuinfo.max_freq = policy->max;
 
 	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
@@ -412,17 +407,17 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
  * platform specific mechanism. We reuse the desired performance register to
  * store the real performance calculated by the platform.
  */
-static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpunum)
+static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cppc_cpudata *cpudata = all_cpu_data[cpunum];
+	struct cppc_cpudata *cpu_data = all_cpu_data[cpu];
 	u64 desired_perf;
 	int ret;
 
-	ret = cppc_get_desired_perf(cpunum, &desired_perf);
+	ret = cppc_get_desired_perf(cpu, &desired_perf);
 	if (ret < 0)
 		return -EIO;
 
-	return cppc_cpufreq_perf_to_khz(cpudata, desired_perf);
+	return cppc_cpufreq_perf_to_khz(cpu_data, desired_perf);
 }
 
 static void cppc_check_hisi_workaround(void)
@@ -450,7 +445,7 @@ static void cppc_check_hisi_workaround(void)
 
 static int __init cppc_cpufreq_init(void)
 {
-	struct cppc_cpudata *cpu;
+	struct cppc_cpudata *cpu_data;
 	int i, ret = 0;
 
 	if (acpi_disabled)
@@ -466,8 +461,8 @@ static int __init cppc_cpufreq_init(void)
 		if (!all_cpu_data[i])
 			goto out;
 
-		cpu = all_cpu_data[i];
-		if (!zalloc_cpumask_var(&cpu->shared_cpu_map, GFP_KERNEL))
+		cpu_data = all_cpu_data[i];
+		if (!zalloc_cpumask_var(&cpu_data->shared_cpu_map, GFP_KERNEL))
 			goto out;
 	}
 
@@ -487,11 +482,11 @@ static int __init cppc_cpufreq_init(void)
 
 out:
 	for_each_possible_cpu(i) {
-		cpu = all_cpu_data[i];
-		if (!cpu)
+		cpu_data = all_cpu_data[i];
+		if (!cpu_data)
 			break;
-		free_cpumask_var(cpu->shared_cpu_map);
-		kfree(cpu);
+		free_cpumask_var(cpu_data->shared_cpu_map);
+		kfree(cpu_data);
 	}
 
 	kfree(all_cpu_data);
@@ -500,15 +495,15 @@ static int __init cppc_cpufreq_init(void)
 
 static void __exit cppc_cpufreq_exit(void)
 {
-	struct cppc_cpudata *cpu;
+	struct cppc_cpudata *cpu_data;
 	int i;
 
 	cpufreq_unregister_driver(&cppc_cpufreq_driver);
 
 	for_each_possible_cpu(i) {
-		cpu = all_cpu_data[i];
-		free_cpumask_var(cpu->shared_cpu_map);
-		kfree(cpu);
+		cpu_data = all_cpu_data[i];
+		free_cpumask_var(cpu_data->shared_cpu_map);
+		kfree(cpu_data);
 	}
 
 	kfree(all_cpu_data);
-- 
2.17.1

