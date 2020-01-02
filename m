Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F90312E313
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2020 07:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgABGgh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jan 2020 01:36:37 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60603 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726292AbgABGgh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2020 01:36:37 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 325232215D;
        Thu,  2 Jan 2020 01:36:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 Jan 2020 01:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=H82xRxh61bgTh
        G+kaAbvv3z6nkx0cTMFo2BWr0/QYbw=; b=GtaVPc2GiIm9f2M2I0CSSoacc+aZM
        IHOUkZ86gGmbNS46Sqkq9lTTZ44daeKmzQ2gF/zV7MR0iRUIE8ZeQxde7dN//yIU
        QDTCOUa27KmeBcKQ1MBQHoOi3WNuw2O7SsVb+asohzkpBpHi8qUN2DQtXqJdkzLr
        3atspx0QuOmFglAajWMunhmcQ62IiSGb6v2tJ0B8YLZ8W1Dx54VM049ftK8tcxDl
        SBD7pzw3Q0d+yStPUzFE+uyGSUtCL+mQfma7OIhPeK7PiCsj7RL8jQxLjPtolFip
        znFH9f1s5yim1+gOl9eD13CgPDr8uyPIoHejx4tExV0/H/hFjgu+y/sRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=H82xRxh61bgThG+kaAbvv3z6nkx0cTMFo2BWr0/QYbw=; b=IIFrD+Zx
        m76/iySeAlMli51Ps7vsFE00ordyQ0sy0R6uVfxMpXHZXxGdfgf24Uf2HLHJ8Tlv
        QX1VpsGP6OcWVOJ/dELoXlqNziDGS3OEfLkHlIHJcHSSxAZX2bhNtnASw9v6kWl9
        lsznvf0GSQqRiKGR84MKAwg/vy0FPaB/jpYknjeHNgqO3a68sVOCbRb9goUNZerW
        12+p58AZrDrlbcl2tqqJ8idQqgSU8aSx1mAOTrw8Ll4qUjbj0H0JwmvGInJM8/aI
        q6pPiq30wa8pAbhLyiT5plgqR8drWjNy7XpE5lzkBEG/8pDTYZiZ1E24Eqrn8xw0
        pFpffRFSXsXGVQ==
X-ME-Sender: <xms:dI8NXjfUnKFHcdMWYGbu7ShdicjwQeOiwYoKKbTisj2az99bSQU4qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdegtddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:dI8NXq0kM0957X8Jhjn81EJkPNUJFyMFO_fTvwCkD4PceugwnhDB8A>
    <xmx:dI8NXrO1JyWOTCufsaAnQfnV9LXjK6cGjkJU0xG5McU9FkKkfoEa8Q>
    <xmx:dI8NXteGIvI0Da-BBO3iGzvLEOzien6_6nApn69QN2J1ujxH8rWflA>
    <xmx:dI8NXu6VmkqyXW9_zrNWt9vL-mI3cdF8Ylh3-uG9KhjDju9wNs6Q-g>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 987C480059;
        Thu,  2 Jan 2020 01:36:35 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 4/7] power: supply: axp20x_usb_power: Use a match structure
Date:   Thu,  2 Jan 2020 00:36:30 -0600
Message-Id: <20200102063633.65388-4-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200102063633.65388-1-samuel@sholland.org>
References: <20200102063633.65388-1-samuel@sholland.org>
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

