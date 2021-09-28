Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D9541B418
	for <lists+linux-pm@lfdr.de>; Tue, 28 Sep 2021 18:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241881AbhI1QoD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Sep 2021 12:44:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:30852 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241820AbhI1QoC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Sep 2021 12:44:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="224789120"
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="224789120"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 09:42:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="486589673"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga008.jf.intel.com with ESMTP; 28 Sep 2021 09:42:22 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, pablomh@gmail.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Process HWP Guaranteed change notification
Date:   Tue, 28 Sep 2021 09:42:17 -0700
Message-Id: <20210928164217.950960-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It is possible that HWP guaranteed ratio is changed in response to
change in power and thermal limits. For example when Intel Speed Select
performance profile is changed or there is change in TDP, hardware can
send notifications. It is possible that the guaranteed ratio is
increased. This creates an issue when turbo is disabled, as the old
limits set in MSR_HWP_REQUEST are still lower and hardware will clip
to older limits.

This change enables HWP interrupt and process HWP interrupts. When
guaranteed is changed, calls cpufreq_update_policy() so that driver
callbacks are called to update to new HWP limits. This callback
is called from a delayed workqueue of 10ms to avoid frequent updates.

Although the scope of IA32_HWP_INTERRUPT is per logical cpu, on some
plaforms interrupt is generated on all CPUs. This is particularly a
problem during initialization, when the driver didn't allocated
data for other CPUs. So this change uses a cpumask of enabled CPUs and
process interrupts on those CPUs only.

When the cpufreq offline() or suspend()callback is called, HWP interrupt
is disabled on those CPUs and also cancels any pending work item.

Spin lock is used to protect data and processing shared with interrupt
handler. Here READ_ONCE(), WRITE_ONCE() macros are used to designate
shared data, even though spin lock act as an optmization barrier here.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
This patch is a replacement from the patch submitted to 5.15 and later
reverted.

 drivers/cpufreq/intel_pstate.c | 117 +++++++++++++++++++++++++++++++--
 1 file changed, 111 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8c176b7dae41..facc56dd58dd 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -32,6 +32,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/cpufeature.h>
 #include <asm/intel-family.h>
+#include "../drivers/thermal/intel/thermal_interrupt.h"
 
 #define INTEL_PSTATE_SAMPLING_INTERVAL	(10 * NSEC_PER_MSEC)
 
@@ -219,6 +220,7 @@ struct global_params {
  * @sched_flags:	Store scheduler flags for possible cross CPU update
  * @hwp_boost_min:	Last HWP boosted min performance
  * @suspended:		Whether or not the driver has been suspended.
+ * @hwp_notify_work:	workqueue for HWP notifications.
  *
  * This structure stores per CPU instance data for all CPUs.
  */
@@ -257,6 +259,7 @@ struct cpudata {
 	unsigned int sched_flags;
 	u32 hwp_boost_min;
 	bool suspended;
+	struct delayed_work hwp_notify_work;
 };
 
 static struct cpudata **all_cpu_data;
@@ -985,11 +988,15 @@ static void intel_pstate_hwp_set(unsigned int cpu)
 	wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
 }
 
