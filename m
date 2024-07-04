Return-Path: <linux-pm+bounces-10597-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F56F92743D
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 12:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D34B1B23391
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 10:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAA61ABC4B;
	Thu,  4 Jul 2024 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Vjj78pAk"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57321ABC47;
	Thu,  4 Jul 2024 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720089782; cv=none; b=RRgk14nTDga9jiZarAyHcr6/NSBDRSKJletAbkt0gEKGF1U1UzFFzd9QdDy1/ABOWr0QNUM45u3Yr+tfcjkQOi74lMX8CLH9FcWvIP4WY2Oxhj4yqCfZp8CAFODpJeHjn5qae+hXTL6Q2Uih7mbKAmCdfkfMkNKUS4h2Dz+1MRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720089782; c=relaxed/simple;
	bh=r6Hn0e3IalT2uWaAgGJoLIJ8VgpjCZODVCW/nG64NLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gW6mIVB2ke1WsjukmUiTRV1PY+ijO3ZU+BJmdHZxqjWUVHta0fAhaW4Ilur7CdqgR4b5QDqaO4u+G9r59a4MVwvhDNHkYM/TlVUo38UjBa22qzVL9xskoG8hohn0WLCBuomZAIu+wr553JMP87QkpIfpVAQfA53BTfm6tKpOry8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Vjj78pAk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720089778;
	bh=r6Hn0e3IalT2uWaAgGJoLIJ8VgpjCZODVCW/nG64NLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vjj78pAk1mnKrn7xbAK4oSuTNoAURhIn850ZIMZlrMYTDEWmEHwRScSHM85GUIFSm
	 nOuwpBczZgd09C6qEC/AuM9w7O3b2zCZjDz05UM28vbIougGSJD0Ookcz+JY/bg7Ai
	 hOQDW61hCV9gBhdclQQjPsNpJXDs8hjQQ1X+uKqfgPXKPAyyzfxNiU7lGAjL5byXuH
	 bOW5UvF/2lOIt3nrMdgUn8Bh5da6SK9erYXWeBoQNC20UchDjnu13Rd6BahTIV6ump
	 FUxG0G6n0S3sCaXndyOQ+SZT65vnnGkHQKlJt1X4ExZaHHVZXaG/SyXo7RsH0hOkaz
	 CS8NB160aCcsg==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 385B93781144;
	Thu,  4 Jul 2024 10:42:58 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 61FB4106066C; Thu, 04 Jul 2024 12:42:57 +0200 (CEST)
Date: Thu, 4 Jul 2024 12:42:57 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Armin Wolf <W_Armin@gmx.de>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/5] power: supply: core: avoid iterating
 properties directly
Message-ID: <sl55t3ds2lak53pe6omee25vt7zdtnzl2j24ec54lui42w47jt@urbvvqmns5nv>
References: <20240608-power-supply-extensions-v2-0-2dcd35b012ad@weissschuh.net>
 <20240608-power-supply-extensions-v2-2-2dcd35b012ad@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xswfieillim2hyws"
Content-Disposition: inline
In-Reply-To: <20240608-power-supply-extensions-v2-2-2dcd35b012ad@weissschuh.net>


--xswfieillim2hyws
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 08, 2024 at 09:19:38PM GMT, Thomas Wei=DFschuh wrote:
> With the introduction of power supply extension, it will not be enough
> to iterate the properties on the struct power_supply directly.
> Instead introduce a helper power_supply_has_property() which will handle
> properties added by extensions.

power_supply_has_property() needs to include properties from
battery_info, which are exposed in addition to the driver's
own properties.

Greetings,

-- Sebastian

