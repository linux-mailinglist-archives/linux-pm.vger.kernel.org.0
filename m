Return-Path: <linux-pm+bounces-25271-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA79A861DF
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 17:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0853019E59AB
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 15:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D874E20F07D;
	Fri, 11 Apr 2025 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DrCL/UZQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C553D1F2367;
	Fri, 11 Apr 2025 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744385293; cv=none; b=eWRhyki8LqwXp+BA/PU6KH3mwudMRwj478LGKBeGLqnKf+LohefFPwaf3W+01p7Jz2R6/j36kODqgEb/o4cLMFevKM9lh9b8rIDwdYBmdxwDBygechuzs6ZfJ5Isht43NETWnKjgFPcVwxSPQXv02dP+tBPyHXPnWEs1QnpyJl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744385293; c=relaxed/simple;
	bh=T7xm717FR4FZlyDtkccmIZOXFnmplEZxWSfvst2FJkY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CQQb97JEfzBxifQR8ELAKIZ2YNMVJGWhx5+4Eohrg45Oc7XR5huyok0H0rOxKKPE8PBcfOlbMgUwoG+fl/fLp+fqQ64lA18yuri9eVIj8lKd0ExLFnRA8PT39CjnqvoIrdeS4VY5X1gLc6kTxjPvKQEi4Nuew7QRlqrg6IBp25k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DrCL/UZQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744385292; x=1775921292;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=T7xm717FR4FZlyDtkccmIZOXFnmplEZxWSfvst2FJkY=;
  b=DrCL/UZQjgS6+Y++T8hqJ6kOzbeSfMscFko/aVLXmEgKk1yCSLZAN7Ir
   trADMEj/FR85RQodCuwpDhMw2pnDEZbiKYaG0IrXM6ZLn+9L8KB9Ayaic
   woj7YXC7QO/7tHKHGNseLrqxlJrLqtsAe2MTJuUb2ogX+ruaQYBwxu/Pi
   5xR08qac61uUFZ3t0KE9zlwSlnLzpqbF00dopv0S1gUMcAPuRPRH4yKJS
   VpAhRmWGscJnLqo/chlFQu1p4YlieWiYEdjrJDildCGwCibbs8a0wETGi
   bEvtdHmvu0qrqaYLBbFtF3tGldSa7UdWjjnxCEgjw0cKfazV5oF1eLR8S
   A==;
X-CSE-ConnectionGUID: uSrTqHY2QGu1iUpT5aSYIQ==
X-CSE-MsgGUID: MQ0WExfGSDqPFgmSi4Hg6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="48648229"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="48648229"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:28:11 -0700
X-CSE-ConnectionGUID: 60GtIHxUTzKpO6MvdOWqbw==
X-CSE-MsgGUID: 74y+/sBFR+2wSqsYMIkekQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="129204130"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.51])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 08:28:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 11 Apr 2025 18:28:01 +0300 (EEST)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
    linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
    Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, 
    Jonathan Corbet <corbet@lwn.net>, 
    Joaquin Ignacio Aramendia <samsagax@gmail.com>, 
    Derek J Clark <derekjohn.clark@gmail.com>, 
    Kevin Greenberg <kdgreenberg234@protonmail.com>, 
    Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>, 
    Eileen <eileen@one-netbook.com>, LKML <linux-kernel@vger.kernel.org>, 
    sre@kernel.org, linux@weissschuh.net, Hans de Goede <hdegoede@redhat.com>, 
    mario.limonciello@amd.com
Subject: Re: [PATCH v8 03/14] platform/x86: oxpec: Move hwmon/oxp-sensors to
 platform/x86
In-Reply-To: <20250322103606.680401-4-lkml@antheas.dev>
Message-ID: <0b0605c8-9409-6000-2d66-005915448726@linux.intel.com>
References: <20250322103606.680401-1-lkml@antheas.dev> <20250322103606.680401-4-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2100229752-1744385281=:944"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2100229752-1744385281=:944
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 22 Mar 2025, Antheas Kapenekakis wrote:

> The EC of OneXPlayer devices used to only control the fan.
> This is no longer the case, with the EC of OneXPlayer gaining
> additional functionality (turbo button, turbo led, battery controls).
>=20
> As it will be beneficial from a complexity perspective
> to retain this driver as a single unit, move it out
> of hwmon, and into platform/x86. Also, remove the
> hwmon documentation to avoid it becoming stale.

Perhaps mention that the sysfs interface will be documented into=20
Documentation/ABI/ as it sound bit harsh to just remove documentation=20
because it could become stale :-) ?

