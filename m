Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D641C2EFD
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 22:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgECUCA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 16:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgECUCA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2020 16:02:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCF3C061A0E;
        Sun,  3 May 2020 13:01:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A56FC2A0113
Received: by earth.universe (Postfix, from userid 1000)
        id 78B083C08C7; Sun,  3 May 2020 22:01:55 +0200 (CEST)
Date:   Sun, 3 May 2020 22:01:55 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 05/11] power: bq25890: fix ADC mode configuration
Message-ID: <20200503200155.zjimaux5dfonwjdw@earth.universe>
References: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
 <c3b8fac36e4ed2b45925107417728591725d99a1.1588517058.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nw6cs6bh4jrtlkv2"
Content-Disposition: inline
In-Reply-To: <c3b8fac36e4ed2b45925107417728591725d99a1.1588517058.git.mirq-linux@rere.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--nw6cs6bh4jrtlkv2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 03, 2020 at 05:21:11PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Datasheet describes two modes for reading ADC measurements:
> 1. continuous, 1 Hz - enabled and started by CONV_RATE bit
> 2. one-shot - triggered by CONV_START bit
>=20
> In continuous mode, CONV_START is read-only and signifies an ongoing
> conversion.
>=20
> Change the code to follow the datasheet and really disable continuous
> mode for power saving.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/power/supply/bq25890_charger.c | 33 ++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index 9339e216651f..3b02fa80aedd 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -126,6 +126,7 @@ static const struct regmap_access_table bq25890_write=
able_regs =3D {
> =20
>  static const struct regmap_range bq25890_volatile_reg_ranges[] =3D {
>  	regmap_reg_range(0x00, 0x00),
> +	regmap_reg_range(0x02, 0x02),
>  	regmap_reg_range(0x09, 0x09),
>  	regmap_reg_range(0x0b, 0x14),
>  };
> @@ -374,18 +375,40 @@ enum bq25890_chrg_fault {
>  	CHRG_FAULT_TIMER_EXPIRED,
>  };
> =20
> +static bool bq25890_is_adc_property(enum power_supply_property psp)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_NOW:
> +	case POWER_SUPPLY_PROP_OUTPUT_VOLTAGE_NOW:

^^^ does not compile without your other patchset, so not applied.

When you send a new version, please Cc some of the recent
contributors to bq25890_charger.c, so that they have a chance
to test the changes with their setup:

Angus Ainslie (Purism) <angus@akkea.ca>
Yauhen Kharuzhy <jekhor@gmail.com>

-- Sebastian

> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		return true;
> +
> +	default:
> +		return false;
> +	}
> +}
> +
>  static int bq25890_power_supply_get_property(struct power_supply *psy,
>  					     enum power_supply_property psp,
>  					     union power_supply_propval *val)
>  {
> -	int ret;
>  	struct bq25890_device *bq =3D power_supply_get_drvdata(psy);
>  	struct bq25890_state state;
> +	bool do_adc_conv;
> +	int ret;
> =20
>  	mutex_lock(&bq->lock);
>  	state =3D bq->state;
> +	do_adc_conv =3D !state.online && bq25890_is_adc_property(psp);
> +	if (do_adc_conv)
> +		bq25890_field_write(bq, F_CONV_START, 1);
>  	mutex_unlock(&bq->lock);
> =20
> +	if (do_adc_conv)
> +		regmap_field_read_poll_timeout(bq->rmap_fields[F_CONV_START],
> +			ret, !ret, 25000, 1000000);
> +
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_STATUS:
>  		if (!state.online)
> @@ -623,8 +646,8 @@ static int bq25890_hw_init(struct bq25890_device *bq)
>  		}
>  	}
> =20
> -	/* Configure ADC for continuous conversions. This does not enable it. */
> -	ret =3D bq25890_field_write(bq, F_CONV_RATE, 1);
> +	/* Configure ADC for continuous conversions when charging */
> +	ret =3D bq25890_field_write(bq, F_CONV_RATE, !!bq->state.online);
>  	if (ret < 0) {
>  		dev_dbg(bq->dev, "Config ADC failed %d\n", ret);
>  		return ret;
> @@ -966,7 +989,7 @@ static int bq25890_suspend(struct device *dev)
>  	 * If charger is removed, while in suspend, make sure ADC is diabled
>  	 * since it consumes slightly more power.
>  	 */
> -	return bq25890_field_write(bq, F_CONV_START, 0);
> +	return bq25890_field_write(bq, F_CONV_RATE, 0);
>  }
> =20
>  static int bq25890_resume(struct device *dev)
> @@ -982,7 +1005,7 @@ static int bq25890_resume(struct device *dev)
> =20
>  	/* Re-enable ADC only if charger is plugged in. */
>  	if (bq->state.online) {
> -		ret =3D bq25890_field_write(bq, F_CONV_START, 1);
> +		ret =3D bq25890_field_write(bq, F_CONV_RATE, 1);
>  		if (ret < 0)
>  			return ret;
>  	}
> --=20
> 2.20.1
>=20

--nw6cs6bh4jrtlkv2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6vIzMACgkQ2O7X88g7
+ppfFxAAgajsn+eCYsxSLe/L55964K/Z+4ouMHGcNkewD3I7bDlOdc7Ss7l91PEy
f5ey+4RnFMVbFI5qar0CXp2mGfnq7WSZTZAthLpjfJdd2QRb0AI8wkdUDroX4Hdb
6iG9eZE9xklDNRsNy1H4D95c55T0u7JDg3zvQSzoGAxHSo/D0iqq69m5y1O++lAj
TCUHwxLF+oRsrEuxReWKpW0t1cdf/z8/ni7b8w+kZMQZKDKYxSCbDtQ2TZNQLqOg
wVxVUPku5jiQAwU3ktgH2tfUG+BLNMC5jH2Dazo1BEAYk41dmTW3/uoYva5Zc2F9
yyVS/773j2kN8svYpXdsMrwbmQmJV8cwLjdyaO0PVZvhLO1gTLonGFn9BHy57SRj
a8Izuf83wL3w/oP9XrGR9nRME60CU/0Cl6a3lj7ul30VZnm7P/rar+KoGYkBwWG5
PmNOWng5h3tYIKCjGrreKcm3MRYYtCIXGzASGo95PEU2pDZ7MeVA68jmgYMEptum
mYKrB1LJ6lF41Wv68PQxt16nwRGfXAedu18Uv1Dv/8J0ZDL4gdECJ3b8pQ1LfEvD
09IONan8CxWnPT3g5Z2dr9kQJizHCxwjMEfudVyA7Aosr6jFASYeGIqYRaxdmTW1
KgFoK4oYGzC5cC0M0w3qkpWdz+wrhGrlnGi/aCg9dejy2RbtcNI=
=yJCF
-----END PGP SIGNATURE-----

--nw6cs6bh4jrtlkv2--
