Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCAD3AFE97
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 10:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhFVICD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 04:02:03 -0400
Received: from foss.arm.com ([217.140.110.172]:44146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230087AbhFVICC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Jun 2021 04:02:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D06BEED1;
        Tue, 22 Jun 2021 00:59:46 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.9.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A2A1D3F718;
        Tue, 22 Jun 2021 00:59:44 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        Chris.Redpath@arm.com, Beata.Michalska@arm.com,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, amit.kachhap@gmail.com
Subject: [RFC PATCH 4/4] thermal: cpufreq_cooling: Improve power estimation based on Active Stats framework
Date:   Tue, 22 Jun 2021 08:59:25 +0100
Message-Id: <20210622075925.16189-5-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210622075925.16189-1-lukasz.luba@arm.com>
References: <20210622075925.16189-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpufreq_cooling has dedicated APIs for thermal governor called
Intelligent Power Allocation (IPA). IPA needs the CPUs power used by the
devices in the past.  Based on this, IPA tries to estimate the power
budget, allocate new budget and split it across cooling devices for the
next period (keeping the system in the thermal envelope).  When the input
power estimated value has big error, the whole mechanism does not work
properly. The current power estimation assumes constant frequency during
the whole IPA period (e.g. 100ms). This can cause big error in the power
estimation, especially when SchedUtil governor is used and frequency is
often adjusted to the current need. This can be visible in periodic
workloads, when the frequency oscillates between two OPPs and IPA samples
the lower frequency.

This patch introduces a new mechanism which solves this frequency
sampling problem. It uses Active Stats framework to track and account
the CPU power used for a given IPA period.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/cpufreq_cooling.c | 120 +++++++++++++++++++++++++++++-
 1 file changed, 119 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index eeb4e4b76c0b..c4a14391db6e 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -10,6 +10,7 @@
  *		Viresh Kumar <viresh.kumar@linaro.org>
  *
  */
+#include <linux/active_stats.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpu_cooling.h>
@@ -61,6 +62,7 @@ struct time_in_idle {
  * @policy: cpufreq policy.
  * @idle_time: idle time stats
  * @qos_req: PM QoS contraint to apply
+ * @ast_mon: Active Stats Monitor array of pointers
  *
  * This structure is required for keeping information of each registered
  * cpufreq_cooling_device.
@@ -75,6 +77,9 @@ struct cpufreq_cooling_device {
 	struct time_in_idle *idle_time;
 #endif
 	struct freq_qos_request qos_req;
+#ifdef CONFIG_ACTIVE_STATS
+	struct active_stats_monitor **ast_mon;
+#endif
 };
 
 #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
@@ -124,6 +129,99 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 	return cpufreq_cdev->em->table[i].frequency;
 }
 
+#ifdef CONFIG_ACTIVE_STATS
+static u32 account_cpu_power(struct active_stats_monitor *ast_mon,
+			     struct em_perf_domain *em)
+{
+	u64 single_power, residency, total_time;
+	u32 power = 0;
+	int i;
+
+	mutex_lock(&ast_mon->lock);
+
+	total_time = ast_mon->local_period;
+
+	for (i = 0; i < ast_mon->states_count; i++) {
+		residency = ast_mon->local->residency[i];
+		single_power = em->table[i].power * residency;
+		single_power = div64_u64(single_power, total_time);
+		power += (u32)single_power;
+	}
+
+	mutex_unlock(&ast_mon->lock);
+
+	return power;
+}
+
+static u32 get_power_est(struct cpufreq_cooling_device *cdev)
+{
+	int num_cpus, ret, i;
+	u32 total_power = 0;
+
+	num_cpus = cpumask_weight(cdev->policy->related_cpus);
+
+	for (i = 0; i < num_cpus; i++) {
+		ret = active_stats_cpu_update_monitor(cdev->ast_mon[i]);
+		if (ret)
+			return 0;
+
+		total_power += account_cpu_power(cdev->ast_mon[i], cdev->em);
+	}
+
+	return total_power;
+}
+
+static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
+				       u32 *power)
+{
+	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+	struct cpufreq_policy *policy = cpufreq_cdev->policy;
+
+	*power = get_power_est(cpufreq_cdev);
+
+	trace_thermal_power_cpu_get_power(policy->related_cpus, 0, 0, 0,
+					  *power);
+
+	return 0;
+}
+
+static void clean_cpu_monitoring(struct cpufreq_cooling_device *cdev)
+{
+	int num_cpus, i;
+
+	num_cpus = cpumask_weight(cdev->policy->related_cpus);
+
+	for (i = 0; i < num_cpus; i++)
+		active_stats_cpu_free_monitor(cdev->ast_mon[i++]);
+
+	kfree(cdev->ast_mon);
+}
+
+static int setup_cpu_monitoring(struct cpufreq_cooling_device *cdev)
+{
+	int cpu, cpus, i = 0;
+
+	cpus = cpumask_weight(cdev->policy->related_cpus);
+
+	cdev->ast_mon = kcalloc(cpus, sizeof(struct active_stats_monitor *),
+				GFP_KERNEL);
+	if (!cdev->ast_mon)
+		return -ENOMEM;
+
+	for_each_cpu(cpu, cdev->policy->related_cpus) {
+		cdev->ast_mon[i] = active_stats_cpu_setup_monitor(cpu);
+		if (IS_ERR_OR_NULL(cdev->ast_mon[i++]))
+			goto cleanup;
+	}
+
+	return 0;
+
+cleanup:
+	clean_cpu_monitoring(cdev);
+	return -EINVAL;
+}
+#else
+
 /**
  * get_load() - get load for a cpu
  * @cpufreq_cdev: struct cpufreq_cooling_device for the cpu
@@ -184,6 +282,15 @@ static u32 get_dynamic_power(struct cpufreq_cooling_device *cpufreq_cdev,
 	return (raw_cpu_power * cpufreq_cdev->last_load) / 100;
 }
 
+static void clean_cpu_monitoring(struct cpufreq_cooling_device *cpufreq_cdev)
+{
+}
+
+static int setup_cpu_monitoring(struct cpufreq_cooling_device *cpufreq_cdev)
+{
+	return 0;
+}
+
 /**
  * cpufreq_get_requested_power() - get the current power
  * @cdev:	&thermal_cooling_device pointer
@@ -252,6 +359,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 
 	return 0;
 }
+#endif
 
 /**
  * cpufreq_state2power() - convert a cpu cdev state to power consumed
@@ -566,6 +674,13 @@ __cpufreq_cooling_register(struct device_node *np,
 		cooling_ops->get_requested_power = cpufreq_get_requested_power;
 		cooling_ops->state2power = cpufreq_state2power;
 		cooling_ops->power2state = cpufreq_power2state;
+
+		ret = setup_cpu_monitoring(cpufreq_cdev);
+		if (ret) {
+			pr_err("%s: failed to alloc active_stats\n", __func__);
+			cdev = ERR_PTR(-EINVAL);
+			goto free_cdev;
+		}
 	} else
 #endif
 	if (policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED) {
@@ -582,7 +697,7 @@ __cpufreq_cooling_register(struct device_node *np,
 		pr_err("%s: Failed to add freq constraint (%d)\n", __func__,
 		       ret);
 		cdev = ERR_PTR(ret);
-		goto free_idle_time;
+		goto remove_active_stats;
 	}
 
 	cdev = ERR_PTR(-ENOMEM);
@@ -601,6 +716,8 @@ __cpufreq_cooling_register(struct device_node *np,
 
 remove_qos_req:
 	freq_qos_remove_request(&cpufreq_cdev->qos_req);
+remove_active_stats:
+	clean_cpu_monitoring(cpufreq_cdev);
 free_idle_time:
 	free_idle_time(cpufreq_cdev);
 free_cdev:
@@ -690,6 +807,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
 	thermal_cooling_device_unregister(cdev);
 	freq_qos_remove_request(&cpufreq_cdev->qos_req);
+	clean_cpu_monitoring(cpufreq_cdev);
 	free_idle_time(cpufreq_cdev);
 	kfree(cpufreq_cdev);
 }
-- 
2.17.1

