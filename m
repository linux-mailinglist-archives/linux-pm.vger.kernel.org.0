Return-Path: <linux-pm+bounces-27254-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95319ABA674
	for <lists+linux-pm@lfdr.de>; Sat, 17 May 2025 01:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B224E74D6
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 23:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334FC27814F;
	Fri, 16 May 2025 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obsMl2Qj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078BC22DA15;
	Fri, 16 May 2025 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747437701; cv=none; b=OEwNcswIhwiM+7ac3mi/vXfnnSvxbS2nh5ipeTwcBTM91/D/cGle2VznF6kzDm8YUbk3ZsmJNjGgjIy4u+QFatbZbHzuYCsf0prXD6T01739ES48KfX8g0T9nd4HHbqUF9OuyTX7rkG7aUchZT7vLerCXynVMm/imR2kT46QIvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747437701; c=relaxed/simple;
	bh=OwRlj0tM+iP/0crW1PSRzlCFDkAFzLKKS3A/BV9mA2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jtblw81xeFaOpVnM1Ho3JPSvbX8YFoM4Z4DWgkS+iTXZ+f1g5J7bCAAW47K3O09KfhxUXjQFFDnVWKcwjIAVDqEwFfsQgqPIH+aswuVfeJ0PubpFpFcelNhzvgjT+6gDHTUbKz9xnsya2A4Iijt+o12joz+z+eh6KVIVblEt3hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obsMl2Qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFECC4AF0B;
	Fri, 16 May 2025 23:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747437700;
	bh=OwRlj0tM+iP/0crW1PSRzlCFDkAFzLKKS3A/BV9mA2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=obsMl2Qj/M0jALKhFX8su33JKI/fDILbHUAKFbgBNwOXicOKeOUSukI71e3Xn8x3U
	 zobV0ZMt9YtTApbmnAGXvlblFbdTcVpXUAw1yuc5z/4YO53g/WNrwrjK6EnRSxi4Xc
	 eyZIzFVdY0IxzIhP89CXPmkWR90EBmhMULqJVjEDELOJDvdCdOgHtTDfbyhq+45Hir
	 dKEQIG2U+hHyl4985BUe3Nu5PlJcEA/oXIQ4OXiFynFoObxI9AKa2Hnd9xKSLIDxHl
	 HP7oI+TNxanGWdVKRJvmFHXhYYri4WzG5pAzHv69fZoS7dyP4l+d6A6vbUwDd+HEKi
	 1uobTrZiUx7QA==
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
Subject: [PATCH 2/3] x86/pm: Use fpu_save_state() in __save_processor_state()
Date: Fri, 16 May 2025 16:18:57 -0700
Message-ID: <20250516231858.27899-3-ebiggers@kernel.org>
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

Make __save_processor_state() use fpu_save_state() instead of a
kernel_fpu_begin() and kernel_fpu_end() pair.  This matches more
directly what it needs.  This eliminates the need for kernel_fpu_begin()
and kernel_fpu_end() to support the irqs_disabled() case.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/power/cpu.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 916441f5e85ce..dde4ccbc77f4b 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -81,11 +81,17 @@ static void msr_restore_context(struct saved_context *ctxt)
 static void __save_processor_state(struct saved_context *ctxt)
 {
 #ifdef CONFIG_X86_32
 	mtrr_save_fixed_ranges(NULL);
 #endif
-	kernel_fpu_begin();
+
+	/*
+	 * The FPU registers may be live for the current task, so save them to
+	 * current's memory register state.  The corresponding restore happens
+	 * lazily when returning to userspace, not in restore_processor_state().
+	 */
+	fpu_save_state();
 
 	/*
 	 * descriptor tables
 	 */
 	store_idt(&ctxt->idt);
@@ -99,11 +105,10 @@ static void __save_processor_state(struct saved_context *ctxt)
 	ctxt->gdt_desc.size = GDT_SIZE - 1;
 	ctxt->gdt_desc.address = (unsigned long)get_cpu_gdt_rw(smp_processor_id());
 
 	store_tr(ctxt->tr);
 
-	/* XMM0..XMM15 should be handled by kernel_fpu_begin(). */
 	/*
 	 * segment registers
 	 */
 	savesegment(gs, ctxt->gs);
 #ifdef CONFIG_X86_64
@@ -139,18 +144,10 @@ void save_processor_state(void)
 }
 #ifdef CONFIG_X86_32
 EXPORT_SYMBOL(save_processor_state);
 #endif
 
-static void do_fpu_end(void)
-{
-	/*
-	 * Restore FPU regs if necessary.
-	 */
-	kernel_fpu_end();
-}
-
 static void fix_processor_context(void)
 {
 	int cpu = smp_processor_id();
 #ifdef CONFIG_X86_64
 	struct desc_struct *desc = get_cpu_gdt_rw(cpu);
@@ -272,11 +269,10 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	wrmsrq(MSR_KERNEL_GS_BASE, ctxt->usermode_gs_base);
 #else
 	loadsegment(gs, ctxt->gs);
 #endif
 
-	do_fpu_end();
 	tsc_verify_tsc_adjust(true);
 	x86_platform.restore_sched_clock_state();
 	cache_bp_restore();
 	perf_restore_debug_store();
 
-- 
2.49.0


