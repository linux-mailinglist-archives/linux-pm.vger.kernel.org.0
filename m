Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2334198B4
	for <lists+linux-pm@lfdr.de>; Mon, 27 Sep 2021 18:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbhI0QQy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Sep 2021 12:16:54 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54778 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbhI0QQx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Sep 2021 12:16:53 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A45471F42FE7
Received: by earth.universe (Postfix, from userid 1000)
        id BE5F23C0CA8; Mon, 27 Sep 2021 18:15:11 +0200 (CEST)
Date:   Mon, 27 Sep 2021 18:15:11 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Bruno Meneguele <bruno.meneguele@smartgreen.net>
Cc:     robh+dt@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] power: supply: bq24735: add watchdog timer delay
 support
Message-ID: <20210927161511.iwu453xceymyviwe@earth.universe>
References: <20210816165245.40416-1-bruno.meneguele@smartgreen.net>
 <20210816165245.40416-2-bruno.meneguele@smartgreen.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3j7coxnatqm6aptm"
Content-Disposition: inline
In-Reply-To: <20210816165245.40416-2-bruno.meneguele@smartgreen.net>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3j7coxnatqm6aptm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 16, 2021 at 01:52:44PM -0300, Bruno Meneguele wrote:
> The BQ24735 charger allows the user to set the watchdog timer delay betwe=
en
> two consecutives ChargeCurrent or ChargeVoltage command writes, if the IC
> doesn't receive any command before the timeout happens, the charge is tur=
ned
> off.
>=20
> This patch adds the support to the user to change the default/POR value w=
ith
> four discrete values:
>=20
>   0 - disabled
>   1 - enabled, 44 sec
>   2 - enabled, 88 sec
>   3 - enabled, 175 sec (default at POR)
>=20
> These are the options supported in the ChargeOptions register bits 13&14.
>=20
> Also, this patch make one additional check when poll-interval is set by t=
he
> user: if the interval set is greater than the WDT timeout it'll fail duri=
ng
> the probe stage, preventing the user to set non-compatible values between
> the two options.
>=20
> Signed-off-by: Bruno Meneguele <bruno.meneguele@smartgreen.net>
> ---
> Changelog:
>   v3 - check wdt_timeout for the maximum and minimum available values=20
>=20
>  drivers/power/supply/bq24735-charger.c | 54 ++++++++++++++++++++++++++
>  include/linux/power/bq24735-charger.h  |  1 +
>  2 files changed, 55 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/suppl=
y/bq24735-charger.c
> index 3ce36d09c017..7e8d0c23df9a 100644
> --- a/drivers/power/supply/bq24735-charger.c
> +++ b/drivers/power/supply/bq24735-charger.c
> @@ -45,6 +45,8 @@
>  /* ChargeOptions bits of interest */
>  #define BQ24735_CHARGE_OPT_CHG_DISABLE	(1 << 0)
>  #define BQ24735_CHARGE_OPT_AC_PRESENT	(1 << 4)
> +#define BQ24735_CHARGE_OPT_WDT_OFFSET	13
> +#define BQ24735_CHARGE_OPT_WDT		(3 << BQ24735_CHARGE_OPT_WDT_OFFSET)
> =20
>  struct bq24735 {
>  	struct power_supply		*charger;
> @@ -156,6 +158,20 @@ static int bq24735_config_charger(struct bq24735 *ch=
arger)
>  		}
>  	}
> =20
> +	if (pdata->wdt_timeout >=3D 0 && pdata->wdt_timeout <=3D 3) {

wdt_timeout is unsigned and can't be smaller than 0.

> +		value =3D pdata->wdt_timeout;
> +
> +		ret =3D bq24735_update_word(charger->client, BQ24735_CHARGE_OPT,
> +					  BQ24735_CHARGE_OPT_WDT,
> +					  (value << BQ24735_CHARGE_OPT_WDT_OFFSET));
> +		if (ret < 0) {
> +			dev_err(&charger->client->dev,
> +				"Failed to write watchdog timer: %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -347,6 +363,23 @@ static struct bq24735_platform *bq24735_parse_dt_dat=
a(struct i2c_client *client)
>  	if (!ret)
>  		pdata->input_current =3D val;
> =20
> +	ret =3D of_property_read_u32(np, "ti,wdt-timeout", &val);
> +	if (!ret) {
> +		if (val >=3D 0 && val <=3D 3) {

wdt_timeout is unsigned and can't be smaller than 0.

> +			pdata->wdt_timeout =3D val;
> +		} else {
> +			dev_warn(&client->dev,
> +				 "Invalid value for ti,wdt-timeout: %d",
> +				 val);
> +		}
> +	} else {
> +		/* Since 0 is a valid value (disabled), set something
> +		 * greater than the maximum limit accepted from the user to
> +		 * represent the "no change" state. */
> +		pdata->wdt_timeout =3D 4;
> +	}
> +
> +
>  	pdata->ext_control =3D of_property_read_bool(np, "ti,external-control");
> =20
>  	return pdata;
> @@ -476,6 +509,27 @@ static int bq24735_charger_probe(struct i2c_client *=
client,
>  			return 0;
>  		if (!charger->poll_interval)
>  			return 0;
> +		if (charger->pdata->wdt_timeout > 0) {
> +			int wdt_ms;
> +
> +			switch (charger->pdata->wdt_timeout) {
> +			case 1:
> +				wdt_ms =3D 44000;
> +				break;
> +			case 2:
> +				wdt_ms =3D 88000;
> +				break;
> +			case 3:
> +				wdt_ms =3D 175000;
> +				break;
> +			}

wdt_ms is not initialized when wdt_timeout is not 1-3 resulting in undefine=
d behaviour.
Also please create constants for the magic numbers, e.g.

#define BQ24735_WDT_OFF                 0
#define BQ24735_WDT_44_SEC              1
#define BQ24735_WDT_88_SEC              2
#define BQ24735_WDT_175_SEC             3
#define BQ24735_WDT_INVALID             4

and use them throughout the code.

-- Sebastian

> +
> +			if (charger->poll_interval > wdt_ms) {
> +				dev_err(&client->dev,
> +					"Poll interval greater than WDT timeout\n");
> +				return -EINVAL;
> +			}
> +		}
> =20
>  		ret =3D devm_delayed_work_autocancel(&client->dev, &charger->poll,
>  						   bq24735_poll);
> diff --git a/include/linux/power/bq24735-charger.h b/include/linux/power/=
bq24735-charger.h
> index 321dd009ce66..ce5a030ca111 100644
> --- a/include/linux/power/bq24735-charger.h
> +++ b/include/linux/power/bq24735-charger.h
> @@ -12,6 +12,7 @@ struct bq24735_platform {
>  	uint32_t charge_current;
>  	uint32_t charge_voltage;
>  	uint32_t input_current;
> +	uint32_t wdt_timeout;
> =20
>  	const char *name;
> =20
> --=20
> 2.31.1
>=20

--3j7coxnatqm6aptm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFR7gsACgkQ2O7X88g7
+pp3/w/+OT/pSW7AY6i6+vVAWn4uCbW1wPUxdnqOiZ6DPLywpVeaEttzyFltgTD3
P8AjUlQMulOM4HCPqqsx/jKFSpKYbfeLkKDiiilRhHJfn2/4vLt3Pu2qLhCS5Bpo
yfghI5Jnlw0OavMbpooqCpZNCFhO/DQPQo3zmJHe7CcYidlddtiddaj3LKCgLPgp
DgS8+scC/SuEKcAv8mJwz0EQAQyGgahgrCI0RvBgKeORDkZMpz/505j9QByVdW5T
JHQdt/fseSMR11wvbXDfpl1/D69nLp6uIYH4Q6r/q2rlPsHeLDFt7t4gxeOjnNNS
ra0fGX8NQrCbmPjk0CKuQeQv5aPNtLti/i7/X6uRrEBF0F4QDcMUl5o9+IsVB6Gw
ws/YE5BOek//htY1DTbrDBdHY1NuVaKxnZPohDLUfkOUXYkTkMqPdz3w4pq8HfTp
m1Q1vcLLwZOFYlLy48g15i4W/tNzGcXZCtXpHM5LixTPGGS3hckC2vfxATqAiz0R
SL/4nz2nCptVj+E0jV6PcEZs7beWQVIo8Bqpw5pJnB2e7Aw5rlEzqReDRsmggdI8
XOQkfIJNtWEjzv+K0aqyIbd0yEbzQ8Ks9YuzTN68DByiA1oTcFOSOrImZ1DTRqb9
pXnahalIf1YwZZIgzZeUhe8ujQk1pTHC6g2zRL0XaooiNhiqmHM=
=ApGI
-----END PGP SIGNATURE-----

--3j7coxnatqm6aptm--
