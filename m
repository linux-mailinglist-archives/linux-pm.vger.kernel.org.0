Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0103745311E
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 12:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbhKPLrv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 06:47:51 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35868 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbhKPLrL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 06:47:11 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 78C4A1F42CB5
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637063051; bh=vVA/QdB0Ucp24f3kIvG7bRDoabhfxVW1tWo5G0+jflQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kc+t1Y+yYBRJDZyZqJ/6VaplAci4ENJ+C2eg/jpzlxCpcz31T1tdzomlkzsGv5D5w
         OuR1ooR1hIQYIO/BJB4GjaFCY4Cj4V2v6LEj7rGgkGh54bAU00ZyYAoytkQFW/+tnJ
         GKm5bvtfNJPLPJCVWYHNBFXwfQY+usQ8B8mkHouNz+A43M9zK5UKnjTZD8+wc4bYRV
         v2CmcQbt+22PReI4pyUu+roiOqOWpT9eiAiiTV0q0ttjsp93EiCjERXmSGOY6SU3by
         sqhkNcu/EyiwI6gWKNzkwRsOLaGqrAQKhmq1kFktlVOSXzSFVaeTlZsN9iw7qXJKPi
         8cf7qD3VRXoSA==
Received: by earth.universe (Postfix, from userid 1000)
        id AC92B3C0F95; Tue, 16 Nov 2021 12:44:08 +0100 (CET)
Date:   Tue, 16 Nov 2021 12:44:08 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Angus Ainslie <angus@akkea.ca>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCH] power: bq25890: add POWER_SUPPLY_PROP_TEMP
Message-ID: <20211116114408.qqfiqtkgxkxorupu@earth.universe>
References: <20211115180253.124271-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d4chpmv5its2jbsn"
Content-Disposition: inline
In-Reply-To: <20211115180253.124271-1-angus@akkea.ca>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--d4chpmv5its2jbsn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 15, 2021 at 10:02:54AM -0800, Angus Ainslie wrote:
> Add the POWER_SUPPLY_PROP_TEMP and a NTC 10K percent VREGN to degrees LUT.
>=20
> Sorry I didn't realize this patch was not upstream yet and was just in ou=
r=20
> tree. It should have been applied before:
>=20
> https://lore.kernel.org/linux-pm/20211110002440.71404-1-angus@akkea.ca/

Indeed. I dropped that patch from the fixes queue. Please squash it
into this one and Cc Hans de Goede on your next submission, so that
he can test on his hardware.

Thanks,

-- Sebastian

