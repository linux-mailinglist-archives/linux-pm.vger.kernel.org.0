Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2355426CB03
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 22:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgIPUVY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 16:21:24 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15042 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbgIPRa6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 13:30:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6247380000>; Wed, 16 Sep 2020 10:11:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 16 Sep 2020 10:11:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 16 Sep 2020 10:11:32 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Sep
 2020 17:11:32 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 16 Sep 2020 17:11:32 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f6247410000>; Wed, 16 Sep 2020 10:11:31 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <viresh.kumar@linaro.org>, <rjw@rjwysocki.net>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch 2/2] cpufreq: tegra194: Fix unlisted boot freq warning
Date:   Wed, 16 Sep 2020 22:41:17 +0530
Message-ID: <1600276277-7290-3-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600276277-7290-1-git-send-email-sumitg@nvidia.com>
References: <1600276277-7290-1-git-send-email-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600276280; bh=ox9oENiyu3gx4p8E6vGXmfBT1FSXs+lmzFKORun6J7Q=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Q4hACVQO1Pz1oFwn+w5viQHnibREBYv6f6WAPoqftNGYN7g0zq+ZrCVKc3HuoAdab
         YKyrgp7mnQ6xwJAj/j0eT3jg51Mrogr0E8TCmt+lCtWr+rPJoLqmB3mnDcyz2GP/7t
         IL1urfnIZ/FiJJSGMcm1KUMpJbY7ceXpWCpSQFN2BJtmiqV68NDvfd4LW09wI6DWqv
         nn1ZDIor6PRotVsNh2XFP9h/eiGrzxSnqs9mtbeb+22LN6uk3I6jBHkcDNmV3BEWPr
         qjm05qmeNCYapeXOVN2BhmckCmyyNVt2g37qlMxIMtLql7O7DMFcbKsAfip0EpGmsb
         b1ukze47CaP5Q==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Warning coming during boot because the boot freq set by bootloader
gets filtered out due to big freq steps while creating freq_table.
Fixing this by setting closest ndiv value from freq_table.
Warning:
  cpufreq: cpufreq_online: CPU0: Running at unlisted freq
  cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed

Also, added change in init to wait till current frequency becomes
equal or near to the previously requested frequency. This is done
because it takes some time to restore the previous frequency while
turning-on non-boot cores during exit from SC7(Suspend-to-RAM).

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 118 ++++++++++++++++++++++++++++++++++---
 1 file changed, 111 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index d5b608d..c3c058a3 100644
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
 
@@ -241,26 +241,130 @@ static unsigned int tegra194_get_speed(u32 cpu)
 	return rate;
 }
 
+static int
+freqtable_find_index_closest_ndiv(struct cpufreq_frequency_table *table,
+				  unsigned int target_ndiv)
+{
+	struct cpufreq_frequency_table *pos;
+	unsigned int ndiv;
+	int idx, best = -1;
+
+	cpufreq_for_each_valid_entry_idx(pos, table, idx) {
+		ndiv = pos->driver_data;
+
+		if (ndiv == target_ndiv)
+			return idx;
+
+		if (ndiv < target_ndiv) {
+			best = idx;
+			continue;
+		}
+
+		/* No ndiv found below target_ndiv */
+		if (best == -1)
+			return idx;
+
+		/* Choose the closest ndiv */
+		if (target_ndiv - table[best].driver_data > ndiv - target_ndiv)
+			return idx;
+
+		return best;
+	}
+
+	return best;
+}
+
+static int
+freqtable_set_closest_ndiv(struct cpufreq_frequency_table *freq_table,
+			   int cpu)
+{
+	u64 ndiv;
+	int idx, ret;
+
+	if (!cpu_online(cpu))
+		return -EINVAL;
+
+	/* get ndiv for the last frequency request from software  */
+	ret = smp_call_function_single(cpu, get_cpu_ndiv, &ndiv, true);
+	if (ret) {
+		pr_err("cpufreq: Failed to get ndiv for CPU%d\n", cpu);
+		return ret;
+	}
+
+	/* while creating freq_table during boot, if the ndiv value got
+	 * filtered out due to large freq steps, then find closest ndiv
+	 * from freq_table and set that.
+	 */
+	idx = freqtable_find_index_closest_ndiv(freq_table, ndiv);
+
+	if (ndiv != freq_table[idx].driver_data) {
+		pr_debug("cpufreq: new freq:%d ndiv:%d, old ndiv:%llu\n",
+			 freq_table[idx].frequency,
+			 freq_table[idx].driver_data, ndiv);
+
+		ret = smp_call_function_single(cpu, set_cpu_ndiv,
+					       freq_table + idx, true);
+		if (ret) {
+			pr_err("cpufreq: setting ndiv for CPU%d failed\n",
+			       cpu);
+			return ret;
+		}
+	}
+
+	return freq_table[idx].frequency;
+}
+
 static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
-	u32 cpu;
+	u32 cpu = policy->cpu;
+	int new_freq, ret;
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
 
 	policy->freq_table = data->tables[cl];
-	policy->cpuinfo.transition_latency = TEGRA_CPUFREQ_TRANSITION_LATENCY;
+	policy->cpuinfo.transition_latency =
+		TEGRA_CPUFREQ_TRANSITION_LATENCY;
+
+	/* Find and set the closest ndiv from freq_table if the boot freq
+	 * already set is filtered out from freq_table or not present.
+	 */
+	new_freq = freqtable_set_closest_ndiv(policy->freq_table, policy->cpu);
+	if (new_freq < 0) {
+		pr_err("cpufreq: set closest ndiv for CPU%d failed(%d)\n",
+		       policy->cpu, new_freq);
+		return new_freq;
+	}
+
+	/* It takes some time to restore the previous frequency while
+	 * turning-on non-boot cores during exit from SC7(Suspend-to-RAM).
+	 * So, wait till it reaches the previous value and timeout if the
+	 * time taken to reach requested freq is >100ms
+	 */
+	ret = read_poll_timeout(tegra194_get_speed_common, policy->cur,
+				abs(policy->cur - new_freq) <= 115200, 0,
+				100 * USEC_PER_MSEC, false, policy->cpu,
+				US_DELAY);
+	if (ret)
+		pr_warn("cpufreq: time taken to restore freq >100ms\n");
+
+	pr_debug("cpufreq: cpu%d, curfreq:%d, setfreq:%d\n", policy->cpu,
+		 policy->cur, new_freq);
 
 	return 0;
 }
-- 
2.7.4

