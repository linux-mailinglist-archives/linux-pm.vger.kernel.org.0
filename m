Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19ECC445595
	for <lists+linux-pm@lfdr.de>; Thu,  4 Nov 2021 15:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhKDOr0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Nov 2021 10:47:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57084 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKDOr0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Nov 2021 10:47:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 740981F45AE7
Received: by earth.universe (Postfix, from userid 1000)
        id E80963C0F95; Thu,  4 Nov 2021 15:44:44 +0100 (CET)
Date:   Thu, 4 Nov 2021 15:44:44 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] power: supply: Introduces bypass charging property
Message-ID: <20211104144444.rulz4br3xu4qc7yh@earth.universe>
References: <20211104135027.2352874-1-rriveram@opensource.cirrus.com>
 <20211104135027.2352874-2-rriveram@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="34ez465lqtj6xncn"
Content-Disposition: inline
In-Reply-To: <20211104135027.2352874-2-rriveram@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--34ez465lqtj6xncn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 04, 2021 at 08:50:27AM -0500, Ricardo Rivera-Matos wrote:
> Adds a POWER_SUPPLY_CHARGE_TYPE_BYPASS option to the POWER_SUPPLY_PROP_CH=
ARGE_TYPE
> property to facilitate bypass charging operation.
>=20
> In bypass charging operation, the charger bypasses the charging path arou=
nd the
> integrated converter allowing for a "smart" wall adaptor to perform the p=
ower
> conversion externally.
>=20
> This operational mode is critical for the USB PPS standard of power adapt=
ors and is
> becoming a common feature in modern charging ICs such as:
>=20
> - BQ25980
> - BQ25975
> - BQ25960
> - LN8000
> - LN8410
>=20
> Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
> ---

Please always send API changes together with a user (e.g. in this
case you could update bq25980_charger driver to use this property).

-- Sebastian

>  drivers/power/supply/power_supply_sysfs.c | 1 +
>  include/linux/power_supply.h              | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index c3d7cbcd4fad..1368e13dc94b 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -89,6 +89,7 @@ static const char * const POWER_SUPPLY_CHARGE_TYPE_TEXT=
[] =3D {
>  	[POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE]	=3D "Adaptive",
>  	[POWER_SUPPLY_CHARGE_TYPE_CUSTOM]	=3D "Custom",
>  	[POWER_SUPPLY_CHARGE_TYPE_LONGLIFE]	=3D "Long Life",
> +	[POWER_SUPPLY_CHARGE_TYPE_BYPASS]	=3D "Bypass",
>  };
> =20
>  static const char * const POWER_SUPPLY_HEALTH_TEXT[] =3D {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 9ca1f120a211..9432234d7900 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -49,6 +49,7 @@ enum {
>  	POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE,	/* dynamically adjusted speed */
>  	POWER_SUPPLY_CHARGE_TYPE_CUSTOM,	/* use CHARGE_CONTROL_* props */
>  	POWER_SUPPLY_CHARGE_TYPE_LONGLIFE,	/* slow speed, longer life */
> +	POWER_SUPPLY_CHARGE_TYPE_BYPASS,	/* bypassing the charger */
>  };
> =20
>  enum {
> --=20
> 2.25.1
>=20

--34ez465lqtj6xncn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGD8dYACgkQ2O7X88g7
+ppJQA/8DzTi8cVt7JjH/Z/Z3dLN6ysXcQc37A3GB1BTeYtACC9M6v6nAmOuMzYg
s1dX6kGQyilTUooWTSqqYmGTYKB7h2tBQzFrqHq8XwZSztQzOK/dk9iK049UslHy
Ill0KA1SGfBtxOxLqI56q4KgR3Wqi3a1C8XvsnL/WNDbyfSJivBncZHDc/fD1Aa5
nkXEkEvcfQrny7LDvw+DhlssYIUGLVRTHdmvTa/hVAfIt8XT//fbJdO1eS8yUn2n
IS4Mm7wmopWgXUe9hGYSSo6FTg7spku30UZke7h7b0gdkJaSPedXyP2d9L+lHisJ
U5fms85cQo3amTDirkhjhqfAxTHVNeNMQbDldlsrIaT65gJyqkOu8gVjTPORDdLF
vFb9RjIl7ROJ58kM2Ld5Hw7n0jvnPqILZn4rQ2jY4V5BXmWdez1eml9IBbzJzewR
a9KWi3202vqGsNT3TQIrgZ6Ze01QtXzwjhCdj0wRifs2UvvFwEppv/wt7aA9rk/j
BehQyQpvLatLiIvLyBUyAiyTCAbPgDmxZNox51xywfZ9K0km8RIQcI3qCsSyC62r
8X48pfi8EVDD/udl8Rw1ICwSQkx9SRjRCR/8JOBmIaZZwsI7tOlnlbSZTtjcjeNF
KHx9zEyEpSMQk55AyVd9Oq4LE2Tgsa0+MHrxRropQnM/tMTYN6s=
=PCw3
-----END PGP SIGNATURE-----

--34ez465lqtj6xncn--
