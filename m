Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41313E9EA0
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 16:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfJ3PPK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 11:15:10 -0400
Received: from mail-wr1-f73.google.com ([209.85.221.73]:44959 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfJ3PPJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 11:15:09 -0400
Received: by mail-wr1-f73.google.com with SMTP id z9so1517665wrq.11
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2019 08:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ppJjHZbtqqkK8HVjmpvQfAXS2NvTs7pI2yxR9wnyKLY=;
        b=kY9JNiitwYUlzFGijhIIFs1fLVGLvpn11tZ9NZtF898vEgg5Gr5Irn+I+CUNpoXoxM
         FgYf/NIvZu7CJBvhPVFSUeP468B5ouFrbsdH6iEv4UU/GuLG+BbINeUH8Yp3FWleiXwT
         8aJNT8BBKb/EMy+WfXy/hl0HPAc5Dq6KaGV/HosRgc+ydDjV+GyfvjQgrI1PsD33uv1H
         KuH8a9VnnT+JrWK5G1yu2NBZNSJJgUf2taeI4UZNymenxWE9k/SfS+XZLXSqxWJQMXEq
         wu0/6TrrQurMGtYUGfUuZjDfVuzb3ka2S6L84bwfG5wkTKKgfBZKvzlP12CpXa8wAxvU
         r8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ppJjHZbtqqkK8HVjmpvQfAXS2NvTs7pI2yxR9wnyKLY=;
        b=fmCKdEAXrFXEAeYtE5506Uin3TQHjJuW/r/muX3kB48mRnUhWsU+v2UnntfIITdzVn
         NSRe0Qp0DjqaQDCoIQJVUEHS0p3sJT3hf9lpBcId8marLAPQp4qUNbO65JCnFG6jl7P9
         PcUeHIPzw57XUTaX23aqf8yzWfQTieIOMk9ZmTcd6HK0a6rZEUhoUQ8q+mtsnP/aCD+e
         ZgOi3oLlB7OFDYULUBncCSMfZJur6vhwpLJsyIeI+L5Btkw8GL9CHJ+q7UtoHC0aOYJN
         qZZ3+3FVtSb6pITMuUCfMX13YFJKmDpVp537npOQxOnqVGmFiArErpe7S/31olG9/TvX
         GVRQ==
X-Gm-Message-State: APjAAAX/yypSW8m4bMC3VxVE1xOTJ9BknPocEhve4+klXM8VTHb+pzrM
        Aq3bHuARTXLoVtlhWnEu2oB2D+ejLp0g
X-Google-Smtp-Source: APXvYqx8H5B/CegQCN8In1hr6s3GV1v9OH1YJ7RXwdMlTRDAw6jFVnJ71fushz2a3lwnmQETBJ9bixBMSTmg
X-Received: by 2002:a5d:51c2:: with SMTP id n2mr321072wrv.149.1572448505654;
 Wed, 30 Oct 2019 08:15:05 -0700 (PDT)
Date:   Wed, 30 Oct 2019 15:14:51 +0000
In-Reply-To: <20191030151451.7961-1-qperret@google.com>
Message-Id: <20191030151451.7961-5-qperret@google.com>
Mime-Version: 1.0
References: <20191030151451.7961-1-qperret@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v9 4/4] thermal: cpu_cooling: Migrate to using the EM framework
From:   Quentin Perret <qperret@google.com>
To:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, daniel.lezcano@linaro.org
Cc:     dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
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

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 drivers/thermal/Kconfig       |   1 +
 drivers/thermal/cpu_cooling.c | 248 ++++++++++++----------------------
 2 files changed, 89 insertions(+), 160 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 001a21abcc28..08ac82384b80 100644
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
index cc6b84e41404..52569b27b426 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/cpu_cooling.h>
+#include <linux/energy_model.h>
 
 #include <trace/events/thermal.h>
 
