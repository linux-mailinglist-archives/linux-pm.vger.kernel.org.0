Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCA3B2442D
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 01:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfETXUR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 19:20:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37547 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfETXUR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2019 19:20:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id p15so7428136pll.4
        for <linux-pm@vger.kernel.org>; Mon, 20 May 2019 16:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YRvbySHDI9m79O10tEqKVbu0RDekXOTbO/NzB7rAlEs=;
        b=CSmbns2X94WFkKq63CfNfv64datLbczpyGYxten2MqFzl49yU9bBmWzG/njavZRAwJ
         0ptKNku1Fb/sEofgaG4sshjeJnGMSSLIxHORCS7RiYtPv3XAuNZQJR5AVladjzb5vItU
         DtHVyuGOLOroVp/jhzFq4ol6wGf8brRUd2fK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YRvbySHDI9m79O10tEqKVbu0RDekXOTbO/NzB7rAlEs=;
        b=Sxm4zOEBgVXw2KGHbD4ChWLH/p/EX1Yjuw3nwlMDFgMaD2MyF/cQ3Sh3+MO/QN+Zw+
         uqYGOyRAJYEQWKqJvVbnBbRvSpVdlaD/cYUPSEcL70o/JYzyk1/Oh61N+KPxkyp3LRZh
         MmnOdoWyr/CnolbB1pls4G01zgIjXZ8R6of7R9ZawuKfTsxCiYwZlPGjmxe6jMeTtHCk
         5Q0NhM9ea1IZYQFDiK7A7o0Tkis/fUC8Iw8DZqbjjlQq4jQZ0IbKSm4LlzfvOjjNazXq
         l5dkgoPhdA+4ZmKAG0jvG/bmD8keuQ6CK2lypSEWCQzxeXroAg87+wCdKhwT6q/09cVb
         p/Vw==
X-Gm-Message-State: APjAAAV9kkBPOODTNtpSn6B3nIRq0NvirxIuAwRpLjQMJFRoV5D+ryjz
        K6fFPLxO7SeCtl2FidDjGex19g==
X-Google-Smtp-Source: APXvYqy24KzqCuoCNaR5XV9MVxMB4poHoGqwCpe+ByXG7wLsxEczPxh3xQpdXoqp2nLas6twp7+gtg==
X-Received: by 2002:a17:902:9693:: with SMTP id n19mr78284329plp.92.1558394416511;
        Mon, 20 May 2019 16:20:16 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id h13sm19350861pgk.55.2019.05.20.16.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 16:20:16 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@google.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 08/12] x86/acpi: Adapt assembly for PIE support
Date:   Mon, 20 May 2019 16:19:33 -0700
Message-Id: <20190520231948.49693-9-thgarnie@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190520231948.49693-1-thgarnie@chromium.org>
References: <20190520231948.49693-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thomas Garnier <thgarnie@google.com>

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/acpi/wakeup_64.S | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 510fa12aab73..e080e943e295 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -14,7 +14,7 @@
 	 * Hooray, we are in Long 64-bit mode (but still running in low memory)
 	 */
 ENTRY(wakeup_long64)
-	movq	saved_magic, %rax
+	movq	saved_magic(%rip), %rax
 	movq	$0x123456789abcdef0, %rdx
 	cmpq	%rdx, %rax
 	jne	bogus_64_magic
@@ -25,14 +25,14 @@ ENTRY(wakeup_long64)
 	movw	%ax, %es
 	movw	%ax, %fs
 	movw	%ax, %gs
-	movq	saved_rsp, %rsp
+	movq	saved_rsp(%rip), %rsp
 
-	movq	saved_rbx, %rbx
-	movq	saved_rdi, %rdi
-	movq	saved_rsi, %rsi
-	movq	saved_rbp, %rbp
+	movq	saved_rbx(%rip), %rbx
+	movq	saved_rdi(%rip), %rdi
+	movq	saved_rsi(%rip), %rsi
+	movq	saved_rbp(%rip), %rbp
 
-	movq	saved_rip, %rax
+	movq	saved_rip(%rip), %rax
 	jmp	*%rax
 ENDPROC(wakeup_long64)
 
@@ -45,7 +45,7 @@ ENTRY(do_suspend_lowlevel)
 	xorl	%eax, %eax
 	call	save_processor_state
 
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	%rsp, pt_regs_sp(%rax)
 	movq	%rbp, pt_regs_bp(%rax)
 	movq	%rsi, pt_regs_si(%rax)
@@ -64,13 +64,14 @@ ENTRY(do_suspend_lowlevel)
 	pushfq
 	popq	pt_regs_flags(%rax)
 
-	movq	$.Lresume_point, saved_rip(%rip)
+	leaq	.Lresume_point(%rip), %rax
+	movq	%rax, saved_rip(%rip)
 
-	movq	%rsp, saved_rsp
-	movq	%rbp, saved_rbp
-	movq	%rbx, saved_rbx
-	movq	%rdi, saved_rdi
-	movq	%rsi, saved_rsi
+	movq	%rsp, saved_rsp(%rip)
+	movq	%rbp, saved_rbp(%rip)
+	movq	%rbx, saved_rbx(%rip)
+	movq	%rdi, saved_rdi(%rip)
+	movq	%rsi, saved_rsi(%rip)
 
 	addq	$8, %rsp
 	movl	$3, %edi
@@ -82,7 +83,7 @@ ENTRY(do_suspend_lowlevel)
 	.align 4
 .Lresume_point:
 	/* We don't restore %rax, it must be 0 anyway */
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	saved_context_cr4(%rax), %rbx
 	movq	%rbx, %cr4
 	movq	saved_context_cr3(%rax), %rbx
-- 
2.21.0.1020.gf2820cf01a-goog

