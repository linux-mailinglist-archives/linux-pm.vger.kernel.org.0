Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAE239B774
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 13:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhFDLEK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 07:04:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33904 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhFDLEK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 07:04:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9289B1F437F6
Received: by earth.universe (Postfix, from userid 1000)
        id 5E02B3C0C95; Fri,  4 Jun 2021 13:02:21 +0200 (CEST)
Date:   Fri, 4 Jun 2021 13:02:21 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] power: reset/supply: add missing
 MODULE_DEVICE_TABLE
Message-ID: <20210604110221.ykclr6yxlw3nflug@earth.universe>
References: <1620896701-53542-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kzwyopa6voscrg7y"
Content-Disposition: inline
In-Reply-To: <1620896701-53542-1-git-send-email-zou_wei@huawei.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--kzwyopa6voscrg7y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 13, 2021 at 05:05:01PM +0800, Zou Wei wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---

Does not apply anymore. Also please split this into three patches,
one for regulator-poweroff, one for ab8500 and one for
charger-manager.

Thanks,

-- Sebastian

>  drivers/power/reset/regulator-poweroff.c | 1 +
>  drivers/power/supply/ab8500_btemp.c      | 1 +
>  drivers/power/supply/ab8500_charger.c    | 1 +
>  drivers/power/supply/ab8500_fg.c         | 1 +
>  drivers/power/supply/charger-manager.c   | 1 +
>  5 files changed, 5 insertions(+)
>=20
> diff --git a/drivers/power/reset/regulator-poweroff.c b/drivers/power/res=
et/regulator-poweroff.c
> index f697088..2070120 100644
> --- a/drivers/power/reset/regulator-poweroff.c
> +++ b/drivers/power/reset/regulator-poweroff.c
> @@ -64,6 +64,7 @@ static const struct of_device_id of_regulator_poweroff_=
match[] =3D {
>  	{ .compatible =3D "regulator-poweroff", },
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, of_regulator_poweroff_match);
> =20
>  static struct platform_driver regulator_poweroff_driver =3D {
>  	.probe =3D regulator_poweroff_probe,
> diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/a=
b8500_btemp.c
> index fdfcd59..db1adc1 100644
> --- a/drivers/power/supply/ab8500_btemp.c
> +++ b/drivers/power/supply/ab8500_btemp.c
> @@ -1106,6 +1106,7 @@ static const struct of_device_id ab8500_btemp_match=
[] =3D {
>  	{ .compatible =3D "stericsson,ab8500-btemp", },
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(of, ab8500_btemp_match);
> =20
>  static struct platform_driver ab8500_btemp_driver =3D {
>  	.probe =3D ab8500_btemp_probe,
> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply=
/ab8500_charger.c
> index a9be10e..94da73e 100644
> --- a/drivers/power/supply/ab8500_charger.c
> +++ b/drivers/power/supply/ab8500_charger.c
> @@ -3644,6 +3644,7 @@ static const struct of_device_id ab8500_charger_mat=
ch[] =3D {
>  	{ .compatible =3D "stericsson,ab8500-charger", },
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(of, ab8500_charger_match);
> =20
>  static struct platform_driver ab8500_charger_driver =3D {
>  	.probe =3D ab8500_charger_probe,
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab85=
00_fg.c
> index 0c7c01a..5a86afd 100644
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -3212,6 +3212,7 @@ static const struct of_device_id ab8500_fg_match[] =
=3D {
>  	{ .compatible =3D "stericsson,ab8500-fg", },
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(of, ab8500_fg_match);
> =20
>  static struct platform_driver ab8500_fg_driver =3D {
>  	.probe =3D ab8500_fg_probe,
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/suppl=
y/charger-manager.c
> index 45da870..d67edb7 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -1279,6 +1279,7 @@ static const struct of_device_id charger_manager_ma=
tch[] =3D {
>  	},
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, charger_manager_match);
> =20
>  static struct charger_desc *of_cm_parse_desc(struct device *dev)
>  {
> --=20
> 2.6.2
>=20

--kzwyopa6voscrg7y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC6CD0ACgkQ2O7X88g7
+pod4xAAkIpz2bUPTtLApmiYEziQwZf5Z5meSAdR521hxMC9A5Kdx6qk5FcCRZbK
Y3561Mye0/TwQSFMI360DX5RWDbeGEo1hjqYPZiQpdQjXWnTC2/HEWFGPknZBkY7
N9EB2E/H1TxMvYoEGQYNLCX+MsmQvOzLiQucmXwdUAssOltjZqXANouXzflBfoh9
lW+QmHLVv7nn0HnlzgDCnsytjouqc9cP0My5ekhhMQNrxwzsi0WnW1NC5RDZf1u9
ukRWvXlqHkHCb3q3GLj+tH0BtT33ohHJPQeEGVmj6XD7ibXgU4w1ECiw7pyct6F0
NjFjzry+RNA6As9PuZOcrvBXEnNRYqQfx6fkDhazyvylsiibDT7qtyGlDIT5E9vc
tJAbJEEBROMpOxjl77UX688eDYCBIWc6OWdUidvZ91Ndz2B3vJofEECtvw7QIGyx
eQEW9tdfoSTwYOyB4JWI8OC4IdYWp/xYik8YVr5cDHGSR29SVN1DnwX3apqjOE0K
ogVbqqwUoFxsti3WgXZNQ2fPS2M+/VDId0s5NZjrWUErdcRAX60S/a9MwMdlKxVY
XW7LKgP8SB+zx8n//mK0sUJhRJvx9h2U7JPto7zPT5okFdH9yyEVcaOADU8LGyux
pdQ+/AV32b2gekmovFezhPtLZawPe7o7QHK6TBdY0hapvqJRY2o=
=qOaK
-----END PGP SIGNATURE-----

--kzwyopa6voscrg7y--
