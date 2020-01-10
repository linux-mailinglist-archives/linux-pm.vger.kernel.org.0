Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2E6136B8B
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 11:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgAJK6B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jan 2020 05:58:01 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58753 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgAJK6A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 05:58:00 -0500
Received: from 79.184.255.90.ipv4.supernova.orange.pl (79.184.255.90) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 6634a672c62481b0; Fri, 10 Jan 2020 11:57:57 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/8] intel_idle: Fold intel_idle_probe() into intel_idle_init()
Date:   Fri, 10 Jan 2020 11:44:58 +0100
Message-ID: <1620893.3AGvmZJH3P@kreacher>
In-Reply-To: <14127826.m9lEolTOYu@kreacher>
References: <14127826.m9lEolTOYu@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is no particular reason why intel_idle_probe() needs to be
a separate function and folding it into intel_idle_init() causes
the code to be somewhat easier to follow, so do just that.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c |   97 +++++++++++++++++++---------------------------
 1 file changed, 42 insertions(+), 55 deletions(-)

Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -1297,58 +1297,6 @@ static inline bool intel_idle_off_by_def
 #endif /* !CONFIG_ACPI_PROCESSOR_CSTATE */
 
 /*
- * intel_idle_probe()
- */
-static int __init intel_idle_probe(void)
-{
-	unsigned int eax, ebx, ecx;
-	const struct x86_cpu_id *id;
-
-	if (max_cstate == 0) {
-		pr_debug("disabled\n");
-		return -EPERM;
-	}
-
-	id = x86_match_cpu(intel_idle_ids);
-	if (id) {
-		if (!boot_cpu_has(X86_FEATURE_MWAIT)) {
-			pr_debug("Please enable MWAIT in BIOS SETUP\n");
-			return -ENODEV;
-		}
-	} else {
-		id = x86_match_cpu(intel_mwait_ids);
-		if (!id)
-			return -ENODEV;
-	}
-
-	if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
-		return -ENODEV;
-
-	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &mwait_substates);
-
-	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) ||
-	    !(ecx & CPUID5_ECX_INTERRUPT_BREAK) ||
-	    !mwait_substates)
-			return -ENODEV;
-
-	pr_debug("MWAIT substates: 0x%x\n", mwait_substates);
-
-	icpu = (const struct idle_cpu *)id->driver_data;
-	if (icpu) {
-		cpuidle_state_table = icpu->state_table;
-		if (icpu->use_acpi)
-			intel_idle_acpi_cst_extract();
-	} else if (!intel_idle_acpi_cst_extract()) {
-		return -ENODEV;
-	}
-
-	pr_debug("v" INTEL_IDLE_VERSION " model 0x%X\n",
-		 boot_cpu_data.x86_model);
-
-	return 0;
-}
-
-/*
  * intel_idle_cpuidle_devices_uninit()
  * Unregisters the cpuidle devices.
  */
@@ -1632,15 +1580,54 @@ static int intel_idle_cpu_online(unsigne
 
 static int __init intel_idle_init(void)
 {
+	const struct x86_cpu_id *id;
+	unsigned int eax, ebx, ecx;
 	int retval;
 
 	/* Do not load intel_idle at all for now if idle= is passed */
 	if (boot_option_idle_override != IDLE_NO_OVERRIDE)
 		return -ENODEV;
 
-	retval = intel_idle_probe();
-	if (retval)
-		return retval;
+	if (max_cstate == 0) {
+		pr_debug("disabled\n");
+		return -EPERM;
+	}
+
+	id = x86_match_cpu(intel_idle_ids);
+	if (id) {
+		if (!boot_cpu_has(X86_FEATURE_MWAIT)) {
+			pr_debug("Please enable MWAIT in BIOS SETUP\n");
+			return -ENODEV;
+		}
+	} else {
+		id = x86_match_cpu(intel_mwait_ids);
+		if (!id)
+			return -ENODEV;
+	}
+
+	if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
+		return -ENODEV;
+
+	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &mwait_substates);
+
+	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) ||
+	    !(ecx & CPUID5_ECX_INTERRUPT_BREAK) ||
+	    !mwait_substates)
+			return -ENODEV;
+
+	pr_debug("MWAIT substates: 0x%x\n", mwait_substates);
+
+	icpu = (const struct idle_cpu *)id->driver_data;
+	if (icpu) {
+		cpuidle_state_table = icpu->state_table;
+		if (icpu->use_acpi)
+			intel_idle_acpi_cst_extract();
+	} else if (!intel_idle_acpi_cst_extract()) {
+		return -ENODEV;
+	}
+
+	pr_debug("v" INTEL_IDLE_VERSION " model 0x%X\n",
+		 boot_cpu_data.x86_model);
 
 	intel_idle_cpuidle_devices = alloc_percpu(struct cpuidle_device);
 	if (intel_idle_cpuidle_devices == NULL)



