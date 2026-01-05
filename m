Return-Path: <linux-pm+bounces-40227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DA5CF576B
	for <lists+linux-pm@lfdr.de>; Mon, 05 Jan 2026 21:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B13343036982
	for <lists+linux-pm@lfdr.de>; Mon,  5 Jan 2026 20:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAD42EC08C;
	Mon,  5 Jan 2026 20:07:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873162C181;
	Mon,  5 Jan 2026 20:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767643635; cv=none; b=IbRigeKMdxKGZr8OWPLN6ZgMnLjz3yAsCJUO+dbfj5WyYOUUVQtjHx2j8pfWK98PUaGQEBJMIcpyFgOCbEdSqQhFRQqITXns+xJeYEsTYfSemuKCwTVsjI24kl+QX1gSqUHQ/tfWkb7HPrxvVGAXdT3G4Z/007lib+oWj26X3L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767643635; c=relaxed/simple;
	bh=DlowPyqgkau83dFIrI3e7nR5t7bGL5BmOjY+OCDVQhs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MQ5psD5bZGBRwGWrV06t+BJlxWDfz17CWr4DQfiQygqUmroq6WxbQGhRHPtyQl31FOv9Fw79YssOd12dtRGNXoCNgcHLdOyOOQBfuB8pOLYIs2RNVU+uXjxfXvdxJQFatNmrHrry9ZDOdNMvxAp5dwzJLjLKf/H7gjqebFnhUos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AABA3339;
	Mon,  5 Jan 2026 12:07:04 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A54353F6A8;
	Mon,  5 Jan 2026 12:07:09 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: rafael@kernel.org,
	pavel@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	anshuman.khandual@arm.com,
	ryan.roberts@arm.com,
	yang@os.amperecomputing.com,
	joey.gouly@arm.com,
	kevin.brodsky@arm.com,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH] arm64: fix cleared E0POE bit after cpu_suspend()/resume()
Date: Mon,  5 Jan 2026 20:07:07 +0000
Message-Id: <20260105200707.2071169-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TCR2_ELx.E0POE is set during smp_init().
However, this bit is not reprogrammed when the CPU enters suspension and
later resumes via cpu_resume(), as __cpu_setup() does not re-enable E0POE
and there is no save/restore logic for the TCR2_ELx system register.

As a result, the E0POE feature no longer works after cpu_resume().

To address this, save and restore TCR2_EL1 in the cpu_suspend()/cpu_resume()
path, rather than adding related logic to __cpu_setup(), taking into account
possible future extensions of the TCR2_ELx feature.

Fixes: bf83dae90fbc ("arm64: enable the Permission Overlay Extension for EL0")
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
NOTE:
  This patch based on v6.19-rc4
---
 arch/arm64/include/asm/suspend.h |  2 +-
 arch/arm64/mm/proc.S             | 22 ++++++++++++++--------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index e65f33edf9d6..e9ce68d50ba4 100644
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
index 01e868116448..3888f2ca43fb 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -97,8 +97,11 @@ SYM_FUNC_START(cpu_do_suspend)
 	mrs	x9, mdscr_el1
 	mrs	x10, oslsr_el1
 	mrs	x11, sctlr_el1
-	get_this_cpu_offset x12
-	mrs	x13, sp_el0
+alternative_if ARM64_HAS_TCR2
+	mrs	x12, REG_TCR2_EL1
+alternative_else_nop_endif
+	get_this_cpu_offset x13
+	mrs	x14, sp_el0
 	stp	x2, x3, [x0]
 	stp	x4, x5, [x0, #16]
 	stp	x6, x7, [x0, #32]
@@ -109,7 +112,7 @@ SYM_FUNC_START(cpu_do_suspend)
 	 * Save x18 as it may be used as a platform register, e.g. by shadow
 	 * call stack.
 	 */
-	str	x18, [x0, #96]
+	stp	x14, x18, [x0, #96]
 	ret
 SYM_FUNC_END(cpu_do_suspend)

@@ -130,8 +133,8 @@ SYM_FUNC_START(cpu_do_resume)
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
@@ -144,10 +147,13 @@ SYM_FUNC_START(cpu_do_resume)
 	msr	tcr_el1, x8
 	msr	vbar_el1, x9
 	msr	mdscr_el1, x10
+alternative_if ARM64_HAS_TCR2
+	msr	REG_TCR2_EL1, x13
+alternative_else_nop_endif

 	msr	sctlr_el1, x12
-	set_this_cpu_offset x13
-	msr	sp_el0, x14
+	set_this_cpu_offset x14
+	msr	sp_el0, x15
 	/*
 	 * Restore oslsr_el1 by writing oslar_el1
 	 */
@@ -161,7 +167,7 @@ alternative_if ARM64_HAS_RAS_EXTN
 	msr_s	SYS_DISR_EL1, xzr
 alternative_else_nop_endif

-	ptrauth_keys_install_kernel_nosync x14, x1, x2, x3
+	ptrauth_keys_install_kernel_nosync x15, x1, x2, x3
 	isb
 	ret
 SYM_FUNC_END(cpu_do_resume)
--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


