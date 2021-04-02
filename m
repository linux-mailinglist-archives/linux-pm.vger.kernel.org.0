Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE42352A21
	for <lists+linux-pm@lfdr.de>; Fri,  2 Apr 2021 13:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbhDBLNT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Apr 2021 07:13:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56010 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbhDBLNM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Apr 2021 07:13:12 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id CF4DD1F46865
Received: by earth.universe (Postfix, from userid 1000)
        id A50203C0C96; Fri,  2 Apr 2021 13:13:08 +0200 (CEST)
Date:   Fri, 2 Apr 2021 13:13:08 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2 1/1] power: reset: at91-reset: use devm_of_iomap
Message-ID: <20210402111308.jx7mrfb52wbcuwjg@earth.universe>
References: <20210402105018.2212-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lpsjzq6g4e4q6k3u"
Content-Disposition: inline
In-Reply-To: <20210402105018.2212-1-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lpsjzq6g4e4q6k3u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 02, 2021 at 01:50:18PM +0300, Claudiu Beznea wrote:
> Use devm_of_iomap() to map resources. This will avoid the necessity to
> track the mapped resources and free them on failure path or on remove.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Suggested-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Thanks, queued.

-- Sebastian

> Changes in v2:
> - use devm_of_iomap()
> - change commit description and title to match to the new approach
> - add Suggested-by tag
>=20
>  drivers/power/reset/at91-reset.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-=
reset.c
> index 3ff9d93a5226..026649409135 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -192,7 +192,7 @@ static int __init at91_reset_probe(struct platform_de=
vice *pdev)
>  	if (!reset)
>  		return -ENOMEM;
> =20
> -	reset->rstc_base =3D of_iomap(pdev->dev.of_node, 0);
> +	reset->rstc_base =3D devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NU=
LL);
>  	if (!reset->rstc_base) {
>  		dev_err(&pdev->dev, "Could not map reset controller address\n");
>  		return -ENODEV;
> @@ -202,7 +202,7 @@ static int __init at91_reset_probe(struct platform_de=
vice *pdev)
>  		/* we need to shutdown the ddr controller, so get ramc base */
>  		for_each_matching_node_and_match(np, at91_ramc_of_match, &match) {
>  			reset->ramc_lpr =3D (u32)match->data;
> -			reset->ramc_base[idx] =3D of_iomap(np, 0);
> +			reset->ramc_base[idx] =3D devm_of_iomap(&pdev->dev, np, 0, NULL);
>  			if (!reset->ramc_base[idx]) {
>  				dev_err(&pdev->dev, "Could not map ram controller address\n");
>  				of_node_put(np);
> --=20
> 2.25.1
>=20

--lpsjzq6g4e4q6k3u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBm/DYACgkQ2O7X88g7
+pp5Cg/8DLYf8b/8g4n5vfpAYfli6gcxs0eZbWgL5dRGvCyEnYiYeTPVt12pEP8d
hb3XDvH9+c2RP1GIVnlyLFMsZDw7hhCkDanan0v7ILxgWyaY8AYO1EfrtH4oO3Fa
sWr+Oov6vPenwMuSTCs2CCWZPKgF3MwInyAaFuF5QvKuyD4xuO/duc9YtpoDmCIr
DFrtuvWtLzinTqWP0dDSEZXEGhAgg7eGcRHR1PQDF1BnkMFz8whJw9biUWpsNCsG
FAQ/R1my+3uJ2TMnaWD4SeHsOgg89xIq8S6BJwpIkyXkNBJN0ySzCNk7a6qHjVMJ
ycS/dDLMvIZ4ELP75OMw3pGak/3icWRxctVvtXp1Ty8cOh3Dhyg7iDm0If4PdG0x
u6ZU5QeKvu1ZZ3eCC0vZ2UfvO3Zrgrf4WtrFkpqhggDCffV8/f2ID6x17CiZ4gnv
5kbFXiL9K79iIqulfdLAo/tVarQhAN4ICtB2ynZ9gS8GzlxuyZKvcAmi1EwPprD5
KhvGafBeGBR0fXhjshNDYskf4bg0WJx5M847Xj7NNsqGHwJVPAf4HHXLWa/NA0WT
ZG+ENbBWOXwOf4TZDMOooZRE7Yf9RYC+wuZwIHxEuIvfCxi52xNIiXg9EQBhTiFD
HEPjHw5bVdxrkcmLu0u8TELYHqrewXDyEIWUautld0WCO6n77AM=
=6wlE
-----END PGP SIGNATURE-----

--lpsjzq6g4e4q6k3u--
