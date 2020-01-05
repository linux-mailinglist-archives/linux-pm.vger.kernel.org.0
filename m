Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE94130563
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2020 02:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgAEBYn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Jan 2020 20:24:43 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36831 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726487AbgAEBYU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Jan 2020 20:24:20 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A344521CDD;
        Sat,  4 Jan 2020 20:24:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 04 Jan 2020 20:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=H82xRxh61bgTh
        G+kaAbvv3z6nkx0cTMFo2BWr0/QYbw=; b=c77H3IeUZSF1kcVIXfRFWOYzUCA71
        IXzRQ/4tRnzSA66hVCj6f4dBbJuYCIz+F50z4SjePtjunwfBidUYOta2hgtxEFyL
        29GthbH01MF8OqY3AKaArKQH+B8VfIHvnfmXs+mL7bTOaix9ZTDbOXN+7yGEzkVw
        YeiBmQZTpvmlFOfh54DVFZJXhv4LyX012mVTQBxkgIwYrA52gZnDUXspJZG5Ehsu
        9ZPpa04OeWodSH1SqnAGNURqVoHToBvVbodvQ5WnxvL5gDgYnZrWXOF/5Cb6GBGP
        C1cJIUhTWtug0g/kw+n56HMDngZWEWqvfxoH+rHHfWjXM8B3dIJAAa3Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=H82xRxh61bgThG+kaAbvv3z6nkx0cTMFo2BWr0/QYbw=; b=qZ1Nbzxk
        25tCskdnJaT6zhKqgbVs8q5NiBhL+2CJCZJtn2ByRaEkUBCkWWs1WGK3tyfb9Jys
        0KKU3NLEtUseej5PDgEoVCxKRjn3nageA/FwbJEcgNdwhassfls2j/tsTaqEKvvA
        1Mt8QMLq0ptxENjadF11vh1LVZ6DRVw+4ezJOaRTzQsarwIm/Vd+WuAxLwBHdBYc
        n+vNmXOCRZomjUse1IU7iHJ8P1hJPiu3jd5nlW8UH6TYZoIoWjBX2ikOVb+HNgOx
        c3IS0poOsxlTmCX5N0lTRWLTjvk5MWlbzCp+6z0gNl/DAwstdG9cG3CtvM7U76LK
        Z/FXJKldTv31Jg==
X-ME-Sender: <xms:wzoRXtqMGurRYWZgUHzZ04P8csBZAcpC0B-ODiIsUKIK6xxdapZi-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdegiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:wzoRXmPed4J6ACG-AgFbbMmg7qS5fUg4xHOwuReYFbLvNgWTyacy3A>
    <xmx:wzoRXr7__TAnf8cm5khe5vWKf9em5w_E-K0EZKaMcNNsrsaNQJ21fg>
    <xmx:wzoRXiXqAUkUGGjqNesxqz94b-_78s_1JaRHhvFyeMtOcBF-BIewdg>
    <xmx:wzoRXiN1ZgJAa6GPwCE1X-hCHw7pwh2xzeo6V1IZpbDpKbSznpdgkQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id F30F080061;
        Sat,  4 Jan 2020 20:24:18 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 6/9] power: supply: axp20x_usb_power: Use a match structure
Date:   Sat,  4 Jan 2020 19:24:13 -0600
Message-Id: <20200105012416.23296-7-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200105012416.23296-1-samuel@sholland.org>
References: <20200105012416.23296-1-samuel@sholland.org>
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

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/power/supply/axp20x_usb_power.c | 91 ++++++++++++++++---------
 1 file changed, 60 insertions(+), 31 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index dd3f3f12e41d..2d7272e19a87 100644
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
@@ -456,15 +495,16 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	axp_data = of_device_get_match_data(&pdev->dev);
+
 	power = devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL);
 	if (!power)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, power);
-	power->axp20x_id = (enum axp20x_variants)of_device_get_match_data(
-								&pdev->dev);
-
 	power->regmap = axp20x->regmap;
+	power->axp20x_id = axp_data->axp20x_id;
+
+	platform_set_drvdata(pdev, power);
 
 	if (power->axp20x_id == AXP202_ID) {
 		/* Enable vbus valid checking */
@@ -481,18 +521,6 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 
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
@@ -504,17 +532,18 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
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
@@ -522,7 +551,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 				axp20x_usb_power_irq, 0, DRVNAME, power);
 		if (ret < 0)
 			dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\n",
-				 irq_names[i], ret);
+				 axp_data->irq_names[i], ret);
 	}
 
 	INIT_DELAYED_WORK(&power->vbus_detect, axp20x_usb_power_poll_vbus);
@@ -544,16 +573,16 @@ static int axp20x_usb_power_remove(struct platform_device *pdev)
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

