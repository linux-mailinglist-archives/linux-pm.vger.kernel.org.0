Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7726D9B0B
	for <lists+linux-pm@lfdr.de>; Thu,  6 Apr 2023 16:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238530AbjDFOrv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Apr 2023 10:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238145AbjDFOrd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Apr 2023 10:47:33 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3CB9748
        for <linux-pm@vger.kernel.org>; Thu,  6 Apr 2023 07:45:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Psknr5wJ0z4xFf;
        Fri,  7 Apr 2023 00:45:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1680792352;
        bh=qodY2Q6CbcE/PBC3R4o7HdbOAge0infBVNAA92K2ITM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kaqSS7OIeEjpjtZkELzMk9V5UHap9SFDVhQEU8UA/HqCTcI7sas9JLN8XNzH/LJOm
         iziSdk9lq8QXDYKBnbxOKVLBgZwI/8bXMT6THnPtst17zYR8sBjkaEZ9hEoYsTZ4c2
         IJdFCX686rb1UHn06jWbPbZhOIgAAiEpoOtnhUuD2M/inJn2SXkDkfudQC0UnbsOez
         RnK5r1DKlo1QAqkt2GmF4tSDT43o3TEZHkD+QRSIpcLvd4hR0JdM6SpDVI4FL1uJwN
         lKY8t6Q+20u7CrZlm+0RXkn/BselT3D+fumGMIRaaFB/EmKnUQvD0uAKUFdXN8r2xd
         tT4lpP6G/ygfQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linuxppc-dev@lists.ozlabs.org>
Cc:     <peterz@infradead.org>, <npiggin@gmail.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH 2/4] powerpc/64: Don't call trace_hardirqs_on() in prep_irq_for_idle()
Date:   Fri,  7 Apr 2023 00:45:33 +1000
Message-Id: <20230406144535.3786008-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406144535.3786008-1-mpe@ellerman.id.au>
References: <20230406144535.3786008-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since commit a01353cf1896 ("cpuidle: Fix ct_idle_*() usage"), the
cpuidle entry code calls trace_hardirqs_on() (actually
trace_hardirqs_on_prepare()) in ct_cpuidle_enter() before calling into
the cpuidle driver.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/irq_64.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/irq_64.c b/arch/powerpc/kernel/irq_64.c
index 2ab0e8d84c1d..938e66829eae 100644
--- a/arch/powerpc/kernel/irq_64.c
+++ b/arch/powerpc/kernel/irq_64.c
@@ -348,9 +348,8 @@ EXPORT_SYMBOL(arch_local_irq_restore);
  * already the case when ppc_md.power_save is called). The function
  * will return whether to enter power save or just return.
  *
- * In the former case, it will have notified lockdep of interrupts
- * being re-enabled and generally sanitized the lazy irq state,
- * and in the latter case it will leave with interrupts hard
+ * In the former case, it will have generally sanitized the lazy irq
+ * state, and in the latter case it will leave with interrupts hard
  * disabled and marked as such, so the local_irq_enable() call
  * in arch_cpu_idle() will properly re-enable everything.
  */
@@ -370,9 +369,6 @@ __cpuidle bool prep_irq_for_idle(void)
 	if (lazy_irq_pending())
 		return false;
 
-	/* Tell lockdep we are about to re-enable */
-	trace_hardirqs_on();
-
 	/*
 	 * Mark interrupts as soft-enabled and clear the
 	 * PACA_IRQ_HARD_DIS from the pending mask since we
-- 
2.39.2

