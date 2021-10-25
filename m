Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F075D43A6BA
	for <lists+linux-pm@lfdr.de>; Tue, 26 Oct 2021 00:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbhJYWnY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 18:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbhJYWnV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 18:43:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE55C061745;
        Mon, 25 Oct 2021 15:40:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8A0121F42821
Received: by earth.universe (Postfix, from userid 1000)
        id 589F93C0CA8; Tue, 26 Oct 2021 00:40:54 +0200 (CEST)
Date:   Tue, 26 Oct 2021 00:40:54 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Thomas Marangoni <thomas.marangoni@mec.at>
Cc:     wens@csie.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM: Added functionality to the axp20x_battery driver
Message-ID: <20211025224054.iu4qtvn6kawxhh46@earth.universe>
References: <20211025144455.16665-1-thomas.marangoni@mec.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zb4qf67uzuv3sphl"
Content-Disposition: inline
In-Reply-To: <20211025144455.16665-1-thomas.marangoni@mec.at>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zb4qf67uzuv3sphl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 25, 2021 at 04:44:55PM +0200, Thomas Marangoni wrote:
> This patch adds missing features of the axp209 battery
> functionality to the driver.

I don't consider "Add missing features" as one logical change, so
please split this according to Documentation/process/submitting-patches.rst

> New and present features have been added to the device tree configuration.
>=20
> Following features have been implemented:
> - Set/Get of OCV curve, this is used to tune the capacity status (setting=
 these
>   values is only possible with the device tree).
> - Set/Get of voltage low alert, this will trigger an interrupt if the giv=
en
>   voltage level is reached. Level 1 will print a warning and level 2 will=
 shutdown
>   the device.
> - Set/Get of temperature sense current, this is useful if a none default =
NTC is
>   used for temperature sensing.
> - Set/Get of temperature sense rate, this defines how often the ADC is ge=
tting
>   the temperature values.
> - Set/Get of temperature charging and discharging voltages, this defines =
the
>   temperature ranges (as voltage) where the battery can be charged.
>   (setting these values is only possible with the device tree).
> - Get of temperature voltage, this returns the voltage that is present on=
 the NTC.

Why is the temperature not converted to =B0C allowing to use
standard properties and being more user friendly?

> These custom properties have been added to /sys:
> - voltage_low_alert_level1 (RW)
> - voltage_low_alert_level2 (RW)
> - ocv_curve (RO)
> - temperature_sense_current (RW)
> - temperature_sense_rate (RW)
> - temperature_sense_voltage_now (RO)
> - temperature_discharge_threshold_voltage_range (RO)
> - temperature_charge_threshold_voltage_range (RO)
>=20
> These IRQs have been added:
> - BATT_PLUGIN (generic, useful for udev)
> - BATT_REMOVAL (generic, useful for udev)
> - CHARG (generic, useful for udev)
> - CHARG_DONE (generic, useful for udev)
> - BATT_TEMP_HIGH (prints warning, axp stops charging/discharging)
> - BATT_TEMP_LOW (prints warning, axp stops charging/discharging)
> - LOW_PWR_LVL1 (prints warning)
> - LOW_PWR_LVL2 (prints warning and initializes a system shutdown)

Battery temperature and low power events should also be reported
through the HEALTH property if possible (i.e. if this information
can be read from a register that keeps the state until the condition
changes). In that case the IRQ should also trigger
power_supply_changed().

> These properties have been added to be applied from the device tree:
> - low-voltage-level1-microvolt
> - low-voltage-level2-microvolt
> - temperature-sense-current-microamp
> - temperature-sense-rate-hertz
> - temperature-discharge-range-microvolt
> - temperature-charge-range-microvolt
> - voltage-max-design-microvolt
> - ocv-capacity-table-0
>=20
> Signed-off-by: Thomas Marangoni <thomas.marangoni@mec.at>
> ---
>  drivers/mfd/axp20x.c                  |  13 +
>  drivers/power/supply/axp20x_battery.c | 938 +++++++++++++++++++++++++-
>  2 files changed, 945 insertions(+), 6 deletions(-)

DT ABI changes require updates to the devicetree binding files [0] &
[1] with the DT maintainers being in Cc.

Custom sysfs properties need to be documented in the userspace ABI
documentation in a new file [2], or become standard properties and
be documented in [3].

[0] Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-=
power-supply.yaml
[1] Documentation/devicetree/bindings/power/supply/battery.yaml
[2] Documentation/ABI/testing/sysfs-class-power-axp20x-battery
[3] Documentation/ABI/testing/sysfs-class-power

For now I will stop reviewing here ;)

Thanks,

