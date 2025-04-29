Return-Path: <linux-pm+bounces-26355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C98AA01E8
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 07:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 680D07AC6EF
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 05:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAE325E47D;
	Tue, 29 Apr 2025 05:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LREXRJ3h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD3B21ABC8;
	Tue, 29 Apr 2025 05:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745905327; cv=none; b=qwoRrfpuD76U7uoiE7rVnVdIEv7JxlPk8O4aoMdI0IshK862VZvTEg0NkWU84bqQEUKfXgK5nBIXkYUxn9ViuN8PVJVhCs9tdUblqJTF4JXgWLTUyyKyEu3vjGk9eg+nEhuH2813Uq0PYzJRs4fUTgcEgMN3ieKmJSOt3L1Yahc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745905327; c=relaxed/simple;
	bh=0e5uxumMVgB+gJ4af5LiBNwBiNJ/RjGAyjB6I+PjhB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QB22yxP09X34JqWNGKRtl6yo1Xpgx1o9SQLrwkDRag3n/jDFXbpnUDcRt3UJeO58WdMiWCkWZVz66uiyw4gnMwsX7QV6vKP5A3m58Cps8aqfQ3A/ds6R2Qk7qG64UY3S4nRgLMoYsCw3YuHZmphMzcQoMcAJGE9ci/azyGVfNNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LREXRJ3h; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so3782540f8f.1;
        Mon, 28 Apr 2025 22:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745905324; x=1746510124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VB5Wtwbx78r+orlHKCiKwe2I8rH2J7zEjSM0oCRsjK0=;
        b=LREXRJ3hUgTGSCbQSam9d+zA+OJBJZZR9CegKE5Nhdo8gLPJk+pr0uJdibjX3CUF8g
         m/TlXJrYMgiXdjEYIkYz4zUtW41v4C8Ucv6ZhM5SChHgoMVz5SA1QVXfhnStjvACNN8F
         bDUfCzMPd+4OoD2z4GRzAGX5WmlogTAk4leaD9aOUkgIagZJ9SbCWPZM4BzxvxatGKBj
         10QKvICszuHEdRld4IIH/kfgxorzYa/PigD/y5Ws0nGbfsVuZugkqCnvT4FpSFcDoc4t
         R6F8iUFriaYCNnFwfCV3/WRIRT7ul1otCcPZaN2GfXp9Gp11/1s2hN6WGLBHn1PumqJa
         Bukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745905324; x=1746510124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VB5Wtwbx78r+orlHKCiKwe2I8rH2J7zEjSM0oCRsjK0=;
        b=wnXT9ho21rQodxOJ0k260kwr5B5Kz7IAXyqBzk0uB1G9x2APGXwrFMyL5MgEdWa0N0
         DYvEjxOqv3p5NYDU0l4CXo5PzzFAyMDzbYbPPpYZtANlZLynH3bReAOzBVvplMyey9I/
         Cj/PXhIzwHRV+olhTZkAjbqqlo967L3OcpSJ86m3lnJcU7l+GMss7K0E3AUOOeFUxZiH
         6m0APmCp423Ou39zhZC0bEqF901Y1zj46Vvz/cMldazpJ8aj7f0ZhT0TQSEofZo3Xk8r
         jsVVmiaJHXf3wTln0kVWbvDvzn01OWs3hNLQovnu/eZYiMUS+gs/nwyidU4GJH7PG8Hv
         LeFw==
