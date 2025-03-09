Return-Path: <linux-pm+bounces-23688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 349B7A58391
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 12:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63BAA16D545
	for <lists+linux-pm@lfdr.de>; Sun,  9 Mar 2025 11:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EFF1C5D75;
	Sun,  9 Mar 2025 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="PrlYaP84"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CED74C08;
	Sun,  9 Mar 2025 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741519290; cv=none; b=K6LGR90FXSj2xeBvG310VuF9K7m/+mmd2Ar+F2H0T2kFqNz5p2hE+a3DtxbnrQ/Og+Pr4NkmwXLeAeDaEaq3gr6KRW4ea4TvYcIZPjEv8ujI+VK4lbLRq8mVZCPpXorPkPCC0Y7O2wFR2kXeMGEVYzz/d6jCLP7VxV5GAOoYKk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741519290; c=relaxed/simple;
	bh=D3tYI8iTJ7QZIlhKuN2+ClrGTuzJa2U2KPsn5/wV2js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eBFE+hAd9J8H+9KM6Ugvl1OH/+QcVVPXra4uBvscu3zOl3gX/9apqBu8eYHYwawXBI+i5rnGdPg/w+4oLB7J9Yc7vTcViZ4lUn1n+TOyiUfG5d7bAdAld29JfVRHfzzV5uDanAG+2hEEjX/rFJBBFvGkiFFk+pqi1yH04esK/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=PrlYaP84; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 917972E037CC;
	Sun,  9 Mar 2025 13:21:16 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741519278;
	bh=w3CdKrkESq2tKARZR2k9fTv2YfnbpHvzaojVRo6xY4o=; h=From:To:Subject;
	b=PrlYaP849T8sA/19KRFS4qOb2ocBEyujLhtlFvgAECkj6400RHpoxQjM72ukJzDDC
	 FiiHqZ/SkXghZgVmAqOuJZICRlEh1T/+c2dn9e1e2rxjDLf1EWr+YbuVwHjNrFKk7W
	 hbXi/r3JQR02UnmsGXfoQiZgbIiW8pm7Ir8DD8hM=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:8d8a:5967:d692:ea4e) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
	Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
	Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>,
	Eileen <eileen@one-netbook.com>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v3 00/12] hwmon: (oxpsensors) Add devices, features,
 fix ABI and move to platform/x86
Date: Sun,  9 Mar 2025 12:21:01 +0100
Message-ID: <20250309112114.1177361-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174151927785.28547.2924708597399637820@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

This four part series updates the oxpsensors module to bring it in line
with its Windows OneXPlayer counterpart. First, it adds support for all
2024, 2025 OneXPlayer handhelds and their special variants. Then, it moves
the module to platform/x86 to allow for including more EC features.

Then, it adds the new charge limiting and bypass features that were first
introduced in the X1 and retrofit to older OneXFly variants and for
controlling the turbo led found in the X1 models. For Bypass, it adds a new
charge_behaviour variant called inhibit-charge-s0.

Finally, it performs a minor refactor by moving around switch statements
into their own functions, in order to allow for fixing the pwm1_enable ABI
in the final patch. Currently, pwm1_enable sets the fan to auto with the
value 0 and allows manual control with the value 1. This patch makes it
so 0 sets the fan to full speed, 1 sets the fan to manual control, and
2 sets the fan to auto. This requires both setting enable and the fan
speed when the enable sysfs is written to as 0, hence the refactor.

As this is a minor ABI break and there is userspace software relying
on this previous behavior, the last patch also changes the /name of the
hwmon endpoint to "oxp_ec" from "oxpec" (mirroring WMI module conventions)
such that userspace software that relied on the previous behavior can be
retrofit to the new kernel while enabling correct functionality on old
and new kernels. Failing that, software that is not updated will just
stop controlling the fans, ensuring no malignant behavior.

Changes since V2:
    - Add ack by Guenter, move platform move patch to be third (not first
      to allow for device support backport to lts kernels)
    - Rework patch text, especially in the refactor patches as per Derek
    - Change bypass to use charge_behaviour instead of charge_type, as that
      ABI supports capability detection and is more appropriate
    - Move battery attach to probe instead of init
    - Fix bug where reading tt_led would instead use the turbo register

Changes since V1:
    - Add X1 Pro, F1 Pro variants
    - Fix minor typo in initial patches
    - Convert oxp-sensors into a platform driver, as it is no longer
      considered a hwmon driver.
    - Add sysfs documentation and myself to the MAINTAINERS file
    - Update documentation to state that this is the OneXPlayer/AOKZOE
      platform driver, and that support for Ayaneo/OPI is provided until
      they gain their own platform driver.

Antheas Kapenekakis (12):
  hwmon: (oxp-sensors) Distinguish the X1 variants
  hwmon: (oxp-sensors) Add all OneXFly variants
  platform/x86: oxpec: Move hwmon/oxp-sensors to platform/x86
  ABI: testing: add tt_toggle and tt_led entries
  power: supply: add inhibit-charge-s0 to charge_behaviour
  platform/x86: oxpec: Add charge threshold and behaviour to OneXPlayer
  platform/x86: oxpec: Rename ec group to tt_toggle
  platform/x86: oxpec: Add turbo led support to X1 devices
  platform/x86: oxpec: Move pwm_enable read to its own function
  platform/x86: oxpec: Move pwm value read/write to separate functions
  platform/x86: oxpec: Move fan speed read to separate function
  platform/x86: oxpec: Adhere to sysfs-class-hwmon and enable pwm on 2

 Documentation/ABI/testing/sysfs-class-power   |  11 +-
 Documentation/ABI/testing/sysfs-platform-oxp  |  29 +
 Documentation/hwmon/index.rst                 |   2 +-
 Documentation/hwmon/oxp-sensors.rst           |  89 ---
 Documentation/hwmon/oxpec.rst                 |  67 ++
 MAINTAINERS                                   |   7 +-
 drivers/hwmon/Kconfig                         |  11 -
 drivers/hwmon/Makefile                        |   1 -
 drivers/platform/x86/Kconfig                  |  11 +
 drivers/platform/x86/Makefile                 |   3 +
 .../oxp-sensors.c => platform/x86/oxpec.c}    | 675 ++++++++++++++----
 drivers/power/supply/power_supply_sysfs.c     |   1 +
 drivers/power/supply/test_power.c             |   1 +
 include/linux/power_supply.h                  |   1 +
 14 files changed, 664 insertions(+), 245 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-oxp
 delete mode 100644 Documentation/hwmon/oxp-sensors.rst
 create mode 100644 Documentation/hwmon/oxpec.rst
 rename drivers/{hwmon/oxp-sensors.c => platform/x86/oxpec.c} (51%)

-- 
2.48.1


