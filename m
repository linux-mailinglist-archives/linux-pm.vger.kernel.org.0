Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B3F7B307
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 21:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388284AbfG3TNY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 15:13:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38201 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388262AbfG3TNY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 15:13:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so30343197pfn.5
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2019 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aCFi9VKfA/regOH6ME0h7V2OJPrhlZ4OE3HFuZl/Mr4=;
        b=hk0Bac0aiWQasaW/82OqlXyeS+zRRbeGWMF9iYoYCCjmyk5hKfhbErMAfoM104i7Br
         TdpwZFEl9pU+frxz1cazoSP6L1BNAC+8jncLJVwuFEsDynqzb3OP7vNis0EU/ikkPW8m
         /LeN2upB3IFugt/kUzhj6IfHluZI3rXDFFkRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aCFi9VKfA/regOH6ME0h7V2OJPrhlZ4OE3HFuZl/Mr4=;
        b=oBr8ty01a308ojvDV6OEEwkhkLdHfqUEMsFloXwBcoWo0QqGoXu9nQEkXs9hcTa0KW
         K3Z8a/zRKQWxB4hyS93c3FgjYyYND6ZTtSrRQYxruc+3vK+wqwRD5dx68I0v5auT+MzY
         bqCPr9savHMMbBeUUJb+cgMEDsKqxgdGPh4BC1/Awxb4OG97k5jEZP54zWHr2bL6FFHN
         hQbhaqO51s5eOaOxGJ3uLvWkOi0pAAeZ1rNqcbEHEJkPitl08vbP/Fla5EcHrHJ47wR4
         OudUFkrzobTiOzRzbeDAekU7R4Ubm+KHoFNKBtZbQcz15f99DJKH08FIBVIIt74/fIr3
         5d9A==
X-Gm-Message-State: APjAAAXNyOrJKnm2r66CU7/t1ZjM00DZZn7KnEl+Uda84SwA/02V+Qo2
        ddVHgVT2sgeu4W2RInzzOTST4Q==
X-Google-Smtp-Source: APXvYqyTpbQ7f3xITrwKbyFWcIPqfOysYAwjkN9vIf84u+eLPDg/LwjNFZLDtMcMgZUrWQ+iiuxmZg==
X-Received: by 2002:a65:57ca:: with SMTP id q10mr113599135pgr.52.1564514003446;
        Tue, 30 Jul 2019 12:13:23 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id n89sm84649540pjc.0.2019.07.30.12.13.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 12:13:23 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 09/11] x86/power/64: Adapt assembly for PIE support
Date:   Tue, 30 Jul 2019 12:12:53 -0700
Message-Id: <20190730191303.206365-10-thgarnie@chromium.org>
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
 arch/x86/power/hibernate_asm_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index a4d5eb0a7ece..796cd19d575b 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -23,7 +23,7 @@
 #include <asm/frame.h>
 
 ENTRY(swsusp_arch_suspend)
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	%rsp, pt_regs_sp(%rax)
 	movq	%rbp, pt_regs_bp(%rax)
 	movq	%rsi, pt_regs_si(%rax)
@@ -114,7 +114,7 @@ ENTRY(restore_registers)
 	movq	%rax, %cr4;  # turn PGE back on
 
 	/* We don't restore %rax, it must be 0 anyway */
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	pt_regs_sp(%rax), %rsp
 	movq	pt_regs_bp(%rax), %rbp
 	movq	pt_regs_si(%rax), %rsi
-- 
2.22.0.770.g0f2c4a37fd-goog

