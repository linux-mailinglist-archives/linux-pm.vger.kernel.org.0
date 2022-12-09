Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72DA648517
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiLIP0g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiLIP03 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E241C8D647
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:27 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599585;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NINAlGXEw/T4c5ZeaG+W4Ck8KSNs7sQEQr+5Bn2f5gw=;
        b=SvKis5ahfyP02Z788WA1qjs1KOLmWrmwAjfabUDz557jawwd3VfLkoc69o375cUhTS2ak3
        7CUfiLp5aIhImp7yayyEVVXbx3SShzZAgtgM3B0ur0Z8cP1WgeYty8S/PwPAtAM0awo2gW
        QgSSZLrnph22XRGlqHHXitowI10J1g2KETseaYvWihNnvGsrqlU3NtlHCuAkvjnsQjh3Cz
        BwIYBJ9RH1RxVellzm6w9DRBsWheIkdiLzWJcnTEKg+Bq7Oa5yFLmFFFiYD1pA85qniLOQ
        LOUO6JR0zChKMZIH/Md7MtpTkV178+yrYAkVdfKRFy87BwkrqacCbSigjq+3JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599585;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NINAlGXEw/T4c5ZeaG+W4Ck8KSNs7sQEQr+5Bn2f5gw=;
        b=pWU8htUDDCq/gSAWSNeBkMUIB9+vsGl/r2bjgE85RQtvIsAye/n/r03Z179mOciujGp46M
        ANnoShPbDSV/FHAQ==
From:   "thermal-bot for Bjorn Andersson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/qcom/lmh: Fix irq handler
 return value
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220316180322.88132-1-bjorn.andersson@linaro.org>
References: <20220316180322.88132-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Message-ID: <167059958526.4906.8006447666823780139.tip-bot2@tip-bot2>
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

Commit-ID:     1c5ec8178db2c71a9c20bd5da03eb1a7165121d3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//1c5ec8178db2c71a9c20bd5da03eb1a7165121d3
Author:        Bjorn Andersson <bjorn.andersson@linaro.org>
AuthorDate:    Wed, 16 Mar 2022 11:03:22 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 17:45:04 +01:00

thermal/drivers/qcom/lmh: Fix irq handler return value

After enough invocations the LMh irq is eventually reported as bad, because the
handler doesn't return IRQ_HANDLED, fix this.

Fixes: 53bca371cdf7 ("thermal/drivers/qcom: Add support for LMh driver")
Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20220316180322.88132-1-bjorn.andersson@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/qcom/lmh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index d3d9b9f..4122a51 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -45,7 +45,7 @@ static irqreturn_t lmh_handle_irq(int hw_irq, void *data)
 	if (irq)
 		generic_handle_irq(irq);
 
-	return 0;
+	return IRQ_HANDLED;
 }
 
 static void lmh_enable_interrupt(struct irq_data *d)
