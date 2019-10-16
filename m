Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED465D8EDA
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 13:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404830AbfJPLDz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 07:03:55 -0400
Received: from foss.arm.com ([217.140.110.172]:36566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404825AbfJPLDy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Oct 2019 07:03:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2895B1597;
        Wed, 16 Oct 2019 04:03:53 -0700 (PDT)
Received: from usa.arm.com (unknown [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0383C3F6C4;
        Wed, 16 Oct 2019 04:03:51 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] cpufreq: merge arm_big_little and vexpress-spc
Date:   Wed, 16 Oct 2019 12:03:43 +0100
Message-Id: <20191016110344.15259-3-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016110344.15259-1-sudeep.holla@arm.com>
References: <20191016110344.15259-1-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

arm_big_little cpufreq driver was designed as a generic big little
driver that could be used by any platform and make use of bL switcher.
Over years alternate solutions have be designed and merged to deal with
bL/HMP systems like EAS.

Also since no other driver made use of generic arm_big_little cpufreq
driver except Vexpress SPC, we can merge them together as vexpress-spc
driver used only on Vexpress TC2(CA15_CA7) platform.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 MAINTAINERS                            |   5 +-
 drivers/cpufreq/Kconfig.arm            |  12 +-
 drivers/cpufreq/Makefile               |   2 -
 drivers/cpufreq/arm_big_little.c       | 658 ------------------------
 drivers/cpufreq/arm_big_little.h       |  43 --
 drivers/cpufreq/vexpress-spc-cpufreq.c | 661 ++++++++++++++++++++++++-
 6 files changed, 652 insertions(+), 729 deletions(-)
 delete mode 100644 drivers/cpufreq/arm_big_little.c
 delete mode 100644 drivers/cpufreq/arm_big_little.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a69e6db80c79..78a4adff7892 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4269,14 +4269,13 @@ F:	include/linux/cpufreq.h
 F:	include/linux/sched/cpufreq.h
 F:	tools/testing/selftests/cpufreq/
 
-CPU FREQUENCY DRIVERS - ARM BIG LITTLE
+CPU FREQUENCY DRIVERS - VEXPRESS SPC ARM BIG LITTLE
 M:	Viresh Kumar <viresh.kumar@linaro.org>
 M:	Sudeep Holla <sudeep.holla@arm.com>
 L:	linux-pm@vger.kernel.org
 W:	http://www.arm.com/products/processors/technologies/biglittleprocessing.php
 S:	Maintained
-F:	drivers/cpufreq/arm_big_little.h
-F:	drivers/cpufreq/arm_big_little.c
+F:	drivers/cpufreq/vexpress-spc-cpufreq.c
 
 CPU POWER MONITORING SUBSYSTEM
 M:	Thomas Renninger <trenn@suse.com>
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index a905796f7f85..3858d86cf409 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -49,14 +49,6 @@ config ARM_ARMADA_8K_CPUFREQ
 
 	  If in doubt, say N.
 
-# big LITTLE core layer and glue drivers
-config ARM_BIG_LITTLE_CPUFREQ
-	tristate "Generic ARM big LITTLE CPUfreq driver"
-	depends on ARM_CPU_TOPOLOGY && HAVE_CLK
-	select PM_OPP
-	help
-	  This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
-
 config ARM_SCPI_CPUFREQ
 	tristate "SCPI based CPUfreq driver"
 	depends on ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI
@@ -69,7 +61,9 @@ config ARM_SCPI_CPUFREQ
 
 config ARM_VEXPRESS_SPC_CPUFREQ
 	tristate "Versatile Express SPC based CPUfreq driver"
-	depends on ARM_BIG_LITTLE_CPUFREQ && ARCH_VEXPRESS_SPC
+	depends on ARM_CPU_TOPOLOGY && HAVE_CLK
+	depends on ARCH_VEXPRESS_SPC
+	select PM_OPP
 	help
 	  This add the CPUfreq driver support for Versatile Express
 	  big.LITTLE platforms using SPC for power management.
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 9a9f5ccd13d9..f6670c4abbb0 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -47,8 +47,6 @@ obj-$(CONFIG_X86_SFI_CPUFREQ)		+= sfi-cpufreq.o
 
 ##################################################################################
 # ARM SoC drivers
-obj-$(CONFIG_ARM_BIG_LITTLE_CPUFREQ)	+= arm_big_little.o
-
 obj-$(CONFIG_ARM_ARMADA_37XX_CPUFREQ)	+= armada-37xx-cpufreq.o
 obj-$(CONFIG_ARM_ARMADA_8K_CPUFREQ)	+= armada-8k-cpufreq.o
 obj-$(CONFIG_ARM_BRCMSTB_AVS_CPUFREQ)	+= brcmstb-avs-cpufreq.o
diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
deleted file mode 100644
index 7fe52fcddcf1..000000000000
--- a/drivers/cpufreq/arm_big_little.c
+++ /dev/null
@@ -1,658 +0,0 @@
-/*
- * ARM big.LITTLE Platforms CPUFreq support
- *
- * Copyright (C) 2013 ARM Ltd.
- * Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
- *
- * Copyright (C) 2013 Linaro.
- * Viresh Kumar <viresh.kumar@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- */
-
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
-#include <linux/clk.h>
-#include <linux/cpu.h>
-#include <linux/cpufreq.h>
-#include <linux/cpumask.h>
-#include <linux/cpu_cooling.h>
-#include <linux/export.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/of_platform.h>
-#include <linux/pm_opp.h>
-#include <linux/slab.h>
-#include <linux/topology.h>
-#include <linux/types.h>
-
-#include "arm_big_little.h"
-
-/* Currently we support only two clusters */
-#define A15_CLUSTER	0
-#define A7_CLUSTER	1
-#define MAX_CLUSTERS	2
-
-#ifdef CONFIG_BL_SWITCHER
-#include <asm/bL_switcher.h>
-static bool bL_switching_enabled;
-#define is_bL_switching_enabled()	bL_switching_enabled
-#define set_switching_enabled(x)	(bL_switching_enabled = (x))
-#else
-#define is_bL_switching_enabled()	false
-#define set_switching_enabled(x)	do { } while (0)
-#define bL_switch_request(...)		do { } while (0)
-#define bL_switcher_put_enabled()	do { } while (0)
-#define bL_switcher_get_enabled()	do { } while (0)
-#endif
-
-#define ACTUAL_FREQ(cluster, freq)  ((cluster == A7_CLUSTER) ? freq << 1 : freq)
-#define VIRT_FREQ(cluster, freq)    ((cluster == A7_CLUSTER) ? freq >> 1 : freq)
-
-static struct thermal_cooling_device *cdev[MAX_CLUSTERS];
-static const struct cpufreq_arm_bL_ops *arm_bL_ops;
-static struct clk *clk[MAX_CLUSTERS];
-static struct cpufreq_frequency_table *freq_table[MAX_CLUSTERS + 1];
-static atomic_t cluster_usage[MAX_CLUSTERS + 1];
-
-static unsigned int clk_big_min;	/* (Big) clock frequencies */
-static unsigned int clk_little_max;	/* Maximum clock frequency (Little) */
-
-static DEFINE_PER_CPU(unsigned int, physical_cluster);
-static DEFINE_PER_CPU(unsigned int, cpu_last_req_freq);
-
-static struct mutex cluster_lock[MAX_CLUSTERS];
-
-static inline int raw_cpu_to_cluster(int cpu)
-{
-	return topology_physical_package_id(cpu);
-}
-
-static inline int cpu_to_cluster(int cpu)
-{
-	return is_bL_switching_enabled() ?
-		MAX_CLUSTERS : raw_cpu_to_cluster(cpu);
-}
-
-static unsigned int find_cluster_maxfreq(int cluster)
-{
-	int j;
-	u32 max_freq = 0, cpu_freq;
-
-	for_each_online_cpu(j) {
-		cpu_freq = per_cpu(cpu_last_req_freq, j);
-
-		if ((cluster == per_cpu(physical_cluster, j)) &&
-				(max_freq < cpu_freq))
-			max_freq = cpu_freq;
-	}
-
-	pr_debug("%s: cluster: %d, max freq: %d\n", __func__, cluster,
-			max_freq);
-
-	return max_freq;
-}
-
-static unsigned int clk_get_cpu_rate(unsigned int cpu)
-{
-	u32 cur_cluster = per_cpu(physical_cluster, cpu);
-	u32 rate = clk_get_rate(clk[cur_cluster]) / 1000;
-
-	/* For switcher we use virtual A7 clock rates */
-	if (is_bL_switching_enabled())
-		rate = VIRT_FREQ(cur_cluster, rate);
-
-	pr_debug("%s: cpu: %d, cluster: %d, freq: %u\n", __func__, cpu,
-			cur_cluster, rate);
-
-	return rate;
-}
-
-static unsigned int bL_cpufreq_get_rate(unsigned int cpu)
-{
-	if (is_bL_switching_enabled()) {
-		pr_debug("%s: freq: %d\n", __func__, per_cpu(cpu_last_req_freq,
-					cpu));
-
-		return per_cpu(cpu_last_req_freq, cpu);
-	} else {
-		return clk_get_cpu_rate(cpu);
-	}
-}
-
-static unsigned int
-bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
-{
-	u32 new_rate, prev_rate;
-	int ret;
-	bool bLs = is_bL_switching_enabled();
-
-	mutex_lock(&cluster_lock[new_cluster]);
-
-	if (bLs) {
-		prev_rate = per_cpu(cpu_last_req_freq, cpu);
-		per_cpu(cpu_last_req_freq, cpu) = rate;
-		per_cpu(physical_cluster, cpu) = new_cluster;
-
-		new_rate = find_cluster_maxfreq(new_cluster);
-		new_rate = ACTUAL_FREQ(new_cluster, new_rate);
-	} else {
-		new_rate = rate;
-	}
-
-	pr_debug("%s: cpu: %d, old cluster: %d, new cluster: %d, freq: %d\n",
-			__func__, cpu, old_cluster, new_cluster, new_rate);
-
-	ret = clk_set_rate(clk[new_cluster], new_rate * 1000);
-	if (!ret) {
-		/*
-		 * FIXME: clk_set_rate hasn't returned an error here however it
-		 * may be that clk_change_rate failed due to hardware or
-		 * firmware issues and wasn't able to report that due to the
-		 * current design of the clk core layer. To work around this
-		 * problem we will read back the clock rate and check it is
-		 * correct. This needs to be removed once clk core is fixed.
-		 */
-		if (clk_get_rate(clk[new_cluster]) != new_rate * 1000)
-			ret = -EIO;
-	}
-
-	if (WARN_ON(ret)) {
-		pr_err("clk_set_rate failed: %d, new cluster: %d\n", ret,
-				new_cluster);
-		if (bLs) {
-			per_cpu(cpu_last_req_freq, cpu) = prev_rate;
-			per_cpu(physical_cluster, cpu) = old_cluster;
-		}
-
-		mutex_unlock(&cluster_lock[new_cluster]);
-
-		return ret;
-	}
-
-	mutex_unlock(&cluster_lock[new_cluster]);
-
-	/* Recalc freq for old cluster when switching clusters */
-	if (old_cluster != new_cluster) {
-		pr_debug("%s: cpu: %d, old cluster: %d, new cluster: %d\n",
-				__func__, cpu, old_cluster, new_cluster);
-
-		/* Switch cluster */
-		bL_switch_request(cpu, new_cluster);
-
-		mutex_lock(&cluster_lock[old_cluster]);
-
-		/* Set freq of old cluster if there are cpus left on it */
-		new_rate = find_cluster_maxfreq(old_cluster);
-		new_rate = ACTUAL_FREQ(old_cluster, new_rate);
-
-		if (new_rate) {
-			pr_debug("%s: Updating rate of old cluster: %d, to freq: %d\n",
-					__func__, old_cluster, new_rate);
-
-			if (clk_set_rate(clk[old_cluster], new_rate * 1000))
-				pr_err("%s: clk_set_rate failed: %d, old cluster: %d\n",
-						__func__, ret, old_cluster);
-		}
-		mutex_unlock(&cluster_lock[old_cluster]);
-	}
-
-	return 0;
-}
-
-/* Set clock frequency */
-static int bL_cpufreq_set_target(struct cpufreq_policy *policy,
-		unsigned int index)
-{
-	u32 cpu = policy->cpu, cur_cluster, new_cluster, actual_cluster;
-	unsigned int freqs_new;
-	int ret;
-
-	cur_cluster = cpu_to_cluster(cpu);
-	new_cluster = actual_cluster = per_cpu(physical_cluster, cpu);
-
-	freqs_new = freq_table[cur_cluster][index].frequency;
-
-	if (is_bL_switching_enabled()) {
-		if ((actual_cluster == A15_CLUSTER) &&
-				(freqs_new < clk_big_min)) {
-			new_cluster = A7_CLUSTER;
-		} else if ((actual_cluster == A7_CLUSTER) &&
-				(freqs_new > clk_little_max)) {
-			new_cluster = A15_CLUSTER;
-		}
-	}
-
-	ret = bL_cpufreq_set_rate(cpu, actual_cluster, new_cluster, freqs_new);
-
-	if (!ret) {
-		arch_set_freq_scale(policy->related_cpus, freqs_new,
-				    policy->cpuinfo.max_freq);
-	}
-
-	return ret;
-}
-
-static inline u32 get_table_count(struct cpufreq_frequency_table *table)
-{
-	int count;
-
-	for (count = 0; table[count].frequency != CPUFREQ_TABLE_END; count++)
-		;
-
-	return count;
-}
-
-/* get the minimum frequency in the cpufreq_frequency_table */
-static inline u32 get_table_min(struct cpufreq_frequency_table *table)
-{
-	struct cpufreq_frequency_table *pos;
-	uint32_t min_freq = ~0;
-	cpufreq_for_each_entry(pos, table)
-		if (pos->frequency < min_freq)
-			min_freq = pos->frequency;
-	return min_freq;
-}
-
-/* get the maximum frequency in the cpufreq_frequency_table */
-static inline u32 get_table_max(struct cpufreq_frequency_table *table)
-{
-	struct cpufreq_frequency_table *pos;
-	uint32_t max_freq = 0;
-	cpufreq_for_each_entry(pos, table)
-		if (pos->frequency > max_freq)
-			max_freq = pos->frequency;
-	return max_freq;
-}
-
-static int merge_cluster_tables(void)
-{
-	int i, j, k = 0, count = 1;
-	struct cpufreq_frequency_table *table;
-
-	for (i = 0; i < MAX_CLUSTERS; i++)
-		count += get_table_count(freq_table[i]);
-
-	table = kcalloc(count, sizeof(*table), GFP_KERNEL);
-	if (!table)
-		return -ENOMEM;
-
-	freq_table[MAX_CLUSTERS] = table;
-
-	/* Add in reverse order to get freqs in increasing order */
-	for (i = MAX_CLUSTERS - 1; i >= 0; i--) {
-		for (j = 0; freq_table[i][j].frequency != CPUFREQ_TABLE_END;
-				j++) {
-			table[k].frequency = VIRT_FREQ(i,
-					freq_table[i][j].frequency);
-			pr_debug("%s: index: %d, freq: %d\n", __func__, k,
-					table[k].frequency);
-			k++;
-		}
-	}
-
-	table[k].driver_data = k;
-	table[k].frequency = CPUFREQ_TABLE_END;
-
-	pr_debug("%s: End, table: %p, count: %d\n", __func__, table, k);
-
-	return 0;
-}
-
-static void _put_cluster_clk_and_freq_table(struct device *cpu_dev,
-					    const struct cpumask *cpumask)
-{
-	u32 cluster = raw_cpu_to_cluster(cpu_dev->id);
-
-	if (!freq_table[cluster])
-		return;
-
-	clk_put(clk[cluster]);
-	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table[cluster]);
-	if (arm_bL_ops->free_opp_table)
-		arm_bL_ops->free_opp_table(cpumask);
-	dev_dbg(cpu_dev, "%s: cluster: %d\n", __func__, cluster);
-}
-
-static void put_cluster_clk_and_freq_table(struct device *cpu_dev,
-					   const struct cpumask *cpumask)
-{
-	u32 cluster = cpu_to_cluster(cpu_dev->id);
-	int i;
-
-	if (atomic_dec_return(&cluster_usage[cluster]))
-		return;
-
-	if (cluster < MAX_CLUSTERS)
-		return _put_cluster_clk_and_freq_table(cpu_dev, cpumask);
-
-	for_each_present_cpu(i) {
-		struct device *cdev = get_cpu_device(i);
-		if (!cdev) {
-			pr_err("%s: failed to get cpu%d device\n", __func__, i);
-			return;
-		}
-
-		_put_cluster_clk_and_freq_table(cdev, cpumask);
-	}
-
-	/* free virtual table */
-	kfree(freq_table[cluster]);
-}
-
-static int _get_cluster_clk_and_freq_table(struct device *cpu_dev,
-					   const struct cpumask *cpumask)
-{
-	u32 cluster = raw_cpu_to_cluster(cpu_dev->id);
-	int ret;
-
-	if (freq_table[cluster])
-		return 0;
-
-	ret = arm_bL_ops->init_opp_table(cpumask);
-	if (ret) {
-		dev_err(cpu_dev, "%s: init_opp_table failed, cpu: %d, err: %d\n",
-				__func__, cpu_dev->id, ret);
-		goto out;
-	}
-
-	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table[cluster]);
-	if (ret) {
-		dev_err(cpu_dev, "%s: failed to init cpufreq table, cpu: %d, err: %d\n",
-				__func__, cpu_dev->id, ret);
-		goto free_opp_table;
-	}
-
-	clk[cluster] = clk_get(cpu_dev, NULL);
-	if (!IS_ERR(clk[cluster])) {
-		dev_dbg(cpu_dev, "%s: clk: %p & freq table: %p, cluster: %d\n",
-				__func__, clk[cluster], freq_table[cluster],
-				cluster);
-		return 0;
-	}
-
-	dev_err(cpu_dev, "%s: Failed to get clk for cpu: %d, cluster: %d\n",
-			__func__, cpu_dev->id, cluster);
-	ret = PTR_ERR(clk[cluster]);
-	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table[cluster]);
-
-free_opp_table:
-	if (arm_bL_ops->free_opp_table)
-		arm_bL_ops->free_opp_table(cpumask);
-out:
-	dev_err(cpu_dev, "%s: Failed to get data for cluster: %d\n", __func__,
-			cluster);
-	return ret;
-}
-
-static int get_cluster_clk_and_freq_table(struct device *cpu_dev,
-					  const struct cpumask *cpumask)
-{
-	u32 cluster = cpu_to_cluster(cpu_dev->id);
-	int i, ret;
-
-	if (atomic_inc_return(&cluster_usage[cluster]) != 1)
-		return 0;
-
-	if (cluster < MAX_CLUSTERS) {
-		ret = _get_cluster_clk_and_freq_table(cpu_dev, cpumask);
-		if (ret)
-			atomic_dec(&cluster_usage[cluster]);
-		return ret;
-	}
-
-	/*
-	 * Get data for all clusters and fill virtual cluster with a merge of
-	 * both
-	 */
-	for_each_present_cpu(i) {
-		struct device *cdev = get_cpu_device(i);
-		if (!cdev) {
-			pr_err("%s: failed to get cpu%d device\n", __func__, i);
-			return -ENODEV;
-		}
-
-		ret = _get_cluster_clk_and_freq_table(cdev, cpumask);
-		if (ret)
-			goto put_clusters;
-	}
-
-	ret = merge_cluster_tables();
-	if (ret)
-		goto put_clusters;
-
-	/* Assuming 2 cluster, set clk_big_min and clk_little_max */
-	clk_big_min = get_table_min(freq_table[0]);
-	clk_little_max = VIRT_FREQ(1, get_table_max(freq_table[1]));
-
-	pr_debug("%s: cluster: %d, clk_big_min: %d, clk_little_max: %d\n",
-			__func__, cluster, clk_big_min, clk_little_max);
-
-	return 0;
-
-put_clusters:
-	for_each_present_cpu(i) {
-		struct device *cdev = get_cpu_device(i);
-		if (!cdev) {
-			pr_err("%s: failed to get cpu%d device\n", __func__, i);
-			return -ENODEV;
-		}
-
-		_put_cluster_clk_and_freq_table(cdev, cpumask);
-	}
-
-	atomic_dec(&cluster_usage[cluster]);
-
-	return ret;
-}
-
-/* Per-CPU initialization */
-static int bL_cpufreq_init(struct cpufreq_policy *policy)
-{
-	u32 cur_cluster = cpu_to_cluster(policy->cpu);
-	struct device *cpu_dev;
-	int ret;
-
-	cpu_dev = get_cpu_device(policy->cpu);
-	if (!cpu_dev) {
-		pr_err("%s: failed to get cpu%d device\n", __func__,
-				policy->cpu);
-		return -ENODEV;
-	}
-
-	if (cur_cluster < MAX_CLUSTERS) {
-		int cpu;
-
-		cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
-
-		for_each_cpu(cpu, policy->cpus)
-			per_cpu(physical_cluster, cpu) = cur_cluster;
-	} else {
-		/* Assumption: during init, we are always running on A15 */
-		per_cpu(physical_cluster, policy->cpu) = A15_CLUSTER;
-	}
-
-	ret = get_cluster_clk_and_freq_table(cpu_dev, policy->cpus);
-	if (ret)
-		return ret;
-
-	policy->freq_table = freq_table[cur_cluster];
-	policy->cpuinfo.transition_latency =
-				arm_bL_ops->get_transition_latency(cpu_dev);
-
-	dev_pm_opp_of_register_em(policy->cpus);
-
-	if (is_bL_switching_enabled())
-		per_cpu(cpu_last_req_freq, policy->cpu) = clk_get_cpu_rate(policy->cpu);
-
-	dev_info(cpu_dev, "%s: CPU %d initialized\n", __func__, policy->cpu);
-	return 0;
-}
-
-static int bL_cpufreq_exit(struct cpufreq_policy *policy)
-{
-	struct device *cpu_dev;
-	int cur_cluster = cpu_to_cluster(policy->cpu);
-
-	if (cur_cluster < MAX_CLUSTERS) {
-		cpufreq_cooling_unregister(cdev[cur_cluster]);
-		cdev[cur_cluster] = NULL;
-	}
-
-	cpu_dev = get_cpu_device(policy->cpu);
-	if (!cpu_dev) {
-		pr_err("%s: failed to get cpu%d device\n", __func__,
-				policy->cpu);
-		return -ENODEV;
-	}
-
-	put_cluster_clk_and_freq_table(cpu_dev, policy->related_cpus);
-	dev_dbg(cpu_dev, "%s: Exited, cpu: %d\n", __func__, policy->cpu);
-
-	return 0;
-}
-
-static void bL_cpufreq_ready(struct cpufreq_policy *policy)
-{
-	int cur_cluster = cpu_to_cluster(policy->cpu);
-
-	/* Do not register a cpu_cooling device if we are in IKS mode */
-	if (cur_cluster >= MAX_CLUSTERS)
-		return;
-
-	cdev[cur_cluster] = of_cpufreq_cooling_register(policy);
-}
-
-static struct cpufreq_driver bL_cpufreq_driver = {
-	.name			= "arm-big-little",
-	.flags			= CPUFREQ_STICKY |
-					CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
-					CPUFREQ_NEED_INITIAL_FREQ_CHECK,
-	.verify			= cpufreq_generic_frequency_table_verify,
-	.target_index		= bL_cpufreq_set_target,
-	.get			= bL_cpufreq_get_rate,
-	.init			= bL_cpufreq_init,
-	.exit			= bL_cpufreq_exit,
-	.ready			= bL_cpufreq_ready,
-	.attr			= cpufreq_generic_attr,
-};
-
-#ifdef CONFIG_BL_SWITCHER
-static int bL_cpufreq_switcher_notifier(struct notifier_block *nfb,
-					unsigned long action, void *_arg)
-{
-	pr_debug("%s: action: %ld\n", __func__, action);
-
-	switch (action) {
-	case BL_NOTIFY_PRE_ENABLE:
-	case BL_NOTIFY_PRE_DISABLE:
-		cpufreq_unregister_driver(&bL_cpufreq_driver);
-		break;
-
-	case BL_NOTIFY_POST_ENABLE:
-		set_switching_enabled(true);
-		cpufreq_register_driver(&bL_cpufreq_driver);
-		break;
-
-	case BL_NOTIFY_POST_DISABLE:
-		set_switching_enabled(false);
-		cpufreq_register_driver(&bL_cpufreq_driver);
-		break;
-
-	default:
-		return NOTIFY_DONE;
-	}
-
-	return NOTIFY_OK;
-}
-
-static struct notifier_block bL_switcher_notifier = {
-	.notifier_call = bL_cpufreq_switcher_notifier,
-};
-
-static int __bLs_register_notifier(void)
-{
-	return bL_switcher_register_notifier(&bL_switcher_notifier);
-}
-
-static int __bLs_unregister_notifier(void)
-{
-	return bL_switcher_unregister_notifier(&bL_switcher_notifier);
-}
-#else
-static int __bLs_register_notifier(void) { return 0; }
-static int __bLs_unregister_notifier(void) { return 0; }
-#endif
-
-int bL_cpufreq_register(const struct cpufreq_arm_bL_ops *ops)
-{
-	int ret, i;
-
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
-	set_switching_enabled(bL_switcher_get_enabled());
-
-	for (i = 0; i < MAX_CLUSTERS; i++)
-		mutex_init(&cluster_lock[i]);
-
-	ret = cpufreq_register_driver(&bL_cpufreq_driver);
-	if (ret) {
-		pr_info("%s: Failed registering platform driver: %s, err: %d\n",
-				__func__, ops->name, ret);
-		arm_bL_ops = NULL;
-	} else {
-		ret = __bLs_register_notifier();
-		if (ret) {
-			cpufreq_unregister_driver(&bL_cpufreq_driver);
-			arm_bL_ops = NULL;
-		} else {
-			pr_info("%s: Registered platform driver: %s\n",
-					__func__, ops->name);
-		}
-	}
-
-	bL_switcher_put_enabled();
-	return ret;
-}
-EXPORT_SYMBOL_GPL(bL_cpufreq_register);
-
-void bL_cpufreq_unregister(const struct cpufreq_arm_bL_ops *ops)
-{
-	if (arm_bL_ops != ops) {
-		pr_err("%s: Registered with: %s, can't unregister, exiting\n",
-				__func__, arm_bL_ops->name);
-		return;
-	}
-
-	bL_switcher_get_enabled();
-	__bLs_unregister_notifier();
-	cpufreq_unregister_driver(&bL_cpufreq_driver);
-	bL_switcher_put_enabled();
-	pr_info("%s: Un-registered platform driver: %s\n", __func__,
-			arm_bL_ops->name);
-	arm_bL_ops = NULL;
-}
-EXPORT_SYMBOL_GPL(bL_cpufreq_unregister);
-
-MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
-MODULE_DESCRIPTION("Generic ARM big LITTLE cpufreq driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/cpufreq/arm_big_little.h b/drivers/cpufreq/arm_big_little.h
deleted file mode 100644
index 88a176e466c8..000000000000
--- a/drivers/cpufreq/arm_big_little.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * ARM big.LITTLE platform's CPUFreq header file
- *
- * Copyright (C) 2013 ARM Ltd.
- * Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
- *
- * Copyright (C) 2013 Linaro.
- * Viresh Kumar <viresh.kumar@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- */
-#ifndef CPUFREQ_ARM_BIG_LITTLE_H
-#define CPUFREQ_ARM_BIG_LITTLE_H
-
-#include <linux/cpufreq.h>
-#include <linux/device.h>
-#include <linux/types.h>
-
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
-int bL_cpufreq_register(const struct cpufreq_arm_bL_ops *ops);
-void bL_cpufreq_unregister(const struct cpufreq_arm_bL_ops *ops);
-
-#endif /* CPUFREQ_ARM_BIG_LITTLE_H */
diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index 53237289e606..9d3f91832990 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -1,31 +1,661 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Versatile Express SPC CPUFreq Interface driver
  *
- * It provides necessary ops to arm_big_little cpufreq driver.
+ * Copyright (C) 2019 ARM Ltd.
+ * Sudeep Holla <sudeep.holla@arm.com>
  *
- * Copyright (C) 2013 ARM Ltd.
- * Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
+ * Copyright (C) 2013 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/clk.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
+#include <linux/cpumask.h>
+#include <linux/cpu_cooling.h>
+#include <linux/device.h>
+#include <linux/export.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
+#include <linux/slab.h>
+#include <linux/topology.h>
 #include <linux/types.h>
 
-#include "arm_big_little.h"
+struct cpufreq_arm_bL_ops {
+	char name[CPUFREQ_NAME_LEN];
+
+	/*
+	 * This must set opp table for cpu_dev in a similar way as done by
+	 * dev_pm_opp_of_add_table().
+	 */
+	int (*init_opp_table)(const struct cpumask *cpumask);
+
+	/* Optional */
+	int (*get_transition_latency)(struct device *cpu_dev);
+	void (*free_opp_table)(const struct cpumask *cpumask);
+};
+
+/* Currently we support only two clusters */
+#define A15_CLUSTER	0
+#define A7_CLUSTER	1
+#define MAX_CLUSTERS	2
+
+#ifdef CONFIG_BL_SWITCHER
+#include <asm/bL_switcher.h>
+static bool bL_switching_enabled;
+#define is_bL_switching_enabled()	bL_switching_enabled
+#define set_switching_enabled(x)	(bL_switching_enabled = (x))
+#else
+#define is_bL_switching_enabled()	false
+#define set_switching_enabled(x)	do { } while (0)
+#define bL_switch_request(...)		do { } while (0)
+#define bL_switcher_put_enabled()	do { } while (0)
+#define bL_switcher_get_enabled()	do { } while (0)
+#endif
+
+#define ACTUAL_FREQ(cluster, freq)  ((cluster == A7_CLUSTER) ? freq << 1 : freq)
+#define VIRT_FREQ(cluster, freq)    ((cluster == A7_CLUSTER) ? freq >> 1 : freq)
+
+static struct thermal_cooling_device *cdev[MAX_CLUSTERS];
+static const struct cpufreq_arm_bL_ops *arm_bL_ops;
+static struct clk *clk[MAX_CLUSTERS];
+static struct cpufreq_frequency_table *freq_table[MAX_CLUSTERS + 1];
+static atomic_t cluster_usage[MAX_CLUSTERS + 1];
+
+static unsigned int clk_big_min;	/* (Big) clock frequencies */
+static unsigned int clk_little_max;	/* Maximum clock frequency (Little) */
+
+static DEFINE_PER_CPU(unsigned int, physical_cluster);
+static DEFINE_PER_CPU(unsigned int, cpu_last_req_freq);
+
+static struct mutex cluster_lock[MAX_CLUSTERS];
+
+static inline int raw_cpu_to_cluster(int cpu)
+{
+	return topology_physical_package_id(cpu);
+}
+
+static inline int cpu_to_cluster(int cpu)
+{
+	return is_bL_switching_enabled() ?
+		MAX_CLUSTERS : raw_cpu_to_cluster(cpu);
+}
+
+static unsigned int find_cluster_maxfreq(int cluster)
+{
+	int j;
+	u32 max_freq = 0, cpu_freq;
+
+	for_each_online_cpu(j) {
+		cpu_freq = per_cpu(cpu_last_req_freq, j);
+
+		if ((cluster == per_cpu(physical_cluster, j)) &&
+				(max_freq < cpu_freq))
+			max_freq = cpu_freq;
+	}
+
+	pr_debug("%s: cluster: %d, max freq: %d\n", __func__, cluster,
+			max_freq);
+
+	return max_freq;
+}
+
+static unsigned int clk_get_cpu_rate(unsigned int cpu)
+{
+	u32 cur_cluster = per_cpu(physical_cluster, cpu);
+	u32 rate = clk_get_rate(clk[cur_cluster]) / 1000;
+
+	/* For switcher we use virtual A7 clock rates */
+	if (is_bL_switching_enabled())
+		rate = VIRT_FREQ(cur_cluster, rate);
+
+	pr_debug("%s: cpu: %d, cluster: %d, freq: %u\n", __func__, cpu,
+			cur_cluster, rate);
+
+	return rate;
+}
+
+static unsigned int bL_cpufreq_get_rate(unsigned int cpu)
+{
+	if (is_bL_switching_enabled()) {
+		pr_debug("%s: freq: %d\n", __func__, per_cpu(cpu_last_req_freq,
+					cpu));
+
+		return per_cpu(cpu_last_req_freq, cpu);
+	} else {
+		return clk_get_cpu_rate(cpu);
+	}
+}
+
+static unsigned int
+bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
+{
+	u32 new_rate, prev_rate;
+	int ret;
+	bool bLs = is_bL_switching_enabled();
+
+	mutex_lock(&cluster_lock[new_cluster]);
+
+	if (bLs) {
+		prev_rate = per_cpu(cpu_last_req_freq, cpu);
+		per_cpu(cpu_last_req_freq, cpu) = rate;
+		per_cpu(physical_cluster, cpu) = new_cluster;
+
+		new_rate = find_cluster_maxfreq(new_cluster);
+		new_rate = ACTUAL_FREQ(new_cluster, new_rate);
+	} else {
+		new_rate = rate;
+	}
+
+	pr_debug("%s: cpu: %d, old cluster: %d, new cluster: %d, freq: %d\n",
+			__func__, cpu, old_cluster, new_cluster, new_rate);
+
+	ret = clk_set_rate(clk[new_cluster], new_rate * 1000);
+	if (!ret) {
+		/*
+		 * FIXME: clk_set_rate hasn't returned an error here however it
+		 * may be that clk_change_rate failed due to hardware or
+		 * firmware issues and wasn't able to report that due to the
+		 * current design of the clk core layer. To work around this
+		 * problem we will read back the clock rate and check it is
+		 * correct. This needs to be removed once clk core is fixed.
+		 */
+		if (clk_get_rate(clk[new_cluster]) != new_rate * 1000)
+			ret = -EIO;
+	}
+
+	if (WARN_ON(ret)) {
+		pr_err("clk_set_rate failed: %d, new cluster: %d\n", ret,
+				new_cluster);
+		if (bLs) {
+			per_cpu(cpu_last_req_freq, cpu) = prev_rate;
+			per_cpu(physical_cluster, cpu) = old_cluster;
+		}
+
+		mutex_unlock(&cluster_lock[new_cluster]);
+
+		return ret;
+	}
+
+	mutex_unlock(&cluster_lock[new_cluster]);
+
+	/* Recalc freq for old cluster when switching clusters */
+	if (old_cluster != new_cluster) {
+		pr_debug("%s: cpu: %d, old cluster: %d, new cluster: %d\n",
+				__func__, cpu, old_cluster, new_cluster);
+
+		/* Switch cluster */
+		bL_switch_request(cpu, new_cluster);
+
+		mutex_lock(&cluster_lock[old_cluster]);
+
+		/* Set freq of old cluster if there are cpus left on it */
+		new_rate = find_cluster_maxfreq(old_cluster);
+		new_rate = ACTUAL_FREQ(old_cluster, new_rate);
+
+		if (new_rate) {
+			pr_debug("%s: Updating rate of old cluster: %d, to freq: %d\n",
+					__func__, old_cluster, new_rate);
+
+			if (clk_set_rate(clk[old_cluster], new_rate * 1000))
+				pr_err("%s: clk_set_rate failed: %d, old cluster: %d\n",
+						__func__, ret, old_cluster);
+		}
+		mutex_unlock(&cluster_lock[old_cluster]);
+	}
+
+	return 0;
+}
+
+/* Set clock frequency */
+static int bL_cpufreq_set_target(struct cpufreq_policy *policy,
+		unsigned int index)
+{
+	u32 cpu = policy->cpu, cur_cluster, new_cluster, actual_cluster;
+	unsigned int freqs_new;
+	int ret;
+
+	cur_cluster = cpu_to_cluster(cpu);
+	new_cluster = actual_cluster = per_cpu(physical_cluster, cpu);
+
+	freqs_new = freq_table[cur_cluster][index].frequency;
+
+	if (is_bL_switching_enabled()) {
+		if ((actual_cluster == A15_CLUSTER) &&
+				(freqs_new < clk_big_min)) {
+			new_cluster = A7_CLUSTER;
+		} else if ((actual_cluster == A7_CLUSTER) &&
+				(freqs_new > clk_little_max)) {
+			new_cluster = A15_CLUSTER;
+		}
+	}
+
+	ret = bL_cpufreq_set_rate(cpu, actual_cluster, new_cluster, freqs_new);
+
+	if (!ret) {
+		arch_set_freq_scale(policy->related_cpus, freqs_new,
+				    policy->cpuinfo.max_freq);
+	}
+
+	return ret;
+}
+
+static inline u32 get_table_count(struct cpufreq_frequency_table *table)
+{
+	int count;
+
+	for (count = 0; table[count].frequency != CPUFREQ_TABLE_END; count++)
+		;
+
+	return count;
+}
+
+/* get the minimum frequency in the cpufreq_frequency_table */
+static inline u32 get_table_min(struct cpufreq_frequency_table *table)
+{
+	struct cpufreq_frequency_table *pos;
+	uint32_t min_freq = ~0;
+	cpufreq_for_each_entry(pos, table)
+		if (pos->frequency < min_freq)
+			min_freq = pos->frequency;
+	return min_freq;
+}
+
+/* get the maximum frequency in the cpufreq_frequency_table */
+static inline u32 get_table_max(struct cpufreq_frequency_table *table)
+{
+	struct cpufreq_frequency_table *pos;
+	uint32_t max_freq = 0;
+	cpufreq_for_each_entry(pos, table)
+		if (pos->frequency > max_freq)
+			max_freq = pos->frequency;
+	return max_freq;
+}
+
+static int merge_cluster_tables(void)
+{
+	int i, j, k = 0, count = 1;
+	struct cpufreq_frequency_table *table;
+
+	for (i = 0; i < MAX_CLUSTERS; i++)
+		count += get_table_count(freq_table[i]);
+
+	table = kcalloc(count, sizeof(*table), GFP_KERNEL);
+	if (!table)
+		return -ENOMEM;
+
+	freq_table[MAX_CLUSTERS] = table;
+
+	/* Add in reverse order to get freqs in increasing order */
+	for (i = MAX_CLUSTERS - 1; i >= 0; i--) {
+		for (j = 0; freq_table[i][j].frequency != CPUFREQ_TABLE_END;
+				j++) {
+			table[k].frequency = VIRT_FREQ(i,
+					freq_table[i][j].frequency);
+			pr_debug("%s: index: %d, freq: %d\n", __func__, k,
+					table[k].frequency);
+			k++;
+		}
+	}
+
+	table[k].driver_data = k;
+	table[k].frequency = CPUFREQ_TABLE_END;
+
+	pr_debug("%s: End, table: %p, count: %d\n", __func__, table, k);
+
+	return 0;
+}
+
+static void _put_cluster_clk_and_freq_table(struct device *cpu_dev,
+					    const struct cpumask *cpumask)
+{
+	u32 cluster = raw_cpu_to_cluster(cpu_dev->id);
+
+	if (!freq_table[cluster])
+		return;
+
+	clk_put(clk[cluster]);
+	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table[cluster]);
+	if (arm_bL_ops->free_opp_table)
+		arm_bL_ops->free_opp_table(cpumask);
+	dev_dbg(cpu_dev, "%s: cluster: %d\n", __func__, cluster);
+}
+
+static void put_cluster_clk_and_freq_table(struct device *cpu_dev,
+					   const struct cpumask *cpumask)
+{
+	u32 cluster = cpu_to_cluster(cpu_dev->id);
+	int i;
+
+	if (atomic_dec_return(&cluster_usage[cluster]))
+		return;
+
+	if (cluster < MAX_CLUSTERS)
+		return _put_cluster_clk_and_freq_table(cpu_dev, cpumask);
+
+	for_each_present_cpu(i) {
+		struct device *cdev = get_cpu_device(i);
+		if (!cdev) {
+			pr_err("%s: failed to get cpu%d device\n", __func__, i);
+			return;
+		}
+
+		_put_cluster_clk_and_freq_table(cdev, cpumask);
+	}
+
+	/* free virtual table */
+	kfree(freq_table[cluster]);
+}
+
+static int _get_cluster_clk_and_freq_table(struct device *cpu_dev,
+					   const struct cpumask *cpumask)
+{
+	u32 cluster = raw_cpu_to_cluster(cpu_dev->id);
+	int ret;
+
+	if (freq_table[cluster])
+		return 0;
+
+	ret = arm_bL_ops->init_opp_table(cpumask);
+	if (ret) {
+		dev_err(cpu_dev, "%s: init_opp_table failed, cpu: %d, err: %d\n",
+				__func__, cpu_dev->id, ret);
+		goto out;
+	}
+
+	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table[cluster]);
+	if (ret) {
+		dev_err(cpu_dev, "%s: failed to init cpufreq table, cpu: %d, err: %d\n",
+				__func__, cpu_dev->id, ret);
+		goto free_opp_table;
+	}
+
+	clk[cluster] = clk_get(cpu_dev, NULL);
+	if (!IS_ERR(clk[cluster])) {
+		dev_dbg(cpu_dev, "%s: clk: %p & freq table: %p, cluster: %d\n",
+				__func__, clk[cluster], freq_table[cluster],
+				cluster);
+		return 0;
+	}
+
+	dev_err(cpu_dev, "%s: Failed to get clk for cpu: %d, cluster: %d\n",
+			__func__, cpu_dev->id, cluster);
+	ret = PTR_ERR(clk[cluster]);
+	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table[cluster]);
+
+free_opp_table:
+	if (arm_bL_ops->free_opp_table)
+		arm_bL_ops->free_opp_table(cpumask);
+out:
+	dev_err(cpu_dev, "%s: Failed to get data for cluster: %d\n", __func__,
+			cluster);
+	return ret;
+}
+
+static int get_cluster_clk_and_freq_table(struct device *cpu_dev,
+					  const struct cpumask *cpumask)
+{
+	u32 cluster = cpu_to_cluster(cpu_dev->id);
+	int i, ret;
+
+	if (atomic_inc_return(&cluster_usage[cluster]) != 1)
+		return 0;
+
+	if (cluster < MAX_CLUSTERS) {
+		ret = _get_cluster_clk_and_freq_table(cpu_dev, cpumask);
+		if (ret)
+			atomic_dec(&cluster_usage[cluster]);
+		return ret;
+	}
+
+	/*
+	 * Get data for all clusters and fill virtual cluster with a merge of
+	 * both
+	 */
+	for_each_present_cpu(i) {
+		struct device *cdev = get_cpu_device(i);
+		if (!cdev) {
+			pr_err("%s: failed to get cpu%d device\n", __func__, i);
+			return -ENODEV;
+		}
+
+		ret = _get_cluster_clk_and_freq_table(cdev, cpumask);
+		if (ret)
+			goto put_clusters;
+	}
+
+	ret = merge_cluster_tables();
+	if (ret)
+		goto put_clusters;
+
+	/* Assuming 2 cluster, set clk_big_min and clk_little_max */
+	clk_big_min = get_table_min(freq_table[0]);
+	clk_little_max = VIRT_FREQ(1, get_table_max(freq_table[1]));
+
+	pr_debug("%s: cluster: %d, clk_big_min: %d, clk_little_max: %d\n",
+			__func__, cluster, clk_big_min, clk_little_max);
+
+	return 0;
+
+put_clusters:
+	for_each_present_cpu(i) {
+		struct device *cdev = get_cpu_device(i);
+		if (!cdev) {
+			pr_err("%s: failed to get cpu%d device\n", __func__, i);
+			return -ENODEV;
+		}
+
+		_put_cluster_clk_and_freq_table(cdev, cpumask);
+	}
+
+	atomic_dec(&cluster_usage[cluster]);
+
+	return ret;
+}
+
+/* Per-CPU initialization */
+static int bL_cpufreq_init(struct cpufreq_policy *policy)
+{
+	u32 cur_cluster = cpu_to_cluster(policy->cpu);
+	struct device *cpu_dev;
+	int ret;
+
+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev) {
+		pr_err("%s: failed to get cpu%d device\n", __func__,
+				policy->cpu);
+		return -ENODEV;
+	}
+
+	if (cur_cluster < MAX_CLUSTERS) {
+		int cpu;
+
+		cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
+
+		for_each_cpu(cpu, policy->cpus)
+			per_cpu(physical_cluster, cpu) = cur_cluster;
+	} else {
+		/* Assumption: during init, we are always running on A15 */
+		per_cpu(physical_cluster, policy->cpu) = A15_CLUSTER;
+	}
+
+	ret = get_cluster_clk_and_freq_table(cpu_dev, policy->cpus);
+	if (ret)
+		return ret;
+
+	policy->freq_table = freq_table[cur_cluster];
+	policy->cpuinfo.transition_latency =
+				arm_bL_ops->get_transition_latency(cpu_dev);
+
+	dev_pm_opp_of_register_em(policy->cpus);
+
+	if (is_bL_switching_enabled())
+		per_cpu(cpu_last_req_freq, policy->cpu) = clk_get_cpu_rate(policy->cpu);
+
+	dev_info(cpu_dev, "%s: CPU %d initialized\n", __func__, policy->cpu);
+	return 0;
+}
+
+static int bL_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	struct device *cpu_dev;
+	int cur_cluster = cpu_to_cluster(policy->cpu);
+
+	if (cur_cluster < MAX_CLUSTERS) {
+		cpufreq_cooling_unregister(cdev[cur_cluster]);
+		cdev[cur_cluster] = NULL;
+	}
+
+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev) {
+		pr_err("%s: failed to get cpu%d device\n", __func__,
+				policy->cpu);
+		return -ENODEV;
+	}
+
+	put_cluster_clk_and_freq_table(cpu_dev, policy->related_cpus);
+	dev_dbg(cpu_dev, "%s: Exited, cpu: %d\n", __func__, policy->cpu);
+
+	return 0;
+}
+
+static void bL_cpufreq_ready(struct cpufreq_policy *policy)
+{
+	int cur_cluster = cpu_to_cluster(policy->cpu);
+
+	/* Do not register a cpu_cooling device if we are in IKS mode */
+	if (cur_cluster >= MAX_CLUSTERS)
+		return;
+
+	cdev[cur_cluster] = of_cpufreq_cooling_register(policy);
+}
+
+static struct cpufreq_driver bL_cpufreq_driver = {
+	.name			= "arm-big-little",
+	.flags			= CPUFREQ_STICKY |
+					CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+					CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.verify			= cpufreq_generic_frequency_table_verify,
+	.target_index		= bL_cpufreq_set_target,
+	.get			= bL_cpufreq_get_rate,
+	.init			= bL_cpufreq_init,
+	.exit			= bL_cpufreq_exit,
+	.ready			= bL_cpufreq_ready,
+	.attr			= cpufreq_generic_attr,
+};
+
+#ifdef CONFIG_BL_SWITCHER
+static int bL_cpufreq_switcher_notifier(struct notifier_block *nfb,
+					unsigned long action, void *_arg)
+{
+	pr_debug("%s: action: %ld\n", __func__, action);
+
+	switch (action) {
+	case BL_NOTIFY_PRE_ENABLE:
+	case BL_NOTIFY_PRE_DISABLE:
+		cpufreq_unregister_driver(&bL_cpufreq_driver);
+		break;
+
+	case BL_NOTIFY_POST_ENABLE:
+		set_switching_enabled(true);
+		cpufreq_register_driver(&bL_cpufreq_driver);
+		break;
+
+	case BL_NOTIFY_POST_DISABLE:
+		set_switching_enabled(false);
+		cpufreq_register_driver(&bL_cpufreq_driver);
+		break;
+
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block bL_switcher_notifier = {
+	.notifier_call = bL_cpufreq_switcher_notifier,
+};
+
+static int __bLs_register_notifier(void)
+{
+	return bL_switcher_register_notifier(&bL_switcher_notifier);
+}
+
+static int __bLs_unregister_notifier(void)
+{
+	return bL_switcher_unregister_notifier(&bL_switcher_notifier);
+}
+#else
+static int __bLs_register_notifier(void) { return 0; }
+static int __bLs_unregister_notifier(void) { return 0; }
+#endif
+
+int bL_cpufreq_register(const struct cpufreq_arm_bL_ops *ops)
+{
+	int ret, i;
+
+	if (arm_bL_ops) {
+		pr_debug("%s: Already registered: %s, exiting\n", __func__,
+				arm_bL_ops->name);
+		return -EBUSY;
+	}
+
+	if (!ops || !strlen(ops->name) || !ops->init_opp_table ||
+	    !ops->get_transition_latency) {
+		pr_err("%s: Invalid arm_bL_ops, exiting\n", __func__);
+		return -ENODEV;
+	}
+
+	arm_bL_ops = ops;
+
+	set_switching_enabled(bL_switcher_get_enabled());
+
+	for (i = 0; i < MAX_CLUSTERS; i++)
+		mutex_init(&cluster_lock[i]);
+
+	ret = cpufreq_register_driver(&bL_cpufreq_driver);
+	if (ret) {
+		pr_info("%s: Failed registering platform driver: %s, err: %d\n",
+				__func__, ops->name, ret);
+		arm_bL_ops = NULL;
+	} else {
+		ret = __bLs_register_notifier();
+		if (ret) {
+			cpufreq_unregister_driver(&bL_cpufreq_driver);
+			arm_bL_ops = NULL;
+		} else {
+			pr_info("%s: Registered platform driver: %s\n",
+					__func__, ops->name);
+		}
+	}
+
+	bL_switcher_put_enabled();
+	return ret;
+}
+
+void bL_cpufreq_unregister(const struct cpufreq_arm_bL_ops *ops)
+{
+	if (arm_bL_ops != ops) {
+		pr_err("%s: Registered with: %s, can't unregister, exiting\n",
+				__func__, arm_bL_ops->name);
+		return;
+	}
+
+	bL_switcher_get_enabled();
+	__bLs_unregister_notifier();
+	cpufreq_unregister_driver(&bL_cpufreq_driver);
+	bL_switcher_put_enabled();
+	pr_info("%s: Un-registered platform driver: %s\n", __func__,
+			arm_bL_ops->name);
+	arm_bL_ops = NULL;
+}
 
 static int ve_spc_init_opp_table(const struct cpumask *cpumask)
 {
@@ -68,4 +698,7 @@ static struct platform_driver ve_spc_cpufreq_platdrv = {
 };
 module_platform_driver(ve_spc_cpufreq_platdrv);
 
-MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
+MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
+MODULE_DESCRIPTION("Vexpress SPC ARM big LITTLE cpufreq driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

