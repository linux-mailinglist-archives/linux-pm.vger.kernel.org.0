Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4E733F130
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhCQNcg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:32:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231184AbhCQNcX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Mar 2021 09:32:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B35C364F30;
        Wed, 17 Mar 2021 13:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615987942;
        bh=dP0T4Vv8ezLoW9YxSyV8XtEBlr4MIKdWUxZQAWmvu7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nEkDFSgPQC30W4exIwygLygvA4NRGCh/9X5Jc5PjWU4vEkLb0iOn+h7suPyfHfnTJ
         aougOIY0Cfb5uj9Y49bkHBM4GszG2VCKQu5IXg+C//qfP/ARWjDEzTsMBVfs5QFExi
         7Ab/LkuHatF5nUREMlUuUrprGKI6TTDGNQWF6lCv5zT60MhhjXgR+xVzHqPGZEgajw
         0Q7vlUTOvGVHnSTEQzThUNbWtid0SaDFcY8zgvWeOfRYcJQagZ8ANmbu9LbeGP47xV
         xCCMDTAY9oCzZAsoz0Kl9UFk8MkZ5iQbAUyMKOWwo5byeUXNj+5Fc788tCrhtzpdg7
         KfLClmGfk5pUg==
Received: by earth.universe (Postfix, from userid 1000)
        id 7A6AB3C0C96; Wed, 17 Mar 2021 14:32:20 +0100 (CET)
Date:   Wed, 17 Mar 2021 14:32:20 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     robh+dt@kernel.org, pali@kernel.org, krzk@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com
Subject: Re: [PATCH V6 2/2] power: supply: bq27xxx: Add support for BQ78Z100
Message-ID: <20210317133220.sv2nlyyiw4nnai4t@earth.universe>
References: <20210317104918.12323-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20210317104918.12323-3-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ulfaazjgolx56jnt"
Content-Disposition: inline
In-Reply-To: <20210317104918.12323-3-Qing-wu.Li@leica-geosystems.com.cn>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ulfaazjgolx56jnt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 17, 2021 at 10:49:18AM +0000, LI Qingwu wrote:
> Add support for TI BQ78Z100, I2C interface gas gauge.
> It provides a fully integrated safety protection
> and authentication for 1 to 2-series cell Li-Ion and
> Li-Polymer battery packs.
>=20
> The patch was tested with BQ78Z100 equipment.
>=20
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>=20
> result of cat "/sys/class/power_supply/<bat_name>/uevent"
>=20
> CASE I:  Discharging current>0:
>     POWER_SUPPLY_NAME=3Dbq78z100-0
>     POWER_SUPPLY_STATUS=3DDischarging
>     POWER_SUPPLY_PRESENT=3D1
>     POWER_SUPPLY_VOLTAGE_NOW=3D3405000
>     POWER_SUPPLY_CURRENT_NOW=3D4000

4mA @ 3.4V is 13.6 mW, which seems really small to me.
Is this what you expect for your hardware?

>     POWER_SUPPLY_CAPACITY=3D28
>     POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
>     POWER_SUPPLY_TEMP=3D259
>     POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D1611000

I guess 18 days TTE is expected with such a small discharge rate.

>     POWER_SUPPLY_TECHNOLOGY=3DLi-ion
>     POWER_SUPPLY_CHARGE_FULL=3D6494000
>     POWER_SUPPLY_CHARGE_FULL_DESIGN=3D6000000
>     POWER_SUPPLY_CYCLE_COUNT=3D1
>     POWER_SUPPLY_ENERGY_NOW=3D0

You are not feeding ENERGY_NOW with data, so do not expose it.

>     POWER_SUPPLY_POWER_AVG=3D65535

That's a signed int16 -1 and looks suspicious. Especially since
expected power average is around 13.6 mW. Is something wrong with
the handling of BQ27XXX_REG_AP for your chip?

>     POWER_SUPPLY_HEALTH=3DGood
>     POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
>=20
> CASE II : No discharging current:
>     POWER_SUPPLY_NAME=3Dbq78z100-0
>     POWER_SUPPLY_STATUS=3DDischarging

That should actually be "Not Charging" for an idle battery. I
suppose recent changes to bq27000, which I applied in the last
few days to my for-next branch, might fix this.

>     POWER_SUPPLY_PRESENT=3D1
>     POWER_SUPPLY_VOLTAGE_NOW=3D3405000
>     POWER_SUPPLY_CURRENT_NOW=3D0
>     POWER_SUPPLY_CAPACITY=3D28
>     POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
>     POWER_SUPPLY_TEMP=3D260
>     POWER_SUPPLY_TECHNOLOGY=3DLi-ion
>     POWER_SUPPLY_CHARGE_FULL=3D6494000
>     POWER_SUPPLY_CHARGE_FULL_DESIGN=3D6000000
>     POWER_SUPPLY_CYCLE_COUNT=3D1
>     POWER_SUPPLY_ENERGY_NOW=3D0
>     POWER_SUPPLY_POWER_AVG=3D0
>     POWER_SUPPLY_HEALTH=3DGood
>     POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
> ---

