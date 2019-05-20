Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 579DD2442E
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 01:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfETXUg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 19:20:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43138 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbfETXUU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2019 19:20:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id gn7so3261355plb.10
        for <linux-pm@vger.kernel.org>; Mon, 20 May 2019 16:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1tp0hWg+Fv4tFS/1ogVPOUXaReV0m0NPqcPhlDEcA4M=;
        b=V2XT6VyD2+DXGZSgdKWFvfyai33es5DC+pNYfU1uPcQQUXoX4sf/c4bDjhULluZD/c
         MfaAquz2qQ7KJQkg9vWSvHcjVIvgRjEQ2Gqt453NVNd8pDuqKvbFpR3SRpLoo9Fhn3Bn
         YPOOGVv69va+6L6dfkLJtQqk9v+n5hsgQ/cqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tp0hWg+Fv4tFS/1ogVPOUXaReV0m0NPqcPhlDEcA4M=;
        b=EnZrULAjVIbhgfN8Fn6WT363MUXzJ4Dl9dMfVoByhr7w40mhWP6dGhop5grp+VFKwS
         /MN0xZzqIGSmWX1R6xHt29lmeVycGSwjUYP6bxxm6mBO119QUFiTyAeFUXLI76CcNZr+
         QMT1qQ35bnRvyMHmnYhhI34QO0g36zRVUTn9gc4WRvIzA1qxmZfCW6dukk5bK25+G+Q9
         NNPO8Q8ULrd0HrC1xPOoIrLauzAXko9iVjyqg2XhlmyDYYUuRsRdAWBKoHcTNckbLhSn
         JwEilsugTHBZL8bdqpOYfa46WE7JKu1qoqGqZgPqc0/bKQ0VKMg/FYNlTB5bhFC5vxqq
         Ah+w==
X-Gm-Message-State: APjAAAW1SIKeAVrvrJDdL34g5XRiYlSiLAA+hLzJVWy4LqKDVKnIJYw4
        kxi4C5WnMTSew4QAQSfWW0QvlQ==
X-Google-Smtp-Source: APXvYqzGnLop82FsJKmnNwPR3WWLt5KGSTjBnQrRed8+UZU4RsaefgYELhyIPHlFuCzzzBwKRGJPNA==
X-Received: by 2002:a17:902:9348:: with SMTP id g8mr36216437plp.174.1558394419565;
        Mon, 20 May 2019 16:20:19 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id h13sm19350861pgk.55.2019.05.20.16.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 16:20:19 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@google.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 10/12] x86/power/64: Adapt assembly for PIE support
Date:   Mon, 20 May 2019 16:19:35 -0700
Message-Id: <20190520231948.49693-11-thgarnie@chromium.org>
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
 arch/x86/power/hibernate_asm_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index 3008baa2fa95..9ed980efef72 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -24,7 +24,7 @@
 #include <asm/frame.h>
 
 ENTRY(swsusp_arch_suspend)
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	%rsp, pt_regs_sp(%rax)
 	movq	%rbp, pt_regs_bp(%rax)
 	movq	%rsi, pt_regs_si(%rax)
@@ -115,7 +115,7 @@ ENTRY(restore_registers)
 	movq	%rax, %cr4;  # turn PGE back on
 
 	/* We don't restore %rax, it must be 0 anyway */
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	pt_regs_sp(%rax), %rsp
 	movq	pt_regs_bp(%rax), %rbp
 	movq	pt_regs_si(%rax), %rsi
-- 
2.21.0.1020.gf2820cf01a-goog