>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---
>  drivers/power/supply/power_supply.h       |  3 ++
>  drivers/power/supply/power_supply_core.c  | 10 +++----
>  drivers/power/supply/power_supply_hwmon.c | 48 +++++++++++++++----------=
------
>  drivers/power/supply/power_supply_sysfs.c | 14 +++------
>  4 files changed, 36 insertions(+), 39 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/p=
ower_supply.h
> index 3cbafc58bdad..622be1f0a180 100644
> --- a/drivers/power/supply/power_supply.h
> +++ b/drivers/power/supply/power_supply.h
> @@ -13,6 +13,9 @@ struct device;
>  struct device_type;
>  struct power_supply;
> =20
> +extern bool power_supply_has_property(const struct power_supply_desc *ps=
y_desc,
> +				      enum power_supply_property psp);
> +
>  #ifdef CONFIG_SYSFS
> =20
>  extern void power_supply_init_attrs(void);
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index fefe938c9342..d57ecdd966e0 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1183,8 +1183,8 @@ bool power_supply_battery_bti_in_range(struct power=
_supply_battery_info *info,
>  }
>  EXPORT_SYMBOL_GPL(power_supply_battery_bti_in_range);
> =20
> -static bool psy_has_property(const struct power_supply_desc *psy_desc,
> -			     enum power_supply_property psp)
> +bool power_supply_has_property(const struct power_supply_desc *psy_desc,
> +			       enum power_supply_property psp)
>  {
>  	bool found =3D false;
>  	int i;
> @@ -1209,7 +1209,7 @@ int power_supply_get_property(struct power_supply *=
psy,
>  		return -ENODEV;
>  	}
> =20
> -	if (psy_has_property(psy->desc, psp))
> +	if (power_supply_has_property(psy->desc, psp))
>  		return psy->desc->get_property(psy, psp, val);
>  	else if (power_supply_battery_info_has_prop(psy->battery_info, psp))
>  		return power_supply_battery_info_get_prop(psy->battery_info, psp, val);
> @@ -1308,7 +1308,7 @@ static int psy_register_thermal(struct power_supply=
 *psy)
>  		return 0;
> =20
>  	/* Register battery zone device psy reports temperature */
> -	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
> +	if (power_supply_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
>  		/* Prefer our hwmon device and avoid duplicates */
>  		struct thermal_zone_params tzp =3D {
>  			.no_hwmon =3D IS_ENABLED(CONFIG_POWER_SUPPLY_HWMON)
> @@ -1361,7 +1361,7 @@ __power_supply_register(struct device *parent,
>  		pr_warn("%s: Expected proper parent device for '%s'\n",
>  			__func__, desc->name);
> =20
> -	if (psy_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
> +	if (power_supply_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
>  	    (!desc->usb_types || !desc->num_usb_types))
>  		return ERR_PTR(-EINVAL);
> =20
> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/su=
pply/power_supply_hwmon.c
> index c97893d4c25e..2ecbe4a74c25 100644
> --- a/drivers/power/supply/power_supply_hwmon.c
> +++ b/drivers/power/supply/power_supply_hwmon.c
> @@ -8,6 +8,8 @@
>  #include <linux/power_supply.h>
>  #include <linux/slab.h>
> =20
> +#include "power_supply.h"
> +
>  struct power_supply_hwmon {
>  	struct power_supply *psy;
>  	unsigned long *props;
> @@ -324,9 +326,26 @@ static const struct hwmon_chip_info power_supply_hwm=
on_chip_info =3D {
>  	.info =3D power_supply_hwmon_info,
>  };
> =20
> +static const enum power_supply_property power_supply_hwmon_props[] =3D {
> +	POWER_SUPPLY_PROP_CURRENT_AVG,
> +	POWER_SUPPLY_PROP_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_TEMP_MAX,
> +	POWER_SUPPLY_PROP_TEMP_MIN,
> +	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
> +	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
> +	POWER_SUPPLY_PROP_TEMP_AMBIENT,
> +	POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN,
> +	POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX,
> +	POWER_SUPPLY_PROP_VOLTAGE_AVG,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +};
> +
>  int power_supply_add_hwmon_sysfs(struct power_supply *psy)
>  {
> -	const struct power_supply_desc *desc =3D psy->desc;
>  	struct power_supply_hwmon *psyhw;
>  	struct device *dev =3D &psy->dev;
>  	struct device *hwmon;
> @@ -352,30 +371,11 @@ int power_supply_add_hwmon_sysfs(struct power_suppl=
y *psy)
>  		goto error;
>  	}
> =20
> -	for (i =3D 0; i < desc->num_properties; i++) {
> -		const enum power_supply_property prop =3D desc->properties[i];
> -
> -		switch (prop) {
> -		case POWER_SUPPLY_PROP_CURRENT_AVG:
> -		case POWER_SUPPLY_PROP_CURRENT_MAX:
> -		case POWER_SUPPLY_PROP_CURRENT_NOW:
> -		case POWER_SUPPLY_PROP_TEMP:
> -		case POWER_SUPPLY_PROP_TEMP_MAX:
> -		case POWER_SUPPLY_PROP_TEMP_MIN:
> -		case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> -		case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> -		case POWER_SUPPLY_PROP_TEMP_AMBIENT:
> -		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
> -		case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
> -		case POWER_SUPPLY_PROP_VOLTAGE_AVG:
> -		case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> -		case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> -		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +	for (i =3D 0; i < ARRAY_SIZE(power_supply_hwmon_props); i++) {
> +		const enum power_supply_property prop =3D power_supply_hwmon_props[i];
> +
> +		if (power_supply_has_property(psy->desc, prop))
>  			set_bit(prop, psyhw->props);
> -			break;
> -		default:
> -			break;
> -		}
>  	}
> =20
>  	name =3D psy->desc->name;
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 3e63d165b2f7..abd44ebfe6fe 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -367,7 +367,6 @@ static umode_t power_supply_attr_is_visible(struct ko=
bject *kobj,
>  	struct device *dev =3D kobj_to_dev(kobj);
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
>  	umode_t mode =3D S_IRUSR | S_IRGRP | S_IROTH;
> -	int i;
> =20
>  	if (!power_supply_attrs[attrno].prop_name)
>  		return 0;
> @@ -375,15 +374,10 @@ static umode_t power_supply_attr_is_visible(struct =
kobject *kobj,
>  	if (attrno =3D=3D POWER_SUPPLY_PROP_TYPE)
>  		return mode;
> =20
> -	for (i =3D 0; i < psy->desc->num_properties; i++) {
> -		int property =3D psy->desc->properties[i];
> -
> -		if (property =3D=3D attrno) {
> -			if (power_supply_property_is_writeable(psy, property) > 0)
> -				mode |=3D S_IWUSR;
> -
> -			return mode;
> -		}
> +	if (power_supply_has_property(psy->desc, attrno)) {
> +		if (power_supply_property_is_writeable(psy, attrno) > 0)
> +			mode |=3D S_IWUSR;
> +		return mode;
>  	}
> =20
>  	if (power_supply_battery_info_has_prop(psy->battery_info, attrno))
>=20
> --=20
> 2.45.2
>=20
>=20

--xswfieillim2hyws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmaGfKYACgkQ2O7X88g7
+ppA4hAAgr6kixbmAxt3HpswiG12L1aQBRjsNvCaval66hpmqtGGjRVbde8TYXAl
GCFoiPkfQ7kBSluAjalHWoVWfOUPIQjBplSEXGpJnc6mhchIIbDV9ElPxkSAFX3r
i61xhqD+4M26NHyxl4C7uC58e2BwPcZ2zNZ/JbDVGQzrT2O3VkJ1Vj5eiVSgkawL
dope8NI7gxzGorCyWlIGTWlTaWA+YdzxkthoSR0jaOXjoreeJw0s6Fm9UKZDf2ol
fyPZXJ7NtQ9Cfdcsqm+NLD2gOiqRFlh8UefqhxORASl75W8X0EIrVJzsLSC7UkqL
AlBbUi5vBJqDoE/+on6awj0f28Nq+zxRe8h8rxJC2ydh973EYHccswrPlsDuVlQ6
D6ODtgGuemwuRWkMqeKFGYrpD8XIFzGQcD7+FiiETO7m554CGvFJenbQJb4WnU7c
kLIsrWGl3QNSXrS0kYXq5QeAymmcYYPrTppW5kqPokOLUaFvev6RIz05RpL4diUp
sgUXE+Np+hYRd2oEgI7NliGHRH/1LZwANKhy7dNrSJa4fKJR3h3vudI4EnqK+3dl
pqaKiECqLohlxCS/w1oteqhm0rxl6wvPZprLaW7UCGx0UpISbbAzluwPxYX1Ki+i
YI8WGsnJHh6ejNZM2qIW7ZAQgm7nnGLguHQgOjgi0OG9qqCElcQ=
=FIE3
-----END PGP SIGNATURE-----

--xswfieillim2hyws--

