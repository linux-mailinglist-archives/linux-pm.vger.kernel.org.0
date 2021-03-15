Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A388733A976
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 02:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhCOBzv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Mar 2021 21:55:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229723AbhCOBzg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 14 Mar 2021 21:55:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 114FB64D92;
        Mon, 15 Mar 2021 01:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615773336;
        bh=AMTS60gMpBvPbiPBCIu0qdctqByuAgh3Ih8GErbrXos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pd+aRmRqQ/piJC2puTAm0iDLQ6sljuY7j5EfzW6MhGgd9R/h32fE5bpcQOzGq42nV
         vl9H8hXecDIJqK9axkspIc6hX/b4hpTaR4MX/fB0aJ5oOhQVtt6KMhwptEL+ANtKOE
         2o1mRJXd9Nu2p940ICG+8Rf0HUPvKjWlH2W1jt6hciR423o7UMfXmi2o/557BxFX9y
         /ZaBqudntXKV7swmjhmVsqeeg9BVOEn9uM96yfjWDwm0br5eMRw6dG0cdTRBiNBPn2
         w5LerXAcKGQSDmuvVZx56TSs5QtgrQuOuMxM09n/h7p1n8xRs/EUs3EiMtppEsTfVW
         DImUauxgiA5Cg==
Received: by earth.universe (Postfix, from userid 1000)
        id 5BCD53C0C96; Mon, 15 Mar 2021 02:55:34 +0100 (CET)
Date:   Mon, 15 Mar 2021 02:55:34 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] power: supply: bq27xxx: make status more robust
Message-ID: <20210315015534.d7rv76e4gp35wqug@earth.universe>
References: <20210303095420.29054-1-matthias.schiffer@ew.tq-group.com>
 <20210303095420.29054-3-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gxdtfnruh7tkfi7r"
Content-Disposition: inline
In-Reply-To: <20210303095420.29054-3-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--gxdtfnruh7tkfi7r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 03, 2021 at 10:54:20AM +0100, Matthias Schiffer wrote:
> There are multiple issues in bq27xxx_battery_status():
>=20
> - On BQ28Q610 is was observed that the "full" flag may be set even while
>   the battery is charging or discharging. With the current logic to make
>   "full" override everything else, it look a very long time (>20min) for
>   the status to change from "full" to "discharging" after unplugging the
>   supply on a device with low power consumption
> - The POWER_SUPPLY_STATUS_NOT_CHARGING check depends on
>   power_supply_am_i_supplied(), which will not work when the supply
>   doesn't exist as a separate device known to Linux
>=20
> We can solve both issues by deriving the status from the current instead
> of the flags field. The flags are now only used to distinguish "full"
> from "not charging", and to determine the sign of the current on
> BQ27XXX_O_ZERO devices.
>=20
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---

Thanks, queued.

-- Sebastian

