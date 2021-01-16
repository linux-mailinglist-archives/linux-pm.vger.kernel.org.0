Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA212F8D11
	for <lists+linux-pm@lfdr.de>; Sat, 16 Jan 2021 12:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbhAPLFt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jan 2021 06:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbhAPLFs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jan 2021 06:05:48 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCA0C061757;
        Sat, 16 Jan 2021 03:05:07 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C2ED31F45E2C
Received: by earth.universe (Postfix, from userid 1000)
        id 0986D3C0C94; Sat, 16 Jan 2021 12:05:02 +0100 (CET)
Date:   Sat, 16 Jan 2021 12:05:01 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hermes Zhang <Hermes.Zhang@axis.com>
Cc:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        kernel <kernel@axis.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] power: supply: bq27xxx: Supporrt CHARGE_NOW for
 bq27z561/bq28z610/bq34z100
Message-ID: <20210116110501.znunkg27y2o4oyqg@earth.universe>
References: <20201222110720.20837-1-chenhui.zhang@axis.com>
 <20201222115312.dbrlup5gzkv2oykz@pali>
 <d220eb7d-91b5-244e-f0d5-d10eae34decb@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="acbhrx54jyeevmcw"
Content-Disposition: inline
In-Reply-To: <d220eb7d-91b5-244e-f0d5-d10eae34decb@axis.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--acbhrx54jyeevmcw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 23, 2020 at 12:40:09AM +0000, Hermes Zhang wrote:
> On 12/22/20 7:53 PM, Pali Roh=E1r wrote:
> > On Tuesday 22 December 2020 19:07:20 Hermes Zhang wrote:
> >> From: Hermes Zhang <chenhuiz@axis.com>
> >>
> >> The CHARGE_NOW is map to REG_NAC for all the gauge chips beofre. But f=
or
> >> some chips (e.g. bq27z561) which doesn't have the REG_NAC, we use REG_=
RC
> >> (remaining capacity) for CHARGE_NOW.
> >>
> >> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> >> ---
> >>
> >> Notes:
> >>      Set correct REG_RC for all the chips if have
> >>     =20
> >>      keep INVALID_REG_ADDR for bq27521, as we could not find
> >>      the datasheet and seems no one use it now.
> > This chip is used in Nokia N950 and Nokia N9. Pavel implemented kernel
> > support, adding to loop.
> >
> > Public information about it are at:
> > https://elinux.org/N950#sn27521_register_map
>=20
> Thanks for the info. From the link it seem bq27521 have neither NAC and=
=20
> RC register.

Thanks, I queued the patch to power-supply's for-next branch. (I reworded t=
he
commit message, which was was hard to understand and had a few typos).

-- Sebastian