@@ -37,21 +38,6 @@
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
-#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
-	u32 power;
-#endif
-};
-
 /**
  * struct time_in_idle - Idle time stats
  * @time: previous reading of the absolute time that this cpu was idle
@@ -71,7 +57,7 @@ struct time_in_idle {
  *	cooling	devices.
  * @max_level: maximum cooling level. One less than total number of valid
  *	cpufreq frequencies.
- * @freq_table: Freq table in descending order of frequencies
+ * @em: Reference on the Energy Model of the device
  * @cdev: thermal_cooling_device pointer to keep track of the
  *	registered cooling device.
  * @policy: cpufreq policy.
@@ -86,7 +72,7 @@ struct cpufreq_cooling_device {
 	u32 last_load;
 	unsigned int cpufreq_state;
 	unsigned int max_level;
-	struct freq_table *freq_table;	/* In descending order */
+	struct em_perf_domain *em;
 	struct cpufreq_policy *policy;
 	struct list_head node;
 	struct time_in_idle *idle_time;
@@ -108,114 +94,40 @@ static LIST_HEAD(cpufreq_cdev_list);
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
-
-	return level - 1;
-}
-
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
-		pr_warn("No cpu device for cpu %d\n", cpu);
-		return -ENODEV;
 	}
 
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
+	return cpufreq_cdev->max_level - i - 1;
 }
 
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
@@ -356,7 +268,7 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 			       struct thermal_zone_device *tz,
 			       unsigned long state, u32 *power)
 {
-	unsigned int freq, num_cpus;
+	unsigned int freq, num_cpus, idx;
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 
 	/* Request state should be less than max_level */
@@ -365,7 +277,8 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 
 	num_cpus = cpumask_weight(cpufreq_cdev->policy->cpus);
 
-	freq = cpufreq_cdev->freq_table[state].frequency;
+	idx = cpufreq_cdev->max_level - state;
+	freq = cpufreq_cdev->em->table[idx].frequency;
 	*power = cpu_freq_to_power(cpufreq_cdev, freq) * num_cpus;
 
 	return 0;
@@ -409,8 +322,59 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 				      power);
 	return 0;
 }
+
+static inline bool em_is_sane(struct cpufreq_cooling_device *cpufreq_cdev,
+			      struct em_perf_domain *em) {
+	struct cpufreq_policy *policy;
+	unsigned int nr_levels;
+
+	if (!em)
+		return false;
+
+	policy = cpufreq_cdev->policy;
+	if (!cpumask_equal(policy->related_cpus, to_cpumask(em->cpus))) {
+		pr_err("The span of pd %*pbl is misaligned with cpufreq policy %*pbl\n",
+			cpumask_pr_args(to_cpumask(em->cpus)),
+			cpumask_pr_args(policy->related_cpus));
+		return false;
+	}
+
+	nr_levels = cpufreq_cdev->max_level + 1;
+	if (em->nr_cap_states != nr_levels) {
+		pr_err("The number of cap states in pd %*pbl (%u) doesn't match the number of cooling levels (%u)\n",
+			cpumask_pr_args(to_cpumask(em->cpus)),
+			em->nr_cap_states, nr_levels);
+		return false;
+	}
+
+	return true;
+}
 #endif /* CONFIG_THERMAL_GOV_POWER_ALLOCATOR */
 
