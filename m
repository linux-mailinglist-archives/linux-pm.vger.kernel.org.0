Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A089526AA95
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 19:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgIOR2W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Sep 2020 13:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbgIOR1b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2020 13:27:31 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFB8C061788
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 10:27:31 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id w126so3481286qka.5
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 10:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=3u6QNX47PZ9TdlezqUiGlsnaSlH8wNQx15OpjBzQXOI=;
        b=e27HTy32MKVmFnXsb0r7jmeNb+xBQVN4J1617K9M8IbpE0Un23KkDv8xC7DMW2cWLX
         RNaoRJF7gVmDjRXtZopVMldnDUpQdRwYBC/rInZNatTBH20LbB6tPRPcJiJBWkBSSlHD
         Pn3HJxzPYWySFg+64lEf/ichizhY+88fqOtu9P8CCL5cbc9AXatzupOTwdGmuIFiceEi
         7mebT+enuDoX/ycLjzu468JLwdT6gRModPMh/dZRRR3DbXQGba29bL4DU9MmQit2LHVt
         LaxSgsxNLU+0V/h9qQEI9Mtw71YiMGdSpWW6gTgYSJ1wQh0qurnN8Pc04Jya1l6M13cO
         6MAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=3u6QNX47PZ9TdlezqUiGlsnaSlH8wNQx15OpjBzQXOI=;
        b=betkFtXq2IwujSDQronnWBoKJB9cyE0oVhyv/7B6ZShqVDOj3Y9UemTMAA9hBSx61z
         pOcdgm0+T7z+djPPdYJS/AWlYTZwlihkM8Z2kO7Y2qEC6iwmIHL47tHXZDg8kmDhKoj7
         fAXzSADQhEq4AR5qwKeAq474WtBvEN1VbNgJ0S3CZHfLXoeAOpHSSaDU6RhrB9iU0sbc
         M06N8jgROpg1w0B0RiZAwHdyuqhOOIgH8PSg/9AbN6S+ZYXX6KEtuH+P+V/LFMfkJFbC
         hlFBw5XaGNMH2tvcPOZcz3zHoJhFdiKR77Qf+Ur1qkXyRkj1YkDNTzbfUh/rpzKL3v1x
         Ip4Q==
X-Gm-Message-State: AOAM533bXpzzrzSMcz1kDarK0J3UYhsiIFIg23plC9fNGlpIkG+OfSbj
        AMxjl5ZhQDJ7mNicr5NQz5OllPon
X-Google-Smtp-Source: ABdhPJy/cc7tlyIbOPVONthyIZiWLQJFCdiXahHjMqgHbhEQAi6cibIzNSCoiRPPhgOBc/UVVH/woDCA
X-Received: from rkir.kir.corp.google.com ([2620:15c:29:200:3e52:82ff:fe5f:f95])
 (user=rkir job=sendgmr) by 2002:a0c:e294:: with SMTP id r20mr2740839qvl.60.1600190850513;
 Tue, 15 Sep 2020 10:27:30 -0700 (PDT)
Date:   Tue, 15 Sep 2020 10:26:58 -0700
Message-Id: <20200915172658.1432732-1-rkir@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH] arch: x86: power: cpu: init %gs before __restore_processor_state
 (clang)
From:   rkir@google.com
To:     rjw@rjwysocki.net, pavel@ucw.cz, tglx@linutronix.de,
        mingo@redhat.com
Cc:     x86@kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, ndesaulniers@google.com,
        adelva@google.com, rkir@google.com, Haitao Shan <hshan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Haitao Shan <hshan@google.com>

This is a workaround which fixes triple fault
in __restore_processor_state on clang when
built with LTO.

When load_TR_desc and load_mm_ldt are inlined into
fix_processor_context due to LTO, they cause
fix_processor_context (or in this case __restore_processor_state,
as fix_processor_context was inlined into __restore_processor_state)
to access the stack canary through %gs, but before
__restore_processor_state has restored the previous value
of %gs properly. LLVM appears to be inlining functions with stack
protectors into functions compiled with -fno-stack-protector,
which is likely a bug in LLVM's inliner that needs to be fixed.

The LLVM bug is here: https://bugs.llvm.org/show_bug.cgi?id=47479

Signed-off-by: Haitao Shan <hshan@google.com>
Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 arch/x86/power/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index db1378c6ff26..e5677adb2d28 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -274,6 +274,16 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 /* Needed by apm.c */
 void notrace restore_processor_state(void)
 {
+#ifdef __clang__
+	// The following code snippet is copied from __restore_processor_state.
+	// Its purpose is to prepare GS segment before the function is called.
+#ifdef CONFIG_X86_64
+	wrmsrl(MSR_GS_BASE, saved_context.kernelmode_gs_base);
+#else
+	loadsegment(fs, __KERNEL_PERCPU);
+	loadsegment(gs, __KERNEL_STACK_CANARY);
+#endif
+#endif
 	__restore_processor_state(&saved_context);
 }
 #ifdef CONFIG_X86_32
-- 
2.28.0.618.gf4bc123cb7-goog

