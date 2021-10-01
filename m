Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A433F41F7B0
	for <lists+linux-pm@lfdr.de>; Sat,  2 Oct 2021 00:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356162AbhJAWsV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Oct 2021 18:48:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:38097 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356211AbhJAWr5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 Oct 2021 18:47:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="205756678"
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="205756678"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 15:44:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="565344027"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2021 15:44:20 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, linux-pm@vger.kernel.org
Subject: [PATCH v11 26/29] intel_idle/amx: Add SPR support with XTILEDATA capability
Date:   Fri,  1 Oct 2021 15:37:25 -0700
Message-Id: <20211001223728.9309-27-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211001223728.9309-1-chang.seok.bae@intel.com>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
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

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
Changes from v9:
* Add a comment to use tile_release() after preempt_disable(). (Dave
  Hansen)
* Use cpu_feature_enabled() instead of boot_cpu_has(). (Borislav Petkov)
* Add a Suggested-by tag.

Changes from v6:
* Update the changelog and function description. (Rafael J. Wysocki)

Changes from v5:
* Moved the code to intel_idle. (Peter Zijlstra)
* Fixed to deactivate fpregs. (Andy Lutomirski and Dave Hansen)
* Updated the code comment. (Dave Hansen)

Changes from v4:
* Added as a new patch. (Thomas Gleixner)
---
 arch/x86/include/asm/special_insns.h |  6 ++
 drivers/idle/intel_idle.c            | 82 ++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 68c257a3de0d..e105c27c2951 100644
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
index e6c543b5ee1d..72b72fa0e072 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -54,6 +54,8 @@
 #include <asm/intel-family.h>
 #include <asm/mwait.h>
 #include <asm/msr.h>
+#include <asm/fpu/internal.h>
+#include <asm/special_insns.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
 
@@ -155,6 +157,58 @@ static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
 	return 0;
 }
 
+/**
+ * idle_tile - Initialize TILE registers in INIT-state
+ *
+ * Leaving state in the dirty TILE registers may prevent the processor from
+ * entering lower-power idle states. Use TILERELEASE to initialize the
+ * state. Destroying fpregs state is safe after the fpstate update.
+ *
+ * WARNING: It should be called after preemption is disabled; otherwise,
+ * reschedule is possible with the destroyed state.
+ */
+static inline void idle_tile(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_XGETBV1) && (xgetbv(1) & XFEATURE_MASK_XTILE)) {
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
@@ -752,6 +806,27 @@ static struct cpuidle_state icx_cstates[] __initdata = {
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
@@ -1095,6 +1170,12 @@ static const struct idle_cpu idle_cpu_icx __initconst = {
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
@@ -1157,6 +1238,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&idle_cpu_skx),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&idle_cpu_icx),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&idle_cpu_icx),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&idle_cpu_spr),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&idle_cpu_knl),
 	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&idle_cpu_knl),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&idle_cpu_bxt),
-- 
2.17.1

