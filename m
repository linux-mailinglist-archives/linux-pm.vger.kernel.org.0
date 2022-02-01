Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E1A4A6890
	for <lists+linux-pm@lfdr.de>; Wed,  2 Feb 2022 00:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiBAXdm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Feb 2022 18:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiBAXdk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Feb 2022 18:33:40 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43370C061714
        for <linux-pm@vger.kernel.org>; Tue,  1 Feb 2022 15:33:40 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5B2E11F4240E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643758418;
        bh=UevBHa5gltdxXG4BKS4p6E50AV4bzhKSl+JkDEFPB9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DEdu5KDGWskXennjFN8xnIRA4/zqe+R/Ed6DGzy6tvhzYcpiLSX5ZbjI6f7oQ7klx
         KKUpbpQk9+PtfGl7Jv1tqjBAI0BufYuWhbPKEbyaD9su6RiZi+KkzW4/VTDknPnMqz
         JDExO9jL7Rx6UhVNVRCx2Rv+gMn4Mj29DCtdUgB+1K1lYdmzsdtLHZER8WVzwWp5mx
         YoUw4WBOswK1Q5C116hM6hV9JqukaDrj1Knj1A8Ms+mjJGrsg9fK9le0pNcQPKic+H
         1/J4OKUp2Q6citiCb5QY7v4jTnTjJqTjA7ahXf1spg3JbZFsATj40AJqXhXw2tHzBT
         Ylibx62R4vHwA==
Received: by earth.universe (Postfix, from userid 1000)
        id E17F73C0CCE; Wed,  2 Feb 2022 00:33:35 +0100 (CET)
Date:   Wed, 2 Feb 2022 00:33:35 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Stephan Gerhold <stephan@gerhold.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 8/8] power: supply: ug3105_battery: Add driver for uPI
 uG3105 battery monitor
Message-ID: <20220201233335.henx5x53i4azbsdy@earth.universe>
References: <20220131155730.309513-1-hdegoede@redhat.com>
 <20220131155730.309513-9-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u6qktltohgdgd4tc"
Content-Disposition: inline
In-Reply-To: <20220131155730.309513-9-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--u6qktltohgdgd4tc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 31, 2022 at 04:57:30PM +0100, Hans de Goede wrote:
> Add a new battery driver for the uPI uG3105 battery monitor.
>=20
> Note the uG3105 is not a full-featured autonomous fuel-gauge. Instead it
> is expected to be use in combination with some always on microcontroller
> reading its coulomb-counter before it can wrap (must be read every 400
> seconds!).
>=20
> Since Linux does not monitor coulomb-counter changes while the device is
> off or suspended, the coulomb counter is not used atm.
>=20
> So far this driver is only used on x86/ACPI (non devicetree) devs
> (also note there is no of_match table). Therefor there is no devicetree
> bindings documentation for this driver's "upi,rsns-microohm" property
> since this is not used in actual devicetree files and the dt bindings
> maintainers have requested properties with no actual dt users to
> _not_ be added to the dt bindings.
>=20
> The property's name has been chosen so that it should not need to be
> changed if/when devicetree enumeration support gets added later, as it
> mirrors "maxim,rsns-microohm" from the "maxim,max17042" bindings.

Except the vendor prefix being incorrect; please use this one:

$ grep -i upi Documentation/devicetree/bindings/vendor-prefixes.yaml
  "^upisemi,.*":
    description: uPI Semiconductor Corp.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/Kconfig          |  15 +
