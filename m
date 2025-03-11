Return-Path: <linux-pm+bounces-23802-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8483BA5B0CC
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 01:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D34587A5521
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 00:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D788A50;
	Tue, 11 Mar 2025 00:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="VTbJGq36"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B10F5258;
	Tue, 11 Mar 2025 00:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741651385; cv=none; b=k7OpFqEJsX5Qw3O8O9c/Dl8z6XTNL4waHu6Zx/WQkCfPxHSdAEY229Wtc2DNOWnEPDojdfTeC9cKDQdPFyTqhxCn06TE+Ji0xllTyzdOsFGP7LkrsxrPCvI3DtejrllzfHusBmbiq2OYuaS5V+rImg5JeUxZULat2ShnqCM72Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741651385; c=relaxed/simple;
	bh=o2rndGmSANWJIWmJ2fiEuwePrpEoDHrLyrWTJCHG844=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5vPKpdKwq/o4APIHiht5Vb7+JLIuuixZxrbF4CoIssMBE0JSObicb4Cbc9cOC6jlaDuZxyjJ02YwvfpGxyoFOBz92it0y97zkIWr6jizuqDRlmsnNWeCfno0Dtacf6FzfL+ps3dm+yk0Zu55hzWJfXYTfwap/KFpY8d6kEMDrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=VTbJGq36; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id B7E8B2E09CA5;
	Tue, 11 Mar 2025 02:02:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741651379;
	bh=mqNigfRlIpWYMl0pBgNTyx7LVnR/pZgC6OV/ptsL+Pg=;
	h=Received:From:Subject:To;
	b=VTbJGq36gABKsI8wtNbQe4sUMinyRBYFNAE2PqRc5J1Q2yrDQYfvUSyUePFpkHlkd
	 2G1r3GRU8+NWScfuV++x/gQ7DotTus9kxEpUGButgCjU/v7GSNbd+CWbYLL/fwGpV3
	 y6WTVxbMtiHoLyznm/lbXC/ccDZxAjK7bYj69F3I=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.175) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f175.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-30bf8f5dde5so30944381fa.2;
        Mon, 10 Mar 2025 17:02:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVs7huxU134iypQ6d+CkSsuWnEwy20QpnVjshVdyZVHUUUoNSbMteYcptYzdjZRUTWmFHY27AwiWcw=@vger.kernel.org,
 AJvYcCWPDdWseToZCwzcz3QJLn3YIjWm8FWPGMSKah0KW6e1eNCipNOOtdd12gpN2gTkbnwg7tckKE2XA0LNc3g=@vger.kernel.org,
 AJvYcCWrA93BkZvvbGP6ZJYZ4RAZ8j4K2RuJnjQ8Z/gSks+/S3NM984Cr1wGmDWBBp9rMEuaQebiMCpO0VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGXeO0kZ4BF6mEMFGEztxebyyRFT7yfuJ36/DnNVUWbss5gz63
	VbnUkWGjFf/rQVe0QDYP4ze7jHAhcHEhzNwZCBJNCZfXj4wXh9bj9Jv8IzeBQT74btEebo15etd
	DuO97NjAib4vQf+qfgiSttFO/ihE=
X-Google-Smtp-Source: 
 AGHT+IEpLukf4KQwouiE/rO5D3PifDw4LGfLW/ikGed/O7+tCnH62GPHtjOSUnA/6LJqiLbhPb1BAYD3WwJjpf355XA=
X-Received: by 2002:a2e:2c0e:0:b0:30b:b956:53c2 with SMTP id
 38308e7fff4ca-30bf4513574mr46821321fa.11.1741651374006; Mon, 10 Mar 2025
 17:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309112114.1177361-1-lkml@antheas.dev>
 <20250309112114.1177361-7-lkml@antheas.dev>
 <CAFqHKT=M0ZqeV25zqfmg1dnfLPfJ2+8+rq12pfXoZkZx-J2e_g@mail.gmail.com>
