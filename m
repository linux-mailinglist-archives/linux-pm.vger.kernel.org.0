Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6022A14013F
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 02:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgAQBBz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 20:01:55 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34324 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729439AbgAQBBz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 20:01:55 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 4D0BE29330B
Received: by earth.universe (Postfix, from userid 1000)
        id 939F03C0C7E; Fri, 17 Jan 2020 02:01:47 +0100 (CET)
Date:   Fri, 17 Jan 2020 02:01:47 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] power: supply: bq2515x: Introduce the bq2515x
 family
Message-ID: <20200117010147.upgm2nkgb73u2rvd@earth.universe>
References: <20200116175039.1317-1-dmurphy@ti.com>
 <20200116175039.1317-5-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5lh6l3twaz3s4z5g"
Content-Disposition: inline
In-Reply-To: <20200116175039.1317-5-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--5lh6l3twaz3s4z5g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Thu, Jan 16, 2020 at 11:50:39AM -0600, Dan Murphy wrote:
> Introduce the bq25150 and bq25155 supply chargers.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/power/supply/Kconfig           |   8 +
>  drivers/power/supply/Makefile          |   1 +
>  drivers/power/supply/bq2515x_charger.c | 739 +++++++++++++++++++++++++
>  3 files changed, 748 insertions(+)
>  create mode 100644 drivers/power/supply/bq2515x_charger.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 27164a1d3c7c..ee9f4b29e0b7 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -589,6 +589,14 @@ config CHARGER_BQ24735
>  	help
>  	  Say Y to enable support for the TI BQ24735 battery charger.
> =20
> +config CHARGER_BQ2515X
> +	tristate "TI BQ2515X battery charger family"
> +	depends on I2C
> +	depends on GPIOLIB || COMPILE_TEST
> +	select REGMAP_I2C
> +	help
> +	  Say Y to enable support for the TI BQ2515X battery charger.
> +
>  config CHARGER_BQ25890
>  	tristate "TI BQ25890 battery charger driver"
>  	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 6c7da920ea83..8fcc175a7e22 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -80,6 +80,7 @@ obj-$(CONFIG_CHARGER_BQ2415X)	+=3D bq2415x_charger.o
>  obj-$(CONFIG_CHARGER_BQ24190)	+=3D bq24190_charger.o
>  obj-$(CONFIG_CHARGER_BQ24257)	+=3D bq24257_charger.o
>  obj-$(CONFIG_CHARGER_BQ24735)	+=3D bq24735-charger.o
> +obj-$(CONFIG_CHARGER_BQ2515X)	+=3D bq2515x_charger.o
>  obj-$(CONFIG_CHARGER_BQ25890)	+=3D bq25890_charger.o
>  obj-$(CONFIG_CHARGER_SMB347)	+=3D smb347-charger.o
>  obj-$(CONFIG_CHARGER_TPS65090)	+=3D tps65090-charger.o
> diff --git a/drivers/power/supply/bq2515x_charger.c b/drivers/power/suppl=
y/bq2515x_charger.c
> new file mode 100644
> index 000000000000..dbf84bef4976
> --- /dev/null
> +++ b/drivers/power/supply/bq2515x_charger.c
> @@ -0,0 +1,739 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// BQ2515X Battery Charger Driver
> +// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>

Correct include is <linux/gpio/consumer.h>

> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +
> +#define BQ2515X_MANUFACTURER "Texas Instruments"
> +
> +#define BQ2515X_STAT0		0x00
> +#define BQ2515X_STAT1		0x01
> +#define BQ2515X_STAT2		0x02
> +#define BQ2515X_FLAG0		0x03
> +#define BQ2515X_FLAG1		0x04
> +#define BQ2515X_FLAG2		0x05
> +#define BQ2515X_FLAG3		0x06
> +#define BQ2515X_MASK0		0x07
> +#define BQ2515X_MASK1		0x08
> +#define BQ2515X_MASK2		0x09
> +#define BQ2515X_MASK3		0x0a
> +#define BQ2515X_VBAT_CTRL	0x12
> +#define BQ2515X_ICHG_CTRL	0x13
> +#define BQ2515X_PCHRGCTRL	0x14
> +#define BQ2515X_TERMCTRL	0x15
> +#define BQ2515X_BUVLO		0x16
> +#define BQ2515X_CHARGERCTRL0	0x17
> +#define BQ2515X_CHARGERCTRL1	0x18
> +#define BQ2515X_ILIMCTRL	0x19
> +#define BQ2515X_LDOCTRL		0x1d
> +#define BQ2515X_MRCTRL		0x30
> +#define BQ2515X_ICCTRL0		0x35
> +#define BQ2515X_ICCTRL1		0x36
> +#define BQ2515X_ICCTRL2		0x37
> +#define BQ2515X_ADCCTRL0	0x40
> +#define BQ2515X_ADCCTRL1	0x41
> +#define BQ2515X_ADC_VBAT_M	0x42
> +#define BQ2515X_ADC_VBAT_L	0x43
> +#define BQ2515X_ADC_TS_M	0x44
> +#define BQ2515X_ADC_TS_L	0x45
> +#define BQ2515X_ADC_ICHG_M	0x46
> +#define BQ2515X_ADC_ICHG_L	0x47
> +#define BQ2515X_ADC_ADCIN_M	0x48
> +#define BQ2515X_ADC_ADCIN_L	0x49
> +#define BQ2515X_ADC_VIN_M	0x4a
> +#define BQ2515X_ADC_VIN_L	0x4b
> +#define BQ2515X_ADC_PMID_M	0x4c
> +#define BQ2515X_ADC_PMID_L	0x4d
> +#define BQ2515X_ADC_IIN_M	0x4e
> +#define BQ2515X_ADC_IIN_L	0x4f
> +#define BQ2515X_ADC_COMP1_M	0x52
> +#define BQ2515X_ADC_COMP1_L	0X53
> +#define BQ2515X_ADC_COMP2_M	0X54
> +#define BQ2515X_ADC_COMP2_L	0x55
> +#define BQ2515X_ADC_COMP3_M	0x56
> +#define BQ2515X_ADC_COMP3_L	0x57
> +#define BQ2515X_ADC_READ_EN	0x58
> +#define BQ2515X_TS_FASTCHGCTRL	0x61
> +#define BQ2515X_TS_COLD		0x62
> +#define BQ2515X_TS_COOL		0x63
> +#define BQ2515X_TS_WARM		0x64
> +#define BQ2515X_TS_HOT		0x65
> +#define BQ2515X_DEVICE_ID	0x6f
> +
> +#define BQ2515X_DIVISOR		65536
> +#define BQ2515X_VBAT_BASE_VOLT	3600000
> +#define BQ2515X_VBAT_REG_MAX	4600000
> +#define BQ2515X_VBAT_REG_MIN	3600000
> +#define BQ2515X_UV_FACTOR	10000
> +
> +#define BQ2515X_ILIM_150MA	0x2
> +#define BQ2515X_ILIM_MASK	0x7
> +#define BQ2515X_HEALTH_MASK	0xf
> +#define BQ2515X_OVERVOLT_MASK	0x80
> +
> +#define BQ2515X_HOT_FLAG	BIT(0)
> +#define BQ2515X_WARM_FLAG	BIT(1)
> +#define BQ2515X_COOL_FLAG	BIT(2)
> +#define BQ2515X_COLD_FLAG	BIT(3)
> +#define BQ2515X_SAFETY_TIMER_EXP	BIT(5)
> +
> +#define BQ2515X_VIN_GOOD	BIT(0)
> +#define BQ2515X_CHRG_DONE	BIT(5)
> +#define BQ2515X_CV_CHRG_MODE	BIT(6)
> +
> +static const int bq2515x_ilim_lvl_values[] =3D {
> +	50000, 100000, 150000, 200000, 300000, 400000, 500000, 600000
> +};
> +
> +/* initial field values, converted to register values */
> +struct bq2515x_init_data {
> +	int ichg;	/* charge current */
> +	int vreg;	/* regulation voltage */
> +};
> +
> +struct bq2515x_device {
> +	struct power_supply *mains;
> +	struct power_supply *battery;
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct mutex lock;
> +
> +	struct gpio_desc *reset_gpio;
> +	struct gpio_desc *lp_gpio;
> +	struct gpio_desc *pg_gpio;
> +	struct gpio_desc *ce_gpio;
> +
> +	char model_name[I2C_NAME_SIZE];
> +	int mains_online;

bool?

> +	uint32_t voltage_min_design;
> +	uint32_t voltage_max_design;
> +	uint32_t charge_full_design;
> +
> +	struct bq2515x_init_data init_data;
> +};
> +
> +static struct reg_default bq2515x_reg_defs[] =3D {
> +	{BQ2515X_STAT0, 0xff},
> +	{BQ2515X_STAT1, 0x0},
> +	{BQ2515X_STAT2, 0x0},
> +	{BQ2515X_FLAG0, 0x0},
> +	{BQ2515X_FLAG1, 0x0},
> +	{BQ2515X_FLAG2, 0x0},
> +	{BQ2515X_FLAG3, 0x0},
> +	{BQ2515X_MASK0, 0x0},
> +	{BQ2515X_MASK1, 0x0},
> +	{BQ2515X_MASK2, 0x0},
> +	{BQ2515X_MASK3, 0x0},
> +};
> +
> +static bool bq2515x_is_ps_online(struct bq2515x_device *bq2515x)
> +{
> +	return bq2515x->mains_online;
> +}
> +
> +static int bq2515x_wake_up(struct bq2515x_device *bq2515x)
> +{
> +	int ret;
> +	int val;
> +
> +	/* Read the STAT register if we can read it then the device is out
> +	 * of ship mode.  If the register cannot be read then attempt to wake
> +	 * it up and enable the ADC.
> +	 */
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_STAT0, &val);
> +	if (!ret)
> +		return ret;
> +
> +	/* Need to toggle LP and MR here */
> +	if (bq2515x->lp_gpio)
> +		gpiod_direction_output(bq2515x->lp_gpio, 1);
> +
> +	if (bq2515x->reset_gpio) {
> +		gpiod_direction_output(bq2515x->lp_gpio, 0);
> +		mdelay(2000);
> +		gpiod_direction_output(bq2515x->lp_gpio, 1);
> +	}

