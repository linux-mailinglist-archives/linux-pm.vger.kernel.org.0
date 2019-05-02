Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 921BB1230C
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 22:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfEBUP6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 16:15:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42372 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBUP6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 16:15:58 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id EEC07263A23
Received: by earth.universe (Postfix, from userid 1000)
        id 908E33C0D1B; Thu,  2 May 2019 22:15:54 +0200 (CEST)
Date:   Thu, 2 May 2019 22:15:54 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     ndesaulniers@google.com, natechancellor@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] power: supply: core: fix clang -Wunsequenced
Message-ID: <20190502201554.qvuunxprepxhvzbm@earth.universe>
References: <20190502012704.12505-1-tranmanphong@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fryypaezrgitn536"
Content-Disposition: inline
In-Reply-To: <20190502012704.12505-1-tranmanphong@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--fryypaezrgitn536
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 02, 2019 at 08:27:06AM +0700, Phong Tran wrote:
> The increment operator of  pointer in be32_to_cpu() is not explicitly.
> It made the warning from clang:
>=20
> drivers/power/supply/power_supply_core.c:674:36: error: multiple
> unsequenced modifications to 'list' [-Werror,-Wunsequenced]
> drivers/power/supply/power_supply_core.c:675:41: error: multiple
> unsequenced modifications to 'list' [-Werror,-Wunsequenced]
>=20
> Link: https://github.com/ClangBuiltLinux/linux/issues/460
>=20
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> ---

Thanks, queued to power-supply's for-next branch.

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index c917a8b43b2b..7cc6f5fac0d0 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -665,8 +665,10 @@ int power_supply_get_battery_info(struct power_suppl=
y *psy,
>  		}
> =20
>  		for (i =3D 0; i < tab_len; i++) {
> -			table[i].ocv =3D be32_to_cpu(*list++);
> -			table[i].capacity =3D be32_to_cpu(*list++);
> +			table[i].ocv =3D be32_to_cpu(*list);
> +			list++;
> +			table[i].capacity =3D be32_to_cpu(*list);
> +			list++;
>  		}
>  	}
> =20
> --=20
> 2.21.0
>=20

--fryypaezrgitn536
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzLT/IACgkQ2O7X88g7
+ppo8g//S3Llctg446+FE7ffQ++R08/UBFsJPdxlsna5xwxbicUoYy2AC1vbXEai
6N4ptFzxGtatqXBD8XqweeMIERjrIL9O0mS35mO3eQ74AUEMkTfyCacOkx1OsAq/
9nRj/BxHtHwYRRI6Uv3RTIw/wi58HTS83DhIPBnumMKSawdq1oRqgRKsOJrlsVum
EU1jB1Cq7m68mzg2Ypzh0JwJVEWRnxRBKmZn9zKvYB3kT0yL/5MLDjyF0HbzjZDC
dycMrKNSuu4G03278veQWH/k0mvejiYzKBQoEyCYuPkJ7SXiTXyin6aPDY+3vfTK
DqtSJAvm5UZ5cM5YU74hpIs/zuhLl7ORx3hR8Idx7KuXBT/Ls4LQCCz4lRJLtEuP
tPGqHoeJQxpjQlFIgLAgplAHJf70zDrjpJ2ZO2n9dZShkM1lGPMvLidazVAXWz70
xD9rkl8aW5lgqm+ccKvCOKl5GQf+3EJYmUQXIlxfGqUa3uEXqVDGMULgghDuy24B
dzinRcFgk4MiVBGWBH1klrCHcO1g8BgkdBLftiz8UwqwfAXlXZQqkmcWgzRTCr8+
gxNzt4o4yPu+9549VeVbrYq7MoPDZPlLeIR+0/tn5jW/aFW1qo08VhQHbNTGKdFL
OULL6mDn5NlQkjumD2LaEs0XCH+xPW6VMeKwjRg/oQCrEnc3klg=
=0jkf
-----END PGP SIGNATURE-----

--fryypaezrgitn536--
