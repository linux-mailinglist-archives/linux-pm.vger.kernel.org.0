Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF2A24FF88
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 16:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgHXOH0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 10:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXOHZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 10:07:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192F2C061573;
        Mon, 24 Aug 2020 07:07:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 226BA296B41
Received: by earth.universe (Postfix, from userid 1000)
        id 1DAF23C0C82; Mon, 24 Aug 2020 16:07:18 +0200 (CEST)
Date:   Mon, 24 Aug 2020 16:07:18 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/6] power: supply: Add battery gauge driver for Acer
 Iconia Tab A500
Message-ID: <20200824140718.apoavlny6hlkm2ql@earth.universe>
References: <20200823140846.19299-1-digetx@gmail.com>
 <20200823140846.19299-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3s27fexe4zvahltn"
Content-Disposition: inline
In-Reply-To: <20200823140846.19299-3-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3s27fexe4zvahltn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 23, 2020 at 05:08:42PM +0300, Dmitry Osipenko wrote:
> This patch adds battery gauge driver for Acer Iconia Tab A500 device.
> The battery gauge function is provided via the Embedded Controller,
> which is found on the Acer A500.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/power/supply/Kconfig             |   6 +
>  drivers/power/supply/Makefile            |   1 +
>  drivers/power/supply/acer_a500_battery.c | 369 +++++++++++++++++++++++
>  3 files changed, 376 insertions(+)
>  create mode 100644 drivers/power/supply/acer_a500_battery.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index faf2830aa152..dff5e5a7383f 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -752,4 +752,10 @@ config CHARGER_WILCO
>  	  information can be found in
>  	  Documentation/ABI/testing/sysfs-class-power-wilco
> =20
> +config BATTERY_ACER_A500
> +	tristate "Acer Iconia Tab A500 battery driver"
> +	depends on MFD_ACER_A500_EC
> +	help
> +	  Say Y to include support for Acer Iconia Tab A500 battery fuel gauge.
> +
>  endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index b3c694a65114..08a5b49e2936 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -96,3 +96,4 @@ obj-$(CONFIG_CHARGER_UCS1002)	+=3D ucs1002_power.o
>  obj-$(CONFIG_CHARGER_BD70528)	+=3D bd70528-charger.o
>  obj-$(CONFIG_CHARGER_BD99954)	+=3D bd99954-charger.o
>  obj-$(CONFIG_CHARGER_WILCO)	+=3D wilco-charger.o
> +obj-$(CONFIG_BATTERY_ACER_A500)	+=3D acer_a500_battery.o
> diff --git a/drivers/power/supply/acer_a500_battery.c b/drivers/power/sup=
ply/acer_a500_battery.c
> new file mode 100644
> index 000000000000..933101e1261e
> --- /dev/null
> +++ b/drivers/power/supply/acer_a500_battery.c
> @@ -0,0 +1,369 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Battery driver for Acer Iconia Tab A500.
> + *
> + * Copyright 2020 GRATE-driver project.
> + *
> + * Based on downstream driver from Acer Inc.
> + * Based on NVIDIA Gas Gauge driver for SBS Compliant Batteries.
> + *
> + * Copyright (c) 2010, NVIDIA Corporation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>
> +
> +#include <linux/mfd/acer-ec-a500.h>
> +
> +#define BATTERY_SERIAL_LEN	22
> +
> +enum {
> +	REG_CAPACITY,
> +	REG_VOLTAGE,
> +	REG_CURRENT,
> +	REG_DESIGN_CAPACITY,
> +	REG_TEMPERATURE,
> +	REG_SERIAL_NUMBER,
> +};
> +
> +#define EC_DATA(_cmd, _delay, _psp) {		\
> +	.psp =3D POWER_SUPPLY_PROP_ ## _psp,	\
> +	.cmd =3D {				\
> +		.cmd =3D _cmd,			\
> +		.post_delay =3D _delay		\
> +	},					\
> +}
> +
> +static const struct chip_data {
> +	enum power_supply_property psp;
> +	struct a500_ec_cmd cmd;
> +} ec_data[] =3D {
> +	[REG_CAPACITY]		=3D EC_DATA(0x00,  0, CAPACITY),
> +	[REG_VOLTAGE]		=3D EC_DATA(0x01,  0, VOLTAGE_NOW),
> +	[REG_CURRENT]		=3D EC_DATA(0x03, 10, CURRENT_NOW),
> +	[REG_DESIGN_CAPACITY]	=3D EC_DATA(0x08,  0, CHARGE_FULL_DESIGN),
> +	[REG_TEMPERATURE]	=3D EC_DATA(0x0a,  0, TEMP),
> +	[REG_SERIAL_NUMBER]	=3D EC_DATA(0x6a,  0, SERIAL_NUMBER),
> +};
> +
> +static const enum power_supply_property a500_battery_properties[] =3D {
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_SERIAL_NUMBER,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +};
> +
> +struct a500_battery {
> +	struct delayed_work poll_work;
> +	struct power_supply *psy;
> +	struct a500_ec *ec_chip;
> +	unsigned int capacity;
> +	char serial[BATTERY_SERIAL_LEN + 1];
> +};
> +
> +static int a500_battery_get_presence(struct a500_battery *bat,
> +				     union power_supply_propval *val)
> +{
> +	s32 ret;
> +
> +	/*
> +	 * DESIGN_CAPACITY register always returns a non-zero value if
> +	 * battery is connected and zero if disconnected.
> +	 */
> +	ret =3D a500_ec_read(bat->ec_chip, &ec_data[REG_DESIGN_CAPACITY].cmd);
> +	if (ret <=3D 0)
> +		val->intval =3D 0;
> +	else
> +		val->intval =3D 1;
> +
> +	return 0;
> +}
> +
> +static bool a500_battery_update_capacity(struct a500_battery *bat)
> +{
> +	unsigned int capacity;
> +	s32 ret;
> +
> +	ret =3D a500_ec_read(bat->ec_chip, &ec_data[REG_CAPACITY].cmd);
> +	if (ret < 0)
> +		return false;
> +
> +	/* capacity can be >100% even if max value is 100% */
> +	capacity =3D min(ret, 100);
> +
> +	if (bat->capacity !=3D capacity) {
> +		bat->capacity =3D capacity;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void a500_battery_get_status(struct a500_battery *bat,
> +				    union power_supply_propval *val)
> +{
> +	if (bat->capacity < 100) {
> +		if (power_supply_am_i_supplied(bat->psy))
> +			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +		else
> +			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +	} else {
> +		val->intval =3D POWER_SUPPLY_STATUS_FULL;
> +	}
> +}
> +
> +static void a500_battery_unit_adjustment(struct device *dev,
> +					 enum power_supply_property psp,
> +					 union power_supply_propval *val)
> +{
> +	const unsigned int base_unit_conversion =3D 1000;
> +	const unsigned int temp_kelvin_to_celsius =3D 2731;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval *=3D base_unit_conversion;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_TEMP:
> +		val->intval -=3D temp_kelvin_to_celsius;
> +		break;
> +
> +	default:
> +		dev_dbg(dev,
> +			"%s: no need for unit conversion %d\n", __func__, psp);
> +	}
> +}
> +
> +static int a500_battery_get_serial_number(struct a500_battery *bat,
> +					  union power_supply_propval *val)
> +{
> +	unsigned int i;
> +	s32 ret =3D 0;
> +
> +	if (bat->serial[0])
> +		goto done;
> +
> +	a500_ec_lock(bat->ec_chip);
> +	for (i =3D 0; i < BATTERY_SERIAL_LEN / 2; i++) {
> +		ret =3D a500_ec_read_locked(bat->ec_chip,
> +					  &ec_data[REG_SERIAL_NUMBER].cmd);
> +		if (ret < 0) {
> +			bat->serial[0] =3D '\0';
> +			break;
> +		}
> +
> +		bat->serial[i * 2 + 0] =3D (ret >> 0) & 0xff;
> +		bat->serial[i * 2 + 1] =3D (ret >> 8) & 0xff;
> +	}
> +	a500_ec_unlock(bat->ec_chip);
> +done:
> +	val->strval =3D bat->serial;
> +
> +	return ret;
> +}

If battery is swapped, this will keep the old serial.

> +static int a500_battery_get_ec_data_index(struct device *dev,
> +					  enum power_supply_property psp)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ec_data); i++)
> +		if (psp =3D=3D ec_data[i].psp)
> +			return i;
> +
> +	dev_dbg(dev, "%s: invalid property %u\n", __func__, psp);
> +
> +	return -EINVAL;
> +}
> +
> +static int a500_battery_get_simple_property(struct a500_battery *bat,
> +					    union power_supply_propval *val,
> +					    unsigned int ec_idx)
> +{
> +	s32 ret;
> +
> +	ret =3D a500_ec_read(bat->ec_chip, &ec_data[ec_idx].cmd);
> +	if (ret < 0)
> +		return ret;
> +
> +	val->intval =3D (u16)ret;
> +
> +	return 0;
> +}
> +
> +static int a500_battery_get_property(struct power_supply *psy,
> +				     enum power_supply_property psp,
> +				     union power_supply_propval *val)
> +{
> +	struct a500_battery *bat =3D power_supply_get_drvdata(psy);
> +	struct device *dev =3D psy->dev.parent;
> +	int ret =3D 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
> +		ret =3D a500_battery_get_serial_number(bat, val);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		ret =3D a500_battery_get_presence(bat, val);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_STATUS:
> +		a500_battery_get_status(bat, val);
> +		break;
> +
> +	case POWER_SUPPLY_PROP_TECHNOLOGY:
> +		val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		a500_battery_update_capacity(bat);
> +		val->intval =3D bat->capacity;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +	case POWER_SUPPLY_PROP_TEMP:
> +		ret =3D a500_battery_get_ec_data_index(dev, psp);
> +		if (ret < 0)
> +			break;
> +
> +		ret =3D a500_battery_get_simple_property(bat, val, ret);
> +		break;
> +
> +	default:
> +		dev_err(dev, "%s: invalid property %u\n", __func__, psp);
> +		return -EINVAL;
> +	}
> +
> +	if (!ret) {
> +		/* convert units to match requirements for power supply class */
> +		a500_battery_unit_adjustment(dev, psp, val);
> +	}
> +
> +	dev_dbg(dev, "%s: property =3D %d, value =3D %x\n",
> +		__func__, psp, val->intval);
> +
> +	/* return NODATA for properties if battery not presents */
> +	if (ret)
> +		return -ENODATA;
> +
> +	return 0;
> +}
> +
> +static void a500_battery_delayed_work(struct work_struct *work)
> +{
> +	struct a500_battery *bat;
> +	bool capacity_changed;
> +
> +	bat =3D container_of(work, struct a500_battery, poll_work.work);
> +	capacity_changed =3D a500_battery_update_capacity(bat);
> +
> +	if (capacity_changed)
> +		power_supply_changed(bat->psy);
> +
> +	/* continuously send uevent notification */
> +	schedule_delayed_work(&bat->poll_work, 30 * HZ);
> +}
> +
> +static const struct power_supply_desc a500_battery_desc =3D {
> +	.name =3D "ec-battery",
> +	.type =3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties =3D a500_battery_properties,
> +	.get_property =3D a500_battery_get_property,
> +	.num_properties =3D ARRAY_SIZE(a500_battery_properties),
> +	.external_power_changed =3D power_supply_changed,
> +};
> +
> +static int a500_battery_probe(struct platform_device *pdev)
> +{
> +	struct power_supply_config psy_cfg =3D {};
> +	struct a500_battery *bat;
> +	int err;
> +
> +	bat =3D devm_kzalloc(&pdev->dev, sizeof(*bat), GFP_KERNEL);
> +	if (!bat)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, bat);
> +
> +	psy_cfg.of_node =3D pdev->dev.parent->of_node;
> +	psy_cfg.drv_data =3D bat;
> +
> +	bat->ec_chip =3D dev_get_drvdata(pdev->dev.parent);
> +
> +	bat->psy =3D devm_power_supply_register_no_ws(&pdev->dev,
> +						    &a500_battery_desc,
> +						    &psy_cfg);
> +	err =3D PTR_ERR_OR_ZERO(bat->psy);
> +	if (err) {
> +		if (err =3D=3D -EPROBE_DEFER)
> +			dev_dbg(&pdev->dev, "failed to register battery, deferring probe\n");
> +		else
> +			dev_err(&pdev->dev, "failed to register battery: %d\n",
> +				err);
> +		return err;
> +	}