+static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata);
+
 static void intel_pstate_hwp_offline(struct cpudata *cpu)
 {
 	u64 value = READ_ONCE(cpu->hwp_req_cached);
 	int min_perf;
 
+	intel_pstate_disable_hwp_interrupt(cpu);
+
 	if (boot_cpu_has(X86_FEATURE_HWP_EPP)) {
 		/*
 		 * In case the EPP has been set to "performance" by the
@@ -1053,6 +1060,9 @@ static int intel_pstate_suspend(struct cpufreq_policy *policy)
 
 	cpu->suspended = true;
 
+	/* disable HWP interrupt and cancel any pending work */
+	intel_pstate_disable_hwp_interrupt(cpu);
+
 	return 0;
 }
 
@@ -1546,15 +1556,105 @@ static void intel_pstate_sysfs_hide_hwp_dynamic_boost(void)
 
 /************************** sysfs end ************************/
 
+static void intel_pstate_notify_work(struct work_struct *work)
+{
+	struct cpudata *cpudata =
+		container_of(to_delayed_work(work), struct cpudata, hwp_notify_work);
+
+	cpufreq_update_policy(cpudata->cpu);
+	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
+}
+
+static DEFINE_SPINLOCK(hwp_notify_lock);
+static cpumask_t hwp_intr_enable_mask;
+
+void notify_hwp_interrupt(void)
+{
+	unsigned int this_cpu = smp_processor_id();
+	struct cpudata *cpudata;
+	unsigned long flags;
+	u64 value;
+
+	if (!READ_ONCE(hwp_active) || !boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
+		return;
+
+	rdmsrl_safe(MSR_HWP_STATUS, &value);
+	if (!(value & 0x01))
+		return;
+
+	spin_lock_irqsave(&hwp_notify_lock, flags);
+
+	if (!cpumask_test_cpu(this_cpu, &hwp_intr_enable_mask))
+		goto ack_intr;
+
+	/*
+	 * Currently we never free all_cpu_data. And we can't reach here
+	 * without this allocated. But for safety for future changes, added
+	 * check.
+	 */
+	if (unlikely(!READ_ONCE(all_cpu_data)))
+		goto ack_intr;
+
+	/*
+	 * The free is done during cleanup, when cpufreq registry is failed.
+	 * We wouldn't be here if it fails on init or switch status. But for
+	 * future changes, added check.
+	 */
+	cpudata = READ_ONCE(all_cpu_data[this_cpu]);
+	if (unlikely(!cpudata))
+		goto ack_intr;
+
+	schedule_delayed_work(&cpudata->hwp_notify_work, msecs_to_jiffies(10));
+
+	spin_unlock_irqrestore(&hwp_notify_lock, flags);
+
+	return;
+
+ack_intr:
+	wrmsrl_safe(MSR_HWP_STATUS, 0);
+	spin_unlock_irqrestore(&hwp_notify_lock, flags);
+}
+
+static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
+{
+	unsigned long flags;
+
+	/* wrmsrl_on_cpu has to be outside spinlock as this can result in IPC */
+	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
+
+	spin_lock_irqsave(&hwp_notify_lock, flags);
+	if (cpumask_test_and_clear_cpu(cpudata->cpu, &hwp_intr_enable_mask))
+		cancel_delayed_work(&cpudata->hwp_notify_work);
+	spin_unlock_irqrestore(&hwp_notify_lock, flags);
+}
+
+static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)
+{
+	/* Enable HWP notification interrupt for guaranteed performance change */
+	if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY)) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&hwp_notify_lock, flags);
+		INIT_DELAYED_WORK(&cpudata->hwp_notify_work, intel_pstate_notify_work);
+		cpumask_set_cpu(cpudata->cpu, &hwp_intr_enable_mask);
+		spin_unlock_irqrestore(&hwp_notify_lock, flags);
+
+		/* wrmsrl_on_cpu has to be outside spinlock as this can result in IPC */
+		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x01);
+	}
+}
+
 static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 {
-	/* First disable HWP notification interrupt as we don't process them */
+	/* First disable HWP notification interrupt till we activate again */
 	if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
 		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
 
 	wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
 	if (cpudata->epp_default == -EINVAL)
 		cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
+
+	intel_pstate_enable_hwp_interrupt(cpudata);
 }
 
 static int atom_get_min_pstate(void)
@@ -2266,7 +2366,7 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 		if (!cpu)
 			return -ENOMEM;
 
-		all_cpu_data[cpunum] = cpu;
+		WRITE_ONCE(all_cpu_data[cpunum], cpu);
 
 		cpu->cpu = cpunum;
 
@@ -2929,8 +3029,10 @@ static void intel_pstate_driver_cleanup(void)
 			if (intel_pstate_driver == &intel_pstate)
 				intel_pstate_clear_update_util_hook(cpu);
 
+			spin_lock(&hwp_notify_lock);
 			kfree(all_cpu_data[cpu]);
-			all_cpu_data[cpu] = NULL;
+			WRITE_ONCE(all_cpu_data[cpu], NULL);
+			spin_unlock(&hwp_notify_lock);
 		}
 	}
 	cpus_read_unlock();
@@ -3199,6 +3301,7 @@ static bool intel_pstate_hwp_is_enabled(void)
 
 static int __init intel_pstate_init(void)
 {
+	static struct cpudata **_all_cpu_data;
 	const struct x86_cpu_id *id;
 	int rc;
 
@@ -3224,7 +3327,7 @@ static int __init intel_pstate_init(void)
 		 * deal with it.
 		 */
 		if ((!no_hwp && boot_cpu_has(X86_FEATURE_HWP_EPP)) || hwp_forced) {
-			hwp_active++;
+			WRITE_ONCE(hwp_active, 1);
 			hwp_mode_bdw = id->driver_data;
 			intel_pstate.attr = hwp_cpufreq_attrs;
 			intel_cpufreq.attr = hwp_cpufreq_attrs;
@@ -3275,10 +3378,12 @@ static int __init intel_pstate_init(void)
 
 	pr_info("Intel P-state driver initializing\n");
 
-	all_cpu_data = vzalloc(array_size(sizeof(void *), num_possible_cpus()));
-	if (!all_cpu_data)
+	_all_cpu_data = vzalloc(array_size(sizeof(void *), num_possible_cpus()));
+	if (!_all_cpu_data)
 		return -ENOMEM;
 
+	WRITE_ONCE(all_cpu_data, _all_cpu_data);
+
 	intel_pstate_request_control_from_smm();
 
 	intel_pstate_sysfs_expose_params();
-- 
2.31.1