> Best Regards,
>=20
> Hermes
>=20
> >
> >>   drivers/power/supply/bq27xxx_battery.c | 35 ++++++++++++++++++++++++=
+-
> >>   1 file changed, 34 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/su=
pply/bq27xxx_battery.c
> >> index 315e0909e6a4..774aa376653e 100644
> >> --- a/drivers/power/supply/bq27xxx_battery.c
> >> +++ b/drivers/power/supply/bq27xxx_battery.c
> >> @@ -110,6 +110,7 @@ enum bq27xxx_reg_index {
> >>   	BQ27XXX_REG_TTES,	/* Time-to-Empty Standby */
> >>   	BQ27XXX_REG_TTECP,	/* Time-to-Empty at Constant Power */
> >>   	BQ27XXX_REG_NAC,	/* Nominal Available Capacity */
> >> +	BQ27XXX_REG_RC,		/* Remaining Capacity */
> >>   	BQ27XXX_REG_FCC,	/* Full Charge Capacity */
> >>   	BQ27XXX_REG_CYCT,	/* Cycle Count */
> >>   	BQ27XXX_REG_AE,		/* Available Energy */
> >> @@ -145,6 +146,7 @@ static u8
> >>   		[BQ27XXX_REG_TTES] =3D 0x1c,
> >>   		[BQ27XXX_REG_TTECP] =3D 0x26,
> >>   		[BQ27XXX_REG_NAC] =3D 0x0c,
> >> +		[BQ27XXX_REG_RC] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_FCC] =3D 0x12,
> >>   		[BQ27XXX_REG_CYCT] =3D 0x2a,
> >>   		[BQ27XXX_REG_AE] =3D 0x22,
> >> @@ -169,6 +171,7 @@ static u8
> >>   		[BQ27XXX_REG_TTES] =3D 0x1c,
> >>   		[BQ27XXX_REG_TTECP] =3D 0x26,
> >>   		[BQ27XXX_REG_NAC] =3D 0x0c,
> >> +		[BQ27XXX_REG_RC] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_FCC] =3D 0x12,
> >>   		[BQ27XXX_REG_CYCT] =3D 0x2a,
> >>   		[BQ27XXX_REG_AE] =3D INVALID_REG_ADDR,
> >> @@ -193,6 +196,7 @@ static u8
> >>   		[BQ27XXX_REG_TTES] =3D 0x1a,
> >>   		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_NAC] =3D 0x0c,
> >> +		[BQ27XXX_REG_RC] =3D 0x10,
> >>   		[BQ27XXX_REG_FCC] =3D 0x12,
> >>   		[BQ27XXX_REG_CYCT] =3D 0x2a,
> >>   		[BQ27XXX_REG_AE] =3D INVALID_REG_ADDR,
> >> @@ -215,6 +219,7 @@ static u8
> >>   		[BQ27XXX_REG_TTES] =3D 0x1c,
> >>   		[BQ27XXX_REG_TTECP] =3D 0x26,
> >>   		[BQ27XXX_REG_NAC] =3D 0x0c,
> >> +		[BQ27XXX_REG_RC] =3D 0x10,
> >>   		[BQ27XXX_REG_FCC] =3D 0x12,
> >>   		[BQ27XXX_REG_CYCT] =3D 0x2a,
> >>   		[BQ27XXX_REG_AE] =3D 0x22,
> >> @@ -237,6 +242,7 @@ static u8
> >>   		[BQ27XXX_REG_TTES] =3D 0x1a,
> >>   		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_NAC] =3D 0x0c,
> >> +		[BQ27XXX_REG_RC] =3D 0x10,
> >>   		[BQ27XXX_REG_FCC] =3D 0x12,
> >>   		[BQ27XXX_REG_CYCT] =3D 0x1e,
> >>   		[BQ27XXX_REG_AE] =3D INVALID_REG_ADDR,
> >> @@ -257,6 +263,7 @@ static u8
> >>   		[BQ27XXX_REG_TTES] =3D 0x1c,
> >>   		[BQ27XXX_REG_TTECP] =3D 0x26,
> >>   		[BQ27XXX_REG_NAC] =3D 0x0c,
> >> +		[BQ27XXX_REG_RC] =3D 0x10,
> >>   		[BQ27XXX_REG_FCC] =3D 0x12,
> >>   		[BQ27XXX_REG_CYCT] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_AE] =3D 0x22,
> >> @@ -277,6 +284,7 @@ static u8
> >>   		[BQ27XXX_REG_TTES] =3D 0x1c,
> >>   		[BQ27XXX_REG_TTECP] =3D 0x26,
> >>   		[BQ27XXX_REG_NAC] =3D 0x0c,
> >> +		[BQ27XXX_REG_RC] =3D 0x10,
> >>   		[BQ27XXX_REG_FCC] =3D 0x12,
> >>   		[BQ27XXX_REG_CYCT] =3D 0x2a,
> >>   		[BQ27XXX_REG_AE] =3D 0x22,
> >> @@ -297,6 +305,7 @@ static u8
> >>   		[BQ27XXX_REG_TTES] =3D 0x1c,
> >>   		[BQ27XXX_REG_TTECP] =3D 0x26,
> >>   		[BQ27XXX_REG_NAC] =3D 0x0c,
> >> +		[BQ27XXX_REG_RC] =3D 0x10,
> >>   		[BQ27XXX_REG_FCC] =3D 0x12,
> >>   		[BQ27XXX_REG_CYCT] =3D 0x2a,
> >>   		[BQ27XXX_REG_AE] =3D 0x22,
> >> @@ -317,6 +326,7 @@ static u8
> >>   		[BQ27XXX_REG_TTES] =3D 0x1c,
> >>   		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_NAC] =3D 0x0c,
> >> +		[BQ27XXX_REG_RC] =3D 0x10,
> >>   		[BQ27XXX_REG_FCC] =3D 0x12,
> >>   		[BQ27XXX_REG_CYCT] =3D 0x1e,
> >>   		[BQ27XXX_REG_AE] =3D INVALID_REG_ADDR,
> >> @@ -337,6 +347,7 @@ static u8
> >>   		[BQ27XXX_REG_TTES] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_NAC] =3D INVALID_REG_ADDR,
> >> +		[BQ27XXX_REG_RC] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_FCC] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_CYCT] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_AE] =3D INVALID_REG_ADDR,
> >> @@ -361,6 +372,7 @@ static u8
> >>   		[BQ27XXX_REG_TTES] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_NAC] =3D 0x0c,
> >> +		[BQ27XXX_REG_RC] =3D 0x10,
> >>   		[BQ27XXX_REG_FCC] =3D 0x12,
> >>   		[BQ27XXX_REG_CYCT] =3D 0x2a,
> >>   		[BQ27XXX_REG_AE] =3D INVALID_REG_ADDR,
> >> @@ -382,6 +394,7 @@ static u8
> >>   		[BQ27XXX_REG_TTES] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_NAC] =3D 0x0c,
> >> +		[BQ27XXX_REG_RC] =3D 0x10,
> >>   		[BQ27XXX_REG_FCC] =3D 0x12,
> >>   		[BQ27XXX_REG_CYCT] =3D 0x2a,
> >>   		[BQ27XXX_REG_AE] =3D INVALID_REG_ADDR,
> >> @@ -405,6 +418,7 @@ static u8
> >>   		[BQ27XXX_REG_TTES] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_NAC] =3D 0x0c,
> >> +		[BQ27XXX_REG_RC] =3D 0x10,
> >>   		[BQ27XXX_REG_FCC] =3D 0x12,
> >>   		[BQ27XXX_REG_CYCT] =3D 0x2a,
> >>   		[BQ27XXX_REG_AE] =3D INVALID_REG_ADDR,
> >> @@ -425,6 +439,7 @@ static u8
> >>   		[BQ27XXX_REG_TTES] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_NAC] =3D 0x08,
> >> +		[BQ27XXX_REG_RC] =3D 0x0c,
> >>   		[BQ27XXX_REG_FCC] =3D 0x0e,
> >>   		[BQ27XXX_REG_CYCT] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_AE] =3D INVALID_REG_ADDR,
> >> @@ -450,6 +465,7 @@ static u8
> >>   		[BQ27XXX_REG_TTES] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_NAC] =3D INVALID_REG_ADDR,
> >> +		[BQ27XXX_REG_RC] =3D 0x10,
> >>   		[BQ27XXX_REG_FCC] =3D 0x12,
> >>   		[BQ27XXX_REG_CYCT] =3D 0x2a,
> >>   		[BQ27XXX_REG_AE] =3D 0x22,
> >> @@ -470,6 +486,7 @@ static u8
> >>   		[BQ27XXX_REG_TTES] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_NAC] =3D INVALID_REG_ADDR,
> >> +		[BQ27XXX_REG_RC] =3D 0x10,
> >>   		[BQ27XXX_REG_FCC] =3D 0x12,
> >>   		[BQ27XXX_REG_CYCT] =3D 0x2a,
> >>   		[BQ27XXX_REG_AE] =3D 0x22,
> >> @@ -490,6 +507,7 @@ static u8
> >>   		[BQ27XXX_REG_TTES] =3D 0x1e,
> >>   		[BQ27XXX_REG_TTECP] =3D INVALID_REG_ADDR,
> >>   		[BQ27XXX_REG_NAC] =3D INVALID_REG_ADDR,
> >> +		[BQ27XXX_REG_RC] =3D 0x04,
> >>   		[BQ27XXX_REG_FCC] =3D 0x06,
> >>   		[BQ27XXX_REG_CYCT] =3D 0x2c,
> >>   		[BQ27XXX_REG_AE] =3D 0x24,
> >> @@ -745,6 +763,7 @@ static enum power_supply_property bq27z561_props[]=
 =3D {
> >>   	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
> >>   	POWER_SUPPLY_PROP_TECHNOLOGY,
> >>   	POWER_SUPPLY_PROP_CHARGE_FULL,
> >> +	POWER_SUPPLY_PROP_CHARGE_NOW,
> >>   	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> >>   	POWER_SUPPLY_PROP_CYCLE_COUNT,
> >>   	POWER_SUPPLY_PROP_POWER_AVG,
> >> @@ -764,6 +783,7 @@ static enum power_supply_property bq28z610_props[]=
 =3D {
> >>   	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
> >>   	POWER_SUPPLY_PROP_TECHNOLOGY,
> >>   	POWER_SUPPLY_PROP_CHARGE_FULL,
> >> +	POWER_SUPPLY_PROP_CHARGE_NOW,
> >>   	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> >>   	POWER_SUPPLY_PROP_CYCLE_COUNT,
> >>   	POWER_SUPPLY_PROP_POWER_AVG,
> >> @@ -784,6 +804,7 @@ static enum power_supply_property bq34z100_props[]=
 =3D {
> >>   	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
> >>   	POWER_SUPPLY_PROP_TECHNOLOGY,
> >>   	POWER_SUPPLY_PROP_CHARGE_FULL,
> >> +	POWER_SUPPLY_PROP_CHARGE_NOW,
> >>   	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> >>   	POWER_SUPPLY_PROP_CYCLE_COUNT,
> >>   	POWER_SUPPLY_PROP_ENERGY_NOW,
> >> @@ -1518,6 +1539,15 @@ static inline int bq27xxx_battery_read_nac(stru=
ct bq27xxx_device_info *di)
> >>   	return bq27xxx_battery_read_charge(di, BQ27XXX_REG_NAC);
> >>   }
> >>  =20
> >> +/*
> >> + * Return the battery Remaining Capacity in =B5Ah
> >> + * Or < 0 if something fails.
> >> + */
> >> +static inline int bq27xxx_battery_read_rc(struct bq27xxx_device_info =
*di)
> >> +{
> >> +	return bq27xxx_battery_read_charge(di, BQ27XXX_REG_RC);
> >> +}
> >> +
> >>   /*
> >>    * Return the battery Full Charge Capacity in =B5Ah
> >>    * Or < 0 if something fails.
> >> @@ -1965,7 +1995,10 @@ static int bq27xxx_battery_get_property(struct =
power_supply *psy,
> >>   			val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;
> >>   		break;
> >>   	case POWER_SUPPLY_PROP_CHARGE_NOW:
> >> -		ret =3D bq27xxx_simple_value(bq27xxx_battery_read_nac(di), val);
> >> +		if (di->regs[BQ27XXX_REG_NAC] !=3D INVALID_REG_ADDR)
> >> +			ret =3D bq27xxx_simple_value(bq27xxx_battery_read_nac(di), val);
> >> +		else
> >> +			ret =3D bq27xxx_simple_value(bq27xxx_battery_read_rc(di), val);
> >>   		break;
> >>   	case POWER_SUPPLY_PROP_CHARGE_FULL:
> >>   		ret =3D bq27xxx_simple_value(di->cache.charge_full, val);
> >> --=20
> >> 2.20.1
> >>
>=20

--acbhrx54jyeevmcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmACyFkACgkQ2O7X88g7
+prgvBAAiJvpSXMg69LZJmduFs+mBku8W1zIqewSMQM5MrN9fSpVfRmyGPa40/JU
FuOFR2p3tXue9IrgNM7rM/oAMrWnQ++IytAkqhjOuDr5JEKGdqkzTu2zP11jOTC6
dS7/GaTO+C+Sn81xdrPDCBdgOzkFcs8Y0vbkWK+v5GA3UMabhA57uHjyWEM/j2pN
CG3Mw/mq8f6dZbsQ8UoD6HO8mZ40mAR7qFxoQD17tF+/0LlyN4Ur6iZdbUYP0xh9
BdPACq/OWxnDnErCwop5InpdL2bmCs6feB8w1ZcQYLZ20+vpCMmWxQ1+MsygbwOI
Ux669Ay2p7V6hxFAVNggbaOy2zSYiD1pMQvU+oxJuCO3GgS+5nV+l4w5PddFQciH
OpfaUkQUPyP/7oPvR+3ga4IER1/g2PSNqZjXCBo90tHcitOWU+CCEKAStGfSslM/
mFn1ivsDN/Ykzj+iRI4wsF9AsTFzIahvdWjOAUULOpjySAfzjk+EivfJ16w/FLhs
Qiub8/0f1Wj40Goy3/58fFs75sp2do+0Wst5KsI0Wb8TMW0wqO71RyzkARpRe08+
qgYMxNu/4QeFvk7OcF+3bAfInrEqQg1JkIGs1DBLRf5eYZsT/yC0QfjIkiK+EtIN
JQWXukXu/HUTHJuK/QEk1V9Bb8d49qMX0fCJ1/Tv2OtRSk2EwJI=
=dKUq
-----END PGP SIGNATURE-----

--acbhrx54jyeevmcw--
