Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67788353C49
	for <lists+linux-pm@lfdr.de>; Mon,  5 Apr 2021 10:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhDEIMQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Apr 2021 04:12:16 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56716 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhDEIMQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Apr 2021 04:12:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 687081F40EDB
Received: by earth.universe (Postfix, from userid 1000)
        id 4241E3C0C96; Mon,  5 Apr 2021 10:12:07 +0200 (CEST)
Date:   Mon, 5 Apr 2021 10:12:07 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Carl Philipp Klemm <philipp@uvos.xyz>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/5] power: supply: cpcap-battery: invalidate
 empty->counter_uah and charge_full when they are grossly wrong
Message-ID: <20210405081207.oqkd37scsimj4lpo@earth.universe>
References: <20210117224638.10c9d9aee7c0144fafd70520@uvos.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ssvre46dn3edmrrv"
Content-Disposition: inline
In-Reply-To: <20210117224638.10c9d9aee7c0144fafd70520@uvos.xyz>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ssvre46dn3edmrrv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 17, 2021 at 10:46:38PM +0100, Carl Philipp Klemm wrote:
> This invalidates empty->counter_uah and charge_full when charge_now indic=
ates
> that they are grossly wrong and adds some tolerance to
> POWER_SUPPLY_PROP_CHARGE_FULL to allow for inaccuracies in the charge cou=
nter
> and manufacturing tolerances in the battery.
>=20
> Signed-off-by: Carl Philipp Klemm <philipp@uvos.xyz>
> ---
>  drivers/power/supply/cpcap-battery.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/=
cpcap-battery.c
> index 86ed41d9627f..8ae0c9c7ebcb 100644
> --- a/drivers/power/supply/cpcap-battery.c
> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -667,10 +667,22 @@ static int cpcap_battery_get_property(struct power_=
supply *psy,
>  		if (!empty->voltage)
>  			return -ENODATA;
>  		val->intval =3D empty->counter_uah - latest->counter_uah;
> -		if (val->intval < 0)
> +		if (val->intval < 0) {
> +			if (ddata->charge_full && abs(val->intval) > ddata->charge_full/5) {

Please add a comment what this check is doing. It's hard to grasp
without context of the commit when reading the driver at a later
point.

/* Assume invalid config if CHARGE_NOW is -20% */

> +				empty->voltage =3D 0;
> +				ddata->charge_full =3D 0;
> +				return -ENODATA;
> +			}
>  			val->intval =3D 0;
> -		else if (ddata->charge_full && ddata->charge_full < val->intval)
> +		}
> +		else if (ddata->charge_full && ddata->charge_full < val->intval) {

put closing curly bracket into the same line as the else. Also
please add sth. like

/* Assume invalid config if CHARGE_NOW exceeds CHARGE_FULL by 20% */

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
> @@ -747,7 +759,7 @@ static int cpcap_battery_set_property(struct power_su=
pply *psy,
>  	case POWER_SUPPLY_PROP_CHARGE_FULL:
>  		if (val->intval < 0)
>  			return -EINVAL;
> -		if (val->intval > ddata->config.info.charge_full_design)
> +		if (val->intval > (6*ddata->config.info.charge_full_design)/5)
>  			return -EINVAL;
> =20
>  		ddata->charge_full =3D val->intval;

-- Sebastian

--ssvre46dn3edmrrv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBqxlAACgkQ2O7X88g7
+pp+4A//WNcSZJnmCk+7d8molNw4pQC8m8OB59QVII+Uh9iOk7TldIrYs6n0Ph2n
TWRhrm7iDRkJhoJzSljtOeKJThXSY5enDGuGsIiTxwTO5EEUNGajbm2lOpbhTv8m
/FvKreJJdsEzNDdgwgDWuw+FCvkhw926YXipqmqYvZ2HaITefujWyfJ/avPRM6be
WUyRtFICYEsAcwI6wsD7OKqlNpTtut1CNcap4WiR1tqbFu9fTMivNrrhsyBVNEl1
8twbzEaIio8F3/C+RQlsx8qA0hDh+n/eyjZxPKI7yw4UFTxcYg6vc7CDvgCHSTA/
FDW1BHv91CVqe9tmnDVOOtUKDYtH4+H0h2RnRNwUuMo4A75JbtSko4FiJ9EI2+bS
o0NwDzknAeij2Bsk1UttjN3Ztb9JXHfbHc2653mbJt7sWq66MAkswejhCFWlqMrY
2CNUxi5GZc5HYCd0Oz6G9JKqxfUPZA+5jlP52dy6iGZqiuVM43Yr6uhUtTWyWMu7
O8frwXsfVGXEkXgi3jprXi49odvgBk5xNa3tqTO4GpqEAl9KzZUKRIMmIRe9d4mL
uChGycJkguvQMWulFLUIQMDsZyA3EGALvu7lsueQLBi+aR6qf3M3bXl5XJfq9Wf4
kn8Pm16Wxbe+m2EqvriAs+ND6qaAz++0PPRYlJEJtTxUBxbe4JI=
=wqOj
-----END PGP SIGNATURE-----

--ssvre46dn3edmrrv--
