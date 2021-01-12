Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934832F40AC
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 01:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393633AbhAMAnC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 19:43:02 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47016 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391954AbhALXuT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 18:50:19 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D3A061F44EE1
Received: by earth.universe (Postfix, from userid 1000)
        id CA41F3C0C94; Wed, 13 Jan 2021 00:49:31 +0100 (CET)
Date:   Wed, 13 Jan 2021 00:49:31 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] power/supply: Add ltc4162-l-charger
Message-ID: <20210112234931.xerruuc6l67yvkkr@earth.universe>
References: <20210107143248.13413-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ez3ypcogxv2dih72"
Content-Disposition: inline
In-Reply-To: <20210107143248.13413-1-mike.looijmans@topic.nl>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ez3ypcogxv2dih72
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 07, 2021 at 03:32:48PM +0100, Mike Looijmans wrote:
> Add support for the LTC4162-L Li-Ion battery charger. The driver allows
> reading back telemetry and to set some charging options like the input
> current limit.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---

Thanks, queued.

-- Sebastian

> v2: Use microohm units instead of milliohm
>     Add interrupt support using smbalert
>     Support obtaining cell-count from devicetree
> v3: Fix overflows in calculations involving resistor values
> v4: Use attr_grp member to register attributes
>     Report input current/voltage for charger and make battery
>     voltage and current into sysfs attributes
> v5: Remove ltc4162l_remove since core now takes care of attributes
>     Add ABI documentation for attributes
>=20
>  .../ABI/testing/sysfs-class-power-ltc4162l    |  82 ++
>  drivers/power/supply/Kconfig                  |   8 +
>  drivers/power/supply/Makefile                 |   1 +
>  drivers/power/supply/ltc4162-l-charger.c      | 931 ++++++++++++++++++
>  4 files changed, 1022 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-power-ltc4162l
>  create mode 100644 drivers/power/supply/ltc4162-l-charger.c
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power-ltc4162l b/Docum=
entation/ABI/testing/sysfs-class-power-ltc4162l
> new file mode 100644
> index 000000000000..ba30db93052b
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-power-ltc4162l
> @@ -0,0 +1,82 @@
> +What:		/sys/class/power_supply/ltc4162-l/charge_status
> +Date:		Januari 2021
> +KernelVersion:	5.11
> +Description:
> +		Detailed charge status information as reported by the chip.
> +
> +		Access: Read
> +
> +		Valid values:
> +			ilim_reg_active
> +			thermal_reg_active
> +			vin_uvcl_active
> +			iin_limit_active
> +			constant_current
> +			constant_voltage
> +			charger_off
> +
> +What:		/sys/class/power_supply/ltc4162-l/ibat
> +Date:		Januari 2021
> +KernelVersion:	5.11
> +Description:
> +		Battery input current as measured by the charger. Negative value
> +		means that the battery is discharging.
> +
> +		Access: Read
> +
> +		Valid values: Signed value in microamps
> +
> +What:		/sys/class/power_supply/ltc4162-l/vbat
> +Date:		Januari 2021
> +KernelVersion:	5.11
> +Description:
> +		Battery voltage as measured by the charger.
> +
> +		Access: Read
> +
> +		Valid values: In microvolts
> +
> +What:		/sys/class/power_supply/ltc4162-l/vbat_avg
> +Date:		Januari 2021
> +KernelVersion:	5.11
> +Description:
> +		Battery voltage, averaged over time, as measured by the charger.
> +
> +		Access: Read
> +
> +		Valid values: In microvolts
> +
> +What:		/sys/class/power_supply/ltc4162-l/force_telemetry
> +Date:		Januari 2021
> +KernelVersion:	5.11
> +Description:
> +		To save battery current, the measurement system is disabled if
> +		the battery is the only source of power. This affects all
> +		voltage, current and temperature measurements.
> +		Write a "1" to this to keep performing telemetry once every few
> +		seconds, even when running on battery (as reported by the online
> +		property, which is "1" when external power is available and "0"
> +		when the system runs on battery).
> +
> +		Access: Read, Write
> +
> +		Valid values: 0 (disabled) or 1 (enabled)
> +
> +What:		/sys/class/power_supply/ltc4162-l/arm_ship_mode
> +Date:		Januari 2021
> +KernelVersion:	5.11
> +Description:
> +		The charger will normally drain the battery while inactive,
> +		typically drawing about 54 microamps. Write a "1" to this
> +		property to arm a special "ship" mode that extends shelf life
> +		by reducing the leakage to about 2.8 microamps. The chip will
> +		remain in this mode (and no longer respond to I2C commands)
> +		until some external power-supply is attached raising the input
> +		voltage above 1V. It will then automatically revert to "0".
> +		Writing a "0" to the property cancels the "ship" mode request.
> +		The ship mode, when armed, activates once the input voltage
> +		drops below 1V.
> +
> +		Access: Read, Write
> +
> +		Valid values: 0 (disable) or 1 (enable)
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index eec646c568b7..23000976cb42 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -513,6 +513,14 @@ config CHARGER_LT3651
>  	  Say Y to include support for the Analog Devices (Linear Technology)
>  	  LT3651 battery charger which reports its status via GPIO lines.
> =20
> +config CHARGER_LTC4162L
> +	tristate "LTC4162-L charger"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say Y to include support for the Analog Devices (Linear Technology)
> +	  LTC4162-L battery charger connected to I2C.
> +
>  config CHARGER_MAX14577
>  	tristate "Maxim MAX14577/77836 battery charger driver"
>  	depends on MFD_MAX14577
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index dd4b86318cd9..17b1cf921c44 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -70,6 +70,7 @@ obj-$(CONFIG_CHARGER_LP8788)	+=3D lp8788-charger.o
>  obj-$(CONFIG_CHARGER_GPIO)	+=3D gpio-charger.o
>  obj-$(CONFIG_CHARGER_MANAGER)	+=3D charger-manager.o
>  obj-$(CONFIG_CHARGER_LT3651)	+=3D lt3651-charger.o
> +obj-$(CONFIG_CHARGER_LTC4162L)	+=3D ltc4162-l-charger.o
>  obj-$(CONFIG_CHARGER_MAX14577)	+=3D max14577_charger.o
>  obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+=3D max14656_charger_detector.o
>  obj-$(CONFIG_CHARGER_MAX77650)	+=3D max77650-charger.o
> diff --git a/drivers/power/supply/ltc4162-l-charger.c b/drivers/power/sup=
ply/ltc4162-l-charger.c
> new file mode 100644
> index 000000000000..cded6484febb
> --- /dev/null
> +++ b/drivers/power/supply/ltc4162-l-charger.c
> @@ -0,0 +1,931 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  Driver for Analog Devices (Linear Technology) LTC4162-L charger IC.
> + *  Copyright (C) 2020, Topic Embedded Products
> + */
> +
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/power_supply.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +
> +/* Registers (names based on what datasheet uses) */
> +#define LTC4162L_EN_LIMIT_ALERTS_REG		0x0D
> +#define LTC4162L_EN_CHARGER_STATE_ALERTS_REG	0x0E
> +#define LTC4162L_EN_CHARGE_STATUS_ALERTS_REG	0x0F
> +#define LTC4162L_CONFIG_BITS_REG		0x14
> +#define LTC4162L_IIN_LIMIT_TARGET		0x15
> +#define LTC4162L_ARM_SHIP_MODE			0x19
> +#define LTC4162L_CHARGE_CURRENT_SETTING		0X1A
> +#define LTC4162L_VCHARGE_SETTING		0X1B
> +#define LTC4162L_C_OVER_X_THRESHOLD		0x1C
> +#define LTC4162L_MAX_CV_TIME			0X1D
> +#define LTC4162L_MAX_CHARGE_TIME		0X1E
> +#define LTC4162L_CHARGER_CONFIG_BITS		0x29
> +#define LTC4162L_CHARGER_STATE			0x34
> +#define LTC4162L_CHARGE_STATUS			0x35
> +#define LTC4162L_LIMIT_ALERTS_REG		0x36
> +#define LTC4162L_CHARGER_STATE_ALERTS_REG	0x37
> +#define LTC4162L_CHARGE_STATUS_ALERTS_REG	0x38
> +#define LTC4162L_SYSTEM_STATUS_REG		0x39
> +#define LTC4162L_VBAT				0x3A
> +#define LTC4162L_VIN				0x3B
> +#define LTC4162L_VOUT				0x3C
> +#define LTC4162L_IBAT				0x3D
> +#define LTC4162L_IIN				0x3E
> +#define LTC4162L_DIE_TEMPERATURE		0x3F
> +#define LTC4162L_THERMISTOR_VOLTAGE		0x40
> +#define LTC4162L_BSR				0x41
> +#define LTC4162L_JEITA_REGION			0x42
> +#define LTC4162L_CHEM_CELLS_REG			0x43
> +#define LTC4162L_ICHARGE_DAC			0x44
> +#define LTC4162L_VCHARGE_DAC			0x45
> +#define LTC4162L_IIN_LIMIT_DAC			0x46
> +#define LTC4162L_VBAT_FILT			0x47
> +#define LTC4162L_INPUT_UNDERVOLTAGE_DAC		0x4B
> +
> +/* Enumeration as in datasheet. Individual bits are mutually exclusive. =
*/
> +enum ltc4162l_state {
> +	battery_detection =3D 2048,
> +	charger_suspended =3D 256,
> +	precharge =3D 128,   /* trickle on low bat voltage */
> +	cc_cv_charge =3D 64, /* normal charge */
> +	ntc_pause =3D 32,
> +	timer_term =3D 16,
> +	c_over_x_term =3D 8, /* battery is full */
> +	max_charge_time_fault =3D 4,
> +	bat_missing_fault =3D 2,
> +	bat_short_fault =3D 1
> +};
> +
> +/* Individual bits are mutually exclusive. Only active in charging state=
s.*/
> +enum ltc4162l_charge_status {
> +	ilim_reg_active =3D 32,
> +	thermal_reg_active =3D 16,
> +	vin_uvcl_active =3D 8,
> +	iin_limit_active =3D 4,
> +	constant_current =3D 2,
> +	constant_voltage =3D 1,
> +	charger_off =3D 0
> +};
> +
> +/* Magic number to write to ARM_SHIP_MODE register */
> +#define LTC4162L_ARM_SHIP_MODE_MAGIC 21325
> +
> +struct ltc4162l_info {
> +	struct i2c_client	*client;
> +	struct regmap		*regmap;
> +	struct power_supply	*charger;
> +	u32 rsnsb;	/* Series resistor that sets charge current, microOhm */
> +	u32 rsnsi;	/* Series resistor to measure input current, microOhm */
> +	u8 cell_count;	/* Number of connected cells, 0 while unknown */
> +};
> +
> +static u8 ltc4162l_get_cell_count(struct ltc4162l_info *info)
> +{
> +	int ret;
> +	unsigned int val;
> +
> +	/* Once read successfully */
> +	if (info->cell_count)
> +		return info->cell_count;
> +
> +	ret =3D regmap_read(info->regmap, LTC4162L_CHEM_CELLS_REG, &val);
> +	if (ret)
> +		return 0;
> +
> +	/* Lower 4 bits is the cell count, or 0 if the chip doesn't know yet */
> +	val &=3D 0x0f;
> +	if (!val)
> +		return 0;
> +
> +	/* Once determined, keep the value */
> +	info->cell_count =3D val;
> +
> +	return val;
> +};
> +
> +/* Convert enum value to POWER_SUPPLY_STATUS value */
> +static int ltc4162l_state_decode(enum ltc4162l_state value)
> +{
> +	switch (value) {
> +	case precharge:
> +	case cc_cv_charge:
> +		return POWER_SUPPLY_STATUS_CHARGING;
> +	case c_over_x_term:
> +		return POWER_SUPPLY_STATUS_FULL;
> +	case bat_missing_fault:
> +	case bat_short_fault:
> +		return POWER_SUPPLY_STATUS_UNKNOWN;
> +	default:
> +		return POWER_SUPPLY_STATUS_NOT_CHARGING;
> +	}
> +};
> +
> +static int ltc4162l_get_status(struct ltc4162l_info *info,
> +			       union power_supply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC4162L_CHARGER_STATE, &regval);
> +	if (ret) {
> +		dev_err(&info->client->dev, "Failed to read CHARGER_STATE\n");
> +		return ret;
> +	}
> +
> +	val->intval =3D ltc4162l_state_decode(regval);
> +
> +	return 0;
> +}
> +
> +static int ltc4162l_charge_status_decode(enum ltc4162l_charge_status val=
ue)
> +{
> +	if (!value)
> +		return POWER_SUPPLY_CHARGE_TYPE_NONE;
> +
> +	/* constant voltage/current and input_current limit are "fast" modes */
> +	if (value <=3D iin_limit_active)
> +		return POWER_SUPPLY_CHARGE_TYPE_FAST;
> +
> +	/* Anything that's not fast we'll return as trickle */
> +	return POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +}
> +
> +static int ltc4162l_get_charge_type(struct ltc4162l_info *info,
> +				    union power_supply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC4162L_CHARGE_STATUS, &regval);
> +	if (ret)
> +		return ret;
> +
> +	val->intval =3D ltc4162l_charge_status_decode(regval);
> +
> +	return 0;
> +}
> +
> +static int ltc4162l_state_to_health(enum ltc4162l_state value)
> +{
> +	switch (value) {
> +	case ntc_pause:
> +		return POWER_SUPPLY_HEALTH_OVERHEAT;
> +	case timer_term:
> +		return POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
> +	case max_charge_time_fault:
> +		return POWER_SUPPLY_HEALTH_WATCHDOG_TIMER_EXPIRE;
> +	case bat_missing_fault:
> +		return POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
> +	case bat_short_fault:
> +		return POWER_SUPPLY_HEALTH_DEAD;
> +	default:
> +		return POWER_SUPPLY_HEALTH_GOOD;
> +	}
> +}
> +
> +static int ltc4162l_get_health(struct ltc4162l_info *info,
> +			       union power_supply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC4162L_CHARGER_STATE, &regval);
> +	if (ret)
> +		return ret;
> +
> +	val->intval =3D ltc4162l_state_to_health(regval);
> +
> +	return 0;
> +}
> +
> +static int ltc4162l_get_online(struct ltc4162l_info *info,
> +			       union power_supply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC4162L_SYSTEM_STATUS_REG, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* BIT(2) indicates if input voltage is sufficient to charge */
> +	val->intval =3D !!(regval & BIT(2));
> +
> +	return 0;
> +}
> +
> +static int ltc4162l_get_vbat(struct ltc4162l_info *info,
> +				  unsigned int reg,
> +				  union power_supply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, reg, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* cell_count =C3=97 192.4=CE=BCV/LSB */
> +	regval *=3D 1924;
> +	regval *=3D ltc4162l_get_cell_count(info);
> +	regval /=3D 10;
> +	val->intval =3D regval;
> +
> +	return 0;
> +}
> +
> +static int ltc4162l_get_ibat(struct ltc4162l_info *info,
> +			     union power_supply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC4162L_IBAT, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* Signed 16-bit number, 1.466=CE=BCV / RSNSB amperes/LSB. */
> +	ret =3D (s16)(regval & 0xFFFF);
> +	val->intval =3D 100 * mult_frac(ret, 14660, (int)info->rsnsb);
> +
> +	return 0;
> +}
> +
> +
> +static int ltc4162l_get_input_voltage(struct ltc4162l_info *info,
> +				      union power_supply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC4162L_VIN, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* 1.649mV/LSB */
> +	val->intval =3D  regval * 1694;
> +
> +	return 0;
> +}
> +
> +static int ltc4162l_get_input_current(struct ltc4162l_info *info,
> +				      union power_supply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC4162L_IIN, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* Signed 16-bit number, 1.466=CE=BCV / RSNSI amperes/LSB. */
> +	ret =3D (s16)(regval & 0xFFFF);
> +	ret *=3D 14660;
> +	ret /=3D info->rsnsi;
> +	ret *=3D 100;
> +
> +	val->intval =3D ret;
> +
> +	return 0;
> +}
> +
> +static int ltc4162l_get_icharge(struct ltc4162l_info *info,
> +				unsigned int reg,
> +				union power_supply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, reg, &regval);
> +	if (ret)
> +		return ret;
> +
> +	regval &=3D BIT(6) - 1; /* Only the lower 5 bits */
> +
> +	/* The charge current servo level: (icharge_dac + 1) =C3=97 1mV/RSNSB */
> +	++regval;
> +	val->intval =3D 10000u * mult_frac(regval, 100000u, info->rsnsb);
> +
> +	return 0;
> +}
> +
> +static int ltc4162l_set_icharge(struct ltc4162l_info *info,
> +				unsigned int reg,
> +				unsigned int value)
> +{
> +	value =3D mult_frac(value, info->rsnsb, 100000u);
> +	value /=3D 10000u;
> +
> +	/* Round to lowest possible */
> +	if (value)
> +		--value;
> +
> +	if (value > 31)
> +		return -EINVAL;
> +
> +	return regmap_write(info->regmap, reg, value);
> +}
> +
> +
> +static int ltc4162l_get_vcharge(struct ltc4162l_info *info,
> +				unsigned int reg,
> +				union power_supply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +	u32 voltage;
> +
> +	ret =3D regmap_read(info->regmap, reg, &regval);
> +	if (ret)
> +		return ret;
> +
> +	regval &=3D BIT(6) - 1; /* Only the lower 5 bits */
> +
> +	/*
> +	 * charge voltage setting can be computed from
> +	 * cell_count =C3=97 (vcharge_setting =C3=97 12.5mV + 3.8125V)
> +	 * where vcharge_setting ranges from 0 to 31 (4.2V max).
> +	 */
> +	voltage =3D 3812500 + (regval * 12500);
> +	voltage *=3D ltc4162l_get_cell_count(info);
> +	val->intval =3D voltage;
> +
> +	return 0;
> +}
> +
> +static int ltc4162l_set_vcharge(struct ltc4162l_info *info,
> +				unsigned int reg,
> +				unsigned int value)
> +{
> +	u8 cell_count =3D ltc4162l_get_cell_count(info);
> +
> +	if (!cell_count)
> +		return -EBUSY; /* Not available yet, try again later */
> +
> +	value /=3D cell_count;
> +
> +	if (value < 3812500)
> +		return -EINVAL;
> +
> +	value -=3D 3812500;
> +	value /=3D 12500;
> +
> +	if (value > 31)
> +		return -EINVAL;
> +
> +	return regmap_write(info->regmap, reg, value);
> +}
> +
> +static int ltc4162l_get_iin_limit_dac(struct ltc4162l_info *info,
> +				     union power_supply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC4162L_IIN_LIMIT_DAC, &regval);
> +	if (ret)
> +		return ret;
> +
> +	regval &=3D BIT(6) - 1; /* Only 6 bits */
> +
> +	/* (iin_limit_dac + 1) =C3=97 500=CE=BCV / RSNSI */
> +	++regval;
> +	regval *=3D 5000000u;
> +	regval /=3D info->rsnsi;
> +	val->intval =3D 100u * regval;
> +
> +	return 0;
> +}
> +
> +static int ltc4162l_set_iin_limit(struct ltc4162l_info *info,
> +				  unsigned int value)
> +{
> +	unsigned int regval;
> +
> +	regval =3D mult_frac(value, info->rsnsi, 50000u);
> +	regval /=3D 10000u;
> +	if (regval)
> +		--regval;
> +	if (regval > 63)
> +		regval =3D 63;
> +
> +	return regmap_write(info->regmap, LTC4162L_IIN_LIMIT_TARGET, regval);
> +}
> +
> +static int ltc4162l_get_die_temp(struct ltc4162l_info *info,
> +				 union power_supply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC4162L_DIE_TEMPERATURE, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* die_temp =C3=97 0.0215=C2=B0C/LSB - 264.4=C2=B0C */
> +	ret =3D (s16)(regval & 0xFFFF);
> +	ret *=3D 215;
> +	ret /=3D 100; /* Centidegrees scale */
> +	ret -=3D 26440;
> +	val->intval =3D ret;
> +
> +	return 0;
> +}
> +
> +static int ltc4162l_get_term_current(struct ltc4162l_info *info,
> +				     union power_supply_propval *val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC4162L_CHARGER_CONFIG_BITS, &regval=
);
> +	if (ret)
> +		return ret;
> +
> +	/* Check if C_OVER_X_THRESHOLD is enabled */
> +	if (!(regval & BIT(2))) {
> +		val->intval =3D 0;
> +		return 0;
> +	}
> +
> +	ret =3D regmap_read(info->regmap, LTC4162L_C_OVER_X_THRESHOLD, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* 1.466=CE=BCV / RSNSB amperes/LSB */
> +	regval *=3D 14660u;
> +	regval /=3D info->rsnsb;
> +	val->intval =3D 100 * regval;
> +
> +	return 0;
> +}
> +
> +static int ltc4162l_set_term_current(struct ltc4162l_info *info,
> +				     unsigned int value)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	if (!value) {
> +		/* Disable en_c_over_x_term when set to zero */
> +		return regmap_update_bits(info->regmap,
> +					  LTC4162L_CHARGER_CONFIG_BITS,
> +					  BIT(2), 0);
> +	}
> +
> +	regval =3D mult_frac(value, info->rsnsb, 14660u);
> +	regval /=3D 100u;
> +
> +	ret =3D  regmap_write(info->regmap, LTC4162L_C_OVER_X_THRESHOLD, regval=
);
> +	if (ret)
> +		return ret;
> +
> +	/* Set en_c_over_x_term after changing the threshold value */
> +	return regmap_update_bits(info->regmap, LTC4162L_CHARGER_CONFIG_BITS,
> +				  BIT(2), BIT(2));
> +}
> +
> +/* Custom properties */
> +static const char * const ltc4162l_charge_status_name[] =3D {
> +	"ilim_reg_active", /* 32 */
> +	"thermal_reg_active",
> +	"vin_uvcl_active",
> +	"iin_limit_active",
> +	"constant_current",
> +	"constant_voltage",
> +	"charger_off" /* 0 */
> +};
> +
> +static ssize_t charge_status_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct power_supply *psy =3D to_power_supply(dev);
> +	struct ltc4162l_info *info =3D power_supply_get_drvdata(psy);
> +	const char *result =3D ltc4162l_charge_status_name[
> +				ARRAY_SIZE(ltc4162l_charge_status_name) - 1];
> +	unsigned int regval;
> +	unsigned int mask;
> +	unsigned int index;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC4162L_CHARGE_STATUS, &regval);
> +	if (ret)
> +		return ret;
> +
> +	/* Only one bit is set according to datasheet, let's be safe here */
> +	for (mask =3D 32, index =3D 0; mask !=3D 0; mask >>=3D 1, ++index) {
> +		if (regval & mask) {
> +			result =3D ltc4162l_charge_status_name[index];
> +			break;
> +		}
> +	}
> +
> +	return sprintf(buf, "%s\n", result);
> +}
> +static DEVICE_ATTR_RO(charge_status);
> +
> +static ssize_t vbat_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct power_supply *psy =3D to_power_supply(dev);
> +	struct ltc4162l_info *info =3D power_supply_get_drvdata(psy);
> +	union power_supply_propval val;
> +	int ret;
> +
> +	ret =3D ltc4162l_get_vbat(info, LTC4162L_VBAT, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", val.intval);
> +}
> +static DEVICE_ATTR_RO(vbat);
> +
> +static ssize_t vbat_avg_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct power_supply *psy =3D to_power_supply(dev);
> +	struct ltc4162l_info *info =3D power_supply_get_drvdata(psy);
> +	union power_supply_propval val;
> +	int ret;
> +
> +	ret =3D ltc4162l_get_vbat(info, LTC4162L_VBAT_FILT, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", val.intval);
> +}
> +static DEVICE_ATTR_RO(vbat_avg);
> +
> +static ssize_t ibat_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct power_supply *psy =3D to_power_supply(dev);
> +	struct ltc4162l_info *info =3D power_supply_get_drvdata(psy);
> +	union power_supply_propval val;
> +	int ret;
> +
> +	ret =3D ltc4162l_get_ibat(info, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", val.intval);
> +}
> +static DEVICE_ATTR_RO(ibat);
> +
> +static ssize_t force_telemetry_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct power_supply *psy =3D to_power_supply(dev);
> +	struct ltc4162l_info *info =3D power_supply_get_drvdata(psy);
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC4162L_CONFIG_BITS_REG, &regval);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "%u\n", regval & BIT(2) ? 1 : 0);
> +}
> +
> +static ssize_t force_telemetry_store(struct device *dev,
> +	struct device_attribute *attr,
> +	const char *buf,
> +	size_t count)
> +{
> +	struct power_supply *psy =3D to_power_supply(dev);
> +	struct ltc4162l_info *info =3D power_supply_get_drvdata(psy);
> +	int ret;
> +	unsigned int value;
> +
> +	ret =3D kstrtouint(buf, 0, &value);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(info->regmap, LTC4162L_CONFIG_BITS_REG,
> +				 BIT(2), value ? BIT(2) : 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(force_telemetry);
> +
> +static ssize_t arm_ship_mode_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct power_supply *psy =3D to_power_supply(dev);
> +	struct ltc4162l_info *info =3D power_supply_get_drvdata(psy);
> +	unsigned int regval;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, LTC4162L_ARM_SHIP_MODE, &regval);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "%u\n",
> +		regval =3D=3D LTC4162L_ARM_SHIP_MODE_MAGIC ? 1 : 0);
> +}
> +
> +static ssize_t arm_ship_mode_store(struct device *dev,
> +	struct device_attribute *attr,
> +	const char *buf,
> +	size_t count)
> +{
> +	struct power_supply *psy =3D to_power_supply(dev);
> +	struct ltc4162l_info *info =3D power_supply_get_drvdata(psy);
> +	int ret;
> +	unsigned int value;
> +
> +	ret =3D kstrtouint(buf, 0, &value);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D regmap_write(info->regmap, LTC4162L_ARM_SHIP_MODE,
> +				value ? LTC4162L_ARM_SHIP_MODE_MAGIC : 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(arm_ship_mode);
> +
> +static struct attribute *ltc4162l_sysfs_entries[] =3D {
> +	&dev_attr_charge_status.attr,
> +	&dev_attr_ibat.attr,
> +	&dev_attr_vbat.attr,
> +	&dev_attr_vbat_avg.attr,
> +	&dev_attr_force_telemetry.attr,
> +	&dev_attr_arm_ship_mode.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group ltc4162l_attr_group =3D {
> +	.name	=3D NULL,	/* put in device directory */
> +	.attrs	=3D ltc4162l_sysfs_entries,
> +};
> +
> +static const struct attribute_group *ltc4162l_attr_groups[] =3D {
> +	&ltc4162l_attr_group,
> +	NULL,
> +};
> +
> +static int ltc4162l_get_property(struct power_supply *psy,
> +				 enum power_supply_property psp,
> +				 union power_supply_propval *val)
> +{
> +	struct ltc4162l_info *info =3D power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		return ltc4162l_get_status(info, val);
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		return ltc4162l_get_charge_type(info, val);
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		return ltc4162l_get_health(info, val);
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		return ltc4162l_get_online(info, val);
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		return ltc4162l_get_input_voltage(info, val);
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		return ltc4162l_get_input_current(info, val);
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		return ltc4162l_get_icharge(info,
> +				LTC4162L_ICHARGE_DAC, val);
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		return ltc4162l_get_icharge(info,
> +				LTC4162L_CHARGE_CURRENT_SETTING, val);
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		return ltc4162l_get_vcharge(info,
> +				LTC4162L_VCHARGE_DAC, val);
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +		return ltc4162l_get_vcharge(info,
> +				LTC4162L_VCHARGE_SETTING, val);
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		return ltc4162l_get_iin_limit_dac(info, val);
> +	case POWER_SUPPLY_PROP_TEMP:
> +		return ltc4162l_get_die_temp(info, val);
> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +		return ltc4162l_get_term_current(info, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ltc4162l_set_property(struct power_supply *psy,
> +					 enum power_supply_property psp,
> +					 const union power_supply_propval *val)
> +{
> +	struct ltc4162l_info *info =3D power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		return ltc4162l_set_icharge(info,
> +				LTC4162L_CHARGE_CURRENT_SETTING, val->intval);
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +		return ltc4162l_set_vcharge(info,
> +				LTC4162L_VCHARGE_SETTING, val->intval);
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		return ltc4162l_set_iin_limit(info, val->intval);
> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +		return ltc4162l_set_term_current(info, val->intval);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ltc4162l_property_is_writeable(struct power_supply *psy,
> +						enum power_supply_property psp)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> +		return 1;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +/* Charger power supply property routines */
> +static enum power_supply_property ltc4162l_properties[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> +};
> +
> +static const struct power_supply_desc ltc4162l_desc =3D {
> +	.name		=3D "ltc4162-l",
> +	.type		=3D POWER_SUPPLY_TYPE_MAINS,
> +	.properties	=3D ltc4162l_properties,
> +	.num_properties	=3D ARRAY_SIZE(ltc4162l_properties),
> +	.get_property	=3D ltc4162l_get_property,
> +	.set_property	=3D ltc4162l_set_property,
> +	.property_is_writeable =3D ltc4162l_property_is_writeable,
> +};
> +
> +static bool ltc4162l_is_writeable_reg(struct device *dev, unsigned int r=
eg)
> +{
> +	/* all registers up to this one are writeable */
> +	if (reg <=3D LTC4162L_CHARGER_CONFIG_BITS)
> +		return true;
> +
> +	/* The ALERTS registers can be written to clear alerts */
> +	if (reg >=3D LTC4162L_LIMIT_ALERTS_REG &&
> +	    reg <=3D LTC4162L_CHARGE_STATUS_ALERTS_REG)
> +		return true;
> +
> +	return false;
> +}
> +
> +static bool ltc4162l_is_volatile_reg(struct device *dev, unsigned int re=
g)
> +{
> +	/* all registers after this one are read-only status registers */
> +	return reg > LTC4162L_CHARGER_CONFIG_BITS;
> +}
> +
> +static const struct regmap_config ltc4162l_regmap_config =3D {
> +	.reg_bits	=3D 8,
> +	.val_bits	=3D 16,
> +	.val_format_endian =3D REGMAP_ENDIAN_LITTLE,
> +	.writeable_reg	=3D ltc4162l_is_writeable_reg,
> +	.volatile_reg	=3D ltc4162l_is_volatile_reg,
> +	.max_register	=3D LTC4162L_INPUT_UNDERVOLTAGE_DAC,
> +	.cache_type	=3D REGCACHE_RBTREE,
> +};
> +
> +static void ltc4162l_clear_interrupts(struct ltc4162l_info *info)
> +{
> +	/* Acknowledge interrupt to chip by clearing all events */
> +	regmap_write(info->regmap, LTC4162L_LIMIT_ALERTS_REG, 0);
> +	regmap_write(info->regmap, LTC4162L_CHARGER_STATE_ALERTS_REG, 0);
> +	regmap_write(info->regmap, LTC4162L_CHARGE_STATUS_ALERTS_REG, 0);
> +}
> +
> +static int ltc4162l_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct i2c_adapter *adapter =3D client->adapter;
> +	struct device *dev =3D &client->dev;
> +	struct ltc4162l_info *info;
> +	struct power_supply_config ltc4162l_config =3D {};
> +	u32 value;
> +	int ret;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA)) {
> +		dev_err(dev, "No support for SMBUS_WORD_DATA\n");
> +		return -ENODEV;
> +	}
> +	info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->client =3D client;
> +	i2c_set_clientdata(client, info);
> +
> +	info->regmap =3D devm_regmap_init_i2c(client, &ltc4162l_regmap_config);
> +	if (IS_ERR(info->regmap)) {
> +		dev_err(dev, "Failed to initialize register map\n");
> +		return PTR_ERR(info->regmap);
> +	}
> +
> +	ret =3D device_property_read_u32(dev, "lltc,rsnsb-micro-ohms",
> +				       &info->rsnsb);
> +	if (ret) {
> +		dev_err(dev, "Missing lltc,rsnsb-micro-ohms property\n");
> +		return ret;
> +	}
> +	if (!info->rsnsb)
> +		return -EINVAL;
> +
> +	ret =3D device_property_read_u32(dev, "lltc,rsnsi-micro-ohms",
> +				       &info->rsnsi);
> +	if (ret) {
> +		dev_err(dev, "Missing lltc,rsnsi-micro-ohms property\n");
> +		return ret;
> +	}
> +	if (!info->rsnsi)
> +		return -EINVAL;
> +
> +	if (!device_property_read_u32(dev, "lltc,cell-count", &value))
> +		info->cell_count =3D value;
> +
> +	ltc4162l_config.of_node =3D dev->of_node;
> +	ltc4162l_config.drv_data =3D info;
> +	ltc4162l_config.attr_grp =3D ltc4162l_attr_groups;
> +
> +	info->charger =3D devm_power_supply_register(dev, &ltc4162l_desc,
> +						   &ltc4162l_config);
> +	if (IS_ERR(info->charger)) {
> +		dev_err(dev, "Failed to register charger\n");
> +		return PTR_ERR(info->charger);
> +	}
> +
> +	/* Disable the threshold alerts, we're not using them */
> +	regmap_write(info->regmap, LTC4162L_EN_LIMIT_ALERTS_REG, 0);
> +
> +	/* Enable interrupts on all status changes */
> +	regmap_write(info->regmap, LTC4162L_EN_CHARGER_STATE_ALERTS_REG,
> +		     0x1fff);
> +	regmap_write(info->regmap, LTC4162L_EN_CHARGE_STATUS_ALERTS_REG, 0x1f);
> +
> +	ltc4162l_clear_interrupts(info);
> +
> +	return 0;
> +}
> +
> +static void ltc4162l_alert(struct i2c_client *client,
> +			   enum i2c_alert_protocol type, unsigned int flag)
> +{
> +	struct ltc4162l_info *info =3D i2c_get_clientdata(client);
> +
> +	if (type !=3D I2C_PROTOCOL_SMBUS_ALERT)
> +		return;
> +
> +	ltc4162l_clear_interrupts(info);
> +	power_supply_changed(info->charger);
> +}
> +
> +static const struct i2c_device_id ltc4162l_i2c_id_table[] =3D {
> +	{ "ltc4162-l", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, ltc4162l_i2c_id_table);
> +
> +static const struct of_device_id ltc4162l_of_match[] =3D {
> +	{ .compatible =3D "lltc,ltc4162-l", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ltc4162l_of_match);
> +
> +static struct i2c_driver ltc4162l_driver =3D {
> +	.probe		=3D ltc4162l_probe,
> +	.alert		=3D ltc4162l_alert,
> +	.id_table	=3D ltc4162l_i2c_id_table,
> +	.driver =3D {
> +		.name		=3D "ltc4162-l-charger",
> +		.of_match_table	=3D of_match_ptr(ltc4162l_of_match),
> +	},
> +};
> +module_i2c_driver(ltc4162l_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
> +MODULE_DESCRIPTION("LTC4162-L charger driver");
> --=20
> 2.17.1
>=20

--ez3ypcogxv2dih72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/+NYYACgkQ2O7X88g7
+pqrnQ//eh2NNadlsZPvGhOCDDy8cz7QRuEaOjbsqM5UrV4TyV5NyJf1ZXaBt3lP
UdsVwvpHPXudWWbA767hkcHTb2dB2nwOr8tYEtoy2kSkTr4sGYjFY8FUy/W8Q7m7
eF+PWv+KELaNC2BulQNrHa4MEU0Sx7saWz4HvbSO/eWw29hesEjeGS+IXRFb3FOF
iH1vFmWI1AtXmkxuREeuBw+xW1scQGc+OO6Y1Q6lp9pjAp1ZnHKLmIYy89KlR1MV
j+HyJxpojeULfJJkTyeB4Ua6wLDHyr9KZU6tryMyiKEB5lbIN1d6pmuNyZelbhcv
FHo25DMHXflx1XCiQvTl+jvMR3rco6ghHKqDXo2rCGGnHscugz6TLtlBx2jXCuai
PR+Npui3lAXif9weA2AmmTOJgQkISPiyWr/wp9hnfh3BVt3vQVtW54dWUNRSPSZ1
I2Uppw/qwFh2z1+IbXNTiw77j+U56rJL0Bb5QSYAMzGb3o5RAvAuKxQ9mpn0Q3JB
IYhhQA+iLM97eIBWDJ8gUJHXC1xMdoQ30e8lz38d+NCz2h/td2d0V2W4USyKV4oi
s3Ea8iyMxwCCyDTjIAuQyY6SEXBTQOda2989IZIt5aFRGYFUUTJFgKFW/IAUBYAS
SWKcYFbcTGNJQlf37Ro6WDFN78MMuvktsIHAQkdNO8OJQ+7VWSU=
=oaY4
-----END PGP SIGNATURE-----

--ez3ypcogxv2dih72--
