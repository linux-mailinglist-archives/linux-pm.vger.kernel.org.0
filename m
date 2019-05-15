Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C29E01EA04
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 10:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfEOIXi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 04:23:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38002 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfEOIXi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 May 2019 04:23:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48C40374;
        Wed, 15 May 2019 01:23:37 -0700 (PDT)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7704D3F703;
        Wed, 15 May 2019 01:23:34 -0700 (PDT)
From:   Quentin Perret <quentin.perret@arm.com>
To:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com
Cc:     daniel.lezcano@linaro.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, mka@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quentin.perret@arm.com
Subject: [PATCH v4 3/3] thermal: cpu_cooling: Migrate to using the EM framework
Date:   Wed, 15 May 2019 09:23:18 +0100
Message-Id: <20190515082318.7993-4-quentin.perret@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515082318.7993-1-quentin.perret@arm.com>
References: <20190515082318.7993-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The newly introduced Energy Model framework manages power cost tables in
a generic way. Moreover, it supports several types of models since the
tables can come from DT or firmware (through SCMI) for example. On the
other hand, the cpu_cooling subsystem manages its own power cost tables
using only DT data.

In order to avoid the duplication of data in the kernel, and in order to
enable IPA with EMs coming from more than just DT, remove the private
tables from cpu_cooling.c and migrate it to using the centralized EM
framework. Doing so should have no visible functional impact for
existing users of IPA since:

 - recent extenstions to the the PM_OPP infrastructure enable the
   registration of EMs in PM_EM using the DT property used by IPA;

 - the existing upstream cpufreq drivers marked with the
   'CPUFREQ_IS_COOLING_DEV' flag all use the aforementioned PM_OPP
   infrastructure, which means they all support PM_EM. The only two
   exceptions are qoriq-cpufreq which doesn't in fact use an EM and
   scmi-cpufreq which doesn't use DT for power costs.

For existing users of cpu_cooling, PM_EM tables will contain the exact
same power values that IPA used to compute on its own until now. The
only new dependency for them is to compile in CONFIG_ENERGY_MODEL.

The case where the thermal subsystem is used without an Energy Model
(cpufreq_cooling_ops) is handled by looking directly at CPUFreq's
frequency table which is already a dependency for cpu_cooling.c anyway.
Since the thermal framework expects the cooling states in a particular
order, bail out whenever the CPUFreq table is unsorted, since that is
fairly uncommon in general, and there are currently no users of
cpu_cooling for this use-case.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/thermal/Kconfig       |   1 +
 drivers/thermal/cpu_cooling.c | 238 ++++++++++++----------------------
 2 files changed, 82 insertions(+), 157 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 653aa27a25a4..d695bd33c440 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -144,6 +144,7 @@ config THERMAL_GOV_USER_SPACE
 
 config THERMAL_GOV_POWER_ALLOCATOR
 	bool "Power allocator thermal governor"
+	depends on ENERGY_MODEL
 	help
 	  Enable this to manage platform thermals by dynamically
 	  allocating and limiting power to devices.
diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index f7c1f49ec87f..322ea89dd078 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -31,6 +31,7 @@
 #include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/cpu_cooling.h>
+#include <linux/energy_model.h>
 
 #include <trace/events/thermal.h>
 
@@ -48,19 +49,6 @@
  *	...
  */
 
-/**
- * struct freq_table - frequency table along with power entries
- * @frequency:	frequency in KHz
- * @power:	power in mW
- *
- * This structure is built when the cooling device registers and helps
- * in translating frequency to power and vice versa.
- */
-struct freq_table {
-	u32 frequency;
-	u32 power;
-};
-
 /**
  * struct time_in_idle - Idle time stats
  * @time: previous reading of the absolute time that this cpu was idle
@@ -82,7 +70,7 @@ struct time_in_idle {
  *	frequency.
  * @max_level: maximum cooling level. One less than total number of valid
  *	cpufreq frequencies.
- * @freq_table: Freq table in descending order of frequencies
+ * @em: Reference on the Energy Model of the device
  * @cdev: thermal_cooling_device pointer to keep track of the
  *	registered cooling device.
  * @policy: cpufreq policy.
@@ -98,7 +86,7 @@ struct cpufreq_cooling_device {
 	unsigned int cpufreq_state;
 	unsigned int clipped_freq;
 	unsigned int max_level;
-	struct freq_table *freq_table;	/* In descending order */
+	struct em_perf_domain *em;
 	struct thermal_cooling_device *cdev;
 	struct cpufreq_policy *policy;
 	struct list_head node;
