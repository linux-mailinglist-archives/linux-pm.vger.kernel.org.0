Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F272C11E093
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2019 10:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfLMJ1d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Dec 2019 04:27:33 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43689 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLMJ1d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Dec 2019 04:27:33 -0500
Received: from 79.184.255.82.ipv4.supernova.orange.pl (79.184.255.82) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 8de01d217efb030e; Fri, 13 Dec 2019 10:27:28 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 10/10] intel_idle: Use ACPI _CST on server systems
Date:   Fri, 13 Dec 2019 10:27:07 +0100
Message-ID: <3728343.TGOlGdFZx8@kreacher>
In-Reply-To: <3950312.2WmFeOdZGY@kreacher>
References: <3950312.2WmFeOdZGY@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In many cases, especially on server systems, it is desirable to avoid
enabling C-states that have been disabled in the platform firmware
(BIOS) setup, except for C1E.

As a rule, the C-states disabled this way are not listed by ACPI
_CST, so if that is used by intel_idle along with the specific
table of C-states that it has for the given processor, the C-states
disabled through the platform firmware will not be enabled by default
by intel_idle.

Accordingly, set the use_acpi flag (introduced previously) in all
server processor profiles defined in intel_idle (so as to make it use
ACPI _CST to decide which C-states to enable by default) and set
the CPUIDLE_FLAG_ALWAYS_ENABLE flag (also introduced previously)
for C1E in all C-states tables in intel_idle that contain C1 too
(so that C1E is enabled regardless of whether or not it is listed
by ACPI _CST).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New patch, not present in the RFC.

