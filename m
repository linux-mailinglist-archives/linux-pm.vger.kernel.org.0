Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0DE15CDCB
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 23:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgBMWFb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 17:05:31 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51260 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgBMWFE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 17:05:04 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id b120af7d0df2dbec; Thu, 13 Feb 2020 23:05:02 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 7/9] intel_idle: Clean up kerneldoc comments of multiple functions
Date:   Thu, 13 Feb 2020 23:03:07 +0100
Message-ID: <16490706.IjqtDSzaaB@kreacher>
In-Reply-To: <2960689.qre192dJKD@kreacher>
References: <2960689.qre192dJKD@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Turn the description comments of some functions in the intel_idle
driver into proper kerneldoc ones and clean them up.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 3a93cd1036fb..9575615c8f4a 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1288,11 +1288,11 @@ static inline void intel_idle_init_cstates_acpi(struct cpuidle_driver *drv) { }
 static inline bool intel_idle_off_by_default(u32 mwait_hint) { return false; }
 #endif /* !CONFIG_ACPI_PROCESSOR_CSTATE */
 
-/*
- * ivt_idle_state_table_update(void)
+/**
+ * ivt_idle_state_table_update - Tune the idle states table for Ivy Town.
  *
- * Tune IVT multi-socket targets
- * Assumption: num_sockets == (max_package_num + 1)
+ * Tune IVT multi-socket targets.
+ * Assumption: num_sockets == (max_package_num + 1).
  */
 static void __init ivt_idle_state_table_update(void)
 {
@@ -1338,11 +1338,11 @@ static unsigned long long __init irtl_2_usec(unsigned long long irtl)
 	return div_u64((irtl & 0x3FF) * ns, NSEC_PER_USEC);
 }
 
-/*
- * bxt_idle_state_table_update(void)
+/**
+ * bxt_idle_state_table_update - Fix up the Broxton idle states table.
  *
- * On BXT, we trust the IRTL to show the definitive maximum latency
- * We use the same value for target_residency.
+ * On BXT, trust the IRTL (Interrupt Response Time Limit) MSR to show the
+ * definitive maximum latency and use the same value for target_residency.
  */
 static void __init bxt_idle_state_table_update(void)
 {
@@ -1385,11 +1385,11 @@ static void __init bxt_idle_state_table_update(void)
 	}
 
 }
-/*
- * sklh_idle_state_table_update(void)
+
+/**
+ * sklh_idle_state_table_update - Fix up the Sky Lake idle states table.
  *
- * On SKL-H (model 0x5e) disable C8 and C9 if:
- * C10 is enabled and SGX disabled
+ * On SKL-H (model 0x5e) skip C8 and C9 if C10 is enabled and SGX disabled.
  */
 static void __init sklh_idle_state_table_update(void)
 {
@@ -1500,9 +1500,9 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 	}
 }
 
-/*
- * intel_idle_cpuidle_driver_init()
- * allocate, initialize cpuidle_states
+/**
+ * intel_idle_cpuidle_driver_init - Create the list of available idle states.
+ * @drv: cpuidle driver structure to initialize.
  */
 static void __init intel_idle_cpuidle_driver_init(struct cpuidle_driver *drv)
 {
@@ -1537,10 +1537,12 @@ static void c1e_promotion_disable(void)
 	wrmsrl(MSR_IA32_POWER_CTL, msr_bits);
 }
 
-/*
- * intel_idle_cpu_init()
- * allocate, initialize, register cpuidle_devices
- * @cpu: cpu/core to initialize
+/**
+ * intel_idle_cpu_init - Register the target CPU with the cpuidle core.
+ * @cpu: CPU to initialize.
+ *
+ * Register a cpuidle device object for @cpu and update its MSRs in accordance
+ * with the processor model flags.
  */
 static int intel_idle_cpu_init(unsigned int cpu)
 {
-- 
2.16.4





