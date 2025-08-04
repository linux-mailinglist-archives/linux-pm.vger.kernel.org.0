Return-Path: <linux-pm+bounces-31886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6614B1A12E
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 14:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1ACF17EFDE
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 12:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BDC257459;
	Mon,  4 Aug 2025 12:18:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279D0259CA9;
	Mon,  4 Aug 2025 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309891; cv=none; b=YZj27mZ3fPm5JnEKMMsqUzpg507CADHifAcawxyN8MAS6aWcCr9DBr/P1j3UhP8jp0VA+42BGOzOAv8AjQL4p4daKKbMSOJQHKJLpwyJ/zV46mgWHwML/ziDePPcaYZABWljkXIL8KGLKQXcssOg78f0oWjUW8nZA5kb1mt41B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309891; c=relaxed/simple;
	bh=4A/Iz1W4dpCEfJiWFU8J6cV2SWj/eTLqk0uJbHh8yrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jnRHd0IiIkXtW3KaG5BF8QvhVOgHxafXnPyTke8Sxxa4zm4QYXp96S3TiqrJ7uES61h4sxFEmif916aeA6vbxHp27gvFeoQ8UAZ3EuSHshKsrsxiCih0ckUIssvalCZhwV35MizHyCIzdfULqRbuzzOrvgNsRYV/cUai/oNpqVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 733DD150C;
	Mon,  4 Aug 2025 05:18:01 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D20A43F738;
	Mon,  4 Aug 2025 05:18:05 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	maz@kernel.org,
	broonie@kernel.org,
	oliver.upton@linux.dev,
	anshuman.khandual@arm.com,
	robh@kernel.org,
	james.morse@arm.com,
	mark.rutland@arm.com,
	joey.gouly@arm.com,
	ry111@xry111.site,
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
	suzuki.poulose@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH 10/11] KVM: arm64: nv: support SCTLR2_ELx on nv
