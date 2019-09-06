Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDE0AB388
	for <lists+linux-pm@lfdr.de>; Fri,  6 Sep 2019 09:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfIFHzx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Sep 2019 03:55:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:34434 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbfIFHzx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Sep 2019 03:55:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0FD5AD0F;
        Fri,  6 Sep 2019 07:55:51 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/2] x86/asm/suspend: Get rid of bogus_64_magic
Date:   Fri,  6 Sep 2019 09:55:49 +0200
Message-Id: <20190906075550.23435-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

bogus_64_magic is only a dead-end loop. There is no need for an
out-of-order function (and unannotated local label), so just handle it
in-place and also store 0xbad-m-a-g-i-c to rcx beforehand.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <lenb@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
---
 arch/x86/kernel/acpi/wakeup_64.S | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index b0715c3ac18d..7f9ade13bbcf 100644
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
-- 
2.23.0

