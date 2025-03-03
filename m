Return-Path: <linux-pm+bounces-23329-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCF2A4CA71
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 18:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79CB17AD8B
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 17:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F53215047;
	Mon,  3 Mar 2025 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="fR8mhTEJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A1C210F6A;
	Mon,  3 Mar 2025 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024099; cv=none; b=LmDh5fZmj9FHJMqxVbaTHOtfyT8Kd2GmQ/ZS/g2i+MLtdokzB+G5YLWEMdQAV8XPiwoiHXL9g/FdRy8OJ5WhTKzDiOBD3RBwvFMh+oRfaSCqeOrcdrXgGXDQZCoiZWayWCoRl+MX2aIoMzCjhN36bcHi/O2QduixrBbEj0/kvrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024099; c=relaxed/simple;
	bh=iDMN4rrBceUEYXqlkKTP4RY49CeemCXZbPGm+CzxaSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NaksiK/J6ArPQlLJB2XStAt2ok+FaxGWMwaV8fqPgX29yBqVj2MZfdzqAniiTW5LLZvJHtf983R0DXdwDpsxHXP3q4xV3joX72xevAGmaKrB5NjQ4WHbYeT2luuyMQHmnmyFm6am1YHxa+m9UhDkTahEtV3FHnZfElDECeKmlpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=fR8mhTEJ; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 484E02E0952E;
	Mon,  3 Mar 2025 19:48:03 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741024084;
	bh=29fX2dP5gBQuuI6ufZPXDnCycOG07kD+08hvoj337p4=;
	h=Received:From:Subject:To;
	b=fR8mhTEJ6cBhcdQeftnjbNiSpG07xQHt3xIapaRQECpvYjSYUdzYaji6ufkuWnI+h
	 +KoI1D1vUcFzghM7xEMHtJHRAUs+eJFgFRCnWvmoX4DdIRWJRE6j11p/Zj1jrLwWaS
	 +rs1vE1MTMgu+0mNZMqGHhIG7h3MvGgWdjbd3uWc=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.177) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f177.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-30bc9cbeac1so1480741fa.1;
        Mon, 03 Mar 2025 09:48:03 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVT89V0eMzLC0NR94JU9AdgNagAFosIQxz3qO0V7EeFrv0ljcJZMgJzCiq115Gs4qIhM17V+omDEOU=@vger.kernel.org,
 AJvYcCWVYsDBK08u5jSPSIZZ+fPgI2nLaHF1DycEowMstOnfWPQA6D1MUH2KhS9Y/r+nUjB5tLnR4lKZZ9oZM/MUxsXMMpACLg==@vger.kernel.org,
 AJvYcCWvdkljjQL95mQ1Mpr1QikB1ruTAsGIie6boc9JBVoJRx84k9NALYPrvyQnoRz+UMY6fd4tWb/yVgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyteMHbfGC3a//fz+QlnmY7Eglx0I9DTgYkS4RpBy+MDrzthaIb
	+vrOAuKiRKJAOr5jkei3zibxjW+3fBspKRp03zP+6qprbDGbuuJICDHaQL6GseUeHa2hTcjMhc/
	rb9BuT9dN13tj3t+twAMLGYoqCNM=
X-Google-Smtp-Source: 
 AGHT+IEZEd9zw1ttDmxZ7tcaRJ6KjJ2VuZRiCWUComhsmMB2kRXdYkwpwtfBc5qySPSoZvYKZvK9dueQ1j0YUkUQkKY=
X-Received: by 2002:a2e:a9a8:0:b0:30b:c980:c5a7 with SMTP id
 38308e7fff4ca-30bc980c98emr3691621fa.5.1741024082394; Mon, 03 Mar 2025
 09:48:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222161824.172511-1-lkml@antheas.dev>
 <20250222161824.172511-12-lkml@antheas.dev>
 <3781a4b0-e9e0-42cb-9393-570b3c8a6305@roeck-us.net>
