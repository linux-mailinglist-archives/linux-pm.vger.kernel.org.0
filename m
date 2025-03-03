Return-Path: <linux-pm+bounces-23312-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D08A4C2CE
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 15:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F0818882F2
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 14:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E1521323C;
	Mon,  3 Mar 2025 14:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfQz1uTi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02CB212B17;
	Mon,  3 Mar 2025 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010796; cv=none; b=ISNB7CdpiuPfH98wRqLL/lwgH8ScoZYsfOHq1bRitM84Sf0pGzxLuHJPC8f54MhDyUIxrXijI4cu6VLnW4jViorzj1hcXcrZ99g+Ql/1y+T+Fplv+nlV1oxSh9hPLOBR+zN/ztrWJJ7dSix+zT4418V7RghGkucklJZcO8O/RTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010796; c=relaxed/simple;
	bh=bz8e8Iu44r0gZGHQ6LaeTCBLMvE9Bd2HHe/NGbaCOa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBkbAHVxtLVvWc08h531ug+zgFTQj6T0hv35npnbBTTEePykjy8FU24+Ue4dXlHSG4ZPVQj2ZvKwVRYb5D0UJG9TyGUq5lkP8sprjne3lNkhjyrhRkEbjs50MYTMDH9dkYzs5N0FGu2xpMRoWFy7bWJ8HAyt/EZxOK+Lfpxf8g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfQz1uTi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22349dc31bcso77132315ad.3;
        Mon, 03 Mar 2025 06:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741010793; x=1741615593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=87/tqBd5ZNtJFSIjhcqx4DE1UUf5Rca7d/rpXEcASSw=;
        b=NfQz1uTi5+GQXBLxneL2L/j5ehhOJfFYWQJLz534uOgp4WJNILMk+TkoP+ysdtwtlz
         Az6c2AYpn0AnZdBchtLWf9w3VKI23i8qyWckeZF7MPh2ivphI26puMua2N14bOxjlu+F
         0rQYWWREvIjiEwpnyAAb1AbPP/FW1CoPXGLgzB7tj1rrqQY1hXjy9RlM0kN7Np5+ygK/
         moMeGaE7aHwk7sKNiKwm/p9Qt9AV8nTV0JWWZvtWT8gn5uZ3EIfbMjlptlRB3su6k5dn
         PzThxe66ZcdZB6TVN6o9LFhQL+O/J3v41rBXZTisTM2RfidR6R2T3a0GPIT1inVBbj5u
         tZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741010793; x=1741615593;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87/tqBd5ZNtJFSIjhcqx4DE1UUf5Rca7d/rpXEcASSw=;
        b=qKPgNKxST6Fb65/S7nGb6SlNB3sd0gKwGvXJ7Kt6ijw4KrJxhBOGKpoIWWg5INs0W3
         3WmILiTZVLsOIRiNLrUeNbTAw7Q/RZjkPTUBoEcL6gtw1+2wnK2L2D8sAS0X50I5FH5N
         bNmChiU0sJURooAMev4UEyAIgWALiNFDQSOjAm2MNAeggcx+LkMePAsH8id8vxCyDLpW
         tWNtOuSKAespiNm6Fm1Ts5vacj0htxWJa1/Shu+eMAdpcXcUYCqcLRrVVWCc/roMXO4f
         liCecN17krO5uzwqPGL73d9ugqttbYivpD0w0cT+6SjLBlnIQJsjpD+TKdCziWkavSEe
         DaKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJNaJDn2D+I3QJVcgVgLUIAdS8qsI9XwHKIzNJPJE6lK1a2o0autbgj66PhRYYBvpHAjHGKDjvQFdzVQ==@vger.kernel.org, AJvYcCUldrOuePgYh86Mk6a2P9uBA1sfqC+W8E5eCVEDcqIU1N1PsUh1fM8TOHJd1PjpQI6RuxSKzFYmWIc=@vger.kernel.org, AJvYcCWGQUKGuGH20aRvWzYD6/3KR3KamFdmb9c2f3gIudw3F7RrgQLjRCEDBM0aIbBMPU0HfkWpSS/kVtg3/rSoNrhYqHj6ZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZN2Z/nIk0MLnoyX4JV42Rc9fRHVMMJUmmOBO9ztUtWbJ0GePQ
	6tcPWPnc0MZx7VhigwbI0doI/Dt2OAYrlavevO8yaW12gQWG1xMe
