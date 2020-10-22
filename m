Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594CB295837
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 08:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444416AbgJVGB7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 02:01:59 -0400
Received: from jax4mhob17.registeredsite.com ([64.69.218.105]:36620 "EHLO
        jax4mhob17.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2503153AbgJVGB5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 02:01:57 -0400
X-Greylist: delayed 57057 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Oct 2020 02:01:53 EDT
Received: from mailpod.hostingplatform.com ([10.30.71.206])
        by jax4mhob17.registeredsite.com (8.14.4/8.14.4) with ESMTP id 09M61owl071627
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2020 02:01:51 -0400
Received: (qmail 7407 invoked by uid 0); 22 Oct 2020 06:01:50 -0000
X-TCPREMOTEIP: 83.128.90.119
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO phenom.domain?not?set.invalid) (mike@milosoftware.com@83.128.90.119)
  by 0 with ESMTPA; 22 Oct 2020 06:01:50 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     sre@kernel.org, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] power/supply: Add ltc4162-l-charger
Date:   Thu, 22 Oct 2020 08:01:42 +0200
Message-Id: <20201022060142.26863-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for the LTC4162-L Li-Ion battery charger. The driver allows
reading back telemetry and to set some charging options like the input
current limit.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/power/supply/Kconfig             |   8 +
 drivers/power/supply/Makefile            |   1 +
 drivers/power/supply/ltc4162-l-charger.c | 847 +++++++++++++++++++++++
 3 files changed, 856 insertions(+)
 create mode 100644 drivers/power/supply/ltc4162-l-charger.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index faf2830aa152..ce5c35d08bb5 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -508,6 +508,14 @@ config CHARGER_LT3651
 	  Say Y to include support for the Analog Devices (Linear Technology)
 	  LT3651 battery charger which reports its status via GPIO lines.
 
+config CHARGER_LTC4162L
+	tristate "LTC4162-L charger"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y to include support for the Analog Devices (Linear Technology)
+	  LTC4162-L battery charger connected to I2C.
+
 config CHARGER_MAX14577
 	tristate "Maxim MAX14577/77836 battery charger driver"
 	depends on MFD_MAX14577
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index b3c694a65114..fe6881d6ef0f 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_CHARGER_LP8788)	+= lp8788-charger.o
 obj-$(CONFIG_CHARGER_GPIO)	+= gpio-charger.o
 obj-$(CONFIG_CHARGER_MANAGER)	+= charger-manager.o
 obj-$(CONFIG_CHARGER_LT3651)	+= lt3651-charger.o
+obj-$(CONFIG_CHARGER_LTC4162L)	+= ltc4162-l-charger.o
 obj-$(CONFIG_CHARGER_MAX14577)	+= max14577_charger.o
 obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+= max14656_charger_detector.o
 obj-$(CONFIG_CHARGER_MAX77650)	+= max77650-charger.o
