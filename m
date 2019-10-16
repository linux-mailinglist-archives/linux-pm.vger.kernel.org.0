Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 988C6D8EDD
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 13:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404834AbfJPLD4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 07:03:56 -0400
Received: from foss.arm.com ([217.140.110.172]:36574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfJPLDy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Oct 2019 07:03:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 491BB15A1;
        Wed, 16 Oct 2019 04:03:54 -0700 (PDT)
Received: from usa.arm.com (unknown [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 639703F6C4;
        Wed, 16 Oct 2019 04:03:53 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] cpufreq: simplify and remove lots of debug messages
Date:   Wed, 16 Oct 2019 12:03:44 +0100
Message-Id: <20191016110344.15259-4-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016110344.15259-1-sudeep.holla@arm.com>
References: <20191016110344.15259-1-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

cpufreq_arm_bL_ops is no longer needed after merging the generic
arm_big_little and vexpress-spc driver. Remove cpufreq_arm_bL_ops
and rename all the bL_* function names to ve_spc_*.

This driver have been used for year now and the extensive debug
messages in the driver are not really required anymore.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/vexpress-spc-cpufreq.c | 274 +++++++------------------
 1 file changed, 75 insertions(+), 199 deletions(-)

diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index 9d3f91832990..19eab7fd5762 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -17,7 +17,6 @@
 #include <linux/cpumask.h>
 #include <linux/cpu_cooling.h>
 #include <linux/device.h>
-#include <linux/export.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of_platform.h>
@@ -27,20 +26,6 @@
 #include <linux/topology.h>
 #include <linux/types.h>
 
-struct cpufreq_arm_bL_ops {
-	char name[CPUFREQ_NAME_LEN];
-
-	/*
-	 * This must set opp table for cpu_dev in a similar way as done by
-	 * dev_pm_opp_of_add_table().
-	 */
-	int (*init_opp_table)(const struct cpumask *cpumask);
-
-	/* Optional */
-	int (*get_transition_latency)(struct device *cpu_dev);
-	void (*free_opp_table)(const struct cpumask *cpumask);
-};
-
 /* Currently we support only two clusters */
 #define A15_CLUSTER	0
 #define A7_CLUSTER	1
@@ -59,11 +44,10 @@ static bool bL_switching_enabled;
 #define bL_switcher_get_enabled()	do { } while (0)
 #endif
 
-#define ACTUAL_FREQ(cluster, freq)  ((cluster == A7_CLUSTER) ? freq << 1 : freq)
-#define VIRT_FREQ(cluster, freq)    ((cluster == A7_CLUSTER) ? freq >> 1 : freq)
+#define ACTUAL_FREQ(cluster, freq)  (((cluster) == A7_CLUSTER) ? (freq) << 1 : (freq))
+#define VIRT_FREQ(cluster, freq)    (((cluster) == A7_CLUSTER) ? (freq) >> 1 : (freq))
 
 static struct thermal_cooling_device *cdev[MAX_CLUSTERS];
-static const struct cpufreq_arm_bL_ops *arm_bL_ops;
 static struct clk *clk[MAX_CLUSTERS];
 static struct cpufreq_frequency_table *freq_table[MAX_CLUSTERS + 1];
 static atomic_t cluster_usage[MAX_CLUSTERS + 1];
@@ -95,14 +79,11 @@ static unsigned int find_cluster_maxfreq(int cluster)
 	for_each_online_cpu(j) {
 		cpu_freq = per_cpu(cpu_last_req_freq, j);
 
-		if ((cluster == per_cpu(physical_cluster, j)) &&
-				(max_freq < cpu_freq))
+		if (cluster == per_cpu(physical_cluster, j) &&
+		    max_freq < cpu_freq)
 			max_freq = cpu_freq;
 	}
 
-	pr_debug("%s: cluster: %d, max freq: %d\n", __func__, cluster,
-			max_freq);
-
 	return max_freq;
 }
 
@@ -115,26 +96,19 @@ static unsigned int clk_get_cpu_rate(unsigned int cpu)
 	if (is_bL_switching_enabled())
 		rate = VIRT_FREQ(cur_cluster, rate);
 
-	pr_debug("%s: cpu: %d, cluster: %d, freq: %u\n", __func__, cpu,
-			cur_cluster, rate);
-
 	return rate;
 }
 
