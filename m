Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DD5232644
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 22:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgG2Uhw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 16:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbgG2Uhw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 16:37:52 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48D4E20663;
        Wed, 29 Jul 2020 20:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596055071;
        bh=309qTvK5GcEy5wSe4cRDLMji/5yZmuE2yR14GxuDGow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qLxohBvvXXEkNnpUF4UzVwagURjY+ckrbJcZWFsdSuRdkFFi1LTS2DW8C1+O+Cm71
         M4T3QY2vS3eljZ/1fQaGYDwMCMJE0noq37aNEhDoFYTNetEtQJcSBmfr7dv79RBqQ5
         LDmObg7gSvoIJm8GLi8CMWF9jMgNI1eHGcRGS4eo=
Received: by earth.universe (Postfix, from userid 1000)
        id 966D83C0B87; Wed, 29 Jul 2020 22:37:49 +0200 (CEST)
Date:   Wed, 29 Jul 2020 22:37:49 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     afd@ti.com, pali@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: Re: [PATCH v6 2/4] power: supply: bq27xxx_battery: Add the BQ27Z561
 Battery monitor
Message-ID: <20200729203749.dyqkpdeohdi5ezyo@earth.universe>
References: <20200729183145.6066-1-dmurphy@ti.com>
 <20200729183145.6066-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hy2d4wbbx6jdpdue"
