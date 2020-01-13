Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8149E1389F8
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 04:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387415AbgAMDxQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jan 2020 22:53:16 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60157 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387502AbgAMDxO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jan 2020 22:53:14 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1659421CC3;
        Sun, 12 Jan 2020 22:53:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 12 Jan 2020 22:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=l1Wlq3jlzd/yz
        FyF8v+T6UaEpVaRruLDvw3P4cuL5sk=; b=KKGF+M3U0PxREwLjNOxTEcU6+H40g
        dOCNlapGVYxjD9bLbNNxZbYCGkG2NsqNtXomI9uqnB+zRIX+5QtS1srZHM/HBfPx
        iyporQvfQ6i3KCyBWocrVW5OHV6H8MoC4ahgyCFJZJXchkE5wZKGbDzTEdYq3Yg0
        pNDGe8cB1/kGDZd1qmT3gHqAvEK5OccCWBTiLq6xxFCPRXDQYPDu7eV4ePTxxSre
        ngsH783WMepRhVdFmI0FCKxXPddU9wqWWEKskm6Wc7oGKFrtKTsjxQUc9r6yBRwN
        r58rLtGQBN4cFlR+lPfsaCojmIUUwjDoZwJDyVbr7I0LPTQkxcTh8PyiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=l1Wlq3jlzd/yzFyF8v+T6UaEpVaRruLDvw3P4cuL5sk=; b=dEmQcZ2z
        qd3yfYgoQxQBkgGaqQBRoDHQVF0lxuhpFwWWVR0eKzJbo2TQNCWNfeAE8dEniFv1
        aTVRky4QK4XhfZZCtozDLHDY7Tn8XAtFc9z+xHfkuohJvIz2v9moqpNF4Q9R8GRZ
        9XQ/gh0hswVz67Tg6ReCIRlqgakdbv4d7ZHDV8kbW+tkiubdEzTkQ0b4MkeGOkXV
        FTJsU/hoNsnelP3NamFwzWxnb0A9Dnm79UG1S0/YUtiqK3w/KSyLRgsw/zJyYcc8
        OzHsjYDEDf0CUHwNk88Q6l5+1KJpQmnn/etwIwuH2Zo+ycksYMq53c1UEm2EK/Qn
        19y5eVeESfR+qQ==
X-ME-Sender: <xms:qOkbXgJSiO1lmc5pd3obIaAB3l0Zj16B4WXrl1ZQKTByzmAHGaPdzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:qOkbXkastZMkaPeMEX4TP-Z2Qahf4G3TDGzw_bFSek5SvWW4dfwQzg>
    <xmx:qOkbXrsqVGOGvX3glfv4libPNOPMDFQ-1qYfJaaA_-L8D99ePg_J8g>
    <xmx:qOkbXhs9nYax7PmobSUwIShRGT4EgrhujxBlTSeIPA3h1PbT_MLkLA>
    <xmx:qekbXnQNSYxyeJrxLIZsogYvNOJltymlLza_KcTZ5m5aRoDh59iSmA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 765E88005C;
        Sun, 12 Jan 2020 22:53:12 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>,
        Oskari Lemmela <oskari@lemmela.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 3/8] power: supply: axp20x_ac_power: Add wakeup control
Date:   Sun, 12 Jan 2020 21:53:05 -0600
Message-Id: <20200113035310.18950-4-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200113035310.18950-1-samuel@sholland.org>
References: <20200113035310.18950-1-samuel@sholland.org>
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

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/power/supply/axp20x_ac_power.c | 91 +++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 17 deletions(-)

diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
index 3ba38f2f281c..ac360016b08a 100644
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

