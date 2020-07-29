Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1ACF232648
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 22:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgG2UiP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 16:38:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgG2UiP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 16:38:15 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A16602082E;
        Wed, 29 Jul 2020 20:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596055094;
        bh=ZtMcHWQnSDUOUOzW/vC7NhMNa3Qp8SiMpTQ/mWVh7U0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y4T3sk8fvc7n3G47mmUhCqU/gvics2lWHwuY1amVr6/L9M3minKu19QoXvidQ1gFm
         2PicXlIDKJWr4nzY5QSl3YD+ujUHUoCc4ClM/YaNVhc8dMdtFdOY1sSAabyiTcSwNL
         NEXzNhn71xkoOmtD/vyc0Krs5EKvk1sM0Te4ZfgY=
Received: by earth.universe (Postfix, from userid 1000)
        id 00BBE3C0B87; Wed, 29 Jul 2020 22:38:12 +0200 (CEST)
Date:   Wed, 29 Jul 2020 22:38:12 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     afd@ti.com, pali@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: Re: [PATCH v6 4/4] power: supply: bq27xxx_battery: Add the BQ28z610
 Battery monitor
Message-ID: <20200729203812.v4etph4qcfius3ka@earth.universe>
References: <20200729183145.6066-1-dmurphy@ti.com>
 <20200729183145.6066-4-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k3uapmft6h66ytra"
Content-Disposition: inline
In-Reply-To: <20200729183145.6066-4-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--k3uapmft6h66ytra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 29, 2020 at 01:31:45PM -0500, Dan Murphy wrote:
> Add the Texas Instruments BQ28z610 battery monitor.
> The register address map is laid out the same as compared to other
> devices within the file.
>=20
> The battery status register bits are similar to the bq27z561 but they
> are different compared to other fuel gauge devices within this file.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq27xxx_battery.c     | 42 ++++++++++++++++++++++
>  drivers/power/supply/bq27xxx_battery_i2c.c |  2 ++
>  include/linux/power/bq27xxx_battery.h      |  1 +
>  3 files changed, 45 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index a05b9a2d112d..a123f6e21f08 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -44,6 +44,7 @@
>   * https://www.ti.com/product/bq27441-g1
>   * https://www.ti.com/product/bq27621-g1
>   * https://www.ti.com/product/bq27z561
> + * https://www.ti.com/product/bq28z610
>   */
> =20
>  #include <linux/device.h>
> @@ -462,6 +463,26 @@ static u8
>  		[BQ27XXX_REG_DCAP] =3D 0x3c,
>  		[BQ27XXX_REG_AP] =3D 0x22,
>  		BQ27XXX_DM_REG_ROWS,
> +	},
> +	bq28z610_regs[BQ27XXX_REG_MAX] =3D {
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
>  	};
> =20
>  static enum power_supply_property bq27000_props[] =3D {
> @@ -717,6 +738,25 @@ static enum power_supply_property bq27z561_props[] =
=3D {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> =20
> +static enum power_supply_property bq28z610_props[] =3D {
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
> @@ -813,6 +853,7 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] =3D {
>  #endif
> =20
>  #define bq27z561_dm_regs 0
> +#define bq28z610_dm_regs 0
> =20
>  #define BQ27XXX_O_ZERO	0x00000001
>  #define BQ27XXX_O_OTDC	0x00000002 /* has OTC/OTD overtemperature flags */
> @@ -865,6 +906,7 @@ static struct {
>  	[BQ27441]   =3D BQ27XXX_DATA(bq27441,   0x80008000, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP | BQ27XXX_O_RAM),
>  	[BQ27621]   =3D BQ27XXX_DATA(bq27621,   0x80008000, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP | BQ27XXX_O_RAM),
>  	[BQ27Z561]  =3D BQ27XXX_DATA(bq27z561,  0         , BQ27Z561_O_BITS),
> +	[BQ28Z610]  =3D BQ27XXX_DATA(bq28z610,  0         , BQ27Z561_O_BITS),
>  };
> =20
>  static DEFINE_MUTEX(bq27xxx_list_lock);
> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/s=
upply/bq27xxx_battery_i2c.c
> index 15f4e75786ab..ab02456d69e5 100644
> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> @@ -254,6 +254,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_tabl=
e[] =3D {
>  	{ "bq27441", BQ27441 },
>  	{ "bq27621", BQ27621 },
>  	{ "bq27z561", BQ27Z561 },
> +	{ "bq28z610", BQ28Z610 },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
> @@ -288,6 +289,7 @@ static const struct of_device_id bq27xxx_battery_i2c_=
of_match_table[] =3D {
>  	{ .compatible =3D "ti,bq27441" },
>  	{ .compatible =3D "ti,bq27621" },
>  	{ .compatible =3D "ti,bq27z561" },
> +	{ .compatible =3D "ti,bq28z610" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, bq27xxx_battery_i2c_of_match_table);
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/=
bq27xxx_battery.h
> index 1f6ea5d5063d..987d9652aa4e 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -31,6 +31,7 @@ enum bq27xxx_chip {
>  	BQ27441,
>  	BQ27621,
>  	BQ27Z561,
> +	BQ28Z610,
>  };
> =20
>  struct bq27xxx_device_info;
> --=20
> 2.28.0
>=20

--k3uapmft6h66ytra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8h3jQACgkQ2O7X88g7
+ppp9g//dMUOavZiN1FqPSL4Qsxsx7nyHPyY/mahN6Ekbgg4S/Dwu3Le+d6VG1mC
mbtR1D48o/ZoZR0Z5wfbR+2eNbIcGUae/IzVHFNXiuqAosHdykHuHNJ25S3kzBfi
b9lbKaGdi7eFXjg7lPGrWYYO8dt768sL1ShMjaQjYTv+Bt1FZHfyuDASzaETXXDZ
P9WADGOV4I3dV9Llyi7mK662j/PwdjGJrC1FkQofGvS8rvuA/AL0BqbZVM2Gro1X
XEH6bFzyHKl35Afa1aUKAeq3x57wdp5onj3VSbyLfBA1/Jof9VXcukwx0l8cEu0b
uB3S+0rq72BHv/XOi/3xf3f+rHHerHyAt3/ScCGJaEeM7mQjARu1YNlFbZwWBS6B
/BR0VZmZPCxFdbp7U4TVU9gr1u3QYQkPl0Ie47Wjl+h0TihC9aI9aODsRBprtNEp
J6Qluhd+AB1Z140yFhLErjKJ4a31UUEmNZMwbHKz+cj4mta1PvxFyKRhTDWl4Bls
npsnEKIB4cMXwJK+Q7amL7Mhcmt1ZMNlAS7JSCZdAcMB48iIps6DPETie14m1Q6a
Zr0vVjRrYQjlRw1YfOlUAGUDhJpSME0bRNBak1Q+D14c+TKmX3sCy+wUeGYRXCt1
1Jkct0RYnObHRZ3AtMYiJKDHQYceHZ8bCvuGbq2ZbhTunY4c8SA=
=rSL2
-----END PGP SIGNATURE-----

--k3uapmft6h66ytra--
