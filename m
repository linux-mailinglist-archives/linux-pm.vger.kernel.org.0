Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A056226CB0B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 22:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgIPUVY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 16:21:24 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15043 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgIPRa6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 13:30:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6247320001>; Wed, 16 Sep 2020 10:11:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 16 Sep 2020 10:11:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 16 Sep 2020 10:11:27 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Sep
 2020 17:11:27 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 16 Sep 2020 17:11:27 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f62473c0001>; Wed, 16 Sep 2020 10:11:27 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <viresh.kumar@linaro.org>, <rjw@rjwysocki.net>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch 1/2] cpufreq: tegra194: get consistent cpuinfo_cur_freq
Date:   Wed, 16 Sep 2020 22:41:16 +0530
Message-ID: <1600276277-7290-2-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600276277-7290-1-git-send-email-sumitg@nvidia.com>
References: <1600276277-7290-1-git-send-email-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600276274; bh=oXH+axlIrWrmMMW7JliHScXS/IYj9I3hPRTXw99Y67M=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=e5NpJqEtVyF0iSjm3HSYcIZEjbmI05YLKBUhC83u3VL1qlZA20cd13Okj2u9fKqoe
         /L5Fcp1uRMIAYT5Q1yNkUTqMaqhmE2Dy9LzjKVKTxUXvt2R07j6soJ96kyU5nzllqM
         OIebOGaUZpbpz46qVQbxJsPY72KhxAY3I1oAr02zpPWQOS1qUmP6UOKjmnGEnsGBsg
         ljFa0ODuT/WNxQ7onZ7AygSQJ2ER+a7f/hUhb4oXqX5ZwSQ6ExHQDwv4nOHXLsk+zX
         HIL37shFft9GCvSLNj235VXgsgXdmitp+dFq8h9yzAR2lQd0d0q5mU9npk+9KJIg5u
         vstmOw40P0TKg==
Sender: linux-pm-owner@vger.kernel.org
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
 drivers/cpufreq/tegra194-cpufreq.c | 66 ++++++++++++++++++++++++++++++++------
 1 file changed, 57 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index e1d931c..d5b608d 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -180,9 +180,65 @@ static unsigned int tegra194_get_speed_common(u32 cpu, u32 delay)
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
+	struct cpufreq_frequency_table *table, *pos;
+	struct cpufreq_policy policy;
+	unsigned int rate;
+	u64 ndiv;
+	int err;
+
+	cpufreq_get_policy(&policy, cpu);
+	table = policy.freq_table;
+
+	/* reconstruct actual cpu freq using counters*/
+	rate = tegra194_get_speed_common(cpu, US_DELAY);
+
+	/* get last written ndiv value*/
+	err = smp_call_function_single(cpu, get_cpu_ndiv, &ndiv, true);
+	if (err) {
+		pr_err("cpufreq: Failed to get ndiv for CPU%d, ret:%d\n",
+		       cpu, err);
+		return rate;
+	}
+
+	/* if the reconstructed frequency has acceptable delta from
+	 * the last written value, then return freq corresponding
+	 * to the last written ndiv value from freq_table. This is
+	 * done to return consistent value.
+	 */
+	cpufreq_for_each_valid_entry(pos, table) {
+		if (pos->driver_data != ndiv)
+			continue;
+
+		if (abs(pos->frequency - rate) > 115200) {
+			pr_warn("cpufreq: high delta (%d) on CPU%d\n",
+				abs(pos->frequency - rate), cpu);
+			pr_warn("cpufreq: cur:%u, set:%u, set ndiv:%llu\n",
+				rate, pos->frequency, ndiv);
+		} else {
+			rate = pos->frequency;
+		}
+		break;
+	}
+	return rate;
 }
 
 static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
@@ -209,14 +265,6 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
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

