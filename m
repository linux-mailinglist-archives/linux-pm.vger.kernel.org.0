Return-Path: <linux-pm+bounces-19718-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D799FB4A3
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 20:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0474A7A2300
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 19:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E311C5F25;
	Mon, 23 Dec 2024 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hh4lObX0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EF1161328;
	Mon, 23 Dec 2024 19:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734981555; cv=none; b=HG/8qefRi2F/JHVD6RrvEFW02HNG4VwTrSF1nJSL1VZZE8ad4fFZQt636ZczFLGf/yCl1IKLxhDLzVXBZI+CcGDazqEW7piSOmeOgVKfneJJY7zmtYaQge2Jo4/XFFODj8vj2oY/+z44CwP9m+OHBB/e7vf37zNic8X4Wk2nJyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734981555; c=relaxed/simple;
	bh=3RpuQldBS7hpE/P6A1CmeISsbkkKHapgpOTrXxhCmQs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gNEK+GNG//9ijCDxSJxvz5fViMCeSDaVbicADJvzgukVPPOXXt4VFw/vUwNABUE9d4rwa+OhfNCkoR1a35odIQ6/juZ7G5re4aWuMWVqOcW68UizuvJ+6KLe6c4h6KKnnTyuVyc6zIxBPiwNjH/vWiO+z3MXgeo4/m9+UU7apNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hh4lObX0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734981553; x=1766517553;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=3RpuQldBS7hpE/P6A1CmeISsbkkKHapgpOTrXxhCmQs=;
  b=Hh4lObX08cBR3oPKD7tDrgm1GcSatRpplfJ7tTHD+vhzhTuXD80zQA3y
   pBMFx6+Zgm5P0srqgX79Ey1oECesve7kB+oqA9GDiQbGAcyFHABmcITZU
   y4uPBmig/fO3NjV0DrcGNLooyEarzqKafmDaYi3hSFdZ91LB85h3H+YkE
   hHa9B6OSirQlZX59EydAxrfgwLCfrzcJ9824QnGzQak6JAmtQtB5qs2mN
   hGQ/qj5I5HURI+6vPXpIhanMPYkIBnVU3lkMLIugUg/yOIZijVpBSkMiz
   PlZ0gzeA1H99LOOm8UzcngtelnJ61bZVYzOyk1O3K4ENyfRJWsvwltJN7
   g==;
X-CSE-ConnectionGUID: QUFDT+EVTjSBVFo/2+o+Rg==
X-CSE-MsgGUID: Pv85NPrpRRKCad6hODsDmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="39395086"
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="39395086"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 11:19:12 -0800
X-CSE-ConnectionGUID: u/SXRiJiSimgaaAyMPqToA==
X-CSE-MsgGUID: X9/0CC+kSG6dBMhGMDVaiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136596946"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.68])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 11:19:10 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 23 Dec 2024 21:19:07 +0200 (EET)
To: Hans de Goede <hdegoede@redhat.com>, Sebastian Reichel <sre@kernel.org>
cc: Andy Shevchenko <andy@kernel.org>, 
    =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>, 
    platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/1] platform/x86: dell-laptop: Use
 power_supply_charge_types_show/_parse() helpers
In-Reply-To: <20241221125140.345776-2-hdegoede@redhat.com>
Message-ID: <c30837b6-496c-e3c5-81a6-61e6e8db7875@linux.intel.com>
References: <20241221125140.345776-1-hdegoede@redhat.com> <20241221125140.345776-2-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-976463236-1734981524=:937"
Content-ID: <0dca0e8c-5d0d-4f65-4405-aeb0e874328e@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-976463236-1734981524=:937
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <d51877b1-90ec-378c-7003-2559a49b5eb1@linux.intel.com>

On Sat, 21 Dec 2024, Hans de Goede wrote:

