Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D5B445C78
	for <lists+linux-pm@lfdr.de>; Thu,  4 Nov 2021 23:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhKDXCf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Nov 2021 19:02:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:49621 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232360AbhKDXCf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Nov 2021 19:02:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="212554549"
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="scan'208";a="212554549"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 15:59:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="scan'208";a="490138598"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga007.jf.intel.com with ESMTP; 04 Nov 2021 15:59:56 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, mingo@redhat.com,
        chang.seok.bae@intel.com, linux-pm@vger.kernel.org
Subject: [PATCH 4/4] intel_idle: Add SPR support with AMX INIT-state
Date:   Thu,  4 Nov 2021 15:52:26 -0700
Message-Id: <20211104225226.5031-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211104225226.5031-1-chang.seok.bae@intel.com>
References: <20211104225226.5031-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a custom Sapphire Rapids C-state table to intel_idle driver. The
parameters in the table are preferred over those supplied by ACPI.

SPR supports AMX, and so this custom table uses idle entry points that know
how to initialize AMX state if necessary.

This guarantees that AMX state will never be the cause of hardware C-state
demotion from C6 to C1E. Under some conditions, this may result in improved
power savings and thus a higher available turbo frequency budget.

[ Based on patch by Artem Bityutskiy <artem.bityutskiy@linux.intel.com>. ]

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 drivers/idle/intel_idle.c | 62 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index e6c543b5ee1d..0ac7dc9e6d51 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -54,6 +54,7 @@
 #include <asm/intel-family.h>
 #include <asm/mwait.h>
 #include <asm/msr.h>
+#include <asm/fpu/api.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
 
@@ -155,6 +156,39 @@ static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
 	return 0;
 }
 
+/**
+ * intel_idle_tile - Ask the processor to enter the given idle state.
+ * @dev: cpuidle device of the target CPU.
+ * @drv: cpuidle driver (assumed to point to intel_idle_driver).
+ *
+ * Ensure TILE registers in INIT-state before using intel_idle() to
+ * enter the idle state.
+ */
+static __cpuidle int intel_idle_tile(struct cpuidle_device *dev,
+				     struct cpuidle_driver *drv, int index)
+{
+	fpu_idle_fpregs();
+
+	return intel_idle(dev, drv, index);
+}
+
+/**
+ * intel_idle_s2idle_tile - Ask the processor to enter the given idle state.
+ * @dev: cpuidle device of the target CPU.
+ * @drv: cpuidle driver (assumed to point to intel_idle_driver).
+ * @index: Target idle state index.
+ *
+ * Ensure TILE registers in INIT-state before using intel_idle_s2idle() to
+ * enter the idle state.
+ */
+static __cpuidle int intel_idle_s2idle_tile(struct cpuidle_device *dev,
+					    struct cpuidle_driver *drv, int index)
+{
+	fpu_idle_fpregs();
+
+	return intel_idle_s2idle(dev, drv, index);
+}
+
 /*
  * States are indexed by the cstate number,
  * which is also the index into the MWAIT hint array.
@@ -752,6 +786,27 @@ static struct cpuidle_state icx_cstates[] __initdata = {
 		.enter = NULL }
 };
 
+static struct cpuidle_state spr_cstates[] __initdata = {
+	{
+		.name = "C1",
+		.desc = "MWAIT 0x00",
+		.flags = MWAIT2flg(0x00),
+		.exit_latency = 1,
+		.target_residency = 1,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C6",
+		.desc = "MWAIT 0x20",
+		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 128,
+		.target_residency = 384,
+		.enter = &intel_idle_tile,
+		.enter_s2idle = intel_idle_s2idle_tile, },
+	{
+		.enter = NULL }
+};
+
 static struct cpuidle_state atom_cstates[] __initdata = {
 	{
 		.name = "C1E",
@@ -1095,6 +1150,12 @@ static const struct idle_cpu idle_cpu_icx __initconst = {
 	.use_acpi = true,
 };
 
+static const struct idle_cpu idle_cpu_spr __initconst = {
+	.state_table = spr_cstates,
+	.disable_promotion_to_c1e = true,
+	.use_acpi = true,
+};
+
 static const struct idle_cpu idle_cpu_avn __initconst = {
 	.state_table = avn_cstates,
 	.disable_promotion_to_c1e = true,
@@ -1157,6 +1218,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&idle_cpu_skx),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&idle_cpu_icx),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&idle_cpu_icx),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&idle_cpu_spr),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&idle_cpu_knl),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&idle_cpu_knl),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&idle_cpu_bxt),
-- 
2.17.1

