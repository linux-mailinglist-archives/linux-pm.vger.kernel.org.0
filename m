Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86BB012E31A
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2020 07:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgABGgr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jan 2020 01:36:47 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48643 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726481AbgABGgi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2020 01:36:38 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E11352223C;
        Thu,  2 Jan 2020 01:36:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 Jan 2020 01:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=caEQPnHTeEFjc
        B3ccMf2T6AEOtDp0lmSqGyWQ95bf+8=; b=bbnFX1Hme4IPu6TMrKvIhRvi4K7U7
        w/M2PlsH2WJhAmJjUk97+eQ9rEfXME3Yv7kg+paHwWrPHDSemfOJecT/p8dLz/pK
        DvOYA4MgO89mdFMNZl1VHUt4RwgyA9eMqITpy8vY+pCmz8t6tUmleCVxY5gwzGFA
        5zMarxGpzz+vtANqy1m2L93/DQTy8v04IFo4dqeO42NFFUpn8jmlIrsAPrg5Apqu
        F3EZIrOglycq9RWYaiN4FaVaoFoGlS6sg+eQRLLzLxursw7p+9oX2qKTT/N2YNYG
        4BpCnib/boZEFg2okfHo2JSo5LqMCMWMCv/CgWxlNjVF3X2ewUzqs75Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=caEQPnHTeEFjcB3ccMf2T6AEOtDp0lmSqGyWQ95bf+8=; b=SzxGl5ZR
        LEb1a81H+UVrzzjhhFExQw9+tQRqU4M6iY+litY2kjE2wf4ZANsH70tZPaR/PMuC
        xTQISJYOrDQ2ITxnfThIqSPwmmT+h2Yniv9dl3D6k51mCHWGIBREsxwFPwd+e751
        knuXppPG3J/vJ+IEEhS+bNgzjcrgLyXmPQnkOKwQCBitQpanCcuhJOJnM9BQA/JR
        fed9XUUMq3Q2tPXTPcKQMEyZ8vBBDu1eQQtrXKAkePVnbS9npbRP6uy8+qF06IQV
        LNpKYd/4kEl5GiC4W0tB42k1BrQAT/nt2m5Mlha0bwZrDb2i5HlCJM2b4CtJ683M
        yfiJtCHhEO1/yA==
X-ME-Sender: <xms:dI8NXr_tCujMmodSSE52-Lhmc73p1xKjjsZ8K3pUROIKU-3_JZoADw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdegtddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:dI8NXnSS7DmjtQQjDKYbEaknY6XSQPtsEU9y0x-sAcmW0Lx5m5BAVA>
    <xmx:dI8NXtE08i0GQnSZ4PM_h0ORDHGxsGNf-JO7-MH0YryNzshPZuS0XA>
    <xmx:dI8NXnPSss3vbt6kQH5_2FSav1MCyWzGcjAlbCq-JkD7FpXr7UsqFQ>
    <xmx:dI8NXgQZl8Xy0vo-wEeOalRfM_ZTNgFIXs1Jwfts7PWWSrZ_xVjUXw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5BAFF80059;
        Thu,  2 Jan 2020 01:36:36 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 6/7] power: supply: axp20x_usb_power: Add wakeup control
Date:   Thu,  2 Jan 2020 00:36:32 -0600
Message-Id: <20200102063633.65388-6-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200102063633.65388-1-samuel@sholland.org>
References: <20200102063633.65388-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The USB power supply input can be used as a wakeup source. Hook up the
VBUS_PLUGIN IRQ to trigger wakeup based on userspace configuration.

To do this, we must remember the list of IRQs for the life of the
device. To know how much space to allocate for the flexible array
member, we switch from using a NULL sentinel to using an array length.

Because we now depend on the specific order of the IRQs (we assume
VBUS_PLUGIN is first and always present), failing to acquire an IRQ
during probe must be a fatal error.

To avoid spuriously waking up the system when the USB power supply is
not configured as a wakeup source, we must explicitly disable all non-
wake IRQs during system suspend. This is because the SoC's NMI input is
shared among all IRQs on the AXP PMIC. Due to the use of regmap-irq, the
individual IRQs within the PMIC are nested threaded interrupts, and are
therefore not automatically disabled during system suspend.

The upshot is that if any other device within the MFD (such as the power
key) is an enabled wakeup source, all enabled IRQs within the PMIC will
cause wakeup. We still need to call enable_irq_wake() when we *do* want
wakeup, in case those other wakeup sources on the PMIC are all disabled.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/power/supply/axp20x_usb_power.c | 80 ++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index f49c8ff4a3f0..16062b2c7ea8 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -66,6 +67,8 @@ struct axp20x_usb_power {
 	struct iio_channel *vbus_i;
 	struct delayed_work vbus_detect;
 	unsigned int old_status;
+	unsigned int num_irqs;
+	unsigned int irqs[];
 };
 
 static irqreturn_t axp20x_usb_power_irq(int irq, void *devid)
