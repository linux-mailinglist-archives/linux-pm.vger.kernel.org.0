Return-Path: <linux-pm+bounces-22529-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D187A3D17F
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 07:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7092416A772
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 06:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26551DFD95;
	Thu, 20 Feb 2025 06:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzLeTDso"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C342B1DE4EF;
	Thu, 20 Feb 2025 06:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740033810; cv=none; b=u6Rp1JJ/de8Qf7F/Glc49/dfREp/H3g77gyahDRr8wMCUcs6uQUtLK89LaKNbP5/iGqE5t5yKzfhut8e1DBTyda7tYj0YQbFeGTYPsHnyZg+rlPFQfqo01p/Y9AbMQJH07E0EZrbb84bG1PlPMkLk7+uVwwP1FNsfwNn184hws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740033810; c=relaxed/simple;
	bh=IgXDkA8zQ7gpIAgHmvEBgq12IekqiOdlAhG7c9x3/tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqgSHePrtWvjwG+oBw8Gml/7sk0OGSYMvgn+Nh9DlDZbQfHVtkmAPXF74pfFO2hIQihLAkL7z7pkIVBC0NQPdtqUjzURv5vD2WNaYVe/1xya6E9/r4TqAAlt6BaplsM9H2mh2ns6UahQpX1wj2mL/GXWlqY0aMtNOEsFUm/tbhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzLeTDso; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fbffe0254fso1194325a91.3;
        Wed, 19 Feb 2025 22:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740033808; x=1740638608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdJdDBPOZx54lELBs2ESegJRMXcmexSRuuAtno7e1Tg=;
        b=DzLeTDsoDwM7PiEuS4sxs7MzN0FWrwG3mTNndgI6NX2LGhqI4dQZr3MmrfWkeXQA+6
         NSCCuBi5zj+VhITf3Ja8BiW6OdimC68htBGRnTqhGhXONh/wprVZD/4RG2cSYXPvVqvy
         sff3tU1u3hQOSPWVqcWcZN2zuVQ+QZK5lt/XGIPlBJwZDV5dUrihIVaPaZfss/4GC5fK
         fIxBqGgmSLz3jBfJ2AyXJv9XkmN1uJGE9lZck1flOo62ALd0gSkqcpC/czXtEu1T4cps
         8UyAuKzEGkXxm7RadvE/RR7CveadUX0quAWNryHyhzl0aIVdL08PYMTE2IGtADDvalDE
         lu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740033808; x=1740638608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QdJdDBPOZx54lELBs2ESegJRMXcmexSRuuAtno7e1Tg=;
        b=TuVi7JDc+EkHs0XmfcNYeRI3HoNslpuE1/3wxgaLbuIK9/zIKZxkYezJ/59FrR8pBl
         7wElcQqtqXCO83GlmWWnq4eY/dMZnFOlOJUxWqx0maBs3PpuWVHvqDdqhGaAKQZyluAP
         ksn/wxtOqr6s69LUEV8z1j+YddtllEaDQuDu2Sg2t/8juIab3RhUqSHOTOAVts6b4ajY
         Lm+zNCXS4olQ9XxN0FxQmLBjtj3QJ+WBTl31J9/RfHNKgGt26pty0tsYAgxI/C9Q/uc8
         LS6vqJui7ah20pgJ5EX2DIJ66b3Y5rfq6rRsFsETIbRTeWcERvlzX8H9OCtlzga7cfXD
         7ktA==
X-Forwarded-Encrypted: i=1; AJvYcCUjzMHyZdo2/xrOJbX3fRwbgM02aC6DtguqjpOo1fE1OMXhOd+YU/SmFsoLWv51usFN5wQELPcITQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgfIkrHiNUKkMTlrx8bEHeBHVXOjzWougft56186D52E9VH0a4
	R859hbA6W1Y0zUMEqgYAs/yvPLrl0pFT7FvV/4Es5/bht963yhsZ
X-Gm-Gg: ASbGncsZ1VZXEj5QK9bIIr0Gi1Cdan8TH3tZLVmrSZBrg0bS7FzUt4s3iavKpApXomf
	4334KgTy6fB+Ct1HWQRQnu/YqDnnC8RaUMjVb6yf61CDnivcxnuHXswSkorexhkSE8gHfiYoSop
	dDYCjJxyxo0cLBTeqbnDKVR3SrmY9oWXYHfqPx5Vi5M/yeCWmbBoTM0icDaIbDJVdHVjqAJl5k+
	WS8Go9ybxz2sJ10dG/6Lr5XKx9LCBdaJ6Xku5OMWjDKTygaG9dhH8M0aO8lDx9hvuFEycNkh4cd
	NbryI2pFkgfqS9ia
