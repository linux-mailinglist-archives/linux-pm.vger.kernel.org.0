Return-Path: <linux-pm+bounces-14700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887E19862A1
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 17:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5C01C2706E
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 15:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4585618EFC9;
	Wed, 25 Sep 2024 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CjZEe0yN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C178218CC1A
	for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2024 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276542; cv=none; b=LiJQVJ1uIhnwKnnVs1iykztY8Nx37HgJP6JicOTy1qjb4XMPQ6QMIgRq9FBppLdggzd7scDTBZcDCaJ7AmQl4E7DCuOidmX62x1NQPS/2C0LhzhmAqZ4pRo0eAGYJzFtams3rAvYBegZ7bX19aZaFgaSmtty2qsXVpz1tzW+Q9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276542; c=relaxed/simple;
	bh=JTcZMRf52oQJjvsrQbaaa26wNEschMPTichZxc3ZyTY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GWYSI81T3kze4m/VSBBj1TIPDMRmkhtrwTYupogMtOeZ9ulMVNzkF7rmN6vxBGFC+QkTzU1al513dITKbBkmLvo31CQS823UBbH8OU9iyi3DXXI5VJ82QBqo4w/9eVLtcsc42+PTGN0jH2nQ8ruNIYT5XctI83TGOVIAlvFO48Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CjZEe0yN; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d9e31e66eeso111472707b3.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2024 08:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276538; x=1727881338; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WebA59vxPkU4u7rhQajyH4BvEeqGZRhskbQXw1lowfs=;
        b=CjZEe0yNT4EA/GcKFh/6Jssm8m05B25tkcW0KFhhtewe6SRdV2pEBLGa8yx/CpnYXJ
         MfntbYWoR1EhxjADX4+aOngkHAyjORnocT0BwOjgiFWm6L9HcXyB25UtRC5WVEKXYQ8/
         OBJp+RzevUhpU5cFWOu9jzr/vhzsqrDj6GDAUkaYRak0E/z6D3Yf/fm8f5JZrtMWcMnl
         N2qyh7vfxeYL30RgFZtnhXpuFyZSZTj5isYZ0+Nn1pn+I+DNbcSSB5DAZw7YyVlBXAoM
         1qDDv2bg/JAR0EqiibTG7Li9wPtqRa1ga4t+tABXo/xjQIYYy2wNNwNCHH8jY+xfdOcT
         OWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276538; x=1727881338;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WebA59vxPkU4u7rhQajyH4BvEeqGZRhskbQXw1lowfs=;
        b=ex3tftR3z/BzGiCw7jkpwz6Nh3V19pW6Suu0lPH2iMzS7n1nrFA8OlhdT0xa2PC7fs
         eRcIN1vLWW3LJchaNnWhExDAwBRBghrMXMK+cSKuH30J6NTbtxXsDvbQAz4KtJ4d3sIn
         DvkKUMdolO2J+AtXwO8ak/g9UXRsSPG8VHhXmJ/hgaB+dgetSzJLQBVdjQgFVM4XVBkc
         bJQI42bl4wlg9i6y+nG9Lgs04c2TqxuTF11UTHjrpH+JAZmrYrUK5hZzrj9wVqahx/KN
         KdAWdELtfz1s2S+bTZqvkUnfbHZ9VcvGvhoGsIynwlcrNLYpbm9uqbO9HpPyUT0ciqge
         g1QA==
X-Forwarded-Encrypted: i=1; AJvYcCUIPZX+5fdymSD8Ir3YNzcofFmVLstvy7IgxB5KcpQ9yL3PAAKBuhkkJ3RKp0pdnQusEiZ1qxyuFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOV+7zt46ag/FLMkz1wu44JH43AhKc6KwSjwS4lAZd1oDU/ZVl
	ILqf9TraGUhyohTbsRDJ1Nn8LCnv9E6r+nDJ2jHPGavkqmiLCj/cJrxqvRo+uiQYt5Uu1A==
X-Google-Smtp-Source: AGHT+IG1eaRHJ+k+oWi0MEewfWnHRvzWiyuPrZa2XUixnuMGDlz9gyzzCn4pjg7USYksDYWFG76nQbXB
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a81:7c46:0:b0:673:b39a:92ce with SMTP id
 00721157ae682-6e21da5ea7bmr151347b3.3.1727276537527; Wed, 25 Sep 2024
 08:02:17 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:11 +0200
