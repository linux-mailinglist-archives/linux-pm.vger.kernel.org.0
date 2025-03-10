Return-Path: <linux-pm+bounces-23788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B45D8A5AC22
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 00:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D7B173BC5
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 23:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF031F0991;
	Mon, 10 Mar 2025 23:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URoApfNJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08D81DDA09;
	Mon, 10 Mar 2025 23:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741648680; cv=none; b=r/DE/lHgF+GHGh9RxDBV7mV83Ys9qfC7d0YKbZqUS7bTvdykY+UsZ0QUEKQRGTYQleHEm/NmajFdH+Adl3BG061Frc4LV6NZXXEVFvd4trwW7vCn4lq6/eotjutJm+etlEPN+qbCFSdpu/QVcvpl4+eW3aJzYqIP8otE/iRY0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741648680; c=relaxed/simple;
	bh=K+opj2WmllIZ3zYF7vRmhQnsO5I42FV4A7ebAvd0gRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qy8t3ijkUQDzUI3nEgLjgTquE1zk+/RiNSkmS+MmEccayR9sZm7LSBMravhmV+LTz41fmY5TrqNHojIrVadDwL7JwSXDeJsPg8VlZPB3fl3XSflekPcUJxc7+laKukaRfY14two8lot2ojUCIsF1y9vW9jUkJ8ZEfwJkk/LSOVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URoApfNJ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c556b7bb12so115517885a.0;
        Mon, 10 Mar 2025 16:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741648678; x=1742253478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kxAlH0RkdQmQhCbEiZXUV0WoFVDMK0yaoIjbU1xdUc=;
        b=URoApfNJ58URHP7XWkA+bc02oB/wXM00k0x9AXtWP4F8BliRRb8lZkML5dxUq8hMFO
         MG416/NeNMbvhE3fBfg2YoYNI8XWoVEEDK7hCL9plcXfQIQYIl7ICxeDOSCqPRmpuCbr
         EosMMsUrZiy4IlnZC11QVyVQUX1kCcpEfWeoIbFAnzNYkU4wAbcnWQk37aEH0qLbZT1e
         L3JUxGKBlZB054LQselUy/+XCykdQzwpAAs/ZEPPAlMRlek5FEIcRsZUrulPxqzIsJ2F
         DPRWmMcIjC9uB5Wv/B4KPhIbLYYXHUgwRW6CGwwvUgkwSLZFb//Ey/EK32vvXTQLz4dn
         lASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741648678; x=1742253478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kxAlH0RkdQmQhCbEiZXUV0WoFVDMK0yaoIjbU1xdUc=;
        b=iRit3/un1fi9EaSBlZHQczLDjtw4MA/CCaZ2vT3gYyU8RnRp/YQc17i4HmZdfNZP14
         co9/yZprJklPtmRVUISyfPShWv2bAFRGHzG73GosVHUW/3OCZJ65gJgJ3fDaebFcvbMA
         jlweBP6s7jnZ/22z/6yNiDrj5v+JrqaIz+pZdjBDsEOIsE9r6dxmhMDs1Z8Q9B1mcp5X
         tsRx6jh5aBzho0cAAIK8rMiuvXwIL6FbMmJfpG1zRyx2ZkX9FF7mK1C/TXTAs66E1TE5
         pHn75/zYzP/8hhNpdu41n53+RqPVh5DVWzWU+BS7FEJBPSdIP2+3gdXqvfz/CycUcYAZ
         RfqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6R/m6H54UhlXow87WS5j7Mv7yKr8uOd63rJL4UJvXAuRVWsYbKKPJgXKzchG8zyRrSIRHBeJFVIE=@vger.kernel.org, AJvYcCWIXmK69W0lY9dlqcVpkz7T8ctCJTdylrgYawvIC4rZ46VKLYv8q3FacIUbMcJDuA3VhSa5h0QzVb/03jE=@vger.kernel.org, AJvYcCXUh/vapyuvHq3HaddN9uC72Bcw3LU1FYFrjg+MSRyUfKIHDYr6wL7EpzSkmbKJIn1CI9zrgpCYZzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGw+1VFiNOv7MbiT2NPCC6uGtPPaz1xsx5+8Mw6oXoLGJbzJGG
	80WesowiRjQrGTqRNpJ4pcXvkH+d3a+coQL9M/+9pZfnN2eS/9UoCo2nVSjegXco0CLWLs244RU
	FKNzxGLkx/92JIcE5l4vM7NLxPOY=
