Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409FC306864
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 01:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhA1AIs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 19:08:48 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36298 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbhA1AIa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 19:08:30 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A13081F4560D
Received: by earth.universe (Postfix, from userid 1000)
        id 8E85D3C0C97; Thu, 28 Jan 2021 01:07:36 +0100 (CET)
Date:   Thu, 28 Jan 2021 01:07:36 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 10/10] power: supply: ab8500_bmdata: Use standard phandle
Message-ID: <20210128000736.ov6f7wm26mwkxuds@earth.universe>
References: <20210123221908.2993388-1-linus.walleij@linaro.org>
 <20210123221908.2993388-11-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xq54y5avbloajvjg"
Content-Disposition: inline
In-Reply-To: <20210123221908.2993388-11-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--xq54y5avbloajvjg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jan 23, 2021 at 11:19:08PM +0100, Linus Walleij wrote:
> Look up the battery using the "monitored-battery" phandle
> as is nowadays a standard DT binding. The actual bindings
> for these charger elements are not upstream so let's sort
> out this mess by conforming to the standard.

Am I missing something? I see binding documentation in

Documentation/devicetree/bindings/power/supply/ab8500

and 'battery' property being used by

arm/boot/dts/ste-ab8500.dtsi
arm/boot/dts/ste-ab8505.dtsi

(would be nice if we can switch to standard infrastructure
of course)

-- Sebastian

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/power/supply/ab8500_bmdata.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/=
ab8500_bmdata.c
> index c2b8c0bb77e2..258f399eaf37 100644
> --- a/drivers/power/supply/ab8500_bmdata.c
> +++ b/drivers/power/supply/ab8500_bmdata.c
> @@ -499,8 +499,7 @@ int ab8500_bm_of_probe(struct device *dev,
>  	const char *btech;
>  	int i;
> =20
> -	/* get phandle to 'battery-info' node */
> -	battery_node =3D of_parse_phandle(np, "battery", 0);
> +	battery_node =3D of_parse_phandle(np, "monitored-battery", 0);
>  	if (!battery_node) {
>  		dev_err(dev, "battery node or reference missing\n");
>  		return -EINVAL;
> --=20
> 2.29.2
>=20

--xq54y5avbloajvjg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmASAEIACgkQ2O7X88g7
+pqJPw//YqAoZKpZgPU4aXWPE/mbvS7Om9cSCyrlJY6Tp9KNt0yGvWtI54CpeRFE
05hO+HtQJ2lbQeFazyHZPbmQtjsjU+Lpypo17jR8G3MvtBKcNo+PeRHYHswfHr2P
vSi5rXsR6jV3fRwxLWPAUsVOXk4587hOY1ptvJDLzeEPdODIri9rqooaAAa8XpRE
Px++vFZi+eFkoWUaccWc0DPLsMRxN9ewcwsxtfte3aCvJYOpc4QLpx1LuidKe42X
MpvUCBzZfGSIBg/Ugk+Vgn1KYyeBzyFhoUZg4kkIpEx3Mx9pinFFlXtmvq/4tmrQ
Wt48TmIfeIZCTVaYhV+ZC16KsQAd/ROquGDbmt1hYxbfyTvnVBKQWIP/cf21NVem
zEq1zxouxRLWs+RjLQ83aJVyOt3bd657BhnPkELvzTfxiCVKNvS5mkK0VjZjtGsW
Nh4nh72FM6i9yTpgN0mHc/RMjrFQWHy1G+BTIEMOCS85jVWJCrzkTjGBqD49pI6B
tTwSpwcCzF9P9JlKOfmlwNR96f/M8ylDFUanjsdhAo8t4+UioduAn3ocl8amYXof
qUK3vGUQo7bVhg7G4HLDlPjaG8KaJs94DTSyC7qFrfu7WUx6QQ6aQIALZ0GSuPrb
X9dc/pcX945aY2EmfXLFSq1+pGvXOzWrVxE0ezUYlAA9EvAMQ08=
=m6lB
-----END PGP SIGNATURE-----

--xq54y5avbloajvjg--
