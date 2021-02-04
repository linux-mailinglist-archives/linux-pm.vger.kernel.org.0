Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBDD30B527
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 03:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhBBCSs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 21:18:48 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44796 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhBBCSm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 21:18:42 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1122Hncd035301;
        Mon, 1 Feb 2021 20:17:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612232269;
        bh=/rKXy8H+CsG2Cum2ctQl8ixGt/vDHklS1MRoHC2ahkg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YwGfZSeG1nSwyay99xSGkvgG6hG2THZAmv78+NmS/r8kpaXjVv577M7lYftWXwkKc
         AGkoDQzlrzLGT6z3of7kPWWMphDbdEQGrihg/hlKMEFDqvA9QMW3xYVXfCKEzbpSpU
         sZ3q5QIYS6PzWmJknzfbq0e72H3GvneP9DD2q6UU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1122Hn9W023552
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Feb 2021 20:17:49 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 1 Feb
 2021 20:17:48 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 1 Feb 2021 20:17:48 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1122HmUw122778;
        Mon, 1 Feb 2021 20:17:48 -0600
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <dmurphy@ti.com>, Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Subject: [PATCH v5 2/2] power: supply: bq25790: Introduce the BQ25790 charger driver
Date:   Mon, 1 Feb 2021 20:17:47 -0600
Message-ID: <20210202021747.717-3-r-rivera-matos@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202021747.717-1-r-rivera-matos@ti.com>
References: <20210202021747.717-1-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Dan Murphy <dmurphy@ti.com>

BQ25790 is a highly integrated switch-mode buck-boost charger
for 1-4 cell Li-ion battery and Li-polymer battery.

Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/power/supply/Kconfig           |    8 +
 drivers/power/supply/Makefile          |    1 +
 drivers/power/supply/bq25790_charger.c | 1100 ++++++++++++++++++++++++
 drivers/power/supply/bq25790_charger.h |  148 ++++
 4 files changed, 1257 insertions(+)
 create mode 100644 drivers/power/supply/bq25790_charger.c
 create mode 100644 drivers/power/supply/bq25790_charger.h

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 006b95eca673..d0ecbe76b720 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -638,6 +638,14 @@ config CHARGER_BQ2515X
 	  rail, ADC for battery and system monitoring, and push-button
 	  controller.
 
+config CHARGER_BQ25790
+	tristate "TI BQ25790 battery charger driver"
+	depends on I2C
+	depends on GPIOLIB || COMPILE_TEST
+	select REGMAP_I2C
+	help
+	  Say Y to enable support for the TI BQ25790 battery charger.
+
 config CHARGER_BQ25890
 	tristate "TI BQ25890 battery charger driver"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 5e5fdbbef531..fa18d4fa9e6a 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_CHARGER_BQ24190)	+= bq24190_charger.o
 obj-$(CONFIG_CHARGER_BQ24257)	+= bq24257_charger.o
 obj-$(CONFIG_CHARGER_BQ24735)	+= bq24735-charger.o
 obj-$(CONFIG_CHARGER_BQ2515X)	+= bq2515x_charger.o
+obj-$(CONFIG_CHARGER_BQ25790)	+= bq25790_charger.o
 obj-$(CONFIG_CHARGER_BQ25890)	+= bq25890_charger.o
 obj-$(CONFIG_CHARGER_BQ25980)	+= bq25980_charger.o
 obj-$(CONFIG_CHARGER_BQ256XX)	+= bq256xx_charger.o
