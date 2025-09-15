Return-Path: <linux-pm+bounces-34661-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F9AB575EE
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 12:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9400201037
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 10:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C6C2FC871;
	Mon, 15 Sep 2025 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlMJCfcX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177742FB62B;
	Mon, 15 Sep 2025 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931258; cv=none; b=Gfy05W2QX1B6x77q/Rq2HaDmfi639z40tpUapMCuFVEpBFJwVpGFFIYo0CoFhPSlNLESAY8QZijo40Ulzjo/SKD0Tp/yR8IfE72AIgKQ8IX/qWmMZa0E+RxggSOcEga/1ZSbzTbdyy+HTUh9CSBTXPxT914jW/1D6B+AS4sBgDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931258; c=relaxed/simple;
	bh=+kxPLkjNYH7LcbwGrQCikywiLqgj2v2qTfRxQc4pypM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hun6yTPrJVbGVvbb7P1auqNgqZSJbhauBAzBZ7bGH1I5ANw1908ndXDVY/JiLADTUZA6exucTerrT5eE0nCwlVbIi4fQttzt4Bhs/+voOkyXGsMua72zOBIz+CZfp1NwskE8bRlZhMBGuGcbjXHIgb3BlNfwHtByMYRNqBIh8k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlMJCfcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A35F1C4CEFB;
	Mon, 15 Sep 2025 10:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757931257;
	bh=+kxPLkjNYH7LcbwGrQCikywiLqgj2v2qTfRxQc4pypM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SlMJCfcXsWn2T8tpc1MuWMm6zn9fqqrlHPMvtdzQJxjDhAEoS8TAb3Oqway+W+ISO
	 dkMjPsx7YN1RkLkUJKipyLP9NcE/BxAMWx3Q9sdnXRl5E3RgRgVtfHhhHx62SM10A+
	 N6ZjKoQyq7qCEmfz4uOdaQau5J8mCFooytN+5dAvjoPCXqm5J0RmgpfV5Hmf05akb7
	 MK+0Fay7RKpfI+rsmJZRYbUtzHbi3dKg++HP7Bv3d7R0pxYC8Vgv51T+q8SKgkz6oT
	 dyo6gQ5OMaPEV8+dactWdIZ2KD+N3b5QzHRDsri17FMkPQTNHSwNwUz56MsiYHzbYi
	 9yBu5u39rabyg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A10CAC598;
	Mon, 15 Sep 2025 10:14:17 +0000 (UTC)
From: Thomas Antoine via B4 Relay <devnull+t.antoine.uclouvain.be@kernel.org>
Date: Mon, 15 Sep 2025 12:14:10 +0200
Subject: [PATCH v6 1/2] power: supply: add support for MAX77759 fuel gauge
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250915-b4-gs101_max77759_fg-v6-1-31d08581500f@uclouvain.be>
References: <20250915-b4-gs101_max77759_fg-v6-0-31d08581500f@uclouvain.be>
In-Reply-To: <20250915-b4-gs101_max77759_fg-v6-0-31d08581500f@uclouvain.be>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Thomas Antoine <t.antoine@uclouvain.be>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757931256; l=23283;
 i=t.antoine@uclouvain.be; s=20241202; h=from:subject:message-id;
 bh=4AT9YubuA0ZWN8UD2NQATjjanyg5oWJLsEvrUOFUoL8=;
 b=3I8dPo9KUu/mi083YuZmXDPJIE3PL6MQ1z4o5GiSszj5F1u32S8XFSBFQoITyc9zz6yA+I6Y2
 Wsf4UjJU7bcDeMeEtDJK+pw9/V40JJ5NY+0sgNmg0e1C9zLeY+hBpnJ
X-Developer-Key: i=t.antoine@uclouvain.be; a=ed25519;
 pk=sw7UYl31W1LTpgWRiX4xIF5x6ok7YWZ6XZnHqy/d3dY=
X-Endpoint-Received: by B4 Relay for t.antoine@uclouvain.be/20241202 with
 auth_id=289
X-Original-From: Thomas Antoine <t.antoine@uclouvain.be>
Reply-To: t.antoine@uclouvain.be

