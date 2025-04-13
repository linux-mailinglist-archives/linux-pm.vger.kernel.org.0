Return-Path: <linux-pm+bounces-25334-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC273A8725A
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 17:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB8A16C058
	for <lists+linux-pm@lfdr.de>; Sun, 13 Apr 2025 15:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188021DF969;
	Sun, 13 Apr 2025 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbGWRnN6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70AD17A305;
	Sun, 13 Apr 2025 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744557668; cv=none; b=uGSITnnLkYrJ/HyQj6Rr63nAXL/BX1+QaYtLeA4I0N9tM3GXC/4NHAMhL6h1YWPB9l7nfrvDYw4vWMDj7XCwXrHBi/pmeTgbkrZIWqOnhR52cjictUkU3MifiQccB61zRAG5q6W4wOUMKj7izyu9alWIXugw0+SPvHH59XBZGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744557668; c=relaxed/simple;
	bh=mWSV7q4R7AU22zsW1y55cXlr9PzlUODn/8fSB8Oz9zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmeYYd7dppodxyxEhak16qqj4sc5a6yp334Ep/LN1tWVaGROgzNr5oHQTB0n+gN5qfrrA6pU1LEtYDrwQPpQdKfb43ljnlJ7aWsZHKfoLdAXRF8HRjvUfe4SO1eMMMcrBjWdHO84mkyGBnxme1OTBL77HOlfiafc2o2AeUhmqYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbGWRnN6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so1994684f8f.1;
        Sun, 13 Apr 2025 08:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744557664; x=1745162464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZxsfLHGhHdw+hcp2OihXnDXrtegA0EYiD0UHSzUaZ4=;
        b=PbGWRnN6xXhA+QBU0lX1202LTr+jXZJM/CuaKN2Q8TffC/XZTIncbp5bfgd9rgztIB
         H5iMdBfLMfpFexiSlIonjXJ54Chje+cz5hszUXZ7/rutd+0markeWW4uYJ/AIbM3q4rg
         A66CaQf0JP+7Q2HJ/7XGCZOWHZ0jLLnvw9p8AkbXc6tVl+HA7IMmiEjALt+OCXJ68VIo
         8pMo4iSjFhDYAZshfn1RMspJKbdhimzLxJaNWIh7s+je7cToFul99jad24eyyDi343L7
         v9H7bLVUPF1CROWeZsqKgYmgnGo3zILu6yl8WFcYNt32DjLcwCCihNlGD3yfjf+rXIpV
         B5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744557664; x=1745162464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZxsfLHGhHdw+hcp2OihXnDXrtegA0EYiD0UHSzUaZ4=;
        b=e+0Vtiis094a4b0m9XjI0Ssk63YPesCQZU+532YV8oMVqASGl0+pjVg7BSIwZg8ccO
         wrek+MZscIJLpLipaaYIZcS9eReM0eOpDw+w+L3CSRuJQMEsxACCwFG/EnuJ5U4RU8z2
         WZYGbg5JsGRRcuYTUmlVOmgjTv/MNJUO+kXQ4odeK7AxFF9vw1rldrHWnuh6fxNkpxjo
         lQsK+WOqX2bJn8/EP7PnpQzy56pNMF2tAEOLo8kWrF06i0PyP3CeKKx43QIkRNSTIpc3
         8+wOdDOkJ9rUaYpcuKBAxkJvkw6PTkbA6855GjkQTLdRJWxrqHtdRnMIXGSCZLLDOk73
         Ydag==
