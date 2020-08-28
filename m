Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF86F255FEE
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 19:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgH1RoO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 13:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgH1RoF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Aug 2020 13:44:05 -0400
Received: from earth.universe (dyndsl-095-033-159-123.ewe-ip-backbone.de [95.33.159.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52F0D2074A;
        Fri, 28 Aug 2020 17:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598636644;
        bh=jC6FFqCcsJ8hjsIfpl39GXUKL5DOQ80DT/RsKA6FHK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fqMfEzj4jMghhRj8+UtZXMnNWxW/bAT/UprjPTf5DPcytGFYPYMbBFPx+4GsuQ3L1
         8ngeUj5mA0IJZDc7JdjLP58gLRs4KHOz/jTi4aZCpfczSwAxCECp/cZeBQQnIK3MoD
         pJPmj0H/SejtGMLF6xrvVea0QyA+6tZolVcLajoY=
Received: by earth.universe (Postfix, from userid 1000)
        id B45CB3C0C82; Fri, 28 Aug 2020 19:44:02 +0200 (CEST)
Date:   Fri, 28 Aug 2020 19:44:02 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Subject: Re: [PATCH v3 1/6] power: supply: max17040: Use regmap i2c
Message-ID: <20200828174402.6fymgrib6qtnyn5v@earth.universe>
References: <20200624155633.3557401-1-iskren.chernev@gmail.com>
 <20200624155633.3557401-2-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="65m5sso65mbi7rb4"
Content-Disposition: inline
In-Reply-To: <20200624155633.3557401-2-iskren.chernev@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--65m5sso65mbi7rb4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 24, 2020 at 06:56:28PM +0300, Iskren Chernev wrote:
> Rewrite i2c operations from i2c client read/write to regmap i2c. As
> a result, most private functions now accept the private driver data
> instead of an i2c client pointer.
>=20
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---

This still does two things: converting the driver to devm_
and using regmap. Please split into two patches. Otherwise
the changes look good, but the patchset needs to be rebased.

-- Sebastian

>  drivers/power/supply/Kconfig            |   1 +
>  drivers/power/supply/max17040_battery.c | 250 +++++++++++-------------
>  2 files changed, 110 insertions(+), 141 deletions(-)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 44d3c8512fb8d..12ca79952768f 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -367,6 +367,7 @@ config AXP288_FUEL_GAUGE
>  config BATTERY_MAX17040
>  	tristate "Maxim MAX17040 Fuel Gauge"
>  	depends on I2C
> +	select REGMAP_I2C
>  	help
>  	  MAX17040 is fuel-gauge systems for lithium-ion (Li+) batteries
>  	  in handheld and portable equipment. The MAX17040 is configured
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supp=
ly/max17040_battery.c
> index 48aa44665e2f1..678241fcc2548 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -16,32 +16,30 @@
>  #include <linux/interrupt.h>
>  #include <linux/power_supply.h>
>  #include <linux/max17040_battery.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
> =20
>  #define MAX17040_VCELL	0x02
>  #define MAX17040_SOC	0x04
>  #define MAX17040_MODE	0x06
>  #define MAX17040_VER	0x08
> -#define MAX17040_RCOMP	0x0C
> +#define MAX17040_CONFIG	0x0C
>  #define MAX17040_CMD	0xFE
> =20
> =20
>  #define MAX17040_DELAY		1000
>  #define MAX17040_BATTERY_FULL	95
> =20
> -#define MAX17040_ATHD_MASK		0xFFC0
> +#define MAX17040_ATHD_MASK		0x3f
>  #define MAX17040_ATHD_DEFAULT_POWER_UP	4
> =20
>  struct max17040_chip {
>  	struct i2c_client		*client;
> +	struct regmap			*regmap;
>  	struct delayed_work		work;
>  	struct power_supply		*battery;
>  	struct max17040_platform_data	*pdata;
> =20
> -	/* State Of Connect */
> -	int online;
> -	/* battery voltage */
> -	int vcell;
>  	/* battery capacity */
>  	int soc;
>  	/* State Of Charge */
> @@ -50,135 +48,68 @@ struct max17040_chip {
>  	u32 low_soc_alert;
>  };
> =20
> -static int max17040_get_property(struct power_supply *psy,
> -			    enum power_supply_property psp,
> -			    union power_supply_propval *val)
> -{
> -	struct max17040_chip *chip =3D power_supply_get_drvdata(psy);
> -
> -	switch (psp) {
> -	case POWER_SUPPLY_PROP_STATUS:
> -		val->intval =3D chip->status;
> -		break;
> -	case POWER_SUPPLY_PROP_ONLINE:
> -		val->intval =3D chip->online;
> -		break;
> -	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> -		val->intval =3D chip->vcell;
> -		break;
> -	case POWER_SUPPLY_PROP_CAPACITY:
> -		val->intval =3D chip->soc;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -	return 0;
> -}
> -
> -static int max17040_write_reg(struct i2c_client *client, int reg, u16 va=
lue)
> -{
> -	int ret;
> -
> -	ret =3D i2c_smbus_write_word_swapped(client, reg, value);
> -
> -	if (ret < 0)
> -		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
> -
> -	return ret;
> -}
> -
> -static int max17040_read_reg(struct i2c_client *client, int reg)
> -{
> -	int ret;
> -
> -	ret =3D i2c_smbus_read_word_swapped(client, reg);
> -
> -	if (ret < 0)
> -		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
> -
> -	return ret;
> -}
> -
> -static void max17040_reset(struct i2c_client *client)
> +static int max17040_reset(struct max17040_chip *chip)
>  {
> -	max17040_write_reg(client, MAX17040_CMD, 0x0054);
> +	return regmap_write(chip->regmap, MAX17040_CMD, 0x0054);
>  }
> =20
> -static int max17040_set_low_soc_alert(struct i2c_client *client, u32 lev=
el)
> +static int max17040_set_low_soc_alert(struct max17040_chip *chip, u32 le=
vel)
>  {
> -	int ret;
> -	u16 data;
> -
>  	level =3D 32 - level;
> -	data =3D max17040_read_reg(client, MAX17040_RCOMP);
> -	/* clear the alrt bit and set LSb 5 bits */
> -	data &=3D MAX17040_ATHD_MASK;
> -	data |=3D level;
> -	ret =3D max17040_write_reg(client, MAX17040_RCOMP, data);
> -
> -	return ret;
> +	return regmap_update_bits(chip->regmap, MAX17040_CONFIG,
> +			MAX17040_ATHD_MASK, level);
>  }
> =20
> -static void max17040_get_vcell(struct i2c_client *client)
> +static int max17040_get_vcell(struct max17040_chip *chip)
>  {
> -	struct max17040_chip *chip =3D i2c_get_clientdata(client);
> -	u16 vcell;
> +	u32 vcell;
> =20
> -	vcell =3D max17040_read_reg(client, MAX17040_VCELL);
> +	regmap_read(chip->regmap, MAX17040_VCELL, &vcell);
> =20
> -	chip->vcell =3D (vcell >> 4) * 1250;
> +	return (vcell >> 4) * 1250;
>  }
> =20
> -static void max17040_get_soc(struct i2c_client *client)
> +static int max17040_get_soc(struct max17040_chip *chip)
>  {
> -	struct max17040_chip *chip =3D i2c_get_clientdata(client);
> -	u16 soc;
> +	u32 soc;
> =20
> -	soc =3D max17040_read_reg(client, MAX17040_SOC);
> +	regmap_read(chip->regmap, MAX17040_SOC, &soc);
> =20
> -	chip->soc =3D (soc >> 8);
> +	return soc >> 8;
>  }
> =20
> -static void max17040_get_version(struct i2c_client *client)
> +static int max17040_get_version(struct max17040_chip *chip)
>  {
> -	u16 version;
> +	int ret;
> +	u32 version;
> =20
> -	version =3D max17040_read_reg(client, MAX17040_VER);
> +	ret =3D regmap_read(chip->regmap, MAX17040_VER, &version);
> =20
> -	dev_info(&client->dev, "MAX17040 Fuel-Gauge Ver 0x%x\n", version);
> +	return ret ? ret : version;
>  }
> =20
> -static void max17040_get_online(struct i2c_client *client)
> +static int max17040_get_online(struct max17040_chip *chip)
>  {
> -	struct max17040_chip *chip =3D i2c_get_clientdata(client);
> -
> -	if (chip->pdata && chip->pdata->battery_online)
> -		chip->online =3D chip->pdata->battery_online();
> -	else
> -		chip->online =3D 1;
> +	return chip->pdata && chip->pdata->battery_online ?
> +		chip->pdata->battery_online() : 1;
>  }
> =20
> -static void max17040_get_status(struct i2c_client *client)
> +static int max17040_get_status(struct max17040_chip *chip)
>  {
> -	struct max17040_chip *chip =3D i2c_get_clientdata(client);
> -
>  	if (!chip->pdata || !chip->pdata->charger_online
> -			|| !chip->pdata->charger_enable) {
> -		chip->status =3D POWER_SUPPLY_STATUS_UNKNOWN;
> -		return;
> -	}
> +			|| !chip->pdata->charger_enable)
> +		return POWER_SUPPLY_STATUS_UNKNOWN;
> +
> +	if (max17040_get_soc(chip) > MAX17040_BATTERY_FULL)
> +		return POWER_SUPPLY_STATUS_FULL;
> =20
> -	if (chip->pdata->charger_online()) {
> +	if (chip->pdata->charger_online())
>  		if (chip->pdata->charger_enable())
> -			chip->status =3D POWER_SUPPLY_STATUS_CHARGING;
> +			return POWER_SUPPLY_STATUS_CHARGING;
>  		else
> -			chip->status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> -	} else {
> -		chip->status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> -	}
> -
> -	if (chip->soc > MAX17040_BATTERY_FULL)
> -		chip->status =3D POWER_SUPPLY_STATUS_FULL;
> +			return POWER_SUPPLY_STATUS_NOT_CHARGING;
> +	else
> +		return POWER_SUPPLY_STATUS_DISCHARGING;
>  }
> =20
>  static int max17040_get_of_data(struct max17040_chip *chip)
> @@ -190,18 +121,31 @@ static int max17040_get_of_data(struct max17040_chi=
p *chip)
>  				 "maxim,alert-low-soc-level",
>  				 &chip->low_soc_alert);
> =20
> -	if (chip->low_soc_alert <=3D 0 || chip->low_soc_alert >=3D 33)
> +	if (chip->low_soc_alert <=3D 0 || chip->low_soc_alert >=3D 33) {
> +		dev_err(dev, "maxim,alert-low-soc-level out of bounds\n");
>  		return -EINVAL;
> +	}
> =20
>  	return 0;
>  }
> =20
> -static void max17040_check_changes(struct i2c_client *client)
> +static void max17040_check_changes(struct max17040_chip *chip)
> +{
> +	chip->soc =3D max17040_get_soc(chip);
> +	chip->status =3D max17040_get_status(chip);
> +}
> +
> +static void max17040_queue_work(struct max17040_chip *chip)
> +{
> +	queue_delayed_work(system_power_efficient_wq, &chip->work,
> +			   MAX17040_DELAY);
> +}
> +
> +static void max17040_stop_work(void *data)
>  {
> -	max17040_get_vcell(client);
> -	max17040_get_soc(client);
> -	max17040_get_online(client);
> -	max17040_get_status(client);
> +	struct max17040_chip *chip =3D data;
> +
> +	cancel_delayed_work_sync(&chip->work);
>  }
> =20
>  static void max17040_work(struct work_struct *work)
> @@ -214,30 +158,29 @@ static void max17040_work(struct work_struct *work)
>  	/* store SOC and status to check changes */
>  	last_soc =3D chip->soc;
>  	last_status =3D chip->status;
> -	max17040_check_changes(chip->client);
> +	max17040_check_changes(chip);
> =20
>  	/* check changes and send uevent */
>  	if (last_soc !=3D chip->soc || last_status !=3D chip->status)
>  		power_supply_changed(chip->battery);
> =20
> -	queue_delayed_work(system_power_efficient_wq, &chip->work,
> -			   MAX17040_DELAY);
> +	max17040_queue_work(chip);
>  }
> =20
>  static irqreturn_t max17040_thread_handler(int id, void *dev)
>  {
>  	struct max17040_chip *chip =3D dev;
> -	struct i2c_client *client =3D chip->client;
> =20
> -	dev_warn(&client->dev, "IRQ: Alert battery low level");
> +	dev_warn(&chip->client->dev, "IRQ: Alert battery low level");
> +
>  	/* read registers */
> -	max17040_check_changes(chip->client);
> +	max17040_check_changes(chip);
> =20
>  	/* send uevent */
>  	power_supply_changed(chip->battery);
> =20
>  	/* reset alert bit */
> -	max17040_set_low_soc_alert(client, chip->low_soc_alert);
> +	max17040_set_low_soc_alert(chip, chip->low_soc_alert);
> =20
>  	return IRQ_HANDLED;
>  }
> @@ -256,6 +199,38 @@ static int max17040_enable_alert_irq(struct max17040=
_chip *chip)
>  	return ret;
>  }
> =20
> +static int max17040_get_property(struct power_supply *psy,
> +			    enum power_supply_property psp,
> +			    union power_supply_propval *val)
> +{
> +	struct max17040_chip *chip =3D power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval =3D max17040_get_status(chip);
> +		break;
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D max17040_get_online(chip);
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval =3D max17040_get_vcell(chip);
> +		break;
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		val->intval =3D max17040_get_soc(chip);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static const struct regmap_config max17040_regmap =3D {
> +	.reg_bits	=3D 8,
> +	.reg_stride	=3D 2,
> +	.val_bits	=3D 16,
> +	.val_format_endian =3D REGMAP_ENDIAN_BIG,
> +};
> +
>  static enum power_supply_property max17040_battery_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_ONLINE,
> @@ -287,31 +262,33 @@ static int max17040_probe(struct i2c_client *client,
>  		return -ENOMEM;
> =20
>  	chip->client =3D client;
> +	chip->regmap =3D devm_regmap_init_i2c(client, &max17040_regmap);
>  	chip->pdata =3D client->dev.platform_data;
>  	ret =3D max17040_get_of_data(chip);
> -	if (ret) {
> -		dev_err(&client->dev,
> -			"failed: low SOC alert OF data out of bounds\n");
> +	if (ret)
>  		return ret;
> -	}
> =20
>  	i2c_set_clientdata(client, chip);
>  	psy_cfg.drv_data =3D chip;
> =20
> -	chip->battery =3D power_supply_register(&client->dev,
> +	chip->battery =3D devm_power_supply_register(&client->dev,
>  				&max17040_battery_desc, &psy_cfg);
>  	if (IS_ERR(chip->battery)) {
>  		dev_err(&client->dev, "failed: power supply register\n");
>  		return PTR_ERR(chip->battery);
>  	}
> =20
> -	max17040_reset(client);
> -	max17040_get_version(client);
> +	ret =3D max17040_get_version(chip);
> +	if (ret < 0)
> +		return ret;
> +	dev_dbg(&chip->client->dev, "MAX17040 Fuel-Gauge Ver 0x%x\n", ret);
> +
> +	max17040_reset(chip);
> =20
>  	/* check interrupt */
>  	if (client->irq && of_device_is_compatible(client->dev.of_node,
>  						   "maxim,max77836-battery")) {
> -		ret =3D max17040_set_low_soc_alert(client, chip->low_soc_alert);
> +		ret =3D max17040_set_low_soc_alert(chip, chip->low_soc_alert);
>  		if (ret) {
>  			dev_err(&client->dev,
>  				"Failed to set low SOC alert: err %d\n", ret);
> @@ -327,18 +304,11 @@ static int max17040_probe(struct i2c_client *client,
>  	}
> =20
>  	INIT_DEFERRABLE_WORK(&chip->work, max17040_work);
> -	queue_delayed_work(system_power_efficient_wq, &chip->work,
> -			   MAX17040_DELAY);
> -
> -	return 0;
> -}
> -
> -static int max17040_remove(struct i2c_client *client)
> -{
> -	struct max17040_chip *chip =3D i2c_get_clientdata(client);
> +	ret =3D devm_add_action(&client->dev, max17040_stop_work, chip);
> +	if (ret)
> +		return ret;
> +	max17040_queue_work(chip);
> =20
> -	power_supply_unregister(chip->battery);
> -	cancel_delayed_work(&chip->work);
>  	return 0;
>  }
> =20
> @@ -362,12 +332,11 @@ static int max17040_resume(struct device *dev)
>  	struct i2c_client *client =3D to_i2c_client(dev);
>  	struct max17040_chip *chip =3D i2c_get_clientdata(client);
> =20
> -	queue_delayed_work(system_power_efficient_wq, &chip->work,
> -			   MAX17040_DELAY);
> -
>  	if (client->irq && device_may_wakeup(dev))
>  		disable_irq_wake(client->irq);
> =20
> +	max17040_queue_work(chip);
> +
>  	return 0;
>  }
> =20
> @@ -401,7 +370,6 @@ static struct i2c_driver max17040_i2c_driver =3D {
>  		.pm	=3D MAX17040_PM_OPS,
>  	},
>  	.probe		=3D max17040_probe,
> -	.remove		=3D max17040_remove,
>  	.id_table	=3D max17040_id,
>  };
>  module_i2c_driver(max17040_i2c_driver);
> --=20
> 2.27.0
>=20

--65m5sso65mbi7rb4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9JQlsACgkQ2O7X88g7
+prxlQ/9EmJNKlULTOecztq7B26A27ggm5y+7RX7k7tZjPcVh605tS2odLlARVGm
8NZy78FtoZPq8a/OVkMWGuMDwJdt7hHtVHuP9v/NVXeXm+cbIM9ewMKnKcOEK347
3BFyPaY0VSr8h1UtHQUIOp7kT05i+IK5Y83y/Mr2Ozjf1kLgAro9vBPmEPBBYmV4
hfRP3Bf3Wvj1p9KPPdndG4zxMUdm175wpLjJTPI9UPQlEt3wHS+vPSjrDKsHMjb5
Qh9Gi3zEol045G3cEgatsu3R03OitF8Xpl18gJ7IJglzD2ZOocoB+BkZSF/uLXox
HBqNM10qZZJ77I7EKqTjaS2Xr/5uFWcxflb559gfl7Qvms/ao69DVCP007DVT7Wj
kS8rIbDtsm2e7FISb9woYl6+o0FIaGzVOZz9ewGPswjhxy9GRt2Us9ml/0mBVEQp
l58jNdc07nS0ulO7G6sIBxWD2lJ22rp76+Lj6nE+u4wiFQeZwHqq7Yey7mcRUltl
tQUDfzmygQfYbbI9NhGBgLueBIW3Clu1exIG8UyNnS2ga+drp1sV1Q0Bv3q5RIET
4RgFr4iZUoD+FALEcGTd7ONk+qET8mZTUT1+PjSRmNMHwTMYq7tjWDF625feySF8
RYtB2qydHprgNoFOUYYGPF+wxJJMKUJS1p7mVy+fx9AHR92ZY7Q=
=W7sT
-----END PGP SIGNATURE-----

--65m5sso65mbi7rb4--