X-Forwarded-Encrypted: i=1; AJvYcCUQydoO/WQBWEXl6joHXQ1env6t8HC9L8wo/szRoEIljF4WUUxx+jJzMZ7QAzKEN/J6TvzNtpBkp2Uhs09e@vger.kernel.org, AJvYcCVwfDwdeTPcCwdOWIGxw80hoRHFKtIL8kvR5t6P3t+EcJdtigPz+UD9DBK5w1ZyjzoR0TZgdE7NIsa5Kac=@vger.kernel.org, AJvYcCWwHPClbYAFyg2WCdpba3jxVWPitkS1uA3oVBt4Ok6kiwXvmYKjRTFV/sR570EalUrUNFRrwhp0QGo=@vger.kernel.org, AJvYcCXQCmXkB/wX8cAubGy7584I86GHqmmU6qvItOeTN2oI8HsumXrM7nm2S5NNM6/52nI8Debvq8PBnrm3@vger.kernel.org
X-Gm-Message-State: AOJu0YyH8DOI5kaQpUZoBDGXp2HSh4PxDO84Gxta0Vq2txqwRBkrq3F2
	rdplA3ayrYVTkBzHhhkBhRafh25+MJ+p6bcS6NTmr8sAeW0R0t+cqInU4LyfEoYW4DPapLbMx/V
	shUnQ+ciNtOVrSDktomSzCGhXPNM=
X-Gm-Gg: ASbGncvhl2XxmnjuGtl5J0WopVAFbMvsQSUpZhVqSlJkus8CzLfm6OanyNUpQdrRDaN
	pJtZqtk0Jab81E7l39TYSQPC1TOuv3JfIgrLDf2fFpl6NN1qFZkH8gMsxYwiq7oFX1zbev3+8an
	fTR518oFy0Oq3tt2KV1IroIvOKmenDKTEo/w==
X-Google-Smtp-Source: AGHT+IH4r75txm4cCS97/f9OrI2KG8AGYPc0bAJ+UQrYpFpQsY0S4uUNIdOxBS8MjpbL6UUQkSMtW3X5+RcM0EVnkBQ=
X-Received: by 2002:a05:6000:402b:b0:3a0:7a5d:96dc with SMTP id
 ffacd0b85a97d-3a08ad32e13mr831956f8f.13.1745905324117; Mon, 28 Apr 2025
 22:42:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250413111033.11408-1-clamor95@gmail.com> <20250413111033.11408-4-clamor95@gmail.com>
 <22du3s2n3pcyivw7ktpqcvyvady24qggiqouz5hqzoca2tzyqd@vdi5qbtdkrgj>
