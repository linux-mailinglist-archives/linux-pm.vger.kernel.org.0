Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BF82019EB
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jun 2020 20:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733166AbgFSSDv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jun 2020 14:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgFSSDv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Jun 2020 14:03:51 -0400
Received: from earth.universe (dyndsl-037-138-190-043.ewe-ip-backbone.de [37.138.190.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 239A320DD4;
        Fri, 19 Jun 2020 18:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592589830;
        bh=XpQcmkHUs6scw56HIc1aqVY7nFfbPMX/4F+G2CVJtCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UJxY/L4df9jEX6dfoD6VrzqtO7UC3LKJlfUzTgxIBvb81T2/h8Ri7YmNpA1XlYNw5
         EDWJLMJ2jc/Rybwv4aPGmjNtVPkKbsq4GelMlA30sUaYQzx7TDTaDFXH/U7s8YyIiy
         jI17E2K3uDm6vUD1GEN+Bde7Bd6hRJpIWKFA5MiY=
Received: by earth.universe (Postfix, from userid 1000)
        id 81DB63C08CD; Fri, 19 Jun 2020 20:03:48 +0200 (CEST)
Date:   Fri, 19 Jun 2020 20:03:48 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: max8998_charger: Correct ONLINE and add
 STATUS props
Message-ID: <20200619180348.hmjedqcp3uqlyj7i@earth.universe>
References: <CY4PR04MB066382CE428A87AD131DB96CA3BA0@CY4PR04MB0663.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w735oymtygjx5gmu"
Content-Disposition: inline
In-Reply-To: <CY4PR04MB066382CE428A87AD131DB96CA3BA0@CY4PR04MB0663.namprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--w735oymtygjx5gmu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 16, 2020 at 03:35:44PM -0700, Jonathan Bakker wrote:
> The ONLINE prop should be when the charger is present (ie able to
> charge), however, it was for when it was actually charging or not.
> Instead, add the STATUS prop to show whether charging is actually
> going on or not.
>=20
> The magic numbers have been ported from a downstream kernel for the
> SGH-T959V.
>=20
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/max8998_charger.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/max8998_charger.c b/drivers/power/suppl=
y/max8998_charger.c
> index 9a926c7c0f22..c26023b19f26 100644
> --- a/drivers/power/supply/max8998_charger.c
> +++ b/drivers/power/supply/max8998_charger.c
> @@ -23,6 +23,7 @@ struct max8998_battery_data {
>  static enum power_supply_property max8998_battery_props[] =3D {
>  	POWER_SUPPLY_PROP_PRESENT, /* the presence of battery */
>  	POWER_SUPPLY_PROP_ONLINE, /* charger is active or not */
> +	POWER_SUPPLY_PROP_STATUS, /* charger is charging/discharging/full */
>  };
> =20
>  /* Note that the charger control is done by a current regulator "CHARGER=
" */
> @@ -49,10 +50,28 @@ static int max8998_battery_get_property(struct power_=
supply *psy,
>  		ret =3D max8998_read_reg(i2c, MAX8998_REG_STATUS2, &reg);
>  		if (ret)
>  			return ret;
> -		if (reg & (1 << 3))
> -			val->intval =3D 0;
> -		else
> +
> +		if (reg & (1 << 5))
>  			val->intval =3D 1;
> +		else
> +			val->intval =3D 0;
> +
> +		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		ret =3D max8998_read_reg(i2c, MAX8998_REG_STATUS2, &reg);
> +		if (ret)
> +			return ret;
> +
> +		if (!(reg & (1 << 5))) {
> +			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		} else {
> +			if (reg & (1 << 6))
> +				val->intval =3D POWER_SUPPLY_STATUS_FULL;
> +			else if (reg & (1 << 3))
> +				val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +			else
> +				val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		}
>  		break;
>  	default:
>  		return -EINVAL;
> --=20
> 2.20.1
>=20

--w735oymtygjx5gmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7s/gQACgkQ2O7X88g7
+poW0g/5ASrparSqnyb/SlMkJRqwhDyImrnEfTNaaJz+8Ro+DKq4h4kMZW3fdPO1
qr77SfFw/ZO/7gWqT4Wk8QcvS+jNPfAxzOhBD1Ob+LW53duR/Febes4ysejyQeBp
C+NiFoBqZ98b8h12fo6XEsk7t9bKUDa0nUS/88h+hGkBnTW2HIJIIdjPDI82pWLF
plS+B5evPO5puIHccegHqSRjL4ltKUL+G/ImivS8cWBlISRXRQctVXLArjyuw9c2
SBC+Fvrg+P6oHYGDdSj+7fNeDow2rR3uGA1aW++nlHVERw0jj8ON5ZRoh3tohYue
+s16kRDQHLf6gCOJSjEeQUbt/j8XtOqOMiUjbRvNZlQbJwjVOTRJRig676cPxfgB
HQ6Gchl1m5x9+MnNp8INX4gp7Q5lNAeS5kBn4CaU/1AXttBJlq8zQAcy4a7HjQxm
pXeUPaGhmcEcAW5+7bukWiKXPaLm3zDqJit1xBpY8+kU3DkTfh4V+YB3W6VtuOfc
LDmp0ylVx2yCkw+ZsjjoLDmzn2NWiqZzFKIxLDjQ1erF62DChEzqoITeHBBWXUo+
3CwPI+NBx8cTJbzimTgmK91fam5X8x8LM6lfWkN7lJirTuECKYaEA8GKLR6Jh1z5
V4OdU3NSrEU3EEvL7LDtK+IBlDIxWiIxCz206y1a01G6WVv5y4M=
=4zhX
-----END PGP SIGNATURE-----

--w735oymtygjx5gmu--
