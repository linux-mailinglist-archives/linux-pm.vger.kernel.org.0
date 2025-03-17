Return-Path: <linux-pm+bounces-24220-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4720A65C60
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 19:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E5017DF5D
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 18:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A141E1DE6;
	Mon, 17 Mar 2025 18:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="E5LA6XG8"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA2C1AD403;
	Mon, 17 Mar 2025 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235666; cv=none; b=IoX6TGamC4O0lBy1sG379yZTEJ1PK63HkntT4LBj5pM7hX7hwVX6akhlq/DNChSxPMFcJWJduEvG6zgkdPE+OvO5S5bYFpDEBbW+81cs4E4KlXFkP2khc3QsnSI13OrG+1M0TDuVOcwgrAr/CUsKylYqG1UDDBwGssWGlD7Qfeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235666; c=relaxed/simple;
	bh=DTGw30GJU6XtyqmLV4rQNAynMK0we6/escXqnDkmrtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGmbOgJw+j1SCW9tiHFxdy39luucFQr/SW5UdDaZ9v4/a/GCOTA4Nhg9vP6lH9yV4Qnbw8unfVUWbZcu7pOqc6eTwdG85MqXGncNWcC+BUc83LknlCLcu1pvFzxsu2uqqrbQRycN9fkoV6r6k6iDw35lHNUFoijmHbGLiEbzVJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=E5LA6XG8; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id DA8172E09714;
	Mon, 17 Mar 2025 20:20:58 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742235659;
	bh=lQhS/dI+OgQN4h3ARbRdjajMvo41AOZLUn72RjEnV1M=;
	h=Received:From:Subject:To;
	b=E5LA6XG8H7A5E5+VJAX6n5QlSwcyTSeP1tgRdsU67f6DHs65Nc4L6GPgew/O9bbZg
	 REBM5Rsj/XHoLrib+Wk1232n9FXFrBFq6OnPqxAPpVXl1q3hdksTusMSliZ7lf43H0
	 YPis7ueuNVCOJjmnebaFq1qCFAgD8gE2ItVwhrL8=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.177) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f177.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-30c416cdcc0so47121171fa.2;
        Mon, 17 Mar 2025 11:20:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU59VAJdQezBPYN1LCnxr3QC3P4gk2cM81J+J7KWWfGFn1QTObJYJX5tRo+5faZNFFBYUWNiTlXLPDP/qw=@vger.kernel.org,
 AJvYcCUtssyJK1ARxJOd7gy3C6nDLhVCalM0KtQd7LPub7K4dDVeAbU7Hro53BcffdagyixjqaCs2li7Oz29/pYk@vger.kernel.org,
 AJvYcCVNeLerBYjvqBnKUVGFVV4UuJmEJnWqMg4D/StgJdKU+Ud2rX5gEfaWUQlVyh+FVPCAyqp8pJhu4eQ=@vger.kernel.org,
 AJvYcCXXwSgSK5v5W32/LkDcr29Ion8lxEXiZtpz3opjY7u1psYGTOL2K44rYu3bkyUF9F1iMnQTG9OSbmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9TVjoOFDT9HWEoGkJGHKpRtiuSb0g5TZN+4HgNhPXeltffys8
	BQ+H6whQIaveOYUlCQ/gQM1m6BSWPq2v8Ho51Dj4WXsynFMUgy3D0ebJUJg5VRJZQ72Wj9C7ijU
	GuezZy7VcyV+/RDD7qb3wWMsCUQo=
X-Google-Smtp-Source: 
 AGHT+IF1GgLFIU9OUI1gZLVF+2PzYl+p2EYN1avr5sGXHHdLK8H1kRx0ZNmy8eLN1UlSswNYLZFrQbs8yst5ep4+kVk=
X-Received: by 2002:a2e:b8d0:0:b0:30b:d44d:e76a with SMTP id
 38308e7fff4ca-30c4a8d8ae1mr111761651fa.25.1742235658072; Mon, 17 Mar 2025
 11:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317155349.1236188-1-lkml@antheas.dev>
 <20250317155349.1236188-14-lkml@antheas.dev>
 <ce0727b4-bf47-4dc7-9103-d87d88a0e213@t-8ch.de>
