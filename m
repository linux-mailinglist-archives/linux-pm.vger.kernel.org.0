Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F14A1F0307
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jun 2020 00:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgFEWoN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 18:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbgFEWoL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jun 2020 18:44:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5991C08C5C2;
        Fri,  5 Jun 2020 15:44:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 85C2F2A51C5
Received: by jupiter.universe (Postfix, from userid 1000)
        id 36CC2480106; Sat,  6 Jun 2020 00:44:04 +0200 (CEST)
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
Subject: [PATCHv2 6/6] power: supply: gpio-charger: drop legacy GPIO support
Date:   Sat,  6 Jun 2020 00:44:03 +0200
Message-Id: <20200605224403.181015-7-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605224403.181015-1-sebastian.reichel@collabora.com>
References: <20200605224403.181015-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All board files have been converted to use boardfile GPIO
descriptor tables, so GPIO support can be removed from
platform data.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/gpio-charger.c | 30 +----------------------------
 include/linux/power/gpio-charger.h  |  5 -----
 2 files changed, 1 insertion(+), 34 deletions(-)

diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 74fc664c01e3..8c9f69f3d13e 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -258,7 +258,6 @@ static int gpio_charger_probe(struct platform_device *pdev)
 	struct power_supply_desc *charger_desc;
 	struct gpio_desc *charge_status;
 	int charge_status_irq;
-	unsigned long flags;
 	int ret;
 	int num_props = 0;
 
@@ -272,41 +271,14 @@ static int gpio_charger_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	gpio_charger->dev = dev;
 
-	/*
-	 * This will fetch a GPIO descriptor from device tree, ACPI or
-	 * boardfile descriptor tables. It's good to try this first.
-	 */
 	gpio_charger->gpiod = devm_gpiod_get_optional(dev, NULL, GPIOD_IN);
-
-	/*
-	 * Fallback to legacy platform data method, if no GPIO is specified
-	 * using boardfile descriptor tables.
-	 */
-	if (!gpio_charger->gpiod && pdata) {
-		/* Non-DT: use legacy GPIO numbers */
-		if (!gpio_is_valid(pdata->gpio)) {
-			dev_err(dev, "Invalid gpio pin in pdata\n");
-			return -EINVAL;
-		}
-		flags = GPIOF_IN;
-		if (pdata->gpio_active_low)
-			flags |= GPIOF_ACTIVE_LOW;
-		ret = devm_gpio_request_one(dev, pdata->gpio, flags,
-					    dev_name(dev));
-		if (ret) {
-			dev_err(dev, "Failed to request gpio pin: %d\n", ret);
-			return ret;
-		}
-		/* Then convert this to gpiod for now */
-		gpio_charger->gpiod = gpio_to_desc(pdata->gpio);
-	} else if (IS_ERR(gpio_charger->gpiod)) {
+	if (IS_ERR(gpio_charger->gpiod)) {
 		/* Just try again if this happens */
 		if (PTR_ERR(gpio_charger->gpiod) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 		dev_err(dev, "error getting GPIO descriptor\n");
 		return PTR_ERR(gpio_charger->gpiod);
 	}
-
 	if (gpio_charger->gpiod) {
 		gpio_charger_properties[num_props] = POWER_SUPPLY_PROP_ONLINE;
 		num_props++;
diff --git a/include/linux/power/gpio-charger.h b/include/linux/power/gpio-charger.h
index 5a5a8de98181..3081391e93c9 100644
--- a/include/linux/power/gpio-charger.h
+++ b/include/linux/power/gpio-charger.h
@@ -13,8 +13,6 @@
  * struct gpio_charger_platform_data - platform_data for gpio_charger devices
  * @name:		Name for the chargers power_supply device
  * @type:		Type of the charger
- * @gpio:		GPIO which is used to indicate the chargers status
- * @gpio_active_low:	Should be set to 1 if the GPIO is active low otherwise 0
  * @supplied_to:	Array of battery names to which this chargers supplies power
  * @num_supplicants:	Number of entries in the supplied_to array
  */
@@ -22,9 +20,6 @@ struct gpio_charger_platform_data {
 	const char *name;
 	enum power_supply_type type;
 
-	int gpio;
-	int gpio_active_low;
-
 	char **supplied_to;
 	size_t num_supplicants;
 };
-- 
2.26.2

