Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E823F24DB
	for <lists+linux-pm@lfdr.de>; Fri, 20 Aug 2021 04:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbhHTClE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Aug 2021 22:41:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:28085 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237372AbhHTClE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Aug 2021 22:41:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="213577047"
X-IronPort-AV: E=Sophos;i="5.84,336,1620716400"; 
   d="scan'208";a="213577047"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 19:40:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,336,1620716400"; 
   d="scan'208";a="532781073"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga002.fm.intel.com with ESMTP; 19 Aug 2021 19:40:27 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, lenb@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] cpufreq: intel_pstate: Process HWP Guaranteed change notification
Date:   Thu, 19 Aug 2021 19:40:06 -0700
Message-Id: <20210820024006.2347720-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210820024006.2347720-1-srinivas.pandruvada@linux.intel.com>
References: <20210820024006.2347720-1-srinivas.pandruvada@linux.intel.com>
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

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index bb4549959b11..0fd2375c1f1e 100644
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
@@ -1625,6 +1628,40 @@ static void intel_pstate_sysfs_hide_hwp_dynamic_boost(void)
 
 /************************** sysfs end ************************/
 
+static void intel_pstate_notify_work(struct work_struct *work)
+{
+	mutex_lock(&intel_pstate_driver_lock);
+	cpufreq_update_policy(smp_processor_id());
+	wrmsrl(MSR_HWP_STATUS, 0);
+	mutex_unlock(&intel_pstate_driver_lock);
+}
+
+void notify_hwp_interrupt(void)
+{
+	unsigned int this_cpu = smp_processor_id();
+	struct cpudata *cpudata;
+	u64 value;
+
+	if (!hwp_active || !boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
+		return;
+
+	rdmsrl(MSR_HWP_STATUS, value);
+	if (!(value & 0x01))
+		return;
+
+	cpudata = all_cpu_data[this_cpu];
+	schedule_delayed_work_on(this_cpu, &cpudata->hwp_notify_work, msecs_to_jiffies(10));
+}
+
+static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)
+{
+	/* Enable HWP notification interrupt for guaranteed performance change */
+	if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY)) {
+		INIT_DELAYED_WORK(&cpudata->hwp_notify_work, intel_pstate_notify_work);
+		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x01);
+	}
+}
+
 static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 {
 	/* First disable HWP notification interrupt as we don't process them */
@@ -1634,6 +1671,8 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 	wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
 	if (cpudata->epp_default == -EINVAL)
 		cpudata->epp_default = intel_pstate_get_epp(cpudata, 0);
+
+	intel_pstate_enable_hwp_interrupt(cpudata);
 }
 
 static int atom_get_min_pstate(void)
-- 
2.31.1

