Return-Path: <linux-pm+bounces-27256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4803EABA681
	for <lists+linux-pm@lfdr.de>; Sat, 17 May 2025 01:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5E11BC1375
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 23:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F18280CD4;
	Fri, 16 May 2025 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gg3Un5t5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC468280A50;
	Fri, 16 May 2025 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747437702; cv=none; b=chHbnQ/x7LsfdG3snsbz+3RjJuOuxWlmbDH1hcK3Z52H6Y0SImsZurMtYScd0G8WdS2dqYCv4ywb1pvZjoNjzvBcgjG7ETMx3Eurn4EPvXdmp22SyT4q4JRD5fcKkKhHlTA9X8c59jRc+2hxh0sEGBcZh83jupKWucz7AjQrlmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747437702; c=relaxed/simple;
	bh=sLfkWTBYyB2WFGVd1rCVQoVKboVRhpxKeej9ZVD3hzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfMcok0Vj2x9r8E5qqo8t3ylgnTQdD21GIlhDKUJ4TlqtPVnQ9kDUd6ht7EnvhmOfiHhjH0XMEvdvu9K0X8nbaPtKucN1qW93Zj3p+uJFM4yk+cDQS8bhwRnGyASkWfBU+CUFSzwBPaOFYItPVHPmLfBdqUGeLN9NYyNm4gHQ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gg3Un5t5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC46C4CEF2;
	Fri, 16 May 2025 23:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747437701;
	bh=sLfkWTBYyB2WFGVd1rCVQoVKboVRhpxKeej9ZVD3hzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gg3Un5t5FRNT6Yb37sRTNNOSXlRm2yt9IpI4JqgQKen7SkU4e/mZTxGXvNXcM0eaZ
	 JTca3rNAEkTrn5QEzMv0q7FklKXl4vC61M/yiigTp03BbA4wC/r06vzzPUbEpoiVjb
	 5sTDPoUBWmCP6zxktR2nIr4frhVzimb52t+kEoB5bh8xyxvJbGAy2LL0Weex2uPRVY
	 OabLNGZN72GZGuO1kdKG/6HQ2VsG3nj5PzP1ued2gHGmLVeYZExRsr+y0sy+7GhJ+K
	 aGDSGbRmo3I9Yeimz8DNRJ39vUrcloWAEUiVAPXbtXdD5Krq2B45XIzHY5EJKiwQtA
	 Mw+rManAw+e6w==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ayush Jain <Ayush.Jain3@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 3/3] x86/fpu: Don't support kernel-mode FPU when irqs_disabled()
Date: Fri, 16 May 2025 16:18:58 -0700
Message-ID: <20250516231858.27899-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516231858.27899-1-ebiggers@kernel.org>
References: <20250516231858.27899-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Make irq_fpu_usable() return false when irqs_disabled().  That makes the
irqs_disabled() checks in kernel_fpu_begin_mask() and kernel_fpu_end()
unnecessary, so also remove those.

Rationale:

- There's no known use case for kernel-mode FPU when irqs_disabled().
  arm64 and riscv already disallow kernel-mode FPU when irqs_disabled().
  __save_processor_state() previously did expect kernel_fpu_begin() and
  kernel_fpu_end() to work when irqs_disabled(), but this was a
  different use case and not actual kernel-mode FPU use.

- This is more efficient, since one call to irqs_disabled() replaces two
  irqs_disabled() and one in_hardirq().

- This fixes irq_fpu_usable() to correctly return false during CPU
  initialization.  Incorrectly returning true caused the SHA-256 library
  code, which is called when loading AMD microcode, to take a
  SIMD-optimized code path too early, causing a crash.  By correctly
  returning false from irq_fpu_usable(), the generic SHA-256 code
  correctly gets used instead.  (Note: SIMD-optimized SHA-256 doesn't
  get enabled until subsys_initcall, but CPU hotplug can happen later.)

Fixes: 11d7956d526f ("crypto: x86/sha256 - implement library instead of shash")
Reported-by: Ayush Jain <Ayush.Jain3@amd.com>
Closes: https://lore.kernel.org/r/20250516112217.GBaCcf6Yoc6LkIIryP@fat_crate.local
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/kernel/fpu/core.c | 49 ++++++++++++++------------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 476393b1d5e8f..9b3c5e17f86cd 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -66,42 +66,31 @@ struct fpu *x86_task_fpu(struct task_struct *task)
  * Can we use the FPU in kernel mode with the
  * whole "kernel_fpu_begin/end()" sequence?
  */
 bool irq_fpu_usable(void)
 {
-	if (WARN_ON_ONCE(in_nmi()))
-		return false;
-
 	/*
-	 * In kernel FPU usage already active?  This detects any explicitly
-	 * nested usage in task or softirq context, which is unsupported.  It
-	 * also detects attempted usage in a hardirq that has interrupted a
-	 * kernel-mode FPU section.
+	 * To ensure that (non-explicitly-nested) kernel-mode FPU is always
+	 * usable in task and softirq contexts, kernel_fpu_begin() disables
+	 * preemption and softirqs, and kernel_fpu_end() re-enables them.  That
+	 * is not compatible with hardirqs being disabled (including hardirq
+	 * context), or with NMI context.  Support for kernel-mode FPU is not
+	 * needed in those contexts anyway.  Return false in those contexts.
+	 *
+	 * Returning false when irqs_disabled() also eliminates the need to
+	 * explicitly check whether the FPU has been initialized yet during CPU
+	 * initialization.  Before then, hardirqs are still disabled.
 	 */
+	if (irqs_disabled() || WARN_ON_ONCE(in_nmi()))
+		return false;
+
+	/* Catch any explicitly nested usage, which should never happen. */
 	if (this_cpu_read(in_kernel_fpu)) {
-		WARN_ON_FPU(!in_hardirq());
+		WARN_ON_FPU(1);
 		return false;
 	}
-
-	/*
-	 * When not in NMI or hard interrupt context, FPU can be used in:
-	 *
-	 * - Task context except from within fpregs_lock()'ed critical
-	 *   regions.
-	 *
-	 * - Soft interrupt processing context which cannot happen
-	 *   while in a fpregs_lock()'ed critical region.
-	 */
-	if (!in_hardirq())
-		return true;
-
-	/*
-	 * In hard interrupt context it's safe when soft interrupts
-	 * are enabled, which means the interrupt did not hit in
-	 * a fpregs_lock()'ed critical region.
-	 */
-	return !softirq_count();
+	return true;
 }
 EXPORT_SYMBOL(irq_fpu_usable);
 
 /*
  * Track AVX512 state use because it is known to slow the max clock
@@ -443,12 +432,11 @@ static __always_inline void __fpu_save_state(void)
 	__cpu_invalidate_fpregs_state();
 }
 
 void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 {
-	if (!irqs_disabled())
-		fpregs_lock();
+	fpregs_lock();
 
 	WARN_ON_FPU(!irq_fpu_usable());
 	WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
 
 	this_cpu_write(in_kernel_fpu, true);
@@ -467,12 +455,11 @@ EXPORT_SYMBOL_GPL(kernel_fpu_begin_mask);
 void kernel_fpu_end(void)
 {
 	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
 
 	this_cpu_write(in_kernel_fpu, false);
-	if (!irqs_disabled())
-		fpregs_unlock();
+	fpregs_unlock();
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_end);
 
 #ifdef CONFIG_PM_SLEEP
 /*
-- 
2.49.0


