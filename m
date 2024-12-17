Return-Path: <linux-pm+bounces-19368-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 039ED9F4A84
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 13:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C0818821C6
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 12:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108391F2390;
	Tue, 17 Dec 2024 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SahyhTJt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BF01F0E58;
	Tue, 17 Dec 2024 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436880; cv=none; b=go5fN3PnYDh1SY1LZDIZFs/eTQD3CHuO2kkcPL2zUOsWB/tSXiCNpN950vC7ZZtaNQ9MQts59IQE0ZW0xtbmp1iE8UBU/u5qtIS53Au5NDczMxXd4WPuZTg1U4h2xtRwtR3yO+QksTy1hsPtRZmrjLr1MOaHp55J3AQ7ZDYOThs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436880; c=relaxed/simple;
	bh=yUbVHTWZqzWUQABKX1Ix220kd8piUApPFnaUXK0lQpk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AElXhI0vrs4dQY+nuuHqedBMndwq4XIYeDM+fg4LpxcBwMWM2y9xe7vkErpZ3d/JwmLrtDboe+g+/hf/lUaH81nns9F73OWrf+BihAmTG3tBiSkow2vT18Q/A3ZGgh3JOFUOkolXW6/5knvTbGdkcWMIbtXIlAqJMTfCeatARjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SahyhTJt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734436878; x=1765972878;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yUbVHTWZqzWUQABKX1Ix220kd8piUApPFnaUXK0lQpk=;
  b=SahyhTJtGHzdf0ntD4exjKYw+8HN/f3O5gOGHwdBN0EsxqsUO5IFJthR
   1zTWZNlHedHxEaGDnVe/pAzvWU+y7sbGS+/l2rjWuSqxc6nsMx5CaCRFK
   JDPHIhsNuMgxUxA8K9rktd04d4neMfLdn5hc7emfLHusE3WLwuU5AY37Q
   MZuoeaYN7awYXmZRTinZHIsdXzqhEBluNVAh/OuFMR/gK02mqh92YziUM
   sNltXiuDtYp7zRcnk/IWA8C/61d9Zpf6O5FBLYh62PpO0+9/SD4IkFPI2
   NSlo1inf1sMqM3G+ZP5nLRKSOUPHPzfPGtS98IsmFAy4Y2F8Vsbf71G9u
   w==;
X-CSE-ConnectionGUID: 6/Ors6aaRSa5PJPti3PyGw==
X-CSE-MsgGUID: 3OkE+q05TbeH8ICFiXNl3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="38532440"
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="38532440"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 04:01:15 -0800
X-CSE-ConnectionGUID: 9LByXQRdTCKHc+42fziDyQ==
X-CSE-MsgGUID: HctWX2sxRDib7wjrMNWioA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="97299009"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.192])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 04:01:12 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Dec 2024 14:01:08 +0200 (EET)
To: Hans de Goede <hdegoede@redhat.com>
cc: Andy Shevchenko <andy@kernel.org>, 
    =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>, 
    Sebastian Reichel <sre@kernel.org>, Jelle van der Waa <jelle@vdwaa.nl>, 
    platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/4] platform/x86: dell-laptop: Use
 power_supply_charge_types_show/_parse() helpers
In-Reply-To: <20241211174451.355421-5-hdegoede@redhat.com>
Message-ID: <0030c3dd-c70c-d21b-de2b-ace0aeb4030d@linux.intel.com>
References: <20241211174451.355421-1-hdegoede@redhat.com> <20241211174451.355421-5-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1618237218-1734436868=:924"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1618237218-1734436868=:924
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 11 Dec 2024, Hans de Goede wrote:

> Make battery_modes a map between tokens and enum power_supply_charge_type
> values instead of between tokens and strings and use the new
> power_supply_charge_types_show/_parse() helpers for show()/store()
> to ensure that things are handled in the same way as in other drivers.
>=20
> This also changes battery_supported_modes to be a bitmap of charge-types
> (enum power_supply_charge_type values) rather then a bitmap of indices
> into battery_modes[].
>=20
> Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/dell/dell-laptop.c | 54 ++++++++++++-------------
>  1 file changed, 25 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x=
86/dell/dell-laptop.c
> index 5671bd0deee7..9a4cfcb8bbe0 100644
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
> +=09=09return -EIO;

Hi Hans,

Is this errno change helpful/correct? There is zero I/O done before=20
reaching this point, just input validation, so why does it return errno=20
that is "I/O error"? If you want to differentiate from -EINVAL, I suggest=
=20
using -ENOENT (but I personally think -EINVAL would be fine as well=20
because it's still an invalid argument even if it passed one stage of=20
the input checks).

--=20
 i.


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
--8323328-1618237218-1734436868=:924--