>  drivers/power/supply/Makefile         |   1 +
>  drivers/power/supply/ug3105_battery.c | 486 ++++++++++++++++++++++++++
>  3 files changed, 502 insertions(+)
>  create mode 100644 drivers/power/supply/ug3105_battery.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index b366e2fd8e97..6b15eb184072 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -866,4 +866,19 @@ config CHARGER_SURFACE
>  	  Microsoft Surface devices, i.e. Surface Pro 7, Surface Laptop 3,
>  	  Surface Book 3, and Surface Laptop Go.
> =20
> +config BATTERY_UG3105
> +	tristate "uPI uG3105 battery monitor driver"
> +	depends on I2C
> +	help
> +	  Battery monitor driver for the uPI uG3105 battery monitor.
> +
> +	  Note the uG3105 is not a full-featured autonomous fuel-gauge. Instead
> +	  it is expected to be use in combination with some always on
> +	  microcontroller reading its coulomb-counter before it can wrap
> +	  (it must be read every 400 seconds!).
> +
> +	  Since Linux does not monitor coulomb-counter changes while the
> +	  device is off or suspended, the functionality of this driver is
> +	  limited to reporting capacity only.
> +
>  endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 2c1b264b2046..edf983676799 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -105,3 +105,4 @@ obj-$(CONFIG_RN5T618_POWER)	+=3D rn5t618_power.o
>  obj-$(CONFIG_BATTERY_ACER_A500)	+=3D acer_a500_battery.o
>  obj-$(CONFIG_BATTERY_SURFACE)	+=3D surface_battery.o
>  obj-$(CONFIG_CHARGER_SURFACE)	+=3D surface_charger.o
> +obj-$(CONFIG_BATTERY_UG3105)	+=3D ug3105_battery.o
> diff --git a/drivers/power/supply/ug3105_battery.c b/drivers/power/supply=
/ug3105_battery.c
> new file mode 100644
> index 000000000000..d92a7ebeb26e
> --- /dev/null
> +++ b/drivers/power/supply/ug3105_battery.c
> @@ -0,0 +1,486 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Battery monitor driver for the uPI uG3105 battery monitor
> + *
> + * Note the uG3105 is not a full-featured autonomous fuel-gauge. Instead=
 it is
> + * expected to be use in combination with some always on microcontroller=
 reading
> + * its coulomb-counter before it can wrap (must be read every 400 second=
s!).
> + *
> + * Since Linux does not monitor coulomb-counter changes while the device
> + * is off or suspended, the coulomb counter is not used atm.
> + *
> + * Possible improvements:
> + * 1. Activate commented out total_coulomb_count code
> + * 2. Reset total_coulomb_count val to 0 when the battery is as good as =
empty
> + *    and remember that we did this (and clear the flag for this on susp=
/resume)
> + * 3. When the battery is full check if the flag that we set total_coulo=
mb_count
> + *    to when the battery was empty is set. If so we now know the capaci=
ty,
> + *    not the design, but actual capacity, of the battery
> + * 4. Add some mechanism (needs userspace help, or maybe use efivar?) to=
 remember
> + *    the actual capacity of the battery over reboots
> + * 5. When we know the actual capacity at probe time, add energy_now and
> + *    energy_full attributes. Guess boot + resume energy_now value based=
 on ocv
> + *    and then use total_coulomb_count to report energy_now over time, r=
esetting
> + *    things to adjust for drift when empty/full. This should give more =
accurate
> + *    readings, esp. in the 30-70% range and allow userspace to estimate=
 time
> + *    remaining till empty/full
> + * 6. Maybe unregister + reregister the psy device when we learn the act=
ual
> + *    capacity during run-time ?

Same problem also exists on a few mobile phones, e.g.
drivers/power/supply/cpcap-battery.c, but no good solution has been
found yet.

> + * The above will also require some sort of mwh_per_unit calculation. Te=
sting
> + * has shown that an estimated 7404mWh increase of the battery's energy =
results
> + * in a total_coulomb_count increase of 3277 units with a 5 milli-ohm se=
nse R.
> + *
> + * Copyright (C) 2021 Hans de Goede <hdegoede@redhat.com>
> + */
> +
> +#include <linux/devm-helpers.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/power_supply.h>
> +#include <linux/workqueue.h>
> +
> +#define UG3105_MOV_AVG_WINDOW					8
> +#define UG3105_INIT_POLL_TIME					(5 * HZ)
> +#define UG3105_POLL_TIME					(30 * HZ)
> +#define UG3105_SETTLE_TIME					(1 * HZ)
> +
> +#define UG3105_INIT_POLL_COUNT					30
> +
> +#define UG3105_REG_MODE						0x00
> +#define UG3105_REG_CTRL1					0x01
> +#define UG3105_REG_COULOMB_CNT					0x02
> +#define UG3105_REG_BAT_VOLT					0x08
> +#define UG3105_REG_BAT_CURR					0x0c
> +
> +#define UG3105_MODE_STANDBY					0x00
> +#define UG3105_MODE_RUN						0x10
> +
> +#define UG3105_CTRL1_RESET_COULOMB_CNT				0x03
> +
> +#define UG3105_CURR_HYST_UA					65000
> +
> +#define UG3105_LOW_BAT_UV					3700000
> +#define UG3105_FULL_BAT_HYST_UV					38000
> +
> +struct ug3105_chip {
> +	struct i2c_client *client;
> +	struct power_supply *psy;
> +	struct power_supply_battery_info *info;
> +	struct delayed_work work;
> +	struct mutex lock;
> +	int ocv[UG3105_MOV_AVG_WINDOW];		/* micro-volt */
> +	int intern_res[UG3105_MOV_AVG_WINDOW];	/* milli-ohm */
> +	int poll_count;
> +	int ocv_avg_index;
> +	int ocv_avg;				/* micro-volt */
> +	int intern_res_poll_count;
> +	int intern_res_avg_index;
> +	int intern_res_avg;			/* milli-ohm */
> +	int volt;				/* micro-volt */
> +	int curr;				/* micro-ampere */
> +	int total_coulomb_count;
> +	int uv_per_unit;
> +	int ua_per_unit;
> +	int status;
> +	int capacity;
> +	bool supplied;
> +};
> +
> +static int ug3105_read_word(struct i2c_client *client, u8 reg)
> +{
> +	int val;
> +
> +	val =3D i2c_smbus_read_word_data(client, reg);
> +	if (val < 0)
> +		dev_err(&client->dev, "Error reading reg 0x%02x\n", reg);
> +
> +	return val;
> +}

