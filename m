Return-Path: <linux-pm+bounces-26148-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C61A9B5DE
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 20:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8EA5A6E3A
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 18:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2432E1C84AF;
	Thu, 24 Apr 2025 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="CLWzb1JA"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F04818D;
	Thu, 24 Apr 2025 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745517641; cv=none; b=nEeKaJLi4lpGQF4fbvrtB68cihGCWqehuZGCjqYToPhiuEm8khvN/zze8vVYJR5zrzj1eZV50D6Q3t9JVn5+5ATw6y/CjBiqR+fnK/AdZClKJ6rwpzxud1FlICDcBQfkSmgmy5yqZjabtziexLWGmKslRuK0nnnYztBrs3RObQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745517641; c=relaxed/simple;
	bh=wXVXiBcaT8kUSl6ozwFJgRrV38JNFM9UkJOF7lOGlAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQrxjjfO1DHlWz4QuGBpZw0dCXNI0uEkG9OZ9e3+Up/ngTaGXenMhVMckMy2ZLegU+ILHzRtjaP+iVK5FSdGqXDFPUu308sVvGhuig0yB0HsS1EdLxkJ11qbEq73PqSdl2zlWixWh7dRNf5JKDOLq7GJB/A9McEpO9xQvXmcGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=CLWzb1JA; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id AF75E2E095CB;
	Thu, 24 Apr 2025 21:00:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1745517627;
	bh=GlNV9X+Men1fnwHlTrr4ZkODMjQtIgVNREterS4XY/E=;
	h=Received:From:Subject:To;
	b=CLWzb1JAW1Wd2a0C4iVc0LSRUErUqe0h+k4rYOzQjaXL0egZFbednkKhhURq5pH7l
	 PmRCnkfufUY6mnIXRxGp4gjUkgWAqm63sUnlSbMCV3e8hdiqagJb0Wtz5viCjEOQiQ
	 +USnSUMi6vETqPnNO5hhsyRZFbkaVP1i1Sb+ZQDc=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.171) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f171.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-30effbfaf4aso15275311fa.3;
        Thu, 24 Apr 2025 11:00:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUoXmZuG7VclC25tVmU0/ZAwiW/GcUZXs0rcnvED1cPv625yMoHHhtprdzZsoMUOYLMPhuuCWH4fs5/MVc=@vger.kernel.org,
 AJvYcCVAXWgePNh8lZ2LbP6zlkcL1o9i9vaT0nfrKjPoHlOjBAhuktd4rT8de+UO/Bml1r8Qw8KbgBnizeI=@vger.kernel.org,
 AJvYcCVlap5UZwIxektN31J0RgO7hMCBEr7yNxlgYmvt1hL5sdeJK4MU75qpywNsOq6hK+85y0+rbBroGfuCg6PX@vger.kernel.org,
 AJvYcCWCxzsPAyh4JdBaA9iMMjk1vQ2onL6ivOcjaG0QAUwlXr8CC7x30cyiXLtCFWuqxkuyL2vwbTjyekM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxpcNbCY6C0o44pjKvpeyPlIQBqo4Kzit44athT/VE1bPGT7sD
	kTZmILzReJ1f4mw8XXNWkgonxKO7ffGzryRkO8RhIA/KGMcwsPENv3aVipsrFASOunVWKjGOOc3
	ZEJgH7rfag2/zJnEUw//OYMNj9zk=
X-Google-Smtp-Source: 
 AGHT+IEmybHK9qK/iNL+lfdSvkpcrcZAIEeN1JzwolnD9DD0AGkNZ7A/0vDOLIP9WbLqVuCZXs0BXPfgdGOTzBSFeso=
X-Received: by 2002:a05:651c:30c7:b0:30b:bdb0:f09d with SMTP id
 38308e7fff4ca-318a9290baemr2166501fa.32.1745517624762; Thu, 24 Apr 2025
 11:00:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417175310.3552671-1-lkml@antheas.dev>
 <20250417175310.3552671-15-lkml@antheas.dev>
 <5423a653-01ac-95d2-fa52-31d849df65ef@linux.intel.com>
In-Reply-To: <5423a653-01ac-95d2-fa52-31d849df65ef@linux.intel.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 24 Apr 2025 20:00:13 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwEmiUtFndi3KaGKN_8MocpJj1R21ENbnjEeyBco8P3KSg@mail.gmail.com>
X-Gm-Features: ATxdqUEdCuA2SywZgU3HQI01EQTNyti1S8-lsgIlU9vTG1xvzz6lZvEXEDS_gc8
Message-ID: 
 <CAGwozwEmiUtFndi3KaGKN_8MocpJj1R21ENbnjEeyBco8P3KSg@mail.gmail.com>
Subject: Re: [PATCH v9 14/15] platform/x86: oxpec: Add charge threshold and
 behaviour to OneXPlayer
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>, Eileen <eileen@one-netbook.com>,
	LKML <linux-kernel@vger.kernel.org>, sre@kernel.org, linux@weissschuh.net,
	Hans de Goede <hdegoede@redhat.com>, mario.limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <174551762615.4416.1266339814403532511@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Thu, 24 Apr 2025 at 15:49, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Thu, 17 Apr 2025, Antheas Kapenekakis wrote:
>
> > With the X1 (AMD), OneXPlayer added a charge limit and charge inhibit
> > feature to their devices. Charge limit allows for choosing an arbitrary
> > battery charge setpoint in percentages. Charge ihibit allows to instruc=
t
> > the device to stop charging either when it is awake or always.
> >
> > This feature was then extended for the F1Pro as well. OneXPlayer also
> > released BIOS updates for the X1 Mini, X1 (Intel), and F1 devices that
> > add support for this feature. Therefore, enable it for all F1 and
> > X1 devices.
> >
> > Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  drivers/platform/x86/Kconfig |   1 +
> >  drivers/platform/x86/oxpec.c | 155 ++++++++++++++++++++++++++++++++++-
> >  2 files changed, 155 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
> > index 739740c4bb535..6c9e64a03aaef 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1204,6 +1204,7 @@ config SEL3350_PLATFORM
> >  config OXP_EC
> >       tristate "OneXPlayer EC platform control"
> >       depends on ACPI_EC
> > +     depends on ACPI_BATTERY
> >       depends on HWMON
> >       depends on X86
> >       help
> > diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.=
c
> > index f0b9fff704de2..ce20bf70027df 100644
> > --- a/drivers/platform/x86/oxpec.c
> > +++ b/drivers/platform/x86/oxpec.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/processor.h>
> > +#include <acpi/battery.h>
> >
> >  /* Handle ACPI lock mechanism */
> >  static u32 oxp_mutex;
> > @@ -60,6 +61,7 @@ enum oxp_board {
> >  };
> >
> >  static enum oxp_board board;
> > +static struct device *oxp_dev;
> >
> >  /* Fan reading and PWM */
> >  #define OXP_SENSOR_FAN_REG             0x76 /* Fan reading is 2 regist=
ers long */
> > @@ -93,6 +95,23 @@ static enum oxp_board board;
> >  #define OXP_X1_TURBO_LED_OFF           0x01
> >  #define OXP_X1_TURBO_LED_ON            0x02
> >
> > +/* Battery extension settings */
> > +#define EC_CHARGE_CONTROL_BEHAVIOURS (BIT(POWER_SUPPLY_CHARGE_BEHAVIOU=
R_AUTO)             | \
> > +                                      BIT(POWER_SUPPLY_CHARGE_BEHAVIOU=
R_INHIBIT_CHARGE)    | \
>
> Please change the endings to:
>
> ...) | <tabs>\
>
> > +                                      BIT(POWER_SUPPLY_CHARGE_BEHAVIOU=
R_INHIBIT_CHARGE_AWAKE))
> > +
> > +#define OXP_X1_CHARGE_LIMIT_REG      0xA3 /* X1 charge limit (%) */
> > +#define OXP_X1_CHARGE_INHIBIT_REG     0xA4 /* X1 bypass charging */
>
> Please use tabs for aligning the values (there were a few other defines
> in the earlier patches with spaces too). (I know the earlier ones used
> space but they don't seem to be in the same group so lets just move to
> tabs with new stuff, optionally, you can add a patch to change also the
> pre-existing ones to use space).
>
> > +
> > +#define OXP_X1_CHARGE_INHIBIT_MASK_AWAKE 0x01
> > +/*
> > + * X1 Mask is 0x0A, OneXFly F1Pro is just 0x02
> > + * but the extra bit on the X1 does nothing.
>
> Reflow to fill 80 chars.
>
> > + */
> > +#define OXP_X1_CHARGE_INHIBIT_MASK_OFF 0x02
> > +#define OXP_X1_CHARGE_INHIBIT_MASK_ALWAYS (OXP_X1_CHARGE_INHIBIT_MASK_=
AWAKE | \
> > +     OXP_X1_CHARGE_INHIBIT_MASK_OFF)
>
> Align to (.

I made the corrections.

Should I send a revision now or wait?

Antheas

> --
>  i.
>
> > +
> >  static const struct dmi_system_id dmi_table[] =3D {
> >       {
> >               .matches =3D {
> > @@ -507,6 +526,129 @@ static ssize_t tt_led_show(struct device *dev,
> >
> >  static DEVICE_ATTR_RW(tt_led);
> >
> > +/* Callbacks for charge behaviour attributes */
> > +static bool oxp_psy_ext_supported(void)
> > +{
> > +     switch (board) {
> > +     case oxp_x1:
> > +     case oxp_fly:
> > +             return true;
> > +     default:
> > +             break;
> > +     }
> > +     return false;
> > +}
> > +
> > +static int oxp_psy_ext_get_prop(struct power_supply *psy,
> > +                                    const struct power_supply_ext *ext=
,
> > +                                    void *data,
> > +                                    enum power_supply_property psp,
> > +                                    union power_supply_propval *val)
> > +{
> > +     long raw_val;
> > +     int ret;
> > +
> > +     switch (psp) {
> > +     case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
> > +             ret =3D read_from_ec(OXP_X1_CHARGE_LIMIT_REG, 1, &raw_val=
);
> > +             if (ret)
> > +                     return ret;
> > +             if (raw_val < 0 || raw_val > 100)
> > +                     return -EINVAL;
> > +             val->intval =3D raw_val;
> > +             return 0;
> > +     case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> > +             ret =3D read_from_ec(OXP_X1_CHARGE_INHIBIT_REG, 1, &raw_v=
al);
> > +             if (ret)
> > +                     return ret;
> > +             if ((raw_val & OXP_X1_CHARGE_INHIBIT_MASK_ALWAYS) =3D=3D
> > +                 OXP_X1_CHARGE_INHIBIT_MASK_ALWAYS)
> > +                     val->intval =3D POWER_SUPPLY_CHARGE_BEHAVIOUR_INH=
IBIT_CHARGE;
> > +             else if ((raw_val & OXP_X1_CHARGE_INHIBIT_MASK_AWAKE) =3D=
=3D
> > +                      OXP_X1_CHARGE_INHIBIT_MASK_AWAKE)
> > +                     val->intval =3D POWER_SUPPLY_CHARGE_BEHAVIOUR_INH=
IBIT_CHARGE_AWAKE;
> > +             else
> > +                     val->intval =3D POWER_SUPPLY_CHARGE_BEHAVIOUR_AUT=
O;
> > +             return 0;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int oxp_psy_ext_set_prop(struct power_supply *psy,
> > +                                    const struct power_supply_ext *ext=
,
> > +                                    void *data,
> > +                                    enum power_supply_property psp,
> > +                                    const union power_supply_propval *=
val)
> > +{
> > +     long raw_val;
> > +
> > +     switch (psp) {
> > +     case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
> > +             if (val->intval > 100)
> > +                     return -EINVAL;
> > +             return write_to_ec(OXP_X1_CHARGE_LIMIT_REG, val->intval);
> > +     case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> > +             switch (val->intval) {
> > +             case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
> > +                     raw_val =3D 0;
> > +                     break;
> > +             case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE:
> > +                     raw_val =3D OXP_X1_CHARGE_INHIBIT_MASK_AWAKE;
> > +                     break;
> > +             case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
> > +                     raw_val =3D OXP_X1_CHARGE_INHIBIT_MASK_ALWAYS;
> > +                     break;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +
> > +             return write_to_ec(OXP_X1_CHARGE_INHIBIT_REG, raw_val);
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int oxp_psy_prop_is_writeable(struct power_supply *psy,
> > +                                         const struct power_supply_ext=
 *ext,
> > +                                         void *data,
> > +                                         enum power_supply_property ps=
p)
> > +{
> > +     return true;
> > +}
> > +
> > +static const enum power_supply_property oxp_psy_ext_props[] =3D {
> > +     POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
> > +     POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
> > +};
> > +
> > +static const struct power_supply_ext oxp_psy_ext =3D {
> > +     .name                   =3D "oxp-charge-control",
> > +     .properties             =3D oxp_psy_ext_props,
> > +     .num_properties         =3D ARRAY_SIZE(oxp_psy_ext_props),
> > +     .charge_behaviours      =3D EC_CHARGE_CONTROL_BEHAVIOURS,
> > +     .get_property           =3D oxp_psy_ext_get_prop,
> > +     .set_property           =3D oxp_psy_ext_set_prop,
> > +     .property_is_writeable  =3D oxp_psy_prop_is_writeable,
> > +};
> > +
> > +static int oxp_add_battery(struct power_supply *battery, struct acpi_b=
attery_hook *hook)
> > +{
> > +     return power_supply_register_extension(battery, &oxp_psy_ext, oxp=
_dev, NULL);
> > +}
> > +
> > +static int oxp_remove_battery(struct power_supply *battery, struct acp=
i_battery_hook *hook)
> > +{
> > +     power_supply_unregister_extension(battery, &oxp_psy_ext);
> > +     return 0;
> > +}
> > +
> > +static struct acpi_battery_hook battery_hook =3D {
> > +     .add_battery    =3D oxp_add_battery,
> > +     .remove_battery =3D oxp_remove_battery,
> > +     .name           =3D "OneXPlayer Battery",
> > +};
> > +
> >  /* PWM enable/disable functions */
> >  static int oxp_pwm_enable(void)
> >  {
> > @@ -847,11 +989,22 @@ static int oxp_platform_probe(struct platform_dev=
ice *pdev)
> >  {
> >       struct device *dev =3D &pdev->dev;
> >       struct device *hwdev;
> > +     int ret;
> >
> > +     oxp_dev =3D dev;
> >       hwdev =3D devm_hwmon_device_register_with_info(dev, "oxp_ec", NUL=
L,
> >                                                    &oxp_ec_chip_info, N=
ULL);
> >
> > -     return PTR_ERR_OR_ZERO(hwdev);
> > +     if (IS_ERR(hwdev))
> > +             return PTR_ERR(hwdev);
> > +
> > +     if (oxp_psy_ext_supported()) {
> > +             ret =3D devm_battery_hook_register(dev, &battery_hook);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> >  }
> >
> >  static struct platform_driver oxp_platform_driver =3D {
> >

