Return-Path: <linux-pm+bounces-9235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D26CA9099CF
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 22:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79CFE283071
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 20:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB9969D31;
	Sat, 15 Jun 2024 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVsveQ8S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C1261FEE;
	Sat, 15 Jun 2024 20:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718482196; cv=none; b=Nk/oW5VoiBs/llbYfYyocFFn0YdoyBADX2XzJHsHPyZY1cnnrOyryQyUszLcWelL33t5qhzvmQF0/Qkaj0PgqY30D3uuw2MacAfTV3jfu2h1eTaVpeToI9jyzy4OuDcx5dfuQV2fbLLyqcMAjQE6y8oZKis7q/zqaHEQ0Xd9fNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718482196; c=relaxed/simple;
	bh=wFI2RWuGFjy8FUotbYTIBsa35aZrC16/N/mVJgXW9J8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nC4zovxEsZh25dwhfFSYefMgZaBS8HcWI00a83m6+vXGwNq0vLtjpe2jEcU6+XU59ykv8VJjXFUQdmkEkCD6n2tM0RelZLH+5Z7gRnZZUBHrbrAsczY68q8qsQgbMix52VGwfovnxH18fOpIO5nG1wyb2gYrVadvm0xR9yFrEJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVsveQ8S; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4217990f8baso29674915e9.2;
        Sat, 15 Jun 2024 13:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718482192; x=1719086992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2gLMNE0xnXqZ/2ivpjlAsBxILyK5J+/etfKmbTg2SY=;
        b=bVsveQ8SJMEihJBycxYxu7qLMyUUMzpbWXgYCIc9OXGTQG4D6dtwgXKYlHhrLbf+nZ
         R24HwfuS9aEfAWEhmQR1tK1iAlzbprZZhoqnN/4ZA0Fajht3r5SBk2ejBMZhI92h++YU
         jCF+ApRIe5mNRYtvyzYJtLsWjauWg5+uWTrHSW7BwZ5p0ev/H3gcdwEiMTZmlsw+Gv7I
         zSPipxtJLF1R5DyIcgR6eEmJc3QofaQd7cg6/JVsLG+7nLQ/oOmY7ATyd+RywqnIMhG2
         cWKSQGC51WQ4rgAaUwk/ZNpwusCJuQJrhkXa81c3/COyoI8J1yeEWdhUN+wJHw8yPBX+
         TSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718482192; x=1719086992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2gLMNE0xnXqZ/2ivpjlAsBxILyK5J+/etfKmbTg2SY=;
        b=DDxZTnLMoqcutz8DRfSvn5KT1Ifjq+Ga0vLRKSctIfosg1QQwpANpYMtUT5ukBEzHH
         BP2cbsechkzO/SXnkttGSWWats0CVq3y095/3Q/pRC9bfb858FiMKS58mNvjgy9qlkJu
         XJhlhllexI96qQ1iM6H6cVkwpUcdzVO7wpefrX7fKHKE9eFx6FoTWop2DF9d8Xmi8tJJ
         qc1m1nIbVypoXGXXt2zFgO31ZEXb2184NGe6UTlilvRktxpcAaj++3FADHf4zvP32fIa
         ObTnvkq8R2JJkFc7VQIEFejFZQlWgEfNfvVpyIHGW9njtV4BqGjKESdGwj0IaoYCQNKW
         u6ug==
X-Forwarded-Encrypted: i=1; AJvYcCVWpjPXFUFuL7XqZCnkFlzHIvjtvAfIHRMn/55A4+/ocsRNXwWnMt+W2Sp9hvRgMwLy8Ime9o0CA1TNGS5hcE60yAdJfXo8fLH+5b4UCqiOeU+Rn6yJyENeUt0N+WM0nFc0ASlyEhQ=
X-Gm-Message-State: AOJu0YzxI0VdvknVRUML1u0UDWFCf9NNzSPYZqGm6pGg0hESjYqsn/7T
	VS0PQ5Zn/dqPN2a+FAYq3eNsy/2CrSJ2j/fPpIvzxnCAo6+bodhk
X-Google-Smtp-Source: AGHT+IHbhs4HaxypYqQxTYyEWtg5LQarh8kchuBH2Hs9wl5anXVPEMXTuo/OYTmJNdTWVeE7kfhMJQ==
X-Received: by 2002:a05:600c:4eca:b0:421:ad42:c4c2 with SMTP id 5b1f17b1804b1-42304826469mr55620145e9.10.1718482192384;
        Sat, 15 Jun 2024 13:09:52 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a666sm108510915e9.45.2024.06.15.13.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 13:09:51 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/2] power: supply: add support for MAX1720x standalone fuel gauge
