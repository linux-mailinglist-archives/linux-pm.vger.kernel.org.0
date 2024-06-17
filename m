Return-Path: <linux-pm+bounces-9382-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E696090BA02
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 20:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B15A1C22B00
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 18:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43061990A1;
	Mon, 17 Jun 2024 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzyod0SR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89794198826;
	Mon, 17 Jun 2024 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718649962; cv=none; b=lva47UtKOw/UTvs0w41QC0SP88uR5/qwkVwOLfpdgOn8hf1WlmHFpFp0coXI+DXxACSv5PIDBBoNZYSoOuH6ta+cX2QzSsmalHMl56J7WlgGHcsdxiFsVWKNgrRUMbGlp3+cXm6n0wfqn+13T0aptUi7IEdRGESnBt+lgZEn2HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718649962; c=relaxed/simple;
	bh=WGbF91kl7JAr0HiUmt2dwh5lFk3koIxWmYauYkyvDcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LaL/4IdO4IniKDYXDY9YhAiO8ljJMqHN/KuD3WHxNnp64ufY8mrEwUkmQTie4s3ekNQY3YPuYIdfhrpW1G/qZXM+2mlwGOKz7H5tQGWIRsJ9w4V09+OjrpMKPVYhyhI79HIYuGe2v7HMUQvKBhfStPumqIRtSXpWHRWUHHKFFKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzyod0SR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35f2c9e23d3so3783443f8f.0;
        Mon, 17 Jun 2024 11:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718649959; x=1719254759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRf6vjAglp1xhamBOyz4NxQ2EaCuNYCLhPu1bSuxxos=;
        b=jzyod0SRBaTzaaDGozkXezeXMT++8jzJS7LtEHvClMZbIOQyry/gqz2gNyJ/HBfdZT
         u0dMYHTtKmBqyZT8zDcDLV7SjeZry39fSyDSjBzU7D7/xNodIZEtOXpaxumg02WvrUrK
         7Va1ad4Eun3FrdajwqSZsy7clrfZ/soESbeyDb4IAdqlx3wKcuECdDN6LVwi5O73blTG
         uxHQowLjBAmHNlAVumy0Ws9X+PCi6ytLRQ0vZzXgAk/EBNR6QPobCdgMiE+V1VOiqhPc
         ogk6dIlOqVaeu8Mw4s9SH6fWdswJViKd6hNGCMHnP5wVW3TU05di1cQ15/m55FgQYDgF
         s6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718649959; x=1719254759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRf6vjAglp1xhamBOyz4NxQ2EaCuNYCLhPu1bSuxxos=;
        b=YZKXbKduwTi2/X/FtzPdjQCrc5t4GdKQu5+yjY3V9Khxd4Hdn43BxRLYY/E1I56+82
         zxLRWJKMmKwpl3xUlj+RfvOWNEJm5+JxODF8ZUaYewjzh3MdUdFQFQ5uz+oeZMGum2qV
         rohFK96Gq6t7kSTzI3dNHgWvx75gASRv+gduQFdOcOcQHVbyrcp2sT6AKuStZ7YNvbt2
         IeYHFKQU7yUcKFAKVw4FFJWe/ATGxYS/8WmlOp/R9OGWSPHlqcyxiu6wcByCnzd38d5S
         GXsWBIgr9LHNohPIz6mXJFeAabkyhP6PmJgXv7v7yDL3Fxgf9ZyGEFfCegvUDFP2TFQR
         5k5g==
X-Forwarded-Encrypted: i=1; AJvYcCV/olk9Gmxbxui8VEK5YE25tL9gYeBkOUH2xPsu4lCeBb+7rrN1xWhE4dSVWbZNS9S4NaHc9qpdVCFZF+i0bHNoi9wUQreYmwvJsPiwje5cQ2Wa7658KUMQzpUoUFbnOd6mCk781NHcD/5Y/Ki4dNJ55Bj0T3Wleev1JMc+jh8xK7UZ
X-Gm-Message-State: AOJu0YzOf64UPZS5KapoviG5KB0yOQE69EOAbiHNB/48kjMULChUcDvh
	iyrFfv2vnks51OdIp29tvsVVKirLWVJ18AlmcHtpZEVRrixHW7uh
