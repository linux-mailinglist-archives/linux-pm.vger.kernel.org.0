Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973851D9590
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 13:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgESLsA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 May 2020 07:48:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4867 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728798AbgESLr6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 May 2020 07:47:58 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B7585B6E4C3FA3958D6D;
        Tue, 19 May 2020 19:47:54 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 19 May 2020 19:47:47 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <Souvik.Chakravarty@arm.com>, <Thanu.Rangarajan@arm.com>
CC:     <Sudeep.Holla@arm.com>, <guohanjun@huawei.com>,
        <john.garry@huawei.com>, <jonathan.cameron@huawei.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [RFC PATCH v3 2/2] CPPC: add support for SW BOOST
Date:   Tue, 19 May 2020 19:41:29 +0800
Message-ID: <1589888489-13828-3-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1589888489-13828-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1589888489-13828-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To add SW BOOST support for CPPC, we need to get the max frequency of
boost mode and non-boost mode. ACPI spec 6.2 section 8.4.7.1 describe
the following two CPC registers.

"Highest performance is the absolute maximum performance an individual
processor may reach, assuming ideal conditions. This performance level
may not be sustainable for long durations, and may only be achievable if
other platform components are in a specific state; for example, it may
require other processors be in an idle state.

Nominal Performance is the maximum sustained performance level of the
processor, assuming ideal operating conditions. In absence of an
external constraint (power, thermal, etc.) this is the performance level
the platform is expected to be able to maintain continuously. All
processors are expected to be able to sustain their nominal performance
state simultaneously."

To add SW BOOST support for CPPC, we can use Highest Performance as the
max performance in boost mode and Nominal Performance as the max
performance in non-boost mode. If the Highest Performance is greater
than the Nominal Performance, we assume SW BOOST is supported.

The current CPPC driver does not support SW BOOST and use 'Highest
Performance' as the max performance the CPU can achieve. 'Nominal
Performance' is used to convert 'performance' to 'frequency'. That
means, if firmware enable boost and provide a value for Highest
Performance which is greater than Nominal Performance, boost feature is
enabled by default.

Because SW BOOST is disabled by default, so, after this patch, boost
feature is disabled by default even if boost is enabled by firmware.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index bda0b24..792ed9e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -37,6 +37,7 @@
  * requested etc.
  */
 static struct cppc_cpudata **all_cpu_data;
+static bool boost_supported;
 
 struct cppc_workaround_oem_info {
 	char oem_id[ACPI_OEM_ID_SIZE + 1];
@@ -310,7 +311,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
 	 */
 	policy->min = cppc_cpufreq_perf_to_khz(cpu, cpu->perf_caps.lowest_nonlinear_perf);
-	policy->max = cppc_cpufreq_perf_to_khz(cpu, cpu->perf_caps.highest_perf);
+	policy->max = cppc_cpufreq_perf_to_khz(cpu, cpu->perf_caps.nominal_perf);
 
 	/*
 	 * Set cpuinfo.min_freq to Lowest to make the full range of performance
@@ -318,7 +319,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	 * nonlinear perf
 	 */
 	policy->cpuinfo.min_freq = cppc_cpufreq_perf_to_khz(cpu, cpu->perf_caps.lowest_perf);
-	policy->cpuinfo.max_freq = cppc_cpufreq_perf_to_khz(cpu, cpu->perf_caps.highest_perf);
+	policy->cpuinfo.max_freq = cppc_cpufreq_perf_to_khz(cpu, cpu->perf_caps.nominal_perf);
 
 	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu_num);
 	policy->shared_type = cpu->shared_type;
@@ -343,6 +344,13 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	cpu->cur_policy = policy;
 
+	/*
+	 * If 'highest_perf' is greater than 'nominal_perf', we assume CPU Boost
+	 * is supported.
+	 */
+	if (cpu->perf_caps.highest_perf > cpu->perf_caps.nominal_perf)
+		boost_supported = true;
+
 	/* Set policy->cur to max now. The governors will adjust later. */
 	policy->cur = cppc_cpufreq_perf_to_khz(cpu,
 					cpu->perf_caps.highest_perf);
@@ -410,6 +418,32 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
 	return cppc_get_rate_from_fbctrs(cpu, fb_ctrs_t0, fb_ctrs_t1);
 }
 
+static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
+{
+	struct cppc_cpudata *cpudata;
+	int ret = 0;
+
+	if (!boost_supported) {
+		pr_err("BOOST not supported by CPU or firmware\n");
+		return -EINVAL;
+	}
+
+	cpudata = all_cpu_data[policy->cpu];
+	if (state)
+		policy->max = cppc_cpufreq_perf_to_khz(cpudata,
+					cpudata->perf_caps.highest_perf);
+	else
+		policy->max = cppc_cpufreq_perf_to_khz(cpudata,
+					cpudata->perf_caps.nominal_perf);
+	policy->cpuinfo.max_freq = policy->max;
+
+	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static struct cpufreq_driver cppc_cpufreq_driver = {
 	.flags = CPUFREQ_CONST_LOOPS,
 	.verify = cppc_verify_policy,
@@ -417,6 +451,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
 	.get = cppc_cpufreq_get_rate,
 	.init = cppc_cpufreq_cpu_init,
 	.stop_cpu = cppc_cpufreq_stop_cpu,
+	.set_boost = cppc_cpufreq_set_boost,
 	.name = "cppc_cpufreq",
 };
 
-- 
1.7.12.4

