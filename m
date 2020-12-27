Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EACD2E3278
	for <lists+linux-pm@lfdr.de>; Sun, 27 Dec 2020 19:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgL0Src (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Dec 2020 13:47:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgL0Src (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 27 Dec 2020 13:47:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DF3420866;
        Sun, 27 Dec 2020 18:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609094809;
        bh=4V3nFHBnfucjDCvjXPp38XRULKM04UJt8ONtC9xv47Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gkjvyJelRt0iAy2O14KQoGGAz3dhRkzSCVmIMBp2MQGMTqMEk4Qk8rnXrikCQYvd3
         xOtL6zYSKVK0IgDfFvUBUbhNcckMTtm5SzmYC4CG5qa1dVSu8Z5zyiNv9J9tykdxV0
         dydHWCwleURwwebskwWwph+MBUrco8+G2/to3ro1imvdLOqnl/RaP632XG+08nboU9
         1Sd2cXTCcqtHKsOccdYTOWDyCTsXXu+PFyaEJAGM98LwtkyQJ4ZF5lOnxV8SaHI87O
         BLcHrhuiZolay/zK95u0egEL9KRkfeg18eUnEkteJaaCWFIhIUqmU7cLuamzwowpwJ
         V/4bHItjJb1rQ==
Received: by earth.universe (Postfix, from userid 1000)
        id 4D2D93C0C93; Sun, 27 Dec 2020 19:46:47 +0100 (CET)
Date:   Sun, 27 Dec 2020 19:46:47 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Subject: Re: [PATCH v4 2/2] power: supply: bq25790: Introduce the BQ25790
 charger driver
Message-ID: <20201227184647.4v27d2xyuhjpcl4r@earth.universe>
References: <20201009144112.3007-1-dmurphy@ti.com>
 <20201009144112.3007-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="edcxhzs3op3e3irg"
Content-Disposition: inline
In-Reply-To: <20201009144112.3007-2-dmurphy@ti.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--edcxhzs3op3e3irg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry, took me a lot longer than expected...

On Fri, Oct 09, 2020 at 09:41:12AM -0500, Dan Murphy wrote:
> BQ25790 is a highly integrated switch-mode buck-boost charger
> for 1-4 cell Li-ion battery and Li-polymer battery.
>=20
> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/power/supply/Kconfig           |    8 +
>  drivers/power/supply/Makefile          |    1 +
>  drivers/power/supply/bq25790_charger.c | 1121 ++++++++++++++++++++++++
>  drivers/power/supply/bq25790_charger.h |  150 ++++
>  4 files changed, 1280 insertions(+)
>  create mode 100644 drivers/power/supply/bq25790_charger.c
>  create mode 100644 drivers/power/supply/bq25790_charger.h
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index eec646c568b7..1cc361238d9a 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -628,6 +628,14 @@ config CHARGER_BQ2515X
>  	  rail, ADC for battery and system monitoring, and push-button
>  	  controller.
> =20
> +config CHARGER_BQ25790
> +	tristate "TI BQ25790 battery charger driver"
> +	depends on I2C
> +	depends on GPIOLIB || COMPILE_TEST
> +	select REGMAP_I2C
> +	help
> +	  Say Y to enable support for the TI BQ25790 battery charger.
> +
>  config CHARGER_BQ25890
>  	tristate "TI BQ25890 battery charger driver"
>  	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index dd4b86318cd9..29b71cc92550 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -83,6 +83,7 @@ obj-$(CONFIG_CHARGER_BQ24190)	+=3D bq24190_charger.o
>  obj-$(CONFIG_CHARGER_BQ24257)	+=3D bq24257_charger.o
>  obj-$(CONFIG_CHARGER_BQ24735)	+=3D bq24735-charger.o
>  obj-$(CONFIG_CHARGER_BQ2515X)	+=3D bq2515x_charger.o
> +obj-$(CONFIG_CHARGER_BQ25790)	+=3D bq25790_charger.o
>  obj-$(CONFIG_CHARGER_BQ25890)	+=3D bq25890_charger.o
>  obj-$(CONFIG_CHARGER_BQ25980)	+=3D bq25980_charger.o
>  obj-$(CONFIG_CHARGER_SMB347)	+=3D smb347-charger.o
> diff --git a/drivers/power/supply/bq25790_charger.c b/drivers/power/suppl=
y/bq25790_charger.c
> new file mode 100644
> index 000000000000..838a49c2f9f0
> --- /dev/null
> +++ b/drivers/power/supply/bq25790_charger.c
> @@ -0,0 +1,1121 @@
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
> +static struct reg_default bq25790_reg_defs[] =3D {
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
> +static int bq25790_watchdog_time[BQ25790_NUM_WD_VAL] =3D {0, 500, 1000, =
2000,
> +							20000, 40000, 80000,
> +							160000};
> +
> +static enum power_supply_usb_type bq25790_usb_type[] =3D {
> +	POWER_SUPPLY_USB_TYPE_PD_DRP,
> +	POWER_SUPPLY_USB_TYPE_SDP,
> +	POWER_SUPPLY_USB_TYPE_CDP,
> +	POWER_SUPPLY_USB_TYPE_DCP,
> +	POWER_SUPPLY_USB_TYPE_UNKNOWN,
> +};
> +
> +static int bq25790_usb_notifier(struct notifier_block *nb, unsigned long=
 val,
> +				void *priv)
> +{
> +	struct bq25790_device *bq =3D
> +			container_of(nb, struct bq25790_device, usb_nb);
> +
> +	bq->usb_event =3D val;
> +	queue_work(system_power_efficient_wq, &bq->usb_work);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static void bq25790_usb_work(struct work_struct *data)
> +{
> +	struct bq25790_device *bq =3D
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
> +}
> +
> +static int bq25790_get_vbat_adc(struct bq25790_device *bq)
> +{
> +	int ret;
> +	int vbat_adc_lsb, vbat_adc_msb;
> +	u16 vbat_adc;
> +
> +	ret =3D regmap_read(bq->regmap, BQ25790_ADC_VBAT_MSB, &vbat_adc_msb);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(bq->regmap, BQ25790_ADC_VBAT_LSB, &vbat_adc_lsb);
> +	if (ret)
> +		return ret;
> +
> +	vbat_adc =3D (vbat_adc_msb << 8) | vbat_adc_lsb;
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
> +	ret =3D regmap_update_bits(bq->regmap, BQ25790_ADC_CTRL,
> +				 BQ25790_ADC_EN, BQ25790_ADC_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(bq->regmap, BQ25790_ADC_VBUS_MSB, &vbus_adc_msb);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(bq->regmap, BQ25790_ADC_VBUS_LSB, &vbus_adc_lsb);
> +	if (ret)
> +		return ret;
> +
> +	vbus_adc =3D (vbus_adc_msb << 8) | vbus_adc_lsb;
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
> +	ret =3D regmap_read(bq->regmap, BQ25790_ADC_IBAT_MSB, &ibat_adc_msb);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(bq->regmap, BQ25790_ADC_IBAT_LSB, &ibat_adc_lsb);
> +	if (ret)
> +		return ret;
> +
> +	ibat_adc =3D (ibat_adc_msb << 8) | ibat_adc_lsb;
> +
> +	return ibat_adc * BQ25790_ADC_CURR_STEP_uA;
> +}
> +
> +static int bq25790_get_term_curr(struct bq25790_device *bq)
> +{
> +	int ret;
> +	int reg_val;
> +
> +	ret =3D regmap_read(bq->regmap, BQ25790_TERM_CTRL, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	reg_val &=3D BQ25790_TERMCHRG_CUR_MASK;
> +
> +	return reg_val * BQ25790_TERMCHRG_CURRENT_STEP_uA;
> +}
> +
> +static int bq25790_get_prechrg_curr(struct bq25790_device *bq)
> +{
> +	int ret;
> +	int reg_val;
> +
> +	ret =3D regmap_read(bq->regmap, BQ25790_PRECHRG_CTRL, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	reg_val &=3D BQ25790_PRECHRG_CUR_MASK;
> +
> +	return reg_val * BQ25790_PRECHRG_CURRENT_STEP_uA;
> +}
> +
> +static int bq25790_get_ichg_curr(struct bq25790_device *bq)
> +{
> +	int ret;
> +	int ichg, ichg_lsb, ichg_msb;
> +
> +	ret =3D regmap_read(bq->regmap, BQ25790_CHRG_I_LIM_LSB, &ichg_lsb);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(bq->regmap, BQ25790_CHRG_I_LIM_MSB, &ichg_msb);
> +	if (ret)
> +		return ret;
> +
> +	ichg =3D (ichg_msb << 8) | ichg_lsb;
> +
> +	return ichg * BQ25790_ICHRG_CURRENT_STEP_uA;
> +}
> +
> +static int bq25790_set_term_curr(struct bq25790_device *bq, int term_cur=
rent)
> +{
> +	int reg_val;
> +
> +	if (term_current < BQ25790_TERMCHRG_I_MIN_uA ||
> +	    term_current > BQ25790_TERMCHRG_I_MAX_uA)
> +		return -EINVAL;
> +
> +	reg_val =3D term_current / BQ25790_TERMCHRG_CURRENT_STEP_uA;
> +
> +	return regmap_update_bits(bq->regmap, BQ25790_TERM_CTRL,
> +				  BQ25790_TERMCHRG_CUR_MASK, reg_val);
> +}
> +
> +static int bq25790_set_prechrg_curr(struct bq25790_device *bq, int pre_c=
urrent)
> +{
> +	int reg_val;
> +
> +	if (pre_current < BQ25790_PRECHRG_I_MIN_uA ||
> +	    pre_current > BQ25790_PRECHRG_I_MAX_uA)
> +		return -EINVAL;
> +
> +	reg_val =3D pre_current / BQ25790_PRECHRG_CURRENT_STEP_uA;
> +
> +	return regmap_update_bits(bq->regmap, BQ25790_PRECHRG_CTRL,
> +				  BQ25790_PRECHRG_CUR_MASK, reg_val);
> +}
> +
> +static int bq25790_set_ichrg_curr(struct bq25790_device *bq, int chrg_cu=
rr)
> +{
> +	int ret;
> +	int ichg, ichg_msb, ichg_lsb;
> +
> +	if (chrg_curr < BQ25790_ICHRG_I_MIN_uA ||
> +	    chrg_curr > BQ25790_ICHRG_I_MAX_uA)
> +		return -EINVAL;
> +
> +	ichg =3D chrg_curr / BQ25790_ICHRG_CURRENT_STEP_uA;
> +	ichg_msb =3D (ichg >> 8) & 0xff;
> +	ret =3D regmap_write(bq->regmap, BQ25790_CHRG_I_LIM_MSB, ichg_msb);
> +	if (ret)
> +		return ret;
> +
> +	ichg_lsb =3D ichg & 0xff;
> +
> +	return regmap_write(bq->regmap, BQ25790_CHRG_I_LIM_LSB, ichg_lsb);
> +}
> +
> +static int bq25790_set_chrg_volt(struct bq25790_device *bq, int chrg_vol=
t)
> +{
> +	int vlim_lsb, vlim_msb, vlim;
> +	int ret;
> +
> +	if (chrg_volt < BQ25790_VREG_V_MIN_uV ||
> +	    chrg_volt > BQ25790_VREG_V_MAX_uV)
> +		return -EINVAL;
> +
> +	vlim =3D chrg_volt / BQ25790_VREG_V_STEP_uV;
> +	vlim_msb =3D (vlim >> 8) & 0xff;
> +	ret =3D regmap_write(bq->regmap, BQ25790_CHRG_V_LIM_MSB, vlim_msb);
> +	if (ret)
> +		return ret;
> +
> +	vlim_lsb =3D vlim & 0xff;
> +
> +	return regmap_write(bq->regmap, BQ25790_CHRG_V_LIM_LSB, vlim_lsb);
> +}
> +
> +static int bq25790_get_chrg_volt(struct bq25790_device *bq)
> +{
> +	int ret;
> +	int vlim_lsb, vlim_msb, chrg_volt;
> +
> +	ret =3D regmap_read(bq->regmap, BQ25790_CHRG_V_LIM_MSB, &vlim_msb);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(bq->regmap, BQ25790_CHRG_V_LIM_LSB, &vlim_lsb);
> +	if (ret)
> +		return ret;
> +
> +	chrg_volt =3D (vlim_msb << 8) | vlim_lsb;
> +
> +	return chrg_volt * BQ25790_VREG_V_STEP_uV;
> +}
> +
> +static int bq25790_set_input_volt_lim(struct bq25790_device *bq, int vin=
dpm)
> +{
> +	int ret;
> +	int vlim_lsb, vlim_msb;
> +	int vlim;
> +
> +	if (vindpm < BQ25790_VINDPM_V_MIN_uV ||
> +	    vindpm > BQ25790_VINDPM_V_MAX_uV)
> +		return -EINVAL;
> +
> +	vlim =3D vindpm / BQ25790_VINDPM_STEP_uV;
> +
> +	vlim_msb =3D (vlim >> 8) & 0xff;
> +
> +	ret =3D regmap_write(bq->regmap, BQ25790_CHRG_V_LIM_MSB, vlim_msb);
> +	if (ret)
> +		return ret;
> +
> +	vlim_lsb =3D vlim & 0xff;
> +
> +	return regmap_write(bq->regmap, BQ25790_CHRG_V_LIM_LSB, vlim_lsb);
> +}
> +
> +static int bq25790_get_input_volt_lim(struct bq25790_device *bq)
> +{
> +	int ret;
> +	int vlim;
> +
> +	ret =3D regmap_read(bq->regmap, BQ25790_INPUT_V_LIM, &vlim);
> +	if (ret)
> +		return ret;
> +
> +	return vlim * BQ25790_VINDPM_STEP_uV;
> +}
> +
> +static int bq25790_set_input_curr_lim(struct bq25790_device *bq, int iin=
dpm)
> +{
> +	int ret;
> +	int ilim, ilim_lsb, ilim_msb;
> +
> +	if (iindpm < BQ25790_IINDPM_I_MIN_uA ||
> +	    iindpm > BQ25790_IINDPM_I_MAX_uA)
> +		return -EINVAL;
> +
> +	ilim =3D iindpm / BQ25790_IINDPM_STEP_uA;
> +	ilim_msb =3D (ilim >> 8) & 0xff;
> +
> +	ret =3D regmap_write(bq->regmap, BQ25790_INPUT_I_LIM_MSB, ilim_msb);
> +	if (ret)
> +		return ret;
> +
> +	ilim_lsb =3D ilim & 0xff;
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
> +	ret =3D regmap_read(bq->regmap, BQ25790_INPUT_I_LIM_MSB, &ilim_msb);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(bq->regmap, BQ25790_INPUT_I_LIM_LSB, &ilim_lsb);
> +	if (ret)
> +		return ret;
> +
> +	ilim =3D (ilim_msb << 8) | ilim_lsb;
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
> +	ret =3D regmap_read(bq->regmap, BQ25790_CHRG_STAT_0, &chrg_stat_0);
> +	if (ret)
> +		return ret;
> +
> +	state->vbus_status =3D chrg_stat_0 & BQ25790_VBUS_PRESENT;
> +
> +	ret =3D regmap_read(bq->regmap, BQ25790_CHRG_STAT_1, &chrg_stat_1);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(bq->regmap, BQ25790_CHRG_CTRL_0, &chrg_ctrl_0);
> +	if (ret)
> +		return ret;
> +
> +	if (chrg_ctrl_0 & BQ25790_CHRG_EN)
> +		state->chrg_status =3D chrg_stat_1 & BQ25790_CHG_STAT_MSK;
> +	else
> +		state->chrg_status =3D BQ25790_NOT_CHRGING;
> +
> +	state->chrg_type =3D chrg_stat_1 & BQ25790_VBUS_STAT_MSK;
> +
> +	ret =3D regmap_read(bq->regmap, BQ25790_CHRG_STAT_4, &chrg_stat_4);
> +	if (ret)
> +		return ret;
> +
> +	state->health =3D chrg_stat_4 & BQ25790_TEMP_MASK;
> +
> +	ret =3D regmap_read(bq->regmap, BQ25790_FAULT_STAT_0, &fault_0);
> +	if (ret)
> +		return ret;
> +
> +	state->fault_0 =3D fault_0;
> +
> +	ret =3D regmap_read(bq->regmap, BQ25790_FAULT_STAT_1, &fault_1);
> +	if (ret)
> +		return ret;
> +
> +	state->fault_1 =3D fault_1;
> +
> +	ret =3D regmap_read(bq->regmap, BQ25790_CHRG_STAT_3, &chrg_stat_3);
> +	if (ret)
> +		return ret;
> +
> +	state->online =3D chrg_stat_3 & BQ25790_VSYS_STAT;
> +
> +	state->vbat_adc =3D bq25790_get_vbat_adc(bq);
> +
> +	state->vbus_adc =3D bq25790_get_vbus_adc(bq);
> +
> +	state->ibat_adc =3D bq25790_get_ibat_adc(bq);
> +
> +	return 0;
> +}
> +
> +static int bq25790_set_property(struct power_supply *psy,
> +		enum power_supply_property prop,
> +		const union power_supply_propval *val)
> +{
> +	struct bq25790_device *bq =3D power_supply_get_drvdata(psy);
> +	int ret =3D -EINVAL;
> +
> +	switch (prop) {
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret =3D bq25790_set_input_curr_lim(bq, val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		ret =3D bq25790_set_chrg_volt(bq, val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		ret =3D bq25790_set_ichrg_curr(bq, val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +		ret =3D bq25790_set_prechrg_curr(bq, val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +		ret =3D bq25790_set_term_curr(bq, val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		break;

what's the point of exposing PROP_STATUS and always returning
EINVAL?

> +	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
> +		ret =3D bq25790_set_input_volt_lim(bq, val->intval);
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
> +	struct bq25790_device *bq =3D power_supply_get_drvdata(psy);
> +	struct bq25790_state state;
> +	int ret =3D 0;
> +
> +	mutex_lock(&bq->lock);
> +	ret =3D bq25790_get_state(bq, &state);
> +	mutex_unlock(&bq->lock);

useless lock, since state is a function local variable.

> +	if (ret)
> +		return ret;
> +
> +	switch (psp) {

please be consistent with newlines after break :)

> +	case POWER_SUPPLY_PROP_STATUS:
> +		if (!state.chrg_type || (state.chrg_type =3D=3D BQ25790_OTG_MODE))
> +			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		else if (!state.chrg_status)
> +			val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		else if (state.chrg_status =3D=3D BQ25790_TERM_CHRG)
> +			val->intval =3D POWER_SUPPLY_STATUS_FULL;
> +		else
> +			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		switch (state.chrg_status) {
> +		case BQ25790_TRICKLE_CHRG:
> +			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +			break;
> +		case BQ25790_PRECHRG:
> +			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +			break;
> +		case BQ25790_FAST_CHRG:
> +			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_FAST;
> +			break;
> +		case BQ25790_TAPER_CHRG:
> +			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_STANDARD;
> +			break;
> +		case BQ25790_TOP_OFF_CHRG:
> +			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +			break;
> +		case BQ25790_NOT_CHRGING:
> +			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_NONE;
> +			break;
> +		default:
> +			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
> +		}
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval =3D BQ25790_MANUFACTURER;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		val->strval =3D BQ25790_NAME;

I think it's better to report bq->model_name (and otherwise that
field is unused :))

> +		break;
> +
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D state.online;
> +		break;
> +	case POWER_SUPPLY_PROP_USB_TYPE:
> +		if (!state.chrg_type) {
> +			val->intval =3D POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +			break;
> +		}
> +		switch (state.chrg_type) {
> +		case BQ25790_USB_SDP:
> +			val->intval =3D POWER_SUPPLY_USB_TYPE_SDP;
> +			break;
> +		case BQ25790_USB_CDP:
> +			val->intval =3D POWER_SUPPLY_USB_TYPE_CDP;
> +			break;
> +		case BQ25790_USB_DCP:
> +			val->intval =3D POWER_SUPPLY_USB_TYPE_DCP;
> +			break;
> +		case BQ25790_OTG_MODE:
> +			val->intval =3D POWER_SUPPLY_USB_TYPE_PD_DRP;
> +			break;
> +
> +		default:
> +			val->intval =3D POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +			break;
> +		}
> +		break;
> +
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		if (state.fault_1 & (BQ25790_OTG_OVP | BQ25790_VSYS_OVP))
> +			val->intval =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +		else
> +			val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
> +
> +		switch (state.health) {
> +		case BQ25790_TEMP_HOT:
> +			val->intval =3D POWER_SUPPLY_HEALTH_HOT;
> +			break;
> +		case BQ25790_TEMP_WARM:
> +			val->intval =3D POWER_SUPPLY_HEALTH_WARM;
> +			break;
> +		case BQ25790_TEMP_COOL:
> +			val->intval =3D POWER_SUPPLY_HEALTH_COOL;
> +			break;
> +		case BQ25790_TEMP_COLD:
> +			val->intval =3D POWER_SUPPLY_HEALTH_COLD;
> +			break;
> +		}
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		ret =3D bq25790_get_ichg_curr(bq);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		ret =3D bq25790_get_chrg_volt(bq);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +		ret =3D bq25790_get_prechrg_curr(bq);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +		ret =3D bq25790_get_term_curr(bq);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval =3D state.vbus_adc;
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
> +		ret =3D bq25790_get_input_volt_lim(bq);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret =3D bq25790_get_input_curr_lim(bq);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
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
> +	struct bq25790_device *bq =3D power_supply_get_drvdata(psy);
> +	struct bq25790_state state;
> +	int ret =3D 0;
> +
> +	mutex_lock(&bq->lock);
> +	ret =3D bq25790_get_state(bq, &state);
> +	mutex_unlock(&bq->lock);

another useless lock, since state is also a function local variable
in this place.

> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(bq->regmap, BQ25790_ADC_CTRL,
> +				 BQ25790_ADC_EN, BQ25790_ADC_EN);
> +	if (ret)
> +		return ret;

why is ADC enabled here?

> +
> +	switch (psp) {

please also be consistent with newline after break in this
switch statement.

> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		val->intval =3D bq->init_data.ichg_max;
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +		val->intval =3D bq->init_data.vreg_max;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval =3D state.vbat_adc;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		val->intval =3D state.ibat_adc;
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
> +	old_state =3D bq->state;
> +	mutex_unlock(&bq->lock);
> +
> +	return (old_state.chrg_status !=3D new_state->chrg_status ||
> +		old_state.chrg_fault !=3D new_state->chrg_fault	||
> +		old_state.online !=3D new_state->online		||
> +		old_state.health !=3D new_state->health	||
> +		old_state.fault_0 !=3D new_state->fault_0 ||
> +		old_state.fault_1 !=3D new_state->fault_1 ||
> +		old_state.chrg_type !=3D new_state->chrg_type ||
> +		old_state.vsys_status !=3D new_state->vsys_status ||
> +		old_state.vbat_adc !=3D new_state->vbat_adc ||
> +		old_state.vbus_adc !=3D new_state->vbus_adc ||
> +		old_state.ibat_adc !=3D new_state->ibat_adc);
> +}
> +
> +static irqreturn_t bq25790_irq_handler_thread(int irq, void *private)
> +{
> +	struct bq25790_device *bq =3D private;
> +	struct bq25790_state state;
> +	int ret;
> +
> +	ret =3D bq25790_get_state(bq, &state);
> +	if (ret < 0)
> +		goto irq_out;
> +
> +	if (!bq25790_state_changed(bq, &state))
> +		goto irq_out;
> +
> +	mutex_lock(&bq->lock);
> +	bq->state =3D state;
> +	mutex_unlock(&bq->lock);
> +
> +	power_supply_changed(bq->charger);
> +
> +irq_out:
> +	return IRQ_HANDLED;
> +}
> +
> +static enum power_supply_property bq25790_power_supply_props[] =3D {
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
> +static enum power_supply_property bq25790_battery_props[] =3D {
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +};
> +
> +static char *bq25790_charger_supplied_to[] =3D {
> +	"main-battery",
> +};

why do you need this? Usually this information should come from
platform data (e.g. DT).

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
> +static const struct power_supply_desc bq25790_power_supply_desc =3D {
> +	.name =3D "bq25790-charger",
> +	.type =3D POWER_SUPPLY_TYPE_USB,
> +	.usb_types =3D bq25790_usb_type,
> +	.num_usb_types =3D ARRAY_SIZE(bq25790_usb_type),
> +	.properties =3D bq25790_power_supply_props,
> +	.num_properties =3D ARRAY_SIZE(bq25790_power_supply_props),
> +	.get_property =3D bq25790_get_property,
> +	.set_property =3D bq25790_set_property,
> +	.property_is_writeable =3D bq25790_property_is_writeable,
> +};
> +
> +static const struct power_supply_desc bq25790_battery_desc =3D {
> +	.name =3D "bq25790-battery",
> +	.type =3D POWER_SUPPLY_TYPE_BATTERY,
> +	.get_property =3D bq25790_battery_get_property,
> +	.properties =3D bq25790_battery_props,
> +	.num_properties =3D ARRAY_SIZE(bq25790_battery_props),
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
> +static const struct regmap_config bq25790_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +
> +	.max_register =3D BQ25790_PART_INFO,
> +	.reg_defaults	=3D bq25790_reg_defs,
> +	.num_reg_defaults =3D ARRAY_SIZE(bq25790_reg_defs),
> +	.cache_type =3D REGCACHE_RBTREE,

There are no holes in the register map, so REGCACHE_FLAT
should be enough.

> +	.volatile_reg =3D bq25790_is_volatile_reg,
> +};
> +
> +static int bq25790_power_supply_init(struct bq25790_device *bq,
> +							struct device *dev)
> +{
> +	struct power_supply_config psy_cfg =3D { .drv_data =3D bq,
> +						.of_node =3D dev->of_node, };
> +
> +	psy_cfg.supplied_to =3D bq25790_charger_supplied_to;
> +	psy_cfg.num_supplicants =3D ARRAY_SIZE(bq25790_charger_supplied_to);
> +
> +	bq->charger =3D devm_power_supply_register(bq->dev,
> +						 &bq25790_power_supply_desc,
> +						 &psy_cfg);
> +	if (IS_ERR(bq->charger))
> +		return -EINVAL;
> +
> +	bq->battery =3D devm_power_supply_register(bq->dev,
> +						      &bq25790_battery_desc,
> +						      &psy_cfg);
> +	if (IS_ERR(bq->battery))
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +static int bq25790_hw_init(struct bq25790_device *bq)
> +{
> +	struct power_supply_battery_info bat_info =3D { };
> +	int wd_reg_val =3D BQ25790_WATCHDOG_DIS;
> +	int wd_max_val =3D BQ25790_NUM_WD_VAL - 1;
> +	int ret =3D 0;
> +	int i;
> +
> +	if (bq->watchdog_timer) {
> +		if (bq->watchdog_timer >=3D bq25790_watchdog_time[wd_max_val])
> +			wd_reg_val =3D wd_max_val;
> +		else {
> +			for (i =3D 0; i < wd_max_val; i++) {
> +				if (bq->watchdog_timer > bq25790_watchdog_time[i] &&
> +				    bq->watchdog_timer < bq25790_watchdog_time[i + 1]) {
> +					wd_reg_val =3D i;
> +					break;
> +				}
> +			}
> +		}
> +	}
> +
> +	ret =3D regmap_update_bits(bq->regmap, BQ25790_CHRG_CTRL_1,
> +				 BQ25790_WATCHDOG_MASK, wd_reg_val);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D power_supply_get_battery_info(bq->charger, &bat_info);
> +	if (ret) {
> +		dev_warn(bq->dev, "battery info missing, default values will be applie=
d\n");
> +
> +		bat_info.constant_charge_current_max_ua =3D
> +							BQ25790_ICHRG_I_DEF_uA;
> +
> +		bat_info.constant_charge_voltage_max_uv =3D
> +							BQ25790_VREG_V_DEF_uV;
> +
> +		bat_info.precharge_current_ua =3D BQ25790_PRECHRG_I_DEF_uA;
> +		bat_info.charge_term_current_ua =3D BQ25790_TERMCHRG_I_DEF_uA;
> +		bq->init_data.ichg_max =3D BQ25790_ICHRG_I_MAX_uA;
> +		bq->init_data.vreg_max =3D BQ25790_VREG_V_MAX_uV;
> +	} else {
> +		bq->init_data.ichg_max =3D
> +				bat_info.constant_charge_current_max_ua;
> +
> +		bq->init_data.vreg_max =3D
> +				bat_info.constant_charge_voltage_max_uv;
> +	}
> +
> +	ret =3D bq25790_set_ichrg_curr(bq,
> +				bat_info.constant_charge_current_max_ua);
> +	if (ret)
> +		goto err_out;
> +
> +	ret =3D bq25790_set_prechrg_curr(bq, bat_info.precharge_current_ua);
> +	if (ret)
> +		goto err_out;
> +
> +	ret =3D bq25790_set_chrg_volt(bq,
> +				bat_info.constant_charge_voltage_max_uv);
> +	if (ret)
> +		goto err_out;
> +
> +	ret =3D bq25790_set_term_curr(bq, bat_info.charge_term_current_ua);
> +	if (ret)
> +		goto err_out;
> +
> +	ret =3D bq25790_set_input_volt_lim(bq, bq->init_data.vlim);
> +	if (ret)
> +		goto err_out;
> +
> +	ret =3D bq25790_set_input_curr_lim(bq, bq->init_data.ilim);
> +	if (ret)
> +		goto err_out;
> +
> +err_out:
> +	return ret;

You need to call power_supply_put_battery_info(), since the
struct contains some pointers with allocated data.

> +}
> +
> +static int bq25790_parse_dt(struct bq25790_device *bq)
> +{
> +	int ret;
> +
> +	ret =3D device_property_read_u32(bq->dev, "ti,watchdog-timeout-ms",
> +				       &bq->watchdog_timer);
> +	if (ret)
> +		bq->watchdog_timer =3D BQ25790_WATCHDOG_DIS;
> +
> +	if (bq->watchdog_timer > BQ25790_WATCHDOG_MAX ||
> +	    bq->watchdog_timer < BQ25790_WATCHDOG_DIS)
> +		return -EINVAL;
> +
> +	ret =3D device_property_read_u32(bq->dev,
> +				       "input-voltage-limit-microvolt",
> +				       &bq->init_data.vlim);
> +	if (ret)
> +		bq->init_data.vlim =3D BQ25790_VINDPM_DEF_uV;
> +
> +	if (bq->init_data.vlim > BQ25790_VINDPM_V_MAX_uV ||
> +	    bq->init_data.vlim < BQ25790_VINDPM_V_MIN_uV)
> +		return -EINVAL;
> +
> +	ret =3D device_property_read_u32(bq->dev,
> +				       "input-current-limit-microamp",
> +				       &bq->init_data.ilim);
> +	if (ret)
> +		bq->init_data.ilim =3D BQ25790_IINDPM_DEF_uA;
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
> +	struct device *dev =3D &client->dev;
> +	struct bq25790_device *bq;
> +	int ret;
> +
> +	bq =3D devm_kzalloc(dev, sizeof(*bq), GFP_KERNEL);
> +	if (!bq)
> +		return -ENOMEM;
> +
> +	bq->client =3D client;
> +	bq->dev =3D dev;
> +
> +	mutex_init(&bq->lock);
> +
> +	strncpy(bq->model_name, id->name, I2C_NAME_SIZE);
> +
> +	bq->regmap =3D devm_regmap_init_i2c(client, &bq25790_regmap_config);
> +	if (IS_ERR(bq->regmap)) {
> +		dev_err(dev, "Failed to allocate register map\n");
> +		return PTR_ERR(bq->regmap);
> +	}
> +
> +	i2c_set_clientdata(client, bq);
> +
> +	ret =3D bq25790_parse_dt(bq);
> +	if (ret) {
> +		dev_err(dev, "Failed to read device tree properties%d\n", ret);
> +		return ret;
> +	}
> +
> +	/* OTG reporting */
> +	bq->usb2_phy =3D devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
> +	if (!IS_ERR_OR_NULL(bq->usb2_phy)) {
> +		INIT_WORK(&bq->usb_work, bq25790_usb_work);
> +		bq->usb_nb.notifier_call =3D bq25790_usb_notifier;
> +		usb_register_notifier(bq->usb2_phy, &bq->usb_nb);

You also need to unregister the usb notifiers on driver removal.
I suggest to use devm_add_action_or_reset():

static void bq25790_unregister_usb_notifier(void *data)
{
    struct bq25790_device *bq =3D (struct bq25790_device *) data;

    if (!IS_ERR_OR_NULL(bq->usb2_phy))
        usb_unregister_notifier(bq->usb2_phy, &bq->usb_nb);

    if (!IS_ERR_OR_NULL(bq->usb3_phy))
        usb_unregister_notifier(bq->usb3_phy, &bq->usb_nb);
}

ret =3D devm_add_action_or_reset(dev, bq25790_unregister_usb_notifier, bq)
if (ret)
    return ret;

-- Sebastian

> +	}
> +
> +	bq->usb3_phy =3D devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
> +	if (!IS_ERR_OR_NULL(bq->usb3_phy)) {
> +		INIT_WORK(&bq->usb_work, bq25790_usb_work);
> +		bq->usb_nb.notifier_call =3D bq25790_usb_notifier;
> +		usb_register_notifier(bq->usb3_phy, &bq->usb_nb);
> +	}
> +
> +	if (client->irq) {
> +		ret =3D devm_request_threaded_irq(dev, client->irq, NULL,
> +						bq25790_irq_handler_thread,
> +						IRQF_TRIGGER_FALLING |
> +						IRQF_ONESHOT,
> +						dev_name(&client->dev), bq);
> +		if (ret)
> +			goto error_out;
> +	}
> +
> +	ret =3D bq25790_power_supply_init(bq, dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register power supply\n");
> +		goto error_out;
> +	}
> +
> +	ret =3D bq25790_hw_init(bq);
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
> +static const struct i2c_device_id bq25790_i2c_ids[] =3D {
> +	{ BQ25790_NAME, 0 },
> +	{ BQ25792_NAME, 1 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, bq25790_i2c_ids);
> +
> +static const struct of_device_id bq25790_of_match[] =3D {
> +	{ .compatible =3D "ti,bq25790", },
> +	{ .compatible =3D "ti,bq25792", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, bq25790_of_match);
> +
> +static const struct acpi_device_id bq25790_acpi_match[] =3D {
> +	{BQ25790_NAME, 0},
> +	{BQ25792_NAME, 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, bq25790_acpi_match);
> +
> +static struct i2c_driver bq25790_driver =3D {
> +	.driver =3D {
> +		.name =3D "bq25790-charger",
> +		.of_match_table =3D bq25790_of_match,
> +		.acpi_match_table =3D ACPI_PTR(bq25790_acpi_match),
> +	},
> +	.probe =3D bq25790_probe,
> +	.id_table =3D bq25790_i2c_ids,
> +};
> +module_i2c_driver(bq25790_driver);
> +
> +MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
> +MODULE_AUTHOR("Ricardo Rivera-Matos <r-rivera-matos@ti.com>");
> +MODULE_DESCRIPTION("bq25790 charger driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/power/supply/bq25790_charger.h b/drivers/power/suppl=
y/bq25790_charger.h
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
> --=20
> 2.28.0.585.ge1cfff676549
>=20

--edcxhzs3op3e3irg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/o1osACgkQ2O7X88g7
+ppm6A//eGy09Ja+DnUYFyiCPCsIxNkCRC9MKwianbxCPOjatmWiJ89y978fpHH9
d+Cn/HOC8AeQVyEvLx2EzzFPEgbFa+aLr/6nZtD2KuFKY9IGWX7qskfJFE18XEQQ
fwQGKdMzs8d/N7nIC1j5dVDeh8LglPSxep1gHd3OTcHZD4ob3Rs6kiuLVJwNEGls
vDpCDSGuwWkLfwv5J7N6DszhrMEFrohdTDFk4/lEHHwUfu8lRFAKWhZhjnD8InAh
sWjagFX2hjHXYYEm3QgRg2OPe/TIpCRKz1vw/3WkntQ19dxqVN7laKU7UeuPvA1H
Bu5n+RSJCKZFTzVc6VBNP/fUh18R/HvGQjtujqrXu0L2Hg+CIKx/ZLkRQZou1Pky
WVTXg+Cj4B338j65BXy2CMAc4Sd7Xg4eHIqAqmMvGGNRQPhEItc3LVgo6Zyvb/3g
8flpDwXlbxHpFvg27GDEN4ewG/3KVdtxp6sqEqlZpG4S9KWKqtrjb3WJ55oDjn4S
E96WvU7SV/AU1E+yO1+VTZ84ZC3MnqX54dSUAVSw6h49tMLIMOkAERXg4qv9DL6z
qQ17cd9/KkaMt3HP3JjaGI3gjVXWqM5ey8+FrBLpasDT4uiRLIvt+F39BVQHK3N+
ZFFg2Uh6sTeDAuBN3xOHaXTBwr98YMGlOa0aWNpw3++R7cYgpmQ=
=8W+9
-----END PGP SIGNATURE-----

--edcxhzs3op3e3irg--
