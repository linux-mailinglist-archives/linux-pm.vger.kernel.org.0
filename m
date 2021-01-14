Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E2B2F69D0
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 19:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbhANSoP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 13:44:15 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51912 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbhANSoO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 13:44:14 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 10D0E1F45D90
Received: by earth.universe (Postfix, from userid 1000)
        id 4ECAF3C0C94; Thu, 14 Jan 2021 19:43:30 +0100 (CET)
Date:   Thu, 14 Jan 2021 19:43:30 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH] power: supply: bq256xx: Fix BQ256XX_NUM_WD_VAL and
 bq256xx_watchdog_time[] overrun
Message-ID: <20210114184330.ka6o5cxhe5ikyeoa@earth.universe>
References: <20210113225352.13099-1-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fm75k6rgj6vu3jnf"
Content-Disposition: inline
In-Reply-To: <20210113225352.13099-1-r-rivera-matos@ti.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--fm75k6rgj6vu3jnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 13, 2021 at 04:53:52PM -0600, Ricardo Rivera-Matos wrote:
> Corrects BQ256XX_NUM_WD_VAL from value of "8" to "4" and fixes the issue =
when 'i'
> is equal to array size then array index over runs the array
>=20
> Fixes: 32e4978bb92 ("power: supply: bq256xx: Introduce the BQ256XX charge=
r driver")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq256xx_charger.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/suppl=
y/bq256xx_charger.c
> index dc74c44618af..8414472083a6 100644
> --- a/drivers/power/supply/bq256xx_charger.c
> +++ b/drivers/power/supply/bq256xx_charger.c
> @@ -135,7 +135,7 @@
>  #define BQ256XX_NTC_FAULT_COLD		(BIT(2) | BIT(0))
>  #define BQ256XX_NTC_FAULT_HOT		(BIT(2) | BIT(1))
> =20
> -#define BQ256XX_NUM_WD_VAL	8
> +#define BQ256XX_NUM_WD_VAL	4
>  #define BQ256XX_WATCHDOG_MASK	GENMASK(5, 4)
>  #define BQ256XX_WATCHDOG_MAX	1600000
>  #define BQ256XX_WATCHDOG_DIS	0
> @@ -1508,6 +1508,10 @@ static int bq256xx_hw_init(struct bq256xx_device *=
bq)
>  	int i;
> =20
>  	for (i =3D 0; i < BQ256XX_NUM_WD_VAL; i++) {
> +		if (bq->watchdog_timer =3D=3D bq256xx_watchdog_time[i]) {
> +			wd_reg_val =3D i;
> +			break;
> +		}
>  		if (bq->watchdog_timer > bq256xx_watchdog_time[i] &&
>  		    bq->watchdog_timer < bq256xx_watchdog_time[i + 1])
>  			wd_reg_val =3D i;
> --=20
> 2.30.0
>=20

--fm75k6rgj6vu3jnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmAAkMwACgkQ2O7X88g7
+po/GA//TtjqsAJY+5xGVUP/g6dReZlNr4b+JCHexErQ6Adl/0hAkZFqSoio8CM7
3O0gEtiphJ6skaRjoGMd/UTKkfZmKB4/QXUZu22SrOIUtiHtIVv/stUeTGzLYf4B
SkZrnoRdrsodQA2+fntLKyiC632xNAA1C2wyYlruvxOS3eyzBfUiwMwmFQk6j06E
i3aaMOkP9LXJjixY+MwJjtMEd/Vl+WgWtiA/SR13KQ7HQ5Ruf5Cv7+UsmgIrepw0
18L4r6HP+4Dn3wMrws4oxFxjZTn/qL4SP1kcfwLfwVGBmR/RpQzx8VMg5lmLWsqN
v9BVE7XZNljBoadr91Px+e3OvgFXWbWlpUHd17pH4KzxHDFuO7xJXa/3+5D11+3W
pg8/DLEUzBcu2DAh6bGByYBv27OjJG8N/1XBorlxpYQLJDYTFVxVyCrQZiBqOe7/
/S7qYMyYsWvPshkSz8eQGNTFIRlpVd5/szf81U353+iX8LaMXItQxutc/innYk94
uZaIHCRigEH6IgwkPagMRF3DKDQoNGD+LIYKcM0a0qmhNFYZnsSCr2oS7sT7NGuU
j8RmqJKHtRCXj4cuGN+baYQm4FLj7rqupR/RLM5IPfYRETDeoUveXxvy3y83m9zp
Rq3gyWZLMuFH2wHUZWxz5oGL3+v43vCHALqahsdR7vBvhH7qfDg=
=ediH
-----END PGP SIGNATURE-----

--fm75k6rgj6vu3jnf--
