Return-Path: <linux-pm+bounces-25260-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1973A8615C
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 17:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F5E8C7435
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA43204F85;
	Fri, 11 Apr 2025 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgEpP+7S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37291F461D;
	Fri, 11 Apr 2025 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384118; cv=none; b=peombJ4Jl8rtWySXyDikEIvxF24rq5V6Had0cMawHlwPqVgboXTLHcYVRsFv2dYPBCF7nfLyeEIygccc1JLGYtVltxXIJUsToDI09r/wpbELmDIHMblDa6AOZSylm/sHnCxzwpVxj86UcvrXHIRQhYQZLEF3P9v+4NykIN54Zbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384118; c=relaxed/simple;
	bh=CS2vj079bxMVRX3OGfBp7wofiaKCNAiISXD6ndR3MJU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VCi+PAUrNbQAsUZfer6HECxkRa5/+Cf98+c7Fm62Riaez3IuVowsO8T8gqltknLhGkHTHX06mV+3t46/OD9Nllba2a7LHiF5uevpL/Ftx+GasbLbbfPoOhQb+0n+Ms2712VmUVFSpgVTgymKWTUTeH3v2aH9EIr49rsLlSl2CIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgEpP+7S; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744384116; x=1775920116;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CS2vj079bxMVRX3OGfBp7wofiaKCNAiISXD6ndR3MJU=;
  b=fgEpP+7SAiAY8eALCgREuSi5yyDqUH2gVQnQBaASu+WWnfkMT1U3+cEU
   Ggq8BW1mFlOel3LKOcHQSeSMqKDfLpLJYnDFQ9X84s3HPGyq14DDJWiMD
   I0cAOboZNpw6psY5Fk/2OArbzOc5T1nrrGMN334z0kUlkhpDM6yKs9c1U
   Ke5Hu+iuldxlWf3yDk9YVTrMgqFi6Wa2b1haV3r1hzfTjcp4m8FoGoByA
   Azgr2Stz9mwY0H7cvMIOUuCsx89xUKCZFBGGrSCxSY74SYgOef7B3L1Ft
   kHQWQugcxDpPYrDAydjVYIty7/PVZRiGMPdUgpsgl6ZAA/jBdH9mlp8L2
   w==;
X-CSE-ConnectionGUID: HLVApWOGQzqIGldpLlAmgQ==
X-CSE-MsgGUID: 6JXc6y/FQKqIP2UtOhoGJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="46068032"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="46068032"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:08:35 -0700
X-CSE-ConnectionGUID: IoU/9sRpS5eduHDL3ik6VQ==
X-CSE-MsgGUID: e5fOgRmdTLySUqiLJJvfRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="129197541"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.51])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:08:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 11 Apr 2025 18:08:25 +0300 (EEST)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
    linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
    Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, 
    Jonathan Corbet <corbet@lwn.net>, 
    Joaquin Ignacio Aramendia <samsagax@gmail.com>, 
    Derek J Clark <derekjohn.clark@gmail.com>, 
    Kevin Greenberg <kdgreenberg234@protonmail.com>, 
    Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>, 
    Eileen <eileen@one-netbook.com>, LKML <linux-kernel@vger.kernel.org>, 
    sre@kernel.org, linux@weissschuh.net, Hans de Goede <hdegoede@redhat.com>, 
    mario.limonciello@amd.com
Subject: Re: [PATCH v8 14/14] platform/x86: oxpec: Add charge threshold and
 behaviour to OneXPlayer
In-Reply-To: <20250322103606.680401-15-lkml@antheas.dev>
Message-ID: <7cb256ca-abb8-784a-7175-bff7d9510715@linux.intel.com>
References: <20250322103606.680401-1-lkml@antheas.dev> <20250322103606.680401-15-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-468852486-1744384105=:944"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-468852486-1744384105=:944
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 22 Mar 2025, Antheas Kapenekakis wrote:

