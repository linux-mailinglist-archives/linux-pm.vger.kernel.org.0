Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E93E2E1C3A
	for <lists+linux-pm@lfdr.de>; Wed, 23 Dec 2020 13:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgLWMYb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Dec 2020 07:24:31 -0500
Received: from mga01.intel.com ([192.55.52.88]:33895 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgLWMYb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 23 Dec 2020 07:24:31 -0500
IronPort-SDR: no72jU6hSVVBh9QSJDpSCwTJ5R0dQkCMazByAdY7Yg0/6iXliBf9v7NO4gDUqsDaC3xXEaZEZv
 LTZzajhQWYOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="194455522"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="194455522"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 04:23:50 -0800
IronPort-SDR: lxgyqUEkW2ZkpZDNkrIGqLPPJgdGXRffPAzvGiYDM1Hs5Vh2mMBoGTVU7z+HWXbHP4sPL5yexm
 vX7G7fn81Hnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="457951591"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2020 04:23:49 -0800
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM Mailing List <linux-pm@vger.kernel.org>
Subject: [PATCH] intel_idle: add SnowRidge C-state table
Date:   Wed, 23 Dec 2020 14:23:48 +0200
Message-Id: <20201223122348.4002645-1-dedekind1@gmail.com>
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
3. C6 latency changed from 50us to 120us. Measured the same way as C1E.

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

