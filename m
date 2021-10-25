Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FBC43A649
	for <lists+linux-pm@lfdr.de>; Tue, 26 Oct 2021 00:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhJYWFY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 18:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhJYWFY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 18:05:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B83C061745;
        Mon, 25 Oct 2021 15:03:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 046B21F42D9E
Received: by earth.universe (Postfix, from userid 1000)
        id 0AD4A3C0CA8; Tue, 26 Oct 2021 00:02:56 +0200 (CEST)
Date:   Tue, 26 Oct 2021 00:02:56 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: max77976: add Maxim MAX77976 charger
 driver
Message-ID: <20211025220256.tlsfosmuclbioj5m@earth.universe>
References: <20211004130732.950512-1-luca@lucaceresoli.net>
 <20211004130732.950512-2-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6qxm5qhnwcys2rgz"
Content-Disposition: inline
In-Reply-To: <20211004130732.950512-2-luca@lucaceresoli.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--6qxm5qhnwcys2rgz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 04, 2021 at 03:07:32PM +0200, Luca Ceresoli wrote:
> Add support for the MAX77976 3.5/5.5A 1-Cell Li+ Battery Charger.
>=20
> This is a simple implementation enough to be used as a simple battery
> charger without OTG and boost.
>=20
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  MAINTAINERS                             |   1 +
>  drivers/power/supply/Kconfig            |  11 +
>  drivers/power/supply/Makefile           |   1 +
>  drivers/power/supply/max77976_charger.c | 508 ++++++++++++++++++++++++
>  4 files changed, 521 insertions(+)
>  create mode 100644 drivers/power/supply/max77976_charger.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b3a3667cef46..064c0560b810 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11392,6 +11392,7 @@ MAXIM MAX77976 BATTERY CHARGER
>  M:	Luca Ceresoli <luca@lucaceresoli.net>
>  S:	Supported
>  F:	Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml
> +F:	drivers/power/supply/max77976_charger.c
> =20
>  MAXIM MUIC CHARGER DRIVERS FOR EXYNOS BASED BOARDS
>  M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index ad93b3550d6d..622d690c883a 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -557,6 +557,17 @@ config CHARGER_MAX77693
>  	help
>  	  Say Y to enable support for the Maxim MAX77693 battery charger.
> =20
> +config CHARGER_MAX77976
> +	tristate "Maxim MAX77976 battery charger driver"
> +	depends on REGMAP_I2C

needs to be selected as pointed out by Randy.

