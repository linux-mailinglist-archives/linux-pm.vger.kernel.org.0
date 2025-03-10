Return-Path: <linux-pm+bounces-23796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C61A5AF8C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 00:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C841714C5
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 23:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DD8221DAA;
	Mon, 10 Mar 2025 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHOfu496"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E491E0E0A;
	Mon, 10 Mar 2025 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741650662; cv=none; b=iqLCI93lnVp21dFljfv37fHrS0MhUpjDRyJAVQUO8Q4AbhxYh48tX2n6OIgvb+p6TtfRj4JWDurWKT6a8farGKW7ctLAr0ddGJMwihihfNDYvOO+J8G2Lzc5WZc3I/AsK/G7Gh7KMxJiFY8kzZ2qv9bsTV29FpBILXH11B3/cVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741650662; c=relaxed/simple;
	bh=UpgTQPJkI9FPIAPN+AMrm1gFR/3CmLnV9B2CqMLpITo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVSXWuKpzL4up58yvmu/507xO6regkuS4rYZ8KQaEHz6KyXCpIOXqjJXv0j0mXwaOLuwE/ZClxOHy4vx5rErmBNsZ/V+o+PAD0OrBoay1+B5Gf8qU6G53Ps4O4xOfaxyG3k3gJjzCAylEkVhsp7IDBhDRRgGUticB8G3pIysDVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHOfu496; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c55500d08cso72355585a.0;
        Mon, 10 Mar 2025 16:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741650660; x=1742255460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nr/tG+Vj8JIGXwyqhAY02QB4s1dkpSacSfNJrAtNmY=;
        b=HHOfu49658FL/lOR/zqeSfKnhkg9G0bEvvpjHW5eHtDmel+dZyotNE7t0PYQ8XuecC
         xQ9gt3rgfNskYYyO+xcDE8QGuSnz1ZfEHk+daLdBna9o55SQLLgTRxb540zV+YclnLEu
         kcRmJxcqOctbIL8uUExzjGkL3yhiFxR4Ig3nMzt5yeu3n49hsDp1QQcIb8LoQLWwFv46
         CuygpsY62FJ6nFxwNfMVt869Lh9CnXxfVDJw+mdgCA8iYobkMW5ccFRb1s+szKYj/mg8
         Un5GJwkjahENhtR4uY9QOrr4uKHLU7F6URK9DRTcLziqENlZYhCncaejVZEG0oKVVq3v
         Fx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741650660; x=1742255460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nr/tG+Vj8JIGXwyqhAY02QB4s1dkpSacSfNJrAtNmY=;
        b=H7BUBePifFoEdYQs3HrZ8tnwQephfzh2J7L1oTOIT6fQEMkk6jEBJMM3PHJhZitAoE
         Zq3rjVIbaE9GKjhNs9Rf7yAVMXfC/x0WnhKgl7OPPEvTd+dHm2EYjAX0haXEAVylrhWj
         dDKHs4vOeqYDP1cumVuuoPeRDzj/Vxr4vTZpMW2ZvnX4dTnftL5Ufg6OpCxMYgIXechc
         JaYY63iKp50yhnsUPETgMOkllwt74oAeM9rcpmsJzNoSC0Yaa7Okm0WaVP8lHvm1gJuj
         n2JRpIqV1EXiaJxizRejIW51ZJRfvHqPrB7KkruSATfeWYCHi62YEH8sjfdAjlqtN4V6
         o9EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgzpbAtyzEKav2LGO4X1c2AXN/fC2Y2BkuIrl3PG4fLwsA7eDAxmuci1XO2Enj4dd0+gM8fdYrUnAKJiU=@vger.kernel.org, AJvYcCWUfA3eDoAkZg7tLteR812xw3aBb742QhcWwQw50mL3nTF/VO8p7EH5M72O2TB8mIpTsJSeto6S4JE=@vger.kernel.org, AJvYcCXyaaCz4vxJBBq1GiN4ZPo6TkM7P+u9kbXtPI7w8YUj+5bptlj1+wQ8wzutiIFwciW+PBYYgTKBz40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+eaXZ/Opu39+azFOIwUkElaAxGD62rLDEYk7ZpeuBnTNOO/VY
	lUCtD4IPmishT5pGjhEeVMpthJqrwZehIY4Up40bJnyM0r+L5KvHSV8IHPTaVabzKHywhLWBHBl
	/jTcfE38K62StViyg3d4hJvmEb/A=
