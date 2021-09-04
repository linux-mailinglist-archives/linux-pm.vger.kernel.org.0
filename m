Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54714009E2
	for <lists+linux-pm@lfdr.de>; Sat,  4 Sep 2021 07:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhIDFib (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Sep 2021 01:38:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:39116 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229965AbhIDFia (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 4 Sep 2021 01:38:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="219283950"
X-IronPort-AV: E=Sophos;i="5.85,267,1624345200"; 
   d="scan'208";a="219283950"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 22:37:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,267,1624345200"; 
   d="scan'208";a="468193385"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga007.jf.intel.com with ESMTP; 03 Sep 2021 22:37:29 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Fix for HWP interrupt before driver is ready
Date:   Fri,  3 Sep 2021 22:37:03 -0700
Message-Id: <20210904053703.581297-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In Lenovo X1 gen9 laptop, HWP interrupts arrive before driver is ready
to handle on that CPU. Basically didn't even allocated memory for per
cpu data structure and not even started interrupt enable process on that
CPU. So interrupt handler observes a NULL pointer to schedule work.

This interrupt was probably for SMM, but since it is redirected to
OS by OSC call, OS receives it, but not ready to handle. That redirection
of interrupt to OS was also done to solve one SMM crash on Yoga 260 for
HWP interrupt a while back.

To solve this the HWP interrupt handler should ignore such request if the
driver is not ready. This will require some flag to wait till the driver
setup a workqueue to handle on a CPU. We can't simply assume cpudata to
be NULL and avoid processing as it may not be NULL but data structure is
not in consistent state.

So created a cpumask which sets the CPU on which interrupt was setup. If
not setup, simply clear the interrupt status and return. Since the
similar issue can happen during S3 resume, clear the bit during offline.

Since interrupt timing may be before HWP is enabled, use safe MSR read
writes as before the change for HWP interrupt.

Fixes: d0e936adbd22 ("cpufreq: intel_pstate: Process HWP Guaranteed change notification")
Reported-and-tested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index b4ffe6c8a0d0..5ac86bfa1080 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -298,6 +298,8 @@ static bool hwp_boost __read_mostly;
 
 static struct cpufreq_driver *intel_pstate_driver __read_mostly;
 
+static cpumask_t hwp_intr_enable_mask;
+
 #ifdef CONFIG_ACPI
 static bool acpi_ppc;
 #endif
@@ -1067,11 +1069,15 @@ static void intel_pstate_hwp_set(unsigned int cpu)
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
@@ -1645,20 +1651,35 @@ void notify_hwp_interrupt(void)
 	if (!hwp_active || !boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
 		return;
 
-	rdmsrl(MSR_HWP_STATUS, value);
+	rdmsrl_safe(MSR_HWP_STATUS, &value);
 	if (!(value & 0x01))
 		return;
 
+	if (!cpumask_test_cpu(this_cpu, &hwp_intr_enable_mask)) {
+		wrmsrl_safe(MSR_HWP_STATUS, 0);
+		return;
+	}
+
 	cpudata = all_cpu_data[this_cpu];
 	schedule_delayed_work_on(this_cpu, &cpudata->hwp_notify_work, msecs_to_jiffies(10));
 }
 
+static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
+{
+
+	if (cpumask_test_and_clear_cpu(cpudata->cpu, &hwp_intr_enable_mask)) {
+		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
+		cancel_delayed_work_sync(&cpudata->hwp_notify_work);
+	}
+}
+
 static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)
 {
 	/* Enable HWP notification interrupt for guaranteed performance change */
 	if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY)) {
 		INIT_DELAYED_WORK(&cpudata->hwp_notify_work, intel_pstate_notify_work);
 		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x01);
+		cpumask_set_cpu(cpudata->cpu, &hwp_intr_enable_mask);
 	}
 }
 
-- 
2.31.1

