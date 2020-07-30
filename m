Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909C6233525
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 17:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgG3PO6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 11:14:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41992 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgG3PO5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 11:14:57 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06UFErst121883;
        Thu, 30 Jul 2020 10:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596122093;
        bh=YxgQ1YeWhPnyoCFLjAh9KG6MTOY5RlStj12DFMxDSjc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NQOtcOnv1hS0fS2qULnqxl6nlJHaXG+xptY7To5SekfDOZZL7+8XN4HWWpl6khQqf
         n9SfT6VXNQ67JPETrbRQaEBXZc392ydLFJtejfQnq+OtSve8jMootL6En347SeuXhz
         xNI0bb0jNiihnxZ0Jjz8uH3HITmIjMWxuVbFq7zI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06UFErlL023831
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 10:14:53 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 30
 Jul 2020 10:14:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 30 Jul 2020 10:14:53 -0500
Received: from [10.250.43.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06UFErgh003732;
        Thu, 30 Jul 2020 10:14:53 -0500
Subject: Re: [PATCH 2/2] power: supply: bq25790: Introduce the BQ25790 charger
 driver
To:     Dan Murphy <dmurphy@ti.com>, <sre@kernel.org>, <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200730145834.29227-1-dmurphy@ti.com>
 <20200730145834.29227-2-dmurphy@ti.com>
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Message-ID: <0c4987bb-0883-debf-36e2-d25391f59399@ti.com>
Date:   Thu, 30 Jul 2020 10:14:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200730145834.29227-2-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>

On 7/30/20 9:58 AM, Dan Murphy wrote:
> BQ25790 is a highly integrated switch-mode buck-boost charger
> for 1-4 cell Li-ion battery and Li-polymer battery.
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>   drivers/power/supply/Kconfig           |    8 +
>   drivers/power/supply/Makefile          |    1 +
>   drivers/power/supply/bq25790_charger.c | 1117 ++++++++++++++++++++++++
>   drivers/power/supply/bq25790_charger.h |  150 ++++
>   4 files changed, 1276 insertions(+)
>   create mode 100644 drivers/power/supply/bq25790_charger.c
>   create mode 100644 drivers/power/supply/bq25790_charger.h
>
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index faf2830aa152..802c644d92be 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -623,6 +623,14 @@ config CHARGER_BQ2515X
>   	  rail, ADC for battery and system monitoring, and push-button
>   	  controller.
>   
> +config CHARGER_BQ25790
> +	tristate "TI BQ25790 battery charger driver"
> +	depends on I2C
> +	depends on GPIOLIB || COMPILE_TEST
> +	select REGMAP_I2C
> +	help
> +	  Say Y to enable support for the TI BQ25790 battery charger.
> +
>   config CHARGER_BQ25890
>   	tristate "TI BQ25890 battery charger driver"
>   	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index b3c694a65114..ae269b9f624b 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -84,6 +84,7 @@ obj-$(CONFIG_CHARGER_BQ24257)	+= bq24257_charger.o
>   obj-$(CONFIG_CHARGER_BQ24735)	+= bq24735-charger.o
>   obj-$(CONFIG_CHARGER_BQ2515X)	+= bq2515x_charger.o
>   obj-$(CONFIG_CHARGER_BQ25890)	+= bq25890_charger.o
> +obj-$(CONFIG_CHARGER_BQ25790)	+= bq25790_charger.o
>   obj-$(CONFIG_CHARGER_SMB347)	+= smb347-charger.o
>   obj-$(CONFIG_CHARGER_TPS65090)	+= tps65090-charger.o
>   obj-$(CONFIG_CHARGER_TPS65217)	+= tps65217_charger.o
> diff --git a/drivers/power/supply/bq25790_charger.c b/drivers/power/supply/bq25790_charger.c
> new file mode 100644
> index 000000000000..92fa859ef55c
> --- /dev/null
> +++ b/drivers/power/supply/bq25790_charger.c
> @@ -0,0 +1,1117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// BQ25790 driver
> +// Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/usb/phy.h>
> +
> +#include <linux/acpi.h>
> +#include <linux/of.h>
> +
> +#include "bq25790_charger.h"
> +
> +#define BQ25790_NUM_WD_VAL	8
> +
> +struct bq25790_init_data {
> +	u32 ichg;
> +	u32 ilim;
> +	u32 vreg;
> +	u32 iterm;
> +	u32 iprechg;
> +	u32 vlim;
> +	u32 ichg_max;
> +	u32 vreg_max;
> +};
> +
> +struct bq25790_state {
> +	bool online;
> +	u8 chrg_status;
> +	u8 chrg_type;
> +	u8 health;
> +	u8 chrg_fault;
> +	u8 vsys_status;
> +	u8 vbus_status;
> +	u8 fault_0;
> +	u8 fault_1;
> +	u32 vbat_adc;
> +	u32 vbus_adc;
> +	u32 ibat_adc;
> +};
> +
> +struct bq25790_device {
> +	struct i2c_client *client;
> +	struct device *dev;
> +	struct power_supply *charger;
> +	struct power_supply *battery;
> +	struct mutex lock;
> +
> +	struct usb_phy *usb2_phy;
> +	struct usb_phy *usb3_phy;
> +	struct notifier_block usb_nb;
> +	struct work_struct usb_work;
> +	unsigned long usb_event;
> +	struct regmap *regmap;
> +
> +	char model_name[I2C_NAME_SIZE];
> +	int device_id;
> +
> +	struct bq25790_init_data init_data;
> +	struct bq25790_state state;
> +	int watchdog_timer;
> +};
> +
> +static struct reg_default bq25790_reg_defs[] = {
> +	{BQ25790_INPUT_V_LIM, 0x24},
> +	{BQ25790_INPUT_I_LIM_MSB, 0x01},
> +	{BQ25790_INPUT_I_LIM_LSB, 0x2c},
> +	{BQ25790_PRECHRG_CTRL, 0xc3},
> +	{BQ25790_TERM_CTRL, 0x5},
> +	{BQ25790_VOTG_REG, 0xdc},
> +	{BQ25790_IOTG_REG, 0x4b},
> +	{BQ25790_TIMER_CTRL, 0x3d},
> +	{BQ25790_CHRG_CTRL_0, 0xa2},
> +	{BQ25790_CHRG_CTRL_1, 0x85},
> +	{BQ25790_CHRG_CTRL_2, 0x40},
> +	{BQ25790_CHRG_CTRL_3, 0x12},
> +	{BQ25790_CHRG_CTRL_5, 0x16},
> +	{BQ25790_MPPT_CTRL, 0xaa},
> +	{BQ25790_TEMP_CTRL, 0xc0},
> +	{BQ25790_NTC_CTRL_0, 0x7a},
> +	{BQ25790_NTC_CTRL_1, 0x54},
> +	{BQ25790_ICO_I_LIM, 0x0},
> +	{BQ25790_CHRG_STAT_0, 0x0},
> +	{BQ25790_CHRG_STAT_1, 0x0},
> +	{BQ25790_CHRG_STAT_2, 0x0},
> +	{BQ25790_CHRG_STAT_3, 0x0},
> +	{BQ25790_CHRG_STAT_4, 0x0},
> +	{BQ25790_FAULT_STAT_0, 0x0},
> +	{BQ25790_FAULT_STAT_1, 0x0},
> +	{BQ25790_CHRG_FLAG_0, 0x0},
> +	{BQ25790_CHRG_FLAG_1, 0x0},
> +	{BQ25790_CHRG_FLAG_2, 0x0},
> +	{BQ25790_CHRG_FLAG_3, 0x0},
> +	{BQ25790_FAULT_FLAG_0, 0x0},
> +	{BQ25790_FAULT_FLAG_1, 0x0},
> +	{BQ25790_CHRG_MSK_0, 0x0},
> +	{BQ25790_CHRG_MSK_1, 0x0},
> +	{BQ25790_CHRG_MSK_2, 0x0},
> +	{BQ25790_CHRG_MSK_3, 0x0},
> +	{BQ25790_FAULT_MSK_0, 0x0},
> +	{BQ25790_FAULT_MSK_1, 0x0},
> +	{BQ25790_ADC_CTRL, 0x30},
> +	{BQ25790_FN_DISABE_0, 0x0},
> +	{BQ25790_FN_DISABE_1, 0x0},
> +	{BQ25790_ADC_IBUS, 0x0},
> +	{BQ25790_ADC_IBAT_MSB, 0x0},
> +	{BQ25790_ADC_IBAT_LSB, 0x0},
> +	{BQ25790_ADC_VBUS_MSB, 0x0},
> +	{BQ25790_ADC_VBUS_LSB, 0x0},
> +	{BQ25790_ADC_VAC1, 0x0},
> +	{BQ25790_ADC_VAC2, 0x0},
> +	{BQ25790_ADC_VBAT_MSB, 0x0},
> +	{BQ25790_ADC_VBAT_LSB, 0x0},
> +	{BQ25790_ADC_VBUS_MSB, 0x0},
> +	{BQ25790_ADC_VBUS_LSB, 0x0},
> +	{BQ25790_ADC_TS, 0x0},
> +	{BQ25790_ADC_TDIE, 0x0},
> +	{BQ25790_ADC_DP, 0x0},
> +	{BQ25790_ADC_DM, 0x0},
> +	{BQ25790_DPDM_DRV, 0x0},
> +	{BQ25790_PART_INFO, 0x0},
> +};
> +
> +static int bq25790_watchdog_time[BQ25790_NUM_WD_VAL] = {0, 500, 1000, 2000,
> +							20000, 40000, 80000,
> +							160000};
> +
> +static enum power_supply_usb_type bq25790_usb_type[] = {
> +	POWER_SUPPLY_USB_TYPE_PD_DRP,
> +	POWER_SUPPLY_USB_TYPE_SDP,
> +	POWER_SUPPLY_USB_TYPE_CDP,
> +	POWER_SUPPLY_USB_TYPE_DCP,
> +	POWER_SUPPLY_USB_TYPE_UNKNOWN,
> +};
> +
> +static int bq25790_usb_notifier(struct notifier_block *nb, unsigned long val,
> +				void *priv)
> +{
> +	struct bq25790_device *bq =
> +			container_of(nb, struct bq25790_device, usb_nb);
> +
> +	bq->usb_event = val;
> +	queue_work(system_power_efficient_wq, &bq->usb_work);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static void bq25790_usb_work(struct work_struct *data)
> +{
> +	struct bq25790_device *bq =
> +			container_of(data, struct bq25790_device, usb_work);
> +
> +	switch (bq->usb_event) {
> +	case USB_EVENT_ID:
> +		break;
> +
> +	case USB_EVENT_NONE:
> +		power_supply_changed(bq->charger);
> +		break;
> +	}
> +
> +	return;
> +
> +	dev_err(bq->dev, "Error switching to charger mode.\n");
> +}
> +
> +static int bq25790_get_vbat_adc(struct bq25790_device *bq)
> +{
> +	int ret;
> +	int vbat_adc_lsb, vbat_adc_msb;
> +	u16 vbat_adc;
> +
> +	ret = regmap_read(bq->regmap, BQ25790_ADC_VBAT_MSB, &vbat_adc_msb);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(bq->regmap, BQ25790_ADC_VBAT_LSB, &vbat_adc_lsb);
> +	if (ret)
> +		return ret;
> +
> +	vbat_adc = (vbat_adc_msb << 8) | vbat_adc_lsb;
> +
> +	return vbat_adc * BQ25790_ADC_VOLT_STEP_uV;
> +}
> +
> +static int bq25790_get_vbus_adc(struct bq25790_device *bq)
> +{
> +	int ret;
> +	int vbus_adc_lsb, vbus_adc_msb;
> +	u16 vbus_adc;
> +
> +	ret = regmap_update_bits(bq->regmap, BQ25790_ADC_CTRL,
> +				 BQ25790_ADC_EN, BQ25790_ADC_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(bq->regmap, BQ25790_ADC_VBUS_MSB, &vbus_adc_msb);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(bq->regmap, BQ25790_ADC_VBUS_LSB, &vbus_adc_lsb);
> +	if (ret)
> +		return ret;
> +
> +	vbus_adc = (vbus_adc_msb << 8) | vbus_adc_lsb;
> +
> +	return vbus_adc * BQ25790_ADC_VOLT_STEP_uV;
> +}
> +
> +static int bq25790_get_ibat_adc(struct bq25790_device *bq)
> +{
> +	int ret;
> +	int ibat_adc_lsb, ibat_adc_msb;
> +	u16 ibat_adc;
> +
> +	ret = regmap_read(bq->regmap, BQ25790_ADC_IBAT_MSB, &ibat_adc_msb);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(bq->regmap, BQ25790_ADC_IBAT_LSB, &ibat_adc_lsb);
> +	if (ret)
> +		return ret;
> +
> +	ibat_adc = (ibat_adc_msb << 8) | ibat_adc_lsb;
> +
> +	return ibat_adc * BQ25790_ADC_CURR_STEP_uA;
> +}
> +
> +static int bq25790_get_term_curr(struct bq25790_device *bq)
> +{
> +	int ret;
> +	int reg_val;
> +
> +	ret = regmap_read(bq->regmap, BQ25790_TERM_CTRL, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	reg_val &= BQ25790_TERMCHRG_CUR_MASK;
> +
> +	return reg_val * BQ25790_TERMCHRG_CURRENT_STEP_uA;
> +}
> +
> +static int bq25790_get_prechrg_curr(struct bq25790_device *bq)
> +{
> +	int ret;
> +	int reg_val;
> +
> +	ret = regmap_read(bq->regmap, BQ25790_PRECHRG_CTRL, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	reg_val &= BQ25790_PRECHRG_CUR_MASK;
> +
> +	return reg_val * BQ25790_PRECHRG_CURRENT_STEP_uA;
> +}
> +
> +static int bq25790_get_ichg_curr(struct bq25790_device *bq)
> +{
> +	int ret;
> +	int ichg, ichg_lsb, ichg_msb;
> +
> +	ret = regmap_read(bq->regmap, BQ25790_CHRG_I_LIM_LSB, &ichg_lsb);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(bq->regmap, BQ25790_CHRG_I_LIM_MSB, &ichg_msb);
> +	if (ret)
> +		return ret;
> +
> +	ichg = (ichg_msb << 8) | ichg_lsb;
> +
> +	return ichg * BQ25790_ICHRG_CURRENT_STEP_uA;
> +}
> +
> +static int bq25790_set_term_curr(struct bq25790_device *bq, int term_current)
> +{
> +	int reg_val;
> +
> +	if (term_current < BQ25790_TERMCHRG_I_MIN_uA ||
> +	    term_current > BQ25790_TERMCHRG_I_MAX_uA)
> +		return -EINVAL;
> +
> +	reg_val = term_current / BQ25790_TERMCHRG_CURRENT_STEP_uA;
> +
> +	return regmap_update_bits(bq->regmap, BQ25790_TERM_CTRL,
> +				  BQ25790_TERMCHRG_CUR_MASK, reg_val);
> +}
> +
> +static int bq25790_set_prechrg_curr(struct bq25790_device *bq, int pre_current)
> +{
> +	int reg_val;
> +
> +	if (pre_current < BQ25790_PRECHRG_I_MIN_uA ||
> +	    pre_current > BQ25790_PRECHRG_I_MAX_uA)
> +		return -EINVAL;
> +
> +	reg_val = pre_current / BQ25790_PRECHRG_CURRENT_STEP_uA;
> +
> +	return regmap_update_bits(bq->regmap, BQ25790_PRECHRG_CTRL,
> +				  BQ25790_PRECHRG_CUR_MASK, reg_val);
> +}
> +
> +static int bq25790_set_ichrg_curr(struct bq25790_device *bq, int chrg_curr)
> +{
> +	int ret;
> +	int ichg, ichg_msb, ichg_lsb;
> +
> +	if (chrg_curr < BQ25790_ICHRG_I_MIN_uA ||
> +	    chrg_curr > BQ25790_ICHRG_I_MAX_uA)
> +		return -EINVAL;
> +
> +	ichg = chrg_curr / BQ25790_ICHRG_CURRENT_STEP_uA;
> +	ichg_msb = (ichg >> 8) & 0xff;
> +	ret = regmap_write(bq->regmap, BQ25790_CHRG_I_LIM_MSB, ichg_msb);
> +	if (ret)
> +		return ret;
> +
> +	ichg_lsb = ichg & 0xff;
> +
> +	return regmap_write(bq->regmap, BQ25790_CHRG_I_LIM_LSB, ichg_lsb);
> +}
> +
> +static int bq25790_set_chrg_volt(struct bq25790_device *bq, int chrg_volt)
> +{
> +	int vlim_lsb, vlim_msb, vlim;
> +	int ret;
> +
> +	if (chrg_volt < BQ25790_VREG_V_MIN_uV ||
> +	    chrg_volt > BQ25790_VREG_V_MAX_uV)
> +		return -EINVAL;
> +
> +	vlim = chrg_volt / BQ25790_VREG_V_STEP_uV;
> +	vlim_msb = (vlim >> 8) & 0xff;
> +	ret = regmap_write(bq->regmap, BQ25790_CHRG_V_LIM_MSB, vlim_msb);
> +	if (ret)
> +		return ret;
> +
> +	vlim_lsb = vlim & 0xff;
> +
> +	return regmap_write(bq->regmap, BQ25790_CHRG_V_LIM_LSB, vlim_lsb);
> +}
> +
> +static int bq25790_get_chrg_volt(struct bq25790_device *bq)
> +{
> +	int ret;
> +	int vlim_lsb, vlim_msb, chrg_volt;
> +
> +	ret = regmap_read(bq->regmap, BQ25790_CHRG_V_LIM_MSB, &vlim_msb);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(bq->regmap, BQ25790_CHRG_V_LIM_LSB, &vlim_lsb);
> +	if (ret)
> +		return ret;
> +
> +	chrg_volt = (vlim_msb << 8) | vlim_lsb;
> +
> +	return chrg_volt * BQ25790_VREG_V_STEP_uV;
> +}
> +
> +static int bq25790_set_input_volt_lim(struct bq25790_device *bq, int vindpm)
> +{
> +	int ret;
> +	int vlim_lsb, vlim_msb;
> +	int vlim;
> +
> +	if (vindpm < BQ25790_VINDPM_V_MIN_uV ||
> +	    vindpm > BQ25790_VINDPM_V_MAX_uV)
> +		return -EINVAL;
> +
> +	vlim = vindpm / BQ25790_VINDPM_STEP_uV;
> +
> +	vlim_msb = (vlim >> 8) & 0xff;
> +
> +	ret = regmap_write(bq->regmap, BQ25790_CHRG_V_LIM_MSB, vlim_msb);
> +	if (ret)
> +		return ret;
> +
> +	vlim_lsb = vlim & 0xff;
> +
> +	return regmap_write(bq->regmap, BQ25790_CHRG_V_LIM_LSB, vlim_lsb);
> +}
> +
> +static int bq25790_get_input_volt_lim(struct bq25790_device *bq)
> +{
> +	int ret;
> +	int vlim;
> +
> +	ret = regmap_read(bq->regmap, BQ25790_INPUT_V_LIM, &vlim);
> +	if (ret)
> +		return ret;
> +
> +	return vlim * BQ25790_VINDPM_STEP_uV;
> +}
> +
> +static int bq25790_set_input_curr_lim(struct bq25790_device *bq, int iindpm)
> +{
> +	int ret;
> +	int ilim, ilim_lsb, ilim_msb;
> +
> +	if (iindpm < BQ25790_IINDPM_I_MIN_uA ||
> +	    iindpm > BQ25790_IINDPM_I_MAX_uA)
> +		return -EINVAL;
> +
> +	ilim = iindpm / BQ25790_IINDPM_STEP_uA;
> +	ilim_msb = (ilim >> 8) & 0xff;
> +
> +	ret = regmap_write(bq->regmap, BQ25790_INPUT_I_LIM_MSB, ilim_msb);
> +	if (ret)
> +		return ret;
> +
> +	ilim_lsb = ilim & 0xff;
> +
> +	return regmap_write(bq->regmap, BQ25790_INPUT_I_LIM_LSB, ilim_lsb);
> +}
> +
> +static int bq25790_get_input_curr_lim(struct bq25790_device *bq)
> +{
> +	int ret;
> +	int ilim_msb, ilim_lsb;
> +	u16 ilim;
> +
> +	ret = regmap_read(bq->regmap, BQ25790_INPUT_I_LIM_MSB, &ilim_msb);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(bq->regmap, BQ25790_INPUT_I_LIM_LSB, &ilim_lsb);
> +	if (ret)
> +		return ret;
> +
> +	ilim = (ilim_msb << 8) | ilim_lsb;
> +
> +	return ilim * BQ25790_IINDPM_STEP_uA;
> +}
> +
> +static int bq25790_get_state(struct bq25790_device *bq,
> +			     struct bq25790_state *state)
> +{
> +	int chrg_stat_0, chrg_stat_1, chrg_stat_3, chrg_stat_4;
> +	int chrg_ctrl_0, fault_0, fault_1;
> +	int ret;
> +
> +	ret = regmap_read(bq->regmap, BQ25790_CHRG_STAT_0, &chrg_stat_0);
> +	if (ret)
> +		return ret;
> +
> +	state->vbus_status = chrg_stat_0 & BQ25790_VBUS_PRESENT;
> +
> +	ret = regmap_read(bq->regmap, BQ25790_CHRG_STAT_1, &chrg_stat_1);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(bq->regmap, BQ25790_CHRG_CTRL_0, &chrg_ctrl_0);
> +	if (ret)
> +		return ret;
> +
> +	if (chrg_ctrl_0 & BQ25790_CHRG_EN)
> +		state->chrg_status = chrg_stat_1 & BQ25790_CHG_STAT_MSK;
> +	else
> +		state->chrg_status = BQ25790_NOT_CHRGING;
> +
> +	state->chrg_type = chrg_stat_1 & BQ25790_VBUS_STAT_MSK;
> +
> +	ret = regmap_read(bq->regmap, BQ25790_CHRG_STAT_4, &chrg_stat_4);
> +	if (ret)
> +		return ret;
> +
> +	state->health = chrg_stat_4 & BQ25790_TEMP_MASK;
> +
> +	ret = regmap_read(bq->regmap, BQ25790_FAULT_STAT_0, &fault_0);
> +	if (ret)
> +		return ret;
> +
> +	state->fault_0 = fault_0;
> +
> +	ret = regmap_read(bq->regmap, BQ25790_FAULT_STAT_1, &fault_1);
> +	if (ret)
> +		return ret;
> +
> +	state->fault_1 = fault_1;
> +
> +	ret = regmap_read(bq->regmap, BQ25790_CHRG_STAT_3, &chrg_stat_3);
> +	if (ret)
> +		return ret;
> +
> +	state->online = chrg_stat_3 & BQ25790_VSYS_STAT;
> +
> +	state->vbat_adc = bq25790_get_vbat_adc(bq);
> +
> +	state->vbus_adc = bq25790_get_vbus_adc(bq);
> +
> +	state->ibat_adc = bq25790_get_ibat_adc(bq);
> +
> +	return 0;
> +}
> +
> +static int bq25790_set_property(struct power_supply *psy,
> +		enum power_supply_property prop,
> +		const union power_supply_propval *val)
> +{
> +	struct bq25790_device *bq = power_supply_get_drvdata(psy);
> +	int ret = -EINVAL;
> +
> +	switch (prop) {
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret = bq25790_set_input_curr_lim(bq, val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		ret = bq25790_set_chrg_volt(bq, val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		ret = bq25790_set_ichrg_curr(bq, val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +		ret = bq25790_set_prechrg_curr(bq, val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +		ret = bq25790_set_term_curr(bq, val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
> +		ret = bq25790_set_input_volt_lim(bq, val->intval);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int bq25790_get_property(struct power_supply *psy,
> +				enum power_supply_property psp,
> +				union power_supply_propval *val)
> +{
> +	struct bq25790_device *bq = power_supply_get_drvdata(psy);
> +	struct bq25790_state state;
> +	int ret = 0;
> +
> +	mutex_lock(&bq->lock);
> +	ret = bq25790_get_state(bq, &state);
> +	mutex_unlock(&bq->lock);
> +	if (ret)
> +		return ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		if (!state.chrg_type || (state.chrg_type == BQ25790_OTG_MODE))
> +			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> +		else if (!state.chrg_status)
> +			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		else if (state.chrg_status == BQ25790_TERM_CHRG)
> +			val->intval = POWER_SUPPLY_STATUS_FULL;
> +		else
> +			val->intval = POWER_SUPPLY_STATUS_CHARGING;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		switch (state.chrg_status) {
> +		case BQ25790_TRICKLE_CHRG:
> +			val->intval = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +			break;
> +		case BQ25790_PRECHRG:
> +			val->intval = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +			break;
> +		case BQ25790_FAST_CHRG:
> +			val->intval = POWER_SUPPLY_CHARGE_TYPE_FAST;
> +			break;
> +		case BQ25790_TAPER_CHRG:
> +			val->intval = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
> +			break;
> +		case BQ25790_TOP_OFF_CHRG:
> +			val->intval = POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +			break;
> +		case BQ25790_NOT_CHRGING:
> +			val->intval = POWER_SUPPLY_CHARGE_TYPE_NONE;
> +			break;
> +		default:
> +			val->intval = POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
> +		}
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval = BQ25790_MANUFACTURER;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		val->strval = BQ25790_NAME;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval = state.online;
> +		break;
> +	case POWER_SUPPLY_PROP_USB_TYPE:
> +		if (!state.chrg_type) {
> +			val->intval = POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +			break;
> +		}
> +		switch (state.chrg_type) {
> +		case BQ25790_USB_SDP:
> +			val->intval = POWER_SUPPLY_USB_TYPE_SDP;
> +			break;
> +		case BQ25790_USB_CDP:
> +			val->intval = POWER_SUPPLY_USB_TYPE_CDP;
> +			break;
> +		case BQ25790_USB_DCP:
> +			val->intval = POWER_SUPPLY_USB_TYPE_DCP;
> +			break;
> +		case BQ25790_OTG_MODE:
> +			val->intval = POWER_SUPPLY_USB_TYPE_PD_DRP;
> +			break;
> +
> +		default:
> +			val->intval = POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +			break;
> +		}
> +		break;
> +
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		if (state.fault_1 && (BQ25790_OTG_OVP | BQ25790_VSYS_OVP))
> +			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +		else
> +			val->intval = POWER_SUPPLY_HEALTH_GOOD;
> +
> +		switch (state.health) {
> +		case BQ25790_TEMP_HOT:
> +			val->intval = POWER_SUPPLY_HEALTH_HOT;
> +			break;
> +		case BQ25790_TEMP_WARM:
> +			val->intval = POWER_SUPPLY_HEALTH_WARM;
> +			break;
> +		case BQ25790_TEMP_COOL:
> +			val->intval = POWER_SUPPLY_HEALTH_COOL;
> +			break;
> +		case BQ25790_TEMP_COLD:
> +			val->intval = POWER_SUPPLY_HEALTH_COLD;
> +			break;
> +		}
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		ret = bq25790_get_ichg_curr(bq);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval = ret;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		ret = bq25790_get_chrg_volt(bq);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval = ret;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +		ret = bq25790_get_prechrg_curr(bq);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval = ret;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +		ret = bq25790_get_term_curr(bq);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval = ret;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval = state.vbus_adc;
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
> +		ret = bq25790_get_input_volt_lim(bq);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval = ret;
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret = bq25790_get_input_curr_lim(bq);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval = ret;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int bq25790_battery_get_property(struct power_supply *psy,
> +				       enum power_supply_property psp,
> +				       union power_supply_propval *val)
> +{
> +	struct bq25790_device *bq = power_supply_get_drvdata(psy);
> +	struct bq25790_state state;
> +	int ret = 0;
> +
> +	mutex_lock(&bq->lock);
> +	ret = bq25790_get_state(bq, &state);
> +	mutex_unlock(&bq->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(bq->regmap, BQ25790_ADC_CTRL,
> +				 BQ25790_ADC_EN, BQ25790_ADC_EN);
> +	if (ret)
> +		return ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		val->intval = bq->init_data.ichg_max;
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +		val->intval = bq->init_data.vreg_max;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval = state.vbat_adc;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		val->intval = state.ibat_adc;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static bool bq25790_state_changed(struct bq25790_device *bq,
> +				  struct bq25790_state *new_state)
> +{
> +	struct bq25790_state old_state;
> +
> +	mutex_lock(&bq->lock);
> +	old_state = bq->state;
> +	mutex_unlock(&bq->lock);
> +
> +	return (old_state.chrg_status != new_state->chrg_status ||
> +		old_state.chrg_fault != new_state->chrg_fault	||
> +		old_state.online != new_state->online		||
> +		old_state.health != new_state->health	||
> +		old_state.fault_0 != new_state->fault_0 ||
> +		old_state.fault_1 != new_state->fault_1 ||
> +		old_state.chrg_type != new_state->chrg_type ||
> +		old_state.vsys_status != new_state->vsys_status ||
> +		old_state.vbat_adc != new_state->vbat_adc ||
> +		old_state.vbus_adc != new_state->vbus_adc ||
> +		old_state.ibat_adc != new_state->ibat_adc);
> +}
> +
> +static irqreturn_t bq25790_irq_handler_thread(int irq, void *private)
> +{
> +	struct bq25790_device *bq = private;
> +	struct bq25790_state state;
> +	int ret;
> +
> +	ret = bq25790_get_state(bq, &state);
> +	if (ret < 0)
> +		goto irq_out;
> +
> +	if (!bq25790_state_changed(bq, &state))
> +		goto irq_out;
> +
> +	mutex_lock(&bq->lock);
> +	bq->state = state;
> +	mutex_unlock(&bq->lock);
> +
> +	power_supply_changed(bq->charger);
> +
> +irq_out:
> +	return IRQ_HANDLED;
> +}
> +
> +static enum power_supply_property bq25790_power_supply_props[] = {
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
> +	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_USB_TYPE,
> +};
> +
> +static enum power_supply_property bq25790_battery_props[] = {
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +};
> +
> +static char *bq25790_charger_supplied_to[] = {
> +	"main-battery",
> +};
> +
> +static int bq25790_property_is_writeable(struct power_supply *psy,
> +					 enum power_supply_property prop)
> +{
> +	switch (prop) {
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +	case POWER_SUPPLY_PROP_STATUS:
> +	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct power_supply_desc bq25790_power_supply_desc = {
> +	.name = "bq25790-charger",
> +	.type = POWER_SUPPLY_TYPE_USB,
> +	.usb_types = bq25790_usb_type,
> +	.num_usb_types = ARRAY_SIZE(bq25790_usb_type),
> +	.properties = bq25790_power_supply_props,
> +	.num_properties = ARRAY_SIZE(bq25790_power_supply_props),
> +	.get_property = bq25790_get_property,
> +	.set_property = bq25790_set_property,
> +	.property_is_writeable = bq25790_property_is_writeable,
> +};
> +
> +static const struct power_supply_desc bq25790_battery_desc = {
> +	.name = "bq25790-battery",
> +	.type = POWER_SUPPLY_TYPE_BATTERY,
> +	.get_property = bq25790_battery_get_property,
> +	.properties = bq25790_battery_props,
> +	.num_properties = ARRAY_SIZE(bq25790_battery_props),
> +};
> +
> +static bool bq25790_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case BQ25790_ICO_I_LIM...BQ25790_FAULT_FLAG_1:
> +	case BQ25790_ADC_IBUS...BQ25790_ADC_DM:
> +	case BQ25790_CHRG_CTRL_0:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config bq25790_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +
> +	.max_register = BQ25790_PART_INFO,
> +	.reg_defaults	= bq25790_reg_defs,
> +	.num_reg_defaults = ARRAY_SIZE(bq25790_reg_defs),
> +	.cache_type = REGCACHE_RBTREE,
> +	.volatile_reg = bq25790_is_volatile_reg,
> +};
> +
> +static int bq25790_power_supply_init(struct bq25790_device *bq,
> +							struct device *dev)
> +{
> +	struct power_supply_config psy_cfg = { .drv_data = bq,
> +						.of_node = dev->of_node, };
> +
> +	psy_cfg.supplied_to = bq25790_charger_supplied_to;
> +	psy_cfg.num_supplicants = ARRAY_SIZE(bq25790_charger_supplied_to);
> +
> +	bq->charger = devm_power_supply_register(bq->dev,
> +						 &bq25790_power_supply_desc,
> +						 &psy_cfg);
> +	if (IS_ERR(bq->charger))
> +		return -EINVAL;
> +
> +	bq->battery = devm_power_supply_register(bq->dev,
> +						      &bq25790_battery_desc,
> +						      &psy_cfg);
> +	if (IS_ERR(bq->battery))
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +static int bq25790_hw_init(struct bq25790_device *bq)
> +{
> +	struct power_supply_battery_info bat_info = { };
> +	int wd_reg_val;
> +	int ret = 0;
> +	int i;
> +
> +	if (bq->watchdog_timer) {
> +		for (i = 0; i < BQ25790_NUM_WD_VAL; i++) {
> +			if (bq->watchdog_timer > bq25790_watchdog_time[i] &&
> +			    bq->watchdog_timer < bq25790_watchdog_time[i + 1]) {
> +				wd_reg_val = i;
> +				break;
> +			}
> +		}
> +	} else
> +		wd_reg_val = BQ25790_WATCHDOG_DIS;
> +
> +	ret = regmap_update_bits(bq->regmap, BQ25790_CHRG_CTRL_1,
> +					BQ25790_WATCHDOG_MASK, wd_reg_val);
> +
> +	ret = power_supply_get_battery_info(bq->charger, &bat_info);
> +	if (ret) {
> +		dev_warn(bq->dev, "battery info missing, default values will be applied\n");
> +
> +		bat_info.constant_charge_current_max_ua =
> +							BQ25790_ICHRG_I_DEF_uA;
> +
> +		bat_info.constant_charge_voltage_max_uv =
> +							BQ25790_VREG_V_DEF_uV;
> +
> +		bat_info.precharge_current_ua = BQ25790_PRECHRG_I_DEF_uA;
> +		bat_info.charge_term_current_ua = BQ25790_TERMCHRG_I_DEF_uA;
> +		bq->init_data.ichg_max = BQ25790_ICHRG_I_MAX_uA;
> +		bq->init_data.vreg_max = BQ25790_VREG_V_MAX_uV;
> +	} else {
> +		bq->init_data.ichg_max =
> +				bat_info.constant_charge_current_max_ua;
> +
> +		bq->init_data.vreg_max =
> +				bat_info.constant_charge_voltage_max_uv;
> +	}
> +
> +	ret = bq25790_set_ichrg_curr(bq,
> +				bat_info.constant_charge_current_max_ua);
> +	if (ret)
> +		goto err_out;
> +
> +	ret = bq25790_set_prechrg_curr(bq, bat_info.precharge_current_ua);
> +	if (ret)
> +		goto err_out;
> +
> +	ret = bq25790_set_chrg_volt(bq,
> +				bat_info.constant_charge_voltage_max_uv);
> +	if (ret)
> +		goto err_out;
> +
> +	ret = bq25790_set_term_curr(bq, bat_info.charge_term_current_ua);
> +	if (ret)
> +		goto err_out;
> +
> +	ret = bq25790_set_input_volt_lim(bq, bq->init_data.vlim);
> +	if (ret)
> +		goto err_out;
> +
> +	ret = bq25790_set_input_curr_lim(bq, bq->init_data.ilim);
> +	if (ret)
> +		goto err_out;
> +
> +err_out:
> +	return ret;
> +}
> +
> +static int bq25790_parse_dt(struct bq25790_device *bq)
> +{
> +	int ret;
> +
> +	ret = device_property_read_u32(bq->dev, "ti,watchdog-timer",
> +				       &bq->watchdog_timer);
> +	if (ret)
> +		bq->watchdog_timer = BQ25790_WATCHDOG_DIS;
> +
> +	if (bq->watchdog_timer > BQ25790_WATCHDOG_MAX ||
> +	    bq->watchdog_timer < BQ25790_WATCHDOG_DIS)
> +		return -EINVAL;
> +
> +	ret = device_property_read_u32(bq->dev,
> +				       "input-voltage-limit-microvolt",
> +				       &bq->init_data.vlim);
> +	if (ret)
> +		bq->init_data.vlim = BQ25790_VINDPM_DEF_uV;
> +
> +	if (bq->init_data.vlim > BQ25790_VINDPM_V_MAX_uV ||
> +	    bq->init_data.vlim < BQ25790_VINDPM_V_MIN_uV)
> +		return -EINVAL;
> +
> +	ret = device_property_read_u32(bq->dev,
> +				       "input-current-limit-microamp",
> +				       &bq->init_data.ilim);
> +	if (ret)
> +		bq->init_data.ilim = BQ25790_IINDPM_DEF_uA;
> +
> +	if (bq->init_data.ilim > BQ25790_IINDPM_I_MAX_uA ||
> +	    bq->init_data.ilim < BQ25790_IINDPM_I_MIN_uA)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int bq25790_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct bq25790_device *bq;
> +	int ret;
> +
> +	bq = devm_kzalloc(dev, sizeof(*bq), GFP_KERNEL);
> +	if (!bq)
> +		return -ENOMEM;
> +
> +	bq->client = client;
> +	bq->dev = dev;
> +
> +	mutex_init(&bq->lock);
> +
> +	strncpy(bq->model_name, id->name, I2C_NAME_SIZE);
> +
> +	bq->regmap = devm_regmap_init_i2c(client, &bq25790_regmap_config);
> +	if (IS_ERR(bq->regmap)) {
> +		dev_err(dev, "Failed to allocate register map\n");
> +		return PTR_ERR(bq->regmap);
> +	}
> +
> +	i2c_set_clientdata(client, bq);
> +
> +	ret = bq25790_parse_dt(bq);
> +	if (ret) {
> +		dev_err(dev, "Failed to read device tree properties%d\n", ret);
> +		return ret;
> +	}
> +
> +	/* OTG reporting */
> +	bq->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
> +	if (!IS_ERR_OR_NULL(bq->usb2_phy)) {
> +		INIT_WORK(&bq->usb_work, bq25790_usb_work);
> +		bq->usb_nb.notifier_call = bq25790_usb_notifier;
> +		usb_register_notifier(bq->usb2_phy, &bq->usb_nb);
> +	}
> +
> +	bq->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
> +	if (!IS_ERR_OR_NULL(bq->usb3_phy)) {
> +		INIT_WORK(&bq->usb_work, bq25790_usb_work);
> +		bq->usb_nb.notifier_call = bq25790_usb_notifier;
> +		usb_register_notifier(bq->usb3_phy, &bq->usb_nb);
> +	}
> +
> +	if (client->irq) {
> +		ret = devm_request_threaded_irq(dev, client->irq, NULL,
> +						bq25790_irq_handler_thread,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						dev_name(&client->dev), bq);
> +		if (ret)
> +			goto error_out;
> +	}
> +
> +	ret = bq25790_power_supply_init(bq, dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register power supply\n");
> +		goto error_out;
> +	}
> +
> +	ret = bq25790_hw_init(bq);
> +	if (ret) {
> +		dev_err(dev, "Cannot initialize the chip.\n");
> +		goto error_out;
> +	}
> +
> +	return ret;
> +error_out:
> +	if (!IS_ERR_OR_NULL(bq->usb2_phy))
> +		usb_unregister_notifier(bq->usb2_phy, &bq->usb_nb);
> +
> +	if (!IS_ERR_OR_NULL(bq->usb3_phy))
> +		usb_unregister_notifier(bq->usb3_phy, &bq->usb_nb);
> +	return ret;
> +}
> +
> +static const struct i2c_device_id bq25790_i2c_ids[] = {
> +	{ BQ25790_NAME, 0 },
> +	{ BQ25792_NAME, 1 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, bq25790_i2c_ids);
> +
> +static const struct of_device_id bq25790_of_match[] = {
> +	{ .compatible = "ti,bq25790", },
> +	{ .compatible = "ti,bq25792", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, bq25790_of_match);
> +
> +static const struct acpi_device_id bq25790_acpi_match[] = {
> +	{BQ25790_NAME, 0},
> +	{BQ25792_NAME, 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, bq25790_acpi_match);
> +
> +static struct i2c_driver bq25790_driver = {
> +	.driver = {
> +		.name = "bq25790-charger",
> +		.of_match_table = bq25790_of_match,
> +		.acpi_match_table = ACPI_PTR(bq25790_acpi_match),
> +	},
> +	.probe = bq25790_probe,
> +	.id_table = bq25790_i2c_ids,
> +};
> +module_i2c_driver(bq25790_driver);
> +
> +MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
> +MODULE_AUTHOR("Ricardo Rivera-Matos <r-rivera-matos@ti.com>");
> +MODULE_DESCRIPTION("bq25790 charger driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/power/supply/bq25790_charger.h b/drivers/power/supply/bq25790_charger.h
> new file mode 100644
> index 000000000000..77234e116a6b
> --- /dev/null
> +++ b/drivers/power/supply/bq25790_charger.h
> @@ -0,0 +1,150 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +// BQ25790 Charger Driver
> +// Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
> +
> +#ifndef _BQ25790_CHARGER_H
> +#define _BQ25790_CHARGER_H
> +
> +#define BQ25790_MANUFACTURER	"Texas Instruments"
> +#define BQ25790_NAME		"bq25790"
> +#define BQ25792_NAME		"bq25792"
> +
> +#define BQ25790_MIN_SYS_V	0x00
> +#define BQ25790_CHRG_V_LIM_MSB	0x01
> +#define BQ25790_CHRG_V_LIM_LSB	0x02
> +#define BQ25790_CHRG_I_LIM_MSB	0x03
> +#define BQ25790_CHRG_I_LIM_LSB	0x04
> +#define BQ25790_INPUT_V_LIM	0x05
> +#define BQ25790_INPUT_I_LIM_MSB	0x06
> +#define BQ25790_INPUT_I_LIM_LSB	0x07
> +#define BQ25790_PRECHRG_CTRL	0x08
> +#define BQ25790_TERM_CTRL	0x09
> +#define BQ25790_RECHRG_CTRL	0x0a
> +#define BQ25790_VOTG_REG	0x0b
> +#define BQ25790_IOTG_REG	0x0d
> +#define BQ25790_TIMER_CTRL	0x0e
> +#define BQ25790_CHRG_CTRL_0	0x0f
> +#define BQ25790_CHRG_CTRL_1	0x10
> +#define BQ25790_CHRG_CTRL_2	0x11
> +#define BQ25790_CHRG_CTRL_3	0x12
> +#define BQ25790_CHRG_CTRL_4	0x13
> +#define BQ25790_CHRG_CTRL_5	0x14
> +#define BQ25790_MPPT_CTRL	0x15
> +#define BQ25790_TEMP_CTRL	0x16
> +#define BQ25790_NTC_CTRL_0	0x17
> +#define BQ25790_NTC_CTRL_1	0x18
> +#define BQ25790_ICO_I_LIM	0x19
> +#define BQ25790_CHRG_STAT_0	0x1b
> +#define BQ25790_CHRG_STAT_1	0x1c
> +#define BQ25790_CHRG_STAT_2	0x1d
> +#define BQ25790_CHRG_STAT_3	0x1e
> +#define BQ25790_CHRG_STAT_4	0x1f
> +#define BQ25790_FAULT_STAT_0	0x20
> +#define BQ25790_FAULT_STAT_1	0x21
> +#define BQ25790_CHRG_FLAG_0	0x22
> +#define BQ25790_CHRG_FLAG_1	0x23
> +#define BQ25790_CHRG_FLAG_2	0x24
> +#define BQ25790_CHRG_FLAG_3	0x25
> +#define BQ25790_FAULT_FLAG_0	0x26
> +#define BQ25790_FAULT_FLAG_1	0x27
> +#define BQ25790_CHRG_MSK_0	0x28
> +#define BQ25790_CHRG_MSK_1	0x29
> +#define BQ25790_CHRG_MSK_2	0x2a
> +#define BQ25790_CHRG_MSK_3	0x2b
> +#define BQ25790_FAULT_MSK_0	0x2c
> +#define BQ25790_FAULT_MSK_1	0x2d
> +#define BQ25790_ADC_CTRL	0x2e
> +#define BQ25790_FN_DISABE_0	0x2f
> +#define BQ25790_FN_DISABE_1	0x30
> +#define BQ25790_ADC_IBUS	0x31
> +#define BQ25790_ADC_IBAT_MSB	0x33
> +#define BQ25790_ADC_IBAT_LSB	0x34
> +#define BQ25790_ADC_VBUS_MSB	0x35
> +#define BQ25790_ADC_VBUS_LSB	0x36
> +#define BQ25790_ADC_VAC1	0x37
> +#define BQ25790_ADC_VAC2	0x39
> +#define BQ25790_ADC_VBAT_MSB	0x3b
> +#define BQ25790_ADC_VBAT_LSB	0x3c
> +#define BQ25790_ADC_VSYS_MSB	0x3d
> +#define BQ25790_ADC_VSYS_LSB	0x3e
> +#define BQ25790_ADC_TS		0x3f
> +#define BQ25790_ADC_TDIE	0x41
> +#define BQ25790_ADC_DP		0x43
> +#define BQ25790_ADC_DM		0x45
> +#define BQ25790_DPDM_DRV	0x47
> +#define BQ25790_PART_INFO	0x48
> +
> +#define BQ25790_CHRG_EN		BIT(5)
> +#define BQ25790_ADC_EN		BIT(7)
> +
> +/* Charger Status 1 */
> +#define BQ25790_CHG_STAT_MSK	GENMASK(7, 5)
> +#define BQ25790_NOT_CHRGING	0
> +#define BQ25790_TRICKLE_CHRG	BIT(5)
> +#define BQ25790_PRECHRG		BIT(6)
> +#define BQ25790_FAST_CHRG	(BIT(5) | BIT(6))
> +#define BQ25790_TAPER_CHRG	BIT(7)
> +#define BQ25790_TOP_OFF_CHRG	(BIT(6) | BIT(7))
> +#define BQ25790_TERM_CHRG	(BIT(5) | BIT(6) | BIT(7))
> +#define BQ25790_VBUS_PRESENT	BIT(0)
> +
> +#define BQ25790_VBUS_STAT_MSK	GENMASK(4, 1)
> +#define BQ25790_USB_SDP		BIT(1)
> +#define BQ25790_USB_CDP		BIT(2)
> +#define BQ25790_USB_DCP		(BIT(1) | BIT(2))
> +#define BQ25790_HVDCP		BIT(3)
> +#define BQ25790_UNKNOWN_3A	(BIT(3) | BIT(1))
> +#define BQ25790_NON_STANDARD	(BIT(3) | BIT(2))
> +#define BQ25790_OTG_MODE	(BIT(3) | BIT(2) | BIT(1))
> +#define BQ25790_UNQUAL_ADAPT	BIT(4)
> +#define BQ25790_DIRECT_PWR	(BIT(4) | BIT(2) | BIT(1))
> +
> +/* Charger Status 4 */
> +#define BQ25790_TEMP_HOT	BIT(0)
> +#define BQ25790_TEMP_WARM	BIT(1)
> +#define BQ25790_TEMP_COOL	BIT(2)
> +#define BQ25790_TEMP_COLD	BIT(3)
> +#define BQ25790_TEMP_MASK	GENMASK(3, 0)
> +
> +#define BQ25790_OTG_OVP		BIT(5)
> +#define BQ25790_VSYS_OVP	BIT(6)
> +#define BQ25790_VSYS_STAT	BIT(4)
> +
> +#define BQ25790_PRECHRG_CUR_MASK		GENMASK(5, 0)
> +#define BQ25790_PRECHRG_CURRENT_STEP_uA		40000
> +#define BQ25790_PRECHRG_I_MIN_uA		40000
> +#define BQ25790_PRECHRG_I_MAX_uA		2000000
> +#define BQ25790_PRECHRG_I_DEF_uA		120000
> +#define BQ25790_TERMCHRG_CUR_MASK		GENMASK(4, 0)
> +#define BQ25790_TERMCHRG_CURRENT_STEP_uA	40000
> +#define BQ25790_TERMCHRG_I_MIN_uA		40000
> +#define BQ25790_TERMCHRG_I_MAX_uA		1000000
> +#define BQ25790_TERMCHRG_I_DEF_uA		200000
> +#define BQ25790_ICHRG_CURRENT_STEP_uA		10000
> +#define BQ25790_ICHRG_I_MIN_uA			50000
> +#define BQ25790_ICHRG_I_MAX_uA			5000000
> +#define BQ25790_ICHRG_I_DEF_uA			1000000
> +
> +#define BQ25790_VREG_V_MAX_uV	18800000
> +#define BQ25790_VREG_V_MIN_uV	3000000
> +#define BQ25790_VREG_V_DEF_uV	3600000
> +#define BQ25790_VREG_V_STEP_uV	10000
> +
> +#define BQ25790_IINDPM_I_MIN_uA	100000
> +#define BQ25790_IINDPM_I_MAX_uA	3300000
> +#define BQ25790_IINDPM_STEP_uA	10000
> +#define BQ25790_IINDPM_DEF_uA	1000000
> +
> +#define BQ25790_VINDPM_V_MIN_uV 3600000
> +#define BQ25790_VINDPM_V_MAX_uV 22000000
> +#define BQ25790_VINDPM_STEP_uV	100000
> +#define BQ25790_VINDPM_DEF_uV	3600000
> +
> +#define BQ25790_ADC_VOLT_STEP_uV	1000
> +#define BQ25790_ADC_CURR_STEP_uA	1000
> +
> +#define BQ25790_WATCHDOG_MASK	GENMASK(2, 0)
> +#define BQ25790_WATCHDOG_DIS	0
> +#define BQ25790_WATCHDOG_MAX	160000
> +
> +#endif /* _BQ25790_CHARGER_H */