Date: Sat, 15 Jun 2024 22:09:32 +0200
Message-Id: <20240615200933.162394-3-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240615200933.162394-1-dima.fedrau@gmail.com>
References: <20240615200933.162394-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

The MAX17201 monitor a single cell pack. The MAX17205 monitor and balance
a 2S or 3S pack or monitor a multiple-series cell pack. Both device use
I2C interface.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/power/supply/Kconfig            |  12 +
 drivers/power/supply/Makefile           |   1 +
 drivers/power/supply/max1720x_battery.c | 324 ++++++++++++++++++++++++
 3 files changed, 337 insertions(+)
 create mode 100644 drivers/power/supply/max1720x_battery.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 3e31375491d5..e620ae1a9c8b 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -402,6 +402,18 @@ config BATTERY_MAX17042
 
 	  Driver can be build as a module (max17042_battery).
 
+config BATTERY_MAX1720X
+tristate "Maxim MAX17201/MAX17205 Fuel Gauge"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  MAX1720x is a family of fuel-gauge systems for lithium-ion (Li+)
+	  batteries in handheld and portable equipment. MAX17201 are
+	  configured to operate with a single lithium cell, the MAX17205
+	  can operate with multiple cells.
+
+	  Say Y to include support for the MAX17201/MAX17205 Fuel Gauges.
+
 config BATTERY_MAX1721X
 	tristate "MAX17211/MAX17215 standalone gas-gauge"
 	depends on W1
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 58b567278034..6f02d0248826 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_CHARGER_DA9150)	+= da9150-charger.o
 obj-$(CONFIG_BATTERY_DA9150)	+= da9150-fg.o
 obj-$(CONFIG_BATTERY_MAX17040)	+= max17040_battery.o
 obj-$(CONFIG_BATTERY_MAX17042)	+= max17042_battery.o
+obj-$(CONFIG_BATTERY_MAX1720X)	+= max1720x_battery.o
 obj-$(CONFIG_BATTERY_MAX1721X)	+= max1721x_battery.o
 obj-$(CONFIG_BATTERY_RT5033)	+= rt5033_battery.o
 obj-$(CONFIG_CHARGER_RT5033)	+= rt5033_charger.o
diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
new file mode 100644
index 000000000000..68d317d01c9d
--- /dev/null
+++ b/drivers/power/supply/max1720x_battery.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Fuel gauge driver for Maxim 17201/17205
+ *
+ * based on max1721x_battery.c
+ *
+ * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
+ */
+
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+
+/* Nonvilatile registers */
+#define MAX1720_NRSENSE			0xCF	/* RSense in 10^-5 Ohm */
+
+/* ModelGauge m5 */
+#define MAX172XX_STATUS			0x00	/* Status */
+#define MAX172XX_STATUS_BAT_ABSENT	BIT(3)	/* Battery absent */
+#define MAX172XX_REPCAP			0x05	/* Average capacity */
+#define MAX172XX_REPSOC			0x06	/* Percentage of charge */
+#define MAX172XX_TEMP			0x08	/* Temperature */
+#define MAX172XX_CURRENT		0x0A	/* Actual current */
+#define MAX172XX_AVG_CURRENT		0x0B	/* Average current */
+#define MAX172XX_TTE			0x11	/* Time to empty */
+#define MAX172XX_AVG_TA			0x16	/* Average temperature */
+#define MAX172XX_DESIGN_CAP		0x18	/* Design capacity */
+#define MAX172XX_TTF			0x20	/* Time to full */
+#define MAX172XX_DEV_NAME		0x21	/* Device name */
+#define MAX172XX_DEV_NAME_TYPE_MASK	GENMASK(3, 0)
+#define MAX172XX_DEV_NAME_TYPE_MAX17201	BIT(0)
+#define MAX172XX_DEV_NAME_TYPE_MAX17205	(BIT(0) | BIT(2))
+#define MAX172XX_BATT			0xDA	/* Battery voltage */
+#define MAX172XX_ATAVCAP		0xDF
+
+static const char *max1720x_manufacturer = "Maxim Integrated";
+static const char *max17201_model = "MAX17201";
+static const char *max17205_model = "MAX17205";
+
+struct max1720x_device_info {
+	struct power_supply *bat;
+	struct power_supply_desc bat_desc;
+	struct i2c_client *ancillary;
+	struct regmap *regmap;
+	int rsense;
+};
+
+/*
+ * Model Gauge M5 Algorithm output register
+ * Volatile data (must not be cached)
+ */
+static const struct regmap_range max1720x_volatile_allow[] = {
+	regmap_reg_range(MAX172XX_STATUS, MAX172XX_ATAVCAP),	/* volatile data */
+};
+
+static const struct regmap_range max1720x_volatile_deny[] = {
+	/* volatile data unused registers */
+	regmap_reg_range(0x24, 0x26),
+	regmap_reg_range(0x30, 0x31),
+	regmap_reg_range(0x33, 0x34),
+	regmap_reg_range(0x37, 0x37),
+	regmap_reg_range(0x3B, 0x3C),
+	regmap_reg_range(0x40, 0x41),
+	regmap_reg_range(0x43, 0x44),
+	regmap_reg_range(0x47, 0x49),
+	regmap_reg_range(0x4B, 0x4C),
+	regmap_reg_range(0x4E, 0xAF),
+	regmap_reg_range(0xB1, 0xB3),
+	regmap_reg_range(0xB5, 0xB7),
+	regmap_reg_range(0xBF, 0xD0),
+	regmap_reg_range(0xDB, 0xDB),
+	regmap_reg_range(0xE0, 0xFF),
+};
+
+static const struct regmap_access_table max1720x_volatile_regs = {
+	.yes_ranges	= max1720x_volatile_allow,
+	.n_yes_ranges	= ARRAY_SIZE(max1720x_volatile_allow),
+	.no_ranges	= max1720x_volatile_deny,
+	.n_no_ranges	= ARRAY_SIZE(max1720x_volatile_deny),
+};
+
+static const struct regmap_config max1720x_regmap_cfg = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.rd_table = &max1720x_volatile_regs,
+	.volatile_table = &max1720x_volatile_regs,
+};
+
+static enum power_supply_property max1720x_battery_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_AVG,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
+	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+/* Convert regs value to power_supply units */
+
+static int max172xx_time_to_ps(unsigned int reg)
+{
+	return reg * 5625 / 1000;	/* in sec. */
+}
+
+static int max172xx_percent_to_ps(unsigned int reg)
+{
+	return reg / 256;	/* in percent from 0 to 100 */
+}
+
+static int max172xx_voltage_to_ps(unsigned int reg)
+{
+	return reg * 1250;	/* in uV */
+}
+
+static int max172xx_capacity_to_ps(unsigned int reg)
+{
+	return reg * 500;	/* in uAh */
+}
+
+/*
+ * Current and temperature is signed values, so unsigned regs
+ * value must be converted to signed type
+ */
+
+static int max172xx_temperature_to_ps(unsigned int reg)
+{
+	int val = (int16_t)(reg);
+
+	return val * 10 / 256; /* in tenths of deg. C */
+}
+
+/*
+ * Calculating current registers resolution:
+ *
+ * RSense stored in 10^-5 Ohm, so mesaurment voltage must be
+ * in 10^-11 Volts for get current in uA.
+ * 16 bit current reg fullscale +/-51.2mV is 102400 uV.
+ * So: 102400 / 65535 * 10^5 = 156252
+ */
+static int max172xx_current_to_voltage(unsigned int reg)
+{
+	int val = (int16_t)(reg);
+
+	return val * 156252;
+}
+
+static int max1720x_battery_get_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val)
+{
+	struct max1720x_device_info *info = power_supply_get_drvdata(psy);
+	unsigned int reg_val = 0;
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		/*
+		 * POWER_SUPPLY_PROP_PRESENT will always readable via
+		 * sysfs interface. Value return 0 if battery not
+		 * present or unaccesable via I2c.
+		 */
+		ret = regmap_read(info->regmap, MAX172XX_STATUS, &reg_val);
+		if (ret < 0)
+			return ret;
+
+		val->intval = !(FIELD_GET(MAX172XX_STATUS_BAT_ABSENT, reg_val));
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		ret = regmap_read(info->regmap, MAX172XX_REPSOC, &reg_val);
+		val->intval = max172xx_percent_to_ps(reg_val);
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = regmap_read(info->regmap, MAX172XX_BATT, &reg_val);
+		val->intval = max172xx_voltage_to_ps(reg_val);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		ret = regmap_read(info->regmap, MAX172XX_DESIGN_CAP, &reg_val);
+		val->intval = max172xx_capacity_to_ps(reg_val);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_AVG:
+		ret = regmap_read(info->regmap, MAX172XX_REPCAP, &reg_val);
+		val->intval = max172xx_capacity_to_ps(reg_val);
+		break;
+	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
+		ret = regmap_read(info->regmap, MAX172XX_TTE, &reg_val);
+		val->intval = max172xx_time_to_ps(reg_val);
+		break;
+	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
+		ret = regmap_read(info->regmap, MAX172XX_TTF, &reg_val);
+		val->intval = max172xx_time_to_ps(reg_val);
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		ret = regmap_read(info->regmap, MAX172XX_TEMP, &reg_val);
+		val->intval = max172xx_temperature_to_ps(reg_val);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = regmap_read(info->regmap, MAX172XX_CURRENT, &reg_val);
+		val->intval = max172xx_current_to_voltage(reg_val) / info->rsense;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_AVG:
+		ret = regmap_read(info->regmap, MAX172XX_AVG_CURRENT, &reg_val);
+		val->intval = max172xx_current_to_voltage(reg_val) / info->rsense;
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		ret = regmap_read(info->regmap, MAX172XX_DEV_NAME, &reg_val);
+		reg_val = FIELD_GET(MAX172XX_DEV_NAME_TYPE_MASK, reg_val);
+		if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX17201)
+			val->strval = max17201_model;
+		else if (reg_val == MAX172XX_DEV_NAME_TYPE_MAX17205)
+			val->strval = max17205_model;
+		else
+			return -ENODEV;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = max1720x_manufacturer;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int max1720x_probe_sense_resistor(struct max1720x_device_info *info)
+{
+	struct device *dev = &info->ancillary->dev;
+	int ret;
+
+	ret = i2c_smbus_read_word_data(info->ancillary, MAX1720_NRSENSE);
+	if (ret < 0)
+		return ret;
+
+	info->rsense = ret;
+	if (!info->rsense) {
+		dev_warn(dev, "RSense not calibrated, set 10 mOhms!\n");
+		info->rsense = 1000; /* in regs in 10^-5 */
+	}
+
+	return 0;
+}
+
+static int max1720x_probe(struct i2c_client *client)
+{
+	struct power_supply_config psy_cfg = {};
+	struct device *dev = &client->dev;
+	struct max1720x_device_info *info;
+	int ret;
+
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, info);
+	info->bat_desc.name = "max1720x";
+	info->bat_desc.no_thermal = true;
+	info->bat_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	info->bat_desc.properties = max1720x_battery_props;
+	info->bat_desc.num_properties = ARRAY_SIZE(max1720x_battery_props);
+	info->bat_desc.get_property = max1720x_battery_get_property;
+	psy_cfg.drv_data = info;
+
+	info->regmap = devm_regmap_init_i2c(client, &max1720x_regmap_cfg);
+	if (IS_ERR(info->regmap))
+		return dev_err_probe(dev, PTR_ERR(info->regmap),
+				     "regmap initialization failed\n");
+
+	info->ancillary = i2c_new_ancillary_device(client, "nvmem", 0xb);
+	if (IS_ERR(info->ancillary))
+		return dev_err_probe(dev, PTR_ERR(info->ancillary),
+				     "Failed to initialize ancillary i2c device\n");
+
+	i2c_set_clientdata(info->ancillary, info);
+	ret = max1720x_probe_sense_resistor(info);
+	if (ret) {
+		i2c_unregister_device(info->ancillary);
+		return dev_err_probe(dev, PTR_ERR(info->bat),
+				     "Failed to read sense resistor value\n");
+	}
+
+	info->bat = devm_power_supply_register(dev, &info->bat_desc, &psy_cfg);
+	if (IS_ERR(info->bat)) {
+		i2c_unregister_device(info->ancillary);
+		return dev_err_probe(dev, PTR_ERR(info->bat),
+				     "Failed to register power supply\n");
+	}
+
+	return 0;
+}
+
+static void max1720x_remove(struct i2c_client *client)
+{
+	struct max1720x_device_info *info = i2c_get_clientdata(client);
+
+	i2c_unregister_device(info->ancillary);
+}
+
+static const struct of_device_id max1720x_of_match[] = {
+	{ .compatible = "maxim,max1720x" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, max1720x_of_match);
+
+static struct i2c_driver max1720x_i2c_driver = {
+	.driver = {
+		   .name = "max1720x",
+		   .of_match_table = max1720x_of_match,
+		   },
+	.probe = max1720x_probe,
+	.remove = max1720x_remove,
+};
+module_i2c_driver(max1720x_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Dimitri Fedrau <dima.fedrau@gmail.com>");
+MODULE_DESCRIPTION("Maxim MAX17201/MAX17205 Fuel Gauge IC driver");
-- 
2.39.2