@@ -121,14 +109,14 @@ static LIST_HEAD(cpufreq_cdev_list);
 static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
 			       unsigned int freq)
 {
-	struct freq_table *freq_table = cpufreq_cdev->freq_table;
-	unsigned long level;
+	int i;
 
-	for (level = 1; level <= cpufreq_cdev->max_level; level++)
-		if (freq > freq_table[level].frequency)
+	for (i = cpufreq_cdev->max_level - 1; i >= 0; i--) {
+		if (freq > cpufreq_cdev->em->table[i].frequency)
 			break;
+	}
 
-	return level - 1;
+	return cpufreq_cdev->max_level - i - 1;
 }
 
 /**
@@ -184,105 +172,30 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-/**
- * update_freq_table() - Update the freq table with power numbers
- * @cpufreq_cdev:	the cpufreq cooling device in which to update the table
- * @capacitance: dynamic power coefficient for these cpus
- *
- * Update the freq table with power numbers.  This table will be used in
- * cpu_power_to_freq() and cpu_freq_to_power() to convert between power and
- * frequency efficiently.  Power is stored in mW, frequency in KHz.  The
- * resulting table is in descending order.
- *
- * Return: 0 on success, -EINVAL if there are no OPPs for any CPUs,
- * or -ENOMEM if we run out of memory.
- */
-static int update_freq_table(struct cpufreq_cooling_device *cpufreq_cdev,
-			     u32 capacitance)
-{
-	struct freq_table *freq_table = cpufreq_cdev->freq_table;
-	struct dev_pm_opp *opp;
-	struct device *dev = NULL;
-	int num_opps = 0, cpu = cpufreq_cdev->policy->cpu, i;
-
-	dev = get_cpu_device(cpu);
-	if (unlikely(!dev)) {
-		dev_warn(&cpufreq_cdev->cdev->device,
-			 "No cpu device for cpu %d\n", cpu);
-		return -ENODEV;
-	}
-
-	num_opps = dev_pm_opp_get_opp_count(dev);
-	if (num_opps < 0)
-		return num_opps;
-
-	/*
-	 * The cpufreq table is also built from the OPP table and so the count
-	 * should match.
-	 */
-	if (num_opps != cpufreq_cdev->max_level + 1) {
-		dev_warn(dev, "Number of OPPs not matching with max_levels\n");
-		return -EINVAL;
-	}
-
-	for (i = 0; i <= cpufreq_cdev->max_level; i++) {
-		unsigned long freq = freq_table[i].frequency * 1000;
-		u32 freq_mhz = freq_table[i].frequency / 1000;
-		u64 power;
-		u32 voltage_mv;
-
-		/*
-		 * Find ceil frequency as 'freq' may be slightly lower than OPP
-		 * freq due to truncation while converting to kHz.
-		 */
-		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
-		if (IS_ERR(opp)) {
-			dev_err(dev, "failed to get opp for %lu frequency\n",
-				freq);
-			return -EINVAL;
-		}
-
-		voltage_mv = dev_pm_opp_get_voltage(opp) / 1000;
-		dev_pm_opp_put(opp);
-
-		/*
-		 * Do the multiplication with MHz and millivolt so as
-		 * to not overflow.
-		 */
-		power = (u64)capacitance * freq_mhz * voltage_mv * voltage_mv;
-		do_div(power, 1000000000);
-
-		/* power is stored in mW */
-		freq_table[i].power = power;
-	}
-
-	return 0;
-}
-
 static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_cdev,
 			     u32 freq)
 {
 	int i;
-	struct freq_table *freq_table = cpufreq_cdev->freq_table;
 
-	for (i = 1; i <= cpufreq_cdev->max_level; i++)
-		if (freq > freq_table[i].frequency)
+	for (i = cpufreq_cdev->max_level - 1; i >= 0; i--) {
+		if (freq > cpufreq_cdev->em->table[i].frequency)
 			break;
+	}
 
-	return freq_table[i - 1].power;
+	return cpufreq_cdev->em->table[i + 1].power;
 }
 
 static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 			     u32 power)
 {
 	int i;
-	struct freq_table *freq_table = cpufreq_cdev->freq_table;
 
-	for (i = 1; i <= cpufreq_cdev->max_level; i++)
-		if (power > freq_table[i].power)
+	for (i = cpufreq_cdev->max_level - 1; i >= 0; i--) {
+		if (power > cpufreq_cdev->em->table[i].power)
 			break;
+	}
 
-	return freq_table[i - 1].frequency;
+	return cpufreq_cdev->em->table[i + 1].frequency;
 }
 
 /**
@@ -374,6 +287,28 @@ static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
 	return 0;
 }
 
+static unsigned int get_state_freq(struct cpufreq_cooling_device *cpufreq_cdev,
+			      unsigned long state)
+{
+	struct cpufreq_policy *policy;
+	unsigned long idx;
+
+	/* Use the Energy Model table if available */
+	if (cpufreq_cdev->em) {
+		idx = cpufreq_cdev->max_level - state;
+		return cpufreq_cdev->em->table[idx].frequency;
+	}
+
+	/* Otherwise, fallback on the CPUFreq table */
+	policy = cpufreq_cdev->policy;
+	if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
+		idx = cpufreq_cdev->max_level - state;
+	else
+		idx = state;
+
+	return policy->freq_table[idx].frequency;
+}
+
 /**
  * cpufreq_set_cur_state - callback function to set the current cooling state.
  * @cdev: thermal cooling device pointer.
@@ -398,7 +333,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	if (cpufreq_cdev->cpufreq_state == state)
 		return 0;
 
-	clip_freq = cpufreq_cdev->freq_table[state].frequency;
+	clip_freq = get_state_freq(cpufreq_cdev, state);
 	cpufreq_cdev->cpufreq_state = state;
 	cpufreq_cdev->clipped_freq = clip_freq;
 
@@ -497,7 +432,7 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 			       struct thermal_zone_device *tz,
 			       unsigned long state, u32 *power)
 {
-	unsigned int freq, num_cpus;
+	unsigned int freq, num_cpus, idx;
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 
 	/* Request state should be less than max_level */
