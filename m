Return-Path: <linux-pm+bounces-27418-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ED3ABDF1C
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 17:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A878C2800
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 15:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675F52609FC;
	Tue, 20 May 2025 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZmj2lo8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4572609C7;
	Tue, 20 May 2025 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747755060; cv=none; b=lGLVy6yCFNaduCNn7PD5kyspwG7B+o5bJsFcWcjHHIhIJ6gT55jty4Nr40K4lqFZaAcyy9D9JXoygz4/cJHuVDIHN+o6xLgwW9oQ5dNOelFggbgeJcvPx39aw76g4uQkpf+66kxLkV5Ct0SSu/U1jdyMjjyC0RwQ4835WuRTVzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747755060; c=relaxed/simple;
	bh=XQsq4hGuKRkw0QINTm7AApAlm0Cid+MeHiqHowoBvFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtFuTo5BeRJoNF97pCecF/x6rFX5S8rYa9gQAn/XcCq/X+U7mKruLYPJmUZcII8+4ipnfuQ2h15+/j609pVTlJZfKMdKEg0RVuF2sFqqgTz9ajBqQC6me7oEojqyxHBUTComG3EhD1jTnvlQk7MMdOlSpzHU7y3wrXz07F4hExs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZmj2lo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAA7C4CEF1;
	Tue, 20 May 2025 15:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747755059;
	bh=XQsq4hGuKRkw0QINTm7AApAlm0Cid+MeHiqHowoBvFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZmj2lo8+qNzJ18KSCICTULkSs4CS+bXOrKQ9oBbCuspT25llTfTzhNNXiY2rZNSj
	 73hfkY0OylMVIR9pYcJleMEIdpIoisI65MPMo+8Z3Pw7qoeX9pLyUiuEzaYqPebUzL
	 BH9s8/+QRXMR6glxsceQqfwA/oAskuux/GOJkHDYX1cK88cLLn7mqqOH6fGGmmUP0W
	 2GnUMd7Jlq/nnGfwWTj1hg+GYRR5YKmFA5/EDQsNEzusSt6JgpCMGH2JmWJCmRf6RY
	 Xk0vXCvFxxVqOuVGDGE9E9jFp+WxEJoVfYyU7w/6iAkj/IayCKP2cgvF99Z+cfVYSd
	 Yror0ZCYogBig==
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
Subject: [PATCH v3 2/2] x86/fpu: Fix irq_fpu_usable() to return false during CPU onlining
Date: Tue, 20 May 2025 08:29:38 -0700
Message-ID: <20250520152938.21881-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520152938.21881-1-ebiggers@kernel.org>
References: <20250520152938.21881-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

irq_fpu_usable() incorrectly returned true before the FPU is
initialized.  The x86 CPU onlining code can call sha256() to checksum
AMD microcode images, before the FPU is initialized.  Since sha256()
recently gained a kernel-mode FPU optimized code path, a crash occurred
in kernel_fpu_begin_mask() during hotplug CPU onlining.

(The crash did not occur during boot-time CPU onlining, since the
optimized sha256() code is not enabled until subsys_initcalls run.)

Fix this by making irq_fpu_usable() return false before fpu__init_cpu()
has run.  To do this without adding any additional overhead to
irq_fpu_usable(), replace the existing per-CPU bool in_kernel_fpu with
kernel_fpu_allowed which tracks both initialization and usage rather
than just usage.  The initial state is false; FPU initialization sets it
to true; kernel-mode FPU sections toggle it to false and then back to
true; and CPU offlining restores it to the initial state of false.

Fixes: 11d7956d526f ("crypto: x86/sha256 - implement library instead of shash")
Reported-by: Ayush Jain <Ayush.Jain3@amd.com>
Closes: https://lore.kernel.org/r/20250516112217.GBaCcf6Yoc6LkIIryP@fat_crate.local
Tested-by: Ayush Jain <Ayush.Jain3@amd.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/include/asm/fpu/api.h |  1 +
 arch/x86/kernel/fpu/core.c     | 24 +++++++++++++++---------
 arch/x86/kernel/fpu/init.c     | 13 +++++++++++++
 arch/x86/kernel/fpu/internal.h |  2 ++
 arch/x86/kernel/smpboot.c      |  6 ++++++
 5 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 8e6848f55dcdb..2983acd95f5de 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -116,10 +116,11 @@ extern void fpu_reset_from_exception_fixup(void);
 /* Boot, hotplug and resume */
 extern void fpu__init_cpu(void);
 extern void fpu__init_system(void);
 extern void fpu__init_check_bugs(void);
 extern void fpu__resume_cpu(void);
