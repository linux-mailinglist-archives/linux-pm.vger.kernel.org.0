Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3FA1C2EEA
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 21:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgECTz4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 15:55:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50178 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgECTz4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2020 15:55:56 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 3A5242A05B9
Received: by earth.universe (Postfix, from userid 1000)
        id E3CCC3C08C7; Sun,  3 May 2020 21:55:51 +0200 (CEST)
Date:   Sun, 3 May 2020 21:55:51 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 03/11] power: bq25890: make property table const
Message-ID: <20200503195551.6xr6ql5iakcuatmn@earth.universe>
References: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
 <ef2a17d5eced06f0e16b12169387b162433937d7.1588517058.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4zlrzofnrsjm3tpd"
Content-Disposition: inline
In-Reply-To: <ef2a17d5eced06f0e16b12169387b162433937d7.1588517058.git.mirq-linux@rere.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--4zlrzofnrsjm3tpd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 03, 2020 at 05:21:10PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Property list should not change, so mark it const.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq25890_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index f9f29edadddc..c4a69fd69f34 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -668,7 +668,7 @@ static int bq25890_hw_init(struct bq25890_device *bq)
>  	return 0;
>  }
> =20
> -static enum power_supply_property bq25890_power_supply_props[] =3D {
> +static const enum power_supply_property bq25890_power_supply_props[] =3D=
 {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  	POWER_SUPPLY_PROP_MODEL_NAME,
>  	POWER_SUPPLY_PROP_STATUS,
> --=20
> 2.20.1
>=20

--4zlrzofnrsjm3tpd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6vIccACgkQ2O7X88g7
+pqAUhAAiNfp7ZmuEMeMxkTW+vlqJHlh1X7K4BiAzYXbwOWOy7YlYaUSihS0QD80
PGzENHGGKFxp0uwDCqB02JmflvmpgQ3u6OjP13Pp8BQc0ri42/JLpR2ok2VfN2Eq
5FwtBKFpf60bCChpYm2VTS7dJTsIraPcorUyTyRu3aSn848WMkbvK1/QMP2qkAjd
4AgnCw0iGctEWeaqnCQEwNVwB+0RXVeO5MZZe7n3lJv9NdHu95QWW/N36qeHyrgr
0r1GUTByxaA2V0yKzKGO12adAF1EWUDpk//w578vKPIk0PMSSG7KYDexfTrSyBDJ
nnWX9q3k4TNX9xiPpevv0XR5yQOu7ZzZUoM9C5CYysOk4aqmUbKbPXK9L5ZpuRbU
Py4+ZB8WNFozYHtLwLFm0bG9YwAAZdbi2KpTwnssUyitaTZCmnYe27e/668AZfBa
i7lNhHEIV5F1lVKBKt1Srzdg/z43yApsv9RAiGvULBnDxwkrzhY6QmbDZWQ4KsLO
MrZRXBCvUFcE+IMqMlvkKN1NzSopIWkhUdMQ+afCCT3wzd2hQ78rjTt5vVIyU/6J
RJscHY9f312FWhsekNvuVVGfK9Dckd96Ym3+ISUNhT+LHhG6f4ouX+XJ4IqcjuQU
i4TRveVd1NIktP4Z9uEX9VosO33Hkyy52nnjunjg+9qCs7oyOjM=
=O39O
-----END PGP SIGNATURE-----

--4zlrzofnrsjm3tpd--
