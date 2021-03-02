Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2745932B344
	for <lists+linux-pm@lfdr.de>; Wed,  3 Mar 2021 04:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352511AbhCCDue (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 22:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839713AbhCBQh6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Mar 2021 11:37:58 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB8BC061356;
        Tue,  2 Mar 2021 08:22:09 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 3CC4A1F4584E
Received: by earth.universe (Postfix, from userid 1000)
        id CEE743C0C96; Tue,  2 Mar 2021 17:22:05 +0100 (CET)
Date:   Tue, 2 Mar 2021 17:22:05 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     robh+dt@kernel.org, dmurphy@ti.com, pali@kernel.org,
        krzk@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com
Subject: Re: [PATCH V4 2/2] power: supply: bq27xxx: Add support for BQ78Z100
Message-ID: <20210302162205.c3ovl3egujx67gmw@earth.universe>
References: <20210205071004.26317-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20210205071004.26317-3-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xnx4ugr3r7ozliui"
Content-Disposition: inline
In-Reply-To: <20210205071004.26317-3-Qing-wu.Li@leica-geosystems.com.cn>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--xnx4ugr3r7ozliui
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 05, 2021 at 07:10:04AM +0000, LI Qingwu wrote:
> Add support for TI BQ78Z100, I2C interface gas gauge.
> It provides a fully integrated safety protection
> and authentication for 1 to 2-series cell Li-Ion and
> Li-Polymer battery packs.
>=20
> The patch was tested with BQ78Z100 equipment.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/power/supply/bq27xxx_battery.c     | 46 +++++++++++++++++++++-
>  drivers/power/supply/bq27xxx_battery_i2c.c |  2 +
>  include/linux/power/bq27xxx_battery.h      |  1 +
>  3 files changed, 48 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 315e0909e6a4..c8579ec7a4f8 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -39,6 +39,7 @@
>   * https://www.ti.com/product/bq27z561
>   * https://www.ti.com/product/bq28z610
>   * https://www.ti.com/product/bq34z100-g1
> + * https://www.ti.com/product/bq78z100
>   */
> =20
>  #include <linux/device.h>
> @@ -497,7 +498,27 @@ static u8
>  		[BQ27XXX_REG_DCAP] =3D 0x3c,
>  		[BQ27XXX_REG_AP] =3D 0x22,
>  		BQ27XXX_DM_REG_ROWS,
> -	};
> +	},
> +	bq78z100_regs[BQ27XXX_REG_MAX] =3D {
> +		[BQ27XXX_REG_CTRL] =3D 0x00,
> +		[BQ27XXX_REG_TEMP] =3D 0x06,
> +		[BQ27XXX_REG_INT_TEMP] =3D 0x28,
> +		[BQ27XXX_REG_VOLT] =3D 0x08,
> +		[BQ27XXX_REG_AI] =3D 0x14,
> +		[BQ27XXX_REG_FLAGS] =3D 0x0a,
> +		[BQ27XXX_REG_TTE] =3D 0x16,
> +		[BQ27XXX_REG_TTF] =3D 0x18,
> +		[BQ27XXX_REG_TTES] =3D INVALID_REG_ADDR,

Datasheet states StandbyTimeToEmpty =3D 0x1C?

> +		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
> +		[BQ27XXX_REG_NAC] =3D INVALID_REG_ADDR,

missing BQ27XXX_REG_RC. Looks like chip has support for it at
address 0x10.

> +		[BQ27XXX_REG_FCC] =3D 0x12,
> +		[BQ27XXX_REG_CYCT] =3D 0x2a,
> +		[BQ27XXX_REG_AE] =3D 0x22,

REG_AE is available energy. REG_AP is average power. Obviously
two completley different things and cannot be the same register.
A quick glance at the datasheet suggests AE does not exist.

> +		[BQ27XXX_REG_SOC] =3D 0x2c,
> +		[BQ27XXX_REG_DCAP] =3D 0x3c,
> +		[BQ27XXX_REG_AP] =3D 0x22,
> +		BQ27XXX_DM_REG_ROWS,
> +};

Please fix indention of };

> =20
>  static enum power_supply_property bq27000_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
> @@ -792,6 +813,27 @@ static enum power_supply_property bq34z100_props[] =
=3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> +static enum power_supply_property bq78z100_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,

You are not providing data for this? (BQ27XXX_REG_TTECP is not set).
Please revisit the list of exposed properties and provide a dump of
/sys/class/power_supply/<your_battery>/uevent in your submission.
Currently you should see some -ENODATA.

