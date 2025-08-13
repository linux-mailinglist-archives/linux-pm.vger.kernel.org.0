Return-Path: <linux-pm+bounces-32277-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A76EB24913
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 14:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FF23AC67F
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 12:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE5F305E15;
	Wed, 13 Aug 2025 12:01:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26522FD1DB;
	Wed, 13 Aug 2025 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086497; cv=none; b=VWDqprd8z6daY89NgtYZ7qREdSJj9CSJGCB8jcrZgr2MZ0mP/HOKRjj2IQefdFYzaNlV5/aENJPEDzxg8LdB9+OWITT2Kxgu9u0lKSTJmv6kHebAAYsOfsTI31/Lo9rFDOpzOt75c6vdeFux+0eQTwgn0vEDH0VbHVaDOJU9DEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086497; c=relaxed/simple;
	bh=VxeLWNVEZRUcSCDmjWrjuOceVIFpt1l7BL6suc1u/B4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SGzqH9F/5niSZ++zK5X6RFvmaVa4E5B9Na1tOsi1SQncJ5BJgTburxLdgv/NTge31cVSmwbs7YWKnInfdeefF1ydcOOmN12WfHNnEF+D4d7RAFROQ1HuPk0IFNQ1sUQBmhKfM84AMKCaUsH6/HUSMik8AhUSny218XjF7afpacs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E731012FC;
	Wed, 13 Aug 2025 05:01:26 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B050D3F5A1;
	Wed, 13 Aug 2025 05:01:31 -0700 (PDT)
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
	suzuki.poulose@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v3 3/5] arm64: save/restore SCTLR2_EL1 when cpu_suspend()/resume()
Date: Wed, 13 Aug 2025 13:01:16 +0100
Message-Id: <20250813120118.3953541-4-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813120118.3953541-1-yeoreum.yun@arm.com>
References: <20250813120118.3953541-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCTLR2_EL1 register is optional starting from ARMv8.8/ARMv9.3,
and becomes mandatory from ARMv8.9/ARMv9.4
and serveral architectural feature are controled by bits in
these registers (i.e) FEAT_PAuth_LR or FEAT_CPA/CPA2

Save and restore SCTLR2_EL1 when cpu_suspend() and resume().
so that configured value can sustain consistency before suspend and
after resume.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/include/asm/suspend.h |  2 +-
 arch/arm64/mm/proc.S             | 26 ++++++++++++++++++--------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index 0cde2f473971..eb60c9735553 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SUSPEND_H
 #define __ASM_SUSPEND_H
 
-#define NR_CTX_REGS 13
+#define NR_CTX_REGS 14
 #define NR_CALLEE_SAVED_REGS 12
 
 /*
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 8c75965afc9e..f297bea7103b 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -87,8 +87,14 @@ SYM_FUNC_START(cpu_do_suspend)
 	mrs	x9, mdscr_el1
 	mrs	x10, oslsr_el1
 	mrs	x11, sctlr_el1
-	get_this_cpu_offset x12
-	mrs	x13, sp_el0
+alternative_if_not ARM64_HAS_SCTLR2
+	mov	x12, xzr
+alternative_else
+	mrs_s	x12, SYS_SCTLR2_EL1
+alternative_endif
+	get_this_cpu_offset x13
+	mrs	x14, sp_el0
+
 	stp	x2, x3, [x0]
 	stp	x4, x5, [x0, #16]
 	stp	x6, x7, [x0, #32]
@@ -99,7 +105,7 @@ SYM_FUNC_START(cpu_do_suspend)
 	 * Save x18 as it may be used as a platform register, e.g. by shadow
 	 * call stack.
 	 */
-	str	x18, [x0, #96]
+	stp	x14, x18, [x0, #96]
 	ret
 SYM_FUNC_END(cpu_do_suspend)
 
@@ -120,8 +126,8 @@ SYM_FUNC_START(cpu_do_resume)
 	 * the buffer to minimize the risk of exposure when used for shadow
 	 * call stack.
 	 */
-	ldr	x18, [x0, #96]
-	str	xzr, [x0, #96]
+	ldp	x15, x18, [x0, #96]
+	str	xzr, [x0, #104]
 	msr	tpidr_el0, x2
 	msr	tpidrro_el0, x3
 	msr	contextidr_el1, x4
@@ -136,8 +142,12 @@ SYM_FUNC_START(cpu_do_resume)
 	msr	mdscr_el1, x10
 
 	msr	sctlr_el1, x12
-	set_this_cpu_offset x13
-	msr	sp_el0, x14
+alternative_if ARM64_HAS_SCTLR2
+	msr_s	SYS_SCTLR2_EL1, x13
+alternative_else_nop_endif
+
+	set_this_cpu_offset x14
+	msr	sp_el0, x15
 	/*
 	 * Restore oslsr_el1 by writing oslar_el1
 	 */
@@ -151,7 +161,7 @@ alternative_if ARM64_HAS_RAS_EXTN
 	msr_s	SYS_DISR_EL1, xzr
 alternative_else_nop_endif
 
-	ptrauth_keys_install_kernel_nosync x14, x1, x2, x3
+	ptrauth_keys_install_kernel_nosync x15, x1, x2, x3
 	isb
 	ret
 SYM_FUNC_END(cpu_do_resume)
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


