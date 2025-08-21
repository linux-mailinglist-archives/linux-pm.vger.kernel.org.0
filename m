Return-Path: <linux-pm+bounces-32823-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F51B300F7
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 19:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73684620731
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 17:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B668C30EF9C;
	Thu, 21 Aug 2025 17:24:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41CA30E0E4;
	Thu, 21 Aug 2025 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797064; cv=none; b=aO5cXoyuj3wtztidQzkzi45NFX2E0nTgsrKH5MgMM3AT7PRGMK6kQTO2gRbIRYFmvmHjmeQPUSKX3nnpXFL/OieNg+DvjbA2uN+RrPuwZVfpq5iDuailMwIJ6myjBbKoklTmjptSrfG1Ycko7wIrRGSLPCpRX2UjRwbEMaOPay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797064; c=relaxed/simple;
	bh=8bUrJy8kFdsel6a29ezZOJv1OAbdONLJW21w+k8jdv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t67We/jVMbXPJHyoNuL03v3BQnvhiwJcWgMziYX3mFPi+2r91MLPo92Jv4rdnoOnoWIDraqfjyeR5jQh6vfsnLUqaSypY1d0LenkHEgNwzX68dHZgaK8ML2BTOolyQhRUG/UDf+0rFOFDAG8PJXTkBRiiVXr0BgElzyBuoBf7vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD9AC152B;
	Thu, 21 Aug 2025 10:24:13 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 640C13F59E;
	Thu, 21 Aug 2025 10:24:18 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	broonie@kernel.org,
	oliver.upton@linux.dev,
	anshuman.khandual@arm.com,
	robh@kernel.org,
	james.morse@arm.com,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	Dave.Martin@arm.com,
	ahmed.genidi@arm.com,
	kevin.brodsky@arm.com,
	scott@os.amperecomputing.com,
	mbenes@suse.cz,
	james.clark@linaro.org,
	frederic@kernel.org,
	rafael@kernel.org,
	pavel@kernel.org,
	ryan.roberts@arm.com,
	suzuki.poulose@arm.com,
	maz@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v4 2/5] arm64: initialise SCTLR2_ELx register at boot time
Date: Thu, 21 Aug 2025 18:24:05 +0100
Message-Id: <20250821172408.2101870-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821172408.2101870-1-yeoreum.yun@arm.com>
References: <20250821172408.2101870-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of the SCTLR2_ELx register is UNKNOWN after reset.
If the firmware initializes these registers properly, no additional
initialization is required.
However, in cases where they are not initialized correctly,
initialize the SCTLR2_ELx registers during CPU/vCPU boot
to prevent unexpected system behavior caused by invalid values.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/include/asm/assembler.h   | 15 +++++++++++++++
 arch/arm64/include/asm/el2_setup.h   |  7 +++++++
 arch/arm64/include/asm/sysreg.h      |  5 +++++
 arch/arm64/kernel/head.S             |  5 +++++
 arch/arm64/kernel/hyp-stub.S         | 10 ++++++++++
 arch/arm64/kvm/hyp/nvhe/psci-relay.c |  3 +++
 6 files changed, 45 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 23be85d93348..c25c2aed5125 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -738,6 +738,21 @@ alternative_endif
 	set_sctlr sctlr_el2, \reg
 .endm
 
+/* Set SCTLR2_ELx to the @reg value. */
+.macro set_sctlr2_elx, el, reg, tmp
+	mrs_s	\tmp, SYS_ID_AA64MMFR3_EL1
+	ubfx	\tmp, \tmp, #ID_AA64MMFR3_EL1_SCTLRX_SHIFT, #4
+	cbz	\tmp, .Lskip_sctlr2_\@
+	.if	\el == 2
+	msr_s	SYS_SCTLR2_EL2, \reg
+	.elseif	\el == 12
+	msr_s	SYS_SCTLR2_EL12, \reg
+	.else
+	msr_s	SYS_SCTLR2_EL1, \reg
+	.endif
+.Lskip_sctlr2_\@:
+.endm
+
 	/*
 	 * Check whether asm code should yield as soon as it is able. This is
 	 * the case if we are currently running in task context, and the
diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index d9529dfc4783..2addf7c096fc 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -48,6 +48,12 @@
 	isb
 .endm
 
+.macro __init_sctlr2_el2
+	mov_q	x0, INIT_SCTLR2_EL2
+	set_sctlr2_elx	2, x0, x1
+	isb
+.endm
+
 .macro __init_el2_hcrx
 	mrs	x0, id_aa64mmfr1_el1
 	ubfx	x0, x0, #ID_AA64MMFR1_EL1_HCX_SHIFT, #4
@@ -411,6 +417,7 @@
  */
 .macro init_el2_state
 	__init_el2_sctlr
