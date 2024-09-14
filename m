Return-Path: <linux-pm+bounces-14248-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBAB978F7C
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 11:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FA61F234AB
	for <lists+linux-pm@lfdr.de>; Sat, 14 Sep 2024 09:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53131CDA0A;
	Sat, 14 Sep 2024 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="ctsHJz66"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE65376046;
	Sat, 14 Sep 2024 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726306161; cv=pass; b=XO7DbCsaq0sfJZ/v5FwL+2Uwhwk0twEdr+VSW2mzPueTuLHQlXY+iknvUi8TaSCfX5Z8fqb1jFAXkgwrU+Zt97pOwSdlla28NxTxGsKgLMjbvAE/xVEI2Bp6NBg+EYrpiJdRbLAeATwbrqAAFpXsExoAJaEM/jvbsXk/wpHhShM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726306161; c=relaxed/simple;
	bh=L81fid8Wcm+kvwcy3A0Oa3G7XD29lKGBY/fba+H3dHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CowrRs2MbGWkA2k8r2ZVjBoRC/JvwKINb9yneUVxvOSLFCgYLdQLGCqLTg0UxiVVSmUhjwECM9WlMGTz0r34RUiEUHvNMexbwm2MD3dhPORFtwIPrmuXwJbPo1AyEa1RgSVkCEGSb7JYQjtGbz7FELm7sqvJbzlK9vBKuMZxwT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=ctsHJz66; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726306151; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=khGgd13W7iWlNUR7aA5XLm5p5c8LTXin5W6YYmBr7zdFjY1UcKpmjmU2t1naFfkdSu2didZkxTzw1UWWtQpX9mPgGMa9vKdZn+4usTs7uMleW+cC0RwcqgK7hgFHDvyZuicy3dCSl2jz1dwQU/4D18OEy226cFq18orYMq3Ezas=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726306151; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/7oTESlBva5gGyxqjRV+meAdzbfjJjp/d+s3NB4DO8M=; 
	b=SL/ECOeS7naFLoORjxJtp0zjq8ZYuNAo899usPRrQZS1NM2ZG26ZU5S3HLgb7shvdtue/+9W1/aBU/fdoBVuHcOkJ8gRY4vtDoW8KicVEhNu14cCVsawfzTVuYuNjRgCvBq4Waa8bD8L6S1vI5lgaAIvLMnMsZh+8KnhcCRPu/c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726306151;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=/7oTESlBva5gGyxqjRV+meAdzbfjJjp/d+s3NB4DO8M=;
	b=ctsHJz66yoCaUR8++I2NpPv0bVn4ZQDLvqoI3Ubd+S46mkSOMeMK3saCYamf/XLq
	1sRKN30KPZ1/DqMQjb5TG5kxuqUJKABU00DevZ884VIOCuTBUg/GWDvS2xZiG4yEwJc
	R9byMtVvxTiJn3Z80Jtgl8hqPvDkdm9TZxQZHJzo=
Received: by mx.zohomail.com with SMTPS id 1726306151123256.3721690308138;
	Sat, 14 Sep 2024 02:29:11 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id 6CEF61060578; Sat, 14 Sep 2024 11:29:04 +0200 (CEST)
Date: Sat, 14 Sep 2024 11:29:04 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 2/9] power: supply: core: register thermal zone
 for battery
Message-ID: <ibihc343f3fcuk5c6gtz7kwhtf6e7pbtwkbx4wxu2wbmk4amfy@qorjk4mrbq44>
References: <20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net>
 <20240904-power-supply-extensions-v3-2-62efeb93f8ec@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vgpytpclbzgnsuok"
Content-Disposition: inline
In-Reply-To: <20240904-power-supply-extensions-v3-2-62efeb93f8ec@weissschuh.net>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/223.982.64
X-ZohoMailClient: External


--vgpytpclbzgnsuok
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 04, 2024 at 09:25:35PM GMT, Thomas Wei=DFschuh wrote:
> power_supply_read_team() can also read the temperature from the battery.
power_supply_read_temp()

> But currently when registering the thermal zone, the battery is
> not checked for POWER_SUPPLY_PROP_TEMP. Introduce a helper which
> can check both the desc and the battery info for property
> existence and use that. Export the helper to the rest of the psy
> core because it will also be used by different subcomponents.
>=20
> Signed-off-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> ---