+static unsigned int get_state_freq(struct cpufreq_cooling_device *cpufreq_cdev,
+				   unsigned long state)
+{
+	struct cpufreq_policy *policy;
+	unsigned long idx;
+
+#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
+	/* Use the Energy Model table if available */
+	if (cpufreq_cdev->em) {
+		idx = cpufreq_cdev->max_level - state;
+		return cpufreq_cdev->em->table[idx].frequency;
+	}
+#endif
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
 /* cpufreq cooling device callback functions are defined below */
 
 /**
@@ -478,7 +442,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	cpufreq_cdev->cpufreq_state = state;
 
 	return freq_qos_update_request(&cpufreq_cdev->qos_req,
-				cpufreq_cdev->freq_table[state].frequency);
+				get_state_freq(cpufreq_cdev, state));
 }
 
 /* Bind cpufreq callbacks to thermal cooling device ops */
@@ -489,26 +453,12 @@ static struct thermal_cooling_device_ops cpufreq_cooling_ops = {
 	.set_cur_state		= cpufreq_set_cur_state,
 };
 
-static unsigned int find_next_max(struct cpufreq_frequency_table *table,
-				  unsigned int prev_max)
-{
-	struct cpufreq_frequency_table *pos;
-	unsigned int max = 0;
-
-	cpufreq_for_each_valid_entry(pos, table) {
-		if (pos->frequency > max && pos->frequency < prev_max)
-			max = pos->frequency;
-	}
-
-	return max;
-}
-
 /**
  * __cpufreq_cooling_register - helper function to create cpufreq cooling device
  * @np: a valid struct device_node to the cooling device device tree node
  * @policy: cpufreq policy
  * Normally this should be same as cpufreq policy->related_cpus.
- * @capacitance: dynamic power coefficient for these cpus
+ * @em: Energy Model of the cpufreq policy
  *
  * This interface function registers the cpufreq cooling device with the name
  * "thermal-cpufreq-%x". This api can support multiple instances of cpufreq
@@ -520,12 +470,13 @@ static unsigned int find_next_max(struct cpufreq_frequency_table *table,
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
 	struct device *dev;
 	int ret;
 	struct thermal_cooling_device_ops *cooling_ops;
@@ -566,54 +517,36 @@ __cpufreq_cooling_register(struct device_node *np,
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
 	cooling_ops = &cpufreq_cooling_ops;
 
 #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
-	if (capacitance) {
-		ret = update_freq_table(cpufreq_cdev, capacitance);
-		if (ret) {
-			cdev = ERR_PTR(ret);
-			goto remove_ida;
-		}
+	if (em_is_sane(cpufreq_cdev, em)) {
+		cpufreq_cdev->em = em;
 		cooling_ops->get_requested_power = cpufreq_get_requested_power;
 		cooling_ops->state2power = cpufreq_state2power;
 		cooling_ops->power2state = cpufreq_power2state;
-	}
+	} else
 #endif
+	if (policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED) {
+		pr_err("%s: unsorted frequency tables are not supported\n",
+		       __func__);
+		cdev = ERR_PTR(-EINVAL);
+		goto remove_ida;
+	}
 
 	ret = freq_qos_add_request(&policy->constraints,
 				   &cpufreq_cdev->qos_req, FREQ_QOS_MAX,
-				   cpufreq_cdev->freq_table[0].frequency);
+				   get_state_freq(cpufreq_cdev, 0));
 	if (ret < 0) {
 		pr_err("%s: Failed to add freq constraint (%d)\n", __func__,
 		       ret);
@@ -636,8 +569,6 @@ __cpufreq_cooling_register(struct device_node *np,
 	freq_qos_remove_request(&cpufreq_cdev->qos_req);
 remove_ida:
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
-free_table:
-	kfree(cpufreq_cdev->freq_table);
 free_idle_time:
 	kfree(cpufreq_cdev->idle_time);
 free_cdev:
@@ -659,7 +590,7 @@ __cpufreq_cooling_register(struct device_node *np,
 struct thermal_cooling_device *
 cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
-	return __cpufreq_cooling_register(NULL, policy, 0);
+	return __cpufreq_cooling_register(NULL, policy, NULL);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_register);
 
@@ -687,7 +618,6 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
 	struct device_node *np = of_get_cpu_node(policy->cpu, NULL);
 	struct thermal_cooling_device *cdev = NULL;
-	u32 capacitance = 0;
 
 	if (!np) {
 		pr_err("cpu_cooling: OF node not available for cpu%d\n",
@@ -696,10 +626,9 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
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
@@ -735,7 +664,6 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 	freq_qos_remove_request(&cpufreq_cdev->qos_req);
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 	kfree(cpufreq_cdev->idle_time);
-	kfree(cpufreq_cdev->freq_table);
 	kfree(cpufreq_cdev);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
-- 
2.24.0.rc0.303.g954a862665-goog