---
 drivers/idle/intel_idle.c | 70 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 20 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 26fe383bb921..1467490adfc3 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -131,7 +131,7 @@ static struct cpuidle_state nehalem_cstates[] = {
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
-		.flags = MWAIT2flg(0x01),
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
@@ -168,7 +168,7 @@ static struct cpuidle_state snb_cstates[] = {
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
-		.flags = MWAIT2flg(0x01),
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
@@ -303,7 +303,7 @@ static struct cpuidle_state ivb_cstates[] = {
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
-		.flags = MWAIT2flg(0x01),
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
@@ -348,7 +348,7 @@ static struct cpuidle_state ivt_cstates[] = {
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
-		.flags = MWAIT2flg(0x01),
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 80,
 		.enter = &intel_idle,
@@ -385,7 +385,7 @@ static struct cpuidle_state ivt_cstates_4s[] = {
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
-		.flags = MWAIT2flg(0x01),
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 250,
 		.enter = &intel_idle,
@@ -422,7 +422,7 @@ static struct cpuidle_state ivt_cstates_8s[] = {
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
-		.flags = MWAIT2flg(0x01),
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 500,
 		.enter = &intel_idle,
@@ -459,7 +459,7 @@ static struct cpuidle_state hsw_cstates[] = {
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
-		.flags = MWAIT2flg(0x01),
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
@@ -527,7 +527,7 @@ static struct cpuidle_state bdw_cstates[] = {
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
-		.flags = MWAIT2flg(0x01),
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
@@ -596,7 +596,7 @@ static struct cpuidle_state skl_cstates[] = {
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
-		.flags = MWAIT2flg(0x01),
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
@@ -665,7 +665,7 @@ static struct cpuidle_state skx_cstates[] = {
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
-		.flags = MWAIT2flg(0x01),
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
@@ -815,7 +815,7 @@ static struct cpuidle_state bxt_cstates[] = {
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
-		.flags = MWAIT2flg(0x01),
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
@@ -876,7 +876,7 @@ static struct cpuidle_state dnv_cstates[] = {
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
-		.flags = MWAIT2flg(0x01),
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
 		.exit_latency = 10,
 		.target_residency = 20,
 		.enter = &intel_idle,
@@ -998,6 +998,13 @@ static const struct idle_cpu idle_cpu_nehalem = {
 	.disable_promotion_to_c1e = true,
 };
 
+static const struct idle_cpu idle_cpu_nhx = {
+	.state_table = nehalem_cstates,
+	.auto_demotion_disable_flags = NHM_C1_AUTO_DEMOTE | NHM_C3_AUTO_DEMOTE,
+	.disable_promotion_to_c1e = true,
+	.use_acpi = true,
+};
+
 static const struct idle_cpu idle_cpu_atom = {
 	.state_table = atom_cstates,
 };
@@ -1016,6 +1023,12 @@ static const struct idle_cpu idle_cpu_snb = {
 	.disable_promotion_to_c1e = true,
 };
 
+static const struct idle_cpu idle_cpu_snx = {
+	.state_table = snb_cstates,
+	.disable_promotion_to_c1e = true,
+	.use_acpi = true,
+};
+
 static const struct idle_cpu idle_cpu_byt = {
 	.state_table = byt_cstates,
 	.disable_promotion_to_c1e = true,
@@ -1036,6 +1049,7 @@ static const struct idle_cpu idle_cpu_ivb = {
 static const struct idle_cpu idle_cpu_ivt = {
 	.state_table = ivt_cstates,
 	.disable_promotion_to_c1e = true,
+	.use_acpi = true,
 };
 
 static const struct idle_cpu idle_cpu_hsw = {
@@ -1043,11 +1057,23 @@ static const struct idle_cpu idle_cpu_hsw = {
 	.disable_promotion_to_c1e = true,
 };
 
+static const struct idle_cpu idle_cpu_hsx = {
+	.state_table = hsw_cstates,
+	.disable_promotion_to_c1e = true,
+	.use_acpi = true,
+};
+
 static const struct idle_cpu idle_cpu_bdw = {
 	.state_table = bdw_cstates,
 	.disable_promotion_to_c1e = true,
 };
 
+static const struct idle_cpu idle_cpu_bdx = {
+	.state_table = bdw_cstates,
+	.disable_promotion_to_c1e = true,
+	.use_acpi = true,
+};
+
 static const struct idle_cpu idle_cpu_skl = {
 	.state_table = skl_cstates,
 	.disable_promotion_to_c1e = true,
@@ -1056,15 +1082,18 @@ static const struct idle_cpu idle_cpu_skl = {
 static const struct idle_cpu idle_cpu_skx = {
 	.state_table = skx_cstates,
 	.disable_promotion_to_c1e = true,
+	.use_acpi = true,
 };
 
 static const struct idle_cpu idle_cpu_avn = {
 	.state_table = avn_cstates,
 	.disable_promotion_to_c1e = true,
+	.use_acpi = true,
 };
 
 static const struct idle_cpu idle_cpu_knl = {
 	.state_table = knl_cstates,
+	.use_acpi = true,
 };
 
 static const struct idle_cpu idle_cpu_bxt = {
@@ -1075,20 +1104,21 @@ static const struct idle_cpu idle_cpu_bxt = {
 static const struct idle_cpu idle_cpu_dnv = {
 	.state_table = dnv_cstates,
 	.disable_promotion_to_c1e = true,
+	.use_acpi = true,
 };
 
 static const struct x86_cpu_id intel_idle_ids[] __initconst = {
-	INTEL_CPU_FAM6(NEHALEM_EP,		idle_cpu_nehalem),
+	INTEL_CPU_FAM6(NEHALEM_EP,		idle_cpu_nhx),
 	INTEL_CPU_FAM6(NEHALEM,			idle_cpu_nehalem),
 	INTEL_CPU_FAM6(NEHALEM_G,		idle_cpu_nehalem),
 	INTEL_CPU_FAM6(WESTMERE,		idle_cpu_nehalem),
-	INTEL_CPU_FAM6(WESTMERE_EP,		idle_cpu_nehalem),
-	INTEL_CPU_FAM6(NEHALEM_EX,		idle_cpu_nehalem),
+	INTEL_CPU_FAM6(WESTMERE_EP,		idle_cpu_nhx),
+	INTEL_CPU_FAM6(NEHALEM_EX,		idle_cpu_nhx),
 	INTEL_CPU_FAM6(ATOM_BONNELL,		idle_cpu_atom),
 	INTEL_CPU_FAM6(ATOM_BONNELL_MID,	idle_cpu_lincroft),
-	INTEL_CPU_FAM6(WESTMERE_EX,		idle_cpu_nehalem),
+	INTEL_CPU_FAM6(WESTMERE_EX,		idle_cpu_nhx),
 	INTEL_CPU_FAM6(SANDYBRIDGE,		idle_cpu_snb),
-	INTEL_CPU_FAM6(SANDYBRIDGE_X,		idle_cpu_snb),
+	INTEL_CPU_FAM6(SANDYBRIDGE_X,		idle_cpu_snx),
 	INTEL_CPU_FAM6(ATOM_SALTWELL,		idle_cpu_atom),
 	INTEL_CPU_FAM6(ATOM_SILVERMONT,		idle_cpu_byt),
 	INTEL_CPU_FAM6(ATOM_SILVERMONT_MID,	idle_cpu_tangier),
@@ -1096,14 +1126,14 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	INTEL_CPU_FAM6(IVYBRIDGE,		idle_cpu_ivb),
 	INTEL_CPU_FAM6(IVYBRIDGE_X,		idle_cpu_ivt),
 	INTEL_CPU_FAM6(HASWELL,			idle_cpu_hsw),
-	INTEL_CPU_FAM6(HASWELL_X,		idle_cpu_hsw),
+	INTEL_CPU_FAM6(HASWELL_X,		idle_cpu_hsx),
 	INTEL_CPU_FAM6(HASWELL_L,		idle_cpu_hsw),
 	INTEL_CPU_FAM6(HASWELL_G,		idle_cpu_hsw),
 	INTEL_CPU_FAM6(ATOM_SILVERMONT_D,	idle_cpu_avn),
 	INTEL_CPU_FAM6(BROADWELL,		idle_cpu_bdw),
 	INTEL_CPU_FAM6(BROADWELL_G,		idle_cpu_bdw),
-	INTEL_CPU_FAM6(BROADWELL_X,		idle_cpu_bdw),
-	INTEL_CPU_FAM6(BROADWELL_D,		idle_cpu_bdw),
+	INTEL_CPU_FAM6(BROADWELL_X,		idle_cpu_bdx),
+	INTEL_CPU_FAM6(BROADWELL_D,		idle_cpu_bdx),
 	INTEL_CPU_FAM6(SKYLAKE_L,		idle_cpu_skl),
 	INTEL_CPU_FAM6(SKYLAKE,			idle_cpu_skl),
 	INTEL_CPU_FAM6(KABYLAKE_L,		idle_cpu_skl),
-- 
2.16.4