X-Google-Smtp-Source: AGHT+IGu949+P7qx4T+3zdjfOamelxJswLH+HTJ0Odtdt4CD8uIS5osibFYTmkuxDe/TLiVPr6PV7Q==
X-Received: by 2002:a5d:494d:0:b0:35f:2e52:b514 with SMTP id ffacd0b85a97d-3609ea9fcc3mr409627f8f.22.1718649958806;
        Mon, 17 Jun 2024 11:45:58 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f249csm12410327f8f.75.2024.06.17.11.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:45:58 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: [PATCH v4 2/2] power: supply: add support for MAX1720x standalone fuel gauge
Date: Mon, 17 Jun 2024 20:45:04 +0200
Message-Id: <20240617184504.304211-3-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240617184504.304211-1-dima.fedrau@gmail.com>
References: <20240617184504.304211-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX17201 monitors a single cell pack. The MAX17205 monitors and
balances a 2S or 3S pack or monitors a multiple-series cell pack. Both
devices use a I2C interface.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/power/supply/Kconfig            |  12 +
 drivers/power/supply/Makefile           |   1 +
 drivers/power/supply/max1720x_battery.c | 363 ++++++++++++++++++++++++
 3 files changed, 376 insertions(+)
 create mode 100644 drivers/power/supply/max1720x_battery.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 3e31375491d5..9294520b64a3 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -402,6 +402,18 @@ config BATTERY_MAX17042
 
 	  Driver can be build as a module (max17042_battery).
 
