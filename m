Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F0B1C2F6A
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 23:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgECVOg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 17:14:36 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50488 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgECVOg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2020 17:14:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id BDAB62A083E
Received: by earth.universe (Postfix, from userid 1000)
        id 794C93C08C7; Sun,  3 May 2020 23:14:32 +0200 (CEST)
Date:   Sun, 3 May 2020 23:14:32 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 07/11] power: bq25890: implement CHARGE_TYPE property
Message-ID: <20200503211432.dvwm5whaeim5krz3@earth.universe>
References: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
 <9b3bd77de9cfef8af8f8ab76270b46599f9e5ab1.1588517058.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pppg25arb2u7vzzu"
Content-Disposition: inline
In-Reply-To: <9b3bd77de9cfef8af8f8ab76270b46599f9e5ab1.1588517058.git.mirq-linux@rere.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--pppg25arb2u7vzzu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 03, 2020 at 05:21:12PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Report charging type based on recently read state.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/bq25890_charger.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index e4368d01396a..ad0901fdceb6 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -429,6 +429,18 @@ static int bq25890_power_supply_get_property(struct =
power_supply *psy,
> =20
>  		break;
> =20
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		if (!state.online || state.chrg_status =3D=3D STATUS_NOT_CHARGING ||
> +		    state.chrg_status =3D=3D STATUS_TERMINATION_DONE)
> +			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_NONE;
> +		else if (state.chrg_status =3D=3D STATUS_PRE_CHARGING)
> +			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_STANDARD;
> +		else if (state.chrg_status =3D=3D STATUS_FAST_CHARGING)
> +			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_FAST;
> +		else /* unreachable */
> +			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
> +		break;
> +
>  	case POWER_SUPPLY_PROP_MANUFACTURER:
>  		val->strval =3D BQ25890_MANUFACTURER;
>  		break;
> @@ -670,6 +682,7 @@ static const enum power_supply_property bq25890_power=
_supply_props[] =3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  	POWER_SUPPLY_PROP_MODEL_NAME,
>  	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
>  	POWER_SUPPLY_PROP_ONLINE,
>  	POWER_SUPPLY_PROP_HEALTH,
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> --=20
> 2.20.1
>=20

--pppg25arb2u7vzzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6vNDgACgkQ2O7X88g7
+poifw/+Pjn+h9NpXuSwdWHNys8yqlmuFVbpBhfJ8suFgJA95qFN+YoUPql4BDcL
aQpTet8z1EjjBZEfdgqd34jkWbUHYAA3T4zDT0ehCuCsdCvhxINQkcDr5FePCXea
d7iv3H98l+OrKvnbL+l1IQ7Z0kUievsdPBjMi8BPU1szkfilFs4JwMzAmG+uXVvr
j8JUmsscvUcdjFcKcQ+sjXV6/5H0gfPydDOz8Mlsa72sxUMOj1YGkJiS9tCdZt/Y
4Y0Nno3NkRdPQAnz/cpiMJT8cbo1j7NIoKyvwP5AytnKg6D8XgtqI5oJnjw1E5SC
N/nQd4339J/8K8O10RTKI+YIQSHVeFh89nLzmby9TZtuKzW7pcAUoVDll9xU8den
p2zNbnzoyObUeorVSFsqKBfoAqgaMscX73WBKttFnqDVWYBBkbb0Cv3mE0iKRg86
n0QhiNqk/MCw9AMhaIP383lq7X/3KsbYLBsr7sIJcXlwZ8rsiAKxlfglxdqkvKoA
aFKpjm9RZuZes8ic7n7oX9zcV2HGQOk54QdxY2hD/LNVKszRH0PcI5WbMlQh1APQ
mCIgbpq8V+oaqt7LFFGlNcILSPvRWrDSTWOXWd0Ykt03ga3woMJFiF5Lx1LuODmD
IbYowMvZUPC9rbQ36YD7GhCm5ki6aTW4Dl1YgiG4LqPqUANV5aQ=
=go7r
-----END PGP SIGNATURE-----

--pppg25arb2u7vzzu--
