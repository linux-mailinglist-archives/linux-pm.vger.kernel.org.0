Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67994257F06
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 18:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgHaQtF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 12:49:05 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40424 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgHaQtE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 12:49:04 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07VGn18g103033;
        Mon, 31 Aug 2020 11:49:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598892541;
        bh=Fja1kS7K7GWcl6ee3C5w+hv3GQQD7Oq6u66v9YmElWk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GDCP6Iijnp7tUKjY6Tp0O11G7zDar6QEHRrtBXeFrM7iySuW1dXLeu4vlJj5gtaBq
         hLWeLtaeqazgbymhVGBZYS68irMTmlwOS6wZyt/lxNL/DrKuiknMOIDPpSdW22ezdW
         qU0v52eS/226Y5zR3B4aWdx5OjlY/IjXNlzG5FS4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07VGn1HK063053
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Aug 2020 11:49:01 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 31
 Aug 2020 11:49:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 31 Aug 2020 11:49:00 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07VGn0lP074965;
        Mon, 31 Aug 2020 11:49:00 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>, <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <r-rivera-matos@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 2/2] power: bq25980: Add support for the BQ259xx family
Date:   Mon, 31 Aug 2020 11:48:49 -0500
Message-ID: <20200831164849.31313-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200831164849.31313-1-dmurphy@ti.com>
References: <20200831164849.31313-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for the BQ25980, BQ25975 and BQ25960 family of flash
chargers.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/power/supply/Kconfig           |    9 +
 drivers/power/supply/Makefile          |    1 +
 drivers/power/supply/bq25980_charger.c | 1316 ++++++++++++++++++++++++
 drivers/power/supply/bq25980_charger.h |  178 ++++
 4 files changed, 1504 insertions(+)
 create mode 100644 drivers/power/supply/bq25980_charger.c
 create mode 100644 drivers/power/supply/bq25980_charger.h

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index faf2830aa152..fbe974e4cff4 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -631,6 +631,15 @@ config CHARGER_BQ25890
 	help
 	  Say Y to enable support for the TI BQ25890 battery charger.
 
+config CHARGER_BQ25980
+	tristate "TI BQ25980 battery charger driver"
+	depends on I2C
+	depends on GPIOLIB || COMPILE_TEST
+	select REGMAP_I2C
+	help
+	  Say Y to enable support for the TI BQ25980, BQ25975 and BQ25960
+	  series of fast battery chargers.
+
 config CHARGER_SMB347
 	tristate "Summit Microelectronics SMB347 Battery Charger"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index b3c694a65114..9b2f21fa6f94 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_CHARGER_BQ24257)	+= bq24257_charger.o
 obj-$(CONFIG_CHARGER_BQ24735)	+= bq24735-charger.o
 obj-$(CONFIG_CHARGER_BQ2515X)	+= bq2515x_charger.o
 obj-$(CONFIG_CHARGER_BQ25890)	+= bq25890_charger.o
+obj-$(CONFIG_CHARGER_BQ25980)	+= bq25980_charger.o
 obj-$(CONFIG_CHARGER_SMB347)	+= smb347-charger.o
 obj-$(CONFIG_CHARGER_TPS65090)	+= tps65090-charger.o
 obj-$(CONFIG_CHARGER_TPS65217)	+= tps65217_charger.o
diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/supply/bq25980_charger.c
new file mode 100644
index 000000000000..3995fb7cf060
--- /dev/null
+++ b/drivers/power/supply/bq25980_charger.c
@@ -0,0 +1,1316 @@
+// SPDX-License-Identifier: GPL-2.0
+// BQ25980 Battery Charger Driver
+// Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/gpio/consumer.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/moduleparam.h>
+#include <linux/slab.h>
+
+#include "bq25980_charger.h"
+
+struct bq25980_state {
+	bool dischg;
+	bool ovp;
+	bool ocp;
+	bool wdt;
+	bool tflt;
+	bool online;
+	bool ce;
+	bool hiz;
+	bool bypass;
+
+	u32 vbat_adc;
+	u32 vsys_adc;
+	u32 ibat_adc;
+};
+
+enum bq25980_id {
+	BQ25980,
+	BQ25975,
+	BQ25960,
+};
+
+struct bq25980_chip_info {
+
+	int model_id;
+
+	const struct regmap_config *regmap_config;
+
+	int busocp_def;
+	int busocp_sc_max;
+	int busocp_byp_max;
+	int busocp_sc_min;
+	int busocp_byp_min;
+
+	int busovp_sc_def;
+	int busovp_byp_def;
+	int busovp_sc_step;
+
+	int busovp_sc_offset;
+	int busovp_byp_step;
+	int busovp_byp_offset;
+	int busovp_sc_min;
+	int busovp_sc_max;
+	int busovp_byp_min;
+	int busovp_byp_max;
+
+	int batovp_def;
+	int batovp_max;
+	int batovp_min;
+	int batovp_step;
+	int batovp_offset;
+
+	int batocp_def;
+	int batocp_max;
+};
+
+struct bq25980_init_data {
+	u32 ichg;
+	u32 bypass_ilim;
+	u32 sc_ilim;
+	u32 vreg;
+	u32 iterm;
+	u32 iprechg;
+	u32 bypass_vlim;
+	u32 sc_vlim;
+	u32 ichg_max;
+	u32 vreg_max;
+};
+
+struct bq25980_device {
+	struct i2c_client *client;
+	struct device *dev;
+	struct power_supply *charger;
+	struct power_supply *battery;
+	struct mutex lock;
+	struct regmap *regmap;
+
+	char model_name[I2C_NAME_SIZE];
+
+	struct bq25980_init_data init_data;
+	const struct bq25980_chip_info *chip_info;
+	struct bq25980_state state;
+	int watchdog_timer;
+};
+
+static struct reg_default bq25980_reg_defs[] = {
+	{BQ25980_BATOVP, 0x5A},
+	{BQ25980_BATOVP_ALM, 0x46},
+	{BQ25980_BATOCP, 0x51},
+	{BQ25980_BATOCP_ALM, 0x50},
+	{BQ25980_BATUCP_ALM, 0x28},
+	{BQ25980_CHRGR_CTRL_1, 0x0},
+	{BQ25980_BUSOVP, 0x26},
+	{BQ25980_BUSOVP_ALM, 0x22},
+	{BQ25980_BUSOCP, 0xD},
+	{BQ25980_BUSOCP_ALM, 0xC},
+	{BQ25980_TEMP_CONTROL, 0x30},
+	{BQ25980_TDIE_ALM, 0xC8},
+	{BQ25980_TSBUS_FLT, 0x15},
+	{BQ25980_TSBAT_FLG, 0x15},
+	{BQ25980_VAC_CONTROL, 0x0},
+	{BQ25980_CHRGR_CTRL_2, 0x0},
+	{BQ25980_CHRGR_CTRL_3, 0x20},
+	{BQ25980_CHRGR_CTRL_4, 0x1D},
+	{BQ25980_CHRGR_CTRL_5, 0x18},
+	{BQ25980_STAT1, 0x0},
+	{BQ25980_STAT2, 0x0},
+	{BQ25980_STAT3, 0x0},
+	{BQ25980_STAT4, 0x0},
+	{BQ25980_STAT5, 0x0},
+	{BQ25980_FLAG1, 0x0},
+	{BQ25980_FLAG2, 0x0},
+	{BQ25980_FLAG3, 0x0},
+	{BQ25980_FLAG4, 0x0},
+	{BQ25980_FLAG5, 0x0},
+	{BQ25980_MASK1, 0x0},
+	{BQ25980_MASK2, 0x0},
+	{BQ25980_MASK3, 0x0},
+	{BQ25980_MASK4, 0x0},
+	{BQ25980_MASK5, 0x0},
+	{BQ25980_DEVICE_INFO, 0x8},
+	{BQ25980_ADC_CONTROL1, 0x0},
+	{BQ25980_ADC_CONTROL2, 0x0},
+	{BQ25980_IBUS_ADC_LSB, 0x0},
+	{BQ25980_IBUS_ADC_MSB, 0x0},
+	{BQ25980_VBUS_ADC_LSB, 0x0},
+	{BQ25980_VBUS_ADC_MSB, 0x0},
+	{BQ25980_VAC1_ADC_LSB, 0x0},
+	{BQ25980_VAC2_ADC_LSB, 0x0},
+	{BQ25980_VOUT_ADC_LSB, 0x0},
+	{BQ25980_VBAT_ADC_LSB, 0x0},
+	{BQ25980_IBAT_ADC_MSB, 0x0},
+	{BQ25980_IBAT_ADC_LSB, 0x0},
+	{BQ25980_TSBUS_ADC_LSB, 0x0},
+	{BQ25980_TSBAT_ADC_LSB, 0x0},
+	{BQ25980_TDIE_ADC_LSB, 0x0},
+	{BQ25980_DEGLITCH_TIME, 0x0},
+	{BQ25980_CHRGR_CTRL_6, 0x0},
+};
+
+static struct reg_default bq25975_reg_defs[] = {
+	{BQ25980_BATOVP, 0x5A},
+	{BQ25980_BATOVP_ALM, 0x46},
+	{BQ25980_BATOCP, 0x51},
+	{BQ25980_BATOCP_ALM, 0x50},
+	{BQ25980_BATUCP_ALM, 0x28},
+	{BQ25980_CHRGR_CTRL_1, 0x0},
+	{BQ25980_BUSOVP, 0x26},
+	{BQ25980_BUSOVP_ALM, 0x22},
+	{BQ25980_BUSOCP, 0xD},
+	{BQ25980_BUSOCP_ALM, 0xC},
+	{BQ25980_TEMP_CONTROL, 0x30},
+	{BQ25980_TDIE_ALM, 0xC8},
+	{BQ25980_TSBUS_FLT, 0x15},
+	{BQ25980_TSBAT_FLG, 0x15},
+	{BQ25980_VAC_CONTROL, 0x0},
+	{BQ25980_CHRGR_CTRL_2, 0x0},
+	{BQ25980_CHRGR_CTRL_3, 0x20},
+	{BQ25980_CHRGR_CTRL_4, 0x1D},
+	{BQ25980_CHRGR_CTRL_5, 0x18},
+	{BQ25980_STAT1, 0x0},
+	{BQ25980_STAT2, 0x0},
+	{BQ25980_STAT3, 0x0},
+	{BQ25980_STAT4, 0x0},
+	{BQ25980_STAT5, 0x0},
+	{BQ25980_FLAG1, 0x0},
+	{BQ25980_FLAG2, 0x0},
+	{BQ25980_FLAG3, 0x0},
+	{BQ25980_FLAG4, 0x0},
+	{BQ25980_FLAG5, 0x0},
+	{BQ25980_MASK1, 0x0},
+	{BQ25980_MASK2, 0x0},
+	{BQ25980_MASK3, 0x0},
+	{BQ25980_MASK4, 0x0},
+	{BQ25980_MASK5, 0x0},
+	{BQ25980_DEVICE_INFO, 0x8},
+	{BQ25980_ADC_CONTROL1, 0x0},
+	{BQ25980_ADC_CONTROL2, 0x0},
+	{BQ25980_IBUS_ADC_LSB, 0x0},
+	{BQ25980_IBUS_ADC_MSB, 0x0},
+	{BQ25980_VBUS_ADC_LSB, 0x0},
+	{BQ25980_VBUS_ADC_MSB, 0x0},
+	{BQ25980_VAC1_ADC_LSB, 0x0},
+	{BQ25980_VAC2_ADC_LSB, 0x0},
+	{BQ25980_VOUT_ADC_LSB, 0x0},
+	{BQ25980_VBAT_ADC_LSB, 0x0},
+	{BQ25980_IBAT_ADC_MSB, 0x0},
+	{BQ25980_IBAT_ADC_LSB, 0x0},
+	{BQ25980_TSBUS_ADC_LSB, 0x0},
+	{BQ25980_TSBAT_ADC_LSB, 0x0},
+	{BQ25980_TDIE_ADC_LSB, 0x0},
+	{BQ25980_DEGLITCH_TIME, 0x0},
+	{BQ25980_CHRGR_CTRL_6, 0x0},
+};
+
+static struct reg_default bq25960_reg_defs[] = {
+	{BQ25980_BATOVP, 0x5A},
+	{BQ25980_BATOVP_ALM, 0x46},
+	{BQ25980_BATOCP, 0x51},
+	{BQ25980_BATOCP_ALM, 0x50},
+	{BQ25980_BATUCP_ALM, 0x28},
+	{BQ25980_CHRGR_CTRL_1, 0x0},
+	{BQ25980_BUSOVP, 0x26},
+	{BQ25980_BUSOVP_ALM, 0x22},
+	{BQ25980_BUSOCP, 0xD},
+	{BQ25980_BUSOCP_ALM, 0xC},
+	{BQ25980_TEMP_CONTROL, 0x30},
+	{BQ25980_TDIE_ALM, 0xC8},
+	{BQ25980_TSBUS_FLT, 0x15},
+	{BQ25980_TSBAT_FLG, 0x15},
+	{BQ25980_VAC_CONTROL, 0x0},
+	{BQ25980_CHRGR_CTRL_2, 0x0},
+	{BQ25980_CHRGR_CTRL_3, 0x20},
+	{BQ25980_CHRGR_CTRL_4, 0x1D},
+	{BQ25980_CHRGR_CTRL_5, 0x18},
+	{BQ25980_STAT1, 0x0},
+	{BQ25980_STAT2, 0x0},
+	{BQ25980_STAT3, 0x0},
+	{BQ25980_STAT4, 0x0},
+	{BQ25980_STAT5, 0x0},
+	{BQ25980_FLAG1, 0x0},
+	{BQ25980_FLAG2, 0x0},
+	{BQ25980_FLAG3, 0x0},
+	{BQ25980_FLAG4, 0x0},
+	{BQ25980_FLAG5, 0x0},
+	{BQ25980_MASK1, 0x0},
+	{BQ25980_MASK2, 0x0},
+	{BQ25980_MASK3, 0x0},
+	{BQ25980_MASK4, 0x0},
+	{BQ25980_MASK5, 0x0},
+	{BQ25980_DEVICE_INFO, 0x8},
+	{BQ25980_ADC_CONTROL1, 0x0},
+	{BQ25980_ADC_CONTROL2, 0x0},
+	{BQ25980_IBUS_ADC_LSB, 0x0},
+	{BQ25980_IBUS_ADC_MSB, 0x0},
+	{BQ25980_VBUS_ADC_LSB, 0x0},
+	{BQ25980_VBUS_ADC_MSB, 0x0},
+	{BQ25980_VAC1_ADC_LSB, 0x0},
+	{BQ25980_VAC2_ADC_LSB, 0x0},
+	{BQ25980_VOUT_ADC_LSB, 0x0},
+	{BQ25980_VBAT_ADC_LSB, 0x0},
+	{BQ25980_IBAT_ADC_MSB, 0x0},
+	{BQ25980_IBAT_ADC_LSB, 0x0},
+	{BQ25980_TSBUS_ADC_LSB, 0x0},
+	{BQ25980_TSBAT_ADC_LSB, 0x0},
+	{BQ25980_TDIE_ADC_LSB, 0x0},
+	{BQ25980_DEGLITCH_TIME, 0x0},
+	{BQ25980_CHRGR_CTRL_6, 0x0},
+};
+
+static int bq25980_watchdog_time[BQ25980_NUM_WD_VAL] = {5000, 10000, 50000,
+							300000};
+
+static int bq25980_get_input_curr_lim(struct bq25980_device *bq)
+{
+	unsigned int busocp_reg_code;
+	int ret;
+
+	ret = regmap_read(bq->regmap, BQ25980_BUSOCP, &busocp_reg_code);
+	if (ret)
+		return ret;
+
+	return (busocp_reg_code * BQ25980_BUSOCP_STEP_uA) + BQ25980_BUSOCP_OFFSET_uA;
+}
+
+static int bq25980_set_hiz(struct bq25980_device *bq, int setting)
+{
+	return regmap_update_bits(bq->regmap, BQ25980_CHRGR_CTRL_2,
+			BQ25980_EN_HIZ, setting);
+}
+
+static int bq25980_set_input_curr_lim(struct bq25980_device *bq, int busocp)
+{
+	unsigned int busocp_reg_code;
+	int ret;
+
+	if (!busocp)
+		return bq25980_set_hiz(bq, BQ25980_ENABLE_HIZ);
+
+	bq25980_set_hiz(bq, BQ25980_DISABLE_HIZ);
+
+	if (busocp < BQ25980_BUSOCP_MIN_uA)
+		busocp = BQ25980_BUSOCP_MIN_uA;
+
+	if (bq->state.bypass)
+		busocp = min(busocp, bq->chip_info->busocp_sc_max);
+	else
+		busocp = min(busocp, bq->chip_info->busocp_byp_max);
+
+	busocp_reg_code = (busocp - BQ25980_BUSOCP_OFFSET_uA)
+						/ BQ25980_BUSOCP_STEP_uA;
+
+	ret = regmap_write(bq->regmap, BQ25980_BUSOCP, busocp_reg_code);
+	if (ret)
+		return ret;
+
+	return regmap_write(bq->regmap, BQ25980_BUSOCP_ALM, busocp_reg_code);
+}
+
+static int bq25980_get_input_volt_lim(struct bq25980_device *bq)
+{
+	unsigned int busovp_reg_code;
+	unsigned int busovp_offset;
+	unsigned int busovp_step;
+	int ret;
+
+	if (bq->state.bypass) {
+		busovp_step = bq->chip_info->busovp_byp_step;
+		busovp_offset = bq->chip_info->busovp_byp_offset;
+	} else {
+		busovp_step = bq->chip_info->busovp_sc_step;
+		busovp_offset = bq->chip_info->busovp_sc_offset;
+	}
+
+	ret = regmap_read(bq->regmap, BQ25980_BUSOVP, &busovp_reg_code);
+	if (ret)
+		return ret;
+
+	return (busovp_reg_code * busovp_step) + busovp_offset;
+}
+
+static int bq25980_set_input_volt_lim(struct bq25980_device *bq, int busovp)
+{
+	unsigned int busovp_reg_code;
+	unsigned int busovp_step;
+	unsigned int busovp_offset;
+	int ret;
+
+	if (bq->state.bypass) {
+		busovp_step = bq->chip_info->busovp_byp_step;
+		busovp_offset = bq->chip_info->busovp_byp_offset;
+		if (busovp > bq->chip_info->busovp_byp_max)
+			busovp = bq->chip_info->busovp_byp_max;
+		else if (busovp < bq->chip_info->busovp_byp_min)
+			busovp = bq->chip_info->busovp_byp_min;
+	} else {
+		busovp_step = bq->chip_info->busovp_sc_step;
+		busovp_offset = bq->chip_info->busovp_sc_offset;
+		if (busovp > bq->chip_info->busovp_sc_max)
+			busovp = bq->chip_info->busovp_sc_max;
+		else if (busovp < bq->chip_info->busovp_sc_min)
+			busovp = bq->chip_info->busovp_sc_min;
+	}
+
+	busovp_reg_code = (busovp - busovp_offset) / busovp_step;
+
+	ret = regmap_write(bq->regmap, BQ25980_BUSOVP, busovp_reg_code);
+	if (ret)
+		return ret;
+
+	return regmap_write(bq->regmap, BQ25980_BUSOVP_ALM, busovp_reg_code);
+}
+
+static int bq25980_get_const_charge_curr(struct bq25980_device *bq)
+{
+	unsigned int batocp_reg_code;
+	int ret;
+
+	ret = regmap_read(bq->regmap, BQ25980_BATOCP, &batocp_reg_code);
+	if (ret)
+		return ret;
+
+	return (batocp_reg_code & BQ25980_BATOCP_MASK) *
+						BQ25980_BATOCP_STEP_uA;
+}
+
+static int bq25980_set_const_charge_curr(struct bq25980_device *bq, int batocp)
+{
+	unsigned int batocp_reg_code;
+	int ret;
+
+	batocp = max(batocp, BQ25980_BATOCP_MIN_uA);
+	batocp = min(batocp, bq->chip_info->batocp_max);
+
+	batocp_reg_code = batocp / BQ25980_BATOCP_STEP_uA;
+
+	ret = regmap_update_bits(bq->regmap, BQ25980_BATOCP,
+				BQ25980_BATOCP_MASK, batocp_reg_code);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(bq->regmap, BQ25980_BATOCP_ALM,
+				BQ25980_BATOCP_MASK, batocp_reg_code);
+}
+
+static int bq25980_get_const_charge_volt(struct bq25980_device *bq)
+{
+	unsigned int batovp_reg_code;
+	int ret;
+
+	ret = regmap_read(bq->regmap, BQ25980_BATOVP, &batovp_reg_code);
+	if (ret)
+		return ret;
+
+	return ((batovp_reg_code * bq->chip_info->batovp_step) +
+			bq->chip_info->batovp_offset);
+}
+
+static int bq25980_set_const_charge_volt(struct bq25980_device *bq, int batovp)
+{
+	unsigned int batovp_reg_code;
+	int ret;
+
+	if (batovp < bq->chip_info->batovp_min)
+		batovp = bq->chip_info->batovp_min;
+
+	if (batovp > bq->chip_info->batovp_max)
+		batovp = bq->chip_info->batovp_max;
+
+	batovp_reg_code = (batovp - bq->chip_info->batovp_offset) /
+						bq->chip_info->batovp_step;
+
+	ret = regmap_write(bq->regmap, BQ25980_BATOVP, batovp_reg_code);
+	if (ret)
+		return ret;
+
+	return regmap_write(bq->regmap, BQ25980_BATOVP_ALM, batovp_reg_code);
+}
+
+static int bq25980_set_bypass(struct bq25980_device *bq, bool en_bypass)
+{
+	int ret;
+
+	if (en_bypass)
+		ret = regmap_update_bits(bq->regmap, BQ25980_CHRGR_CTRL_2,
+					BQ25980_EN_BYPASS, BQ25980_EN_BYPASS);
+	else
+		ret = regmap_update_bits(bq->regmap, BQ25980_CHRGR_CTRL_2,
+					BQ25980_EN_BYPASS, en_bypass);
+	if (ret)
+		return ret;
+
+	bq->state.bypass = en_bypass;
+
+	return bq->state.bypass;
+}
+
+static int bq25980_set_chg_en(struct bq25980_device *bq, bool en_chg)
+{
+	int ret;
+
+	if (en_chg)
+		ret = regmap_update_bits(bq->regmap, BQ25980_CHRGR_CTRL_2,
+					BQ25980_CHG_EN, BQ25980_CHG_EN);
+	else
+		ret = regmap_update_bits(bq->regmap, BQ25980_CHRGR_CTRL_2,
+					BQ25980_CHG_EN, en_chg);
+	if (ret)
+		return ret;
+
+	bq->state.ce = en_chg;
+
+	return 0;
+}
+
+static int bq25980_get_adc_ibus(struct bq25980_device *bq)
+{
+	int ibus_adc_lsb, ibus_adc_msb;
+	u16 ibus_adc;
+	int ret;
+
+	ret = regmap_read(bq->regmap, BQ25980_IBUS_ADC_MSB, &ibus_adc_msb);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(bq->regmap, BQ25980_IBUS_ADC_LSB, &ibus_adc_lsb);
+	if (ret)
+		return ret;
+
+	ibus_adc = (ibus_adc_msb << 8) | ibus_adc_lsb;
+
+	if (ibus_adc_msb & BQ25980_ADC_POLARITY_BIT)
+		return ((ibus_adc ^ 0xffff) + 1) * BQ25980_ADC_CURR_STEP_uA;
+
+	return ibus_adc * BQ25980_ADC_CURR_STEP_uA;
+}
+
+static int bq25980_get_adc_vbus(struct bq25980_device *bq)
+{
+	int vbus_adc_lsb, vbus_adc_msb;
+	u16 vbus_adc;
+	int ret;
+
+	ret = regmap_read(bq->regmap, BQ25980_VBUS_ADC_MSB, &vbus_adc_msb);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(bq->regmap, BQ25980_VBUS_ADC_LSB, &vbus_adc_lsb);
+	if (ret)
+		return ret;
+
+	vbus_adc = (vbus_adc_msb << 8) | vbus_adc_lsb;
+
+	return vbus_adc * BQ25980_ADC_VOLT_STEP_uV;
+}
+
+static int bq25980_get_ibat_adc(struct bq25980_device *bq)
+{
+	int ret;
+	int ibat_adc_lsb, ibat_adc_msb;
+	int ibat_adc;
+
+	ret = regmap_read(bq->regmap, BQ25980_IBAT_ADC_MSB, &ibat_adc_msb);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(bq->regmap, BQ25980_IBAT_ADC_LSB, &ibat_adc_lsb);
+	if (ret)
+		return ret;
+
+	ibat_adc = (ibat_adc_msb << 8) | ibat_adc_lsb;
+
+	if (ibat_adc_msb & BQ25980_ADC_POLARITY_BIT)
+		return ((ibat_adc ^ 0xffff) + 1) * BQ25980_ADC_CURR_STEP_uA;
+
+	return ibat_adc * BQ25980_ADC_CURR_STEP_uA;
+}
+
+static int bq25980_get_adc_vbat(struct bq25980_device *bq)
+{
+	int vsys_adc_lsb, vsys_adc_msb;
+	u16 vsys_adc;
+	int ret;
+
+	ret = regmap_read(bq->regmap, BQ25980_VBAT_ADC_MSB, &vsys_adc_msb);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(bq->regmap, BQ25980_VBAT_ADC_LSB, &vsys_adc_lsb);
+	if (ret)
+		return ret;
+
+	vsys_adc = (vsys_adc_msb << 8) | vsys_adc_lsb;
+
+	return vsys_adc * BQ25980_ADC_VOLT_STEP_uV;
+}
+
+static int bq25980_get_state(struct bq25980_device *bq,
+				struct bq25980_state *state)
+{
+	unsigned int chg_ctrl_2;
+	unsigned int stat1;
+	unsigned int stat2;
+	unsigned int stat3;
+	unsigned int stat4;
+	unsigned int ibat_adc_msb;
+	int ret;
+
+	ret = regmap_read(bq->regmap, BQ25980_STAT1, &stat1);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(bq->regmap, BQ25980_STAT2, &stat2);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(bq->regmap, BQ25980_STAT3, &stat3);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(bq->regmap, BQ25980_STAT4, &stat4);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(bq->regmap, BQ25980_CHRGR_CTRL_2, &chg_ctrl_2);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(bq->regmap, BQ25980_IBAT_ADC_MSB, &ibat_adc_msb);
+	if (ret)
+		return ret;
+
+	state->dischg = ibat_adc_msb & BQ25980_ADC_POLARITY_BIT;
+	state->ovp = (stat1 & BQ25980_STAT1_OVP_MASK) |
+		(stat3 & BQ25980_STAT3_OVP_MASK);
+	state->ocp = (stat1 & BQ25980_STAT1_OCP_MASK) |
+		(stat2 & BQ25980_STAT2_OCP_MASK);
+	state->tflt = stat4 & BQ25980_STAT4_TFLT_MASK;
+	state->wdt = stat4 & BQ25980_WD_STAT;
+	state->online = stat3 & BQ25980_PRESENT_MASK;
+	state->ce = chg_ctrl_2 & BQ25980_CHG_EN;
+	state->hiz = chg_ctrl_2 & BQ25980_EN_HIZ;
+	state->bypass = chg_ctrl_2 & BQ25980_EN_BYPASS;
+
+	return 0;
+}
+
+static int bq25980_set_battery_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				const union power_supply_propval *val)
+{
+	struct bq25980_device *bq = power_supply_get_drvdata(psy);
+	int ret = 0;
+
+	if (ret)
+		return ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		ret = bq25980_set_const_charge_curr(bq, val->intval);
+		if (ret)
+			return ret;
+		break;
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		ret = bq25980_set_const_charge_volt(bq, val->intval);
+		if (ret)
+			return ret;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int bq25980_get_battery_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	struct bq25980_device *bq = power_supply_get_drvdata(psy);
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		val->intval = bq->init_data.ichg_max;
+		break;
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		val->intval = bq->init_data.vreg_max;
+		break;
+
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = bq25980_get_ibat_adc(bq);
+		val->intval = ret;
+		break;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = bq25980_get_adc_vbat(bq);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int bq25980_set_charger_property(struct power_supply *psy,
+		enum power_supply_property prop,
+		const union power_supply_propval *val)
+{
+	struct bq25980_device *bq = power_supply_get_drvdata(psy);
+	int ret = -EINVAL;
+
+	switch (prop) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = bq25980_set_input_curr_lim(bq, val->intval);
+		if (ret)
+			return ret;
+		break;
+
+	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
+		ret = bq25980_set_input_volt_lim(bq, val->intval);
+		if (ret)
+			return ret;
+		break;
+
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		ret = bq25980_set_bypass(bq, val->intval);
+		if (ret)
+			return ret;
+		break;
+
+	case POWER_SUPPLY_PROP_STATUS:
+		ret = bq25980_set_chg_en(bq, val->intval);
+		if (ret)
+			return ret;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int bq25980_get_charger_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	struct bq25980_device *bq = power_supply_get_drvdata(psy);
+	struct bq25980_state state;
+	int ret = 0;
+
+	mutex_lock(&bq->lock);
+	ret = bq25980_get_state(bq, &state);
+	mutex_unlock(&bq->lock);
+	if (ret)
+		return ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = BQ25980_MANUFACTURER;
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = bq->model_name;
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = state.online;
+		break;
+
+	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
+		ret = bq25980_get_input_volt_lim(bq);
+		if (ret < 0)
+			return ret;
+		val->intval = ret;
+		break;
+
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = bq25980_get_input_curr_lim(bq);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+
+	case POWER_SUPPLY_PROP_HEALTH:
+		val->intval = POWER_SUPPLY_HEALTH_GOOD;
+
+		if (state.tflt)
+			val->intval = POWER_SUPPLY_HEALTH_OVERHEAT;
+		else if (state.ovp)
+			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+		else if (state.ocp)
+			val->intval = POWER_SUPPLY_HEALTH_OVERCURRENT;
+		else if (state.wdt)
+			val->intval =
+				POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE;
+		break;
+
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+
+		if ((state.ce) && (!state.hiz))
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (state.dischg)
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else if (!state.ce)
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		val->intval = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+
+		if (!state.ce)
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_NONE;
+		else if (state.bypass)
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_FAST;
+		else if (!state.bypass)
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
+		break;
+
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		ret = bq25980_get_adc_ibus(bq);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = bq25980_get_adc_vbus(bq);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		ret = bq25980_get_const_charge_curr(bq);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		ret = bq25980_get_const_charge_volt(bq);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static bool bq25980_state_changed(struct bq25980_device *bq,
+				  struct bq25980_state *new_state)
+{
+	struct bq25980_state old_state;
+
+	mutex_lock(&bq->lock);
+	old_state = bq->state;
+	mutex_unlock(&bq->lock);
+
+	return (old_state.dischg != new_state->dischg ||
+		old_state.ovp != new_state->ovp ||
+		old_state.ocp != new_state->ocp ||
+		old_state.online != new_state->online ||
+		old_state.wdt != new_state->wdt ||
+		old_state.tflt != new_state->tflt ||
+		old_state.ce != new_state->ce ||
+		old_state.hiz != new_state->hiz ||
+		old_state.bypass != new_state->bypass);
+}
+
+static irqreturn_t bq25980_irq_handler_thread(int irq, void *private)
+{
+	struct bq25980_device *bq = private;
+	struct bq25980_state state;
+	int ret;
+
+	ret = bq25980_get_state(bq, &state);
+	if (ret < 0)
+		goto irq_out;
+
+	if (!bq25980_state_changed(bq, &state))
+		goto irq_out;
+
+	mutex_lock(&bq->lock);
+	bq->state = state;
+	mutex_unlock(&bq->lock);
+
+	power_supply_changed(bq->charger);
+
+irq_out:
+	return IRQ_HANDLED;
+}
+
+static enum power_supply_property bq25980_power_supply_props[] = {
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+};
+
+static enum power_supply_property bq25980_battery_props[] = {
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+};
+
+static char *bq25980_charger_supplied_to[] = {
+	"main-battery",
+};
+
+static int bq25980_property_is_writeable(struct power_supply *psy,
+					 enum power_supply_property prop)
+{
+	switch (prop) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+	case POWER_SUPPLY_PROP_STATUS:
+	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct power_supply_desc bq25980_power_supply_desc = {
+	.name = "bq25980-charger",
+	.type = POWER_SUPPLY_TYPE_MAINS,
+	.properties = bq25980_power_supply_props,
+	.num_properties = ARRAY_SIZE(bq25980_power_supply_props),
+	.get_property = bq25980_get_charger_property,
+	.set_property = bq25980_set_charger_property,
+	.property_is_writeable = bq25980_property_is_writeable,
+};
+
+static struct power_supply_desc bq25980_battery_desc = {
+	.name			= "bq25980-battery",
+	.type			= POWER_SUPPLY_TYPE_BATTERY,
+	.get_property		= bq25980_get_battery_property,
+	.set_property		= bq25980_set_battery_property,
+	.properties		= bq25980_battery_props,
+	.num_properties		= ARRAY_SIZE(bq25980_battery_props),
+	.property_is_writeable	= bq25980_property_is_writeable,
+};
+
+
+static bool bq25980_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BQ25980_CHRGR_CTRL_2:
+	case BQ25980_STAT1...BQ25980_FLAG5:
+	case BQ25980_ADC_CONTROL1...BQ25980_TDIE_ADC_LSB:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config bq25980_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = BQ25980_CHRGR_CTRL_6,
+	.reg_defaults	= bq25980_reg_defs,
+	.num_reg_defaults = ARRAY_SIZE(bq25980_reg_defs),
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_reg = bq25980_is_volatile_reg,
+};
+
+static const struct regmap_config bq25975_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = BQ25980_CHRGR_CTRL_6,
+	.reg_defaults	= bq25975_reg_defs,
+	.num_reg_defaults = ARRAY_SIZE(bq25975_reg_defs),
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_reg = bq25980_is_volatile_reg,
+};
+
+static const struct regmap_config bq25960_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = BQ25980_CHRGR_CTRL_6,
+	.reg_defaults	= bq25960_reg_defs,
+	.num_reg_defaults = ARRAY_SIZE(bq25960_reg_defs),
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_reg = bq25980_is_volatile_reg,
+};
+
+static const struct bq25980_chip_info bq25980_chip_info_tbl[] = {
+	[BQ25980] = {
+		.model_id = BQ25980,
+		.regmap_config = &bq25980_regmap_config,
+
+		.busocp_def = BQ25980_BUSOCP_DFLT_uA,
+		.busocp_sc_min = BQ25960_BUSOCP_SC_MAX_uA,
+		.busocp_sc_max = BQ25980_BUSOCP_SC_MAX_uA,
+		.busocp_byp_max = BQ25980_BUSOCP_BYP_MAX_uA,
+		.busocp_byp_min = BQ25980_BUSOCP_MIN_uA,
+
+		.busovp_sc_def = BQ25980_BUSOVP_DFLT_uV,
+		.busovp_byp_def = BQ25980_BUSOVP_BYPASS_DFLT_uV,
+		.busovp_sc_step = BQ25980_BUSOVP_SC_STEP_uV,
+		.busovp_sc_offset = BQ25980_BUSOVP_SC_OFFSET_uV,
+		.busovp_byp_step = BQ25980_BUSOVP_BYP_STEP_uV,
+		.busovp_byp_offset = BQ25980_BUSOVP_BYP_OFFSET_uV,
+		.busovp_sc_min = BQ25980_BUSOVP_SC_MIN_uV,
+		.busovp_sc_max = BQ25980_BUSOVP_SC_MAX_uV,
+		.busovp_byp_min = BQ25980_BUSOVP_BYP_MIN_uV,
+		.busovp_byp_max = BQ25980_BUSOVP_BYP_MAX_uV,
+
+		.batovp_def = BQ25980_BATOVP_DFLT_uV,
+		.batovp_max = BQ25980_BATOVP_MAX_uV,
+		.batovp_min = BQ25980_BATOVP_MIN_uV,
+		.batovp_step = BQ25980_BATOVP_STEP_uV,
+		.batovp_offset = BQ25980_BATOVP_OFFSET_uV,
+
+		.batocp_def = BQ25980_BATOCP_DFLT_uA,
+		.batocp_max = BQ25980_BATOCP_MAX_uA,
+	},
+
+	[BQ25975] = {
+		.model_id = BQ25975,
+		.regmap_config = &bq25975_regmap_config,
+
+		.busocp_def = BQ25975_BUSOCP_DFLT_uA,
+		.busocp_sc_min = BQ25975_BUSOCP_SC_MAX_uA,
+		.busocp_sc_max = BQ25975_BUSOCP_SC_MAX_uA,
+		.busocp_byp_min = BQ25980_BUSOCP_MIN_uA,
+		.busocp_byp_max = BQ25975_BUSOCP_BYP_MAX_uA,
+
+		.busovp_sc_def = BQ25975_BUSOVP_DFLT_uV,
+		.busovp_byp_def = BQ25975_BUSOVP_BYPASS_DFLT_uV,
+		.busovp_sc_step = BQ25975_BUSOVP_SC_STEP_uV,
+		.busovp_sc_offset = BQ25975_BUSOVP_SC_OFFSET_uV,
+		.busovp_byp_step = BQ25975_BUSOVP_BYP_STEP_uV,
+		.busovp_byp_offset = BQ25975_BUSOVP_BYP_OFFSET_uV,
+		.busovp_sc_min = BQ25975_BUSOVP_SC_MIN_uV,
+		.busovp_sc_max = BQ25975_BUSOVP_SC_MAX_uV,
+		.busovp_byp_min = BQ25975_BUSOVP_BYP_MIN_uV,
+		.busovp_byp_max = BQ25975_BUSOVP_BYP_MAX_uV,
+
+		.batovp_def = BQ25975_BATOVP_DFLT_uV,
+		.batovp_max = BQ25975_BATOVP_MAX_uV,
+		.batovp_min = BQ25975_BATOVP_MIN_uV,
+		.batovp_step = BQ25975_BATOVP_STEP_uV,
+		.batovp_offset = BQ25975_BATOVP_OFFSET_uV,
+
+		.batocp_def = BQ25980_BATOCP_DFLT_uA,
+		.batocp_max = BQ25980_BATOCP_MAX_uA,
+	},
+
+	[BQ25960] = {
+		.model_id = BQ25960,
+		.regmap_config = &bq25960_regmap_config,
+
+		.busocp_def = BQ25960_BUSOCP_DFLT_uA,
+		.busocp_sc_min = BQ25960_BUSOCP_SC_MAX_uA,
+		.busocp_sc_max = BQ25960_BUSOCP_SC_MAX_uA,
+		.busocp_byp_min = BQ25960_BUSOCP_SC_MAX_uA,
+		.busocp_byp_max = BQ25960_BUSOCP_BYP_MAX_uA,
+
+		.busovp_sc_def = BQ25975_BUSOVP_DFLT_uV,
+		.busovp_byp_def = BQ25975_BUSOVP_BYPASS_DFLT_uV,
+		.busovp_sc_step = BQ25960_BUSOVP_SC_STEP_uV,
+		.busovp_sc_offset = BQ25960_BUSOVP_SC_OFFSET_uV,
+		.busovp_byp_step = BQ25960_BUSOVP_BYP_STEP_uV,
+		.busovp_byp_offset = BQ25960_BUSOVP_BYP_OFFSET_uV,
+		.busovp_sc_min = BQ25960_BUSOVP_SC_MIN_uV,
+		.busovp_sc_max = BQ25960_BUSOVP_SC_MAX_uV,
+		.busovp_byp_min = BQ25960_BUSOVP_BYP_MIN_uV,
+		.busovp_byp_max = BQ25960_BUSOVP_BYP_MAX_uV,
+
+		.batovp_def = BQ25960_BATOVP_DFLT_uV,
+		.batovp_max = BQ25960_BATOVP_MAX_uV,
+		.batovp_min = BQ25960_BATOVP_MIN_uV,
+		.batovp_step = BQ25960_BATOVP_STEP_uV,
+		.batovp_offset = BQ25960_BATOVP_OFFSET_uV,
+
+		.batocp_def = BQ25960_BATOCP_DFLT_uA,
+		.batocp_max = BQ25960_BATOCP_MAX_uA,
+	},
+};
+
+static int bq25980_power_supply_init(struct bq25980_device *bq,
+							struct device *dev)
+{
+	struct power_supply_config psy_cfg = { .drv_data = bq,
+						.of_node = dev->of_node, };
+
+	psy_cfg.supplied_to = bq25980_charger_supplied_to;
+	psy_cfg.num_supplicants = ARRAY_SIZE(bq25980_charger_supplied_to);
+
+	bq->charger = devm_power_supply_register(bq->dev,
+						 &bq25980_power_supply_desc,
+						 &psy_cfg);
+	if (IS_ERR(bq->charger))
+		return -EINVAL;
+
+	bq->battery = devm_power_supply_register(bq->dev,
+						      &bq25980_battery_desc,
+						      &psy_cfg);
+	if (IS_ERR(bq->battery))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int bq25980_hw_init(struct bq25980_device *bq)
+{
+	struct power_supply_battery_info bat_info = { };
+	int wd_reg_val;
+	int ret = 0;
+	int curr_val;
+	int volt_val;
+	int i;
+
+	if (!bq->watchdog_timer) {
+		ret = regmap_update_bits(bq->regmap, BQ25980_CHRGR_CTRL_3,
+					 BQ25980_WATCHDOG_DIS,
+					 BQ25980_WATCHDOG_DIS);
+	} else {
+		for (i = 0; i < BQ25980_NUM_WD_VAL; i++) {
+			if (bq->watchdog_timer > bq25980_watchdog_time[i] &&
+			    bq->watchdog_timer < bq25980_watchdog_time[i + 1]) {
+				wd_reg_val = i;
+				break;
+			}
+		}
+
+		ret = regmap_update_bits(bq->regmap, BQ25980_CHRGR_CTRL_3,
+					BQ25980_WATCHDOG_MASK, wd_reg_val);
+	}
+	if (ret)
+		return ret;
+
+	ret = power_supply_get_battery_info(bq->charger, &bat_info);
+	if (ret) {
+		dev_warn(bq->dev, "battery info missing\n");
+		return -EINVAL;
+	}
+
+	bq->init_data.ichg_max = bat_info.constant_charge_current_max_ua;
+	bq->init_data.vreg_max = bat_info.constant_charge_voltage_max_uv;
+
+	if (bq->state.bypass) {
+		ret = regmap_update_bits(bq->regmap, BQ25980_CHRGR_CTRL_2,
+					BQ25980_EN_BYPASS, BQ25980_EN_BYPASS);
+		if (ret)
+			return ret;
+
+		curr_val = bq->init_data.bypass_ilim;
+		volt_val = bq->init_data.bypass_vlim;
+	} else {
+		curr_val = bq->init_data.sc_ilim;
+		volt_val = bq->init_data.sc_vlim;
+	}
+
+	ret = bq25980_set_input_curr_lim(bq, curr_val);
+	if (ret)
+		return ret;
+
+	ret = bq25980_set_input_volt_lim(bq, volt_val);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(bq->regmap, BQ25980_ADC_CONTROL1,
+				 BQ25980_ADC_EN, BQ25980_ADC_EN);
+}
+
+static int bq25980_parse_dt(struct bq25980_device *bq)
+{
+	int ret;
+
+	ret = device_property_read_u32(bq->dev, "ti,watchdog-timeout-ms",
+				       &bq->watchdog_timer);
+	if (ret)
+		bq->watchdog_timer = BQ25980_WATCHDOG_MIN;
+
+	if (bq->watchdog_timer > BQ25980_WATCHDOG_MAX ||
+	    bq->watchdog_timer < BQ25980_WATCHDOG_MIN)
+		return -EINVAL;
+
+	ret = device_property_read_u32(bq->dev,
+				       "ti,sc-ovp-limit-microvolt",
+				       &bq->init_data.sc_vlim);
+	if (ret)
+		bq->init_data.sc_vlim = bq->chip_info->busovp_sc_def;
+
+	if (bq->init_data.sc_vlim > bq->chip_info->busovp_sc_max ||
+	    bq->init_data.sc_vlim < bq->chip_info->busovp_sc_min) {
+		dev_err(bq->dev, "SC ovp limit is out of range\n");
+		return -EINVAL;
+	}
+
+	ret = device_property_read_u32(bq->dev,
+				       "ti,sc-ocp-limit-microamp",
+				       &bq->init_data.sc_ilim);
+	if (ret)
+		bq->init_data.sc_ilim = bq->chip_info->busocp_def;
+
+	if (bq->init_data.sc_ilim > bq->chip_info->busocp_sc_max ||
+	    bq->init_data.sc_ilim < bq->chip_info->busocp_sc_min) {
+		dev_err(bq->dev, "SC ocp limit is out of range\n");
+		return -EINVAL;
+	}
+
+	ret = device_property_read_u32(bq->dev,
+				       "ti,bypass-ovp-limit-microvolt",
+				       &bq->init_data.bypass_vlim);
+	if (ret)
+		bq->init_data.bypass_vlim = bq->chip_info->busovp_byp_def;
+
+	if (bq->init_data.bypass_vlim > bq->chip_info->busovp_byp_max ||
+	    bq->init_data.bypass_vlim < bq->chip_info->busovp_byp_min) {
+		dev_err(bq->dev, "Bypass ovp limit is out of range\n");
+		return -EINVAL;
+	}
+
+	ret = device_property_read_u32(bq->dev,
+				       "ti,bypass-ocp-limit-microamp",
+				       &bq->init_data.bypass_ilim);
+	if (ret)
+		bq->init_data.bypass_ilim = bq->chip_info->busocp_def;
+
+	if (bq->init_data.bypass_ilim > bq->chip_info->busocp_byp_max ||
+	    bq->init_data.bypass_ilim < bq->chip_info->busocp_byp_min) {
+		dev_err(bq->dev, "Bypass ocp limit is out of range\n");
+		return -EINVAL;
+	}
+
+
+	bq->state.bypass = device_property_read_bool(bq->dev,
+						      "ti,bypass-enable");
+	return 0;
+}
+
+static int bq25980_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct bq25980_device *bq;
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
+	strncpy(bq->model_name, id->name, I2C_NAME_SIZE);
+	bq->chip_info = &bq25980_chip_info_tbl[id->driver_data];
+
+	bq->regmap = devm_regmap_init_i2c(client,
+					  bq->chip_info->regmap_config);
+	if (IS_ERR(bq->regmap)) {
+		dev_err(dev, "Failed to allocate register map\n");
+		return PTR_ERR(bq->regmap);
+	}
+
+	i2c_set_clientdata(client, bq);
+
+	ret = bq25980_parse_dt(bq);
+	if (ret) {
+		dev_err(dev, "Failed to read device tree properties%d\n", ret);
+		return ret;
+	}
+
+	if (client->irq) {
+		ret = devm_request_threaded_irq(dev, client->irq, NULL,
+						bq25980_irq_handler_thread,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						dev_name(&client->dev), bq);
+		if (ret)
+			return ret;
+	}
+
+	ret = bq25980_power_supply_init(bq, dev);
+	if (ret) {
+		dev_err(dev, "Failed to register power supply\n");
+		return ret;
+	}
+
+	ret = bq25980_hw_init(bq);
+	if (ret) {
+		dev_err(dev, "Cannot initialize the chip.\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct i2c_device_id bq25980_i2c_ids[] = {
+	{ "bq25980", BQ25980 },
+	{ "bq25975", BQ25975 },
+	{ "bq25975", BQ25975 },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, bq25980_i2c_ids);
+
+static const struct of_device_id bq25980_of_match[] = {
+	{ .compatible = "ti,bq25980", .data = (void *)BQ25980 },
+	{ .compatible = "ti,bq25975", .data = (void *)BQ25975 },
+	{ .compatible = "ti,bq25960", .data = (void *)BQ25960 },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, bq25980_of_match);
+
+static struct i2c_driver bq25980_driver = {
+	.driver = {
+		.name = "bq25980-charger",
+		.of_match_table = bq25980_of_match,
+	},
+	.probe = bq25980_probe,
+	.id_table = bq25980_i2c_ids,
+};
+module_i2c_driver(bq25980_driver);
+
+MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
+MODULE_AUTHOR("Ricardo Rivera-Matos <r-rivera-matos@ti.com>");
+MODULE_DESCRIPTION("bq25980 charger driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/power/supply/bq25980_charger.h b/drivers/power/supply/bq25980_charger.h
new file mode 100644
index 000000000000..39f94eba5f6c
--- /dev/null
+++ b/drivers/power/supply/bq25980_charger.h
@@ -0,0 +1,178 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/ */
+
+#ifndef BQ25980_CHARGER_H
+#define BQ25980_CHARGER_H
+
+#define BQ25980_MANUFACTURER "Texas Instruments"
+
+#define BQ25980_BATOVP			0x0
+#define BQ25980_BATOVP_ALM		0x1
+#define BQ25980_BATOCP			0x2
+#define BQ25980_BATOCP_ALM		0x3
+#define BQ25980_BATUCP_ALM		0x4
+#define BQ25980_CHRGR_CTRL_1	0x5
+#define BQ25980_BUSOVP			0x6
+#define BQ25980_BUSOVP_ALM		0x7
+#define BQ25980_BUSOCP			0x8
+#define BQ25980_BUSOCP_ALM		0x9
+#define BQ25980_TEMP_CONTROL		0xA
+#define BQ25980_TDIE_ALM		0xB
+#define BQ25980_TSBUS_FLT		0xC
+#define BQ25980_TSBAT_FLG		0xD
+#define BQ25980_VAC_CONTROL		0xE
+#define BQ25980_CHRGR_CTRL_2	0xF
+#define BQ25980_CHRGR_CTRL_3	0x10
+#define BQ25980_CHRGR_CTRL_4	0x11
+#define BQ25980_CHRGR_CTRL_5	0x12
+#define BQ25980_STAT1			0x13
+#define BQ25980_STAT2			0x14
+#define BQ25980_STAT3			0x15
+#define BQ25980_STAT4			0x16
+#define BQ25980_STAT5			0x17
+#define BQ25980_FLAG1			0x18
+#define BQ25980_FLAG2			0x19
+#define BQ25980_FLAG3			0x1A
+#define BQ25980_FLAG4			0x1B
+#define BQ25980_FLAG5			0x1C
+#define BQ25980_MASK1			0x1D
+#define BQ25980_MASK2			0x1E
+#define BQ25980_MASK3			0x1F
+#define BQ25980_MASK4			0x20
+#define BQ25980_MASK5			0x21
+#define BQ25980_DEVICE_INFO		0x22
+#define BQ25980_ADC_CONTROL1		0x23
+#define BQ25980_ADC_CONTROL2		0x24
+#define BQ25980_IBUS_ADC_MSB		0x25
+#define BQ25980_IBUS_ADC_LSB		0x26
+#define BQ25980_VBUS_ADC_MSB		0x27
+#define BQ25980_VBUS_ADC_LSB		0x28
+#define BQ25980_VAC1_ADC_MSB		0x29
+#define BQ25980_VAC1_ADC_LSB		0x2A
+#define BQ25980_VAC2_ADC_MSB		0x2B
+#define BQ25980_VAC2_ADC_LSB		0x2C
+#define BQ25980_VOUT_ADC_MSB		0x2D
+#define BQ25980_VOUT_ADC_LSB		0x2E
+#define BQ25980_VBAT_ADC_MSB		0x2F
+#define BQ25980_VBAT_ADC_LSB		0x30
+#define BQ25980_IBAT_ADC_MSB		0x31
+#define BQ25980_IBAT_ADC_LSB		0x32
+#define BQ25980_TSBUS_ADC_MSB		0x33
+#define BQ25980_TSBUS_ADC_LSB		0x34
+#define BQ25980_TSBAT_ADC_MSB		0x35
+#define BQ25980_TSBAT_ADC_LSB		0x36
+#define BQ25980_TDIE_ADC_MSB		0x37
+#define BQ25980_TDIE_ADC_LSB		0x38
+#define BQ25980_DEGLITCH_TIME		0x39
+#define BQ25980_CHRGR_CTRL_6	0x3A
+
+#define BQ25980_BUSOCP_STEP_uA		250000
+#define BQ25980_BUSOCP_OFFSET_uA	1000000
+
+#define BQ25980_BUSOCP_DFLT_uA		4250000
+#define BQ25975_BUSOCP_DFLT_uA		4250000
+#define BQ25960_BUSOCP_DFLT_uA		3250000
+
+#define BQ25980_BUSOCP_MIN_uA		1000000
+
+#define BQ25980_BUSOCP_SC_MAX_uA	5750000
+#define BQ25975_BUSOCP_SC_MAX_uA	5750000
+#define BQ25960_BUSOCP_SC_MAX_uA	3750000
+
+#define BQ25980_BUSOCP_BYP_MAX_uA	8500000
+#define BQ25975_BUSOCP_BYP_MAX_uA	8500000
+#define BQ25960_BUSOCP_BYP_MAX_uA	5750000
+
+#define BQ25980_BUSOVP_SC_STEP_uV	100000
+#define BQ25975_BUSOVP_SC_STEP_uV	50000
+#define BQ25960_BUSOVP_SC_STEP_uV	50000
+#define BQ25980_BUSOVP_SC_OFFSET_uV	14000000
+#define BQ25975_BUSOVP_SC_OFFSET_uV	7000000
+#define BQ25960_BUSOVP_SC_OFFSET_uV	7000000
+
+#define BQ25980_BUSOVP_BYP_STEP_uV	50000
+#define BQ25975_BUSOVP_BYP_STEP_uV	25000
+#define BQ25960_BUSOVP_BYP_STEP_uV	25000
+#define BQ25980_BUSOVP_BYP_OFFSET_uV	7000000
+#define BQ25975_BUSOVP_BYP_OFFSET_uV	3500000
+#define BQ25960_BUSOVP_BYP_OFFSET_uV	3500000
+
+#define BQ25980_BUSOVP_DFLT_uV		17800000
+#define BQ25980_BUSOVP_BYPASS_DFLT_uV	8900000
+#define BQ25975_BUSOVP_DFLT_uV		8900000
+#define BQ25975_BUSOVP_BYPASS_DFLT_uV	4450000
+#define BQ25960_BUSOVP_DFLT_uV		8900000
+
+#define BQ25980_BUSOVP_SC_MIN_uV	14000000
+#define BQ25975_BUSOVP_SC_MIN_uV	7000000
+#define BQ25960_BUSOVP_SC_MIN_uV	7000000
+#define BQ25980_BUSOVP_BYP_MIN_uV	7000000
+#define BQ25975_BUSOVP_BYP_MIN_uV	3500000
+#define BQ25960_BUSOVP_BYP_MIN_uV	3500000
+
+#define BQ25980_BUSOVP_SC_MAX_uV	22000000
+#define BQ25975_BUSOVP_SC_MAX_uV	12750000
+#define BQ25960_BUSOVP_SC_MAX_uV	12750000
+
+#define BQ25980_BUSOVP_BYP_MAX_uV	12750000
+#define BQ25975_BUSOVP_BYP_MAX_uV	6500000
+#define BQ25960_BUSOVP_BYP_MAX_uV	6500000
+
+#define BQ25980_BATOVP_STEP_uV		20000
+#define BQ25975_BATOVP_STEP_uV		10000
+#define BQ25960_BATOVP_STEP_uV		10000
+
+#define BQ25980_BATOVP_OFFSET_uV	7000000
+#define BQ25975_BATOVP_OFFSET_uV	3500000
+#define BQ25960_BATOVP_OFFSET_uV	3500000
+
+#define BQ25980_BATOVP_DFLT_uV		14000000
+#define BQ25975_BATOVP_DFLT_uV		8900000
+#define BQ25960_BATOVP_DFLT_uV		8900000
+
+#define BQ25980_BATOVP_MIN_uV		7000000
+#define BQ25975_BATOVP_MIN_uV		3500000
+#define BQ25960_BATOVP_MIN_uV		3500000
+
+#define BQ25980_BATOVP_MAX_uV		9540000
+#define BQ25975_BATOVP_MAX_uV		4770000
+#define BQ25960_BATOVP_MAX_uV		4770000
+
+#define BQ25980_BATOCP_STEP_uA		100000
+
+#define BQ25980_BATOCP_MASK		GENMASK(6, 0)
+
+#define BQ25980_BATOCP_DFLT_uA		8100000
+#define BQ25960_BATOCP_DFLT_uA		6100000
+
+#define BQ25980_BATOCP_MIN_uA		2000000
+
+#define BQ25980_BATOCP_MAX_uA		11000000
+#define BQ25975_BATOCP_MAX_uA		11000000
+#define BQ25960_BATOCP_MAX_uA		7000000
+
+#define BQ25980_ENABLE_HIZ		0xff
+#define BQ25980_DISABLE_HIZ		0x0
+#define BQ25980_EN_BYPASS		BIT(3)
+#define BQ25980_STAT1_OVP_MASK		(BIT(6) | BIT(5) | BIT(0))
+#define BQ25980_STAT3_OVP_MASK		(BIT(7) | BIT(6))
+#define BQ25980_STAT1_OCP_MASK		BIT(3)
+#define BQ25980_STAT2_OCP_MASK		(BIT(6) | BIT(1))
+#define BQ25980_STAT4_TFLT_MASK		GENMASK(5, 1)
+#define BQ25980_WD_STAT			BIT(0)
+#define BQ25980_PRESENT_MASK		GENMASK(4, 2)
+#define BQ25980_CHG_EN			BIT(4)
+#define BQ25980_EN_HIZ			BIT(6)
+#define BQ25980_ADC_EN			BIT(7)
+
+#define BQ25980_ADC_VOLT_STEP_uV        1000
+#define BQ25980_ADC_CURR_STEP_uA        1000
+#define BQ25980_ADC_POLARITY_BIT	BIT(7)
+
+#define BQ25980_WATCHDOG_MASK	GENMASK(4, 3)
+#define BQ25980_WATCHDOG_DIS	BIT(2)
+#define BQ25980_WATCHDOG_MAX	300000
+#define BQ25980_WATCHDOG_MIN	0
+#define BQ25980_NUM_WD_VAL	4
+
+#endif /* BQ25980_CHARGER_H */
-- 
2.28.0