+config BATTERY_MAX1720X
+	tristate "Maxim MAX17201/MAX17205 Fuel Gauge"
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
index 000000000000..cd0a35fb4fef
--- /dev/null
+++ b/drivers/power/supply/max1720x_battery.c
@@ -0,0 +1,363 @@
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
+#include <asm/unaligned.h>
+
+/* Nonvolatile registers */
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
+#define MAX172XX_CYCLES			0x17
+#define MAX172XX_DESIGN_CAP		0x18	/* Design capacity */
+#define MAX172XX_AVG_VCELL		0x19
+#define MAX172XX_TTF			0x20	/* Time to full */
+#define MAX172XX_DEV_NAME		0x21	/* Device name */
+#define MAX172XX_DEV_NAME_TYPE_MASK	GENMASK(3, 0)
+#define MAX172XX_DEV_NAME_TYPE_MAX17201	BIT(0)
+#define MAX172XX_DEV_NAME_TYPE_MAX17205	(BIT(0) | BIT(2))
+#define MAX172XX_QR_TABLE10		0x22
+#define MAX172XX_BATT			0xDA	/* Battery voltage */
+#define MAX172XX_ATAVCAP		0xDF
+
+static const char *const max1720x_manufacturer = "Maxim Integrated";
+static const char *const max17201_model = "MAX17201";
+static const char *const max17205_model = "MAX17205";
+
+struct max1720x_device_info {
+	struct regmap *regmap;
+	int rsense;
+};
+
+/*
+ * Model Gauge M5 Algorithm output register
+ * Volatile data (must not be cached)
+ */
+static const struct regmap_range max1720x_volatile_allow[] = {
+	regmap_reg_range(MAX172XX_STATUS, MAX172XX_CYCLES),
+	regmap_reg_range(MAX172XX_AVG_VCELL, MAX172XX_TTF),
+	regmap_reg_range(MAX172XX_QR_TABLE10, MAX172XX_ATAVCAP),
+};
+
+static const struct regmap_range max1720x_readable_allow[] = {
+	regmap_reg_range(MAX172XX_STATUS, MAX172XX_ATAVCAP),
+};
+
+static const struct regmap_range max1720x_readable_deny[] = {
+	/* unused registers */
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
+static const struct regmap_access_table max1720x_readable_regs = {
+	.yes_ranges	= max1720x_readable_allow,
+	.n_yes_ranges	= ARRAY_SIZE(max1720x_readable_allow),
+	.no_ranges	= max1720x_readable_deny,
+	.n_no_ranges	= ARRAY_SIZE(max1720x_readable_deny),
+};
+
+static const struct regmap_access_table max1720x_volatile_regs = {
+	.yes_ranges	= max1720x_volatile_allow,
+	.n_yes_ranges	= ARRAY_SIZE(max1720x_volatile_allow),
+	.no_ranges	= max1720x_readable_deny,
+	.n_no_ranges	= ARRAY_SIZE(max1720x_readable_deny),
+};
+
+static const struct regmap_config max1720x_regmap_cfg = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.rd_table = &max1720x_readable_regs,
+	.volatile_table = &max1720x_volatile_regs,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static const enum power_supply_property max1720x_battery_props[] = {
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
+	int val = (int16_t)reg;
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
+	int val = (int16_t)reg;
+
+	return val * 156252;
+}
+
+static int max1720x_battery_get_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val)
+{
+	struct max1720x_device_info *info = power_supply_get_drvdata(psy);
+	unsigned int reg_val;
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
+		if (ret < 0) {
+			val->intval = 0;
+			return 0;
+		}
+
+		val->intval = !FIELD_GET(MAX172XX_STATUS_BAT_ABSENT, reg_val);
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
+static int max1720x_read_word_data_nvmem(struct i2c_client *ancillary, u8 addr)
+{
+	u8 rx[2];
+	struct i2c_msg msgs[] = {
+		{
+			.addr = ancillary->addr,
+			.flags = 0,
+			.len = 1,
+			.buf = &addr,
+		},
+		{
+			.addr = ancillary->addr,
+			.flags = I2C_M_RD,
+			.len = 2,
+			.buf = &rx[0],
+		},
+	};
+	int ret;
+
+	ret = i2c_transfer(ancillary->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret != ARRAY_SIZE(msgs))
+		return ret < 0 ? ret : -EIO;
+
+	return get_unaligned_le16(&rx[0]);
+}
+
+static int max1720x_probe_sense_resistor(struct i2c_client *client,
+					 struct max1720x_device_info *info)
+{
+	struct device *dev = &client->dev;
+	struct i2c_client *ancillary;
+	int ret;
+
+	ancillary = i2c_new_ancillary_device(client, "nvmem", 0xb);
+	if (IS_ERR(ancillary)) {
+		dev_err(dev, "Failed to initialize ancillary i2c device\n");
+		return PTR_ERR(ancillary);
+	}
+
+	ret = max1720x_read_word_data_nvmem(ancillary, MAX1720_NRSENSE);
+	i2c_unregister_device(ancillary);
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
+static const struct power_supply_desc max1720x_bat_desc = {
+	.name = "max1720x",
+	.no_thermal = true,
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = max1720x_battery_props,
+	.num_properties = ARRAY_SIZE(max1720x_battery_props),
+	.get_property = max1720x_battery_get_property,
+};
+
+static int max1720x_probe(struct i2c_client *client)
+{
+	struct power_supply_config psy_cfg = {};
+	struct device *dev = &client->dev;
+	struct max1720x_device_info *info;
+	struct power_supply *bat;
+	int ret;
+
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	psy_cfg.drv_data = info;
+
+	info->regmap = devm_regmap_init_i2c(client, &max1720x_regmap_cfg);
+	if (IS_ERR(info->regmap))
+		return dev_err_probe(dev, PTR_ERR(info->regmap),
+				     "regmap initialization failed\n");
+
+	ret = max1720x_probe_sense_resistor(client, info);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to read sense resistor value\n");
+
+	bat = devm_power_supply_register(dev, &max1720x_bat_desc, &psy_cfg);
+	if (IS_ERR(bat))
+		return dev_err_probe(dev, PTR_ERR(bat),
+				     "Failed to register power supply\n");
+
+	return 0;
+}
+
+static const struct of_device_id max1720x_of_match[] = {
+	{ .compatible = "maxim,max17201" },
+	{ .compatible = "maxim,max17205" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, max1720x_of_match);
+
+static struct i2c_driver max1720x_i2c_driver = {
+	.driver = {
+		.name = "max1720x",
+		.of_match_table = max1720x_of_match,
+	},
+	.probe = max1720x_probe,
+};
+module_i2c_driver(max1720x_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Dimitri Fedrau <dima.fedrau@gmail.com>");
+MODULE_DESCRIPTION("Maxim MAX17201/MAX17205 Fuel Gauge IC driver");
-- 
2.39.2


