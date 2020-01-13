Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7CA41389FB
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 04:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbgAMDxU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jan 2020 22:53:20 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56387 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387562AbgAMDxP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jan 2020 22:53:15 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 97E9821C1E;
        Sun, 12 Jan 2020 22:53:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 12 Jan 2020 22:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=MzYN8BJBjUwio
        5aswSx7OzDTDuHEuWowhgMznvEocyY=; b=HZXfbnkJP/U0JHOGqjfQGTPvm5Ws5
        bwH9emsaNINZZ8wOVaK5l0UwEOV3STRnwHmGY8vr3qXLADsXpSar5yUrKHIU4Zlk
        ldrSna6kdbga3fcAoOoUvNH6A/YCOBUTVO+13kpg4K7DzMqxpSe8/ENRqt6QyuJ+
        4vjDS8O5Fw70D6XW3vd281eDVZrP3ka1oepbJ9IuG0iWJEh6rmPDMdgVEExXkfn9
        EZIbZR/03JUENGF2QJgLb/nvXjuSB0OrjnbkHBzmGxMHR4l2JrZsO9cMaR2TpBK4
        /NYT04eJG5ulfi6HfIL3Tc9Zf5KcqZLXfVw8XJqvJ8tATjFS3Aj21USTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=MzYN8BJBjUwio5aswSx7OzDTDuHEuWowhgMznvEocyY=; b=bR9WJudl
        8cLLtXC46M4R3CH0FVPzA/bWd0biGNiMb54+fdbheFJIJQ69XaQX7KsleyFXnlBn
        h2eSQY6sFpQoFnNn75JIETcF4lgr3quWxaPyeFDYtj2JsJqwXGe+B8aHN2aaL8w1
        Du/lgb5xig4PWls7fY0TVZzOsdu87L+RQr2vO1ygNXAU0eHCDNBVCHPj/Kk5zb6r
        4/L8BI+86aJTTK09ffwoqsIaUgcPAyhxn3qKL+Z3liiFEiaeKpO7oa1FTxc4T6+Q
        7YcbOr8XC7koDkGmMo0S/DIo1KTF931YFdA4bVFDcQaGO8EajRtdos6a54Fsw6Mq
        /n4Unx8uul0qGg==
X-ME-Sender: <xms:qukbXijNNXM2eurse6jcK82FWMmk25XNriuJK6qcdp7LAAFb1cbptA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeiledgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:qukbXkQryDIiL0sLoxcQZueP4efQmE6TZMWApRuGwvRxGix4IL78aQ>
    <xmx:qukbXi_X7I0fbwi8L1VvPnZ5TKMjIowqPCNJhFXUP2fPMfEzuS0HoA>
    <xmx:qukbXiTDOj2jStseOyoqyUYxjLrAuU9H90tGISmiXNLMa23LHPOHVg>
    <xmx:qukbXu0mEPuWCqNCXid3fo4m8NUpZWxVkgj5ieqgUUebi0mxJHXcvA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0CD3D8005C;
        Sun, 12 Jan 2020 22:53:14 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>,
        Oskari Lemmela <oskari@lemmela.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 7/8] power: supply: axp20x_usb_power: Add wakeup control
Date:   Sun, 12 Jan 2020 21:53:09 -0600
Message-Id: <20200113035310.18950-8-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200113035310.18950-1-samuel@sholland.org>
References: <20200113035310.18950-1-samuel@sholland.org>
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
index 3b3cc1e33f19..4292b86d0429 100644
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
@@ -65,6 +66,8 @@ struct axp20x_usb_power {
 	struct iio_channel *vbus_i;
 	struct delayed_work vbus_detect;
 	unsigned int old_status;
+	unsigned int num_irqs;
+	unsigned int irqs[];
 };
 
 static irqreturn_t axp20x_usb_power_irq(int irq, void *devid)
@@ -438,45 +441,85 @@ static const char * const axp20x_irq_names[] = {
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
@@ -523,15 +566,19 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
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
@@ -560,19 +607,22 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
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
@@ -612,8 +662,9 @@ static struct platform_driver axp20x_usb_power_driver = {
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

