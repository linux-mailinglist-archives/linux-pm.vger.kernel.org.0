Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B7752D2D7
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbiESMoe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238024AbiESMoc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACD6BA9A9
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:28 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zVkkpnc/ayrSNQO32X72l/cX2M7u+XO8l3jJseyS4fI=;
        b=lqzMrzyGIYLQ8UcojJ81EDIi7bBE2LTyHl9IPZOuFV0dqLpL7yisSSIVOd+Wc4HmpcfL0c
        28F6iPG6fGGdL39p9HhU/pAS2zLAI0FWlz+7N8dSytnQRb/7PJZiw6OySmZ3TlHSQDR/M3
        iJcaHqPWVh/OAOqph6jENbkpgWVuc8uok5bQXkWqPJ9Eb6XQILgYfKRL8YpTD+yHo0Sftt
        tSbxRUiTFYoSVX8jVdpIrI6LhBmxvG/GKStsEvBd8n4WqVhxgbWoktY24S5qmcvSYSPAyc
        QSttl1VqVdZ5eRaw2+wZ6vhZ0a/0x5y3QJxrBXBhZ+2l7FwY54Nm50WvW0Bpbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zVkkpnc/ayrSNQO32X72l/cX2M7u+XO8l3jJseyS4fI=;
        b=PsiFoQJSp4qtobUhjwF+73LAdnbKMatWnfPVaW+GGITsRGT9YNHtXh5p3VzrNhroRp/JLw
        kRLmbBTVryUnwoCQ==
From:   "thermal-bot for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/rcar_thermal: Use
 platform_get_irq_optional() to get the interrupt
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220110144039.5810-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110144039.5810-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <165296426622.4207.14773589688435037058.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     3277e022a1c31f5041753942b3d9006174ca7aa2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//3277e022a1c31f5041753942b3d9006174ca7aa2
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Mon, 10 Jan 2022 14:40:39 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:50 +02:00

thermal/drivers/rcar_thermal: Use platform_get_irq_optional() to get the interrupt

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq_optional().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20220110144039.5810-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/rcar_thermal.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index b49f04d..1d729ed 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -445,7 +445,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	struct rcar_thermal_common *common;
 	struct rcar_thermal_priv *priv;
 	struct device *dev = &pdev->dev;
-	struct resource *res, *irq;
+	struct resource *res;
 	const struct rcar_thermal_chip *chip = of_device_get_match_data(dev);
 	int mres = 0;
 	int i;
@@ -467,9 +467,16 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(dev);
 
 	for (i = 0; i < chip->nirqs; i++) {
-		irq = platform_get_resource(pdev, IORESOURCE_IRQ, i);
-		if (!irq)
-			continue;
+		int irq;
+
+		ret = platform_get_irq_optional(pdev, i);
+		if (ret < 0 && ret != -ENXIO)
+			goto error_unregister;
+		if (ret > 0)
+			irq = ret;
+		else
+			break;
+
 		if (!common->base) {
 			/*
 			 * platform has IRQ support.
@@ -487,7 +494,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			idle = 0; /* polling delay is not needed */
 		}
 
-		ret = devm_request_irq(dev, irq->start, rcar_thermal_irq,
+		ret = devm_request_irq(dev, irq, rcar_thermal_irq,
 				       IRQF_SHARED, dev_name(dev), common);
 		if (ret) {
 			dev_err(dev, "irq request failed\n ");