> +	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CYCLE_COUNT,
> +	POWER_SUPPLY_PROP_ENERGY_NOW,
> +	POWER_SUPPLY_PROP_POWER_AVG,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
>  struct bq27xxx_dm_reg {
>  	u8 subclass_id;
>  	u8 offset;
> @@ -890,6 +932,7 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] =3D {
>  #define bq27z561_dm_regs 0
>  #define bq28z610_dm_regs 0
>  #define bq34z100_dm_regs 0
> +#define bq78z100_dm_regs 0
> =20
>  #define BQ27XXX_O_ZERO		BIT(0)
>  #define BQ27XXX_O_OTDC		BIT(1) /* has OTC/OTD overtemperature flags */
> @@ -948,6 +991,7 @@ static struct {
>  	[BQ28Z610]  =3D BQ27XXX_DATA(bq28z610,  0         , BQ27Z561_O_BITS),
>  	[BQ34Z100]  =3D BQ27XXX_DATA(bq34z100,  0         , BQ27XXX_O_OTDC | BQ=
27XXX_O_SOC_SI | \
>  							  BQ27XXX_O_HAS_CI | BQ27XXX_O_MUL_CHEM),
> +	[BQ78Z100]  =3D BQ27XXX_DATA(bq78z100,  0x00000000, BQ27Z561_O_BITS),

why 0x00000000 instead of just '0' like in the other entries?

>  };
> =20
>  static DEFINE_MUTEX(bq27xxx_list_lock);
> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/s=
upply/bq27xxx_battery_i2c.c
> index eb4f4284982f..46f078350fd3 100644
> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> @@ -248,6 +248,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_tabl=
e[] =3D {
>  	{ "bq27z561", BQ27Z561 },
>  	{ "bq28z610", BQ28Z610 },
>  	{ "bq34z100", BQ34Z100 },
> +	{ "bq78z100", BQ78Z100 },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
> @@ -284,6 +285,7 @@ static const struct of_device_id bq27xxx_battery_i2c_=
of_match_table[] =3D {
>  	{ .compatible =3D "ti,bq27z561" },
>  	{ .compatible =3D "ti,bq28z610" },
>  	{ .compatible =3D "ti,bq34z100" },
> +	{ .compatible =3D "ti,bq78z100" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, bq27xxx_battery_i2c_of_match_table);
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/=
bq27xxx_battery.h
> index 111a40d0d3d5..ac17618043b1 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -33,6 +33,7 @@ enum bq27xxx_chip {
>  	BQ27Z561,
>  	BQ28Z610,
>  	BQ34Z100,
> +	BQ78Z100,
>  };
> =20
>  struct bq27xxx_device_info;

Thanks,

-- Sebastian

--xnx4ugr3r7ozliui
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmA+Zh8ACgkQ2O7X88g7
+pocvBAAgWijnjFdq0RaW+65TRCJOZFe4kOqZj9fcK1bPAAC2UnoP1agj+sSjPoI
cfjLqjWA3ZZml2yFYcK1g9BqTx5bHpnhXL80O3eMmaywKtqIEXYi5pBOOIGnvdDk
PHsVQddouByozK49L55yanpcfJJPdq1ioi3xCCWI0VCTBISRyP/Y5YxGxTV/oMqY
T2bSq/NSTePVwWcG9ziRf30IZYXYE0fxQR8kY8NhVIcVRm72rMmqjnlr3g2ij3JR
vr+MCdf8/zLvwB/BRy3B6FOj6wiZ3kJZtLHDEG2WuDEpj7uNjeCdyVA8rzt4NDOG
WnB4MC6OCqn7rbo9h71WAcLuegVxFYgCVBCb61ju58sLgJsYzAVBTHUQBF2BtWTb
m5gatjOI6iRQ2jExspxO/JVcHo8maBGwHeIhevYWEzn3z+1QpZlAJzkmMtDTg/EY
/ai2K83ZlCoeEVpcOO+NrhLdseEdoC/MZRP721TE+JCh974s0SRfBEJhz2hkMMtw
67v8N7KOvyC1KN2IdJi604O5srozdrN1HnAEnfm40ojh5rJirQ5XrKQqu07cmqMH
N/YsWIKvwFCg/jboLA/0qkyLcBVAGVujXd2hHaknAfQgBJy+RKIkqhGcoNe3OmDK
dYKky0iSuySXF7JqIWvO7mR1sF6OOf2NXkKsY8YsAPfBe45GLNg=
=MF9Q
-----END PGP SIGNATURE-----

--xnx4ugr3r7ozliui--
