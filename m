Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3681F0308
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jun 2020 00:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgFEWoN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 18:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728418AbgFEWoM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jun 2020 18:44:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB984C08C5C3;
        Fri,  5 Jun 2020 15:44:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 3AC372A0C32
Received: by jupiter.universe (Postfix, from userid 1000)
        id 2A144480102; Sat,  6 Jun 2020 00:44:04 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 2/6] power: supply: gpio-charger: Make gpios optional
Date:   Sat,  6 Jun 2020 00:43:59 +0200
Message-Id: <20200605224403.181015-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605224403.181015-1-sebastian.reichel@collabora.com>
References: <20200605224403.181015-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While strongly recommended, not all devices have a gpio to
detect if the charger is connected. This moves the 'gpios'
from required to optional section.

This also modifies error handling for the GPIO a bit: We
no longer fallback to pdata, if a GPIO is specified using
GPIO descriptor tables. This is a bit cleaner and does
not have any real impact: There are only two mainline pdata
users (arm/mach-sa1100/collie.c, arm/mach-pxa/tosa.c) and
none of them specify the GPIO via gpiod descriptor tables.
Once both have been converted the driver's support for
specifying GPIOs numbers in pdata will be dropped.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/power/supply/gpio-charger.yaml   |  7 +++-
 drivers/power/supply/gpio-charger.c           | 38 ++++++++++++-------
 2 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
index 78b167c62ab1..30eabbb14ef3 100644
--- a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
@@ -41,7 +41,12 @@ properties:
 
 required:
   - compatible
-  - gpios
+
+anyOf:
+  - required:
+    - gpios
+  - required:
+    - charge-status-gpios
 
 additionalProperties: false
 
diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 1b959c7f8b0e..875735d50716 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -112,9 +112,14 @@ static int gpio_charger_get_irq(struct device *dev, void *dev_id,
 	return irq;
 }
 
+/*
+ * The entries will be overwritten by driver's probe routine depending
+ * on the available features. This list ensures, that the array is big
+ * enough for all optional features.
+ */
 static enum power_supply_property gpio_charger_properties[] = {
 	POWER_SUPPLY_PROP_ONLINE,
-	POWER_SUPPLY_PROP_STATUS /* Must always be last in the array. */
+	POWER_SUPPLY_PROP_STATUS,
 };
 
 static int gpio_charger_probe(struct platform_device *pdev)
@@ -128,6 +133,7 @@ static int gpio_charger_probe(struct platform_device *pdev)
 	int charge_status_irq;
 	unsigned long flags;
 	int ret;
+	int num_props = 0;
 
 	if (!pdata && !dev->of_node) {
 		dev_err(dev, "No platform data\n");
@@ -142,13 +148,13 @@ static int gpio_charger_probe(struct platform_device *pdev)
 	 * This will fetch a GPIO descriptor from device tree, ACPI or
 	 * boardfile descriptor tables. It's good to try this first.
 	 */
-	gpio_charger->gpiod = devm_gpiod_get(dev, NULL, GPIOD_IN);
+	gpio_charger->gpiod = devm_gpiod_get_optional(dev, NULL, GPIOD_IN);
 
 	/*
-	 * If this fails and we're not using device tree, try the
-	 * legacy platform data method.
+	 * Fallback to legacy platform data method, if no GPIO is specified
+	 * using boardfile descriptor tables.
 	 */
-	if (IS_ERR(gpio_charger->gpiod) && !dev->of_node) {
+	if (!gpio_charger->gpiod && pdata) {
 		/* Non-DT: use legacy GPIO numbers */
 		if (!gpio_is_valid(pdata->gpio)) {
 			dev_err(dev, "Invalid gpio pin in pdata\n");
@@ -173,17 +179,23 @@ static int gpio_charger_probe(struct platform_device *pdev)
 		return PTR_ERR(gpio_charger->gpiod);
 	}
 
+	if (gpio_charger->gpiod) {
+		gpio_charger_properties[num_props] = POWER_SUPPLY_PROP_ONLINE;
+		num_props++;
+	}
+
 	charge_status = devm_gpiod_get_optional(dev, "charge-status", GPIOD_IN);
-	gpio_charger->charge_status = charge_status;
-	if (IS_ERR(gpio_charger->charge_status))
-		return PTR_ERR(gpio_charger->charge_status);
+	if (IS_ERR(charge_status))
+		return PTR_ERR(charge_status);
+	if (charge_status) {
+		gpio_charger->charge_status = charge_status;
+		gpio_charger_properties[num_props] = POWER_SUPPLY_PROP_STATUS;
+		num_props++;
+	}
 
 	charger_desc = &gpio_charger->charger_desc;
 	charger_desc->properties = gpio_charger_properties;
-	charger_desc->num_properties = ARRAY_SIZE(gpio_charger_properties);
-	/* Remove POWER_SUPPLY_PROP_STATUS from the supported properties. */
-	if (!gpio_charger->charge_status)
-		charger_desc->num_properties -= 1;
+	charger_desc->num_properties = num_props;
 	charger_desc->get_property = gpio_charger_get_property;
 
 	psy_cfg.of_node = dev->of_node;
@@ -269,6 +281,6 @@ static struct platform_driver gpio_charger_driver = {
 module_platform_driver(gpio_charger_driver);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
-MODULE_DESCRIPTION("Driver for chargers which report their online status through a GPIO");
+MODULE_DESCRIPTION("Driver for chargers only communicating via GPIO(s)");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:gpio-charger");
-- 
2.26.2

