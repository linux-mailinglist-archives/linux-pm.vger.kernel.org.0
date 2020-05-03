Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C611C2EE8
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 21:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgECTzb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 15:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgECTzb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2020 15:55:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A05C061A0E;
        Sun,  3 May 2020 12:55:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 29EE12A010B
Received: by earth.universe (Postfix, from userid 1000)
        id D7CF73C08C7; Sun,  3 May 2020 21:55:26 +0200 (CEST)
Date:   Sun, 3 May 2020 21:55:26 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 02/11] power: bq25890: simplify chip name property
 getter
Message-ID: <20200503195526.p24qf6gt4ejl2nvp@earth.universe>
References: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
 <e623178ff9592e041089a40a7593b5a5770df4f3.1588517058.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hwyrnsyqigfvx4b5"
Content-Disposition: inline
In-Reply-To: <e623178ff9592e041089a40a7593b5a5770df4f3.1588517058.git.mirq-linux@rere.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--hwyrnsyqigfvx4b5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 03, 2020 at 05:21:10PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Driver rejects unknown chips early in the probe(), so when
> bq25890_power_supply_get_property() is made reachable, bq->chip_version
> will already be set to correct value - there is no need to check
> it again.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq25890_charger.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index c642519ef7b2..f9f29edadddc 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -32,6 +32,13 @@ enum bq25890_chip_version {
>  	BQ25896,
>  };
> =20
> +static const char *const bq25890_chip_name[] =3D {
> +	"BQ25890",
> +	"BQ25892",
> +	"BQ25895",
> +	"BQ25896",
> +};
> +
>  enum bq25890_fields {
>  	F_EN_HIZ, F_EN_ILIM, F_IILIM,				     /* Reg00 */
>  	F_BHOT, F_BCOLD, F_VINDPM_OFS,				     /* Reg01 */
> @@ -400,17 +407,7 @@ static int bq25890_power_supply_get_property(struct =
power_supply *psy,
>  		break;
> =20
>  	case POWER_SUPPLY_PROP_MODEL_NAME:
> -		if (bq->chip_version =3D=3D BQ25890)
> -			val->strval =3D "BQ25890";
> -		else if (bq->chip_version =3D=3D BQ25892)
> -			val->strval =3D "BQ25892";
> -		else if (bq->chip_version =3D=3D BQ25895)
> -			val->strval =3D "BQ25895";
> -		else if (bq->chip_version =3D=3D BQ25896)
> -			val->strval =3D "BQ25896";
> -		else
> -			val->strval =3D "UNKNOWN";
> -
> +		val->strval =3D bq25890_chip_name[bq->chip_version];
>  		break;
> =20
>  	case POWER_SUPPLY_PROP_ONLINE:
> --=20
> 2.20.1
>=20

--hwyrnsyqigfvx4b5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6vIacACgkQ2O7X88g7
+po69Q//caWeqFN2/MC3PAg2BH4Yw9wxpWmN2ZorEV4WcZbOQEX9TMSZKrBidKjb
rnTMke9BrMC95bUUQSAf8fDOlvyDzEiGwd4qD0jyjfs22qg2yEnWjSlDcIauCaJb
vmetFeKdSflAm0YxJ7XoWhLgH3ZQLx5Tjgx+L3xunQKPkzvw1cYj5nIL8ai0QtZS
qfjD+ze6nXk5uXf7HVlhh2ISV6+N8oJnI2Q65Y3SlCHuffrVg/Xkj7MB17RZjbB4
RGbjHfjMp1RVJmtiuwd3BH9+StJH3OGut6Jb2vOZ1icpaCHyCQXxHNoYmJVX02/F
t0hVjlleOWy47kQdwRj0uk5YE8XfPLAdmI7Hyc4NX/lhS0RvKUGRG/0vS76qZqDJ
2Pebz8CAn1Ub9SnfNv2sHAfrylEgm4jm24l/CgU/EqyCGnm9XzWRDjh5D0k2Xfo9
ifp7rjxKT5JH7AHamRywdpd4G83gTe8BHBv/YKItlL9rYq3qwY0dUM2E/OGz8RV5
ORuF2cX4aWb9bpRkYRTgyryb4h5qCrJrJHmy0OQiVIHpch9qio+U9hWpPSW7bwxD
/KFUB4Ff8VeZArzHM9lJd6YaQJa4HVmiVkCpXg+DXurFc4DiLV1BbQTTyr1MdNnr
PvLyir9ow/v/mgDMWpD/RFgVGHU6/pDQnwHnlSE7L/g3+zBethI=
=BZOz
-----END PGP SIGNATURE-----

--hwyrnsyqigfvx4b5--