> With the X1 (AMD), OneXPlayer added a charge limit and charge inhibit
> feature to their devices. Charge limit allows for choosing an arbitrary
> battery charge setpoint in percentages. Charge ihibit allows to instruct
> the device to stop charging either when it is awake or always.
>=20
> This feature was then extended for the F1Pro as well. OneXPlayer also
> released BIOS updates for the X1 Mini, X1 (Intel), and F1 devices that
> add support for this feature. Therefore, enable it for all F1 and
> X1 devices.
>=20
> Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/Kconfig |   1 +
>  drivers/platform/x86/oxpec.c | 160 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 157 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 82cfc76bc5c9f..f4d993658c01f 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1189,6 +1189,7 @@ config SEL3350_PLATFORM
>  config OXP_EC
>  =09tristate "OneXPlayer EC platform control"
>  =09depends on ACPI_EC
> +=09depends on ACPI_BATTERY
>  =09depends on HWMON
>  =09depends on X86
>  =09help
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index 0a5b33a842b24..e6ea702006ec5 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -24,6 +24,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/processor.h>
> +#include <acpi/battery.h>
> =20
>  /* Handle ACPI lock mechanism */
>  static u32 oxp_mutex;
> @@ -60,6 +61,7 @@ enum oxp_board {
>  };
> =20
>  static enum oxp_board board;
> +static struct device *oxp_dev;
> =20
>  /* Fan reading and PWM */
>  #define OXP_SENSOR_FAN_REG             0x76 /* Fan reading is 2 register=
s long */
> @@ -93,6 +95,23 @@ static enum oxp_board board;
>  #define OXP_X1_TURBO_LED_OFF           0x01
>  #define OXP_X1_TURBO_LED_ON            0x02
> =20
> +/* Battery extension settings */
> +#define EC_CHARGE_CONTROL_BEHAVIOURS=09(BIT(POWER_SUPPLY_CHARGE_BEHAVIOU=
R_AUTO)             | \
> +=09=09=09=09=09 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)    | \
> +=09=09=09=09=09 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE))
> +
> +#define OXP_X1_CHARGE_LIMIT_REG      0xA3 /* X1 charge limit (%) */
> +#define OXP_X1_CHARGE_INHIBIT_REG     0xA4 /* X1 bypass charging */
> +
> +#define OXP_X1_CHARGE_INHIBIT_MASK_AWAKE 0x01
> +/*
> + * X1 Mask is 0x0A, OneXFly F1Pro is just 0x02
> + * but the extra bit on the X1 does nothing.
> + */
> +#define OXP_X1_CHARGE_INHIBIT_MASK_OFF 0x02
> +#define OXP_X1_CHARGE_INHIBIT_MASK_ALWAYS (OXP_X1_CHARGE_INHIBIT_MASK_AW=
AKE | \
> +=09OXP_X1_CHARGE_INHIBIT_MASK_OFF)
> +
>  static const struct dmi_system_id dmi_table[] =3D {
>  =09{
>  =09=09.matches =3D {
> @@ -507,6 +526,129 @@ static ssize_t tt_led_show(struct device *dev,
> =20
>  static DEVICE_ATTR_RW(tt_led);
> =20
> +/* Callbacks for charge behaviour attributes */
> +static bool oxp_psy_ext_supported(void)
> +{
> +=09switch (board) {
> +=09case oxp_x1:
> +=09case oxp_fly:
> +=09=09return true;
> +=09default:
> +=09=09break;
> +=09}
> +=09return false;
> +}
> +
> +static int oxp_psy_ext_get_prop(struct power_supply *psy,
> +=09=09=09=09       const struct power_supply_ext *ext,
> +=09=09=09=09       void *data,
> +=09=09=09=09       enum power_supply_property psp,
> +=09=09=09=09       union power_supply_propval *val)
> +{
> +=09long raw_val;
> +=09int ret;
> +
> +=09switch (psp) {
> +=09case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
> +=09=09ret =3D read_from_ec(OXP_X1_CHARGE_LIMIT_REG, 1, &raw_val);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09=09if (raw_val >=3D 0 && raw_val > 100)

Is one of the signs wrong way around??

> +=09=09=09return -EINVAL;
> +=09=09val->intval =3D raw_val;
> +=09=09return 0;
> +=09case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> +=09=09ret =3D read_from_ec(OXP_X1_CHARGE_INHIBIT_REG, 1, &raw_val);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09=09if ((raw_val & OXP_X1_CHARGE_INHIBIT_MASK_ALWAYS) =3D=3D
> +=09=09    OXP_X1_CHARGE_INHIBIT_MASK_ALWAYS)
> +=09=09=09val->intval =3D POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
> +=09=09else if ((raw_val & OXP_X1_CHARGE_INHIBIT_MASK_AWAKE) =3D=3D
> +=09=09=09 OXP_X1_CHARGE_INHIBIT_MASK_AWAKE)
> +=09=09=09val->intval =3D POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AW=
AKE;
> +=09=09else
> +=09=09=09val->intval =3D POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> +=09=09return 0;
> +=09default:
> +=09=09return -EINVAL;
> +=09}
> +}
> +
> +static int oxp_psy_ext_set_prop(struct power_supply *psy,
> +=09=09=09=09       const struct power_supply_ext *ext,
> +=09=09=09=09       void *data,
> +=09=09=09=09       enum power_supply_property psp,
> +=09=09=09=09       const union power_supply_propval *val)
> +{
> +=09long raw_val;
> +
> +=09switch (psp) {
> +=09case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
> +=09=09if (val->intval > 100)
> +=09=09=09return -EINVAL;
> +=09=09return write_to_ec(OXP_X1_CHARGE_LIMIT_REG, val->intval);
> +=09case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> +=09=09switch (val->intval) {
> +=09=09case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
> +=09=09=09raw_val =3D 0;
> +=09=09=09break;
> +=09=09case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE:
> +=09=09=09raw_val =3D OXP_X1_CHARGE_INHIBIT_MASK_AWAKE;
> +=09=09=09break;
> +=09=09case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
> +=09=09=09raw_val =3D OXP_X1_CHARGE_INHIBIT_MASK_ALWAYS;
> +=09=09=09break;
> +=09=09default:
> +=09=09=09return -EINVAL;
> +=09=09}
> +
> +=09=09return write_to_ec(OXP_X1_CHARGE_INHIBIT_REG, raw_val);
> +=09default:
> +=09=09return -EINVAL;
> +=09}
> +}
> +
> +static int oxp_psy_prop_is_writeable(struct power_supply *psy,
> +=09=09=09=09=09    const struct power_supply_ext *ext,
> +=09=09=09=09=09    void *data,
> +=09=09=09=09=09    enum power_supply_property psp)
> +{
> +=09return true;
> +}
> +
> +static const enum power_supply_property oxp_psy_ext_props[] =3D {
> +=09POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
> +=09POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
> +};
> +
> +static const struct power_supply_ext oxp_psy_ext =3D {
> +=09.name=09=09=09=3D "oxp-charge-control",
> +=09.properties=09=09=3D oxp_psy_ext_props,
> +=09.num_properties=09=09=3D ARRAY_SIZE(oxp_psy_ext_props),
> +=09.charge_behaviours=09=3D EC_CHARGE_CONTROL_BEHAVIOURS,
> +=09.get_property=09=09=3D oxp_psy_ext_get_prop,
> +=09.set_property=09=09=3D oxp_psy_ext_set_prop,
> +=09.property_is_writeable=09=3D oxp_psy_prop_is_writeable,
> +};
> +
> +static int oxp_add_battery(struct power_supply *battery, struct acpi_bat=
tery_hook *hook)
> +{
> +=09return power_supply_register_extension(battery, &oxp_psy_ext, oxp_dev=
, NULL);
> +}
> +
> +static int oxp_remove_battery(struct power_supply *battery, struct acpi_=
battery_hook *hook)
> +{
> +=09power_supply_unregister_extension(battery, &oxp_psy_ext);
> +=09return 0;
> +}
> +
> +static struct acpi_battery_hook battery_hook =3D {
> +=09.add_battery=09=3D oxp_add_battery,
> +=09.remove_battery=09=3D oxp_remove_battery,
> +=09.name=09=09=3D "OneXPlayer Battery",
> +};
> +
>  /* PWM enable/disable functions */
>  static int oxp_pwm_enable(void)
>  {
> @@ -845,12 +987,22 @@ static const struct hwmon_chip_info oxp_ec_chip_inf=
o =3D {
>  static int oxp_platform_probe(struct platform_device *pdev)
>  {
>  =09struct device *dev =3D &pdev->dev;
> -=09struct device *hwdev;
> +=09int ret;
> +
> +=09oxp_dev =3D dev;
> +=09ret =3D PTR_ERR_OR_ZERO(devm_hwmon_device_register_with_info(
> +=09=09dev, "oxp_ec", NULL, &oxp_ec_chip_info, NULL));
> =20
> -=09hwdev =3D devm_hwmon_device_register_with_info(dev, "oxp_ec", NULL,
> -=09=09=09=09=09=09     &oxp_ec_chip_info, NULL);
> +=09if (ret)

Using PTR_ERR_OR_ZERO() isn't IMO good change as it's meant for returning=
=20
0. Just preserve hwdev as it was and use IS_ERR(hwdev) here.

> +=09=09return ret;
> =20
> -=09return PTR_ERR_OR_ZERO(hwdev);
> +=09if (oxp_psy_ext_supported()) {
> +=09=09ret =3D devm_battery_hook_register(dev, &battery_hook);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09}
> +
> +=09return 0;
>  }
> =20
>  static struct platform_driver oxp_platform_driver =3D {
>=20

--=20
 i.

--8323328-468852486-1744384105=:944--

