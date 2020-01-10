Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A45EF136B80
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 11:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbgAJK56 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jan 2020 05:57:58 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52467 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbgAJK54 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 05:57:56 -0500
Received: from 79.184.255.90.ipv4.supernova.orange.pl (79.184.255.90) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 9409162859ea356d; Fri, 10 Jan 2020 11:57:54 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 6/8] intel_idle: Annotate initialization code and data structures
Date:   Fri, 10 Jan 2020 11:51:22 +0100
Message-ID: <9485725.GhrZopcvGO@kreacher>
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

Annotate the functions that are only used at the initialization time
with __init and the data structures used by them with __initdata or
__initconst.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -1148,7 +1148,7 @@ static const struct x86_cpu_id intel_mwa
 	{}
 };
 
-static bool intel_idle_max_cstate_reached(int cstate)
+static bool __init intel_idle_max_cstate_reached(int cstate)
 {
 	if (cstate + 1 > max_cstate) {
 		pr_info("max_cstate %d reached\n", max_cstate);
@@ -1164,7 +1164,7 @@ static bool no_acpi __read_mostly;
 module_param(no_acpi, bool, 0444);
 MODULE_PARM_DESC(no_acpi, "Do not use ACPI _CST for building the idle states list");
 
-static struct acpi_processor_power acpi_state_table;
+static struct acpi_processor_power acpi_state_table __initdata;
 
 /**
  * intel_idle_cst_usable - Check if the _CST information can be used.
@@ -1172,7 +1172,7 @@ static struct acpi_processor_power acpi_
  * Check if all of the C-states listed by _CST in the max_cstate range are
  * ACPI_CSTATE_FFH, which means that they should be entered via MWAIT.
  */
-static bool intel_idle_cst_usable(void)
+static bool __init intel_idle_cst_usable(void)
 {
 	int cstate, limit;
 
@@ -1189,7 +1189,7 @@ static bool intel_idle_cst_usable(void)
 	return true;
 }
 
-static bool intel_idle_acpi_cst_extract(void)
+static bool __init intel_idle_acpi_cst_extract(void)
 {
 	unsigned int cpu;
 
@@ -1224,7 +1224,7 @@ static bool intel_idle_acpi_cst_extract(
 	return false;
 }
 
-static void intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
+static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 {
 	int cstate, limit = min_t(int, CPUIDLE_STATE_MAX, acpi_state_table.count);
 
@@ -1268,7 +1268,7 @@ static void intel_idle_init_cstates_acpi
 	}
 }
 
-static bool intel_idle_off_by_default(u32 mwait_hint)
+static bool __init intel_idle_off_by_default(u32 mwait_hint)
 {
 	int cstate, limit;
 
@@ -1302,7 +1302,7 @@ static inline bool intel_idle_off_by_def
  * Tune IVT multi-socket targets
  * Assumption: num_sockets == (max_package_num + 1)
  */
-static void ivt_idle_state_table_update(void)
+static void __init ivt_idle_state_table_update(void)
 {
 	/* IVT uses a different table for 1-2, 3-4, and > 4 sockets */
 	int cpu, package_num, num_sockets = 1;
@@ -1329,10 +1329,11 @@ static void ivt_idle_state_table_update(
  * Translate IRTL (Interrupt Response Time Limit) MSR to usec
  */
 
-static unsigned int irtl_ns_units[] = {
-	1, 32, 1024, 32768, 1048576, 33554432, 0, 0 };
+static const unsigned int irtl_ns_units[] __initconst = {
+	1, 32, 1024, 32768, 1048576, 33554432, 0, 0
+};
 
-static unsigned long long irtl_2_usec(unsigned long long irtl)
+static unsigned long long __init irtl_2_usec(unsigned long long irtl)
 {
 	unsigned long long ns;
 
@@ -1349,7 +1350,7 @@ static unsigned long long irtl_2_usec(un
  * On BXT, we trust the IRTL to show the definitive maximum latency
  * We use the same value for target_residency.
  */
-static void bxt_idle_state_table_update(void)
+static void __init bxt_idle_state_table_update(void)
 {
 	unsigned long long msr;
 	unsigned int usec;
@@ -1396,7 +1397,7 @@ static void bxt_idle_state_table_update(
  * On SKL-H (model 0x5e) disable C8 and C9 if:
  * C10 is enabled and SGX disabled
  */
-static void sklh_idle_state_table_update(void)
+static void __init sklh_idle_state_table_update(void)
 {
 	unsigned long long msr;
 	unsigned int eax, ebx, ecx, edx;
@@ -1433,7 +1434,7 @@ static void sklh_idle_state_table_update
 	skl_cstates[6].flags |= CPUIDLE_FLAG_UNUSABLE;	/* C9-SKL */
 }
 
-static void intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
+static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 {
 	int cstate;
 



