Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C9C1E5A1A
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 10:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgE1IAC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 04:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgE1IAC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 04:00:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADECC05BD1E;
        Thu, 28 May 2020 01:00:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E4C8E2A3CC0
Received: by earth.universe (Postfix, from userid 1000)
        id AB0D83C08C7; Thu, 28 May 2020 09:59:58 +0200 (CEST)
Date:   Thu, 28 May 2020 09:59:58 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 3/3] power: charger: max14577: Add proper
 dt-compatible strings
Message-ID: <20200528075958.3ck2gh7t2ubi4w6m@earth.universe>
References: <20200522102448.30209-1-m.szyprowski@samsung.com>
 <CGME20200522102455eucas1p13700db68b90ec05bd02d21014b81b656@eucas1p1.samsung.com>
 <20200522102448.30209-3-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t4rywburgusgvb6o"
Content-Disposition: inline
In-Reply-To: <20200522102448.30209-3-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--t4rywburgusgvb6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 22, 2020 at 12:24:48PM +0200, Marek Szyprowski wrote:
> Add device tree compatible strings and create proper modalias structures
> to let this driver load automatically if compiled as module, because
> max14577 MFD driver creates MFD cells with such compatible strings.
>=20
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---

I saw some discussion for patch 1, but still queued this considering
the compatible string is already documented in the DT bindings and
at least one of them is already being used in DT files.

TL;DR: Thanks, queued.

-- Sebastian

> v3:
> - sorted of_max14577_charger_dt_match
> v2:
> - added .of_match_table pointer
> ---
>  drivers/power/supply/max14577_charger.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/power/supply/max14577_charger.c b/drivers/power/supp=
ly/max14577_charger.c
> index 8a59feac6468..96f4cd1941b2 100644
> --- a/drivers/power/supply/max14577_charger.c
> +++ b/drivers/power/supply/max14577_charger.c
> @@ -623,9 +623,19 @@ static const struct platform_device_id max14577_char=
ger_id[] =3D {
>  };
>  MODULE_DEVICE_TABLE(platform, max14577_charger_id);
> =20
> +static const struct of_device_id of_max14577_charger_dt_match[] =3D {
> +	{ .compatible =3D "maxim,max14577-charger",
> +	  .data =3D (void *)MAXIM_DEVICE_TYPE_MAX14577, },
> +	{ .compatible =3D "maxim,max77836-charger",
> +	  .data =3D (void *)MAXIM_DEVICE_TYPE_MAX77836, },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, of_max14577_charger_dt_match);
> +
>  static struct platform_driver max14577_charger_driver =3D {
>  	.driver =3D {
>  		.name	=3D "max14577-charger",
> +		.of_match_table =3D of_max14577_charger_dt_match,
>  	},
>  	.probe		=3D max14577_charger_probe,
>  	.remove		=3D max14577_charger_remove,
> --=20
> 2.17.1
>=20

--t4rywburgusgvb6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7Pb2sACgkQ2O7X88g7
+ppNTQ//bZc44aH3MWRyOYyniSgeTQoZ+iZph/9Z70FlNCFCYuBw2XlsyE/4myyx
1P1n6ynzHHCLpsiQUJYVhBxRiAf+/KYEVdniB8ZiIOapGuaqKxJvGebQQPKsRJf8
ch+OVgpEYRwGatd9Y7bF0F5SEGKxxGEvApqkp+C5q+gL4Qt5yKg89lI9vc8pbNTL
Rb8/tlI0GLmkF8REhB0gb0DQFukCXIb8ZBp786eNMocVn68nuISopop4p3zbh9oo
FLWpWwaXBfZR7MeP80EAuhGrSPLXl3063FS/zgTZ4YSvNVqN3TjH+YiV2gdfrcE8
oX9IZwHA5NY1sGo9dVt9fYIzFFv5sGP8oabdZCWlJawQDc7DZr5Lk/3kNntvsTA5
FFQgjWor7QiprWGVtoKzjAOqeagY6GWK5KZO/nCLGqJ/nMvxadxiPzzKDRMrcskE
aL7XlVgaPZ9oho4IboIXn8wjKvYOpICN3VO553rnzVxYLrKNBZqlEdqVFp+AGiAK
nKg6SdVaQu6o3fY/8yNUoEe8ZmCiPOPl2DCSVSX/i5suZrHkt/n5/90DGH/DW0wo
TbOd5eLaMzKSNkcK17TfoF2/g6ZKSUIQoaJJHXU8UDeX2xXrwPRT9t0kSoHWVy0g
ZN+D/JMumOBi5Py6OMDPMrNscXIMZwW1AApSUBSK/EaEMcklQ98=
=CSm8
-----END PGP SIGNATURE-----

--t4rywburgusgvb6o--
