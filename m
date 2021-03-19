Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C09341B6D
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 12:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhCSL1E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 07:27:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229785AbhCSL0s (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Mar 2021 07:26:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E33B064F6C;
        Fri, 19 Mar 2021 11:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616153208;
        bh=IQxD9EX3/Tm0g6p8Dpp2AGu54qrCUYuQN/WiwB7eN1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ShqrN+8hmkvkyO2JzzJ7j7Djo4jm0KwAWpQpjTiH3hqN8FYcOWEJU7A89+2KBOQNU
         KMi0Q0fWqwjy2B/Tu75mqiVKZTU5KIob985yavWemwrolLZok3CDNFaWZBqB9xvnpD
         n64EKyDMUvG3oFAXdVK1LV4HHwfXIXrYQ969nWTN0cVU5534XxnAT/BGdhxd13JXyw
         wbhs9LVC039f8fQ5dCfejC46bXIiTM1CGYpOXZQg41EwpSaioqQ83oOsc7ZsLDZyDf
         oTzHCxWULvHTRgtEaAvMK6x30dWwge05Q3/rpvwDJvqvPXzI1+tScjyzeKcQmSOR55
         L9c7AdyyceHsQ==
Received: by earth.universe (Postfix, from userid 1000)
        id CFC0F3C0C96; Fri, 19 Mar 2021 12:26:45 +0100 (CET)
Date:   Fri, 19 Mar 2021 12:26:45 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        TERTYCHNYI Grygorii <grygorii.tertychnyi@leica-geosystems.com>,
        ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>
Subject: Re: [PATCH V6 2/2] power: supply: bq27xxx: Add support for BQ78Z100
Message-ID: <20210319112645.dpooltu32etdqz5v@earth.universe>
References: <20210317104918.12323-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20210317104918.12323-3-Qing-wu.Li@leica-geosystems.com.cn>
 <20210317133220.sv2nlyyiw4nnai4t@earth.universe>
 <DB7PR06MB4571FB9071EA8EC176C85755D7689@DB7PR06MB4571.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w4mhzuwmddbzeull"
Content-Disposition: inline
In-Reply-To: <DB7PR06MB4571FB9071EA8EC176C85755D7689@DB7PR06MB4571.eurprd06.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--w4mhzuwmddbzeull
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 19, 2021 at 10:16:51AM +0000, LI Qingwu wrote:
> About 4mA current, it's not the expected current, since we are
> working remotely, the instrument was unattended. With the real
> current, the battery will be empty in a working day, so we just
> connect a dummy load for test for a while,

IIUIC 4-5 mA is the expected current for your dummy load and
the test data looks ok?

> You mentioned the POWER_AVG looks suspicious, yes, it's due to I
> didn't pick the all the commits from master into my code, after
> pick it's looks correct.

Ok.

> About " Discharging " for idle battery, I picked you change, and
> it is "Not Charging", yes fixed by you!

Great.

> One question, after I pick all the commits, the current goes to
> negative during discharging, is this correct?

Yes, as documented in 05f94eb98907 ("power: supply: document current
direction") the current should be negative when battery discharges
and positive when it charges.

> POWER_SUPPLY_NAME=3Dbq78z100-0
> POWER_SUPPLY_STATUS=3DDischarging
> POWER_SUPPLY_PRESENT=3D1
> POWER_SUPPLY_VOLTAGE_NOW=3D3386000
> POWER_SUPPLY_CURRENT_NOW=3D-5000
> POWER_SUPPLY_CAPACITY=3D27
> POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
> POWER_SUPPLY_TEMP=3D269
> POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D1249920
> POWER_SUPPLY_TECHNOLOGY=3DLi-ion
> POWER_SUPPLY_CHARGE_FULL=3D6494000
> POWER_SUPPLY_CHARGE_NOW=3D1736000
> POWER_SUPPLY_CHARGE_FULL_DESIGN=3D6000000
> POWER_SUPPLY_CYCLE_COUNT=3D1
> POWER_SUPPLY_POWER_AVG=3D-20000
> POWER_SUPPLY_HEALTH=3DGood
> POWER_SUPPLY_MANUFACTURER=3DTexas Instruments

That data looks consistent to me now.

Last but not least: Please don't top-post in kernel mailing
lists and use inline style instead, as stated in
Documentation/process/howto.rst:

> Remember to keep the context and the attribution of your replies intact,
> keep the "John Kernelhacker wrote ...:" lines at the top of your reply, a=
nd
> add your statements between the individual quoted sections instead of
> writing at the top of the mail.

Thanks,

-- Sebastian

> -----Original Message-----
> Hi,
>=20
> On Wed, Mar 17, 2021 at 10:49:18AM +0000, LI Qingwu wrote:
> > Add support for TI BQ78Z100, I2C interface gas gauge.
> > It provides a fully integrated safety protection and authentication=20
> > for 1 to 2-series cell Li-Ion and Li-Polymer battery packs.
> >=20
> > The patch was tested with BQ78Z100 equipment.
> >=20
> > Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> >=20
> > result of cat "/sys/class/power_supply/<bat_name>/uevent"
> >=20
> > CASE I:  Discharging current>0:
> >     POWER_SUPPLY_NAME=3Dbq78z100-0
> >     POWER_SUPPLY_STATUS=3DDischarging
> >     POWER_SUPPLY_PRESENT=3D1
> >     POWER_SUPPLY_VOLTAGE_NOW=3D3405000
> >     POWER_SUPPLY_CURRENT_NOW=3D4000
>=20
> 4mA @ 3.4V is 13.6 mW, which seems really small to me.
> Is this what you expect for your hardware?
>=20
> >     POWER_SUPPLY_CAPACITY=3D28
> >     POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
> >     POWER_SUPPLY_TEMP=3D259
> >     POWER_SUPPLY_TIME_TO_EMPTY_NOW=3D1611000
>=20
> I guess 18 days TTE is expected with such a small discharge rate.
>=20
> >     POWER_SUPPLY_TECHNOLOGY=3DLi-ion
> >     POWER_SUPPLY_CHARGE_FULL=3D6494000
> >     POWER_SUPPLY_CHARGE_FULL_DESIGN=3D6000000
> >     POWER_SUPPLY_CYCLE_COUNT=3D1
> >     POWER_SUPPLY_ENERGY_NOW=3D0
>=20
> You are not feeding ENERGY_NOW with data, so do not expose it.
>=20
> >     POWER_SUPPLY_POWER_AVG=3D65535
>=20
> That's a signed int16 -1 and looks suspicious. Especially since expected =
power average is around 13.6 mW. Is something wrong with the handling of BQ=
27XXX_REG_AP for your chip?
>=20
> >     POWER_SUPPLY_HEALTH=3DGood
> >     POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
> >=20
> > CASE II : No discharging current:
> >     POWER_SUPPLY_NAME=3Dbq78z100-0
> >     POWER_SUPPLY_STATUS=3DDischarging
>=20
> That should actually be "Not Charging" for an idle battery. I suppose rec=
ent changes to bq27000, which I applied in the last few days to my for-next=
 branch, might fix this.
>=20
> >     POWER_SUPPLY_PRESENT=3D1
> >     POWER_SUPPLY_VOLTAGE_NOW=3D3405000
> >     POWER_SUPPLY_CURRENT_NOW=3D0
> >     POWER_SUPPLY_CAPACITY=3D28
> >     POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
> >     POWER_SUPPLY_TEMP=3D260
> >     POWER_SUPPLY_TECHNOLOGY=3DLi-ion
> >     POWER_SUPPLY_CHARGE_FULL=3D6494000
> >     POWER_SUPPLY_CHARGE_FULL_DESIGN=3D6000000
> >     POWER_SUPPLY_CYCLE_COUNT=3D1
> >     POWER_SUPPLY_ENERGY_NOW=3D0
> >     POWER_SUPPLY_POWER_AVG=3D0
> >     POWER_SUPPLY_HEALTH=3DGood
> >     POWER_SUPPLY_MANUFACTURER=3DTexas Instruments
> > ---
>=20
> You should expose POWER_SUPPLY_PROP_CHARGE_NOW for exposing BQ27XXX_REG_R=
C info, which is more precise than CAPACITY.
>=20
> Thanks,
>=20
> -- Sebastian
>=20
> >  drivers/power/supply/bq27xxx_battery.c     | 44 ++++++++++++++++++++++
> >  drivers/power/supply/bq27xxx_battery_i2c.c |  2 +
> >  include/linux/power/bq27xxx_battery.h      |  1 +
> >  3 files changed, 47 insertions(+)
> >=20
> > diff --git a/drivers/power/supply/bq27xxx_battery.c=20
> > b/drivers/power/supply/bq27xxx_battery.c
> > index 4c4a7b1c64c5..05a4f9190160 100644
> > --- a/drivers/power/supply/bq27xxx_battery.c
> > +++ b/drivers/power/supply/bq27xxx_battery.c
> > @@ -39,6 +39,7 @@
> >   * https://www.ti.com/product/bq27z561
> >   * https://www.ti.com/product/bq28z610
> >   * https://www.ti.com/product/bq34z100-g1
> > + * https://www.ti.com/product/bq78z100
> >   */
> > =20
> >  #include <linux/device.h>
> > @@ -515,6 +516,27 @@ static u8
> >  		[BQ27XXX_REG_DCAP] =3D 0x3c,
> >  		[BQ27XXX_REG_AP] =3D 0x22,
> >  		BQ27XXX_DM_REG_ROWS,
> > +	},
> > +	bq78z100_regs[BQ27XXX_REG_MAX] =3D {
> > +		[BQ27XXX_REG_CTRL] =3D 0x00,
> > +		[BQ27XXX_REG_TEMP] =3D 0x06,
> > +		[BQ27XXX_REG_INT_TEMP] =3D 0x28,
> > +		[BQ27XXX_REG_VOLT] =3D 0x08,
> > +		[BQ27XXX_REG_AI] =3D 0x14,
> > +		[BQ27XXX_REG_FLAGS] =3D 0x0a,
> > +		[BQ27XXX_REG_TTE] =3D 0x16,
> > +		[BQ27XXX_REG_TTF] =3D 0x18,
> > +		[BQ27XXX_REG_TTES] =3D 0x1c,
> > +		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
> > +		[BQ27XXX_REG_NAC] =3D INVALID_REG_ADDR,
> > +		[BQ27XXX_REG_RC] =3D 0x10,
> > +		[BQ27XXX_REG_FCC] =3D 0x12,
> > +		[BQ27XXX_REG_CYCT] =3D 0x2a,
> > +		[BQ27XXX_REG_AE] =3D INVALID_REG_ADDR,
> > +		[BQ27XXX_REG_SOC] =3D 0x2c,
> > +		[BQ27XXX_REG_DCAP] =3D 0x3c,
> > +		[BQ27XXX_REG_AP] =3D 0x22,
> > +		BQ27XXX_DM_REG_ROWS,
> >  	};
> > =20
> >  static enum power_supply_property bq27000_props[] =3D { @@ -813,6=20
> > +835,26 @@ static enum power_supply_property bq34z100_props[] =3D {
> >  	POWER_SUPPLY_PROP_MANUFACTURER,
> >  };
> > =20
> > +static enum power_supply_property bq78z100_props[] =3D {
> > +	POWER_SUPPLY_PROP_STATUS,
> > +	POWER_SUPPLY_PROP_PRESENT,
> > +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> > +	POWER_SUPPLY_PROP_CURRENT_NOW,
> > +	POWER_SUPPLY_PROP_CAPACITY,
> > +	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
> > +	POWER_SUPPLY_PROP_TEMP,
> > +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
> > +	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
> > +	POWER_SUPPLY_PROP_TECHNOLOGY,
> > +	POWER_SUPPLY_PROP_CHARGE_FULL,
> > +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> > +	POWER_SUPPLY_PROP_CYCLE_COUNT,
> > +	POWER_SUPPLY_PROP_ENERGY_NOW,
> > +	POWER_SUPPLY_PROP_POWER_AVG,
> > +	POWER_SUPPLY_PROP_HEALTH,
> > +	POWER_SUPPLY_PROP_MANUFACTURER,
> > +};
> > +
> >  struct bq27xxx_dm_reg {
> >  	u8 subclass_id;
> >  	u8 offset;
> > @@ -911,6 +953,7 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] =3D =
{ =20
> > #define bq27z561_dm_regs 0  #define bq28z610_dm_regs 0  #define=20
> > bq34z100_dm_regs 0
> > +#define bq78z100_dm_regs 0
> > =20
> >  #define BQ27XXX_O_ZERO		BIT(0)
> >  #define BQ27XXX_O_OTDC		BIT(1) /* has OTC/OTD overtemperature flags */
> > @@ -969,6 +1012,7 @@ static struct {
> >  	[BQ28Z610]  =3D BQ27XXX_DATA(bq28z610,  0         , BQ27Z561_O_BITS),
> >  	[BQ34Z100]  =3D BQ27XXX_DATA(bq34z100,  0         , BQ27XXX_O_OTDC | =
BQ27XXX_O_SOC_SI | \
> >  							  BQ27XXX_O_HAS_CI | BQ27XXX_O_MUL_CHEM),
> > +	[BQ78Z100]  =3D BQ27XXX_DATA(bq78z100,  0x00000000, BQ27Z561_O_BITS),
> >  };
> > =20
> >  static DEFINE_MUTEX(bq27xxx_list_lock); diff --git=20
> > a/drivers/power/supply/bq27xxx_battery_i2c.c=20
> > b/drivers/power/supply/bq27xxx_battery_i2c.c
> > index eb4f4284982f..46f078350fd3 100644
> > --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> > +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> > @@ -248,6 +248,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_ta=
ble[] =3D {
> >  	{ "bq27z561", BQ27Z561 },
> >  	{ "bq28z610", BQ28Z610 },
> >  	{ "bq34z100", BQ34Z100 },
> > +	{ "bq78z100", BQ78Z100 },
> >  	{},
> >  };
> >  MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table); @@ -284,6 +285,7 @@=20
> > static const struct of_device_id bq27xxx_battery_i2c_of_match_table[] =
=3D {
> >  	{ .compatible =3D "ti,bq27z561" },
> >  	{ .compatible =3D "ti,bq28z610" },
> >  	{ .compatible =3D "ti,bq34z100" },
> > +	{ .compatible =3D "ti,bq78z100" },
> >  	{},
> >  };
> >  MODULE_DEVICE_TABLE(of, bq27xxx_battery_i2c_of_match_table);
> > diff --git a/include/linux/power/bq27xxx_battery.h=20
> > b/include/linux/power/bq27xxx_battery.h
> > index 111a40d0d3d5..ac17618043b1 100644
> > --- a/include/linux/power/bq27xxx_battery.h
> > +++ b/include/linux/power/bq27xxx_battery.h
> > @@ -33,6 +33,7 @@ enum bq27xxx_chip {
> >  	BQ27Z561,
> >  	BQ28Z610,
> >  	BQ34Z100,
> > +	BQ78Z100,
> >  };
> > =20
> >  struct bq27xxx_device_info;
> > --
> > 2.17.1
> >=20

--w4mhzuwmddbzeull
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBUim8ACgkQ2O7X88g7
+pruMBAAnMtxJeSbycAdE1BxZCeYDYmcFMI0aNW71Ltqj3TTduxxb2SvqbaWyNu/
l6N25ShL7/qV+qSU1Zwz8gs40GjGxe/j91YQULLy3nZfWeW4T4V/sUyqDUawv+an
cYkTFdzCQsxcWrwuHnVRG84BXYLp1rz+2ryZnD/UztBGJV8JfBzO16q345QC+js4
eJm/QBhn9AhWg2MszipyD4Mf5xqBX/lEKKlDCwh5KYz7F49MBHhMFiocwiq1xcRP
hUJIsdaMstKyaAq8SLU2TAQdOUc9fynzCqHVWzZvwaCKq3uXw+UuxtFPOnY340nt
DiACqt30YADSw/MQEbMXFKEKYiP/TEthoeFav6DKFMxiRdT3Q6tr+E5FncOfRxwZ
QyIEKwDVWzF6+ZucMqwMq7aSK0ecf1J6v/rZeaRytE3cEoBjcrHza/XQWNKcafQ1
5rXa0fqlmjm4WsZaNk+Spy2lgQdfZL5qxc4W2ezrD4ft+HWwOHB+uEPk3/s+TzaB
BwK8OBKPWS7lKnr47zR2hR+mxQOHzcsMW4ARToOnmTfq9dPuGhWL63KYx2Z+mp8y
Cyjcz61DZ+GhAikHrBR8GBkCyvZj+LNOphO/rxBEXwQGscuFIvyiA59MS+qgwaYU
MLXvxt81+i5JSLtdmxXB85DL0UqOabMY42+oaUC6ITkH+PekzoE=
=EA/K
-----END PGP SIGNATURE-----

--w4mhzuwmddbzeull--