-static unsigned int bL_cpufreq_get_rate(unsigned int cpu)
+static unsigned int ve_spc_cpufreq_get_rate(unsigned int cpu)
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
-bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
+ve_spc_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 {
 	u32 new_rate, prev_rate;
 	int ret;
@@ -153,9 +127,6 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 		new_rate = rate;
 	}
 
-	pr_debug("%s: cpu: %d, old cluster: %d, new cluster: %d, freq: %d\n",
-			__func__, cpu, old_cluster, new_cluster, new_rate);
-
 	ret = clk_set_rate(clk[new_cluster], new_rate * 1000);
 	if (!ret) {
 		/*
@@ -171,8 +142,6 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 	}
 
 	if (WARN_ON(ret)) {
-		pr_err("clk_set_rate failed: %d, new cluster: %d\n", ret,
-				new_cluster);
 		if (bLs) {
 			per_cpu(cpu_last_req_freq, cpu) = prev_rate;
 			per_cpu(physical_cluster, cpu) = old_cluster;
@@ -187,9 +156,6 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 
 	/* Recalc freq for old cluster when switching clusters */
 	if (old_cluster != new_cluster) {
-		pr_debug("%s: cpu: %d, old cluster: %d, new cluster: %d\n",
-				__func__, cpu, old_cluster, new_cluster);
-
 		/* Switch cluster */
 		bL_switch_request(cpu, new_cluster);
 
@@ -199,14 +165,9 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
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
 
@@ -214,34 +175,32 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 }
 
 /* Set clock frequency */
-static int bL_cpufreq_set_target(struct cpufreq_policy *policy,
-		unsigned int index)
+static int ve_spc_cpufreq_set_target(struct cpufreq_policy *policy,
+				     unsigned int index)
 {
 	u32 cpu = policy->cpu, cur_cluster, new_cluster, actual_cluster;
-	unsigned int freqs_new;
+	unsigned int freq_new;
 	int ret;
 
 	cur_cluster = cpu_to_cluster(cpu);
 	new_cluster = actual_cluster = per_cpu(physical_cluster, cpu);
 
-	freqs_new = freq_table[cur_cluster][index].frequency;
+	freq_new = freq_table[cur_cluster][index].frequency;
 
 	if (is_bL_switching_enabled()) {
-		if ((actual_cluster == A15_CLUSTER) &&
-				(freqs_new < clk_big_min)) {
+		if (actual_cluster == A15_CLUSTER && freq_new < clk_big_min)
 			new_cluster = A7_CLUSTER;
-		} else if ((actual_cluster == A7_CLUSTER) &&
-				(freqs_new > clk_little_max)) {
+		else if (actual_cluster == A7_CLUSTER &&
+			 freq_new > clk_little_max)
 			new_cluster = A15_CLUSTER;
-		}
 	}
 
-	ret = bL_cpufreq_set_rate(cpu, actual_cluster, new_cluster, freqs_new);
+	ret = ve_spc_cpufreq_set_rate(cpu, actual_cluster, new_cluster,
+				      freq_new);
 
-	if (!ret) {
-		arch_set_freq_scale(policy->related_cpus, freqs_new,
+	if (!ret)
+		arch_set_freq_scale(policy->related_cpus, freq_new,
 				    policy->cpuinfo.max_freq);
-	}
 
 	return ret;
 }
@@ -260,7 +219,8 @@ static inline u32 get_table_count(struct cpufreq_frequency_table *table)
 static inline u32 get_table_min(struct cpufreq_frequency_table *table)
 {
 	struct cpufreq_frequency_table *pos;
-	uint32_t min_freq = ~0;
+	u32 min_freq = ~0;
+
 	cpufreq_for_each_entry(pos, table)
 		if (pos->frequency < min_freq)
 			min_freq = pos->frequency;
@@ -271,7 +231,8 @@ static inline u32 get_table_min(struct cpufreq_frequency_table *table)
 static inline u32 get_table_max(struct cpufreq_frequency_table *table)
 {
 	struct cpufreq_frequency_table *pos;
-	uint32_t max_freq = 0;
+	u32 max_freq = 0;
+
 	cpufreq_for_each_entry(pos, table)
 		if (pos->frequency > max_freq)
 			max_freq = pos->frequency;
@@ -293,22 +254,15 @@ static int merge_cluster_tables(void)
 	freq_table[MAX_CLUSTERS] = table;
 
 	/* Add in reverse order to get freqs in increasing order */
-	for (i = MAX_CLUSTERS - 1; i >= 0; i--) {
+	for (i = MAX_CLUSTERS - 1; i >= 0; i--)
 		for (j = 0; freq_table[i][j].frequency != CPUFREQ_TABLE_END;
-				j++) {
-			table[k].frequency = VIRT_FREQ(i,
-					freq_table[i][j].frequency);
-			pr_debug("%s: index: %d, freq: %d\n", __func__, k,
-					table[k].frequency);
-			k++;
-		}
-	}
+		     j++, k++)
+			table[k].frequency =
+				VIRT_FREQ(i, freq_table[i][j].frequency);
 
 	table[k].driver_data = k;
 	table[k].frequency = CPUFREQ_TABLE_END;
 
-	pr_debug("%s: End, table: %p, count: %d\n", __func__, table, k);
-
 	return 0;
 }
 
@@ -322,9 +276,6 @@ static void _put_cluster_clk_and_freq_table(struct device *cpu_dev,
 
 	clk_put(clk[cluster]);
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table[cluster]);
-	if (arm_bL_ops->free_opp_table)
-		arm_bL_ops->free_opp_table(cpumask);
-	dev_dbg(cpu_dev, "%s: cluster: %d\n", __func__, cluster);
 }
 
 static void put_cluster_clk_and_freq_table(struct device *cpu_dev,
@@ -341,11 +292,9 @@ static void put_cluster_clk_and_freq_table(struct device *cpu_dev,
 
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
 
@@ -362,39 +311,30 @@ static int _get_cluster_clk_and_freq_table(struct device *cpu_dev,
 	if (freq_table[cluster])
 		return 0;
 
-	ret = arm_bL_ops->init_opp_table(cpumask);
-	if (ret) {
-		dev_err(cpu_dev, "%s: init_opp_table failed, cpu: %d, err: %d\n",
-				__func__, cpu_dev->id, ret);
+	/*
+	 * platform specific SPC code must initialise the opp table
+	 * so just check if the OPP count is non-zero
+	 */
+	ret = dev_pm_opp_get_opp_count(cpu_dev) <= 0;
+	if (ret)
 		goto out;
-	}
 
 	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table[cluster]);
-	if (ret) {
-		dev_err(cpu_dev, "%s: failed to init cpufreq table, cpu: %d, err: %d\n",
-				__func__, cpu_dev->id, ret);
-		goto free_opp_table;
-	}
+	if (ret)
+		goto out;
 
 	clk[cluster] = clk_get(cpu_dev, NULL);
-	if (!IS_ERR(clk[cluster])) {
-		dev_dbg(cpu_dev, "%s: clk: %p & freq table: %p, cluster: %d\n",
-				__func__, clk[cluster], freq_table[cluster],
-				cluster);
+	if (!IS_ERR(clk[cluster]))
 		return 0;
-	}
 
 	dev_err(cpu_dev, "%s: Failed to get clk for cpu: %d, cluster: %d\n",
-			__func__, cpu_dev->id, cluster);
+		__func__, cpu_dev->id, cluster);
 	ret = PTR_ERR(clk[cluster]);
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table[cluster]);
 
-free_opp_table:
-	if (arm_bL_ops->free_opp_table)
-		arm_bL_ops->free_opp_table(cpumask);
 out:
 	dev_err(cpu_dev, "%s: Failed to get data for cluster: %d\n", __func__,
-			cluster);
+		cluster);
 	return ret;
 }
 
