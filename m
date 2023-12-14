Return-Path: <linux-pm+bounces-1164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E8881370E
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 17:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94FC1F2174D
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 16:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2BC61FDB;
	Thu, 14 Dec 2023 16:56:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB0B8E
	for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 08:56:27 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2305223"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="2305223"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 08:56:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="947637114"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="947637114"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga005.jf.intel.com with ESMTP; 14 Dec 2023 08:56:25 -0800
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>,
	Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 2/2] intel_idle: add Sierra Forest SoC support
Date: Thu, 14 Dec 2023 18:56:22 +0200
Message-Id: <20231214165622.100428-2-dedekind1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231214165622.100428-1-dedekind1@gmail.com>
References: <20231214165622.100428-1-dedekind1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Add Sierra Forest SoC C-states, which are C1, C1E, C6S, and C6SP.

Sierra Forest SoC is built with modules, each module includes 4 cores
(Crestmont microarchitecture). There is one L2 cache per module, shared between
the 4 cores.

There is no core C6 state, but there is C6S state, which has module scope:
when all 4 cores request C6S, the entire module (4 cores + L2 cache) enters the
low power state.

C6SP state has package scope - when all modules in the package enter C6S, the
package enters the power state mode.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 44 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 3b846d4f8707..b4390822edad 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1300,6 +1300,43 @@ static struct cpuidle_state grr_cstates[] __initdata = {
 		.enter = NULL }
 };
 
+static struct cpuidle_state srf_cstates[] __initdata = {
+	{
+		.name = "C1",
+		.desc = "MWAIT 0x00",
+		.flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_ALWAYS_ENABLE,
+		.exit_latency = 1,
+		.target_residency = 1,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C1E",
+		.desc = "MWAIT 0x01",
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
+		.exit_latency = 2,
+		.target_residency = 10,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C6S",
+		.desc = "MWAIT 0x22",
+		.flags = MWAIT2flg(0x22) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 270,
+		.target_residency = 700,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C6SP",
+		.desc = "MWAIT 0x23",
+		.flags = MWAIT2flg(0x23) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 310,
+		.target_residency = 900,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.enter = NULL }
+};
+
 static const struct idle_cpu idle_cpu_nehalem __initconst = {
 	.state_table = nehalem_cstates,
 	.auto_demotion_disable_flags = NHM_C1_AUTO_DEMOTE | NHM_C3_AUTO_DEMOTE,
@@ -1455,6 +1492,12 @@ static const struct idle_cpu idle_cpu_grr __initconst = {
 	.use_acpi = true,
 };
 
+static const struct idle_cpu idle_cpu_srf __initconst = {
+	.state_table = srf_cstates,
+	.disable_promotion_to_c1e = true,
+	.use_acpi = true,
+};
+
 static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EP,		&idle_cpu_nhx),
 	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM,		&idle_cpu_nehalem),
@@ -1502,6 +1545,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&idle_cpu_dnv),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&idle_cpu_snr),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT,	&idle_cpu_grr),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	&idle_cpu_srf),
 	{}
 };
 
-- 
2.40.1


