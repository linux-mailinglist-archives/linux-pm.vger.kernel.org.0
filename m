Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F222A7F47
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 13:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbgKEM4p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 07:56:45 -0500
Received: from foss.arm.com ([217.140.110.172]:60002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730594AbgKEM4p (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 07:56:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43AB6142F;
        Thu,  5 Nov 2020 04:56:44 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0F4DB3F719;
        Thu,  5 Nov 2020 04:56:42 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        sudeep.holla@arm.com
Cc:     morten.rasmussen@arm.com, jeremy.linton@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH 3/8] cppc_cpufreq: simplify use of performance capabilities
Date:   Thu,  5 Nov 2020 12:55:19 +0000
Message-Id: <20201105125524.4409-4-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201105125524.4409-1-ionela.voinescu@arm.com>
References: <20201105125524.4409-1-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The CPPC performance capabilities are used significantly throughout
the driver. Simplify the use of them by introducing a local pointer
"caps" to point to cpu_data->perf_caps, in functions that access
performance capabilities often.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 40 +++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 317169453549..7cc9bd8568de 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -183,15 +183,16 @@ static int cppc_verify_policy(struct cpufreq_policy_data *policy)
 static void cppc_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 {
 	struct cppc_cpudata *cpu_data = all_cpu_data[policy->cpu];
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
 	unsigned int cpu = policy->cpu;
 	int ret;
 
-	cpu_data->perf_ctrls.desired_perf = cpu_data->perf_caps.lowest_perf;
+	cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	if (ret)
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
-			 cpu_data->perf_caps.lowest_perf, cpu, ret);
+			 caps->lowest_perf, cpu, ret);
 }
 
 /*
@@ -240,11 +241,12 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	struct cppc_cpudata *cpu_data = all_cpu_data[policy->cpu];
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
 	unsigned int cpu = policy->cpu;
 	int ret = 0;
 
 	cpu_data->cpu = cpu;
-	ret = cppc_get_perf_caps(cpu, &cpu_data->perf_caps);
+	ret = cppc_get_perf_caps(cpu, caps);
 
 	if (ret) {
 		pr_debug("Err reading CPU%d perf capabilities. ret:%d\n",
@@ -253,23 +255,27 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	/* Convert the lowest and nominal freq from MHz to KHz */
-	cpu_data->perf_caps.lowest_freq *= 1000;
-	cpu_data->perf_caps.nominal_freq *= 1000;
+	caps->lowest_freq *= 1000;
+	caps->nominal_freq *= 1000;
 
 	/*
 	 * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
 	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
 	 */
-	policy->min = cppc_cpufreq_perf_to_khz(cpu_data, cpu_data->perf_caps.lowest_nonlinear_perf);
-	policy->max = cppc_cpufreq_perf_to_khz(cpu_data, cpu_data->perf_caps.nominal_perf);
+	policy->min = cppc_cpufreq_perf_to_khz(cpu_data,
+					       caps->lowest_nonlinear_perf);
+	policy->max = cppc_cpufreq_perf_to_khz(cpu_data,
+					       caps->nominal_perf);
 
 	/*
 	 * Set cpuinfo.min_freq to Lowest to make the full range of performance
 	 * available if userspace wants to use any perf between lowest & lowest
 	 * nonlinear perf
 	 */
-	policy->cpuinfo.min_freq = cppc_cpufreq_perf_to_khz(cpu_data, cpu_data->perf_caps.lowest_perf);
-	policy->cpuinfo.max_freq = cppc_cpufreq_perf_to_khz(cpu_data, cpu_data->perf_caps.nominal_perf);
+	policy->cpuinfo.min_freq = cppc_cpufreq_perf_to_khz(cpu_data,
+							    caps->lowest_perf);
+	policy->cpuinfo.max_freq = cppc_cpufreq_perf_to_khz(cpu_data,
+							    caps->nominal_perf);
 
 	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
 	policy->shared_type = cpu_data->shared_type;
@@ -283,7 +289,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 			if (unlikely(i == cpu))
 				continue;
 
-			memcpy(&all_cpu_data[i]->perf_caps, &cpu_data->perf_caps,
+			memcpy(&all_cpu_data[i]->perf_caps, caps,
 			       sizeof(cpu_data->perf_caps));
 		}
 	} else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL) {
@@ -298,18 +304,17 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	 * If 'highest_perf' is greater than 'nominal_perf', we assume CPU Boost
 	 * is supported.
 	 */
-	if (cpu_data->perf_caps.highest_perf > cpu_data->perf_caps.nominal_perf)
+	if (caps->highest_perf > caps->nominal_perf)
 		boost_supported = true;
 
 	/* Set policy->cur to max now. The governors will adjust later. */
-	policy->cur = cppc_cpufreq_perf_to_khz(cpu_data,
-					cpu_data->perf_caps.highest_perf);
-	cpu_data->perf_ctrls.desired_perf = cpu_data->perf_caps.highest_perf;
+	policy->cur = cppc_cpufreq_perf_to_khz(cpu_data, caps->highest_perf);
+	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
 	if (ret)
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
-			 cpu_data->perf_caps.highest_perf, cpu, ret);
+			 caps->highest_perf, cpu, ret);
 
 	return ret;
 }
@@ -368,6 +373,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 {
 	struct cppc_cpudata *cpu_data = all_cpu_data[policy->cpu];
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
 	int ret;
 
 	if (!boost_supported) {
@@ -377,10 +383,10 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 
 	if (state)
 		policy->max = cppc_cpufreq_perf_to_khz(cpu_data,
-					cpu_data->perf_caps.highest_perf);
+						       caps->highest_perf);
 	else
 		policy->max = cppc_cpufreq_perf_to_khz(cpu_data,
-					cpu_data->perf_caps.nominal_perf);
+						       caps->nominal_perf);
 	policy->cpuinfo.max_freq = policy->max;
 
 	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
-- 
2.17.1

