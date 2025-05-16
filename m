Return-Path: <linux-pm+bounces-27257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D504ABA682
	for <lists+linux-pm@lfdr.de>; Sat, 17 May 2025 01:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5315A1BC1642
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 23:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05470280CE0;
	Fri, 16 May 2025 23:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dV/au78r"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4D3280A53;
	Fri, 16 May 2025 23:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747437702; cv=none; b=LssBJtt6uZKs+6U7wkLbbXIwy6jGgnmt/fcDb0Edx+Jkq73Y1eXd9yZYBUOQfVsHoNuLIEE19AUW6VtOQBgY9dLU12BfUuYHnV+Sa/iRDKeQz7nNzkYJ+I1xWQqPlHfgUChVZKBnCydZu1Rnsb/bmBSVhEKKoT+xCDlD//n3Wu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747437702; c=relaxed/simple;
	bh=EyEIYHKmSDcRWjcjZuBlOz8/xbPehLGEHqj0Xc579mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgLofKP/sAhlhuBzW8ObPa2hDwBJAhx+td52vixJWj8SdUxTpygTs7IEEwOmdLMdqPiCrjshD2/zoC0qJZ5EWUH78EwSFtl+N2fGUhH2Yj7kvhPd2OCNsMq/nk36ZL0f/lg1Py8CQY2F4Ic9+7ioLBiH2bA2j5xjIHw92ovGVX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dV/au78r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC29C4CEE9;
	Fri, 16 May 2025 23:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747437700;
	bh=EyEIYHKmSDcRWjcjZuBlOz8/xbPehLGEHqj0Xc579mU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dV/au78riVFVpGQw7WnhYNZLgBcB/NnyKgJNRSWGsVkWk4m16wMco8idAskCoVfLO
	 +LyAWGHYkZtKuQjN4PEBCRu8Mb7FQBLbjqMJUEURUzN5VgMgIBf+rXvKkd7MGfjRT3
	 nmf0YijhWYWA6TcwhMqE+IcCvn+XfTkBP7PzhHKgkfdu+xp6ESbq6xR5zRiuyWHORP
	 CPb/zH6GuDCNlbfsa0VDd/EGyw+mAXzI8YwKeDEKVEzPuZIWywIN0BzTJoCu8wsEi9
	 Kc82iV1eU0k5WHKrox6k+Qt3VgR1aBwNHkjKKmtqgSuYMTGI/qKVziu7BXyz18595+
	 ADb2u8YfmKJvQ==
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
Subject: [PATCH 1/3] x86/fpu: Add fpu_save_state() for __save_processor_state()
Date: Fri, 16 May 2025 16:18:56 -0700
Message-ID: <20250516231858.27899-2-ebiggers@kernel.org>
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

Add a new function fpu_save_state() which handles the FPU state saving
and invalidation that __save_processor_state() needs.  This will allow
__save_processor_state() to stop using kernel_fpu_begin() and
kernel_fpu_end() for something other than actual kernel-mode FPU.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/include/asm/fpu/api.h |  1 +
 arch/x86/kernel/fpu/core.c     | 43 ++++++++++++++++++++++++++++------
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 8e6848f55dcdb..3ad359c5b100e 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -26,10 +26,11 @@
 #define KFPU_MXCSR	_BITUL(1)	/* MXCSR will be initialized */
 
 extern void kernel_fpu_begin_mask(unsigned int kfpu_mask);
 extern void kernel_fpu_end(void);
 extern bool irq_fpu_usable(void);
+extern void fpu_save_state(void);
 extern void fpregs_mark_activate(void);
 
 /* Code that is unaware of kernel_fpu_begin_mask() can use this */
 static inline void kernel_fpu_begin(void)
 {
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 948b4f5fad99c..476393b1d5e8f 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -118,11 +118,11 @@ static void update_avx_timestamp(struct fpu *fpu)
 
 /*
  * Save the FPU register state in fpu->fpstate->regs. The register state is
  * preserved.
  *
- * Must be called with fpregs_lock() held.
+ * Must be called with fpregs_lock() held or hardirqs disabled.
  *
  * The legacy FNSAVE instruction clears all FPU state unconditionally, so
  * register state has to be reloaded. That might be a pointless exercise
  * when the FPU is going to be used by another task right after that. But
  * this only affects 20+ years old 32bit systems and avoids conditionals all
@@ -431,26 +431,31 @@ int fpu_copy_uabi_to_guest_fpstate(struct fpu_guest *gfpu, const void *buf,
 	return copy_uabi_from_kernel_to_xstate(kstate, ustate, vpkru);
 }
 EXPORT_SYMBOL_GPL(fpu_copy_uabi_to_guest_fpstate);
 #endif /* CONFIG_KVM */
 
+static __always_inline void __fpu_save_state(void)
+{
+	if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER)) &&
+	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
+		set_thread_flag(TIF_NEED_FPU_LOAD);
+		save_fpregs_to_fpstate(x86_task_fpu(current));
+	}
+	__cpu_invalidate_fpregs_state();
+}
+
 void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 {
 	if (!irqs_disabled())
 		fpregs_lock();
 
 	WARN_ON_FPU(!irq_fpu_usable());
 	WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
 
 	this_cpu_write(in_kernel_fpu, true);
 
-	if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER)) &&
-	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
-		set_thread_flag(TIF_NEED_FPU_LOAD);
-		save_fpregs_to_fpstate(x86_task_fpu(current));
-	}
-	__cpu_invalidate_fpregs_state();
+	__fpu_save_state();
 
 	/* Put sane initial values into the control registers. */
 	if (likely(kfpu_mask & KFPU_MXCSR) && boot_cpu_has(X86_FEATURE_XMM))
 		ldmxcsr(MXCSR_DEFAULT);
 
@@ -467,10 +472,34 @@ void kernel_fpu_end(void)
 	if (!irqs_disabled())
 		fpregs_unlock();
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_end);
 
+#ifdef CONFIG_PM_SLEEP
+/*
+ * If the FPU registers are live for the current task, save them to current's
+ * memory register state and set TIF_NEED_FPU_LOAD.  This is used by the suspend
+ * and kexec code to prepare for the FPU registers being clobbered.  Unlike
+ * kernel_fpu_begin(), this function can be called with hardirqs disabled, and
+ * it does not initialize the FPU control registers for kernel-mode FPU use.
+ */
+void fpu_save_state(void)
+{
+	unsigned long flags;
+
+	WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
+
+	/*
+	 * This is sometimes called with hardirqs disabled, so we need to use
+	 * local_irq_save/restore() instead of fpregs_lock/unlock().
+	 */
+	local_irq_save(flags);
+	__fpu_save_state();
+	local_irq_restore(flags);
+}
+#endif /* CONFIG_PM_SLEEP */
+
 /*
  * Sync the FPU register state to current's memory register state when the
  * current task owns the FPU. The hardware register state is preserved.
  */
 void fpu_sync_fpstate(struct fpu *fpu)
-- 
2.49.0


