Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD98D359DF5
	for <lists+linux-pm@lfdr.de>; Fri,  9 Apr 2021 13:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhDILwO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Apr 2021 07:52:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35874 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhDILwO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Apr 2021 07:52:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 74AF61F464C8
Received: by earth.universe (Postfix, from userid 1000)
        id D80423C0C96; Fri,  9 Apr 2021 13:51:57 +0200 (CEST)
Date:   Fri, 9 Apr 2021 13:51:57 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Chen Lifu <chenlifu@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] power: reset: hisi-reboot: add missing
 MODULE_DEVICE_TABLE
Message-ID: <20210409115157.cifirven2au4mj45@earth.universe>
References: <20210409025011.8796-1-chenlifu@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5pez7hzvzer77b36"
Content-Disposition: inline
In-Reply-To: <20210409025011.8796-1-chenlifu@huawei.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--5pez7hzvzer77b36
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 09, 2021 at 10:50:11AM +0800, Chen Lifu wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Chen Lifu <chenlifu@huawei.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/hisi-reboot.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/reset/hisi-reboot.c b/drivers/power/reset/hisi=
-reboot.c
> index 5abc5f6ba0fd..34409340528f 100644
> --- a/drivers/power/reset/hisi-reboot.c
> +++ b/drivers/power/reset/hisi-reboot.c
> @@ -68,6 +68,7 @@ static const struct of_device_id hisi_reboot_of_match[]=
 =3D {
>  	{ .compatible =3D "hisilicon,sysctrl" },
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, hisi_reboot_of_match);
> =20
>  static struct platform_driver hisi_reboot_driver =3D {
>  	.probe =3D hisi_reboot_probe,
>=20

--5pez7hzvzer77b36
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBwP90ACgkQ2O7X88g7
+podlg//Q/InvDUDGeGGzBjK9HaUmbZ9yb9A2n4jKp1hpxH0kdy3DDu63+k+uHtp
ZcwsrVjtVzdMsCb/g/S7cqZIZEcjB6g6fyRqvgul5g6sZJkMrx+ASdersUCALXua
yfC7nxzigWncVGV+H0DT96FwUHQYjfR7riD0yGI3hweXO8MDM+NK6OGAJIJ/maHW
Fb6rC6WMwEkc+sKmDyrKRKVnTcbTiDE+4zBVmi5c9RMQOk0xchs/lJqU36NzYflI
rmZnFrMwuwszVjaDc6AHAIPgyPcCZtgnF3souUKn67FrTTNtPsNNXmmATQAZkiDM
nIdWFt5PYX5b4MlC20H4sWvvGG5ojJacd14NB/1u2wGROhCL5lkvrg65sSysQty8
/+U9vTR7v4S3uNrM9C9fefERRcvt2M7y0nLumKlhwnY0HW4EgeUXMOTMwCpgij1g
l85P7Gf0s55dw8XeB7fJ4gwQ5bc/qvE/9yqt5o1J0u+Pr1cr6tqENUH2fUsNb/Zp
9hAiBhw67LWW/dBvoyDbR/nAVGBwFbqYB/h7+kJiuoAUoD0ATaESPf8zC0v8BCdF
qDg+K1CVngSLIqVFQ1o0L1jxBIx8ojNNUxkjYpTliJs/ChR6UKiYor4Sft9xMJSJ
nXvyBoSmpVPe5rZxBfKZe6QMNbvlt8d+PigGWXZ7459FyI8LEVU=
=XwSD
-----END PGP SIGNATURE-----

--5pez7hzvzer77b36--