gpiod_set_value_cansleep()

> +	return regmap_write(bq2515x->regmap, BQ2515X_ADC_READ_EN, BIT(3));
> +}
> +
> +static int bq2515x_update_ps_status(struct bq2515x_device *bq2515x)
> +{
> +	bool dc =3D false;
> +	unsigned int val;
> +	int ret;
> +
> +	if (bq2515x->pg_gpio)
> +		val =3D gpiod_get_value(bq2515x->pg_gpio);

Should be ok to call gpiod_get_value_cansleep().

> +	else {
> +		ret =3D regmap_read(bq2515x->regmap, BQ2515X_STAT0, &val);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	dc =3D val & BQ2515X_VIN_GOOD;
> +
> +	ret =3D bq2515x->mains_online !=3D dc;
> +
> +	bq2515x->mains_online =3D dc;
> +
> +	return ret;
> +}
> +
> +static int get_const_charge_current(struct bq2515x_device *bq2515x)
> +{
> +	int ret;
> +	int iin_msb;
> +	int iin_lsb;
> +	u16 ichg_measurement;
> +	int ilim_val, ichg_multiplier;
> +
> +	if (!bq2515x_is_ps_online(bq2515x))
> +		return -ENODATA;
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_ADC_IIN_M, &iin_msb);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_ADC_IIN_L, &iin_lsb);
> +	if (ret < 0)
> +		return ret;
> +
> +	ichg_measurement =3D (iin_msb << 8) | iin_lsb;
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_ILIMCTRL, &ilim_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ilim_val >=3D BQ2515X_ILIM_150MA)
> +		ichg_multiplier =3D 350;
> +	else
> +		ichg_multiplier =3D 750;
> +
> +	return (ichg_measurement * 100 / BQ2515X_DIVISOR) * ichg_multiplier;
> +}
> +
> +static int get_const_charge_voltage(struct bq2515x_device *bq2515x)
> +{
> +	int ret;
> +	int vin_msb;
> +	int vin_lsb;
> +	u16 vbat_measurement;
> +
> +	if (!bq2515x_is_ps_online(bq2515x))
> +		bq2515x_wake_up(bq2515x);

Is it intentional, that get_const_charge_current returns -ENODATA
and this get_const_charge_voltage just wakes up the device without
AC being connected?

> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_ADC_VBAT_M, &vin_msb);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_ADC_VBAT_L, &vin_lsb);
> +	if (ret)
> +		return ret;
> +
> +	vbat_measurement =3D (vin_msb << 8) | vin_lsb;
> +	return ((vbat_measurement * BQ2515X_UV_FACTOR) / BQ2515X_DIVISOR) * 6;
> +}
> +
> +static int bq2515x_charging_status(struct bq2515x_device *bq2515x,
> +				   union power_supply_propval *val)
> +{
> +	unsigned int status;
> +	int ret;
> +
> +	if (!bq2515x_is_ps_online(bq2515x))

val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;

> +		return 0;
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_STAT0, &status);
> +	if (ret) {
> +		val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;

You can drop val->intval assignment, since you return an error
anyways.

> +		return ret;
> +	}
> +
> +	if (status & BQ2515X_CV_CHRG_MODE && status & BQ2515X_VIN_GOOD)
> +		val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +	else if (status & BQ2515X_CHRG_DONE)
> +		val->intval =3D POWER_SUPPLY_STATUS_FULL;
> +	else if (status & BQ2515X_VIN_GOOD)
> +		val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +	else
> +		val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +
> +	return ret;
> +}
> +
> +static int bq2515x_get_batt_reg(struct bq2515x_device *bq2515x)
> +{
> +	int vbat_reg_code;
> +	int ret;
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_VBAT_CTRL, &vbat_reg_code);
> +	if (ret)
> +		return ret;
> +
> +	return BQ2515X_VBAT_BASE_VOLT + vbat_reg_code * BQ2515X_UV_FACTOR;
> +}
> +
> +static int bq2515x_set_batt_reg(struct bq2515x_device *bq2515x, int val)
> +{
> +	int vbat_reg_code;
> +
> +	if (val > BQ2515X_VBAT_REG_MAX || val < BQ2515X_VBAT_REG_MIN)
> +		return -EINVAL;
> +
> +	vbat_reg_code =3D (val - BQ2515X_VBAT_BASE_VOLT) / BQ2515X_UV_FACTOR;
> +
> +	return regmap_write(bq2515x->regmap, BQ2515X_VBAT_CTRL, vbat_reg_code);
> +}
> +
> +static int bq2515x_get_ilim_lvl(struct bq2515x_device *bq2515x)
> +{
> +	int ret;
> +	int val;
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_ILIMCTRL, &val);
> +	if (ret)
> +		return ret;
> +
> +	return bq2515x_ilim_lvl_values[val & BQ2515X_ILIM_MASK];
> +}
> +
> +static int bq2515x_set_ilim_lvl(struct bq2515x_device *bq2515x, int val)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(bq2515x_ilim_lvl_values); i++) {
> +		if (val =3D=3D bq2515x_ilim_lvl_values[i])
> +			break;
> +
> +		if (val > bq2515x_ilim_lvl_values[i - 1] &&
> +		    val < bq2515x_ilim_lvl_values[i]) {
> +			if (val - bq2515x_ilim_lvl_values[i - 1] <
> +			    bq2515x_ilim_lvl_values[i] - val) {
> +				i =3D i - 1;
> +				break;
> +			}
> +		}
> +	}
> +
> +	return regmap_write(bq2515x->regmap, BQ2515X_ILIMCTRL, i);
> +}
> +
> +static int bq2515x_power_supply_property_is_writeable(struct power_suppl=
y *psy,
> +					enum power_supply_property prop)
> +{
> +	switch (prop) {
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +	case POWER_SUPPLY_PROP_CHARGE_NOW:

You probably do not want to use this property, it is used by
batteries to expose the uAh currently available (i.e. 3000mAh /
7000mAh).

> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int bq2515x_charger_get_health(struct bq2515x_device *bq2515x,
> +				      union power_supply_propval *val)
> +{
> +	int health;
> +	int ret;
> +	int v;
> +
> +	if (!bq2515x_is_ps_online(bq2515x))
> +		bq2515x_wake_up(bq2515x);
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_FLAG1, &v);
> +	if (ret)
> +		return -EIO;
> +
> +	if (v & BQ2515X_HEALTH_MASK) {
> +		switch (v & BQ2515X_HEALTH_MASK) {
> +		case BQ2515X_HOT_FLAG:
> +			health =3D POWER_SUPPLY_HEALTH_HOT;
> +			break;
> +		case BQ2515X_WARM_FLAG:
> +			health =3D POWER_SUPPLY_HEALTH_WARM;
> +			break;
> +		case BQ2515X_COOL_FLAG:
> +			health =3D POWER_SUPPLY_HEALTH_COOL;
> +			break;
> +		case BQ2515X_COLD_FLAG:
> +			health =3D POWER_SUPPLY_HEALTH_COLD;
> +			break;
> +		default:
> +			health =3D POWER_SUPPLY_HEALTH_UNKNOWN;
> +		}
> +	} else if (v & BQ2515X_OVERVOLT_MASK) {
> +		health =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +	} else {
> +		health =3D POWER_SUPPLY_HEALTH_GOOD;
> +	}
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_FLAG3, &v);
> +	if (v & BQ2515X_SAFETY_TIMER_EXP)
> +		health =3D POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
> +
> +	val->intval =3D health;
> +
> +	return 0;
> +}
> +
> +static int bq2515x_set_charge_enable(struct bq2515x_device *bq2515x, int=
 val)
