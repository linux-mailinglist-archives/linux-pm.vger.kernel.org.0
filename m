Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B1E1D11F0
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 13:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgEML4V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 07:56:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48104 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730004AbgEML4S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 07:56:18 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D19482A28AA
Received: by jupiter.universe (Postfix, from userid 1000)
        id 6FDD64800F8; Wed, 13 May 2020 13:56:13 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 1/2] power: supply: gpio-charger: add charge-current-limit feature
Date:   Wed, 13 May 2020 13:56:00 +0200
Message-Id: <20200513115601.360642-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add new charge-current-limit feature to gpio-charger. This also
makes the online status GPIO optional, since hardware might only
expose the charge-current-limit feature and there is no good reason
to have it mandatory now that different GPIOs are supported.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/power/supply/gpio-charger.txt    |  11 +-
 drivers/power/supply/gpio-charger.c           | 176 ++++++++++++++++--
 2 files changed, 174 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
index 0fb33b2c62a6..dbfd29029f69 100644
--- a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
+++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
@@ -2,8 +2,6 @@ gpio-charger
 
 Required properties :
  - compatible : "gpio-charger"
- - gpios : GPIO indicating the charger presence.
-   See GPIO binding in bindings/gpio/gpio.txt .
  - charger-type : power supply type, one of
      unknown
      battery
@@ -15,7 +13,13 @@ Required properties :
      usb-aca (USB accessory charger adapter)
 
 Optional properties:
+ - gpios : GPIO indicating the charger presence.
+   See GPIO binding in bindings/gpio/gpio.txt .
  - charge-status-gpios: GPIO indicating whether a battery is charging.
+ - charge-current-limit-gpios: Output GPIOs specifiers for limiting the charge current
+ - charge-current-limit-mapping: List of touples with current in uA and a GPIO bitmap (in this order).
+                                The GPIOs are encoded in the same order as specified in charge-current-limit-gpios.
+				The touples must be provided in descending order of the current limit.
 
 Example:
 
@@ -24,6 +28,9 @@ Example:
 		charger-type = "usb-sdp";
 		gpios = <&gpd 28 GPIO_ACTIVE_LOW>;
 		charge-status-gpios = <&gpc 27 GPIO_ACTIVE_LOW>;
