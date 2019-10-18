Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 686E3DC2E1
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 12:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438712AbfJRKi2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 06:38:28 -0400
Received: from [217.140.110.172] ([217.140.110.172]:34226 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2438605AbfJRKi1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Oct 2019 06:38:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36F63B56;
        Fri, 18 Oct 2019 03:38:03 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4EB413F6C4;
        Fri, 18 Oct 2019 03:38:02 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nico@fluxnic.net
Subject: [PATCH v3 3/5] cpufreq: vexpress-spc: drop unnessary cpufreq_arm_bL_ops abstraction
Date:   Fri, 18 Oct 2019 11:37:47 +0100
Message-Id: <20191018103749.11226-4-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018103749.11226-1-sudeep.holla@arm.com>
References: <20191018103749.11226-1-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

cpufreq_arm_bL_ops is no longer needed after merging the generic
arm_big_little and vexpress-spc driver. Remove it along with the
unused bL_cpufreq_{,un}register routines and rename some bL_*
functions to ve_spc_*.

Acked-by: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/vexpress-spc-cpufreq.c | 148 +++++++------------------
 1 file changed, 37 insertions(+), 111 deletions(-)

diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index 622dc42e42b1..3eaeefea66b9 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -26,20 +26,6 @@
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
@@ -62,7 +48,6 @@ static bool bL_switching_enabled;
 #define VIRT_FREQ(cluster, freq)    ((cluster == A7_CLUSTER) ? freq >> 1 : freq)
 
 static struct thermal_cooling_device *cdev[MAX_CLUSTERS];
-static const struct cpufreq_arm_bL_ops *arm_bL_ops;
 static struct clk *clk[MAX_CLUSTERS];
 static struct cpufreq_frequency_table *freq_table[MAX_CLUSTERS + 1];
 static atomic_t cluster_usage[MAX_CLUSTERS + 1];
@@ -120,7 +105,7 @@ static unsigned int clk_get_cpu_rate(unsigned int cpu)
 	return rate;
 }
 
-static unsigned int bL_cpufreq_get_rate(unsigned int cpu)
+static unsigned int ve_spc_cpufreq_get_rate(unsigned int cpu)
 {
 	if (is_bL_switching_enabled()) {
 		pr_debug("%s: freq: %d\n", __func__, per_cpu(cpu_last_req_freq,
@@ -133,7 +118,7 @@ static unsigned int bL_cpufreq_get_rate(unsigned int cpu)
 }
 
 static unsigned int
-bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
+ve_spc_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 {
 	u32 new_rate, prev_rate;
 	int ret;
@@ -213,8 +198,8 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 }
 
 /* Set clock frequency */
-static int bL_cpufreq_set_target(struct cpufreq_policy *policy,
-		unsigned int index)
+static int ve_spc_cpufreq_set_target(struct cpufreq_policy *policy,
+				     unsigned int index)
 {
 	u32 cpu = policy->cpu, cur_cluster, new_cluster, actual_cluster;
 	unsigned int freqs_new;
@@ -235,7 +220,8 @@ static int bL_cpufreq_set_target(struct cpufreq_policy *policy,
 		}
 	}
 
-	ret = bL_cpufreq_set_rate(cpu, actual_cluster, new_cluster, freqs_new);
+	ret = ve_spc_cpufreq_set_rate(cpu, actual_cluster, new_cluster,
+				      freqs_new);
 
 	if (!ret) {
 		arch_set_freq_scale(policy->related_cpus, freqs_new,
@@ -321,8 +307,6 @@ static void _put_cluster_clk_and_freq_table(struct device *cpu_dev,
 
 	clk_put(clk[cluster]);
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table[cluster]);
-	if (arm_bL_ops->free_opp_table)
-		arm_bL_ops->free_opp_table(cpumask);
 	dev_dbg(cpu_dev, "%s: cluster: %d\n", __func__, cluster);
 }
 
@@ -361,18 +345,19 @@ static int _get_cluster_clk_and_freq_table(struct device *cpu_dev,
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
 	if (ret) {
 		dev_err(cpu_dev, "%s: failed to init cpufreq table, cpu: %d, err: %d\n",
 				__func__, cpu_dev->id, ret);
-		goto free_opp_table;
+		goto out;
 	}
 
 	clk[cluster] = clk_get(cpu_dev, NULL);
@@ -388,9 +373,6 @@ static int _get_cluster_clk_and_freq_table(struct device *cpu_dev,
 	ret = PTR_ERR(clk[cluster]);
 	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table[cluster]);
 
-free_opp_table:
-	if (arm_bL_ops->free_opp_table)
-		arm_bL_ops->free_opp_table(cpumask);
 out:
 	dev_err(cpu_dev, "%s: Failed to get data for cluster: %d\n", __func__,
 			cluster);
@@ -459,7 +441,7 @@ static int get_cluster_clk_and_freq_table(struct device *cpu_dev,
 }
 
 /* Per-CPU initialization */
-static int bL_cpufreq_init(struct cpufreq_policy *policy)
+static int ve_spc_cpufreq_init(struct cpufreq_policy *policy)
 {
 	u32 cur_cluster = cpu_to_cluster(policy->cpu);
 	struct device *cpu_dev;
@@ -489,8 +471,7 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 		return ret;
 
 	policy->freq_table = freq_table[cur_cluster];
-	policy->cpuinfo.transition_latency =
-				arm_bL_ops->get_transition_latency(cpu_dev);
+	policy->cpuinfo.transition_latency = 1000000; /* 1 ms */
 
 	dev_pm_opp_of_register_em(policy->cpus);
 
@@ -501,7 +482,7 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int bL_cpufreq_exit(struct cpufreq_policy *policy)
+static int ve_spc_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct device *cpu_dev;
 	int cur_cluster = cpu_to_cluster(policy->cpu);
@@ -524,7 +505,7 @@ static int bL_cpufreq_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void bL_cpufreq_ready(struct cpufreq_policy *policy)
+static void ve_spc_cpufreq_ready(struct cpufreq_policy *policy)
 {
 	int cur_cluster = cpu_to_cluster(policy->cpu);
 
@@ -535,17 +516,17 @@ static void bL_cpufreq_ready(struct cpufreq_policy *policy)
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
 
@@ -558,17 +539,17 @@ static int bL_cpufreq_switcher_notifier(struct notifier_block *nfb,
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
@@ -596,95 +577,40 @@ static int __bLs_register_notifier(void) { return 0; }
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