@@ -420,11 +360,9 @@ static int get_cluster_clk_and_freq_table(struct device *cpu_dev,
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
@@ -438,19 +376,14 @@ static int get_cluster_clk_and_freq_table(struct device *cpu_dev,
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
 
@@ -460,7 +393,7 @@ static int get_cluster_clk_and_freq_table(struct device *cpu_dev,
 }
 
 /* Per-CPU initialization */
-static int bL_cpufreq_init(struct cpufreq_policy *policy)
+static int ve_spc_cpufreq_init(struct cpufreq_policy *policy)
 {
 	u32 cur_cluster = cpu_to_cluster(policy->cpu);
 	struct device *cpu_dev;
@@ -469,7 +402,7 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
 		pr_err("%s: failed to get cpu%d device\n", __func__,
-				policy->cpu);
+		       policy->cpu);
 		return -ENODEV;
 	}
 
@@ -490,19 +423,19 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 		return ret;
 
 	policy->freq_table = freq_table[cur_cluster];
-	policy->cpuinfo.transition_latency =
-				arm_bL_ops->get_transition_latency(cpu_dev);
+	policy->cpuinfo.transition_latency = 1000000; /* 1 ms */
 
 	dev_pm_opp_of_register_em(policy->cpus);
 
 	if (is_bL_switching_enabled())
-		per_cpu(cpu_last_req_freq, policy->cpu) = clk_get_cpu_rate(policy->cpu);
+		per_cpu(cpu_last_req_freq, policy->cpu) =
+						clk_get_cpu_rate(policy->cpu);
 
 	dev_info(cpu_dev, "%s: CPU %d initialized\n", __func__, policy->cpu);
 	return 0;
 }
 