can we use regmap instead? :)

> +static int ug3105_get_status(struct ug3105_chip *chip)
> +{
> +	int full =3D chip->info->constant_charge_voltage_max_uv - UG3105_FULL_B=
AT_HYST_UV;
> +
> +	if (chip->curr > UG3105_CURR_HYST_UA)
> +		return POWER_SUPPLY_STATUS_CHARGING;
> +
> +	if (chip->curr < -UG3105_CURR_HYST_UA)
> +		return POWER_SUPPLY_STATUS_DISCHARGING;
> +
> +	if (chip->supplied && chip->ocv_avg > full)
> +		return POWER_SUPPLY_STATUS_FULL;
> +
> +	return POWER_SUPPLY_STATUS_NOT_CHARGING;
> +}
> +
> +static int ug3105_get_capacity(struct ug3105_chip *chip)
> +{
> +	/*
> +	 * OCV voltages in uV for 0-110% in 5% increments, the 100-110% is
> +	 * for LiPo HV (High-Voltage) bateries which can go up to 4.35V
> +	 * instead of the usual 4.2V.
> +	 */
> +	static const int ocv_capacity_tbl[23] =3D {
> +		3350000,
> +		3610000,
> +		3690000,
> +		3710000,
> +		3730000,
> +		3750000,
> +		3770000,
> +		3786667,
> +		3803333,
> +		3820000,
> +		3836667,
> +		3853333,
> +		3870000,
> +		3907500,
> +		3945000,
> +		3982500,
> +		4020000,
> +		4075000,
> +		4110000,
> +		4150000,
> +		4200000,
> +		4250000,
> +		4300000,
> +	};
> +	int i, ocv_diff, ocv_step;
> +
> +	if (chip->ocv_avg < ocv_capacity_tbl[0])
> +		return 0;
> +
> +	if (chip->status =3D=3D POWER_SUPPLY_STATUS_FULL)
> +		return 100;
> +
> +	for (i =3D 1; i < ARRAY_SIZE(ocv_capacity_tbl); i++) {
> +		if (chip->ocv_avg > ocv_capacity_tbl[i])
> +			continue;
> +
> +		ocv_diff =3D ocv_capacity_tbl[i] - chip->ocv_avg;
> +		ocv_step =3D ocv_capacity_tbl[i] - ocv_capacity_tbl[i - 1];
> +		/* scale 0-110% down to 0-100% for LiPo HV */
> +		if (chip->info->constant_charge_voltage_max_uv >=3D 4300000)
> +			return (i * 500 - ocv_diff * 500 / ocv_step) / 110;
> +		else
> +			return i * 5 - ocv_diff * 5 / ocv_step;
> +	}
> +
> +	return 100;
> +}
> +
> +static void ug3105_work(struct work_struct *work)
> +{
> +	struct ug3105_chip *chip =3D container_of(work, struct ug3105_chip,
> +						work.work);
> +	int i, val, curr_diff, volt_diff, res, win_size;
> +	bool prev_supplied =3D chip->supplied;
> +	int prev_status =3D chip->status;
> +	int prev_volt =3D chip->volt;
> +	int prev_curr =3D chip->curr;
> +	struct power_supply *psy;
> +
> +	mutex_lock(&chip->lock);
> +
> +	psy =3D chip->psy;
> +	if (!psy)
> +		goto out;
> +
> +	val =3D ug3105_read_word(chip->client, UG3105_REG_BAT_VOLT);
> +	if (val < 0)
> +		goto out;
> +	chip->volt =3D val * chip->uv_per_unit;
> +
> +	val =3D ug3105_read_word(chip->client, UG3105_REG_BAT_CURR);
> +	if (val < 0)
> +		goto out;
> +	chip->curr =3D (s16)val * chip->ua_per_unit;
> +
> +	chip->ocv[chip->ocv_avg_index] =3D
> +		chip->volt - chip->curr * chip->intern_res_avg / 1000;
> +	chip->ocv_avg_index =3D (chip->ocv_avg_index + 1) % UG3105_MOV_AVG_WIND=
OW;
> +	chip->poll_count++;
> +
> +	/*
> +	 * See possible improvements comment above.
> +	 *
> +	 * Read + reset coulomb counter every 10 polls (every 300 seconds)
> +	 * if ((chip->poll_count % 10) =3D=3D 0) {
> +	 *	val =3D ug3105_read_word(chip->client, UG3105_REG_COULOMB_CNT);
> +	 *	if (val < 0)
> +	 *		goto out;
> +	 *
> +	 *	i2c_smbus_write_byte_data(chip->client, UG3105_REG_CTRL1,
> +	 *				  UG3105_CTRL1_RESET_COULOMB_CNT);
> +	 *
> +	 *	chip->total_coulomb_count +=3D (s16)val;
> +	 *	dev_dbg(&chip->client->dev, "coulomb count %d total %d\n",
> +	 *		(s16)val, chip->total_coulomb_count);
> +	 * }
> +	 */
> +
> +	chip->ocv_avg =3D 0;
> +	win_size =3D min(chip->poll_count, UG3105_MOV_AVG_WINDOW);
> +	for (i =3D 0; i < win_size; i++)
> +		chip->ocv_avg +=3D chip->ocv[i];
> +	chip->ocv_avg /=3D win_size;
> +
> +	chip->supplied =3D power_supply_am_i_supplied(psy);
> +	chip->status =3D ug3105_get_status(chip);
> +	chip->capacity =3D ug3105_get_capacity(chip);
> +
> +	/*
> +	 * Skip internal resistance calc on charger [un]plug and
> +	 * when the battery is almost empty (voltage low).
> +	 */
> +	if (chip->supplied !=3D prev_supplied ||
> +	    chip->volt < UG3105_LOW_BAT_UV ||
> +	    chip->poll_count < 2)
> +		goto out;
> +
> +	/*
> +	 * Assuming that the OCV voltage does not change significantly
> +	 * between 2 polls, then we can calculate the internal resistance
> +	 * on a significant current change by attributing all voltage
> +	 * change between the 2 readings to the internal resistance.
> +	 */
> +	curr_diff =3D abs(chip->curr - prev_curr);
> +	if (curr_diff < UG3105_CURR_HYST_UA)
> +		goto out;
> +
> +	volt_diff =3D abs(chip->volt - prev_volt);
> +	res =3D volt_diff * 1000 / curr_diff;
> +
> +	if ((res < (chip->intern_res_avg * 2 / 3)) ||
> +	    (res > (chip->intern_res_avg * 4 / 3))) {
> +		dev_dbg(&chip->client->dev, "Ignoring outlier internal resistance %d m=
Ohm\n", res);
> +		goto out;
> +	}
> +
> +	dev_dbg(&chip->client->dev, "Internal resistance %d mOhm\n", res);
> +
> +	chip->intern_res[chip->intern_res_avg_index] =3D res;
> +	chip->intern_res_avg_index =3D (chip->intern_res_avg_index + 1) % UG310=
5_MOV_AVG_WINDOW;
> +	chip->intern_res_poll_count++;
> +
> +	chip->intern_res_avg =3D 0;
> +	win_size =3D min(chip->intern_res_poll_count, UG3105_MOV_AVG_WINDOW);
> +	for (i =3D 0; i < win_size; i++)
> +		chip->intern_res_avg +=3D chip->intern_res[i];
> +	chip->intern_res_avg /=3D win_size;
> +
> +out:
> +	mutex_unlock(&chip->lock);
> +
> +	queue_delayed_work(system_wq, &chip->work,
> +			   (chip->poll_count <=3D UG3105_INIT_POLL_COUNT) ?
> +					UG3105_INIT_POLL_TIME : UG3105_POLL_TIME);
> +
> +	if (chip->status !=3D prev_status && psy)
> +		power_supply_changed(psy);
> +}
> +
> +static enum power_supply_property ug3105_battery_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_SCOPE,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_OCV,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +};
> +
> +static int ug3105_get_property(struct power_supply *psy,
> +			       enum power_supply_property psp,
> +			       union power_supply_propval *val)
> +{
> +	struct ug3105_chip *chip =3D power_supply_get_drvdata(psy);
> +	int ret =3D 0;
> +
> +	mutex_lock(&chip->lock);
> +
> +	if (!chip->psy) {
> +		ret =3D -EAGAIN;
> +		goto out;
> +	}
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval =3D chip->status;
> +		break;
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval =3D 1;
> +		break;
> +	case POWER_SUPPLY_PROP_TECHNOLOGY:
> +		val->intval =3D chip->info->technology;
> +		break;
> +	case POWER_SUPPLY_PROP_SCOPE:
> +		val->intval =3D POWER_SUPPLY_SCOPE_SYSTEM;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret =3D ug3105_read_word(chip->client, UG3105_REG_BAT_VOLT);
> +		if (ret < 0)
> +			break;
> +		val->intval =3D ret * chip->uv_per_unit;
> +		ret =3D 0;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
> +		val->intval =3D chip->ocv_avg;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		ret =3D ug3105_read_word(chip->client, UG3105_REG_BAT_CURR);
> +		if (ret < 0)
> +			break;
> +		val->intval =3D (s16)ret * chip->ua_per_unit;
> +		ret =3D 0;
> +		break;
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		val->intval =3D chip->capacity;
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +	}
> +
> +out:
> +	mutex_unlock(&chip->lock);
> +	return ret;
> +}
> +
> +static void ug3105_external_power_changed(struct power_supply *psy)
> +{
> +	struct ug3105_chip *chip =3D power_supply_get_drvdata(psy);
> +
> +	dev_dbg(&chip->client->dev, "external power changed\n");
> +	mod_delayed_work(system_wq, &chip->work, UG3105_SETTLE_TIME);
> +}
> +
> +static const struct power_supply_desc ug3105_psy_desc =3D {
> +	.name		=3D "ug3105_battery",
> +	.type		=3D POWER_SUPPLY_TYPE_BATTERY,
> +	.get_property	=3D ug3105_get_property,
> +	.external_power_changed	=3D ug3105_external_power_changed,
> +	.properties	=3D ug3105_battery_props,
> +	.num_properties	=3D ARRAY_SIZE(ug3105_battery_props),
> +};
> +
> +static void ug3105_init(struct ug3105_chip *chip)
> +{
> +	chip->poll_count =3D 0;
> +	chip->ocv_avg_index =3D 0;
> +	chip->total_coulomb_count =3D 0;
> +	i2c_smbus_write_byte_data(chip->client, UG3105_REG_MODE,
> +				  UG3105_MODE_RUN);
> +	i2c_smbus_write_byte_data(chip->client, UG3105_REG_CTRL1,
> +				  UG3105_CTRL1_RESET_COULOMB_CNT);
> +	queue_delayed_work(system_wq, &chip->work, 0);
> +	flush_delayed_work(&chip->work);
> +}
> +
> +static int ug3105_probe(struct i2c_client *client)
> +{
> +	struct power_supply_config psy_cfg =3D {};
> +	struct device *dev =3D &client->dev;
> +	u32 curr_sense_res_uohm =3D 10000;
> +	struct power_supply *psy;
> +	struct ug3105_chip *chip;
> +	int ret;
> +
> +	chip =3D devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->client =3D client;
> +	mutex_init(&chip->lock);
> +	ret =3D devm_delayed_work_autocancel(dev, &chip->work, ug3105_work);
> +	if (ret)
> +		return ret;
> +
> +	psy_cfg.drv_data =3D chip;
> +	psy =3D devm_power_supply_register(dev, &ug3105_psy_desc, &psy_cfg);
> +	if (IS_ERR(psy))
> +		return PTR_ERR(psy);
> +
> +	ret =3D power_supply_get_battery_info(psy, &chip->info);
> +	if (ret)
> +		return ret;

this allocates data, so you need to call power_supply_put_battery_info()
when chip->info is no loner required.

> +
> +	if (chip->info->factory_internal_resistance_uohm =3D=3D -EINVAL ||
> +	    chip->info->constant_charge_voltage_max_uv =3D=3D -EINVAL) {
> +		dev_err(dev, "error required properties are missing\n");
> +		return -ENODEV;
> +	}
> +
> +	device_property_read_u32(dev, "upi,rsns-microohm", &curr_sense_res_uohm=
);
> +
> +	/*
> +	 * DAC maximum is 4.5V divided by 65536 steps + an unknown factor of 10
> +	 * coming from somewhere for some reason (verified with a volt-meter).
> +	 */
> +	chip->uv_per_unit =3D 45000000/65536;
> +	/* Datasheet says 8.1 uV per unit for the current ADC */
> +	chip->ua_per_unit =3D 8100000 / curr_sense_res_uohm;
> +
> +	/* Use provided internal resistance as start point (in milli-ohm) */
> +	chip->intern_res_avg =3D chip->info->factory_internal_resistance_uohm /=
 1000;
> +	/* Also add it to the internal resistance moving average window */
> +	chip->intern_res[0] =3D chip->intern_res_avg;
> +	chip->intern_res_avg_index =3D 1;
> +	chip->intern_res_poll_count =3D 1;
> +
> +	mutex_lock(&chip->lock);
> +	chip->psy =3D psy;
> +	mutex_unlock(&chip->lock);
> +
> +	ug3105_init(chip);
> +
> +	i2c_set_clientdata(client, chip);
> +	return 0;
> +}
> +
> +static int __maybe_unused ug3105_suspend(struct device *dev)
> +{
> +	struct ug3105_chip *chip =3D dev_get_drvdata(dev);
> +
> +	cancel_delayed_work_sync(&chip->work);
> +	i2c_smbus_write_byte_data(chip->client, UG3105_REG_MODE,
> +				  UG3105_MODE_STANDBY);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused ug3105_resume(struct device *dev)
> +{
> +	struct ug3105_chip *chip =3D dev_get_drvdata(dev);
> +
> +	ug3105_init(chip);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(ug3105_pm_ops, ug3105_suspend,
> +			ug3105_resume);
> +
> +static const struct i2c_device_id ug3105_id[] =3D {
> +	{ "ug3105" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ug3105_id);
> +
> +static struct i2c_driver ug3105_i2c_driver =3D {
> +	.driver	=3D {
> +		.name =3D "ug3105",
> +		.pm =3D &ug3105_pm_ops,
> +	},
> +	.probe_new =3D ug3105_probe,
> +	.id_table =3D ug3105_id,
> +};
> +module_i2c_driver(ug3105_i2c_driver);
> +
> +MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com");
> +MODULE_DESCRIPTION("uPI uG3105 battery monitor driver");
> +MODULE_LICENSE("GPL");

Otherwise LGTM.

-- Sebastian

--u6qktltohgdgd4tc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmH5w0wACgkQ2O7X88g7
+poo3BAAjrJ2dEE38MDrHjX5HLHdBgqs2OU6HY/apKD08GFXjXrLKbSnNQ7q/m0a
u0g/h+rDD1SuyxM33YjO4ddXALp5W0bbr2zoFs/wTy5snzRcwsO0hiSKaEXJs/US
lZUkfBFOpK6lFdTAa/9cg0408M7CVvUwXevQLdmcVS7D3CDAepdUJ+FkhL9r23h/
7AnhbZK3moMrqv0QDWMjIqLagMwvbQV7IEzHMlad7clrSji+aSJNPVKDfPSbjbt0
lmZJMM0ELMUhBDnewYkO9rsF6p4aZPZlnrUZ2mcf4It4XoX+TRM4YutYZ4waWKZP
HZAttU9aRnoJGXuZx0Y8OURWx11vzwTfnzG89oU4zOrl4Sc5JJ9Tq/S2xC/649ct
4VbSMBYKudgda7+NHggQ51ixJ/6USozEpzlbavq2CHoFpRfBrbD69WZryG5XxNTN
xGaTsyjXeZFfTfMmZcEPvgosWhMz/ep5nLeFjAFrhmtxTdYo02DVrPr94W5ntILl
2MpCgqMZJPmSh+GBgVQHVigLpl8FEWUuxwJYElWUAv2JItl6uw6At+YmA053+Wnq
a9qJhDKW3GYFIQcRf8ll8CfMtYYO1Gp9JjiSjl3s8Q4SqAZFQlDQuIxP3hGzRnHX
Um9daaL2ph5E2xFzb1ggiBx2yuCrWcklSzTDSLvPkrjtQIK5ZK0=
=a/Pr
-----END PGP SIGNATURE-----

--u6qktltohgdgd4tc--
