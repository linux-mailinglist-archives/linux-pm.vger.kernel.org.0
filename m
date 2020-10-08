Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439A82874B6
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 15:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbgJHNBU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 09:01:20 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9916 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730215AbgJHNBT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2020 09:01:19 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7f0d920004>; Thu, 08 Oct 2020 06:01:06 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Oct
 2020 13:01:18 +0000
Received: from sumitg-l4t.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 8 Oct 2020 13:01:15 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <viresh.kumar@linaro.org>, <rjw@rjwysocki.net>,
        <sudeep.holla@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v2 1/2] cpufreq: tegra194: get consistent cpuinfo_cur_freq
Date:   Thu, 8 Oct 2020 18:31:05 +0530
Message-ID: <1602162066-26442-2-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602162066-26442-1-git-send-email-sumitg@nvidia.com>
References: <1602162066-26442-1-git-send-email-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602162066; bh=qZHO3180KiTmcwJKBSDJ4Sns4UjYQladd81U7oRT7lA=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=QFPPidD1/GhsgVGQooioSRQ/od/HuQKZuAXBV3VQzVhVneVBRE4FM4tqRrvRWzigb
         qkT0kpHUG7gAOhN2fOfp2BIzCckDlref5YNTtyBT3UePiAu4e61RkxnmnLZGK/XfwZ
         XCfhJHzYNLhEGPyCHM/Fvfeexm+DOPLknGlJths7j9nj6AXnfpando/G7jwvz5BoDN
         SaTwkZjv/NxU/toNqQ+L2Jq+6dm88CaBqM0m3y2YSROhjUfyO1u6bJnP1IKQA9xyyG
         Bb1qyL4XkE4ZHWplhwsondZkYHzC3SXHbKCNb4q/CQkoiYPmr8Bw/l8RWsoEjrMguV
         2PUzJBhhmF1XA==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Frequency returned by 'cpuinfo_cur_freq' using counters is not fixed
and keeps changing slightly. This change returns a consistent value
from freq_table. If the reconstructed frequency has acceptable delta
from the last written value, then return the frequency corresponding
to the last written ndiv value from freq_table. Otherwise, print a
warning and return the reconstructed freq.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 71 +++++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index e1d931c..d250e49 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -180,9 +180,70 @@ static unsigned int tegra194_get_speed_common(u32 cpu, u32 delay)
 	return (rate_mhz * KHZ); /* in KHz */
 }
 
+static void get_cpu_ndiv(void *ndiv)
+{
+	u64 ndiv_val;
+
+	asm volatile("mrs %0, s3_0_c15_c0_4" : "=r" (ndiv_val) : );
+
+	*(u64 *)ndiv = ndiv_val;
+}
+
+static void set_cpu_ndiv(void *data)
+{
+	struct cpufreq_frequency_table *tbl = data;
+	u64 ndiv_val = (u64)tbl->driver_data;
+
+	asm volatile("msr s3_0_c15_c0_4, %0" : : "r" (ndiv_val));
+}
+
 static unsigned int tegra194_get_speed(u32 cpu)
 {
-	return tegra194_get_speed_common(cpu, US_DELAY);
+	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
+	struct cpufreq_frequency_table *pos;
+	unsigned int rate;
+	u64 ndiv;
+	int ret;
+	u32 cl;
+
+	if (!cpu_online(cpu))
+		return -EINVAL;
+
+	smp_call_function_single(cpu, get_cpu_cluster, &cl, true);
+
+	if (cl >= data->num_clusters)
+		return -EINVAL;
+
+	/* reconstruct actual cpu freq using counters */
+	rate = tegra194_get_speed_common(cpu, US_DELAY);
+
+	/* get last written ndiv value */
+	ret = smp_call_function_single(cpu, get_cpu_ndiv, &ndiv, true);
+	if (ret) {
+		pr_err("cpufreq: Failed to get ndiv for CPU%d, ret:%d\n",
+		       cpu, ret);
+		return rate;
+	}
+
+	/*
+	 * If the reconstructed frequency has acceptable delta from
+	 * the last written value, then return freq corresponding
+	 * to the last written ndiv value from freq_table. This is
+	 * done to return consistent value.
+	 */
+	cpufreq_for_each_valid_entry(pos, data->tables[cl]) {
+		if (pos->driver_data != ndiv)
+			continue;
+
+		if (abs(pos->frequency - rate) > 115200) {
+			pr_warn("cpufreq: cpu%d,cur:%u,set:%u,set ndiv:%llu\n",
+				cpu, rate, pos->frequency, ndiv);
+		} else {
+			rate = pos->frequency;
+		}
+		break;
+	}
+	return rate;
 }
 
 static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
@@ -209,14 +270,6 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void set_cpu_ndiv(void *data)
-{
-	struct cpufreq_frequency_table *tbl = data;
-	u64 ndiv_val = (u64)tbl->driver_data;
-
-	asm volatile("msr s3_0_c15_c0_4, %0" : : "r" (ndiv_val));
-}
-
 static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
 				       unsigned int index)
 {
-- 
2.7.4