>=20
> v2: no changes
>=20
>  drivers/power/supply/bq27xxx_battery.c | 88 +++++++++++++-------------
>  1 file changed, 43 insertions(+), 45 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 20e1dc8a87cf..b62a8cfd9d09 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1777,14 +1777,27 @@ static void bq27xxx_battery_poll(struct work_stru=
ct *work)
>  		schedule_delayed_work(&di->work, poll_interval * HZ);
>  }
> =20
> +static bool bq27xxx_battery_is_full(struct bq27xxx_device_info *di, int =
flags)
> +{
> +	if (di->opts & BQ27XXX_O_ZERO)
> +		return (flags & BQ27000_FLAG_FC);
> +	else if (di->opts & BQ27Z561_O_BITS)
> +		return (flags & BQ27Z561_FLAG_FC);
> +	else
> +		return (flags & BQ27XXX_FLAG_FC);
> +}
> +
>  /*
> - * Return the battery average current in =B5A
> + * Return the battery average current in =B5A and the status
>   * Note that current can be negative signed as well
>   * Or 0 if something fails.
>   */
> -static int bq27xxx_battery_current(struct bq27xxx_device_info *di,
> -				   union power_supply_propval *val)
> +static int bq27xxx_battery_current_and_status(
> +	struct bq27xxx_device_info *di,
> +	union power_supply_propval *val_curr,
> +	union power_supply_propval *val_status)
>  {
> +	bool single_flags =3D (di->opts & BQ27XXX_O_ZERO);
>  	int curr;
>  	int flags;
> =20
> @@ -1794,17 +1807,39 @@ static int bq27xxx_battery_current(struct bq27xxx=
_device_info *di,
>  		return curr;
>  	}
> =20
> +	flags =3D bq27xxx_read(di, BQ27XXX_REG_FLAGS, single_flags);
> +	if (flags < 0) {
> +		dev_err(di->dev, "error reading flags\n");
> +		return flags;
> +	}
> +
>  	if (di->opts & BQ27XXX_O_ZERO) {
> -		flags =3D bq27xxx_read(di, BQ27XXX_REG_FLAGS, true);
>  		if (!(flags & BQ27000_FLAG_CHGS)) {
>  			dev_dbg(di->dev, "negative current!\n");
>  			curr =3D -curr;
>  		}
> =20
> -		val->intval =3D curr * BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
> +		curr =3D curr * BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
>  	} else {
>  		/* Other gauges return signed value */
> -		val->intval =3D (int)((s16)curr) * 1000;
> +		curr =3D (int)((s16)curr) * 1000;
> +	}
> +
> +	if (val_curr)
> +		val_curr->intval =3D curr;
> +
> +	if (val_status) {
> +		if (curr > 0) {
> +			val_status->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +		} else if (curr < 0) {
> +			val_status->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		} else {
> +			if (bq27xxx_battery_is_full(di, flags))
> +				val_status->intval =3D POWER_SUPPLY_STATUS_FULL;
> +			else
> +				val_status->intval =3D
> +					POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		}
>  	}
> =20
>  	return 0;
> @@ -1836,43 +1871,6 @@ static int bq27xxx_battery_pwr_avg(struct bq27xxx_=
device_info *di,
>  	return 0;
>  }
> =20
> -static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
> -				  union power_supply_propval *val)
> -{
> -	int status;
> -
> -	if (di->opts & BQ27XXX_O_ZERO) {
> -		if (di->cache.flags & BQ27000_FLAG_FC)
> -			status =3D POWER_SUPPLY_STATUS_FULL;
> -		else if (di->cache.flags & BQ27000_FLAG_CHGS)
> -			status =3D POWER_SUPPLY_STATUS_CHARGING;
> -		else
> -			status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> -	} else if (di->opts & BQ27Z561_O_BITS) {
> -		if (di->cache.flags & BQ27Z561_FLAG_FC)
> -			status =3D POWER_SUPPLY_STATUS_FULL;
> -		else if (di->cache.flags & BQ27Z561_FLAG_DIS_CH)
> -			status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> -		else
> -			status =3D POWER_SUPPLY_STATUS_CHARGING;
> -	} else {
> -		if (di->cache.flags & BQ27XXX_FLAG_FC)
> -			status =3D POWER_SUPPLY_STATUS_FULL;
> -		else if (di->cache.flags & BQ27XXX_FLAG_DSC)
> -			status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> -		else
> -			status =3D POWER_SUPPLY_STATUS_CHARGING;
> -	}
> -
> -	if ((status =3D=3D POWER_SUPPLY_STATUS_DISCHARGING) &&
> -	    (power_supply_am_i_supplied(di->bat) > 0))
> -		status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> -
> -	val->intval =3D status;
> -
> -	return 0;
> -}
> -
>  static int bq27xxx_battery_capacity_level(struct bq27xxx_device_info *di,
>  					  union power_supply_propval *val)
>  {
> @@ -1960,7 +1958,7 @@ static int bq27xxx_battery_get_property(struct powe=
r_supply *psy,
> =20
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_STATUS:
> -		ret =3D bq27xxx_battery_status(di, val);
> +		ret =3D bq27xxx_battery_current_and_status(di, NULL, val);
>  		break;
>  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>  		ret =3D bq27xxx_battery_voltage(di, val);
> @@ -1969,7 +1967,7 @@ static int bq27xxx_battery_get_property(struct powe=
r_supply *psy,
>  		val->intval =3D di->cache.flags < 0 ? 0 : 1;
>  		break;
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
> -		ret =3D bq27xxx_battery_current(di, val);
> +		ret =3D bq27xxx_battery_current_and_status(di, val, NULL);
>  		break;
>  	case POWER_SUPPLY_PROP_CAPACITY:
>  		ret =3D bq27xxx_simple_value(di->cache.capacity, val);
> --=20
> 2.17.1
>=20

--gxdtfnruh7tkfi7r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBOvpYACgkQ2O7X88g7
+pr3ow/+O7Va23H/A0huo5H/r6ZUNqkK+7/McuqBEtbV/bcALxvLqTshBcOJvR92
IiX6m0SCfz56VTticjzXnGy7GLGF7k4P8VbwovuIBoKWHXAIZU+yGqsODWXzzMJp
WfnoEvzSedYJvayBzxAKoIfIuhPWx0FprVUvpoy0nrhgf0IUdtoLMqALtgRgbhvr
4zEAVJ1jJkiBEhdefL22OwnFdUzfsgXkG17W5qc1jYf/5Nm9loyIHxV2QzKcD4yG
e7qxyMo3ldx0MvFOjGCQlET9q3gh5JB2THniErIE+HQwv4pqcLN6xRYuXlrLwgKa
VVlaChM8fQ148Rq1V0dwCTnJ6COCjKjT2rQzvhjvmTy32Pf3F49Hh4/bSLCbOIjH
MGRN2he3ZNkg/GaDIHfG2Aav+bTZnTOh3ZB5y/1gdXfxXg+j5/rhudn+9wATVsBn
pCosax+wsPrAY30I2metprQZi9H6HeQcapkioiNRdm0Bojq0qak6xA7x2gDiL0v6
chgzAg4kB7ZBreZlBXXU/ES/OOU785oLPgbz4UKhWz7OySuOeoL8AByqs3GsIwbM
obhLU83y+ap42C7rIwCwEb8kDhJaXY2FzGaAYJmPmPPLgVxe7ZF+95xHUIgKttz6
qqDzJb399WHFzkjVgkzxKkk9TJx4PYlj09RUDVhvJWX920OzzNQ=
=GhAM
-----END PGP SIGNATURE-----

--gxdtfnruh7tkfi7r--