You should expose POWER_SUPPLY_PROP_CHARGE_NOW for exposing
BQ27XXX_REG_RC info, which is more precise than CAPACITY.

Thanks,

-- Sebastian

>  drivers/power/supply/bq27xxx_battery.c     | 44 ++++++++++++++++++++++
>  drivers/power/supply/bq27xxx_battery_i2c.c |  2 +
>  include/linux/power/bq27xxx_battery.h      |  1 +
>  3 files changed, 47 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 4c4a7b1c64c5..05a4f9190160 100644
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
> @@ -515,6 +516,27 @@ static u8
>  		[BQ27XXX_REG_DCAP] =3D 0x3c,
>  		[BQ27XXX_REG_AP] =3D 0x22,
>  		BQ27XXX_DM_REG_ROWS,
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
> +		[BQ27XXX_REG_TTES] =3D 0x1c,
> +		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
> +		[BQ27XXX_REG_NAC] =3D INVALID_REG_ADDR,
> +		[BQ27XXX_REG_RC] =3D 0x10,
> +		[BQ27XXX_REG_FCC] =3D 0x12,
> +		[BQ27XXX_REG_CYCT] =3D 0x2a,
> +		[BQ27XXX_REG_AE] =3D INVALID_REG_ADDR,
> +		[BQ27XXX_REG_SOC] =3D 0x2c,
> +		[BQ27XXX_REG_DCAP] =3D 0x3c,
> +		[BQ27XXX_REG_AP] =3D 0x22,
> +		BQ27XXX_DM_REG_ROWS,
>  	};
> =20
>  static enum power_supply_property bq27000_props[] =3D {
> @@ -813,6 +835,26 @@ static enum power_supply_property bq34z100_props[] =
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
> @@ -911,6 +953,7 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] =3D {
>  #define bq27z561_dm_regs 0
>  #define bq28z610_dm_regs 0
>  #define bq34z100_dm_regs 0
> +#define bq78z100_dm_regs 0
> =20
>  #define BQ27XXX_O_ZERO		BIT(0)
>  #define BQ27XXX_O_OTDC		BIT(1) /* has OTC/OTD overtemperature flags */
> @@ -969,6 +1012,7 @@ static struct {
>  	[BQ28Z610]  =3D BQ27XXX_DATA(bq28z610,  0         , BQ27Z561_O_BITS),
>  	[BQ34Z100]  =3D BQ27XXX_DATA(bq34z100,  0         , BQ27XXX_O_OTDC | BQ=
27XXX_O_SOC_SI | \
>  							  BQ27XXX_O_HAS_CI | BQ27XXX_O_MUL_CHEM),
> +	[BQ78Z100]  =3D BQ27XXX_DATA(bq78z100,  0x00000000, BQ27Z561_O_BITS),
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
> --=20
> 2.17.1
>=20

--ulfaazjgolx56jnt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBSBNYACgkQ2O7X88g7
+po7cRAAiEHZ1Q+anvGAe72jt6xDycEXFA+EwDdtDZOzhkh3cr/rV47Kt2mbonO8
g7aAwtabAoym0YlKzSGkouhHbwRy1NoMRWmxT4BT9o23P0LLRd4IpPszaQ/ijk6I
2fWMqEnRzxQz6TuBFt6IdE38R6WRT4IdTi9xk01jS7Bg+BlEzikp2zzwCVHsM8QV
XqINOsWxdDUe4upHZXEyLn7G1EblJ7HIvTIPuFt1MUSHfTwnt7zh8yklGjkYwpSY
YFvCYrJTDCaxv0NpMSGMmq60WINSYqK2QAoE8EmRvVqCJ80Lf2CTtwyn0EkvIsIs
WkgarUAPrk1FrFHK6GLYWKoEuNgrbV3Ax4mbq+xz3zylGEv68Sg6WOL0xr3meV+j
2SHql8mVGFs4QkkLXTzRfu952bzrGaDbCqfBkzUP0m0it4zTi3Ay77FS8VO14xrN
dv8+eMgOb0qciAnM5eYftX1y4OKWYtBMvdA3sygYeLgLbXa5+rHRBH/8N1MsmFCi
Oxzuxgx1oZIfAsMolx4R2oBJBzfxO9aNRnxDOUUH9VuuvdHEQSss/L6sk/3h2fjq
nMlvG9lD/rkxbSAZIeOAB6GiKYTnuCGan4clGblNbXV1M7sPwd91LoGnaZj29RRI
ELNS65+mERPTBUJ/VCEYxiAb5DHJROKQbq41lc/3Bo4WhC8RjiM=
=/4/K
-----END PGP SIGNATURE-----

--ulfaazjgolx56jnt--