X-Gm-Gg: ASbGncse/aHSGG7YfqMgBsArsNR8buhysX6MkyDaQQkwXNwtjQhCuOx495mbamB4Bld
	C6P/AYEmceOQTggaq35XZYz/tbYx5LoEj2s5z9ZHiQ7OQdy1JF0UtxM8oaJ5FlLbrK3Fiy63yTv
	y5OOOnu+GIppbH8Res7SBZAf9MPVg=
X-Google-Smtp-Source: AGHT+IEuLhLbfWpqKcUnhtiNjheXrWdUu2+AmcxQdyMsRlw9Zlp908S1cXyNG+szLfKpsDlu3otyPvi6RU20bBHbrmw=
X-Received: by 2002:a05:6214:da9:b0:6e8:ee44:ce9f with SMTP id
 6a1803df08f44-6e900604697mr251358806d6.20.1741648677701; Mon, 10 Mar 2025
 16:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309112114.1177361-1-lkml@antheas.dev> <20250309112114.1177361-4-lkml@antheas.dev>
In-Reply-To: <20250309112114.1177361-4-lkml@antheas.dev>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Mon, 10 Mar 2025 16:17:46 -0700
X-Gm-Features: AQ5f1JroAh30RFRqwBJMBODA64lcEg3QOB0t3UypnJGzrO41y8p_5rDEUkixGNA
Message-ID: <CAFqHKTn4hrKS0aiG1UNfZG5+mVcWEZw729pKv2YhXJtsFDCJEA@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] platform/x86: oxpec: Move hwmon/oxp-sensors to platform/x86
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
> The EC of OneXPlayer devices used to only control the fan.
> This is no longer the case, with the EC of OneXPlayer gaining
> additional functionality (turbo button, turbo led, battery controls).
>
> As it will be beneficial from a complexity perspective
> to retain this driver as a single unit, move it out
> of hwmon, and into platform/x86.
>
> While at it, add myself to the maintainer's file.
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  Documentation/hwmon/index.rst                         |  2 +-
>  Documentation/hwmon/{oxp-sensors.rst =3D> oxpec.rst}    |  0
>  MAINTAINERS                                           |  7 ++++---
>  drivers/hwmon/Kconfig                                 | 11 -----------
>  drivers/hwmon/Makefile                                |  1 -
>  drivers/platform/x86/Kconfig                          | 11 +++++++++++
>  drivers/platform/x86/Makefile                         |  3 +++
>  drivers/{hwmon/oxp-sensors.c =3D> platform/x86/oxpec.c} | 10 ++++------
>  8 files changed, 23 insertions(+), 22 deletions(-)
>  rename Documentation/hwmon/{oxp-sensors.rst =3D> oxpec.rst} (100%)

IMO this should also be moved, it doesn't really make sense that hwmon
would continue to carry the docs after the move. Platform/x86 doesn't
seem to have a home in Documentation, perhaps misc-devices? Armin or
Ilpo may have some thoughts here.

