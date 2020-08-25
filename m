Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF04251CDD
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 18:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHYQFG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 12:05:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60340 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgHYQFF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 12:05:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 21141299AB4
Received: by earth.universe (Postfix, from userid 1000)
        id 830E73C0C82; Tue, 25 Aug 2020 18:05:00 +0200 (CEST)
Date:   Tue, 25 Aug 2020 18:05:00 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Subject: Re: [PATCH] power: supply: bq2515x: Constify static variables
Message-ID: <20200825160500.wxigzcoergyrqapj@earth.universe>
References: <20200824232228.38423-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qi5obm626a6gxj6s"
Content-Disposition: inline
In-Reply-To: <20200824232228.38423-1-rikard.falkeborn@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qi5obm626a6gxj6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 25, 2020 at 01:22:28AM +0200, Rikard Falkeborn wrote:
> Constify a number of static variables that are not modified to allow the
> compiler to put them in read-only memory.
>=20
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq2515x_charger.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq2515x_charger.c b/drivers/power/suppl=
y/bq2515x_charger.c
> index 36b0c8c98d40..9dcb61ea4cf2 100644
> --- a/drivers/power/supply/bq2515x_charger.c
> +++ b/drivers/power/supply/bq2515x_charger.c
> @@ -188,7 +188,7 @@ struct bq2515x_device {
>  	struct bq2515x_init_data init_data;
>  };
> =20
> -static struct reg_default bq25150_reg_defaults[] =3D {
> +static const struct reg_default bq25150_reg_defaults[] =3D {
>  	{BQ2515X_FLAG0, 0x0},
>  	{BQ2515X_FLAG1, 0x0},
>  	{BQ2515X_FLAG2, 0x0},
> @@ -227,7 +227,7 @@ static struct reg_default bq25150_reg_defaults[] =3D {
>  	{BQ2515X_DEVICE_ID, 0x20},
>  };
> =20
> -static struct reg_default bq25155_reg_defaults[] =3D {
> +static const struct reg_default bq25155_reg_defaults[] =3D {
>  	{BQ2515X_FLAG0, 0x0},
>  	{BQ2515X_FLAG1, 0x0},
>  	{BQ2515X_FLAG2, 0x0},
> @@ -886,14 +886,14 @@ static int bq2515x_battery_get_property(struct powe=
r_supply *psy,
>  	return 0;
>  }
> =20
> -static enum power_supply_property bq2515x_battery_properties[] =3D {
> +static const enum power_supply_property bq2515x_battery_properties[] =3D=
 {
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  	POWER_SUPPLY_PROP_CURRENT_NOW,
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
>  };
> =20
> -static enum power_supply_property bq2515x_mains_properties[] =3D {
> +static const enum power_supply_property bq2515x_mains_properties[] =3D {
>  	POWER_SUPPLY_PROP_ONLINE,
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_HEALTH,
> @@ -905,7 +905,7 @@ static enum power_supply_property bq2515x_mains_prope=
rties[] =3D {
>  	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
>  };
> =20
> -static struct power_supply_desc bq2515x_mains_desc =3D {
> +static const struct power_supply_desc bq2515x_mains_desc =3D {
>  	.name			=3D "bq2515x-mains",
>  	.type			=3D POWER_SUPPLY_TYPE_MAINS,
>  	.get_property		=3D bq2515x_mains_get_property,
> @@ -915,7 +915,7 @@ static struct power_supply_desc bq2515x_mains_desc =
=3D {
>  	.property_is_writeable	=3D bq2515x_power_supply_property_is_writeable,
>  };
> =20
> -static struct power_supply_desc bq2515x_battery_desc =3D {
> +static const struct power_supply_desc bq2515x_battery_desc =3D {
>  	.name			=3D "bq2515x-battery",
>  	.type			=3D POWER_SUPPLY_TYPE_BATTERY,
>  	.get_property		=3D bq2515x_battery_get_property,
> --=20
> 2.28.0
>=20

--qi5obm626a6gxj6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9FNqIACgkQ2O7X88g7
+ppT7hAAkzQO5mGX9BUXEjs4drahR2s3CGaToZ4uHFLxPruncGAO6FRiNeXbSCxF
GDl2O6Bv2oDSX7vKQqs0KgVE3VB+SiWj8OV9aNhTbAqjJQR587qnagBB7p0UZg3l
uHUMSJAVy8YOyx2AOUuVovqX9FsRoKcg3QhpH/dNGCxiM+Lpps1H2lHllH5fNSZV
St8grBKX2NG1Azgnr2CG2TS3lnNL5bmJt1AdpPduR0KmHSFjXz/VgPmmQjdsxo91
2i+r2B4Re/UZ+EEIMRp0vzSm/Ak08aGkIsJTYi9MtIRx8aBUnOm6wNP7lZCkNeuZ
LkqFVuOnZDbAOYTuRTTeVX/zbddJNuVf/yNTzMm+rA4At2s9rO5eoi533Bz8/+8w
qhBrpXSj2Nr65FATcm6x6WKDSX4F1LV6yXWuYu3PYNEVEkxKlKTYSYaqCwFOI0pD
LpCRYFCsz8qBmW9AOY0eyDPY1aXNKJ7cuNALh8oYM48P1e/zaLxICLBEr3fZzojk
4sokMfNUr5yc4U0T1GY5SIFP5Hj50Z/c6Q+o/Wr+RCQk+dh/UnDccDcMHckFufNK
3/jWZFmtxWNheQflCzesx9oBaU6ukmO9DEPeqPLC6Uu5HRP/aZGo6NuMvjUHKHBL
GGhGR1C0L539j4RqO0k2u91pvWnjvd8CSjP31AT5KBonMnwJv0E=
=DTzh
-----END PGP SIGNATURE-----

--qi5obm626a6gxj6s--