X-Forwarded-Encrypted: i=1; AJvYcCUc/GcMZJR2T2lN7K6o4qwNHjc5xA9DIqkrdyxIRDp8MwrsBYCiKkUM/Z7erP+F6FfAGTNLWF9rJ3o=@vger.kernel.org, AJvYcCXChZaUdVKqjFxs2alAgVifwlUXGqYdmWnFeYpQAmTy2R7NDLXDpGNhMrY+ABjuRfGJ5H2z1ISslwgX@vger.kernel.org, AJvYcCXN5GDv9zEZA+1+zwXSX52Xzu6QIh2e8ctpkoirn3kJ8plWDmNu2fdjOH6O/VH/FfhVU89W7WzsaoJLokA=@vger.kernel.org, AJvYcCXSZTZP29afsPNuHtSlOXEDkutFuzITNsVcXqeM+SDNPbzLc8aXG54dVqKN4QDfmh7KHCQoxfNpc/KYOxRi@vger.kernel.org
X-Gm-Message-State: AOJu0YwosGJQdfSFXZQ7P6MCqa3ewjDy+xoLXSa6eG9Q5vnYkbKcpcua
	hvrjiwG+O6ibAzk66ouAtTLGEz/wOfoi95LOo6M0Xd/2dG13qWmHdAFHQhJ5lFZqynKWzDe4i8M
	jKtFxoTl3av56Zgd8kV3CoLoLhpo=
X-Gm-Gg: ASbGncuSeNejlswiSnm2mZmvrLpk/6ieSuaKaqIvBxlxDeaf3k2iXhwiMwEwLlm4e03
	m28W4CKTVGeu+Cqr4CJ2+yC/WYgvVYWRMIgdoONUWv3Iid517Bv48gq8n4V7c9FU7i+6WCJ3bh1
	LLx8ap0bJSWtZ/lWdYT5M2z9ZJ4LX1pSht/A==
X-Google-Smtp-Source: AGHT+IGjHNiNv8xmMNLFj/VRqKMFKwkKPYf8eGYGtYSTGt34DuGz6ijuodgiCwqBlQh9UvOz9mRx87GXDJeXuB50mYA=
X-Received: by 2002:a05:6000:40d9:b0:39c:1258:2dc9 with SMTP id
 ffacd0b85a97d-39eaaeca292mr7797745f8f.58.1744557663831; Sun, 13 Apr 2025
 08:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250413111033.11408-1-clamor95@gmail.com> <20250413111033.11408-4-clamor95@gmail.com>
 <1d27b3b5-0ece-4abe-acd7-3a3c86490dae@oracle.com>