power_supply_battery_info contains constant battery information like
design capacity or maximum voltage, which is e.g. supplied by the
firmware and needed by fuel-gauges or chargers. The temperature is
not constant and cannot be part of power_supply_battery_info, so
this does not really make sense.

Greetings,

-- Sebastian

>  drivers/power/supply/power_supply.h      |  3 +++
>  drivers/power/supply/power_supply_core.c | 14 +++++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/p=
ower_supply.h
> index 3cbafc58bdad..b01faeaf7827 100644
> --- a/drivers/power/supply/power_supply.h
> +++ b/drivers/power/supply/power_supply.h
> @@ -13,6 +13,9 @@ struct device;
>  struct device_type;
>  struct power_supply;
> =20
> +extern bool power_supply_has_property(struct power_supply *psy,
> +				      enum power_supply_property psp);
> +
>  #ifdef CONFIG_SYSFS
> =20
>  extern void power_supply_init_attrs(void);
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index cff68c4fd63c..dcb7e4853030 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1199,6 +1199,18 @@ static bool psy_desc_has_property(const struct pow=
er_supply_desc *psy_desc,
>  	return found;
>  }
> =20
> +bool power_supply_has_property(struct power_supply *psy,
> +			       enum power_supply_property psp)
> +{
> +	if (psy_desc_has_property(psy->desc, psp))
> +		return true;
> +
> +	if (power_supply_battery_info_has_prop(psy->battery_info, psp))
> +		return true;
> +
> +	return false;
> +}
> +
>  int power_supply_get_property(struct power_supply *psy,
>  			    enum power_supply_property psp,
>  			    union power_supply_propval *val)
> @@ -1308,7 +1320,7 @@ static int psy_register_thermal(struct power_supply=
 *psy)
>  		return 0;
> =20
>  	/* Register battery zone device psy reports temperature */
> -	if (psy_desc_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
> +	if (power_supply_has_property(psy, POWER_SUPPLY_PROP_TEMP)) {
>  		/* Prefer our hwmon device and avoid duplicates */
>  		struct thermal_zone_params tzp =3D {
>  			.no_hwmon =3D IS_ENABLED(CONFIG_POWER_SUPPLY_HWMON)
>=20
> --=20
> 2.46.0
>=20
>=20

--vgpytpclbzgnsuok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmblV1wACgkQ2O7X88g7
+pqLWA//YFHKUjkKD/GNYWYMXbdZCiYq0b4lkAb6CBakP9lBONDf5fFTPf1XeDUy
O2ReyqELFWGuj8glTD8zbHw0tdnC1QPFVbVBqjg9jkRzfrua63O9gO3MfyMtM70t
OPTUvbIzsV3cev3WFpr6R+TWv+WPf2Jmz2ox4r8urfKK3SyRzyjEpJdD8/xn1MVQ
OS4eu8cLB5QyISy09OmtCnmCR/gNhcRhZX4vbnaMg6Xbh2CsGzWU/KUJCHeLivwH
gv8X3pu3EhcrTAdzNEmckQpielAc/UQ+PZ3MP8afngfVWZP9zWXARw5X8gxLp9D9
8Dnm/L/euDfzKM/Ku8XOK+odXMYmL1aon0/wljeKDMNNChxBsIGJdwXfWh7GM+0r
o5zDJ50n22D+P5HilaEPcQ4pfacvX/axlpd1uAHqHwYGNi+SWUMkYrCxStT25X8t
KhBvCmuU1BSTZNdJdEQzZaTJt3i6aN8qWFargGgyKAsytQt0lopi7+Uyaly7Nd9+
lHGqjchYj3UGHws83CDXuBRTRMGY0k0BxRK2VQ+BK982LeF31Om4yk1qvoSRw3u8
cWQV7d1tw4oQUGGOiPSmZck6UFQJXHYdkzj5ZmY9MxHZljnETKpBWWFwLVRpES8o
C91AJ4t8gUxUWAdQdCeQv/NhAi0Zz35ZVYWNwbnpzBJ+caC8Vdw=
=T04E
-----END PGP SIGNATURE-----

--vgpytpclbzgnsuok--

