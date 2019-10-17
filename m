Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E216DAC61
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 14:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502403AbfJQMfk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 08:35:40 -0400
Received: from [217.140.110.172] ([217.140.110.172]:41504 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2389783AbfJQMfk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Oct 2019 08:35:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DE331C14;
        Thu, 17 Oct 2019 05:35:19 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 371723F718;
        Thu, 17 Oct 2019 05:35:18 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nico@fluxnic.net
Subject: [PATCH v2 4/5] cpufreq: vexpress-spc: remove lots of debug messages
Date:   Thu, 17 Oct 2019 13:35:07 +0100
Message-Id: <20191017123508.26130-5-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017123508.26130-1-sudeep.holla@arm.com>
References: <20191017123508.26130-1-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This driver have been used and tested for year now and the extensive
debug/log messages in the driver are not really required anymore.
Get rid of those unnecessary log messages.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/vexpress-spc-cpufreq.c | 72 +++++---------------------
 1 file changed, 13 insertions(+), 59 deletions(-)

diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index 9689f50a8973..81064430317f 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -84,9 +84,6 @@ static unsigned int find_cluster_maxfreq(int cluster)
 			max_freq = cpu_freq;
 	}
 
-	pr_debug("%s: cluster: %d, max freq: %d\n", __func__, cluster,
-			max_freq);
-
 	return max_freq;
 }
 
@@ -99,22 +96,15 @@ static unsigned int clk_get_cpu_rate(unsigned int cpu)
 	if (is_bL_switching_enabled())
 		rate = VIRT_FREQ(cur_cluster, rate);
 
-	pr_debug("%s: cpu: %d, cluster: %d, freq: %u\n", __func__, cpu,
-			cur_cluster, rate);
-
 	return rate;
 }
 
 static unsigned int ve_spc_cpufreq_get_rate(unsigned int cpu)
 {
-	if (is_bL_switching_enabled()) {
-		pr_debug("%s: freq: %d\n", __func__, per_cpu(cpu_last_req_freq,
-					cpu));
-
+	if (is_bL_switching_enabled())
 		return per_cpu(cpu_last_req_freq, cpu);
-	} else {
+	else
 		return clk_get_cpu_rate(cpu);
-	}
 }
 
 static unsigned int
@@ -137,9 +127,6 @@ ve_spc_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 		new_rate = rate;
 	}
 
-	pr_debug("%s: cpu: %d, old cluster: %d, new cluster: %d, freq: %d\n",
-			__func__, cpu, old_cluster, new_cluster, new_rate);
-
 	ret = clk_set_rate(clk[new_cluster], new_rate * 1000);
 	if (!ret) {
 		/*
@@ -155,8 +142,6 @@ ve_spc_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 	}
 
 	if (WARN_ON(ret)) {
-		pr_err("clk_set_rate failed: %d, new cluster: %d\n", ret,
-				new_cluster);
 		if (bLs) {
 			per_cpu(cpu_last_req_freq, cpu) = prev_rate;
 			per_cpu(physical_cluster, cpu) = old_cluster;
@@ -171,9 +156,6 @@ ve_spc_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 
 	/* Recalc freq for old cluster when switching clusters */
 	if (old_cluster != new_cluster) {
-		pr_debug("%s: cpu: %d, old cluster: %d, new cluster: %d\n",
-				__func__, cpu, old_cluster, new_cluster);
-
 		/* Switch cluster */
 		bL_switch_request(cpu, new_cluster);
 
@@ -183,14 +165,9 @@ ve_spc_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 		new_rate = find_cluster_maxfreq(old_cluster);
 		new_rate = ACTUAL_FREQ(old_cluster, new_rate);
 
-		if (new_rate) {
-			pr_debug("%s: Updating rate of old cluster: %d, to freq: %d\n",
-					__func__, old_cluster, new_rate);
-
-			if (clk_set_rate(clk[old_cluster], new_rate * 1000))
-				pr_err("%s: clk_set_rate failed: %d, old cluster: %d\n",
-						__func__, ret, old_cluster);
-		}
+		if (new_rate && clk_set_rate(clk[old_cluster], new_rate * 1000))
+			pr_err("%s: clk_set_rate failed: %d, old cluster: %d\n",
+			       __func__, ret, old_cluster);
 		mutex_unlock(&cluster_lock[old_cluster]);
 	}
 
@@ -283,8 +260,6 @@ static int merge_cluster_tables(void)
 				j++) {
 			table[k].frequency = VIRT_FREQ(i,
 					freq_table[i][j].frequency);
-			pr_debug("%s: index: %d, freq: %d\n", __func__, k,
-					table[k].frequency);
 			k++;
 		}
 	}
