Return-Path: <linux-pm+bounces-24399-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2998A6C117
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 18:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB9D4610DB
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF2E22D7A4;
	Fri, 21 Mar 2025 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArgHnKYI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67021D8E07;
	Fri, 21 Mar 2025 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577415; cv=none; b=M0PjbBFbFz///KG9imD33Tv3BO/KfQMvry5hpIFqmtp4mKnJ5sL7EACXgKc8mvpyQ2ukgoWx82ZsKei9KvJxFduroklvC5zFsvJ7tgYvMM9+OdzmA+DRBjEgC1HNTBIuudjMS46JqnB1i+RcfkLzSubrkcJ8enbCX0VF6+OIqSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577415; c=relaxed/simple;
	bh=mhyr1Efzto/6WdPtZi0/MX9Rx1suko3LmuAnegYGxDI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NPnM0HEbXhyy7QbOK/JEH9gX3ajuAjphGUGLQYLxQpma6Rp2mMVrpYf3gQJMA+FjggJPf+XgGYyID/kUH1W+COuOEDFk5wsCjsKhyf+7yX6EPULnzesdDFBTOJ0YNALnEU5hnv/B207zkzg1K0JReg31oEyrxmhKSIX/AHbWMw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArgHnKYI; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22409077c06so25560505ad.1;
        Fri, 21 Mar 2025 10:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742577413; x=1743182213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8i//BDa5v0dvJDkEA2fd7PHT9jRJc1TXdcY6VlZ8X1s=;
        b=ArgHnKYIVTeGvwWoWklV2N6unCxiGEUcy6rTQEKVtL3dLUCbKuU+SKWsGH05x56Dfh
         X4d4ujZybzkgi7Bvf7zJ0BbkfD0hBMBN7EivXotFMA4Wkj6fEMXgvF+1iZImvBtmJc/z
         gNS+V/rxB4RsfBIHTHrIj0stxkZUqLowD084r4n+7Xsscg9U5tqBoQbNBmQgWN7tBHuh
         VN0ZcwZw57Fq8+BkNdyaEmdm4RZCvdMiCDvbvlNaZ/R+sn5ft5r23dh6rtvKGnGMdDHJ
         G2hS1ZjCzAElmjEHYsNTmyHNhLCPsR/uuYKIAXHUfmQdPf/1Y/ehpm4qDrgRlcVOGaP9
         fgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742577413; x=1743182213;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8i//BDa5v0dvJDkEA2fd7PHT9jRJc1TXdcY6VlZ8X1s=;
        b=vO6Epo/oVeoPHlFm+MIpxNHYGOemqt51TJNRqYPZhcztJGVdiUXVtjE1cvWVzAUhoi
         NW3SVGT49axtQzJ0qsm1kD7BXq/gh+z6YrSXR2rhe20VtAXpFdZ/DBtM4MjLDR945STx
         ujOgBp0SHeT8JzD04bxcRJ29JZixEYa/2qu9xC1cYusC1NosFwZXMuP96LZsZFGWLarC
         vV+j10LEayyVOwMZeNmW7S69Lm2BGvuKeKrFgLfPhkK8jWY7NQxdMMa8DKwc4jnVYIps
         DbNqG3xW6wg6EL8WdURxtG1qaQAPoplFvvtjq9PEO5lJ+XF4Ty5VyLuoQVdhBPNB+Qyj
         xTqg==