> Make battery_modes a map between tokens and enum power_supply_charge_type
> values instead of between tokens and strings and use the new
> power_supply_charge_types_show/_parse() helpers for show()/store()
> to ensure that things are handled in the same way as in other drivers.
>=20
> This also changes battery_supported_modes to be a bitmap of charge-types
> (enum power_supply_charge_type values) rather then a bitmap of indices
> into battery_modes[].
>=20
> Reviewed-by: Thomas Wei=DFschuh <linux@weissschuh.net>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
> Changes in v5:
> - Return ENOENT instead of EIO in charge_types_store() when the requested
>   mode was accepted by power_supply_charge_types_parse() but for some
>   reason is not found in the battery_modes[] array
> ---
>  drivers/platform/x86/dell/dell-laptop.c | 54 ++++++++++++-------------
>  1 file changed, 25 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x=
86/dell/dell-laptop.c
> index 5671bd0deee7..e6da468daf83 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -103,15 +103,15 @@ static bool mute_led_registered;
> =20
>  struct battery_mode_info {
>  =09int token;
> -=09const char *label;
> +=09enum power_supply_charge_type charge_type;
>  };
> =20
>  static const struct battery_mode_info battery_modes[] =3D {
> -=09{ BAT_PRI_AC_MODE_TOKEN,   "Trickle" },
> -=09{ BAT_EXPRESS_MODE_TOKEN,  "Fast" },
> -=09{ BAT_STANDARD_MODE_TOKEN, "Standard" },
> -=09{ BAT_ADAPTIVE_MODE_TOKEN, "Adaptive" },
> -=09{ BAT_CUSTOM_MODE_TOKEN,   "Custom" },
> +=09{ BAT_PRI_AC_MODE_TOKEN,   POWER_SUPPLY_CHARGE_TYPE_TRICKLE },
> +=09{ BAT_EXPRESS_MODE_TOKEN,  POWER_SUPPLY_CHARGE_TYPE_FAST },
> +=09{ BAT_STANDARD_MODE_TOKEN, POWER_SUPPLY_CHARGE_TYPE_STANDARD },
> +=09{ BAT_ADAPTIVE_MODE_TOKEN, POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE },
> +=09{ BAT_CUSTOM_MODE_TOKEN,   POWER_SUPPLY_CHARGE_TYPE_CUSTOM },
>  };
>  static u32 battery_supported_modes;
> =20
> @@ -2261,46 +2261,42 @@ static ssize_t charge_types_show(struct device *d=
ev,
>  =09=09struct device_attribute *attr,
>  =09=09char *buf)
>  {
> -=09ssize_t count =3D 0;
> +=09enum power_supply_charge_type charge_type;
>  =09int i;
> =20
>  =09for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
> -=09=09bool active;
> +=09=09charge_type =3D battery_modes[i].charge_type;
> =20
> -=09=09if (!(battery_supported_modes & BIT(i)))
> +=09=09if (!(battery_supported_modes & BIT(charge_type)))
>  =09=09=09continue;
> =20
> -=09=09active =3D dell_battery_mode_is_active(battery_modes[i].token);
> -=09=09count +=3D sysfs_emit_at(buf, count, active ? "[%s] " : "%s ",
> -=09=09=09=09battery_modes[i].label);
> +=09=09if (!dell_battery_mode_is_active(battery_modes[i].token))
> +=09=09=09continue;
> +
> +=09=09return power_supply_charge_types_show(dev, battery_supported_modes=
,
> +=09=09=09=09=09=09      charge_type, buf);
>  =09}
> =20
> -=09/* convert the last space to a newline */
> -=09if (count > 0)
> -=09=09count--;
> -=09count +=3D sysfs_emit_at(buf, count, "\n");
> -
> -=09return count;
> +=09/* No active mode found */
> +=09return -EIO;
>  }
> =20
>  static ssize_t charge_types_store(struct device *dev,
>  =09=09struct device_attribute *attr,
>  =09=09const char *buf, size_t size)
>  {
> -=09bool matched =3D false;
> -=09int err, i;
> +=09int charge_type, err, i;
> +
> +=09charge_type =3D power_supply_charge_types_parse(battery_supported_mod=
es, buf);
> +=09if (charge_type < 0)
> +=09=09return charge_type;
> =20
>  =09for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
> -=09=09if (!(battery_supported_modes & BIT(i)))
> -=09=09=09continue;
> -
> -=09=09if (sysfs_streq(battery_modes[i].label, buf)) {
> -=09=09=09matched =3D true;
> +=09=09if (battery_modes[i].charge_type =3D=3D charge_type)
>  =09=09=09break;
> -=09=09}
>  =09}
> -=09if (!matched)
> -=09=09return -EINVAL;
> +=09if (i =3D=3D ARRAY_SIZE(battery_modes))
> +=09=09return -ENOENT;
> =20
>  =09err =3D dell_battery_set_mode(battery_modes[i].token);
>  =09if (err)
> @@ -2430,7 +2426,7 @@ static u32 __init battery_get_supported_modes(void)
> =20
>  =09for (i =3D 0; i < ARRAY_SIZE(battery_modes); i++) {
>  =09=09if (dell_smbios_find_token(battery_modes[i].token))
> -=09=09=09modes |=3D BIT(i);
> +=09=09=09modes |=3D BIT(battery_modes[i].charge_type);
>  =09}
> =20
>  =09return modes;
>=20
--8323328-976463236-1734981524=:937--

