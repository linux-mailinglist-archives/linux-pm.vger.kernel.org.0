Return-Path: <linux-pm+bounces-23792-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6717A5AD78
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 00:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658B13AC801
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 23:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C971EF38C;
	Mon, 10 Mar 2025 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="HjuoPhia"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0C7199FBA;
	Mon, 10 Mar 2025 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741649439; cv=none; b=guqXirOZvrWXofKjQLohtPaTf1g2WNnN2iSo1iR9mfh9TYMy1QmeHXSBWXnqW1LUY2w0b0kTQmRzrbRGbNS1wQVk46S9hGdNSj62ouRSWKk53rJz1QhY0cSi+ZysgWBoB37nebwLCoxHxAdG+wbJ31pPqoN5V9ZNhBm/q5WEQf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741649439; c=relaxed/simple;
	bh=OgCGDnBuT6GRobWlRKrsqUDkyeG8g3K7AtoUJaE3soU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZbFw33tMVwsFpd99n5XyLOUXCcLlZ/M4Lz8rxkFVRoNf68jCYH1VBjcsM9+tKSPz5d97QX6PDrzPhDsKUAC03FF0i5DneMfFI22cWsz+pK+zOKhBPr+6U2/50ac0iNWFE8cSKe8SERSMo0jH1IgCTQlVfZYavQJ4Gf4JquGbSUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=HjuoPhia; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 660F72E09B08;
	Tue, 11 Mar 2025 01:30:33 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741649434;
	bh=qNPqYe1M7MJgCKWz680dtzB3LIq0lgJX+RBpAY1oWsw=;
	h=Received:From:Subject:To;
	b=HjuoPhiadU8rIe0johsu87TpBJ3Nz9NBC123g6gM2BJ2fZ95m0Sn7KE8X+7bTwJpu
	 fvira0O6LDSkg1RenNJWhN/uiJvAkn5/pMpSBRRwO+V3SiJPlgy9fJITuac+YbMTIi
	 boy+bqUUJhu0grlDTZ0xTU0+cAHFZVIlIiV+xaUI=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.176) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f176.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-30bf3f3539dso37769011fa.1;
        Mon, 10 Mar 2025 16:30:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCURBrLdMC/ZvD5AmgeKARevnc/SD8x77rzo3zp5ZVx+1v2+Io+ASZ+J7KPdcyO9AYTtYL+QiFGBw9Y=@vger.kernel.org,
 AJvYcCVUD75rWckYiiO97Wj0roTu912r6axGWiavF42lp3avQIu5YDSrDxuRBKHEg/UvCyjaPiUQOg9sgKZ4lcw=@vger.kernel.org,
 AJvYcCWjv9zYmh+DUX5TvqPRVojWti6s62uU5yONIIlrNecCPOKcBz4C6ZGgb0tm1iiDA+KbC/q3v/C293I=@vger.kernel.org
X-Gm-Message-State: AOJu0YytJ26w5iTJUYdZ8fNcE9GVqdlFGFozA+MwgE2jfZAVpxCJ7EOc
	C5/8oSc8sJsOOsck6nDy0s/Dc/FbPyoxCUtLtZw2AFTYxBnyZzfj31pOzbYFBdOEwLmi3pet020
	WrUTb9hRiArREi+IcMl1QQoV8LxE=
X-Google-Smtp-Source: 
 AGHT+IGnB5W0AMN3KtJYzkf/I2pws+cTfwF2uTZoDrTLDEvW9Z/N65y1irDJxu5eX2nl/jG9RaR97YMvu9p+ssDWQn8=
X-Received: by 2002:a2e:9598:0:b0:30b:ee7d:1a88 with SMTP id
 38308e7fff4ca-30c20ebea10mr4382421fa.10.1741649432537; Mon, 10 Mar 2025
 16:30:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309112114.1177361-1-lkml@antheas.dev>
 <20250309112114.1177361-4-lkml@antheas.dev>
 <CAFqHKTn4hrKS0aiG1UNfZG5+mVcWEZw729pKv2YhXJtsFDCJEA@mail.gmail.com>
In-Reply-To: 
 <CAFqHKTn4hrKS0aiG1UNfZG5+mVcWEZw729pKv2YhXJtsFDCJEA@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 11 Mar 2025 00:30:21 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEbVKsx8yh7hRLHFho9eJdb5TdTVN-3jV1V0vj7-5mq7g@mail.gmail.com>