In-Reply-To: 
 <CAFqHKT=M0ZqeV25zqfmg1dnfLPfJ2+8+rq12pfXoZkZx-J2e_g@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 11 Mar 2025 01:02:42 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwFUG4FoZvtSp-Vz5816K8WvNP5YgGB1H29M388q1GD_yw@mail.gmail.com>
X-Gm-Features: AQ5f1JoucYDU_jPjyUjhMUL93ucl3plxSOALUT88tsi8Rlh0xrH5zz5Apk1EcY8
Message-ID: 
 <CAGwozwFUG4FoZvtSp-Vz5816K8WvNP5YgGB1H29M388q1GD_yw@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] platform/x86: oxpec: Add charge threshold and
 behaviour to OneXPlayer
To: Derek John Clark <derekjohn.clark@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <174165137544.28025.622617932087270383@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Tue, 11 Mar 2025 at 00:51, Derek John Clark
<derekjohn.clark@gmail.com> wrote:
>
> On Sun, Mar 9, 2025 at 4:21=E2=80=AFAM Antheas Kapenekakis <lkml@antheas.=
dev> wrote:
> >
> > With the X1 (AMD), OneXPlayer added a charge limit and charge bypass to
> > their devices. Charge limit allows for choosing an arbitrary battery
> > charge setpoint in percentages. Charge bypass allows to instruct the
> > device to stop charging either when it is in s0 or always.
> >
> > This feature was then extended for the F1Pro as well. OneXPlayer also
> > released BIOS updates for the X1 Mini, X1 (Intel), and F1 devices that
> > add support for this feature. Therefore, enable it for all F1 and
> > X1 devices.
> >
>
> As noted in your previous patch, I think checking for BIOS support is
> a wise move here.
>
> > Add both of these under the standard sysfs battery endpoints for them,
> > by looking for the battery. OneXPlayer devices have a single battery.
> >
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  drivers/platform/x86/oxpec.c | 217 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 217 insertions(+)
> >
> > diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.=
c
> > index dc3a0871809c..dd6d333ebcfa 100644
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
> > @@ -87,6 +88,24 @@ static enum oxp_board board;
> >
> >  #define OXP_TURBO_RETURN_VAL           0x00 /* Common return val */
> >
> > +/* Battery bypass settings */
> > +#define EC_CHARGE_CONTROL_BEHAVIOURS_X1        (BIT(POWER_SUPPLY_CHARG=
E_BEHAVIOUR_AUTO)             | \
> > +                                        BIT(POWER_SUPPLY_CHARGE_BEHAVI=
OUR_INHIBIT_CHARGE)    | \
> > +                                        BIT(POWER_SUPPLY_CHARGE_BEHAVI=
OUR_INHIBIT_CHARGE_S0))
> > +
> > +#define OXP_X1_CHARGE_LIMIT_REG      0xA3 /* X1 charge limit (%) */
> > +#define OXP_X1_CHARGE_BYPASS_REG     0xA4 /* X1 bypass charging */
> > +
> > +#define OXP_X1_CHARGE_BYPASS_MASK_S0 0x01
> > +/*
> > + * Cannot control S3, S5 individually.
> > + * X1 Mask is 0x0A, OneXFly F1Pro is just 0x02
> > + * but the extra bit on the X1 does nothing.
> > + */
> > +#define OXP_X1_CHARGE_BYPASS_MASK_S3S5 0x02
> > +#define OXP_X1_CHARGE_BYPASS_MASK_ALWAYS (OXP_X1_CHARGE_BYPASS_MASK_S0=
 | \