> Signed-off-by: Angus Ainslie <angus@akkea.ca>
> ---
>  drivers/power/supply/bq25890_charger.c | 36 +++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index 945c3257ca93..7f52029f0702 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -266,6 +266,7 @@ enum bq25890_table_ids {
>  	/* lookup tables */
>  	TBL_TREG,
>  	TBL_BOOSTI,
> +	TBL_TSPCT,
>  };
> =20
>  /* Thermal Regulation Threshold lookup table, in degrees Celsius */
> @@ -280,6 +281,28 @@ static const u32 bq25890_boosti_tbl[] =3D {
> =20
>  #define BQ25890_BOOSTI_TBL_SIZE		ARRAY_SIZE(bq25890_boosti_tbl)
> =20
> +/* NTC 10K temperature lookup table in thenths of a degree */
> +static const u32 bq25890_tspct_tbl[] =3D {
> +	850, 840, 830, 820, 810, 800, 790, 780,
> +	770, 760, 750, 740, 730, 720, 710, 700,
> +	690, 685, 680, 675, 670, 660, 650, 645,
> +	640, 630, 620, 615, 610, 600, 590, 585,
> +	580, 570, 565, 560, 550, 540, 535, 530,
> +	520, 515, 510, 500, 495, 490, 480, 475,
> +	470, 460, 455, 450, 440, 435, 430, 425,
> +	420, 410, 405, 400, 390, 385, 380, 370,
> +	365, 360, 355, 350, 340, 335, 330, 320,
> +	310, 305, 300, 290, 285, 280, 275, 270,
> +	260, 250, 245, 240, 230, 225, 220, 210,
> +	205, 200, 190, 180, 175, 170, 160, 150,
> +	145, 140, 130, 120, 115, 110, 100, 90,
> +	80, 70, 60, 50, 40, 30, 20, 10,
> +	0, -10, -20, -30, -40, -60, -70, -80,
> +	-90, -10, -120, -140, -150, -170, -190, -210,
> +};
> +
> +#define BQ25890_TSPCT_TBL_SIZE		ARRAY_SIZE(bq25890_tspct_tbl)
> +
>  struct bq25890_range {
>  	u32 min;
>  	u32 max;
> @@ -308,7 +331,8 @@ static const union {
> =20
>  	/* lookup tables */
>  	[TBL_TREG] =3D	{ .lt =3D {bq25890_treg_tbl, BQ25890_TREG_TBL_SIZE} },
> -	[TBL_BOOSTI] =3D	{ .lt =3D {bq25890_boosti_tbl, BQ25890_BOOSTI_TBL_SIZE=
} }
> +	[TBL_BOOSTI] =3D	{ .lt =3D {bq25890_boosti_tbl, BQ25890_BOOSTI_TBL_SIZE=
} },
> +	[TBL_TSPCT] =3D	{ .lt =3D {bq25890_tspct_tbl, BQ25890_TSPCT_TBL_SIZE} }
>  };
> =20
>  static int bq25890_field_read(struct bq25890_device *bq,
> @@ -528,6 +552,15 @@ static int bq25890_power_supply_get_property(struct =
power_supply *psy,
>  		val->intval =3D ret * -50000;
>  		break;
> =20
> +	case POWER_SUPPLY_PROP_TEMP:
> +		ret =3D bq25890_field_read(bq, F_TSPCT);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* convert TS percentage into rough temperature */
> +		val->intval =3D bq25890_find_val(ret, TBL_TSPCT);
> +		break;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -713,6 +746,7 @@ static const enum power_supply_property bq25890_power=
_supply_props[] =3D {
>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_TEMP,
>  };
> =20
>  static char *bq25890_charger_supplied_to[] =3D {
> --=20
> 2.25.1
>=20

--d4chpmv5its2jbsn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGTmXcACgkQ2O7X88g7
+ppwcQ//dc61BlxwVp//O9WWeuzLSaHFi0OitnNAUG3Qx1CWrP0T8de+cxJgb8SJ
RIc2CsfbDodgk8w9PIVVw17RhliPeTvsQYkwuvOcCedoCp61iyhzc2w4dbMwfRyA
FVqdFDeZgWoEzmKYlVjfTJTw3ncej+zsg1qwCPiUBtpLntsgASeqiW4TxLZEoraT
0zH+75MoNoUEtVUn7GI3GhWuvb6RxknbW5mKerkO3lz6Plo80i2f1Cu4wwpJfUez
1+Feih3C0jfehM01/g3tm6a/CwrZsAUmv6botjQ6y7f3zYgmMfXrc7C0dw9yazPI
YlM3v5KxxVx+odBoGmAGFsnsr+HsHQQUBcZP7reE8CeHkXtSzjQ5XhYndfQ4UavE
yXD7hv0O6UAxPd+2WEkoS8yR8aeTeQC+9evex/DaP8z6wl4GkZh0sesxdm8sjp/S
SgcjiwZbBNoRQ6PWDvZUkhXys/TH8iI9yV3cJWZdzwqsz5T4SuG0/6uSVC/bLueq
G0pgQ/3oiLyEullcD092PNC6refVY1B0+DFgwLIN7D+QhLP5iawx0s5X1ZMUNgIn
lmSJdYZwTyv92lktiEYF4ZfDUgObmbWl+BHE2ex62iwK1+Tv6hr+ty2/i3bbfJzG
BpEXNAA4b4tRp2pXk8I8q9qTqY5sXCLkFa8LZCgdyhf0sSV6hFY=
=Z+CS
-----END PGP SIGNATURE-----

--d4chpmv5its2jbsn--