>=20
> While at it, add myself to the maintainer's file.
>=20
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  Documentation/hwmon/index.rst                 |  2 +-
>  Documentation/hwmon/oxp-sensors.rst           | 89 -------------------
>  MAINTAINERS                                   |  7 +-
>  drivers/hwmon/Kconfig                         | 11 ---
>  drivers/hwmon/Makefile                        |  1 -
>  drivers/platform/x86/Kconfig                  | 12 +++
>  drivers/platform/x86/Makefile                 |  3 +
>  .../oxp-sensors.c =3D> platform/x86/oxpec.c}    | 10 +--
>  8 files changed, 24 insertions(+), 111 deletions(-)
>  delete mode 100644 Documentation/hwmon/oxp-sensors.rst
>  rename drivers/{hwmon/oxp-sensors.c =3D> platform/x86/oxpec.c} (98%)
>=20
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rs=
t
> index 874f8fd263252..dd7a54d5f2816 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -186,7 +186,7 @@ Hardware Monitoring Kernel Drivers
>     nzxt-kraken3
>     nzxt-smart2
>     occ
> -   oxp-sensors
> +   oxpec
>     pc87360
>     pc87427
>     pcf8591
> diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/ox=
p-sensors.rst
> deleted file mode 100644
> index 581c4dafbfa13..0000000000000
> --- a/Documentation/hwmon/oxp-sensors.rst
> +++ /dev/null
> @@ -1,89 +0,0 @@
> -.. SPDX-License-Identifier: GPL-2.0-or-later
> -
> -Kernel driver oxp-sensors
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> -
> -Authors:
> -    - Derek John Clark <derekjohn.clark@gmail.com>
> -    - Joaqu=C3=ADn Ignacio Aramend=C3=ADa <samsagax@gmail.com>
> -
> -Description:
> -------------
> -
> -Handheld devices from OneNetbook, AOKZOE, AYANEO, And OrangePi provide f=
an
> -readings and fan control through their embedded controllers.
> -
> -Currently supports OneXPlayer devices, AOKZOE, AYANEO, and OrangePi
> -handheld devices. AYANEO devices preceding the AIR and OneXPlayer device=
s
> -preceding the Mini A07 are not supportable as the EC model is different
> -and do not have manual control capabilities.
> -
> -Some OneXPlayer and AOKZOE models have a toggle for changing the behavio=
ur
> -of the "Turbo/Silent" button of the device. It will change the key event
> -that it triggers with a flip of the `tt_toggle` attribute. See below for
> -boards that support this function.
> -
> -Supported devices
> ------------------
> -
> -Currently the driver supports the following handhelds:
> -
> - - AOKZOE A1
> - - AOKZOE A1 PRO
> - - AYANEO 2
> - - AYANEO 2S
> - - AYANEO AIR
> - - AYANEO AIR 1S
> - - AYANEO AIR Plus (Mendocino)
> - - AYANEO AIR Pro
> - - AYANEO Flip DS
> - - AYANEO Flip KB
> - - AYANEO Geek
> - - AYANEO Geek 1S
> - - AYANEO KUN
> - - OneXPlayer 2
> - - OneXPlayer 2 Pro
> - - OneXPlayer AMD
> - - OneXPlayer mini AMD
> - - OneXPlayer mini AMD PRO
> - - OneXPlayer OneXFly
> - - OneXPlayer X1 A
> - - OneXPlayer X1 i
> - - OneXPlayer X1 mini
> - - OrangePi NEO-01
> -
> -"Turbo/Silent" button behaviour toggle is only supported on:
> - - AOK ZOE A1
> - - AOK ZOE A1 PRO
> - - OneXPlayer 2
> - - OneXPlayer 2 Pro
> - - OneXPlayer mini AMD (only with updated alpha BIOS)
> - - OneXPlayer mini AMD PRO
> - - OneXPlayer OneXFly
> - - OneXPlayer X1 A
> - - OneXPlayer X1 i
> - - OneXPlayer X1 mini
> -
> -Sysfs entries
> --------------
> -
> -The following attributes are supported:
> -
> -fan1_input
> -  Read Only. Reads current fan RPM.
> -
> -pwm1_enable
> -  Read Write. Enable manual fan control. Write "1" to set to manual, wri=
te "0"
> -  to let the EC control de fan speed. Read this attribute to see current=
 status.
> -
> -pwm1
> -  Read Write. Read this attribute to see current duty cycle in the range=
 [0-255].