X-Google-Smtp-Source: AGHT+IGKWfNJUjXuNDLnkXtT9lYiOH6/FU/VkWd4OlnD9jxKDmuN1difU7nVKV2vViweERa6fLS1Pg==
X-Received: by 2002:a17:90a:dfc5:b0:2ee:cd83:8fe6 with SMTP id 98e67ed59e1d1-2fcb5ac074amr10353580a91.35.1740033807786;
        Wed, 19 Feb 2025 22:43:27 -0800 (PST)
Received: from SC8280XP.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ad7c62sm12738279a91.29.2025.02.19.22.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 22:43:27 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: sebastian.reichel@collabora.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mitltlatltl@gmail.com
Subject: Re: [PATCH v3 5/6] power: supply: add Huawei Matebook E Go psy driver
Date: Thu, 20 Feb 2025 14:43:20 +0800
Message-ID: <20250220064321.4641-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <gw2ciofohbyv6u6pt2iqmy64al2suk5vzaixoyofetsugmyep7@nmymx3vgllwe>
References: <gw2ciofohbyv6u6pt2iqmy64al2suk5vzaixoyofetsugmyep7@nmymx3vgllwe>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Feb 20, 2025 at 8:24 AM Sebastian Reichel <sebastian.reichel@collabora.com> wrote: 
> Hi,
> 
> On Tue, Jan 14, 2025 at 01:51:27AM +0800, Pengyu Luo wrote:
> > On the Huawei Matebook E Go tablet the EC provides access to the adapter
> > and battery status. Add the driver to read power supply status on the
> > tablet.
> >
> > Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> > ---
> >  .../ABI/testing/sysfs-class-power-gaokun      |  47 ++
> >  drivers/power/supply/Kconfig                  |  10 +
> >  drivers/power/supply/Makefile                 |   1 +
> >  drivers/power/supply/huawei-gaokun-battery.c  | 548 ++++++++++++++++++
> >  4 files changed, 606 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-class-power-gaokun
> >  create mode 100644 drivers/power/supply/huawei-gaokun-battery.c
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-power-gaokun b/Documentation/ABI/testing/sysfs-class-power-gaokun
> > new file mode 100644
> > index 000000000..b1eb9e8d7
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-class-power-gaokun
> > @@ -0,0 +1,47 @@
> > +What:                /sys/class/power_supply/gaokun-ec-battery/smart_charge
> > +Date:                January 2025
> > +KernelVersion:       6.12
> > +Contact:     Pengyu Luo <mitltlatltl@gmail.com>
> > +Description:
> > +             This entry allows configuration of smart charging behavior with
> > +             four parameters. The format is: <mode> <delay> <start> <stop>.
> > +
> > +             - mode: Defines the charging mode (1 or 4). Mode 4 enables delay,
> > +                     while mode 1 does not.
> > +             - delay: Specifies the delay in hours (non-negative). This is
> > +                     only used when 'mode' is set to 4.
> > +             - start: The battery percentage at which charging starts (0-100).
> > +             - stop: The battery percentage at which charging stops (1-100).
> > +
> > +              When the laptop is connected to a power adapter, it starts
> > +              charging if the battery level is below the 'start' value. It
> > +              continues charging until the battery reaches the 'stop' level.
> > +              If the battery is already above the 'stop' level, charging is
> > +              paused.
> > +
> > +              When the power adapter is always connected, charging will
> > +              begin if the battery level falls below 'start', and charging
> > +              will stop once the battery reaches 'stop'.
> > +
> > +              If mode is set to 4, the above charging mode will only occur
> > +              after the specified delay in hours. If mode is 1, there is
> > +              no delay.
> > +
> > +             Access: Read, Write
> > +
> > +             Valid values:
> > +                     - mode: integer value (1 or 4)
> > +                     - delay: integer value, delay in hours (non-negative)
> > +                     - start: integer value, battery percentage (0-100)
> > +                     - stop: integer value, battery percentage (1-100)
> 
> There are common properties for start and stop charging percentage,
> which should be used:
> 
> * POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD
> * POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD
> 

Agree, but at least, we should pass delay, start, end. EC only
providedone interface to set mode and delay, that requires 4
arguments, we can handle it with 3 arguments, as you suggested
below. but if we treat start and end separated, then if we want
to set smart charge, we set start, set end, set delay(read start
read end, then set them again). It is a bit redundant.

