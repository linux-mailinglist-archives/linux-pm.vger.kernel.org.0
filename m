Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4ED2874BC
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 15:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbgJHNBa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 09:01:30 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14784 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729869AbgJHNB3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2020 09:01:29 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7f0d710001>; Thu, 08 Oct 2020 06:00:33 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Oct
 2020 13:01:24 +0000
Received: from sumitg-l4t.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 8 Oct 2020 13:01:20 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <viresh.kumar@linaro.org>, <rjw@rjwysocki.net>,
        <sudeep.holla@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v2 2/2] cpufreq: tegra194: Fix unlisted boot freq warning
Date:   Thu, 8 Oct 2020 18:31:06 +0530
Message-ID: <1602162066-26442-3-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602162066-26442-1-git-send-email-sumitg@nvidia.com>
References: <1602162066-26442-1-git-send-email-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602162033; bh=w/t/1HPtHe4dWml26XyhXVC/J2g3Sci7nmwVsHDJwGw=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=rRZVfG4fiJdhzamTESY2oBrCljhFhQ14lxavgwcLewW20BoGjIzcpDvx7nSaGfSRR
         K0ptRUpNtMPBKCuNm/kIy57jrEk86dYOnRL6+8X7bTYWhH1eR+AqQiEVURYfrABzDg
         bx0A8yo0NTKrLVoGgIunLxzw+L/IRSpiUPbzL91t19Pg9LEn++z0cM1FUNeVVvS4bn
         X5g027JUwArOfK5GouxWL4IQPQOSn61g6m239l1VHv6duTANfX4F1OJAe8USi5jl1t
         6n7a0xPnqU+aN8RgvWmxRkpH2xLWhLjdGICUmeTDxX2u5GnVnHWWW3FxQHp4Gbofgj
         cZq7EXYrVPxqA==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Warning coming during boot because the boot freq set by bootloader
gets filtered out due to big freq steps while creating freq_table.
Fix this by setting closest higher frequency from freq_table.
Warning:
  cpufreq: cpufreq_online: CPU0: Running at unlisted freq
  cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed

These warning messages also come during hotplug online of non-boot
CPU's while exiting from 'Suspend-to-RAM'. This happens because
during exit from 'Suspend-to-RAM', some time is taken to restore
last software requested CPU frequency written in register before
entering suspend. To fix this, adding online hook to wait till the
current frequency becomes equal or close to the last requested
frequency.

Fixes: df320f89359c ("cpufreq: Add Tegra194 cpufreq driver")
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 86 ++++++++++++++++++++++++++++++++++----
 1 file changed, 79 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index d250e49..cc28b1e3 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -7,6 +7,7 @@
 #include <linux/cpufreq.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -21,7 +22,6 @@
 #define KHZ                     1000
 #define REF_CLK_MHZ             408 /* 408 MHz */
 #define US_DELAY                500
-#define US_DELAY_MIN            2
 #define CPUFREQ_TBL_STEP_HZ     (50 * KHZ * KHZ)
 #define MAX_CNT                 ~0U
 
@@ -249,17 +249,22 @@ static unsigned int tegra194_get_speed(u32 cpu)
 static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
-	u32 cpu;
+	u32 cpu = policy->cpu;
+	int ret;
 	u32 cl;
 
-	smp_call_function_single(policy->cpu, get_cpu_cluster, &cl, true);
+	if (!cpu_online(cpu))
+		return -EINVAL;
+
+	ret = smp_call_function_single(cpu, get_cpu_cluster, &cl, true);
+	if (ret) {
+		pr_err("cpufreq: Failed to get cluster for CPU%d\n", cpu);
+		return ret;
+	}
 
 	if (cl >= data->num_clusters)
 		return -EINVAL;
 
-	/* boot freq */
-	policy->cur = tegra194_get_speed_common(policy->cpu, US_DELAY_MIN);
-
 	/* set same policy for all cpus in a cluster */
 	for (cpu = (cl * 2); cpu < ((cl + 1) * 2); cpu++)
 		cpumask_set_cpu(cpu, policy->cpus);
@@ -267,7 +272,23 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
 	policy->freq_table = data->tables[cl];
 	policy->cpuinfo.transition_latency = TEGRA_CPUFREQ_TRANSITION_LATENCY;
 
-	return 0;
+	policy->cur = tegra194_get_speed_common(policy->cpu, US_DELAY);
+
+	ret = cpufreq_table_validate_and_sort(policy);
+	if (ret)
+		return ret;
+
+	/* Are we running at unknown frequency ? */
+	ret = cpufreq_frequency_table_get_index(policy, policy->cur);
+	if (ret == -EINVAL) {
+		ret = __cpufreq_driver_target(policy, policy->cur - 1,
+					      CPUFREQ_RELATION_L);
+		if (ret)
+			return ret;
+		policy->cur = tegra194_get_speed_common(policy->cpu, US_DELAY);
+	}
+
+	return ret;
 }
 
 static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
@@ -285,6 +306,55 @@ static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
 	return 0;
 }
 
+static int tegra194_cpufreq_online(struct cpufreq_policy *policy)
+{
+	unsigned int interm_freq, last_set_freq;
+	struct cpufreq_frequency_table *pos;
+	u64 ndiv;
+	int ret;
+
+	if (!cpu_online(policy->cpu))
+		return -EINVAL;
+
+	/* get ndiv for the last frequency request from software  */
+	ret = smp_call_function_single(policy->cpu, get_cpu_ndiv, &ndiv, true);
+	if (ret) {
+		pr_err("cpufreq: Failed to get ndiv for CPU%d\n", policy->cpu);
+		return ret;
+	}
+
+	cpufreq_for_each_valid_entry(pos, policy->freq_table) {
+		if (pos->driver_data == ndiv) {
+			last_set_freq = pos->frequency;
+			break;
+		}
+	}
+
+	policy->cur = tegra194_get_speed_common(policy->cpu, US_DELAY);
+	interm_freq =  policy->cur;
+
+	/*
+	 * It takes some time to restore the previous frequency while
+	 * turning-on non-boot cores during exit from SC7(Suspend-to-RAM).
+	 * So, wait till it reaches the previous value and timeout if the
+	 * time taken to reach requested freq is >100ms
+	 */
+	ret = read_poll_timeout(tegra194_get_speed_common, policy->cur,
+				abs(policy->cur - last_set_freq) <= 115200, 0,
+				100 * USEC_PER_MSEC, false, policy->cpu,
+				US_DELAY);
+	if (ret)
+		pr_warn("cpufreq: cpu%d, cur:%u, last set:%u, intermed:%u\n",
+			policy->cpu, policy->cur, last_set_freq, interm_freq);
+
+	return ret;
+}
+
+static int tegra194_cpufreq_offline(struct cpufreq_policy *policy)
+{
+	return 0;
+}
+
 static struct cpufreq_driver tegra194_cpufreq_driver = {
 	.name = "tegra194",
 	.flags = CPUFREQ_STICKY | CPUFREQ_CONST_LOOPS |
@@ -294,6 +364,8 @@ static struct cpufreq_driver tegra194_cpufreq_driver = {
 	.get = tegra194_get_speed,
 	.init = tegra194_cpufreq_init,
 	.attr = cpufreq_generic_attr,
+	.online = tegra194_cpufreq_online,
+	.offline = tegra194_cpufreq_offline,
 };
 
 static void tegra194_cpufreq_free_resources(void)
-- 
2.7.4

