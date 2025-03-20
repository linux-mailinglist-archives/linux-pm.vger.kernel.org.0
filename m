Return-Path: <linux-pm+bounces-24342-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEEBA6ACA1
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 19:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D4B57AF943
	for <lists+linux-pm@lfdr.de>; Thu, 20 Mar 2025 18:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116141E5702;
	Thu, 20 Mar 2025 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Ioeb1umN"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598A81D9A50;
	Thu, 20 Mar 2025 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493714; cv=none; b=o9zg2C1kt0SJ0heftdv2BBSTCXEB81Hn9ZB2eCgp0nfUeEBkGeQOfCbfFml0+rOcXDWa5H0VKEaUvQ0hymi6Zbk81EBVGt34nK2ZKi1gSauUqJrucwlKgtP+Qdw/B67U9iPnUA8zbGcNO4Z5IpPrPPdj/n8nVF8+15iO/K4A0WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493714; c=relaxed/simple;
	bh=ri4iePpKdHJZbPjuAz2uuFnkK1A0W4w0YFmS0f70L9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgn5Y3nyVnkKFP7X48P3Vo1XPD3qWpemZt3w7m2QjSngyRKBzQQdWrR4Zcjt+OdGGac3d1791eIchNCajFpYoEWRXH5UBI3i5EDYPTlrIjeJ+MXMiOx4kAxXOMWcP23A9JsisfzffseF8jGwtHWkv5PXRZyA+3YpapAnb8h2g7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Ioeb1umN; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id D72852E09430;
	Thu, 20 Mar 2025 20:01:40 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742493701;
	bh=bfcDkCq066rbtoTdEqNCoKT/INV1aOtvGSYxQcLPl5g=;
	h=Received:From:Subject:To;
	b=Ioeb1umNACm1DpUB0pnCUIi5e8b4t2gYxDU81cW2p8BJmz65RlVXMtKLj3vLtv5px
	 lgDm5JroMKdwbJZW21W31+hriZWtWY1WVzqtses1VfCADi3jSrA9VteFLtZQznyCAj
	 Flw0ynpxAWjkTB/33q8wMuVs8S5UtHoevIH4wTz0=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.167.42) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lf1-f42.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-549b159c84cso1309219e87.3;
        Thu, 20 Mar 2025 11:01:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU5UkZGfXEEnWPYMC2s9CAka8p4U7/SiXMkazatTTrU5y80jrQTu14yQN09IcWQNtfYQKtW+5ubEKME22y5@vger.kernel.org,
 AJvYcCU6pVPo7tuZUlnH9hfn/swBFxkeN0ycrd+/X/TV1BD2MmkGh3vvgL644R3pRSro+dGn5K17+4IohyWNo5A=@vger.kernel.org,
 AJvYcCUNHWR0LVEYoyFkDh2epeESjrWJCHOBNDzZMu7d/IXv3g4XPRZGJ9heuBwXST3jXyVZmj9iPHHQT40=@vger.kernel.org,
 AJvYcCVOpmtnn6zkG9b5QADAmN8uH5xsI8sX2yjpx9VDVoSDl3QonNS4wBJaMkSBT2x347sRRNEkfEh+RVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj1RHVsA444HQO1BYbbC0K4Eb8TiPERAomgLftWI//fCSxvd4j
	q3VHJGTfpEm1FAzXPZvd3qZ2kW5mkla05hpvuTGnnnHD+E4DMWWCxN2zJBh+y3Z6lScdSso5wfA
	UjtfUqDI/8OuET062VflQYtka6OU=
X-Google-Smtp-Source: 
 AGHT+IGfhvfuOiB+DEb6uOTl9EpxtzHoqw+6Gezd8dTghpF9jNKTgiZmVV/+1AlX1dPtpovYPwKYj9IP3xGz+Cdgws0=
X-Received: by 2002:a05:6512:1254:b0:549:8924:2212 with SMTP id
 2adb3069b0e04-54ad64865bemr99041e87.17.1742493700020; Thu, 20 Mar 2025
 11:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319175512.27059-1-lkml@antheas.dev>
 <41DE9E62-7BE6-4E65-BCFF-98DB243BB527@gmail.com>
