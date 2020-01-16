Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F0013EBF8
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 18:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394462AbgAPRxs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 12:53:48 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58728 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394449AbgAPRxp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 12:53:45 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00GHrf0E014811;
        Thu, 16 Jan 2020 11:53:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579197221;
        bh=qaBsAfmSFg8mIdSDEGZ/dwo7l0nNwFDMMGQp4E3pBbU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HztZvj9kq0qzuOYBoArsvM1sMBxLVx/RtDDgsLCm0wbNn4KIUGKpGQX/AgKKrjr0A
         +ObSi5cLFAXTnrvgHdln788/kgYSu7DMys23YswIXcXjHB/0CkNj07CVbNCAMCDjNR
         Un2sQTLegX0pQnY0x1V8RZBzbVdNjH1yRKMnbxH8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00GHrffw128719
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Jan 2020 11:53:41 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 16
 Jan 2020 11:53:41 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 16 Jan 2020 11:53:41 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00GHrfF1058150;
        Thu, 16 Jan 2020 11:53:41 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <sebastian.reichel@collabora.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v4 4/4] power: supply: bq2515x: Introduce the bq2515x family
Date:   Thu, 16 Jan 2020 11:50:39 -0600
Message-ID: <20200116175039.1317-5-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116175039.1317-1-dmurphy@ti.com>
References: <20200116175039.1317-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce the bq25150 and bq25155 supply chargers.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/power/supply/Kconfig           |   8 +
 drivers/power/supply/Makefile          |   1 +
 drivers/power/supply/bq2515x_charger.c | 739 +++++++++++++++++++++++++
 3 files changed, 748 insertions(+)
 create mode 100644 drivers/power/supply/bq2515x_charger.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 27164a1d3c7c..ee9f4b29e0b7 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -589,6 +589,14 @@ config CHARGER_BQ24735
 	help
 	  Say Y to enable support for the TI BQ24735 battery charger.
 
+config CHARGER_BQ2515X
+	tristate "TI BQ2515X battery charger family"
+	depends on I2C
+	depends on GPIOLIB || COMPILE_TEST
+	select REGMAP_I2C
+	help
+	  Say Y to enable support for the TI BQ2515X battery charger.
+
 config CHARGER_BQ25890
 	tristate "TI BQ25890 battery charger driver"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 6c7da920ea83..8fcc175a7e22 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_CHARGER_BQ2415X)	+= bq2415x_charger.o
 obj-$(CONFIG_CHARGER_BQ24190)	+= bq24190_charger.o
 obj-$(CONFIG_CHARGER_BQ24257)	+= bq24257_charger.o
 obj-$(CONFIG_CHARGER_BQ24735)	+= bq24735-charger.o
+obj-$(CONFIG_CHARGER_BQ2515X)	+= bq2515x_charger.o
 obj-$(CONFIG_CHARGER_BQ25890)	+= bq25890_charger.o
 obj-$(CONFIG_CHARGER_SMB347)	+= smb347-charger.o
 obj-$(CONFIG_CHARGER_TPS65090)	+= tps65090-charger.o
