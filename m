Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6209039A6A6
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 19:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhFCRHq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 13:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhFCRHq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 13:07:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAC1C06174A
        for <linux-pm@vger.kernel.org>; Thu,  3 Jun 2021 10:06:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 894431F4109D
Received: by earth.universe (Postfix, from userid 1000)
        id 72B353C0C95; Thu,  3 Jun 2021 19:05:58 +0200 (CEST)
Date:   Thu, 3 Jun 2021 19:05:58 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pm@vger.kernel.org, David Heidelberg <david@ixit.cz>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH] power: supply: smb347-charger: Drop unused include
Message-ID: <20210603170558.c353rc2abp3p3lny@earth.universe>
References: <20210529001902.468060-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sy4kekrnq56zutjz"
Content-Disposition: inline
In-Reply-To: <20210529001902.468060-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--sy4kekrnq56zutjz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 29, 2021 at 02:19:02AM +0200, Linus Walleij wrote:
> This driver is including the legacy GPIO header <linux/gpio.h>
> but not using any symbols from it. Delete the include.
>=20
> Cc: David Heidelberg <david@ixit.cz>
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/smb347-charger.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply=
/smb347-charger.c
> index 3376f42d46c3..df240420f2de 100644
> --- a/drivers/power/supply/smb347-charger.c
> +++ b/drivers/power/supply/smb347-charger.c
> @@ -10,7 +10,6 @@
> =20
>  #include <linux/delay.h>
>  #include <linux/err.h>
> -#include <linux/gpio.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> --=20
> 2.31.1
>=20

--sy4kekrnq56zutjz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC5C/YACgkQ2O7X88g7
+pqL5A/+MDgugeutdvtpb2Z0GOxuYDmV0SEHV8d6w7Si/VMxIFuohoy2w8i0KxQ/
E3uE9jcP5kQGx+TOq83NngFgSjlV3JVQ+9TDeSvs3bZOMPIEzVRLhWAIT4dd8rz2
g9UGQpTk2NU8x96i0cl3OHoi3JUZVm/tig4fjcF/6lPCJ+RFANvfXlHcNG5w2d25
/3Mvy0z8fQYcXxNJvJUyrWF38IpOBSxGzInKrdq8rutlYgspU3mLBePOybf2v2fN
OAOvBVRd6wTVEMq0zZUzDY3Bl5xB6jo77JEMd79dkP6vPW0w6m4ZPjRn8pGISgcC
3GtxM/cU+TpA9xrybiC52LJB9sWX9G2cqV6k1qpa9loBnxoPQJEP3yVbiA0MgjIl
o5QyS9vy5wCEc6caEz5xTKCTz2PZUvFfd/WQMR8WW53XM4vOtkN2SwQsH2pTcmyd
IBwHFF31SKRL0HpBfHoI0sE/E6iBoUtI/Xf/E14MSZ/G5lbkhiYrW/8tA5x6blCj
53s9YZwJh6YOX3o0WgirOeb5G1GL6OKKX4rMoaV78lFUSTc/gNPY7j3F3xWD2IIz
t5ilfP/y6g3LWmnPFzC/MXw64waf8NllGGjSLmjhQR6HJjE5xDn5W5Hjfo3NE15q
A/XyjDEBNoT9EnBbDPg7F8VsQijX/2fb0ZFqyc1JRC2jYUTkWZ0=
=64Y4
-----END PGP SIGNATURE-----

--sy4kekrnq56zutjz--
