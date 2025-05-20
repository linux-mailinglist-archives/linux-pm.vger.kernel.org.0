Return-Path: <linux-pm+bounces-27417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B17CAABDF42
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 17:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7802162A61
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 15:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74082571C8;
	Tue, 20 May 2025 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+tx8XMQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5902472B2;
	Tue, 20 May 2025 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747755059; cv=none; b=kDfsQws1aPButkkjnFec1Fv3svOqsga0qjPZlzcQ+ze1/VpdeD/RN7CuoPfY3DgCR3Br2TqS8GiZI0znM4qserjKwsg9bRIjByWzCt2uW7tLwVOubXkhzmsGMJFbcnBrDlqqqK08EoyyPrmBYLgpz6ni84GfMGmu4YIn8u+mR7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747755059; c=relaxed/simple;
	bh=VsmtpwN7ZMx/feXnEs7bIpevjlQvf0bxR1Wk+TKYvuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3XufagVuejsvs783slLTNgOy/rXZSLITL4EVzf2CVTnQk7DCTkv02+cG2OvIvtqWYBxCpFZ4oSOnPg3hRpyx6ZwdMmtnbt96RRn44QZcJflwyDoPlWapngRQ9Lt8t/RzBFeEJje0wkUMVQt6RWCJrDy8rmwI3QgLCxk8LDGsDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+tx8XMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084B9C4CEEB;
	Tue, 20 May 2025 15:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747755059;
	bh=VsmtpwN7ZMx/feXnEs7bIpevjlQvf0bxR1Wk+TKYvuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h+tx8XMQrZE3DcTi4L70OBETRBCpr+loDjlkOdNV9O65rrwRS6XeaAqD9mgLvY0ZH
	 UOzwL9FnPOFLzpdQuE0Oqd36gfWCkYviwCLURQbVl06bNNgiHCXSTd/FmWU46Lrbg/
	 s7pVbwSZLPykpGUph85WSVNqgnyKJa0Kz2VVkfE1mEbbN5wrHUIPDUH8axuxbdMN1t
	 jzANM5pXvL40RF+Ikh14xqQFEjFNXOBWHoZDblJ2Bs3ouO1Zkm5/iGisRn5IzTkwKy
	 cWPGWnrriedozY4JdRyFLlZTNcdCZYzusIMyZh8wpBGVpzUbhataD3E8zE/LmsD4VW
	 GzLGuVmLORgjg==
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
Subject: [PATCH v3 1/2] x86/fpu: Replace in_kernel_fpu with kernel_fpu_allowed
Date: Tue, 20 May 2025 08:29:37 -0700
Message-ID: <20250520152938.21881-2-ebiggers@kernel.org>
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

Replace the per-CPU bool in_kernel_fpu with kernel_fpu_allowed which
carries the opposite meaning.  Initialize to true instead of false.  No
functional change.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/kernel/fpu/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 948b4f5fad99c..6495259a23962 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -43,11 +43,11 @@ struct fpu_state_config fpu_user_cfg __ro_after_init;
  * depending on the FPU hardware format:
  */
 struct fpstate init_fpstate __ro_after_init;
 
 /* Track in-kernel FPU usage */
-static DEFINE_PER_CPU(bool, in_kernel_fpu);
+static DEFINE_PER_CPU(bool, kernel_fpu_allowed) = true;
 
 /*
  * Track which context is using the FPU on the CPU:
  */
 DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
@@ -75,11 +75,11 @@ bool irq_fpu_usable(void)
 	 * In kernel FPU usage already active?  This detects any explicitly
 	 * nested usage in task or softirq context, which is unsupported.  It
 	 * also detects attempted usage in a hardirq that has interrupted a
 	 * kernel-mode FPU section.
 	 */
-	if (this_cpu_read(in_kernel_fpu)) {
+	if (!this_cpu_read(kernel_fpu_allowed)) {
 		WARN_ON_FPU(!in_hardirq());
 		return false;
 	}
 
 	/*
@@ -437,13 +437,14 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
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
@@ -459,13 +460,14 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
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
 
-- 
2.49.0