In-Reply-To: <22du3s2n3pcyivw7ktpqcvyvady24qggiqouz5hqzoca2tzyqd@vdi5qbtdkrgj>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 29 Apr 2025 08:41:52 +0300
X-Gm-Features: ATxdqUElrxNQVvYfTDSXnijX_xzVnVpoe4pcjetfMWxSULzsIaUGPBLP-yAkRuE
Message-ID: <CAPVz0n0Qcu7NAsqiRRrUjZLhRhNp=rmtdM9XLnf2XTiTpDyJgg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] power/supply: Add driver for Pegatron Chagall battery
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Heiko Stuebner <heiko@sntech.de>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Aradhya Bhatia <a-bhatia1@ti.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 29 =D0=BA=D0=B2=D1=96=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 02:0=
2 Sebastian Reichel
<sebastian.reichel@collabora.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi,
>
> On Sun, Apr 13, 2025 at 02:10:32PM +0300, Svyatoslav Ryhel wrote:
> > The Pegatron Chagall is an Android tablet utilizing a customized Cypres=
s
> > CG7153AM microcontroller (MCU) as its battery fuel gauge. It supports a
> > single-cell battery and features a dual-color charging LED.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
>
> This looks mostly good to me, but I have some comments.
>
> >  drivers/power/supply/Kconfig           |  12 +
> >  drivers/power/supply/Makefile          |   1 +
> >  drivers/power/supply/chagall-battery.c | 308 +++++++++++++++++++++++++
> >  3 files changed, 321 insertions(+)
> >  create mode 100644 drivers/power/supply/chagall-battery.c
>
> [...]
>
> > +static void chagall_leds_status_update(struct chagall_battery_data *cg=
, int state)
> > +{
> > +     switch (state) {
> > +     case POWER_SUPPLY_STATUS_FULL:
> > +             led_set_brightness(&cg->amber_led, LED_OFF);
> > +             led_set_brightness(&cg->white_led,  LED_ON);
> > +             break;
> > +
> > +     case POWER_SUPPLY_STATUS_CHARGING:
> > +             led_set_brightness(&cg->white_led, LED_OFF);
> > +             led_set_brightness(&cg->amber_led,  LED_ON);
> > +             break;
> > +
> > +     default:
> > +             led_set_brightness(&cg->amber_led, LED_OFF);
> > +             led_set_brightness(&cg->white_led, LED_OFF);
> > +             break;
> > +     }
> > +}
>
> Instead of doing this, you should setup LED triggers when
> registering the LEDs. The white LED can use power-supply's full_trig
> and the orange LED can use power-supply's charging_trig, which
> should have the same effect.
>
> > +static const enum power_supply_property chagall_battery_properties[] =
=3D {
> > +     POWER_SUPPLY_PROP_STATUS,
> > +     POWER_SUPPLY_PROP_PRESENT,
> > +     POWER_SUPPLY_PROP_VOLTAGE_NOW,
> > +     POWER_SUPPLY_PROP_VOLTAGE_MAX,
> > +     POWER_SUPPLY_PROP_CURRENT_NOW,
> > +     POWER_SUPPLY_PROP_CURRENT_MAX,
> > +     POWER_SUPPLY_PROP_CAPACITY,
> > +     POWER_SUPPLY_PROP_TEMP,
> > +     POWER_SUPPLY_PROP_CHARGE_FULL,
> > +     POWER_SUPPLY_PROP_CHARGE_NOW,
> > +};
> > +
> > +static const unsigned int chagall_battery_prop_offs[] =3D {
> > +     [POWER_SUPPLY_PROP_TEMP] =3D CHAGALL_REG_BATTERY_TEMPERATURE,
> > +     [POWER_SUPPLY_PROP_VOLTAGE_NOW] =3D CHAGALL_REG_BATTERY_VOLTAGE,
> > +     [POWER_SUPPLY_PROP_CURRENT_NOW] =3D CHAGALL_REG_BATTERY_CURRENT,
> > +     [POWER_SUPPLY_PROP_CAPACITY] =3D CHAGALL_REG_BATTERY_CAPACITY,
> > +     [POWER_SUPPLY_PROP_CURRENT_MAX] =3D CHAGALL_REG_BATTERY_CHARGING_=
CURRENT,
> > +     [POWER_SUPPLY_PROP_VOLTAGE_MAX] =3D CHAGALL_REG_BATTERY_CHARGING_=
VOLTAGE,
> > +     [POWER_SUPPLY_PROP_STATUS] =3D CHAGALL_REG_BATTERY_STATUS,
> > +     [POWER_SUPPLY_PROP_CHARGE_NOW] =3D CHAGALL_REG_BATTERY_REMAIN_CAP=
ACITY,
> > +     [POWER_SUPPLY_PROP_CHARGE_FULL] =3D CHAGALL_REG_BATTERY_FULL_CAPA=
CITY,
> > +};
>
> Please use the same order for chagall_battery_prop_offs and
> chagall_battery_properties. Makes it a lot easier to see
> that all options have been covered.
>
> > +static int chagall_battery_get_value(struct chagall_battery_data *cg,
> > +                                  enum power_supply_property psp, u32 =
*val)
> > +{
> > +     if (psp >=3D ARRAY_SIZE(chagall_battery_prop_offs))
> > +             return -EINVAL;
> > +     if (!chagall_battery_prop_offs[psp])
> > +             return -EINVAL;
> > +
> > +     /* Battery data is stored in 2 consecutive registers with little-=
endian */
> > +     return regmap_bulk_read(cg->regmap, chagall_battery_prop_offs[psp=
], val, 2);
> > +}
> > +
> > +static int chagall_battery_get_property(struct power_supply *psy,
> > +                                     enum power_supply_property psp,
> > +                                     union power_supply_propval *val)
> > +{
> > +     struct chagall_battery_data *cg =3D power_supply_get_drvdata(psy)=
;
> > +     int ret;
> > +
> > +     switch (psp) {
> > +     case POWER_SUPPLY_PROP_PRESENT:
> > +             val->intval =3D 1;
> > +             break;
> > +
> > +     default:
> > +             ret =3D chagall_battery_get_value(cg, psp, &val->intval);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             switch (psp) {
> > +             case POWER_SUPPLY_PROP_TEMP:
> > +                     val->intval -=3D TEMP_CELSIUS_OFFSET;
> > +                     break;
> > +
> > +             case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> > +             case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> > +             case POWER_SUPPLY_PROP_CURRENT_MAX:
> > +             case POWER_SUPPLY_PROP_CURRENT_NOW:
> > +             case POWER_SUPPLY_PROP_CHARGE_FULL:
> > +             case POWER_SUPPLY_PROP_CHARGE_NOW:
> > +                     val->intval *=3D 1000;
> > +                     break;
> > +
> > +             case POWER_SUPPLY_PROP_STATUS:
> > +                     if (val->intval & BATTERY_FULL_CHARGED)
> > +                             val->intval =3D POWER_SUPPLY_STATUS_FULL;
> > +                     else if (val->intval & BATTERY_FULL_DISCHARGED)
> > +                             val->intval =3D POWER_SUPPLY_STATUS_NOT_C=
HARGING;
>
> Have you tested this path? POWER_SUPPLY_STATUS_NOT_CHARGING is
> intended to be used when the battery is neither charging nor
> discharging. Does BATTERY_FULL_DISCHARGED mean, that the battery
> is fully depleted and not providing any energy at all? Or is this
> some kind of "battery level is criticial, you should attach a
> power-supply now or the system will be turn off by itself soon"?
>

This one is tricky. I have transferred this logic from downstream
kernel and couldn't trigger BATTERY_FULL_DISCHARGED ever. It might be
a brief state you describe as "battery level is criticial, you should
attach a power-supply now or the system will be turn off by itself
soon" but there is no such entry in POWER_SUPPLY_STATUS enum, so I
assumed that  POWER_SUPPLY_STATUS_NOT_CHARGING co-responds to such
state. If this is not the case I will just remove this entry.

> > +                     else if (val->intval & BATTERY_DISCHARGING)
> > +                             val->intval =3D POWER_SUPPLY_STATUS_DISCH=
ARGING;
> > +                     else
> > +                             val->intval =3D POWER_SUPPLY_STATUS_CHARG=
ING;
> > +                     break;
> > +
> > +             default:
> > +                     break;
> > +             }
> > +
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void chagall_battery_poll_work(struct work_struct *work)
> > +{
> > +     struct chagall_battery_data *cg =3D
> > +             container_of(work, struct chagall_battery_data, poll_work=
.work);
> > +     u32 state;
> > +     int ret;
> > +
> > +     ret =3D chagall_battery_get_value(cg, POWER_SUPPLY_PROP_STATUS, &=
state);
> > +     if (ret)
> > +             return;
> > +
> > +     if (state & BATTERY_FULL_CHARGED)
> > +             state =3D POWER_SUPPLY_STATUS_FULL;
> > +     else if (state & BATTERY_DISCHARGING)
> > +             state =3D POWER_SUPPLY_STATUS_DISCHARGING;
> > +     else
> > +             state =3D POWER_SUPPLY_STATUS_CHARGING;
>
> This basically duplicates the logic from chagall_battery_get_property(),
> so put the translation logic into a helper function and use it in
> both places.
>
> Greetings,
>
> -- Sebastian