Content-Disposition: inline
In-Reply-To: <20200729183145.6066-2-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--hy2d4wbbx6jdpdue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 29, 2020 at 01:31:43PM -0500, Dan Murphy wrote:
> Add the Texas Instruments BQ27Z561 battery monitor.  The register address
> map is laid out the same as compared to other devices within the file.
> The battery status register has differing bits to determine if the
> battery is full, discharging or dead.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq27xxx_battery.c     | 68 +++++++++++++++++++++-
>  drivers/power/supply/bq27xxx_battery_i2c.c |  2 +
>  include/linux/power/bq27xxx_battery.h      |  1 +
>  3 files changed, 70 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index acaafed037be..a05b9a2d112d 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -43,6 +43,7 @@
>   * https://www.ti.com/product/bq27411-g1
>   * https://www.ti.com/product/bq27441-g1
>   * https://www.ti.com/product/bq27621-g1
> + * https://www.ti.com/product/bq27z561
>   */
> =20
>  #include <linux/device.h>
> @@ -79,6 +80,11 @@
>  #define BQ27000_FLAG_FC		BIT(5)
>  #define BQ27000_FLAG_CHGS	BIT(7) /* Charge state flag */
> =20
> +/* BQ27Z561 has different layout for Flags register */
> +#define BQ27Z561_FLAG_FDC	BIT(4) /* Battery fully discharged */
> +#define BQ27Z561_FLAG_FC		BIT(5) /* Battery fully charged */
> +#define BQ27Z561_FLAG_DIS_CH	BIT(6) /* Battery is discharging */
> +
>  /* control register params */
>  #define BQ27XXX_SEALED			0x20
>  #define BQ27XXX_SET_CFGUPDATE		0x13
> @@ -431,12 +437,32 @@ static u8
>  		[BQ27XXX_REG_DCAP] =3D 0x3c,
>  		[BQ27XXX_REG_AP] =3D 0x18,
>  		BQ27XXX_DM_REG_ROWS,
> -	};
> +	},
>  #define bq27411_regs bq27421_regs
>  #define bq27425_regs bq27421_regs
>  #define bq27426_regs bq27421_regs
>  #define bq27441_regs bq27421_regs
>  #define bq27621_regs bq27421_regs
> +	bq27z561_regs[BQ27XXX_REG_MAX] =3D {
> +		[BQ27XXX_REG_CTRL] =3D 0x00,
> +		[BQ27XXX_REG_TEMP] =3D 0x06,
> +		[BQ27XXX_REG_INT_TEMP] =3D INVALID_REG_ADDR,
> +		[BQ27XXX_REG_VOLT] =3D 0x08,
> +		[BQ27XXX_REG_AI] =3D 0x14,
> +		[BQ27XXX_REG_FLAGS] =3D 0x0a,
> +		[BQ27XXX_REG_TTE] =3D 0x16,
> +		[BQ27XXX_REG_TTF] =3D 0x18,
> +		[BQ27XXX_REG_TTES] =3D INVALID_REG_ADDR,
> +		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
> +		[BQ27XXX_REG_NAC] =3D INVALID_REG_ADDR,
> +		[BQ27XXX_REG_FCC] =3D 0x12,
> +		[BQ27XXX_REG_CYCT] =3D 0x2a,
> +		[BQ27XXX_REG_AE] =3D 0x22,
> +		[BQ27XXX_REG_SOC] =3D 0x2c,
> +		[BQ27XXX_REG_DCAP] =3D 0x3c,
> +		[BQ27XXX_REG_AP] =3D 0x22,
> +		BQ27XXX_DM_REG_ROWS,
> +	};
> =20
>  static enum power_supply_property bq27000_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
> @@ -672,6 +698,25 @@ static enum power_supply_property bq27421_props[] =
=3D {
>  #define bq27441_props bq27421_props
>  #define bq27621_props bq27421_props
> =20
> +static enum power_supply_property bq27z561_props[] =3D {
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
> +	POWER_SUPPLY_PROP_POWER_AVG,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
>  struct bq27xxx_dm_reg {
>  	u8 subclass_id;
>  	u8 offset;
> @@ -767,11 +812,14 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] =3D {
>  #define bq27621_dm_regs 0
>  #endif
> =20
> +#define bq27z561_dm_regs 0
> +
>  #define BQ27XXX_O_ZERO	0x00000001
>  #define BQ27XXX_O_OTDC	0x00000002 /* has OTC/OTD overtemperature flags */
>  #define BQ27XXX_O_UTOT  0x00000004 /* has OT overtemperature flag */
>  #define BQ27XXX_O_CFGUP	0x00000008
>  #define BQ27XXX_O_RAM	0x00000010
> +#define BQ27Z561_O_BITS	0x00000020
> =20
>  #define BQ27XXX_DATA(ref, key, opt) {		\
>  	.opts =3D (opt),				\
> @@ -816,6 +864,7 @@ static struct {
>  	[BQ27426]   =3D BQ27XXX_DATA(bq27426,   0x80008000, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP | BQ27XXX_O_RAM),
>  	[BQ27441]   =3D BQ27XXX_DATA(bq27441,   0x80008000, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP | BQ27XXX_O_RAM),
>  	[BQ27621]   =3D BQ27XXX_DATA(bq27621,   0x80008000, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP | BQ27XXX_O_RAM),
> +	[BQ27Z561]  =3D BQ27XXX_DATA(bq27z561,  0         , BQ27Z561_O_BITS),
>  };
> =20
>  static DEFINE_MUTEX(bq27xxx_list_lock);
> @@ -1551,6 +1600,8 @@ static bool bq27xxx_battery_dead(struct bq27xxx_dev=
ice_info *di, u16 flags)
>  {
>  	if (di->opts & BQ27XXX_O_ZERO)
>  		return flags & (BQ27000_FLAG_EDV1 | BQ27000_FLAG_EDVF);
> +	else if (di->opts & BQ27Z561_O_BITS)
> +		return flags & BQ27Z561_FLAG_FDC;
>  	else
>  		return flags & (BQ27XXX_FLAG_SOC1 | BQ27XXX_FLAG_SOCF);
>  }
> @@ -1595,6 +1646,7 @@ void bq27xxx_battery_update(struct bq27xxx_device_i=
nfo *di)
>  				cache.time_to_empty_avg =3D bq27xxx_battery_read_time(di, BQ27XXX_RE=
G_TTECP);
>  			if (di->regs[BQ27XXX_REG_TTF] !=3D INVALID_REG_ADDR)
>  				cache.time_to_full =3D bq27xxx_battery_read_time(di, BQ27XXX_REG_TTF=
);
> +
>  			cache.charge_full =3D bq27xxx_battery_read_fcc(di);
>  			cache.capacity =3D bq27xxx_battery_read_soc(di);
>  			if (di->regs[BQ27XXX_REG_AE] !=3D INVALID_REG_ADDR)
> @@ -1682,6 +1734,13 @@ static int bq27xxx_battery_status(struct bq27xxx_d=
evice_info *di,
>  			status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
>  		else
>  			status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +	} else if (di->opts & BQ27Z561_O_BITS) {
> +		if (di->cache.flags & BQ27Z561_FLAG_FC)
> +			status =3D POWER_SUPPLY_STATUS_FULL;
> +		else if (di->cache.flags & BQ27Z561_FLAG_DIS_CH)
> +			status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		else
> +			status =3D POWER_SUPPLY_STATUS_CHARGING;
>  	} else {
>  		if (di->cache.flags & BQ27XXX_FLAG_FC)
>  			status =3D POWER_SUPPLY_STATUS_FULL;
> @@ -1710,6 +1769,13 @@ static int bq27xxx_battery_capacity_level(struct b=
q27xxx_device_info *di,
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
>  		else
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
> +	} else if (di->opts & BQ27Z561_O_BITS) {
> +		if (di->cache.flags & BQ27Z561_FLAG_FC)
> +			level =3D POWER_SUPPLY_CAPACITY_LEVEL_FULL;
> +		else if (di->cache.flags & BQ27Z561_FLAG_FDC)
> +			level =3D POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
> +		else
> +			level =3D POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
>  	} else {
>  		if (di->cache.flags & BQ27XXX_FLAG_FC)
>  			level =3D POWER_SUPPLY_CAPACITY_LEVEL_FULL;
> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/s=
upply/bq27xxx_battery_i2c.c
> index 8e114a7abfc9..15f4e75786ab 100644
> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> @@ -253,6 +253,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_tabl=
e[] =3D {
>  	{ "bq27426", BQ27426 },
>  	{ "bq27441", BQ27441 },
>  	{ "bq27621", BQ27621 },
> +	{ "bq27z561", BQ27Z561 },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
> @@ -286,6 +287,7 @@ static const struct of_device_id bq27xxx_battery_i2c_=
of_match_table[] =3D {
>  	{ .compatible =3D "ti,bq27426" },
>  	{ .compatible =3D "ti,bq27441" },
>  	{ .compatible =3D "ti,bq27621" },
> +	{ .compatible =3D "ti,bq27z561" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, bq27xxx_battery_i2c_of_match_table);
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/=
bq27xxx_battery.h
> index 507c5e214c42..1f6ea5d5063d 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -30,6 +30,7 @@ enum bq27xxx_chip {
>  	BQ27426,
>  	BQ27441,
>  	BQ27621,
> +	BQ27Z561,
>  };
> =20
>  struct bq27xxx_device_info;
> --=20
> 2.28.0
>=20

--hy2d4wbbx6jdpdue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8h3h0ACgkQ2O7X88g7
+poxsg//Z1bagn1b1bnga1iH7DVXozBtrlPOdu5Ta55S4mLL07g1ELb1rXd/QBIv
q1RJJlqv0YaYjNHDhksh6lkLNTZXN7+DHm2PztDGNBAfTvkUGj08YSTERuFVNg4I
Wrzp2Z/UsNIVk2yrf3ttKEMtnc4MXY4EsTHYmOWanUWD+wZ8DHxdN2pJWhLdxqPS
YJcERBjueNyXPB7YkoUWydCDwJv2Ydb6XhPU0d53pMdg/1rZhFuT0BdXYslKn2vW
4rPxe4w/lTgTGcqEKeez0XBYBjOeNfPajdhUaOQeVKlcZ4zGLQapL0e3JGSn6/pP
wdH78D8n5AvhFy+8Il9jd2w5bFp8+ARxlnKOY+gFn3KPPR4wUOshhcZCtFb7D8TX
D5mtSzPNkrplNFXz40vKy8dtoEA3E2dMopjLQW5mWEn6+Y1Dew4+YQvcgsXESAGa
uFZ5HXPfdJV47XsxJGbzR0uIlrfbqpOR9O2dlC/o3l9pfoULOb52RO91iOkibtgP
EX5w+NOp47+rnvTNhWv8eTz+J+nmYecP9UBESC0ptQaPVk7s5JthCIj+pzRRqS3Y
1Ec8/HvRavCSWyYNyPFLc5adHQxztrnW3w3G9E+IyICXQORFy+OlQ/xsMNYtAyvD
EE17NH//ksWjZXwwg6qoIhfGO8D4lpVILm7ljqZ+uhyaaKXKixw=
=MUq2
-----END PGP SIGNATURE-----

--hy2d4wbbx6jdpdue--