In-Reply-To: <41DE9E62-7BE6-4E65-BCFF-98DB243BB527@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 20 Mar 2025 19:01:28 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwGXW_H1TdLNiYGctTpMpXBEYLtgdn-dcn9zP+LSpnYUew@mail.gmail.com>
X-Gm-Features: AQ5f1JoKC-br4Ylipx4s-aD-wtdmaefte9GBB96ByJ_g9JolJcvjF51P1NHYNlo
Message-ID: 
 <CAGwozwGXW_H1TdLNiYGctTpMpXBEYLtgdn-dcn9zP+LSpnYUew@mail.gmail.com>
Subject: Re: [PATCH v6 00/14] hwmon: (oxpsensors) Add devices, features, fix
 ABI and move to platform/x86
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>, linux-kernel@vger.kernel.org,
 sre@kernel.org,
	linux@weissschuh.net, ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com,
	mario.limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <174249370148.7628.2782718619305504685@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Thu, 20 Mar 2025 at 18:33, Derek J. Clark <derekjohn.clark@gmail.com> wr=
ote:
>
>
>
> On March 19, 2025 7:54:55 AM HST, Antheas Kapenekakis <lkml@antheas.dev> =
wrote:
> >This four part series updates the oxpsensors module to bring it in line
> >with its Windows OneXPlayer counterpart. First, it adds support for all
> >2024, 2025 OneXPlayer handhelds and their special variants. Then, it mov=
es
> >the module to platform/x86 to allow for including more EC features.
> >
> >Then, it adds the new charge limiting and bypass features that were firs=
t
> >introduced in the X1 and retrofit to older OneXFly variants and for
> >controlling the turbo led found in the X1 models. For Bypass, it adds a =
new
> >charge_behaviour variant called inhibit-charge-s0.
> >
> >Finally, it performs a minor refactor by moving around switch statements
> >into their own functions, in order to allow for fixing the pwm1_enable A=
BI
> >in the final patch. Currently, pwm1_enable sets the fan to auto with the
> >value 0 and allows manual control with the value 1. This patch makes it
> >so 0 sets the fan to full speed, 1 sets the fan to manual control, and
> >2 sets the fan to auto. This requires both setting enable and the fan
> >speed when the enable sysfs is written to as 0, hence the refactor.
> >
> >As this is a minor ABI break and there is userspace software relying
> >on this previous behavior, the last patch also changes the /name of the
> >hwmon endpoint to "oxp_ec" from "oxpec" (mirroring WMI module convention=
s)
> >such that userspace software that relied on the previous behavior can be
> >retrofit to the new kernel while enabling correct functionality on old
> >and new kernels. Failing that, software that is not updated will just
> >stop controlling the fans, ensuring no malignant behavior.
> >
> >---
> >V5: https://lore.kernel.org/all/20250317155349.1236188-1-lkml@antheas.de=
v/
> >V4: https://lore.kernel.org/all/20250311165406.331046-1-lkml@antheas.dev=
/
> >V3: https://lore.kernel.org/all/20250309112114.1177361-1-lkml@antheas.de=
v/
> >
> >Changes since V5:
> >    - Separate doc entries with Fixes as by Mario
> >    - Add sysfs file name to subject as per Thomas
> >    - Make tt_led and tt_turbo const as per Thomas
> >    - Align a couple of structs as per Thomas
> >    - Remove excess battery check as per Thomas
> >    - For Thomas: devices without a BIOS update battery control is a NOO=
P
> >      OXP is a boutique manufacturer for now, so gathering information
> >      about old devices to add BIOS checks is not practical unfortunatel=
y
>
> Antheas,
> This sort of begs the question on how this feature was tested on those de=
vices? That question includes whether or not it is really a no-op in unsupp=
orted BIOS. My old contacts at OXP are no longer employed there, are you in=
 contact with anyone at OXP currently that can potentially provide the data=
?
>
> I'm still of the opinion that the attribute should be explicitly enabled =
only on a known supported BIOS.  IMO there is a general assumption that a d=
river exposed attribute fd will work and having a no-op will confuse users =
and lead to spurious bug reports. We shouldn't be exposing a no-op in the s=
ysfs for a driver if we can avoid it. If we add the BIOS checks we can also=
 print to dmesg if a BIOS is too low a version so they will know why it isn=
't there.
>
> That being said, it does seem likely low risk, so I'm not nacking the fea=
ture as is if the subsystem maintainers are okay with it.
>
> - Derek

Hi Derek,
I have tested this patch series on an X1 (AMD) personally. I also have
multiple people that have tested it on an F1 Pro, X1 Intel, and an X1
Mini. And I am pretty sure that at least 1 or 2 people have tested on
an older BIOS too without an ill effect.