X-Gm-Features: AQ5f1JoM0_C2npBKOoN_7KllLJ-C71LSFaMp_OyLXs4_Bd3ATrR8Ared27tD4QY
Message-ID: 
 <CAGwozwEbVKsx8yh7hRLHFho9eJdb5TdTVN-3jV1V0vj7-5mq7g@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] platform/x86: oxpec: Move hwmon/oxp-sensors to
 platform/x86
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
 <174164943394.20762.15105591864460359133@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Tue, 11 Mar 2025 at 00:18, Derek John Clark
<derekjohn.clark@gmail.com> wrote:
>
> On Sun, Mar 9, 2025 at 4:21=E2=80=AFAM Antheas Kapenekakis <lkml@antheas.=
dev> wrote:
> >
> > The EC of OneXPlayer devices used to only control the fan.
> > This is no longer the case, with the EC of OneXPlayer gaining
> > additional functionality (turbo button, turbo led, battery controls).
> >
> > As it will be beneficial from a complexity perspective
> > to retain this driver as a single unit, move it out
> > of hwmon, and into platform/x86.
> >
> > While at it, add myself to the maintainer's file.
> >
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  Documentation/hwmon/index.rst                         |  2 +-
> >  Documentation/hwmon/{oxp-sensors.rst =3D> oxpec.rst}    |  0
> >  MAINTAINERS                                           |  7 ++++---
> >  drivers/hwmon/Kconfig                                 | 11 -----------
> >  drivers/hwmon/Makefile                                |  1 -
> >  drivers/platform/x86/Kconfig                          | 11 +++++++++++
> >  drivers/platform/x86/Makefile                         |  3 +++
> >  drivers/{hwmon/oxp-sensors.c =3D> platform/x86/oxpec.c} | 10 ++++-----=
-
> >  8 files changed, 23 insertions(+), 22 deletions(-)
> >  rename Documentation/hwmon/{oxp-sensors.rst =3D> oxpec.rst} (100%)
>
> IMO this should also be moved, it doesn't really make sense that hwmon
> would continue to carry the docs after the move. Platform/x86 doesn't
> seem to have a home in Documentation, perhaps misc-devices? Armin or
> Ilpo may have some thoughts here.

I looked at similar drivers and I think asus-wmi was the same FYI. The
sensors for it reside in hwmon.

> >  rename drivers/{hwmon/oxp-sensors.c =3D> platform/x86/oxpec.c} (98%)
> >
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.=
rst
> > index 874f8fd26325..dd7a54d5f281 100644
> > --- a/Documentation/hwmon/index.rst
> > +++ b/Documentation/hwmon/index.rst
> > @@ -186,7 +186,7 @@ Hardware Monitoring Kernel Drivers
> >     nzxt-kraken3
> >     nzxt-smart2
> >     occ
> > -   oxp-sensors
> > +   oxpec
> >     pc87360
> >     pc87427
> >     pcf8591
> > diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/=
oxpec.rst
> > similarity index 100%
> > rename from Documentation/hwmon/oxp-sensors.rst
> > rename to Documentation/hwmon/oxpec.rst
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0248c9eb39d6..a11d346a458b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17641,12 +17641,13 @@ S:    Maintained
> >  F:     drivers/mtd/nand/onenand/
> >  F:     include/linux/mtd/onenand*.h
> >
> > -ONEXPLAYER FAN DRIVER
> > +ONEXPLAYER PLATFORM EC DRIVER
> > +M:     Antheas Kapenekakis <lkml@antheas.dev>
> >  M:     Derek John Clark <derekjohn.clark@gmail.com>
> >  M:     Joaqu=C3=ADn Ignacio Aramend=C3=ADa <samsagax@gmail.com>
> > -L:     linux-hwmon@vger.kernel.org
> > +L:     platform-driver-x86@vger.kernel.org
> >  S:     Maintained
> > -F:     drivers/hwmon/oxp-sensors.c
> > +F:     drivers/platform/x86/oxpec.c
> >
> >  ONIE TLV NVMEM LAYOUT DRIVER
> >  M:     Miquel Raynal <miquel.raynal@bootlin.com>
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 4cbaba15d86e..09f7aed96d15 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1774,17 +1774,6 @@ config SENSORS_NZXT_SMART2
> >
> >  source "drivers/hwmon/occ/Kconfig"
> >
> > -config SENSORS_OXP
> > -       tristate "OneXPlayer EC fan control"
> > -       depends on ACPI_EC
> > -       depends on X86
> > -       help
> > -               If you say yes here you get support for fan readings an=
d control over
> > -               OneXPlayer handheld devices. Only OneXPlayer mini AMD h=
andheld variant
> > -               boards are supported.
> > -
> > -               Can also be built as a module. In that case it will be =
called oxp-sensors.
> > -
> >  config SENSORS_PCF8591
> >         tristate "Philips PCF8591 ADC/DAC"
> >         depends on I2C
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index b7ef0f0562d3..0edb08824b17 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -181,7 +181,6 @@ obj-$(CONFIG_SENSORS_NTC_THERMISTOR)        +=3D nt=
c_thermistor.o
> >  obj-$(CONFIG_SENSORS_NZXT_KRAKEN2) +=3D nzxt-kraken2.o
> >  obj-$(CONFIG_SENSORS_NZXT_KRAKEN3) +=3D nzxt-kraken3.o
> >  obj-$(CONFIG_SENSORS_NZXT_SMART2) +=3D nzxt-smart2.o
> > -obj-$(CONFIG_SENSORS_OXP) +=3D oxp-sensors.o
> >  obj-$(CONFIG_SENSORS_PC87360)  +=3D pc87360.o
> >  obj-$(CONFIG_SENSORS_PC87427)  +=3D pc87427.o
> >  obj-$(CONFIG_SENSORS_PCF8591)  +=3D pcf8591.o
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
> > index 0258dd879d64..4531b20c6b30 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1186,6 +1186,17 @@ config SEL3350_PLATFORM
> >           To compile this driver as a module, choose M here: the module
> >           will be called sel3350-platform.
> >
> > +config OXP_EC
> > +       tristate "OneXPlayer EC platform control"
> > +       depends on ACPI_EC
> > +       depends on X86
> > +       help
> > +               Enables support for the platform EC of OneXPlayer and A=
OKZOE
> > +               handheld devices. This includes fan speed, fan controls=
, and
> > +               disabling the default TDP behavior of the device. Due t=
o legacy
> > +               reasons, this driver also provides hwmon functionality =
to Ayaneo
> > +               devices and the OrangePi Neo.
> > +
>
> I don't think it is necessary to indicate future plans in config
> options or documentation. It should just reflect the current state of
> the kernel at the time of the patch. Whenever I get to submitting
> ayaneo-platform I'll remove the necessary notes from Kconfigs, Docs,
> etc.

