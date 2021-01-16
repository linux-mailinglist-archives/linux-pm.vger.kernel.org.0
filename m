Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BD72F8DE7
	for <lists+linux-pm@lfdr.de>; Sat, 16 Jan 2021 18:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbhAPRLz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jan 2021 12:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbhAPRK4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jan 2021 12:10:56 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7BFC061383;
        Sat, 16 Jan 2021 06:57:50 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id DEB961F45967
Received: by earth.universe (Postfix, from userid 1000)
        id 36D843C0C94; Sat, 16 Jan 2021 15:57:04 +0100 (CET)
Date:   Sat, 16 Jan 2021 15:57:04 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     pali@kernel.org, dmurphy@ti.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: bq27xxx: fix polarity of current_now
Message-ID: <20210116145704.7hycpifbjgjivqkq@earth.universe>
References: <20201204144950.8062-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vku3nkbr2fik7cnz"
Content-Disposition: inline
In-Reply-To: <20201204144950.8062-1-andreas@kemnade.info>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vku3nkbr2fik7cnz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 04, 2020 at 03:49:50PM +0100, Andreas Kemnade wrote:
> current_now has to be negative during discharging and positive during
> charging, the behavior seen is the other way round.
>=20
> Tested on GTA04 with Openmoko battery
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq27xxx_battery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 315e0909e6a4..3ecc18b01d49 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1789,7 +1789,7 @@ static int bq27xxx_battery_current(struct bq27xxx_d=
evice_info *di,
> =20
>  	if (di->opts & BQ27XXX_O_ZERO) {
>  		flags =3D bq27xxx_read(di, BQ27XXX_REG_FLAGS, true);
> -		if (flags & BQ27000_FLAG_CHGS) {
> +		if (!(flags & BQ27000_FLAG_CHGS)) {
>  			dev_dbg(di->dev, "negative current!\n");
>  			curr =3D -curr;
>  		}
> @@ -1797,7 +1797,7 @@ static int bq27xxx_battery_current(struct bq27xxx_d=
evice_info *di,
>  		val->intval =3D curr * BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
>  	} else {
>  		/* Other gauges return signed value */
> -		val->intval =3D (int)((s16)curr) * 1000;
> +		val->intval =3D -(int)((s16)curr) * 1000;
>  	}
> =20
>  	return 0;
> --=20
> 2.20.1
>=20

--vku3nkbr2fik7cnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmAC/rsACgkQ2O7X88g7
+ppoUw//Y0VezhyUUgXG8oAdqVCIH6BoEnPVtschzcHgpXIMDwvbDpStNF5wOqUI
nrnwnFBt7V4e5UTlTiDLDHzLzdeWGPFtNtbf/ajIl/qBhqh0oH3vcKOt6hZXF/7S
ja3CmObDPwL3yS9ehUQdZGvZWPK6ozzQ1m2bZvoUwq6ExLZxLNkLkPjDNiHfHYxQ
XHmbPwV4184Jl800ZPmjbj6zorkquy6trs/yLhs6/97r1R6aROJVN0JVoi34K5fA
dle+XUtQWB6TNIeTvMvCc4KLYzDq/WKhioHvt8zZGr5dvfL9Ti+Io4pdcLi+yD6x
Iec6GrTtO+Z3ZpObXlL6dSN9SDcfa10PKGiAIRjNH8dXbkLjCTgOPPEKav6RcPSN
I6sPNbQr4bbEV5CxRTymeRn40PVFcETQQuNymmv6/Eu/vCqYpyaBiHAYuw0tuyDT
DBKdo6PK+rxmlKzfDiVZ5qZDLyuXA//KdER9ujAv+AsSotOpz5EYdmsnfpGVctWo
dH8eNJIpWBYbH7UeGUPueYdhSVLRb/X7Tihoemx0vzziX15PfZVoKrgXyO+imA8Y
2g7XAg+P6m1yj0SN6GEyDvRhvSFs+wtZu2D84nH5PMNxbZ8A0DpMYtg98WbmKPgD
BbF4jqSIA4wejlpcYOYOIbJkG2gLicYTETiIMuNGgG5+vy/rBwI=
=z4n7
-----END PGP SIGNATURE-----

--vku3nkbr2fik7cnz--