X-Forwarded-Encrypted: i=1; AJvYcCUPxJGaucHqdZylTbKPGoq5vN7DjUJ6rKjVvSdnCfEX42p0xGN0taWoBLKLonuY0kVsqPxEunSA/BU=@vger.kernel.org, AJvYcCV1cBttheE8wXo6ZTKIbq91yKkHSKw0WyyNW0hN7qhau57o2/KQTjbtcGJTgH7S39dXEUKBYdcXAOU=@vger.kernel.org, AJvYcCWQPTMcULDbk2mW035Md0UKFzBNKpb4lermOpxH0F6/WX3sZfoTymdx1UDp1P6KLnIT/7jphGgDC14LDbpELU0wHbgzqA==@vger.kernel.org, AJvYcCWWFx5eXW4lHQtFzOJuqzrs7zldjgRQj58cWkdgQeH53mDVYKm7bt+268nQmc7sGIJycqYNyC37T4CnG995@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ9dNgYDCJ1fpF/sbMrB85SXmXGseH/NnOESjBwwbIJC2akI+Q
	hNLavZNV0bsnjlNGKnOiU2eoPb8ZN8n4u2wuYZYCkGFAJujHkq0l
X-Gm-Gg: ASbGncvSHMA6NbRdkdIe5naQa3VngMvUPbf1qjtftzaWxqoAIJfGhOUiRlteggJBMOv
	TiZT54gtdvCiS0LYBxayHAv7oNxjebMpvWvdAIj1PeH19Osfz7foG5dztJLlJI05vlfySBH3bV4
	gjs9hYSYE2Ecox9aEA6BFSMlC6BYpDq2nOKfRbPq+YYtsSC2P2TJVCkNqMm8bJCta+uMwn+Ar/x
	JPV27pdfDTFwFwSslRtxxMfP5OUO/N9iz0vvUIqvlJCE2S7xkSfpeowbyLi96+GpxmxSc1jJZ1Z
	K/dlP2loiCL/gTJkq3uOoMjx5HvOWa0SP9ZuMDZniGZHiMIAF0i4oDC3Hok=
X-Google-Smtp-Source: AGHT+IH+1PKeHYLQOfk2UsR/Gh4n8yHVe1Xpnr1hVL7En1XlYgMolzB55S7fjiy3RV/oTo2BMebukA==
X-Received: by 2002:a17:902:cec8:b0:223:668d:eba9 with SMTP id d9443c01a7336-22780c5587bmr84105385ad.10.1742577412847;
        Fri, 21 Mar 2025 10:16:52 -0700 (PDT)
Received: from [127.0.0.1] ([172.102.8.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811d9f1bsm19695945ad.166.2025.03.21.10.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 10:16:52 -0700 (PDT)
Date: Fri, 21 Mar 2025 07:16:50 -1000
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v7_00/14=5D_hwmon=3A_=28oxpsensors=29_Add_dev?=
 =?US-ASCII?Q?ices=2C_features=2C_fix_ABI_and_move_to_platform/x86?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250319181044.392235-1-lkml@antheas.dev>
References: <20250319181044.392235-1-lkml@antheas.dev>
Message-ID: <2798B14C-C8A4-4976-AF40-22A1E0FFB0FC@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 19, 2025 8:10:27 AM HST, Antheas Kapenekakis <lkml@antheas=2Edev>=
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
>V6: NA
>V5: https://lore=2Ekernel=2Eorg/all/20250317155349=2E1236188-1-lkml@anthe=
as=2Edev/
>V4: https://lore=2Ekernel=2Eorg/all/20250311165406=2E331046-1-lkml@anthea=
s=2Edev/
>V3: https://lore=2Ekernel=2Eorg/all/20250309112114=2E1177361-1-lkml@anthe=
as=2Edev/
>
>Changes since V6:
>    - Fix compile error due to extra const=2E My bad on that one, did a
>      double check on a device too=2E
>

For the remainder of the series without my tag:
Reviewed-by: Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>

>Changes since V5:
>    - Separate doc entries with Fixes as by Mario
>    - Add sysfs file name to subject as per Thomas
>    - Make tt_led and tt_turbo const as per Thomas
>    - Align a couple of structs as per Thomas
>    - Remove excess battery check as per Thomas
>    - For Thomas: devices without a BIOS update battery control is a NOOP
>      OXP is a boutique manufacturer for now, so gathering information
>      about old devices to add BIOS checks is not practical unfortunately
>
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

- Derek