From: Thomas Antoine <t.antoine@uclouvain.be>

The Maxim MAX77759 is a PMIC used in gs101-oriole and gs101-raven
(Google Pixel 6 and 6 Pro). It contains a fuel gauge on a separate
I2C address. Add basic support for this fuel gauge. The driver is
based on the driver for the MAX17201 and MAX17205 which also uses
the MAX M5 fuel gauge. There is a lot in common between the two
devices with some key differences. The main one is the lack of nvmem
in the fuel gauge of the MAX77759.

The initialization of the chip is very basic and mostly hardcoded.
Loading the model of the fuel gauge is not implemented here.
Values are extracted from available devices.

On both gs101-oriole and gs101-raven, the same EEPROM as for the
battery id is used to backup some of the state of the fuel gauge.
Use a standard nvmem binding to access this data. The CRC8 is
computed to allow to go from linux to a stock android without
apparent data corruption. If other devices using the MAX77759 are
found/created, a similar nvmem layout should be made or the driver
should be extended to support those devices.

The current, capacity, temperature and charge have all been tested.
The charge full design and capacity equal the ones seen on android,
the ratio between average charge and average current does predict
pretty accurately the time to empty under a constant workload and
temperature is coherent with the dynamic state of the device.

Health is not enabled as it always reports overheating. The time to
empty is wrong by about a factor 2. The voltage reporting is
correct when using VCELL (which reports the lowest voltage of all
cells) when considering that the device is connected to a single
cell. It could be enabled by either confirming that the device is
connected to a single cell or finding an alternative reporting mean.

Modifications have been made to it since but the regmap was
originally proposed by André Draszik in

Link: https://lore.kernel.org/all/d1bade77b5281c1de6b2ddcb4dbbd033e455a116.camel@linaro.org/

Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/power/supply/Kconfig            |  14 +
 drivers/power/supply/Makefile           |   1 +
 drivers/power/supply/max77759_battery.c | 652 ++++++++++++++++++++++++++++++++
 3 files changed, 667 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 72f3b2b4d346df354475274b1c6b4ed047fdca1d..2d024fd3a45644d9f6d4e7c48ea98f4efe0c443d 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -473,6 +473,20 @@ config BATTERY_MAX1721X
 	  Say Y here to enable support for the MAX17211/MAX17215 standalone
 	  battery gas-gauge.
 
+config BATTERY_MAX77759
+	tristate "Maxim Integrated MAX77759 Fuel Gauge"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say yes to enable support for the Fuel gauge of the Maxim Integrated
+	  MAX77759. It is a companion Power Management IC for USB Type-C
+	  applications with Battery Charger, Fuel Gauge, temperature sensors,
+	  USB Type-C Port Controller (TCPC), NVMEM, and additional GPIO
+	  interfaces.
+
+	  To compile this driver as module, choose M here: the
+	  module will be called max77759_fg.
+
 config BATTERY_TWL4030_MADC
 	tristate "TWL4030 MADC battery driver"
 	depends on TWL4030_MADC
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 51e37e8bdeb35a5ee7a74cd86d4def9d900a542d..b96b5ce9c846c57ce71c23ede949d0e89c06a65a 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_BATTERY_MAX17040)	+= max17040_battery.o
 obj-$(CONFIG_BATTERY_MAX17042)	+= max17042_battery.o
 obj-$(CONFIG_BATTERY_MAX1720X)	+= max1720x_battery.o
 obj-$(CONFIG_BATTERY_MAX1721X)	+= max1721x_battery.o
+obj-$(CONFIG_BATTERY_MAX77759)	+= max77759_battery.o
 obj-$(CONFIG_BATTERY_RT5033)	+= rt5033_battery.o
 obj-$(CONFIG_CHARGER_RT5033)	+= rt5033_charger.o
 obj-$(CONFIG_CHARGER_RT9455)	+= rt9455_charger.o