> For the charge mode it seems there is no need to expose anything.
> You can have a single property for the charge delay in hours. If
> '0' is written to it there is no delay, so you can use mode 1 and
> otherwise you can use mode 4. There is no need for this multi-value
> mess. The delay thing seems to be quite specific to this EC, so a
> custom property for that is fine.
> 

Agree, mentioned above

> > +What:                /sys/class/power_supply/gaokun-ec-battery/smart_charge_enable
> > +Date:                January 2025
> > +KernelVersion:       6.12
> > +Contact:     Pengyu Luo <mitltlatltl@gmail.com>
> > +Description:
> > +             This entry allows enabling smart charging.
> > +
> > +             Access: Read, Write
> > +
> > +             Valid values: 0 (disabled) or 1 (enabled)
> > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > index 7b18358f1..556bda9ad 100644
> > --- a/drivers/power/supply/Kconfig
> > +++ b/drivers/power/supply/Kconfig
> > @@ -161,6 +161,16 @@ config BATTERY_DS2782
> >         Say Y here to enable support for the DS2782/DS2786 standalone battery
> >         gas-gauge.
> > 
> > +config BATTERY_HUAWEI_GAOKUN
> > +     tristate "Huawei Matebook E Go power supply"
> > +     depends on EC_HUAWEI_GAOKUN
> > +     help
> > +       This driver enables battery and adapter support on the Huawei Matebook
> > +       E Go, which is a sc8280xp-based 2-in-1 tablet.
> > +
> > +       To compile the driver as a module, choose M here: the module will be
> > +       called huawei-gaokun-battery.
> > +
> >  config BATTERY_LEGO_EV3
> >       tristate "LEGO MINDSTORMS EV3 battery"
> >       depends on OF && IIO && GPIOLIB && (ARCH_DAVINCI_DA850 || COMPILE_TEST)
> > diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> > index b55cc48a4..796570e7f 100644
> > --- a/drivers/power/supply/Makefile
> > +++ b/drivers/power/supply/Makefile
> > @@ -31,6 +31,7 @@ obj-$(CONFIG_BATTERY_DS2781)        += ds2781_battery.o
> >  obj-$(CONFIG_BATTERY_DS2782) += ds2782_battery.o
> >  obj-$(CONFIG_BATTERY_GAUGE_LTC2941)  += ltc2941-battery-gauge.o
> >  obj-$(CONFIG_BATTERY_GOLDFISH)       += goldfish_battery.o
> > +obj-$(CONFIG_BATTERY_HUAWEI_GAOKUN)  += huawei-gaokun-battery.o
> >  obj-$(CONFIG_BATTERY_LEGO_EV3)       += lego_ev3_battery.o
> >  obj-$(CONFIG_BATTERY_LENOVO_YOGA_C630) += lenovo_yoga_c630_battery.o
> >  obj-$(CONFIG_BATTERY_PMU)    += pmu_battery.o
> > diff --git a/drivers/power/supply/huawei-gaokun-battery.c b/drivers/power/supply/huawei-gaokun-battery.c
> > new file mode 100644
> > index 000000000..65b617aea
> > --- /dev/null
> > +++ b/drivers/power/supply/huawei-gaokun-battery.c
> > @@ -0,0 +1,548 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * huawei-gaokun-battery - A power supply driver for HUAWEI Matebook E Go
> > + *
> > + * reference: drivers/power/supply/lenovo_yoga_c630_battery.c
> > + *            drivers/platform/arm64/acer-aspire1-ec.c
> > + *            drivers/acpi/battery.c
> > + *            drivers/acpi/ac.c
> > + *
> > + * Copyright (C) 2024 Pengyu Luo <mitltlatltl@gmail.com>
> > + */
> > +
> > +#include <linux/auxiliary_bus.h>
> > +#include <linux/bits.h>
> > +#include <linux/delay.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/module.h>
> > +#include <linux/notifier.h>
> > +#include <linux/platform_data/huawei-gaokun-ec.h>
> > +#include <linux/power_supply.h>
> > +#include <linux/sprintf.h>
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* String Data Reg */
> > +
> > +#define EC_BAT_VENDOR                0x01 /* from 0x01 to 0x0F, SUNWODA */
> > +#define EC_BAT_MODEL         0x11 /* from 0x11 to 0x1F, HB30A8P9ECW-22T */
> > +
> > +#define EC_ADP_STATUS                0x81
> > +#define EC_AC_STATUS         BIT(0)
> > +#define EC_BAT_PRESENT               BIT(1) /* BATC._STA */
> > +
> > +#define EC_BAT_STATUS                0x82 /* _BST */
> > +#define EC_BAT_DISCHARGING   BIT(0)
> > +#define EC_BAT_CHARGING              BIT(1)
> > +#define EC_BAT_CRITICAL              BIT(2) /* Low Battery Level */
> > +#define EC_BAT_FULL          BIT(3)
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* Word Data Reg */
> > +
> > +/* 0x5A: ?
> > + * 0x5C: ?
> > + * 0x5E: ?
> > + * 0X60: ?
> > + * 0x84: ?
> > + */
> > +
> > +#define EC_BAT_STATUS_START  0x90
> > +#define EC_BAT_PERCENTAGE    0x90
> > +#define EC_BAT_VOLTAGE               0x92
> > +#define EC_BAT_CAPACITY              0x94
> > +#define EC_BAT_FULL_CAPACITY 0x96
> > +/* 0x98: ? */
> > +#define EC_BAT_CURRENT               0x9A
> > +/* 0x9C: ? */
> > +
> > +#define EC_BAT_INFO_START    0xA0
> > +/* 0xA0: POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT? */
> > +#define EC_BAT_DESIGN_CAPACITY       0xA2
> > +#define EC_BAT_DESIGN_VOLTAGE        0xA4
> > +#define EC_BAT_SERIAL_NUMBER 0xA6
> > +#define EC_BAT_CYCLE_COUNT   0xAA
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* Battery Event ID */
> > +
> > +#define EC_EVENT_BAT_A0              0xA0
> > +#define EC_EVENT_BAT_A1              0xA1
> > +#define EC_EVENT_BAT_A2              0xA2
> > +#define EC_EVENT_BAT_A3              0xA3
> > +#define EC_EVENT_BAT_B1              0xB1
> > +/* EVENT B1 A0 A1 repeat about every 1s 2s 3s respectively */
> > +
> > +/* ACPI _BIX field, Min sampling time, the duration between two _BST */
> > +#define CACHE_TIME           3000 /* cache time in milliseconds */
> > +
> > +#define MILLI_TO_MICRO               1000
> > +
> > +struct gaokun_psy_bat_status {
> > +     __le16 percentage_now;  /* 0x90 */
> > +     __le16 voltage_now;
> > +     __le16 capacity_now;
> > +     __le16 full_capacity;
> > +     __le16 unknown1;
> > +     __le16 rate_now;
> > +     __le16 unknown2;        /* 0x9C */
> > +} __packed;
> > +
> > +struct gaokun_psy_bat_info {
> > +     __le16 unknown3;        /* 0xA0 */
> > +     __le16 design_capacity;
> > +     __le16 design_voltage;
> > +     __le16 serial_number;
> > +     __le16 padding2;
> > +     __le16 cycle_count;     /* 0xAA */
> > +} __packed;
> > +
> > +struct gaokun_psy {
> > +     struct gaokun_ec *ec;
> > +     struct device *dev;
> > +     struct notifier_block nb;
> > +
> > +     struct power_supply *bat_psy;
> > +     struct power_supply *adp_psy;
> > +
> > +     unsigned long update_time;
> > +     struct gaokun_psy_bat_status status;
> > +     struct gaokun_psy_bat_info info;
> > +
> > +     char battery_model[0x10]; /* HB30A8P9ECW-22T, the real one is XXX-22A */
> > +     char battery_serial[0x10];
> > +     char battery_vendor[0x10];
> > +
> > +     int charge_now;
> > +     int online;
> > +     int bat_present;
> > +};
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* Adapter */
> > +
> > +static int gaokun_psy_get_adp_status(struct gaokun_psy *ecbat)
> > +{
> > +     /* _PSR */
> > +     int ret;
> > +     u8 online;
> > +
> > +     ret = gaokun_ec_psy_read_byte(ecbat->ec, EC_ADP_STATUS, &online);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ecbat->online = !!(online & EC_AC_STATUS);
> > +
> > +     return 0;
> > +}
> > +
> > +static int gaokun_psy_get_adp_property(struct power_supply *psy,
> > +                                    enum power_supply_property psp,
> > +                                    union power_supply_propval *val)
> > +{
> > +     struct gaokun_psy *ecbat = power_supply_get_drvdata(psy);
> > +     int ret;
> > +
> > +     ret = gaokun_psy_get_adp_status(ecbat);
> > +     if (ret)
> > +             return ret;
> > +
> > +     switch (psp) {
> > +     case POWER_SUPPLY_PROP_ONLINE:
> > +             val->intval = ecbat->online;
> > +             break;
> > +
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static enum power_supply_property gaokun_psy_adp_props[] = {
> > +     POWER_SUPPLY_PROP_ONLINE,
> > +};
> > +
> > +static const struct power_supply_desc gaokun_psy_adp_desc = {
> > +     .name           = "gaokun-ec-adapter",
> > +     .type           = POWER_SUPPLY_TYPE_USB_TYPE_C,
> 
> That's deprecated and should not be used. Use POWER_SUPPLY_TYPE_USB
> and POWER_SUPPLY_PROP_USB_TYPE for the exact type.
> 

Agree

> > +     .get_property   = gaokun_psy_get_adp_property,
> > +     .properties     = gaokun_psy_adp_props,
> > +     .num_properties = ARRAY_SIZE(gaokun_psy_adp_props),
> > +};
> > +
> > +/* -------------------------------------------------------------------------- */
> > +/* Battery */
> > +
> > +static inline void gaokun_psy_get_bat_present(struct gaokun_psy *ecbat)
> > +{
> > +     int ret;
> > +     u8 present;
> > +
> > +     /* Some kind of initialization */
> > +     gaokun_ec_write(ecbat->ec, (u8 []){0x02, 0xB2, 1, 0x90});
> > +
> > +     ret = gaokun_ec_psy_read_byte(ecbat->ec, EC_ADP_STATUS, &present);
> > +
> > +     ecbat->bat_present = ret ? false : !!(present & EC_BAT_PRESENT);
> > +}
> > +
> > +static inline int gaokun_psy_bat_present(struct gaokun_psy *ecbat)
> > +{
> > +     return ecbat->bat_present;
> > +}
> > +
> > +static int gaokun_psy_get_bat_info(struct gaokun_psy *ecbat)
> > +{
> > +     /* _BIX */
> > +     if (!gaokun_psy_bat_present(ecbat))
> > +             return 0;
> > +
> > +     return gaokun_ec_psy_multi_read(ecbat->ec, EC_BAT_INFO_START,
> > +                                     sizeof(ecbat->info), (u8 *)&ecbat->info);
> > +}
> > +
> > +static void gaokun_psy_update_bat_charge(struct gaokun_psy *ecbat)
> > +{
> > +     u8 charge;
> > +
> > +     gaokun_ec_psy_read_byte(ecbat->ec, EC_BAT_STATUS, &charge);
> > +
> > +     switch (charge) {
> > +     case EC_BAT_CHARGING:
> > +             ecbat->charge_now = POWER_SUPPLY_STATUS_CHARGING;
> > +             break;
> > +     case EC_BAT_DISCHARGING:
> > +             ecbat->charge_now = POWER_SUPPLY_STATUS_DISCHARGING;
> > +             break;
> > +     case EC_BAT_FULL:
> > +             ecbat->charge_now = POWER_SUPPLY_STATUS_FULL;
> > +             break;
> > +     default:
> > +             dev_warn(ecbat->dev, "unknown charge state %d\n", charge);
> > +     }
> > +}
> > +
> > +static int gaokun_psy_get_bat_status(struct gaokun_psy *ecbat)
> > +{
> > +     /* _BST */
> > +     int ret;
> > +
> > +     if (time_before(jiffies, ecbat->update_time +
> > +                     msecs_to_jiffies(CACHE_TIME)))
> > +             return 0;
> > +
> > +     gaokun_psy_update_bat_charge(ecbat);
> > +     ret = gaokun_ec_psy_multi_read(ecbat->ec, EC_BAT_STATUS_START,
> > +                                    sizeof(ecbat->status), (u8 *)&ecbat->status);
> > +
> > +     ecbat->update_time = jiffies;
> > +
> > +     return ret;
> > +}
> > +
> > +static void gaokun_psy_init(struct gaokun_psy *ecbat)
> > +{
> > +     gaokun_psy_get_bat_present(ecbat);
> 
> why?
> 

EC provided a way to check if battery is presented, if there is no
battery, then we don't fetch battery info, but other info
(i.e. adapter) is still available.

> > +     if (!gaokun_psy_bat_present(ecbat))
> > +             return;
> 
> You only call it in your probe function, so the following will
> remain uninitialized if the battery was not present at boot time.
> 

mentioned above, keep them uninitialized is unharmful.

Best wishes,
Pengyu

