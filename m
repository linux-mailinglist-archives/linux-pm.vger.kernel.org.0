Return-Path: <linux-pm+bounces-14250-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A816E978F88
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 11:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363081F218AB
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 09:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED181CCEEE;
	Sat, 14 Sep 2024 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="PxLG7Rmu"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D816F14F118;
	Sat, 14 Sep 2024 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726306550; cv=pass; b=vDoJTdcEXkVbJDTx0lLaPgUmKm8Mdr7aMozWcnxh4OvulgSHXc9QSsO9uYFlWCawjGPt+CJq2uA6jy7a9I/YPUm/NKTBZCzG8ySdeKvFCuGNibqwp8Oa5RX2CSO7PeIc19BXW7YKGZ0TNA58PG6QBNhLRJsi1q64+wp4COGJDG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726306550; c=relaxed/simple;
	bh=95rFxjfBTJXJ8zua5g3voqls50XTWz7BaObiWDHAQG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHXmjFRdXTs9SGJbULm/FHhn7nIoFAanTcLnQt0tcV8tlwDlvaJX21gxtW2R+YbC2I/PiXsOp9MWtw9VyK7JVyiLyshNerF/Ri62SX51dj5A7/PTpZnuRyIUZWWSlk4+FcUFKOpc449MZpgl0cS37Vjywqv/21NWXaT1zuvoKzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=PxLG7Rmu; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726306541; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Cuwoo+ZJyfUCqLQhCOXnbY7KQiRP69ke4i4JfJh7P8w1Ts0sTXW61K1HjMe/ErF4FpRyfh2QIfEGa6oet6TlOw4p0tpJfws1B53b/0bPP4noWRwlebEmgD/kQ9WNKZudbngoviwFlflUo74DzmUld81rVxMk9gEmzqOBLWev/vk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726306541; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BJf/nio0dhtr2vHlZI6OPhn8ad2d/DR84zGkhnGioZI=; 
	b=KqyaV5qYQu3K9q+JA+DLLwz6pwlNcQFT8Qrj+5QRFIznv0JEGXvZO0QRKvkMTA3gzKbkH2GdIVjd0XgUPZ1rwTby4I7iOI21vucv9sTLD96kBrJKbSFfJZ7a/Xt4d42GYXLhT6dxeWDGzI6ryZh1GPdcwE+rIpYvyL0UECkzXdo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726306541;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=BJf/nio0dhtr2vHlZI6OPhn8ad2d/DR84zGkhnGioZI=;
	b=PxLG7Rmum7Cl59TgwEfPSK9HACcq9FjrSqyGZ7vXOsnYTFA5XK68sPzXEOZ78UJo
	fTflnGqHTLNE54fvSYFypnWfF1OIiwcmseTDOphXuhPjP/Ffas0iOVZCInzB9Grwic3
	cxoxJJQJ77P0pHnUP3Wv2ilNMLaH9N+FBhEaZEaA=
Received: by mx.zohomail.com with SMTPS id 172630653879631.10850661180416;
	Sat, 14 Sep 2024 02:35:38 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id E8DA31060578; Sat, 14 Sep 2024 11:35:32 +0200 (CEST)
Date: Sat, 14 Sep 2024 11:35:32 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 3/9] power: supply: hwmon: register battery
 properties
Message-ID: <i3fh5xurju4ma5lkupqytt5mqke2a35mllguelxxmprjokpuew@7xbqt6spt653>
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
 <20240904-power-supply-extensions-v3-3-62efeb93f8ec@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3oa72ub2qq73gf3k"
Content-Disposition: inline
In-Reply-To: <20240904-power-supply-extensions-v3-3-62efeb93f8ec@weissschuh.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/223.982.64
X-ZohoMailClient: External


--3oa72ub2qq73gf3k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 04, 2024 at 09:25:36PM GMT, Thomas Wei=DFschuh wrote:
> Instead of only registering properties from the psy_desc itself,
> also register the ones from the battery.
> Use power_supply_has_property() for this test which makes the logic also
> easier to read.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  drivers/power/supply/power_supply_hwmon.c | 52 +++++++++++++++----------=
------
>  1 file changed, 26 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/su=
pply/power_supply_hwmon.c
> index baacefbdf768..1c1ad3e1d81f 100644
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
> @@ -347,9 +349,28 @@ static const struct hwmon_chip_info power_supply_hwm=
on_chip_info =3D {
>  	.info =3D power_supply_hwmon_info,
>  };
> =20
> +static const enum power_supply_property power_supply_hwmon_props[] =3D {
> +	POWER_SUPPLY_PROP_CURRENT_AVG,
> +	POWER_SUPPLY_PROP_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_POWER_AVG,
> +	POWER_SUPPLY_PROP_POWER_NOW,
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
> @@ -375,32 +396,11 @@ int power_supply_add_hwmon_sysfs(struct power_suppl=
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
> -		case POWER_SUPPLY_PROP_POWER_AVG:
> -		case POWER_SUPPLY_PROP_POWER_NOW:
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
> +		if (power_supply_has_property(psy, prop))
>  			set_bit(prop, psyhw->props);
> -			break;
> -		default:
> -			break;
> -		}
>  	}
> =20
>  	name =3D psy->desc->name;
>=20
> --=20
> 2.46.0
>=20
>=20

--3oa72ub2qq73gf3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmblWOQACgkQ2O7X88g7
+prvhxAAqMx1ciIpLzx5SWinc6lCqnkaMfSQkQlzOb9L13P3PrpgVG4aU/n4kuD6
hHgnP1j3Vd2y9W+6IUs1Xnnq5mhbWrMAgvLDanayWZKXflNq1pXPEHmTSDOrzww1
0/j247Q8QRGZFdgmznzKXynszNNlQONMsXsEEJGe73tobXq+mynB3DYf9EL+c1lP
8IvtGLEE9Qwg8AH4lT8RKlcLKUSnbkQ3V48+O8MLFHIgg0OF2FLDvdN2PkFNck/g
xxJ6CYvX9ML2AIfR2P5vXXD7zESTzgWq1WrWHw2CP8552XQv93FbvmbJLWnffqVq
PIJkJtUr0GJ7+vNtsvVLHSegrBJ8KA9AF8sUPkmRzUYw0Q1hv70SqXkD9sKSzSmr
kFtOSH0JICXfcPFveABgCluLCpNJd9+hFTZKe8dcHb5knB8VBhBVm2Gcb1Ah65Xj
hgcFMWTWQ9CFilKwPQ6U3qxm8r9TM7f/xRs9rnDOYKipP3zIiIB/VVbpkjku/vGC
B/4w9gZZ27wR191U0D53Bp3PQu3tB1Rs6CGk6ktUZ+ZPQGr70ar1HfmNaxxknPLV
B/B25urk2nsph5hbF1U94f9dHCXGtRRwCYFHRq+bziYVM9wiezwoi0DrGqT1Mych
GTCWtet/8dl+b84IGR+J30z7GqMwaUs1SNKBxVfnEtb1KoypSnw=
=3cJX
-----END PGP SIGNATURE-----

--3oa72ub2qq73gf3k--

