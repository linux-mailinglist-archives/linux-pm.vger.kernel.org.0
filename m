Return-Path: <linux-pm+bounces-26191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F29A9C6AA
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 13:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D591BC11F5
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 11:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D35E23F28B;
	Fri, 25 Apr 2025 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXdu0Vhv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF3023373B;
	Fri, 25 Apr 2025 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579128; cv=none; b=rBvJ0V5hQ6Y2FHkUeB96V6czz7Kfs0EcIBpd2bB2EeW7crsBiYqHG6iWxktWkp4r5cl+Mqg3Sa0uZvJaZeqYOJM2EZ//LLcFbpXR7ljsyghyxLEIbPCvPogpxoTBSpAASgi3YjNz+198O0sv7zDuHClpWzL9DWtm+A8Y8xwgU0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579128; c=relaxed/simple;
	bh=YpqP70C3h3hK64vKubewZtLum1drWQcRIC0SIq5nfXQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Dv7TeAcjzKq4+RQtrm8AauDtUgjpJMSr1p4Ig8Vdu1Ux8Vu3TtHfyXe3CsI6R26uZEpLYROLAeLrpXDnuDLsnNJd/1Imx9MUTPJjyifzX9kAIyBGluZknSGYfWyobQATwxX7cxbmVMfY6tBXV8AmX5Jk6wrhYgq7D4S48cS2c1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RXdu0Vhv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745579126; x=1777115126;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YpqP70C3h3hK64vKubewZtLum1drWQcRIC0SIq5nfXQ=;
  b=RXdu0VhvUbK6qWugH8vxtexdLkcuhBS4FpB0cLL/ytg4BH7IV1+sgmHB
   R5mwhwp4PPXlokADlabP3yD7wG6r/cnrga7nmPom9KkijM4eNqzTVI6Hc
   RespTyP/yF0YUlxBvCp70tP0TtVX3HTfBChc6UcZSSpUHEWoD1ytcR2Hy
   xd1rq+NpC06zhbwENsZo9BZzcC/B7Dm86aFLKEZJebNEVxhGb/0KPLz02
   q4VZTAtnGWlSZXSPA2wYAUoCx7jfRHtNerpfFhy+tO3AjKAmlGKV0IY9W
   tjNNrklYDm3p4cGmcZ2L68OT9aIv4N60OaR+DtsMBmKP49SQA/+5/GyZk
   w==;
X-CSE-ConnectionGUID: To32BRnTQaeQknd8h7hujQ==
X-CSE-MsgGUID: 2xB24WUySzqPHrCDccREeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47122786"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="47122786"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 04:05:25 -0700
X-CSE-ConnectionGUID: fDL2LiscTfCwM1vqjg2lig==
X-CSE-MsgGUID: kcyAqKSJTZ+izEBgt72wCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="170098556"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.154])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 04:05:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 25 Apr 2025 14:05:14 +0300 (EEST)
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
In-Reply-To: <CAGwozwEmiUtFndi3KaGKN_8MocpJj1R21ENbnjEeyBco8P3KSg@mail.gmail.com>
Message-ID: <6193cf3a-f5a3-2e91-50d0-ef980cad334d@linux.intel.com>
References: <20250417175310.3552671-1-lkml@antheas.dev> <20250417175310.3552671-15-lkml@antheas.dev> <5423a653-01ac-95d2-fa52-31d849df65ef@linux.intel.com> <CAGwozwEmiUtFndi3KaGKN_8MocpJj1R21ENbnjEeyBco8P3KSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1201764611-1745579114=:950"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1201764611-1745579114=:950
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 24 Apr 2025, Antheas Kapenekakis wrote:

> On Thu, 24 Apr 2025 at 15:49, Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Thu, 17 Apr 2025, Antheas Kapenekakis wrote:
> >
> > > With the X1 (AMD), OneXPlayer added a charge limit and charge inhibit
> > > feature to their devices. Charge limit allows for choosing an arbitra=
ry
> > > battery charge setpoint in percentages. Charge ihibit allows to instr=
uct
> > > the device to stop charging either when it is awake or always.
> > >
> > > This feature was then extended for the F1Pro as well. OneXPlayer also
> > > released BIOS updates for the X1 Mini, X1 (Intel), and F1 devices tha=
t
> > > add support for this feature. Therefore, enable it for all F1 and
> > > X1 devices.
> > >
> > > Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > > Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> > > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > > ---
> > >  drivers/platform/x86/Kconfig |   1 +
> > >  drivers/platform/x86/oxpec.c | 155 +++++++++++++++++++++++++++++++++=
+-
> > >  2 files changed, 155 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kcon=
fig
> > > index 739740c4bb535..6c9e64a03aaef 100644
> > > --- a/drivers/platform/x86/Kconfig
> > > +++ b/drivers/platform/x86/Kconfig
> > > @@ -1204,6 +1204,7 @@ config SEL3350_PLATFORM
> > >  config OXP_EC
> > >       tristate "OneXPlayer EC platform control"
> > >       depends on ACPI_EC
> > > +     depends on ACPI_BATTERY
> > >       depends on HWMON
> > >       depends on X86
> > >       help
> > > diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpe=
c.c
> > > index f0b9fff704de2..ce20bf70027df 100644
> > > --- a/drivers/platform/x86/oxpec.c
> > > +++ b/drivers/platform/x86/oxpec.c
> > > @@ -24,6 +24,7 @@
> > >  #include <linux/module.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/processor.h>
> > > +#include <acpi/battery.h>
> > >
> > >  /* Handle ACPI lock mechanism */
> > >  static u32 oxp_mutex;
> > > @@ -60,6 +61,7 @@ enum oxp_board {
> > >  };
> > >
> > >  static enum oxp_board board;
> > > +static struct device *oxp_dev;
> > >
> > >  /* Fan reading and PWM */
> > >  #define OXP_SENSOR_FAN_REG             0x76 /* Fan reading is 2 regi=
sters long */
> > > @@ -93,6 +95,23 @@ static enum oxp_board board;
> > >  #define OXP_X1_TURBO_LED_OFF           0x01
> > >  #define OXP_X1_TURBO_LED_ON            0x02
> > >
> > > +/* Battery extension settings */
> > > +#define EC_CHARGE_CONTROL_BEHAVIOURS (BIT(POWER_SUPPLY_CHARGE_BEHAVI=
OUR_AUTO)             | \
> > > +                                      BIT(POWER_SUPPLY_CHARGE_BEHAVI=
OUR_INHIBIT_CHARGE)    | \
> >
> > Please change the endings to:
> >
> > ...) | <tabs>\
> >
> > > +                                      BIT(POWER_SUPPLY_CHARGE_BEHAVI=
OUR_INHIBIT_CHARGE_AWAKE))
> > > +
> > > +#define OXP_X1_CHARGE_LIMIT_REG      0xA3 /* X1 charge limit (%) */
> > > +#define OXP_X1_CHARGE_INHIBIT_REG     0xA4 /* X1 bypass charging */
> >
> > Please use tabs for aligning the values (there were a few other defines
> > in the earlier patches with spaces too). (I know the earlier ones used
> > space but they don't seem to be in the same group so lets just move to
> > tabs with new stuff, optionally, you can add a patch to change also the
> > pre-existing ones to use space).
> >
> > > +
> > > +#define OXP_X1_CHARGE_INHIBIT_MASK_AWAKE 0x01
> > > +/*
> > > + * X1 Mask is 0x0A, OneXFly F1Pro is just 0x02
> > > + * but the extra bit on the X1 does nothing.
> >
> > Reflow to fill 80 chars.
> >
> > > + */
> > > +#define OXP_X1_CHARGE_INHIBIT_MASK_OFF 0x02
> > > +#define OXP_X1_CHARGE_INHIBIT_MASK_ALWAYS (OXP_X1_CHARGE_INHIBIT_MAS=
K_AWAKE | \
> > > +     OXP_X1_CHARGE_INHIBIT_MASK_OFF)
> >
> > Align to (.
>=20
> I made the corrections.
>=20
> Should I send a revision now or wait?

Just send a new version please so I can apply these, I think people have=20
had enough time to comment on them. :-) (I was basically applying these=20
while I noticed those issues and some of them were a little awkward to=20
change/tweak while applying so I left the updating in your hands instead).

--=20
 i.

