Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1276013B832
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 04:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgAODky (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 22:40:54 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41373 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729061AbgAODkw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 22:40:52 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id EA65E22138;
        Tue, 14 Jan 2020 22:40:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 14 Jan 2020 22:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=KQFR8kPZD6D3w
        XqLJBfc7mBAUnyFMy2alXybJXUpbSE=; b=Q2n9snhjH+4cJql1sJJMpyonzuqBW
        35mTvRLw1oxMdFLKr01aelhSFSZpAFYev1Osn9WxgZcw+h/y9DRgq+ukMYRjdDJ8
        EF2W4PBVKm+SBsMoFTOQwJnjm77TyvGjQx0ZRVieZskwLqbjWwheSkXlZIvh66cO
        yCj6Q/g2nZUdIWgkQt8vcdhXzLgFsJp0XrgOvJXIYCRYr4H8xbShHNIWkuFgsRrU
        dWW0GOcoMazBYDEyhT902dUWXyFDJHMs0tD9nEuz4KmOvWDgfJ8eUddAzObS1HCC
        Rl9/4ah3G2hAige7/VEfYPNxYq4eqpweMgACf3id/fUpduZVZq4SHAeSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=KQFR8kPZD6D3wXqLJBfc7mBAUnyFMy2alXybJXUpbSE=; b=pA5wxifr
        kokNJ0DYW1OemRzw5zorWd70gxjbOcYdqRYarS9DWCgHg+tbgcx2VkAvwngar06m
        Y5EWKqiQ3APAy4Npzyv9sqGzPrCfRBKW3lxyxrtqBa/DwhHLSOw/87BGg5pNJ9HS
        4fSr5CV8FNb5vUwJd0dmMauaJ21mrxNQZnNuBiraoR0qUu1O7B3US9trlqz+z73Y
        xbQDI60tWvZGh5qQWnSF5kaPC2eoZK9nj0ea+EhqpdSBIHYnG/Ut9fJOdFxPFAP8
        4WzgV2Qnf9pDJsrNWccAGdh06cM8J98xLJJeRJ17zdIMILANDHixhK7E2FsX+kkB
        LKequW3k2rEeEQ==
X-ME-Sender: <xms:wokeXvm-tK1fnm4a3s2jvfCZOb800s2ETWWyzukjjdQJFcZryjziXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrtddvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:wokeXu62E1LJjxb1EuiDIE98MVpOfYMWqf6BD28_KKGS0KNLwm4Pbw>
    <xmx:wokeXg-tlQnu4kPB7zAThGMo3NY_hjJERVnEHibtjySIx98ivh1q3w>
    <xmx:wokeXmiGdh7BLfXj_qvGt2X04h8laGeA2JIIhoTLenwQmuX7n5jZsA>
    <xmx:wokeXstZVYZQK2-bAGLQaExe_rCRzajVmbqnIthSWfJMUk6HfrgHrw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7883730602DE;
        Tue, 14 Jan 2020 22:40:50 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Oskari Lemmela <oskari@lemmela.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 3/4] power: supply: axp20x_usb_power: Add wakeup control
Date:   Tue, 14 Jan 2020 21:40:47 -0600
Message-Id: <20200115034048.24901-4-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200115034048.24901-1-samuel@sholland.org>
References: <20200115034048.24901-1-samuel@sholland.org>
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

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/power/supply/axp20x_usb_power.c | 83 ++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index f14736041c41..1732304bc96e 100644
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
@@ -67,6 +68,8 @@ struct axp20x_usb_power {
 	struct iio_channel *vbus_i;
 	struct delayed_work vbus_detect;
 	unsigned int old_status;
+	unsigned int num_irqs;
+	unsigned int irqs[];
 };
 
 static irqreturn_t axp20x_usb_power_irq(int irq, void *devid)
@@ -440,45 +443,85 @@ static const char * const axp20x_irq_names[] = {
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
 
+#ifdef CONFIG_PM_SLEEP
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
@@ -525,15 +568,19 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	power = devm_kzalloc(&pdev->dev, sizeof(*power), GFP_KERNEL);
+	axp_data = of_device_get_match_data(&pdev->dev);
+
+	power = devm_kzalloc(&pdev->dev,
+			     struct_size(power, irqs, axp_data->num_irq_names),
+			     GFP_KERNEL);
 	if (!power)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, power);
 
-	axp_data = of_device_get_match_data(&pdev->dev);
 	power->axp20x_id = axp_data->axp20x_id;
 	power->regmap = axp20x->regmap;
+	power->num_irqs = axp_data->num_irq_names;
 
 	if (power->axp20x_id == AXP202_ID) {
 		/* Enable vbus valid checking */
@@ -568,19 +615,22 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
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
@@ -620,8 +670,9 @@ static struct platform_driver axp20x_usb_power_driver = {
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

