Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711461C169F
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 16:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbgEANvP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 09:51:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60814 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbgEANvO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 09:51:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 05E862A27A1
Received: by earth.universe (Postfix, from userid 1000)
        id 8FED63C08C7; Fri,  1 May 2020 15:51:09 +0200 (CEST)
Date:   Fri, 1 May 2020 15:51:09 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: charger-manager: fix adding of optional properties
Message-ID: <20200501135109.45gwxpczcqdt3fbb@earth.universe>
References: <20200501133008.GA8927@qmqm.qmqm.pl>
 <995cf2c7d41d4895c319b60ea4ea83e858c34cef.1588340276.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nnhgdofmvnbyk45e"
Content-Disposition: inline
In-Reply-To: <995cf2c7d41d4895c319b60ea4ea83e858c34cef.1588340276.git.mirq-linux@rere.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--nnhgdofmvnbyk45e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 01, 2020 at 03:39:53PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Use num_properties to index added property.
> This will prevent overwriting POWER_SUPPLY_PROP_CHARGE_NOW with
> POWER_SUPPLY_PROP_CURRENT_NOW and leaving the latter entry
> uninitialized.
>=20
> For clarity, num_properties is initialized with length of the copied
> array instead of relying on previously memcpy'd value.
>=20
> Fixes: 0a46510addc7 ("power: supply: charger-manager: Prepare for const p=
roperties")
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---

I folded your fix directly into the charger-manager patch, which did
not yet reach linux-next. If you send the num_properties part as a
separate one, I will merge it.

-- Sebastian

>  drivers/power/supply/charger-manager.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/suppl=
y/charger-manager.c
> index a71e2ee81423..2ef53dc1f2fb 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -1729,7 +1729,7 @@ static int charger_manager_probe(struct platform_de=
vice *pdev)
>  	memcpy(properties, default_charger_props,
>  		sizeof(enum power_supply_property) *
>  		ARRAY_SIZE(default_charger_props));
> -	num_properties =3D psy_default.num_properties;
> +	num_properties =3D ARRAY_SIZE(default_charger_props);
> =20
>  	/* Find which optional psy-properties are available */
>  	fuel_gauge =3D power_supply_get_by_name(desc->psy_fuel_gauge);
> @@ -1740,14 +1740,14 @@ static int charger_manager_probe(struct platform_=
device *pdev)
>  	}
>  	if (!power_supply_get_property(fuel_gauge,
>  					  POWER_SUPPLY_PROP_CHARGE_NOW, &val)) {
> -		properties[cm->charger_psy_desc.num_properties] =3D
> +		properties[num_properties] =3D
>  				POWER_SUPPLY_PROP_CHARGE_NOW;
>  		num_properties++;
>  	}
>  	if (!power_supply_get_property(fuel_gauge,
>  					  POWER_SUPPLY_PROP_CURRENT_NOW,
>  					  &val)) {
> -		properties[cm->charger_psy_desc.num_properties] =3D
> +		properties[num_properties] =3D
>  				POWER_SUPPLY_PROP_CURRENT_NOW;
>  		num_properties++;
>  	}
> --=20
> 2.20.1
>=20

--nnhgdofmvnbyk45e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6sKU0ACgkQ2O7X88g7
+prZSw//S5LEfAIdeKAPy6jnJ9RFL7hieePdJ0YZBueIL+JPtexJh4Sjj/6EnfMy
77/oGQaqSZQixx2KLbnlgR56FuA4gnPUi9ynxkOasozzar0VKYroySPmGJxtP2ID
7P2ErJg0kU2cYvyaIP4EUOFqTxHCrAiEaWHGjaaCK5pKZ7b2WER62zsL2Lj3oO7x
7ncSoVCTIxu0O0AEXVafs8v0o63zQGkk2zPTcmjKMtbPW8QCZBXpBAsGuy9v945J
xg8LVGRfyuR8vP71ZgPLaA+NCJIew6iLH/l4RVgs5iDAuN2VnJn5OARA/7ZNfOxx
Gxr/0y7L2RGlrj69XsFFbgSR/5xiFDMZCQ6aK3YK182L413+FGswH/v+8ypcW2cP
r2OzHj3FwWTUdyHzcZyXMzVYXaFkLZBiAcDTqAN3OQApSlwRDAX4bB98cckEXsko
C7hc6C6vIvvQO/roKN5V3IlLJ5k2cCE/Tf4pK3ABiGdwvQkkSMVsSTx3RK3TYaQ/
otBKDuHt5sgpLlvVxdwiljOLiyTYmkeheB/qYR+wWGwJySwRbKnbaa1sL/iy4N7F
yiQ8evjn4e0FBl8qSK1+GnXVU02dalVM+cEFrxu1DezlBHZxzh0x1Pj/Da0ezL0/
3CMQNR2F2Lwu0Gom/AI0JieGBmtoz49P8X24xy1aPg+fQGt0hyE=
=gvbx
-----END PGP SIGNATURE-----

--nnhgdofmvnbyk45e--
