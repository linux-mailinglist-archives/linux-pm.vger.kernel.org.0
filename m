Return-Path: <linux-pm+bounces-25309-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52732A86BC1
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 10:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D045F8C4A81
	for <lists+linux-pm@lfdr.de>; Sat, 12 Apr 2025 08:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4053B199E88;
	Sat, 12 Apr 2025 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="21DygarQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CC72367A0;
	Sat, 12 Apr 2025 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744445014; cv=none; b=WQq9CQ5lr/AkZUsl9uqkfQkLrD+CQ/cdAl1UGdQ1QkJolVAc9buzlBeqw0enmidWk41H65fCBniiSymnYp75sni17qk/JEPAfdK8H+7x47pN4F2uflKDJzTamBFZx9UQ2thEwjUIFHeCwl+GYjP4bxa4umu6krrtZScGZuWqtyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744445014; c=relaxed/simple;
	bh=5nBio8wlliBNQW4WQis/MiGyLIy7ogfaAOQ5SBiRDKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=novseRYvvCKr2ZE2xEyxWDIY8BEMxlNZKUr9Xezoexu8LiQMD9MeGAxX8bVIzHU0oP3xUnI1M3sKaGduSIxdehHu3qvtaL3ReMvh+5C6kozEeICLA/0p2zZSNqRgSdfHO2K2e4NGH0m4z6SU4P3+VRjcrpIMf/ziuCQFHE0knwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=21DygarQ; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id A51C12E08F07;
	Sat, 12 Apr 2025 11:03:27 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1744445008;
	bh=9eclBdoR1RHM4mapaVLRab+CXat6srIe/hVQa507uks=;
	h=Received:From:Subject:To;
	b=21DygarQspi7Jg8fzOiX5c87qBJgCqqyrT1GtFOpLEEOglt3ilpRboUE+pKIUhSMD
	 BPlEd5zYI9fEGJEM2d4oKLFJwUDn4FtAS5codlMJlpqrFq2TWVG1WKmfZCw8mkts0k
	 OtNkqUN+QchMAvzYHs4h6pCSr+2kqm2xy7Ka7Fxs=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.176) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f176.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-30db1bd3bddso25706581fa.3;
        Sat, 12 Apr 2025 01:03:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU/fdZELQrGgHIaW9mRpmSTaoOE/cfPtqXpJr0dcEX9YUezzVTlV6FEp2FiGd9cxTK45NO+nwYR32c=@vger.kernel.org,
 AJvYcCU4mUBe0kI12XRm8E9Ch/Qgg302j3H9LywM65jW0olEunzuwQm6cXZqB/3SqlVSWcT5HZcm3zfsB4Q=@vger.kernel.org,
 AJvYcCVXuxPTP/XMqXpyphDhyys/37kFRcqUDcHul0gJ3XEzMglb7Rhru8C8aA8o6NVDIWKuJzAGmSDM46saOsvB@vger.kernel.org,
 AJvYcCXqpNIrsKHJ7SkpMWWH3Iazb14lVG53r5WN47XvT/O9laWSY5q3cvbMZsy29eM/zGCIxUGCideb8j7IOU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfBFwhVkR6MgvJrKwkK0Wx6w8xpSA6uEzPTJNIu72hmNqdcdYV
	XiDebOSOhMW/wpu77uJhxd3UnTyCwje8lQirKLIEAIpctX4E/gbKvzvds/Bz+jmB0LrUdtT2zN8
	oJ0MuBs33fGZgK8D2Zx1fT/Iz0V4=
X-Google-Smtp-Source: 
 AGHT+IHBtkKRKPv1sQDr6Z4nwcIo3ya5BmR4dVQC2umc8i09gXAsq9hrRvnZJxEv1d3aMmXVHqORNMycwxGDoaPhZS8=
X-Received: by 2002:a05:651c:211f:b0:30c:dbf:519f with SMTP id
 38308e7fff4ca-31049a8131dmr15981651fa.35.1744445006650; Sat, 12 Apr 2025
 01:03:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322103606.680401-1-lkml@antheas.dev>
 <20250322103606.680401-4-lkml@antheas.dev>
 <0b0605c8-9409-6000-2d66-005915448726@linux.intel.com>
In-Reply-To: <0b0605c8-9409-6000-2d66-005915448726@linux.intel.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 12 Apr 2025 10:03:15 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHww+JaMWhos6pn_70LXYB9aAb+_+iqnKE8CEODDA01pA@mail.gmail.com>
X-Gm-Features: ATxdqUGMzObM-V5ysGFXmQX9-H3J-VZCrpiS_TvBUrRUKzUYHCfHCW8re_FZxTU
Message-ID: 
 <CAGwozwHww+JaMWhos6pn_70LXYB9aAb+_+iqnKE8CEODDA01pA@mail.gmail.com>