The older F1s are a bit of a question mark. The BIOS update for those
came out around Xmas and I do not have that many users with them.
However, they act identically to the new ones when it comes to the EC
and the controller, so I do not think that is that big of an issue.
Also, no one has asked yet about it not working on those devices. And
they ask about a lot of things. Yanking charging support from those
will just hurt those users unnecessarily as they will get it later.

Eileen is from OneXPlayer and is cc'd in this series.

Antheas

> >Changes since V4:
> >    - Fix nits by Hans
> >    - change inhibit-charge-s0 to inhibit-charge-awake
> >    - use devm_battery_hook_register and power_supply_unregister_extensi=
on
> >      (based on cros driver)
> >    - move charge behavior patches to the end to make the rest of the se=
ries
> >      easier to merge
> >    - CC platform-x86 and power maintainers
> >
> >Changes since V3:
> >    - Fix nits by Derek
> >    - Remove the hwmon documentation as it is not required for platform
> >      drivers (suggested by Guenter)
> >    - Add ACPI_BATTERY and HWMON depends to Kconfig
> >      (reported by kernel robot)
> >    - Homogenize driver into following reverse xmas convention
> >
> >Changes since V2:
> >    - Add ack by Guenter, move platform move patch to be third (not firs=
t
> >      to allow for device support backport to lts kernels)
> >    - Rework patch text, especially in the refactor patches as per Derek
> >    - Change bypass to use charge_behaviour instead of charge_type, as t=
hat
> >      ABI supports capability detection and is more appropriate
> >    - Move battery attach to probe instead of init
> >    - Fix bug where reading tt_led would instead use the turbo register
> >
> >Changes since V1:
> >    - Add X1 Pro, F1 Pro variants
> >    - Fix minor typo in initial patches
> >    - Convert oxp-sensors into a platform driver, as it is no longer
> >      considered a hwmon driver.
> >    - Add sysfs documentation and myself to the MAINTAINERS file
> >    - Update documentation to state that this is the OneXPlayer/AOKZOE
> >      platform driver, and that support for Ayaneo/OPI is provided until
> >      they gain their own platform driver.
> >
> >Antheas Kapenekakis (14):
> >  hwmon: (oxp-sensors) Distinguish the X1 variants
> >  hwmon: (oxp-sensors) Add all OneXFly variants
> >  platform/x86: oxpec: Move hwmon/oxp-sensors to platform/x86
> >  ABI: testing: sysfs-class-oxp: add missing documentation
> >  ABI: testing: sysfs-class-oxp: add tt_led attribute documentation
> >  platform/x86: oxpec: Rename ec group to tt_toggle
> >  platform/x86: oxpec: Add turbo led support to X1 devices
> >  platform/x86: oxpec: Move pwm_enable read to its own function
> >  platform/x86: oxpec: Move pwm value read/write to separate functions
> >  platform/x86: oxpec: Move fan speed read to separate function
> >  platform/x86: oxpec: Adhere to sysfs-class-hwmon and enable pwm on 2
> >  platform/x86: oxpec: Follow reverse xmas convention for tt_toggle
> >  power: supply: add inhibit-charge-awake to charge_behaviour
> >  platform/x86: oxpec: Add charge threshold and behaviour to OneXPlayer
> >
> > Documentation/ABI/testing/sysfs-class-power   |  11 +-
> > Documentation/ABI/testing/sysfs-platform-oxp  |  25 +
> > Documentation/hwmon/index.rst                 |   2 +-
> > Documentation/hwmon/oxp-sensors.rst           |  89 ---
> > MAINTAINERS                                   |   7 +-
> > drivers/hwmon/Kconfig                         |  11 -
> > drivers/hwmon/Makefile                        |   1 -
> > drivers/platform/x86/Kconfig                  |  13 +
> > drivers/platform/x86/Makefile                 |   3 +
> > .../oxp-sensors.c =3D> platform/x86/oxpec.c}    | 624 ++++++++++++++---=
-
> > drivers/power/supply/power_supply_sysfs.c     |   7 +-
> > drivers/power/supply/test_power.c             |   1 +
> > include/linux/power_supply.h                  |   1 +
> > 13 files changed, 540 insertions(+), 255 deletions(-)
> > create mode 100644 Documentation/ABI/testing/sysfs-platform-oxp
> > delete mode 100644 Documentation/hwmon/oxp-sensors.rst
> > rename drivers/{hwmon/oxp-sensors.c =3D> platform/x86/oxpec.c} (52%)
> >
> >
> >base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1

