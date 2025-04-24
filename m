Return-Path: <linux-pm+bounces-26123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8861EA9AFAD
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 15:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2131B60FA7
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 13:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61D61B3956;
	Thu, 24 Apr 2025 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RFVgqhHQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6301B3929;
	Thu, 24 Apr 2025 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745502534; cv=none; b=t7L+mWZGRmzwR8emGUP4T/+2xmIi+mh39iSfl/3ZTFjAym19yryt6rR4LvPZl/12xd7E8Fx3kJCCFFgmXTWE+XKCYh0CZmD/uND0QJ7yjjBGFbCD1/emtQSiOKIkelKFvLlxCKcQovC50lj0hre9v2nD1mI2Fg/GiPLJK1gJWSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745502534; c=relaxed/simple;
	bh=4FlVdAMHwr32o+T5a8iielNhGK5S+TqpCQF4fydWrKQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tFMq6K7aZq5VcGaQFPk0oFctamz8ptjcpfrgrL6FfeKWTYXVDzgsdCtNOP8DQB6dCHjRoO8JpkjOZnwbLUkJXA/uqnO/UyXKyuDGOfNOx9wsrrnpcBMF6Vqe0rtTlV/L1I4E37ievuk31uCaGHyUZspDmpUCyt9R++OQkiSucVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RFVgqhHQ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745502532; x=1777038532;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4FlVdAMHwr32o+T5a8iielNhGK5S+TqpCQF4fydWrKQ=;
  b=RFVgqhHQ257wdwjqlVeClQXfMxx0jNoYoAa9VrEcS7LzTWNW4l53gbIt
   AirtyiEsUiTJmU683MmKTaIgZYRcwxN2U6sjUqrc8u5KoEXm81hPtPN9C
   att8kslf+3ZXuQedzAwt3I0UMYDeFDu5ijlfSJ/GImdwClxgwQkehb175
   1iEStKekra/bnyXp94qfWzw0PMh09XueGRqeakv79ClOJSScwkg3vCl9l
   Xqjhuurl01km4vcjCy9X56Fb/eT+dFbh5Q6AxIdqqbTQhu7eVrn56WW/2
   1ElffPdEBjiRlo+ZQ0TLaTGVMOtmaiw1FcFU14CWgS9v1MFhYrVU7XEqf
   A==;
X-CSE-ConnectionGUID: f7tYdETbQWS021SBEbu3VQ==
X-CSE-MsgGUID: kii36djRQ1W74LTEi6oxmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47271631"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47271631"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 06:48:51 -0700
X-CSE-ConnectionGUID: cwSN99nbSq+pREGEli4Q0Q==
X-CSE-MsgGUID: g9/ijGsFSJKcDzs2j/F8JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="155849228"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 06:48:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 24 Apr 2025 16:48:41 +0300 (EEST)
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
Subject: Re: [PATCH v9 14/15] platform/x86: oxpec: Add charge threshold and
 behaviour to OneXPlayer
In-Reply-To: <20250417175310.3552671-15-lkml@antheas.dev>
Message-ID: <5423a653-01ac-95d2-fa52-31d849df65ef@linux.intel.com>
References: <20250417175310.3552671-1-lkml@antheas.dev> <20250417175310.3552671-15-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-327762574-1745502521=:944"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-327762574-1745502521=:944
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 17 Apr 2025, Antheas Kapenekakis wrote:

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
>  drivers/platform/x86/oxpec.c | 155 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 155 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 739740c4bb535..6c9e64a03aaef 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1204,6 +1204,7 @@ config SEL3350_PLATFORM
>  config OXP_EC
>  =09tristate "OneXPlayer EC platform control"
>  =09depends on ACPI_EC
> +=09depends on ACPI_BATTERY
>  =09depends on HWMON
>  =09depends on X86
>  =09help
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index f0b9fff704de2..ce20bf70027df 100644
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

Please change the endings to:

=2E..) | <tabs>\

> +=09=09=09=09=09 BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE))
> +
> +#define OXP_X1_CHARGE_LIMIT_REG      0xA3 /* X1 charge limit (%) */
> +#define OXP_X1_CHARGE_INHIBIT_REG     0xA4 /* X1 bypass charging */

Please use tabs for aligning the values (there were a few other defines=20
in the earlier patches with spaces too). (I know the earlier ones used=20
space but they don't seem to be in the same group so lets just move to=20
tabs with new stuff, optionally, you can add a patch to change also the=20
pre-existing ones to use space).

> +
> +#define OXP_X1_CHARGE_INHIBIT_MASK_AWAKE 0x01
> +/*
> + * X1 Mask is 0x0A, OneXFly F1Pro is just 0x02
> + * but the extra bit on the X1 does nothing.

Reflow to fill 80 chars.

> + */
> +#define OXP_X1_CHARGE_INHIBIT_MASK_OFF 0x02
> +#define OXP_X1_CHARGE_INHIBIT_MASK_ALWAYS (OXP_X1_CHARGE_INHIBIT_MASK_AW=
AKE | \
> +=09OXP_X1_CHARGE_INHIBIT_MASK_OFF)

Align to (.

--=20
 i.

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
> +=09=09if (raw_val < 0 || raw_val > 100)
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
> @@ -847,11 +989,22 @@ static int oxp_platform_probe(struct platform_devic=
e *pdev)
>  {
>  =09struct device *dev =3D &pdev->dev;
>  =09struct device *hwdev;
> +=09int ret;
> =20
> +=09oxp_dev =3D dev;
>  =09hwdev =3D devm_hwmon_device_register_with_info(dev, "oxp_ec", NULL,
>  =09=09=09=09=09=09     &oxp_ec_chip_info, NULL);
> =20
> -=09return PTR_ERR_OR_ZERO(hwdev);
> +=09if (IS_ERR(hwdev))
> +=09=09return PTR_ERR(hwdev);
> +
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
--8323328-327762574-1745502521=:944--

