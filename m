Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F551A68EC
	for <lists+linux-pm@lfdr.de>; Mon, 13 Apr 2020 17:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgDMPew (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 11:34:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60174 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbgDMPev (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 11:34:51 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 6B7B22A0BE2
Received: by earth.universe (Postfix, from userid 1000)
        id 619D43C08C7; Mon, 13 Apr 2020 17:34:46 +0200 (CEST)
Date:   Mon, 13 Apr 2020 17:34:46 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq24257_charger: Replace depends on
 REGMAP_I2C with select
Message-ID: <20200413153446.yrxhfyc3tyylvmfy@earth.universe>
References: <20200413141051.506784-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n3loi6mwwmphleaw"
Content-Disposition: inline
In-Reply-To: <20200413141051.506784-1-enric.balletbo@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--n3loi6mwwmphleaw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 13, 2020 at 04:10:51PM +0200, Enric Balletbo i Serra wrote:
> regmap is a library function that gets selected by drivers that need
> it. No driver modules should depend on it. Depending on REGMAP_I2C makes
> this driver only build if another driver already selected REGMAP_I2C,
> as the symbol can't be selected through the menu kernel configuration.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index f3424fdce341..d37ec0d03237 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -577,7 +577,7 @@ config CHARGER_BQ24257
>  	tristate "TI BQ24250/24251/24257 battery charger driver"
>  	depends on I2C
>  	depends on GPIOLIB || COMPILE_TEST
> -	depends on REGMAP_I2C
> +	select REGMAP_I2C
>  	help
>  	  Say Y to enable support for the TI BQ24250, BQ24251, and BQ24257 batt=
ery
>  	  chargers.

--n3loi6mwwmphleaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6UhogACgkQ2O7X88g7
+ppXzg/8DpLbJx/q9foG5s2lAUmu407/lb/O47DOcOHRbGwlLhvlFqLVxLEAinIo
G8FSsfXWBpmTKaev7lxF2rzS2XaSiiRKiWhWsvMoorYJqdg5wN8UmRe7H41vDoY9
9jJryUmGjENCjierjEE2S4z8K9EO+hJf3UKuUWQb8DAg/c0rKONwtS6udodSyjZN
AWE8AIalcoaptRTzKfpjUrywBXYoqzn+wHSj9tMH1v9HXJ6LbEY8dYbuon2k4b0U
XmbOavkQlFc6x9mwnu0T/xif8CNKN8nxyQrmSrUpPO2w084Tv2DBtbrvezXTI9Lk
1G9GC2liCVzMSMp+8CeGegWIp0obsStqY496eCaRPF6otEFsD40Td6Q7/UAh4ssz
IjuVjwlW/PW7o9zCi8UXlq2uthQEy0YmdQAE9ZUQZTSMTN0OCncwEMw3wpr25gSZ
IPEYSpUnd7RvwTe/bLwXtx5Ky2AwAL5OAVGqLN2ydu4v0o7cu3vQhsQX56/lKjXs
qDzbkPeyYnUgkg2GvmLNhY865qaptGjEm9tOdi7CodtyXe9/5XI327mxh/mrZbkA
ooBO0qHgIp22mc0+ErsyHt97pnCZvj1Zno7ElXuJZWefLS5wzUx+ixA7SIOaQNcD
2ehEL7e3vbQtFc6uuKF8qAO2JS/BaLrPMFdyGue8PaaAn1zrkqA=
=aU0m
-----END PGP SIGNATURE-----

--n3loi6mwwmphleaw--
