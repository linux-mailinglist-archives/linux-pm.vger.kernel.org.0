Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2352C13B836
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 04:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgAODkv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 22:40:51 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59385 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729045AbgAODkv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 22:40:51 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 44B732213F;
        Tue, 14 Jan 2020 22:40:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 14 Jan 2020 22:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=1dk5aijTk6w4v
        CQgyLDInAxNbaNiMI7LvAOenwMv7lM=; b=YddlsDuS3TEiWMDGBvt7Sbx60qxiM
        2A+9yvh2j+O7FBwABKkaPc5KR8WkMJwgVzNeysXQ/ck9BBkJyoJhcERz17Ur8+WQ
        Z8TY+2YVWT4/NdFzpkZMcvfnRh8Mzylda5HWks5Qkt25PmWfrpT2XW5jKrorev2m
        KLpF2Zg6L/vmkpCHDBWqaQlAcx85lk4pqPXovDuxTxIDlqMwg1BqkULaWzQRwYWZ
        JLjeh4etx7cRqKIAJLEoSvy4bIdIVs+1RWyBoAn4dydyX7uYD/k1IDTrlmzizsR8
        PNlTrFXYQ6moFZ35Odd1J85+YtycVJkxkz996eYsJK2riOPaZZgQPVy0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=1dk5aijTk6w4vCQgyLDInAxNbaNiMI7LvAOenwMv7lM=; b=OlJUdP6t
        gBxPK8GM31/AoobOTrFPvkp3BYnmmJYeOyOA2oXOxIMm3Wo36ts++D9At/ljRtUa
        CGgXEs3TvPm3gU6Y6qL4Q5cV2vZJtAOhNH8mmSRSMwlVFXXLArbc4/QVyxMr37ay
        9wXyaphK9fdYl7KtzFWPHMzIykHoZ7h3v5sV5SqV3w+fq2pfth3yfbyYTG1wWJlD
        4WvUL8LuGDaQgeOdT02S3/zG43MAB+SYqR1Uza/gSG5YS/OrxIaWggtjcHIyYA5g
        iwDlhBv1kCwj6qfSi+EpZY2CmPYUVbQ96aHnsNSvlI7qyQjsIUkSam71/qbxVo0M
        mziuMAYFjsdAmA==
X-ME-Sender: <xms:wokeXioT-QrPuBhblJbvXrk_ROS-jjQRHTf6Z9eC_Wb4aLLVQZVS1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrtddvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:wokeXsUbLFhCSwGKXhwknfiVKLEL-8O0WfbZT3C8TgEQEny28xxSgg>
    <xmx:wokeXvPEBgyoIYtkkVoU_k53L9_IUzQXl0n8LOU7x7_7THH8LsjNDg>
    <xmx:wokeXgC9ksIfPf-PwJgy_aVLQHLyzGK94sKfguts2nXR8w7vartxNA>
    <xmx:wokeXvsHvgr0jgXVqF281rlhgaq4VibBve-XPWTwBPLxBZfIWGelYQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id C6B0C30607B0;
        Tue, 14 Jan 2020 22:40:49 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 1/4] power: supply: axp20x_usb_power: Use a match structure
Date:   Tue, 14 Jan 2020 21:40:45 -0600
Message-Id: <20200115034048.24901-2-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200115034048.24901-1-samuel@sholland.org>
References: <20200115034048.24901-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Instead of ad-hoc variant ID checks throughout the code, let's start
moving the variant-specific details to a match structure. This allows
for future flexibility, and it better matches the other axp20x power
supply drivers.

This commit removes most variant checks from axp20x_usb_power_probe().
Other parts of the driver still do ID matching; they are left unchanged
for now.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/power/supply/axp20x_usb_power.c | 86 ++++++++++++++++---------
 1 file changed, 57 insertions(+), 29 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index dd3f3f12e41d..cd7071057457 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -405,6 +405,50 @@ static const struct power_supply_desc axp22x_usb_power_desc = {
 	.set_property = axp20x_usb_power_set_property,
 };
 
