Return-Path: <linux-pm+bounces-24341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F92BA6AC1A
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 18:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C330D18857B9
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 17:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A141224B01;
	Thu, 20 Mar 2025 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ml6rbWjd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74033223336;
	Thu, 20 Mar 2025 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492016; cv=none; b=rmOxZhqCSx5pAnywomHUAtwhcPlz5C6cewthEWLHAw5hhVSjC5L9CLDzlbK0uLCGFuyxpQxXjzM5XTMbHR5DkDydcaba2ej6sod69RlNncaVtzpjxrmSWu1StJdi+uZzXig/Jg2rhj9cEoB4qoBg3vAQijV8YnDjBrfec5PGes8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492016; c=relaxed/simple;
	bh=PagMdvtg5KTGSUdqloqmzmN+2CHEwsXpUsFu5h9EYiI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Z5vNSuh1b4zbUo+oWLnkWQ3BkXhXeQK15PMvvq8TDEiRv5Vr2Ok844+qVghiUzX7/jIZi//1VWoGPVYx/qSuLK7EGakaWCwDiLTEbRdBO9kem6zFYVoAfwY7g0+WAJ0o0ocr1JICGO22OKaKomTYKUqXflprwxRGzgrKxqsdjcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ml6rbWjd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2254e0b4b79so31240085ad.2;
        Thu, 20 Mar 2025 10:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742492014; x=1743096814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4IA8tCZYJI9t5hg42P7F7sSH+jw28GDy2AHdYlBsWo8=;
        b=Ml6rbWjdJb5NdddaIH506HJo9aBC64newd8LOaV80FMb6o0IrOwKpooimpvL8y/l5q
         /mx4AD06tgD+a0Xn6Dk7epw30Zzh5c3hexTRUdMKcOOGxGVtfVMlFt1RhIZ6k55tEEdw
         mL/CfPvsyZQlHAqoq9aSl3puU2cajYPLEBPyovLwnG1i8N/nFOQ1Q6LLlxZBjqJdcbyD
         dOjznhziZJVzsRyAnY9daP8f0EzxVj+xfAfepcOycbSbf/t+jHioDZQpyQ8517m1GMdr
         in7/tKNr6NaDsgfoYfcS3OizfU0rdd59fnHKNfSXI1QMrWBOlnQgtmlaRekSzNn2qaMk
         r0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742492014; x=1743096814;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4IA8tCZYJI9t5hg42P7F7sSH+jw28GDy2AHdYlBsWo8=;
        b=ggOLRRHQ58jWQoQslz1b25+78shZx4jg1uxLwb1djG7fd+QhegRlIRVHWJidPG5whd
         E3HppSLna6Zu199JMeimf796xSArqh6mm3ff7woneTd3EQr8jiI7RR0FjQ0aL/p9rMuB
         1lYRxtNjW80IOJejNTHaZzU0YvVzOzZuYg8qgoxxo6j79+dnsnFhR9trbA14s0c8eosf
         wsBQ54r81cGP4O+pYjl/Hns7FzuY6QbsP8g5l1oWw/O1S4sLlzPPTTMWoy9UeqpKpQzB
         w1WYYhBxd3ymb+J4qOYktJSo2/z+hz1qhAV2KVAEGe+Dq44hMDEep3GhHGGrnaF5J/J+
         AKYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2YFMRA2zf9uexQnYVMRoHd7iTfUKtC6U9GGwLwwi1GfNaNTlDs8F9F+aNLezXZav7VXPytLtB81A=@vger.kernel.org, AJvYcCUFjhZNJ4D1mZwDi1vJWpUBAYIQxOWYNe3abBL5lNrgz1JR99kxGsnY/MLlqTJgspCbAx6QZVy78OsFva/D@vger.kernel.org, AJvYcCVFzrOeJhoHsMwCX13b09+7lmlt0zrQzviIe5nC8kIXToz/fb66qAlDk2qZMZcWEgjDQbuHVu2uqms=@vger.kernel.org, AJvYcCVg35dQ23TeIXlkhy07B+X25B28c4NSK/j9gxtdH66X2To9+Rq5hlhqZn2PAW7Z3OyHW/lljttfd7yg9IRn6m8//eYIew==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVabTqt2zWsIwAj8Yx0kdZnGZw17zZRVlaesSFA1PjRdMCnNbu
	VXAxJWUgsgPex+49OqY+gk3FwBZsnh4qCHdu54sRFHeoY4YMnhUj
