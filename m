Return-Path: <linux-pm+bounces-10323-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8774923911
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 11:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D938284679
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 09:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9941527A1;
	Tue,  2 Jul 2024 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXioJj76"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6506414E2C1;
	Tue,  2 Jul 2024 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719911001; cv=none; b=c18/Ve1N81ArD1jqEphoNbV63oqk5Wj0WbzLMtMl/svsLNr6yz521+FfvbIEwH1jnJO4EPGR8XYU8iAGAnhfCWPbGaEiNf7O2lzpu+4xZ7ME3yJUDCkbwO6k1Sn0MlZVnLRn0sUra2T6xL/lYJrxc1ExFIP+OYRTzVSRpNUeUIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719911001; c=relaxed/simple;
	bh=rk0aGNEuBuXrBdl2BlJbkPWRE8IT2whii//Y+UwJbu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pcTDxvZvuvdCUgztuDazE3GSvNUwBoXPomnB66CLGewZjs9zUPCH2G07rcc+4OhWJe4HFEmheI2wIpKjIrVl4avtDrG2Nd2hYehV3j3F7I375PLFAk+PWTKsshBCfK1hhfqrspb+l2GgwvYMrE771N8stdSCh30hLycAcpmkbh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXioJj76; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3658197cdbbso2195459f8f.3;
        Tue, 02 Jul 2024 02:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719910998; x=1720515798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA3wSsAG2fuToP8fTeamMMSNOeXnOQXPB/W2tGcmdFw=;
        b=NXioJj76Vj9MCRGVyHnoLQmKCfXbpU+9ZLrxw+KfYqfqZwqv8c42UiXeWZnKBRYuAr
         0HQ8L0JNYTe2x3GlLOdjPfAyvMy72Tgq1UWPyOg0Q5z642e+Pbjl2TLr4WP4S/2uVyVy
         Vo+N1QEwO22BP1QB3Vt4XXK+6zzXN1v6c8tXUlM8OXMwRxzfZqcOKTNDbVqkcJoZPy0P
         8DGlT53g6Br5bUMOm+olypgfcG1UgGoPSFuh1114WnSJLOem+fVD8CzPg/2jdAOITbVG
         /76cDVavyQ2VHuNLHwbZCvlyGah4/RpyvnRkC/RTRSoS3Gx3sD+HpGKEAUD9yk2DsiTk
         cyOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719910998; x=1720515798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iA3wSsAG2fuToP8fTeamMMSNOeXnOQXPB/W2tGcmdFw=;
        b=msehzTAe5VOoOhz1xMh5sjy2vFQ6KNpv+mcuyNI3S8dLRV/AS3gUv9GIQ2dSrIZOK8
         eznjIwyGZZfsHxd7IQyhhg1wAKYbA+jOSwmE8mzUXfDwSXaW4Udnu1Vi8AES+DGpC0yU
         NoHCtUlq+r8hvHqzWhe/nRlQ3ST0gxMfco35ompca/Fppi8lSAYKXIvYduv9+UudMEeF
         c2s4LNNXIRiiT/jFNJZTVsthJkAnOawHMMIDsKudvJ6NCjFYV2CK9C3b8y4QcKDn98ol
         iZ9Y0NEGouOqKaBCrKnXWhVYc+iHLlLB0yRakJntP+qnvFGJsR4gryd6ZyktlCl5VdlU
         lA7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlaJ52EQTw3blrY2oIx/SDjDDvjege9P6G4IbxgUBoLBdlfs9Hna8vgulMqz8xX/K8xfkjHCyLX/Cr2DPK1ZMYfPW40v5ezfJmnDp35UCT319P7AVeXmUw0xeNiaXqzUaIEMdcug+XQA13GLrrtCJJKVGH1+QPFkERPefqNE6oVkBu
X-Gm-Message-State: AOJu0YwdNGC9qaquvZ5CV7f/0hsvmseRju6u6/+v7cumgcnaYCohlWjx
	2f/qLWzFGHVWhGfnIsWCe+FY2/hNrbuhNQZKLk11FoJ/++QDdZ5y
X-Google-Smtp-Source: AGHT+IEh11e3F2mwUQ6ETikd9wtUmwX5pgrmvBA+PKsV5NaPD0ZdYalvd7spti2sR55WcxBoZtEHcg==
X-Received: by 2002:a5d:4526:0:b0:367:277e:bd64 with SMTP id ffacd0b85a97d-3677573964bmr5036109f8f.71.1719910997374;
        Tue, 02 Jul 2024 02:03:17 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e1688sm12616624f8f.60.2024.07.02.02.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:03:17 -0700 (PDT)
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
Subject: [PATCH v6 2/2] power: supply: add support for MAX1720x standalone fuel gauge
Date: Tue,  2 Jul 2024 11:03:08 +0200
Message-Id: <20240702090308.8848-3-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240702090308.8848-1-dima.fedrau@gmail.com>
References: <20240702090308.8848-1-dima.fedrau@gmail.com>
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

Reviewed-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/power/supply/Kconfig            |  12 +
 drivers/power/supply/Makefile           |   1 +
 drivers/power/supply/max1720x_battery.c | 337 ++++++++++++++++++++++++
 3 files changed, 350 insertions(+)
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
index 000000000000..edc262f0a62f
--- /dev/null
+++ b/drivers/power/supply/max1720x_battery.c
@@ -0,0 +1,337 @@
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
+#define MAX1720X_NRSENSE		0xCF	/* RSense in 10^-5 Ohm */
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
+	.max_register = MAX172XX_ATAVCAP,
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
+	ret = i2c_smbus_read_word_data(ancillary, MAX1720X_NRSENSE);
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
+	psy_cfg.fwnode = dev_fwnode(dev);
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


