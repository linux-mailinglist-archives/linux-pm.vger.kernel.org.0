Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC2333A977
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 02:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhCOBzv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Mar 2021 21:55:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhCOBzV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 14 Mar 2021 21:55:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11EC864E67;
        Mon, 15 Mar 2021 01:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615773321;
        bh=nVjBE/YAgAi5qC0iN0iHucVz5KYJSEP12RH/z68bNMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oRkzt1dl2BkCQv5Z0HYb2aAIDwWlT8cU17Y9q/viOfdgUQwUMKbebYSEfqGDeQh0E
         kGwCBi7dxjmLITrfHANwbcKTOhpCPKz0SD1oZJXWArAPkeTMd5vhDBcfRnS2hDozeq
         1tpjyu0vMpTC70g8VADGX0m0Pq9CnjzAJilJ484ILIlaZCzymovpx05k2J1Lusi3u0
         uiwxc3FNBzontw1p0odq6icwZD4smfRIHh+QA+2dsQIfQJJg93qF1UJHCHcHF+jTf/
         Q7fb5qBvT8UfdUDzEmcgXnffx4u65Idq4U+LljqMiOP1LVZ8y9hIPqYxTerMzVNATI
         pOQXj4ogGGdVQ==
Received: by earth.universe (Postfix, from userid 1000)
        id 32F273C0C96; Mon, 15 Mar 2021 02:55:19 +0100 (CET)
Date:   Mon, 15 Mar 2021 02:55:19 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] power: supply: bq27xxx: fix power_avg for newer
 ICs
Message-ID: <20210315015519.zicho37dqkqbz4bw@earth.universe>
References: <20210303095420.29054-1-matthias.schiffer@ew.tq-group.com>
 <20210303095420.29054-2-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="54534snac7meqzeq"
Content-Disposition: inline
In-Reply-To: <20210303095420.29054-2-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--54534snac7meqzeq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 03, 2021 at 10:54:19AM +0100, Matthias Schiffer wrote:
> On all newer bq27xxx ICs, the AveragePower register contains a signed
> value; in addition to handling the raw value as unsigned, the driver
> code also didn't convert it to =B5W as expected.
>=20
> At least for the BQ28Z610, the reference manual incorrectly states that
> the value is in units of 1mW and not 10mW. I have no way of knowing
> whether the manuals of other supported ICs contain the same error, or if
> there are models that actually use 1mW. At least, the new code shouldn't
> be *less* correct than the old version for any device.
>=20
> power_avg is removed from the cache structure, se we don't have to
> extend it to store both a signed value and an error code. Always getting
> an up-to-date value may be desirable anyways, as it avoids inconsistent
> current and power readings when switching between charging and
> discharging.
>=20
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---

Thanks, queued.

-- Sebastian

