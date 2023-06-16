Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8221973328A
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jun 2023 15:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjFPNxD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jun 2023 09:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFPNxC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2023 09:53:02 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287DB30DE
        for <linux-pm@vger.kernel.org>; Fri, 16 Jun 2023 06:52:56 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686923575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=raAjiXztDhuejqjgDIi3ajilKhYkJBwhbCGx4pOyvAw=;
        b=BsOmhDgaoGpB/brbcksAP7WMk6MH/yniLVC6L5v8CzO7hBfnwM8CzfL0XfD5KOgxkIpzs9
        ARm7oVCX5qWFLoKlO2lDq5ISzPk9Np4+XGQe6Co/WNmj22eQ2BcXH/7EXuYkHP+fDnbSnf
        qXW+89Pg2tuvreRFTeaSHKBvI0m78WWkUgMO41lfK/YBF9codDmPvDf0DvGChovkovy7By
        58fwVF3hcCVQnc5XMKvm1wh+jyXMO2ZRdWioytuI93mboPDoM9ck+HYhLrys/27bg8TvNO
        7lRdsPUVvcDANyf9DJQPBRlvyZWOcsnaQB6S6ZDtCBL8azi/gr7km1+ZXVTuqg==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E585A4000A;
        Fri, 16 Jun 2023 13:52:54 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 1/2] power: reset: at91-reset: change the power on reason prototype
Date:   Fri, 16 Jun 2023 15:52:51 +0200
Message-Id: <20230616135252.2787679-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616135252.2787679-1-miquel.raynal@bootlin.com>
References: <20230616135252.2787679-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It is quite uncommon to use a driver helper with parameters like *pdev
and __iomem *base. It is much cleaner and close to today's standards to
provide the per-device driver structure and then access its
internals. Let's do this with the helper which returns the power on
reason. While we change the parameters, we can as well rename the
function from at91_reset_status() to at91_reset_reason() to be more
accurate with what the helper actually does, and finally because we don't
really need the pdev argument in this helper besides for printing the
reset reason, we can move the dev_info() call into the probe.

All these modifications prepare the introduction of a sysfs entry to
access this information. This way the diff will be much smaller. Thus,
there is no intended functional change.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/power/reset/at91-reset.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 741e44a017c3..d6884841a6dc 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -149,11 +149,10 @@ static int at91_reset(struct notifier_block *this, unsigned long mode,
 	return NOTIFY_DONE;
 }
 
-static void __init at91_reset_status(struct platform_device *pdev,
-				     void __iomem *base)
+static const char * __init at91_reset_reason(struct at91_reset *reset)
 {
+	u32 reg = readl(reset->rstc_base + AT91_RSTC_SR);
 	const char *reason;
-	u32 reg = readl(base + AT91_RSTC_SR);
 
 	switch ((reg & AT91_RSTC_RSTTYP) >> 8) {
 	case RESET_TYPE_GENERAL:
@@ -185,7 +184,7 @@ static void __init at91_reset_status(struct platform_device *pdev,
 		break;
 	}
 
-	dev_info(&pdev->dev, "Starting after %s\n", reason);
+	return reason;
 }
 
 static const struct of_device_id at91_ramc_of_match[] = {
@@ -392,7 +391,7 @@ static int __init at91_reset_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_clk;
 
-	at91_reset_status(pdev, reset->rstc_base);
+	dev_info(&pdev->dev, "Starting after %s\n", at91_reset_reason(reset));
 
 	return 0;
 
-- 
2.34.1

