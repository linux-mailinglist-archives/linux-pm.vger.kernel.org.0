Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5521F2F8DD5
	for <lists+linux-pm@lfdr.de>; Sat, 16 Jan 2021 18:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbhAPRK1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jan 2021 12:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbhAPRKZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jan 2021 12:10:25 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33188C0617A6;
        Sat, 16 Jan 2021 06:04:34 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 766AA1F45AB1
Received: by earth.universe (Postfix, from userid 1000)
        id 106B23C0C94; Sat, 16 Jan 2021 15:03:49 +0100 (CET)
Date:   Sat, 16 Jan 2021 15:03:48 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     angkery <angkery@163.com>
Cc:     yangjunlin@yulong.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: charger-manager: fix the wrong status of
 health
Message-ID: <20210116140348.ym75ldaalfadznvb@earth.universe>
References: <20210116114120.3531-1-angkery@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fngjxqr44dfbbnjc"
Content-Disposition: inline
In-Reply-To: <20210116114120.3531-1-angkery@163.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--fngjxqr44dfbbnjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jan 16, 2021 at 07:41:20PM +0800, angkery wrote:
> From: Junlin Yang <yangjunlin@yulong.com>
>=20
> cm->emergency_stop will only be the value in the enumeration,
> and can not be less than zero, it will get an exception value.
> So replace it with the corresponding value.
>=20
> Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/charger-manager.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/suppl=
y/charger-manager.c
> index 6fcebe4..0d28741 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -723,9 +723,9 @@ static int charger_get_property(struct power_supply *=
psy,
>  		val->intval =3D cm->battery_status;
>  		break;
>  	case POWER_SUPPLY_PROP_HEALTH:
> -		if (cm->emergency_stop > 0)
> +		if (cm->emergency_stop =3D=3D CM_BATT_OVERHEAT)
>  			val->intval =3D POWER_SUPPLY_HEALTH_OVERHEAT;
> -		else if (cm->emergency_stop < 0)
> +		else if (cm->emergency_stop =3D=3D CM_BATT_COLD)
>  			val->intval =3D POWER_SUPPLY_HEALTH_COLD;
>  		else
>  			val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
> --=20
> 1.9.1
>=20
>=20

--fngjxqr44dfbbnjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmAC8kQACgkQ2O7X88g7
+pqEzRAAjFmekAooCxV/8ZfdIrMmp9lCr12iWfBN6JPV0Mx1nxzXzOwRQm8Sa/du
OwTk5TkiPoW3Rs5nHf2CwPo4kBHSrwY0v7TYh8bOKLQeWt1wiUq7Gmczy/4c5h4a
AC/3Nzf7C5U+vhVHvB59kubQPRhwr2Rvaqph9BaqFi5Vto14Osc0FoTjPavI0uK0
+iQfpWEqoCGME49z2IQBJe8i33PdKrXcicQZni6IVrNVm0aUuWcrottF7agJy9Wm
CGbk6Zo4m+mut7boo7hSecPInWRrdGJDAq5wIfI7wRUICtetBtabZ4A9OTWdtcv4
ZDxPBTJSKL/2dvb0XykPr8uIzpv51TG1LPmOH+qbsHKcKqwIef4tRcnNvjemCmdz
hMYHmmP49blGp2HiyDdwsuEVfFIIko6GJwokFc+eQ5z12SDMSp6pLWdSz8q/kYDW
3lZvscSVbH0IlrIReoxihC8M4O9Wu1mkkAoYMjCwyzNNXErIXbPy+AKfHQcvghpq
gwZ2LGaMKkvCfBykMlRl0OH4YeBL1UdnKgk5eGkYe/Be5BHTSkhm1tJizoVX4mV3
Uwq3PaPhvJC/iAQ6+NQPZNFTefwhS1mM6y3CdEFEOowfVqZlGp/m129nJGBq1Jjs
+TGFl4wWficNfbDgrUenReAYr2keRahjRGYmHh2JRZS/0Se1uso=
=0AAy
-----END PGP SIGNATURE-----

--fngjxqr44dfbbnjc--