X-Gm-Gg: ASbGncvZPpsgCB3aUasYlPw2nph4xmZj5ZJqVwuoQDw/B2aOaeJy09mdJKeZMTpeozO
	xu6ezdk0ihjKl3AbVNfgX3UG+KAsb4uaUQkd7pbcIEFpecbxrxz3Rv/+bcFYtran5Bsd4iPhmfE
	EZpaBDod82uz2/R0tMn/I/thYxH3M=
X-Google-Smtp-Source: AGHT+IERZi3YQSf4riwbwsXCkqGHgPWxpMa88xkk4OEcGvaHbjfzLhlka4H/f4CbwZWAhwAdz1NG2q5re4kAPzRlJzI=
X-Received: by 2002:a05:6214:405:b0:6e4:2c6e:7cdc with SMTP id
 6a1803df08f44-6ea2f6f2dd7mr22644046d6.25.1741650659901; Mon, 10 Mar 2025
 16:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309112114.1177361-1-lkml@antheas.dev> <20250309112114.1177361-7-lkml@antheas.dev>
In-Reply-To: <20250309112114.1177361-7-lkml@antheas.dev>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Mon, 10 Mar 2025 16:50:48 -0700
X-Gm-Features: AQ5f1JogVSY1v_2_NHDD3LAPFPZlYJB1C1nnLn5hM210FRFTVSvJ5S9GYyZiSSs
Message-ID: <CAFqHKT=M0ZqeV25zqfmg1dnfLPfJ2+8+rq12pfXoZkZx-J2e_g@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] platform/x86: oxpec: Add charge threshold and
 behaviour to OneXPlayer
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Joaquin Ignacio Aramendia <samsagax@gmail.com>, Kevin Greenberg <kdgreenberg234@protonmail.com>, 
	Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>, 
	Eileen <eileen@one-netbook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 4:21=E2=80=AFAM Antheas Kapenekakis <lkml@antheas.de=
v> wrote:
>
> With the X1 (AMD), OneXPlayer added a charge limit and charge bypass to
> their devices. Charge limit allows for choosing an arbitrary battery
> charge setpoint in percentages. Charge bypass allows to instruct the
> device to stop charging either when it is in s0 or always.
>
> This feature was then extended for the F1Pro as well. OneXPlayer also
> released BIOS updates for the X1 Mini, X1 (Intel), and F1 devices that
> add support for this feature. Therefore, enable it for all F1 and
> X1 devices.
>

As noted in your previous patch, I think checking for BIOS support is
a wise move here.

> Add both of these under the standard sysfs battery endpoints for them,
> by looking for the battery. OneXPlayer devices have a single battery.
>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/oxpec.c | 217 +++++++++++++++++++++++++++++++++++
>  1 file changed, 217 insertions(+)
>
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index dc3a0871809c..dd6d333ebcfa 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -24,6 +24,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/processor.h>
> +#include <acpi/battery.h>
>
>  /* Handle ACPI lock mechanism */
>  static u32 oxp_mutex;
> @@ -87,6 +88,24 @@ static enum oxp_board board;
>
>  #define OXP_TURBO_RETURN_VAL           0x00 /* Common return val */
>
> +/* Battery bypass settings */
> +#define EC_CHARGE_CONTROL_BEHAVIOURS_X1        (BIT(POWER_SUPPLY_CHARGE_=
BEHAVIOUR_AUTO)             | \
> +                                        BIT(POWER_SUPPLY_CHARGE_BEHAVIOU=
R_INHIBIT_CHARGE)    | \
> +                                        BIT(POWER_SUPPLY_CHARGE_BEHAVIOU=
R_INHIBIT_CHARGE_S0))
> +
> +#define OXP_X1_CHARGE_LIMIT_REG      0xA3 /* X1 charge limit (%) */
> +#define OXP_X1_CHARGE_BYPASS_REG     0xA4 /* X1 bypass charging */
> +
> +#define OXP_X1_CHARGE_BYPASS_MASK_S0 0x01
> +/*
> + * Cannot control S3, S5 individually.
> + * X1 Mask is 0x0A, OneXFly F1Pro is just 0x02
> + * but the extra bit on the X1 does nothing.
> + */
> +#define OXP_X1_CHARGE_BYPASS_MASK_S3S5 0x02
> +#define OXP_X1_CHARGE_BYPASS_MASK_ALWAYS (OXP_X1_CHARGE_BYPASS_MASK_S0 |=
 \