In-Reply-To: <3781a4b0-e9e0-42cb-9393-570b3c8a6305@roeck-us.net>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 3 Mar 2025 18:47:51 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwE8h86y6PDu+0zuhx-9XU2sA_K7RicH_G_aSOKU15M5vg@mail.gmail.com>
X-Gm-Features: AQ5f1JojJsMNbYUm1sGa4LSU4e_So2GINpqdhHw_rI5pCjq56XSG2fnym_6Ppw4
Message-ID: 
 <CAGwozwE8h86y6PDu+0zuhx-9XU2sA_K7RicH_G_aSOKU15M5vg@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] platform/x86: oxpec: Move hwmon/oxp-sensors to
 platform/x86
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>, Eileen <eileen@one-netbook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <174102408408.24288.13177874548149470812@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Mon, 3 Mar 2025 at 15:07, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 2/22/25 08:18, Antheas Kapenekakis wrote:
> > Once upon a time, the platform EC of handheld devices only
> > controlled the fan. This is no longer the case, with the
> > EC of OneXPlayer gaining additional functionality.
> >
> > As it will be beneficial from a complexity perspective
> > to retain this driver as a single unit, move it out
> > of hwmon, and into platform/x86.
> >
> > While at it, add myself to the maintainer's file.
> >
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
>
> This should really have been the first patch of the series.
>
> Guenter

You are right, I will try to for the V3. Hopefully its not too hairy
to rebase the patches.

I will still keep the device additions first so they are possible to
cherry pick to lts kernels.

> > ---
> >   Documentation/hwmon/index.rst                         |  2 +-
> >   Documentation/hwmon/{oxp-sensors.rst =3D> oxpec.rst}    |  0
> >   MAINTAINERS                                           |  7 ++++---
> >   drivers/hwmon/Kconfig                                 | 11 ----------=
-
> >   drivers/hwmon/Makefile                                |  1 -
> >   drivers/platform/x86/Kconfig                          | 11 ++++++++++=
+
> >   drivers/platform/x86/Makefile                         |  3 +++
> >   drivers/{hwmon/oxp-sensors.c =3D> platform/x86/oxpec.c} | 10 ++++----=
--
> >   8 files changed, 23 insertions(+), 22 deletions(-)
> >   rename Documentation/hwmon/{oxp-sensors.rst =3D> oxpec.rst} (100%)
> >   rename drivers/{hwmon/oxp-sensors.c =3D> platform/x86/oxpec.c} (98%)
> >
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.=
rst
> > index 874f8fd26325..dd7a54d5f281 100644
> > --- a/Documentation/hwmon/index.rst
> > +++ b/Documentation/hwmon/index.rst
> > @@ -186,7 +186,7 @@ Hardware Monitoring Kernel Drivers
> >      nzxt-kraken3
> >      nzxt-smart2
> >      occ
> > -   oxp-sensors
> > +   oxpec
> >      pc87360
> >      pc87427
> >      pcf8591
> > diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/=
oxpec.rst
> > similarity index 100%
> > rename from Documentation/hwmon/oxp-sensors.rst
> > rename to Documentation/hwmon/oxpec.rst
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a5e49d57c589..35db92380f99 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17629,12 +17629,13 @@ S:  Maintained
> >   F:  drivers/mtd/nand/onenand/
> >   F:  include/linux/mtd/onenand*.h
> >
> > -ONEXPLAYER FAN DRIVER
> > +ONEXPLAYER PLATFORM EC DRIVER
> > +M:   Antheas Kapenekakis <lkml@antheas.dev>
> >   M:  Derek John Clark <derekjohn.clark@gmail.com>
> >   M:  Joaqu=C3=ADn Ignacio Aramend=C3=ADa <samsagax@gmail.com>
> > -L:   linux-hwmon@vger.kernel.org
> > +L:   platform-driver-x86@vger.kernel.org
> >   S:  Maintained
> > -F:   drivers/hwmon/oxp-sensors.c
> > +F:   drivers/platform/x86/oxpec.c
> >
> >   ONIE TLV NVMEM LAYOUT DRIVER
> >   M:  Miquel Raynal <miquel.raynal@bootlin.com>
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 4cbaba15d86e..09f7aed96d15 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1774,17 +1774,6 @@ config SENSORS_NZXT_SMART2
> >
> >   source "drivers/hwmon/occ/Kconfig"
> >
> > -config SENSORS_OXP
> > -     tristate "OneXPlayer EC fan control"
> > -     depends on ACPI_EC
> > -     depends on X86
> > -     help
> > -             If you say yes here you get support for fan readings and =
control over
> > -             OneXPlayer handheld devices. Only OneXPlayer mini AMD han=
dheld variant
> > -             boards are supported.
> > -
> > -             Can also be built as a module. In that case it will be ca=
lled oxp-sensors.
> > -
> >   config SENSORS_PCF8591
> >       tristate "Philips PCF8591 ADC/DAC"
> >       depends on I2C
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index b7ef0f0562d3..0edb08824b17 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -181,7 +181,6 @@ obj-$(CONFIG_SENSORS_NTC_THERMISTOR)      +=3D ntc_=
thermistor.o
> >   obj-$(CONFIG_SENSORS_NZXT_KRAKEN2) +=3D nzxt-kraken2.o
> >   obj-$(CONFIG_SENSORS_NZXT_KRAKEN3) +=3D nzxt-kraken3.o
> >   obj-$(CONFIG_SENSORS_NZXT_SMART2) +=3D nzxt-smart2.o
> > -obj-$(CONFIG_SENSORS_OXP) +=3D oxp-sensors.o
> >   obj-$(CONFIG_SENSORS_PC87360)       +=3D pc87360.o
> >   obj-$(CONFIG_SENSORS_PC87427)       +=3D pc87427.o
> >   obj-$(CONFIG_SENSORS_PCF8591)       +=3D pcf8591.o
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
> > index 0258dd879d64..4531b20c6b30 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1186,6 +1186,17 @@ config SEL3350_PLATFORM
> >         To compile this driver as a module, choose M here: the module
> >         will be called sel3350-platform.
> >
> > +config OXP_EC
> > +     tristate "OneXPlayer EC platform control"
> > +     depends on ACPI_EC
> > +     depends on X86
> > +     help
> > +             Enables support for the platform EC of OneXPlayer and AOK=
ZOE
> > +             handheld devices. This includes fan speed, fan controls, =
and
> > +             disabling the default TDP behavior of the device. Due to =
legacy
> > +             reasons, this driver also provides hwmon functionality to=
 Ayaneo