In-Reply-To: <1d27b3b5-0ece-4abe-acd7-3a3c86490dae@oracle.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 13 Apr 2025 18:20:52 +0300
X-Gm-Features: ATxdqUH5j-izEnwu2HVtZQvn83SOvfJ_NgRHUbo_7xu1_ql0JGxo0yv3KOatEzA
Message-ID: <CAPVz0n3+gbAmxqevwXnepJUpr+rEtM5znMf82gvTFRzANbB4ig@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] power/supply: Add driver for Pegatron Chagall battery
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Heiko Stuebner <heiko@sntech.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Aradhya Bhatia <a-bhatia1@ti.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 13 =D0=BA=D0=B2=D1=96=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 18:1=
6 ALOK TIWARI <alok.a.tiwari@oracle.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
>
>
> subject  -> "power: supply:"
>
> On 13-04-2025 16:40, Svyatoslav Ryhel wrote:
> > The Pegatron Chagall is an Android tablet utilizing a customized Cypres=
s
> > CG7153AM microcontroller (MCU) as its battery fuel gauge. It supports a
> > single-cell battery and features a dual-color charging LED.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >   drivers/power/supply/Kconfig           |  12 +
> >   drivers/power/supply/Makefile          |   1 +
> >   drivers/power/supply/chagall-battery.c | 308 ++++++++++++++++++++++++=
+
> >   3 files changed, 321 insertions(+)
> >   create mode 100644 drivers/power/supply/chagall-battery.c
> >
> > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfi=
g
> > index 9f2eef6787f7..d0fc9db524bd 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -107,6 +107,18 @@ config BATTERY_ACT8945A
> >         Say Y here to enable support for power supply provided by
> >         Active-semi ActivePath ACT8945A charger.
> >
> > +config BATTERY_CHAGALL
> > +     tristate "Pegatron Chagall battery driver"
> > +     depends on I2C
> > +     depends on LEDS_CLASS
> > +     help
> > +       Say Y to include support for Cypress CG7153AM IC based battery
> > +       fuel gauge with custom firmware found in Pegatron Chagall based
> > +       tablet line.
> > +
> > +       This driver can also be built as a module. If so, the module wi=
ll be
> > +       called chagall-battery.
> > +
> >   config BATTERY_CPCAP
> >       tristate "Motorola CPCAP PMIC battery driver"
> >       depends on MFD_CPCAP && IIO
> > diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makef=
ile
> > index 59c4a9f40d28..4ecf48a33fdd 100644
> > --- a/drivers/power/supply/Makefile
> > +++ b/drivers/power/supply/Makefile
> > @@ -23,6 +23,7 @@ obj-$(CONFIG_CHARGER_ADP5061)       +=3D adp5061.o
> >   obj-$(CONFIG_BATTERY_ACT8945A)      +=3D act8945a_charger.o
> >   obj-$(CONFIG_BATTERY_AXP20X)        +=3D axp20x_battery.o
> >   obj-$(CONFIG_CHARGER_AXP20X)        +=3D axp20x_ac_power.o
> > +obj-$(CONFIG_BATTERY_CHAGALL)        +=3D chagall-battery.o
> >   obj-$(CONFIG_BATTERY_CPCAP) +=3D cpcap-battery.o
> >   obj-$(CONFIG_BATTERY_CW2015)        +=3D cw2015_battery.o
> >   obj-$(CONFIG_BATTERY_DS2760)        +=3D ds2760_battery.o
> > diff --git a/drivers/power/supply/chagall-battery.c b/drivers/power/sup=
ply/chagall-battery.c
> > new file mode 100644
> > index 000000000000..1a278331efe7
> > --- /dev/null
> > +++ b/drivers/power/supply/chagall-battery.c
> > @@ -0,0 +1,308 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
>
> Blank line require
>
> > +#include <linux/array_size.h>
> > +#include <linux/delay.h>
> > +#include <linux/devm-helpers.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/leds.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/power_supply.h>
> > +#include <linux/regmap.h>
> > +
> > +#define CHAGALL_REG_LED_AMBER                                0x60
> > +#define CHAGALL_REG_LED_WHITE                                0x70
> > +#define CHAGALL_REG_BATTERY_TEMPERATURE                      0xa2
> > +#define CHAGALL_REG_BATTERY_VOLTAGE                  0xa4
> > +#define CHAGALL_REG_BATTERY_CURRENT                  0xa6
> > +#define CHAGALL_REG_BATTERY_CAPACITY                 0xa8
> > +#define CHAGALL_REG_BATTERY_CHARGING_CURRENT         0xaa
> > +#define CHAGALL_REG_BATTERY_CHARGING_VOLTAGE         0xac
> > +#define CHAGALL_REG_BATTERY_STATUS                   0xae
> > +#define   BATTERY_DISCHARGING                                BIT(6)
> > +#define   BATTERY_FULL_CHARGED                               BIT(5)
> > +#define   BATTERY_FULL_DISCHARGED                    BIT(4)
>
> ' ' after "#define", remove extra ' '
>
> > +#define CHAGALL_REG_BATTERY_REMAIN_CAPACITY          0xb0
> > +#define CHAGALL_REG_BATTERY_FULL_CAPACITY            0xb2
> > +#define CHAGALL_REG_MAX_COUNT                                0xb4
> > +
> > +#define CHAGALL_BATTERY_DATA_REFRESH                 5000
> > +#define TEMP_CELSIUS_OFFSET                          2731
> > +
> > +static const struct regmap_config chagall_battery_regmap_config =3D {
> > +     .reg_bits =3D 8,
> > +     .val_bits =3D 8,
> > +     .max_register =3D CHAGALL_REG_MAX_COUNT,
> > +     .reg_format_endian =3D REGMAP_ENDIAN_LITTLE,
> > +     .val_format_endian =3D REGMAP_ENDIAN_LITTLE,
> > +};
> > +
> > +struct chagall_battery_data {
> > +     struct regmap *regmap;
> > +     struct led_classdev amber_led;
> > +     struct led_classdev white_led;
> > +     struct power_supply *battery;
> > +     struct delayed_work poll_work;
> > +     u16 last_state;
> > +};
> > +
> > +static void chagall_led_set_brightness_amber(struct led_classdev *led,
> > +                                          enum led_brightness brightne=
ss)
> > +{
> > +     struct chagall_battery_data *cg =3D
> > +             container_of(led, struct chagall_battery_data, amber_led)=
;
> > +
> > +     regmap_write(cg->regmap, CHAGALL_REG_LED_AMBER, brightness);
> > +}
> > +
> > +static void chagall_led_set_brightness_white(struct led_classdev *led,
> > +                                          enum led_brightness brightne=
ss)
> > +{
> > +     struct chagall_battery_data *cg =3D
> > +             container_of(led, struct chagall_battery_data, white_led)=
;
> > +
> > +     regmap_write(cg->regmap, CHAGALL_REG_LED_WHITE, brightness);
> > +}
> > +
> > +static void chagall_leds_status_update(struct chagall_battery_data *cg=
, int state)
> > +{
> > +     switch (state) {
> > +     case POWER_SUPPLY_STATUS_FULL:
> > +             led_set_brightness(&cg->amber_led, LED_OFF);
> > +             led_set_brightness(&cg->white_led,  LED_ON);
> > +             break;
> > +
>
> no Blank line.
>
> > +     case POWER_SUPPLY_STATUS_CHARGING:
> > +             led_set_brightness(&cg->white_led, LED_OFF);
> > +             led_set_brightness(&cg->amber_led,  LED_ON);
> > +             break;
> > +
>
> no Blank line.
>
> > +     default:
> > +             led_set_brightness(&cg->amber_led, LED_OFF);
> > +             led_set_brightness(&cg->white_led, LED_OFF);
> > +             break;
> > +     }
> > +}
> > +
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
> > +
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
> > +                     else if (val->intval & BATTERY_DISCHARGING)
> > +                             val->intval =3D POWER_SUPPLY_STATUS_DISCH=
ARGING;
> > +                     else
> > +                             val->intval =3D POWER_SUPPLY_STATUS_CHARG=
ING;
> > +                     break;
> > +
>
> no blank line is required between a case label.
>
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
> > +
> > +     if (cg->last_state !=3D state) {
> > +             cg->last_state =3D state;
> > +             power_supply_changed(cg->battery);
> > +     }
> > +
> > +     chagall_leds_status_update(cg, state);
> > +
> > +     /* continuously send uevent notification */
> > +     schedule_delayed_work(&cg->poll_work,
> > +                           msecs_to_jiffies(CHAGALL_BATTERY_DATA_REFRE=
SH));
> > +}
> > +
> > +static const struct power_supply_desc chagall_battery_desc =3D {
> > +     .name =3D "chagall-battery",
> > +     .type =3D POWER_SUPPLY_TYPE_BATTERY,
> > +     .properties =3D chagall_battery_properties,
> > +     .num_properties =3D ARRAY_SIZE(chagall_battery_properties),
> > +     .get_property =3D chagall_battery_get_property,
> > +     .external_power_changed =3D power_supply_changed,
> > +};
> > +
> > +static int chagall_battery_probe(struct i2c_client *client)
> > +{
> > +     struct chagall_battery_data *cg;
> > +     struct device *dev =3D &client->dev;
> > +     struct power_supply_config cfg =3D { };
> > +     int ret;
> > +
> > +     cg =3D devm_kzalloc(dev, sizeof(*cg), GFP_KERNEL);
> > +     if (!cg)
> > +             return -ENOMEM;
> > +
> > +     cfg.drv_data =3D cg;
> > +     cfg.fwnode =3D dev_fwnode(dev);
> > +
> > +     i2c_set_clientdata(client, cg);
> > +
> > +     cg->regmap =3D devm_regmap_init_i2c(client, &chagall_battery_regm=
ap_config);
> > +     if (IS_ERR(cg->regmap))
> > +             return dev_err_probe(dev, PTR_ERR(cg->regmap), "cannot al=
locate regmap\n");
> > +
> > +     cg->last_state =3D POWER_SUPPLY_STATUS_UNKNOWN;
> > +     cg->battery =3D devm_power_supply_register(dev, &chagall_battery_=
desc, &cfg);
> > +     if (IS_ERR(cg->battery))
> > +             return dev_err_probe(dev, PTR_ERR(cg->battery), "failed t=
o register power supply\n");
> > +
> > +     cg->amber_led.name =3D "power::amber";
> > +     cg->amber_led.max_brightness =3D 1;
> > +     cg->amber_led.flags =3D LED_CORE_SUSPENDRESUME;
> > +     cg->amber_led.brightness_set =3D chagall_led_set_brightness_amber=
;
> > +
> > +     ret =3D devm_led_classdev_register(dev, &cg->amber_led);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to register amber =
LED\n");
> > +
> > +     cg->white_led.name =3D "power::white";
> > +     cg->white_led.max_brightness =3D 1;
> > +     cg->white_led.flags =3D LED_CORE_SUSPENDRESUME;
> > +     cg->white_led.brightness_set =3D chagall_led_set_brightness_white=
;
> > +
> > +     ret =3D devm_led_classdev_register(dev, &cg->white_led);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to register white =
LED\n");
> > +
> > +     led_set_brightness(&cg->amber_led, LED_OFF);
> > +     led_set_brightness(&cg->white_led, LED_OFF);
> > +
> > +     ret =3D devm_delayed_work_autocancel(dev, &cg->poll_work, chagall=
_battery_poll_work);
> > +     if (ret)
> > +             return ret;
> > +
> > +     schedule_delayed_work(&cg->poll_work, msecs_to_jiffies(CHAGALL_BA=
TTERY_DATA_REFRESH));
>
> a '\n' before return is customary
>
> > +     return 0;
> > +}
> > +
> > +static int __maybe_unused chagall_battery_suspend(struct device *dev)
> > +{
> > +     struct i2c_client *client =3D to_i2c_client(dev);
> > +     struct chagall_battery_data *cg =3D i2c_get_clientdata(client);
> > +
> > +     cancel_delayed_work_sync(&cg->poll_work);
>
> a '\n' before return
>
> > +     return 0;
> > +}
> > +
> > +static int __maybe_unused chagall_battery_resume(struct device *dev)
> > +{
> > +     struct i2c_client *client =3D to_i2c_client(dev);
> > +     struct chagall_battery_data *cg =3D i2c_get_clientdata(client);
> > +
> > +     schedule_delayed_work(&cg->poll_work, msecs_to_jiffies(CHAGALL_BA=
TTERY_DATA_REFRESH));
>
> a '\n' before return is customary
>
> > +     return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(chagall_battery_pm_ops,
> > +                      chagall_battery_suspend, chagall_battery_resume)=
;
> > +
> > +static const struct of_device_id chagall_of_match[] =3D {
> > +     { .compatible =3D "pegatron,chagall-ec" },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, chagall_of_match);
> > +
> > +static struct i2c_driver chagall_battery_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "chagall-battery",
> > +             .pm =3D &chagall_battery_pm_ops,
> > +             .of_match_table =3D chagall_of_match,
> > +     },
> > +     .probe =3D chagall_battery_probe,
> > +};
> > +module_i2c_driver(chagall_battery_driver);
> > +
> > +MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> > +MODULE_DESCRIPTION("Pegatron Chagall fuel gauge driver");
> > +MODULE_LICENSE("GPL");
>
>
>
> Thanks,
> Alok

Acknowledged. Thank you.