+	__init_sctlr2_el2
 	__init_el2_hcrx
 	__init_el2_timers
 	__init_el2_debug
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index d5b5f2ae1afa..0431b357b87b 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -868,6 +868,8 @@
 #define INIT_SCTLR_EL2_MMU_OFF \
 	(SCTLR_EL2_RES1 | ENDIAN_SET_EL2)
 
+#define INIT_SCTLR2_EL2			UL(0)
+
 /* SCTLR_EL1 specific flags. */
 #ifdef CONFIG_CPU_BIG_ENDIAN
 #define ENDIAN_SET_EL1		(SCTLR_EL1_E0E | SCTLR_ELx_EE)
@@ -888,6 +890,8 @@
 	 SCTLR_EL1_LSMAOE | SCTLR_EL1_nTLSMD | SCTLR_EL1_EIS   | \
 	 SCTLR_EL1_TSCXT  | SCTLR_EL1_EOS)
 
+#define INIT_SCTLR2_EL1			UL(0)
+
 /* MAIR_ELx memory attributes (used by Linux) */
 #define MAIR_ATTR_DEVICE_nGnRnE		UL(0x00)
 #define MAIR_ATTR_DEVICE_nGnRE		UL(0x04)
@@ -1164,6 +1168,7 @@
 	msr	hcr_el2, \reg
 #endif
 	.endm
+
 #else
 
 #include <linux/bitfield.h>
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index ca04b338cb0d..e42664246e15 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -276,6 +276,8 @@ SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
 	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
 	pre_disable_mmu_workaround
 	msr	sctlr_el1, x0
+	mov_q	x0, INIT_SCTLR2_EL1
+	set_sctlr2_elx	1, x0, x1
 	isb
 	mov_q	x0, INIT_PSTATE_EL1
 	msr	spsr_el1, x0
@@ -308,6 +310,7 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 	isb
 
 	mov_q	x1, INIT_SCTLR_EL1_MMU_OFF
+	mov_q	x2, INIT_SCTLR2_EL1
 
 	mrs	x0, hcr_el2
 	and	x0, x0, #HCR_E2H
@@ -315,11 +318,13 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 
 	/* Set a sane SCTLR_EL1, the VHE way */
 	msr_s	SYS_SCTLR_EL12, x1
+	set_sctlr2_elx	12, x2, x0
 	mov	x2, #BOOT_CPU_FLAG_E2H
 	b	3f
 
 2:
 	msr	sctlr_el1, x1
+	set_sctlr2_elx	1, x2, x0
 	mov	x2, xzr
 3:
 	mov	x0, #INIT_PSTATE_EL1
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 36e2d26b54f5..ac12f1b4f8e2 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -144,7 +144,17 @@ SYM_CODE_START_LOCAL(__finalise_el2)
 
 .Lskip_indirection:
 .Lskip_tcr2:
+	mrs_s	x1, SYS_ID_AA64MMFR3_EL1
+	ubfx	x1, x1, #ID_AA64MMFR3_EL1_SCTLRX_SHIFT, #4
+	cbz	x1, .Lskip_sctlr2
+	mrs_s	x1, SYS_SCTLR2_EL12
+	msr_s	SYS_SCTLR2_EL1, x1
 
+	// clean SCTLR2_EL1
+	mov_q	x1, INIT_SCTLR2_EL1
+	msr_s	SYS_SCTLR2_EL12, x1
+
+.Lskip_sctlr2:
 	isb
 
 	// Hack the exception return to stay at EL2
diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index c3e196fb8b18..df1180cad7f8 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -4,6 +4,7 @@
  * Author: David Brazdil <dbrazdil@google.com>
  */
 
+#include <asm/cpufeature.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
@@ -219,6 +220,8 @@ asmlinkage void __noreturn __kvm_host_psci_cpu_entry(bool is_cpu_on)
 		release_boot_args(boot_args);
 
 	write_sysreg_el1(INIT_SCTLR_EL1_MMU_OFF, SYS_SCTLR);
+	if (cpus_have_final_cap(ARM64_HAS_SCTLR2))
+		write_sysreg_el1(INIT_SCTLR2_EL1, SYS_SCTLR2);
 	write_sysreg(INIT_PSTATE_EL1, SPSR_EL2);
 
 	__host_enter(host_ctxt);
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


