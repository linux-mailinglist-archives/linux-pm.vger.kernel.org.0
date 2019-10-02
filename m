Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6339C876C
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 13:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfJBLgK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 07:36:10 -0400
Received: from hermes.aosc.io ([199.195.250.187]:42754 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfJBLgK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Oct 2019 07:36:10 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id BFE2482D3A;
        Wed,  2 Oct 2019 11:26:54 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 2/2] power: supply: axp20x_usb_power: add applied max Vbus support for AXP813
Date:   Wed,  2 Oct 2019 19:25:45 +0800
Message-Id: <20191002112545.58481-3-icenowy@aosc.io>
In-Reply-To: <20191002112545.58481-1-icenowy@aosc.io>
References: <20191002112545.58481-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

AXP813 PMIC has two Vbus maximum value settings -- one is the default
value, which is currently the only supported one; the other is the
really applied value, which is set according to the default value if the
BC detection module detected a charging port, or 500mA if no charging
port is detected.

Add support for reading and writing of the really applied Vbus maxmium
value. Interestingly it has a larger range than the default value.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/power/supply/axp20x_usb_power.c | 132 +++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 5f0a5722b19e..905668a2727f 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -50,6 +50,18 @@
 
 #define AXP813_BC_EN		BIT(0)
 
+#define AXP813_VBUS_CLIMIT_REAL_MASK	GENMASK(7, 4)
+#define AXP813_VBUS_CLIMIT_REAL_100mA	(0 << 4)
+#define AXP813_VBUS_CLIMIT_REAL_500mA	(1 << 4)
+#define AXP813_VBUS_CLIMIT_REAL_900mA	(2 << 4)
+#define AXP813_VBUS_CLIMIT_REAL_1500mA	(3 << 4)
+#define AXP813_VBUS_CLIMIT_REAL_2000mA	(4 << 4)
+#define AXP813_VBUS_CLIMIT_REAL_2500mA	(5 << 4)
+#define AXP813_VBUS_CLIMIT_REAL_3000mA	(6 << 4)
+#define AXP813_VBUS_CLIMIT_REAL_3500mA	(7 << 4)
+#define AXP813_VBUS_CLIMIT_REAL_4000mA	(8 << 4)
+/* The remaining values are all 4000mA according to the datasheet */
+
 /*
  * Note do not raise the debounce time, we must report Vusb high within
  * 100ms otherwise we get Vbus errors in musb.
@@ -159,6 +171,47 @@ static int axp813_get_current_max(struct axp20x_usb_power *power, int *val)
 	return 0;
 }
 
+static int axp813_get_input_current_limit(struct axp20x_usb_power *power, int *val)
+{
+	unsigned int v;
+	int ret = regmap_read(power->regmap, AXP22X_CHRG_CTRL3, &v);
+
+	if (ret)
+		return ret;
+
+	switch (v & AXP813_VBUS_CLIMIT_REAL_MASK) {
+	case AXP813_VBUS_CLIMIT_REAL_100mA:
+		*val = 100000;
+		break;
+	case AXP813_VBUS_CLIMIT_REAL_500mA:
+		*val = 500000;
+		break;
+	case AXP813_VBUS_CLIMIT_REAL_900mA:
+		*val = 900000;
+		break;
+	case AXP813_VBUS_CLIMIT_REAL_1500mA:
+		*val = 1500000;
+		break;
+	case AXP813_VBUS_CLIMIT_REAL_2000mA:
+		*val = 2000000;
+		break;
+	case AXP813_VBUS_CLIMIT_REAL_2500mA:
+		*val = 2500000;
+		break;
+	case AXP813_VBUS_CLIMIT_REAL_3000mA:
+		*val = 3000000;
+		break;
+	case AXP813_VBUS_CLIMIT_REAL_3500mA:
+		*val = 3500000;
+		break;
+	default:
+		/* All other cases are 4000mA */
+		*val = 4000000;
+		break;
+	}
+	return 0;
+}
+
 static int axp20x_usb_power_get_property(struct power_supply *psy,
 	enum power_supply_property psp, union power_supply_propval *val)
 {
@@ -200,6 +253,8 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
 		if (power->axp20x_id == AXP813_ID)
 			return axp813_get_current_max(power, &val->intval);
 		return axp20x_get_current_max(power, &val->intval);
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return axp813_get_input_current_limit(power, &val->intval);
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		if (IS_ENABLED(CONFIG_AXP20X_ADC)) {
 			ret = iio_read_channel_processed(power->vbus_i,
@@ -338,6 +393,48 @@ static int axp20x_usb_power_set_current_max(struct axp20x_usb_power *power,
 	return -EINVAL;
 }
 
+static int axp20x_usb_power_set_input_current_limit(struct axp20x_usb_power *power,
+						    int intval)
+{
+	int val;
+
+	switch (intval) {
+	case 100000:
+		val = AXP813_VBUS_CLIMIT_REAL_100mA;
+		break;
+	case 500000:
+		val = AXP813_VBUS_CLIMIT_REAL_500mA;
+		break;
+	case 900000:
+		val = AXP813_VBUS_CLIMIT_REAL_900mA;
+		break;
+	case 1500000:
+		val = AXP813_VBUS_CLIMIT_REAL_1500mA;
+		break;
+	case 2000000:
+		val = AXP813_VBUS_CLIMIT_REAL_2000mA;
+		break;
+	case 2500000:
+		val = AXP813_VBUS_CLIMIT_REAL_2500mA;
+		break;
+	case 3000000:
+		val = AXP813_VBUS_CLIMIT_REAL_3000mA;
+		break;
+	case 3500000:
+		val = AXP813_VBUS_CLIMIT_REAL_3500mA;
+		break;
+	case 4000000:
+		val = AXP813_VBUS_CLIMIT_REAL_4000mA;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(power->regmap,
+				  AXP22X_CHRG_CTRL3,
+				  AXP813_VBUS_CLIMIT_REAL_MASK, val);
+}
+
 static int axp20x_usb_power_set_property(struct power_supply *psy,
 					 enum power_supply_property psp,
 					 const union power_supply_propval *val)
@@ -354,6 +451,9 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
 								val->intval);
 		return axp20x_usb_power_set_current_max(power, val->intval);
 
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return axp20x_usb_power_set_input_current_limit(power, val->intval);
+
 	default:
 		return -EINVAL;
 	}
@@ -365,7 +465,8 @@ static int axp20x_usb_power_prop_writeable(struct power_supply *psy,
 					   enum power_supply_property psp)
 {
 	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
-	       psp == POWER_SUPPLY_PROP_CURRENT_MAX;
+	       psp == POWER_SUPPLY_PROP_CURRENT_MAX ||
+	       psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
 }
 
 static enum power_supply_property axp20x_usb_power_properties[] = {
@@ -386,6 +487,15 @@ static enum power_supply_property axp22x_usb_power_properties[] = {
 	POWER_SUPPLY_PROP_CURRENT_MAX,
 };
 
+static enum power_supply_property axp813_usb_power_properties[] = {
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+};
+
 static const struct power_supply_desc axp20x_usb_power_desc = {
 	.name = "axp20x-usb",
 	.type = POWER_SUPPLY_TYPE_USB,
@@ -406,6 +516,16 @@ static const struct power_supply_desc axp22x_usb_power_desc = {
 	.set_property = axp20x_usb_power_set_property,
 };
 
+static const struct power_supply_desc axp813_usb_power_desc = {
+	.name = "axp20x-usb",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.properties = axp813_usb_power_properties,
+	.num_properties = ARRAY_SIZE(axp813_usb_power_properties),
+	.property_is_writeable = axp20x_usb_power_prop_writeable,
+	.get_property = axp20x_usb_power_get_property,
+	.set_property = axp20x_usb_power_set_property,
+};
+
 static int configure_iio_channels(struct platform_device *pdev,
 				  struct axp20x_usb_power *power)
 {
@@ -487,10 +607,16 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		usb_power_desc = &axp20x_usb_power_desc;
 		irq_names = axp20x_irq_names;
 	} else if (power->axp20x_id == AXP221_ID ||
-		   power->axp20x_id == AXP223_ID ||
-		   power->axp20x_id == AXP813_ID) {
+		   power->axp20x_id == AXP223_ID) {
 		usb_power_desc = &axp22x_usb_power_desc;
 		irq_names = axp22x_irq_names;
+	} else if (power->axp20x_id == AXP813_ID) {
+		usb_power_desc = &axp813_usb_power_desc;
+		irq_names = axp22x_irq_names;
+
+		/* Enable USB Battery Charging specification detection */
+		regmap_update_bits(axp20x->regmap, AXP288_BC_GLOBAL,
+				   AXP813_BC_EN, AXP813_BC_EN);
 	} else {
 		dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
 			axp20x->variant);
-- 
2.21.0