diff --git a/drivers/power/supply/bq25790_charger.c b/drivers/power/supply/bq25790_charger.c
new file mode 100644
index 000000000000..2a2305b985df
--- /dev/null
+++ b/drivers/power/supply/bq25790_charger.c
@@ -0,0 +1,1100 @@
+// SPDX-License-Identifier: GPL-2.0
+// BQ25790 driver
+// Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/usb/phy.h>
+
+#include <linux/acpi.h>
+#include <linux/of.h>
+
+#include "bq25790_charger.h"
+
+#define BQ25790_NUM_WD_VAL	8
+
+struct bq25790_init_data {
+	u32 ichg;
+	u32 ilim;
+	u32 vreg;
+	u32 iterm;
+	u32 iprechg;
+	u32 vlim;
+	u32 ichg_max;
+	u32 vreg_max;
+};
+
+struct bq25790_state {
+	bool online;
+	u8 chrg_status;
+	u8 chrg_type;
+	u8 health;
+	u8 chrg_fault;
+	u8 vsys_status;
+	u8 vbus_status;
+	u8 fault_0;
+	u8 fault_1;
+	u32 vbat_adc;
+	u32 vbus_adc;
+	u32 ibat_adc;
+};
+
+enum bq25790_id {
+	BQ25790,
+	BQ25792,
+};
+
+struct bq25790_device {
+	struct i2c_client *client;
+	struct device *dev;
+	struct power_supply *charger;
+	struct power_supply *battery;
+	struct mutex lock;
+
+	struct usb_phy *usb2_phy;
+	struct usb_phy *usb3_phy;
+	struct notifier_block usb_nb;
+	struct work_struct usb_work;
+	unsigned long usb_event;
+	struct regmap *regmap;
+
+	char model_name[I2C_NAME_SIZE];
+	int device_id;
+
+	struct bq25790_init_data init_data;
+	struct bq25790_state state;
+	int watchdog_timer;
+};
+
+static struct reg_default bq25790_reg_defs[] = {
+	{BQ25790_INPUT_V_LIM, 0x24},
+	{BQ25790_INPUT_I_LIM_MSB, 0x01},
+	{BQ25790_INPUT_I_LIM_LSB, 0x2c},
+	{BQ25790_PRECHRG_CTRL, 0xc3},
+	{BQ25790_TERM_CTRL, 0x5},
+	{BQ25790_VOTG_REG, 0xdc},
+	{BQ25790_IOTG_REG, 0x4b},
+	{BQ25790_TIMER_CTRL, 0x3d},
+	{BQ25790_CHRG_CTRL_0, 0xa2},
+	{BQ25790_CHRG_CTRL_1, 0x85},
+	{BQ25790_CHRG_CTRL_2, 0x40},
+	{BQ25790_CHRG_CTRL_3, 0x12},
+	{BQ25790_CHRG_CTRL_5, 0x16},
+	{BQ25790_MPPT_CTRL, 0xaa},
+	{BQ25790_TEMP_CTRL, 0xc0},
+	{BQ25790_NTC_CTRL_0, 0x7a},
+	{BQ25790_NTC_CTRL_1, 0x54},
+	{BQ25790_ICO_I_LIM, 0x0},
+	{BQ25790_CHRG_STAT_0, 0x0},
+	{BQ25790_CHRG_STAT_1, 0x0},
+	{BQ25790_CHRG_STAT_2, 0x0},
+	{BQ25790_CHRG_STAT_3, 0x0},
+	{BQ25790_CHRG_STAT_4, 0x0},
+	{BQ25790_FAULT_STAT_0, 0x0},
+	{BQ25790_FAULT_STAT_1, 0x0},
+	{BQ25790_CHRG_FLAG_0, 0x0},
+	{BQ25790_CHRG_FLAG_1, 0x0},
+	{BQ25790_CHRG_FLAG_2, 0x0},
+	{BQ25790_CHRG_FLAG_3, 0x0},
+	{BQ25790_FAULT_FLAG_0, 0x0},
+	{BQ25790_FAULT_FLAG_1, 0x0},
+	{BQ25790_CHRG_MSK_0, 0x0},
+	{BQ25790_CHRG_MSK_1, 0x0},
+	{BQ25790_CHRG_MSK_2, 0x0},
+	{BQ25790_CHRG_MSK_3, 0x0},
+	{BQ25790_FAULT_MSK_0, 0x0},
+	{BQ25790_FAULT_MSK_1, 0x0},
+	{BQ25790_ADC_CTRL, 0x30},
+	{BQ25790_FN_DISABE_0, 0x0},
+	{BQ25790_FN_DISABE_1, 0x0},
+	{BQ25790_ADC_IBUS, 0x0},
+	{BQ25790_ADC_IBAT_MSB, 0x0},
+	{BQ25790_ADC_IBAT_LSB, 0x0},
+	{BQ25790_ADC_VBUS_MSB, 0x0},
+	{BQ25790_ADC_VBUS_LSB, 0x0},
+	{BQ25790_ADC_VAC1, 0x0},
+	{BQ25790_ADC_VAC2, 0x0},
+	{BQ25790_ADC_VBAT_MSB, 0x0},
+	{BQ25790_ADC_VBAT_LSB, 0x0},
+	{BQ25790_ADC_VBUS_MSB, 0x0},
+	{BQ25790_ADC_VBUS_LSB, 0x0},
+	{BQ25790_ADC_TS, 0x0},
+	{BQ25790_ADC_TDIE, 0x0},
+	{BQ25790_ADC_DP, 0x0},
+	{BQ25790_ADC_DM, 0x0},
+	{BQ25790_DPDM_DRV, 0x0},
+	{BQ25790_PART_INFO, 0x0},
+};
+
+static int bq25790_watchdog_time[BQ25790_NUM_WD_VAL] = {0, 500, 1000, 2000,
+							20000, 40000, 80000,
+							160000};
+
+static enum power_supply_usb_type bq25790_usb_type[] = {
+	POWER_SUPPLY_USB_TYPE_ACA,
+	POWER_SUPPLY_USB_TYPE_SDP,
+	POWER_SUPPLY_USB_TYPE_CDP,
+	POWER_SUPPLY_USB_TYPE_DCP,
+	POWER_SUPPLY_USB_TYPE_UNKNOWN,
+};
+
+static int bq25790_usb_notifier(struct notifier_block *nb, unsigned long val,
+				void *priv)
+{
+	struct bq25790_device *bq =
+			container_of(nb, struct bq25790_device, usb_nb);
+
+	bq->usb_event = val;
+	queue_work(system_power_efficient_wq, &bq->usb_work);
+
+	return NOTIFY_OK;
+}
+
+static void bq25790_usb_work(struct work_struct *data)
+{
+	struct bq25790_device *bq =
+			container_of(data, struct bq25790_device, usb_work);
+
+	switch (bq->usb_event) {
+	case USB_EVENT_ID:
+		break;
+
+	case USB_EVENT_NONE:
+		power_supply_changed(bq->charger);
+		break;
+	}
+}
+
+static int bq25790_get_vbat_adc(struct bq25790_device *bq)
+{
+	int ret;
+	int vbat_adc_lsb, vbat_adc_msb;
+	u16 vbat_adc;
+
+	ret = regmap_read(bq->regmap, BQ25790_ADC_VBAT_MSB, &vbat_adc_msb);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(bq->regmap, BQ25790_ADC_VBAT_LSB, &vbat_adc_lsb);
+	if (ret)
+		return ret;
+
+	vbat_adc = (vbat_adc_msb << 8) | vbat_adc_lsb;
+
+	return vbat_adc * BQ25790_ADC_VOLT_STEP_uV;
+}
+
+static int bq25790_get_vbus_adc(struct bq25790_device *bq)
+{
+	int ret;
+	int vbus_adc_lsb, vbus_adc_msb;
+	u16 vbus_adc;
+
+	ret = regmap_read(bq->regmap, BQ25790_ADC_VBUS_MSB, &vbus_adc_msb);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(bq->regmap, BQ25790_ADC_VBUS_LSB, &vbus_adc_lsb);
+	if (ret)
+		return ret;
+
+	vbus_adc = (vbus_adc_msb << 8) | vbus_adc_lsb;
+
+	return vbus_adc * BQ25790_ADC_VOLT_STEP_uV;
+}
+
+static int bq25790_get_ibat_adc(struct bq25790_device *bq)
+{
+	int ret;
+	int ibat_adc_lsb, ibat_adc_msb;
+	u16 ibat_adc;
+
+	ret = regmap_read(bq->regmap, BQ25790_ADC_IBAT_MSB, &ibat_adc_msb);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(bq->regmap, BQ25790_ADC_IBAT_LSB, &ibat_adc_lsb);
+	if (ret)
+		return ret;
+
+	ibat_adc = (ibat_adc_msb << 8) | ibat_adc_lsb;
+
+	return ibat_adc * BQ25790_ADC_CURR_STEP_uA;
+}
+
+static int bq25790_get_term_curr(struct bq25790_device *bq)
+{
+	int ret;
+	int reg_val;
+
+	ret = regmap_read(bq->regmap, BQ25790_TERM_CTRL, &reg_val);
+	if (ret)
+		return ret;
+
+	reg_val &= BQ25790_TERMCHRG_CUR_MASK;
+
+	return reg_val * BQ25790_TERMCHRG_CURRENT_STEP_uA;
+}
+
+static int bq25790_get_prechrg_curr(struct bq25790_device *bq)
+{
+	int ret;
+	int reg_val;
+
+	ret = regmap_read(bq->regmap, BQ25790_PRECHRG_CTRL, &reg_val);
+	if (ret)
+		return ret;
+
+	reg_val &= BQ25790_PRECHRG_CUR_MASK;
+
+	return reg_val * BQ25790_PRECHRG_CURRENT_STEP_uA;
+}
+
+static int bq25790_get_ichg_curr(struct bq25790_device *bq)
+{
+	int ret;
+	int ichg, ichg_lsb, ichg_msb;
+
+	ret = regmap_read(bq->regmap, BQ25790_CHRG_I_LIM_LSB, &ichg_lsb);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(bq->regmap, BQ25790_CHRG_I_LIM_MSB, &ichg_msb);
+	if (ret)
+		return ret;
+
+	ichg = (ichg_msb << 8) | ichg_lsb;
+
+	return ichg * BQ25790_ICHRG_CURRENT_STEP_uA;
+}
+
+static int bq25790_set_term_curr(struct bq25790_device *bq, int term_current)
+{
+	int reg_val;
+
+	term_current = clamp(term_current, BQ25790_TERMCHRG_I_MIN_uA,
+					BQ25790_TERMCHRG_I_MAX_uA);
+
+	reg_val = term_current / BQ25790_TERMCHRG_CURRENT_STEP_uA;
+
+	return regmap_update_bits(bq->regmap, BQ25790_TERM_CTRL,
+				  BQ25790_TERMCHRG_CUR_MASK, reg_val);
+}
+
+static int bq25790_set_prechrg_curr(struct bq25790_device *bq, int pre_current)
+{
+	int reg_val;
+
+	pre_current = clamp(pre_current, BQ25790_PRECHRG_I_MIN_uA,
+					BQ25790_PRECHRG_I_MAX_uA);
+
+	reg_val = pre_current / BQ25790_PRECHRG_CURRENT_STEP_uA;
+
+	return regmap_update_bits(bq->regmap, BQ25790_PRECHRG_CTRL,
+				  BQ25790_PRECHRG_CUR_MASK, reg_val);
+}
+
+static int bq25790_set_ichrg_curr(struct bq25790_device *bq, int chrg_curr)
+{
+	int chrg_curr_max = bq->init_data.ichg_max;
+	int ichg, ichg_msb, ichg_lsb;
+	int ret;
+
+	chrg_curr = clamp(chrg_curr, BQ25790_ICHRG_I_MIN_uA,
+					chrg_curr_max);
+
+	ichg = chrg_curr / BQ25790_ICHRG_CURRENT_STEP_uA;
+	ichg_msb = (ichg >> 8) & 0xff;
+	ret = regmap_write(bq->regmap, BQ25790_CHRG_I_LIM_MSB, ichg_msb);
+	if (ret)
+		return ret;
+
+	ichg_lsb = ichg & 0xff;
+
+	return regmap_write(bq->regmap, BQ25790_CHRG_I_LIM_LSB, ichg_lsb);
+}
+
+static int bq25790_set_chrg_volt(struct bq25790_device *bq, int chrg_volt)
+{
+	int chrg_volt_max = bq->init_data.vreg_max;
+	int vlim_lsb, vlim_msb, vlim;
+	int ret;
+
+	chrg_volt = clamp(chrg_volt, BQ25790_VREG_V_MIN_uV, chrg_volt_max);
+
+	vlim = chrg_volt / BQ25790_VREG_V_STEP_uV;
+	vlim_msb = (vlim >> 8) & 0xff;
+	ret = regmap_write(bq->regmap, BQ25790_CHRG_V_LIM_MSB, vlim_msb);
+	if (ret)
+		return ret;
+
+	vlim_lsb = vlim & 0xff;
+
+	return regmap_write(bq->regmap, BQ25790_CHRG_V_LIM_LSB, vlim_lsb);
+}
+
+static int bq25790_get_chrg_volt(struct bq25790_device *bq)
+{
+	int ret;
+	int vlim_lsb, vlim_msb, chrg_volt;
+
+	ret = regmap_read(bq->regmap, BQ25790_CHRG_V_LIM_MSB, &vlim_msb);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(bq->regmap, BQ25790_CHRG_V_LIM_LSB, &vlim_lsb);
+	if (ret)
+		return ret;
+
+	chrg_volt = (vlim_msb << 8) | vlim_lsb;
+
+	return chrg_volt * BQ25790_VREG_V_STEP_uV;
+}
+
+static int bq25790_set_input_volt_lim(struct bq25790_device *bq, int vindpm)
+{
+	int ret;
+	int vlim_lsb, vlim_msb;
+	int vlim;
+
+	vindpm = clamp(vindpm, BQ25790_VINDPM_V_MIN_uV,
+						BQ25790_VINDPM_V_MAX_uV);
+
+	vlim = vindpm / BQ25790_VINDPM_STEP_uV;
+
+	vlim_msb = (vlim >> 8) & 0xff;
+
+	ret = regmap_write(bq->regmap, BQ25790_CHRG_V_LIM_MSB, vlim_msb);
+	if (ret)
+		return ret;
+
+	vlim_lsb = vlim & 0xff;
+
+	return regmap_write(bq->regmap, BQ25790_CHRG_V_LIM_LSB, vlim_lsb);
+}
+
+static int bq25790_get_input_volt_lim(struct bq25790_device *bq)
+{
+	int ret;
+	int vlim;
+
+	ret = regmap_read(bq->regmap, BQ25790_INPUT_V_LIM, &vlim);
+	if (ret)
+		return ret;
+
+	return vlim * BQ25790_VINDPM_STEP_uV;
+}
+
+static int bq25790_set_input_curr_lim(struct bq25790_device *bq, int iindpm)
+{
+	int ret;
+	int ilim, ilim_lsb, ilim_msb;
+
+	iindpm = clamp(iindpm, BQ25790_IINDPM_I_MIN_uA,
+						BQ25790_IINDPM_I_MAX_uA);
+
+	ilim = iindpm / BQ25790_IINDPM_STEP_uA;
+	ilim_msb = (ilim >> 8) & 0xff;
+
+	ret = regmap_write(bq->regmap, BQ25790_INPUT_I_LIM_MSB, ilim_msb);
+	if (ret)
+		return ret;
+
+	ilim_lsb = ilim & 0xff;
+
+	return regmap_write(bq->regmap, BQ25790_INPUT_I_LIM_LSB, ilim_lsb);
+}
+
+static int bq25790_get_input_curr_lim(struct bq25790_device *bq)
+{
+	int ret;
+	int ilim_msb, ilim_lsb;
+	u16 ilim;
+
+	ret = regmap_read(bq->regmap, BQ25790_INPUT_I_LIM_MSB, &ilim_msb);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(bq->regmap, BQ25790_INPUT_I_LIM_LSB, &ilim_lsb);
+	if (ret)
+		return ret;
+
+	ilim = (ilim_msb << 8) | ilim_lsb;
+
+	return ilim * BQ25790_IINDPM_STEP_uA;
+}
+
+static int bq25790_get_state(struct bq25790_device *bq,
+			     struct bq25790_state *state)
+{
+	int chrg_stat_0, chrg_stat_1, chrg_stat_3, chrg_stat_4;
+	int chrg_ctrl_0, fault_0, fault_1;
+	int ret;
+
+	ret = regmap_update_bits(bq->regmap, BQ25790_ADC_CTRL,
+				 BQ25790_ADC_EN, BQ25790_ADC_EN);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(bq->regmap, BQ25790_CHRG_STAT_0, &chrg_stat_0);
+	if (ret)
+		return ret;
+
+	state->vbus_status = chrg_stat_0 & BQ25790_VBUS_PRESENT;
+
+	ret = regmap_read(bq->regmap, BQ25790_CHRG_STAT_1, &chrg_stat_1);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(bq->regmap, BQ25790_CHRG_CTRL_0, &chrg_ctrl_0);
+	if (ret)
+		return ret;
+
+	if (chrg_ctrl_0 & BQ25790_CHRG_EN)
+		state->chrg_status = chrg_stat_1 & BQ25790_CHG_STAT_MSK;
+	else
+		state->chrg_status = BQ25790_NOT_CHRGING;
+
+	state->chrg_type = chrg_stat_1 & BQ25790_VBUS_STAT_MSK;
+
+	ret = regmap_read(bq->regmap, BQ25790_CHRG_STAT_4, &chrg_stat_4);
+	if (ret)
+		return ret;
+
+	state->health = chrg_stat_4 & BQ25790_TEMP_MASK;
+
+	ret = regmap_read(bq->regmap, BQ25790_FAULT_STAT_0, &fault_0);
+	if (ret)
+		return ret;
+
+	state->fault_0 = fault_0;
+
+	ret = regmap_read(bq->regmap, BQ25790_FAULT_STAT_1, &fault_1);
+	if (ret)
+		return ret;
+
+	state->fault_1 = fault_1;
+
+	ret = regmap_read(bq->regmap, BQ25790_CHRG_STAT_3, &chrg_stat_3);
+	if (ret)
+		return ret;
+
+	state->online = chrg_stat_3 & BQ25790_VSYS_STAT;
+
+	state->vbat_adc = bq25790_get_vbat_adc(bq);
+
+	state->vbus_adc = bq25790_get_vbus_adc(bq);
+
+	state->ibat_adc = bq25790_get_ibat_adc(bq);
+
+	return 0;
+}
+
+static void bq25790_charger_reset(void *data)
+{
+	struct bq25790_device *bq = data;
+
+	if (!IS_ERR_OR_NULL(bq->usb2_phy))
+		usb_unregister_notifier(bq->usb2_phy, &bq->usb_nb);
+
+	if (!IS_ERR_OR_NULL(bq->usb3_phy))
+		usb_unregister_notifier(bq->usb3_phy, &bq->usb_nb);
+}
+
+static int bq25790_set_property(struct power_supply *psy,
+		enum power_supply_property prop,
+		const union power_supply_propval *val)
+{
+	struct bq25790_device *bq = power_supply_get_drvdata(psy);
+	int ret = -EINVAL;
+
+	switch (prop) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = bq25790_set_input_curr_lim(bq, val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		ret = bq25790_set_chrg_volt(bq, val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		ret = bq25790_set_ichrg_curr(bq, val->intval);
+		break;
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+		ret = bq25790_set_prechrg_curr(bq, val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		ret = bq25790_set_term_curr(bq, val->intval);
+		break;
+	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
+		ret = bq25790_set_input_volt_lim(bq, val->intval);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int bq25790_get_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	struct bq25790_device *bq = power_supply_get_drvdata(psy);
+	struct bq25790_state state;
+	int ret = 0;
+
+	ret = bq25790_get_state(bq, &state);
+	if (ret)
+		return ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (!state.chrg_type || (state.chrg_type == BQ25790_OTG_MODE))
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else if (!state.chrg_status)
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		else if (state.chrg_status == BQ25790_TERM_CHRG)
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		switch (state.chrg_status) {
+		case BQ25790_TRICKLE_CHRG:
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+			break;
+		case BQ25790_PRECHRG:
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+			break;
+		case BQ25790_FAST_CHRG:
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_FAST;
+			break;
+		case BQ25790_TAPER_CHRG:
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
+			break;
+		case BQ25790_TOP_OFF_CHRG:
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
+			break;
+		case BQ25790_NOT_CHRGING:
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_NONE;
+			break;
+		default:
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
+		}
+		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = BQ25790_MANUFACTURER;
+		break;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = bq->model_name;
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = state.online;
+		break;
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		if (!state.chrg_type) {
+			val->intval = POWER_SUPPLY_USB_TYPE_UNKNOWN;
+			break;
+		}
+		switch (state.chrg_type) {
+		case BQ25790_USB_SDP:
+			val->intval = POWER_SUPPLY_USB_TYPE_SDP;
+			break;
+		case BQ25790_USB_CDP:
+			val->intval = POWER_SUPPLY_USB_TYPE_CDP;
+			break;
+		case BQ25790_USB_DCP:
+			val->intval = POWER_SUPPLY_USB_TYPE_DCP;
+			break;
+		case BQ25790_OTG_MODE:
+			val->intval = POWER_SUPPLY_USB_TYPE_ACA;
+			break;
+		default:
+			val->intval = POWER_SUPPLY_USB_TYPE_UNKNOWN;
+			break;
+		}
+		break;
+
+	case POWER_SUPPLY_PROP_HEALTH:
+		if (state.fault_1 & (BQ25790_OTG_OVP | BQ25790_VSYS_OVP))
+			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+		else
+			val->intval = POWER_SUPPLY_HEALTH_GOOD;
+
+		switch (state.health) {
+		case BQ25790_TEMP_HOT:
+			val->intval = POWER_SUPPLY_HEALTH_HOT;
+			break;
+		case BQ25790_TEMP_WARM:
+			val->intval = POWER_SUPPLY_HEALTH_WARM;
+			break;
+		case BQ25790_TEMP_COOL:
+			val->intval = POWER_SUPPLY_HEALTH_COOL;
+			break;
+		case BQ25790_TEMP_COLD:
+			val->intval = POWER_SUPPLY_HEALTH_COLD;
+			break;
+		}
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+		ret = bq25790_get_ichg_curr(bq);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+		ret = bq25790_get_chrg_volt(bq);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+		ret = bq25790_get_prechrg_curr(bq);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+		ret = bq25790_get_term_curr(bq);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = state.vbus_adc;
+		break;
+	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
+		ret = bq25790_get_input_volt_lim(bq);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = bq25790_get_input_curr_lim(bq);
+		if (ret < 0)
+			return ret;
+
+		val->intval = ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int bq25790_battery_get_property(struct power_supply *psy,
+				       enum power_supply_property psp,
+				       union power_supply_propval *val)
+{
+	struct bq25790_device *bq = power_supply_get_drvdata(psy);
+	struct bq25790_state state;
+	int ret = 0;
+
+	ret = bq25790_get_state(bq, &state);
+	if (ret)
+		return ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
+		val->intval = bq->init_data.ichg_max;
+		break;
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
+		val->intval = bq->init_data.vreg_max;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = state.vbat_adc;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = state.ibat_adc;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static bool bq25790_state_changed(struct bq25790_device *bq,
+				  struct bq25790_state *new_state)
+{
+	struct bq25790_state old_state;
+
+	mutex_lock(&bq->lock);
+	old_state = bq->state;
+	mutex_unlock(&bq->lock);
+
+	return memcmp(&old_state, new_state,
+				sizeof(struct bq25790_state)) != 0;
+}
+
+static irqreturn_t bq25790_irq_handler_thread(int irq, void *private)
+{
+	struct bq25790_device *bq = private;
+	struct bq25790_state state;
+	int ret;
+
+	ret = bq25790_get_state(bq, &state);
+	if (ret < 0)
+		goto irq_out;
+
+	if (!bq25790_state_changed(bq, &state))
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
+static enum power_supply_property bq25790_power_supply_props[] = {
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
+	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
+	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_USB_TYPE,
+};
+
+static enum power_supply_property bq25790_battery_props[] = {
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+};
+
+static int bq25790_property_is_writeable(struct power_supply *psy,
+					 enum power_supply_property prop)
+{
+	switch (prop) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
+	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
+	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct power_supply_desc bq25790_power_supply_desc = {
+	.name = "bq25790-charger",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.usb_types = bq25790_usb_type,
+	.num_usb_types = ARRAY_SIZE(bq25790_usb_type),
+	.properties = bq25790_power_supply_props,
+	.num_properties = ARRAY_SIZE(bq25790_power_supply_props),
+	.get_property = bq25790_get_property,
+	.set_property = bq25790_set_property,
+	.property_is_writeable = bq25790_property_is_writeable,
+};
+
+static const struct power_supply_desc bq25790_battery_desc = {
+	.name = "bq25790-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.get_property = bq25790_battery_get_property,
+	.properties = bq25790_battery_props,
+	.num_properties = ARRAY_SIZE(bq25790_battery_props),
+};
+
+static bool bq25790_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BQ25790_ICO_I_LIM...BQ25790_FAULT_FLAG_1:
+	case BQ25790_ADC_IBUS...BQ25790_ADC_DM:
+	case BQ25790_CHRG_CTRL_0:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config bq25790_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = BQ25790_PART_INFO,
+	.reg_defaults	= bq25790_reg_defs,
+	.num_reg_defaults = ARRAY_SIZE(bq25790_reg_defs),
+	.cache_type = REGCACHE_FLAT,
+	.volatile_reg = bq25790_is_volatile_reg,
+};
+
+static int bq25790_power_supply_init(struct bq25790_device *bq,
+		struct power_supply_config *psy_cfg, struct device *dev)
+{
+	bq->charger = devm_power_supply_register(bq->dev,
+						 &bq25790_power_supply_desc,
+						 psy_cfg);
+	if (IS_ERR(bq->charger))
+		return -EINVAL;
+
+	bq->battery = devm_power_supply_register(bq->dev,
+						      &bq25790_battery_desc,
+						      psy_cfg);
+	if (IS_ERR(bq->battery))
+		return -EINVAL;
+	return 0;
+}
+
+static int bq25790_hw_init(struct bq25790_device *bq)
+{
+	struct power_supply_battery_info bat_info = { };
+	int wd_reg_val = BQ25790_WATCHDOG_DIS;
+	int wd_max_val = BQ25790_NUM_WD_VAL - 1;
+	int ret = 0;
+	int i;
+
+	if (bq->watchdog_timer) {
+		if (bq->watchdog_timer >= bq25790_watchdog_time[wd_max_val])
+			wd_reg_val = wd_max_val;
+		else {
+			for (i = 0; i < wd_max_val; i++) {
+				if (bq->watchdog_timer > bq25790_watchdog_time[i] &&
+				    bq->watchdog_timer < bq25790_watchdog_time[i + 1]) {
+					wd_reg_val = i;
+					break;
+				}
+			}
+		}
+	}
+
+	ret = regmap_update_bits(bq->regmap, BQ25790_CHRG_CTRL_1,
+				 BQ25790_WATCHDOG_MASK, wd_reg_val);
+	if (ret)
+		return ret;
+
+	ret = power_supply_get_battery_info(bq->charger, &bat_info);
+	if (ret) {
+		dev_warn(bq->dev, "battery info missing, default values will be applied\n");
+
+		bat_info.constant_charge_current_max_ua =
+							BQ25790_ICHRG_I_DEF_uA;
+
+		bat_info.constant_charge_voltage_max_uv =
+							BQ25790_VREG_V_DEF_uV;
+
+		bat_info.precharge_current_ua = BQ25790_PRECHRG_I_DEF_uA;
+		bat_info.charge_term_current_ua = BQ25790_TERMCHRG_I_DEF_uA;
+		bq->init_data.ichg_max = BQ25790_ICHRG_I_MAX_uA;
+		bq->init_data.vreg_max = BQ25790_VREG_V_MAX_uV;
+	} else {
+		bq->init_data.ichg_max =
+				bat_info.constant_charge_current_max_ua;
+
+		bq->init_data.vreg_max =
+				bat_info.constant_charge_voltage_max_uv;
+	}
+
+	ret = bq25790_set_ichrg_curr(bq,
+				bat_info.constant_charge_current_max_ua);
+	if (ret)
+		return ret;
+
+	ret = bq25790_set_prechrg_curr(bq, bat_info.precharge_current_ua);
+	if (ret)
+		return ret;
+
+	ret = bq25790_set_chrg_volt(bq,
+				bat_info.constant_charge_voltage_max_uv);
+	if (ret)
+		return ret;
+
+	ret = bq25790_set_term_curr(bq, bat_info.charge_term_current_ua);
+	if (ret)
+		return ret;
+
+	ret = bq25790_set_input_volt_lim(bq, bq->init_data.vlim);
+	if (ret)
+		return ret;
+
+	ret = bq25790_set_input_curr_lim(bq, bq->init_data.ilim);
+	if (ret)
+		return ret;
+
+	power_supply_put_battery_info(bq->charger, &bat_info);
+
+	return 0;
+}
+
+static int bq25790_parse_dt(struct bq25790_device *bq,
+		struct power_supply_config *psy_cfg, struct device *dev)
+{
+	int ret = 0;
+
+	psy_cfg->drv_data = bq;
+	psy_cfg->of_node = dev->of_node;
+
+	ret = device_property_read_u32(bq->dev, "ti,watchdog-timeout-ms",
+				       &bq->watchdog_timer);
+	if (ret)
+		bq->watchdog_timer = BQ25790_WATCHDOG_DIS;
+
+	if (bq->watchdog_timer > BQ25790_WATCHDOG_MAX ||
+	    bq->watchdog_timer < BQ25790_WATCHDOG_DIS)
+		return -EINVAL;
+
+	ret = device_property_read_u32(bq->dev,
+				       "input-voltage-limit-microvolt",
+				       &bq->init_data.vlim);
+	if (ret)
+		bq->init_data.vlim = BQ25790_VINDPM_DEF_uV;
+
+	if (bq->init_data.vlim > BQ25790_VINDPM_V_MAX_uV ||
+	    bq->init_data.vlim < BQ25790_VINDPM_V_MIN_uV)
+		return -EINVAL;
+
+	ret = device_property_read_u32(bq->dev,
+				       "input-current-limit-microamp",
+				       &bq->init_data.ilim);
+	if (ret)
+		bq->init_data.ilim = BQ25790_IINDPM_DEF_uA;
+
+	if (bq->init_data.ilim > BQ25790_IINDPM_I_MAX_uA ||
+	    bq->init_data.ilim < BQ25790_IINDPM_I_MIN_uA)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int bq25790_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct bq25790_device *bq;
+	struct power_supply_config psy_cfg = { };
+
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
+
+	bq->regmap = devm_regmap_init_i2c(client, &bq25790_regmap_config);
+
+	if (IS_ERR(bq->regmap)) {
+		dev_err(dev, "Failed to allocate register map\n");
+		return PTR_ERR(bq->regmap);
+	}
+
+	i2c_set_clientdata(client, bq);
+
+	ret = bq25790_parse_dt(bq, &psy_cfg, dev);
+	if (ret) {
+		dev_err(dev, "Failed to read device tree properties%d\n", ret);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, bq25790_charger_reset, bq);
+	if (ret)
+		return ret;
+
+	/* OTG reporting */
+	bq->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
+	if (!IS_ERR_OR_NULL(bq->usb2_phy)) {
+		INIT_WORK(&bq->usb_work, bq25790_usb_work);
+		bq->usb_nb.notifier_call = bq25790_usb_notifier;
+		usb_register_notifier(bq->usb2_phy, &bq->usb_nb);
+	}
+
+	bq->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
+	if (!IS_ERR_OR_NULL(bq->usb3_phy)) {
+		INIT_WORK(&bq->usb_work, bq25790_usb_work);
+		bq->usb_nb.notifier_call = bq25790_usb_notifier;
+		usb_register_notifier(bq->usb3_phy, &bq->usb_nb);
+	}
+
+	if (client->irq) {
+		ret = devm_request_threaded_irq(dev, client->irq, NULL,
+						bq25790_irq_handler_thread,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						dev_name(&client->dev), bq);
+		if (ret < 0) {
+			dev_err(dev, "get irq fail: %d\n", ret);
+			return ret;
+		}
+	}
+
+	ret = bq25790_power_supply_init(bq, &psy_cfg, dev);
+	if (ret) {
+		dev_err(dev, "Failed to register power supply\n");
+		return ret;
+	}
+
+	ret = bq25790_hw_init(bq);
+	if (ret) {
+		dev_err(dev, "Cannot initialize the chip.\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static const struct i2c_device_id bq25790_i2c_ids[] = {
+	{ "bq25790", BQ25790 },
+	{ "bq25792", BQ25792 },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, bq25790_i2c_ids);
+
+static const struct of_device_id bq25790_of_match[] = {
+	{ .compatible = "ti,bq25790", },
+	{ .compatible = "ti,bq25792", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, bq25790_of_match);
+
+static const struct acpi_device_id bq25790_acpi_match[] = {
+	{ "bq25790", BQ25790 },
+	{ "bq25792", BQ25792 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, bq25790_acpi_match);
+
+static struct i2c_driver bq25790_driver = {
+	.driver = {
+		.name = "bq25790-charger",
+		.of_match_table = bq25790_of_match,
+		.acpi_match_table = bq25790_acpi_match,
+	},
+	.probe = bq25790_probe,
+	.id_table = bq25790_i2c_ids,
+};
+module_i2c_driver(bq25790_driver);
+
+MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
+MODULE_AUTHOR("Ricardo Rivera-Matos <r-rivera-matos@ti.com>");
+MODULE_DESCRIPTION("bq25790 charger driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/power/supply/bq25790_charger.h b/drivers/power/supply/bq25790_charger.h
new file mode 100644
index 000000000000..891104ee00a0
--- /dev/null
+++ b/drivers/power/supply/bq25790_charger.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+// BQ25790 Charger Driver
+// Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
+
+#ifndef _BQ25790_CHARGER_H
+#define _BQ25790_CHARGER_H
+
+#define BQ25790_MANUFACTURER	"Texas Instruments"
+
+#define BQ25790_MIN_SYS_V	0x00
+#define BQ25790_CHRG_V_LIM_MSB	0x01
+#define BQ25790_CHRG_V_LIM_LSB	0x02
+#define BQ25790_CHRG_I_LIM_MSB	0x03
+#define BQ25790_CHRG_I_LIM_LSB	0x04
+#define BQ25790_INPUT_V_LIM	0x05
+#define BQ25790_INPUT_I_LIM_MSB	0x06
+#define BQ25790_INPUT_I_LIM_LSB	0x07
+#define BQ25790_PRECHRG_CTRL	0x08
+#define BQ25790_TERM_CTRL	0x09
+#define BQ25790_RECHRG_CTRL	0x0a
+#define BQ25790_VOTG_REG	0x0b
+#define BQ25790_IOTG_REG	0x0d
+#define BQ25790_TIMER_CTRL	0x0e
+#define BQ25790_CHRG_CTRL_0	0x0f
+#define BQ25790_CHRG_CTRL_1	0x10
+#define BQ25790_CHRG_CTRL_2	0x11
+#define BQ25790_CHRG_CTRL_3	0x12
+#define BQ25790_CHRG_CTRL_4	0x13
+#define BQ25790_CHRG_CTRL_5	0x14
+#define BQ25790_MPPT_CTRL	0x15
+#define BQ25790_TEMP_CTRL	0x16
+#define BQ25790_NTC_CTRL_0	0x17
+#define BQ25790_NTC_CTRL_1	0x18
+#define BQ25790_ICO_I_LIM	0x19
+#define BQ25790_CHRG_STAT_0	0x1b
+#define BQ25790_CHRG_STAT_1	0x1c
+#define BQ25790_CHRG_STAT_2	0x1d
+#define BQ25790_CHRG_STAT_3	0x1e
+#define BQ25790_CHRG_STAT_4	0x1f
+#define BQ25790_FAULT_STAT_0	0x20
+#define BQ25790_FAULT_STAT_1	0x21
+#define BQ25790_CHRG_FLAG_0	0x22
+#define BQ25790_CHRG_FLAG_1	0x23
+#define BQ25790_CHRG_FLAG_2	0x24
+#define BQ25790_CHRG_FLAG_3	0x25
+#define BQ25790_FAULT_FLAG_0	0x26
+#define BQ25790_FAULT_FLAG_1	0x27
+#define BQ25790_CHRG_MSK_0	0x28
+#define BQ25790_CHRG_MSK_1	0x29
+#define BQ25790_CHRG_MSK_2	0x2a
+#define BQ25790_CHRG_MSK_3	0x2b
+#define BQ25790_FAULT_MSK_0	0x2c
+#define BQ25790_FAULT_MSK_1	0x2d
+#define BQ25790_ADC_CTRL	0x2e
+#define BQ25790_FN_DISABE_0	0x2f
+#define BQ25790_FN_DISABE_1	0x30
+#define BQ25790_ADC_IBUS	0x31
+#define BQ25790_ADC_IBAT_MSB	0x33
+#define BQ25790_ADC_IBAT_LSB	0x34
+#define BQ25790_ADC_VBUS_MSB	0x35
+#define BQ25790_ADC_VBUS_LSB	0x36
+#define BQ25790_ADC_VAC1	0x37
+#define BQ25790_ADC_VAC2	0x39
+#define BQ25790_ADC_VBAT_MSB	0x3b
+#define BQ25790_ADC_VBAT_LSB	0x3c
+#define BQ25790_ADC_VSYS_MSB	0x3d
+#define BQ25790_ADC_VSYS_LSB	0x3e
+#define BQ25790_ADC_TS		0x3f
+#define BQ25790_ADC_TDIE	0x41
+#define BQ25790_ADC_DP		0x43
+#define BQ25790_ADC_DM		0x45
+#define BQ25790_DPDM_DRV	0x47
+#define BQ25790_PART_INFO	0x48
+
+#define BQ25790_CHRG_EN		BIT(5)
+#define BQ25790_ADC_EN		BIT(7)
+
+/* Charger Status 1 */
+#define BQ25790_CHG_STAT_MSK	GENMASK(7, 5)
+#define BQ25790_NOT_CHRGING	0
+#define BQ25790_TRICKLE_CHRG	BIT(5)
+#define BQ25790_PRECHRG		BIT(6)
+#define BQ25790_FAST_CHRG	(BIT(5) | BIT(6))
+#define BQ25790_TAPER_CHRG	BIT(7)
+#define BQ25790_TOP_OFF_CHRG	(BIT(6) | BIT(7))
+#define BQ25790_TERM_CHRG	(BIT(5) | BIT(6) | BIT(7))
+#define BQ25790_VBUS_PRESENT	BIT(0)
+
+#define BQ25790_VBUS_STAT_MSK	GENMASK(4, 1)
+#define BQ25790_USB_SDP		BIT(1)
+#define BQ25790_USB_CDP		BIT(2)
+#define BQ25790_USB_DCP		(BIT(1) | BIT(2))
+#define BQ25790_HVDCP		BIT(3)
+#define BQ25790_UNKNOWN_3A	(BIT(3) | BIT(1))
+#define BQ25790_NON_STANDARD	(BIT(3) | BIT(2))
+#define BQ25790_OTG_MODE	(BIT(3) | BIT(2) | BIT(1))
+#define BQ25790_UNQUAL_ADAPT	BIT(4)
+#define BQ25790_DIRECT_PWR	(BIT(4) | BIT(2) | BIT(1))
+
+/* Charger Status 4 */
+#define BQ25790_TEMP_HOT	BIT(0)
+#define BQ25790_TEMP_WARM	BIT(1)
+#define BQ25790_TEMP_COOL	BIT(2)
+#define BQ25790_TEMP_COLD	BIT(3)
+#define BQ25790_TEMP_MASK	GENMASK(3, 0)
+
+#define BQ25790_OTG_OVP		BIT(5)
+#define BQ25790_VSYS_OVP	BIT(6)
+#define BQ25790_VSYS_STAT	BIT(4)
+
+#define BQ25790_PRECHRG_CUR_MASK		GENMASK(5, 0)
+#define BQ25790_PRECHRG_CURRENT_STEP_uA		40000
+#define BQ25790_PRECHRG_I_MIN_uA		40000
+#define BQ25790_PRECHRG_I_MAX_uA		2000000
+#define BQ25790_PRECHRG_I_DEF_uA		120000
+#define BQ25790_TERMCHRG_CUR_MASK		GENMASK(4, 0)
+#define BQ25790_TERMCHRG_CURRENT_STEP_uA	40000
+#define BQ25790_TERMCHRG_I_MIN_uA		40000
+#define BQ25790_TERMCHRG_I_MAX_uA		1000000
+#define BQ25790_TERMCHRG_I_DEF_uA		200000
+#define BQ25790_ICHRG_CURRENT_STEP_uA		10000
+#define BQ25790_ICHRG_I_MIN_uA			50000
+#define BQ25790_ICHRG_I_MAX_uA			5000000
+#define BQ25790_ICHRG_I_DEF_uA			1000000
+
+#define BQ25790_VREG_V_MAX_uV	18800000
+#define BQ25790_VREG_V_MIN_uV	3000000
+#define BQ25790_VREG_V_DEF_uV	3600000
+#define BQ25790_VREG_V_STEP_uV	10000
+
+#define BQ25790_IINDPM_I_MIN_uA	100000
+#define BQ25790_IINDPM_I_MAX_uA	3300000
+#define BQ25790_IINDPM_STEP_uA	10000
+#define BQ25790_IINDPM_DEF_uA	1000000
+
+#define BQ25790_VINDPM_V_MIN_uV 3600000
+#define BQ25790_VINDPM_V_MAX_uV 22000000
+#define BQ25790_VINDPM_STEP_uV	100000
+#define BQ25790_VINDPM_DEF_uV	3600000
+
+#define BQ25790_ADC_VOLT_STEP_uV	1000
+#define BQ25790_ADC_CURR_STEP_uA	1000
+
+#define BQ25790_WATCHDOG_MASK	GENMASK(2, 0)
+#define BQ25790_WATCHDOG_DIS	0
+#define BQ25790_WATCHDOG_MAX	160000
+
+#endif /* _BQ25790_CHARGER_H */
-- 
2.30.0

