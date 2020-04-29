Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEDD1BEB6B
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 00:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD2WF0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 18:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2WF0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 18:05:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D67C03C1AE;
        Wed, 29 Apr 2020 15:05:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 19BC12A2192
Received: by earth.universe (Postfix, from userid 1000)
        id 92DA63C08C6; Thu, 30 Apr 2020 00:05:22 +0200 (CEST)
Date:   Thu, 30 Apr 2020 00:05:22 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: Introduce the BQ27561 Fuel gauge
 driver
Message-ID: <20200429220522.w3likr4ywklxrkvr@earth.universe>
References: <20200417172227.28075-1-dmurphy@ti.com>
 <20200417172227.28075-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j4gnrncae3skbgwq"
Content-Disposition: inline
In-Reply-To: <20200417172227.28075-2-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--j4gnrncae3skbgwq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 17, 2020 at 12:22:27PM -0500, Dan Murphy wrote:
> Introduce the BQ27561 Fuel gauge driver from Texas Instruments. The
> driver also supports the BQ27750 as it has the same register map and
> bit mask.

Why a separate driver instead of adding support to bq27xxx? The register
map seems to be similar enough.

> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/power/supply/Kconfig      |   9 +
>  drivers/power/supply/Makefile     |   1 +
>  drivers/power/supply/bq27561_fg.c | 304 ++++++++++++++++++++++++++++++
>  3 files changed, 314 insertions(+)
>  create mode 100644 drivers/power/supply/bq27561_fg.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index f3424fdce341..febf6bf8c4ea 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -597,6 +597,15 @@ config CHARGER_BQ25890
>  	help
>  	  Say Y to enable support for the TI BQ25890 battery charger.
> =20
> +config FUEL_GAUGE_BQ27561
> +	tristate "Texas Instruments bq27561 fuel gauge driver"
> +	depends on I2C
> +	select REGMAP_I2C

good :)

