Return-Path: <linux-pm+bounces-31885-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 962ADB1A12C
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 14:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6DF189FB6B
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 12:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A24D259CAC;
	Mon,  4 Aug 2025 12:18:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043412580D7;
	Mon,  4 Aug 2025 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309887; cv=none; b=k5WPN+XgJGgZ0topxFnI0ydfPVyJonoDLDu+WOrh5j/96eCRvpRgYN2evOio+B5LN8Uuy1zUXW/k1+6coGhsbKu9IVQOaNikWOTMyZF/DTFSaC6knzN8bcOhc66WsGeaMkBoewwCQm7LvBAkH8UctANVvzx3zsnXFTyD+519W8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309887; c=relaxed/simple;
	bh=T8+5cPQjby9DphJUgYz99BLIwppZBx1SYLGNWbR12rY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZOpF6sVSgqpSvK+frIs8gq9YjPwiBf0giNKbHMOquoP2HFqpEJ7RLGpwA0sKOs2di4iewhYmArwGnLVM31U820zOaYRwa8gtCwVX7+ALcDwWb2qjKwgLni8rFW/ePU2JwjMFQCNsOi9iTcyx0iogBnd4hOcwPZUO+4s6oPBal0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83D111E32;
	Mon,  4 Aug 2025 05:17:57 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E27133F738;
	Mon,  4 Aug 2025 05:18:01 -0700 (PDT)
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
Subject: [PATCH 09/11] KVM: arm64: support SCTLR2_EL1 for guest
Date: Mon,  4 Aug 2025 13:17:22 +0100
Message-Id: <20250804121724.3681531-10-yeoreum.yun@arm.com>
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

support SCTLR2_EL1 system register for guest.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/include/asm/kvm_host.h          |  4 ++++
 arch/arm64/include/asm/vncr_mapping.h      |  1 +
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 16 ++++++++++++++++
 arch/arm64/kvm/sys_regs.c                  | 11 +++++++++++
 4 files changed, 32 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 3e41a880b062..4ff0ebcc2f60 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -532,6 +532,7 @@ enum vcpu_sysreg {
 	VNCR(SCTLR_EL1),/* System Control Register */
 	VNCR(ACTLR_EL1),/* Auxiliary Control Register */
 	VNCR(CPACR_EL1),/* Coprocessor Access Control */
+	VNCR(SCTLR2_EL1),/* Extended System Control Register */
 	VNCR(ZCR_EL1),	/* SVE Control */
 	VNCR(TTBR0_EL1),/* Translation Table Base Register 0 */
 	VNCR(TTBR1_EL1),/* Translation Table Base Register 1 */
@@ -1659,6 +1660,9 @@ void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
 #define kvm_has_tcr2(k)				\
 	(kvm_has_feat((k), ID_AA64MMFR3_EL1, TCRX, IMP))

+#define kvm_has_sctlr2(k)				\
+	(kvm_has_feat((k), ID_AA64MMFR3_EL1, SCTLRX, IMP))
+
 #define kvm_has_s1pie(k)				\
 	(kvm_has_feat((k), ID_AA64MMFR3_EL1, S1PIE, IMP))

diff --git a/arch/arm64/include/asm/vncr_mapping.h b/arch/arm64/include/asm/vncr_mapping.h
index 6f556e993644..ce7a401cb1be 100644
--- a/arch/arm64/include/asm/vncr_mapping.h
+++ b/arch/arm64/include/asm/vncr_mapping.h
@@ -51,6 +51,7 @@
 #define VNCR_SP_EL1             0x240
 #define VNCR_VBAR_EL1           0x250
 #define VNCR_TCR2_EL1		0x270
+#define VNCR_SCTLR2_EL1 	0x278
 #define VNCR_PIRE0_EL1		0x290
 #define VNCR_PIR_EL1		0x2A0
 #define VNCR_POR_EL1		0x2A8
diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index 4d0dbea4c56f..29ee9cd54a04 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -98,6 +98,17 @@ static inline bool ctxt_has_tcrx(struct kvm_cpu_context *ctxt)
 	return kvm_has_tcr2(kern_hyp_va(vcpu->kvm));
 }

+static inline bool ctxt_has_sctlrx(struct kvm_cpu_context *ctxt)
+{
+	struct kvm_vcpu *vcpu;
+
+	if (!cpus_have_final_cap(ARM64_HAS_SCTLR2))
+		return false;
+
+	vcpu = ctxt_to_vcpu(ctxt);
+	return kvm_has_sctlr2(kern_hyp_va(vcpu->kvm));
+}
+
 static inline bool ctxt_has_s1poe(struct kvm_cpu_context *ctxt)
 {
 	struct kvm_vcpu *vcpu;
@@ -112,6 +123,8 @@ static inline bool ctxt_has_s1poe(struct kvm_cpu_context *ctxt)
 static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt_sys_reg(ctxt, SCTLR_EL1)	= read_sysreg_el1(SYS_SCTLR);
+	if (ctxt_has_sctlrx(ctxt))
+		ctxt_sys_reg(ctxt, SCTLR2_EL1)	= read_sysreg_el1(SYS_SCTLR2);
 	ctxt_sys_reg(ctxt, CPACR_EL1)	= read_sysreg_el1(SYS_CPACR);
 	ctxt_sys_reg(ctxt, TTBR0_EL1)	= read_sysreg_el1(SYS_TTBR0);
 	ctxt_sys_reg(ctxt, TTBR1_EL1)	= read_sysreg_el1(SYS_TTBR1);
@@ -200,6 +213,9 @@ static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt,
 		isb();
 	}

+	if (ctxt_has_sctlrx(ctxt))
+		write_sysreg_el1(ctxt_sys_reg(ctxt, SCTLR2_EL1), SYS_SCTLR2);
+
 	write_sysreg_el1(ctxt_sys_reg(ctxt, CPACR_EL1),	SYS_CPACR);
 	write_sysreg_el1(ctxt_sys_reg(ctxt, TTBR0_EL1),	SYS_TTBR0);
 	write_sysreg_el1(ctxt_sys_reg(ctxt, TTBR1_EL1),	SYS_TTBR1);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index c20bd6f21e60..c960470b6d2b 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2588,6 +2588,15 @@ static unsigned int tcr2_el2_visibility(const struct kvm_vcpu *vcpu,
 	return __el2_visibility(vcpu, rd, tcr2_visibility);
 }

+static unsigned int sctlr2_visibility(const struct kvm_vcpu *vcpu,
+				    const struct sys_reg_desc *rd)
+{
+	if (kvm_has_sctlr2(vcpu->kvm))
+		return 0;
+
+	return REG_HIDDEN;
+}
+
 static unsigned int s1pie_visibility(const struct kvm_vcpu *vcpu,
 				     const struct sys_reg_desc *rd)
 {
@@ -2955,6 +2964,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_SCTLR_EL1), access_vm_reg, reset_val, SCTLR_EL1, 0x00C50078 },
 	{ SYS_DESC(SYS_ACTLR_EL1), access_actlr, reset_actlr, ACTLR_EL1 },
 	{ SYS_DESC(SYS_CPACR_EL1), NULL, reset_val, CPACR_EL1, 0 },
+	{ SYS_DESC(SYS_SCTLR2_EL1), access_vm_reg, reset_val, SCTLR2_EL1, 0,
+	  .visibility = sctlr2_visibility },

 	MTE_REG(RGSR_EL1),
 	MTE_REG(GCR_EL1),
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


