Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E71E4210E9
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 16:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhJDOI3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 10:08:29 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:59457 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230380AbhJDOI3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 10:08:29 -0400
Received: from [77.244.183.192] (port=65250 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mXNhd-004WfD-I8; Mon, 04 Oct 2021 15:08:21 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH 2/2] power: supply: max77976: add Maxim MAX77976 charger driver
Date:   Mon,  4 Oct 2021 15:07:32 +0200
Message-Id: <20211004130732.950512-2-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004130732.950512-1-luca@lucaceresoli.net>
References: <20211004130732.950512-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for the MAX77976 3.5/5.5A 1-Cell Li+ Battery Charger.

This is a simple implementation enough to be used as a simple battery
charger without OTG and boost.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 MAINTAINERS                             |   1 +
 drivers/power/supply/Kconfig            |  11 +
 drivers/power/supply/Makefile           |   1 +
 drivers/power/supply/max77976_charger.c | 508 ++++++++++++++++++++++++
 4 files changed, 521 insertions(+)
 create mode 100644 drivers/power/supply/max77976_charger.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b3a3667cef46..064c0560b810 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11392,6 +11392,7 @@ MAXIM MAX77976 BATTERY CHARGER
 M:	Luca Ceresoli <luca@lucaceresoli.net>
 S:	Supported
 F:	Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml
+F:	drivers/power/supply/max77976_charger.c
 
 MAXIM MUIC CHARGER DRIVERS FOR EXYNOS BASED BOARDS
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index ad93b3550d6d..622d690c883a 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -557,6 +557,17 @@ config CHARGER_MAX77693
 	help
 	  Say Y to enable support for the Maxim MAX77693 battery charger.
 
+config CHARGER_MAX77976
+	tristate "Maxim MAX77976 battery charger driver"
+	depends on REGMAP_I2C
+	help
+	  The Maxim MAX77976 is a 19 Vin, 5.5A 1-Cell Li+ Battery Charger
+	  USB OTG support. It has an I2C interface for configuration.
+
+	  Say Y to enable support for the Maxim MAX77976 battery charger.
+	  This driver can also be built as a module. If so, the module will be
+	  called max77976_charger.
+
 config CHARGER_MAX8997
 	tristate "Maxim MAX8997/MAX8966 PMIC battery charger driver"
 	depends on MFD_MAX8997 && REGULATOR_MAX8997
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 4e55a11aab79..2c1b264b2046 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_CHARGER_MAX14577)	+= max14577_charger.o
 obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+= max14656_charger_detector.o
 obj-$(CONFIG_CHARGER_MAX77650)	+= max77650-charger.o
 obj-$(CONFIG_CHARGER_MAX77693)	+= max77693_charger.o
+obj-$(CONFIG_CHARGER_MAX77976)	+= max77976_charger.o
 obj-$(CONFIG_CHARGER_MAX8997)	+= max8997_charger.o
 obj-$(CONFIG_CHARGER_MAX8998)	+= max8998_charger.o
 obj-$(CONFIG_CHARGER_MP2629)	+= mp2629_charger.o
