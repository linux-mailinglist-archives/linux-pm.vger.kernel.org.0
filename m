Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED9AA13F9A6
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 20:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgAPTi1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 14:38:27 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60582 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbgAPTi1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 14:38:27 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A047C294582
Received: by earth.universe (Postfix, from userid 1000)
        id 9E4203C0C7C; Thu, 16 Jan 2020 20:38:21 +0100 (CET)
Date:   Thu, 16 Jan 2020 20:38:21 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] power: supply: bq25890_charger: fix incorrect
 error return when bq25890_field_read fails
Message-ID: <20200116193821.eahey33llmtmahhj@earth.universe>
References: <20200116170900.86548-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gsoxf3b5hpk7troz"
Content-Disposition: inline
In-Reply-To: <20200116170900.86548-1-colin.king@canonical.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--gsoxf3b5hpk7troz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Colin,

Thanks, queued.

-- Sebastian

On Thu, Jan 16, 2020 at 05:09:00PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Currently a read failure by bq25890_field_read on F_DEV_REV is returning
> an error in id instead of rev. Fix this by returning the value in rev.
>=20
> Addresses-Coverity: ("Copy-paste error")
> Fixes: d20267c9a98e ("power: supply: bq25890_charger: Add support of BQ25=
892 and BQ25896 chips")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/power/supply/bq25890_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index 785dbc6307b0..aebd1253dbc9 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -765,7 +765,7 @@ static int bq25890_get_chip_version(struct bq25890_de=
vice *bq)
>  	rev =3D bq25890_field_read(bq, F_DEV_REV);
>  	if (rev < 0) {
>  		dev_err(bq->dev, "Cannot read chip revision.\n");
> -		return id;
> +		return rev;
>  	}
> =20
>  	switch (id) {
> --=20
> 2.24.0
>=20

--gsoxf3b5hpk7troz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl4gu6oACgkQ2O7X88g7
+pr00w/+JvbtQgu/7hNLNnfksPXRdxDSAaS0OB0CPRvhxOqxunWKTkvZPZdj1RP3
JZj97mi5SblDGr9qHbIzAVg/Sj0pn0vHlnkwSuqKsB7MgKtTMPRNud6Pk1FaSuMJ
bWWLNTOwWG+yetuiMHGqT9QvVKdBNb3HaWQJN+I4JvRzpf69hp75fhV0A1Q7lIvw
y3S8v1F2e/Y2o3f2ajdryRd1uYf+agfSeW7gZ+aQbY8gUICV6e5II27pvvxjylFn
V1qgy0yDlCjvP9uifQ8yK74baZHDpyU0flSylHOPIV8/V16m5WLzCRW5Dxauzsx0
3Ulqyg34JSd3eri/7oFzmHyWHEgxE7yBnXuc+ngroXF8ljR6cpz/xoBjczIbSsdc
CZRlYZqGBnuXroUACy1oyR81ial3wPYt6zSs4uhE9+cl4YYeAZ/tKnq13Re75I5s
h/tNfwR8007mEVHVpqxo1aUVfDfbYiQZkGrGSOgB58n6Ulhq+nmNJIF6/TSd54qb
uR3uy2kHdBb9q7OtMiV/QQNiLzcf17VwJEzauRdSKng8zo5n65z7qPW2UlDwu345
tnGiriKqwMJROFMoKaKTXDS8zdK2Ae/72ooLKH9qXfZDKfbaDnp/GAE6BAHBeJCs
dMXbeDN9hwTMBBnl8Iwo4haNowWD/SvldJb6Ha/yOT7xg5sF14s=
=RT7i
-----END PGP SIGNATURE-----

--gsoxf3b5hpk7troz--
