Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8251287EDE
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 00:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgJHW5l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 18:57:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbgJHW5l (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Oct 2020 18:57:41 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F207E22247;
        Thu,  8 Oct 2020 22:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602197860;
        bh=dQMGOo0zpRT3llC8i+BmMza1pMzLdSZLc04ieL/SGCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OkzkB4nei2hu+R+OlFWdi5ULn1xUmG4xGMeUs7jvrGFsorrEBhqW0bCAMOQIv0NXK
         7OipEHxRESRlB/BxNLsLMrr7LgRzH67yDEKlZaQFUeuU+TK9IaUcS+BpgjH6trT2ze
         g4iBS7eOzQv16SWohVnDWl1u764HcoOt4UN4Z9fk=
Received: by earth.universe (Postfix, from userid 1000)
        id 7C20A3C0C87; Fri,  9 Oct 2020 00:57:37 +0200 (CEST)
Date:   Fri, 9 Oct 2020 00:57:37 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] power: supply: Add battery gauge driver for Acer
 Iconia Tab A500
Message-ID: <20201008225737.mfhgrqi73fozqdfz@earth.universe>
References: <20200906195103.1347-1-digetx@gmail.com>
 <20200906195103.1347-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ok6fkpcma74wg3w4"
Content-Disposition: inline
In-Reply-To: <20200906195103.1347-4-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ok6fkpcma74wg3w4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Sep 06, 2020 at 10:51:01PM +0300, Dmitry Osipenko wrote:
> This patch adds battery gauge driver for Acer Iconia Tab A500 device.
> The battery gauge function is provided via the Embedded Controller,
> which is found on the Acer A500.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/Kconfig             |   6 +
>  drivers/power/supply/Makefile            |   1 +
>  drivers/power/supply/acer_a500_battery.c | 297 +++++++++++++++++++++++
>  3 files changed, 304 insertions(+)
>  create mode 100644 drivers/power/supply/acer_a500_battery.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index a4657484f38b..21257a81b55b 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -760,4 +760,10 @@ config RN5T618_POWER
>  	  This driver can also be built as a module. If so, the module will be
>  	  called rn5t618_power.
> =20
> +config BATTERY_ACER_A500
> +	tristate "Acer Iconia Tab A500 battery driver"
> +	depends on MFD_ACER_A500_EC
> +	help
> +	  Say Y to include support for Acer Iconia Tab A500 battery fuel gauge.
> +
>  endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 293d4a5d80d3..d0f1b77c5c49 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -97,3 +97,4 @@ obj-$(CONFIG_CHARGER_BD70528)	+=3D bd70528-charger.o
>  obj-$(CONFIG_CHARGER_BD99954)	+=3D bd99954-charger.o
>  obj-$(CONFIG_CHARGER_WILCO)	+=3D wilco-charger.o
>  obj-$(CONFIG_RN5T618_POWER)	+=3D rn5t618_power.o
> +obj-$(CONFIG_BATTERY_ACER_A500)	+=3D acer_a500_battery.o
> diff --git a/drivers/power/supply/acer_a500_battery.c b/drivers/power/sup=
ply/acer_a500_battery.c
> new file mode 100644
> index 000000000000..93135933c8af
> --- /dev/null
> +++ b/drivers/power/supply/acer_a500_battery.c
> @@ -0,0 +1,297 @@
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
> +#include <linux/regmap.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>
> +
> +enum {
> +	REG_CAPACITY,
> +	REG_VOLTAGE,
> +	REG_CURRENT,
> +	REG_DESIGN_CAPACITY,
> +	REG_TEMPERATURE,
> +};
> +
> +#define EC_DATA(_reg, _psp) {			\
> +	.psp =3D POWER_SUPPLY_PROP_ ## _psp,	\
> +	.reg =3D _reg,				\
> +}
> +
> +static const struct battery_register {
> +	enum power_supply_property psp;
> +	unsigned int reg;
> +} ec_data[] =3D {
> +	[REG_CAPACITY]		=3D EC_DATA(0x00, CAPACITY),
> +	[REG_VOLTAGE]		=3D EC_DATA(0x01, VOLTAGE_NOW),
> +	[REG_CURRENT]		=3D EC_DATA(0x03, CURRENT_NOW),
> +	[REG_DESIGN_CAPACITY]	=3D EC_DATA(0x08, CHARGE_FULL_DESIGN),
> +	[REG_TEMPERATURE]	=3D EC_DATA(0x0a, TEMP),
> +};
> +
> +static const enum power_supply_property a500_battery_properties[] =3D {
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +};
> +
> +struct a500_battery {
> +	struct delayed_work poll_work;
> +	struct power_supply *psy;
> +	struct regmap *rmap;
> +	unsigned int capacity;
> +};
> +
> +static bool a500_battery_update_capacity(struct a500_battery *bat)
> +{
> +	unsigned int capacity;
> +	int err;
> +
> +	err =3D regmap_read(bat->rmap, ec_data[REG_CAPACITY].reg, &capacity);
> +	if (err)
> +		return false;
> +
> +	/* capacity can be >100% even if max value is 100% */
> +	capacity =3D min(capacity, 100u);
> +
> +	if (bat->capacity !=3D capacity) {
> +		bat->capacity =3D capacity;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int a500_battery_get_status(struct a500_battery *bat)
> +{
> +	if (bat->capacity < 100) {
> +		if (power_supply_am_i_supplied(bat->psy))
> +			return POWER_SUPPLY_STATUS_CHARGING;
> +		else
> +			return POWER_SUPPLY_STATUS_DISCHARGING;
> +	}
> +
> +	return POWER_SUPPLY_STATUS_FULL;
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
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval =3D !!val->intval;
> +		break;
> +
> +	default:
> +		dev_dbg(dev,
> +			"%s: no need for unit conversion %d\n", __func__, psp);
> +	}
> +}
> +
> +static int a500_battery_get_ec_data_index(struct device *dev,
> +					  enum power_supply_property psp)
> +{
> +	unsigned int i;
> +
> +	/*
> +	 * DESIGN_CAPACITY register always returns a non-zero value if
> +	 * battery is connected and zero if disconnected, hence we'll use
> +	 * it for judging the battery presence.
> +	 */
> +	if (psp =3D=3D POWER_SUPPLY_PROP_PRESENT)
> +		psp =3D POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN;
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
> +static int a500_battery_get_property(struct power_supply *psy,
> +				     enum power_supply_property psp,
> +				     union power_supply_propval *val)
> +{
> +	struct a500_battery *bat =3D power_supply_get_drvdata(psy);
> +	struct device *dev =3D psy->dev.parent;
> +	int ret =3D 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval =3D a500_battery_get_status(bat);
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
> +	case POWER_SUPPLY_PROP_PRESENT:
> +	case POWER_SUPPLY_PROP_TEMP:
> +		ret =3D a500_battery_get_ec_data_index(dev, psp);
> +		if (ret < 0)
> +			break;
> +
> +		ret =3D regmap_read(bat->rmap, ec_data[ret].reg, &val->intval);
> +		break;
> +
> +	default:
> +		dev_err(dev, "%s: invalid property %u\n", __func__, psp);
> +		return -EINVAL;
> +	}
> +
> +	if (!ret) {
> +		/* convert units to match requirements of power supply class */
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
> +static void a500_battery_poll_work(struct work_struct *work)
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
> +	bat->rmap =3D dev_get_regmap(pdev->dev.parent, "KB930");
> +	if (!bat->rmap)
> +		return -EINVAL;
> +
> +	bat->psy =3D devm_power_supply_register_no_ws(&pdev->dev,
> +						    &a500_battery_desc,
> +						    &psy_cfg);
> +	if (IS_ERR(bat->psy))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(bat->psy),
> +				     "failed to register battery\n");
> +
> +	INIT_DELAYED_WORK(&bat->poll_work, a500_battery_poll_work);
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
> +MODULE_LICENSE("GPL");
> --=20
> 2.27.0
>=20

--ok6fkpcma74wg3w4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9/mV4ACgkQ2O7X88g7
+pqdow/+L+EkeTIIOm3OSxcy7JUXyJ/js106wo9SF4KnEhTemK1h7QAnkiA6Yl0X
NIRedoQFFjc/eecQaGHhNP+I8M1M4zrXwP3Wfxthsc4tkHCNCypJqwgW+JoSU5pv
kVa3QwYDTn02b0Umx9w8RlJjWthli1tuZZiWaT5hZJzAJMNYGyap6SPITkfB8PPq
DlaKEuUsQiOzuCD4mrx9d3kIJTPZj6LMMYXdNA+WREkM3d2yrAxq0kY3iZSQkeK+
0hlQMAJyzrBm0nkl5tYfNnk+ivh5D0+Qt0wKR27MZX960eOfSnlwtYRiSsSu7z8i
cbXouEKAuY78QSoji/mWiEbYWR/Qcqd9qW8pUjMz4rSVCqtmNhFna7V+kuQ1zXiW
5Bvccj7KzPww45lVEVyLeQcVoMDwNAtmXIyKRKR4nb39J41yQts3Q00VH/r5I5f4
tWJLDO7QC6IXx14XSydVar0WQ7uYK90ojFW9cCthDn/hM3tKtrumhMIpO6cxl0uP
AZhcvE81r7nlbEFCz2Fr2uW0GgqfoiIiAHaMAdFVnQODX6iDUfHiP3PnwoqaKf8Z
2XRlQ+Ntor9asZOjlEHHSxpr0GZaRhl+JBtIgmg9SaS4BOCt1X0KQLMvGiRr3DGj
nkE1EKPsMbAjQn+K6V5/QczDMtPN6KrfsMcd7zXspvArHZlT29A=
=JZte
-----END PGP SIGNATURE-----

--ok6fkpcma74wg3w4--
