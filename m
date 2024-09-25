Return-Path: <linux-pm+bounces-14709-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F07EB986301
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 17:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F731F27BF0
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 15:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FBB193416;
	Wed, 25 Sep 2024 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IaC9jD8Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4944A192D93
	for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276564; cv=none; b=Rn+FlQhmmv8hOWb+4UjTDAby6wGrFNPXGtHlIM91aMfhydIb23r17RSv2BoYkS6MJnrbRbNTQ5CPOMVAHLNlnnyp1/F5/+62pXl8u6pG5Io2aX7Tvo7DOV//faMQB9QAnWOwT7G4E3B6RYbxNLGl1IoXoFGWBRH7pFSkznnadXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276564; c=relaxed/simple;
	bh=9UAQuGK2mWhKEqX7oxUH9zhtKGPJ6CK9xsJA2g/Xjq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WTYDU8lDpAbGUf1vsoQQwd260psBs5iSqMnYvY9tc+zwnLq6h8qohFnicuzhShPuBMNAWuaNiVzS2Fr+wdioxqLwCNOGwus4kDdizQlC9zwQS2QSLsyWnSSBjfzNie/OvvVi7IpmSdpCi9BgAMudKJQiGNVa9n2EmIf/YlvyQfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IaC9jD8Y; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e1fbe2a6b1so57005987b3.2
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2024 08:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276561; x=1727881361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FlbORA03gt7VD7U3AKlte04ifRsDRozPK1w/WollpSI=;
        b=IaC9jD8YpWlb+NCU9e67XCuo3kv2uwa1BPK7X8tClCdPocUNZWV6grI1ExqTONqDqc
         rmnlZCQt6Ck4GzQuASe+KiECDP/vsIVbr7TdzUY6cUov2xdnNCm/ELgFEcQWMQF4AUuO
         0RtMVJ+cCkyJDZVieNIZorPUcLLzjFi6L3e60UlQ6iUZyjBZmr2kjgN43hHKApZcvVKy
         rsT7wtMPICkxJ/4cdjBNppSp6ArQf5d6t8ncw+pysDbe5BiD6s63bnOlU9AA36XlUgD3
         PY9j1Fmf1ULtMhN80q32jriOG27+u8TcDn8OA4AB19vLWG0CpGNRuBiKrWMTaQP7ExCw
         EJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276561; x=1727881361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlbORA03gt7VD7U3AKlte04ifRsDRozPK1w/WollpSI=;
        b=AT60LHMtfPNZc4TEVHn/afcQQwW+VcKO/uj49eOc6S68gLqhsdME2wSKSMDZN7C4Ws
         sUK6PCnNZiQFhmqrNJf4ChcOJnDCymTVIgxo7pC4iquo4a/TUbIRyVg8EX6cCBs4LJ9O
         nO4uIAUBWTtFXaYWmFll5+cx8alNLqeYRoGjfXF6bu3ikPOPDfmPcoylXnw1uYhe/CI2
         K6h+cB2PUeHrAh+k8jXruJYaym2CdiPd8ghJxl+EbFFimF+eDef7eaY5/N2wk3lmluZr
         n505nt1hVKS6xhE709AtyO81fyYODVytHr1RZig5qDD4eB3WLzXHG+/6bZOk3hsTBptR
         qJjA==
X-Forwarded-Encrypted: i=1; AJvYcCUCGw//SYfSz7Sf0QYI3dMgIQtg11/mMzLpgGZTKJdQh30cOol8SR5Usa5LNQURnKOG5+71vb14hA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9axfKRqysLGB8tAzP/chdIRaTfCOSCoOZ4CAwViAiCJTsf2nU
	tvr+EGVLyLZCJxJBWwaj/Ocano440xcAcBA+yZRwoFZwMXB0LLLaISzHwd0oaJQmLFL1CQ==
X-Google-Smtp-Source: AGHT+IH4yCJxpgJpRghyt05ffZ0KMtbzY3622CltTm7OPK0ZYLkhBwwkH9bUzMfV7VeGOafl80KA41By
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:4289:b0:6e0:1ad:b197 with SMTP id
 00721157ae682-6e21d9eb35cmr74667b3.3.1727276561223; Wed, 25 Sep 2024 08:02:41
 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:20 +0200
In-Reply-To: <20240925150059.3955569-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2120; i=ardb@kernel.org;
 h=from:subject; bh=udZt3Ybebg1JaBid31YzntWp5JIa5pAk0HVUlAzZyZ0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2L6gljFsPIOfpfC+4mTz0SPOfTfNeM53artXe5vlz2r
 m2tZ4xiRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjI/0qG/z53N1inv844/EXP
 gLPr2aVVD8T/nDB5/WSxtlzL53WrfboZGX7d3NY04aKrkHqeft+Obu4DWbvCTcvYF6zT0yzuZn0 pwQAA
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925150059.3955569-50-ardb+git@google.com>
Subject: [RFC PATCH 20/28] x64/acpi: Use PIC-compatible references in wakeup_64.S
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

Use ordinary RIP-relative references to make the code compatible with
running the linker in PIE mode.

Note that wakeup_long64() runs in the kernel's ordinary virtual mapping
so there is no need to record the address of .Lresume_point in a global
variable. And fix the comment while at it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/acpi/wakeup_64.S | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 94ff83f3d3fe..af2f2ed57658 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -14,7 +14,7 @@
 
 .code64
 	/*
-	 * Hooray, we are in Long 64-bit mode (but still running in low memory)
+	 * Hooray, we are in Long 64-bit mode
 	 */
 SYM_FUNC_START(wakeup_long64)
 	movq	saved_magic(%rip), %rax
@@ -40,7 +40,7 @@ SYM_FUNC_START(wakeup_long64)
 	movq	saved_rsi(%rip), %rsi
 	movq	saved_rbp(%rip), %rbp
 
-	movq	saved_rip(%rip), %rax
+	leaq	.Lresume_point(%rip), %rax
 	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rax
 SYM_FUNC_END(wakeup_long64)
@@ -51,7 +51,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
 	xorl	%eax, %eax
 	call	save_processor_state
 
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	%rsp, pt_regs_sp(%rax)
 	movq	%rbp, pt_regs_bp(%rax)
 	movq	%rsi, pt_regs_si(%rax)
@@ -70,8 +70,6 @@ SYM_FUNC_START(do_suspend_lowlevel)
 	pushfq
 	popq	pt_regs_flags(%rax)
 
-	movq	$.Lresume_point, saved_rip(%rip)
-
 	movq	%rsp, saved_rsp(%rip)
 	movq	%rbp, saved_rbp(%rip)
 	movq	%rbx, saved_rbx(%rip)
@@ -88,7 +86,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
 	.align 4
 .Lresume_point:
 	/* We don't restore %rax, it must be 0 anyway */
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	saved_context_cr4(%rax), %rbx
 	movq	%rbx, %cr4
 	movq	saved_context_cr3(%rax), %rbx
@@ -137,7 +135,6 @@ saved_rsi:		.quad	0
 saved_rdi:		.quad	0
 saved_rbx:		.quad	0
 
-saved_rip:		.quad	0
 saved_rsp:		.quad	0
 
 SYM_DATA(saved_magic,	.quad	0)
-- 
2.46.0.792.g87dc391469-goog