> +	depends on GPIOLIB || COMPILE_TEST
> +	help
> +	 Say Y here to enable support for fuel gauge with TI bq27561
> +	 fuel gauge chips.
> +
>  config CHARGER_SMB347
>  	tristate "Summit Microelectronics SMB347 Battery Charger"
>  	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 6c7da920ea83..4e402292b276 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -81,6 +81,7 @@ obj-$(CONFIG_CHARGER_BQ24190)	+=3D bq24190_charger.o
>  obj-$(CONFIG_CHARGER_BQ24257)	+=3D bq24257_charger.o
>  obj-$(CONFIG_CHARGER_BQ24735)	+=3D bq24735-charger.o
>  obj-$(CONFIG_CHARGER_BQ25890)	+=3D bq25890_charger.o
> +obj-$(CONFIG_FUEL_GAUGE_BQ27561)	+=3D bq27561_fg.o
>  obj-$(CONFIG_CHARGER_SMB347)	+=3D smb347-charger.o
>  obj-$(CONFIG_CHARGER_TPS65090)	+=3D tps65090-charger.o
>  obj-$(CONFIG_CHARGER_TPS65217)	+=3D tps65217_charger.o
> diff --git a/drivers/power/supply/bq27561_fg.c b/drivers/power/supply/bq2=
7561_fg.c
> new file mode 100644
> index 000000000000..b9f7cdc00d2e
> --- /dev/null
> +++ b/drivers/power/supply/bq27561_fg.c
> @@ -0,0 +1,304 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// BQ27561 Fuel Gauge Driver
> +// Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
> +// Author: Dan Murphy <dmurphy@ti.com>
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/power_supply.h>
> +#include <linux/types.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/moduleparam.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +
> +#define BQ27561_REG_CNTL	0x00
> +#define BQ27561_REG_AR		0x02
> +#define BQ27561_REG_TEMP	0x06
> +#define BQ27561_REG_VOLT	0x08
> +#define BQ27561_REG_REMAIN_CAP	0x10
> +#define BQ27561_REG_BATTSTAT	0x0a
> +#define BQ27561_REG_CURRENT	0x0c
> +#define BQ27561_REG_FCC		0x12
> +#define BQ27561_REG_AVG_CURRENT	0x14
> +#define BQ27561_REG_TTE		0x16
> +#define BQ27561_REG_TTF		0x18
> +#define BQ27561_REG_CYCLECNT	0x2a
> +#define BQ27561_REG_RSOC	0x2c
> +
> +#define BQ27561_VAL_MULTIPLIER	1000
> +#define BQ27561_TEMP_K_TO_C	2732
> +#define BQ27561_TIME_MIN_TO_S	60
> +
> +#define BQ27561_BATT_DEPLETED	BIT(4)
> +#define BQ27561_BATT_CHARGED	BIT(5)
> +#define BQ27561_BATT_DISCHARGING	BIT(6)
> +
> +enum {
> +	BQ27561,
> +	BQ27750,
> +};
> +
> +struct bq27561_device {
> +	struct device *dev;
> +	struct i2c_client *client;
> +	struct power_supply *battery;
> +};
> +
> +static enum power_supply_property bq27561_properties[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
> +};
> +
> +static int bq27561_get_temp(struct bq27561_device *bq)
> +{
> +	unsigned int temp;
> +
> +	temp =3D i2c_smbus_read_word_data(bq->client, BQ27561_REG_TEMP);

please use regmap instead of direct i2c read/write commands!

> +	if (temp < 0)
> +		return temp;

so e.g. -EIO will become -0.5=B0C?

> +	return temp - BQ27561_TEMP_K_TO_C;
> +}
> +
> +static int bq27561_get_voltage(struct bq27561_device *bq)
> +{
> +	unsigned int batt_volt;
> +
> +	batt_volt =3D i2c_smbus_read_word_data(bq->client, BQ27561_REG_VOLT);
> +	if (batt_volt < 0)
> +		return batt_volt;
> +
> +	return batt_volt * BQ27561_VAL_MULTIPLIER;
> +}
> +
> +static int bq27561_get_current(struct bq27561_device *bq)
> +{
> +	unsigned int batt_curr;
> +
> +	batt_curr =3D i2c_smbus_read_word_data(bq->client, BQ27561_REG_CURRENT);
> +	if (batt_curr < 0)
> +		return batt_curr;
> +
> +	return batt_curr * BQ27561_VAL_MULTIPLIER;
> +}
> +
> +static int bq27561_get_charge_capacity(struct bq27561_device *bq)
> +{
> +	unsigned int charge_cap;
> +
> +	charge_cap =3D i2c_smbus_read_word_data(bq->client, BQ27561_REG_FCC);
> +	if (charge_cap < 0)
> +		return charge_cap;
> +
> +	return charge_cap * BQ27561_VAL_MULTIPLIER;
> +}
> +
> +static int bq27561_get_batt_status(struct bq27561_device *bq)
> +{
> +	unsigned int batt_stat;
> +	unsigned int curr;
> +	int ret;
> +
> +	batt_stat =3D i2c_smbus_read_word_data(bq->client, BQ27561_REG_BATTSTAT=
);
> +	if (batt_stat < 0)
> +		return batt_stat;
> +
> +	curr =3D i2c_smbus_read_word_data(bq->client, BQ27561_REG_CURRENT);
> +	if (curr < 0)
> +		return curr;
> +
> +	if (batt_stat & BQ27561_BATT_CHARGED)
> +		ret =3D POWER_SUPPLY_STATUS_FULL;
> +	else if (batt_stat & BQ27561_BATT_DISCHARGING || curr =3D=3D 0)
> +		ret =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +	else if (curr > 0)
> +		ret =3D POWER_SUPPLY_STATUS_CHARGING;
> +	else
> +		ret =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +
> +	return ret;
> +}
> +
> +static int bq27561_get_empty_time(struct bq27561_device *bq)
> +{
> +	unsigned int empty_time;
> +
> +	empty_time =3D i2c_smbus_read_word_data(bq->client, BQ27561_REG_TTE);
> +	if (empty_time < 0)
> +		return empty_time;
> +
> +	return empty_time * BQ27561_TIME_MIN_TO_S;
> +}
> +
> +static int bq27561_get_property(struct power_supply *psy,
> +				enum power_supply_property psp,
> +				union power_supply_propval *val)
> +{
> +	struct bq27561_device *bq =3D power_supply_get_drvdata(psy);
> +	int ret =3D 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret =3D bq27561_get_voltage(bq);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		ret =3D bq27561_get_current(bq);
> +		if (ret < 0)
> +			return ret;

current can be negative (charging vs discharging).

> +
> +		val->intval =3D ret;
> +		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		ret =3D bq27561_get_batt_status(bq);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP:
> +		val->intval =3D bq27561_get_temp(bq);
> +		break;

no error handling?

> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		ret =3D i2c_smbus_read_word_data(bq->client, BQ27561_REG_RSOC);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL:
> +		ret =3D bq27561_get_charge_capacity(bq);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
> +		ret =3D bq27561_get_empty_time(bq);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
> +		ret =3D i2c_smbus_read_word_data(bq->client, BQ27561_REG_AR);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +	default:
> +		return -EINVAL;
> +	};
> +
> +	return 0;
> +}
> +
> +static int bq27561_set_property(struct power_supply *psy,
> +				enum power_supply_property psp,
> +				const union power_supply_propval *val)
> +{
> +	struct bq27561_device *bq =3D power_supply_get_drvdata(psy);
> +	int ret =3D 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
> +		ret =3D i2c_smbus_write_word_data(bq->client, BQ27561_REG_AR,
> +						val->intval);
> +		break;
> +	default:
> +		return -EINVAL;
> +	};
> +
> +	return ret;
> +}
> +
> +static int bq27561_prop_is_writeable(struct power_supply *psy,
> +				     enum power_supply_property prop)
> +{
> +	switch (prop) {
> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
> +		return 1;
> +	default:
> +		return 0;
> +	};
> +}
> +
> +static struct power_supply_desc bq27561_power_supply_desc =3D {
> +	.type =3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties =3D bq27561_properties,
> +	.num_properties =3D ARRAY_SIZE(bq27561_properties),
> +	.get_property =3D bq27561_get_property,
> +	.set_property =3D bq27561_set_property,
> +	.property_is_writeable =3D bq27561_prop_is_writeable,
> +};
> +
> +static int bq27561_probe(struct i2c_client *client,
> +				 const struct i2c_device_id *id)
> +{
> +	struct bq27561_device *bq;
> +	struct power_supply_config psy_cfg;
> +
> +	bq =3D devm_kzalloc(&client->dev, sizeof(*bq), GFP_KERNEL);
> +	if (!bq)
> +		return -ENOMEM;
> +
> +	bq->dev =3D &client->dev;
> +	bq->client =3D client;
> +	i2c_set_clientdata(client, bq);
> +
> +	psy_cfg.drv_data =3D bq;

You should setup psy_cfg.of_node, so that it can be referenced
in DT.

> +	bq27561_power_supply_desc.name =3D id->name;
> +	bq->battery =3D devm_power_supply_register(bq->dev,
> +						 &bq27561_power_supply_desc,
> +						 &psy_cfg);
> +
> +	if (IS_ERR(bq->battery))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id bq27561_match_table[] =3D {
> +	{.compatible =3D "ti,bq27561",},
> +	{.compatible =3D "ti,bq27750",},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, bq_fg_match_table);
> +
> +static const struct i2c_device_id bq27561_id[] =3D {
> +	{"bq27561", BQ27561},
> +	{"bq27750", BQ27750},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, bq27561_id);
> +
> +static struct i2c_driver bq27561_battery_driver =3D {
> +	.driver =3D {
> +		   .name =3D "bq27561-fuel-gauge",
> +		   .of_match_table =3D bq27561_match_table,
> +		   .owner =3D THIS_MODULE,

i2c_register_driver() sets it owner automatically, so
drop this.

> +		   },
> +	.probe =3D bq27561_probe,
> +	.id_table =3D bq27561_id,
> +};
> +module_i2c_driver(bq27561_battery_driver);
> +
> +MODULE_AUTHOR("Texas Instruments");
> +MODULE_DESCRIPTION("bq27561 battery monitor driver");
> +MODULE_LICENSE("GPL v2");

-- Sebastian

--j4gnrncae3skbgwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6p+hwACgkQ2O7X88g7
+ppZuw//WSYjAQi3tCF/aOTStoIDvMqvnrkMFU04qel0WnryzOC0+MUnhi09yPKT
//aSMaXZRnB5yDMs36tkW5z5XZY60Y69jrhTGTuD2albOUbasNwMzkKjlwR4XrOX
/YHpdYTYxsZqFeztl4jdoEBpQVTMqWR74e0JhrE+9nWC/8Es4de0+vK9b89Ul/9G
WJz5XVBzyDRw0kIP/IOvLUUT+FyqqNbHIePr9gYtYN8XQ9iwnAJyc0VDvhnm3tDP
NE8mgCHbbTmTTCQDoKwqdIV5gAMl+n4gluGcuJP/N/gl0D97kP+8kNCPyGxVwQuK
pR0rORXIawayqyOSx4d9+VEk7619+7lxUEVNAgPrljxFmAeWw0jpgZSVQQEx0ZYR
RPhIh5lAUtvk/KK2EhKHBrvLBE81/BrfC/BylGM8lu6KMRsNxkVxSgC5Pmp7m56l
Gj+wiiPNE7WFg6Jd2APdZn2W34llZrfPb6975MUBL7954WlSXN2qWSyf3luXCiYw
rOC6EfYIZef2DQnk+UPTLCnBqbECDb0NAkjV/gAFXPr2G/jEKPsiDTUk37DKF9TU
pOxdAPvzDy9ndh0kedk+4y3slGawcIxGH7T/xXEltoUYr18l0aYLu2n7/SeOxZbO
ZK59K2vIcza9BPuvOLBRZjuU2l64QJASkoCQb4XH/xNBtQwFXtg=
=xryv
-----END PGP SIGNATURE-----

--j4gnrncae3skbgwq--