diff --git a/drivers/power/supply/bq2515x_charger.c b/drivers/power/supply/bq2515x_charger.c
new file mode 100644
index 000000000000..dbf84bef4976
--- /dev/null
+++ b/drivers/power/supply/bq2515x_charger.c
@@ -0,0 +1,739 @@
+// SPDX-License-Identifier: GPL-2.0
+// BQ2515X Battery Charger Driver
+// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#define BQ2515X_MANUFACTURER "Texas Instruments"
+
+#define BQ2515X_STAT0		0x00
+#define BQ2515X_STAT1		0x01
+#define BQ2515X_STAT2		0x02
+#define BQ2515X_FLAG0		0x03
+#define BQ2515X_FLAG1		0x04
+#define BQ2515X_FLAG2		0x05
+#define BQ2515X_FLAG3		0x06
+#define BQ2515X_MASK0		0x07
+#define BQ2515X_MASK1		0x08
+#define BQ2515X_MASK2		0x09
+#define BQ2515X_MASK3		0x0a
+#define BQ2515X_VBAT_CTRL	0x12
+#define BQ2515X_ICHG_CTRL	0x13
+#define BQ2515X_PCHRGCTRL	0x14
+#define BQ2515X_TERMCTRL	0x15
+#define BQ2515X_BUVLO		0x16
+#define BQ2515X_CHARGERCTRL0	0x17
+#define BQ2515X_CHARGERCTRL1	0x18
+#define BQ2515X_ILIMCTRL	0x19
+#define BQ2515X_LDOCTRL		0x1d
+#define BQ2515X_MRCTRL		0x30
+#define BQ2515X_ICCTRL0		0x35
+#define BQ2515X_ICCTRL1		0x36
+#define BQ2515X_ICCTRL2		0x37
+#define BQ2515X_ADCCTRL0	0x40
+#define BQ2515X_ADCCTRL1	0x41
+#define BQ2515X_ADC_VBAT_M	0x42
+#define BQ2515X_ADC_VBAT_L	0x43
+#define BQ2515X_ADC_TS_M	0x44
+#define BQ2515X_ADC_TS_L	0x45
+#define BQ2515X_ADC_ICHG_M	0x46
+#define BQ2515X_ADC_ICHG_L	0x47
+#define BQ2515X_ADC_ADCIN_M	0x48
+#define BQ2515X_ADC_ADCIN_L	0x49
+#define BQ2515X_ADC_VIN_M	0x4a
+#define BQ2515X_ADC_VIN_L	0x4b
+#define BQ2515X_ADC_PMID_M	0x4c
+#define BQ2515X_ADC_PMID_L	0x4d
+#define BQ2515X_ADC_IIN_M	0x4e
+#define BQ2515X_ADC_IIN_L	0x4f
+#define BQ2515X_ADC_COMP1_M	0x52
+#define BQ2515X_ADC_COMP1_L	0X53
+#define BQ2515X_ADC_COMP2_M	0X54
+#define BQ2515X_ADC_COMP2_L	0x55
+#define BQ2515X_ADC_COMP3_M	0x56
+#define BQ2515X_ADC_COMP3_L	0x57
+#define BQ2515X_ADC_READ_EN	0x58
+#define BQ2515X_TS_FASTCHGCTRL	0x61
+#define BQ2515X_TS_COLD		0x62
+#define BQ2515X_TS_COOL		0x63
+#define BQ2515X_TS_WARM		0x64
+#define BQ2515X_TS_HOT		0x65
+#define BQ2515X_DEVICE_ID	0x6f
+
+#define BQ2515X_DIVISOR		65536
+#define BQ2515X_VBAT_BASE_VOLT	3600000
+#define BQ2515X_VBAT_REG_MAX	4600000
+#define BQ2515X_VBAT_REG_MIN	3600000
+#define BQ2515X_UV_FACTOR	10000
+
+#define BQ2515X_ILIM_150MA	0x2
+#define BQ2515X_ILIM_MASK	0x7
+#define BQ2515X_HEALTH_MASK	0xf
+#define BQ2515X_OVERVOLT_MASK	0x80
+
+#define BQ2515X_HOT_FLAG	BIT(0)
+#define BQ2515X_WARM_FLAG	BIT(1)
+#define BQ2515X_COOL_FLAG	BIT(2)
+#define BQ2515X_COLD_FLAG	BIT(3)
+#define BQ2515X_SAFETY_TIMER_EXP	BIT(5)
+
+#define BQ2515X_VIN_GOOD	BIT(0)
+#define BQ2515X_CHRG_DONE	BIT(5)
+#define BQ2515X_CV_CHRG_MODE	BIT(6)
+
+static const int bq2515x_ilim_lvl_values[] = {
+	50000, 100000, 150000, 200000, 300000, 400000, 500000, 600000
+};
+
+/* initial field values, converted to register values */
+struct bq2515x_init_data {
+	int ichg;	/* charge current */
+	int vreg;	/* regulation voltage */
+};
+
+struct bq2515x_device {
+	struct power_supply *mains;
+	struct power_supply *battery;
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct device *dev;
+	struct mutex lock;
+
+	struct gpio_desc *reset_gpio;
+	struct gpio_desc *lp_gpio;
+	struct gpio_desc *pg_gpio;
+	struct gpio_desc *ce_gpio;
+
+	char model_name[I2C_NAME_SIZE];
+	int mains_online;
+
+	uint32_t voltage_min_design;
+	uint32_t voltage_max_design;
+	uint32_t charge_full_design;
+
+	struct bq2515x_init_data init_data;
+};
+
+static struct reg_default bq2515x_reg_defs[] = {
+	{BQ2515X_STAT0, 0xff},
+	{BQ2515X_STAT1, 0x0},
+	{BQ2515X_STAT2, 0x0},
+	{BQ2515X_FLAG0, 0x0},
+	{BQ2515X_FLAG1, 0x0},
+	{BQ2515X_FLAG2, 0x0},
+	{BQ2515X_FLAG3, 0x0},
+	{BQ2515X_MASK0, 0x0},
+	{BQ2515X_MASK1, 0x0},
+	{BQ2515X_MASK2, 0x0},
+	{BQ2515X_MASK3, 0x0},
+};
+
+static bool bq2515x_is_ps_online(struct bq2515x_device *bq2515x)
+{
+	return bq2515x->mains_online;
+}
+
+static int bq2515x_wake_up(struct bq2515x_device *bq2515x)
+{
+	int ret;
+	int val;
+
+	/* Read the STAT register if we can read it then the device is out
+	 * of ship mode.  If the register cannot be read then attempt to wake
+	 * it up and enable the ADC.
+	 */
+	ret = regmap_read(bq2515x->regmap, BQ2515X_STAT0, &val);
+	if (!ret)
+		return ret;
+
+	/* Need to toggle LP and MR here */
+	if (bq2515x->lp_gpio)
+		gpiod_direction_output(bq2515x->lp_gpio, 1);
+
+	if (bq2515x->reset_gpio) {
+		gpiod_direction_output(bq2515x->lp_gpio, 0);
+		mdelay(2000);
+		gpiod_direction_output(bq2515x->lp_gpio, 1);
+	}
+
+	return regmap_write(bq2515x->regmap, BQ2515X_ADC_READ_EN, BIT(3));
+}
+
+static int bq2515x_update_ps_status(struct bq2515x_device *bq2515x)
+{
+	bool dc = false;
+	unsigned int val;
+	int ret;
+
+	if (bq2515x->pg_gpio)
+		val = gpiod_get_value(bq2515x->pg_gpio);
+	else {
+		ret = regmap_read(bq2515x->regmap, BQ2515X_STAT0, &val);
+		if (ret < 0)
+			return ret;
+	}
+
+	dc = val & BQ2515X_VIN_GOOD;
+
+	ret = bq2515x->mains_online != dc;
+
+	bq2515x->mains_online = dc;
+
+	return ret;
+}
+
+static int get_const_charge_current(struct bq2515x_device *bq2515x)
+{
+	int ret;
+	int iin_msb;
+	int iin_lsb;
+	u16 ichg_measurement;
+	int ilim_val, ichg_multiplier;
+
+	if (!bq2515x_is_ps_online(bq2515x))
+		return -ENODATA;
+
+	ret = regmap_read(bq2515x->regmap, BQ2515X_ADC_IIN_M, &iin_msb);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(bq2515x->regmap, BQ2515X_ADC_IIN_L, &iin_lsb);
+	if (ret < 0)
+		return ret;
+
+	ichg_measurement = (iin_msb << 8) | iin_lsb;
+	ret = regmap_read(bq2515x->regmap, BQ2515X_ILIMCTRL, &ilim_val);
+	if (ret < 0)
+		return ret;
+
+	if (ilim_val >= BQ2515X_ILIM_150MA)
+		ichg_multiplier = 350;
+	else
+		ichg_multiplier = 750;
+
+	return (ichg_measurement * 100 / BQ2515X_DIVISOR) * ichg_multiplier;
+}
+
+static int get_const_charge_voltage(struct bq2515x_device *bq2515x)
+{
+	int ret;
+	int vin_msb;
+	int vin_lsb;
+	u16 vbat_measurement;
+
+	if (!bq2515x_is_ps_online(bq2515x))
+		bq2515x_wake_up(bq2515x);
+
+	ret = regmap_read(bq2515x->regmap, BQ2515X_ADC_VBAT_M, &vin_msb);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(bq2515x->regmap, BQ2515X_ADC_VBAT_L, &vin_lsb);
+	if (ret)
+		return ret;
+
+	vbat_measurement = (vin_msb << 8) | vin_lsb;
+	return ((vbat_measurement * BQ2515X_UV_FACTOR) / BQ2515X_DIVISOR) * 6;
+}
+
+static int bq2515x_charging_status(struct bq2515x_device *bq2515x,
+				   union power_supply_propval *val)
+{
+	unsigned int status;
+	int ret;
+
+	if (!bq2515x_is_ps_online(bq2515x))
+		return 0;
+
+	ret = regmap_read(bq2515x->regmap, BQ2515X_STAT0, &status);
+	if (ret) {
+		val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+		return ret;
+	}
+
+	if (status & BQ2515X_CV_CHRG_MODE && status & BQ2515X_VIN_GOOD)
+		val->intval = POWER_SUPPLY_STATUS_CHARGING;
+	else if (status & BQ2515X_CHRG_DONE)
+		val->intval = POWER_SUPPLY_STATUS_FULL;
+	else if (status & BQ2515X_VIN_GOOD)
+		val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+	else
+		val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+
+	return ret;
+}
+
+static int bq2515x_get_batt_reg(struct bq2515x_device *bq2515x)
+{
+	int vbat_reg_code;
+	int ret;
+
+	ret = regmap_read(bq2515x->regmap, BQ2515X_VBAT_CTRL, &vbat_reg_code);
+	if (ret)
+		return ret;
+
+	return BQ2515X_VBAT_BASE_VOLT + vbat_reg_code * BQ2515X_UV_FACTOR;
+}
+
+static int bq2515x_set_batt_reg(struct bq2515x_device *bq2515x, int val)
+{
+	int vbat_reg_code;
+
+	if (val > BQ2515X_VBAT_REG_MAX || val < BQ2515X_VBAT_REG_MIN)
+		return -EINVAL;
+
+	vbat_reg_code = (val - BQ2515X_VBAT_BASE_VOLT) / BQ2515X_UV_FACTOR;
+
+	return regmap_write(bq2515x->regmap, BQ2515X_VBAT_CTRL, vbat_reg_code);
+}
+
+static int bq2515x_get_ilim_lvl(struct bq2515x_device *bq2515x)
+{
+	int ret;
+	int val;
+
+	ret = regmap_read(bq2515x->regmap, BQ2515X_ILIMCTRL, &val);
+	if (ret)
+		return ret;
+
+	return bq2515x_ilim_lvl_values[val & BQ2515X_ILIM_MASK];
+}
+
+static int bq2515x_set_ilim_lvl(struct bq2515x_device *bq2515x, int val)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(bq2515x_ilim_lvl_values); i++) {
+		if (val == bq2515x_ilim_lvl_values[i])
+			break;
+
+		if (val > bq2515x_ilim_lvl_values[i - 1] &&
+		    val < bq2515x_ilim_lvl_values[i]) {
+			if (val - bq2515x_ilim_lvl_values[i - 1] <
+			    bq2515x_ilim_lvl_values[i] - val) {
+				i = i - 1;
+				break;
+			}
+		}
+	}
+
+	return regmap_write(bq2515x->regmap, BQ2515X_ILIMCTRL, i);
+}
+
+static int bq2515x_power_supply_property_is_writeable(struct power_supply *psy,
+					enum power_supply_property prop)
+{
+	switch (prop) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int bq2515x_charger_get_health(struct bq2515x_device *bq2515x,
+				      union power_supply_propval *val)
+{
+	int health;
+	int ret;
+	int v;
+
+	if (!bq2515x_is_ps_online(bq2515x))
+		bq2515x_wake_up(bq2515x);
+
+	ret = regmap_read(bq2515x->regmap, BQ2515X_FLAG1, &v);
+	if (ret)
+		return -EIO;
+
+	if (v & BQ2515X_HEALTH_MASK) {
+		switch (v & BQ2515X_HEALTH_MASK) {
+		case BQ2515X_HOT_FLAG:
+			health = POWER_SUPPLY_HEALTH_HOT;
+			break;
+		case BQ2515X_WARM_FLAG:
+			health = POWER_SUPPLY_HEALTH_WARM;
+			break;
+		case BQ2515X_COOL_FLAG:
+			health = POWER_SUPPLY_HEALTH_COOL;
+			break;
+		case BQ2515X_COLD_FLAG:
+			health = POWER_SUPPLY_HEALTH_COLD;
+			break;
+		default:
+			health = POWER_SUPPLY_HEALTH_UNKNOWN;
+		}
+	} else if (v & BQ2515X_OVERVOLT_MASK) {
+		health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+	} else {
+		health = POWER_SUPPLY_HEALTH_GOOD;
+	}
+
+	ret = regmap_read(bq2515x->regmap, BQ2515X_FLAG3, &v);
+	if (v & BQ2515X_SAFETY_TIMER_EXP)
+		health = POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
+
+	val->intval = health;
+
+	return 0;
+}
+
+static int bq2515x_set_charge_enable(struct bq2515x_device *bq2515x, int val)
+{
+	if (bq2515x->ce_gpio)
+		gpiod_set_value(bq2515x->ce_gpio, val);
+
+	return 0;
+}
+
+static int bq2515x_get_charge_enable(struct bq2515x_device *bq2515x)
+{
+	int charge_value;
+
+	if (bq2515x->ce_gpio)
+		charge_value = gpiod_get_value(bq2515x->ce_gpio);
+	else
+		return -EINVAL;
+
+	return charge_value;
+}
+
+static int bq2515x_mains_set_property(struct power_supply *psy,
+		enum power_supply_property prop,
+		const union power_supply_propval *val)
+{
+	struct bq2515x_device *bq2515x = power_supply_get_drvdata(psy);
+	int ret;
+
+	switch (prop) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = bq2515x_set_ilim_lvl(bq2515x, val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		ret = bq2515x_set_batt_reg(bq2515x, val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+		ret = bq2515x_set_charge_enable(bq2515x, val->intval);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int bq2515x_mains_get_property(struct power_supply *psy,
+				     enum power_supply_property prop,
+				     union power_supply_propval *val)
+{
+	struct bq2515x_device *bq2515x = power_supply_get_drvdata(psy);
+	int ret;
+
+	switch (prop) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = bq2515x->mains_online;
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		ret = get_const_charge_current(bq2515x);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = bq2515x_get_ilim_lvl(bq2515x);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		ret = bq2515x_get_batt_reg(bq2515x);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = bq2515x->model_name;
+		ret = 0;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = BQ2515X_MANUFACTURER;
+		ret = 0;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		val->intval = BQ2515X_VBAT_REG_MAX;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		val->intval = BQ2515X_VBAT_REG_MIN;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+		ret = bq2515x_get_charge_enable(bq2515x);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int bq2515x_battery_get_property(struct power_supply *psy,
+				       enum power_supply_property prop,
+				       union power_supply_propval *val)
+{
+	struct bq2515x_device *bq2515x = power_supply_get_drvdata(psy);
+	int ret;
+
+	ret = bq2515x_update_ps_status(bq2515x);
+	if (ret < 0)
+		return ret;
+
+	switch (prop) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (!bq2515x_is_ps_online(bq2515x)) {
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+			break;
+		}
+
+		ret = bq2515x_charging_status(bq2515x, val);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = get_const_charge_voltage(bq2515x);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+		val->intval = bq2515x->voltage_min_design;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+		val->intval = bq2515x->voltage_max_design;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		val->intval = bq2515x->charge_full_design;
+		break;
+	case POWER_SUPPLY_PROP_HEALTH:
+		ret = bq2515x_charger_get_health(bq2515x, val);
+		if (ret)
+			val->intval = POWER_SUPPLY_HEALTH_UNKNOWN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static enum power_supply_property bq2515x_battery_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+};
+
+static enum power_supply_property bq2515x_charger_properties[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+static struct power_supply_desc bq2515x_mains_desc = {
+	.name			= "bq2515x-mains",
+	.type			= POWER_SUPPLY_TYPE_MAINS,
+	.get_property		= bq2515x_mains_get_property,
+	.set_property		= bq2515x_mains_set_property,
+	.properties		= bq2515x_charger_properties,
+	.num_properties		= ARRAY_SIZE(bq2515x_charger_properties),
+	.property_is_writeable = bq2515x_power_supply_property_is_writeable,
+
+};
+
+static struct power_supply_desc bq2515x_battery_desc = {
+	.name			= "bq2515x-battery",
+	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.get_property		= bq2515x_battery_get_property,
+	.properties		= bq2515x_battery_properties,
+	.num_properties		= ARRAY_SIZE(bq2515x_battery_properties),
+};
+
+
+static int bq2515x_power_supply_register(struct bq2515x_device *bq2515x)
+{
+	struct power_supply_config psy_cfg = { .drv_data = bq2515x, };
+
+	bq2515x->mains = devm_power_supply_register(bq2515x->dev,
+						    &bq2515x_mains_desc,
+						    &psy_cfg);
+	if (IS_ERR(bq2515x->mains))
+		return -EINVAL;
+
+	bq2515x->battery = devm_power_supply_register(bq2515x->dev,
+						      &bq2515x_battery_desc,
+						      &psy_cfg);
+	if (IS_ERR(bq2515x->battery))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int bq2515x_hw_init(struct bq2515x_device *bq2515x)
+{
+	int ret = 0;
+
+	if (bq2515x->init_data.ichg)
+		ret = bq2515x_set_ilim_lvl(bq2515x, bq2515x->init_data.ichg);
+
+	if (ret)
+		goto err_out;
+
+	if (bq2515x->init_data.vreg)
+		ret = bq2515x_set_batt_reg(bq2515x, bq2515x->init_data.vreg);
+
+err_out:
+	return ret;
+}
+
+static int bq2515x_read_properties(struct bq2515x_device *bq2515x)
+{
+	int ret;
+
+	ret = device_property_read_u32(bq2515x->dev,
+				      "constant-charge-current-max-microamp",
+				      &bq2515x->init_data.ichg);
+	if (ret)
+		bq2515x->init_data.ichg = bq2515x_ilim_lvl_values[1];
+
+	ret = device_property_read_u32(bq2515x->dev,
+				      "constant-charge-voltage-max-microvolt",
+				      &bq2515x->init_data.vreg);
+	if (ret)
+		bq2515x->init_data.vreg = 4200000;
+
+
+	bq2515x->pg_gpio = devm_gpiod_get_optional(bq2515x->dev,
+						   "pg", GPIOD_IN);
+	if (IS_ERR(bq2515x->pg_gpio))
+		dev_info(bq2515x->dev, "PG GPIO not defined");
+
+	bq2515x->reset_gpio = devm_gpiod_get_optional(bq2515x->dev,
+						   "reset", GPIOD_OUT_LOW);
+
+	if (PTR_ERR(bq2515x->reset_gpio) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	bq2515x->lp_gpio = devm_gpiod_get_optional(bq2515x->dev, "low-power",
+						   GPIOD_OUT_LOW);
+	if (PTR_ERR(bq2515x->lp_gpio) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	bq2515x->ce_gpio = devm_gpiod_get_optional(bq2515x->dev,
+						   "charge-enable",
+						   GPIOD_OUT_HIGH);
+	if (PTR_ERR(bq2515x->ce_gpio) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	return ret;
+}
+
+static const struct regmap_config bq2515x_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = BQ2515X_DEVICE_ID,
+	.reg_defaults     = bq2515x_reg_defs,
+	.num_reg_defaults = ARRAY_SIZE(bq2515x_reg_defs),
+	.cache_type	  = REGCACHE_RBTREE,
+};
+
+static int bq2515x_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct bq2515x_device *bq;
+	int ret;
+
+	bq = devm_kzalloc(dev, sizeof(*bq), GFP_KERNEL);
+	if (!bq)
+		return -ENOMEM;
+
+	bq->client = client;
+	bq->dev = dev;
+
+	mutex_init(&bq->lock);
+
+	bq->regmap = devm_regmap_init_i2c(client, &bq2515x_regmap_config);
+	if (IS_ERR(bq->regmap)) {
+		dev_err(dev, "failed to allocate register map\n");
+		return PTR_ERR(bq->regmap);
+	}
+
+	strncpy(bq->model_name, id->name, I2C_NAME_SIZE);
+
+	i2c_set_clientdata(client, bq);
+
+	ret = bq2515x_read_properties(bq);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register power supply %d\n", ret);
+		return ret;
+	}
+
+	ret = bq2515x_hw_init(bq);
+	if (ret < 0) {
+		dev_err(dev, "Cannot initialize the chip.\n");
+		return ret;
+	}
+
+	return bq2515x_power_supply_register(bq);
+}
+
+static const struct i2c_device_id bq2515x_i2c_ids[] = {
+	{ "bq25150", 0 },
+	{ "bq25155", 1 },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, bq2515x_i2c_ids);
+
+static const struct of_device_id bq2515x_of_match[] = {
+	{ .compatible = "ti,bq25150", },
+	{ .compatible = "ti,bq25155", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, bq2515x_of_match);
+
+static struct i2c_driver bq2515x_driver = {
+	.driver = {
+		.name = "bq2515x-charger",
+		.of_match_table = bq2515x_of_match,
+	},
+	.probe = bq2515x_probe,
+	.id_table = bq2515x_i2c_ids,
+};
+module_i2c_driver(bq2515x_driver);
+
+MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
+MODULE_DESCRIPTION("BQ2515X charger driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.0

