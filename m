Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E9E2E30AE
	for <lists+linux-pm@lfdr.de>; Sun, 27 Dec 2020 11:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgL0KL7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Dec 2020 05:11:59 -0500
Received: from mga06.intel.com ([134.134.136.31]:1558 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgL0KL7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 27 Dec 2020 05:11:59 -0500
IronPort-SDR: ijlHiFiIHP8L8ttMi6kyq59H939LviHu5R78lE10MP5nBXvaSZ1la8AYaVYxQEpPhaBEwT2HLK
 hcFEQWapV58Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9846"; a="237854270"
X-IronPort-AV: E=Sophos;i="5.78,452,1599548400"; 
   d="scan'208";a="237854270"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2020 02:11:18 -0800
IronPort-SDR: DatykGpWndZiCNUZwvmGEj/EOSj6/0HQsA8R7aho3wHKfDFS6YTEEn3IJsv/pNzSTG0dPPf63Y
 lVjoXi+VAt4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,452,1599548400"; 
   d="scan'208";a="346589046"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by fmsmga008.fm.intel.com with ESMTP; 27 Dec 2020 02:11:17 -0800
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH v2] intel_idle: add SnowRidge C-state table
Date:   Sun, 27 Dec 2020 12:11:16 +0200
Message-Id: <20201227101116.1888740-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Add C-state table for the SnowRidge SoC which is found on Intel Jacobsville
platforms.

The following has been changed.
1. C1E latency changed from 10us to 15us. It was measured using the
   opensource "wult" tool (the "nic" method, 15us is the 99.99th percentile).
2. C1E power break even changed from 20us to 25us, which may result in less C1E
   residency in some workloads.
3. C6 latency changed from 50us to 130us. Measured the same way as C1E.

The C6 C-state is supported only by some SnowRidge revisions, so add a C-state
table commentary about this.

On SnowRidge, C6 support is enumerated via the usual mechanism: "mwait" leaf of
the "cpuid" instruction. The 'intel_idle' driver does check this leaf, so even
though C6 is present in the table, the driver will only use it if the CPU does
support it.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 41 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

Changelog:
v2. Fixed C6 latency value in the commit message (120 -> 130).

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 9a810e4a7946..1ef4ac3cc87c 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -976,6 +976,39 @@ static struct cpuidle_state dnv_cstates[] __initdata = {
 		.enter = NULL }
 };
 
+/*
+ * Note, depending on HW and FW revision, SnowRidge SoC may or may not support
+ * C6, and this is indicated in the CPUID mwait leaf.
+ */
+static struct cpuidle_state snr_cstates[] __initdata = {
+	{
+		.name = "C1",
+		.desc = "MWAIT 0x00",
+		.flags = MWAIT2flg(0x00),
+		.exit_latency = 2,
+		.target_residency = 2,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C1E",
+		.desc = "MWAIT 0x01",
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
+		.exit_latency = 15,
+		.target_residency = 25,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C6",
+		.desc = "MWAIT 0x20",
+		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 130,
+		.target_residency = 500,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.enter = NULL }
+};
+
 static const struct idle_cpu idle_cpu_nehalem __initconst = {
 	.state_table = nehalem_cstates,
 	.auto_demotion_disable_flags = NHM_C1_AUTO_DEMOTE | NHM_C3_AUTO_DEMOTE,
@@ -1097,6 +1130,12 @@ static const struct idle_cpu idle_cpu_dnv __initconst = {
 	.use_acpi = true,
 };
 
+static const struct idle_cpu idle_cpu_snr __initconst = {
+	.state_table = snr_cstates,
+	.disable_promotion_to_c1e = true,
+	.use_acpi = true,
+};
+
 static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EP,		&idle_cpu_nhx),
 	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM,		&idle_cpu_nehalem),
@@ -1135,7 +1174,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&idle_cpu_bxt),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&idle_cpu_bxt),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&idle_cpu_dnv),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&idle_cpu_dnv),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&idle_cpu_snr),
 	{}
 };
 
-- 
2.26.2