>  rename drivers/{hwmon/oxp-sensors.c =3D> platform/x86/oxpec.c} (98%)
>
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rs=
t
> index 874f8fd26325..dd7a54d5f281 100644
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
pec.rst
> similarity index 100%
> rename from Documentation/hwmon/oxp-sensors.rst
> rename to Documentation/hwmon/oxpec.rst
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0248c9eb39d6..a11d346a458b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17641,12 +17641,13 @@ S:    Maintained
>  F:     drivers/mtd/nand/onenand/
>  F:     include/linux/mtd/onenand*.h
>
> -ONEXPLAYER FAN DRIVER
> +ONEXPLAYER PLATFORM EC DRIVER
> +M:     Antheas Kapenekakis <lkml@antheas.dev>
>  M:     Derek John Clark <derekjohn.clark@gmail.com>
>  M:     Joaqu=C3=ADn Ignacio Aramend=C3=ADa <samsagax@gmail.com>
> -L:     linux-hwmon@vger.kernel.org
> +L:     platform-driver-x86@vger.kernel.org
>  S:     Maintained
> -F:     drivers/hwmon/oxp-sensors.c
> +F:     drivers/platform/x86/oxpec.c
>
>  ONIE TLV NVMEM LAYOUT DRIVER
>  M:     Miquel Raynal <miquel.raynal@bootlin.com>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 4cbaba15d86e..09f7aed96d15 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1774,17 +1774,6 @@ config SENSORS_NZXT_SMART2
>
>  source "drivers/hwmon/occ/Kconfig"
>
> -config SENSORS_OXP
> -       tristate "OneXPlayer EC fan control"
> -       depends on ACPI_EC
> -       depends on X86
> -       help
> -               If you say yes here you get support for fan readings and =
control over
> -               OneXPlayer handheld devices. Only OneXPlayer mini AMD han=
dheld variant
> -               boards are supported.
> -
> -               Can also be built as a module. In that case it will be ca=
lled oxp-sensors.
> -
>  config SENSORS_PCF8591
>         tristate "Philips PCF8591 ADC/DAC"
>         depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index b7ef0f0562d3..0edb08824b17 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -181,7 +181,6 @@ obj-$(CONFIG_SENSORS_NTC_THERMISTOR)        +=3D ntc_=
thermistor.o
>  obj-$(CONFIG_SENSORS_NZXT_KRAKEN2) +=3D nzxt-kraken2.o
>  obj-$(CONFIG_SENSORS_NZXT_KRAKEN3) +=3D nzxt-kraken3.o
>  obj-$(CONFIG_SENSORS_NZXT_SMART2) +=3D nzxt-smart2.o
> -obj-$(CONFIG_SENSORS_OXP) +=3D oxp-sensors.o
>  obj-$(CONFIG_SENSORS_PC87360)  +=3D pc87360.o
>  obj-$(CONFIG_SENSORS_PC87427)  +=3D pc87427.o
>  obj-$(CONFIG_SENSORS_PCF8591)  +=3D pcf8591.o
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0258dd879d64..4531b20c6b30 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1186,6 +1186,17 @@ config SEL3350_PLATFORM
>           To compile this driver as a module, choose M here: the module
>           will be called sel3350-platform.
>
> +config OXP_EC
> +       tristate "OneXPlayer EC platform control"
> +       depends on ACPI_EC
> +       depends on X86
> +       help
> +               Enables support for the platform EC of OneXPlayer and AOK=
ZOE
> +               handheld devices. This includes fan speed, fan controls, =
and
> +               disabling the default TDP behavior of the device. Due to =
legacy
> +               reasons, this driver also provides hwmon functionality to=
 Ayaneo
> +               devices and the OrangePi Neo.
> +

I don't think it is necessary to indicate future plans in config
options or documentation. It should just reflect the current state of
the kernel at the time of the patch. Whenever I get to submitting
ayaneo-platform I'll remove the necessary notes from Kconfigs, Docs,
etc.

>  endif # X86_PLATFORM_DEVICES
>
>  config P2SB
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
> index e1b142947067..f64a191c1162 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)             +=3D winm=
ate-fm07-keys.o
>
>  # SEL
>  obj-$(CONFIG_SEL3350_PLATFORM)         +=3D sel3350-platform.o
> +
> +# OneXPlayer
> +obj-$(CONFIG_OXP_EC)           +=3D oxpec.o
> \ No newline at end of file
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/platform/x86/oxpec.c
> similarity index 98%
> rename from drivers/hwmon/oxp-sensors.c
> rename to drivers/platform/x86/oxpec.c
> index f7a64fbc8f33..dc3a0871809c 100644
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

Same as above.

Cheers,
- Derek

>   * Fan control is provided via pwm interface in the range [0-255].
>   * Old AMD boards use [0-100] as range in the EC, the written value is
> @@ -16,6 +13,7 @@
>   *
>   * Copyright (C) 2022 Joaqu=C3=ADn I. Aramend=C3=ADa <samsagax@gmail.com=
>
>   * Copyright (C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
> + * Copyright (C) 2025 Antheas Kapenekakis <lkml@antheas.dev>
>   */
>
>  #include <linux/acpi.h>
> --
> 2.48.1
>