+static const char * const axp20x_irq_names[] = {
+	"VBUS_PLUGIN",
+	"VBUS_REMOVAL",
+	"VBUS_VALID",
+	"VBUS_NOT_VALID",
+	NULL
+};
+
+static const char * const axp22x_irq_names[] = {
+	"VBUS_PLUGIN",
+	"VBUS_REMOVAL",
+	NULL
+};
+
+struct axp_data {
+	const struct power_supply_desc	*power_desc;
+	const char * const		*irq_names;
+	enum axp20x_variants		axp20x_id;
+};
+
+static const struct axp_data axp202_data = {
+	.power_desc	= &axp20x_usb_power_desc,
+	.irq_names	= axp20x_irq_names,
+	.axp20x_id	= AXP202_ID,
+};
+
+static const struct axp_data axp221_data = {
+	.power_desc	= &axp22x_usb_power_desc,
+	.irq_names	= axp22x_irq_names,
+	.axp20x_id	= AXP221_ID,
+};
+
+static const struct axp_data axp223_data = {
+	.power_desc	= &axp22x_usb_power_desc,
+	.irq_names	= axp22x_irq_names,
+	.axp20x_id	= AXP223_ID,
+};
+
+static const struct axp_data axp813_data = {
+	.power_desc	= &axp22x_usb_power_desc,
+	.irq_names	= axp22x_irq_names,
+	.axp20x_id	= AXP813_ID,
+};
+
 static int configure_iio_channels(struct platform_device *pdev,
 				  struct axp20x_usb_power *power)
 {
@@ -440,12 +484,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
 	struct power_supply_config psy_cfg = {};
 	struct axp20x_usb_power *power;
-	static const char * const axp20x_irq_names[] = { "VBUS_PLUGIN",
-		"VBUS_REMOVAL", "VBUS_VALID", "VBUS_NOT_VALID", NULL };
-	static const char * const axp22x_irq_names[] = {
-		"VBUS_PLUGIN", "VBUS_REMOVAL", NULL };
-	const char * const *irq_names;
-	const struct power_supply_desc *usb_power_desc;
+	const struct axp_data *axp_data;
 	int i, irq, ret;
 
 	if (!of_device_is_available(pdev->dev.of_node))
@@ -461,9 +500,9 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, power);
-	power->axp20x_id = (enum axp20x_variants)of_device_get_match_data(
-								&pdev->dev);
 
+	axp_data = of_device_get_match_data(&pdev->dev);
+	power->axp20x_id = axp_data->axp20x_id;
 	power->regmap = axp20x->regmap;
 
 	if (power->axp20x_id == AXP202_ID) {
@@ -481,18 +520,6 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 
 		if (ret)
 			return ret;
-
-		usb_power_desc = &axp20x_usb_power_desc;
-		irq_names = axp20x_irq_names;
-	} else if (power->axp20x_id == AXP221_ID ||
-		   power->axp20x_id == AXP223_ID ||
-		   power->axp20x_id == AXP813_ID) {
-		usb_power_desc = &axp22x_usb_power_desc;
-		irq_names = axp22x_irq_names;
-	} else {
-		dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
-			axp20x->variant);
-		return -EINVAL;
 	}
 
 	if (power->axp20x_id == AXP813_ID) {
@@ -504,17 +531,18 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	psy_cfg.of_node = pdev->dev.of_node;
 	psy_cfg.drv_data = power;
 
-	power->supply = devm_power_supply_register(&pdev->dev, usb_power_desc,
+	power->supply = devm_power_supply_register(&pdev->dev,
+						   axp_data->power_desc,
 						   &psy_cfg);
 	if (IS_ERR(power->supply))
 		return PTR_ERR(power->supply);
 
 	/* Request irqs after registering, as irqs may trigger immediately */
-	for (i = 0; irq_names[i]; i++) {
-		irq = platform_get_irq_byname(pdev, irq_names[i]);
+	for (i = 0; axp_data->irq_names[i]; i++) {
+		irq = platform_get_irq_byname(pdev, axp_data->irq_names[i]);
 		if (irq < 0) {
 			dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
-				 irq_names[i], irq);
+				 axp_data->irq_names[i], irq);
 			continue;
 		}
 		irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
@@ -522,7 +550,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 				axp20x_usb_power_irq, 0, DRVNAME, power);
 		if (ret < 0)
 			dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\n",
-				 irq_names[i], ret);
+				 axp_data->irq_names[i], ret);
 	}
 
 	INIT_DELAYED_WORK(&power->vbus_detect, axp20x_usb_power_poll_vbus);
@@ -544,16 +572,16 @@ static int axp20x_usb_power_remove(struct platform_device *pdev)
 static const struct of_device_id axp20x_usb_power_match[] = {
 	{
 		.compatible = "x-powers,axp202-usb-power-supply",
-		.data = (void *)AXP202_ID,
+		.data = &axp202_data,
 	}, {
 		.compatible = "x-powers,axp221-usb-power-supply",
-		.data = (void *)AXP221_ID,
+		.data = &axp221_data,
 	}, {
 		.compatible = "x-powers,axp223-usb-power-supply",
-		.data = (void *)AXP223_ID,
+		.data = &axp223_data,
 	}, {
 		.compatible = "x-powers,axp813-usb-power-supply",
-		.data = (void *)AXP813_ID,
+		.data = &axp813_data,
 	}, { /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, axp20x_usb_power_match);
-- 
2.23.0

