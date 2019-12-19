Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8D1512592B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 02:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLSBWm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 20:22:42 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39516 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLSBWm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 20:22:42 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B7DBC292930
Received: by earth.universe (Postfix, from userid 1000)
        id 2B2443C0C7B; Thu, 19 Dec 2019 02:22:37 +0100 (CET)
Date:   Thu, 19 Dec 2019 02:22:37 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/7] power: supply: sbs-battery: fix CAPACITY_MODE bit
 naming
Message-ID: <20191219012237.nhif6c5bubfvhp3v@earth.universe>
References: <20191101190705.13393-1-jeff.dagenais@gmail.com>
 <20191101190705.13393-5-jeff.dagenais@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zj3uzes423yqjwny"
Content-Disposition: inline
In-Reply-To: <20191101190705.13393-5-jeff.dagenais@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zj3uzes423yqjwny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 01, 2019 at 03:07:03PM -0400, Jean-Francois Dagenais wrote:
> "Battery mode" is the name of the register, the bit manipulated by this
> code is "CAPACITY_MODE" (Smart Battery System Specifications).
>=20
> Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/sbs-battery.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index f92b98d900d2..46c89dd05f46 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -46,10 +46,10 @@ enum {
> =20
>  /* Battery Mode defines */
>  #define BATTERY_MODE_OFFSET		0x03
> -#define BATTERY_MODE_MASK		0x8000
> -enum sbs_battery_mode {
> -	BATTERY_MODE_AMPS =3D 0,
> -	BATTERY_MODE_WATTS =3D 0x8000
> +#define BATTERY_MODE_CAPACITY_MASK	(1<<15)
> +enum sbs_capacity_mode {
> +	CAPACITY_MODE_AMPS =3D 0,
> +	CAPACITY_MODE_WATTS =3D BATTERY_MODE_CAPACITY_MASK
>  };
> =20
>  /* manufacturer access defines */
> @@ -513,8 +513,8 @@ static void  sbs_unit_adjustment(struct i2c_client *c=
lient,
>  	}
>  }
> =20
> -static enum sbs_battery_mode sbs_set_battery_mode(struct i2c_client *cli=
ent,
> -	enum sbs_battery_mode mode)
> +static enum sbs_capacity_mode sbs_set_capacity_mode(struct i2c_client *c=
lient,
> +	enum sbs_capacity_mode mode)
>  {
>  	int ret, original_val;
> =20
> @@ -522,13 +522,13 @@ static enum sbs_battery_mode sbs_set_battery_mode(s=
truct i2c_client *client,
>  	if (original_val < 0)
>  		return original_val;
> =20
> -	if ((original_val & BATTERY_MODE_MASK) =3D=3D mode)
> +	if ((original_val & BATTERY_MODE_CAPACITY_MASK) =3D=3D mode)
>  		return mode;
> =20
> -	if (mode =3D=3D BATTERY_MODE_AMPS)
> -		ret =3D original_val & ~BATTERY_MODE_MASK;
> +	if (mode =3D=3D CAPACITY_MODE_AMPS)
> +		ret =3D original_val & ~BATTERY_MODE_CAPACITY_MASK;
>  	else
> -		ret =3D original_val | BATTERY_MODE_MASK;
> +		ret =3D original_val | BATTERY_MODE_CAPACITY_MASK;
> =20
>  	ret =3D sbs_write_word_data(client, BATTERY_MODE_OFFSET, ret);
>  	if (ret < 0)
> @@ -536,7 +536,7 @@ static enum sbs_battery_mode sbs_set_battery_mode(str=
uct i2c_client *client,
> =20
>  	usleep_range(1000, 2000);
> =20
> -	return original_val & BATTERY_MODE_MASK;
> +	return original_val & BATTERY_MODE_CAPACITY_MASK;
>  }
> =20
>  static int sbs_get_battery_capacity(struct i2c_client *client,
> @@ -544,12 +544,12 @@ static int sbs_get_battery_capacity(struct i2c_clie=
nt *client,
>  	union power_supply_propval *val)
>  {
>  	s32 ret;
> -	enum sbs_battery_mode mode =3D BATTERY_MODE_WATTS;
> +	enum sbs_capacity_mode mode =3D CAPACITY_MODE_WATTS;
> =20
>  	if (power_supply_is_amp_property(psp))
> -		mode =3D BATTERY_MODE_AMPS;
> +		mode =3D CAPACITY_MODE_AMPS;
> =20
> -	mode =3D sbs_set_battery_mode(client, mode);
> +	mode =3D sbs_set_capacity_mode(client, mode);
>  	if (mode < 0)
>  		return mode;
> =20
> @@ -559,7 +559,7 @@ static int sbs_get_battery_capacity(struct i2c_client=
 *client,
> =20
>  	val->intval =3D ret;
> =20
> -	ret =3D sbs_set_battery_mode(client, mode);
> +	ret =3D sbs_set_capacity_mode(client, mode);
>  	if (ret < 0)
>  		return ret;
> =20
> --=20
> 2.23.0
>=20

--zj3uzes423yqjwny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl360N0ACgkQ2O7X88g7
+po25w//alqSVDkFBQpfg9zHSQLltupcVa2HXf7cyc+7uaEGksR8HpEM3xPsD8Yo
1FlxiGZc+xQa7qeTbIwLkXxgk6U2jJ+UQrzGvpu3fWaNbUMfb76BOsPevcu5kXHG
Msfxbkb8gIiMn8Jdzu41zyE7PjoyHJJ50qz18e+N0blGMZzsjuSMYGPpy6xvQnk9
kvUSb+GFvgB31/EUDK5Euu9jynAs+DJP7u2afWljk7W3jmfpPZ4QYZh+FjvJCit9
queWmDgSonWnlnjow9QiCWG2G+NsWY63R9nS73gzFgWOL1wRo0WNTqsyGqqEwdfs
dJ00vKv15n1B6QxvsJEoK3HKVPdFnNY+RMDqGHVDLmnT1KbWeXRqWADhElTpjGWb
qUIEF6PPScyeei7aQapkQWVVqmTzh8FfiSqFciPi1/kIMXztQY57pwBQaOmxIQv2
n9CzAXs6X2CNUBJ6BGGZO6XiY1DYx/3yxv4zJpAfuDc6B6JFFupRTUtHokLh+kQB
YLTZ3yiF7TfWmEBZUJkJSad20TSnz3czqmyuZk+nDYvVNYEoAhtRbXohSunBmecl
6TuB67/9+ya+IYPJqOEIThqNgfGjx8+VCm927aBWcSuiEov4036txj1L3mbQ0cWI
U/uFix+YyxtpWIKENnQDmIWLh6ONQCVQP3mBxBTiHPb9EEAcpQY=
=8JAr
-----END PGP SIGNATURE-----

--zj3uzes423yqjwny--
