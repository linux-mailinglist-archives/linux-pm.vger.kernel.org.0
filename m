Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54E22F4009
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 01:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbhALXQB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 18:16:01 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46304 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbhALXQB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 18:16:01 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 837221F45554
Received: by earth.universe (Postfix, from userid 1000)
        id 351893C0C94; Wed, 13 Jan 2021 00:15:17 +0100 (CET)
Date:   Wed, 13 Jan 2021 00:15:17 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pm@vger.kernel.org, Alexander Kurz <akurz@blala.de>
Subject: Re: [PATCH] power: supply: max14656: Drop unused includes
Message-ID: <20210112231517.ghp7f6b6hoojre64@earth.universe>
References: <20210110121328.81259-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ilph5kzu32sm3v5i"
Content-Disposition: inline
In-Reply-To: <20210110121328.81259-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ilph5kzu32sm3v5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 10, 2021 at 01:13:28PM +0100, Linus Walleij wrote:
> The driver includes two GPIO headers but does not use
> symbols from any of them, so drop these includes.
>=20
> Cc: Alexander Kurz <akurz@blala.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/max14656_charger_detector.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/max14656_charger_detector.c b/drivers/p=
ower/supply/max14656_charger_detector.c
> index 137f9fafce8c..3f49b29f3c88 100644
> --- a/drivers/power/supply/max14656_charger_detector.c
> +++ b/drivers/power/supply/max14656_charger_detector.c
> @@ -15,8 +15,6 @@
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/slab.h>
> -#include <linux/gpio.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_device.h>
>  #include <linux/workqueue.h>
>  #include <linux/power_supply.h>
> --=20
> 2.29.2
>=20

--ilph5kzu32sm3v5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/+LX8ACgkQ2O7X88g7
+pqj5A/9Gxp5WK2ZKWTLZas8YwNGBjgpiWQ40wg+gMOMiyHOJ1gvdV1hffkEKuL7
mDSY9jXU3bgIK9Z/ldThpspswxPI9g3SYEfGVjAr+rrp/qe6iLmvdB7it3kAL8Bs
koJ+1dFfTMuXbvcICL2Aj/nfwmPOFFOxfBDvL5i+h0ieshvVXoh5pAsC8/atIRg0
oR16k+Lo9zw2++Ri3ksjkGRMfbqKa2BwzhysdpesWS49950s50kjf5XoNCln+v2B
KD3Hy6n6w2oe+JL2+GbDw4D/m1ww5ggZynQJNP4FYZjk6L4HBwOozx7qBwIA3N1t
5h4es5URzn9wtDAMMOXz8Ipyd+dkXnjcgx2CYxt8qSvq+gYIxtpDAQHvwFXXAErl
yiHzTNzIViFYlYdYoY38GqSZY04URqg+2bZDO7G8gMLqks82ZHPLHDpSU9QqTx/n
VYLGfRnbErrdTo6daWbKcpT0z+bcIJd/jwKs4uGKCf06K1uIsleecLDRTctoRvCI
RSMGRfTOAOufa5i5P15LnC0/879kCq6ar8pcUrRva4dRpOGQEWDCvJCsqX49yRI3
PO5HRmE1GlQ2rGKaqgMrREVmW+j4P1kMuDsgajlNgLqpNAZzLhj+X7/QJiAPX9O5
BiJNrsKidvWZKSiR/+9q4PegB8H2MhGW1we7j/vtOz7SwDOaXLw=
=ydv7
-----END PGP SIGNATURE-----

--ilph5kzu32sm3v5i--
