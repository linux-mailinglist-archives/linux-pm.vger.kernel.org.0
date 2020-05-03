Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA8C1C2F6F
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 23:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgECVQw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 17:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgECVQw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2020 17:16:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B82C061A0E;
        Sun,  3 May 2020 14:16:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5F5242A083E
Received: by earth.universe (Postfix, from userid 1000)
        id 4A2CA3C08C7; Sun,  3 May 2020 23:16:49 +0200 (CEST)
Date:   Sun, 3 May 2020 23:16:49 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 09/11] power: bq25890: implement INPUT_CURRENT_LIMIT
 property
Message-ID: <20200503211649.2ktlpv264le6ntpy@earth.universe>
References: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
 <48d71a9b286e688ce8155449f62dc8fe0da39f17.1588517058.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wwvfkkjxsqpol2ja"
Content-Disposition: inline
In-Reply-To: <48d71a9b286e688ce8155449f62dc8fe0da39f17.1588517058.git.mirq-linux@rere.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--wwvfkkjxsqpol2ja
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 03, 2020 at 05:21:13PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Report REG00.IINLIM value as INPUT_CURRENT_LIMIT property.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/bq25890_charger.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index b48685009048..87c5832e23d3 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -254,6 +254,7 @@ enum bq25890_table_ids {
>  	/* range tables */
>  	TBL_ICHG,
>  	TBL_ITERM,
> +	TBL_IILIM,
>  	TBL_VREG,
>  	TBL_BOOSTV,
>  	TBL_SYSVMIN,
> @@ -294,6 +295,7 @@ static const union {
>  	/* TODO: BQ25896 has max ICHG 3008 mA */
>  	[TBL_ICHG] =3D	{ .rt =3D {0,	  5056000, 64000} },	 /* uA */
>  	[TBL_ITERM] =3D	{ .rt =3D {64000,   1024000, 64000} },	 /* uA */
> +	[TBL_IILIM] =3D   { .rt =3D {50000,   3200000, 50000} },	 /* uA */
>  	[TBL_VREG] =3D	{ .rt =3D {3840000, 4608000, 16000} },	 /* uV */
>  	[TBL_BOOSTV] =3D	{ .rt =3D {4550000, 5510000, 64000} },	 /* uV */
>  	[TBL_SYSVMIN] =3D { .rt =3D {3000000, 3700000, 100000} },	 /* uV */
> @@ -505,6 +507,14 @@ static int bq25890_power_supply_get_property(struct =
power_supply *psy,
>  		val->intval =3D bq25890_find_val(bq->init_data.iterm, TBL_ITERM);
>  		break;
> =20
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret =3D bq25890_field_read(bq, F_IILIM);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D bq25890_find_val(ret, TBL_IILIM);
> +		break;
> +
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>  		ret =3D bq25890_field_read(bq, F_SYSV); /* read measured value */
>  		if (ret < 0)
> @@ -695,6 +705,7 @@ static const enum power_supply_property bq25890_power=
_supply_props[] =3D {
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
>  	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
>  	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  };
> =20
> --=20
> 2.20.1
>=20

--wwvfkkjxsqpol2ja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6vNMEACgkQ2O7X88g7
+pqgTA/9EjdEkQ7l9Haz4qCVVgTQuZJv+hRFM3EtuzyMQtFd6FHZkNS6I+PmihNe
s6SIbx0ZMdO9ZwPCeG/p9sEAoQta1sOP1aKm5KwZ85pXjYglg7FWHQq/m8bOpRrT
xrX583E5/3kOwVnO8m2iTemQahx4G1xMFPXV0h838y6BUMCOVTlTX2MINCtfGx7t
4MC6BDrcxR5FFLhbNK6ziBs6dnXmEW13YQY54OHLgC+HPxnxe3Dq/vGQxeIjil6D
8cRxk8tz7LP4RqRnR2Q9nMItYIUyCUNZdl2dweBNZTPQfEyeu30ONC89DGQV8TdZ
flP+s/U3a5M1MAJucViGBHImrd+I8GZCMnJIlkt8TTsntlKJy7arzkNw3ve2V99U
YTMJWwNvmCbV37cHqHh32HNwnhwul7Q31uWmhnVqVxgtYIkHcvZPcS59yxQI2VlI
MWaNrdi1tibQlFAOymbthFUl7rWUKV9iD9wnbKdI1qseOSLVfRwshgWysXM23v3C
NEWqdL1LEw/ZCTBhYL3lXdLpIfdy5dKzHz/VEAQFploPxOVic27wveT754NyQw8S
xyJnbykF7n6/onWTLJa823O9GQAcXbaTBiisBnwQeeaWdzrz5jY+J/yjmUMo/zWt
1AxUYJoUVmIr4VqZzF4eOAZcWpUkv81Tv5lWs+/FUmoYFhhB2pE=
=9e0U
-----END PGP SIGNATURE-----

--wwvfkkjxsqpol2ja--