+
+		charge-current-limit-gpios = <&gpioA 11 GPIO_ACTIVE_HIGH>, <&gpioA 12 GPIO_ACTIVE_HIGH>;
+		charge-current-limit-mapping = <2500000 0x00>, <700000 0x01>, <0 0x02>;
 	};
 
 	battery {
diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index 1b959c7f8b0e..4a5eac7cc36c 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -18,7 +18,13 @@
 
 #include <linux/power/gpio-charger.h>
 
+struct gpio_mapping {
+	u32 limit_ua;
+	u32 gpiodata;
+} __packed;
+
 struct gpio_charger {
+	struct device *dev;
 	unsigned int irq;
 	unsigned int charge_status_irq;
 	bool wakeup_enabled;
@@ -27,6 +33,11 @@ struct gpio_charger {
 	struct power_supply_desc charger_desc;
 	struct gpio_desc *gpiod;
 	struct gpio_desc *charge_status;
+
+	struct gpio_descs *current_limit_gpios;
+	struct gpio_mapping *current_limit_map;
+	u32 current_limit_map_size;
+	u32 charge_current_limit;
 };
 
 static irqreturn_t gpio_charger_irq(int irq, void *devid)
@@ -43,6 +54,35 @@ static inline struct gpio_charger *psy_to_gpio_charger(struct power_supply *psy)
 	return power_supply_get_drvdata(psy);
 }
 
+static int set_charge_current_limit(struct gpio_charger *gpio_charger, int val)
+{
+	struct gpio_mapping mapping;
+	int ndescs = gpio_charger->current_limit_gpios->ndescs;
+	struct gpio_desc **gpios = gpio_charger->current_limit_gpios->desc;
+	int i;
+
+	if (!gpio_charger->current_limit_map_size)
+		return -EINVAL;
+
+	for (i = 0; i < gpio_charger->current_limit_map_size; i++) {
+		if (gpio_charger->current_limit_map[i].limit_ua <= val)
+			break;
+	}
+	mapping = gpio_charger->current_limit_map[i];
+
+	for (i = 0; i < ndescs; i++) {
+		bool val = (mapping.gpiodata >> i) & 1;
+		gpiod_set_value_cansleep(gpios[ndescs-i-1], val);
+	}
+
+	gpio_charger->charge_current_limit = mapping.limit_ua;
+
+	dev_dbg(gpio_charger->dev, "set charge current limit to %d (requested: %d)\n",
+		gpio_charger->charge_current_limit, val);
+
+	return 0;
+}
+
 static int gpio_charger_get_property(struct power_supply *psy,
 		enum power_supply_property psp, union power_supply_propval *val)
 {
@@ -58,6 +98,9 @@ static int gpio_charger_get_property(struct power_supply *psy,
 		else
 			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		val->intval = gpio_charger->charge_current_limit;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -65,6 +108,34 @@ static int gpio_charger_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static int gpio_charger_set_property(struct power_supply *psy,
+	enum power_supply_property psp, const union power_supply_propval *val)
+{
+	struct gpio_charger *gpio_charger = psy_to_gpio_charger(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		return set_charge_current_limit(gpio_charger, val->intval);
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int gpio_charger_property_is_writeable(struct power_supply *psy,
+					      enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		return 1;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static enum power_supply_type gpio_charger_get_type(struct device *dev)
 {
 	const char *chargetype;
@@ -112,9 +183,70 @@ static int gpio_charger_get_irq(struct device *dev, void *dev_id,
 	return irq;
 }
 
+static int init_charge_current_limit(struct device *dev,
+				    struct gpio_charger *gpio_charger)
+{
+	int i, len;
+	u32 cur_limit = U32_MAX;
+
+	gpio_charger->current_limit_gpios = devm_gpiod_get_array_optional(dev,
+		"charge-current-limit", GPIOD_OUT_LOW);
+	if (IS_ERR(gpio_charger->current_limit_gpios)) {
+		dev_err(dev, "error getting current-limit GPIOs\n");
+		return PTR_ERR(gpio_charger->current_limit_gpios);
+	}
+
+	if (!gpio_charger->current_limit_gpios)
+		return 0;
+
+	len = device_property_read_u32_array(dev, "charge-current-limit-mapping",
+		NULL, 0);
+	if (len < 0)
+		return len;
+
+	if (len % 2) {
+		dev_err(dev, "invalid charge-current-limit-mapping length\n");
+		return -EINVAL;
+	}
+
+	gpio_charger->current_limit_map = devm_kmalloc_array(dev,
+		len / 2, sizeof(*gpio_charger->current_limit_map), GFP_KERNEL);
+	if (!gpio_charger->current_limit_map)
+		return -ENOMEM;
+
+	gpio_charger->current_limit_map_size = len / 2;
+
+	len = device_property_read_u32_array(dev, "charge-current-limit-mapping",
+		(u32*) gpio_charger->current_limit_map, len);
+	if (len < 0)
+		return len;
+
+	for (i=0; i < gpio_charger->current_limit_map_size; i++) {
+		if (gpio_charger->current_limit_map[i].limit_ua > cur_limit) {
+			dev_err(dev, "invalid charge-current-limit-mapping\n");
+			return -EINVAL;
+		}
+
+		cur_limit = gpio_charger->current_limit_map[i].limit_ua;
+	}
+
+	/* default to smallest current limitation for safety reasons */
+	len = gpio_charger->current_limit_map_size - 1;
+	set_charge_current_limit(gpio_charger,
+		gpio_charger->current_limit_map[len].limit_ua);
+
+	return 0;
+}
+
+/*
+ * The entries will be overwritten by driver's probe routine depending
+ * on the available features. This list ensures, that the array is big
+ * enough for all optional features.
+ */
 static enum power_supply_property gpio_charger_properties[] = {
 	POWER_SUPPLY_PROP_ONLINE,
-	POWER_SUPPLY_PROP_STATUS /* Must always be last in the array. */
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 };
 
 static int gpio_charger_probe(struct platform_device *pdev)
@@ -128,6 +260,7 @@ static int gpio_charger_probe(struct platform_device *pdev)
 	int charge_status_irq;
 	unsigned long flags;
 	int ret;
+	int num_props = 0;
 
 	if (!pdata && !dev->of_node) {
 		dev_err(dev, "No platform data\n");
@@ -137,18 +270,19 @@ static int gpio_charger_probe(struct platform_device *pdev)
 	gpio_charger = devm_kzalloc(dev, sizeof(*gpio_charger), GFP_KERNEL);
 	if (!gpio_charger)
 		return -ENOMEM;
+	gpio_charger->dev = dev;
 
 	/*
 	 * This will fetch a GPIO descriptor from device tree, ACPI or
 	 * boardfile descriptor tables. It's good to try this first.
 	 */
-	gpio_charger->gpiod = devm_gpiod_get(dev, NULL, GPIOD_IN);
+	gpio_charger->gpiod = devm_gpiod_get_optional(dev, NULL, GPIOD_IN);
 
 	/*
 	 * If this fails and we're not using device tree, try the
 	 * legacy platform data method.
 	 */
-	if (IS_ERR(gpio_charger->gpiod) && !dev->of_node) {
+	if (!gpio_charger->gpiod && !dev->of_node) {
 		/* Non-DT: use legacy GPIO numbers */
 		if (!gpio_is_valid(pdata->gpio)) {
 			dev_err(dev, "Invalid gpio pin in pdata\n");
@@ -173,18 +307,38 @@ static int gpio_charger_probe(struct platform_device *pdev)
 		return PTR_ERR(gpio_charger->gpiod);
 	}
 
+	if (gpio_charger->gpiod &&
+	    num_props < ARRAY_SIZE(gpio_charger_properties)) {
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
+	if (charge_status && num_props < ARRAY_SIZE(gpio_charger_properties)) {
+		gpio_charger->charge_status = charge_status;
+		gpio_charger_properties[num_props] = POWER_SUPPLY_PROP_STATUS;
+		num_props++;
+	}
+
+	ret = init_charge_current_limit(dev, gpio_charger);
+	if (ret < 0)
+		return ret;
+	if (gpio_charger->current_limit_map &&
+	    num_props < ARRAY_SIZE(gpio_charger_properties)) {
+		gpio_charger_properties[num_props] =
+			POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
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
+	charger_desc->set_property = gpio_charger_set_property;
+	charger_desc->property_is_writeable =
+					gpio_charger_property_is_writeable;
 
 	psy_cfg.of_node = dev->of_node;
 	psy_cfg.drv_data = gpio_charger;
@@ -269,6 +423,6 @@ static struct platform_driver gpio_charger_driver = {
 module_platform_driver(gpio_charger_driver);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
-MODULE_DESCRIPTION("Driver for chargers which report their online status through a GPIO");
+MODULE_DESCRIPTION("Driver for chargers only communicating via GPIO(s)");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:gpio-charger");
-- 
2.26.2

