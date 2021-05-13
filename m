Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C701937F62A
	for <lists+linux-pm@lfdr.de>; Thu, 13 May 2021 13:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhEMLCM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 May 2021 07:02:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39298 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbhEMLCA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 May 2021 07:02:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8A6991F4281B
Received: by earth.universe (Postfix, from userid 1000)
        id 568DE3C0C95; Thu, 13 May 2021 13:00:45 +0200 (CEST)
Date:   Thu, 13 May 2021 13:00:45 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-pm@vger.kernel.org, Hsinyi Wang <hsinyi@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] power: supply: sbs-battery: cache constant
 string properties
Message-ID: <20210513110045.5yrootk4bv6u6lya@earth.universe>
References: <20210513020308.4011440-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e52rk7gjjtm66sun"
Content-Disposition: inline
In-Reply-To: <20210513020308.4011440-1-ikjn@chromium.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--e52rk7gjjtm66sun
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 13, 2021 at 10:03:08AM +0800, Ikjoon Jang wrote:
> Currently sbs-battery supports three string properties -
> manufacturer, model_name, and chemistry. Buffers for those
> properties are currently defined as global variables.
>=20
> This patch moves those global variables into struct sbs_info
> and cache/reuse them as they are all constant values.

Thanks, that's a nice cleanup. I have a two comments, though.
Please find them inline.

> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
>=20
> ---
> Resend v2: Adds Tested-by, escape from v1 mail thread.
>
> Changes in v2:
> - change function name of sbs_get_battery_string_property()
>   to sbs_get_constant_string()
> - use cached string properties
> - use cached technology value in sbs_get_chemistry()
>=20
>  drivers/power/supply/sbs-battery.c | 140 +++++++++++++++++------------
>  1 file changed, 82 insertions(+), 58 deletions(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index 4bf92831cb06..414de9bc47bf 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -188,6 +188,14 @@ static const enum power_supply_property sbs_properti=
es[] =3D {
>  /* Supports special manufacturer commands from TI BQ20Z65 and BQ20Z75 IC=
=2E */
>  #define SBS_FLAGS_TI_BQ20ZX5		BIT(0)
> =20
> +static const enum power_supply_property string_properties[] =3D {
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +};
> +
> +#define NR_STRING_BUFFERS	ARRAY_SIZE(string_properties)
> +
>  struct sbs_info {
>  	struct i2c_client		*client;
>  	struct power_supply		*power_supply;
> @@ -201,11 +209,22 @@ struct sbs_info {
>  	struct delayed_work		work;
>  	struct mutex			mode_lock;
>  	u32				flags;
> +	int				technology;
> +	char				strings[NR_STRING_BUFFERS][I2C_SMBUS_BLOCK_MAX + 1];
>  };
> =20
> -static char model_name[I2C_SMBUS_BLOCK_MAX + 1];
> -static char manufacturer[I2C_SMBUS_BLOCK_MAX + 1];
> -static char chemistry[I2C_SMBUS_BLOCK_MAX + 1];
> +static char *sbs_get_string_buf(struct sbs_info *chip,
> +				enum power_supply_property psp)
> +{
> +	int i =3D 0;
> +
> +	for (i =3D 0; i < NR_STRING_BUFFERS; i++)
> +		if (string_properties[i] =3D=3D psp)
> +			return chip->strings[i];
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
>  static bool force_load;
> =20
>  static int sbs_read_word_data(struct i2c_client *client, u8 address);
> @@ -639,17 +658,45 @@ static int sbs_get_battery_property(struct i2c_clie=
nt *client,
>  	return 0;
>  }
> =20
> -static int sbs_get_battery_string_property(struct i2c_client *client,
> -	int reg_offset, enum power_supply_property psp, char *val)
> +static int sbs_get_property_index(struct i2c_client *client,
> +	enum power_supply_property psp)
>  {
> -	s32 ret;
> +	int count;
> +
> +	for (count =3D 0; count < ARRAY_SIZE(sbs_data); count++)
> +		if (psp =3D=3D sbs_data[count].psp)
> +			return count;
> =20
> -	ret =3D sbs_read_string_data(client, sbs_data[reg_offset].addr, val);
> +	dev_warn(&client->dev,
> +		"%s: Invalid Property - %d\n", __func__, psp);
> =20
> -	if (ret < 0)
> -		return ret;
> +	return -EINVAL;
> +}
> =20
> -	return 0;
> +static const char *sbs_get_constant_string(struct sbs_info *chip,
> +			enum power_supply_property psp)
> +{
> +	int ret;
> +	char *buf;
> +	u8 addr;
> +
> +	buf =3D sbs_get_string_buf(chip, psp);
> +	if (IS_ERR(buf))
> +		return buf;
> +
> +	if (!buf[0]) {
> +		ret =3D sbs_get_property_index(chip->client, psp);
> +		if (ret < 0)
> +			return ERR_PTR(ret);
> +
> +		addr =3D sbs_data[ret].addr;
> +
> +		ret =3D sbs_read_string_data(chip->client, addr, buf);
> +		if (ret < 0)
> +			return ERR_PTR(ret);
> +	}
> +
> +	return buf;
>  }
> =20
>  static void  sbs_unit_adjustment(struct i2c_client *client,
> @@ -772,48 +819,34 @@ static int sbs_get_battery_serial_number(struct i2c=
_client *client,
>  	return 0;
>  }
> =20
> -static int sbs_get_property_index(struct i2c_client *client,
> -	enum power_supply_property psp)
> -{
> -	int count;
> -	for (count =3D 0; count < ARRAY_SIZE(sbs_data); count++)
> -		if (psp =3D=3D sbs_data[count].psp)
> -			return count;
> -
> -	dev_warn(&client->dev,
> -		"%s: Invalid Property - %d\n", __func__, psp);
> -
> -	return -EINVAL;
> -}
> -
> -static int sbs_get_chemistry(struct i2c_client *client,
> +static int sbs_get_chemistry(struct sbs_info *chip,
>  		union power_supply_propval *val)
>  {
> -	enum power_supply_property psp =3D POWER_SUPPLY_PROP_TECHNOLOGY;
> -	int ret;
> +	const char *chemistry;
> =20
> -	ret =3D sbs_get_property_index(client, psp);
> -	if (ret < 0)
> -		return ret;
> +	if (chip->technology >=3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN)
> +		return chip->technology;

This obviously must look like this:

val->intval =3D chip->technology;
return 0;

With your code you should only see correct technology for the
first read of the technology property. How did you test your
changes?

> -	ret =3D sbs_get_battery_string_property(client, ret, psp,
> -					      chemistry);
> -	if (ret < 0)
> -		return ret;
> +	chemistry =3D sbs_get_constant_string(chip, POWER_SUPPLY_PROP_TECHNOLOG=
Y);
> +
> +	if (IS_ERR(chemistry))
> +		return PTR_ERR(chemistry);
> =20
>  	if (!strncasecmp(chemistry, "LION", 4))
> -		val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;
> +		chip->technology =3D POWER_SUPPLY_TECHNOLOGY_LION;
>  	else if (!strncasecmp(chemistry, "LiP", 3))
> -		val->intval =3D POWER_SUPPLY_TECHNOLOGY_LIPO;
> +		chip->technology =3D POWER_SUPPLY_TECHNOLOGY_LIPO;
>  	else if (!strncasecmp(chemistry, "NiCd", 4))
> -		val->intval =3D POWER_SUPPLY_TECHNOLOGY_NiCd;
> +		chip->technology =3D POWER_SUPPLY_TECHNOLOGY_NiCd;
>  	else if (!strncasecmp(chemistry, "NiMH", 4))
> -		val->intval =3D POWER_SUPPLY_TECHNOLOGY_NiMH;
> +		chip->technology =3D POWER_SUPPLY_TECHNOLOGY_NiMH;
>  	else
> -		val->intval =3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
> +		chip->technology =3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
> =20
> -	if (val->intval =3D=3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN)
> -		dev_warn(&client->dev, "Unknown chemistry: %s\n", chemistry);
> +	if (chip->technology =3D=3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN)
> +		dev_warn(&chip->client->dev, "Unknown chemistry: %s\n", chemistry);
> +
> +	val->intval =3D chip->technology;
> =20
>  	return 0;
>  }
> @@ -857,6 +890,7 @@ static int sbs_get_property(struct power_supply *psy,
>  	int ret =3D 0;
>  	struct sbs_info *chip =3D power_supply_get_drvdata(psy);
>  	struct i2c_client *client =3D chip->client;
> +	const char *str;
> =20
>  	if (chip->gpio_detect) {
>  		ret =3D gpiod_get_value_cansleep(chip->gpio_detect);
> @@ -882,7 +916,7 @@ static int sbs_get_property(struct power_supply *psy,
>  		break;
> =20
>  	case POWER_SUPPLY_PROP_TECHNOLOGY:
> -		ret =3D sbs_get_chemistry(client, val);
> +		ret =3D sbs_get_chemistry(chip, val);
>  		if (ret < 0)
>  			break;
> =20
> @@ -934,23 +968,12 @@ static int sbs_get_property(struct power_supply *ps=
y,
>  		break;
> =20
>  	case POWER_SUPPLY_PROP_MODEL_NAME:
> -		ret =3D sbs_get_property_index(client, psp);
> -		if (ret < 0)
> -			break;
> -
> -		ret =3D sbs_get_battery_string_property(client, ret, psp,
> -						      model_name);
> -		val->strval =3D model_name;
> -		break;
> -
>  	case POWER_SUPPLY_PROP_MANUFACTURER:
> -		ret =3D sbs_get_property_index(client, psp);
> -		if (ret < 0)
> -			break;
> -
> -		ret =3D sbs_get_battery_string_property(client, ret, psp,
> -						      manufacturer);
> -		val->strval =3D manufacturer;
> +		str =3D sbs_get_constant_string(chip, psp);
> +		if (IS_ERR(str))
> +			ret =3D PTR_ERR(str);
> +		else
> +			val->strval =3D str;
>  		break;
> =20
>  	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
> @@ -1097,6 +1120,7 @@ static int sbs_probe(struct i2c_client *client)
>  	psy_cfg.of_node =3D client->dev.of_node;
>  	psy_cfg.drv_data =3D chip;
>  	chip->last_state =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +	chip->technology =3D -1;
>  	mutex_init(&chip->mode_lock);
> =20
>  	/* use pdata if available, fall back to DT properties,

You need to invalidate the cached values when battery is unplugged,
since a different battery may be attached afterwards.

-- Sebastian

--e52rk7gjjtm66sun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmCdBtUACgkQ2O7X88g7
+po0Xw//WddHrroJTH34k47MgkflCohB3ydiNCxPTXh0b16pXr3G9i0v+GHk8rTm
fBu8S1Il0+pSxzrtVZl++eZM4xFyXRCTi0Q1ILdv9pJRqNy7BqioPn7W+NKSqaSA
PFq7WtkPVq6Zu3KKfnWgqPpiwORsZWKLJ7owLHOsmU3btvxAP31ijf1Mhw6/XtvG
MKTBYGrexh7djYf/UDNodKofzL+jDpBPf7GG/Mqbm8+Kbw3/7p4Fz9nma2sWajIT
iAWsmR/OoHObfjxp3ZIJ+4RqOaBuYp4Ax4RFjkPGNck1OElKgrE4JIrXmrNL3cmj
qPBjLuspzCh4GaMW6HBqLWVCQjn00RnmJwNIzlRdblN/fVQ5kD9fHMTrFEBNkZm7
eygQ1q2SQhQOtrjJ9J2oBKjVPeMKae4sQLGqNvMiR9L4h9ezZzLVq1uiPPYIxp4Y
xTjDqZA+6WOs5ZO4Xs1fUL9sIBklVvMBh9QMK5Zx6AGOOt3cVg4onFZjhJA3rvI1
fXXHKe3+gaIh9t7TyW7NfMYhh9MK7R0F/i0lz/FsNOIfuBtNCe3LIFXn2OJNuz0A
UCdv0LQMPOJm/z4UmpWUSMJqVUEf+TIU3x2BaV3yO5LcvlpxqiaXBeiPTMe8TNSU
YKAbGjBSBjpmh/SCZ02YlXVlt1AkixjBlyLDGZTF2vq0TKi9Khg=
=/qh8
-----END PGP SIGNATURE-----

--e52rk7gjjtm66sun--
