Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC66028DDC1
	for <lists+linux-pm@lfdr.de>; Wed, 14 Oct 2020 11:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgJNJgX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 05:36:23 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6440 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgJNJgX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2020 05:36:23 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f86c6890003>; Wed, 14 Oct 2020 02:36:09 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 14 Oct
 2020 09:36:18 +0000
Received: from sumitg-l4t.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 14 Oct 2020 09:36:15 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <sudeep.holla@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <ksitaraman@nvidia.com>
Subject: [PATCH v3] cpufreq: tegra194: get consistent cpuinfo_cur_freq
Date:   Wed, 14 Oct 2020 15:06:11 +0530
Message-ID: <1602668171-30104-1-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602668169; bh=nJXHQmA8SJehW7u27ymHyIMfAp9QzF0a30R0l0W0ccY=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=I9hRcMpXYVEMOYPv3b65uisktBZmMlkA1NAwI6Rsi5F8yQWTLcqGa8HZXFw2jfwcN
         KRZvsk+toi82mkENMo6imd3A+E9HskH2np3Dr/+/YVZlNuJf/fHRz9Vnaszsh+KbQx
         1LKATsBjfGJLRwtqbmE3Xx2OnhWyys2oX8bJ/6jJNhMcOkLPmlPzdgJvoZlbzwgZFj
         k8CaJgRBDjI8r190U6IpBeYt4MotlQ401n2sU5OBf6LyHOTglRlWXc7jnJ23Xen5CN
         xpLKly1Yu2YBEMwN7EK3+CyFK5/f4vPmsetjqafSjlJWJWEEwE9p52Q0I0LBKC7W1c
         d+vuEO0A2r+Ig==
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

Sending only this patch as other patch not required after the change
to convert 'pr_warn' to 'pr_info' in cpufreq core for unlisted freq.
Changelog
v1[2] -> v3:
- Removed unwanted checks for cpu_online and max cluster number
- Used WARN_ON_ONCE to avoid print flooding.

v1[1] -> v2:
- Minor changes to improve comments and reduce debug prints.
- Get freq table from cluster specific data instead of policy.

[2] https://marc.info/?l=linux-tegra&m=160216218511280&w=2
[1] https://marc.info/?l=linux-arm-kernel&m=160028821117535&w=2

 drivers/cpufreq/tegra194-cpufreq.c | 62 ++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index e1d931c..7901587 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -180,9 +180,61 @@ static unsigned int tegra194_get_speed_common(u32 cpu, u32 delay)
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
+	smp_call_function_single(cpu, get_cpu_cluster, &cl, true);
+
+	/* reconstruct actual cpu freq using counters */
+	rate = tegra194_get_speed_common(cpu, US_DELAY);
+
+	/* get last written ndiv value */
+	ret = smp_call_function_single(cpu, get_cpu_ndiv, &ndiv, true);
+	if (WARN_ON_ONCE(ret))
+		return rate;
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
@@ -209,14 +261,6 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
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

