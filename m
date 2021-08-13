Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A063EBA2A
	for <lists+linux-pm@lfdr.de>; Fri, 13 Aug 2021 18:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhHMQfZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Aug 2021 12:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbhHMQfZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Aug 2021 12:35:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57199C061756;
        Fri, 13 Aug 2021 09:34:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 1BE991F44A96
Received: by earth.universe (Postfix, from userid 1000)
        id CB6733C0C99; Fri, 13 Aug 2021 18:34:54 +0200 (CEST)
Date:   Fri, 13 Aug 2021 18:34:54 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     zhuguanghong <zhuguanghong@uniontech.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] POWER SUPPLY CLASS/SUBSYSTEM : add new status 'Full
 charging' can show that the battery is fully charged but still charging
Message-ID: <20210813163454.de6rprklvnbnq3yv@earth.universe>
References: <20210707081751.17021-1-zhuguanghong@uniontech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3benhu3tw7vl2w3i"
Content-Disposition: inline
In-Reply-To: <20210707081751.17021-1-zhuguanghong@uniontech.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3benhu3tw7vl2w3i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 07, 2021 at 04:17:51PM +0800, zhuguanghong wrote:

Where is the long description?

Why is this needed? If userspace wants to know the details
(trickle charging vs small leak battery usage) it can always
check current_now / power_now. I think adding this will make
things more complex without any real improvement.

> Signed-off-by: zhuguanghong <zhuguanghong@uniontech.com>
> ---


>  drivers/power/supply/power_supply_sysfs.c | 1 +
>  include/linux/power_supply.h              | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index c3d7cbcd4fad..0ddb84b7637f 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -78,6 +78,7 @@ static const char * const POWER_SUPPLY_STATUS_TEXT[] =
=3D {
>  	[POWER_SUPPLY_STATUS_DISCHARGING]	=3D "Discharging",
>  	[POWER_SUPPLY_STATUS_NOT_CHARGING]	=3D "Not charging",
>  	[POWER_SUPPLY_STATUS_FULL]		=3D "Full",
> +	[POWER_SUPPLY_STATUS_FULL_CHARGING]	=3D "Full charging",
>  };
> =20
>  static const char * const POWER_SUPPLY_CHARGE_TYPE_TEXT[] =3D {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index be203985ecdd..04844dbb18c4 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -37,6 +37,7 @@ enum {
>  	POWER_SUPPLY_STATUS_DISCHARGING,
>  	POWER_SUPPLY_STATUS_NOT_CHARGING,
>  	POWER_SUPPLY_STATUS_FULL,
> +	POWER_SUPPLY_STATUS_FULL_CHARGING,
>  };
> =20
>  /* What algorithm is the charger using? */
> --=20
> 2.20.1
>=20
>=20
>=20

--3benhu3tw7vl2w3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEWny4ACgkQ2O7X88g7
+pq8ZQ//X1ATR3gAGaI0TI1vVVl8FLJSgVoxAB8vTjtm0zPlO6u0kZJzrvvdDZtj
Gzspdf7+HNUK+vhNcfiBs+XIsV8ch/ccHrCVl57UrwTPxGz8oYwdUlLoR7JXbzEk
z8WvDb1RNZJZHldk2OA5NsiNyMput0uayp9FTkXSg00GSFICamqbbnY68KiocPxe
UVpsjTyjZN5WmDlB1SEV28vPrpy0/M/NGHGLqIzzVkrzd+byzNoRA3dn83UKMuf3
8EPySgX9NHIfyAKCYf+bx+9tDOGQIKe4WyLR2QGbjLk1PUQYOfImlaTLGzQ3O+L2
s9uAnxxeUi2w+wwtfmBtZYtEnIT/yW9kThUJj5idSeDXzOd1+xTLq4U6GEEYQ9St
oxVi6uTrCjAWjQhdMZ/I2kJlgl3tdSIxKjJah9NcT/HR7/eF4ZpgwTv0S66CgKf1
cQdqr67D1In93xoz9O64JW3O+96lMJouhKc08HXtTkdAH8sxENukKYAhHnvbsZEM
WsT1Xcn6fQyhQ0VBF3VjSwBNGpjAkmhU1HA0T8hBNYuTjB3/zYE2a9a4xnapoc8x
xZevAK37NqtzVwzc60xXLnQtQGsKjx4fo2NNo9GmM9adTf+rGB28XDifS6LIBjA9
sO2QIFOFzRHDji5ZgHNIrx4Tl+P+C3gzLBnUvxGo2BNICczJ+zo=
=7zT3
-----END PGP SIGNATURE-----

--3benhu3tw7vl2w3i--
