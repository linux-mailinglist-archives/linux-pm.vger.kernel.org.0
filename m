Return-Path: <linux-pm+bounces-25686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37263A93353
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 09:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF84C189A0A7
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 07:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105A626B949;
	Fri, 18 Apr 2025 07:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hf5N3Gcr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F6F2116E0;
	Fri, 18 Apr 2025 07:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744960486; cv=none; b=YjNJBfZjmiUOLaKoa10tv60/8Mj7lo5AGJiRFksgLnyr6QN+OPtXSdz7mkFDTEE/gPwHZOwTjSaxgwTwmexhd2WpAwmw82txE/IfRkdESggX+owZf794ppNgUb8TSF62wN7DP5x6uv4Mx+Spwjanv2iejw6eznCjz/4wzGC0wbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744960486; c=relaxed/simple;
	bh=613zIT3r1MuwyAZHMZ/p8NB/oqBG0AzIpV7oiIhvj4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkPgg9X+F0NzQaBrmJ1sOwML3xzgaF9LaK4viumW+5D0lWsJqsPUpLhzYQFieGVoVZqmdWQ50MsWa9pfSsqmBfV3b8G/qkZiMUV0u6xeaJrKbhI2ss/zzNjZcflkhKZP0RPAWyz3PAOO5DQ1gfcsRZH+10LazAc2m0mXCtfh2Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hf5N3Gcr; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so2739404a12.2;
        Fri, 18 Apr 2025 00:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744960483; x=1745565283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFx34+qBm/59SvTL7iTt7bIIp4e1pGYsUrJXj+WCcsk=;
        b=Hf5N3GcrQkNa6cA6P1HuSyZCL1IvGkvyN7x5kVo+9pGzH6uPXka4FoHEpLPgxqmixI
         PM8JxkeSIN789lvtCr+Ph431XR1cqidxLwLR2cfIAOAsG96sWnvEsCfo0y2cvIpyzpWz
         I6HO9reLwr2Kdrm9hIySMhvgwlXvwXuMmkmlVEbSY94G+1vqhE0Li3eiU9Mj02ZdY4Mw
         iBcESxe5Dy9UfHsQzUZ4DfmvYNM5Pzs7b/2qVdga0IKdbiIk0drsYjpYywK1xzXMm4ei
         DSh0p0WXSlqZ+jgLbRbK9MmwH9IklyaaoerSoeRUpI3a25msjmVHPiot2do/uJlTea8q
         RquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744960483; x=1745565283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFx34+qBm/59SvTL7iTt7bIIp4e1pGYsUrJXj+WCcsk=;
        b=QmCLqllaiZ+UYlVzG0c+hbAgGLGdHmWgjj/eji1RWQ4JvLiu+hn5Uwcn2vmFAlB4sR
         ojhK9Kg5KXPT4TB29ZnFRKQVTbaSSEJlVi8Vlj71C93eBUddFmTsp/GEvPpGwr5ZNrtl
         fm6MPm+i9NOrc6GXrAHuS87wfNwc7SvZm35y9OdkcUNqhIW6KEjcxikPDTpiVAqp9gWQ
         exLCPMJHukdZedWC6Puh8Z8TBTuxWsQ4bdmvVXaHz7v8AkiKTuLFJsBa96To3Mhlg5Rd
         PLtq9Fgan54DZwhBEEjHcMO4GkWfkr4rorG8weCPaswNPRJkyC94Xd1INdwwP/QpSQuh
         n+/w==
X-Forwarded-Encrypted: i=1; AJvYcCVqR0JbAEtyiJGOMU+GZGN9SwxyvAVh0Mhp4gPIIFJaGnPnCg0qVMKgtZ5i1Lzq9lQU7fnheLVgbulSn1I=@vger.kernel.org, AJvYcCXNNKwzlTN83MpMsL3qkAR63c1jahYxRteytIdR4Gky29zUFsV9P8SjSEKyowleTRWaNIWJY72OFtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC5q988EqS3B4aGv4NqdLliUtM07gYgd9n1w+MBXPH8rgXuuXF
	/i/7b8FRHtYd5IhC/YnTrDP6jj7uz7Sx9EMBZaHShnmCvXHgeWti
