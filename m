Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7892F6A00
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 19:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbhANSug (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 13:50:36 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52108 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbhANSug (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 13:50:36 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 0F7451F45A80
Received: by earth.universe (Postfix, from userid 1000)
        id 0F4FB3C0C94; Thu, 14 Jan 2021 19:49:51 +0100 (CET)
Date:   Thu, 14 Jan 2021 19:49:51 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/3] power: supply: Add battery gauge driver for Acer
 Iconia Tab A500
Message-ID: <20210114184951.4itiy5kfqjcxkoms@earth.universe>
References: <20201228160547.30562-1-digetx@gmail.com>
 <20201228160547.30562-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fanhwzk2b46wa3oi"
Content-Disposition: inline
In-Reply-To: <20201228160547.30562-4-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--fanhwzk2b46wa3oi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 28, 2020 at 07:05:47PM +0300, Dmitry Osipenko wrote:
> This patch adds battery gauge driver for Acer Iconia Tab A500 device.
> The battery gauge function is provided via the Embedded Controller,
> which is found on the Acer A500.
>=20
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/Kconfig             |   6 +
>  drivers/power/supply/Makefile            |   1 +
>  drivers/power/supply/acer_a500_battery.c | 297 +++++++++++++++++++++++
>  3 files changed, 304 insertions(+)
>  create mode 100644 drivers/power/supply/acer_a500_battery.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index eec646c568b7..bc493173ddbc 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -774,4 +774,10 @@ config RN5T618_POWER
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
> index dd4b86318cd9..0607a3d64c0f 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -98,3 +98,4 @@ obj-$(CONFIG_CHARGER_BD70528)	+=3D bd70528-charger.o
>  obj-$(CONFIG_CHARGER_BD99954)	+=3D bd99954-charger.o
>  obj-$(CONFIG_CHARGER_WILCO)	+=3D wilco-charger.o
>  obj-$(CONFIG_RN5T618_POWER)	+=3D rn5t618_power.o
> +obj-$(CONFIG_BATTERY_ACER_A500)	+=3D acer_a500_battery.o
> diff --git a/drivers/power/supply/acer_a500_battery.c b/drivers/power/sup=
ply/acer_a500_battery.c
> new file mode 100644
> index 000000000000..32a0bfcac08f
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
> +	struct regmap *regmap;
> +	unsigned int capacity;
> +};
> +
> +static bool a500_battery_update_capacity(struct a500_battery *bat)
> +{
> +	unsigned int capacity;
> +	int err;
> +
> +	err =3D regmap_read(bat->regmap, ec_data[REG_CAPACITY].reg, &capacity);
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
> +		ret =3D regmap_read(bat->regmap, ec_data[ret].reg, &val->intval);
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
> +	bat->regmap =3D dev_get_regmap(pdev->dev.parent, "KB930");
> +	if (!bat->regmap)
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
> 2.29.2
>=20

--fanhwzk2b46wa3oi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmAAkk4ACgkQ2O7X88g7
+ppdjw/6AkYv9leP/9NMuxsp3uUHlSnkhvhL0R1obHZVCcrzUvOKVSTOUNRKjfYB
N/IHrt0W8Ehkqeeeh+c/hIiNuId6mGtdqnmYJUdSy/GKahHNvBWdwhizGY8NjwYq
yrZDAmPiqZ/KpS4oYdeQE72/4JD28gX3Ws9e8U7MknIPuCRRGDrqi+ZxEM2qBkG2
cWOSs/THhTYEbYNmdPAqo1kq3Ii/6INCQkLXh+xxUSk3euTDWWG+ash4+OIutGvZ
czbQ8Im2MYMRepOpN6zmjnb3jXZBveqiMi1VpKIycWMQ41sw61fEBA6O7C+77R2D
CEVN16u6sS3aSBkwTenRsUXr58B+yL1Oth1e09iwLSJ3m78+E+UK6oE5mS6ztu5Y
XNrEh1Ika/wL+eK9xBjNSVospj1vGxu5qYP7y57778t/VzkrawRxGIY3LNoonCK/
MuAywfXs5kfJYOYDBf5NrUWmqw4gE/xQSeqWpYM+ku3Ou61JeW/X3t2HBdMpf0ax
pEZ397FPs49LyuW/D6HmZ+tPUq6BEtz6a7CpgdnUWA9LgVpTGGbqjefRZ+Yh66DY
yufrJUZiM/KuyljRFJuf4SSF1i033yFWC9HBKuqk1aTE7U96rDh7JVdIVF95Taw3
8iZssJX31FVNcS3pKBn3ni6a4pk/yo2T1rYBBjpj9hafrzGgU2k=
=JNT8
-----END PGP SIGNATURE-----

--fanhwzk2b46wa3oi--
