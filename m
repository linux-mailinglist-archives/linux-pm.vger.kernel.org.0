Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265A742A84D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Oct 2021 17:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbhJLPem (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Oct 2021 11:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbhJLPel (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Oct 2021 11:34:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A723C061570
        for <linux-pm@vger.kernel.org>; Tue, 12 Oct 2021 08:32:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 0E1781F43CC4
Received: by earth.universe (Postfix, from userid 1000)
        id 99C793C0CA8; Tue, 12 Oct 2021 17:32:35 +0200 (CEST)
Date:   Tue, 12 Oct 2021 17:32:35 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     linux-pm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] power: supply: rt5033_battery: Change =?utf-8?Q?volta?=
 =?utf-8?Q?ge_values_to_=C2=B5V?=
Message-ID: <20211012153235.qnwfpg24mcsxivep@earth.universe>
References: <20211008083245.2884-1-jahau.ref@rocketmail.com>
 <20211008083245.2884-1-jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qfmwc7oacui6dg4j"
Content-Disposition: inline
In-Reply-To: <20211008083245.2884-1-jahau@rocketmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qfmwc7oacui6dg4j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 08, 2021 at 10:32:45AM +0200, Jakob Hauser wrote:
> Currently the rt5033_battery driver provides voltage values in mV. It
> should be =B5V as stated in Documentation/power/power_supply_class.rst.
>=20
> Fixes: b847dd96e659 ("power: rt5033_battery: Add RT5033 Fuel gauge device=
 driver")
> Cc: Beomho Seo <beomho.seo@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
>  drivers/power/supply/rt5033_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply=
/rt5033_battery.c
> index 9ad0afe83d1b..7a23c70f4879 100644
> --- a/drivers/power/supply/rt5033_battery.c
> +++ b/drivers/power/supply/rt5033_battery.c
> @@ -60,7 +60,7 @@ static int rt5033_battery_get_watt_prop(struct i2c_clie=
nt *client,
>  	regmap_read(battery->regmap, regh, &msb);
>  	regmap_read(battery->regmap, regl, &lsb);
> =20
> -	ret =3D ((msb << 4) + (lsb >> 4)) * 1250 / 1000;
> +	ret =3D ((msb << 4) + (lsb >> 4)) * 1250;
> =20
>  	return ret;
>  }


Thanks, queued.

-- Sebastian

--qfmwc7oacui6dg4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFlqpMACgkQ2O7X88g7
+po02A/+NUguoxABkwc5030ut+DSOnugH8ISHnyzw9vmOX843tXu/v4JOdjh7POI
kWscwGkrOZPopfUlnFfIncMTo1umviTjuwfvVc8ys+Ar9BJheP/7YeaCn9PpcCkX
K881BIvjWjnTdWUoUAzgbjHfqsdK+qtSQfa6jLBWacJCFP4+yb7AzJnLjC5cozLZ
SB5nyI/+yuSM2nIjZ09ZECvfofVjLcWO43bupoKo/YlengpH3SzEv1xuPpXU63tG
pgUqe5YMsUOay33zmL1hnoxO4jpEo/4INRa5+lwLEkDaNORgrYxiUeT/teyper1+
0StJEqEmT8NkHBgIdHxjIH6tGK1TOaxTdjSkhFJJl13T5MG3n5z190PloEvK56Vg
RzXKj/Xr4H6AzhnHxhht4XwKnIXQO9b4pEcWNclC1ySir8zPRP+ys43oSTgI0hCg
YkjkxbwvsamcS5Gb6aGZ7qYc8ZintUTotSU7wF2mmRtR58sUFn/XLNh3q1dZGQFM
2dwKmtvrsbIGsqJNgCoZR+0mjRG8LvNAYQAIuj0cTJVkpgups/LHfYQuoJmPo2F0
41TKPX1gn8cjhajPRVomRecjzo/JShJCBDGH2WIWOUT9vpi5WFdo8bOdJ3oaZnu9
7nFz0s6etat7Vgj9cwwZ/DIY39CCXFavpqiM+w4Ga+URQQrFJiM=
=LiKn
-----END PGP SIGNATURE-----

--qfmwc7oacui6dg4j--