X-Gm-Gg: ASbGnct5g22hX3F0u7aqb2qaG3YB82tQwbg4Fjo1vbxF2JaBGs2tLL8YdljZ+sd0Ozl
	hO5tPkwReGWVafkHJVC9Qxj3HoOTcILVEa7IQnvEtcbVS5sk/PAHAMes378lT+y3ChFqz4xXwbP
	SQgF7X4+H9JpVsXxS8SfY5hP0z8sAVIzBRJBPW+29gI3VjHJ9QI1p8iwVMWCoIMws6w91Nrlhzo
	CL06eJEIWZdJAJS/YBfoW7tPJG2zCWyn794wCHxGQJkDMqI9vBkFXYH+Bx3LPI86a9HX+YGR+eB
	6H++eRzL1vmA8IzSrbZhidw4fmXBefC5
X-Google-Smtp-Source: AGHT+IHyAv8ZFczf4w8OHn4dFYovzMpxaqvgJ/r0oLf6fENeJLUuhc5Zqo8P/+9SL6uhW52HFgUZ7w==
X-Received: by 2002:a17:907:6e8a:b0:aca:d4f0:2b9f with SMTP id a640c23a62f3a-acb74ad8451mr124874066b.10.1744960482716;
        Fri, 18 Apr 2025 00:14:42 -0700 (PDT)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f625a5ec5bsm667619a12.81.2025.04.18.00.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 00:14:42 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-video@atrey.karlin.mff.cuni.cz,
	xen-devel@lists.xenproject.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Subject: [PATCH -tip v2 2/2] x86/asm: Remove semicolon from "rep" prefixes
Date: Fri, 18 Apr 2025 09:13:51 +0200
Message-ID: <20250418071437.4144391-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418071437.4144391-1-ubizjak@gmail.com>
References: <20250418071437.4144391-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Minimum version of binutils required to compile the kernel is 2.25.
This version correctly handles the "rep" prefixes, so it is possible
to remove the semicolon, which was used to support ancient versions
of GNU as.

Due to the semicolon, the compiler considers "rep; insn" (or its
alternate "rep\n\tinsn" form) as two separate instructions. Removing
the semicolon makes asm length calculations more accurate, consequently
making scheduling and inlining decisions of the compiler more accurate.

