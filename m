Return-Path: <linux-pm+bounces-24211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B402AA65771
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 17:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB96883A7F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 16:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C856117A31C;
	Mon, 17 Mar 2025 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="J9vJYFdb"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD391714AC;
	Mon, 17 Mar 2025 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227358; cv=none; b=IsDGFUuf+lE7kGvfcv0RAoYcji1tj8D/WJEGiTNdzDwM4DmAaOl5y5NCmDSndhpp4GPrQ6577jf1vNvJhYnalVkzTnj2b/HYsFZgbUzO+XCtbyYPXeedxSPSGkGWF5ZbimkZb04NS+7dFKwVpk72v66LflJngSK3n2I7NI5397c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227358; c=relaxed/simple;
	bh=D4NAe2iUldLe4tWzQTlHWH/IOChqKMJQqbOqVgCD8UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7M+8ibvx4OvjM5VKbhIFM+VGN6yVA/Gv/5bLnmZ10JT/wChlTDedJUtpfSOV0y7/5IKNl6Zo6ABvJ5xBMfJt+p1qsiZga/HA7fte4LiVhGByqR9ir7JGMBLAeAfh/xK2Xi30pVTinMlRdg7tLWKzGC8N6+V1DCY5GmKuqrqzzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=J9vJYFdb; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 79DF32E09564;
	Mon, 17 Mar 2025 18:02:32 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742227354;
	bh=xqwq/Em1fb5FMerjkMCm9F29xL5Dgmo9MCoLm5hsuTI=;
	h=Received:From:Subject:To;
	b=J9vJYFdbDUkFtTdJrHn750leNJuSPKRLOyrlsePoc4IXZ7Aeg+L7ANV0j2BLlb/3I
	 KwTX05/njWnzu8dS+wfh7bWLZhgcM8PbvrjVcnBXwfsr3Ku7jgymNu4Orm/NjGIU/h
	 jp02v1fUuojgpkHLHy0dCY1Wn0Nq+cobguISHbis=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.167.48) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lf1-f48.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5493b5bc6e8so4926574e87.2;
        Mon, 17 Mar 2025 09:02:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCV16eyUBrMr8h0VgkaWUluFGaVnQAMtn+0f3tHEKRclAid9vtrnHuRtDyB3sm1V5B5weOa4w6vX4kM=@vger.kernel.org,
 AJvYcCVJaPdY00hXonZeXHw5uIN2D8I9SSJnSwm4/VKEI51t7gOSz6cffmars8ibp65La2K856vNTGunH9A=@vger.kernel.org,
 AJvYcCXyPTdPWcAryhkSqsf46ZwKWWhtvYwnZq65sxgGVgdNIGE01ZQNHDafmlJeH8EelzIf+lXRa01TxUuTZi+x@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ARrQTcFIMiGzbGs5TuV4G+LeVTJw8TLeIoxVzGoOudEidOy1
	qBcfAcGzi3QDg0b6Av4KY5aWfwEiPgaORpogUyILQ6IsqCjleQ1wy1J3ZR3o7r2fS0+qQo1WTRn
	DnT58tZybamXDSt2msi+nyOLFL7U=
X-Google-Smtp-Source: 
 AGHT+IFAz0kgLEC4uOK5AMohsc/jk5E7XXBP21RkpD3X51bWXhdPJnWXixdvWJ4et23gAPlBTH0Rax/SNpXgmxt28Rc=
X-Received: by 2002:a05:6512:4016:b0:545:291:7ee0 with SMTP id
 2adb3069b0e04-549c3989bd1mr7520993e87.34.1742227351699; Mon, 17 Mar 2025
 09:02:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317155349.1236188-1-lkml@antheas.dev>
In-Reply-To: <20250317155349.1236188-1-lkml@antheas.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 17 Mar 2025 17:02:19 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwFpDT4gyEdjJfw8AGvd=_e-fn7yH-9_POzrPF7bOBQCnQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqzrAnul1Njdh95_GogWrVQDg12FtNQW814Szv4wMVky15Q9NrjTW90OdQ
Message-ID: 
 <CAGwozwFpDT4gyEdjJfw8AGvd=_e-fn7yH-9_POzrPF7bOBQCnQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/13] hwmon: (oxpsensors) Add devices, features, fix
 ABI and move to platform/x86
To: platform-driver-x86@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>, Eileen <eileen@one-netbook.com>,
	linux-kernel@vger.kernel.org, sre@kernel.org, linux@weissschuh.net,
	Hans de Goede <hdegoede@redhat.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174222735323.27976.11177177396523630123@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Forgot to add some ccs. Adding them here. Going very close to my ISPs'
email limit per hour

Antheas

