Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE4DD130562
	for <lists+linux-pm@lfdr.de>; Sun,  5 Jan 2020 02:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgAEBYU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Jan 2020 20:24:20 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46859 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726264AbgAEBYT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Jan 2020 20:24:19 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id ACB4C21B62;
        Sat,  4 Jan 2020 20:24:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 04 Jan 2020 20:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=WrStUasd4Cc83
        ADtqUJg0NBcBBfCEyykALqqb1HDxp0=; b=Bmngpm/p82u8HlP8dz+JVbgpI0tV4
        V/s5M75CDS0laVWRnoHAX1taL1WU0A3IF9aG9BFT7TtlT49jEWqq0MLtMUj6gb61
        5S7nj+jabFawxBU1XgRv3J5DpggvfNPflMWtreg3hgN5UTdmmfTE04A0CEt+m/RA
        s07CSYTlPZdcPKktq67MVvX2dpOdOlPP5DrqN0k94dq8u/7JiwjesiVbLbhq64eB
        BTHmDaMCcNnzyYJWmWFgslt59MZl1WdGiKpjMBjdQuDeQCqqxWQVYxN3YI8aaP0+
        HHHNmvX25ol+BkC+1YsoR9fiKOevB/UFQ1HCPyaSSY1sqaJKqSUaPMdlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=WrStUasd4Cc83ADtqUJg0NBcBBfCEyykALqqb1HDxp0=; b=H9rY78IO
        aP7yVg65WG7IvewRQlW+irQdD8dX/AptJVHGHVU4UOmS6VTNewm9UR0h7e5vUf00
        RCdKj3iOjC08cEXxaBkem+wMhfmTLa+5uiDH0qSzXRkXKq/EKmfxa+JWrNiFd3rY
        T/kiqAvx7wBtMNmvJh4Tbjp9Z/Cu6rs4Od9YB1qQzQBSUG0gcrINQZaCvQr1R5qs
        nOUt5qVTUKp8l6PS7Tp+4PJocKRux8Iyp6Ml47YFnJOvTqUj2ahLgB69YV6gOEg0
        E2M2XJQcUDzJkL/xowSiUpfptiipBz4c4PS0t1xJr1OcEwY49mQfbN/Gcd/0uG1R
        ++qe4KpmioKL9Q==
X-ME-Sender: <xms:wjoRXmUAMH0x8WXUSVU3713I0s8ziKsUtidluCecKWij7vDy8WsSlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdegiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:wjoRXk6lVZYUe_VSnf_zImo9j2UP-2k5QSAAIEQXAqOIhU16xxD0hw>
    <xmx:wjoRXp-5l1W4X3LmnhV5A7nNQgpAOnUbg-8ZQ-WWbId-mwQO-BI01A>
    <xmx:wjoRXknIOznZJH_es1_E6KeC5rWl51mahItWVHwYLaAPBaaymvbOEw>
    <xmx:wjoRXiH4_VmsHqqZsSgXIXPUmXFDjdvKAP60l2VekZIn4G-ajoWgAw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0016980061;
        Sat,  4 Jan 2020 20:24:17 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 4/9] power: supply: axp20x_ac_power: Add wakeup control
Date:   Sat,  4 Jan 2020 19:24:11 -0600
Message-Id: <20200105012416.23296-5-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200105012416.23296-1-samuel@sholland.org>
References: <20200105012416.23296-1-samuel@sholland.org>
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

To avoid spuriously waking up the system when the AC power supply is
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
 drivers/power/supply/axp20x_ac_power.c | 91 +++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 17 deletions(-)

diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
index bc2663cd47fa..177b5c1eee8f 100644
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
@@ -44,6 +45,8 @@ struct axp20x_ac_power {
 	struct iio_channel *acin_v;
 	struct iio_channel *acin_i;
 	bool has_acin_path_sel;
+	unsigned int num_irqs;
+	unsigned int irqs[];
 };
 
 static irqreturn_t axp20x_ac_power_irq(int irq, void *devid)
@@ -242,38 +245,86 @@ static const struct power_supply_desc axp813_ac_power_desc = {
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
 	bool				acin_path_sel;
 };
 
 static const struct axp_data axp20x_data = {
 	.power_desc	= &axp20x_ac_power_desc,
+	.irq_names	= axp20x_irq_names,
+	.num_irq_names	= ARRAY_SIZE(axp20x_irq_names),
 	.acin_adc	= true,
 	.acin_path_sel	= false,
 };
 
 static const struct axp_data axp22x_data = {
 	.power_desc	= &axp22x_ac_power_desc,
+	.irq_names	= axp20x_irq_names,
+	.num_irq_names	= ARRAY_SIZE(axp20x_irq_names),
 	.acin_adc	= false,
 	.acin_path_sel	= false,
 };
 
 static const struct axp_data axp813_data = {
 	.power_desc	= &axp813_ac_power_desc,
+	.irq_names	= axp20x_irq_names,
+	.num_irq_names	= ARRAY_SIZE(axp20x_irq_names),
 	.acin_adc	= false,
 	.acin_path_sel	= true,
 };
 
+#ifdef CONFIG_PM_SLEEP
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
@@ -284,12 +335,14 @@ static int axp20x_ac_power_probe(struct platform_device *pdev)
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
@@ -308,6 +361,7 @@ static int axp20x_ac_power_probe(struct platform_device *pdev)
 
 	power->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	power->has_acin_path_sel = axp_data->acin_path_sel;
+	power->num_irqs = axp_data->num_irq_names;
 
 	platform_set_drvdata(pdev, power);
 
@@ -321,20 +375,22 @@ static int axp20x_ac_power_probe(struct platform_device *pdev)
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
@@ -357,8 +413,9 @@ MODULE_DEVICE_TABLE(of, axp20x_ac_power_match);
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

