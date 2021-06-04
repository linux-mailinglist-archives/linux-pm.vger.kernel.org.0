Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D6E39B788
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 13:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhFDLHd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 07:07:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33944 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhFDLHc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 07:07:32 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id CC5DC1F438C5
Received: by earth.universe (Postfix, from userid 1000)
        id 2F3FF3C0C95; Fri,  4 Jun 2021 13:05:43 +0200 (CEST)
Date:   Fri, 4 Jun 2021 13:05:43 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/1] power: reset: at91-sama5d2_shdwc: Remove redundant
 error printing in at91_shdwc_probe()
Message-ID: <20210604110543.26za5xwuwbkufk2u@earth.universe>
References: <20210511094919.4885-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lrngh3i7mnsnhmgy"
Content-Disposition: inline
In-Reply-To: <20210511094919.4885-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lrngh3i7mnsnhmgy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 11, 2021 at 05:49:19PM +0800, Zhen Lei wrote:
> When devm_ioremap_resource() fails, a clear enough error message will be
> printed by its subfunction __devm_ioremap_resource(). The error
> information contains the device name, failure cause, and possibly resource
> information.
>=20
> Therefore, remove the error printing here to simplify code and reduce the
> binary size.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/at91-sama5d2_shdwc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/res=
et/at91-sama5d2_shdwc.c
> index 125e592af445e32..d8ecffe72f165cb 100644
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -351,10 +351,8 @@ static int __init at91_shdwc_probe(struct platform_d=
evice *pdev)
> =20
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	at91_shdwc->shdwc_base =3D devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(at91_shdwc->shdwc_base)) {
> -		dev_err(&pdev->dev, "Could not map reset controller address\n");
> +	if (IS_ERR(at91_shdwc->shdwc_base))
>  		return PTR_ERR(at91_shdwc->shdwc_base);
> -	}
> =20
>  	match =3D of_match_node(at91_shdwc_of_match, pdev->dev.of_node);
>  	at91_shdwc->rcfg =3D match->data;
> --=20
> 2.26.0.106.g9fadedd
>=20
>=20

--lrngh3i7mnsnhmgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC6CQcACgkQ2O7X88g7
+ppvSA/+MGkYvO6jhWDe8+nVnCCEa4cz8c/8BzP9+56cWpMci+PHLKbDoPw0wBRA
aKFKOzyrM0t6N8D+ZDAC0R871kw4TGMg/9HiXyEV8ZXW27xVB6WRZdlJRH3hkiFY
jLVjJlXwlrw6U05VA4UwnZYdXNYcP1/9RCtWq0OGbgHdjpheFqQ2JmPillMLmBfI
H/1nnvo6EXc8lEUoGeEVwspT0BoSiGndH6pPILflKajqAMPRT5ZiI8xko1K1T88u
89JRipnQ6tTZITYNawR/7U0TvuIAYp+LbiJCwa2OwWYayHS+eOOjG1I7F07seAyh
NopGLKfhonoUGD7yyLAMqmEeIaAxTgqM1H1W1fLXafXP7Ff/2+lfk6UzCAbCFPq6
57vNN935fFSVttmYkPeeb4MUfM95N7BffPlJztR8fREsLSrFnkJDTYO9USQ1pV9f
cCwe2pT3KrHL+y8pIVjbsCSKqQrije+nK4I2PWrwOrKhgZjv1Vws8GKzHKaFZb1R
PeaZmlkeMXGCibrgErNO/HfUr7f0FouR5rabbpbB+2x9jEwvVwcYHw7dlWV6oSPg
UXdAqg+jpkaDkNNmue11vR3Ibimzmk1aIiA3HoAegFiXzDmaB6Ewm8P+nnVdbrYa
MGehF91zEqCaywIW7XXQi7ifsyPBEUwsm1DkbIaacxdBzqHbmrM=
=K2JN
-----END PGP SIGNATURE-----

--lrngh3i7mnsnhmgy--