diff --git a/drivers/power/supply/ltc4162-l-charger.c b/drivers/power/supply/ltc4162-l-charger.c
new file mode 100644
index 000000000000..4560a1ac5a08
--- /dev/null
+++ b/drivers/power/supply/ltc4162-l-charger.c
@@ -0,0 +1,847 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Driver for Analog Devices (Linear Technology) LTC4162-L charger IC.
+ *  Copyright (C) 2020, Topic Embedded Products
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/of_irq.h>
+#include <linux/of_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/power_supply.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+
+/* Registers (names based on what datasheet uses) */
+#define LTC4162L_EN_LIMIT_ALERTS_REG		0x0D
+#define LTC4162L_EN_CHARGER_STATE_ALERTS_REG	0x0E
+#define LTC4162L_EN_CHARGE_STATUS_ALERTS_REG	0x0F
+#define LTC4162L_CONFIG_BITS_REG		0x14
+#define LTC4162L_IIN_LIMIT_TARGET		0x15
+#define LTC4162L_ARM_SHIP_MODE			0x19
+#define LTC4162L_CHARGE_CURRENT_SETTING		0X1A
+#define LTC4162L_VCHARGE_SETTING		0X1B
+#define LTC4162L_C_OVER_X_THRESHOLD		0x1C
+#define LTC4162L_MAX_CV_TIME			0X1D
+#define LTC4162L_MAX_CHARGE_TIME		0X1E
+#define LTC4162L_CHARGER_CONFIG_BITS		0x29
+#define LTC4162L_CHARGER_STATE			0x34
+#define LTC4162L_CHARGE_STATUS			0x35
+#define LTC4162L_LIMIT_ALERTS_REG		0x36
+#define LTC4162L_CHARGER_STATE_ALERTS_REG	0x37
+#define LTC4162L_CHARGE_STATUS_ALERTS_REG	0x38
+#define LTC4162L_SYSTEM_STATUS_REG		0x39
+#define LTC4162L_VBAT				0x3A
+#define LTC4162L_VIN				0x3B
+#define LTC4162L_VOUT				0x3C
+#define LTC4162L_IBAT				0x3D
+#define LTC4162L_IIN				0x3E
+#define LTC4162L_DIE_TEMPERATURE		0x3F
+#define LTC4162L_THERMISTOR_VOLTAGE		0x40
+#define LTC4162L_BSR				0x41
+#define LTC4162L_JEITA_REGION			0x42
+#define LTC4162L_CHEM_CELLS_REG			0x43
+#define LTC4162L_ICHARGE_DAC			0x44
+#define LTC4162L_VCHARGE_DAC			0x45
+#define LTC4162L_IIN_LIMIT_DAC			0x46
+#define LTC4162L_VBAT_FILT			0x47
+#define LTC4162L_INPUT_UNDERVOLTAGE_DAC		0x4B
+
+/* Enumeration as in datasheet. Individual bits are mutually exclusive. */
+enum ltc4162l_state {
+	battery_detection = 2048,
+	charger_suspended = 256,
+	precharge = 128,   /* trickle on low bat voltage */
+	cc_cv_charge = 64, /* normal charge */
+	ntc_pause = 32,
+	timer_term = 16,
+	c_over_x_term = 8, /* battery is full */
+	max_charge_time_fault = 4,
+	bat_missing_fault = 2,
+	bat_short_fault = 1
+};
+
+/* Individual bits are mutually exclusive. Only active in charging states.*/
+enum ltc4162l_charge_status {
+	ilim_reg_active = 32,
+	thermal_reg_active = 16,
+	vin_uvcl_active = 8,
+	iin_limit_active = 4,
+	constant_current = 2,
+	constant_voltage = 1,
+	charger_off = 0
+};
+
+/* Magic number to write to ARM_SHIP_MODE register */
+#define LTC4162L_ARM_SHIP_MODE_MAGIC 21325
+
+
+struct ltc4162l_info {
+	struct i2c_client	*client;
+	struct regmap		*regmap;
+	struct power_supply	*charger;
+	u32 rsnsb;	/* Series resistor that sets charge current, mOhm */
+	u32 rsnsi;	/* Series resistor to measure input current, mOhm */
+	u8 cell_count;	/* Number of connected cells, 0 while unknown */
+};
+
+static u8 ltc4162l_get_cell_count(struct ltc4162l_info *info)
+{
+	int ret;
+	unsigned int val;
+
+	/* Once read successfully */
+	if (info->cell_count)
+		return info->cell_count;
+
+	ret = regmap_read(info->regmap, LTC4162L_CHEM_CELLS_REG, &val);
+	if (ret)
+		return 0;
+
+	/* Lower 4 bits is the cell count, or 0 if the chip doesn't know yet */
+	val &= 0x0f;
+	if (!val)
+		return 0;
+
+	/* Once determined, keep the value */
+	info->cell_count = val;
+
+	return val;
+};
+
+/* Convert enum value to POWER_SUPPLY_STATUS value */
+static int ltc4162l_state_decode(enum ltc4162l_state value)
+{
+	switch (value) {
+	case precharge:
+	case cc_cv_charge:
+		return POWER_SUPPLY_STATUS_CHARGING;
+	case c_over_x_term:
+		return POWER_SUPPLY_STATUS_FULL;
+	case bat_missing_fault:
+	case bat_short_fault:
+		return POWER_SUPPLY_STATUS_UNKNOWN;
+	default:
+		return POWER_SUPPLY_STATUS_NOT_CHARGING;
+	}
+};
+
+static int ltc4162l_get_status(struct ltc4162l_info *info,
+			       union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(info->regmap, LTC4162L_CHARGER_STATE, &regval);
+	if (ret) {
+		dev_err(&info->client->dev, "Failed to read CHARGER_STATE\n");
+		return ret;
+	}
+
+	val->intval = ltc4162l_state_decode(regval);
+
+	return 0;
+}
+
+static int ltc4162l_charge_status_decode(enum ltc4162l_charge_status value)
+{
+	if (!value)
+		return POWER_SUPPLY_CHARGE_TYPE_NONE;
+
+	/* constant voltage/current and input_current limit are "fast" modes */
+	if (value <= iin_limit_active)
+		return POWER_SUPPLY_CHARGE_TYPE_FAST;
+
+	/* Anything that's not fast we'll return as trickle */
+	return POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+}
+
+static int ltc4162l_get_charge_type(struct ltc4162l_info *info,
+				    union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(info->regmap, LTC4162L_CHARGE_STATUS, &regval);
+	if (ret)
+		return ret;
+
+	val->intval = ltc4162l_charge_status_decode(regval);
+
+	return 0;
+}
+
+static int ltc4162l_state_to_health(enum ltc4162l_state value)
+{
+	switch (value) {
+	case ntc_pause:
+		return POWER_SUPPLY_HEALTH_OVERHEAT;
+	case timer_term:
+		return POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
+	case max_charge_time_fault:
+		return POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE;
+	case bat_missing_fault:
+		return POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+	case bat_short_fault:
+		return POWER_SUPPLY_HEALTH_DEAD;
+	default:
+		return POWER_SUPPLY_HEALTH_GOOD;
+	}
+}
+
+static int ltc4162l_get_health(struct ltc4162l_info *info,
+			       union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(info->regmap, LTC4162L_CHARGER_STATE, &regval);
+	if (ret)
+		return ret;
+
+	val->intval = ltc4162l_state_to_health(regval);
+
+	return 0;
+}
+
+static int ltc4162l_get_online(struct ltc4162l_info *info,
+			       union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(info->regmap, LTC4162L_SYSTEM_STATUS_REG, &regval);
+	if (ret)
+		return ret;
+
+	/* BIT(2) indicates if input voltage is sufficient to charge */
+	val->intval = !!(regval & BIT(2));
+
+	return 0;
+}
+
+
+static int ltc4162l_get_vbat(struct ltc4162l_info *info,
+				  unsigned int reg,
+				  union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(info->regmap, reg, &regval);
+	if (ret)
+		return ret;
+
+	/* cell_count × 192.4μV/LSB */
+	regval *= 1924;
+	regval *= ltc4162l_get_cell_count(info);
+	regval /= 10;
+	val->intval = regval;
+
+	return 0;
+}
+
+static int ltc4162l_get_ibat(struct ltc4162l_info *info,
+			     union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(info->regmap, LTC4162L_IBAT, &regval);
+	if (ret)
+		return ret;
+
+	/* Signed 16-bit number, 1.466μV / RSNSB amperes/LSB. */
+	val->intval = (int)((s16)(regval & 0xFFFF)) * 1466 / (int)info->rsnsb;
+
+	return 0;
+}
+
+static int ltc4162l_get_icharge(struct ltc4162l_info *info,
+				unsigned int reg,
+				union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(info->regmap, reg, &regval);
+	if (ret)
+		return ret;
+
+	regval &= BIT(6) - 1; /* Only the lower 5 bits */
+
+	/* The charge current servo level: (icharge_dac + 1) × 1mV/RSNSB */
+	val->intval = 1000000 * (regval + 1) / info->rsnsb;
+
+	return 0;
+}
+
+static int ltc4162l_set_icharge(struct ltc4162l_info *info,
+				unsigned int reg,
+				unsigned int value)
+{
+	value *= info->rsnsb;
+	value /= 1000000;
+
+	/* Round to lowest possible */
+	if (value)
+		--value;
+
+	if (value > 31)
+		return -EINVAL;
+
+	return regmap_write(info->regmap, reg, value);
+}
+
+
+static int ltc4162l_get_vcharge(struct ltc4162l_info *info,
+				unsigned int reg,
+				union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+	u32 voltage;
+
+	ret = regmap_read(info->regmap, reg, &regval);
+	if (ret)
+		return ret;
+
+	regval &= BIT(6) - 1; /* Only the lower 5 bits */
+
+	/*
+	 * charge voltage setting can be computed from
+	 * cell_count × (vcharge_setting × 12.5mV + 3.8125V)
+	 * where vcharge_setting ranges from 0 to 31 (4.2V max).
+	 */
+	voltage = 3812500 + (regval * 12500);
+	voltage *= ltc4162l_get_cell_count(info);
+	val->intval = voltage;
+
+	return 0;
+}
+
+static int ltc4162l_set_vcharge(struct ltc4162l_info *info,
+				unsigned int reg,
+				unsigned int value)
+{
+	u8 cell_count = ltc4162l_get_cell_count(info);
+
+	if (!cell_count)
+		return -EBUSY; /* Not available yet, try again later */
+
+	value /= cell_count;
+
+	if (value < 3812500)
+		return -EINVAL;
+
+	value -= 3812500;
+	value /= 12500;
+
+	if (value > 31)
+		return -EINVAL;
+
+	return regmap_write(info->regmap, reg, value);
+}
+
+static int ltc4162l_get_iin_limit_dac(struct ltc4162l_info *info,
+				     union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(info->regmap, LTC4162L_IIN_LIMIT_DAC, &regval);
+	if (ret)
+		return ret;
+
+	/* (iin_limit_dac + 1) × 500μV / RSNSI */
+	++regval;
+	val->intval = (500000 * regval) / info->rsnsi;
+
+	return 0;
+}
+
+static int ltc4162l_set_iin_limit(struct ltc4162l_info *info,
+				  unsigned int value)
+{
+	unsigned int regval;
+
+	regval = value * info->rsnsi;
+	regval /= 500000;
+	if (regval)
+		--regval;
+	if (regval > 63)
+		regval = 63;
+
+	return regmap_write(info->regmap, LTC4162L_IIN_LIMIT_TARGET, regval);
+}
+
+static int ltc4162l_get_die_temp(struct ltc4162l_info *info,
+				 union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(info->regmap, LTC4162L_DIE_TEMPERATURE, &regval);
+	if (ret)
+		return ret;
+
+	/* die_temp × 0.0215°C/LSB - 264.4°C */
+	ret = (s16)(regval & 0xFFFF);
+	ret *= 215;
+	ret /= 100; /* Centidegrees scale */
+	ret -= 26440;
+	val->intval = ret;
+
+	return 0;
+}
+
+static int ltc4162l_get_term_current(struct ltc4162l_info *info,
+				     union power_supply_propval *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(info->regmap, LTC4162L_CHARGER_CONFIG_BITS, &regval);
+	if (ret)
+		return ret;
+
+	/* Check if C_OVER_X_THRESHOLD is enabled */
+	if (!(regval & BIT(2))) {
+		val->intval = 0;
+		return 0;
+	}
+
+	ret = regmap_read(info->regmap, LTC4162L_C_OVER_X_THRESHOLD, &regval);
+	if (ret)
+		return ret;
+
+	/* 1.466μV / RSNSB amperes/LSB */
+	val->intval = (1466 * regval) / info->rsnsb;
+
+	return 0;
+}
+
+static int ltc4162l_set_term_current(struct ltc4162l_info *info,
+				     unsigned int value)
+{
+	int ret;
+	unsigned int regval;
+
+	if (!value) {
+		/* Disable en_c_over_x_term when set to zero */
+		return regmap_update_bits(info->regmap,
+					  LTC4162L_CHARGER_CONFIG_BITS,
+					  BIT(2), 0);
+	}
+
+	regval = DIV_ROUND_CLOSEST(value * info->rsnsb, 1466);
+
+	ret =  regmap_write(info->regmap, LTC4162L_C_OVER_X_THRESHOLD, regval);
+	if (ret)
+		return ret;
+
+	/* Set en_c_over_x_term after changing the threshold value */
+	return regmap_update_bits(info->regmap, LTC4162L_CHARGER_CONFIG_BITS,
+				  BIT(2), BIT(2));
+}
+
+/* Custom properties */
+static const char * const ltc4162l_charge_status_name[] = {
+	"ilim_reg_active", /* 32 */
+	"thermal_reg_active",
+	"vin_uvcl_active",
+	"iin_limit_active",
+	"constant_current",
+	"constant_voltage",
+	"charger_off" /* 0 */
+};
+
+static ssize_t charge_status_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct power_supply *psy = to_power_supply(dev);
+	struct ltc4162l_info *info = power_supply_get_drvdata(psy);
+	const char *result = ltc4162l_charge_status_name[
+				ARRAY_SIZE(ltc4162l_charge_status_name) - 1];
+	unsigned int regval;
+	unsigned int mask;
+	unsigned int index;
+	int ret;
+
+	ret = regmap_read(info->regmap, LTC4162L_CHARGE_STATUS, &regval);
+	if (ret)
+		return ret;
+
+	/* Only one bit is set according to datasheet, let's be safe here */
+	for (mask = 32, index = 0; mask != 0; mask >>= 1, ++index) {
+		if (regval & mask) {
+			result = ltc4162l_charge_status_name[index];
+			break;
+		}
+	}
+
+	return sprintf(buf, "%s\n", result);
+}
+static DEVICE_ATTR_RO(charge_status);
+
+static ssize_t input_voltage_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct power_supply *psy = to_power_supply(dev);
+	struct ltc4162l_info *info = power_supply_get_drvdata(psy);
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(info->regmap, LTC4162L_VIN, &regval);
+	if (ret)
+		return ret;
+
+	/* 1.649mV/LSB */
+	regval *= 1694;
+
+	return sprintf(buf, "%u\n", regval);
+}
+static DEVICE_ATTR_RO(input_voltage);
+
+static ssize_t input_current_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct power_supply *psy = to_power_supply(dev);
+	struct ltc4162l_info *info = power_supply_get_drvdata(psy);
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(info->regmap, LTC4162L_IIN, &regval);
+	if (ret)
+		return ret;
+
+	/* Signed 16-bit number, 1.466μV / RSNSI amperes/LSB. */
+	ret = (int)((s16)(regval & 0xFFFF)) * 1466 / (int)info->rsnsi;
+
+	return sprintf(buf, "%u\n", ret);
+}
+static DEVICE_ATTR_RO(input_current);
+
+static ssize_t force_telemetry_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct power_supply *psy = to_power_supply(dev);
+	struct ltc4162l_info *info = power_supply_get_drvdata(psy);
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(info->regmap, LTC4162L_CONFIG_BITS_REG, &regval);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n", regval & BIT(2) ? 1 : 0);
+}
+
+static ssize_t force_telemetry_store(struct device *dev,
+	struct device_attribute *attr,
+	const char *buf,
+	size_t count)
+{
+	struct power_supply *psy = to_power_supply(dev);
+	struct ltc4162l_info *info = power_supply_get_drvdata(psy);
+	int ret;
+	unsigned int value;
+
+	ret = kstrtouint(buf, 0, &value);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(info->regmap, LTC4162L_CONFIG_BITS_REG,
+				 BIT(2), value ? BIT(2) : 0);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(force_telemetry);
+
+static ssize_t arm_ship_mode_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct power_supply *psy = to_power_supply(dev);
+	struct ltc4162l_info *info = power_supply_get_drvdata(psy);
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(info->regmap, LTC4162L_ARM_SHIP_MODE, &regval);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%u\n",
+		regval == LTC4162L_ARM_SHIP_MODE_MAGIC ? 1 : 0);
+}
+
+static ssize_t arm_ship_mode_store(struct device *dev,
+	struct device_attribute *attr,
+	const char *buf,
+	size_t count)
+{
+	struct power_supply *psy = to_power_supply(dev);
+	struct ltc4162l_info *info = power_supply_get_drvdata(psy);
+	int ret;
+	unsigned int value;
+
+	ret = kstrtouint(buf, 0, &value);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(info->regmap, LTC4162L_ARM_SHIP_MODE,
+				value ? LTC4162L_ARM_SHIP_MODE_MAGIC : 0);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(arm_ship_mode);
+
+static struct attribute *ltc4162l_sysfs_entries[] = {
+	&dev_attr_charge_status.attr,
+	&dev_attr_input_voltage.attr,
+	&dev_attr_input_current.attr,
+	&dev_attr_force_telemetry.attr,
+	&dev_attr_arm_ship_mode.attr,
+	NULL,
+};
+
+static struct attribute_group ltc4162l_attr_group = {
+	.name	= NULL,	/* put in device directory */
+	.attrs	= ltc4162l_sysfs_entries,
+};
+
+static int ltc4162l_get_property(struct power_supply *psy,
+				 enum power_supply_property psp,
+				 union power_supply_propval *val)
+{
+	struct ltc4162l_info *info = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		return ltc4162l_get_status(info, val);
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		return ltc4162l_get_charge_type(info, val);
+	case POWER_SUPPLY_PROP_HEALTH:
+		return ltc4162l_get_health(info, val);
+	case POWER_SUPPLY_PROP_ONLINE:
+		return ltc4162l_get_online(info, val);
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		return ltc4162l_get_vbat(info, LTC4162L_VBAT, val);
+	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
+		return ltc4162l_get_vbat(info, LTC4162L_VBAT_FILT, val);
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		return ltc4162l_get_ibat(info, val);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		return ltc4162l_get_icharge(info,
+				LTC4162L_ICHARGE_DAC, val);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		return ltc4162l_get_icharge(info,
+				LTC4162L_CHARGE_CURRENT_SETTING, val);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		return ltc4162l_get_vcharge(info,
+				LTC4162L_VCHARGE_DAC, val);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		return ltc4162l_get_vcharge(info,
+				LTC4162L_VCHARGE_SETTING, val);
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return ltc4162l_get_iin_limit_dac(info, val);
+	case POWER_SUPPLY_PROP_TEMP:
+		return ltc4162l_get_die_temp(info, val);
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		return ltc4162l_get_term_current(info, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltc4162l_set_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 const union power_supply_propval *val)
+{
+	struct ltc4162l_info *info = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		return ltc4162l_set_icharge(info,
+				LTC4162L_CHARGE_CURRENT_SETTING, val->intval);
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		return ltc4162l_set_vcharge(info,
+				LTC4162L_VCHARGE_SETTING, val->intval);
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return ltc4162l_set_iin_limit(info, val->intval);
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		return ltc4162l_set_term_current(info, val->intval);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltc4162l_property_is_writeable(struct power_supply *psy,
+						enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+/* Charger power supply property routines */
+static enum power_supply_property ltc4162l_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW, /* Reports battery voltage */
+	POWER_SUPPLY_PROP_VOLTAGE_AVG,
+	POWER_SUPPLY_PROP_CURRENT_NOW, /* Reports battery current */
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+};
+
+static const struct power_supply_desc ltc4162l_desc = {
+	.name		= "ltc4162-l",
+	.type		= POWER_SUPPLY_TYPE_MAINS,
+	.properties	= ltc4162l_properties,
+	.num_properties	= ARRAY_SIZE(ltc4162l_properties),
+	.get_property	= ltc4162l_get_property,
+	.set_property	= ltc4162l_set_property,
+	.property_is_writeable = ltc4162l_property_is_writeable,
+};
+
+static bool ltc4162l_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	/* all registers up to this one are writeable */
+	if (reg <= LTC4162L_CHARGER_CONFIG_BITS)
+		return true;
+
+	/* The ALERTS registers can be written to clear alerts */
+	if (reg >= LTC4162L_LIMIT_ALERTS_REG &&
+	    reg <= LTC4162L_CHARGE_STATUS_ALERTS_REG)
+		return true;
+
+	return false;
+}
+
+static bool ltc4162l_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	/* all registers after this one are read-only status registers */
+	return reg > LTC4162L_CHARGER_CONFIG_BITS;
+}
+
+static const struct regmap_config ltc4162l_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 16,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.writeable_reg	= ltc4162l_is_writeable_reg,
+	.volatile_reg	= ltc4162l_is_volatile_reg,
+	.max_register	= LTC4162L_INPUT_UNDERVOLTAGE_DAC,
+	.cache_type	= REGCACHE_RBTREE,
+};
+
+static int ltc4162l_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = client->adapter;
+	struct device *dev = &client->dev;
+	struct ltc4162l_info *info;
+	struct power_supply_config ltc4162l_config = {};
+	int ret;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA)) {
+		dev_err(dev, "No support for SMBUS_WORD_DATA\n");
+		return -ENODEV;
+	}
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->client = client;
+	i2c_set_clientdata(client, info);
+
+	info->regmap = devm_regmap_init_i2c(client, &ltc4162l_regmap_config);
+	if (IS_ERR(info->regmap)) {
+		dev_err(dev, "Failed to initialize register map\n");
+		return PTR_ERR(info->regmap);
+	}
+
+	ret = device_property_read_u32(dev, "lltc,rsnsb", &info->rsnsb);
+	if (ret) {
+		dev_err(dev, "Missing lltc,rsnsb property, assume 10 mOhm\n");
+		info->rsnsb = 10;
+	}
+	ret = device_property_read_u32(dev, "lltc,rsnsi", &info->rsnsi);
+	if (ret) {
+		dev_err(dev, "Missing lltc,rsnsi property, assume 10 mOhm\n");
+		info->rsnsi = 10;
+	}
+
+	ltc4162l_config.of_node = dev->of_node;
+	ltc4162l_config.drv_data = info;
+
+	info->charger = devm_power_supply_register(dev, &ltc4162l_desc,
+						   &ltc4162l_config);
+	if (IS_ERR(info->charger)) {
+		dev_err(dev, "Failed to register charger\n");
+		return PTR_ERR(info->charger);
+	}
+
+	ret = sysfs_create_group(&info->charger->dev.kobj,
+				 &ltc4162l_attr_group);
+	if (ret)
+		dev_err(dev, "failed to create extra sysfs entries\n");
+
+	return 0;
+}
+
+static int ltc4162l_remove(struct i2c_client *client)
+{
+	struct ltc4162l_info *info = i2c_get_clientdata(client);
+
+	sysfs_remove_group(&info->charger->dev.kobj, &ltc4162l_attr_group);
+
+	return 0;
+}
+
+static const struct i2c_device_id ltc4162l_i2c_id_table[] = {
+	{ "ltc4162-l", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, ltc4162l_i2c_id_table);
+
+static const struct of_device_id ltc4162l_of_match[] = {
+	{ .compatible = "lltc,ltc4162-l", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ltc4162l_of_match);
+
+static struct i2c_driver ltc4162l_driver = {
+	.probe		= ltc4162l_probe,
+	.remove		= ltc4162l_remove,
+	.id_table	= ltc4162l_i2c_id_table,
+	.driver = {
+		.name		= "ltc4162-l-charger",
+		.of_match_table	= of_match_ptr(ltc4162l_of_match),
+	},
+};
+module_i2c_driver(ltc4162l_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
+MODULE_DESCRIPTION("LTC4162-L charger driver");
-- 
2.17.1