Most of the functionality of this driver does not apply to Ayaneo
anymore though. I think it is good Ayaneo got mainline support for fan
curves by re-using the existing oxp-sensors hwmon driver, but in this
case we are converting it to the OneXPlayer platform driver now, so
the documentation should reflect that?

> >  endif # X86_PLATFORM_DEVICES
> >
> >  config P2SB
> > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makef=
ile
> > index e1b142947067..f64a191c1162 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)             +=3D wi=
nmate-fm07-keys.o
> >
> >  # SEL
> >  obj-$(CONFIG_SEL3350_PLATFORM)         +=3D sel3350-platform.o
> > +
> > +# OneXPlayer
> > +obj-$(CONFIG_OXP_EC)           +=3D oxpec.o
> > \ No newline at end of file
> > diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/platform/x86/oxpec.c
> > similarity index 98%
> > rename from drivers/hwmon/oxp-sensors.c
> > rename to drivers/platform/x86/oxpec.c
> > index f7a64fbc8f33..dc3a0871809c 100644
> > --- a/drivers/hwmon/oxp-sensors.c
> > +++ b/drivers/platform/x86/oxpec.c
> > @@ -1,11 +1,8 @@
> >  // SPDX-License-Identifier: GPL-2.0+
> >  /*
> > - * Platform driver for OneXPlayer, AOKZOE, AYANEO, and OrangePi Handhe=
lds
> > - * that expose fan reading and control via hwmon sysfs.
> > - *
> > - * Old OXP boards have the same DMI strings and they are told apart by
> > - * the boot cpu vendor (Intel/AMD). Of these older models only AMD is
> > - * supported.
> > + * Platform driver for OneXPlayer and AOKZOE devices. For the time bei=
ng,
> > + * it also exposes fan controls for AYANEO, and OrangePi Handhelds via
> > + * hwmon sysfs.
> >   *
>
> Same as above.
>
> Cheers,
> - Derek
>
> >   * Fan control is provided via pwm interface in the range [0-255].
> >   * Old AMD boards use [0-100] as range in the EC, the written value is
> > @@ -16,6 +13,7 @@
> >   *
> >   * Copyright (C) 2022 Joaqu=C3=ADn I. Aramend=C3=ADa <samsagax@gmail.c=
om>
> >   * Copyright (C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
> > + * Copyright (C) 2025 Antheas Kapenekakis <lkml@antheas.dev>
> >   */
> >
> >  #include <linux/acpi.h>
> > --
> > 2.48.1
> >