Removing the semicolon also enables assembler checks involving "rep"
prefixes. Trying to assemble e.g. "rep addl %eax, %ebx" results in:

  Error: invalid instruction `add' after `rep'

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>
---
v2: Split the patch from the previous version.
---
 arch/x86/include/asm/io.h            |  6 +++---
 arch/x86/include/asm/string_32.h     | 15 ++++++---------
 arch/x86/kernel/head_32.S            |  8 +++-----
 arch/x86/kernel/relocate_kernel_32.S |  6 +++---
 arch/x86/kernel/relocate_kernel_64.S |  6 +++---
 arch/x86/lib/iomem.c                 |  2 +-
 arch/x86/lib/string_32.c             | 17 ++++++-----------
 arch/x86/lib/strstr_32.c             |  6 ++----
 arch/x86/lib/usercopy_32.c           | 18 +++++++++---------
 arch/x86/platform/pvh/head.S         |  3 +--
 arch/x86/power/hibernate_asm_32.S    |  3 +--
 arch/x86/power/hibernate_asm_64.S    |  3 +--
 12 files changed, 39 insertions(+), 54 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index e889c3bab5a2..ca309a3227c7 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -217,7 +217,7 @@ void memset_io(volatile void __iomem *, int, size_t);
 static inline void __iowrite32_copy(void __iomem *to, const void *from,
 				    size_t count)
 {
-	asm volatile("rep ; movsl"
+	asm volatile("rep movsl"
 		     : "=&c"(count), "=&D"(to), "=&S"(from)
 		     : "0"(count), "1"(to), "2"(from)
 		     : "memory");
@@ -282,7 +282,7 @@ static inline void outs##bwl(u16 port, const void *addr, unsigned long count) \
 			count--;					\
 		}							\
 	} else {							\
-		asm volatile("rep; outs" #bwl				\
+		asm volatile("rep outs" #bwl				\
 			     : "+S"(addr), "+c"(count)			\
 			     : "d"(port) : "memory");			\
 	}								\
@@ -298,7 +298,7 @@ static inline void ins##bwl(u16 port, void *addr, unsigned long count)	\
 			count--;					\
 		}							\
 	} else {							\
-		asm volatile("rep; ins" #bwl				\
+		asm volatile("rep ins" #bwl				\
 			     : "+D"(addr), "+c"(count)			\
 			     : "d"(port) : "memory");			\
 	}								\
diff --git a/arch/x86/include/asm/string_32.h b/arch/x86/include/asm/string_32.h
index 32c0d981a82a..e9cce169bb4c 100644
--- a/arch/x86/include/asm/string_32.h
+++ b/arch/x86/include/asm/string_32.h
@@ -33,11 +33,11 @@ extern size_t strlen(const char *s);
 static __always_inline void *__memcpy(void *to, const void *from, size_t n)
 {
 	int d0, d1, d2;
-	asm volatile("rep ; movsl\n\t"
+	asm volatile("rep movsl\n\t"
 		     "movl %4,%%ecx\n\t"
 		     "andl $3,%%ecx\n\t"
 		     "jz 1f\n\t"
-		     "rep ; movsb\n\t"
+		     "rep movsb\n\t"
 		     "1:"
 		     : "=&c" (d0), "=&D" (d1), "=&S" (d2)
 		     : "0" (n / 4), "g" (n), "1" ((long)to), "2" ((long)from)
@@ -89,7 +89,7 @@ static __always_inline void *__constant_memcpy(void *to, const void *from,
 	if (n >= 5 * 4) {
 		/* large block: use rep prefix */
 		int ecx;
-		asm volatile("rep ; movsl"
+		asm volatile("rep movsl"
 			     : "=&c" (ecx), "=&D" (edi), "=&S" (esi)
 			     : "0" (n / 4), "1" (edi), "2" (esi)
 			     : "memory"
@@ -165,8 +165,7 @@ extern void *memchr(const void *cs, int c, size_t count);
 static inline void *__memset_generic(void *s, char c, size_t count)
 {
 	int d0, d1;
-	asm volatile("rep\n\t"
-		     "stosb"
+	asm volatile("rep stosb"
 		     : "=&c" (d0), "=&D" (d1)
 		     : "a" (c), "1" (s), "0" (count)
 		     : "memory");
@@ -199,8 +198,7 @@ extern void *memset(void *, int, size_t);
 static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
 {
 	int d0, d1;
-	asm volatile("rep\n\t"
-		     "stosw"
+	asm volatile("rep stosw"
 		     : "=&c" (d0), "=&D" (d1)
 		     : "a" (v), "1" (s), "0" (n)
 		     : "memory");
@@ -211,8 +209,7 @@ static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
 static inline void *memset32(uint32_t *s, uint32_t v, size_t n)
 {
 	int d0, d1;
-	asm volatile("rep\n\t"
-		     "stosl"
+	asm volatile("rep stosl"
 		     : "=&c" (d0), "=&D" (d1)
 		     : "a" (v), "1" (s), "0" (n)
 		     : "memory");
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 2e42056d2306..76743dfad6ab 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -86,7 +86,7 @@ SYM_CODE_START(startup_32)
 	movl $pa(__bss_stop),%ecx
 	subl %edi,%ecx
 	shrl $2,%ecx
-	rep ; stosl
+	rep stosl
 /*
  * Copy bootup parameters out of the way.
  * Note: %esi still has the pointer to the real-mode data.
@@ -98,15 +98,13 @@ SYM_CODE_START(startup_32)
 	movl $pa(boot_params),%edi
 	movl $(PARAM_SIZE/4),%ecx
 	cld
-	rep
-	movsl
+	rep movsl
 	movl pa(boot_params) + NEW_CL_POINTER,%esi
 	andl %esi,%esi
 	jz 1f			# No command line
 	movl $pa(boot_command_line),%edi
 	movl $(COMMAND_LINE_SIZE/4),%ecx
-	rep
-	movsl
+	rep movsl
 1:
 
 #ifdef CONFIG_OLPC
diff --git a/arch/x86/kernel/relocate_kernel_32.S b/arch/x86/kernel/relocate_kernel_32.S
index c7c4b1917336..57276f134d12 100644
--- a/arch/x86/kernel/relocate_kernel_32.S
+++ b/arch/x86/kernel/relocate_kernel_32.S
@@ -263,17 +263,17 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 
 	movl	%edx, %edi
 	movl    $1024, %ecx
-	rep ; movsl
+	rep movsl
 
 	movl	%ebp, %edi
 	movl	%eax, %esi
 	movl	$1024, %ecx
-	rep ; movsl
+	rep movsl
 
 	movl	%eax, %edi
 	movl	%edx, %esi
 	movl	$1024, %ecx
-	rep ; movsl
+	rep movsl
 
 	lea	PAGE_SIZE(%ebp), %esi
 	jmp     0b
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 3062cb3efc44..1d6355227bf6 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -363,20 +363,20 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	/* copy source page to swap page */
 	movq	kexec_pa_swap_page(%rip), %rdi
 	movl	$512, %ecx
-	rep ; movsq
+	rep movsq
 
 	/* copy destination page to source page */
 	movq	%rax, %rdi
 	movq	%rdx, %rsi
 	movl	$512, %ecx
-	rep ; movsq
+	rep movsq
 
 	/* copy swap page to destination page */
 	movq	%rdx, %rdi
 	movq	kexec_pa_swap_page(%rip), %rsi
 .Lnoswap:
 	movl	$512, %ecx
-	rep ; movsq
+	rep movsq
 
 	lea	PAGE_SIZE(%rax), %rsi
 	jmp	.Lloop
diff --git a/arch/x86/lib/iomem.c b/arch/x86/lib/iomem.c
index 5eecb45d05d5..c20e04764edc 100644
--- a/arch/x86/lib/iomem.c
+++ b/arch/x86/lib/iomem.c
@@ -10,7 +10,7 @@
 static __always_inline void rep_movs(void *to, const void *from, size_t n)
 {
 	unsigned long d0, d1, d2;
-	asm volatile("rep ; movsl\n\t"
+	asm volatile("rep movsl\n\t"
 		     "testb $2,%b4\n\t"
 		     "je 1f\n\t"
 		     "movsw\n"
diff --git a/arch/x86/lib/string_32.c b/arch/x86/lib/string_32.c
index 53b3f202267c..f87ec24fa579 100644
--- a/arch/x86/lib/string_32.c
+++ b/arch/x86/lib/string_32.c
@@ -40,8 +40,7 @@ char *strncpy(char *dest, const char *src, size_t count)
 		"stosb\n\t"
 		"testb %%al,%%al\n\t"
 		"jne 1b\n\t"
-		"rep\n\t"
-		"stosb\n"
+		"rep stosb\n"
 		"2:"
 		: "=&S" (d0), "=&D" (d1), "=&c" (d2), "=&a" (d3)
 		: "0" (src), "1" (dest), "2" (count) : "memory");
@@ -54,8 +53,7 @@ EXPORT_SYMBOL(strncpy);
 char *strcat(char *dest, const char *src)
 {
 	int d0, d1, d2, d3;
-	asm volatile("repne\n\t"
-		"scasb\n\t"
+	asm volatile("repne scasb\n\t"
 		"decl %1\n"
 		"1:\tlodsb\n\t"
 		"stosb\n\t"
@@ -72,8 +70,7 @@ EXPORT_SYMBOL(strcat);
 char *strncat(char *dest, const char *src, size_t count)
 {
 	int d0, d1, d2, d3;
-	asm volatile("repne\n\t"
-		"scasb\n\t"
+	asm volatile("repne scasb\n\t"
 		"decl %1\n\t"
 		"movl %8,%3\n"
 		"1:\tdecl %3\n\t"
@@ -167,8 +164,7 @@ size_t strlen(const char *s)
 {
 	int d0;
 	size_t res;
-	asm volatile("repne\n\t"
-		"scasb"
+	asm volatile("repne scasb"
 		: "=c" (res), "=&D" (d0)
 		: "1" (s), "a" (0), "0" (0xffffffffu)
 		: "memory");
@@ -184,8 +180,7 @@ void *memchr(const void *cs, int c, size_t count)
 	void *res;
 	if (!count)
 		return NULL;
-	asm volatile("repne\n\t"
-		"scasb\n\t"
+	asm volatile("repne scasb\n\t"
 		"je 1f\n\t"
 		"movl $1,%0\n"
 		"1:\tdecl %0"
@@ -202,7 +197,7 @@ void *memscan(void *addr, int c, size_t size)
 {
 	if (!size)
 		return addr;
-	asm volatile("repnz; scasb\n\t"
+	asm volatile("repnz scasb\n\t"
 	    "jnz 1f\n\t"
 	    "dec %%edi\n"
 	    "1:"
diff --git a/arch/x86/lib/strstr_32.c b/arch/x86/lib/strstr_32.c
index 38f37df056f7..28267985e85f 100644
--- a/arch/x86/lib/strstr_32.c
+++ b/arch/x86/lib/strstr_32.c
@@ -8,16 +8,14 @@ int	d0, d1;
 register char *__res;
 __asm__ __volatile__(
 	"movl %6,%%edi\n\t"
-	"repne\n\t"
-	"scasb\n\t"
+	"repne scasb\n\t"
 	"notl %%ecx\n\t"
 	"decl %%ecx\n\t"	/* NOTE! This also sets Z if searchstring='' */
 	"movl %%ecx,%%edx\n"
 	"1:\tmovl %6,%%edi\n\t"
 	"movl %%esi,%%eax\n\t"
 	"movl %%edx,%%ecx\n\t"
-	"repe\n\t"
-	"cmpsb\n\t"
+	"repe cmpsb\n\t"
 	"je 2f\n\t"		/* also works for empty string, see above */
 	"xchgl %%eax,%%esi\n\t"
 	"incl %%esi\n\t"
diff --git a/arch/x86/lib/usercopy_32.c b/arch/x86/lib/usercopy_32.c
index 422257c350c6..f6f436f1d573 100644
--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -38,9 +38,9 @@ do {									\
 	might_fault();							\
 	__asm__ __volatile__(						\
 		ASM_STAC "\n"						\
-		"0:	rep; stosl\n"					\
+		"0:	rep stosl\n"					\
 		"	movl %2,%0\n"					\
-		"1:	rep; stosb\n"					\
+		"1:	rep stosb\n"					\
 		"2: " ASM_CLAC "\n"					\
 		_ASM_EXTABLE_TYPE_REG(0b, 2b, EX_TYPE_UCOPY_LEN4, %2)	\
 		_ASM_EXTABLE_UA(1b, 2b)					\
@@ -140,9 +140,9 @@ __copy_user_intel(void __user *to, const void *from, unsigned long size)
 		       "       shrl  $2, %0\n"
 		       "       andl  $3, %%eax\n"
 		       "       cld\n"
-		       "99:    rep; movsl\n"
+		       "99:    rep movsl\n"
 		       "36:    movl %%eax, %0\n"
-		       "37:    rep; movsb\n"
+		       "37:    rep movsb\n"
 		       "100:\n"
 		       _ASM_EXTABLE_UA(1b, 100b)
 		       _ASM_EXTABLE_UA(2b, 100b)
@@ -242,9 +242,9 @@ static unsigned long __copy_user_intel_nocache(void *to,
 	       "        shrl  $2, %0\n"
 	       "        andl $3, %%eax\n"
 	       "        cld\n"
-	       "6:      rep; movsl\n"
+	       "6:      rep movsl\n"
 	       "        movl %%eax,%0\n"
-	       "7:      rep; movsb\n"
+	       "7:      rep movsb\n"
 	       "8:\n"
 	       _ASM_EXTABLE_UA(0b, 8b)
 	       _ASM_EXTABLE_UA(1b, 8b)
@@ -293,14 +293,14 @@ do {									\
 		"	negl %0\n"					\
 		"	andl $7,%0\n"					\
 		"	subl %0,%3\n"					\
-		"4:	rep; movsb\n"					\
+		"4:	rep movsb\n"					\
 		"	movl %3,%0\n"					\
 		"	shrl $2,%0\n"					\
 		"	andl $3,%3\n"					\
 		"	.align 2,0x90\n"				\
-		"0:	rep; movsl\n"					\
+		"0:	rep movsl\n"					\
 		"	movl %3,%0\n"					\
-		"1:	rep; movsb\n"					\
+		"1:	rep movsb\n"					\
 		"2:\n"							\
 		_ASM_EXTABLE_TYPE_REG(4b, 2b, EX_TYPE_UCOPY_LEN1, %3)	\
 		_ASM_EXTABLE_TYPE_REG(0b, 2b, EX_TYPE_UCOPY_LEN4, %3)	\
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index cfa18ec7d55f..1d78e5631bb8 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -87,8 +87,7 @@ SYM_CODE_START(pvh_start_xen)
 	mov %ebx, %esi
 	movl rva(pvh_start_info_sz)(%ebp), %ecx
 	shr $2,%ecx
-	rep
-	movsl
+	rep movsl
 
 	leal rva(early_stack_end)(%ebp), %esp
 
diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index 5606a15cf9a1..fb910d9f8471 100644
--- a/arch/x86/power/hibernate_asm_32.S
+++ b/arch/x86/power/hibernate_asm_32.S
@@ -69,8 +69,7 @@ copy_loop:
 	movl	pbe_orig_address(%edx), %edi
 
 	movl	$(PAGE_SIZE >> 2), %ecx
-	rep
-	movsl
+	rep movsl
 
 	movl	pbe_next(%edx), %edx
 	jmp	copy_loop
diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index 66f066b8feda..c73be0a02a6c 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -138,8 +138,7 @@ SYM_FUNC_START(core_restore_code)
 	movq	pbe_address(%rdx), %rsi
 	movq	pbe_orig_address(%rdx), %rdi
 	movq	$(PAGE_SIZE >> 3), %rcx
-	rep
-	movsq
+	rep movsq
 
 	/* progress to the next pbe */
 	movq	pbe_next(%rdx), %rdx
-- 
2.49.0


