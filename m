Return-Path: <linux-pm+bounces-27375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE2FABC5A3
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 19:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571444A3684
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 17:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C664288CA2;
	Mon, 19 May 2025 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTg+RvBc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E702288C9C;
	Mon, 19 May 2025 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747675845; cv=none; b=YJ1PaqhVEje3bDNwTvsYd4ONreP6lhJmf119VKReNcsrVErFKEylegZ3d78jvRR2e2dc2qEjbFJgw6AHjZMcHgB1Ld7m/C2ZpchujVfGAf5i0n8Do12KBj5pOOBEaoapcxPgpINvKVUtDpxsZPtBuJ376RY0klLxUVwpZojg5HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747675845; c=relaxed/simple;
	bh=445sPrJ0OISg9BTwHpJqzeGDnex13qUpJTleh2di2JI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CWcS3g6zIlnNUx26Fx/mc6EdZnRSNL7rcwlZ6W01eK9KqyP/lS8qbAXzwGi1CUfUl3U8GztSpAlpQs25Xe3g9Xk4JGrceU8fv1cL6ElpEJvW2fhAZ2y5aFEXPznZXfa8wb1/+fw8eicUocEMzkgOCbtLo06GDjpRXB6QuNqLeoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTg+RvBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427FBC4CEED;
	Mon, 19 May 2025 17:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747675843;
	bh=445sPrJ0OISg9BTwHpJqzeGDnex13qUpJTleh2di2JI=;
	h=From:To:Cc:Subject:Date:From;
	b=JTg+RvBczj4vy+Lx8ePGBs6s9RsaDm7gAipItAzNfUI2IUO4Rhn3mqP54GF+DsMDR
	 FkFh7mZwwvCj/Z/PiHoaD5NcYlfPUNiOgyxHu4agOB8/To1IHrawZCV/TnraKdTvP/
	 BSbUl3Z6+P2JfDMrdKiOUffVx5wdAWHCNx6jLEd9MeDSaIqWMfbFs2XbvsOg+gEhMB
	 rmSye9Ty/GUN4q/cCWXkm/m/QeNPnDrVo/nPN49npVHy35QOff3Y8k1UV+vAR0rSUr
	 IACav5/YF8qDmLT70v3q35QwoKRDQ0mL9viEyTLYBq9q8H0vOaBhQJhKTH6OhO8ESE
	 jxHPRNQ/aYDsg==
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
Subject: [PATCH v2] x86/fpu: Fix irq_fpu_usable() to return false during CPU onlining
Date: Mon, 19 May 2025 10:29:54 -0700
Message-ID: <20250519172954.13015-1-ebiggers@kernel.org>
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
Tested-by: Ayush Jain <Ayush.Jain3@amd.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---

v2:
  - Add WARN_ON_FPU when kernel_fpu_allowed has unexpected value in
    fpu__init_cpu() or cpu_disable_common().  Since WARN_ON_FPU is
    defined in fpu/internal.h which should not be included by smpboot.c,
    made cpu_disable_common() call a new function fpu__disable_cpu().
  - Added Tested-by.

 arch/x86/include/asm/fpu/api.h |  1 +
 arch/x86/kernel/fpu/core.c     | 34 +++++++++++++++++++++-------------
 arch/x86/kernel/fpu/init.c     | 13 +++++++++++++
 arch/x86/kernel/fpu/internal.h |  2 ++
 arch/x86/kernel/smpboot.c      |  6 ++++++
 5 files changed, 43 insertions(+), 13 deletions(-)

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

base-commit: 3ee84e3dd88e39b55b534e17a7b9a181f1d46809
-- 
2.49.0


