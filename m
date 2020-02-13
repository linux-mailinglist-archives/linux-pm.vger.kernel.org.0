Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5377915CDC3
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 23:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgBMWFH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 17:05:07 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48604 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgBMWFG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 17:05:06 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id a7ea24a22e38e834; Thu, 13 Feb 2020 23:05:03 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 5/9] intel_idle: Annotate init time data structures
Date:   Thu, 13 Feb 2020 23:01:36 +0100
Message-ID: <6952359.KTbxnIrxPq@kreacher>
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

Add __initdata or __initconst annotations to the static data
structures that are only used during the initialization of the
driver.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c | 78 +++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index b7341e0b910a..5e627c40f6b0 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -192,7 +192,7 @@ static __cpuidle void intel_idle_s2idle(struct cpuidle_device *dev,
  * which is also the index into the MWAIT hint array.
  * Thus C0 is a dummy.
  */
-static struct cpuidle_state nehalem_cstates[] = {
+static struct cpuidle_state nehalem_cstates[] __initdata = {
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
@@ -229,7 +229,7 @@ static struct cpuidle_state nehalem_cstates[] = {
 		.enter = NULL }
 };
 
-static struct cpuidle_state snb_cstates[] = {
+static struct cpuidle_state snb_cstates[] __initdata = {
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
@@ -274,7 +274,7 @@ static struct cpuidle_state snb_cstates[] = {
 		.enter = NULL }
 };
 
-static struct cpuidle_state byt_cstates[] = {
+static struct cpuidle_state byt_cstates[] __initdata = {
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
@@ -319,7 +319,7 @@ static struct cpuidle_state byt_cstates[] = {
 		.enter = NULL }
 };
 
-static struct cpuidle_state cht_cstates[] = {
+static struct cpuidle_state cht_cstates[] __initdata = {
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
@@ -364,7 +364,7 @@ static struct cpuidle_state cht_cstates[] = {
 		.enter = NULL }
 };
 
-static struct cpuidle_state ivb_cstates[] = {
+static struct cpuidle_state ivb_cstates[] __initdata = {
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
@@ -409,7 +409,7 @@ static struct cpuidle_state ivb_cstates[] = {
 		.enter = NULL }
 };
 
-static struct cpuidle_state ivt_cstates[] = {
+static struct cpuidle_state ivt_cstates[] __initdata = {
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
@@ -446,7 +446,7 @@ static struct cpuidle_state ivt_cstates[] = {
 		.enter = NULL }
 };
 
-static struct cpuidle_state ivt_cstates_4s[] = {
+static struct cpuidle_state ivt_cstates_4s[] __initdata = {
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
@@ -483,7 +483,7 @@ static struct cpuidle_state ivt_cstates_4s[] = {
 		.enter = NULL }
 };
 
-static struct cpuidle_state ivt_cstates_8s[] = {
+static struct cpuidle_state ivt_cstates_8s[] __initdata = {
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
@@ -520,7 +520,7 @@ static struct cpuidle_state ivt_cstates_8s[] = {
 		.enter = NULL }
 };
 
-static struct cpuidle_state hsw_cstates[] = {
+static struct cpuidle_state hsw_cstates[] __initdata = {
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
@@ -588,7 +588,7 @@ static struct cpuidle_state hsw_cstates[] = {
 	{
 		.enter = NULL }
 };
-static struct cpuidle_state bdw_cstates[] = {
+static struct cpuidle_state bdw_cstates[] __initdata = {
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
@@ -657,7 +657,7 @@ static struct cpuidle_state bdw_cstates[] = {
 		.enter = NULL }
 };
 
-static struct cpuidle_state skl_cstates[] = {
+static struct cpuidle_state skl_cstates[] __initdata = {
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
@@ -726,7 +726,7 @@ static struct cpuidle_state skl_cstates[] = {
 		.enter = NULL }
 };
 
-static struct cpuidle_state skx_cstates[] = {
+static struct cpuidle_state skx_cstates[] __initdata = {
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
@@ -755,7 +755,7 @@ static struct cpuidle_state skx_cstates[] = {
 		.enter = NULL }
 };
 
-static struct cpuidle_state atom_cstates[] = {
+static struct cpuidle_state atom_cstates[] __initdata = {
 	{
 		.name = "C1E",
 		.desc = "MWAIT 0x00",
@@ -791,7 +791,7 @@ static struct cpuidle_state atom_cstates[] = {
 	{
 		.enter = NULL }
 };
-static struct cpuidle_state tangier_cstates[] = {
+static struct cpuidle_state tangier_cstates[] __initdata = {
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
@@ -835,7 +835,7 @@ static struct cpuidle_state tangier_cstates[] = {
 	{
 		.enter = NULL }
 };
-static struct cpuidle_state avn_cstates[] = {
+static struct cpuidle_state avn_cstates[] __initdata = {
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
@@ -855,7 +855,7 @@ static struct cpuidle_state avn_cstates[] = {
 	{
 		.enter = NULL }
 };
-static struct cpuidle_state knl_cstates[] = {
+static struct cpuidle_state knl_cstates[] __initdata = {
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
@@ -876,7 +876,7 @@ static struct cpuidle_state knl_cstates[] = {
 		.enter = NULL }
 };
 
-static struct cpuidle_state bxt_cstates[] = {
+static struct cpuidle_state bxt_cstates[] __initdata = {
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
@@ -937,7 +937,7 @@ static struct cpuidle_state bxt_cstates[] = {
 		.enter = NULL }
 };
 
-static struct cpuidle_state dnv_cstates[] = {
+static struct cpuidle_state dnv_cstates[] __initdata = {
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
@@ -966,116 +966,116 @@ static struct cpuidle_state dnv_cstates[] = {
 		.enter = NULL }
 };
 
-static const struct idle_cpu idle_cpu_nehalem = {
+static const struct idle_cpu idle_cpu_nehalem __initconst = {
 	.state_table = nehalem_cstates,
 	.auto_demotion_disable_flags = NHM_C1_AUTO_DEMOTE | NHM_C3_AUTO_DEMOTE,
 	.disable_promotion_to_c1e = true,
 };
 
-static const struct idle_cpu idle_cpu_nhx = {
+static const struct idle_cpu idle_cpu_nhx __initconst = {
 	.state_table = nehalem_cstates,
 	.auto_demotion_disable_flags = NHM_C1_AUTO_DEMOTE | NHM_C3_AUTO_DEMOTE,
 	.disable_promotion_to_c1e = true,
 	.use_acpi = true,
 };
 
-static const struct idle_cpu idle_cpu_atom = {
+static const struct idle_cpu idle_cpu_atom __initconst = {
 	.state_table = atom_cstates,
 };
 
-static const struct idle_cpu idle_cpu_tangier = {
+static const struct idle_cpu idle_cpu_tangier __initconst = {
 	.state_table = tangier_cstates,
 };
 
-static const struct idle_cpu idle_cpu_lincroft = {
+static const struct idle_cpu idle_cpu_lincroft __initconst = {
 	.state_table = atom_cstates,
 	.auto_demotion_disable_flags = ATM_LNC_C6_AUTO_DEMOTE,
 };
 
-static const struct idle_cpu idle_cpu_snb = {
+static const struct idle_cpu idle_cpu_snb __initconst = {
 	.state_table = snb_cstates,
 	.disable_promotion_to_c1e = true,
 };
 
-static const struct idle_cpu idle_cpu_snx = {
+static const struct idle_cpu idle_cpu_snx __initconst = {
 	.state_table = snb_cstates,
 	.disable_promotion_to_c1e = true,
 	.use_acpi = true,
 };
 
-static const struct idle_cpu idle_cpu_byt = {
+static const struct idle_cpu idle_cpu_byt __initconst = {
 	.state_table = byt_cstates,
 	.disable_promotion_to_c1e = true,
 	.byt_auto_demotion_disable_flag = true,
 };
 
-static const struct idle_cpu idle_cpu_cht = {
+static const struct idle_cpu idle_cpu_cht __initconst = {
 	.state_table = cht_cstates,
 	.disable_promotion_to_c1e = true,
 	.byt_auto_demotion_disable_flag = true,
 };
 
-static const struct idle_cpu idle_cpu_ivb = {
+static const struct idle_cpu idle_cpu_ivb __initconst = {
 	.state_table = ivb_cstates,
 	.disable_promotion_to_c1e = true,
 };
 
-static const struct idle_cpu idle_cpu_ivt = {
+static const struct idle_cpu idle_cpu_ivt __initconst = {
 	.state_table = ivt_cstates,
 	.disable_promotion_to_c1e = true,
 	.use_acpi = true,
 };
 
-static const struct idle_cpu idle_cpu_hsw = {
+static const struct idle_cpu idle_cpu_hsw __initconst = {
 	.state_table = hsw_cstates,
 	.disable_promotion_to_c1e = true,
 };
 
-static const struct idle_cpu idle_cpu_hsx = {
+static const struct idle_cpu idle_cpu_hsx __initconst = {
 	.state_table = hsw_cstates,
 	.disable_promotion_to_c1e = true,
 	.use_acpi = true,
 };
 
-static const struct idle_cpu idle_cpu_bdw = {
+static const struct idle_cpu idle_cpu_bdw __initconst = {
 	.state_table = bdw_cstates,
 	.disable_promotion_to_c1e = true,
 };
 
-static const struct idle_cpu idle_cpu_bdx = {
+static const struct idle_cpu idle_cpu_bdx __initconst = {
 	.state_table = bdw_cstates,
 	.disable_promotion_to_c1e = true,
 	.use_acpi = true,
 };
 
-static const struct idle_cpu idle_cpu_skl = {
+static const struct idle_cpu idle_cpu_skl __initconst = {
 	.state_table = skl_cstates,
 	.disable_promotion_to_c1e = true,
 };
 
-static const struct idle_cpu idle_cpu_skx = {
+static const struct idle_cpu idle_cpu_skx __initconst = {
 	.state_table = skx_cstates,
 	.disable_promotion_to_c1e = true,
 	.use_acpi = true,
 };
 
-static const struct idle_cpu idle_cpu_avn = {
+static const struct idle_cpu idle_cpu_avn __initconst = {
 	.state_table = avn_cstates,
 	.disable_promotion_to_c1e = true,
 	.use_acpi = true,
 };
 
-static const struct idle_cpu idle_cpu_knl = {
+static const struct idle_cpu idle_cpu_knl __initconst = {
 	.state_table = knl_cstates,
 	.use_acpi = true,
 };
 
-static const struct idle_cpu idle_cpu_bxt = {
+static const struct idle_cpu idle_cpu_bxt __initconst = {
 	.state_table = bxt_cstates,
 	.disable_promotion_to_c1e = true,
 };
 
-static const struct idle_cpu idle_cpu_dnv = {
+static const struct idle_cpu idle_cpu_dnv __initconst = {
 	.state_table = dnv_cstates,
 	.disable_promotion_to_c1e = true,
 	.use_acpi = true,
-- 
2.16.4