In-Reply-To: <20240925150059.3955569-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3674; i=ardb@kernel.org;
 h=from:subject; bh=R6ohiPGa3ul2ikQd2A7YE6wpEPvXq0bd6W2LGMrzZ/k=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2L6m4L/Wkc7n0aPQzsYULiEQZPMlgefsmsLHv4K8KPe
 c6T1d0dpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCLF8YwMhwNCO7WWnu4+bHJ/
 R+KN+e/7+Z5GTZy4J83mRy0Xx+UbAowMLwuTAsXUc+SfqAVdK+gtnHdHT+jRjZtrv3D/ms77oD2 BCwA=
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925150059.3955569-41-ardb+git@google.com>
Subject: [RFC PATCH 11/28] x86/pvh: Avoid absolute symbol references in .head.text
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The .head.text section contains code that may execute from a different
address than it was linked at. This is fragile, given that the x86 ABI
can refer to global symbols via absolute or relative references, and the
toolchain assumes that these are interchangeable, which they are not in
this particular case.

In the case of the PVH code, there are some additional complications:
- the absolute references are in 32-bit code, which get emitted with
  R_X86_64_32 relocations, and these are not permitted in PIE code;
- the code in question is not actually relocatable: it can only run
  correctly from the physical load address specified in the ELF note.

So rewrite the code to only rely on relative symbol references: these
are always 32-bits wide, even in 64-bit code, and are resolved by the
linker at build time.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/pvh/head.S | 39 ++++++++++++++------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index adbf57e83e4e..e6cb7da40e09 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -54,7 +54,20 @@ SYM_CODE_START(pvh_start_xen)
 	UNWIND_HINT_END_OF_STACK
 	cld
 
-	lgdt (_pa(gdt))
+	/*
+	 * This is position dependent code that can only execute correctly from
+	 * the physical address that the kernel was linked to run at. Use the
+	 * symbols emitted for the ELF note to construct the build time physical
+	 * address of pvh_start_xen(), without relying on absolute 32-bit ELF
+	 * relocations, as these are not supported by the linker when running in
+	 * -pie mode, and should be avoided in .head.text in general.
+	 */
+0:	mov $xen_elfnote_phys32_entry_offset - 0b, %ebp
+	sub $xen_elfnote_phys32_entry - 0b, %ebp
+
+	lea (gdt - pvh_start_xen)(%ebp), %eax
+	add %eax, 2(%eax)
+	lgdt (%eax)
 
 	mov $PVH_DS_SEL,%eax
 	mov %eax,%ds
@@ -62,14 +75,14 @@ SYM_CODE_START(pvh_start_xen)
 	mov %eax,%ss
 
 	/* Stash hvm_start_info. */
-	mov $_pa(pvh_start_info), %edi
+	lea (pvh_start_info - pvh_start_xen)(%ebp), %edi
 	mov %ebx, %esi
-	mov _pa(pvh_start_info_sz), %ecx
+	mov (pvh_start_info_sz - pvh_start_xen)(%ebp), %ecx
 	shr $2,%ecx
 	rep
 	movsl
 
-	mov $_pa(early_stack_end), %esp
+	lea (early_stack_end - pvh_start_xen)(%ebp), %esp
 
 	/* Enable PAE mode. */
 	mov %cr4, %eax
@@ -84,17 +97,21 @@ SYM_CODE_START(pvh_start_xen)
 	wrmsr
 
 	/* Enable pre-constructed page tables. */
-	mov $_pa(init_top_pgt), %eax
+	lea (init_top_pgt - pvh_start_xen)(%ebp), %eax
 	mov %eax, %cr3
 	mov $(X86_CR0_PG | X86_CR0_PE), %eax
 	mov %eax, %cr0
 
 	/* Jump to 64-bit mode. */
-	ljmp $PVH_CS_SEL, $_pa(1f)
+	lea  (1f - pvh_start_xen)(%ebp), %eax
+	push $PVH_CS_SEL
+	push %eax
+	lret
 
 	/* 64-bit entry point. */
 	.code64
 1:
+	UNWIND_HINT_END_OF_STACK
 	/* Clear %gs so early per-CPU references target the per-CPU load area */
 	mov $MSR_GS_BASE,%ecx
 	xor %eax, %eax
@@ -108,10 +125,8 @@ SYM_CODE_START(pvh_start_xen)
 	call *%rax
 
 	/* startup_64 expects boot_params in %rsi. */
-	mov $_pa(pvh_bootparams), %rsi
-	mov $_pa(startup_64), %rax
-	ANNOTATE_RETPOLINE_SAFE
-	jmp *%rax
+	lea pvh_bootparams(%rip), %rsi
+	jmp startup_64
 
 #else /* CONFIG_X86_64 */
 
@@ -146,8 +161,8 @@ SYM_CODE_END(pvh_start_xen)
 	.section ".init.data","aw"
 	.balign 8
 SYM_DATA_START_LOCAL(gdt)
-	.word gdt_end - gdt_start
-	.long _pa(gdt_start)
+	.word gdt_end - gdt_start - 1
+	.long gdt_start - gdt
 	.word 0
 SYM_DATA_END(gdt)
 SYM_DATA_START_LOCAL(gdt_start)
-- 
2.46.0.792.g87dc391469-goog