X-Gm-Gg: ASbGnctiGHmOsyDPDuzXeHqnc56shtbweWaI51vnTCbqXWTU2OJ5MR2ADtoffi5/m6w
	oWII98BsMQQt4UB6QteEoD1ymZvudNrnSkaI1O2GNAo4LwAD9oozm+DtntXkZHXSsTJEXZ7gBoE
	E9ZFU9o0qI3M9GG192OAiu7euwDc9YOY97V2ofLxTHEYUy9dXisPazkJ7WrRA/3pZ4bAPcMZZNy
	Hxct1cswN+sSEuf1JaCTaDHuH3ZW427cQU5ctHtp7n8wpdnpb05eC8p5dRJ549xylqKk/zLt9mS
	NN/FLQcBq8VdBGQYF4eAwFVLkOrqz9TLu+4YHgCwKtpmWiW/ETttzEehf6V3JLkJf0HwO4CzWVx
	QX0j6400MTo5YmvvmQQ==
X-Google-Smtp-Source: AGHT+IHYyPoIAviQ9WlZut/1R4lPJhxqJvypBSagtWuzXwkv/P+hqHZJzpslKnir4PuxhCJ88UfKHw==
X-Received: by 2002:a17:902:cec1:b0:21f:592b:b4b6 with SMTP id d9443c01a7336-22369244244mr198361845ad.47.1741010791522;
        Mon, 03 Mar 2025 06:06:31 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223505338f0sm77847815ad.248.2025.03.03.06.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 06:06:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3781a4b0-e9e0-42cb-9393-570b3c8a6305@roeck-us.net>
Date: Mon, 3 Mar 2025 06:06:28 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] platform/x86: oxpec: Move hwmon/oxp-sensors to
 platform/x86
To: Antheas Kapenekakis <lkml@antheas.dev>, linux-hwmon@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Derek J Clark <derekjohn.clark@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
 Eileen <eileen@one-netbook.com>
References: <20250222161824.172511-1-lkml@antheas.dev>
 <20250222161824.172511-12-lkml@antheas.dev>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250222161824.172511-12-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/22/25 08:18, Antheas Kapenekakis wrote:
> Once upon a time, the platform EC of handheld devices only
> controlled the fan. This is no longer the case, with the
> EC of OneXPlayer gaining additional functionality.
> 
> As it will be beneficial from a complexity perspective
> to retain this driver as a single unit, move it out
> of hwmon, and into platform/x86.
> 
> While at it, add myself to the maintainer's file.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

Acked-by: Guenter Roeck <linux@roeck-us.net>

This should really have been the first patch of the series.

Guenter