> > +       OXP_X1_CHARGE_BYPASS_MASK_S3S5)
> > +
> >  static const struct dmi_system_id dmi_table[] =3D {
> >         {
> >                 .matches =3D {
> > @@ -434,6 +453,194 @@ static ssize_t tt_toggle_show(struct device *dev,
> >
> >  static DEVICE_ATTR_RW(tt_toggle);
> >
> > +/* Callbacks for turbo toggle attribute */
>
> This comment is not correct for the section. I think it was a copy/paste?
>
> > +static bool charge_behaviour_supported(void)
>
> Attribute groups support .is_visible. This blocks invocation from
> userspace, vice doing it in probe() manually.

Unsure what this means. Instead of using is_visible, I block the
battery attachment, which is preferable ATM as all devices that
support battery features support all of them. If new devices have
additional features not covered by this, we will have to move towards
using is_visible.

> > +{
> > +       switch (board) {
> > +       case oxp_x1:
> > +       case oxp_fly:
> > +               return 1;
> > +       default:
> > +               break;
> > +       }
> > +       return 0;
> > +}
> > +
> > +static ssize_t charge_behaviour_store(struct device *dev,
> > +                              struct device_attribute *attr, const cha=
r *buf,
> > +                              size_t count)
> > +{
> > +       int ret;
> > +       u8 reg;
> > +       long val, s0, always;
> > +       unsigned int available;
> > +
>
> Convention is to order variables in reverse xmas tree, with the
> longest line first and shortest line last.

Sure

> > +       switch (board) {
> > +       case oxp_x1:
> > +       case oxp_fly:
> > +               s0 =3D OXP_X1_CHARGE_BYPASS_MASK_S0;
> > +               always =3D OXP_X1_CHARGE_BYPASS_MASK_ALWAYS;
> > +               reg =3D OXP_X1_CHARGE_BYPASS_REG;
> > +               available =3D EC_CHARGE_CONTROL_BEHAVIOURS_X1;
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       ret =3D power_supply_charge_behaviour_parse(available, buf);
> > +       if (ret < 0)
>
> Does ret ever return > 0? I think you can just if (ret)

This is how it is used in other platform drivers. I might be able to
indulge you on the others though.

> > +               return ret;
> > +
> > +       switch (ret) {
> > +       case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
> > +               val =3D 0;
> > +               break;
> > +       case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0:
> > +               val =3D s0;
> > +               break;
> > +       case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
> > +               val =3D always;
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       ret =3D write_to_ec(reg, val);
> > +       if (ret < 0)
>
> if (ret)
>
> > +               return ret;
> > +
> > +       return count;
> > +}
> > +
> > +static ssize_t charge_behaviour_show(struct device *dev,
> > +                             struct device_attribute *attr, char *buf)
> > +{
> > +       int ret;
> > +       u8 reg;
> > +       long val, s0, always, sel;
> > +       unsigned int available;
> > +
>
> Reverse xmas tree here too.
>
> > +       switch (board) {
> > +       case oxp_x1:
> > +       case oxp_fly:
> > +               s0 =3D OXP_X1_CHARGE_BYPASS_MASK_S0;
> > +               always =3D OXP_X1_CHARGE_BYPASS_MASK_ALWAYS;
> > +               reg =3D OXP_X1_CHARGE_BYPASS_REG;
> > +               available =3D EC_CHARGE_CONTROL_BEHAVIOURS_X1;
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       ret =3D read_from_ec(reg, 1, &val);
> > +       if (ret < 0)
>
> if (ret)
>
> > +               return ret;
> > +
> > +       if ((val & always) =3D=3D always)
> > +               sel =3D POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
> > +       else if ((val & s0) =3D=3D s0)
> > +               sel =3D POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0=
;
> > +       else
> > +               sel =3D POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> > +
> > +       return power_supply_charge_behaviour_show(dev, available, sel, =
buf);
> > +}
> > +
> > +static DEVICE_ATTR_RW(charge_behaviour);
> > +
> > +static ssize_t charge_control_end_threshold_store(struct device *dev,
> > +                              struct device_attribute *attr, const cha=
r *buf,
> > +                              size_t count)
> > +{
> > +       u64 val, reg;
> > +       int ret;
> > +
> > +       ret =3D kstrtou64(buf, 10, &val);
> > +       if (ret < 0)
>
> if (ret)
>
> > +               return ret;
> > +       if (val > 100)
> > +               return -EINVAL;
> > +
> > +       switch (board) {
> > +       case oxp_x1:
> > +       case oxp_fly:
> > +               reg =3D OXP_X1_CHARGE_LIMIT_REG;
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       ret =3D write_to_ec(reg, val);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       return count;
> > +}
> > +
> > +static ssize_t charge_control_end_threshold_show(struct device *dev,
> > +                             struct device_attribute *attr, char *buf)
> > +{
> > +       int ret;
> > +       u8 reg;
> > +       long val;
> > +
>
> Reverse xmas tree here too.
>
> > +       switch (board) {
> > +       case oxp_x1:
> > +       case oxp_fly:
> > +               reg =3D OXP_X1_CHARGE_LIMIT_REG;
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       ret =3D read_from_ec(reg, 1, &val);
> > +       if (ret < 0)
>
> if (ret)
>
> Cheers,
> - Derek
>
> > +               return ret;
> > +
> > +       return sysfs_emit(buf, "%ld\n", val);
> > +}
> > +
> > +static DEVICE_ATTR_RW(charge_control_end_threshold);
> > +
> > +static int oxp_battery_add(struct power_supply *battery, struct acpi_b=
attery_hook *hook)
> > +{
> > +       /* OneXPlayer devices only have one battery. */
> > +       if (strcmp(battery->desc->name, "BAT0") !=3D 0 &&
> > +           strcmp(battery->desc->name, "BAT1") !=3D 0 &&
> > +           strcmp(battery->desc->name, "BATC") !=3D 0 &&
> > +           strcmp(battery->desc->name, "BATT") !=3D 0)
> > +               return -ENODEV;
> > +
> > +       if (device_create_file(&battery->dev,
> > +           &dev_attr_charge_control_end_threshold))
> > +               return -ENODEV;
> > +
> > +       if (device_create_file(&battery->dev,
> > +           &dev_attr_charge_behaviour)) {
> > +               device_remove_file(&battery->dev,
> > +                               &dev_attr_charge_control_end_threshold)=
;
> > +               return -ENODEV;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int oxp_battery_remove(struct power_supply *battery, struct acp=
i_battery_hook *hook)
> > +{
> > +       device_remove_file(&battery->dev,
> > +                          &dev_attr_charge_control_end_threshold);
> > +       device_remove_file(&battery->dev,
> > +                          &dev_attr_charge_behaviour);
> > +       return 0;
> > +}
> > +
> > +static struct acpi_battery_hook battery_hook =3D {
> > +       .add_battery =3D oxp_battery_add,
> > +       .remove_battery =3D oxp_battery_remove,
> > +       .name =3D "OneXPlayer Battery",
> > +};
> > +
> >  /* PWM enable/disable functions */
> >  static int oxp_pwm_enable(void)
> >  {
> > @@ -716,15 +923,25 @@ static int oxp_platform_probe(struct platform_dev=
ice *pdev)
> >         hwdev =3D devm_hwmon_device_register_with_info(dev, "oxpec", NU=
LL,
> >                                                      &oxp_ec_chip_info,=
 NULL);
> >
> > +       if (charge_behaviour_supported())
> > +               battery_hook_register(&battery_hook);
> > +
> >         return PTR_ERR_OR_ZERO(hwdev);
> >  }
> >
> > +static void oxp_platform_remove(struct platform_device *device)
> > +{
> > +       if (charge_behaviour_supported())
> > +               battery_hook_unregister(&battery_hook);
> > +}
> > +
> >  static struct platform_driver oxp_platform_driver =3D {
> >         .driver =3D {
> >                 .name =3D "oxp-platform",
> >                 .dev_groups =3D oxp_ec_groups,
> >         },
> >         .probe =3D oxp_platform_probe,
> > +       .remove =3D oxp_platform_remove,
> >  };
> >
> >  static struct platform_device *oxp_platform_device;
> > --
> > 2.48.1
> >

