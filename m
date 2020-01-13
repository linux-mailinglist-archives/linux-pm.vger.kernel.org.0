Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4144138A04
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 04:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387598AbgAMDxV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jan 2020 22:53:21 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53963 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387554AbgAMDxO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jan 2020 22:53:14 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CDFFC21E29;
        Sun, 12 Jan 2020 22:53:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 12 Jan 2020 22:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=tP5rdRHswnvAA
        e51NTPo8tR712TUgFQuWQxKZmMe5GM=; b=dKF9CSddxudc3ArQ7N7yOy3739ZQJ
        LY54BQL5YP38nE0tk4+NTHjhg2GSgX1rHaYs15n+3WGX6XiSToF55/E6Q3um/Okk
        5M4dGCsqUWF0y5MENJkU17+A4DTQT0wbklv5zn4qFvvTcgVdhEnbHkNppQeTjdQk
        yXfXT5lyRVHJRLBknLe3gZ+upolcCusdF+hXusdDWPIH+s8Vj7Vcre4ZWdvD95c3
        eWNZLIpMzKEKkmavz7Npa5cYEMFPYI5t6E8n8aNqRy6TFBkn73cPIjnC6jSgJlq+
        lwUpV6hml+uX1krmX+YQ8DQlIDfXvfu480LgmRwSj/FTH1apyBZVUHCgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=tP5rdRHswnvAAe51NTPo8tR712TUgFQuWQxKZmMe5GM=; b=KGIeyTaq
        1pTiu6ChPeR5OMz+DByjMiilJUFMV8eFnBsgwZ8BsniZSA3WIRXhyGM/jATr4qtX
        oxAHN1GDYNqSOj+wtTzjkz1P/WHDW6JTWxXhgvi/ivOma5NE7whEKQ6EaKKJx88l
        BPKgd0VYdPjupYK4OFO5vb6v/px2rVYsfh06F0SRrYWAaFPQgWi0UFKLGRUUw/q9
        KHCgM4qR/bx4qrfdJL0b2ZvU11uuQrUMZiEEgem0IOXwYFbho79scLdXwXteNeFs
        qYgwycTnsDSSC+HgVXAwg32E1AKAQQbuSNy6t5yjgnRtUPcIq69xFny/M5iqFIMU
        m96mW0rlrGNOaQ==
X-ME-Sender: <xms:qekbXtuZN56SZFKEE4tjHFjZf8O1-DP_8l8_44jaW4Gn_7iE90Hh5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:qekbXuHGlbPiQEDMOy2dTE0pI6lWAeYh1jGNXBd5jqe0eRGVryc6Lg>
    <xmx:qekbXr8ffLmiys-qEM914tZM4dfOP0-4naC3_vCuStoICdlRoorDnQ>
    <xmx:qekbXuiDkwj8H9wJMMrRb7sk0S_zXz4ov5__U13-WhC5J3_a2we70w>
    <xmx:qekbXt9yKcbFweuHKWM7AbPP_N6ZKMjKifsvzYR5w-ub_dGKn9EbZg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 410638005C;
        Sun, 12 Jan 2020 22:53:13 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>,
        Oskari Lemmela <oskari@lemmela.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 5/8] power: supply: axp20x_usb_power: Use a match structure
Date:   Sun, 12 Jan 2020 21:53:07 -0600
Message-Id: <20200113035310.18950-6-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200113035310.18950-1-samuel@sholland.org>
References: <20200113035310.18950-1-samuel@sholland.org>
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

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/power/supply/axp20x_usb_power.c | 86 ++++++++++++++++---------
 1 file changed, 57 insertions(+), 29 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 2573de2a0adc..cd89ee12dd18 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -403,6 +403,50 @@ static const struct power_supply_desc axp22x_usb_power_desc = {
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
@@ -438,12 +482,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
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
@@ -459,9 +498,9 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, power);
-	power->axp20x_id = (enum axp20x_variants)of_device_get_match_data(
-								&pdev->dev);
 
+	axp_data = of_device_get_match_data(&pdev->dev);
+	power->axp20x_id = axp_data->axp20x_id;
 	power->regmap = axp20x->regmap;
 
 	if (power->axp20x_id == AXP202_ID) {
@@ -479,34 +518,23 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 
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
@@ -514,7 +542,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 				axp20x_usb_power_irq, 0, DRVNAME, power);
 		if (ret < 0)
 			dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\n",
-				 irq_names[i], ret);
+				 axp_data->irq_names[i], ret);
 	}
 
 	INIT_DELAYED_WORK(&power->vbus_detect, axp20x_usb_power_poll_vbus);
@@ -536,16 +564,16 @@ static int axp20x_usb_power_remove(struct platform_device *pdev)
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

