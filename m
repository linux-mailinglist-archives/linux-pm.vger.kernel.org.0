Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA76758434E
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiG1Plu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiG1Plt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:41:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637DF675B7
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:48 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=luoPkByJ58tkZ49XoDClSSRGoc6PTNHqpjqOrkJWTU8=;
        b=rl1sMcbX1YMrveEHqKTvT3naThAAytC5qILCA/mglnHYbTm7hHhU4UfAX1uqxRtvRwO5iu
        e75DcqgjBA6Z5Qwd/gFKw302DawMB9xx6Sdny3U8G6EnYze9WlEhs7QfhSmFSWcm954Icc
        qyWIUOouyCzkULEOg/G9h6w08JOlpJzEHi0QF8AWwJA7MW4v7PaRYscWLiaFQw1gyuIF/F
        xEojVtZpDvLaXS2Io3V92aM2sDEMKWtH3F6POdRtM4B6EeUa0qLQGAn/W8JuUEHn8k+NJp
        gQo0W8Az77zJ4oyKktC0bh6FXmUkkisf9ohYgpyalJUYnCbgGzQbXbg5Loht+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=luoPkByJ58tkZ49XoDClSSRGoc6PTNHqpjqOrkJWTU8=;
        b=LXQFRg6dukO4HXLlOl/untLjvywcTEYzj0aaaS7Rr4VyrzVfqicb9TNVImuaibwbJCJhcA
        Vl4Gxh04jJMyc6Cg==
From:   "thermal-bot for Yang Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/u8500: Remove unnecessary
 print function dev_err()
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220719003556.74460-1-yang.lee@linux.alibaba.com>
References: <20220719003556.74460-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <165902290593.15455.4628253169016805715.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     8cf18eea46e24a337c5a095edeed42ca03e97811
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//8cf18eea46e24a337c5a095edeed42ca03e97811
Author:        Yang Li <yang.lee@linux.alibaba.com>
AuthorDate:    Tue, 19 Jul 2022 08:35:56 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:50 +02:00

thermal/drivers/u8500: Remove unnecessary print function dev_err()

The print function dev_err() is redundant because platform_get_irq()
already prints an error.

Eliminate the follow coccicheck warnings:
./drivers/thermal/db8500_thermal.c:162:2-9: line 162 is redundant because platform_get_irq() already prints an error
./drivers/thermal/db8500_thermal.c:176:2-9: line 176 is redundant because platform_get_irq() already prints an error

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Link: https://lore.kernel.org/r/20220719003556.74460-1-yang.lee@linux.alibaba.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/db8500_thermal.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index ed40cfd..121cf85 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -158,10 +158,8 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	low_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_LOW");
-	if (low_irq < 0) {
-		dev_err(dev, "Get IRQ_HOTMON_LOW failed\n");
+	if (low_irq < 0)
 		return low_irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, low_irq, NULL,
 		prcmu_low_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
@@ -172,10 +170,8 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	}
 
 	high_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_HIGH");
-	if (high_irq < 0) {
-		dev_err(dev, "Get IRQ_HOTMON_HIGH failed\n");
+	if (high_irq < 0)
 		return high_irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, high_irq, NULL,
 		prcmu_high_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