> ---
>   Documentation/hwmon/index.rst                         |  2 +-
>   Documentation/hwmon/{oxp-sensors.rst => oxpec.rst}    |  0
>   MAINTAINERS                                           |  7 ++++---
>   drivers/hwmon/Kconfig                                 | 11 -----------
>   drivers/hwmon/Makefile                                |  1 -
>   drivers/platform/x86/Kconfig                          | 11 +++++++++++
>   drivers/platform/x86/Makefile                         |  3 +++
>   drivers/{hwmon/oxp-sensors.c => platform/x86/oxpec.c} | 10 ++++------
>   8 files changed, 23 insertions(+), 22 deletions(-)
>   rename Documentation/hwmon/{oxp-sensors.rst => oxpec.rst} (100%)
>   rename drivers/{hwmon/oxp-sensors.c => platform/x86/oxpec.c} (98%)
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 874f8fd26325..dd7a54d5f281 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -186,7 +186,7 @@ Hardware Monitoring Kernel Drivers
>      nzxt-kraken3
>      nzxt-smart2
>      occ
> -   oxp-sensors
> +   oxpec
>      pc87360
>      pc87427
>      pcf8591
> diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxpec.rst
> similarity index 100%
> rename from Documentation/hwmon/oxp-sensors.rst
> rename to Documentation/hwmon/oxpec.rst
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5e49d57c589..35db92380f99 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17629,12 +17629,13 @@ S:	Maintained
>   F:	drivers/mtd/nand/onenand/
>   F:	include/linux/mtd/onenand*.h
>   
> -ONEXPLAYER FAN DRIVER
> +ONEXPLAYER PLATFORM EC DRIVER
> +M:	Antheas Kapenekakis <lkml@antheas.dev>
>   M:	Derek John Clark <derekjohn.clark@gmail.com>
>   M:	Joaquín Ignacio Aramendía <samsagax@gmail.com>
> -L:	linux-hwmon@vger.kernel.org
> +L:	platform-driver-x86@vger.kernel.org
>   S:	Maintained
> -F:	drivers/hwmon/oxp-sensors.c
> +F:	drivers/platform/x86/oxpec.c
>   
>   ONIE TLV NVMEM LAYOUT DRIVER
>   M:	Miquel Raynal <miquel.raynal@bootlin.com>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 4cbaba15d86e..09f7aed96d15 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1774,17 +1774,6 @@ config SENSORS_NZXT_SMART2
>   
>   source "drivers/hwmon/occ/Kconfig"
>   
> -config SENSORS_OXP
> -	tristate "OneXPlayer EC fan control"
> -	depends on ACPI_EC
> -	depends on X86
> -	help
> -		If you say yes here you get support for fan readings and control over
> -		OneXPlayer handheld devices. Only OneXPlayer mini AMD handheld variant
> -		boards are supported.
> -
> -		Can also be built as a module. In that case it will be called oxp-sensors.
> -
>   config SENSORS_PCF8591
>   	tristate "Philips PCF8591 ADC/DAC"
>   	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index b7ef0f0562d3..0edb08824b17 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -181,7 +181,6 @@ obj-$(CONFIG_SENSORS_NTC_THERMISTOR)	+= ntc_thermistor.o
>   obj-$(CONFIG_SENSORS_NZXT_KRAKEN2) += nzxt-kraken2.o
>   obj-$(CONFIG_SENSORS_NZXT_KRAKEN3) += nzxt-kraken3.o
>   obj-$(CONFIG_SENSORS_NZXT_SMART2) += nzxt-smart2.o
> -obj-$(CONFIG_SENSORS_OXP) += oxp-sensors.o
>   obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
>   obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
>   obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0258dd879d64..4531b20c6b30 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1186,6 +1186,17 @@ config SEL3350_PLATFORM
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called sel3350-platform.
>   
> +config OXP_EC
> +	tristate "OneXPlayer EC platform control"
> +	depends on ACPI_EC
> +	depends on X86
> +	help
> +		Enables support for the platform EC of OneXPlayer and AOKZOE
> +		handheld devices. This includes fan speed, fan controls, and
> +		disabling the default TDP behavior of the device. Due to legacy
> +		reasons, this driver also provides hwmon functionality to Ayaneo
> +		devices and the OrangePi Neo.
> +
>   endif # X86_PLATFORM_DEVICES
>   
>   config P2SB
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index e1b142947067..f64a191c1162 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)		+= winmate-fm07-keys.o
>   
>   # SEL
>   obj-$(CONFIG_SEL3350_PLATFORM)		+= sel3350-platform.o
> +
> +# OneXPlayer
> +obj-$(CONFIG_OXP_EC)		+= oxpec.o
> \ No newline at end of file
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/platform/x86/oxpec.c
> similarity index 98%
> rename from drivers/hwmon/oxp-sensors.c
> rename to drivers/platform/x86/oxpec.c
> index b5ba863a762a..51845aae8a44 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -1,11 +1,8 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /*
> - * Platform driver for OneXPlayer, AOKZOE, AYANEO, and OrangePi Handhelds
> - * that expose fan reading and control via hwmon sysfs.
> - *
> - * Old OXP boards have the same DMI strings and they are told apart by
> - * the boot cpu vendor (Intel/AMD). Of these older models only AMD is
> - * supported.
> + * Platform driver for OneXPlayer and AOKZOE devices. For the time being,
> + * it also exposes fan controls for AYANEO, and OrangePi Handhelds via
> + * hwmon sysfs.
>    *
>    * Fan control is provided via pwm interface in the range [0-255].
>    * Old AMD boards use [0-100] as range in the EC, the written value is
> @@ -16,6 +13,7 @@
>    *
>    * Copyright (C) 2022 Joaquín I. Aramendía <samsagax@gmail.com>
>    * Copyright (C) 2024 Derek J. Clark <derekjohn.clark@gmail.com>
> + * Copyright (C) 2025 Antheas Kapenekakis <lkml@antheas.dev>
>    */
>   
>   #include <linux/acpi.h>