> > +             devices and the OrangePi Neo.
> > +
> >   endif # X86_PLATFORM_DEVICES
> >
> >   config P2SB
> > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makef=
ile
> > index e1b142947067..f64a191c1162 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)           +=3D winm=
ate-fm07-keys.o
> >
> >   # SEL
> >   obj-$(CONFIG_SEL3350_PLATFORM)              +=3D sel3350-platform.o
> > +
> > +# OneXPlayer
> > +obj-$(CONFIG_OXP_EC)         +=3D oxpec.o
> > \ No newline at end of file
> > diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/platform/x86/oxpec.c
> > similarity index 98%
> > rename from drivers/hwmon/oxp-sensors.c
> > rename to drivers/platform/x86/oxpec.c
> > index b5ba863a762a..51845aae8a44 100644
> > --- a/drivers/hwmon/oxp-sensors.c
> > +++ b/drivers/platform/x86/oxpec.c
> > @@ -1,11 +1,8 @@
> >   // SPDX-License-Identifier: GPL-2.0+
> >   /*
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
> >    *
> >    * Fan control is provided via pwm interface in the range [0-255].
> >    * Old AMD boards use [0-100] as range in the EC, the written value i=
s
> > @@ -16,6 +13,7 @@
> >    *
> >    * Copyright (C) 2022 Joaqu=C3=ADn I. Aramend=C3=ADa <samsagax@gmail.=
com>
> >    * Copyright (C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
> > + * Copyright (C) 2025 Antheas Kapenekakis <lkml@antheas.dev>
> >    */
> >
> >   #include <linux/acpi.h>
>