@@ -506,7 +441,8 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 
 	num_cpus = cpumask_weight(cpufreq_cdev->policy->cpus);
 
-	freq = cpufreq_cdev->freq_table[state].frequency;
+	idx = cpufreq_cdev->max_level - state;
+	freq = cpufreq_cdev->em->table[idx].frequency;
 	*power = cpu_freq_to_power(cpufreq_cdev, freq) * num_cpus;
 
 	return 0;
@@ -559,7 +495,6 @@ static struct thermal_cooling_device_ops cpufreq_cooling_ops = {
 	.get_cur_state = cpufreq_get_cur_state,
 	.set_cur_state = cpufreq_set_cur_state,
 };
-
 static struct thermal_cooling_device_ops cpufreq_power_cooling_ops = {
 	.get_max_state		= cpufreq_get_max_state,
 	.get_cur_state		= cpufreq_get_cur_state,
@@ -574,18 +509,31 @@ static struct notifier_block thermal_cpufreq_notifier_block = {
 	.notifier_call = cpufreq_thermal_notifier,
 };
 
-static unsigned int find_next_max(struct cpufreq_frequency_table *table,
-				  unsigned int prev_max)
-{
-	struct cpufreq_frequency_table *pos;
-	unsigned int max = 0;
+static inline bool em_is_sane(struct cpufreq_cooling_device *cpufreq_cdev,
+			      struct em_perf_domain *em) {
+	struct cpufreq_policy *policy;
+	unsigned int nr_levels;
 
-	cpufreq_for_each_valid_entry(pos, table) {
-		if (pos->frequency > max && pos->frequency < prev_max)
-			max = pos->frequency;
+	if (!em)
+		return false;
+
+	policy = cpufreq_cdev->policy;
+	if (!cpumask_equal(policy->related_cpus, to_cpumask(em->cpus))) {
+		pr_err("The span of pd %*pbl is misaligned with cpufreq policy %*pbl\n",
+			cpumask_pr_args(to_cpumask(em->cpus)),
+			cpumask_pr_args(policy->related_cpus));
+		return false;
 	}
 
-	return max;
+	nr_levels = cpufreq_cdev->max_level + 1;
+	if (em->nr_cap_states != nr_levels) {
+		pr_err("The number of cap states in pd %*pbl (%u) doesn't match the number of cooling levels (%u)\n",
+			cpumask_pr_args(to_cpumask(em->cpus)),
+			em->nr_cap_states, nr_levels);
+		return false;
+	}
+
+	return true;
 }
 
 /**
@@ -593,7 +541,7 @@ static unsigned int find_next_max(struct cpufreq_frequency_table *table,
  * @np: a valid struct device_node to the cooling device device tree node
  * @policy: cpufreq policy
  * Normally this should be same as cpufreq policy->related_cpus.
- * @capacitance: dynamic power coefficient for these cpus
+ * @em: Energy Model of the cpufreq policy
  *
  * This interface function registers the cpufreq cooling device with the name
  * "thermal-cpufreq-%x". This api can support multiple instances of cpufreq
@@ -605,12 +553,13 @@ static unsigned int find_next_max(struct cpufreq_frequency_table *table,
  */
 static struct thermal_cooling_device *
 __cpufreq_cooling_register(struct device_node *np,
-			struct cpufreq_policy *policy, u32 capacitance)
+			struct cpufreq_policy *policy,
+			struct em_perf_domain *em)
 {
 	struct thermal_cooling_device *cdev;
 	struct cpufreq_cooling_device *cpufreq_cdev;
 	char dev_name[THERMAL_NAME_LENGTH];
-	unsigned int freq, i, num_cpus;
+	unsigned int i, num_cpus;
 	int ret;
 	struct thermal_cooling_device_ops *cooling_ops;
 	bool first;
@@ -644,46 +593,26 @@ __cpufreq_cooling_register(struct device_node *np,
 	/* max_level is an index, not a counter */
 	cpufreq_cdev->max_level = i - 1;
 
-	cpufreq_cdev->freq_table = kmalloc_array(i,
-					sizeof(*cpufreq_cdev->freq_table),
-					GFP_KERNEL);
-	if (!cpufreq_cdev->freq_table) {
-		cdev = ERR_PTR(-ENOMEM);
-		goto free_idle_time;
-	}
-
 	ret = ida_simple_get(&cpufreq_ida, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
 		cdev = ERR_PTR(ret);
-		goto free_table;
+		goto free_idle_time;
 	}
 	cpufreq_cdev->id = ret;
 
 	snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
 		 cpufreq_cdev->id);
 
-	/* Fill freq-table in descending order of frequencies */
-	for (i = 0, freq = -1; i <= cpufreq_cdev->max_level; i++) {
-		freq = find_next_max(policy->freq_table, freq);
-		cpufreq_cdev->freq_table[i].frequency = freq;
-
-		/* Warn for duplicate entries */
-		if (!freq)
-			pr_warn("%s: table has duplicate entries\n", __func__);
-		else
-			pr_debug("%s: freq:%u KHz\n", __func__, freq);
-	}
-
-	if (capacitance) {
-		ret = update_freq_table(cpufreq_cdev, capacitance);
-		if (ret) {
-			cdev = ERR_PTR(ret);
-			goto remove_ida;
-		}
-
+	if (em_is_sane(cpufreq_cdev, em)) {
+		cpufreq_cdev->em = em;
 		cooling_ops = &cpufreq_power_cooling_ops;
-	} else {
+	} else if (policy->freq_table_sorted != CPUFREQ_TABLE_UNSORTED) {
 		cooling_ops = &cpufreq_cooling_ops;
+	} else {
+		pr_err("%s: unsorted frequency tables are not supported\n",
+				__func__);
+		cdev = ERR_PTR(-EINVAL);
+		goto remove_ida;
 	}
 
 	cdev = thermal_of_cooling_device_register(np, dev_name, cpufreq_cdev,
@@ -691,7 +620,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	if (IS_ERR(cdev))
 		goto remove_ida;
 
-	cpufreq_cdev->clipped_freq = cpufreq_cdev->freq_table[0].frequency;
+	cpufreq_cdev->clipped_freq = get_state_freq(cpufreq_cdev, 0);
 	cpufreq_cdev->cdev = cdev;
 
 	mutex_lock(&cooling_list_lock);
@@ -708,8 +637,6 @@ __cpufreq_cooling_register(struct device_node *np,
 
 remove_ida:
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
-free_table:
-	kfree(cpufreq_cdev->freq_table);
 free_idle_time:
 	kfree(cpufreq_cdev->idle_time);
 free_cdev:
@@ -731,7 +658,7 @@ __cpufreq_cooling_register(struct device_node *np,
 struct thermal_cooling_device *
 cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
-	return __cpufreq_cooling_register(NULL, policy, 0);
+	return __cpufreq_cooling_register(NULL, policy, NULL);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_register);
 
@@ -759,7 +686,6 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
 	struct device_node *np = of_get_cpu_node(policy->cpu, NULL);
 	struct thermal_cooling_device *cdev = NULL;
-	u32 capacitance = 0;
 
 	if (!np) {
 		pr_err("cpu_cooling: OF node not available for cpu%d\n",
@@ -768,10 +694,9 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 	}
 
 	if (of_find_property(np, "#cooling-cells", NULL)) {
-		of_property_read_u32(np, "dynamic-power-coefficient",
-				     &capacitance);
+		struct em_perf_domain *em = em_cpu_get(policy->cpu);
 
-		cdev = __cpufreq_cooling_register(np, policy, capacitance);
+		cdev = __cpufreq_cooling_register(np, policy, em);
 		if (IS_ERR(cdev)) {
 			pr_err("cpu_cooling: cpu%d failed to register as cooling device: %ld\n",
 			       policy->cpu, PTR_ERR(cdev));
@@ -813,7 +738,6 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 	thermal_cooling_device_unregister(cpufreq_cdev->cdev);
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 	kfree(cpufreq_cdev->idle_time);
-	kfree(cpufreq_cdev->freq_table);
 	kfree(cpufreq_cdev);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
-- 
2.21.0