> +       OXP_X1_CHARGE_BYPASS_MASK_S3S5)
> +
>  static const struct dmi_system_id dmi_table[] =3D {
>         {
>                 .matches =3D {
> @@ -434,6 +453,194 @@ static ssize_t tt_toggle_show(struct device *dev,
>
>  static DEVICE_ATTR_RW(tt_toggle);
>
> +/* Callbacks for turbo toggle attribute */

This comment is not correct for the section. I think it was a copy/paste?

> +static bool charge_behaviour_supported(void)

Attribute groups support .is_visible. This blocks invocation from
userspace, vice doing it in probe() manually.

> +{
> +       switch (board) {
> +       case oxp_x1:
> +       case oxp_fly:
> +               return 1;
> +       default:
> +               break;
> +       }
> +       return 0;
> +}
> +
> +static ssize_t charge_behaviour_store(struct device *dev,
> +                              struct device_attribute *attr, const char =
*buf,
> +                              size_t count)
> +{
> +       int ret;
> +       u8 reg;
> +       long val, s0, always;
> +       unsigned int available;
> +

Convention is to order variables in reverse xmas tree, with the
longest line first and shortest line last.

> +       switch (board) {
> +       case oxp_x1:
> +       case oxp_fly:
> +               s0 =3D OXP_X1_CHARGE_BYPASS_MASK_S0;
> +               always =3D OXP_X1_CHARGE_BYPASS_MASK_ALWAYS;
> +               reg =3D OXP_X1_CHARGE_BYPASS_REG;
> +               available =3D EC_CHARGE_CONTROL_BEHAVIOURS_X1;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       ret =3D power_supply_charge_behaviour_parse(available, buf);
> +       if (ret < 0)

Does ret ever return > 0? I think you can just if (ret)

> +               return ret;
> +
> +       switch (ret) {
> +       case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
> +               val =3D 0;
> +               break;
> +       case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0:
> +               val =3D s0;
> +               break;
> +       case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
> +               val =3D always;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       ret =3D write_to_ec(reg, val);
> +       if (ret < 0)

if (ret)

> +               return ret;
> +
> +       return count;
> +}
> +
> +static ssize_t charge_behaviour_show(struct device *dev,
> +                             struct device_attribute *attr, char *buf)
> +{
> +       int ret;
> +       u8 reg;
> +       long val, s0, always, sel;
> +       unsigned int available;
> +

Reverse xmas tree here too.

> +       switch (board) {
> +       case oxp_x1:
> +       case oxp_fly:
> +               s0 =3D OXP_X1_CHARGE_BYPASS_MASK_S0;
> +               always =3D OXP_X1_CHARGE_BYPASS_MASK_ALWAYS;
> +               reg =3D OXP_X1_CHARGE_BYPASS_REG;
> +               available =3D EC_CHARGE_CONTROL_BEHAVIOURS_X1;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       ret =3D read_from_ec(reg, 1, &val);
> +       if (ret < 0)

if (ret)

> +               return ret;
> +
> +       if ((val & always) =3D=3D always)
> +               sel =3D POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
> +       else if ((val & s0) =3D=3D s0)
> +               sel =3D POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0;
> +       else
> +               sel =3D POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> +
> +       return power_supply_charge_behaviour_show(dev, available, sel, bu=
f);
> +}
> +
> +static DEVICE_ATTR_RW(charge_behaviour);
> +
> +static ssize_t charge_control_end_threshold_store(struct device *dev,
> +                              struct device_attribute *attr, const char =
*buf,
> +                              size_t count)
> +{
> +       u64 val, reg;
> +       int ret;
> +
> +       ret =3D kstrtou64(buf, 10, &val);
> +       if (ret < 0)

if (ret)

> +               return ret;
> +       if (val > 100)
> +               return -EINVAL;
> +
> +       switch (board) {
> +       case oxp_x1:
> +       case oxp_fly:
> +               reg =3D OXP_X1_CHARGE_LIMIT_REG;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       ret =3D write_to_ec(reg, val);
> +       if (ret < 0)
> +               return ret;
> +
> +       return count;
> +}
> +
> +static ssize_t charge_control_end_threshold_show(struct device *dev,
> +                             struct device_attribute *attr, char *buf)
> +{
> +       int ret;
> +       u8 reg;
> +       long val;
> +

Reverse xmas tree here too.

> +       switch (board) {
> +       case oxp_x1:
> +       case oxp_fly:
> +               reg =3D OXP_X1_CHARGE_LIMIT_REG;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       ret =3D read_from_ec(reg, 1, &val);
> +       if (ret < 0)

if (ret)

Cheers,
- Derek

> +               return ret;
> +
> +       return sysfs_emit(buf, "%ld\n", val);
> +}
> +
> +static DEVICE_ATTR_RW(charge_control_end_threshold);
> +
> +static int oxp_battery_add(struct power_supply *battery, struct acpi_bat=
tery_hook *hook)
> +{
> +       /* OneXPlayer devices only have one battery. */
> +       if (strcmp(battery->desc->name, "BAT0") !=3D 0 &&
> +           strcmp(battery->desc->name, "BAT1") !=3D 0 &&
> +           strcmp(battery->desc->name, "BATC") !=3D 0 &&
> +           strcmp(battery->desc->name, "BATT") !=3D 0)
> +               return -ENODEV;
> +
> +       if (device_create_file(&battery->dev,
> +           &dev_attr_charge_control_end_threshold))
> +               return -ENODEV;
> +
> +       if (device_create_file(&battery->dev,
> +           &dev_attr_charge_behaviour)) {
> +               device_remove_file(&battery->dev,
> +                               &dev_attr_charge_control_end_threshold);
> +               return -ENODEV;
> +       }
> +
> +       return 0;
> +}
> +
> +static int oxp_battery_remove(struct power_supply *battery, struct acpi_=
battery_hook *hook)
> +{
> +       device_remove_file(&battery->dev,
> +                          &dev_attr_charge_control_end_threshold);
> +       device_remove_file(&battery->dev,
> +                          &dev_attr_charge_behaviour);
> +       return 0;
> +}
> +
> +static struct acpi_battery_hook battery_hook =3D {
> +       .add_battery =3D oxp_battery_add,
> +       .remove_battery =3D oxp_battery_remove,
> +       .name =3D "OneXPlayer Battery",
> +};
> +
>  /* PWM enable/disable functions */
>  static int oxp_pwm_enable(void)
>  {
> @@ -716,15 +923,25 @@ static int oxp_platform_probe(struct platform_devic=
e *pdev)
>         hwdev =3D devm_hwmon_device_register_with_info(dev, "oxpec", NULL=
,
>                                                      &oxp_ec_chip_info, N=
ULL);
>
> +       if (charge_behaviour_supported())
> +               battery_hook_register(&battery_hook);
> +
>         return PTR_ERR_OR_ZERO(hwdev);
>  }
>
> +static void oxp_platform_remove(struct platform_device *device)
> +{
> +       if (charge_behaviour_supported())
> +               battery_hook_unregister(&battery_hook);
> +}
> +
>  static struct platform_driver oxp_platform_driver =3D {
>         .driver =3D {
>                 .name =3D "oxp-platform",
>                 .dev_groups =3D oxp_ec_groups,
>         },
>         .probe =3D oxp_platform_probe,
> +       .remove =3D oxp_platform_remove,
>  };
>
>  static struct platform_device *oxp_platform_device;
> --
> 2.48.1
>

