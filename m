Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5B03CB83A
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jul 2021 15:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhGPOBd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jul 2021 10:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhGPOBd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jul 2021 10:01:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BE4C06175F
        for <linux-pm@vger.kernel.org>; Fri, 16 Jul 2021 06:58:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B7CE11F440D9
Received: by earth.universe (Postfix, from userid 1000)
        id A9E853C0C97; Fri, 16 Jul 2021 15:58:34 +0200 (CEST)
Date:   Fri, 16 Jul 2021 15:58:34 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/5] power: supply: ab8500: Use library interpolation
Message-ID: <20210716135834.rd67uro4edbdfgao@earth.universe>
References: <20210713152709.871833-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cslwl4sbykjbhqsa"
Content-Disposition: inline
In-Reply-To: <20210713152709.871833-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--cslwl4sbykjbhqsa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Tue, Jul 13, 2021 at 05:27:05PM +0200, Linus Walleij wrote:
> The kernel already has a static inline for linear interpolation
> so use that instead of rolling our own.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Thanks, I queued the whole series.

-- Sebastian

>  drivers/power/supply/ab8500_btemp.c |  6 ++++--
>  drivers/power/supply/ab8500_fg.c    | 14 +++++++-------
>  2 files changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/a=
b8500_btemp.c
> index dbdcff32f353..24958b935d39 100644
> --- a/drivers/power/supply/ab8500_btemp.c
> +++ b/drivers/power/supply/ab8500_btemp.c
> @@ -27,6 +27,7 @@
>  #include <linux/mfd/abx500.h>
>  #include <linux/mfd/abx500/ab8500.h>
>  #include <linux/iio/consumer.h>
> +#include <linux/fixp-arith.h>
> =20
>  #include "ab8500-bm.h"
> =20
> @@ -437,8 +438,9 @@ static int ab8500_btemp_res_to_temp(struct ab8500_bte=
mp *di,
>  			i++;
>  	}
> =20
> -	return tbl[i].temp + ((tbl[i + 1].temp - tbl[i].temp) *
> -		(res - tbl[i].resist)) / (tbl[i + 1].resist - tbl[i].resist);
> +	return fixp_linear_interpolate(tbl[i].resist, tbl[i].temp,
> +				       tbl[i + 1].resist, tbl[i + 1].temp,
> +				       res);
>  }
> =20
>  /**
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab85=
00_fg.c
> index 3d45ed0157c6..bdbf3f13bee0 100644
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -34,6 +34,7 @@
>  #include <linux/mfd/abx500/ab8500.h>
>  #include <linux/iio/consumer.h>
>  #include <linux/kernel.h>
> +#include <linux/fixp-arith.h>
> =20
>  #include "ab8500-bm.h"
> =20
> @@ -56,9 +57,6 @@
>  /* FG constants */
>  #define BATT_OVV			0x01
> =20
> -#define interpolate(x, x1, y1, x2, y2) \
> -	((y1) + ((((y2) - (y1)) * ((x) - (x1))) / ((x2) - (x1))));
> -
>  /**
>   * struct ab8500_fg_interrupts - ab8500 fg interrupts
>   * @name:	name of the interrupt
> @@ -868,11 +866,12 @@ static int ab8500_fg_volt_to_capacity(struct ab8500=
_fg *di, int voltage)
>  	}
> =20
>  	if ((i > 0) && (i < tbl_size)) {
> -		cap =3D interpolate(voltage,
> +		cap =3D fixp_linear_interpolate(
>  			tbl[i].voltage,
>  			tbl[i].capacity * 10,
>  			tbl[i-1].voltage,
> -			tbl[i-1].capacity * 10);
> +			tbl[i-1].capacity * 10,
> +			voltage);
>  	} else if (i =3D=3D 0) {
>  		cap =3D 1000;
>  	} else {
> @@ -920,11 +919,12 @@ static int ab8500_fg_battery_resistance(struct ab85=
00_fg *di)
>  	}
> =20
>  	if ((i > 0) && (i < tbl_size)) {
> -		resist =3D interpolate(di->bat_temp / 10,
> +		resist =3D fixp_linear_interpolate(
>  			tbl[i].temp,
>  			tbl[i].resist,
>  			tbl[i-1].temp,
> -			tbl[i-1].resist);
> +			tbl[i-1].resist,
> +			di->bat_temp / 10);
>  	} else if (i =3D=3D 0) {
>  		resist =3D tbl[0].resist;
>  	} else {
> --=20
> 2.31.1
>=20

--cslwl4sbykjbhqsa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmDxkIoACgkQ2O7X88g7
+polKg/+Ppj6aX5Q3udR4W757p7xSsF35eK0MFZMFcojVzYjOnHpN5joXg5WxXIV
TxMooQB41vpFmEcBhD6Z0ERnUSegk2cFYZl4nBn5WXI3PXlC7ZCT27l1KQyUzMdV
iPgF10J6EyyTbjeQP4NTT4TzzFOacBasv/qVSJBKf/zliDlrzE6FE5q52q89fkFo
N8Zyj/3fcsLZawBQUNL/oV68/LNFHcwYxfN235khpxXJItXXZJ84eszogYyMZOh7
OmhcRsNDDOMU50Zz+geJD6hODexJRV2KraJEifz0Y3oy8o2PjOQiEt4yMkWApCJL
n2cwjZVVi2OhGDCt9B7TphHOT6Y/3lqmzk8QFbXv4TFwODBySR97QZpO5dK8SLe1
Ay+AF8lxRTiB+kOCyYkOHQdjSR39KvWUw23fp4PAbYv3K0+4PREZ61B/YfjAGXZB
D9YAeDnnd7vAU7pczda716uTO2Bm+TBJdqzXy5+DMB9CeGx7wUlHApyIXZ3aV6+B
6+TSU7cSM7Z462BatUJP+ik5NftOxuij5LU4F0btW1RAcFypSAyDCqxS5fVJcts5
hADt7kfkSKC7UNnNGv8uaqk577FK3hCVQ8Q0l5ov4pF4oW5tt1cIlTzsmQgpCis5
S55KVTn99Zku9hAbFhhrgNku+WSPKqQ8+8uEYENNi96aNSbZ8Q0=
=VBlK
-----END PGP SIGNATURE-----

--cslwl4sbykjbhqsa--
