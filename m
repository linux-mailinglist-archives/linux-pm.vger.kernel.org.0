Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36D38136B87
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 11:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgAJK56 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jan 2020 05:57:58 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:59944 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgAJK54 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 05:57:56 -0500
Received: from 79.184.255.90.ipv4.supernova.orange.pl (79.184.255.90) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id f8a495c79c98f501; Fri, 10 Jan 2020 11:57:53 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 7/8] intel_idle: Move 3 functions closer to their callers
Date:   Fri, 10 Jan 2020 11:52:32 +0100
Message-ID: <25912277.QUMiHIpAT5@kreacher>
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

Move intel_idle_verify_cstate(), auto_demotion_disable() and
c1e_promotion_disable() closer to their callers.

While at it, annotate intel_idle_verify_cstate() with __init,
as it is only used during the initialization of the driver.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c |   67 +++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 33 deletions(-)

Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -951,39 +951,6 @@ static void intel_idle_s2idle(struct cpu
 	mwait_idle_with_hints(eax, ecx);
 }
 
-static bool intel_idle_verify_cstate(unsigned int mwait_hint)
-{
-	unsigned int mwait_cstate = MWAIT_HINT2CSTATE(mwait_hint) + 1;
-	unsigned int num_substates = (mwait_substates >> mwait_cstate * 4) &
-					MWAIT_SUBSTATE_MASK;
-
-	/* Ignore the C-state if there are NO sub-states in CPUID for it. */
-	if (num_substates == 0)
-		return false;
-
-	if (mwait_cstate > 2 && !boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
-		mark_tsc_unstable("TSC halts in idle states deeper than C2");
-
-	return true;
-}
-
-static void auto_demotion_disable(void)
-{
-	unsigned long long msr_bits;
-
-	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
-	msr_bits &= ~(icpu->auto_demotion_disable_flags);
-	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
-}
-static void c1e_promotion_disable(void)
-{
-	unsigned long long msr_bits;
-
-	rdmsrl(MSR_IA32_POWER_CTL, msr_bits);
-	msr_bits &= ~0x2;
-	wrmsrl(MSR_IA32_POWER_CTL, msr_bits);
-}
-
 static const struct idle_cpu idle_cpu_nehalem = {
 	.state_table = nehalem_cstates,
 	.auto_demotion_disable_flags = NHM_C1_AUTO_DEMOTE | NHM_C3_AUTO_DEMOTE,
@@ -1434,6 +1401,22 @@ static void __init sklh_idle_state_table
 	skl_cstates[6].flags |= CPUIDLE_FLAG_UNUSABLE;	/* C9-SKL */
 }
 
+static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
+{
+	unsigned int mwait_cstate = MWAIT_HINT2CSTATE(mwait_hint) + 1;
+	unsigned int num_substates = (mwait_substates >> mwait_cstate * 4) &
+					MWAIT_SUBSTATE_MASK;
+
+	/* Ignore the C-state if there are NO sub-states in CPUID for it. */
+	if (num_substates == 0)
+		return false;
+
+	if (mwait_cstate > 2 && !boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
+		mark_tsc_unstable("TSC halts in idle states deeper than C2");
+
+	return true;
+}
+
 static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 {
 	int cstate;
@@ -1503,6 +1486,24 @@ static void __init intel_idle_cpuidle_dr
 		intel_idle_init_cstates_acpi(drv);
 }
 
+static void auto_demotion_disable(void)
+{
+	unsigned long long msr_bits;
+
+	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
+	msr_bits &= ~(icpu->auto_demotion_disable_flags);
+	wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
+}
+
+static void c1e_promotion_disable(void)
+{
+	unsigned long long msr_bits;
+
+	rdmsrl(MSR_IA32_POWER_CTL, msr_bits);
+	msr_bits &= ~0x2;
+	wrmsrl(MSR_IA32_POWER_CTL, msr_bits);
+}
+
 /*
  * intel_idle_cpu_init()
  * allocate, initialize, register cpuidle_devices