In-Reply-To: <ce0727b4-bf47-4dc7-9103-d87d88a0e213@t-8ch.de>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 17 Mar 2025 19:20:46 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEqjoW-6J8rzm9HcJ0W1DVvzzPkPRzsKZE62gk3Q1ewSA@mail.gmail.com>
X-Gm-Features: AQ5f1Jpj3TQ2IMZaaUu8tTFLvlxNFvPgIFNKpUpHMuVbO0dMUD8TETLhLplPWuY
Message-ID: 
 <CAGwozwEqjoW-6J8rzm9HcJ0W1DVvzzPkPRzsKZE62gk3Q1ewSA@mail.gmail.com>
Subject: Re: [PATCH v5 13/13] platform/x86: oxpec: Add charge threshold and
 behaviour to OneXPlayer
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>, Eileen <eileen@one-netbook.com>,
	linux-kernel@vger.kernel.org, sre@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <174223565968.26444.1298207011260685595@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Mon, 17 Mar 2025 at 19:13, Thomas Wei=C3=9Fschuh <linux@weissschuh.net> =
wrote:
>
> On 2025-03-17 16:53:49+0100, Antheas Kapenekakis wrote:
> > With the X1 (AMD), OneXPlayer added a charge limit and charge inhibit
> > feature to their devices. Charge limit allows for choosing an arbitrary
> > battery charge setpoint in percentages. Charge ihibit allows to instruc=
t
>                                                  inhibit
>
> > the device to stop charging either when it is awake or always.
> >
> > This feature was then extended for the F1Pro as well. OneXPlayer also
> > released BIOS updates for the X1 Mini, X1 (Intel), and F1 devices that
> > add support for this feature. Therefore, enable it for all F1 and
> > X1 devices.
>
> What happens for devices without the BIOS update?
> Can the availability be detected during probe and handled properly?
>
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  drivers/platform/x86/Kconfig |   1 +
> >  drivers/platform/x86/oxpec.c | 164 ++++++++++++++++++++++++++++++++++-
> >  2 files changed, 161 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
> > index 82cfc76bc5c9f..f4d993658c01f 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1189,6 +1189,7 @@ config SEL3350_PLATFORM
> >  config OXP_EC
> >       tristate "OneXPlayer EC platform control"
> >       depends on ACPI_EC
> > +     depends on ACPI_BATTERY
> >       depends on HWMON
> >       depends on X86
> >       help
> > diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.=
c
> > index 39a29295f9cfe..88d839c2a4834 100644
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
>
> Using a global variable is ugly.
> An explicit parameter passed through
> battery_hook_register() -> add_battery()
> would be nicer.
> It would require changes to the core code and all its users, though.

I debated doing this. Unfortunately, this driver uses a global
variable already (see board), so introducing a struct here seemed a
bit excessive.

During a refactor, removing the board global variable would introduce
a features struct, which can then be used for the battery hook.

So I think they should be done together in a future series.