@@ -429,45 +432,85 @@ static const char * const axp20x_irq_names[] = {
 	"VBUS_REMOVAL",
 	"VBUS_VALID",
 	"VBUS_NOT_VALID",
-	NULL
 };
 
 static const char * const axp22x_irq_names[] = {
 	"VBUS_PLUGIN",
 	"VBUS_REMOVAL",
-	NULL
 };
 
 struct axp_data {
 	const struct power_supply_desc	*power_desc;
 	const char * const		*irq_names;
+	unsigned int			num_irq_names;
 	enum axp20x_variants		axp20x_id;
 };
 
 static const struct axp_data axp202_data = {
 	.power_desc	= &axp20x_usb_power_desc,
 	.irq_names	= axp20x_irq_names,
+	.num_irq_names	= ARRAY_SIZE(axp20x_irq_names),
 	.axp20x_id	= AXP202_ID,
 };
 
 static const struct axp_data axp221_data = {
 	.power_desc	= &axp22x_usb_power_desc,
 	.irq_names	= axp22x_irq_names,
+	.num_irq_names	= ARRAY_SIZE(axp22x_irq_names),
 	.axp20x_id	= AXP221_ID,
 };
 
 static const struct axp_data axp223_data = {
 	.power_desc	= &axp22x_usb_power_desc,
 	.irq_names	= axp22x_irq_names,
+	.num_irq_names	= ARRAY_SIZE(axp22x_irq_names),
 	.axp20x_id	= AXP223_ID,
 };
 
 static const struct axp_data axp813_data = {
 	.power_desc	= &axp22x_usb_power_desc,
 	.irq_names	= axp22x_irq_names,
+	.num_irq_names	= ARRAY_SIZE(axp22x_irq_names),
 	.axp20x_id	= AXP813_ID,
 };
 
+#if CONFIG_PM_SLEEP
+static int axp20x_usb_power_suspend(struct device *dev)
+{
+	struct axp20x_usb_power *power = dev_get_drvdata(dev);
+	int i = 0;
+
+	/*
+	 * Allow wake via VBUS_PLUGIN only.
+	 *
+	 * As nested threaded IRQs are not automatically disabled during
+	 * suspend, we must explicitly disable the remainder of the IRQs.
+	 */
+	if (device_may_wakeup(&power->supply->dev))
+		enable_irq_wake(power->irqs[i++]);
+	while (i < power->num_irqs)
+		disable_irq(power->irqs[i++]);
+
+	return 0;
+}
+
+static int axp20x_usb_power_resume(struct device *dev)
+{
+	struct axp20x_usb_power *power = dev_get_drvdata(dev);
+	int i = 0;
+
+	if (device_may_wakeup(&power->supply->dev))
+		disable_irq_wake(power->irqs[i++]);
+	while (i < power->num_irqs)
+		enable_irq(power->irqs[i++]);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(axp20x_usb_power_pm_ops, axp20x_usb_power_suspend,
+						  axp20x_usb_power_resume);
+
 static int configure_iio_channels(struct platform_device *pdev,
 				  struct axp20x_usb_power *power)
 {
@@ -516,12 +559,15 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 
 	axp_data = of_device_get_match_data(&pdev->dev);
 
-	power = devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL);
+	power = devm_kzalloc(&pdev->dev,
+			     struct_size(power, irqs, axp_data->num_irq_names),
+			     GFP_KERNEL);
 	if (!power)
 		return -ENOMEM;
 
 	power->regmap = axp20x->regmap;
 	power->axp20x_id = axp_data->axp20x_id;
+	power->num_irqs = axp_data->num_irq_names;
 
 	platform_set_drvdata(pdev, power);
 
@@ -558,19 +604,22 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		return PTR_ERR(power->supply);
 
 	/* Request irqs after registering, as irqs may trigger immediately */
-	for (i = 0; axp_data->irq_names[i]; i++) {
+	for (i = 0; i < axp_data->num_irq_names; i++) {
 		irq = platform_get_irq_byname(pdev, axp_data->irq_names[i]);
 		if (irq < 0) {
-			dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
-				 axp_data->irq_names[i], irq);
-			continue;
+			dev_err(&pdev->dev, "No IRQ for %s: %d\n",
+				axp_data->irq_names[i], irq);
+			return irq;
+		}
+		power->irqs[i] = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
+		ret = devm_request_any_context_irq(&pdev->dev, power->irqs[i],
+						   axp20x_usb_power_irq, 0,
+						   DRVNAME, power);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Error requesting %s IRQ: %d\n",
+				axp_data->irq_names[i], ret);
+			return ret;
 		}
-		irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
-		ret = devm_request_any_context_irq(&pdev->dev, irq,
-				axp20x_usb_power_irq, 0, DRVNAME, power);
-		if (ret < 0)
-			dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\n",
-				 axp_data->irq_names[i], ret);
 	}
 
 	INIT_DELAYED_WORK(&power->vbus_detect, axp20x_usb_power_poll_vbus);
@@ -610,8 +659,9 @@ static struct platform_driver axp20x_usb_power_driver = {
 	.probe = axp20x_usb_power_probe,
 	.remove = axp20x_usb_power_remove,
 	.driver = {
-		.name = DRVNAME,
-		.of_match_table = axp20x_usb_power_match,
+		.name		= DRVNAME,
+		.of_match_table	= axp20x_usb_power_match,
+		.pm		= &axp20x_usb_power_pm_ops,
 	},
 };
 
-- 
2.23.0