-static int bL_cpufreq_exit(struct cpufreq_policy *policy)
+static int ve_spc_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct device *cpu_dev;
 	int cur_cluster = cpu_to_cluster(policy->cpu);
@@ -515,17 +448,15 @@ static int bL_cpufreq_exit(struct cpufreq_policy *policy)
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
 		pr_err("%s: failed to get cpu%d device\n", __func__,
-				policy->cpu);
+		       policy->cpu);
 		return -ENODEV;
 	}
 
 	put_cluster_clk_and_freq_table(cpu_dev, policy->related_cpus);
-	dev_dbg(cpu_dev, "%s: Exited, cpu: %d\n", __func__, policy->cpu);
-
 	return 0;
 }
 
-static void bL_cpufreq_ready(struct cpufreq_policy *policy)
+static void ve_spc_cpufreq_ready(struct cpufreq_policy *policy)
 {
 	int cur_cluster = cpu_to_cluster(policy->cpu);
 
@@ -536,17 +467,17 @@ static void bL_cpufreq_ready(struct cpufreq_policy *policy)
 	cdev[cur_cluster] = of_cpufreq_cooling_register(policy);
 }
 
-static struct cpufreq_driver bL_cpufreq_driver = {
-	.name			= "arm-big-little",
+static struct cpufreq_driver ve_spc_cpufreq_driver = {
+	.name			= "vexpress-spc",
 	.flags			= CPUFREQ_STICKY |
 					CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
 					CPUFREQ_NEED_INITIAL_FREQ_CHECK,
 	.verify			= cpufreq_generic_frequency_table_verify,
-	.target_index		= bL_cpufreq_set_target,
-	.get			= bL_cpufreq_get_rate,
-	.init			= bL_cpufreq_init,
-	.exit			= bL_cpufreq_exit,
-	.ready			= bL_cpufreq_ready,
+	.target_index		= ve_spc_cpufreq_set_target,
+	.get			= ve_spc_cpufreq_get_rate,
+	.init			= ve_spc_cpufreq_init,
+	.exit			= ve_spc_cpufreq_exit,
+	.ready			= ve_spc_cpufreq_ready,
 	.attr			= cpufreq_generic_attr,
 };
 
@@ -559,17 +490,17 @@ static int bL_cpufreq_switcher_notifier(struct notifier_block *nfb,
 	switch (action) {
 	case BL_NOTIFY_PRE_ENABLE:
 	case BL_NOTIFY_PRE_DISABLE:
-		cpufreq_unregister_driver(&bL_cpufreq_driver);
+		cpufreq_unregister_driver(&ve_spc_cpufreq_driver);
 		break;
 
 	case BL_NOTIFY_POST_ENABLE:
 		set_switching_enabled(true);
-		cpufreq_register_driver(&bL_cpufreq_driver);
+		cpufreq_register_driver(&ve_spc_cpufreq_driver);
 		break;
 
 	case BL_NOTIFY_POST_DISABLE:
 		set_switching_enabled(false);
-		cpufreq_register_driver(&bL_cpufreq_driver);
+		cpufreq_register_driver(&ve_spc_cpufreq_driver);
 		break;
 
 	default:
@@ -597,95 +528,40 @@ static int __bLs_register_notifier(void) { return 0; }
 static int __bLs_unregister_notifier(void) { return 0; }
 #endif
 
-int bL_cpufreq_register(const struct cpufreq_arm_bL_ops *ops)
+static int ve_spc_cpufreq_probe(struct platform_device *pdev)
 {
 	int ret, i;
 
-	if (arm_bL_ops) {
-		pr_debug("%s: Already registered: %s, exiting\n", __func__,
-				arm_bL_ops->name);
-		return -EBUSY;
-	}
-
-	if (!ops || !strlen(ops->name) || !ops->init_opp_table ||
-	    !ops->get_transition_latency) {
-		pr_err("%s: Invalid arm_bL_ops, exiting\n", __func__);
-		return -ENODEV;
-	}
-
-	arm_bL_ops = ops;
-
 	set_switching_enabled(bL_switcher_get_enabled());
 
 	for (i = 0; i < MAX_CLUSTERS; i++)
 		mutex_init(&cluster_lock[i]);
 
-	ret = cpufreq_register_driver(&bL_cpufreq_driver);
+	ret = cpufreq_register_driver(&ve_spc_cpufreq_driver);
 	if (ret) {
 		pr_info("%s: Failed registering platform driver: %s, err: %d\n",
-				__func__, ops->name, ret);
-		arm_bL_ops = NULL;
+			__func__, ve_spc_cpufreq_driver.name, ret);
 	} else {
 		ret = __bLs_register_notifier();
-		if (ret) {
-			cpufreq_unregister_driver(&bL_cpufreq_driver);
-			arm_bL_ops = NULL;
-		} else {
+		if (ret)
+			cpufreq_unregister_driver(&ve_spc_cpufreq_driver);
+		else
 			pr_info("%s: Registered platform driver: %s\n",
-					__func__, ops->name);
-		}
+				__func__, ve_spc_cpufreq_driver.name);
 	}
 
 	bL_switcher_put_enabled();
 	return ret;
 }
 
-void bL_cpufreq_unregister(const struct cpufreq_arm_bL_ops *ops)
+static int ve_spc_cpufreq_remove(struct platform_device *pdev)
 {
-	if (arm_bL_ops != ops) {
-		pr_err("%s: Registered with: %s, can't unregister, exiting\n",
-				__func__, arm_bL_ops->name);
-		return;
-	}
-
 	bL_switcher_get_enabled();
 	__bLs_unregister_notifier();
-	cpufreq_unregister_driver(&bL_cpufreq_driver);
+	cpufreq_unregister_driver(&ve_spc_cpufreq_driver);
 	bL_switcher_put_enabled();
 	pr_info("%s: Un-registered platform driver: %s\n", __func__,
-			arm_bL_ops->name);
-	arm_bL_ops = NULL;
-}
-
-static int ve_spc_init_opp_table(const struct cpumask *cpumask)
-{
-	struct device *cpu_dev = get_cpu_device(cpumask_first(cpumask));
-	/*
-	 * platform specific SPC code must initialise the opp table
-	 * so just check if the OPP count is non-zero
-	 */
-	return dev_pm_opp_get_opp_count(cpu_dev) <= 0;
-}
-
-static int ve_spc_get_transition_latency(struct device *cpu_dev)
-{
-	return 1000000; /* 1 ms */
-}
-
-static const struct cpufreq_arm_bL_ops ve_spc_cpufreq_ops = {
-	.name	= "vexpress-spc",
-	.get_transition_latency = ve_spc_get_transition_latency,
-	.init_opp_table = ve_spc_init_opp_table,
-};
-
-static int ve_spc_cpufreq_probe(struct platform_device *pdev)
-{
-	return bL_cpufreq_register(&ve_spc_cpufreq_ops);
-}
-
-static int ve_spc_cpufreq_remove(struct platform_device *pdev)
-{
-	bL_cpufreq_unregister(&ve_spc_cpufreq_ops);
+		ve_spc_cpufreq_driver.name);
 	return 0;
 }
 
-- 
2.17.1

