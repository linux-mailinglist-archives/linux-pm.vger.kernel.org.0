Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC8012E31D
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2020 07:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgABGgh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jan 2020 01:36:37 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38687 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726050AbgABGgg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2020 01:36:36 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 67F7D22022;
        Thu,  2 Jan 2020 01:36:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 Jan 2020 01:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=5E2Z1B5s9ul8W
        sz8hqXds2n/amt1/rnEjWZTm6f4JAg=; b=jOERHjMZ1dJ1OnWoqqgRh1737sWot
        UsXSq8Lih7iVtzi125Vq2jTMNGEdWZkKWiansCnxSsFfKH0xRgrlPfWfKqCC/AXT
        vZrqzKDm8YWieWf95CCW0dgwMQuIRZ+1U9DV9MquCxpl9k0fNNy58dlsIlt5ml4E
        vySsyxHQEJXr+2i2jfre3mP9FXZcpyWlGzkjXCFcqsFK60/1EzN269m2nG/Sm2gr
        hoSvxTcb6Qr9Kyr7G3RPrsJC3MWjMtnAfEc1WuC527rapTTJ73CEmMDA8RTILZJq
        WiNRFO78fOQa7vY4Lowq0Xa7o0Y1mFAZT3UoofiLgGhMPi+ccK8j07yWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=5E2Z1B5s9ul8Wsz8hqXds2n/amt1/rnEjWZTm6f4JAg=; b=JpIWxztj
        y3huX+UkfJCVb78K6ZHD/UNSjnA1mU2XTygRERPKm+jNno92ORRKfcRPk8lHGGDr
        dcpK5qDGUmCxtI6W5zEcUe1hgZnrjdcA8Z9nTf7IJ6ZwHRL5FSXBLkXtgha/9u5G
        wfUX5QhoMGTZJcZcHAgagYosNggYwBvtRqY0BrdWiTeVxU6fz/cKdKm+HmpHT3ge
        u3t58TQASJw2JR6yo4dEW0iiCbJBEf/wXvcNqMO2nfYpPqDQAVWnRQRqvpnU9xrA
        QpwhWtsFQ/ejg3TVvM0vGqiMuoX4oEcnCZCzBBh+6Awc+FoRZQYzo8zWsjVa+oqp
        lzi4hefTmjy9zQ==
X-ME-Sender: <xms:c48NXp-5VarHzj4lZMd4IwsXLIwwT30kEy30gkR9Kuj1rGl3beVeyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdegtddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:c48NXrjw-GQR_nsLadqDRaBiW_1C9Z8hlj62BDPSGYlO-IR6jReiMQ>
    <xmx:c48NXhcEJc3O-Hg1EZGM28pgeGYAjANyN6qCyc4xJPHVBrwuP0Wpxw>
    <xmx:c48NXqq1OaC6XTQ67zetCpjf_2e6KmAEkeUir4zlQjwzT9t02tdaFg>
    <xmx:c48NXqBWl-P_jvlGfdlV1cRVI_-BTJR2oYRNiFHNkaCSJ-SRStnqqg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id D775080059;
        Thu,  2 Jan 2020 01:36:34 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/7] power: supply: axp20x_ac_power: Add wakeup control
Date:   Thu,  2 Jan 2020 00:36:28 -0600
Message-Id: <20200102063633.65388-2-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200102063633.65388-1-samuel@sholland.org>
References: <20200102063633.65388-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The AC power supply input can be used as a wakeup source. Hook up the
ACIN_PLUGIN IRQ to trigger wakeup based on userspace configuration.

To do this, we must remember the list of IRQs for the life of the
device. To know how much space to allocate for the flexible array
member, we switch from using a NULL sentinel to using an array length.

Because we now depend on the specific order of the IRQs (we assume
ACIN_PLUGIN is first and always present), failing to acquire an IRQ
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
 drivers/power/supply/axp20x_ac_power.c | 103 +++++++++++++++++++------
 1 file changed, 80 insertions(+), 23 deletions(-)

diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
index 4410e7b89383..6f172cc62826 100644
--- a/drivers/power/supply/axp20x_ac_power.c
+++ b/drivers/power/supply/axp20x_ac_power.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/power_supply.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -42,6 +43,8 @@ struct axp20x_ac_power {
 	struct power_supply *supply;
 	struct iio_channel *acin_v;
 	struct iio_channel *acin_i;
+	unsigned int num_irqs;
+	unsigned int irqs[];
 };
 
 static irqreturn_t axp20x_ac_power_irq(int irq, void *devid)
@@ -229,34 +232,82 @@ static const struct power_supply_desc axp813_ac_power_desc = {
 	.set_property = axp813_ac_power_set_property,
 };
 
