Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA43AB521
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2019 11:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392978AbfIFJwL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Sep 2019 05:52:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46795 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392975AbfIFJwK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Sep 2019 05:52:10 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6AuS-000557-PG; Fri, 06 Sep 2019 11:52:04 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4B09D1C0DE8;
        Fri,  6 Sep 2019 11:52:04 +0200 (CEST)
Date:   Fri, 06 Sep 2019 09:52:04 -0000
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm/suspend: Get rid of bogus_64_magic
Cc:     Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20190906075550.23435-1-jslaby@suse.cz>
References: <20190906075550.23435-1-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <156776352423.24167.12782521075233555186.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     559ceeed62a5121783a8955c63aeb18aaa0ef224
Gitweb:        https://git.kernel.org/tip/559ceeed62a5121783a8955c63aeb18aaa0ef224
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Fri, 06 Sep 2019 09:55:49 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 06 Sep 2019 10:34:15 +02:00

x86/asm/suspend: Get rid of bogus_64_magic

bogus_64_magic is only a dead-end loop. There is no need for an
out-of-order function (and unannotated local label), so just handle it
in-place and also store 0xbad-m-a-g-i-c to %rcx beforehand, in case
someone is inspecting registers.

Here a qemu+gdb example:

  Remote debugging using localhost:1235
  wakeup_long64 () at arch/x86/kernel/acpi/wakeup_64.S:26
  26              jmp 1b
  (gdb) info registers
  rax            0x123456789abcdef0       1311768467463790320
  rbx            0x0      0
  rcx            0xbad6d61676963  3286910041024867
  		 ^^^^^^^^^^^^^^^

 [ bp: Add the gdb example. ]

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190906075550.23435-1-jslaby@suse.cz
---
 arch/x86/kernel/acpi/wakeup_64.S | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index b0715c3..7f9ade1 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -18,8 +18,13 @@ ENTRY(wakeup_long64)
 	movq	saved_magic, %rax
 	movq	$0x123456789abcdef0, %rdx
 	cmpq	%rdx, %rax
-	jne	bogus_64_magic
+	je	2f
 
+	/* stop here on a saved_magic mismatch */
+	movq $0xbad6d61676963, %rcx
+1:
+	jmp 1b
+2:
 	movw	$__KERNEL_DS, %ax
 	movw	%ax, %ss	
 	movw	%ax, %ds
@@ -37,9 +42,6 @@ ENTRY(wakeup_long64)
 	jmp	*%rax
 ENDPROC(wakeup_long64)
 
-bogus_64_magic:
-	jmp	bogus_64_magic
-
 ENTRY(do_suspend_lowlevel)
 	FRAME_BEGIN
 	subq	$8, %rsp