X-Gm-Gg: ASbGncs5ygA7sCFgoP/SbA+yCmVTGwPOQYtn+/oj+MAqrBr04KIoX3w/GHRsLcE6QEF
	qoht/ayo7zE5UAv914uUHBeStigoarIXwk+XCAXcv7QViNHONbr1AYoNfGA9+h5blhIWNL9uxdN
	HRuqx/RigPuXeHPTSui5DMXOIRi1LT8oq9PSoyA8Qg3Y7aE1S/V5f47g040WmVmUiVQXRZttmQy
	Ua8oKTTtgwj6h/s7ywomC04crycslHlhFctqKEOv7AKbBu1YrJGKegbkl1Ig+k19fDTcMqJKQyB
	q2OYFVo9nu5AF1PtC3gVyjcCFKsJEmvYqLZqHtQojiIV5eO7oqe7Lg==
X-Google-Smtp-Source: AGHT+IFthf2CpWZEJwnTLLJ3fvyLbU3lQKkDNvBnaDnU0oy5qNCojO0XZ/7VGrr1w5tBksnrck+Yhg==
X-Received: by 2002:a17:902:e74c:b0:224:76f:9e45 with SMTP id d9443c01a7336-22780d7fd37mr3693615ad.21.1742492013424;
        Thu, 20 Mar 2025 10:33:33 -0700 (PDT)
