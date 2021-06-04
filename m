Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881EE39B91B
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 14:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhFDMjO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 08:39:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34938 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFDMjO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 08:39:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 851FB1F439B4
Received: by earth.universe (Postfix, from userid 1000)
        id 40E933C0C95; Fri,  4 Jun 2021 14:37:25 +0200 (CEST)
Date:   Fri, 4 Jun 2021 14:37:25 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Carl Philipp Klemm <philipp@uvos.xyz>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] power: supply: cpcap-battery: invalidate
 empty->counter_uah and charge_full when charge_now indicates that they are
 grossly wrong
Message-ID: <20210604123725.skvntgzvmbidyrau@earth.universe>
References: <20210423145831.a8f0ba37baa211353cdf43b8@uvos.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="edgwsfgidhpbf44q"
Content-Disposition: inline
In-Reply-To: <20210423145831.a8f0ba37baa211353cdf43b8@uvos.xyz>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--edgwsfgidhpbf44q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 23, 2021 at 02:58:31PM +0200, Carl Philipp Klemm wrote:
> This invalidates empty->counter_uah and charge_full when charge_now indic=
ates
> that they are grossly wrong and adds some tolerance to
> POWER_SUPPLY_PROP_CHARGE_FULL to allow for inaccuracies in the charge cou=
nter
> and manufacturing tolerances in the battery.
>=20
> Signed-off-by: Carl Philipp Klemm <philipp@uvos.xyz>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/cpcap-battery.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/=
cpcap-battery.c
> index 386d269e699f..9d9453231ea7 100644
> --- a/drivers/power/supply/cpcap-battery.c
> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -762,10 +762,23 @@ static int cpcap_battery_get_property(struct power_=
supply *psy,
>  		if (!empty->voltage)
>  			return -ENODATA;
>  		val->intval =3D empty->counter_uah - latest->counter_uah;
> -		if (val->intval < 0)
> +		if (val->intval < 0) {
> +			/* Assume invalid config if CHARGE_NOW is -20% */
> +			if (ddata->charge_full && abs(val->intval) > ddata->charge_full/5) {
> +				empty->voltage =3D 0;
> +				ddata->charge_full =3D 0;
> +				return -ENODATA;
> +			}
>  			val->intval =3D 0;
> -		else if (ddata->charge_full && ddata->charge_full < val->intval)
> +		} else if (ddata->charge_full && ddata->charge_full < val->intval) {
> +			/* Assume invalid config if CHARGE_NOW exceeds CHARGE_FULL by 20% */
> +			if (val->intval > (6*ddata->charge_full)/5) {
> +				empty->voltage =3D 0;
> +				ddata->charge_full =3D 0;
> +				return -ENODATA;
> +			}
>  			val->intval =3D ddata->charge_full;
> +		}
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_FULL:
>  		if (!ddata->charge_full)
> @@ -842,7 +855,7 @@ static int cpcap_battery_set_property(struct power_su=
pply *psy,
>  	case POWER_SUPPLY_PROP_CHARGE_FULL:
>  		if (val->intval < 0)
>  			return -EINVAL;
> -		if (val->intval > ddata->config.info.charge_full_design)
> +		if (val->intval > (6*ddata->config.info.charge_full_design)/5)
>  			return -EINVAL;
> =20
>  		ddata->charge_full =3D val->intval;
> --=20
> 2.31.0
>=20
>=20

--edgwsfgidhpbf44q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC6Hn4ACgkQ2O7X88g7
+pq9cRAAp5tyNwfHuqkaqbULXgd4luGLpB2c1KMYzkO2m7L+gL3mDAivNcoc1AzA
4704i+a2vadbFOKVBFHkNDiWMxjLvhTHzEqX3+KUU7zIcXbEcPBGQU3MYbD7hzYd
QJyr2rjlEyJwdj4sKjT7X3Wj5d+lTYjldXpBOQySI1kSlTXDfrpdxbAGdWvABD39
UqF9NgwSkgRqPjT3fVhVARjoCTPNYBjwX9TaR+jQqONAL1A7Itvck9TCP7480I+0
u2Pn/QQZXh1lYs8x3kFdMsy4j6RptMTpvau6Ov56PW9vyrQ+FzzcFN9zY+PjXjCc
DapH0fdi5IpnPudRDqe/fvM4R2aM9ka35ioyZsrFbgE9Eu/zTIPUKNLFu0RCXcrp
rSZYRwUhUilNVqnqUrpDRdiedCHupp8+mG9hXsyFBS12tuRM+pMH7fTHhGBWTK71
W3ZyhMrt133lc1R5kkXeLbT3v5ixm0ZQUTX8n/VP48MPjX4D+PesDVeT1zI2U+35
NMsjzMua3lzXq0NRgpVUxzHBztVXD/cf2S+Lv8ijTU5vlJQsh48Ds2mbG8nN6bkD
Z2F03i6HkPQN3BjSmfeueAmfurLYSAZiBo5HvjaOLjd7+zGbdkM768IZHQgWd3OL
7jRCiCfOvkfh6XwYWqs16RstG+XZm3m2XVEd2dH1BE5i49lESPs=
=frO6
-----END PGP SIGNATURE-----

--edgwsfgidhpbf44q--