On Mon, 17 Mar 2025 at 16:54, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> This four part series updates the oxpsensors module to bring it in line
> with its Windows OneXPlayer counterpart. First, it adds support for all
> 2024, 2025 OneXPlayer handhelds and their special variants. Then, it moves
> the module to platform/x86 to allow for including more EC features.
>
> Then, it adds the new charge limiting and bypass features that were first
> introduced in the X1 and retrofit to older OneXFly variants and for
> controlling the turbo led found in the X1 models. For Bypass, it adds a new
> charge_behaviour variant called inhibit-charge-s0.
>
> Finally, it performs a minor refactor by moving around switch statements
> into their own functions, in order to allow for fixing the pwm1_enable ABI
> in the final patch. Currently, pwm1_enable sets the fan to auto with the
> value 0 and allows manual control with the value 1. This patch makes it
> so 0 sets the fan to full speed, 1 sets the fan to manual control, and
> 2 sets the fan to auto. This requires both setting enable and the fan
> speed when the enable sysfs is written to as 0, hence the refactor.
>
> As this is a minor ABI break and there is userspace software relying
> on this previous behavior, the last patch also changes the /name of the
> hwmon endpoint to "oxp_ec" from "oxpec" (mirroring WMI module conventions)
> such that userspace software that relied on the previous behavior can be
> retrofit to the new kernel while enabling correct functionality on old
> and new kernels. Failing that, software that is not updated will just
> stop controlling the fans, ensuring no malignant behavior.
>
> ---
> V4: https://lore.kernel.org/all/20250311165406.331046-1-lkml@antheas.dev/
> V3: https://lore.kernel.org/all/20250309112114.1177361-1-lkml@antheas.dev/
>
> Changes since V4:
>     - Fix nits by Hans
>     - change inhibit-charge-s0 to inhibit-charge-awake
>     - use devm_battery_hook_register and power_supply_unregister_extension
>       (based on cros driver)
>     - move charge behavior patches to the end to make the rest of the series
>       easier to merge
>     - CC platform-x86 and power maintainers
>
> Changes since V3:
>     - Fix nits by Derek
>     - Remove the hwmon documentation as it is not required for platform
>       drivers (suggested by Guenter)
>     - Add ACPI_BATTERY and HWMON depends to Kconfig
>       (reported by kernel robot)
>     - Homogenize driver into following reverse xmas convention
>
> Changes since V2:
>     - Add ack by Guenter, move platform move patch to be third (not first
>       to allow for device support backport to lts kernels)
>     - Rework patch text, especially in the refactor patches as per Derek
>     - Change bypass to use charge_behaviour instead of charge_type, as that
>       ABI supports capability detection and is more appropriate
>     - Move battery attach to probe instead of init
>     - Fix bug where reading tt_led would instead use the turbo register
>
> Changes since V1:
>     - Add X1 Pro, F1 Pro variants
>     - Fix minor typo in initial patches
>     - Convert oxp-sensors into a platform driver, as it is no longer
>       considered a hwmon driver.
>     - Add sysfs documentation and myself to the MAINTAINERS file
>     - Update documentation to state that this is the OneXPlayer/AOKZOE
>       platform driver, and that support for Ayaneo/OPI is provided until
>       they gain their own platform driver.
>
> Antheas Kapenekakis (13):
>   hwmon: (oxp-sensors) Distinguish the X1 variants
>   hwmon: (oxp-sensors) Add all OneXFly variants
>   platform/x86: oxpec: Move hwmon/oxp-sensors to platform/x86
>   ABI: testing: add tt_toggle and tt_led entries
>   platform/x86: oxpec: Rename ec group to tt_toggle
>   platform/x86: oxpec: Add turbo led support to X1 devices
>   platform/x86: oxpec: Move pwm_enable read to its own function
>   platform/x86: oxpec: Move pwm value read/write to separate functions
>   platform/x86: oxpec: Move fan speed read to separate function
>   platform/x86: oxpec: Adhere to sysfs-class-hwmon and enable pwm on 2
>   platform/x86: oxpec: Follow reverse xmas convention for tt_toggle
>   power: supply: add inhibit-charge-awake to charge_behaviour
>   platform/x86: oxpec: Add charge threshold and behaviour to OneXPlayer
>
>  Documentation/ABI/testing/sysfs-class-power   |  11 +-
>  Documentation/ABI/testing/sysfs-platform-oxp  |  26 +
>  Documentation/hwmon/index.rst                 |   2 +-
>  Documentation/hwmon/oxp-sensors.rst           |  89 ---
>  MAINTAINERS                                   |   7 +-
>  drivers/hwmon/Kconfig                         |  11 -
>  drivers/hwmon/Makefile                        |   1 -
>  drivers/platform/x86/Kconfig                  |  13 +
>  drivers/platform/x86/Makefile                 |   3 +
>  .../oxp-sensors.c => platform/x86/oxpec.c}    | 628 ++++++++++++++----
>  drivers/power/supply/power_supply_sysfs.c     |   1 +
>  drivers/power/supply/test_power.c             |   1 +
>  include/linux/power_supply.h                  |   1 +
>  13 files changed, 542 insertions(+), 252 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-oxp
>  delete mode 100644 Documentation/hwmon/oxp-sensors.rst
>  rename drivers/{hwmon/oxp-sensors.c => platform/x86/oxpec.c} (52%)
>
>
> base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
> --
> 2.48.1
>

