Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD2339B8A1
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 14:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhFDMDr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 08:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhFDMDq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 08:03:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361B7C06174A;
        Fri,  4 Jun 2021 05:02:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 0ED591F43977
Received: by earth.universe (Postfix, from userid 1000)
        id 5D6253C0C95; Fri,  4 Jun 2021 14:01:56 +0200 (CEST)
Date:   Fri, 4 Jun 2021 14:01:56 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Matheus Castello <matheus@castello.eng.br>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFT PATCH 1/3] power: supply: max17040: remove non-working
 POWER_SUPPLY_PROP_STATUS
Message-ID: <20210604120156.l2nglxbh5mayciri@earth.universe>
References: <20210507161927.105862-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f3bvyjsnlrfsxl4t"
Content-Disposition: inline
In-Reply-To: <20210507161927.105862-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--f3bvyjsnlrfsxl4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 07, 2021 at 12:19:25PM -0400, Krzysztof Kozlowski wrote:
> The driver was reporting POWER_SUPPLY_PROP_STATUS via platform data
> functions.  Without platform data, the max17040_get_status() functions
> returns early with POWER_SUPPLY_STATUS_UNKNOWN.  Since there are no
> platforms using the driver with platform data (no board files with the
> driver), the status property was always unknown.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Thanks, I queued the series.

-- Sebastian

>  drivers/power/supply/max17040_battery.c | 32 +++----------------------
>  1 file changed, 3 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supp=
ly/max17040_battery.c
> index 1aab868adabf..12854c87df53 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -147,8 +147,6 @@ struct max17040_chip {
> =20
>  	/* battery capacity */
>  	int soc;
> -	/* State Of Charge */
> -	int status;
>  	/* Low alert threshold from 32% to 1% of the State of Charge */
>  	u32 low_soc_alert;
>  	/* some devices return twice the capacity */
> @@ -225,24 +223,6 @@ static int max17040_get_online(struct max17040_chip =
*chip)
>  		chip->pdata->battery_online() : 1;
>  }
> =20
> -static int max17040_get_status(struct max17040_chip *chip)
> -{
> -	if (!chip->pdata || !chip->pdata->charger_online
> -			|| !chip->pdata->charger_enable)
> -		return POWER_SUPPLY_STATUS_UNKNOWN;
> -
> -	if (max17040_get_soc(chip) > MAX17040_BATTERY_FULL)
> -		return POWER_SUPPLY_STATUS_FULL;
> -
> -	if (chip->pdata->charger_online())
> -		if (chip->pdata->charger_enable())
> -			return POWER_SUPPLY_STATUS_CHARGING;
> -		else
> -			return POWER_SUPPLY_STATUS_NOT_CHARGING;
> -	else
> -		return POWER_SUPPLY_STATUS_DISCHARGING;
> -}
> -
>  static int max17040_get_of_data(struct max17040_chip *chip)
>  {
>  	struct device *dev =3D &chip->client->dev;
> @@ -283,7 +263,6 @@ static int max17040_get_of_data(struct max17040_chip =
*chip)
>  static void max17040_check_changes(struct max17040_chip *chip)
>  {
>  	chip->soc =3D max17040_get_soc(chip);
> -	chip->status =3D max17040_get_status(chip);
>  }
> =20
>  static void max17040_queue_work(struct max17040_chip *chip)
> @@ -302,17 +281,16 @@ static void max17040_stop_work(void *data)
>  static void max17040_work(struct work_struct *work)
>  {
>  	struct max17040_chip *chip;
> -	int last_soc, last_status;
> +	int last_soc;
> =20
>  	chip =3D container_of(work, struct max17040_chip, work.work);
> =20
> -	/* store SOC and status to check changes */
> +	/* store SOC to check changes */
>  	last_soc =3D chip->soc;
> -	last_status =3D chip->status;
>  	max17040_check_changes(chip);
> =20
>  	/* check changes and send uevent */
> -	if (last_soc !=3D chip->soc || last_status !=3D chip->status)
> +	if (last_soc !=3D chip->soc)
>  		power_supply_changed(chip->battery);
> =20
>  	max17040_queue_work(chip);
> @@ -415,9 +393,6 @@ static int max17040_get_property(struct power_supply =
*psy,
>  	struct max17040_chip *chip =3D power_supply_get_drvdata(psy);
> =20
>  	switch (psp) {
> -	case POWER_SUPPLY_PROP_STATUS:
> -		val->intval =3D max17040_get_status(chip);
> -		break;
>  	case POWER_SUPPLY_PROP_ONLINE:
>  		val->intval =3D max17040_get_online(chip);
>  		break;
> @@ -444,7 +419,6 @@ static const struct regmap_config max17040_regmap =3D=
 {
>  };
> =20
>  static enum power_supply_property max17040_battery_props[] =3D {
> -	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_ONLINE,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  	POWER_SUPPLY_PROP_CAPACITY,
> --=20
> 2.25.1
>=20

--f3bvyjsnlrfsxl4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC6FjQACgkQ2O7X88g7
+pqwbQ//ZwSSeTLVKSkB64kWjXCnweTMNLWruq5Ggbb6ug4KFqsS2pb91fSQraES
aEQchk/0DqJa0HDqHhGgfukuFycYUQJaax5ZUkuDk294e8Pev872m4S5fY9UpknE
4oFKyYD+0z5/S1iZ9Htlt3kesrHjJKG1nGNe53+nVlFB1syC/jKE3b7KTG6yAdcS
K4Ugsc2wI0LfxdYPTtKrUxLBGod0ufVv/W6K8MW9/gedHoSVbvqmtKrLZwdTJDEI
4qgvWzAO6CsMbM6IY3Sie/f4yyWuV8V0CIeFzK/PDGhF5F2PgqkeEJjf1YATQRBE
W4ybZ7bBvcLPoLgNIid9PwkC4nmv0ItekmOmESbEopqf+lHH99IocQeuxmw3RDf0
x2Oiu8GfLXZHrazrsSHmoMc1son9VMEBB3cg336oqSbEeUGMWzzkRPFBGaaoYzO2
EoAkFPuRacu1Ixhp9rysgqO2QHx1bX7NgPPU3iGTZMPWU9CWnEfAne+yV8Qjknua
b2FjXzeBzLHFag0PvCOFSnJ5fTYXPOVw3jUrcvTaw1sdJyrzYhLW5yXblfjg0CxE
MjL8pf/xzKxt6U9gwD5XO7jPBXWFLO8gRQ+5SU7KUcrY2vhu5HwUnkxBrr+76Gx6
D+KNqTIx3OwqXPdwEXy6Yob8gYgPDo8X5bt/DurA9iIF8UoTEE4=
=6ejI
-----END PGP SIGNATURE-----

--f3bvyjsnlrfsxl4t--