> -  When pwm1_enable is set to "1" (manual) write any value in the range [=
0-255]
> -  to set fan speed.
> -
> -tt_toggle
> -  Read Write. Read this attribute to check the status of the turbo/silen=
t
> -  button behaviour function. Write "1" to activate the switch and "0" to
> -  deactivate it. The specific keycodes and behaviour is specific to the =
device
> -  both with this function on and off. This attribute is attached to the =
platform
> -  driver and not to the hwmon driver (/sys/devices/platform/oxp-platform=
/tt_toggle)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c9763412a5089..20720f92e4a63 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17656,12 +17656,13 @@ S:=09Maintained
>  F:=09drivers/mtd/nand/onenand/
>  F:=09include/linux/mtd/onenand*.h
> =20
> -ONEXPLAYER FAN DRIVER
> +ONEXPLAYER PLATFORM EC DRIVER
> +M:=09Antheas Kapenekakis <lkml@antheas.dev>
>  M:=09Derek John Clark <derekjohn.clark@gmail.com>
>  M:=09Joaqu=C3=ADn Ignacio Aramend=C3=ADa <samsagax@gmail.com>
> -L:=09linux-hwmon@vger.kernel.org
> +L:=09platform-driver-x86@vger.kernel.org
>  S:=09Maintained
> -F:=09drivers/hwmon/oxp-sensors.c
> +F:=09drivers/platform/x86/oxpec.c
> =20
>  ONIE TLV NVMEM LAYOUT DRIVER
>  M:=09Miquel Raynal <miquel.raynal@bootlin.com>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 4cbaba15d86ef..09f7aed96d15e 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1774,17 +1774,6 @@ config SENSORS_NZXT_SMART2
> =20
>  source "drivers/hwmon/occ/Kconfig"
> =20
> -config SENSORS_OXP
> -=09tristate "OneXPlayer EC fan control"
> -=09depends on ACPI_EC
> -=09depends on X86
> -=09help
> -=09=09If you say yes here you get support for fan readings and control o=
ver
> -=09=09OneXPlayer handheld devices. Only OneXPlayer mini AMD handheld var=
iant
> -=09=09boards are supported.
> -
> -=09=09Can also be built as a module. In that case it will be called oxp-=
sensors.
> -
>  config SENSORS_PCF8591
>  =09tristate "Philips PCF8591 ADC/DAC"
>  =09depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index b7ef0f0562d37..0edb08824b178 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -181,7 +181,6 @@ obj-$(CONFIG_SENSORS_NTC_THERMISTOR)=09+=3D ntc_therm=
istor.o
>  obj-$(CONFIG_SENSORS_NZXT_KRAKEN2) +=3D nzxt-kraken2.o
>  obj-$(CONFIG_SENSORS_NZXT_KRAKEN3) +=3D nzxt-kraken3.o
>  obj-$(CONFIG_SENSORS_NZXT_SMART2) +=3D nzxt-smart2.o
> -obj-$(CONFIG_SENSORS_OXP) +=3D oxp-sensors.o
>  obj-$(CONFIG_SENSORS_PC87360)=09+=3D pc87360.o
>  obj-$(CONFIG_SENSORS_PC87427)=09+=3D pc87427.o
>  obj-$(CONFIG_SENSORS_PCF8591)=09+=3D pcf8591.o
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0258dd879d64b..82cfc76bc5c9f 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1186,6 +1186,18 @@ config SEL3350_PLATFORM
>  =09  To compile this driver as a module, choose M here: the module
>  =09  will be called sel3350-platform.
> =20
> +config OXP_EC
> +=09tristate "OneXPlayer EC platform control"
> +=09depends on ACPI_EC
> +=09depends on HWMON
> +=09depends on X86
> +=09help
> +=09=09Enables support for the platform EC of OneXPlayer and AOKZOE
> +=09=09handheld devices. This includes fan speed, fan controls, and
> +=09=09disabling the default TDP behavior of the device. Due to legacy
> +=09=09reasons, this driver also provides hwmon functionality to Ayaneo
> +=09=09devices and the OrangePi Neo.
> +
>  endif # X86_PLATFORM_DEVICES
> =20
>  config P2SB
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
> index e1b1429470674..f64a191c1162e 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)=09=09+=3D winmate-fm0=
7-keys.o
> =20
>  # SEL
>  obj-$(CONFIG_SEL3350_PLATFORM)=09=09+=3D sel3350-platform.o
> +
> +# OneXPlayer
> +obj-$(CONFIG_OXP_EC)=09=09+=3D oxpec.o
> \ No newline at end of file

Please fix the newline.

> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/platform/x86/oxpec.c
> similarity index 98%
> rename from drivers/hwmon/oxp-sensors.c
> rename to drivers/platform/x86/oxpec.c
> index f7a64fbc8f33e..dc3a0871809cd 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -1,11 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Platform driver for OneXPlayer, AOKZOE, AYANEO, and OrangePi Handheld=
s
> - * that expose fan reading and control via hwmon sysfs.
> - *
> - * Old OXP boards have the same DMI strings and they are told apart by
> - * the boot cpu vendor (Intel/AMD). Of these older models only AMD is
> - * supported.
> + * Platform driver for OneXPlayer and AOKZOE devices. For the time being=
,
> + * it also exposes fan controls for AYANEO, and OrangePi Handhelds via
> + * hwmon sysfs.
>   *
>   * Fan control is provided via pwm interface in the range [0-255].
>   * Old AMD boards use [0-100] as range in the EC, the written value is
> @@ -16,6 +13,7 @@
>   *
>   * Copyright (C) 2022 Joaqu=C3=ADn I. Aramend=C3=ADa <samsagax@gmail.com=
>
>   * Copyright (C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
> + * Copyright (C) 2025 Antheas Kapenekakis <lkml@antheas.dev>
>   */
> =20
>  #include <linux/acpi.h>
>=20

--=20
 i.

--8323328-2100229752-1744385281=:944--