>=20
> Antheas
>=20
> > --
> >  i.
> >
> > > +
> > >  static const struct dmi_system_id dmi_table[] =3D {
> > >       {
> > >               .matches =3D {
> > > @@ -507,6 +526,129 @@ static ssize_t tt_led_show(struct device *dev,
> > >
> > >  static DEVICE_ATTR_RW(tt_led);
> > >
> > > +/* Callbacks for charge behaviour attributes */
> > > +static bool oxp_psy_ext_supported(void)
> > > +{
> > > +     switch (board) {
> > > +     case oxp_x1:
> > > +     case oxp_fly:
> > > +             return true;
> > > +     default:
> > > +             break;
> > > +     }
> > > +     return false;
> > > +}
> > > +
> > > +static int oxp_psy_ext_get_prop(struct power_supply *psy,
> > > +                                    const struct power_supply_ext *e=
xt,
> > > +                                    void *data,
> > > +                                    enum power_supply_property psp,
> > > +                                    union power_supply_propval *val)
> > > +{
> > > +     long raw_val;
> > > +     int ret;
> > > +
> > > +     switch (psp) {
> > > +     case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
> > > +             ret =3D read_from_ec(OXP_X1_CHARGE_LIMIT_REG, 1, &raw_v=
al);
> > > +             if (ret)
> > > +                     return ret;
> > > +             if (raw_val < 0 || raw_val > 100)
> > > +                     return -EINVAL;
> > > +             val->intval =3D raw_val;
> > > +             return 0;
> > > +     case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> > > +             ret =3D read_from_ec(OXP_X1_CHARGE_INHIBIT_REG, 1, &raw=
_val);
> > > +             if (ret)
> > > +                     return ret;
> > > +             if ((raw_val & OXP_X1_CHARGE_INHIBIT_MASK_ALWAYS) =3D=
=3D
> > > +                 OXP_X1_CHARGE_INHIBIT_MASK_ALWAYS)
> > > +                     val->intval =3D POWER_SUPPLY_CHARGE_BEHAVIOUR_I=
NHIBIT_CHARGE;
> > > +             else if ((raw_val & OXP_X1_CHARGE_INHIBIT_MASK_AWAKE) =
=3D=3D
> > > +                      OXP_X1_CHARGE_INHIBIT_MASK_AWAKE)
> > > +                     val->intval =3D POWER_SUPPLY_CHARGE_BEHAVIOUR_I=
NHIBIT_CHARGE_AWAKE;
> > > +             else
> > > +                     val->intval =3D POWER_SUPPLY_CHARGE_BEHAVIOUR_A=
UTO;
> > > +             return 0;
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +}
> > > +
> > > +static int oxp_psy_ext_set_prop(struct power_supply *psy,
> > > +                                    const struct power_supply_ext *e=
xt,
> > > +                                    void *data,
> > > +                                    enum power_supply_property psp,
> > > +                                    const union power_supply_propval=
 *val)
> > > +{
> > > +     long raw_val;
> > > +
> > > +     switch (psp) {
> > > +     case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
> > > +             if (val->intval > 100)
> > > +                     return -EINVAL;
> > > +             return write_to_ec(OXP_X1_CHARGE_LIMIT_REG, val->intval=
);
> > > +     case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> > > +             switch (val->intval) {
> > > +             case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
> > > +                     raw_val =3D 0;
> > > +                     break;
> > > +             case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE=
:
> > > +                     raw_val =3D OXP_X1_CHARGE_INHIBIT_MASK_AWAKE;
> > > +                     break;
> > > +             case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
> > > +                     raw_val =3D OXP_X1_CHARGE_INHIBIT_MASK_ALWAYS;
> > > +                     break;
> > > +             default:
> > > +                     return -EINVAL;
> > > +             }
> > > +
> > > +             return write_to_ec(OXP_X1_CHARGE_INHIBIT_REG, raw_val);
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +}
> > > +
> > > +static int oxp_psy_prop_is_writeable(struct power_supply *psy,
> > > +                                         const struct power_supply_e=
xt *ext,
> > > +                                         void *data,
> > > +                                         enum power_supply_property =
psp)
> > > +{
> > > +     return true;
> > > +}
> > > +
> > > +static const enum power_supply_property oxp_psy_ext_props[] =3D {
> > > +     POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
> > > +     POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
> > > +};
> > > +
> > > +static const struct power_supply_ext oxp_psy_ext =3D {
> > > +     .name                   =3D "oxp-charge-control",
> > > +     .properties             =3D oxp_psy_ext_props,
> > > +     .num_properties         =3D ARRAY_SIZE(oxp_psy_ext_props),
> > > +     .charge_behaviours      =3D EC_CHARGE_CONTROL_BEHAVIOURS,
> > > +     .get_property           =3D oxp_psy_ext_get_prop,
> > > +     .set_property           =3D oxp_psy_ext_set_prop,
> > > +     .property_is_writeable  =3D oxp_psy_prop_is_writeable,
> > > +};
> > > +
> > > +static int oxp_add_battery(struct power_supply *battery, struct acpi=
_battery_hook *hook)
> > > +{
> > > +     return power_supply_register_extension(battery, &oxp_psy_ext, o=
xp_dev, NULL);
> > > +}
> > > +
> > > +static int oxp_remove_battery(struct power_supply *battery, struct a=
cpi_battery_hook *hook)
> > > +{
> > > +     power_supply_unregister_extension(battery, &oxp_psy_ext);
> > > +     return 0;
> > > +}
> > > +
> > > +static struct acpi_battery_hook battery_hook =3D {
> > > +     .add_battery    =3D oxp_add_battery,
> > > +     .remove_battery =3D oxp_remove_battery,
> > > +     .name           =3D "OneXPlayer Battery",
> > > +};
> > > +
> > >  /* PWM enable/disable functions */
> > >  static int oxp_pwm_enable(void)
> > >  {
> > > @@ -847,11 +989,22 @@ static int oxp_platform_probe(struct platform_d=
evice *pdev)
> > >  {
> > >       struct device *dev =3D &pdev->dev;
> > >       struct device *hwdev;
> > > +     int ret;
> > >
> > > +     oxp_dev =3D dev;
> > >       hwdev =3D devm_hwmon_device_register_with_info(dev, "oxp_ec", N=
ULL,
> > >                                                    &oxp_ec_chip_info,=
 NULL);
> > >
> > > -     return PTR_ERR_OR_ZERO(hwdev);
> > > +     if (IS_ERR(hwdev))
> > > +             return PTR_ERR(hwdev);
> > > +
> > > +     if (oxp_psy_ext_supported()) {
> > > +             ret =3D devm_battery_hook_register(dev, &battery_hook);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> > > +
> > > +     return 0;
> > >  }
> > >
> > >  static struct platform_driver oxp_platform_driver =3D {
> > >
>=20
--8323328-1201764611-1745579114=:950--