-- Sebastian

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 8161a5dc68e8..05dea452b513 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -191,6 +191,17 @@ static const struct resource axp20x_usb_power_supply=
_resources[] =3D {
>  	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_VBUS_NOT_VALID, "VBUS_NOT_VALID"),
>  };
> =20
> +static const struct resource axp20x_battery_power_supply_resources[] =3D=
 {
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_BATT_PLUGIN, "BATT_PLUGIN"),
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_BATT_REMOVAL, "BATT_REMOVAL"),
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_CHARG, "CHARG"),
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_CHARG_DONE, "CHARG_DONE"),
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_BATT_TEMP_HIGH, "BATT_TEMP_HIGH"),
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_BATT_TEMP_LOW, "BATT_TEMP_LOW"),
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_LOW_PWR_LVL1, "LOW_PWR_LVL1"),
> +	DEFINE_RES_IRQ_NAMED(AXP20X_IRQ_LOW_PWR_LVL2, "LOW_PWR_LVL2"),
> +};
> +
>  static const struct resource axp22x_usb_power_supply_resources[] =3D {
>  	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_PLUGIN, "VBUS_PLUGIN"),
>  	DEFINE_RES_IRQ_NAMED(AXP22X_IRQ_VBUS_REMOVAL, "VBUS_REMOVAL"),
> @@ -604,6 +615,8 @@ static const struct mfd_cell axp20x_cells[] =3D {
>  	}, {
>  		.name		=3D "axp20x-battery-power-supply",
>  		.of_compatible	=3D "x-powers,axp209-battery-power-supply",
> +		.num_resources	=3D ARRAY_SIZE(axp20x_battery_power_supply_resources),
> +		.resources	=3D axp20x_battery_power_supply_resources,
>  	}, {
>  		.name		=3D "axp20x-ac-power-supply",
>  		.of_compatible	=3D "x-powers,axp202-ac-power-supply",
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply=
/axp20x_battery.c
> index 18a9db0df4b1..5997c8192c73 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -31,6 +31,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/consumer.h>
>  #include <linux/mfd/axp20x.h>
> +#include <linux/reboot.h>
> =20
>  #define AXP20X_PWR_STATUS_BAT_CHARGING	BIT(2)
> =20
> @@ -56,6 +57,25 @@
> =20
>  #define AXP20X_V_OFF_MASK		GENMASK(2, 0)
> =20
> +#define AXP20X_APS_WARN_MASK		GENMASK(7, 0)
> +
> +#define AXP20X_TEMP_MASK		GENMASK(7, 0)
> +
> +#define AXP20X_ADC_TS_RATE_MASK		GENMASK(7, 6)
> +#define AXP20X_ADC_TS_RATE_25Hz		(0 << 6)
> +#define AXP20X_ADC_TS_RATE_50Hz		(1 << 6)
> +#define AXP20X_ADC_TS_RATE_100Hz	(2 << 6)
> +#define AXP20X_ADC_TS_RATE_200Hz	(3 << 6)
> +
> +#define AXP20X_ADC_TS_CURRENT_MASK	GENMASK(5, 4)
> +#define AXP20X_ADC_TS_CURRENT_20uA	(0 << 4)
> +#define AXP20X_ADC_TS_CURRENT_40uA	(1 << 4)
> +#define AXP20X_ADC_TS_CURRENT_60uA	(2 << 4)
> +#define AXP20X_ADC_TS_CURRENT_80uA	(3 << 4)
> +
> +
> +#define DRVNAME "axp20x-battery-power-supply"
> +
>  struct axp20x_batt_ps;
> =20
>  struct axp_data {
> @@ -78,6 +98,79 @@ struct axp20x_batt_ps {
>  	const struct axp_data	*data;
>  };
> =20
> +/*
> + * OCV curve has fixed values and percentage can be adjusted, this array=
 represents
> + * the fixed values in uV
> + */
> +const int axp20x_ocv_values_uV[AXP20X_OCV_MAX + 1] =3D {
> +	3132800,
> +	3273600,
> +	3414400,
> +	3555200,
> +	3625600,
> +	3660800,
> +	3696000,
> +	3731200,
> +	3766400,
> +	3801600,
> +	3836800,
> +	3872000,
> +	3942400,
> +	4012800,
> +	4083200,
> +	4153600,
> +};
> +
> +static irqreturn_t axp20x_battery_power_irq(int irq, void *devid)
> +{
> +	struct axp20x_batt_ps *axp20x_batt =3D devid;
> +
> +	power_supply_changed(axp20x_batt->batt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t axp20x_battery_low_voltage_alert1_irq(int irq, void *=
devid)
> +{
> +	struct axp20x_batt_ps *axp20x_batt =3D devid;
> +
> +	dev_warn(axp20x_batt->dev, "Battery voltage low!");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +
> +static irqreturn_t axp20x_battery_low_voltage_alert2_irq(int irq, void *=
devid)
> +{
> +	struct axp20x_batt_ps *axp20x_batt =3D devid;
> +
> +	dev_emerg(axp20x_batt->dev, "Battery voltage very low! Iniatializing sh=
utdown.");
> +
> +	orderly_poweroff(true);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t axp20x_battery_temperature_low_irq(int irq, void *dev=
id)
> +{
> +	struct axp20x_batt_ps *axp20x_batt =3D devid;
> +
> +	dev_crit(axp20x_batt->dev, "Battery temperature to low!");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +
> +static irqreturn_t axp20x_battery_temperature_high_irq(int irq, void *de=
vid)
> +{
> +	struct axp20x_batt_ps *axp20x_batt =3D devid;
> +
> +	dev_crit(axp20x_batt->dev, "Battery temperature to high!");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +
>  static int axp20x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_=
batt,
>  					  int *val)
>  {
> @@ -181,6 +274,361 @@ static int axp20x_get_constant_charge_current(struc=
t axp20x_batt_ps *axp,
>  	return 0;
>  }
> =20
> +static int axp20x_battery_set_ocv_table(struct axp20x_batt_ps *axp_batt,
> +					struct power_supply_battery_ocv_table ocv_table[AXP20X_OCV_MAX+1],
> +					int ocv_table_size)
> +{
> +	int ret, i, error =3D 0;
> +
> +	if (ocv_table_size !=3D AXP20X_OCV_MAX+1)
> +		return 1;
> +
> +	for (i =3D 0; i < ocv_table_size; i++) {
> +		ret =3D regmap_update_bits(axp_batt->regmap, AXP20X_OCV(i),
> +			GENMASK(7, 0), ocv_table[i].capacity);
> +
> +		if (ret)
> +			error =3D ret;
> +	}
> +
> +	return error;
> +}
> +
> +static int axp20x_battery_set_voltage_low_alert1(struct axp20x_batt_ps *=
axp_batt,
> +					 int voltage_alert)
> +{
> +	int ret;
> +	/* converts the warning voltage level in uV to the neeeded reg value */
> +	int val1 =3D (voltage_alert - 2867200) / (1400 * 4);
> +
> +	if (val1 < 0 || val1 > AXP20X_APS_WARN_MASK)
> +		return -EINVAL;
> +
> +	ret =3D regmap_update_bits(axp_batt->regmap, AXP20X_APS_WARN_L1,
> +				  AXP20X_APS_WARN_MASK, val1);
> +
> +	return ret;
> +}
> +
> +static int axp20x_battery_get_voltage_low_alert1(struct axp20x_batt_ps *=
axp_batt,
> +						 int *voltage_alert)
> +{
> +	int reg, ret;
> +
> +	ret =3D regmap_read(axp_batt->regmap, AXP20X_APS_WARN_L1, &reg);
> +	if (ret)
> +		return ret;
> +
> +	/* converts the reg value to warning voltage level in uV */
> +	*voltage_alert =3D 2867200 + (1400 * (reg & AXP20X_APS_WARN_MASK) * 4);
> +
> +	return ret;
> +}
> +
> +static int axp20x_battery_set_voltage_low_alert2(struct axp20x_batt_ps *=
axp_batt,
> +					 int voltage_alert)
> +{
> +	int ret;
> +
> +	/* converts the warning voltage level in uV to the neeeded reg value */
> +	int val1 =3D (voltage_alert - 2867200) / (1400 * 4);
> +
> +	if (val1 < 0 || val1 > AXP20X_APS_WARN_MASK)
> +		return -EINVAL;
> +
> +	ret =3D regmap_update_bits(axp_batt->regmap, AXP20X_APS_WARN_L2,
> +				  AXP20X_APS_WARN_MASK, val1);
> +
> +	return ret;
> +}
> +
> +static int axp20x_battery_get_voltage_low_alert2(struct axp20x_batt_ps *=
axp_batt,
> +						 int *voltage_alert)
> +{
> +	int reg, ret;
> +
> +	ret =3D regmap_read(axp_batt->regmap, AXP20X_APS_WARN_L2, &reg);
> +	if (ret)
> +		return ret;
> +
> +	/* converts the reg value to warning voltage level in uV */
> +	*voltage_alert =3D 2867200 + (1400 * (reg & AXP20X_APS_WARN_MASK) * 4);
> +
> +	return ret;
> +}
> +
> +static int axp20x_battery_set_temperature_sense_current(struct axp20x_ba=
tt_ps *axp_batt,
> +							int sense_current)
> +{
> +	int ret;
> +	int reg =3D -1;
> +
> +	switch (sense_current) {
> +	case 20:
> +		reg =3D AXP20X_ADC_TS_CURRENT_20uA;
> +		break;
> +	case 40:
> +		reg =3D AXP20X_ADC_TS_CURRENT_40uA;
> +		break;
> +	case 60:
> +		reg =3D AXP20X_ADC_TS_CURRENT_60uA;
> +		break;
> +	case 80:
> +		reg =3D AXP20X_ADC_TS_CURRENT_80uA;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (reg < 0)
> +		return -EINVAL;
> +
> +	ret =3D regmap_update_bits(axp_batt->regmap, AXP20X_ADC_RATE,
> +				  AXP20X_ADC_TS_CURRENT_MASK, reg);
> +
> +	return ret;
> +}
> +
> +static int axp20x_battery_get_temperature_sense_current(struct axp20x_ba=
tt_ps *axp_batt,
> +							int *sense_current)
> +{
> +	int reg, ret;
> +
> +	ret =3D regmap_read(axp_batt->regmap, AXP20X_ADC_RATE, &reg);
> +	if (ret)
> +		return ret;
> +
> +	reg =3D reg & AXP20X_ADC_TS_CURRENT_MASK;
> +
> +	switch (reg) {
> +	case AXP20X_ADC_TS_CURRENT_20uA:
> +		*sense_current =3D 20;
> +		break;
> +	case AXP20X_ADC_TS_CURRENT_40uA:
> +		*sense_current =3D 40;
> +		break;
> +	case AXP20X_ADC_TS_CURRENT_60uA:
> +		*sense_current =3D 60;
> +		break;
> +	case AXP20X_ADC_TS_CURRENT_80uA:
> +		*sense_current =3D 80;
> +		break;
> +	default:
> +		*sense_current =3D -1;
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int axp20x_battery_set_temperature_sense_rate(struct axp20x_batt_=
ps *axp_batt,
> +						     int sample_rate)
> +{
> +	int ret;
> +	int reg =3D -1;
> +
> +	switch (sample_rate) {
> +	case 25:
> +		reg =3D AXP20X_ADC_TS_RATE_25Hz;
> +		break;
> +	case 50:
> +		reg =3D AXP20X_ADC_TS_RATE_50Hz;
> +		break;
> +	case 100:
> +		reg =3D AXP20X_ADC_TS_RATE_100Hz;
> +		break;
> +	case 200:
> +		reg =3D AXP20X_ADC_TS_RATE_200Hz;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (reg < 0)
> +		return -EINVAL;
> +
> +	ret =3D regmap_update_bits(axp_batt->regmap, AXP20X_ADC_RATE,
> +				  AXP20X_ADC_TS_RATE_MASK, reg);
> +
> +	return ret;
> +}
> +
> +static int axp20x_battery_get_temperature_sense_rate(struct axp20x_batt_=
ps *axp_batt,
> +						     int *sample_rate)
> +{
> +	int reg, ret;
> +
> +	ret =3D regmap_read(axp_batt->regmap, AXP20X_ADC_RATE, &reg);
> +	if (ret)
> +		return ret;
> +
> +	reg =3D reg & AXP20X_ADC_TS_RATE_MASK;
> +
> +	switch (reg) {
> +	case AXP20X_ADC_TS_RATE_25Hz:
> +		*sample_rate =3D 25;
> +		break;
> +	case AXP20X_ADC_TS_RATE_50Hz:
> +		*sample_rate =3D 50;
> +		break;
> +	case AXP20X_ADC_TS_RATE_100Hz:
> +		*sample_rate =3D 100;
> +		break;
> +	case AXP20X_ADC_TS_RATE_200Hz:
> +		*sample_rate =3D 200;
> +		break;
> +	default:
> +		*sample_rate =3D -1;
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int axp20x_battery_set_temperature_discharge_voltage_min(struct a=
xp20x_batt_ps *axp_batt,
> +								int voltage)
> +{
> +	int ret;
> +
> +	int val1 =3D voltage / (0x10 * 800);
> +
> +	if (val1 < 0 || val1 > AXP20X_TEMP_MASK)
> +		return -EINVAL;
> +
> +	ret =3D regmap_update_bits(axp_batt->regmap, AXP20X_V_LTF_DISCHRG,
> +				  AXP20X_TEMP_MASK, val1);
> +
> +	return ret;
> +}
> +
> +static int axp20x_battery_get_temperature_discharge_voltage_min(struct a=
xp20x_batt_ps *axp_batt,
> +								int *voltage)
> +{
> +	int reg, ret;
> +
> +	ret =3D regmap_read(axp_batt->regmap, AXP20X_V_LTF_DISCHRG, &reg);
> +	if (ret)
> +		return ret;
> +
> +	*voltage =3D reg * 0x10 * 800;
> +
> +	return ret;
> +}
> +
> +static int axp20x_battery_set_temperature_discharge_voltage_max(struct a=
xp20x_batt_ps *axp_batt,
> +								int voltage)
> +{
> +	int ret;
> +
> +	int val1 =3D voltage / (0x10 * 800);
> +
> +	if (val1 < 0 || val1 > AXP20X_TEMP_MASK)
> +		return -EINVAL;
> +
> +	ret =3D regmap_update_bits(axp_batt->regmap, AXP20X_V_HTF_DISCHRG,
> +				  AXP20X_TEMP_MASK, val1);
> +
> +	return ret;
> +}
> +
> +static int axp20x_battery_get_temperature_discharge_voltage_max(struct a=
xp20x_batt_ps *axp_batt,
> +								int *voltage)
> +{
> +	int reg, ret;
> +
> +	ret =3D regmap_read(axp_batt->regmap, AXP20X_V_HTF_DISCHRG, &reg);
> +	if (ret)
> +		return ret;
> +
> +	*voltage =3D reg * 0x10 * 800;
> +
> +	return ret;
> +}
> +
> +static int axp20x_battery_set_temperature_charge_voltage_min(struct axp2=
0x_batt_ps *axp_batt,
> +							     int voltage)
> +{
> +	int ret;
> +
> +	int val1 =3D voltage / (0x10 * 800);
> +
> +	if (val1 < 0 || val1 > AXP20X_TEMP_MASK)
> +		return -EINVAL;
> +
> +	ret =3D regmap_update_bits(axp_batt->regmap, AXP20X_V_LTF_CHRG,
> +				  AXP20X_TEMP_MASK, val1);
> +
> +	return ret;
> +}
> +
> +static int axp20x_battery_get_temperature_charge_voltage_min(struct axp2=
0x_batt_ps *axp_batt,
> +							     int *voltage)
> +{
> +	int reg, ret;
> +
> +	ret =3D regmap_read(axp_batt->regmap, AXP20X_V_LTF_CHRG, &reg);
> +	if (ret)
> +		return ret;
> +
> +	*voltage =3D reg * 0x10 * 800;
> +
> +	return ret;
> +}
> +
> +static int axp20x_battery_set_temperature_charge_voltage_max(struct axp2=
0x_batt_ps *axp_batt,
> +							     int voltage)
> +{
> +	int ret;
> +
> +	int val1 =3D voltage / (0x10 * 800);
> +
> +	if (val1 < 0 || val1 > AXP20X_TEMP_MASK)
> +		return -EINVAL;
> +
> +	ret =3D regmap_update_bits(axp_batt->regmap, AXP20X_V_HTF_CHRG,
> +				  AXP20X_TEMP_MASK, val1);
> +
> +	return ret;
> +}
> +
> +static int axp20x_battery_get_temperature_charge_voltage_max(struct axp2=
0x_batt_ps *axp_batt,
> +							     int *voltage)
> +{
> +	int reg, ret;
> +
> +	ret =3D regmap_read(axp_batt->regmap, AXP20X_V_HTF_CHRG, &reg);
> +	if (ret)
> +		return ret;
> +
> +	*voltage =3D reg * 0x10 * 800;
> +
> +	return ret;
> +}
> +
> +static int axp20x_battery_get_temp_sense_voltage_now(struct axp20x_batt_=
ps *axp_batt,
> +						     int *voltage)
> +{
> +	int reg, ret, val1;
> +
> +	ret =3D regmap_read(axp_batt->regmap, AXP20X_TS_IN_L, &reg);
> +	if (ret)
> +		return ret;
> +
> +	val1 =3D reg;
> +
> +	ret =3D regmap_read(axp_batt->regmap, AXP20X_TS_IN_H, &reg);
> +	if (ret)
> +		return ret;
> +
> +	/* merging high and low value */
> +	val1 =3D (reg << 4) | val1;
> +
> +	/* convert register value to real uV */
> +	*voltage =3D val1 * 800;
> +
> +	return ret;
> +}
> +
>  static int axp20x_battery_get_prop(struct power_supply *psy,
>  				   enum power_supply_property psp,
>  				   union power_supply_propval *val)
> @@ -461,7 +909,8 @@ static int axp20x_battery_set_prop(struct power_suppl=
y *psy,
>  		return axp20x_set_voltage_min_design(axp20x_batt, val->intval);
> =20
>  	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> -		return axp20x_batt->data->set_max_voltage(axp20x_batt, val->intval);
> +		return axp20x_batt->data->set_max_voltage(axp20x_batt,
> +							  val->intval);
> =20
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
>  		return axp20x_set_constant_charge_current(axp20x_batt,
> @@ -472,13 +921,16 @@ static int axp20x_battery_set_prop(struct power_sup=
ply *psy,
>  	case POWER_SUPPLY_PROP_STATUS:
>  		switch (val->intval) {
>  		case POWER_SUPPLY_STATUS_CHARGING:
> -			return regmap_update_bits(axp20x_batt->regmap, AXP20X_CHRG_CTRL1,
> -				AXP20X_CHRG_CTRL1_ENABLE, AXP20X_CHRG_CTRL1_ENABLE);
> +			return regmap_update_bits(axp20x_batt->regmap,
> +						  AXP20X_CHRG_CTRL1,
> +						  AXP20X_CHRG_CTRL1_ENABLE,
> +						  AXP20X_CHRG_CTRL1_ENABLE);
> =20
>  		case POWER_SUPPLY_STATUS_DISCHARGING:
>  		case POWER_SUPPLY_STATUS_NOT_CHARGING:
> -			return regmap_update_bits(axp20x_batt->regmap, AXP20X_CHRG_CTRL1,
> -				AXP20X_CHRG_CTRL1_ENABLE, 0);
> +			return regmap_update_bits(axp20x_batt->regmap,
> +						  AXP20X_CHRG_CTRL1,
> +						  AXP20X_CHRG_CTRL1_ENABLE, 0);
>  		}
>  		fallthrough;
>  	default:
> @@ -510,6 +962,275 @@ static int axp20x_battery_prop_writeable(struct pow=
er_supply *psy,
>  	       psp =3D=3D POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;
>  }
> =20
> +/* -- Custom attributes ------------------------------------------------=
----- */
> +
> +static ssize_t voltage_low_alert_level1_show(struct device *dev,
> +					     struct device_attribute *attr,
> +					     char *buf)
> +{
> +	struct power_supply *psy =3D dev_get_drvdata(dev);
> +	struct axp20x_batt_ps *axp20x_batt =3D power_supply_get_drvdata(psy);
> +	int status;
> +
> +	int voltage_alert;
> +
> +	axp20x_battery_get_voltage_low_alert1(axp20x_batt, &voltage_alert);
> +	status =3D sprintf(buf, "%d\n", voltage_alert);
> +
> +	return status;
> +}
> +
> +static ssize_t voltage_low_alert_level1_store(struct device *dev,
> +					      struct device_attribute *attr,
> +					      const char *buf, size_t count)
> +{
> +	struct power_supply *psy =3D dev_get_drvdata(dev);
> +
> +	struct axp20x_batt_ps *axp20x_batt =3D power_supply_get_drvdata(psy);
> +	unsigned long value;
> +	int status;
> +
> +	status =3D kstrtoul(buf, 0, &value);
> +	if (status)
> +		return status;
> +
> +	status =3D axp20x_battery_set_voltage_low_alert1(axp20x_batt, value);
> +	if (status)
> +		return status;
> +
> +	return count;
> +}
> +
> +DEVICE_ATTR_RW(voltage_low_alert_level1);
> +
> +static ssize_t voltage_low_alert_level2_show(struct device *dev,
> +					     struct device_attribute *attr,
> +					     char *buf)
> +{
> +	struct power_supply *psy =3D dev_get_drvdata(dev);
> +	struct axp20x_batt_ps *axp20x_batt =3D power_supply_get_drvdata(psy);
> +	int status;
> +
> +	int voltage_alert;
> +
> +	axp20x_battery_get_voltage_low_alert2(axp20x_batt, &voltage_alert);
> +	status =3D sprintf(buf, "%d\n", voltage_alert);
> +
> +	return status;
> +}
> +
> +static ssize_t voltage_low_alert_level2_store(struct device *dev,
> +					      struct device_attribute *attr,
> +					      const char *buf, size_t count)
> +{
> +	struct power_supply *psy =3D dev_get_drvdata(dev);
> +	struct axp20x_batt_ps *axp20x_batt =3D power_supply_get_drvdata(psy);
> +	unsigned long value;
> +	int status;
> +
> +	status =3D kstrtoul(buf, 0, &value);
> +	if (status)
> +		return status;
> +
> +	status =3D axp20x_battery_set_voltage_low_alert2(axp20x_batt, value);
> +	if (status)
> +		return status;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(voltage_low_alert_level2);
> +
> +static ssize_t ocv_curve_show(struct device *dev, struct device_attribut=
e *attr,
> +			      char *buf)
> +{
> +	struct power_supply *psy =3D dev_get_drvdata(dev);
> +	struct axp20x_batt_ps *axp20x_batt =3D power_supply_get_drvdata(psy);
> +	int status, ret, reg, i;
> +
> +	int ocv_curve_size =3D AXP20X_OCV_MAX+1;
> +	struct power_supply_battery_ocv_table ocv_curve[AXP20X_OCV_MAX+1];
> +
> +
> +	status =3D 0;
> +	for (i =3D 0; i < ocv_curve_size; i++) {
> +		ret =3D regmap_read(axp20x_batt->regmap, AXP20X_OCV(i), &reg);
> +		if (ret)
> +			status =3D ret;
> +		ocv_curve[i].capacity =3D reg;
> +		ocv_curve[i].ocv =3D axp20x_ocv_values_uV[i];
> +	}
> +
> +	if (status)
> +		return status;
> +
> +	status =3D 0;
> +	for (i =3D 0; i < ocv_curve_size; i++) {
> +		ret =3D sprintf(buf, "%sOCV_%d=3D%d\nCAP_%d=3D%d\n", buf, i,
> +			      ocv_curve[i].ocv, i, ocv_curve[i].capacity);
> +		if (ret)
> +			status =3D ret;
> +	}
> +
> +	return status;
> +}
> +
> +static DEVICE_ATTR_RO(ocv_curve);
> +
> +static ssize_t temperature_sense_current_show(struct device *dev,
> +					      struct device_attribute *attr,
> +					      char *buf)
> +{
> +	struct power_supply *psy =3D dev_get_drvdata(dev);
> +	struct axp20x_batt_ps *axp20x_batt =3D power_supply_get_drvdata(psy);
> +	int status;
> +
> +	int sense_current;
> +
> +	axp20x_battery_get_temperature_sense_current(axp20x_batt, &sense_curren=
t);
> +	status =3D sprintf(buf, "%d\n", sense_current);
> +
> +	return status;
> +}
> +
> +static ssize_t temperature_sense_current_store(struct device *dev,
> +					       struct device_attribute *attr,
> +					       const char *buf, size_t count)
> +{
> +	struct power_supply *psy =3D dev_get_drvdata(dev);
> +	struct axp20x_batt_ps *axp20x_batt =3D power_supply_get_drvdata(psy);
> +	unsigned long value;
> +	int status;
> +
> +	status =3D kstrtoul(buf, 0, &value);
> +	if (status)
> +		return status;
> +
> +	status =3D axp20x_battery_set_temperature_sense_current(axp20x_batt, va=
lue);
> +	if (status)
> +		return status;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(temperature_sense_current);
> +
> +static ssize_t temperature_sense_rate_show(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct power_supply *psy =3D dev_get_drvdata(dev);
> +	struct axp20x_batt_ps *axp20x_batt =3D power_supply_get_drvdata(psy);
> +	int status;
> +
> +	int sense_rate;
> +
> +	axp20x_battery_get_temperature_sense_rate(axp20x_batt, &sense_rate);
> +	status =3D sprintf(buf, "%d\n", sense_rate);
> +
> +	return status;
> +}
> +
> +static ssize_t temperature_sense_rate_store(struct device *dev,
> +					    struct device_attribute *attr,
> +					    const char *buf, size_t count)
> +{
> +	struct power_supply *psy =3D dev_get_drvdata(dev);
> +	struct axp20x_batt_ps *axp20x_batt =3D power_supply_get_drvdata(psy);
> +	unsigned long value;
> +	int status;
> +
> +	status =3D kstrtoul(buf, 0, &value);
> +	if (status)
> +		return status;
> +
> +	status =3D axp20x_battery_set_temperature_sense_rate(axp20x_batt, value=
);
> +	if (status)
> +		return status;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(temperature_sense_rate);
> +
> +static ssize_t temperature_sense_voltage_now_show(struct device *dev,
> +						  struct device_attribute *attr,
> +						  char *buf)
> +{
> +	struct power_supply *psy =3D dev_get_drvdata(dev);
> +	struct axp20x_batt_ps *axp20x_batt =3D power_supply_get_drvdata(psy);
> +	int status;
> +
> +	int voltage;
> +
> +	axp20x_battery_get_temp_sense_voltage_now(axp20x_batt, &voltage);
> +	status =3D sprintf(buf, "%d\n", voltage);
> +
> +	return status;
> +}
> +
> +static DEVICE_ATTR_RO(temperature_sense_voltage_now);
> +
> +static ssize_t temperature_discharge_threshold_voltage_range_show(struct=
 device *dev,
> +								  struct device_attribute *attr,
> +								  char *buf)
> +{
> +	struct power_supply *psy =3D dev_get_drvdata(dev);
> +	struct axp20x_batt_ps *axp20x_batt =3D power_supply_get_drvdata(psy);
> +	int status;
> +
> +	int min_voltage, max_voltage;
> +
> +	axp20x_battery_get_temperature_discharge_voltage_min(axp20x_batt,
> +							     &min_voltage);
> +	axp20x_battery_get_temperature_discharge_voltage_max(axp20x_batt,
> +							     &max_voltage);
> +
> +	status =3D sprintf(buf, "MIN=3D%d\nMAX=3D%d\n", min_voltage, max_voltag=
e);
> +
> +	return status;
> +}
> +
> +static DEVICE_ATTR_RO(temperature_discharge_threshold_voltage_range);
> +
> +static ssize_t temperature_charge_threshold_voltage_range_show(struct de=
vice *dev,
> +							       struct device_attribute *attr,
> +							       char *buf)
> +{
> +	struct power_supply *psy =3D dev_get_drvdata(dev);
> +	struct axp20x_batt_ps *axp20x_batt =3D power_supply_get_drvdata(psy);
> +	int status;
> +
> +	int min_voltage, max_voltage;
> +
> +	axp20x_battery_get_temperature_charge_voltage_min(axp20x_batt,
> +							  &min_voltage);
> +	axp20x_battery_get_temperature_charge_voltage_max(axp20x_batt,
> +							  &max_voltage);
> +
> +	status =3D sprintf(buf, "MIN=3D%d\nMAX=3D%d\n", min_voltage, max_voltag=
e);
> +
> +	return status;
> +}
> +
> +static DEVICE_ATTR_RO(temperature_charge_threshold_voltage_range);
> +
> +static struct attribute *axp20x_batt_attrs[] =3D {
> +	&dev_attr_voltage_low_alert_level1.attr,
> +	&dev_attr_voltage_low_alert_level2.attr,
> +	&dev_attr_ocv_curve.attr,
> +	&dev_attr_temperature_sense_current.attr,
> +	&dev_attr_temperature_sense_rate.attr,
> +	&dev_attr_temperature_sense_voltage_now.attr,
> +	&dev_attr_temperature_discharge_threshold_voltage_range.attr,
> +	&dev_attr_temperature_charge_threshold_voltage_range.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(axp20x_batt);
> +
> +/* -- Custom attributes END --------------------------------------------=
----- */
> +
>  static const struct power_supply_desc axp20x_batt_ps_desc =3D {
>  	.name =3D "axp20x-battery",
>  	.type =3D POWER_SUPPLY_TYPE_BATTERY,
> @@ -520,6 +1241,9 @@ static const struct power_supply_desc axp20x_batt_ps=
_desc =3D {
>  	.set_property =3D axp20x_battery_set_prop,
>  };
> =20
> +static const char * const irq_names[] =3D { "BATT_PLUGIN", "BATT_REMOVAL=
", "CHARG",
> +					  "CHARG_DONE", NULL };
> +
>  static const struct axp_data axp209_data =3D {
>  	.ccc_scale =3D 100000,
>  	.ccc_offset =3D 300000,
> @@ -559,10 +1283,12 @@ MODULE_DEVICE_TABLE(of, axp20x_battery_ps_id);
> =20
>  static int axp20x_power_probe(struct platform_device *pdev)
>  {
> +	struct axp20x_dev *axp20x =3D dev_get_drvdata(pdev->dev.parent);
>  	struct axp20x_batt_ps *axp20x_batt;
>  	struct power_supply_config psy_cfg =3D {};
>  	struct power_supply_battery_info info;
>  	struct device *dev =3D &pdev->dev;
> +	int i, irq, ret =3D 0;
> =20
>  	if (!of_device_is_available(pdev->dev.of_node))
>  		return -ENODEV;
> @@ -602,6 +1328,7 @@ static int axp20x_power_probe(struct platform_device=
 *pdev)
> =20
>  	psy_cfg.drv_data =3D axp20x_batt;
>  	psy_cfg.of_node =3D pdev->dev.of_node;
> +	psy_cfg.attr_grp =3D axp20x_batt_groups;
> =20
>  	axp20x_batt->data =3D (struct axp_data *)of_device_get_match_data(dev);
> =20
> @@ -615,14 +1342,105 @@ static int axp20x_power_probe(struct platform_dev=
ice *pdev)
>  	}
> =20
>  	if (!power_supply_get_battery_info(axp20x_batt->batt, &info)) {
> +		struct device_node *battery_np;
> +
>  		int vmin =3D info.voltage_min_design_uv;
> +		int vmax =3D info.voltage_max_design_uv;
>  		int ccc =3D info.constant_charge_current_max_ua;
> +		struct power_supply_battery_ocv_table ocv_table[AXP20X_OCV_MAX+1];
> +		int ocv_table_size =3D 0;
> +		int lvl1 =3D 0;
> +		int lvl2 =3D 0;
> +		int temp_sense_current =3D 0;
> +		int temp_sense_rate =3D 0;
> +		int temp_discharge_min =3D -1;
> +		int temp_discharge_max =3D -1;
> +		int temp_charge_min =3D -1;
> +		int temp_charge_max =3D -1;
> +
> +		int i =3D 0, j =3D 0;
> +		bool too_many_ocv_tables =3D false;
> +		bool too_many_ocv_values =3D false;
> +		bool ocv_values_mismatch =3D false;
> +
> +		battery_np =3D of_parse_phandle(axp20x_batt->batt->of_node,
> +					      "monitored-battery", 0);
> +
> +		of_property_read_u32(battery_np, "low-voltage-level1-microvolt",
> +				     &lvl1);
> +		of_property_read_u32(battery_np, "low-voltage-level2-microvolt",
> +				     &lvl2);
> +		of_property_read_u32(battery_np, "temperature-sense-current-microamp",
> +				     &temp_sense_current);
> +		of_property_read_u32(battery_np, "temperature-sense-rate-hertz",
> +				     &temp_sense_rate);
> +
> +		of_property_read_u32_index(battery_np, "temperature-discharge-range-mi=
crovolt",
> +					   0, &temp_discharge_min);
> +		of_property_read_u32_index(battery_np, "temperature-discharge-range-mi=
crovolt",
> +					   1, &temp_discharge_max);
> +
> +		of_property_read_u32_index(battery_np, "temperature-charge-range-micro=
volt",
> +					   0, &temp_charge_min);
> +		of_property_read_u32_index(battery_np, "temperature-charge-range-micro=
volt",
> +					   1, &temp_charge_max);
> =20
>  		if (vmin > 0 && axp20x_set_voltage_min_design(axp20x_batt,
>  							      vmin))
>  			dev_err(&pdev->dev,
>  				"couldn't set voltage_min_design\n");
> =20
> +		if (vmax > 0 && axp20x_battery_set_max_voltage(axp20x_batt,
> +							       vmax))
> +			dev_err(&pdev->dev,
> +				"couldn't set voltage_max_design\n");
> +
> +		if (lvl1 > 0 && axp20x_battery_set_voltage_low_alert1(axp20x_batt,
> +								      lvl1))
> +			dev_err(&pdev->dev,
> +				"couldn't set voltage_low_alert_level1\n");
> +
> +		if (lvl2 > 0 && axp20x_battery_set_voltage_low_alert2(axp20x_batt,
> +								      lvl2))
> +			dev_err(&pdev->dev,
> +				"couldn't set voltage_low_alert_level2\n");
> +
> +		if (temp_sense_current > 0 &&
> +		    axp20x_battery_set_temperature_sense_current(axp20x_batt,
> +								 temp_sense_current))
> +			dev_err(&pdev->dev,
> +				"couldn't set temperature_sense_current\n");
> +
> +		if (temp_sense_rate > 0 &&
> +		    axp20x_battery_set_temperature_sense_rate(axp20x_batt,
> +							      temp_sense_rate))
> +			dev_err(&pdev->dev,
> +				"couldn't set temperature_sense_rate\n");
> +
> +		if (temp_discharge_min >=3D 0 &&
> +		    axp20x_battery_set_temperature_discharge_voltage_min(axp20x_batt,
> +									 temp_discharge_min))
> +			dev_err(&pdev->dev,
> +				"couldn't set temperature_sense_rate\n");
> +
> +		if (temp_discharge_max >=3D 0 &&
> +		    axp20x_battery_set_temperature_discharge_voltage_max(axp20x_batt,
> +									 temp_discharge_max))
> +			dev_err(&pdev->dev,
> +				"couldn't set temperature_sense_rate\n");
> +
> +		if (temp_charge_min >=3D 0 &&
> +		    axp20x_battery_set_temperature_charge_voltage_min(axp20x_batt,
> +								      temp_charge_min))
> +			dev_err(&pdev->dev,
> +				"couldn't set temperature_sense_rate\n");
> +
> +		if (temp_charge_max >=3D 0 &&
> +		    axp20x_battery_set_temperature_charge_voltage_max(axp20x_batt,
> +								      temp_charge_max))
> +			dev_err(&pdev->dev,
> +				"couldn't set temperature_sense_rate\n");
> +
>  		/* Set max to unverified value to be able to set CCC */
>  		axp20x_batt->max_ccc =3D ccc;
> =20
> @@ -634,6 +1452,57 @@ static int axp20x_power_probe(struct platform_devic=
e *pdev)
>  			axp20x_batt->max_ccc =3D ccc;
>  			axp20x_set_constant_charge_current(axp20x_batt, ccc);
>  		}
> +
> +		too_many_ocv_tables =3D false;
> +		too_many_ocv_values =3D false;
> +		ocv_values_mismatch =3D false;
> +		for (i =3D 0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++) {
> +			if (info.ocv_table_size[i] =3D=3D -EINVAL ||
> +			   info.ocv_temp[i] =3D=3D -EINVAL ||
> +			   info.ocv_table[i] =3D=3D NULL)
> +				continue;
> +
> +			if (info.ocv_table_size[i] > (AXP20X_OCV_MAX+1)) {
> +				too_many_ocv_values =3D true;
> +				dev_err(&pdev->dev, "Too many values in ocv table, only %d values ar=
e supported",
> +					AXP20X_OCV_MAX + 1);
> +				break;
> +			}
> +
> +			if (i > 0) {
> +				too_many_ocv_tables =3D true;
> +				dev_err(&pdev->dev, "Only one ocv table is supported");
> +				break;
> +			}
> +
> +			for (j =3D 0; j < info.ocv_table_size[i]; j++) {
> +				if (info.ocv_table[i][j].ocv !=3D axp20x_ocv_values_uV[j]) {
> +					ocv_values_mismatch =3D true;
> +					break;
> +				}
> +			}
> +
> +			if (ocv_values_mismatch) {
> +				dev_err(&pdev->dev, "ocv tables missmatches requirements");
> +				dev_info(&pdev->dev, "ocv table requires following ocv values in tha=
t order:");
> +				for (j =3D 0; j < AXP20X_OCV_MAX+1; j++) {
> +					dev_info(&pdev->dev, "%d uV",
> +						 axp20x_ocv_values_uV[j]);
> +				}
> +				break;
> +			}
> +
> +			ocv_table_size =3D info.ocv_table_size[i];
> +			for (j =3D 0; j < info.ocv_table_size[i]; j++)
> +				ocv_table[j] =3D info.ocv_table[i][j];
> +
> +		}
> +
> +		if (!too_many_ocv_tables && !too_many_ocv_values &&
> +		    !ocv_values_mismatch)
> +			axp20x_battery_set_ocv_table(axp20x_batt, ocv_table,
> +						     ocv_table_size);
> +
>  	}
> =20
>  	/*
> @@ -643,13 +1512,70 @@ static int axp20x_power_probe(struct platform_devi=
ce *pdev)
>  	axp20x_get_constant_charge_current(axp20x_batt,
>  					   &axp20x_batt->max_ccc);
> =20
> +	/* Request irqs after registering, as irqs may trigger immediately */
> +	for (i =3D 0; irq_names[i]; i++) {
> +		irq =3D platform_get_irq_byname(pdev, irq_names[i]);
> +		if (irq < 0) {
> +			dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
> +				 irq_names[i], irq);
> +			continue;
> +		}
> +		irq =3D regmap_irq_get_virq(axp20x->regmap_irqc, irq);
> +		ret =3D devm_request_any_context_irq(&pdev->dev, irq,
> +						   axp20x_battery_power_irq, 0,
> +						   DRVNAME, axp20x_batt);
> +		if (ret < 0)
> +			dev_warn(&pdev->dev, "Error requesting %s IRQ: %d\n",
> +				 irq_names[i], ret);
> +	}
> +
> +	irq =3D platform_get_irq_byname(pdev, "LOW_PWR_LVL1");
> +	irq =3D regmap_irq_get_virq(axp20x->regmap_irqc, irq);
> +	ret =3D devm_request_any_context_irq(&pdev->dev, irq,
> +					   axp20x_battery_low_voltage_alert1_irq,
> +					   0, DRVNAME, axp20x_batt);
> +
> +	if (ret < 0)
> +		dev_warn(&pdev->dev, "Error requesting AXP20X_IRQ_LOW_PWR_LVL1 IRQ: %d=
\n",
> +			 ret);
> +
> +	irq =3D platform_get_irq_byname(pdev, "LOW_PWR_LVL2");
> +	irq =3D regmap_irq_get_virq(axp20x->regmap_irqc, irq);
> +	ret =3D devm_request_any_context_irq(&pdev->dev, irq,
> +					   axp20x_battery_low_voltage_alert2_irq,
> +					   0, DRVNAME, axp20x_batt);
> +
> +	if (ret < 0)
> +		dev_warn(&pdev->dev, "Error requesting AXP20X_IRQ_LOW_PWR_LVL2 IRQ: %d=
\n",
> +			 ret);
> +
> +	irq =3D platform_get_irq_byname(pdev, "BATT_TEMP_LOW");
> +	irq =3D regmap_irq_get_virq(axp20x->regmap_irqc, irq);
> +	ret =3D devm_request_any_context_irq(&pdev->dev, irq,
> +					   axp20x_battery_temperature_low_irq,
> +					   0, DRVNAME, axp20x_batt);
> +
> +	if (ret < 0)
> +		dev_warn(&pdev->dev, "Error requesting AXP20X_IRQ_BATT_TEMP_LOW IRQ: %=
d\n",
> +			 ret);
> +
> +	irq =3D platform_get_irq_byname(pdev, "BATT_TEMP_HIGH");
> +	irq =3D regmap_irq_get_virq(axp20x->regmap_irqc, irq);
> +	ret =3D devm_request_any_context_irq(&pdev->dev, irq,
> +					   axp20x_battery_temperature_high_irq,
> +					   0, DRVNAME, axp20x_batt);
> +
> +	if (ret < 0)
> +		dev_warn(&pdev->dev, "Error requesting AXP20X_IRQ_BATT_TEMP_HIGH IRQ: =
%d\n",
> +			 ret);
> +
>  	return 0;
>  }
> =20
>  static struct platform_driver axp20x_batt_driver =3D {
>  	.probe    =3D axp20x_power_probe,
>  	.driver   =3D {
> -		.name  =3D "axp20x-battery-power-supply",
> +		.name  =3D DRVNAME,
>  		.of_match_table =3D axp20x_battery_ps_id,
>  	},
>  };
> --=20
> 2.25.1
>=20

--zb4qf67uzuv3sphl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmF3MnMACgkQ2O7X88g7
+prT4w/+NZLFnSGh1Hdzk0VV5T/liOViycfeb75TUuo/rEqQbRjeaIylWc5pLOvS
71ah5LOGxKPgDeLIZUZsbyqczUpkehTxa5b5k7iLWCuFfJr3V5oeBOyf+XnopZcO
sW2oYuSKxfmeZbzQWfiXhrYGjSeDwU9fVVIFpMVQikIdzghr4LvPSt64UUBt5dlK
6iSI/HHl/dvta+B9VPIy5WIERUCb3+Pal3QhVfZX/QX+J1l7YNJykTFEp8gIs5UC
MpluNDexnoG3hydmY5P0t/gR1bH//lkacWM+/VehkYbpUUdBMx1o+BWaU5SevtH0
MpnP+yrl51Qsdv8QD0gyYiNQagk4oX0YnKzd81majCtWd/H2pxAAOMs5CTOI+tXU
4QbQqVu1+raxWuKJqdHmUS/94Oav7dbO+I0u1XKkCzTHJW2GHV6aMj8gwDCZ1z7S
GDcKRFAz33lr0g1ShTqJXAAlFyPbDbwXJ4GFwBcte7UYokiLDl11DWUFR4osUpW3
XB3y+CeyFRIZY7ySQOXrZ+b3MvQqJb7LftWt9vGofqBIMv6VndbJEEjhZKeAxAKd
Ll9dCvJcHEQ45FUIKIQQtIne+b8hKRbBpIyJWkq92QAMkHUpGw+ObilP28Cfia2L
hMKJc/7ACruuqnkMTFZtY8EoiX6Fvks3QCaK0feOFYIVW5QJOw8=
=VuQJ
-----END PGP SIGNATURE-----

--zb4qf67uzuv3sphl--