+static const char * const axp20x_irq_names[] = {
+	"ACIN_PLUGIN",
+	"ACIN_REMOVAL",
+};
+
 struct axp_data {
 	const struct power_supply_desc	*power_desc;
+	const char * const		*irq_names;
+	unsigned int			num_irq_names;
 	bool				acin_adc;
 };
 
 static const struct axp_data axp20x_data = {
-	.power_desc = &axp20x_ac_power_desc,
-	.acin_adc = true,
+	.power_desc	= &axp20x_ac_power_desc,
+	.irq_names	= axp20x_irq_names,
+	.num_irq_names	= ARRAY_SIZE(axp20x_irq_names),
+	.acin_adc	= true,
 };
 
 static const struct axp_data axp22x_data = {
-	.power_desc = &axp22x_ac_power_desc,
-	.acin_adc = false,
+	.power_desc	= &axp22x_ac_power_desc,
+	.irq_names	= axp20x_irq_names,
+	.num_irq_names	= ARRAY_SIZE(axp20x_irq_names),
+	.acin_adc	= false,
 };
 
 static const struct axp_data axp813_data = {
-	.power_desc = &axp813_ac_power_desc,
-	.acin_adc = false,
+	.power_desc	= &axp813_ac_power_desc,
+	.irq_names	= axp20x_irq_names,
+	.num_irq_names	= ARRAY_SIZE(axp20x_irq_names),
+	.acin_adc	= false,
 };
 
+#if CONFIG_PM_SLEEP
+static int axp20x_ac_power_suspend(struct device *dev)
+{
+	struct axp20x_ac_power *power = dev_get_drvdata(dev);
+	int i = 0;
+
+	/*
+	 * Allow wake via ACIN_PLUGIN only.
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
+static int axp20x_ac_power_resume(struct device *dev)
+{
+	struct axp20x_ac_power *power = dev_get_drvdata(dev);
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
+static SIMPLE_DEV_PM_OPS(axp20x_ac_power_pm_ops, axp20x_ac_power_suspend,
+						 axp20x_ac_power_resume);
+
 static int axp20x_ac_power_probe(struct platform_device *pdev)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
 	struct power_supply_config psy_cfg = {};
 	struct axp20x_ac_power *power;
 	const struct axp_data *axp_data;
-	static const char * const irq_names[] = { "ACIN_PLUGIN", "ACIN_REMOVAL",
-		NULL };
 	int i, irq, ret;
 
 	if (!of_device_is_available(pdev->dev.of_node))
@@ -267,12 +318,14 @@ static int axp20x_ac_power_probe(struct platform_device *pdev)
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
 
-	axp_data = of_device_get_match_data(&pdev->dev);
-
 	if (axp_data->acin_adc) {
 		power->acin_v = devm_iio_channel_get(&pdev->dev, "acin_v");
 		if (IS_ERR(power->acin_v)) {
@@ -290,6 +343,7 @@ static int axp20x_ac_power_probe(struct platform_device *pdev)
 	}
 
 	power->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	power->num_irqs = axp_data->num_irq_names;
 
 	platform_set_drvdata(pdev, power);
 
@@ -303,20 +357,22 @@ static int axp20x_ac_power_probe(struct platform_device *pdev)
 		return PTR_ERR(power->supply);
 
 	/* Request irqs after registering, as irqs may trigger immediately */
-	for (i = 0; irq_names[i]; i++) {
-		irq = platform_get_irq_byname(pdev, irq_names[i]);
+	for (i = 0; i < axp_data->num_irq_names; i++) {
+		irq = platform_get_irq_byname(pdev, axp_data->irq_names[i]);
 		if (irq < 0) {
-			dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
-				 irq_names[i], irq);
-			continue;
+			dev_err(&pdev->dev, "No IRQ for %s: %d\n",
+				axp_data->irq_names[i], irq);
+			return irq;
 		}
-		irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
-		ret = devm_request_any_context_irq(&pdev->dev, irq,
+		power->irqs[i] = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
+		ret = devm_request_any_context_irq(&pdev->dev, power->irqs[i],
 						   axp20x_ac_power_irq, 0,
 						   DRVNAME, power);
-		if (ret < 0)
-			dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\n",
-				 irq_names[i], ret);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Error requesting %s IRQ: %d\n",
+				axp_data->irq_names[i], ret);
+			return ret;
+		}
 	}
 
 	return 0;
@@ -339,8 +395,9 @@ MODULE_DEVICE_TABLE(of, axp20x_ac_power_match);
 static struct platform_driver axp20x_ac_power_driver = {
 	.probe = axp20x_ac_power_probe,
 	.driver = {
-		.name = DRVNAME,
-		.of_match_table = axp20x_ac_power_match,
+		.name		= DRVNAME,
+		.of_match_table	= axp20x_ac_power_match,
+		.pm		= &axp20x_ac_power_pm_ops,
 	},
 };
 
-- 
2.23.0