@@ -292,8 +267,6 @@ static int merge_cluster_tables(void)
 	table[k].driver_data = k;
 	table[k].frequency = CPUFREQ_TABLE_END;
 
-	pr_debug("%s: End, table: %p, count: %d\n", __func__, table, k);
-
 	return 0;
 }
 
@@ -307,7 +280,6 @@ static void _put_cluster_clk_and_freq_table(struct device *cpu_dev,
 
 	clk_put(clk[cluster]);
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table[cluster]);
-	dev_dbg(cpu_dev, "%s: cluster: %d\n", __func__, cluster);
 }
 
 static void put_cluster_clk_and_freq_table(struct device *cpu_dev,
@@ -324,11 +296,9 @@ static void put_cluster_clk_and_freq_table(struct device *cpu_dev,
 
 	for_each_present_cpu(i) {
 		struct device *cdev = get_cpu_device(i);
-		if (!cdev) {
-			pr_err("%s: failed to get cpu%d device\n", __func__, i);
-			return;
-		}
 
+		if (!cdev)
+			return;
 		_put_cluster_clk_and_freq_table(cdev, cpumask);
 	}
 
@@ -354,19 +324,12 @@ static int _get_cluster_clk_and_freq_table(struct device *cpu_dev,
 		goto out;
 
 	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table[cluster]);
-	if (ret) {
-		dev_err(cpu_dev, "%s: failed to init cpufreq table, cpu: %d, err: %d\n",
-				__func__, cpu_dev->id, ret);
+	if (ret)
 		goto out;
-	}
 
 	clk[cluster] = clk_get(cpu_dev, NULL);
-	if (!IS_ERR(clk[cluster])) {
-		dev_dbg(cpu_dev, "%s: clk: %p & freq table: %p, cluster: %d\n",
-				__func__, clk[cluster], freq_table[cluster],
-				cluster);
+	if (!IS_ERR(clk[cluster]))
 		return 0;
-	}
 
 	dev_err(cpu_dev, "%s: Failed to get clk for cpu: %d, cluster: %d\n",
 			__func__, cpu_dev->id, cluster);
@@ -401,11 +364,9 @@ static int get_cluster_clk_and_freq_table(struct device *cpu_dev,
 	 */
 	for_each_present_cpu(i) {
 		struct device *cdev = get_cpu_device(i);
-		if (!cdev) {
-			pr_err("%s: failed to get cpu%d device\n", __func__, i);
-			return -ENODEV;
-		}
 
+		if (!cdev)
+			return -ENODEV;
 		ret = _get_cluster_clk_and_freq_table(cdev, cpumask);
 		if (ret)
 			goto put_clusters;
@@ -419,19 +380,14 @@ static int get_cluster_clk_and_freq_table(struct device *cpu_dev,
 	clk_big_min = get_table_min(freq_table[0]);
 	clk_little_max = VIRT_FREQ(1, get_table_max(freq_table[1]));
 
-	pr_debug("%s: cluster: %d, clk_big_min: %d, clk_little_max: %d\n",
-			__func__, cluster, clk_big_min, clk_little_max);
-
 	return 0;
 
 put_clusters:
 	for_each_present_cpu(i) {
 		struct device *cdev = get_cpu_device(i);
-		if (!cdev) {
-			pr_err("%s: failed to get cpu%d device\n", __func__, i);
-			return -ENODEV;
-		}
 
+		if (!cdev)
+			return -ENODEV;
 		_put_cluster_clk_and_freq_table(cdev, cpumask);
 	}
 
@@ -500,8 +456,6 @@ static int ve_spc_cpufreq_exit(struct cpufreq_policy *policy)
 	}
 
 	put_cluster_clk_and_freq_table(cpu_dev, policy->related_cpus);
-	dev_dbg(cpu_dev, "%s: Exited, cpu: %d\n", __func__, policy->cpu);
-
 	return 0;
 }
 
-- 
2.17.1

