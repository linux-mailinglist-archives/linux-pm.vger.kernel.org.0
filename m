Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624BA39B8E7
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 14:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhFDMWf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 08:22:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34804 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhFDMWe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 08:22:34 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 4940B1F415FC
Received: by earth.universe (Postfix, from userid 1000)
        id 4A8433C0C95; Fri,  4 Jun 2021 14:20:45 +0200 (CEST)
Date:   Fri, 4 Jun 2021 14:20:45 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] power: supply: axp20x_battery: implement writeable
 status to enable/disable battery charging
Message-ID: <20210604122045.itugfiivy5il5bkz@earth.universe>
References: <20210421090354.GF19953@lemon.iwr.uni-heidelberg.de>
 <CAGb2v64U3vMew8LUU776Mx7jYj3eVb4FXQdXMZ0aJNBPUh2D2A@mail.gmail.com>
 <20210505112902.GC5302@lemon.iwr.uni-heidelberg.de>
 <CAGb2v64UN6=26QiQLqSWmNJPo49bPOQ3Q-Oz=LsbZz3JcszU0Q@mail.gmail.com>
 <20210510131804.GP11983@lemon.iwr.uni-heidelberg.de>
 <20210512105856.GA15727@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fwpzoq2jvtqjw6gp"
Content-Disposition: inline
In-Reply-To: <20210512105856.GA15727@lemon.iwr.uni-heidelberg.de>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--fwpzoq2jvtqjw6gp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 12, 2021 at 12:58:56PM +0200, Hermann Lauer wrote:
> Allow disabling and reenabling battery charging of an axp209 PMIC through=
 a
> writable status property. With the current driver code charging is always=
 on.
>=20
> This works on the axp209 of Banana {Pi M1+,Pro} and should work on all AX=
P chips.
>=20
> Signed-off-by: Hermann.Lauer@uni-heidelberg.de
> ---

Thanks, queued.

-- Sebastian

> v2: add fallthrough and improve commit message (thanks to Maxime and Chen=
Yu)
> v3: fix fallthrough usage
>=20
> Thanks to ChenYu for the idea and greetings
>   Hermann
>=20
>  drivers/power/supply/axp20x_battery.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply=
/axp20x_battery.c
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -40,6 +40,7 @@
>  #define AXP209_FG_PERCENT		GENMASK(6, 0)
>  #define AXP22X_FG_VALID			BIT(7)
> =20
> +#define AXP20X_CHRG_CTRL1_ENABLE	BIT(7)
>  #define AXP20X_CHRG_CTRL1_TGT_VOLT	GENMASK(6, 5)
>  #define AXP20X_CHRG_CTRL1_TGT_4_1V	(0 << 5)
>  #define AXP20X_CHRG_CTRL1_TGT_4_15V	(1 << 5)
> @@ -468,7 +469,18 @@
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
>  		return axp20x_set_max_constant_charge_current(axp20x_batt,
>  							      val->intval);
> +	case POWER_SUPPLY_PROP_STATUS:
> +		switch (val->intval) {
> +		case POWER_SUPPLY_STATUS_CHARGING:
> +			return regmap_update_bits(axp20x_batt->regmap, AXP20X_CHRG_CTRL1,
> +				AXP20X_CHRG_CTRL1_ENABLE, AXP20X_CHRG_CTRL1_ENABLE);
> =20
> +		case POWER_SUPPLY_STATUS_DISCHARGING:
> +		case POWER_SUPPLY_STATUS_NOT_CHARGING:
> +			return regmap_update_bits(axp20x_batt->regmap, AXP20X_CHRG_CTRL1,
> +				AXP20X_CHRG_CTRL1_ENABLE, 0);
> +		}
> +		fallthrough;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -491,7 +503,8 @@
>  static int axp20x_battery_prop_writeable(struct power_supply *psy,
>  					 enum power_supply_property psp)
>  {
> -	return psp =3D=3D POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN ||
> +	return psp =3D=3D POWER_SUPPLY_PROP_STATUS ||
> +	       psp =3D=3D POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN ||
>  	       psp =3D=3D POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN ||
>  	       psp =3D=3D POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT ||
>  	       psp =3D=3D POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX;

--fwpzoq2jvtqjw6gp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC6GpQACgkQ2O7X88g7
+prBhBAAj2NlkEeOOAOh6GLN3xrV4Sx2+H5w/kwXzxSghPjMIq0WyICTLoORnuPw
iwTSVWg7sCOgKKCE10LDwyhKkkuhVBz/Y8NyWnv9MitmIDk0eXwquBvswjtL+pqv
yceOGUEA0+FwV2YVkZjQa+TasIdBKo9Zk2sbiHZ/3QFi1H/9k5RXjrYTxOxrSZsr
zNMckIN5ZaUnxmwwAZWMCa6urjsMM0+5XsjOiAGbCwgZwsnSeOeBLwaQFqWXrIKS
g0Jg1uEyb0C62FZhtbBEIj2GMF8nTg/hFQiLRHC+xSnxV+v5m/2OGMyySfGiCN4M
nj1ZzMtYozFYYdEVB3lht+w633WDmmZw4tLxvt80hF9x4RdFYcqxk8fJxwjvKLnq
eRq1WLgwQTQFK3fSJceLt6gtnCijo2F95Cob8Ene1EnSHrrez9szZTobn5FHw/oA
x4lvXqLa+InfCDLlK0KQC4DJo32mfho27P+r0RJL1fExdsvV8CJTxNNMeKxIjEQo
evbAOiSZOd5P91wWPna11/5cHybdnFIVRC7SdAVt2TddDfddTeaUX0ZLTmd/Z8vP
DvjUmR2ZoGnkooURBJ1q4c5C5L1LDyuK6fTJbSZecDnVKu9sWhIPbQbtFwqHPGbo
MzU2IeigOgWMsttKwYsL2R1FuuTAdGfviVnRL2Kev+x076bZEY4=
=Ffeg
-----END PGP SIGNATURE-----

--fwpzoq2jvtqjw6gp--