diff --git a/drivers/power/supply/max77759_battery.c b/drivers/power/supply/max77759_battery.c
new file mode 100644
index 0000000000000000000000000000000000000000..a49980241f8951705237d1f9c4328d0ff516c344
--- /dev/null
+++ b/drivers/power/supply/max77759_battery.c
@@ -0,0 +1,652 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Fuel gauge driver for Maxim 777759
+ *
+ * based on max1720x_battery.c
+ *
+ * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
+ */
+
+#include <linux/bitfield.h>
+#include <linux/crc8.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+
+#include <linux/unaligned.h>
+
+#define MAX77759_FG_CRC8_POLYNOMIAL  0x07
+DECLARE_CRC8_TABLE(max77759_fg_crc8_table);
+
+#define MAX77759_FG_STATUS		0x00	/* Status */
+#define MAX77759_FG_STATUS_POR		BIT(1)	/* Power-On Reset */
+#define MAX77759_FG_STATUS_BAT_ABSENT	BIT(3)	/* Battery absent */
+#define MAX77759_FG_REPCAP		0x05	/* Average capacity */
+#define MAX77759_FG_REPSOC		0x06	/* Percentage of charge */
+#define MAX77759_FG_TEMP		0x08	/* Temperature */
+#define MAX77759_FG_CURRENT		0x0A	/* Actual current */
+#define MAX77759_FG_AVG_CURRENT		0x0B	/* Average current */
+#define MAX77759_FG_FULL_CAP		0x10	/* Calculated full capacity */
+#define MAX77759_FG_QR_TABLE00		0x12
+#define MAX77759_FG_FULLSOCTHR		0x13
+#define MAX77759_FG_CYCLES		0x17
+#define MAX77759_FG_DESIGN_CAP		0x18	/* Design capacity */
+#define MAX77759_FG_CONFIG		0x1D
+#define MAX77759_FG_ICHGTERM		0x1E
+#define MAX77759_FG_DEV_NAME		0x21	/* Device name */
+#define MAX77759_FG_DEV_NAME_TYPE_MASK	GENMASK(15, 9)
+#define MAX77759_FG_DEV_NAME_TYPE	0x31
+#define MAX77759_FG_QR_TABLE10		0x22
+#define MAX77759_FG_FULLCAPNOM		0x23	/* Nominal full capacity */
+#define MAX77759_FG_LEARNCFG		0x28
+#define MAX77759_FG_FILTERCFG		0x29
+#define MAX77759_FG_RELAXCFG		0x2A
+#define MAX77759_FG_MISCCFG		0x2B
+#define MAX77759_FG_TGAIN		0x2C
+#define MAX77759_FG_TOFF		0x2D
+#define MAX77759_FG_CGAIN		0x2E
+#define MAX77759_FG_QR_TABLE20		0x32
+#define MAX77759_FG_FULLCAPREP		0x35	/* Reported full capacity */
+#define MAX77759_FG_RCOMP0		0x38
+#define MAX77759_FG_TEMPCO		0x39	/* Temperature Compensation*/
+#define MAX77759_FG_TASKPERIOD		0x3C
+#define MAX77759_FG_TASKPERIOD_175MS	0x1680
+#define MAX77759_FG_TASKPERIOD_351MS	0x2D00
+#define MAX77759_FG_QR_TABLE30		0x42
+#define MAX77759_FG_DQACC		0x45
+#define MAX77759_FG_DPACC		0x46
+#define MAX77759_FG_VFSOC0		0x48
+#define MAX77759_FG_CONVGCFG		0x49
+#define MAX77759_FG_COMMAND		0x60
+#define MAX77759_FG_COMMAND_LOCK_CONF	0x0000	/* Lock extra config */
+#define MAX77759_FG_COMMAND_UNLOCK_CONF	0x0080	/* Unlock extra config */
+#define MAX77759_FG_CV_MIXCAP		0xB6
+#define MAX77759_FG_CV_HALFTIME		0xB7
+#define MAX77759_FG_CURVE		0xB9
+#define MAX77759_FG_CONFIG2		0xBB
+#define MAX77759_FG_CONFIG2_OCVQEN	BIT(4)
+#define MAX77759_FG_CONFIG2_LDMDL	BIT(5)	/* Load model */
+#define MAX77759_FG_CONFIG2_DSOCEN	BIT(7)
+#define MAX77759_FG_VFSOC		0xFF
+
+static const char *const max77759_fg_manufacturer = "Maxim Integrated";
+static const char *const max77759_fg_model = "MAX77759";
+
+struct max77759_fg_device_info {
+	struct regmap *regmap;
+	int rsense;
+};
+
+/*
+ * Registers 0x80 up to 0xaf which contain the model for the fuel gauge
+ * algorithm are locked. They can be unlocked by writing 0x59 to 0x62
+ * and 0xc4 to 0x63. They should be enabled in the regmap if the driver
+ * is extended to manage the model.
+ */
+static const struct regmap_range max77759_fg_registers[] = {
+	regmap_reg_range(0x00, 0x4f),
+	regmap_reg_range(0x60, 0x60),
+	regmap_reg_range(0xb0, 0xbf),
+	regmap_reg_range(0xd0, 0xd0),
+	regmap_reg_range(0xdc, 0xdf),
+	regmap_reg_range(0xfb, 0xfb),
+	regmap_reg_range(0xff, 0xff),
+};
+
+static const struct regmap_range max77759_fg_ro_registers[] = {
+	regmap_reg_range(0x3d, 0x3d),
+	regmap_reg_range(0xfb, 0xfb),
+	regmap_reg_range(0xff, 0xff),
+};
+
+static const struct regmap_access_table max77759_fg_write_table = {
+	.no_ranges = max77759_fg_ro_registers,
+	.n_no_ranges = ARRAY_SIZE(max77759_fg_ro_registers),
+};
+
+static const struct regmap_access_table max77759_fg_rd_table = {
+	.yes_ranges = max77759_fg_registers,
+	.n_yes_ranges = ARRAY_SIZE(max77759_fg_registers),
+};
+
+static const struct regmap_config max77759_fg_regmap_cfg = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = 0xff,
+	.wr_table = &max77759_fg_write_table,
+	.rd_table = &max77759_fg_rd_table,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+	.cache_type = REGCACHE_NONE,
+};
+
+static const enum power_supply_property max77759_fg_battery_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_AVG,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+};
+
+struct max77759_fg_state_save {
+	u16 rcomp0;
+	u16 tempco;
+	u16 fullcaprep;
+	u16 cycles;
+	u16 fullcapnom;
+	u16 qrtable00;
+	u16 qrtable10;
+	u16 qrtable20;
+	u16 qrtable30;
+	u16 mixcap;
+	u16 halftime;
+	u8 crc;
+} __packed;
+
+/* Convert regs value to power_supply units */
+
+static int max77759_fg_percent_to_ps(unsigned int reg)
+{
+	return reg / 256;	/* in percent from 0 to 100 */
+}
+
+static int max77759_fg_capacity_to_ps(unsigned int reg,
+				      struct max77759_fg_device_info *info)
+{
+	return reg * (500000 / info->rsense);	/* in uAh */
+}
+
+static int max77759_fg_capacity_lsb(struct max77759_fg_device_info *info,
+				    unsigned int *lsb)
+{
+	unsigned int reg_task_period;
+	int ret;
+
+	ret = regmap_read(info->regmap, MAX77759_FG_TASKPERIOD,
+			  &reg_task_period);
+	if (ret < 0)
+		return ret;
+
+	switch (reg_task_period) {
+	case MAX77759_FG_TASKPERIOD_175MS:
+		*lsb = 1;
+		break;
+	case MAX77759_FG_TASKPERIOD_351MS:
+		*lsb = 2;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+/*
+ * Current and temperature is signed values, so unsigned regs
+ * value must be converted to signed type
+ */
+
+static int max77759_fg_temperature_to_ps(unsigned int reg)
+{
+	int val = (int16_t)reg;
+
+	return val * 10 / 256; /* in tenths of deg. C */
+}
+
+/*
+ * Calculating current registers resolution:
+ *
+ * RSense stored in 10^-5 Ohm, so measurement voltage must be
+ * in 10^-11 Volts for get current in uA.
+ * 16 bit current reg fullscale +/-51.2mV is 102400 uV.
+ * So: 102400 / 65535 * 10^5 = 156252
+ */
+static int max77759_fg_current_to_voltage(unsigned int reg)
+{
+	int val = (int16_t)reg;
+
+	return val * 156252;
+}
+
+static int max77759_fg_battery_get_property(struct power_supply *psy,
+					    enum power_supply_property psp,
+					    union power_supply_propval *val)
+{
+	struct max77759_fg_device_info *info = power_supply_get_drvdata(psy);
+	unsigned int reg_val;
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		/*
+		 * POWER_SUPPLY_PROP_PRESENT will always readable via
+		 * sysfs interface. Value return 0 if battery not
+		 * present or inaccesable via I2C.
+		 */
+		ret = regmap_read(info->regmap, MAX77759_FG_STATUS, &reg_val);
+		if (ret < 0) {
+			val->intval = 0;
+			return 0;
+		}
+
+		val->intval = !FIELD_GET(MAX77759_FG_STATUS_BAT_ABSENT, reg_val);
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		ret = regmap_read(info->regmap, MAX77759_FG_REPSOC, &reg_val);
+		val->intval = max77759_fg_percent_to_ps(reg_val);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		ret = regmap_read(info->regmap, MAX77759_FG_DESIGN_CAP, &reg_val);
+		if (ret < 0)
+			return ret;
+
+		val->intval = max77759_fg_capacity_to_ps(reg_val, info);
+		ret = max77759_fg_capacity_lsb(info, &reg_val);
+		val->intval *= reg_val;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_AVG:
+		ret = regmap_read(info->regmap, MAX77759_FG_REPCAP, &reg_val);
+		if (ret < 0)
+			return ret;
+
+		val->intval = max77759_fg_capacity_to_ps(reg_val, info);
+		ret = max77759_fg_capacity_lsb(info, &reg_val);
+		val->intval *= reg_val;
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		ret = regmap_read(info->regmap, MAX77759_FG_TEMP, &reg_val);
+		val->intval = max77759_fg_temperature_to_ps(reg_val);
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = regmap_read(info->regmap, MAX77759_FG_CURRENT, &reg_val);
+		val->intval = max77759_fg_current_to_voltage(reg_val) / info->rsense;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_AVG:
+		ret = regmap_read(info->regmap, MAX77759_FG_AVG_CURRENT, &reg_val);
+		val->intval = max77759_fg_current_to_voltage(reg_val) / info->rsense;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		ret = regmap_read(info->regmap, MAX77759_FG_FULL_CAP, &reg_val);
+		if (ret < 0)
+			return ret;
+
+		val->intval = max77759_fg_capacity_to_ps(reg_val, info);
+		ret = max77759_fg_capacity_lsb(info, &reg_val);
+		val->intval *= reg_val;
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		ret = regmap_read(info->regmap, MAX77759_FG_DEV_NAME, &reg_val);
+		if (ret < 0)
+			return ret;
+
+		reg_val = FIELD_GET(MAX77759_FG_DEV_NAME_TYPE_MASK, reg_val);
+		if (reg_val == MAX77759_FG_DEV_NAME_TYPE)
+			val->strval = max77759_fg_model;
+		else
+			return -ENODEV;
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = max77759_fg_manufacturer;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int max77759_fg_init(struct device *dev,
+			    struct max77759_fg_device_info *info,
+			    struct power_supply *bat_psy)
+{
+	struct max77759_fg_state_save *state;
+	struct power_supply_battery_info *bat_info;
+	struct nvmem_cell *cell;
+	unsigned int val;
+	int ret;
+	size_t len;
+
+	ret = power_supply_get_battery_info(bat_psy, &bat_info);
+	if (ret)
+		return ret;
+
+	cell = devm_nvmem_cell_get(dev, "fg_state");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	state = (struct max77759_fg_state_save *)nvmem_cell_read(cell, &len);
+	if (IS_ERR(state))
+		return PTR_ERR(state);
+	if (len != sizeof(struct max77759_fg_state_save)) {
+		ret = -EINVAL;
+		goto err_init;
+	}
+
+	ret = regmap_write(info->regmap, MAX77759_FG_REPCAP, 0x0000);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_RELAXCFG, 0x0839);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_COMMAND,
+			   MAX77759_FG_COMMAND_UNLOCK_CONF);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_read(info->regmap, MAX77759_FG_VFSOC, &val);
+	if (ret < 0)
+		goto err_init;
+	ret = regmap_write(info->regmap, MAX77759_FG_VFSOC0, val);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_LEARNCFG, 0x260E);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_CONFIG, 0x4217);
+	if (ret < 0)
+		goto err_init;
+
+	val = MAX77759_FG_CONFIG2_DSOCEN | MAX77759_FG_CONFIG2_OCVQEN;
+	ret = regmap_write(info->regmap, MAX77759_FG_CONFIG2, val);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_FULLSOCTHR, 0x5F00);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_FULLCAPREP,
+			   state->fullcaprep);
+	if (ret < 0)
+		goto err_init;
+
+	//Use an LSB of 2 because TASKPERIOD will be set to 351MS
+	val = bat_info->charge_full_design_uah * (info->rsense / 100) / 10000;
+	ret = regmap_write(info->regmap, MAX77759_FG_DESIGN_CAP, val);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_DPACC, 0x0C80);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_DQACC,
+			   state->fullcapnom >> 4);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_STATUS,
+			   MAX77759_FG_STATUS_POR);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_FULLCAPNOM,
+			   state->fullcapnom);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_QR_TABLE00,
+			   state->qrtable00);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_QR_TABLE10,
+			   state->qrtable10);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_QR_TABLE20,
+			   state->qrtable20);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_QR_TABLE30,
+			   state->qrtable30);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_RCOMP0, state->rcomp0);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_TEMPCO, state->tempco);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_TASKPERIOD,
+			   MAX77759_FG_TASKPERIOD_351MS);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_ICHGTERM,
+			   bat_info->charge_term_current_ua *
+			   info->rsense / 15625);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_TGAIN, 0xED51);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_TOFF, 0x1EBA);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_MISCCFG, 0x3870);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_CV_MIXCAP, state->mixcap);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_CV_HALFTIME,
+			   state->halftime);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_CONVGCFG, 0x2241);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_COMMAND,
+			   MAX77759_FG_COMMAND_LOCK_CONF);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_CURVE, 0x0014);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_FILTERCFG, 0xc623);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_CGAIN, 0x0400);
+	if (ret < 0)
+		goto err_init;
+
+	val = MAX77759_FG_CONFIG2_DSOCEN | MAX77759_FG_CONFIG2_OCVQEN;
+	val |= MAX77759_FG_CONFIG2_LDMDL;
+	ret = regmap_write(info->regmap, MAX77759_FG_CONFIG2, val);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_STATUS, 0x0000);
+	if (ret < 0)
+		goto err_init;
+
+	ret = regmap_write(info->regmap, MAX77759_FG_CYCLES, state->cycles);
+	if (ret < 0)
+		goto err_init;
+
+	kfree(state);
+	return 0;
+
+err_init:
+	kfree(state);
+	return ret;
+}
+
+static const struct power_supply_desc max77759_fg_bat_desc = {
+	.name = "max77759-fg",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = max77759_fg_battery_props,
+	.num_properties = ARRAY_SIZE(max77759_fg_battery_props),
+	.get_property = max77759_fg_battery_get_property,
+};
+
+static int max77759_fg_backup_fg_state(struct device *dev,
+				       struct regmap *regmap)
+{
+	struct max77759_fg_state_save state;
+	struct nvmem_cell *cell;
+	int val;
+	int ret;
+
+	ret = regmap_read(regmap, MAX77759_FG_RCOMP0, &val);
+	if (ret < 0)
+		return ret;
+	state.rcomp0 = (u16)val;
+
+	ret = regmap_read(regmap, MAX77759_FG_TEMPCO, &val);
+	if (ret < 0)
+		return ret;
+	state.tempco = (u16)val;
+
+	ret = regmap_read(regmap, MAX77759_FG_FULLCAPREP, &val);
+	if (ret < 0)
+		return ret;
+	state.fullcaprep = (u16)val;
+
+	ret = regmap_read(regmap, MAX77759_FG_CYCLES, &val);
+	if (ret < 0)
+		return ret;
+	state.cycles = (u16)val;
+
+	ret = regmap_read(regmap, MAX77759_FG_FULLCAPNOM, &val);
+	if (ret < 0)
+		return ret;
+	state.fullcapnom = (u16)val;
+
+	ret = regmap_read(regmap, MAX77759_FG_QR_TABLE00, &val);
+	if (ret < 0)
+		return ret;
+	state.qrtable00 = (u16)val;
+
+	ret = regmap_read(regmap, MAX77759_FG_QR_TABLE10, &val);
+	if (ret < 0)
+		return ret;
+	state.qrtable10 = (u16)val;
+
+	ret = regmap_read(regmap, MAX77759_FG_QR_TABLE20, &val);
+	if (ret < 0)
+		return ret;
+	state.qrtable20 = (u16)val;
+
+	ret = regmap_read(regmap, MAX77759_FG_QR_TABLE30, &val);
+	if (ret < 0)
+		return ret;
+	state.qrtable30 = (u16)val;
+
+	ret = regmap_read(regmap, MAX77759_FG_CV_MIXCAP, &val);
+	if (ret < 0)
+		return ret;
+	state.mixcap = (u16)val;
+
+	ret = regmap_read(regmap, MAX77759_FG_CV_HALFTIME, &val);
+	if (ret < 0)
+		return ret;
+	state.halftime = (u16)val;
+
+	state.crc = crc8(max77759_fg_crc8_table, (u8 *)&state,
+			 sizeof(state) - sizeof(state.crc), CRC8_INIT_VALUE);
+
+	cell = devm_nvmem_cell_get(dev, "fg_state");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+	ret = nvmem_cell_write(cell, &state, sizeof(state));
+	if (ret < 0)
+		dev_err(dev, "Failed to write fg_state to NVMEM: %d\n", ret);
+
+	return ret;
+}
+
+static void max77759_fg_remove(struct i2c_client *client)
+{
+	struct max77759_fg_device_info *info = i2c_get_clientdata(client);
+
+	max77759_fg_backup_fg_state(&client->dev, info->regmap);
+}
+
+static int max77759_fg_probe(struct i2c_client *client)
+{
+	struct power_supply_config psy_cfg = {};
+	struct device *dev = &client->dev;
+	struct max77759_fg_device_info *info;
+	struct power_supply *bat;
+	int ret, val;
+
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	psy_cfg.drv_data = info;
+	psy_cfg.fwnode = dev_fwnode(dev);
+
+	crc8_populate_msb(max77759_fg_crc8_table, MAX77759_FG_CRC8_POLYNOMIAL);
+
+	i2c_set_clientdata(client, info);
+
+	info->regmap = devm_regmap_init_i2c(client, &max77759_fg_regmap_cfg);
+	if (IS_ERR(info->regmap))
+		return dev_err_probe(dev, PTR_ERR(info->regmap),
+				     "regmap initialization failed\n");
+
+	ret = device_property_read_u32(dev, "shunt-resistor-micro-ohms", &val);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to read RSense from devicetree\n");
+	info->rsense = val / 10;
+
+	bat = devm_power_supply_register(dev, &max77759_fg_bat_desc, &psy_cfg);
+	if (IS_ERR(bat))
+		return dev_err_probe(dev, PTR_ERR(bat),
+				     "Failed to register power supply\n");
+
+	ret = max77759_fg_init(dev, info, bat);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize chip\n");
+
+	return 0;
+}
+
+static const struct of_device_id max77759_fg_of_match[] = {
+	{ .compatible = "maxim,max77759-fg" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, max77759_fg_of_match);
+
+static struct i2c_driver max77759_fg_i2c_driver = {
+	.driver = {
+		.name = "max77759_fg",
+		.of_match_table = max77759_fg_of_match,
+	},
+	.probe = max77759_fg_probe,
+	.remove = max77759_fg_remove,
+};
+module_i2c_driver(max77759_fg_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Thomas Antoine <t.antoine@uclouvain.be>");
+MODULE_DESCRIPTION("Maxim MAX77759 Fuel Gauge IC driver");

-- 
2.51.0



