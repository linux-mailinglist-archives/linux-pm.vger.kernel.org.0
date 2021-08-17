Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B63B3EEDF4
	for <lists+linux-pm@lfdr.de>; Tue, 17 Aug 2021 16:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbhHQOBp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 10:01:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53788 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhHQOBp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 10:01:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 6364F1F4320F
Received: by earth.universe (Postfix, from userid 1000)
        id 1A2403C08DB; Tue, 17 Aug 2021 16:01:09 +0200 (CEST)
Date:   Tue, 17 Aug 2021 16:01:09 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCH 1/4] power: supply: max17042_battery: clean up
 MAX17055_V_empty
Message-ID: <20210817140109.sp4sk7cqkxjrcmyf@earth.universe>
References: <20210816165016.3153776-1-sebastian.krzyszkowiak@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z6mpwaxoo7zhi7lb"
Content-Disposition: inline
In-Reply-To: <20210816165016.3153776-1-sebastian.krzyszkowiak@puri.sm>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--z6mpwaxoo7zhi7lb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 16, 2021 at 06:50:13PM +0200, Sebastian Krzyszkowiak wrote:
> This register is same as in MAX17047 and MAX17050, so there's no need
> for custom casing it.
>=20
> Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> ---

Thanks, series queued.

-- Sebastian

>  drivers/power/supply/max17042_battery.c | 4 ----
>  include/linux/power/max17042_battery.h  | 1 -
>  2 files changed, 5 deletions(-)
>=20
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supp=
ly/max17042_battery.c
> index c6078f179fb3..01e6728a9e2b 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -283,8 +283,6 @@ static int max17042_get_property(struct power_supply =
*psy,
>  	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
>  		if (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17042)
>  			ret =3D regmap_read(map, MAX17042_V_empty, &data);
> -		else if (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17055)
> -			ret =3D regmap_read(map, MAX17055_V_empty, &data);
>  		else
>  			ret =3D regmap_read(map, MAX17047_V_empty, &data);
>  		if (ret < 0)
> @@ -778,8 +776,6 @@ static inline void max17042_override_por_values(struc=
t max17042_chip *chip)
> =20
>  	if (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17042)
>  		max17042_override_por(map, MAX17042_V_empty, config->vempty);
> -	if (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17055)
> -		max17042_override_por(map, MAX17055_V_empty, config->vempty);
>  	else
>  		max17042_override_por(map, MAX17047_V_empty, config->vempty);
>  	max17042_override_por(map, MAX17042_TempNom, config->temp_nom);
> diff --git a/include/linux/power/max17042_battery.h b/include/linux/power=
/max17042_battery.h
> index d55c746ac56e..7e5da60cbea3 100644
> --- a/include/linux/power/max17042_battery.h
> +++ b/include/linux/power/max17042_battery.h
> @@ -113,7 +113,6 @@ enum max17042_register {
>  enum max17055_register {
>  	MAX17055_QRes		=3D 0x0C,
>  	MAX17055_TTF		=3D 0x20,
> -	MAX17055_V_empty	=3D 0x3A,
>  	MAX17055_TIMER		=3D 0x3E,
>  	MAX17055_USER_MEM	=3D 0x40,
>  	MAX17055_RGAIN		=3D 0x42,
> --=20
> 2.32.0
>=20

--z6mpwaxoo7zhi7lb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEbwR4ACgkQ2O7X88g7
+ppD0g/+N5t8Og3doAgkCzV4Y+a6PfrLQCISpaT6ONuEUEaX/ugB6m6EhIlZfPYw
+3rqKhc1Krl8YY5kE5KvQdsQusZ/CT07WwweJYVtdV7xd8iLX0DufNoVPI1E+2Cd
fbkavXryxKLVsFXx8yDFaj5nkdU5E/zCfyTqHRlJT25H0WNWFWbfd6v7ppunpzRC
kOQ3VBqz467M499lFcpyJIDPSaWhSEICJAuMgcRkK97Pey6DA1AjiconiLpWQxkR
NujXXgiBpSBDSgXF87OmVBlS/qA3hMXB91kcdYd2yMaKSccBa84pbwOdt24oDhE4
ekSYPBOshRxIsH+VK4sJBkxRgburVUlYPjnK3vCNq6ZBQtX3BZT1vINP2MdkuMXz
G2DWioREPp6W0IolC8Bk9zUQSJ8VFk9qd+7mzii2AShsFg9LL2T5rX9xgMLidkZB
gJO35edtvxOTihaiSy/1X6yj/0gWBrNUpxkBaZ8lki92aRcTbLw5H7VqcxcZ5JJM
Mhl3mx7IZ3Q+7CiXKNkN/DbAthUoxV7aGVZnBR+ptt7DS8/VunGhGbtLJ6ucGSoq
jhevOMsDqr8PBz/9B7/gRWpEuhUnQjlvw1AAIFW+UWk8yUNpU2Dzcc5mP97Fsqpl
ToT/OGJn+jEQhD5QmH+zV194cO4471P0XVNwCuBbtyoZU1hmAo4=
=gfuG
-----END PGP SIGNATURE-----

--z6mpwaxoo7zhi7lb--