diff --git a/drivers/power/supply/max77976_charger.c b/drivers/power/supply/max77976_charger.c
new file mode 100644
index 000000000000..2ff900b1843a
--- /dev/null
+++ b/drivers/power/supply/max77976_charger.c
@@ -0,0 +1,508 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * max77976_charger.c - Driver for the Maxim MAX77976 battery charger
+ *
+ * Copyright (C) 2021 Luca Ceresoli
+ * Author: Luca Ceresoli <luca@lucaceresoli.net>
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+
+#define MAX77976_DRIVER_NAME	"max77976-charger"
+#define MAX77976_CHIP_ID	0x76
+
+static const char *max77976_manufacturer	= "Maxim Integrated";
+static const char *max77976_model		= "MAX77976";
+
+/* --------------------------------------------------------------------------
+ * Register map
+ */
+
+#define MAX77976_REG_CHIP_ID		0x00
+#define MAX77976_REG_CHIP_REVISION	0x01
+#define MAX77976_REG_CHG_INT_OK		0x12
+#define MAX77976_REG_CHG_DETAILS_01	0x14
+#define MAX77976_REG_CHG_CNFG_00	0x16
+#define MAX77976_REG_CHG_CNFG_02	0x18
+#define MAX77976_REG_CHG_CNFG_06	0x1c
+#define MAX77976_REG_CHG_CNFG_09	0x1f
+
+/* CHG_DETAILS_01.CHG_DTLS values */
+enum max77976_charging_state {
+	MAX77976_CHARGING_PREQUALIFICATION = 0x0,
+	MAX77976_CHARGING_FAST_CONST_CURRENT,
+	MAX77976_CHARGING_FAST_CONST_VOLTAGE,
+	MAX77976_CHARGING_TOP_OFF,
+	MAX77976_CHARGING_DONE,
+	MAX77976_CHARGING_RESERVED_05,
+	MAX77976_CHARGING_TIMER_FAULT,
+	MAX77976_CHARGING_SUSPENDED_QBATT_OFF,
+	MAX77976_CHARGING_OFF,
+	MAX77976_CHARGING_RESERVED_09,
+	MAX77976_CHARGING_THERMAL_SHUTDOWN,
+	MAX77976_CHARGING_WATCHDOG_EXPIRED,
+	MAX77976_CHARGING_SUSPENDED_JEITA,
+	MAX77976_CHARGING_SUSPENDED_THM_REMOVAL,
+	MAX77976_CHARGING_SUSPENDED_PIN,
+	MAX77976_CHARGING_RESERVED_0F,
+};
+
+/* CHG_DETAILS_01.BAT_DTLS values */
+enum max77976_battery_state {
+	MAX77976_BATTERY_BATTERY_REMOVAL = 0x0,
+	MAX77976_BATTERY_PREQUALIFICATION,
+	MAX77976_BATTERY_TIMER_FAULT,
+	MAX77976_BATTERY_REGULAR_VOLTAGE,
+	MAX77976_BATTERY_LOW_VOLTAGE,
+	MAX77976_BATTERY_OVERVOLTAGE,
+	MAX77976_BATTERY_RESERVED,
+	MAX77976_BATTERY_BATTERY_ONLY, // No valid adapter is present
+};
+
+/* CHG_CNFG_00.MODE values */
+enum max77976_mode {
+	MAX77976_MODE_CHARGER_BUCK		= 0x5,
+	MAX77976_MODE_BOOST			= 0x9,
+};
+
+/* CHG_CNFG_02.CHG_CC: charge current limit, 100..5500 mA, 50 mA steps */
+#define MAX77976_CHG_CC_STEP			  50000U
+#define MAX77976_CHG_CC_MIN			 100000U
+#define MAX77976_CHG_CC_MAX			5500000U
+
+/* CHG_CNFG_09.CHGIN_ILIM: input current limit, 100..3200 mA, 100 mA steps */
+#define MAX77976_CHGIN_ILIM_STEP		 100000U
+#define MAX77976_CHGIN_ILIM_MIN			 100000U
+#define MAX77976_CHGIN_ILIM_MAX			3200000U
+
+enum max77976_field_idx {
+	VERSION, REVISION,                      /* CHIP_REVISION */
+	CHGIN_OK,                               /* CHG_INT_OK */
+	BAT_DTLS, CHG_DTLS,                     /* CHG_DETAILS_01 */
+	MODE,                                   /* CHG_CNFG_00 */
+	CHG_CC,                                 /* CHG_CNFG_02 */
+	CHGPROT,                                /* CHG_CNFG_06 */
+	CHGIN_ILIM,                             /* CHG_CNFG_09 */
+	MAX77976_N_REGMAP_FIELDS
+};
+
+static const struct reg_field max77976_reg_field[MAX77976_N_REGMAP_FIELDS] = {
+	[VERSION]        = REG_FIELD(MAX77976_REG_CHIP_REVISION,   4, 7),
+	[REVISION]       = REG_FIELD(MAX77976_REG_CHIP_REVISION,   0, 3),
+	[CHGIN_OK]       = REG_FIELD(MAX77976_REG_CHG_INT_OK,      6, 6),
+	[CHG_DTLS]       = REG_FIELD(MAX77976_REG_CHG_DETAILS_01,  0, 3),
+	[BAT_DTLS]       = REG_FIELD(MAX77976_REG_CHG_DETAILS_01,  4, 6),
+	[MODE]           = REG_FIELD(MAX77976_REG_CHG_CNFG_00,     0, 3),
+	[CHG_CC]         = REG_FIELD(MAX77976_REG_CHG_CNFG_02,     0, 6),
+	[CHGPROT]        = REG_FIELD(MAX77976_REG_CHG_CNFG_06,     2, 3),
+	[CHGIN_ILIM]     = REG_FIELD(MAX77976_REG_CHG_CNFG_09,     0, 5),
+};
+
+static const struct regmap_config max77976_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x24,
+};
+
+/* --------------------------------------------------------------------------
+ * Data structures
+ */
+
+struct max77976 {
+	struct i2c_client	*client;
+	struct regmap		*regmap;
+	struct regmap_field	*rfield[MAX77976_N_REGMAP_FIELDS];
+};
+
+/* --------------------------------------------------------------------------
+ * power_supply properties
+ */
+
+static int max77976_get_status(struct max77976 *chg, int *val)
+{
+	unsigned int regval;
+	int err;
+
+	err = regmap_field_read(chg->rfield[CHG_DTLS], &regval);
+	if (err < 0)
+		return err;
+
+	switch (regval) {
+	case MAX77976_CHARGING_PREQUALIFICATION:
+	case MAX77976_CHARGING_FAST_CONST_CURRENT:
+	case MAX77976_CHARGING_FAST_CONST_VOLTAGE:
+	case MAX77976_CHARGING_TOP_OFF:
+		*val = POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	case MAX77976_CHARGING_DONE:
+		*val = POWER_SUPPLY_STATUS_FULL;
+		break;
+	case MAX77976_CHARGING_TIMER_FAULT:
+	case MAX77976_CHARGING_SUSPENDED_QBATT_OFF:
+	case MAX77976_CHARGING_SUSPENDED_JEITA:
+	case MAX77976_CHARGING_SUSPENDED_THM_REMOVAL:
+	case MAX77976_CHARGING_SUSPENDED_PIN:
+		*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case MAX77976_CHARGING_OFF:
+	case MAX77976_CHARGING_THERMAL_SHUTDOWN:
+	case MAX77976_CHARGING_WATCHDOG_EXPIRED:
+		*val = POWER_SUPPLY_STATUS_DISCHARGING;
+		break;
+	default:
+		*val = POWER_SUPPLY_STATUS_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static int max77976_get_charge_type(struct max77976 *chg, int *val)
+{
+	unsigned int regval;
+	int err;
+
+	err = regmap_field_read(chg->rfield[CHG_DTLS], &regval);
+	if (err < 0)
+		return err;
+
+	switch (regval) {
+	case MAX77976_CHARGING_PREQUALIFICATION:
+		*val = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+		break;
+	case MAX77976_CHARGING_FAST_CONST_CURRENT:
+	case MAX77976_CHARGING_FAST_CONST_VOLTAGE:
+		*val = POWER_SUPPLY_CHARGE_TYPE_FAST;
+		break;
+	case MAX77976_CHARGING_TOP_OFF:
+		*val = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
+		break;
+	case MAX77976_CHARGING_DONE:
+	case MAX77976_CHARGING_TIMER_FAULT:
+	case MAX77976_CHARGING_SUSPENDED_QBATT_OFF:
+	case MAX77976_CHARGING_OFF:
+	case MAX77976_CHARGING_THERMAL_SHUTDOWN:
+	case MAX77976_CHARGING_WATCHDOG_EXPIRED:
+	case MAX77976_CHARGING_SUSPENDED_JEITA:
+	case MAX77976_CHARGING_SUSPENDED_THM_REMOVAL:
+	case MAX77976_CHARGING_SUSPENDED_PIN:
+		*val = POWER_SUPPLY_CHARGE_TYPE_NONE;
+		break;
+	default:
+		*val = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static int max77976_get_health(struct max77976 *chg, int *val)
+{
+	unsigned int regval;
+	int err;
+
+	err = regmap_field_read(chg->rfield[BAT_DTLS], &regval);
+	if (err < 0)
+		return err;
+
+	switch (regval) {
+	case MAX77976_BATTERY_BATTERY_REMOVAL:
+		*val = POWER_SUPPLY_HEALTH_DEAD;
+		break;
+	case MAX77976_BATTERY_PREQUALIFICATION:
+	case MAX77976_BATTERY_LOW_VOLTAGE:
+	case MAX77976_BATTERY_REGULAR_VOLTAGE:
+		*val = POWER_SUPPLY_HEALTH_GOOD;
+		break;
+	case MAX77976_BATTERY_TIMER_FAULT:
+		*val = POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
+		break;
+	case MAX77976_BATTERY_OVERVOLTAGE:
+		*val = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+		break;
+	case MAX77976_BATTERY_BATTERY_ONLY:
+		*val = POWER_SUPPLY_HEALTH_UNKNOWN;
+		break;
+	default:
+		*val = POWER_SUPPLY_HEALTH_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static int max77976_get_online(struct max77976 *chg, int *val)
+{
+	unsigned int regval;
+	int err;
+
+	err = regmap_field_read(chg->rfield[CHGIN_OK], &regval);
+	if (err < 0)
+		return err;
+
+	*val = (regval ? 1 : 0);
+
+	return 0;
+}
+
+static int max77976_get_integer(struct max77976 *chg, enum max77976_field_idx fidx,
+				unsigned int clamp_min, unsigned int clamp_max,
+				unsigned int mult, int *val)
+{
+	unsigned int regval;
+	int err;
+
+	err = regmap_field_read(chg->rfield[fidx], &regval);
+	if (err < 0)
+		return err;
+
+	*val = clamp_val(regval * mult, clamp_min, clamp_max);
+
+	return 0;
+}
+
+static int max77976_set_integer(struct max77976 *chg, enum max77976_field_idx fidx,
+				unsigned int clamp_min, unsigned int clamp_max,
+				unsigned int div, int val)
+{
+	unsigned int regval;
+
+	regval = clamp_val(val, clamp_min, clamp_max) / div;
+
+	return regmap_field_write(chg->rfield[fidx], regval);
+}
+
+static int max77976_get_property(struct power_supply *psy,
+				 enum power_supply_property psp,
+				 union power_supply_propval *val)
+{
+	struct max77976 *chg = power_supply_get_drvdata(psy);
+	int err = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		err = max77976_get_status(chg, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		err = max77976_get_charge_type(chg, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_HEALTH:
+		err = max77976_get_health(chg, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		err = max77976_get_online(chg, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
+		val->intval = MAX77976_CHG_CC_MAX;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+		err = max77976_get_integer(chg, CHG_CC,
+					   MAX77976_CHG_CC_MIN,
+					   MAX77976_CHG_CC_MAX,
+					   MAX77976_CHG_CC_STEP,
+					   &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		err = max77976_get_integer(chg, CHGIN_ILIM,
+					   MAX77976_CHGIN_ILIM_MIN,
+					   MAX77976_CHGIN_ILIM_MAX,
+					   MAX77976_CHGIN_ILIM_STEP,
+					   &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = max77976_model;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = max77976_manufacturer;
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
+static int max77976_set_property(struct power_supply *psy,
+				 enum power_supply_property psp,
+				 const union power_supply_propval *val)
+{
+	struct max77976 *chg = power_supply_get_drvdata(psy);
+	int err = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+		err = max77976_set_integer(chg, CHG_CC,
+					   MAX77976_CHG_CC_MIN,
+					   MAX77976_CHG_CC_MAX,
+					   MAX77976_CHG_CC_STEP,
+					   val->intval);
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		err = max77976_set_integer(chg, CHGIN_ILIM,
+					   MAX77976_CHGIN_ILIM_MIN,
+					   MAX77976_CHGIN_ILIM_MAX,
+					   MAX77976_CHGIN_ILIM_STEP,
+					   val->intval);
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	return err;
+};
+
+static int max77976_property_is_writeable(struct power_supply *psy,
+					  enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static enum power_supply_property max77976_psy_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+static const struct power_supply_desc max77976_psy_desc = {
+	.name			= MAX77976_DRIVER_NAME,
+	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.properties		= max77976_psy_props,
+	.num_properties		= ARRAY_SIZE(max77976_psy_props),
+	.get_property		= max77976_get_property,
+	.set_property		= max77976_set_property,
+	.property_is_writeable	= max77976_property_is_writeable,
+};
+
+/* --------------------------------------------------------------------------
+ * Entry point
+ */
+
+static int max77976_detect(struct max77976 *chg)
+{
+	struct device *dev = &chg->client->dev;
+	unsigned int id, ver, rev;
+	int err;
+
+	err = regmap_read(chg->regmap, MAX77976_REG_CHIP_ID, &id);
+	if (err)
+		return dev_err_probe(dev, err, "cannot read chip ID\n");
+
+	if (id != MAX77976_CHIP_ID)
+		return dev_err_probe(dev, -ENXIO, "unknown model ID 0x%02x\n", id);
+
+	err = regmap_field_read(chg->rfield[VERSION], &ver);
+	if (!err)
+		err = regmap_field_read(chg->rfield[REVISION], &rev);
+	if (err)
+		return dev_err_probe(dev, -ENXIO, "cannot read version/revision\n");
+
+	dev_info(dev, "detected model MAX779%02x ver %u rev %u", id, ver, rev);
+
+	return 0;
+}
+static int max77976_configure(struct max77976 *chg)
+{
+	struct device *dev = &chg->client->dev;
+	int err;
+
+	/* Magic value to unlock writing to some registers */
+	err = regmap_field_write(chg->rfield[CHGPROT], 0x3);
+	if (err)
+		goto err;
+
+	/*
+	 * Mode 5 = Charger ON, OTG OFF, buck ON, boost OFF.
+	 * Other modes are not implemented by this driver.
+	 */
+	err = regmap_field_write(chg->rfield[MODE], MAX77976_MODE_CHARGER_BUCK);
+	if (err)
+		goto err;
+
+	return 0;
+
+err:
+	return dev_err_probe(dev, err, "error while configuring");
+}
+
+static int max77976_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct power_supply_config psy_cfg = {};
+	struct power_supply *psy;
+	struct max77976 *chg;
+	int err;
+	int i;
+
+	chg = devm_kzalloc(dev, sizeof(*chg), GFP_KERNEL);
+	if (!chg)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, chg);
+	psy_cfg.drv_data = chg;
+	chg->client = client;
+
+	chg->regmap = devm_regmap_init_i2c(client, &max77976_regmap_config);
+	if (IS_ERR(chg->regmap))
+		return dev_err_probe(dev, PTR_ERR(chg->regmap),
+				     "cannot allocate regmap\n");
+
+	for (i = 0; i < MAX77976_N_REGMAP_FIELDS; i++) {
+		chg->rfield[i] = devm_regmap_field_alloc(dev, chg->regmap,
+							 max77976_reg_field[i]);
+		if (IS_ERR(chg->rfield[i]))
+			return dev_err_probe(dev, PTR_ERR(chg->rfield[i]),
+					     "cannot allocate regmap field\n");
+	}
+
+	err = max77976_detect(chg);
+	if (err)
+		return err;
+
+	err = max77976_configure(chg);
+	if (err)
+		return err;
+
+	psy = devm_power_supply_register_no_ws(dev, &max77976_psy_desc, &psy_cfg);
+	if (IS_ERR(psy))
+		return dev_err_probe(dev, PTR_ERR(psy), "cannot register\n");
+
+	return 0;
+}
+
+static const struct i2c_device_id max77976_i2c_id[] = {
+	{ MAX77976_DRIVER_NAME, 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, max77976_i2c_id);
+
+static const struct of_device_id max77976_of_id[] = {
+	{ .compatible = "maxim,max77976" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, max77976_of_id);
+
+static struct i2c_driver max77976_driver = {
+	.driver = {
+		.name		= MAX77976_DRIVER_NAME,
+		.of_match_table	= of_match_ptr(max77976_of_id),
+	},
+	.probe_new	= max77976_probe,
+	.id_table	= max77976_i2c_id,
+};
+module_i2c_driver(max77976_driver);
+
+MODULE_AUTHOR("Luca Ceresoli <luca@lucaceresoli.net>");
+MODULE_DESCRIPTION("Maxim MAX77976 charger driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