Received: from ?IPv6:::1? ([2607:fb91:1bec:5896:ac39:c338:6b1e:14b4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f459fbsm598185ad.78.2025.03.20.10.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 10:33:33 -0700 (PDT)
Date: Thu, 20 Mar 2025 07:33:28 -1000
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Antheas Kapenekakis <lkml@antheas.dev>, platform-driver-x86@vger.kernel.org
CC: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
 Eileen <eileen@one-netbook.com>, linux-kernel@vger.kernel.org,
 sre@kernel.org, linux@weissschuh.net, ilpo.jarvinen@linux.intel.com,
 hdegoede@redhat.com, mario.limonciello@amd.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_00/14=5D_hwmon=3A_=28oxpsensors=29_Add_dev?=
 =?US-ASCII?Q?ices=2C_features=2C_fix_ABI_and_move_to_platform/x86?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250319175512.27059-1-lkml@antheas.dev>
References: <20250319175512.27059-1-lkml@antheas.dev>
Message-ID: <41DE9E62-7BE6-4E65-BCFF-98DB243BB527@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 19, 2025 7:54:55 AM HST, Antheas Kapenekakis <lkml@antheas=2Edev>=
 wrote:
>This four part series updates the oxpsensors module to bring it in line
>with its Windows OneXPlayer counterpart=2E First, it adds support for all
>2024, 2025 OneXPlayer handhelds and their special variants=2E Then, it mo=
ves
>the module to platform/x86 to allow for including more EC features=2E
>
>Then, it adds the new charge limiting and bypass features that were first
>introduced in the X1 and retrofit to older OneXFly variants and for
>controlling the turbo led found in the X1 models=2E For Bypass, it adds a=
 new
>charge_behaviour variant called inhibit-charge-s0=2E
>
>Finally, it performs a minor refactor by moving around switch statements
>into their own functions, in order to allow for fixing the pwm1_enable AB=
I
>in the final patch=2E Currently, pwm1_enable sets the fan to auto with th=
e
>value 0 and allows manual control with the value 1=2E This patch makes it
>so 0 sets the fan to full speed, 1 sets the fan to manual control, and
>2 sets the fan to auto=2E This requires both setting enable and the fan
>speed when the enable sysfs is written to as 0, hence the refactor=2E
>
>As this is a minor ABI break and there is userspace software relying
>on this previous behavior, the last patch also changes the /name of the
>hwmon endpoint to "oxp_ec" from "oxpec" (mirroring WMI module conventions=
)
>such that userspace software that relied on the previous behavior can be
>retrofit to the new kernel while enabling correct functionality on old
>and new kernels=2E Failing that, software that is not updated will just
>stop controlling the fans, ensuring no malignant behavior=2E
>
>---
>V5: https://lore=2Ekernel=2Eorg/all/20250317155349=2E1236188-1-lkml@anthe=
as=2Edev/
>V4: https://lore=2Ekernel=2Eorg/all/20250311165406=2E331046-1-lkml@anthea=
s=2Edev/
>V3: https://lore=2Ekernel=2Eorg/all/20250309112114=2E1177361-1-lkml@anthe=
as=2Edev/
>
>Changes since V5:
>    - Separate doc entries with Fixes as by Mario
>    - Add sysfs file name to subject as per Thomas
>    - Make tt_led and tt_turbo const as per Thomas
>    - Align a couple of structs as per Thomas
>    - Remove excess battery check as per Thomas
>    - For Thomas: devices without a BIOS update battery control is a NOOP
>      OXP is a boutique manufacturer for now, so gathering information
>      about old devices to add BIOS checks is not practical unfortunately

Antheas,
This sort of begs the question on how this feature was tested on those dev=
ices? That question includes whether or not it is really a no-op in unsuppo=
rted BIOS=2E My old contacts at OXP are no longer employed there, are you i=
n contact with anyone at OXP currently that can potentially provide the dat=
a?

I'm still of the opinion that the attribute should be explicitly enabled o=
nly on a known supported BIOS=2E  IMO there is a general assumption that a =
driver exposed attribute fd will work and having a no-op will confuse users=
 and lead to spurious bug reports=2E We shouldn't be exposing a no-op in th=
e sysfs for a driver if we can avoid it=2E If we add the BIOS checks we can=
 also print to dmesg if a BIOS is too low a version so they will know why i=
t isn't there=2E

That being said, it does seem likely low risk, so I'm not nacking the feat=
ure as is if the subsystem maintainers are okay with it=2E=20

- Derek

>Changes since V4:
>    - Fix nits by Hans
>    - change inhibit-charge-s0 to inhibit-charge-awake
>    - use devm_battery_hook_register and power_supply_unregister_extensio=
n
>      (based on cros driver)
>    - move charge behavior patches to the end to make the rest of the ser=
ies
>      easier to merge
>    - CC platform-x86 and power maintainers
>
>Changes since V3:
>    - Fix nits by Derek
>    - Remove the hwmon documentation as it is not required for platform
>      drivers (suggested by Guenter)
>    - Add ACPI_BATTERY and HWMON depends to Kconfig
>      (reported by kernel robot)
>    - Homogenize driver into following reverse xmas convention
>
>Changes since V2:
>    - Add ack by Guenter, move platform move patch to be third (not first
>      to allow for device support backport to lts kernels)
>    - Rework patch text, especially in the refactor patches as per Derek
>    - Change bypass to use charge_behaviour instead of charge_type, as th=
at
>      ABI supports capability detection and is more appropriate
>    - Move battery attach to probe instead of init
>    - Fix bug where reading tt_led would instead use the turbo register
>
>Changes since V1:
>    - Add X1 Pro, F1 Pro variants
>    - Fix minor typo in initial patches
>    - Convert oxp-sensors into a platform driver, as it is no longer
>      considered a hwmon driver=2E
>    - Add sysfs documentation and myself to the MAINTAINERS file
>    - Update documentation to state that this is the OneXPlayer/AOKZOE
>      platform driver, and that support for Ayaneo/OPI is provided until
>      they gain their own platform driver=2E
>
>Antheas Kapenekakis (14):
>  hwmon: (oxp-sensors) Distinguish the X1 variants
>  hwmon: (oxp-sensors) Add all OneXFly variants
>  platform/x86: oxpec: Move hwmon/oxp-sensors to platform/x86
>  ABI: testing: sysfs-class-oxp: add missing documentation
>  ABI: testing: sysfs-class-oxp: add tt_led attribute documentation
>  platform/x86: oxpec: Rename ec group to tt_toggle
>  platform/x86: oxpec: Add turbo led support to X1 devices
>  platform/x86: oxpec: Move pwm_enable read to its own function
>  platform/x86: oxpec: Move pwm value read/write to separate functions
>  platform/x86: oxpec: Move fan speed read to separate function
>  platform/x86: oxpec: Adhere to sysfs-class-hwmon and enable pwm on 2
>  platform/x86: oxpec: Follow reverse xmas convention for tt_toggle
>  power: supply: add inhibit-charge-awake to charge_behaviour
>  platform/x86: oxpec: Add charge threshold and behaviour to OneXPlayer
>
> Documentation/ABI/testing/sysfs-class-power   |  11 +-
> Documentation/ABI/testing/sysfs-platform-oxp  |  25 +
> Documentation/hwmon/index=2Erst                 |   2 +-
> Documentation/hwmon/oxp-sensors=2Erst           |  89 ---
> MAINTAINERS                                   |   7 +-
> drivers/hwmon/Kconfig                         |  11 -
> drivers/hwmon/Makefile                        |   1 -
> drivers/platform/x86/Kconfig                  |  13 +
> drivers/platform/x86/Makefile                 |   3 +
> =2E=2E=2E/oxp-sensors=2Ec =3D> platform/x86/oxpec=2Ec}    | 624 ++++++++=
++++++----
> drivers/power/supply/power_supply_sysfs=2Ec     |   7 +-
> drivers/power/supply/test_power=2Ec             |   1 +
> include/linux/power_supply=2Eh                  |   1 +
> 13 files changed, 540 insertions(+), 255 deletions(-)
> create mode 100644 Documentation/ABI/testing/sysfs-platform-oxp
> delete mode 100644 Documentation/hwmon/oxp-sensors=2Erst
> rename drivers/{hwmon/oxp-sensors=2Ec =3D> platform/x86/oxpec=2Ec} (52%)
>
>
>base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1

