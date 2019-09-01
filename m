Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAF9A4BB7
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2019 22:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfIAUNs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Sep 2019 16:13:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbfIAUNs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 1 Sep 2019 16:13:48 -0400
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03A502190F;
        Sun,  1 Sep 2019 20:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567368827;
        bh=/pnvx7fXx7aB1zSkYAkxF9Mb5HZf517huqG1qnH5axI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mSiJ+hOpiK/RShw6XMEbQRYgTXLzW6Tnnp6Hhkj0PLRAxKjid60xN0JKf+LVRgupq
         kA/l60HntRllYA+gZCJlw9v+wwjJa4iLD7ENFJLRTA8pRz9tXirk4wpBMehfOUvFmX
         pmLvbGI9BgQpt9NRwebMeEUMlZ1RGmPH5wMreTzw=
Received: by earth.universe (Postfix, from userid 1000)
        id AB50B3C0B7F; Sun,  1 Sep 2019 22:13:44 +0200 (CEST)
Date:   Sun, 1 Sep 2019 22:13:44 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Romain Izard <romain.izard.pro@gmail.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: register HWMON devices with valid names
Message-ID: <20190901201344.i2c26f4wrnle6kfa@earth.universe>
References: <20190830131556.10021-1-romain.izard.pro@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c4buasnye3oatj63"
Content-Disposition: inline
In-Reply-To: <20190830131556.10021-1-romain.izard.pro@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--c4buasnye3oatj63
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 30, 2019 at 03:15:56PM +0200, Romain Izard wrote:
> With the introduction of the HWMON compatibility layer to the power
> supply framework in Linux 5.3, all power supply devices' names can be
> used directly to create HWMON devices with the same names.
>=20
> But HWMON has rules on allowable names that are different from those
> used in the power supply framework. The dash character is forbidden, as
> it is used by the libsensors library in userspace as a separator,
> whereas this character is used in the device names in more than half of
> the existing power supply drivers. This last case is consistent with the
> typical naming usage with MFD and Device Tree.
>=20
> This leads to warnings in the kernel log, with the format:
>=20
> power_supply gpio-charger: hwmon: \
> 	'gpio-charger' is not a valid name attribute, please fix
>=20
> Add a protection to power_supply_add_hwmon_sysfs() that replaces any
> dash in the device name with an underscore when registering with the
> HWMON framework. Other forbidden characters (star, slash, space, tab,
> newline) are not replaced, as they are not in common use.
>=20
> Fixes: e67d4dfc9ff1 ("power: supply: Add HWMON compatibility layer")
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---

Thanks, queued.

-- Sebastian

>=20
> v2: Remove a superfluous cast
>=20
>  drivers/power/supply/power_supply_hwmon.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/su=
pply/power_supply_hwmon.c
> index 51fe60440d12..75cf861ba492 100644
> --- a/drivers/power/supply/power_supply_hwmon.c
> +++ b/drivers/power/supply/power_supply_hwmon.c
> @@ -284,6 +284,7 @@ int power_supply_add_hwmon_sysfs(struct power_supply =
*psy)
>  	struct device *dev =3D &psy->dev;
>  	struct device *hwmon;
>  	int ret, i;
> +	const char *name;
> =20
>  	if (!devres_open_group(dev, power_supply_add_hwmon_sysfs,
>  			       GFP_KERNEL))
> @@ -334,7 +335,19 @@ int power_supply_add_hwmon_sysfs(struct power_supply=
 *psy)
>  		}
>  	}
> =20
> -	hwmon =3D devm_hwmon_device_register_with_info(dev, psy->desc->name,
> +	name =3D psy->desc->name;
> +	if (strchr(name, '-')) {
> +		char *new_name;
> +
> +		new_name =3D devm_kstrdup(dev, name, GFP_KERNEL);
> +		if (!new_name) {
> +			ret =3D -ENOMEM;
> +			goto error;
> +		}
> +		strreplace(new_name, '-', '_');
> +		name =3D new_name;
> +	}
> +	hwmon =3D devm_hwmon_device_register_with_info(dev, name,
>  						psyhw,
>  						&power_supply_hwmon_chip_info,
>  						NULL);
> --=20
> 2.17.1
>=20

--c4buasnye3oatj63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1sJngACgkQ2O7X88g7
+pp5aQ/+LkCU4NbcIvbNQMwVtFJ9tfxLqOZCeGxHvfwPlHAE3e+dvGDaX4A6e8JJ
b6a42lqoxZTM4EEr9M9NMOJiLcqeQHrl0R684pGWkv/CbRGt1W3IWRS0/aDC+EUE
6i4NdmXdmNuB3tjV4OmINIGQp2i2Yoa6+k4RJ/gI1yyQZgKTIiOI78FfHe433gm3
o4VYnIAy4VK/jfxdgJm1A/LcGXeG5yDxLRMMzIqtEZ5bTdrMN48YSv6SNdC9XG7M
0qccPbg+uW+dozdr7wRLizMF8makESodVz97Y/Dsa5daLB8u++gUB/f9WvKXo9FG
xZ4gyJYXwZec67So/I/+Vz2szkWfawj8GjUfGIAz+s7weaHa96PwXu3TYKeJQaTT
FTYCnNGivZfeBGZSdfcgIt0onCTBKLX893DvC4hiTTjFOqLYtuwPLgjFLJpZAxJx
XHJpkju7+YVf4mue81+l/i81y0M/Y6klPYXFFU2WvI/E2DvZX7GTNTRA7hCtnZzZ
T9xCzGT8GnaNn1FK7zSHZgJfqvksYEff7er///+OaZ3n4Vs0htIdb6JEWOLcqqlx
vnrA5bVg1IbOIUaEcfdEx5PamKGXWSi3L6u31A7zTj7QwLy8Qj1V/kTZpThBqRfD
NZHovFCL2zhvQ/Xvt33U5rGnSnAL33WJ2AOYUGE6K9Ttixgo5Fo=
=HuKa
-----END PGP SIGNATURE-----

--c4buasnye3oatj63--