+extern void fpu__disable_cpu(void);
 
 #ifdef CONFIG_MATH_EMULATION
 extern void fpstate_init_soft(struct swregs_state *soft);
 #else
 static inline void fpstate_init_soft(struct swregs_state *soft) {}
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 6495259a23962..ea138583dd92a 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -42,12 +42,15 @@ struct fpu_state_config fpu_user_cfg __ro_after_init;
  * Represents the initial FPU state. It's mostly (but not completely) zeroes,
  * depending on the FPU hardware format:
  */
 struct fpstate init_fpstate __ro_after_init;
 
-/* Track in-kernel FPU usage */
-static DEFINE_PER_CPU(bool, kernel_fpu_allowed) = true;
+/*
+ * Track FPU initialization and kernel-mode usage. 'true' means the FPU is
+ * initialized and is not currently being used by the kernel:
+ */
+DEFINE_PER_CPU(bool, kernel_fpu_allowed);
 
 /*
  * Track which context is using the FPU on the CPU:
  */
 DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
@@ -70,19 +73,22 @@ bool irq_fpu_usable(void)
 {
 	if (WARN_ON_ONCE(in_nmi()))
 		return false;
 
 	/*
-	 * In kernel FPU usage already active?  This detects any explicitly
-	 * nested usage in task or softirq context, which is unsupported.  It
-	 * also detects attempted usage in a hardirq that has interrupted a
-	 * kernel-mode FPU section.
+	 * Return false in the following cases:
+	 *
+	 * - FPU is not yet initialized. This can happen only when the call is
+	 *   coming from CPU onlining, for example for microcode checksumming.
+	 * - The kernel is already using the FPU, either because of explicit
+	 *   nesting (which should never be done), or because of implicit
+	 *   nesting when a hardirq interrupted a kernel-mode FPU section.
+	 *
+	 * The single boolean check below handles both cases:
 	 */
-	if (!this_cpu_read(kernel_fpu_allowed)) {
-		WARN_ON_FPU(!in_hardirq());
+	if (!this_cpu_read(kernel_fpu_allowed))
 		return false;
-	}
 
 	/*
 	 * When not in NMI or hard interrupt context, FPU can be used in:
 	 *
 	 * - Task context except from within fpregs_lock()'ed critical
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 6bb3e35c40e24..c581a3e452dfd 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -49,10 +49,23 @@ static void fpu__init_cpu_generic(void)
  */
 void fpu__init_cpu(void)
 {
 	fpu__init_cpu_generic();
 	fpu__init_cpu_xstate();
+
+	/* Start allowing kernel-mode FPU: */
+	WARN_ON_FPU(this_cpu_read(kernel_fpu_allowed));
+	this_cpu_write(kernel_fpu_allowed, true);
+}
+
+/*
+ * Stop allowing kernel-mode FPU. Called when a CPU is brought offline:
+ */
+void fpu__disable_cpu(void)
+{
+	WARN_ON_FPU(!this_cpu_read(kernel_fpu_allowed));
+	this_cpu_write(kernel_fpu_allowed, false);
 }
 
 static bool __init fpu__probe_without_cpuid(void)
 {
 	unsigned long cr0;
diff --git a/arch/x86/kernel/fpu/internal.h b/arch/x86/kernel/fpu/internal.h
index 975de070c9c98..9782152d609c7 100644
--- a/arch/x86/kernel/fpu/internal.h
+++ b/arch/x86/kernel/fpu/internal.h
@@ -2,10 +2,12 @@
 #ifndef __X86_KERNEL_FPU_INTERNAL_H
 #define __X86_KERNEL_FPU_INTERNAL_H
 
 extern struct fpstate init_fpstate;
 
+DECLARE_PER_CPU(bool, kernel_fpu_allowed);
+
 /* CPU feature check wrappers */
 static __always_inline __pure bool use_xsave(void)
 {
 	return cpu_feature_enabled(X86_FEATURE_XSAVE);
 }
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index d7d61b3de2bf6..cf42a7632dd49 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1186,10 +1186,16 @@ void cpu_disable_common(void)
 {
 	int cpu = smp_processor_id();
 
 	remove_siblinginfo(cpu);
 
+	/*
+	 * Stop allowing kernel-mode FPU. This is needed so that if the CPU is
+	 * brought online again, the initial state is not allowed:
+	 */
+	fpu__disable_cpu();
+
 	/* It's now safe to remove this processor from the online map */
 	lock_vector_lock();
 	remove_cpu_from_maps(cpu);
 	unlock_vector_lock();
 	fixup_irqs();
-- 
2.49.0