Subject: Re: [PATCH v8 03/14] platform/x86: oxpec: Move hwmon/oxp-sensors to
 platform/x86
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
 <174444500852.17833.10654244409224694558@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Fri, 11 Apr 2025 at 17:28, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Sat, 22 Mar 2025, Antheas Kapenekakis wrote:
>
> > The EC of OneXPlayer devices used to only control the fan.
> > This is no longer the case, with the EC of OneXPlayer gaining
> > additional functionality (turbo button, turbo led, battery controls).
> >
> > As it will be beneficial from a complexity perspective
> > to retain this driver as a single unit, move it out
> > of hwmon, and into platform/x86. Also, remove the
> > hwmon documentation to avoid it becoming stale.
>
> Perhaps mention that the sysfs interface will be documented into
> Documentation/ABI/ as it sound bit harsh to just remove documentation
> because it could become stale :-) ?

The reasoning here was more complex. It was boilerplate hwmon
documentation so if it stayed it would have stayed there. However,
there was a disagreement with how it should be reworded, so Guenter
suggested it be removed, since hwmon documentation for platform
drivers is optional.

Thanks for the review. I will try to get through the other emails the
next week and do a v9

Antheas

> >
> > While at it, add myself to the maintainer's file.
> >
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> > Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  Documentation/hwmon/index.rst                 |  2 +-
> >  Documentation/hwmon/oxp-sensors.rst           | 89 -------------------
> >  MAINTAINERS                                   |  7 +-
> >  drivers/hwmon/Kconfig                         | 11 ---
> >  drivers/hwmon/Makefile                        |  1 -
> >  drivers/platform/x86/Kconfig                  | 12 +++
> >  drivers/platform/x86/Makefile                 |  3 +
> >  .../oxp-sensors.c =3D> platform/x86/oxpec.c}    | 10 +--
> >  8 files changed, 24 insertions(+), 111 deletions(-)
> >  delete mode 100644 Documentation/hwmon/oxp-sensors.rst
> >  rename drivers/{hwmon/oxp-sensors.c =3D> platform/x86/oxpec.c} (98%)
> >
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.=
rst
> > index 874f8fd263252..dd7a54d5f2816 100644
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
oxp-sensors.rst
> > deleted file mode 100644
> > index 581c4dafbfa13..0000000000000
> > --- a/Documentation/hwmon/oxp-sensors.rst
> > +++ /dev/null
> > @@ -1,89 +0,0 @@
> > -.. SPDX-License-Identifier: GPL-2.0-or-later
> > -
> > -Kernel driver oxp-sensors
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > -
> > -Authors:
> > -    - Derek John Clark <derekjohn.clark@gmail.com>
> > -    - Joaqu=C3=ADn Ignacio Aramend=C3=ADa <samsagax@gmail.com>
> > -
> > -Description:
> > -------------
> > -
> > -Handheld devices from OneNetbook, AOKZOE, AYANEO, And OrangePi provide=
 fan
> > -readings and fan control through their embedded controllers.
> > -
> > -Currently supports OneXPlayer devices, AOKZOE, AYANEO, and OrangePi
> > -handheld devices. AYANEO devices preceding the AIR and OneXPlayer devi=
ces
> > -preceding the Mini A07 are not supportable as the EC model is differen=
t
> > -and do not have manual control capabilities.
> > -
> > -Some OneXPlayer and AOKZOE models have a toggle for changing the behav=
iour
> > -of the "Turbo/Silent" button of the device. It will change the key eve=
nt
> > -that it triggers with a flip of the `tt_toggle` attribute. See below f=
or
> > -boards that support this function.
> > -
> > -Supported devices
> > ------------------
> > -
> > -Currently the driver supports the following handhelds:
> > -
> > - - AOKZOE A1
> > - - AOKZOE A1 PRO
> > - - AYANEO 2
> > - - AYANEO 2S
> > - - AYANEO AIR
> > - - AYANEO AIR 1S
> > - - AYANEO AIR Plus (Mendocino)
> > - - AYANEO AIR Pro
> > - - AYANEO Flip DS
> > - - AYANEO Flip KB
> > - - AYANEO Geek
> > - - AYANEO Geek 1S
> > - - AYANEO KUN
> > - - OneXPlayer 2
> > - - OneXPlayer 2 Pro
> > - - OneXPlayer AMD
> > - - OneXPlayer mini AMD
> > - - OneXPlayer mini AMD PRO
> > - - OneXPlayer OneXFly
> > - - OneXPlayer X1 A
> > - - OneXPlayer X1 i
> > - - OneXPlayer X1 mini
> > - - OrangePi NEO-01
> > -
> > -"Turbo/Silent" button behaviour toggle is only supported on:
> > - - AOK ZOE A1
> > - - AOK ZOE A1 PRO
> > - - OneXPlayer 2
> > - - OneXPlayer 2 Pro
> > - - OneXPlayer mini AMD (only with updated alpha BIOS)
> > - - OneXPlayer mini AMD PRO
> > - - OneXPlayer OneXFly
> > - - OneXPlayer X1 A
> > - - OneXPlayer X1 i
> > - - OneXPlayer X1 mini
> > -
> > -Sysfs entries
> > --------------
> > -
> > -The following attributes are supported:
> > -
> > -fan1_input
> > -  Read Only. Reads current fan RPM.
> > -
> > -pwm1_enable
> > -  Read Write. Enable manual fan control. Write "1" to set to manual, w=
rite "0"
> > -  to let the EC control de fan speed. Read this attribute to see curre=
nt status.
> > -
> > -pwm1
> > -  Read Write. Read this attribute to see current duty cycle in the ran=
ge [0-255].
> > -  When pwm1_enable is set to "1" (manual) write any value in the range=
 [0-255]