> +{
> +	if (bq2515x->ce_gpio)
> +		gpiod_set_value(bq2515x->ce_gpio, val);

gpiod_set_value_cansleep() ?

Also it should return without doing anything if the supplied gpio is
NULL, so you can drop the protection.

> +
> +	return 0;
> +}
> +
> +static int bq2515x_get_charge_enable(struct bq2515x_device *bq2515x)
> +{
> +	int charge_value;
> +
> +	if (bq2515x->ce_gpio)
> +		charge_value =3D gpiod_get_value(bq2515x->ce_gpio);
> +	else
> +		return -EINVAL;
> +
> +	return charge_value;
> +}

Maybe just

{
    if (!bq2515x->ce_gpio)
        return -EINVAL;

    return gpiod_get_value_cansleep(bq2515x->ce_gpio);
}

> +static int bq2515x_mains_set_property(struct power_supply *psy,
> +		enum power_supply_property prop,
> +		const union power_supply_propval *val)
> +{
> +	struct bq2515x_device *bq2515x =3D power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	switch (prop) {
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret =3D bq2515x_set_ilim_lvl(bq2515x, val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		ret =3D bq2515x_set_batt_reg(bq2515x, val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
> +		ret =3D bq2515x_set_charge_enable(bq2515x, val->intval);
> +		break;

As I guessed the wrong property is used. Make the STATUS property
writable instead.

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int bq2515x_mains_get_property(struct power_supply *psy,
> +				     enum power_supply_property prop,
> +				     union power_supply_propval *val)
> +{
> +	struct bq2515x_device *bq2515x =3D power_supply_get_drvdata(psy);
> +	int ret;

ret =3D 0;

> +
> +	switch (prop) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D bq2515x->mains_online;
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		ret =3D get_const_charge_current(bq2515x);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;

if (!ret)
    val->intval =3D ret;

> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret =3D bq2515x_get_ilim_lvl(bq2515x);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;

(see above)

> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		ret =3D bq2515x_get_batt_reg(bq2515x);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;

(see above)

> +		break;
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		val->strval =3D bq2515x->model_name;
> +		ret =3D 0;

ret =3D 0 can be removed (after my suggested change).

> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval =3D BQ2515X_MANUFACTURER;
> +		ret =3D 0;

ret =3D 0 can be removed (after my suggested change).

> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> +		val->intval =3D BQ2515X_VBAT_REG_MAX;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +		val->intval =3D BQ2515X_VBAT_REG_MIN;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
> +		ret =3D bq2515x_get_charge_enable(bq2515x);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;

(see above)

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;

return ret;

> +}
> +
> +static int bq2515x_battery_get_property(struct power_supply *psy,
> +				       enum power_supply_property prop,
> +				       union power_supply_propval *val)
> +{
> +	struct bq2515x_device *bq2515x =3D power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	ret =3D bq2515x_update_ps_status(bq2515x);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (prop) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		if (!bq2515x_is_ps_online(bq2515x)) {
> +			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +			break;
> +		}
> +
> +		ret =3D bq2515x_charging_status(bq2515x, val);
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret =3D get_const_charge_voltage(bq2515x);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> +		val->intval =3D bq2515x->voltage_min_design;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +		val->intval =3D bq2515x->voltage_max_design;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +		val->intval =3D bq2515x->charge_full_design;
> +		break;
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		ret =3D bq2515x_charger_get_health(bq2515x, val);
> +		if (ret)
> +			val->intval =3D POWER_SUPPLY_HEALTH_UNKNOWN;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static enum power_supply_property bq2515x_battery_properties[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +};
> +
> +static enum power_supply_property bq2515x_charger_properties[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
> +static struct power_supply_desc bq2515x_mains_desc =3D {
> +	.name			=3D "bq2515x-mains",
> +	.type			=3D POWER_SUPPLY_TYPE_MAINS,
> +	.get_property		=3D bq2515x_mains_get_property,
> +	.set_property		=3D bq2515x_mains_set_property,
> +	.properties		=3D bq2515x_charger_properties,
> +	.num_properties		=3D ARRAY_SIZE(bq2515x_charger_properties),
> +	.property_is_writeable =3D bq2515x_power_supply_property_is_writeable,
> +
> +};
> +
> +static struct power_supply_desc bq2515x_battery_desc =3D {
> +	.name			=3D "bq2515x-battery",
> +	.type			=3D POWER_SUPPLY_TYPE_BATTERY,
> +	.get_property		=3D bq2515x_battery_get_property,
> +	.properties		=3D bq2515x_battery_properties,
> +	.num_properties		=3D ARRAY_SIZE(bq2515x_battery_properties),
> +};
> +
> +
> +static int bq2515x_power_supply_register(struct bq2515x_device *bq2515x)
> +{
> +	struct power_supply_config psy_cfg =3D { .drv_data =3D bq2515x, };
> +
> +	bq2515x->mains =3D devm_power_supply_register(bq2515x->dev,
> +						    &bq2515x_mains_desc,
> +						    &psy_cfg);
> +	if (IS_ERR(bq2515x->mains))
> +		return -EINVAL;
> +
> +	bq2515x->battery =3D devm_power_supply_register(bq2515x->dev,
> +						      &bq2515x_battery_desc,
> +						      &psy_cfg);
> +	if (IS_ERR(bq2515x->battery))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int bq2515x_hw_init(struct bq2515x_device *bq2515x)
> +{
> +	int ret =3D 0;
> +
> +	if (bq2515x->init_data.ichg)
> +		ret =3D bq2515x_set_ilim_lvl(bq2515x, bq2515x->init_data.ichg);
> +
> +	if (ret)
> +		goto err_out;
> +
> +	if (bq2515x->init_data.vreg)
> +		ret =3D bq2515x_set_batt_reg(bq2515x, bq2515x->init_data.vreg);
> +
> +err_out:
> +	return ret;
> +}
> +
> +static int bq2515x_read_properties(struct bq2515x_device *bq2515x)
> +{
> +	int ret;
> +
> +	ret =3D device_property_read_u32(bq2515x->dev,
> +				      "constant-charge-current-max-microamp",
> +				      &bq2515x->init_data.ichg);
> +	if (ret)
> +		bq2515x->init_data.ichg =3D bq2515x_ilim_lvl_values[1];
> +
> +	ret =3D device_property_read_u32(bq2515x->dev,
> +				      "constant-charge-voltage-max-microvolt",
> +				      &bq2515x->init_data.vreg);
> +	if (ret)
> +		bq2515x->init_data.vreg =3D 4200000;
> +
> +
> +	bq2515x->pg_gpio =3D devm_gpiod_get_optional(bq2515x->dev,
> +						   "pg", GPIOD_IN);
> +	if (IS_ERR(bq2515x->pg_gpio))
> +		dev_info(bq2515x->dev, "PG GPIO not defined");

Let's name the GPIO "ac-detect" in DT, which is descriptive.

> +	bq2515x->reset_gpio =3D devm_gpiod_get_optional(bq2515x->dev,
> +						   "reset", GPIOD_OUT_LOW);
> +
> +	if (PTR_ERR(bq2515x->reset_gpio) =3D=3D -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
> +	bq2515x->lp_gpio =3D devm_gpiod_get_optional(bq2515x->dev, "low-power",
> +						   GPIOD_OUT_LOW);
> +	if (PTR_ERR(bq2515x->lp_gpio) =3D=3D -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
> +	bq2515x->ce_gpio =3D devm_gpiod_get_optional(bq2515x->dev,
> +						   "charge-enable",
> +						   GPIOD_OUT_HIGH);
> +	if (PTR_ERR(bq2515x->ce_gpio) =3D=3D -EPROBE_DEFER)
> +		return -EPROBE_DEFER;

You silently drop any error from devm_gpiod_get_optional(),
which does not seem like a good idea. I suggest to just
error out on any problem, since there will be only errors
when the GPIO is described in DT (or ACPI/...).

> +	return ret;
> +}
> +
> +static const struct regmap_config bq2515x_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +
> +	.max_register =3D BQ2515X_DEVICE_ID,
> +	.reg_defaults     =3D bq2515x_reg_defs,
> +	.num_reg_defaults =3D ARRAY_SIZE(bq2515x_reg_defs),
> +	.cache_type	  =3D REGCACHE_RBTREE,
> +};

Thanks for using regmap :)

> +static int bq2515x_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct bq2515x_device *bq;
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
> +	bq->regmap =3D devm_regmap_init_i2c(client, &bq2515x_regmap_config);
> +	if (IS_ERR(bq->regmap)) {
> +		dev_err(dev, "failed to allocate register map\n");
> +		return PTR_ERR(bq->regmap);
> +	}
> +
> +	strncpy(bq->model_name, id->name, I2C_NAME_SIZE);
> +
> +	i2c_set_clientdata(client, bq);
> +
> +	ret =3D bq2515x_read_properties(bq);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to register power supply %d\n", ret);

Wrong error message?

> +		return ret;
> +	}
> +
> +	ret =3D bq2515x_hw_init(bq);
> +	if (ret < 0) {
> +		dev_err(dev, "Cannot initialize the chip.\n");
> +		return ret;
> +	}
> +
> +	return bq2515x_power_supply_register(bq);
> +}
> +
> +static const struct i2c_device_id bq2515x_i2c_ids[] =3D {
> +	{ "bq25150", 0 },
> +	{ "bq25155", 1 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, bq2515x_i2c_ids);
> +
> +static const struct of_device_id bq2515x_of_match[] =3D {
> +	{ .compatible =3D "ti,bq25150", },
> +	{ .compatible =3D "ti,bq25155", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, bq2515x_of_match);
> +
> +static struct i2c_driver bq2515x_driver =3D {
> +	.driver =3D {
> +		.name =3D "bq2515x-charger",
> +		.of_match_table =3D bq2515x_of_match,
> +	},
> +	.probe =3D bq2515x_probe,
> +	.id_table =3D bq2515x_i2c_ids,
> +};
> +module_i2c_driver(bq2515x_driver);
> +
> +MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
> +MODULE_DESCRIPTION("BQ2515X charger driver");
> +MODULE_LICENSE("GPL v2");

So apart from the things above, I have two general issues:

1. Exposing a battery device from the charger should be avoided.
   Userspace assumes that every battery device is a separate
   device. When the charger exposes a battery there are to devices
   for the same physical device.

2. The properties "constant-charge-current-max-microamp" and
   "constant-charge-voltage-max-microvolt" are battery properties,
   that should be put into a battery node and consumed by the
   charger. There is a nice helper function available to do this:

   power_supply_get_battery_info()

   The idea is to improve this in the future, so that a fuel
   gauge consumes this and becomes a smart battery. Then the
   charger asks the smart battery for any required battery
   information. This is not yet ready, though. So for now the
   charger should fetch the information from the simple-battery
   node.

-- Sebastian

--5lh6l3twaz3s4z5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl4hB3cACgkQ2O7X88g7
+pokhQ/6A1H3czSeLQfrzW9og1PPfHg+Ow6nRJGXC+qSI7DluogmYN0plUFoEHbB
GaVbVoVWzEeiyLTYARp7Cym3AyAYAgYZ43uhPFWKV8fjNY89w7ZwH6Mlf53gP2uz
xoubO546lMM2ltDtGs78aKzUrEVzcvn5QVuRdLb4rOcRVl/U2IUrViHDUhxML+Jx
1iCgZ35qxhJxiGhiD1LC3fBjW+74jFwlOjkBThNDFdBFYYKSB0npkB0RqpQWhZRo
gWGyNqemJSd2l11JkGS2Jh7/iPMx0sMU3zo16v0v+qb+RcyNV0jMYsJjFHARrhUF
YAiWPNVyVtklhaASg8pkjXdlHgQq2+BzJwxi4Wir3MadklDv1064/NcTgOheeZPs
hzxLmtgVSgWEEU3v6QP4R7B+Wo9rnu8A9XyxQME6u9LTmQksvS3VuqI6gI7PZcZ4
SyNr5NuROvCKvN47mMmpO1TNAqgNl1+KnxvUhOlEx+nrYypwjhkN7D0Lr3SWkZPd
M/6Mic1ohLuosb2WvXnq52ZUMd6aGPoMIkOogcpIh7VQQQjcxjW+GbFnxEo6hlw6
8JhhCm78P2BVxk8rHKqEKvHer++Ny0DYIy9xowFRYG+qJ4LJRuwGWgTJvZLkzicg
SDJoOyjtcpn5wwVtGRCn7ncT/mB1uUSHcY924vpbZdWRXWY0t84=
=k5Lz
-----END PGP SIGNATURE-----

--5lh6l3twaz3s4z5g--
