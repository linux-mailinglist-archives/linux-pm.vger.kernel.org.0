Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6F81C2F6C
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 23:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgECVPw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 3 May 2020 17:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgECVPw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2020 17:15:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45385C061A0E;
        Sun,  3 May 2020 14:15:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id F31792A083E
Received: by earth.universe (Postfix, from userid 1000)
        id 955063C08C7; Sun,  3 May 2020 23:15:48 +0200 (CEST)
Date:   Sun, 3 May 2020 23:15:48 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 08/11] power: bq25890: implement PRECHARGE_CURRENT
 property
Message-ID: <20200503211548.vxbdno432hptfd62@earth.universe>
References: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
 <f6827f3c9a9666ac15e227220ef9efabf67e0caa.1588517058.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uififpnqqghvdmi2"
Content-Disposition: inline
In-Reply-To: <f6827f3c9a9666ac15e227220ef9efabf67e0caa.1588517058.git.mirq-linux@rere.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--uififpnqqghvdmi2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 03, 2020 at 05:21:13PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Report configured precharge current.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/bq25890_charger.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index ad0901fdceb6..b48685009048 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -497,6 +497,10 @@ static int bq25890_power_supply_get_property(struct =
power_supply *psy,
>  		val->intval =3D bq25890_find_val(bq->init_data.vreg, TBL_VREG);
>  		break;
> =20
> +	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +		val->intval =3D bq25890_find_val(bq->init_data.iprechg, TBL_ITERM);
> +		break;
> +
>  	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
>  		val->intval =3D bq25890_find_val(bq->init_data.iterm, TBL_ITERM);
>  		break;
> @@ -689,6 +693,7 @@ static const enum power_supply_property bq25890_power=
_supply_props[] =3D {
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
>  	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  };
> --=20
> 2.20.1
>=20

--uififpnqqghvdmi2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6vNIQACgkQ2O7X88g7
+pojRw/+KC0hY8OhUb02Aec5+3GVsERHAVS7bTM2+PYZtNCwPyE0T03jm3xJukWs
ohWpjbDUptGNRSRwL0ld7xW029yzmPD/P6bOkVxFeM5zomDTo7hiFnWzlyKKcZDF
vWbGpb0t6YlZAT74q6qNemnzd2POqUP2CBTSlBiaahKqyzVAaLUwRQxPrR9yzmMw
HlzM8eH+Ui8oJb/cjw8Zz2zQo+KuhmI57g1GFoKNDNCbqIy0ylxIPrCCOoIDgd0O
yluLDK78/hM+XTXpV6Ct8DiwtLUAPZUVme9WwLBO5xl629mVlkJcEOwoJc16Hmku
QY3OUsf/nb9DerWonXuGyLktztbzbFoaNijgRX1lEi7FWd9tHHFVJTUP0i0g4Md9
KNv6X164rGni6aZfGoum2RgAFvicWBBR7snsjXNUVpicWKC+ttRiPlSYFUK9g0EO
xClFu+XP/GIbJrXXiKh+3eH/sf/m428O52mUDZeC4bjg9WkagMBynyeisLnIeZtf
SPuy09kTIc/uvTpsrl6Dn7o3k/ngPLE84x5kJjckmTYOvBvOt2mNVovSspy6Bpre
mOeORfLb4vaOnbwMOM/NdOh9UbWATNTRVBsiiliHf4a3sftb2jVkNQWeR1ncVje3
aM0d+UsG2ngcpdiyDRaaL+5PDgKxozUjB15oJMb7j9gsxZc28+0=
=lyQH
-----END PGP SIGNATURE-----

--uififpnqqghvdmi2--