> > -  to set fan speed.
> > -
> > -tt_toggle
> > -  Read Write. Read this attribute to check the status of the turbo/sil=
ent
> > -  button behaviour function. Write "1" to activate the switch and "0" =
to
> > -  deactivate it. The specific keycodes and behaviour is specific to th=
e device
> > -  both with this function on and off. This attribute is attached to th=
e platform
> > -  driver and not to the hwmon driver (/sys/devices/platform/oxp-platfo=
rm/tt_toggle)
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c9763412a5089..20720f92e4a63 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17656,12 +17656,13 @@ S:  Maintained
> >  F:   drivers/mtd/nand/onenand/
> >  F:   include/linux/mtd/onenand*.h
> >
> > -ONEXPLAYER FAN DRIVER
> > +ONEXPLAYER PLATFORM EC DRIVER
> > +M:   Antheas Kapenekakis <lkml@antheas.dev>
> >  M:   Derek John Clark <derekjohn.clark@gmail.com>
> >  M:   Joaqu=C3=ADn Ignacio Aramend=C3=ADa <samsagax@gmail.com>
> > -L:   linux-hwmon@vger.kernel.org
> > +L:   platform-driver-x86@vger.kernel.org
> >  S:   Maintained
> > -F:   drivers/hwmon/oxp-sensors.c
> > +F:   drivers/platform/x86/oxpec.c
> >
> >  ONIE TLV NVMEM LAYOUT DRIVER
> >  M:   Miquel Raynal <miquel.raynal@bootlin.com>
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 4cbaba15d86ef..09f7aed96d15e 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1774,17 +1774,6 @@ config SENSORS_NZXT_SMART2
> >
> >  source "drivers/hwmon/occ/Kconfig"
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
> >  config SENSORS_PCF8591
> >       tristate "Philips PCF8591 ADC/DAC"
> >       depends on I2C
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index b7ef0f0562d37..0edb08824b178 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -181,7 +181,6 @@ obj-$(CONFIG_SENSORS_NTC_THERMISTOR)      +=3D ntc_=
thermistor.o
> >  obj-$(CONFIG_SENSORS_NZXT_KRAKEN2) +=3D nzxt-kraken2.o
> >  obj-$(CONFIG_SENSORS_NZXT_KRAKEN3) +=3D nzxt-kraken3.o
> >  obj-$(CONFIG_SENSORS_NZXT_SMART2) +=3D nzxt-smart2.o
> > -obj-$(CONFIG_SENSORS_OXP) +=3D oxp-sensors.o
> >  obj-$(CONFIG_SENSORS_PC87360)        +=3D pc87360.o
> >  obj-$(CONFIG_SENSORS_PC87427)        +=3D pc87427.o
> >  obj-$(CONFIG_SENSORS_PCF8591)        +=3D pcf8591.o
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
> > index 0258dd879d64b..82cfc76bc5c9f 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1186,6 +1186,18 @@ config SEL3350_PLATFORM
> >         To compile this driver as a module, choose M here: the module
> >         will be called sel3350-platform.
> >
> > +config OXP_EC
> > +     tristate "OneXPlayer EC platform control"
> > +     depends on ACPI_EC
> > +     depends on HWMON
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
> >  endif # X86_PLATFORM_DEVICES
> >
> >  config P2SB
> > diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makef=
ile
> > index e1b1429470674..f64a191c1162e 100644
> > --- a/drivers/platform/x86/Makefile
> > +++ b/drivers/platform/x86/Makefile
> > @@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)           +=3D winm=
ate-fm07-keys.o
> >
> >  # SEL
> >  obj-$(CONFIG_SEL3350_PLATFORM)               +=3D sel3350-platform.o
> > +
> > +# OneXPlayer
> > +obj-$(CONFIG_OXP_EC)         +=3D oxpec.o
> > \ No newline at end of file
>
> Please fix the newline.
>
> > diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/platform/x86/oxpec.c
> > similarity index 98%
> > rename from drivers/hwmon/oxp-sensors.c
> > rename to drivers/platform/x86/oxpec.c
> > index f7a64fbc8f33e..dc3a0871809cd 100644
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
> >
>
> --
>  i.

