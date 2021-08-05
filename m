Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3D03E18F7
	for <lists+linux-pm@lfdr.de>; Thu,  5 Aug 2021 17:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242784AbhHEP7n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Aug 2021 11:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242731AbhHEP7n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Aug 2021 11:59:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D466FC061765;
        Thu,  5 Aug 2021 08:59:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id AB7CF1F44206
Received: by earth.universe (Postfix, from userid 1000)
        id 206F23C0C9B; Thu,  5 Aug 2021 17:59:25 +0200 (CEST)
Date:   Thu, 5 Aug 2021 17:59:25 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: sc27xx: Delete superfluous error message
Message-ID: <20210805155925.7eoiuxbchwcegnyt@earth.universe>
References: <20210805125233.16268-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="37i7djb4jbjvjxc2"
Content-Disposition: inline
In-Reply-To: <20210805125233.16268-1-tangbin@cmss.chinamobile.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--37i7djb4jbjvjxc2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 05, 2021 at 08:52:33PM +0800, Tang Bin wrote:
> In the function sc27xx_fgu_probe(), when get irq failed,
> platform_get_irq() logs an error message, so remove
> redundant message here.
>=20
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---

Thanks, queued.

--Sebastian

>  drivers/power/supply/sc27xx_fuel_gauge.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/sup=
ply/sc27xx_fuel_gauge.c
> index 9c627618c..5e7f7a19e 100644
> --- a/drivers/power/supply/sc27xx_fuel_gauge.c
> +++ b/drivers/power/supply/sc27xx_fuel_gauge.c
> @@ -1229,10 +1229,8 @@ static int sc27xx_fgu_probe(struct platform_device=
 *pdev)
>  	}
> =20
>  	irq =3D platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(dev, "no irq resource specified\n");
> +	if (irq < 0)
>  		return irq;
> -	}
> =20
>  	ret =3D devm_request_threaded_irq(data->dev, irq, NULL,
>  					sc27xx_fgu_interrupt,
> --=20
> 2.20.1.windows.1
>=20
>=20
>=20

--37i7djb4jbjvjxc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEMCtYACgkQ2O7X88g7
+pq0Ng/7BkQAIB4/ThTdQvIXJarp3t0TrgG28nUJ9ZWyimudzseVrrgmnaI9TsM5
ystKE8Hxux1l+Z3aXJwQkNI61rTNL/9K/bfJrKVPRE5yKxDohYpyZyy5c/Te2gqF
GXZ98gc6RE62mRm9XrZ6omld0gFtfbZ74c7Sw5W3FuonfE/6j6d1PBXqANP7lxJt
vcO1+p5sYeDSqGsn9wiweRDLODmRAPfVeDuc+7R44Z4Wcxung/q7Vjpu4mEbkNpY
+Yd8vYbQpw6ZgiebybV3L8StzNtBx2z+wg4tj2GvhHuQ+NZDan7jyqiPcC+QTW6B
fb0wavnozBtW/HasBepGm9kSsOSHzSI3JJopVoKL258ELD9THG1bGAAkAPwSmVc1
QVaUrolTNX9AohZKJasdUNsfsPntWOEq0eaABk65vKnYBCiJ5sWCoM2dy8eVnReD
WToZ4M9JqMAo16UeAYbHKO9Ydav6x7ijZBElo76Zj8jrDGOKYt/uPOSrRynu6lTY
Uf0QBYS4AQvGBowUWSbgO20wIzJr7ldprsiXaQ81H0pFVe0O/JpiIpallegQek5+
BcrFfX1wwuEn3dmj8AxndybVsAHv1yY3JF6HM2FInoLWDrSS5ebF/wDv2nt12+xr
s+kHBmT+4g1j6fSFzLXAGECk0ZorOeOD8LrLPwUdWSKW6Vd4WdA=
=K6MR
-----END PGP SIGNATURE-----

--37i7djb4jbjvjxc2--
