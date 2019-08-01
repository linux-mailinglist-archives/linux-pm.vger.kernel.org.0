Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 156DC7DBCC
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 14:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbfHAMrB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 08:47:01 -0400
Received: from foss.arm.com ([217.140.110.172]:35500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731335AbfHAMq6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Aug 2019 08:46:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D16051570;
        Thu,  1 Aug 2019 05:46:57 -0700 (PDT)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B354D3F575;
        Thu,  1 Aug 2019 05:46:55 -0700 (PDT)
From:   Quentin Perret <quentin.perret@arm.com>
To:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, daniel.lezcano@linaro.org
Cc:     dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quentin.perret@arm.com
Subject: [PATCH v6 2/3] thermal: cpu_cooling: Make the power-related code depend on IPA
Date:   Thu,  1 Aug 2019 13:46:42 +0100
Message-Id: <20190801124643.17112-3-quentin.perret@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801124643.17112-1-quentin.perret@arm.com>
References: <20190801124643.17112-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The core CPU cooling infrastructure has power-related functions
that have only one client: IPA. Since there can be no user of those
functions if IPA is not compiled in, make sure to guard them with
checks on CONFIG_THERMAL_GOV_POWER_ALLOCATOR to not waste space
unnecessarily.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/thermal/cpu_cooling.c | 214 +++++++++++++++++-----------------
 1 file changed, 104 insertions(+), 110 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 4c5db59a619b..498f59ab64b2 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -46,7 +46,9 @@
  */
 struct freq_table {
 	u32 frequency;
+#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
 	u32 power;
+#endif
 };
 
 /**
@@ -96,28 +98,6 @@ static DEFINE_IDA(cpufreq_ida);
 static DEFINE_MUTEX(cooling_list_lock);
 static LIST_HEAD(cpufreq_cdev_list);
 
-/* Below code defines functions to be used for cpufreq as cooling device */
-
-/**
- * get_level: Find the level for a particular frequency
- * @cpufreq_cdev: cpufreq_cdev for which the property is required
- * @freq: Frequency
- *
- * Return: level corresponding to the frequency.
- */
-static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
-			       unsigned int freq)
-{
-	struct freq_table *freq_table = cpufreq_cdev->freq_table;
-	unsigned long level;
-
-	for (level = 1; level <= cpufreq_cdev->max_level; level++)
-		if (freq > freq_table[level].frequency)
-			break;
-
-	return level - 1;
-}
-
 /**
  * cpufreq_thermal_notifier - notifier callback for cpufreq policy change.
  * @nb:	struct notifier_block * with callback info.
@@ -171,6 +151,27 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
+/**
+ * get_level: Find the level for a particular frequency
+ * @cpufreq_cdev: cpufreq_cdev for which the property is required
+ * @freq: Frequency
+ *
+ * Return: level corresponding to the frequency.
+ */
+static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
+			       unsigned int freq)
+{
+	struct freq_table *freq_table = cpufreq_cdev->freq_table;
+	unsigned long level;
+
+	for (level = 1; level <= cpufreq_cdev->max_level; level++)
+		if (freq > freq_table[level].frequency)
+			break;
+
+	return level - 1;
+}
+
 /**
  * update_freq_table() - Update the freq table with power numbers
  * @cpufreq_cdev:	the cpufreq cooling device in which to update the table
@@ -319,80 +320,6 @@ static u32 get_dynamic_power(struct cpufreq_cooling_device *cpufreq_cdev,
 	return (raw_cpu_power * cpufreq_cdev->last_load) / 100;
 }
 
-/* cpufreq cooling device callback functions are defined below */
-
-/**
- * cpufreq_get_max_state - callback function to get the max cooling state.
- * @cdev: thermal cooling device pointer.
- * @state: fill this variable with the max cooling state.
- *
- * Callback for the thermal cooling device to return the cpufreq
- * max cooling state.
- *
- * Return: 0 on success, an error code otherwise.
- */
-static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
-				 unsigned long *state)
-{
-	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
-
-	*state = cpufreq_cdev->max_level;
-	return 0;
-}
-
-/**
- * cpufreq_get_cur_state - callback function to get the current cooling state.
- * @cdev: thermal cooling device pointer.
- * @state: fill this variable with the current cooling state.
- *
- * Callback for the thermal cooling device to return the cpufreq
- * current cooling state.
- *
- * Return: 0 on success, an error code otherwise.
- */
-static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
-				 unsigned long *state)
-{
-	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
-
-	*state = cpufreq_cdev->cpufreq_state;
-
-	return 0;
-}
-
-/**
- * cpufreq_set_cur_state - callback function to set the current cooling state.
- * @cdev: thermal cooling device pointer.
- * @state: set this variable to the current cooling state.
- *
- * Callback for the thermal cooling device to change the cpufreq
- * current cooling state.
- *
- * Return: 0 on success, an error code otherwise.
- */
-static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
-				 unsigned long state)
-{
-	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
-	unsigned int clip_freq;
-
-	/* Request state should be less than max_level */
-	if (WARN_ON(state > cpufreq_cdev->max_level))
-		return -EINVAL;
-
-	/* Check if the old cooling action is same as new cooling action */
-	if (cpufreq_cdev->cpufreq_state == state)
-		return 0;
-
-	clip_freq = cpufreq_cdev->freq_table[state].frequency;
-	cpufreq_cdev->cpufreq_state = state;
-	cpufreq_cdev->clipped_freq = clip_freq;
-
-	cpufreq_update_policy(cpufreq_cdev->policy->cpu);
-
-	return 0;
-}
-
 /**
  * cpufreq_get_requested_power() - get the current power
  * @cdev:	&thermal_cooling_device pointer
@@ -536,22 +463,88 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 				      power);
 	return 0;
 }
+#endif /* CONFIG_THERMAL_GOV_POWER_ALLOCATOR */
+
+/* cpufreq cooling device callback functions are defined below */
+
+/**
+ * cpufreq_get_max_state - callback function to get the max cooling state.
+ * @cdev: thermal cooling device pointer.
+ * @state: fill this variable with the max cooling state.
+ *
+ * Callback for the thermal cooling device to return the cpufreq
+ * max cooling state.
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
+				 unsigned long *state)
+{
+	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+
+	*state = cpufreq_cdev->max_level;
+	return 0;
+}
+
+/**
+ * cpufreq_get_cur_state - callback function to get the current cooling state.
+ * @cdev: thermal cooling device pointer.
+ * @state: fill this variable with the current cooling state.
+ *
+ * Callback for the thermal cooling device to return the cpufreq
+ * current cooling state.
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
+				 unsigned long *state)
+{
+	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+
+	*state = cpufreq_cdev->cpufreq_state;
+
+	return 0;
+}
+
+/**
+ * cpufreq_set_cur_state - callback function to set the current cooling state.
+ * @cdev: thermal cooling device pointer.
+ * @state: set this variable to the current cooling state.
+ *
+ * Callback for the thermal cooling device to change the cpufreq
+ * current cooling state.
+ *
+ * Return: 0 on success, an error code otherwise.
+ */
+static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
+				 unsigned long state)
+{
+	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+	unsigned int clip_freq;
+
+	/* Request state should be less than max_level */
+	if (WARN_ON(state > cpufreq_cdev->max_level))
+		return -EINVAL;
+
+	/* Check if the old cooling action is same as new cooling action */
+	if (cpufreq_cdev->cpufreq_state == state)
+		return 0;
+
+	clip_freq = cpufreq_cdev->freq_table[state].frequency;
+	cpufreq_cdev->cpufreq_state = state;
+	cpufreq_cdev->clipped_freq = clip_freq;
+
+	cpufreq_update_policy(cpufreq_cdev->policy->cpu);
+
+	return 0;
+}
 
 /* Bind cpufreq callbacks to thermal cooling device ops */
 
 static struct thermal_cooling_device_ops cpufreq_cooling_ops = {
-	.get_max_state = cpufreq_get_max_state,
-	.get_cur_state = cpufreq_get_cur_state,
-	.set_cur_state = cpufreq_set_cur_state,
-};
-
-static struct thermal_cooling_device_ops cpufreq_power_cooling_ops = {
 	.get_max_state		= cpufreq_get_max_state,
 	.get_cur_state		= cpufreq_get_cur_state,
 	.set_cur_state		= cpufreq_set_cur_state,
-	.get_requested_power	= cpufreq_get_requested_power,
-	.state2power		= cpufreq_state2power,
-	.power2state		= cpufreq_power2state,
 };
 
 /* Notifier for cpufreq policy change */
@@ -659,18 +652,19 @@ __cpufreq_cooling_register(struct device_node *np,
 			pr_debug("%s: freq:%u KHz\n", __func__, freq);
 	}
 
+	cooling_ops = &cpufreq_cooling_ops;
+#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
 	if (capacitance) {
 		ret = update_freq_table(cpufreq_cdev, capacitance);
 		if (ret) {
 			cdev = ERR_PTR(ret);
 			goto remove_ida;
 		}
-
-		cooling_ops = &cpufreq_power_cooling_ops;
-	} else {
-		cooling_ops = &cpufreq_cooling_ops;
+		cooling_ops->get_requested_power = cpufreq_get_requested_power;
+		cooling_ops->state2power = cpufreq_state2power;
+		cooling_ops->power2state = cpufreq_power2state;
 	}
-
+#endif
 	cdev = thermal_of_cooling_device_register(np, dev_name, cpufreq_cdev,
 						  cooling_ops);
 	if (IS_ERR(cdev))
-- 
2.22.0

