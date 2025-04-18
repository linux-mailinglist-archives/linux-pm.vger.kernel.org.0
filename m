Return-Path: <linux-pm+bounces-25685-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F70AA93350
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 09:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989A23A8816
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 07:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D3D26B0A0;
	Fri, 18 Apr 2025 07:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enaTwG6u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC0726AABC;
	Fri, 18 Apr 2025 07:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744960485; cv=none; b=i0RP8Qg44znxp22NDRfw5r/Qofpnc1fTneiLO3IK0GgUViFriPQZvn4WrS6wgz2iNwxoPKksNDD6IHsyG4Ye20VZMxxnNE3iRY6I8R/0k6K2wrwfUc6DVo+2yX41YQYbbM/jwI22K+WfgwOjMZg0Pexd20tclPoniKY9ab0JhOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744960485; c=relaxed/simple;
	bh=rCVrIgyyK4M7X55KalZ+8MLPNu0GbZkdqgEvw4Ee5DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fRfci8JXIdfscPL6mxI3LtYBkTzfxkd036Xn7nL1aXoh8YG6Hiubk4hvNPTDSfZy2AjwnQymFCmDkz1NNlac44zbjFnyMRhXyCb+iUn6kfIs6eSOoshzU+XPu+Tnw7CTjEJZq7bCzgcsISfxrG8X+K7pPLQ/VOxfSsY7MssAYo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enaTwG6u; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5eb92df4fcbso2926566a12.0;
        Fri, 18 Apr 2025 00:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744960482; x=1745565282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5woHMQeMVJnProeJ/6Cdzx+SnUrs7izAlab21WdVNXo=;
        b=enaTwG6u/aqKj3YNuaZE6B46uYmBBBWbHnKZGRuAmO+ANCizhrMTWv8RxQHZ+szuD1
         5eO4ZVcBGwswguBAsRFTCY9OlBLOaV0A8eUXSKm+t5jmjvZaNYsMI5gxnoNWiA3PvlXj
         x5xf5SMWbk7n3ccTEGGeXXBmhp95g8y8y0UVUm+lyiq7gsgfhRn0OUgU4lcvK8nx+wJM
         ujP3CZVoY0Oe7qVgCzYXzCSmCHvE3gLOo/OrxyKxYSMkHL/OV7MfQuByZQ/8pifUnnZ/
         yeTfjzqkt9jwbICoCBRyHKYaTnxHQYdOgw2cF+ItApL+dcz1qWxkR9sdv8Rnr6jv6iGg
         1h2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744960482; x=1745565282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5woHMQeMVJnProeJ/6Cdzx+SnUrs7izAlab21WdVNXo=;
        b=Qo3pweeMmapuBdKhyf/CFBm7i1lDXeBvYE7ajjJUoMiEjTnTEG/Ue09Saz9fSrzcG7
         efqbeI9WrsaFi4PhHz7EppGOPlA1+YafrWvQEQrvSqmo462+7N9iL2MXlckjMI0HfiCd
         lArCxUtlAff5M5t6qx7gPQx+wTW/dRNZQpAQhnugrOy5Khs0cx2jNGIZF3VMKcQQpr6E
         2agA8u/1dxu9p54O1QTWxM6SGCB8vyGwoPFbI9/rlPdHoPWW9quZ+r4sPf/syQ8cAISO
         O7+b2Cns5CLNlib34AigwkeT4+6UvnsWG7jc50X73Vz0l+LVBrTr0es+wNEITe8zK41t
         cn6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUG14//EqbDTpQVUUQfHYptnGtlbgLHyJm/o6y3Y9ihgb2FDL1PH6Xv6x9VBBO0j/V7RsePPDkgDxMv+dc=@vger.kernel.org, AJvYcCWlp17j6v3VXLQ1yrGuLdUof/F6a5LE0g9y/3d5hSrn8HyFewgz4Orw45CaLu7XsvEGf5HaGYpHTJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz10YTFSaMl6O1R7axlb68LBMtAF57bkifRWj2UgbIrD7ukCEbD
	PnG8xHre3FkC0dqnLG3KcYIdv8fn6C6HCDl9aM5X10lO8t+3cVuCLQH/+tBC