Date: Mon,  4 Aug 2025 13:17:23 +0100
Message-Id: <20250804121724.3681531-11-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804121724.3681531-1-yeoreum.yun@arm.com>
References: <20250804121724.3681531-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support SCTLR2_ELx sysreg on nv.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/include/asm/kvm_host.h  |  3 +++
 arch/arm64/kvm/emulate-nested.c    |  2 ++
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c |  6 ++++++
 arch/arm64/kvm/nested.c            | 13 +++++++++++++
 arch/arm64/kvm/sys_regs.c          |  9 +++++++++
 5 files changed, 33 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 4ff0ebcc2f60..95d0027a734e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -525,6 +525,7 @@ enum vcpu_sysreg {
 	TCR2_EL2,	/* Extended Translation Control Register (EL2) */
 	MDCR_EL2,	/* Monitor Debug Configuration Register (EL2) */
 	CNTHCTL_EL2,	/* Counter-timer Hypervisor Control register */
+	SCTLR2_EL2,	/* Extend System Control Register (EL2) */

 	/* Any VNCR-capable reg goes after this point */
 	MARKER(__VNCR_START__),
@@ -1161,6 +1162,7 @@ static inline bool __vcpu_read_sys_reg_from_cpu(int reg, u64 *val)
 	switch (reg) {
 	case SCTLR_EL1:		*val = read_sysreg_s(SYS_SCTLR_EL12);	break;
 	case CPACR_EL1:		*val = read_sysreg_s(SYS_CPACR_EL12);	break;
+	case SCTLR2_EL1:	*val = read_sysreg_s(SYS_SCTLR2_EL12);	break;
 	case TTBR0_EL1:		*val = read_sysreg_s(SYS_TTBR0_EL12);	break;
 	case TTBR1_EL1:		*val = read_sysreg_s(SYS_TTBR1_EL12);	break;
 	case TCR_EL1:		*val = read_sysreg_s(SYS_TCR_EL12);	break;
@@ -1211,6 +1213,7 @@ static inline bool __vcpu_write_sys_reg_to_cpu(u64 val, int reg)
 	switch (reg) {
 	case SCTLR_EL1:		write_sysreg_s(val, SYS_SCTLR_EL12);	break;
 	case CPACR_EL1:		write_sysreg_s(val, SYS_CPACR_EL12);	break;
+	case SCTLR2_EL1:	write_sysreg_s(val, SYS_SCTLR2_EL12);	break;
 	case TTBR0_EL1:		write_sysreg_s(val, SYS_TTBR0_EL12);	break;
 	case TTBR1_EL1:		write_sysreg_s(val, SYS_TTBR1_EL12);	break;
 	case TCR_EL1:		write_sysreg_s(val, SYS_TCR_EL12);	break;
diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 3a384e9660b8..d7809682915c 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -782,6 +782,7 @@ static const struct encoding_to_trap_config encoding_to_cgt[] __initconst = {
 	SR_TRAP(OP_TLBI_RVALE1OSNXS,	CGT_HCR_TTLB_TTLBOS),
 	SR_TRAP(OP_TLBI_RVAALE1OSNXS,	CGT_HCR_TTLB_TTLBOS),
 	SR_TRAP(SYS_SCTLR_EL1,		CGT_HCR_TVM_TRVM),
+	SR_TRAP(SYS_SCTLR2_EL1,		CGT_HCR_TVM_TRVM),
 	SR_TRAP(SYS_TTBR0_EL1,		CGT_HCR_TVM_TRVM),
 	SR_TRAP(SYS_TTBR1_EL1,		CGT_HCR_TVM_TRVM),
 	SR_TRAP(SYS_TCR_EL1,		CGT_HCR_TVM_TRVM),
@@ -1354,6 +1355,7 @@ static const struct encoding_to_trap_config encoding_to_fgt[] __initconst = {
 	SR_FGT(SYS_SCXTNUM_EL0,		HFGRTR, SCXTNUM_EL0, 1),
 	SR_FGT(SYS_SCXTNUM_EL1, 	HFGRTR, SCXTNUM_EL1, 1),
 	SR_FGT(SYS_SCTLR_EL1, 		HFGRTR, SCTLR_EL1, 1),
+	SR_FGT(SYS_SCTLR2_EL1, 		HFGRTR, SCTLR_EL1, 1), /* not typo! */
 	SR_FGT(SYS_REVIDR_EL1, 		HFGRTR, REVIDR_EL1, 1),
 	SR_FGT(SYS_PAR_EL1, 		HFGRTR, PAR_EL1, 1),
 	SR_FGT(SYS_MPIDR_EL1, 		HFGRTR, MPIDR_EL1, 1),
diff --git a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
index 73e4bc7fde9e..689e3297d949 100644
--- a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
@@ -51,6 +51,9 @@ static void __sysreg_save_vel2_state(struct kvm_vcpu *vcpu)
 		__vcpu_assign_sys_reg(vcpu, TTBR1_EL2,	 read_sysreg_el1(SYS_TTBR1));
 		__vcpu_assign_sys_reg(vcpu, TCR_EL2,	 read_sysreg_el1(SYS_TCR));

+		if (ctxt_has_sctlrx(&vcpu->arch.ctxt))
+			__vcpu_assign_sys_reg(vcpu, SCTLR2_EL2, read_sysreg_el1(SYS_SCTLR2));
+
 		if (ctxt_has_tcrx(&vcpu->arch.ctxt)) {
 			__vcpu_assign_sys_reg(vcpu, TCR2_EL2, read_sysreg_el1(SYS_TCR2));

@@ -120,6 +123,9 @@ static void __sysreg_restore_vel2_state(struct kvm_vcpu *vcpu)
 		write_sysreg_el1(val, SYS_TCR);
 	}

+	if (ctxt_has_sctlrx(&vcpu->arch.ctxt))
+		write_sysreg_el1(__vcpu_sys_reg(vcpu, SCTLR2_EL2), SYS_SCTLR2);
+
 	if (ctxt_has_tcrx(&vcpu->arch.ctxt)) {
 		write_sysreg_el1(__vcpu_sys_reg(vcpu, TCR2_EL2), SYS_TCR2);

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index dc1d26559bfa..a4d3b2d2fd80 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1704,6 +1704,19 @@ int kvm_init_nv_sysregs(struct kvm_vcpu *vcpu)
 			 TCR2_EL2_AMEC1 | TCR2_EL2_DisCH0 | TCR2_EL2_DisCH1);
 	set_sysreg_masks(kvm, TCR2_EL2, res0, res1);

+	/*
+	 * SCTLR2_EL2 - until explicit support for each feature, set all as RES0.
+	 */
+	res0 = SCTLR2_EL2_RES0 | SCTLR2_EL2_EMEC;
+	res0 |= SCTLR2_EL2_EASE;
+	res0 |= SCTLR2_EL2_NMEA;
+	res0 |= (SCTLR2_EL2_EnADERR | SCTLR2_EL2_EnANERR);
+	res0 |= SCTLR2_EL2_EnIDCP128;
+	res0 |= (SCTLR2_EL2_CPTA | SCTLR2_EL2_CPTA0 |
+		 SCTLR2_EL2_CPTM | SCTLR2_EL2_CPTM0);
+	res1 = SCTLR2_EL2_RES1;
+	set_sysreg_masks(kvm, SCTLR2_EL2, res0, res1);
+
 	/* SCTLR_EL1 */
 	res0 = SCTLR_EL1_RES0;
 	res1 = SCTLR_EL1_RES1;
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index c960470b6d2b..24881b7248b5 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -122,6 +122,7 @@ static bool get_el2_to_el1_mapping(unsigned int reg,
 		PURE_EL2_SYSREG(  CNTHCTL_EL2	);
 		MAPPED_EL2_SYSREG(SCTLR_EL2,   SCTLR_EL1,
 				  translate_sctlr_el2_to_sctlr_el1	     );
+		MAPPED_EL2_SYSREG(SCTLR2_EL2,  SCTLR2_EL1,    NULL	     );
 		MAPPED_EL2_SYSREG(CPTR_EL2,    CPACR_EL1,
 				  translate_cptr_el2_to_cpacr_el1	     );
 		MAPPED_EL2_SYSREG(TTBR0_EL2,   TTBR0_EL1,
@@ -2597,6 +2598,12 @@ static unsigned int sctlr2_visibility(const struct kvm_vcpu *vcpu,
 	return REG_HIDDEN;
 }

+static unsigned int sctlr2_el2_visibility(const struct kvm_vcpu *vcpu,
+				    const struct sys_reg_desc *rd)
+{
+	return __el2_visibility(vcpu, rd, sctlr2_visibility);
+}
+
 static unsigned int s1pie_visibility(const struct kvm_vcpu *vcpu,
 				     const struct sys_reg_desc *rd)
 {
@@ -3313,6 +3320,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	EL2_REG_VNCR(VMPIDR_EL2, reset_unknown, 0),
 	EL2_REG(SCTLR_EL2, access_rw, reset_val, SCTLR_EL2_RES1),
 	EL2_REG(ACTLR_EL2, access_rw, reset_val, 0),
+	EL2_REG_FILTERED(SCTLR2_EL2, access_rw, reset_val, 0,
+			 sctlr2_el2_visibility),
 	EL2_REG_VNCR(HCR_EL2, reset_hcr, 0),
 	EL2_REG(MDCR_EL2, access_mdcr, reset_mdcr, 0),
 	EL2_REG(CPTR_EL2, access_rw, reset_val, CPTR_NVHE_EL2_RES1),
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


