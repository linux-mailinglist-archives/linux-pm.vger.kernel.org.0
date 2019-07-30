Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B107B30F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 21:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfG3TNs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 15:13:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34585 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388134AbfG3TNV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 15:13:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so24330541pgc.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2019 12:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9kWf22Rclzq8G5FoRJbzmMz7xyL94toIUGR9urAcRyA=;
        b=F2smkGoK8KcptIdvV2SjQfrL6PlXipy7JjEVMHgzprpHrwcKNVKa93zl9Fymh8BUlh
         fpA3d71j1qBWHNgMomuekNiCQ8MlumiE/acWNOlnavR9gnndo7YWMyqkKvctTUhMJcWm
         5nm1cizH8+WJfF2ZVgUHYpKcxa3wRzq+Z8spk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9kWf22Rclzq8G5FoRJbzmMz7xyL94toIUGR9urAcRyA=;
        b=lGcrlW/p2P+I8tCGYeH02n9VlCjfhjDMpcBTSX+PMV4IFipv7vV0IDcaONaPv+1jog
         8a4x62+IjbLVOygc9Z2DWMNWraXlgTgZ9AHPLTaKh9YNUgCJCmFdit6jPc+q1ViAryye
         82ODj9i5Ybwvi0sP6L6cFLdiyel1vgL05LIiQj94RS7hMIS+MEUs/MaM16gqLXa0g9wp
         EIO1VFHmBwli+JtKqa3mlMpcUyFwwXyDh+7FTNhlrHB0Gzwm396VXoq4AQTxkVvGVpb9
         QGuwb7eDR9hLZ8AezZ9mOwiK5DYS09ioq6CJcYPvmQIkIFCAhed8V1QVJ38OKXflgzEZ
         m2Sw==
X-Gm-Message-State: APjAAAUypcg/xLBZIoGUyTiBEKjd/B/ghrzSwDSO3/VoHpfP2WwihXLo
        Y+ubCHcoSLhaB56BU1YLbJrIGA==
X-Google-Smtp-Source: APXvYqzr6BK0Xn2ozWdzr0KbSdWi9wDSK/YZN9WyQ63sDSm1hYENlMW/XPd2uWlP9oB/IStB2Eg/AA==
X-Received: by 2002:a63:784c:: with SMTP id t73mr113500712pgc.268.1564514000500;
        Tue, 30 Jul 2019 12:13:20 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id n89sm84649540pjc.0.2019.07.30.12.13.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 12:13:20 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 07/11] x86/acpi: Adapt assembly for PIE support
Date:   Tue, 30 Jul 2019 12:12:51 -0700
Message-Id: <20190730191303.206365-8-thgarnie@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190730191303.206365-1-thgarnie@chromium.org>
References: <20190730191303.206365-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/acpi/wakeup_64.S | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index b0715c3ac18d..3ec6c1b74ad4 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -15,7 +15,7 @@
 	 * Hooray, we are in Long 64-bit mode (but still running in low memory)
 	 */
 ENTRY(wakeup_long64)
-	movq	saved_magic, %rax
+	movq	saved_magic(%rip), %rax
 	movq	$0x123456789abcdef0, %rdx
 	cmpq	%rdx, %rax
 	jne	bogus_64_magic
@@ -26,14 +26,14 @@ ENTRY(wakeup_long64)
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
 
@@ -46,7 +46,7 @@ ENTRY(do_suspend_lowlevel)
 	xorl	%eax, %eax
 	call	save_processor_state
 
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	%rsp, pt_regs_sp(%rax)
 	movq	%rbp, pt_regs_bp(%rax)
 	movq	%rsi, pt_regs_si(%rax)
@@ -65,13 +65,14 @@ ENTRY(do_suspend_lowlevel)
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
@@ -83,7 +84,7 @@ ENTRY(do_suspend_lowlevel)
 	.align 4
 .Lresume_point:
 	/* We don't restore %rax, it must be 0 anyway */
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	saved_context_cr4(%rax), %rbx
 	movq	%rbx, %cr4
 	movq	saved_context_cr3(%rax), %rbx
-- 
2.22.0.770.g0f2c4a37fd-goog