if (IS_ERR(bat->psy))
    return dev_err_probe(&pdev->dev, PTR_ERR(err), "failed to register batt=
ery\n");

> +
> +	INIT_DELAYED_WORK(&bat->poll_work, a500_battery_delayed_work);
> +	schedule_delayed_work(&bat->poll_work, HZ);
> +
> +	return 0;
> +}
> +
> +static int a500_battery_remove(struct platform_device *pdev)
> +{
> +	struct a500_battery *bat =3D dev_get_drvdata(&pdev->dev);
> +
> +	cancel_delayed_work_sync(&bat->poll_work);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused a500_battery_suspend(struct device *dev)
> +{
> +	struct a500_battery *bat =3D dev_get_drvdata(dev);
> +
> +	cancel_delayed_work_sync(&bat->poll_work);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused a500_battery_resume(struct device *dev)
> +{
> +	struct a500_battery *bat =3D dev_get_drvdata(dev);
> +
> +	schedule_delayed_work(&bat->poll_work, HZ);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(a500_battery_pm_ops,
> +			 a500_battery_suspend, a500_battery_resume);
> +
> +static struct platform_driver a500_battery_driver =3D {
> +	.driver =3D {
> +		.name =3D "acer-a500-iconia-battery",
> +		.pm =3D &a500_battery_pm_ops,
> +	},
> +	.probe =3D a500_battery_probe,
> +	.remove =3D a500_battery_remove,
> +};
> +module_platform_driver(a500_battery_driver);
> +
> +MODULE_DESCRIPTION("Battery gauge driver for Acer Iconia Tab A500");
> +MODULE_AUTHOR("Dmitry Osipenko <digetx@gmail.com>");
> +MODULE_ALIAS("platform:acer-a500-iconia-battery");
> +MODULE_LICENSE("GPL v2");

MODULE_LICENSE("GPL");

Otherwise looks good to me.

-- Sebastian

--3s27fexe4zvahltn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9DyYgACgkQ2O7X88g7
+potDw//Tx6LxSyYC1gJCzsa/Olat/9R5GLgt6nON91yVRhYT2pOU5B71FEhbpyX
tJo5RSvj/OytAA3OdRhBi+SlA84fMsv2pAIv7EnG2e5bptka/+j6ET4UryC30R0v
GQemOT6w5TOxttsgFsCQoTkaN5AvRjUwNqm8H+W/eOfYONFCdcdENXNMVlmI5j+l
OmaKPFdCroe/ce6IwiXnmwNV4VEAmKBzuTHht/KaBpnyuGsGLISKMNzrJiZHllby
6YpcJtaadJ5CMUEKvqx6tMD9fn4elTPYQJScyV4OEmjYBoN8W95ReUSmTlAwH1PX
//kNHOjsCHSnEumVElsvFtzcHLdrvh328et8LeHx7reRT/I/UUTTffLzA9GfEoNg
tUZ8J1SvYlLg5Gr6VhIbAkdQNed8ND9ipUFZg6rxG8DUstHCux29M4E6+SxgGoKi
X4piiFoBuWwdFzD0FzFvFJ7fuTHZPgodjlyB//dLJv2Hi8SuF3K3IDB+BDp5nWp9
ZoTzYkg6m5VUAD/2abQ95IUyb+GvCdhrlLeykJ4Y3jIMsDq0xtQG/sAyhUzHWunQ
VRbk+oZWAu34wCDjpKQFL/73Sneonr+8FsNcqH5PC5mb6qTdExfRvWvU78H4KbC7
KjuwRUVliuVVpJnF/7xD7oeVjQOBprRs7HeBbvCCe1dPMZYn/IA=
=PSgQ
-----END PGP SIGNATURE-----

--3s27fexe4zvahltn--
