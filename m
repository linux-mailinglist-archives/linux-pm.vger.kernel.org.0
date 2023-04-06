Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390826D9B09
	for <lists+linux-pm@lfdr.de>; Thu,  6 Apr 2023 16:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbjDFOru (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Apr 2023 10:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjDFOrc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Apr 2023 10:47:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB481AD3D
        for <linux-pm@vger.kernel.org>; Thu,  6 Apr 2023 07:45:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Psknr2BzMz4xFZ;
        Fri,  7 Apr 2023 00:45:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1680792352;
        bh=xPxa877hnQ/ia2BPQZXawdRAt1BVSr9MAYE3vUoMiCM=;
        h=From:To:Cc:Subject:Date:From;
        b=PERGucNT5wNEHwGDTCppTfkLRzkC8lfXfZ4hLd0Kwz8KF9tYXZHlwTm0tgJm+Ck+F
         E7ClYoQVTAq1fKAhosfoG2RT+t+/fn3HuJYsSDQBEH3SwzYdFRG/zJpvd89HM5iIfD
         /YUQFcC4r2EY/m/rBweeTjDEXsD9eLbj9kJGIDHftuXh3r2njGlTG6zyhh70kYCgp2
         A316fNfar/OySOclvVeAVbo0y421BhYm88VgP9BiRjfmvT6s2RDZahma9QDYZS75WP
         10iMH5vAPvQpDV+1O+KxWCv2XI7daErGiFjoHxk2wjVzesMM8Mm5UWQI+FyT997Qxg
         ln+h0XcYhsJyQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linuxppc-dev@lists.ozlabs.org>
Cc:     <peterz@infradead.org>, <npiggin@gmail.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/4] powerpc/64: Mark prep_irq_for_idle() __cpuidle
Date:   Fri,  7 Apr 2023 00:45:32 +1000
Message-Id: <20230406144535.3786008-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.39.2
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

Code in the idle path is not allowed to be instrumented because RCU is
disabled, see commit 0e985e9d2286 ("cpuidle: Add comments about
noinstr/__cpuidle usage").

Mark prep_irq_for_idle() __cpuidle, which is equivalent to noinstr, to
enforce that.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/irq_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/irq_64.c b/arch/powerpc/kernel/irq_64.c
index c788c55512ed..2ab0e8d84c1d 100644
--- a/arch/powerpc/kernel/irq_64.c
+++ b/arch/powerpc/kernel/irq_64.c
@@ -354,7 +354,7 @@ EXPORT_SYMBOL(arch_local_irq_restore);
  * disabled and marked as such, so the local_irq_enable() call
  * in arch_cpu_idle() will properly re-enable everything.
  */
-bool prep_irq_for_idle(void)
+__cpuidle bool prep_irq_for_idle(void)
 {
 	/*
 	 * First we need to hard disable to ensure no interrupt
-- 
2.39.2