X-Gm-Gg: ASbGncuMDOgqM6E6cie1taKv/mdmc9fDzTMGuueaNb0rXFiVsI4yKDx+wewWs9JhXgh
	kHv7uNd7OngxuvHqvcbDBiq+prFpB2/atwrCvR6hi8d9872Fn0z5pJwoFm4a30CSScaN558pTvX
	TJNKet2REEPs2pBij4p51E1A4U387syB49ACyNr5L45QHCE1eGAPOz9yODYwjYs1G0v0A3Y497U
	hu8QyvVh6rG7JybIYraaqY2eWCz0WAYfxJ6xomXWJhBl6u1VS3Mu6M3sODK1SFGe2gokbisb6ym
	5aa8O0xhaz//1lcafnN/LWYiL0egb2Uzhvvr0zNGHy4=
X-Google-Smtp-Source: AGHT+IEMlcURDofq+umzsuPFLiss3QdLovTjMZcPPVHbY8ksiEyTxikdvtWBNS1fdkBA78M8BMMovw==
X-Received: by 2002:a05:6402:1e8e:b0:5f4:c2d0:fbb2 with SMTP id 4fb4d7f45d1cf-5f628597fbbmr1249814a12.18.1744960481435;
        Fri, 18 Apr 2025 00:14:41 -0700 (PDT)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f625a5ec5bsm667619a12.81.2025.04.18.00.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 00:14:40 -0700 (PDT)
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
	Martin Mares <mj@ucw.cz>
Subject: [PATCH -tip v2 1/2] x86/boot: Remove semicolon from "rep" prefixes
Date: Fri, 18 Apr 2025 09:13:50 +0200
Message-ID: <20250418071437.4144391-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.49.0
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
Cc: Martin Mares <mj@ucw.cz>
---
v2: Split the patch from the previous version.
---
 arch/x86/boot/bioscall.S          | 4 ++--
 arch/x86/boot/boot.h              | 4 ++--
 arch/x86/boot/compressed/string.c | 8 ++++----
 arch/x86/boot/copy.S              | 8 ++++----
 arch/x86/boot/header.S            | 2 +-
 arch/x86/boot/string.c            | 2 +-
 arch/x86/boot/video.c             | 2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/boot/bioscall.S b/arch/x86/boot/bioscall.S
index aa9b96457584..cf4a6155714e 100644
--- a/arch/x86/boot/bioscall.S
+++ b/arch/x86/boot/bioscall.S
@@ -32,7 +32,7 @@ intcall:
 	movw	%dx, %si
 	movw	%sp, %di
 	movw	$11, %cx
-	rep; movsl
+	rep movsl
 
 	/* Pop full state from the stack */
 	popal
@@ -67,7 +67,7 @@ intcall:
 	jz	4f
 	movw	%sp, %si
 	movw	$11, %cx
-	rep; movsl
+	rep movsl
 4:	addw	$44, %sp
 
 	/* Restore state and return */
diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index 38f17a1e1e36..f3771a6373c7 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -155,14 +155,14 @@ static inline void wrgs32(u32 v, addr_t addr)
 static inline bool memcmp_fs(const void *s1, addr_t s2, size_t len)
 {
 	bool diff;
-	asm volatile("fs; repe; cmpsb" CC_SET(nz)
+	asm volatile("fs repe cmpsb" CC_SET(nz)
 		     : CC_OUT(nz) (diff), "+D" (s1), "+S" (s2), "+c" (len));
 	return diff;
 }
 static inline bool memcmp_gs(const void *s1, addr_t s2, size_t len)
 {
 	bool diff;
-	asm volatile("gs; repe; cmpsb" CC_SET(nz)
+	asm volatile("gs repe cmpsb" CC_SET(nz)
 		     : CC_OUT(nz) (diff), "+D" (s1), "+S" (s2), "+c" (len));
 	return diff;
 }
diff --git a/arch/x86/boot/compressed/string.c b/arch/x86/boot/compressed/string.c
index 81fc1eaa3229..9af19d9614cb 100644
--- a/arch/x86/boot/compressed/string.c
+++ b/arch/x86/boot/compressed/string.c
@@ -15,9 +15,9 @@ static void *____memcpy(void *dest, const void *src, size_t n)
 {
 	int d0, d1, d2;
 	asm volatile(
-		"rep ; movsl\n\t"
+		"rep movsl\n\t"
 		"movl %4,%%ecx\n\t"
-		"rep ; movsb\n\t"
+		"rep movsb"
 		: "=&c" (d0), "=&D" (d1), "=&S" (d2)
 		: "0" (n >> 2), "g" (n & 3), "1" (dest), "2" (src)
 		: "memory");
@@ -29,9 +29,9 @@ static void *____memcpy(void *dest, const void *src, size_t n)
 {
 	long d0, d1, d2;
 	asm volatile(
-		"rep ; movsq\n\t"
+		"rep movsq\n\t"
 		"movq %4,%%rcx\n\t"
-		"rep ; movsb\n\t"
+		"rep movsb"
 		: "=&c" (d0), "=&D" (d1), "=&S" (d2)
 		: "0" (n >> 3), "g" (n & 7), "1" (dest), "2" (src)
 		: "memory");
diff --git a/arch/x86/boot/copy.S b/arch/x86/boot/copy.S
index 6afd05e819d2..3973a67cd04e 100644
--- a/arch/x86/boot/copy.S
+++ b/arch/x86/boot/copy.S
@@ -22,10 +22,10 @@ SYM_FUNC_START_NOALIGN(memcpy)
 	movw	%dx, %si
 	pushw	%cx
 	shrw	$2, %cx
-	rep; movsl
+	rep movsl
 	popw	%cx
 	andw	$3, %cx
-	rep; movsb
+	rep movsb
 	popw	%di
 	popw	%si
 	retl
@@ -38,10 +38,10 @@ SYM_FUNC_START_NOALIGN(memset)
 	imull	$0x01010101,%eax
 	pushw	%cx
 	shrw	$2, %cx
-	rep; stosl
+	rep stosl
 	popw	%cx
 	andw	$3, %cx
-	rep; stosb
+	rep stosb
 	popw	%di
 	retl
 SYM_FUNC_END(memset)
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b5c79f43359b..9cb91421b4e4 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -585,7 +585,7 @@ start_of_setup:
 	xorl	%eax, %eax
 	subw	%di, %cx
 	shrw	$2, %cx
-	rep; stosl
+	rep stosl
 
 # Jump to C code (should not return)
 	calll	main
diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index 84f7a883ce1e..f35369bb14c5 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -32,7 +32,7 @@
 int memcmp(const void *s1, const void *s2, size_t len)
 {
 	bool diff;
-	asm("repe; cmpsb" CC_SET(nz)
+	asm("repe cmpsb" CC_SET(nz)
 	    : CC_OUT(nz) (diff), "+D" (s1), "+S" (s2), "+c" (len));
 	return diff;
 }
diff --git a/arch/x86/boot/video.c b/arch/x86/boot/video.c
index f2e96905b3fe..0641c8c46aee 100644
--- a/arch/x86/boot/video.c
+++ b/arch/x86/boot/video.c
@@ -292,7 +292,7 @@ static void restore_screen(void)
 			     "shrw %%cx ; "
 			     "jnc 1f ; "
 			     "stosw \n\t"
-			     "1: rep;stosl ; "
+			     "1: rep stosl ; "
 			     "popw %%es"
 			     : "+D" (dst), "+c" (npad)
 			     : "bdS" (video_segment),
-- 
2.49.0