>=20
> v2: fixed units in commit message
>=20
>  drivers/power/supply/bq27xxx_battery.c | 51 ++++++++++++++------------
>  include/linux/power/bq27xxx_battery.h  |  1 -
>  2 files changed, 27 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index cb6ebd2f905e..20e1dc8a87cf 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1661,27 +1661,6 @@ static int bq27xxx_battery_read_time(struct bq27xx=
x_device_info *di, u8 reg)
>  	return tval * 60;
>  }
> =20
> -/*
> - * Read an average power register.
> - * Return < 0 if something fails.
> - */
> -static int bq27xxx_battery_read_pwr_avg(struct bq27xxx_device_info *di)
> -{
> -	int tval;
> -
> -	tval =3D bq27xxx_read(di, BQ27XXX_REG_AP, false);
> -	if (tval < 0) {
> -		dev_err(di->dev, "error reading average power register  %02x: %d\n",
> -			BQ27XXX_REG_AP, tval);
> -		return tval;
> -	}
> -
> -	if (di->opts & BQ27XXX_O_ZERO)
> -		return (tval * BQ27XXX_POWER_CONSTANT) / BQ27XXX_RS;
> -	else
> -		return tval;
> -}
> -
>  /*
>   * Returns true if a battery over temperature condition is detected
>   */
> @@ -1769,8 +1748,6 @@ void bq27xxx_battery_update(struct bq27xxx_device_i=
nfo *di)
>  		}
>  		if (di->regs[BQ27XXX_REG_CYCT] !=3D INVALID_REG_ADDR)
>  			cache.cycle_count =3D bq27xxx_battery_read_cyct(di);
> -		if (di->regs[BQ27XXX_REG_AP] !=3D INVALID_REG_ADDR)
> -			cache.power_avg =3D bq27xxx_battery_read_pwr_avg(di);
> =20
>  		/* We only have to read charge design full once */
>  		if (di->charge_design_full <=3D 0)
> @@ -1833,6 +1810,32 @@ static int bq27xxx_battery_current(struct bq27xxx_=
device_info *di,
>  	return 0;
>  }
> =20
> +/*
> + * Get the average power in =B5W
> + * Return < 0 if something fails.
> + */
> +static int bq27xxx_battery_pwr_avg(struct bq27xxx_device_info *di,
> +				   union power_supply_propval *val)
> +{
> +	int power;
> +
> +	power =3D bq27xxx_read(di, BQ27XXX_REG_AP, false);
> +	if (power < 0) {
> +		dev_err(di->dev,
> +			"error reading average power register %02x: %d\n",
> +			BQ27XXX_REG_AP, power);
> +		return power;
> +	}
> +
> +	if (di->opts & BQ27XXX_O_ZERO)
> +		val->intval =3D (power * BQ27XXX_POWER_CONSTANT) / BQ27XXX_RS;
> +	else
> +		/* Other gauges return a signed value in units of 10mW */
> +		val->intval =3D (int)((s16)power) * 10000;
> +
> +	return 0;
> +}
> +
>  static int bq27xxx_battery_status(struct bq27xxx_device_info *di,
>  				  union power_supply_propval *val)
>  {
> @@ -2020,7 +2023,7 @@ static int bq27xxx_battery_get_property(struct powe=
r_supply *psy,
>  		ret =3D bq27xxx_simple_value(di->cache.energy, val);
>  		break;
>  	case POWER_SUPPLY_PROP_POWER_AVG:
> -		ret =3D bq27xxx_simple_value(di->cache.power_avg, val);
> +		ret =3D bq27xxx_battery_pwr_avg(di, val);
>  		break;
>  	case POWER_SUPPLY_PROP_HEALTH:
>  		ret =3D bq27xxx_simple_value(di->cache.health, val);
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/=
bq27xxx_battery.h
> index 111a40d0d3d5..8d5f4f40fb41 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -53,7 +53,6 @@ struct bq27xxx_reg_cache {
>  	int capacity;
>  	int energy;
>  	int flags;
> -	int power_avg;
>  	int health;
>  };
> =20
> --=20
> 2.17.1
>=20

--54534snac7meqzeq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBOvoYACgkQ2O7X88g7
+poZ9BAAhr0kGYebJZbZu6yQQqwwbsX7iCguYifTH3GkdO/y4uT7Yp+ISsB92p8v
LIT1t2kwAaa81gonRt99Z4VG82pAdmWj8NZCueRoakUYv0HUT2iAtR/ucACygLEm
KjNHOCHWGreKwwoB+iYY1GyLIYw3XS+vtAQf/Vavr1YhagsR1eSsYYA4aD/gnTxE
+P8Zz116vbUnTurOd54zSEhj65iI/1OUKzgrM/H45czK32IowYsYyPWtlkLd5pXn
5SvmkLRF/nsBDgyCrldfeDYNwcVUWATsCa7M6SDYM7gF1jS/+bZLa5SPypQm/yOo
VXN0Cx8ItWD/7rg96jAtsuclbiFUvgkaJ3Nd3aiUW+iBVoqrsDhVdwURgndeX0On
G3jHhUbEBthcdyc+5MMn/LdtTLYxEO4UJjPQpq/BNwNHVg5y7CpKE54I9VU+wObc
5UmaSBQ7nIYRmfqCa5LsueAEmMaw7l85WlF1XxfvJGaNHeNbhXdi5N1kOvS0TjBJ
rd2ledDDOR+Y+XqRDB68qixeB5TPd1NXrVDBMT2Jrn9zLXqSLyj9/6XjzwBefG2D
pvIJtymsGNw+VC0vto9xEuwWRXZlcEs3jLZ6HqWdnQp5/BoLF8YnWDJ5bNdpfdxm
DFvQxbf8jnkRMlGiXHEzlXi2ZVL6rHKCoHyisvWzcXciGpt+IqQ=
=9wlF
-----END PGP SIGNATURE-----

--54534snac7meqzeq--