> >
> >  /* Fan reading and PWM */
> >  #define OXP_SENSOR_FAN_REG             0x76 /* Fan reading is 2 regist=
ers long */
> > @@ -93,6 +95,23 @@ static enum oxp_board board;
> >  #define OXP_X1_TURBO_LED_OFF           0x01
> >  #define OXP_X1_TURBO_LED_ON            0x02
> >
> > +/* Battery extension settings */
> > +#define EC_CHARGE_CONTROL_BEHAVIOURS_X1      (BIT(POWER_SUPPLY_CHARGE_=
BEHAVIOUR_AUTO)             | \
> > +                                      BIT(POWER_SUPPLY_CHARGE_BEHAVIOU=
R_INHIBIT_CHARGE)    | \
> > +                                      BIT(POWER_SUPPLY_CHARGE_BEHAVIOU=
R_INHIBIT_CHARGE_AWAKE))
> > +
> > +#define OXP_X1_CHARGE_LIMIT_REG      0xA3 /* X1 charge limit (%) */
> > +#define OXP_X1_CHARGE_INHIBIT_REG     0xA4 /* X1 bypass charging */
> > +
> > +#define OXP_X1_CHARGE_INHIBIT_MASK_AWAKE 0x01
> > +/*
> > + * X1 Mask is 0x0A, OneXFly F1Pro is just 0x02
> > + * but the extra bit on the X1 does nothing.
> > + */
> > +#define OXP_X1_CHARGE_INHIBIT_MASK_OFF 0x02
> > +#define OXP_X1_CHARGE_INHIBIT_MASK_ALWAYS (OXP_X1_CHARGE_INHIBIT_MASK_=
AWAKE | \
> > +     OXP_X1_CHARGE_INHIBIT_MASK_OFF)
> > +
> >  static const struct dmi_system_id dmi_table[] =3D {
> >       {
> >               .matches =3D {
> > @@ -507,6 +526,136 @@ static ssize_t tt_led_show(struct device *dev,
> >
> >  static DEVICE_ATTR_RW(tt_led);
> >
> > +/* Callbacks for charge behaviour attributes */
> > +static bool oxp_psy_ext_supported(void)
> > +{
> > +     switch (board) {
> > +     case oxp_x1:
> > +     case oxp_fly:
> > +             return 1;
> > +     default:
> > +             break;
> > +     }
> > +     return 0;
>
> For 'bool' use 'true' and 'false.
>
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
> > +             if (raw_val > 100)
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
> > +struct power_supply_ext oxp_psy_ext =3D {
>
> static const
>
> > +     .name                   =3D "oxp-charge-control",
> > +     .properties             =3D oxp_psy_ext_props,
> > +     .num_properties         =3D ARRAY_SIZE(oxp_psy_ext_props),
> > +     .charge_behaviours      =3D EC_CHARGE_CONTROL_BEHAVIOURS_X1,
>
> The charge control behaviours are named "X1", but nothing else.
> Seems inconsistent.
>
> > +     .get_property           =3D oxp_psy_ext_get_prop,
> > +     .set_property           =3D oxp_psy_ext_set_prop,
> > +     .property_is_writeable  =3D oxp_psy_prop_is_writeable,
> > +};
> > +
> > +static int oxp_add_battery(struct power_supply *battery, struct acpi_b=
attery_hook *hook)
> > +{
> > +     /* OneXPlayer devices only have one battery. */
> > +     if (strcmp(battery->desc->name, "BAT0") !=3D 0 &&
> > +         strcmp(battery->desc->name, "BAT1") !=3D 0 &&
> > +         strcmp(battery->desc->name, "BATC") !=3D 0 &&
> > +         strcmp(battery->desc->name, "BATT") !=3D 0)
> > +             return -ENODEV;
>
> If they only have one battery, why is the check necessary?

Leftover from when I modelled the battery hook from asus-wmi. If the
battery hook only runs for system batteries and not e.g., for
peripherals, I will remove this.

> > +
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
> > +     .add_battery =3D oxp_add_battery,
> > +     .remove_battery =3D oxp_remove_battery,
> > +     .name =3D "OneXPlayer Battery",
>
> This struct can also be aligned.

Can you expand on that?

> > +};
> > +
> >  /* PWM enable/disable functions */
> >  static int oxp_pwm_enable(void)
> >  {
> > @@ -845,12 +994,19 @@ static const struct hwmon_chip_info oxp_ec_chip_i=
nfo =3D {
> >  static int oxp_platform_probe(struct platform_device *pdev)
> >  {
> >       struct device *dev =3D &pdev->dev;
> > -     struct device *hwdev;
> > +     int ret;
> >
> > -     hwdev =3D devm_hwmon_device_register_with_info(dev, "oxpec", NULL=
,
> > -                                                  &oxp_ec_chip_info, N=
ULL);
> > +     oxp_dev =3D dev;
> > +     ret =3D PTR_ERR_OR_ZERO(devm_hwmon_device_register_with_info(
> > +             dev, "oxp_ec", NULL, &oxp_ec_chip_info, NULL));
> >
> > -     return PTR_ERR_OR_ZERO(hwdev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (oxp_psy_ext_supported())
> > +             return devm_battery_hook_register(dev, &battery_hook);
>
> If the driver is extended in the future this line will need to be touch
> again as it is an unconditional early return.
>
> This is more future-proof:
>
> if (oxp_psy_ext_supported()) {
>         ret =3D devm_battery_hook_register(dev, &battery_hook);
>         if (ret)
>                 return ret;
> }
>
> > +
> > +     return 0;
> >  }
> >
> >  static struct platform_driver oxp_platform_driver =3D {
> > --
> > 2.48.1
> >

Thanks for the comments, I will try to fix them on a V6. Hopefully you
can clarify the 3 here.

Best,
Antheas

