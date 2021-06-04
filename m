Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779D039B760
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 12:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhFDLAt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 07:00:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33880 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhFDLAs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 07:00:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id EC6401F43734
Received: by earth.universe (Postfix, from userid 1000)
        id 6CADA3C0C95; Fri,  4 Jun 2021 12:58:59 +0200 (CEST)
Date:   Fri, 4 Jun 2021 12:58:59 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Bixuan Cui <cuibixuan@huawei.com>
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] power: reset: gpio-poweroff: add missing
 MODULE_DEVICE_TABLE
Message-ID: <20210604105859.r3odo4zmt2xye66s@earth.universe>
References: <20210508031459.53589-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4e4c6hhugzglxbt4"
Content-Disposition: inline
In-Reply-To: <20210508031459.53589-1-cuibixuan@huawei.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--4e4c6hhugzglxbt4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 08, 2021 at 11:14:59AM +0800, Bixuan Cui wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/gpio-poweroff.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gp=
io-poweroff.c
> index c5067eb75370..1c5af2fef142 100644
> --- a/drivers/power/reset/gpio-poweroff.c
> +++ b/drivers/power/reset/gpio-poweroff.c
> @@ -90,6 +90,7 @@ static const struct of_device_id of_gpio_poweroff_match=
[] =3D {
>  	{ .compatible =3D "gpio-poweroff", },
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, of_gpio_poweroff_match);
> =20
>  static struct platform_driver gpio_poweroff_driver =3D {
>  	.probe =3D gpio_poweroff_probe,
>=20

--4e4c6hhugzglxbt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC6B2wACgkQ2O7X88g7
+pq4jA/9GMSpYvSqLnbDgN6MPyduQzazfXqxmPDrnHTeFaRdVSz175QXtnWvnR0o
t48YVNvkPXVUQRKZEqc7Uyqh80MVtvDjlpuPJPzejPXYrfXKloAixIIsa8+G/0G0
hrPVf9NiNRdj69T5YNN71oBeHwnj9/CW6Cnqye3BVpKmPQ1RXvuo9Tm6VQdWeyr5
C7CAQuU96UNDJj8RVPLVKNBZb8j0BHUlyybGDQz2hazedfQCP+3dmW+raQd+pAN4
4r7B47jHE5/zQAxZ9wGwPn1y9HdKeEEITWmRmuWkIi3zYaPbvx/k92BZz9a1uahf
cXufesdT2Nrm6TgDurfD4Y/oFn2AsSnleg8bAUHR6jRGBgDHppugU2OxNu/eWuo6
7rq/49xJsSZVEevkJMJySHBAnrvzJtT4hntolJRMkKVB35SS2d33E82/GHZ0JNmN
AnqOK12ybMp+ri+YvUzge/vC7BGfSIQSMd74BaTDsfbjTtrLXeUmOCJPgf8oPD29
vUJZf0Y/FB0PIqGjId16GQ+4EnjArx1UrAEiFnTD9N0iLelRn23lWVbKLn1L6vvb
1weyQV8YGahW6WGwKaa8N3zwsQjv+1xky36xBlzRA4e80QPc88PUp2OO5mpNXuGl
3IPTzn7hd0qvT9dBbixfo0e3iniWhkvau6tp95uUX56McP/vfI4=
=0Qok
-----END PGP SIGNATURE-----

--4e4c6hhugzglxbt4--