> +	help
> +	  The Maxim MAX77976 is a 19 Vin, 5.5A 1-Cell Li+ Battery Charger
> +	  USB OTG support. It has an I2C interface for configuration.
> +
> +	  Say Y to enable support for the Maxim MAX77976 battery charger.
> +	  This driver can also be built as a module. If so, the module will be
> +	  called max77976_charger.
> +
>  config CHARGER_MAX8997
>  	tristate "Maxim MAX8997/MAX8966 PMIC battery charger driver"
>  	depends on MFD_MAX8997 && REGULATOR_MAX8997
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 4e55a11aab79..2c1b264b2046 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -75,6 +75,7 @@ obj-$(CONFIG_CHARGER_MAX14577)	+=3D max14577_charger.o
>  obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+=3D max14656_charger_detector.o
>  obj-$(CONFIG_CHARGER_MAX77650)	+=3D max77650-charger.o
>  obj-$(CONFIG_CHARGER_MAX77693)	+=3D max77693_charger.o
> +obj-$(CONFIG_CHARGER_MAX77976)	+=3D max77976_charger.o
>  obj-$(CONFIG_CHARGER_MAX8997)	+=3D max8997_charger.o
>  obj-$(CONFIG_CHARGER_MAX8998)	+=3D max8998_charger.o
>  obj-$(CONFIG_CHARGER_MP2629)	+=3D mp2629_charger.o
> diff --git a/drivers/power/supply/max77976_charger.c b/drivers/power/supp=
ly/max77976_charger.c
> new file mode 100644
> index 000000000000..2ff900b1843a
> --- /dev/null
> +++ b/drivers/power/supply/max77976_charger.c
> @@ -0,0 +1,508 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * max77976_charger.c - Driver for the Maxim MAX77976 battery charger
> + *
> + * Copyright (C) 2021 Luca Ceresoli
> + * Author: Luca Ceresoli <luca@lucaceresoli.net>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +
> +#define MAX77976_DRIVER_NAME	"max77976-charger"
> +#define MAX77976_CHIP_ID	0x76
> +
> +static const char *max77976_manufacturer	=3D "Maxim Integrated";
> +static const char *max77976_model		=3D "MAX77976";
> +
> +/* ---------------------------------------------------------------------=
-----
> + * Register map
> + */
> +
> +#define MAX77976_REG_CHIP_ID		0x00
> +#define MAX77976_REG_CHIP_REVISION	0x01
> +#define MAX77976_REG_CHG_INT_OK		0x12
> +#define MAX77976_REG_CHG_DETAILS_01	0x14
> +#define MAX77976_REG_CHG_CNFG_00	0x16
> +#define MAX77976_REG_CHG_CNFG_02	0x18
> +#define MAX77976_REG_CHG_CNFG_06	0x1c
> +#define MAX77976_REG_CHG_CNFG_09	0x1f
> +
> +/* CHG_DETAILS_01.CHG_DTLS values */
> +enum max77976_charging_state {
> +	MAX77976_CHARGING_PREQUALIFICATION =3D 0x0,
> +	MAX77976_CHARGING_FAST_CONST_CURRENT,
> +	MAX77976_CHARGING_FAST_CONST_VOLTAGE,
> +	MAX77976_CHARGING_TOP_OFF,
> +	MAX77976_CHARGING_DONE,
> +	MAX77976_CHARGING_RESERVED_05,
> +	MAX77976_CHARGING_TIMER_FAULT,
> +	MAX77976_CHARGING_SUSPENDED_QBATT_OFF,
> +	MAX77976_CHARGING_OFF,
> +	MAX77976_CHARGING_RESERVED_09,
> +	MAX77976_CHARGING_THERMAL_SHUTDOWN,
> +	MAX77976_CHARGING_WATCHDOG_EXPIRED,
> +	MAX77976_CHARGING_SUSPENDED_JEITA,
> +	MAX77976_CHARGING_SUSPENDED_THM_REMOVAL,
> +	MAX77976_CHARGING_SUSPENDED_PIN,
> +	MAX77976_CHARGING_RESERVED_0F,
> +};
> +
> +/* CHG_DETAILS_01.BAT_DTLS values */
> +enum max77976_battery_state {
> +	MAX77976_BATTERY_BATTERY_REMOVAL =3D 0x0,
> +	MAX77976_BATTERY_PREQUALIFICATION,
> +	MAX77976_BATTERY_TIMER_FAULT,
> +	MAX77976_BATTERY_REGULAR_VOLTAGE,
> +	MAX77976_BATTERY_LOW_VOLTAGE,
> +	MAX77976_BATTERY_OVERVOLTAGE,
> +	MAX77976_BATTERY_RESERVED,
> +	MAX77976_BATTERY_BATTERY_ONLY, // No valid adapter is present
> +};
> +
> +/* CHG_CNFG_00.MODE values */
> +enum max77976_mode {
> +	MAX77976_MODE_CHARGER_BUCK		=3D 0x5,
> +	MAX77976_MODE_BOOST			=3D 0x9,
> +};
> +
> +/* CHG_CNFG_02.CHG_CC: charge current limit, 100..5500 mA, 50 mA steps */
> +#define MAX77976_CHG_CC_STEP			  50000U
> +#define MAX77976_CHG_CC_MIN			 100000U
> +#define MAX77976_CHG_CC_MAX			5500000U
> +
> +/* CHG_CNFG_09.CHGIN_ILIM: input current limit, 100..3200 mA, 100 mA ste=
ps */
> +#define MAX77976_CHGIN_ILIM_STEP		 100000U
> +#define MAX77976_CHGIN_ILIM_MIN			 100000U
> +#define MAX77976_CHGIN_ILIM_MAX			3200000U
> +
> +enum max77976_field_idx {
> +	VERSION, REVISION,                      /* CHIP_REVISION */
> +	CHGIN_OK,                               /* CHG_INT_OK */
> +	BAT_DTLS, CHG_DTLS,                     /* CHG_DETAILS_01 */
> +	MODE,                                   /* CHG_CNFG_00 */
> +	CHG_CC,                                 /* CHG_CNFG_02 */
> +	CHGPROT,                                /* CHG_CNFG_06 */
> +	CHGIN_ILIM,                             /* CHG_CNFG_09 */
> +	MAX77976_N_REGMAP_FIELDS
> +};
> +
> +static const struct reg_field max77976_reg_field[MAX77976_N_REGMAP_FIELD=
S] =3D {
> +	[VERSION]        =3D REG_FIELD(MAX77976_REG_CHIP_REVISION,   4, 7),
> +	[REVISION]       =3D REG_FIELD(MAX77976_REG_CHIP_REVISION,   0, 3),
> +	[CHGIN_OK]       =3D REG_FIELD(MAX77976_REG_CHG_INT_OK,      6, 6),
> +	[CHG_DTLS]       =3D REG_FIELD(MAX77976_REG_CHG_DETAILS_01,  0, 3),
> +	[BAT_DTLS]       =3D REG_FIELD(MAX77976_REG_CHG_DETAILS_01,  4, 6),
> +	[MODE]           =3D REG_FIELD(MAX77976_REG_CHG_CNFG_00,     0, 3),
> +	[CHG_CC]         =3D REG_FIELD(MAX77976_REG_CHG_CNFG_02,     0, 6),
> +	[CHGPROT]        =3D REG_FIELD(MAX77976_REG_CHG_CNFG_06,     2, 3),
> +	[CHGIN_ILIM]     =3D REG_FIELD(MAX77976_REG_CHG_CNFG_09,     0, 5),
> +};
> +
> +static const struct regmap_config max77976_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D 0x24,
> +};
> +
> +/* ---------------------------------------------------------------------=
-----
> + * Data structures
> + */
> +
> +struct max77976 {
> +	struct i2c_client	*client;
> +	struct regmap		*regmap;
> +	struct regmap_field	*rfield[MAX77976_N_REGMAP_FIELDS];
> +};
> +
> +/* ---------------------------------------------------------------------=
-----
> + * power_supply properties
> + */
> +
> +static int max77976_get_status(struct max77976 *chg, int *val)
> +{
> +	unsigned int regval;
> +	int err;
> +
> +	err =3D regmap_field_read(chg->rfield[CHG_DTLS], &regval);
> +	if (err < 0)
> +		return err;
> +
> +	switch (regval) {
> +	case MAX77976_CHARGING_PREQUALIFICATION:
> +	case MAX77976_CHARGING_FAST_CONST_CURRENT:
> +	case MAX77976_CHARGING_FAST_CONST_VOLTAGE:
> +	case MAX77976_CHARGING_TOP_OFF:
> +		*val =3D POWER_SUPPLY_STATUS_CHARGING;
> +		break;
> +	case MAX77976_CHARGING_DONE:
> +		*val =3D POWER_SUPPLY_STATUS_FULL;
> +		break;
> +	case MAX77976_CHARGING_TIMER_FAULT:
> +	case MAX77976_CHARGING_SUSPENDED_QBATT_OFF:
> +	case MAX77976_CHARGING_SUSPENDED_JEITA:
> +	case MAX77976_CHARGING_SUSPENDED_THM_REMOVAL:
> +	case MAX77976_CHARGING_SUSPENDED_PIN:
> +		*val =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		break;
> +	case MAX77976_CHARGING_OFF:
> +	case MAX77976_CHARGING_THERMAL_SHUTDOWN:
> +	case MAX77976_CHARGING_WATCHDOG_EXPIRED:
> +		*val =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		break;
> +	default:
> +		*val =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77976_get_charge_type(struct max77976 *chg, int *val)
> +{
> +	unsigned int regval;
> +	int err;
> +
> +	err =3D regmap_field_read(chg->rfield[CHG_DTLS], &regval);
> +	if (err < 0)
> +		return err;
> +
> +	switch (regval) {
> +	case MAX77976_CHARGING_PREQUALIFICATION:
> +		*val =3D POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +		break;
> +	case MAX77976_CHARGING_FAST_CONST_CURRENT:
> +	case MAX77976_CHARGING_FAST_CONST_VOLTAGE:
> +		*val =3D POWER_SUPPLY_CHARGE_TYPE_FAST;
> +		break;
> +	case MAX77976_CHARGING_TOP_OFF:
> +		*val =3D POWER_SUPPLY_CHARGE_TYPE_STANDARD;
> +		break;
> +	case MAX77976_CHARGING_DONE:
> +	case MAX77976_CHARGING_TIMER_FAULT:
> +	case MAX77976_CHARGING_SUSPENDED_QBATT_OFF:
> +	case MAX77976_CHARGING_OFF:
> +	case MAX77976_CHARGING_THERMAL_SHUTDOWN:
> +	case MAX77976_CHARGING_WATCHDOG_EXPIRED:
> +	case MAX77976_CHARGING_SUSPENDED_JEITA:
> +	case MAX77976_CHARGING_SUSPENDED_THM_REMOVAL:
> +	case MAX77976_CHARGING_SUSPENDED_PIN:
> +		*val =3D POWER_SUPPLY_CHARGE_TYPE_NONE;
> +		break;
> +	default:
> +		*val =3D POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77976_get_health(struct max77976 *chg, int *val)
> +{
> +	unsigned int regval;
> +	int err;
> +
> +	err =3D regmap_field_read(chg->rfield[BAT_DTLS], &regval);
> +	if (err < 0)
> +		return err;
> +
> +	switch (regval) {
> +	case MAX77976_BATTERY_BATTERY_REMOVAL:
> +		*val =3D POWER_SUPPLY_HEALTH_DEAD;
> +		break;

I suppose the charger is still able to power the system when
there is no battery, so it's not dead. I think this should
either report POWER_SUPPLY_HEALTH_GOOD or introduce a new
POWER_SUPPLY_HEALTH_NO_BATTERY.

> +	case MAX77976_BATTERY_PREQUALIFICATION:
> +	case MAX77976_BATTERY_LOW_VOLTAGE:

Not sure what prequalification is, but at least low voltage seems
like a candidate to either introduce a new health property, or
report an unspecified failure instead of HEALTH_GOOD.

> +	case MAX77976_BATTERY_REGULAR_VOLTAGE:
> +		*val =3D POWER_SUPPLY_HEALTH_GOOD;
> +		break;
> +	case MAX77976_BATTERY_TIMER_FAULT:
> +		*val =3D POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
> +		break;
> +	case MAX77976_BATTERY_OVERVOLTAGE:
> +		*val =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +		break;
> +	case MAX77976_BATTERY_BATTERY_ONLY:
> +		*val =3D POWER_SUPPLY_HEALTH_UNKNOWN;
> +		break;
> +	default:
> +		*val =3D POWER_SUPPLY_HEALTH_UNKNOWN;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77976_get_online(struct max77976 *chg, int *val)
> +{
> +	unsigned int regval;
> +	int err;
> +
> +	err =3D regmap_field_read(chg->rfield[CHGIN_OK], &regval);
> +	if (err < 0)
> +		return err;
> +
> +	*val =3D (regval ? 1 : 0);
> +
> +	return 0;
> +}
> +
> +static int max77976_get_integer(struct max77976 *chg, enum max77976_fiel=
d_idx fidx,
> +				unsigned int clamp_min, unsigned int clamp_max,
> +				unsigned int mult, int *val)
> +{
> +	unsigned int regval;
> +	int err;
> +
> +	err =3D regmap_field_read(chg->rfield[fidx], &regval);
> +	if (err < 0)
> +		return err;
> +
> +	*val =3D clamp_val(regval * mult, clamp_min, clamp_max);
> +
> +	return 0;
> +}
> +
> +static int max77976_set_integer(struct max77976 *chg, enum max77976_fiel=
d_idx fidx,
> +				unsigned int clamp_min, unsigned int clamp_max,
> +				unsigned int div, int val)
> +{
> +	unsigned int regval;
> +
> +	regval =3D clamp_val(val, clamp_min, clamp_max) / div;
> +
> +	return regmap_field_write(chg->rfield[fidx], regval);
> +}
> +
> +static int max77976_get_property(struct power_supply *psy,
> +				 enum power_supply_property psp,
> +				 union power_supply_propval *val)
> +{
> +	struct max77976 *chg =3D power_supply_get_drvdata(psy);
> +	int err =3D 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		err =3D max77976_get_status(chg, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		err =3D max77976_get_charge_type(chg, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		err =3D max77976_get_health(chg, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		err =3D max77976_get_online(chg, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
> +		val->intval =3D MAX77976_CHG_CC_MAX;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
> +		err =3D max77976_get_integer(chg, CHG_CC,
> +					   MAX77976_CHG_CC_MIN,
> +					   MAX77976_CHG_CC_MAX,
> +					   MAX77976_CHG_CC_STEP,
> +					   &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		err =3D max77976_get_integer(chg, CHGIN_ILIM,
> +					   MAX77976_CHGIN_ILIM_MIN,
> +					   MAX77976_CHGIN_ILIM_MAX,
> +					   MAX77976_CHGIN_ILIM_STEP,
> +					   &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		val->strval =3D max77976_model;
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval =3D max77976_manufacturer;
> +		break;
> +	default:
> +		err =3D -EINVAL;
> +	}
> +
> +	return err;
> +}
> +
> +static int max77976_set_property(struct power_supply *psy,
> +				 enum power_supply_property psp,
> +				 const union power_supply_propval *val)
> +{
> +	struct max77976 *chg =3D power_supply_get_drvdata(psy);
> +	int err =3D 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
> +		err =3D max77976_set_integer(chg, CHG_CC,
> +					   MAX77976_CHG_CC_MIN,
> +					   MAX77976_CHG_CC_MAX,
> +					   MAX77976_CHG_CC_STEP,
> +					   val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		err =3D max77976_set_integer(chg, CHGIN_ILIM,
> +					   MAX77976_CHGIN_ILIM_MIN,
> +					   MAX77976_CHGIN_ILIM_MAX,
> +					   MAX77976_CHGIN_ILIM_STEP,
> +					   val->intval);
> +		break;
> +	default:
> +		err =3D -EINVAL;
> +	}
> +
> +	return err;
> +};
> +
> +static int max77976_property_is_writeable(struct power_supply *psy,
> +					  enum power_supply_property psp)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static enum power_supply_property max77976_psy_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
> +	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
> +static const struct power_supply_desc max77976_psy_desc =3D {
> +	.name			=3D MAX77976_DRIVER_NAME,
> +	.type			=3D POWER_SUPPLY_TYPE_BATTERY,

Incorrect type. TYPE_BATTERY is for fuel gauges. Looks like max77976
is supposed to be used with USB, so:

=2Etype =3D POWER_SUPPLY_TYPE_USB,

> +	.properties		=3D max77976_psy_props,
> +	.num_properties		=3D ARRAY_SIZE(max77976_psy_props),
> +	.get_property		=3D max77976_get_property,
> +	.set_property		=3D max77976_set_property,
> +	.property_is_writeable	=3D max77976_property_is_writeable,
> +};
> +
> +/* ---------------------------------------------------------------------=
-----
> + * Entry point
> + */
> +
> +static int max77976_detect(struct max77976 *chg)
> +{
> +	struct device *dev =3D &chg->client->dev;
> +	unsigned int id, ver, rev;
> +	int err;
> +
> +	err =3D regmap_read(chg->regmap, MAX77976_REG_CHIP_ID, &id);
> +	if (err)
> +		return dev_err_probe(dev, err, "cannot read chip ID\n");
> +
> +	if (id !=3D MAX77976_CHIP_ID)
> +		return dev_err_probe(dev, -ENXIO, "unknown model ID 0x%02x\n", id);
> +
> +	err =3D regmap_field_read(chg->rfield[VERSION], &ver);
> +	if (!err)
> +		err =3D regmap_field_read(chg->rfield[REVISION], &rev);
> +	if (err)
> +		return dev_err_probe(dev, -ENXIO, "cannot read version/revision\n");
> +
> +	dev_info(dev, "detected model MAX779%02x ver %u rev %u", id, ver, rev);
> +
> +	return 0;
> +}

missing newline

> +static int max77976_configure(struct max77976 *chg)
> +{
> +	struct device *dev =3D &chg->client->dev;
> +	int err;
> +
> +	/* Magic value to unlock writing to some registers */
> +	err =3D regmap_field_write(chg->rfield[CHGPROT], 0x3);
> +	if (err)
> +		goto err;
> +
> +	/*
> +	 * Mode 5 =3D Charger ON, OTG OFF, buck ON, boost OFF.
> +	 * Other modes are not implemented by this driver.
> +	 */
> +	err =3D regmap_field_write(chg->rfield[MODE], MAX77976_MODE_CHARGER_BUC=
K);
> +	if (err)
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	return dev_err_probe(dev, err, "error while configuring");
> +}
> +
> +static int max77976_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct power_supply_config psy_cfg =3D {};
> +	struct power_supply *psy;
> +	struct max77976 *chg;
> +	int err;
> +	int i;
> +
> +	chg =3D devm_kzalloc(dev, sizeof(*chg), GFP_KERNEL);
> +	if (!chg)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, chg);
> +	psy_cfg.drv_data =3D chg;
> +	chg->client =3D client;
> +
> +	chg->regmap =3D devm_regmap_init_i2c(client, &max77976_regmap_config);
> +	if (IS_ERR(chg->regmap))
> +		return dev_err_probe(dev, PTR_ERR(chg->regmap),
> +				     "cannot allocate regmap\n");
> +
> +	for (i =3D 0; i < MAX77976_N_REGMAP_FIELDS; i++) {
> +		chg->rfield[i] =3D devm_regmap_field_alloc(dev, chg->regmap,
> +							 max77976_reg_field[i]);
> +		if (IS_ERR(chg->rfield[i]))
> +			return dev_err_probe(dev, PTR_ERR(chg->rfield[i]),
> +					     "cannot allocate regmap field\n");
> +	}
> +
> +	err =3D max77976_detect(chg);
> +	if (err)
> +		return err;
> +
> +	err =3D max77976_configure(chg);
> +	if (err)
> +		return err;
> +
> +	psy =3D devm_power_supply_register_no_ws(dev, &max77976_psy_desc, &psy_=
cfg);
> +	if (IS_ERR(psy))
> +		return dev_err_probe(dev, PTR_ERR(psy), "cannot register\n");
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id max77976_i2c_id[] =3D {
> +	{ MAX77976_DRIVER_NAME, 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, max77976_i2c_id);
> +
> +static const struct of_device_id max77976_of_id[] =3D {
> +	{ .compatible =3D "maxim,max77976" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, max77976_of_id);
> +
> +static struct i2c_driver max77976_driver =3D {
> +	.driver =3D {
> +		.name		=3D MAX77976_DRIVER_NAME,
> +		.of_match_table	=3D of_match_ptr(max77976_of_id),
> +	},
> +	.probe_new	=3D max77976_probe,
> +	.id_table	=3D max77976_i2c_id,
> +};
> +module_i2c_driver(max77976_driver);
> +
> +MODULE_AUTHOR("Luca Ceresoli <luca@lucaceresoli.net>");
> +MODULE_DESCRIPTION("Maxim MAX77976 charger driver");
> +MODULE_LICENSE("GPL v2");

Otherwise looks good!

-- Sebastian

--6qxm5qhnwcys2rgz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmF3KYwACgkQ2O7X88g7
+ppHDRAAjotGBSsiU3ozQaWo+3D3JBopkaimqFVLqGWichMd/+0Sffaa7bwuN85i
GhrzjnEORGbmiReP/K/y19g0CuqzVWppLVBcuEhLC48VoSm8K8NbxFcHyf3SvhK9
ZTwNNujONMWd6msXBqRnGrAjbCB6NskpX6I9qfzzLh7aYIMZeIPyVEXLE4kcZnJr
687VlbOPth4IHRdPLX/X4eraPBZPWokYqQ1Za/pDMvNzDI/mbmfq4KjwZKkdI/PI
at3BX5lK1CkF2sHh/QnY/uJMfNILSFVqThpDMKqvTGg5ujc0rnZ8PuZKiRKZfSQ5
BweuRQw7FTsFR2/qytGJg7GV6XmiMzQBJ0xHDVVvgSMTYcGHA4V+w3y0jB6kvkWC
uuG4vTwoE4Sld6z8yVOtSt7F/sKgsKDUdrZGM78952q2gKOsGjzvR9ESk12iDcOq
2vDFMDt9I4XJOSFr82pR6cN2rXa2wJkvleEqJIq2BT0RApYDlKyTP79kKDbZniK0
sRazg6XHFKOJPAsgpVfQty5Vgheuy5w+tsOiLLzgjoSYtE/abPBYTOJWKBnokbEX
JbGoLabbEJRUHHC3cASYPh5JggOkOJypliJZM14MJEv6pSJkmAVSuWXY0S0g2Ne4
dcuQuDCxyv51u0mfvyX8zfU2y+oUgRjqacZIkexZtxPqaJVp0P8=
=h7tG
-----END PGP SIGNATURE-----

--6qxm5qhnwcys2rgz--
