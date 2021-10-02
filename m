Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DADA41FCC7
	for <lists+linux-pm@lfdr.de>; Sat,  2 Oct 2021 17:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhJBPqN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 Oct 2021 11:46:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56952 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbhJBPqN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Oct 2021 11:46:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 6708D1F4415C
Received: by earth.universe (Postfix, from userid 1000)
        id B2A2D3C0CA8; Sat,  2 Oct 2021 17:44:23 +0200 (CEST)
Date:   Sat, 2 Oct 2021 17:44:23 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cristian Birsan <cristian.birsan@microchip.com>
Subject: Re: [PATCH] power: reset: at91-reset: check properly the return
 value of devm_of_iomap
Message-ID: <20211002154423.7nqf4cjdhwt3o7yr@earth.universe>
References: <20210930100928.2211599-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ffz6vw2dlpygm7sh"
Content-Disposition: inline
In-Reply-To: <20210930100928.2211599-1-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ffz6vw2dlpygm7sh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 30, 2021 at 01:09:28PM +0300, Claudiu Beznea wrote:
> devm_of_iomap() returns error code or valid pointer. Check its return
> value with IS_ERR().
>=20
> Fixes: bd3127733f2c ("power: reset: at91-reset: use devm_of_iomap")
> Reported-by: Cristian Birsan <cristian.birsan@microchip.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/at91-reset.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-=
reset.c
> index 026649409135..64def79d557a 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -193,7 +193,7 @@ static int __init at91_reset_probe(struct platform_de=
vice *pdev)
>  		return -ENOMEM;
> =20
>  	reset->rstc_base =3D devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NU=
LL);
> -	if (!reset->rstc_base) {
> +	if (IS_ERR(reset->rstc_base)) {
>  		dev_err(&pdev->dev, "Could not map reset controller address\n");
>  		return -ENODEV;
>  	}
> @@ -203,7 +203,7 @@ static int __init at91_reset_probe(struct platform_de=
vice *pdev)
>  		for_each_matching_node_and_match(np, at91_ramc_of_match, &match) {
>  			reset->ramc_lpr =3D (u32)match->data;
>  			reset->ramc_base[idx] =3D devm_of_iomap(&pdev->dev, np, 0, NULL);
> -			if (!reset->ramc_base[idx]) {
> +			if (IS_ERR(reset->ramc_base[idx])) {
>  				dev_err(&pdev->dev, "Could not map ram controller address\n");
>  				of_node_put(np);
>  				return -ENODEV;
> --=20
> 2.25.1
>=20

--ffz6vw2dlpygm7sh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFYflcACgkQ2O7X88g7
+pqFtg/+IXbgVjqPjIw5vj8d+o4PgFs7s9hbs0C+ZR/fnAMKFMG3gMowDqbMlRCk
19hkfItGXVVSHdPzPVFq2sSNNxjs5zKTUXwNHdAagKNOvy4+715igKswVZin4o24
Hv3GnchI6Uwh8K0dDYWT1Bvw/PXMKNLLaD4FJ9fH1OthKiSnel7+9222iGXo3/be
0OHGJFrIM9B+73XWsYiGD9Kh0yijsleGXr90GhT8S7vXyzUKwCGaT9DR/2YWvI7P
GF/W4QOUIpBXMIJMNSh8jaSddQUQ2er4Alncb7DrjKaflGFn9Rah8tF9I5+U1s4q
zHEoDY14rykovzx6Hi5Z3o1au2g4pG9mWh6i1cd/ld0V4wIBl/+7+mpHODEEB8vF
Osi3q/Se+x84IG2IxUVZbCSlYFEIgfvvMWbxhZYllJ+kMaxH7OgXm9ehuxt2LtDT
nAPLEvAOj5rE9qW3v8TkLFl1DYGlisIRkPTCAEXdOs6NBFUssA9W+Bu5ASByWEhn
1L91kL+PbMJ3lzv7AHxnu7K2z0dTSCXesH8nUDLMstglGHhPcEp+/CHq/kUY11P0
LWdC1lpsAQsG8MgBATrwlywq7M26aBHnEduPDOYf6duRuvsUU3zHab9iF0d88npc
4fsB7ww2Xbuc3woBGZrBX91yBK6Vsx7Kquq5aF8MVbp8CWg7wwc=
=B3aB
-----END PGP SIGNATURE-----

--ffz6vw2dlpygm7sh--
