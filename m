Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E31639A9B3
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 20:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhFCSFf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 14:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhFCSFf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 14:05:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B86C06174A;
        Thu,  3 Jun 2021 11:03:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 25D441F43475
Received: by earth.universe (Postfix, from userid 1000)
        id CA0133C0C95; Thu,  3 Jun 2021 20:03:46 +0200 (CEST)
Date:   Thu, 3 Jun 2021 20:03:46 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-pm@vger.kernel.org, Hsinyi Wang <hsinyi@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] power: supply: sbs-battery: cache constant string
 properties
Message-ID: <20210603180346.omjexgprlejga34n@earth.universe>
References: <20210526191600.v4.1.I446881dabe094fff375847593be87ec2624f587f@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ay5jp6hivwzdl3yk"
Content-Disposition: inline
In-Reply-To: <20210526191600.v4.1.I446881dabe094fff375847593be87ec2624f587f@changeid>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ay5jp6hivwzdl3yk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 26, 2021 at 07:16:04PM +0800, Ikjoon Jang wrote:
> Currently sbs-battery supports three string properties -
> manufacturer, model_name, and chemistry. Buffers for those
> properties are currently defined as global variables.
>=20
> This patch moves those global variables into struct sbs_info
> and cache/reuse them as they are all constant values.
>=20
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
>=20
> ---

Thanks, queued.

-- Sebastian

>=20
> Changes in v4:
> - Fix a build error from patch manipulation
>=20
> Changes in v3:
> - Invalidate cached properties upon update_presence(!present)
> - Fix a bug in reading chemistry
>=20
> Changes in v2:
> - change function name of sbs_get_battery_string_property()
>   to sbs_get_constant_string()
> - use cached string properties
> - use cached technology value in sbs_get_chemistry()
>=20
>  drivers/power/supply/sbs-battery.c | 153 ++++++++++++++++++-----------
>  1 file changed, 95 insertions(+), 58 deletions(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index b6a538ebb378..b6ee3a14576f 100644
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
> @@ -201,11 +209,32 @@ struct sbs_info {
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
> +static void sbs_invalidate_cached_props(struct sbs_info *chip)
> +{
> +	int i =3D 0;
> +
> +	chip->technology =3D -1;
> +
> +	for (i =3D 0; i < NR_STRING_BUFFERS; i++)
> +		chip->strings[i][0] =3D 0;
> +}
> +
>  static bool force_load;
> =20
>  static int sbs_read_word_data(struct i2c_client *client, u8 address);
> @@ -243,6 +272,7 @@ static int sbs_update_presence(struct sbs_info *chip,=
 bool is_present)
>  		chip->is_present =3D false;
>  		/* Disable PEC when no device is present */
>  		client->flags &=3D ~I2C_CLIENT_PEC;
> +		sbs_invalidate_cached_props(chip);
>  		return 0;
>  	}
> =20
> @@ -639,17 +669,45 @@ static int sbs_get_battery_property(struct i2c_clie=
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
> =20
> -	ret =3D sbs_read_string_data(client, sbs_data[reg_offset].addr, val);
> +	for (count =3D 0; count < ARRAY_SIZE(sbs_data); count++)
> +		if (psp =3D=3D sbs_data[count].psp)
> +			return count;
> =20
> -	if (ret < 0)
> -		return ret;
> +	dev_warn(&client->dev,
> +		"%s: Invalid Property - %d\n", __func__, psp);
> =20
> -	return 0;
> +	return -EINVAL;
> +}
> +
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
> @@ -772,48 +830,36 @@ static int sbs_get_battery_serial_number(struct i2c=
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
> +	if (chip->technology !=3D -1) {
> +		val->intval =3D chip->technology;
> +		return 0;
> +	}
> =20
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
> +
> +	if (chip->technology =3D=3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN)
> +		dev_warn(&chip->client->dev, "Unknown chemistry: %s\n", chemistry);
> =20
> -	if (val->intval =3D=3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN)
> -		dev_warn(&client->dev, "Unknown chemistry: %s\n", chemistry);
> +	val->intval =3D chip->technology;
> =20
>  	return 0;
>  }
> @@ -857,6 +903,7 @@ static int sbs_get_property(struct power_supply *psy,
>  	int ret =3D 0;
>  	struct sbs_info *chip =3D power_supply_get_drvdata(psy);
>  	struct i2c_client *client =3D chip->client;
> +	const char *str;
> =20
>  	if (chip->gpio_detect) {
>  		ret =3D gpiod_get_value_cansleep(chip->gpio_detect);
> @@ -882,7 +929,7 @@ static int sbs_get_property(struct power_supply *psy,
>  		break;
> =20
>  	case POWER_SUPPLY_PROP_TECHNOLOGY:
> -		ret =3D sbs_get_chemistry(client, val);
> +		ret =3D sbs_get_chemistry(chip, val);
>  		if (ret < 0)
>  			break;
> =20
> @@ -934,23 +981,12 @@ static int sbs_get_property(struct power_supply *ps=
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
> @@ -1097,6 +1133,7 @@ static int sbs_probe(struct i2c_client *client)
>  	psy_cfg.of_node =3D client->dev.of_node;
>  	psy_cfg.drv_data =3D chip;
>  	chip->last_state =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +	sbs_invalidate_cached_props(chip);
>  	mutex_init(&chip->mode_lock);
> =20
>  	/* use pdata if available, fall back to DT properties,
> --=20
> 2.31.1.818.g46aad6cb9e-goog
>=20

--ay5jp6hivwzdl3yk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC5GX0ACgkQ2O7X88g7
+pr4vQ//dvSIqkq9BfbTARyzgULjqVfzN1SL1fT+MFd/DaWCnVhuluehEg5nhpns
oce9ZQwdYj6z7KGFw/gBSMfiEzGs1OampOUA4lOE7q0j+VV7bEKquWBkvN/AfZWR
a/US7WpMPn4k0axjCPbFJYGgQ57scHapiDDPahxts1ZuoiKBLclC43jqdRWeqtKV
Xj8IliR0k3qKxrKv2XRWSw7VqWLl2ZK0U3MvH1MaBM0tMXdFqn8FI9roGEHaYC2Q
Uh0m9G4eMEe/rUj0W8Y7HeTSJxPNcQygR/vwEM1XxOULkAfqO9fRvpeb8Lo4U2r1
u7hT3z+rxN3ZqBPIgmZXdRW0PEk7bIpCFpLyqR0KE4mGrh1tXU5aTYMgMq5PR26L
oDDQpGR1kQxP6q69EXKX1D5Qavv+HAHnrSWbqJnEAcGkiFGjVhXdu3Ainmi+4kBn
CVIhhFHSb6Zz3h5fOG3fjnz+bVDRuj4ttP+UOFCG6EDwfTB8FyxyqLwoVFCHgVDg
jwXbxtoqRRJsdMwfO7EnXt/GIsjZh8A5twLo+DPxSmslqsDyxw8dhm/tbCHRNmfw
V3vnv0h5/fTgespMoUfl8ZgJICV7p5dv9n5hj78djEwla+qcMeP5uXl4EJwF7uXN
qEGlfPpW3mm1/vlVy9SJumDIJFo7d6e2TldQbYBj05ap4TESOJI=
=RzpA
-----END PGP SIGNATURE-----

--ay5jp6hivwzdl3yk--
