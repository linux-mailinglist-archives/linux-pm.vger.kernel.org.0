Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868143CC41F
	for <lists+linux-pm@lfdr.de>; Sat, 17 Jul 2021 17:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbhGQPiR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Jul 2021 11:38:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:24192 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235162AbhGQPiR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 17 Jul 2021 11:38:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="210853896"
X-IronPort-AV: E=Sophos;i="5.84,248,1620716400"; 
   d="scan'208";a="210853896"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2021 08:35:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,248,1620716400"; 
   d="scan'208";a="631387079"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2021 08:35:12 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, linux-pm@vger.kernel.org
Subject: [PATCH v8 25/26] intel_idle/amx: Add SPR support with XTILEDATA capability
Date:   Sat, 17 Jul 2021 08:29:02 -0700
Message-Id: <20210717152903.7651-26-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210717152903.7651-1-chang.seok.bae@intel.com>
References: <20210717152903.7651-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a custom Sapphire Rapids (SPR) C-state table to intel_idle driver. The
parameters in this table are preferred over those supplied by ACPI.

SPR supports AMX, and so this custom table uses idle entry points that know
how to initialize AMX TMM state, if necessary.

This guarantees that AMX TMM state will never be the cause of hardware
C-state demotion from C6 to C1E. Under some conditions this may result in
improved power savings, and thus higher available turbo frequency budget.

[ Based on patch by Artem Bityutskiy <artem.bityutskiy@linux.intel.com>. ]

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
Changes from v6:
* Update the changelog and function description. (Rafael J. Wysocki)

Changes from v5:
* Moved the code to intel_idle. (Peter Zijlstra)
* Fixed to deactivate fpregs. (Andy Lutomirski and Dave Hansen)
* Updated the code comment. (Dave Hansen)

Changes from v4:
* Added as a new patch. (Thomas Gleixner)
---
 arch/x86/include/asm/special_insns.h |  6 +++
 drivers/idle/intel_idle.c            | 79 ++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index f3fbb84ff8a7..fada1bb82c7b 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -294,6 +294,12 @@ static inline int enqcmds(void __iomem *dst, const void *src)
 	return 0;
 }
 
+static inline void tile_release(void)
+{
+	/* Instruction opcode for TILERELEASE; supported in binutils >= 2.36. */
+	asm volatile(".byte 0xc4, 0xe2, 0x78, 0x49, 0xc0");
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_SPECIAL_INSNS_H */
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index e6c543b5ee1d..fe1ba26cc797 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -54,6 +54,8 @@
 #include <asm/intel-family.h>
 #include <asm/mwait.h>
 #include <asm/msr.h>
+#include <asm/fpu/internal.h>
+#include <asm/special_insns.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
 
@@ -155,6 +157,55 @@ static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
 	return 0;
 }
 
+/**
+ * idle_tile - Initialize TILE registers in INIT-state
+ *
+ * Leaving state in the dirty TILE registers may prevent the processor from
+ * entering lower-power idle states. Use TILERELEASE to initialize the
+ * state. Destroying fpregs state is safe after the fpstate update.
+ */
+static inline void idle_tile(void)
+{
+	if (boot_cpu_has(X86_FEATURE_XGETBV1) && (xgetbv(1) & XFEATURE_MASK_XTILE)) {
+		tile_release();
+		fpregs_deactivate(&current->thread.fpu);
+	}
+}
+
+/**
+ * intel_idle_tile - Ask the processor to enter the given idle state.
+ * @dev: cpuidle device of the target CPU.
+ * @drv: cpuidle driver (assumed to point to intel_idle_driver).
+ * @index: Target idle state index.
+ *
+ * Ensure TILE registers in INIT-state before using intel_idle() to
+ * enter the idle state.
+ */
+static __cpuidle int intel_idle_tile(struct cpuidle_device *dev,
+				     struct cpuidle_driver *drv, int index)
+{
+	idle_tile();
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
+	idle_tile();
+
+	return intel_idle_s2idle(dev, drv, index);
+}
+
 /*
  * States are indexed by the cstate number,
  * which is also the index into the MWAIT hint array.
@@ -752,6 +803,27 @@ static struct cpuidle_state icx_cstates[] __initdata = {
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
@@ -1095,6 +1167,12 @@ static const struct idle_cpu idle_cpu_icx __initconst = {
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
@@ -1157,6 +1235,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&idle_cpu_skx),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&idle_cpu_icx),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&idle_cpu_icx),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&idle_cpu_spr),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&idle_cpu_knl),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&idle_cpu_knl),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&idle_cpu_bxt),
-- 
2.17.1

