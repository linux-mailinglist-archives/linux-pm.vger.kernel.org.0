Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44090A5C93
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 21:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfIBTNd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 15:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbfIBTNd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Sep 2019 15:13:33 -0400
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 772ED21883;
        Mon,  2 Sep 2019 19:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567451611;
        bh=2emdnbkw/A2Qn2r3YgBO+VwF9EdlPA7DAXyWwEZc5mU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UpOmjm5BXMBI12HnTpIeEPIQrVWfy1XfhdJNsBh8oKK+9/4aIrMvnzhtGjsQARnFX
         e2Jk3yKxI1zkMVJ/nfm5pjJf8XFKPxoxpHZgmIZg+O41ordkK4h+mqbPJk4so4k8a8
         sleKM+FCJGEQcLQ2Bzqro3qd5NdAmbY4HnMv40n0=
Received: by earth.universe (Postfix, from userid 1000)
        id 3D59B3C0B7F; Mon,  2 Sep 2019 21:13:29 +0200 (CEST)
Date:   Mon, 2 Sep 2019 21:13:29 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, krzk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq25890_charger: Add the BQ25895 part
Message-ID: <20190902191329.3fef5pmbf3ootov2@earth.universe>
References: <20190705113751.18116-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bgvlxohmiwmitvjc"
Content-Disposition: inline
In-Reply-To: <20190705113751.18116-1-angus@akkea.ca>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--bgvlxohmiwmitvjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 05, 2019 at 05:37:51AM -0600, Angus Ainslie (Purism) wrote:
> The BQ25895 is almost identical to the BQ25890.
>=20
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq25890_charger.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index d333f2b321b9..9d1ec8d677de 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -22,6 +22,7 @@
>  #define BQ25890_IRQ_PIN			"bq25890_irq"
> =20
>  #define BQ25890_ID			3
> +#define BQ25895_ID			7
>  #define BQ25896_ID			0
> =20
>  enum bq25890_fields {
> @@ -171,7 +172,7 @@ static const struct reg_field bq25890_reg_fields[] =
=3D {
>  	[F_WD]			=3D REG_FIELD(0x07, 4, 5),
>  	[F_TMR_EN]		=3D REG_FIELD(0x07, 3, 3),
>  	[F_CHG_TMR]		=3D REG_FIELD(0x07, 1, 2),
> -	[F_JEITA_ISET]		=3D REG_FIELD(0x07, 0, 0),
> +	[F_JEITA_ISET]		=3D REG_FIELD(0x07, 0, 0), // reserved on BQ25895
>  	/* REG08 */
>  	[F_BATCMP]		=3D REG_FIELD(0x08, 5, 7),
>  	[F_VCLAMP]		=3D REG_FIELD(0x08, 2, 4),
> @@ -180,7 +181,7 @@ static const struct reg_field bq25890_reg_fields[] =
=3D {
>  	[F_FORCE_ICO]		=3D REG_FIELD(0x09, 7, 7),
>  	[F_TMR2X_EN]		=3D REG_FIELD(0x09, 6, 6),
>  	[F_BATFET_DIS]		=3D REG_FIELD(0x09, 5, 5),
> -	[F_JEITA_VSET]		=3D REG_FIELD(0x09, 4, 4),
> +	[F_JEITA_VSET]		=3D REG_FIELD(0x09, 4, 4), // reserved on BQ25895
>  	[F_BATFET_DLY]		=3D REG_FIELD(0x09, 3, 3),
>  	[F_BATFET_RST_EN]	=3D REG_FIELD(0x09, 2, 2),
>  	[F_PUMPX_UP]		=3D REG_FIELD(0x09, 1, 1),
> @@ -188,7 +189,7 @@ static const struct reg_field bq25890_reg_fields[] =
=3D {
>  	/* REG0A */
>  	[F_BOOSTV]		=3D REG_FIELD(0x0A, 4, 7),
>  	/* PFM_OTG_DIS 3 on BQ25896 */
> -	[F_BOOSTI]		=3D REG_FIELD(0x0A, 0, 2),
> +	[F_BOOSTI]		=3D REG_FIELD(0x0A, 0, 2), // reserved on BQ25895
>  	/* REG0B */
>  	[F_VBUS_STAT]		=3D REG_FIELD(0x0B, 5, 7),
>  	[F_CHG_STAT]		=3D REG_FIELD(0x0B, 3, 4),
> @@ -392,6 +393,8 @@ static int bq25890_power_supply_get_property(struct p=
ower_supply *psy,
>  	case POWER_SUPPLY_PROP_MODEL_NAME:
>  		if (bq->chip_id =3D=3D BQ25890_ID)
>  			val->strval =3D "BQ25890";
> +		else if (bq->chip_id =3D=3D BQ25895_ID)
> +			val->strval =3D "BQ25895";
>  		else if (bq->chip_id =3D=3D BQ25896_ID)
>  			val->strval =3D "BQ25896";
>  		else
> @@ -862,7 +865,8 @@ static int bq25890_probe(struct i2c_client *client,
>  		return bq->chip_id;
>  	}
> =20
> -	if ((bq->chip_id !=3D BQ25890_ID) && (bq->chip_id !=3D BQ25896_ID)) {
> +	if ((bq->chip_id !=3D BQ25890_ID) && (bq->chip_id !=3D BQ25895_ID)
> +			&& (bq->chip_id !=3D BQ25896_ID)) {
>  		dev_err(dev, "Chip with ID=3D%d, not supported!\n", bq->chip_id);
>  		return -ENODEV;
>  	}
> --=20
> 2.17.1
>=20

--bgvlxohmiwmitvjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1tadkACgkQ2O7X88g7
+prufA//alEGqOkxLUo5wi0lHGBnAyZ6XfVqTevdgayoqCxYYXV8e+MXy5JZ8Sol
suJKne5GwLkmSW1EiJ60gTNHV3vUjbAq1gj0I7xvZUYG1hecfE8kWwTplOZiyU3E
fDB0uNtnajJr+syYWDAwFXejmzN65Zlro7e5Gx1lnz8f5lTvwASHvMUtCwZj+/wK
C0yEiwpNu8ZzykKJyl1OG8eqbmfGprVr+512QteYsrxNADuPSLz6CmxRpgkAW7Pz
n1fKMK5YTOXkooq55QFAY1JNsAkee3qGQbdDb5F9fWzN7K4bu6gTz3mIA52SuiN6
r4zRRwXkSFSStfGhzEoHp0SjKoI9Bmy6JL6xlF/IQs1JQ1Jt0GiMDQETT/M6CUhz
5xqV7aFHOUToPRghMbUVojw0oC5x+961W7bgWsS6tMKX+klW1JGiwyt7pvktmGhI
M/28UNHbnAIlWt++weaT49kNJW7vGwJyuCr7XprFsDRTiuVHxHJjC+r6XmU46kCJ
zHBcJuaG5h1Nx4DaNUWEs3WPbp/wBff0Yc+VLbqFIvEwqjQj6zwW6p09aZnEwgYx
bXXQXOGl2eFj24ARS3cf2QO8tTLLMrXnUzI0FX9CHBTPojK79e98R1CkzHkCOG7u
m1ZSRCrvPLVqkik2wplPddZaB3q7ke78zEW8oZPppPgLLU9gZB8=
=Zbr9
-----END PGP SIGNATURE-----

--bgvlxohmiwmitvjc--
