Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0546E201498
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jun 2020 18:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391564AbgFSQNJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jun 2020 12:13:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405551AbgFSQNI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Jun 2020 12:13:08 -0400
Received: from earth.universe (dyndsl-037-138-190-043.ewe-ip-backbone.de [37.138.190.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E80121707;
        Fri, 19 Jun 2020 16:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592583186;
        bh=+aGv8iwpP9+CMWh9+MqOAmfYSORfqBYG5ecXa4aIoEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e43nN9FHe7GOOfgyNbVneGjTU5Y2LBPg8eCXA98mxpVBE9Pflf0HQARwCRXtRNB3i
         LjuzZC+GeCFDRfhQpSHE01+sxqr8dny2jX7qkpHOdrlOIetGlR/iJsXmi44u718Ke9
         mBbzrY9IOuYR6YGbwIhh41Z792gzzCaJdpxkT7LQ=
Received: by earth.universe (Postfix, from userid 1000)
        id 933F43C08CD; Fri, 19 Jun 2020 18:13:04 +0200 (CEST)
Date:   Fri, 19 Jun 2020 18:13:04 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Subject: Re: [PATCH v2 2/2] power: supply: max17040: Support compatible
 devices
Message-ID: <20200619161304.z4k522rjdewmhija@earth.universe>
References: <20200618101340.2671020-1-iskren.chernev@gmail.com>
 <20200618101340.2671020-2-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2fxo3kd4q4dxs5f5"
Content-Disposition: inline
In-Reply-To: <20200618101340.2671020-2-iskren.chernev@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2fxo3kd4q4dxs5f5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 18, 2020 at 01:13:40PM +0300, Iskren Chernev wrote:
> The max17040 fuel gauge is part of a family of 8 chips that have very
> similar mode of operations and registers.
>=20
> This change adds:
> - compatible strings for all supported devices and handles the minor
>   differences between them;
> - handling for devices reporting double capacity via maxim,double-soc;
> - handling for setting rcomp, a compensation value for more accurate
>   reading, affected by battery chemistry and operating temps;
> - suppot for SOC alerts (capacity changes by +/- 1%), to prevent polling
>   every second;
> - redo i2c read/writes via regmap

Please split this into multiple patches as described in
Documentation/process/submitting-patches.rst:

3) Separate your changes
------------------------

Separate each **logical change** into a separate patch.

Thanks,

-- Sebastian

> The datasheets of the supported devices are linked [0] [1] [2] [3].
>=20
> [0] https://datasheets.maximintegrated.com/en/ds/MAX17040-MAX17041.pdf
> [1] https://datasheets.maximintegrated.com/en/ds/MAX17043-MAX17044.pdf
> [2] https://datasheets.maximintegrated.com/en/ds/MAX17048-MAX17049.pdf
> [3] https://datasheets.maximintegrated.com/en/ds/MAX17058-MAX17059.pdf
>=20
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> ---
> v1: https://lkml.org/lkml/2020/6/8/683
>=20
> changes in v2:
> - make max17040_family static
> - fix rcomp len check
> - implement maxim,skip-reset
> - reword Kconfig text
>=20
>  drivers/power/supply/Kconfig            |  11 +-
>  drivers/power/supply/max17040_battery.c | 466 +++++++++++++++++-------
>  2 files changed, 338 insertions(+), 139 deletions(-)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 44d3c8512fb8d..69e9eaa100d9f 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -368,9 +368,14 @@ config BATTERY_MAX17040
>  	tristate "Maxim MAX17040 Fuel Gauge"
>  	depends on I2C
>  	help
> -	  MAX17040 is fuel-gauge systems for lithium-ion (Li+) batteries
> -	  in handheld and portable equipment. The MAX17040 is configured
> -	  to operate with a single lithium cell
> +	  Maxim models with ModelGauge are fuel-gauge systems for lithium-ion
> +	  (Li+) batteries in handheld and portable equipment, including
> +	  max17040, max17041, max17043, max17044, max17048, max17049, max17058,
> +	  max17059.  It is also included in some batteries like max77836.
> +
> +	  Driver supports reporting SOC (State of Charge, i.e capacity),
> +	  voltage and configurable low-SOC wakeup interrupt. For certain models
> +	  a SOC change interrupt is also supported.
> =20
>  config BATTERY_MAX17042
>  	tristate "Maxim MAX17042/17047/17050/8997/8966 Fuel Gauge"
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supp=
ly/max17040_battery.c
> index 48aa44665e2f1..1244982cacacb 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -15,193 +15,342 @@
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/power_supply.h>
> +#include <linux/of_device.h>
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
> +#define MAX17040_STATUS	0x1A
>  #define MAX17040_CMD	0xFE
> =20
> =20
>  #define MAX17040_DELAY		1000
>  #define MAX17040_BATTERY_FULL	95
> +#define MAX17040_RCOMP_DEFAULT  0x9700
> =20
> -#define MAX17040_ATHD_MASK		0xFFC0
> +#define MAX17040_ATHD_MASK		0x3f
> +#define MAX17040_ALSC_MASK		0x40
>  #define MAX17040_ATHD_DEFAULT_POWER_UP	4
> +#define MAX17040_STATUS_HD_MASK		0x1000
> +#define MAX17040_STATUS_SC_MASK		0x2000
> +#define MAX17040_CFG_RCOMP_MASK		0xff00
> +
> +enum chip_id {
> +	ID_MAX17040,
> +	ID_MAX17041,
> +	ID_MAX17043,
> +	ID_MAX17044,
> +	ID_MAX17048,
> +	ID_MAX17049,
> +	ID_MAX17058,
> +	ID_MAX17059,
> +};
> +
> +/* values that differ by chip_id */
> +struct chip_data {
> +	u16 reset_val;
> +	u16 vcell_shift;
> +	u16 vcell_mul;
> +	u16 vcell_div;
> +	u8  rcomp_bytes;
> +	u8  has_low_soc_alert;
> +	u8  has_soc_alert;
> +};
> +
> +static struct chip_data max17040_family[] =3D {
> +	[ID_MAX17040] =3D {
> +		.reset_val =3D 0x0054,
> +		.vcell_shift =3D 4,
> +		.vcell_mul =3D 1250,
> +		.vcell_div =3D 1,
> +		.rcomp_bytes =3D 2,
> +		.has_low_soc_alert =3D 0,
> +		.has_soc_alert =3D 0,
> +	},
> +	[ID_MAX17041] =3D {
> +		.reset_val =3D 0x0054,
> +		.vcell_shift =3D 4,
> +		.vcell_mul =3D 2500,
> +		.vcell_div =3D 1,
> +		.rcomp_bytes =3D 2,
> +		.has_low_soc_alert =3D 0,
> +		.has_soc_alert =3D 0,
> +	},
> +	[ID_MAX17043] =3D {
> +		.reset_val =3D 0x0054,
> +		.vcell_shift =3D 4,
> +		.vcell_mul =3D 1250,
> +		.vcell_div =3D 1,
> +		.rcomp_bytes =3D 1,
> +		.has_low_soc_alert =3D 1,
> +		.has_soc_alert =3D 0,
> +	},
> +	[ID_MAX17044] =3D {
> +		.reset_val =3D 0x0054,
> +		.vcell_shift =3D 4,
> +		.vcell_mul =3D 2500,
> +		.vcell_div =3D 1,
> +		.rcomp_bytes =3D 1,
> +		.has_low_soc_alert =3D 1,
> +		.has_soc_alert =3D 0,
> +	},
> +	[ID_MAX17048] =3D {
> +		.reset_val =3D 0x5400,
> +		.vcell_shift =3D 0,
> +		.vcell_mul =3D 625,
> +		.vcell_div =3D 8,
> +		.rcomp_bytes =3D 1,
> +		.has_low_soc_alert =3D 1,
> +		.has_soc_alert =3D 1,
> +	},
> +	[ID_MAX17049] =3D {
> +		.reset_val =3D 0x5400,
> +		.vcell_shift =3D 0,
> +		.vcell_mul =3D 625,
> +		.vcell_div =3D 4,
> +		.rcomp_bytes =3D 1,
> +		.has_low_soc_alert =3D 1,
> +		.has_soc_alert =3D 1,
> +	},
> +	[ID_MAX17058] =3D {
> +		.reset_val =3D 0x5400,
> +		.vcell_shift =3D 0,
> +		.vcell_mul =3D 625,
> +		.vcell_div =3D 8,
> +		.rcomp_bytes =3D 1,
> +		.has_low_soc_alert =3D 1,
> +		.has_soc_alert =3D 0,
> +	},
> +	[ID_MAX17059] =3D {
> +		.reset_val =3D 0x5400,
> +		.vcell_shift =3D 0,
> +		.vcell_mul =3D 625,
> +		.vcell_div =3D 4,
> +		.rcomp_bytes =3D 1,
> +		.has_low_soc_alert =3D 1,
> +		.has_soc_alert =3D 0,
> +	},
> +};
> =20
>  struct max17040_chip {
>  	struct i2c_client		*client;
> +	struct regmap			*regmap;
>  	struct delayed_work		work;
>  	struct power_supply		*battery;
>  	struct max17040_platform_data	*pdata;
> +	struct chip_data		data;
> =20
> -	/* State Of Connect */
> -	int online;
> -	/* battery voltage */
> -	int vcell;
>  	/* battery capacity */
>  	int soc;
>  	/* State Of Charge */
>  	int status;
> +
>  	/* Low alert threshold from 32% to 1% of the State of Charge */
>  	u32 low_soc_alert;
> +	/* some devices return twice the capacity */
> +	bool quirk_double_soc;
> +	/* resetting causes some devices to show inaccurate reading */
> +	bool quirk_skip_reset;
> +	/* higher 8 bits for 17043+, 16 bits for 17040,41 */
> +	u16 rcomp;
>  };
> =20
> -static int max17040_get_property(struct power_supply *psy,
> -			    enum power_supply_property psp,
> -			    union power_supply_propval *val)
> +static int max17040_reset(struct max17040_chip *chip)
>  {
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
> +	return regmap_write(chip->regmap, MAX17040_CMD, chip->data.reset_val);
>  }
> =20
> -static int max17040_write_reg(struct i2c_client *client, int reg, u16 va=
lue)
> +static int max17040_set_low_soc_alert(struct max17040_chip *chip, u32 le=
vel)
>  {
> -	int ret;
> -
> -	ret =3D i2c_smbus_write_word_swapped(client, reg, value);
> -
> -	if (ret < 0)
> -		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
> +	level =3D 32 - level;
> +	return regmap_update_bits(chip->regmap, MAX17040_CONFIG,
> +			MAX17040_ATHD_MASK, level);
> +}
> =20
> -	return ret;
> +static int max17040_set_soc_alert(struct max17040_chip *chip, bool enabl=
e)
> +{
> +	return regmap_update_bits(chip->regmap, MAX17040_CONFIG,
> +			MAX17040_ALSC_MASK, enable ? MAX17040_ALSC_MASK : 0);
>  }
> =20
> -static int max17040_read_reg(struct i2c_client *client, int reg)
> +/* Returns true if alert cause was SOC change, not low SOC */
> +static bool max17040_handle_soc_alert(struct max17040_chip *chip)
>  {
> -	int ret;
> +	bool ret =3D true;
> +	u32 data;
> =20
> -	ret =3D i2c_smbus_read_word_swapped(client, reg);
> +	regmap_read(chip->regmap, MAX17040_STATUS, &data);
> =20
> -	if (ret < 0)
> -		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
> +	if (data & MAX17040_STATUS_HD_MASK) {
> +		// this alert was caused by low soc
> +		ret =3D false;
> +	}
> +	if (data & MAX17040_STATUS_SC_MASK) {
> +		// soc change bit -- deassert to mark as handled
> +		regmap_write(chip->regmap, MAX17040_STATUS,
> +				data & ~MAX17040_STATUS_SC_MASK);
> +	}
> =20
>  	return ret;
>  }
> =20
> -static void max17040_reset(struct i2c_client *client)
> +static int max17040_set_rcomp(struct max17040_chip *chip, u16 rcomp)
>  {
> -	max17040_write_reg(client, MAX17040_CMD, 0x0054);
> +	u16 mask =3D chip->data.rcomp_bytes =3D=3D 2 ?
> +		0xffff : MAX17040_CFG_RCOMP_MASK;
> +
> +	return regmap_update_bits(chip->regmap, MAX17040_CONFIG, mask, rcomp);
>  }
> =20
> -static int max17040_set_low_soc_alert(struct i2c_client *client, u32 lev=
el)
> +static int max17040_raw_vcell_to_uvolts(struct max17040_chip *chip, u16 =
vcell)
>  {
> -	int ret;
> -	u16 data;
> -
> -	level =3D 32 - level;
> -	data =3D max17040_read_reg(client, MAX17040_RCOMP);
> -	/* clear the alrt bit and set LSb 5 bits */
> -	data &=3D MAX17040_ATHD_MASK;
> -	data |=3D level;
> -	ret =3D max17040_write_reg(client, MAX17040_RCOMP, data);
> +	struct chip_data *d =3D &chip->data;
> =20
> -	return ret;
> +	return (vcell >> d->vcell_shift) * d->vcell_mul / d->vcell_div;
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
> +	return max17040_raw_vcell_to_uvolts(chip, vcell);
>  }
> =20
> -static void max17040_get_soc(struct i2c_client *client)
> +static int max17040_raw_soc_to_percent(struct max17040_chip *chip, u16 s=
oc)
>  {
> -	struct max17040_chip *chip =3D i2c_get_clientdata(client);
> -	u16 soc;
> +	int shift =3D 8;
> =20
> -	soc =3D max17040_read_reg(client, MAX17040_SOC);
> +	if (chip->quirk_double_soc)
> +		shift +=3D 1;
> =20
> -	chip->soc =3D (soc >> 8);
> +	return soc >> shift;
>  }
> =20
> -static void max17040_get_version(struct i2c_client *client)
> +static int max17040_get_soc(struct max17040_chip *chip)
>  {
> -	u16 version;
> +	u32 soc;
> =20
> -	version =3D max17040_read_reg(client, MAX17040_VER);
> +	regmap_read(chip->regmap, MAX17040_SOC, &soc);
> =20
> -	dev_info(&client->dev, "MAX17040 Fuel-Gauge Ver 0x%x\n", version);
> +	return max17040_raw_soc_to_percent(chip, soc);
>  }
> =20
> -static void max17040_get_online(struct i2c_client *client)
> +static void max17040_get_version(struct max17040_chip *chip)
>  {
> -	struct max17040_chip *chip =3D i2c_get_clientdata(client);
> +	u32 version;
> =20
> -	if (chip->pdata && chip->pdata->battery_online)
> -		chip->online =3D chip->pdata->battery_online();
> -	else
> -		chip->online =3D 1;
> +	regmap_read(chip->regmap, MAX17040_VER, &version);
> +
> +	dev_dbg(&chip->client->dev, "MAX17040 Fuel-Gauge Ver 0x%x\n", version);
>  }
> =20
> -static void max17040_get_status(struct i2c_client *client)
> +static int max17040_get_online(struct max17040_chip *chip)
>  {
> -	struct max17040_chip *chip =3D i2c_get_clientdata(client);
> +	return chip->pdata && chip->pdata->battery_online ?
> +		chip->pdata->battery_online() : 1;
> +}
> =20
> +static int max17040_get_status(struct max17040_chip *chip)
> +{
>  	if (!chip->pdata || !chip->pdata->charger_online
>  			|| !chip->pdata->charger_enable) {
> -		chip->status =3D POWER_SUPPLY_STATUS_UNKNOWN;
> -		return;
> +		return POWER_SUPPLY_STATUS_UNKNOWN;
>  	}
> =20
> +	if (max17040_get_soc(chip) > MAX17040_BATTERY_FULL)
> +		return POWER_SUPPLY_STATUS_FULL;
> +
>  	if (chip->pdata->charger_online()) {
>  		if (chip->pdata->charger_enable())
> -			chip->status =3D POWER_SUPPLY_STATUS_CHARGING;
> +			return POWER_SUPPLY_STATUS_CHARGING;
>  		else
> -			chip->status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +			return POWER_SUPPLY_STATUS_NOT_CHARGING;
>  	} else {
> -		chip->status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		return POWER_SUPPLY_STATUS_DISCHARGING;
>  	}
> +}
> +
> +static int max17040_get_property(struct power_supply *psy,
> +			    enum power_supply_property psp,
> +			    union power_supply_propval *val)
> +{
> +	struct max17040_chip *chip =3D power_supply_get_drvdata(psy);
> =20
> -	if (chip->soc > MAX17040_BATTERY_FULL)
> -		chip->status =3D POWER_SUPPLY_STATUS_FULL;
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
>  }
> =20
> +
>  static int max17040_get_of_data(struct max17040_chip *chip)
>  {
>  	struct device *dev =3D &chip->client->dev;
> +	struct chip_data *data =3D &max17040_family[
> +		(enum chip_id) of_device_get_match_data(dev)];
> +	int rcomp_len;
> +	u8 rcomp[2];
> =20
>  	chip->low_soc_alert =3D MAX17040_ATHD_DEFAULT_POWER_UP;
>  	device_property_read_u32(dev,
>  				 "maxim,alert-low-soc-level",
>  				 &chip->low_soc_alert);
> =20
> -	if (chip->low_soc_alert <=3D 0 || chip->low_soc_alert >=3D 33)
> +	if (chip->low_soc_alert <=3D 0 || chip->low_soc_alert >=3D 33) {
> +		dev_err(dev, "maxim,alert-low-soc-level out of bounds\n");
>  		return -EINVAL;
> +	}
> +
> +	chip->quirk_double_soc =3D device_property_read_bool(dev,
> +							   "maxim,double-soc");
> +	chip->quirk_skip_reset =3D device_property_read_bool(dev,
> +							   "maxim,skip-reset");
> +	rcomp_len =3D device_property_count_u8(dev, "maxim,rcomp");
> +	chip->rcomp =3D MAX17040_RCOMP_DEFAULT;
> +	if (rcomp_len =3D=3D data->rcomp_bytes) {
> +		device_property_read_u8_array(dev, "maxim,rcomp",
> +					      rcomp, rcomp_len);
> +		chip->rcomp =3D rcomp_len =3D=3D 2 ?
> +			rcomp[0] << 8 | rcomp[1] :
> +			rcomp[0] << 8;
> +	} else if (rcomp_len > 0) {
> +		dev_err(dev, "maxim,rcomp has incorrect length\n");
> +		return -EINVAL;
> +	}
> =20
>  	return 0;
>  }
> =20
> -static void max17040_check_changes(struct i2c_client *client)
> +static void max17040_check_changes(struct max17040_chip *chip)
>  {
> -	max17040_get_vcell(client);
> -	max17040_get_soc(client);
> -	max17040_get_online(client);
> -	max17040_get_status(client);
> +	chip->soc =3D max17040_get_soc(chip);
> +	chip->status =3D max17040_get_status(chip);
> +}
> +
> +static void max17040_queue_work(struct max17040_chip *chip)
> +{
> +	queue_delayed_work(system_power_efficient_wq, &chip->work,
> +			   MAX17040_DELAY);
>  }
> =20
>  static void max17040_work(struct work_struct *work)
> @@ -214,35 +363,42 @@ static void max17040_work(struct work_struct *work)
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
> +}
> +
> +static void max17040_stop_work(void *data)
> +{
> +	struct max17040_chip *chip =3D data;
> +
> +	cancel_delayed_work_sync(&chip->work);
>  }
> =20
>  static irqreturn_t max17040_thread_handler(int id, void *dev)
>  {
>  	struct max17040_chip *chip =3D dev;
> -	struct i2c_client *client =3D chip->client;
> =20
> -	dev_warn(&client->dev, "IRQ: Alert battery low level");
> +	if (!(chip->data.has_soc_alert && max17040_handle_soc_alert(chip)))
> +		dev_warn(&chip->client->dev, "IRQ: Alert battery low level\n");
> +
>  	/* read registers */
> -	max17040_check_changes(chip->client);
> +	max17040_check_changes(chip);
> =20
>  	/* send uevent */
>  	power_supply_changed(chip->battery);
> =20
> -	/* reset alert bit */
> -	max17040_set_low_soc_alert(client, chip->low_soc_alert);
> +	/* reset low soc alert bit */
> +	max17040_set_low_soc_alert(chip, chip->low_soc_alert);
> =20
>  	return IRQ_HANDLED;
>  }
> =20
> -static int max17040_enable_alert_irq(struct max17040_chip *chip)
> +static int max17040_setup_irq(struct max17040_chip *chip)
>  {
>  	struct i2c_client *client =3D chip->client;
>  	unsigned int flags;
> @@ -256,6 +412,13 @@ static int max17040_enable_alert_irq(struct max17040=
_chip *chip)
>  	return ret;
>  }
> =20
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
> @@ -277,6 +440,8 @@ static int max17040_probe(struct i2c_client *client,
>  	struct i2c_adapter *adapter =3D client->adapter;
>  	struct power_supply_config psy_cfg =3D {};
>  	struct max17040_chip *chip;
> +	enum chip_id chip_id;
> +	bool enable_irq =3D false;
>  	int ret;
> =20
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
> @@ -287,38 +452,63 @@ static int max17040_probe(struct i2c_client *client,
>  		return -ENOMEM;
> =20
>  	chip->client =3D client;
> +	chip->regmap =3D devm_regmap_init_i2c(client, &max17040_regmap);
>  	chip->pdata =3D client->dev.platform_data;
> -	ret =3D max17040_get_of_data(chip);
> -	if (ret) {
> -		dev_err(&client->dev,
> -			"failed: low SOC alert OF data out of bounds\n");
> -		return ret;
> +	chip_id =3D (enum chip_id) id->driver_data;
> +	if (client->dev.of_node) {
> +		ret =3D max17040_get_of_data(chip);
> +		if (ret)
> +			return ret;
> +		chip_id =3D (enum chip_id) of_device_get_match_data(&client->dev);
>  	}
> +	chip->data =3D max17040_family[chip_id];
> =20
>  	i2c_set_clientdata(client, chip);
>  	psy_cfg.drv_data =3D chip;
> =20
> -	chip->battery =3D power_supply_register(&client->dev,
> -				&max17040_battery_desc, &psy_cfg);
> +	chip->battery =3D devm_power_supply_register(&client->dev,
> +					&max17040_battery_desc, &psy_cfg);
>  	if (IS_ERR(chip->battery)) {
>  		dev_err(&client->dev, "failed: power supply register\n");
>  		return PTR_ERR(chip->battery);
>  	}
> =20
> -	max17040_reset(client);
> -	max17040_get_version(client);
> +	if (!chip->quirk_skip_reset) {
> +		max17040_reset(chip);
> +	}
> +	max17040_get_version(chip);
> +	max17040_set_rcomp(chip, chip->rcomp);
> =20
>  	/* check interrupt */
> -	if (client->irq && of_device_is_compatible(client->dev.of_node,
> -						   "maxim,max77836-battery")) {
> -		ret =3D max17040_set_low_soc_alert(client, chip->low_soc_alert);
> +	if (client->irq && chip->data.has_low_soc_alert) {
> +		ret =3D max17040_set_low_soc_alert(chip, chip->low_soc_alert);
>  		if (ret) {
>  			dev_err(&client->dev,
>  				"Failed to set low SOC alert: err %d\n", ret);
>  			return ret;
>  		}
> +		enable_irq =3D true;
> +	}
> +
> +	if (client->irq && chip->data.has_soc_alert) {
> +		ret =3D max17040_set_soc_alert(chip, 1);
> +		if (ret) {
> +			dev_err(&client->dev,
> +				"Failed to set SOC alert: err %d\n", ret);
> +			return ret;
> +		}
> +		enable_irq =3D true;
> +	} else {
> +		/* soc alerts negate the need for polling */
> +		INIT_DEFERRABLE_WORK(&chip->work, max17040_work);
> +		ret =3D devm_add_action(&client->dev, max17040_stop_work, chip);
> +		if (ret)
> +			return ret;
> +		max17040_queue_work(chip);
> +	}
> =20
> -		ret =3D max17040_enable_alert_irq(chip);
> +	if (enable_irq) {
> +		ret =3D max17040_setup_irq(chip);
>  		if (ret) {
>  			client->irq =3D 0;
>  			dev_warn(&client->dev,
> @@ -326,19 +516,6 @@ static int max17040_probe(struct i2c_client *client,
>  		}
>  	}
> =20
> -	INIT_DEFERRABLE_WORK(&chip->work, max17040_work);
> -	queue_delayed_work(system_power_efficient_wq, &chip->work,
> -			   MAX17040_DELAY);
> -
> -	return 0;
> -}
> -
> -static int max17040_remove(struct i2c_client *client)
> -{
> -	struct max17040_chip *chip =3D i2c_get_clientdata(client);
> -
> -	power_supply_unregister(chip->battery);
> -	cancel_delayed_work(&chip->work);
>  	return 0;
>  }
> =20
> @@ -349,10 +526,13 @@ static int max17040_suspend(struct device *dev)
>  	struct i2c_client *client =3D to_i2c_client(dev);
>  	struct max17040_chip *chip =3D i2c_get_clientdata(client);
> =20
> -	cancel_delayed_work(&chip->work);
> -
>  	if (client->irq && device_may_wakeup(dev))
>  		enable_irq_wake(client->irq);
> +	if (client->irq && chip->data.has_soc_alert)
> +		// disable soc alert to prevent wakeup
> +		max17040_set_soc_alert(chip, 0);
> +	else
> +		cancel_delayed_work(&chip->work);
> =20
>  	return 0;
>  }
> @@ -362,11 +542,12 @@ static int max17040_resume(struct device *dev)
>  	struct i2c_client *client =3D to_i2c_client(dev);
>  	struct max17040_chip *chip =3D i2c_get_clientdata(client);
> =20
> -	queue_delayed_work(system_power_efficient_wq, &chip->work,
> -			   MAX17040_DELAY);
> -
>  	if (client->irq && device_may_wakeup(dev))
>  		disable_irq_wake(client->irq);
> +	if (client->irq && chip->data.has_soc_alert)
> +		max17040_set_soc_alert(chip, 1);
> +	else
> +		max17040_queue_work(chip);
> =20
>  	return 0;
>  }
> @@ -381,16 +562,30 @@ static SIMPLE_DEV_PM_OPS(max17040_pm_ops, max17040_=
suspend, max17040_resume);
>  #endif /* CONFIG_PM_SLEEP */
> =20
>  static const struct i2c_device_id max17040_id[] =3D {
> -	{ "max17040" },
> -	{ "max77836-battery" },
> -	{ }
> +	{ "max17040", ID_MAX17040 },
> +	{ "max17041", ID_MAX17041 },
> +	{ "max17043", ID_MAX17043 },
> +	{ "max77836-battery", ID_MAX17043 },
> +	{ "max17044", ID_MAX17044 },
> +	{ "max17048", ID_MAX17048 },
> +	{ "max17049", ID_MAX17049 },
> +	{ "max17058", ID_MAX17058 },
> +	{ "max17059", ID_MAX17059 },
> +	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(i2c, max17040_id);
> =20
>  static const struct of_device_id max17040_of_match[] =3D {
> -	{ .compatible =3D "maxim,max17040" },
> -	{ .compatible =3D "maxim,max77836-battery" },
> -	{ },
> +	{ .compatible =3D "maxim,max17040", .data =3D (void *) ID_MAX17040 },
> +	{ .compatible =3D "maxim,max17041", .data =3D (void *) ID_MAX17041 },
> +	{ .compatible =3D "maxim,max17043", .data =3D (void *) ID_MAX17043 },
> +	{ .compatible =3D "maxim,max77836-battery", .data =3D (void *) ID_MAX17=
043 },
> +	{ .compatible =3D "maxim,max17044", .data =3D (void *) ID_MAX17044 },
> +	{ .compatible =3D "maxim,max17048", .data =3D (void *) ID_MAX17048 },
> +	{ .compatible =3D "maxim,max17049", .data =3D (void *) ID_MAX17049 },
> +	{ .compatible =3D "maxim,max17058", .data =3D (void *) ID_MAX17058 },
> +	{ .compatible =3D "maxim,max17059", .data =3D (void *) ID_MAX17059 },
> +	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, max17040_of_match);
> =20
> @@ -401,7 +596,6 @@ static struct i2c_driver max17040_i2c_driver =3D {
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

--2fxo3kd4q4dxs5f5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7s5AQACgkQ2O7X88g7
+prTDRAAjjn9PG+xrqYgq5OEGwBqBu0NnUpozx9Sk1PxWTfu2jk9m7j1FuHpneBa
v3R9pbsnLwP2CVFQ7iImpDAuKoRDa871muyruC4fokjOfCPrzTHQC1w6yqeckGfY
2TNi4b9OGU8toYM5eEX6197IrzNEUms7u7dEZMgDAEAGE2NJWOun6A//J9PoR9m0
5H6r/4OsDbI9m0xNzqV99awkvB30HSOjFjlBcGnl14xk4bQjtzf4BYB0cjwS1XKu
MoUnT/gYo1fVNfSpvfddN5WYc6i+SAGwYzjqTfNuLi+mdwqCmPrn9qIo4fLywUsT
pgs8kZcrU6ri05fYaCPwIwJ73SYM+phWVDmzOnjSdrV1TJw/Nm83CL9pT+znrvmx
+8b+c0RWpRHsuiTYPI1SY9DgPWBXM+mQwrr3ivJN0tdAEuV8rWSTeEiNaugMM37s
ZZBPojVKBbEAdRqupYZo6bDR39VeW8uELI517EFvofS8Z/6MmVsKa5QiP7nGbWvh
nw54ReC0DMuHZBm2z1mlWK4Cscqfg7gllSHGJ78wr0AGwqo2C98gc6EiUhm6gn6W
obxIhCQ4xGyjY77CnLmJyxEs0xqbZ4uqUYC2WDwZqg3qT66Djwn7lHR8aLuCtVhS
quVLTv0xDI1bJpZp4aSBFO+uRn67vf84Dc5xNKS7uYXJ5mIdxvo=
=4jDm
-----END PGP SIGNATURE-----

--2fxo3kd4q4dxs5f5--
