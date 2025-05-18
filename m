Return-Path: <linux-pm+bounces-27278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD334ABB174
	for <lists+linux-pm@lfdr.de>; Sun, 18 May 2025 21:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E4E1895FCF
	for <lists+linux-pm@lfdr.de>; Sun, 18 May 2025 19:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583F91EB18A;
	Sun, 18 May 2025 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9jExvFj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DB513B58D;
	Sun, 18 May 2025 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747596833; cv=none; b=IidVfcXjkSEj3epOqBNckIXMFLJX5mUZrwlrDVaFgniRtp+3928FNpkX8bR5nNeBTL1JAaNnbpt64VFvBlO25YTGTvOz1EI0NsXGH4kuZWW7GMqVAX6uGLobsmeyaqFQ00jzaFiyOxH0nTUfFslUpSJcLqbW//osYzSy24gD+Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747596833; c=relaxed/simple;
	bh=hzxC7MYJ7+HUoIK32oYZfsXGgy71E5mkKoul03prqBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUREhp5HjqxYoiT8Hq1XDAgH+iOUkaBtLe2G+7zwnnRhXxqLBHKacQ8DuKUO9eNX9Sd34jMVZgrA1LaYl8dEDSCD3BockBQV3pFKDa3GAHzGwCbnPoKYe/zq79+nBEeg32n0fk0GItAOQfRzH6ucKMzE47cinnhiP/NVnXMrLyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9jExvFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3E1C4CEE7;
	Sun, 18 May 2025 19:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747596832;
	bh=hzxC7MYJ7+HUoIK32oYZfsXGgy71E5mkKoul03prqBY=;
	h=From:To:Cc:Subject:Date:From;
	b=K9jExvFjIVhPfLJbHSeB2Mxr7qr4DIfmXw9JPk9gqGUDTUdrQI0kJtQWCfpmiS7DU
	 bePig/0VgJQlhuVkVJ41gs20O2cm+ZUQsznqnTHrzgZgrpBCujDlEscR8axKY8+DjJ
	 LovSondh2F7ENE2LaoTQ0WzlHiL+ag9ZoXsABSToxIQrjJpO9kFIpwHfsWbPrar3qE
	 CeYfyZwrs8Z88UmGcm3HHNi4UMeoLXwScFZhVi7jP0yuDh3bgnGOHxRHZpU9eHh0yK
	 C/dhuOgAqTN2vA0fvv23qwYaSevXABDMmyySpJTXfcEWcGgIOC20F2tJ+WqplPvUyY
	 NHFH1MolVwZDw==
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
Subject: [PATCH] x86/fpu: Fix irq_fpu_usable() to return false during CPU onlining
Date: Sun, 18 May 2025 12:32:12 -0700
Message-ID: <20250518193212.1822-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
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
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/include/asm/fpu/api.h |  1 +
 arch/x86/kernel/fpu/core.c     | 34 +++++++++++++++++++++-------------
 arch/x86/kernel/fpu/init.c     |  3 +++
 arch/x86/kernel/smpboot.c      |  6 ++++++
 4 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 8e6848f55dcdb..cd6f194a912bf 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -124,10 +124,11 @@ extern void fpstate_init_soft(struct swregs_state *soft);
 #else
 static inline void fpstate_init_soft(struct swregs_state *soft) {}
 #endif
 
 /* State tracking */
+DECLARE_PER_CPU(bool, kernel_fpu_allowed);
 DECLARE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
 
 /* Process cleanup */
 #ifdef CONFIG_X86_64
 extern void fpstate_free(struct fpu *fpu);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 948b4f5fad99c..ea138583dd92a 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -42,12 +42,15 @@ struct fpu_state_config fpu_user_cfg __ro_after_init;
  * Represents the initial FPU state. It's mostly (but not completely) zeroes,
  * depending on the FPU hardware format:
  */
 struct fpstate init_fpstate __ro_after_init;
 
-/* Track in-kernel FPU usage */
-static DEFINE_PER_CPU(bool, in_kernel_fpu);
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
-	if (this_cpu_read(in_kernel_fpu)) {
-		WARN_ON_FPU(!in_hardirq());
+	if (!this_cpu_read(kernel_fpu_allowed))
 		return false;
-	}
 
 	/*
 	 * When not in NMI or hard interrupt context, FPU can be used in:
 	 *
 	 * - Task context except from within fpregs_lock()'ed critical
@@ -437,13 +443,14 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 {
 	if (!irqs_disabled())
 		fpregs_lock();
 
 	WARN_ON_FPU(!irq_fpu_usable());
-	WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
 
-	this_cpu_write(in_kernel_fpu, true);
+	/* Toggle kernel_fpu_allowed to false: */
+	WARN_ON_FPU(!this_cpu_read(kernel_fpu_allowed));
+	this_cpu_write(kernel_fpu_allowed, false);
 
 	if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER)) &&
 	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
 		set_thread_flag(TIF_NEED_FPU_LOAD);
 		save_fpregs_to_fpstate(x86_task_fpu(current));
@@ -459,13 +466,14 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_begin_mask);
 
 void kernel_fpu_end(void)
 {
-	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
+	/* Toggle kernel_fpu_allowed back to true: */
+	WARN_ON_FPU(this_cpu_read(kernel_fpu_allowed));
+	this_cpu_write(kernel_fpu_allowed, true);
 
-	this_cpu_write(in_kernel_fpu, false);
 	if (!irqs_disabled())
 		fpregs_unlock();
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_end);
 
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 6bb3e35c40e24..99db41bf9fa6b 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -49,10 +49,13 @@ static void fpu__init_cpu_generic(void)
  */
 void fpu__init_cpu(void)
 {
 	fpu__init_cpu_generic();
 	fpu__init_cpu_xstate();
+
+	/* Start allowing kernel-mode FPU: */
+	this_cpu_write(kernel_fpu_allowed, true);
 }
 
 static bool __init fpu__probe_without_cpuid(void)
 {
 	unsigned long cr0;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index e266c4edea17e..58ede3fa6a75b 100644
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
+	this_cpu_write(kernel_fpu_allowed, false);
+
 	/* It's now safe to remove this processor from the online map */
 	lock_vector_lock();
 	remove_cpu_from_maps(cpu);
 	unlock_vector_lock();
 	fixup_irqs();

base-commit: 8566fc3b96539e3235909d6bdda198e1282beaed
-- 
2.49.0


