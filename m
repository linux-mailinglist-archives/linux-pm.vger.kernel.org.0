Return-Path: <linux-pm+bounces-24197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEED3A656F8
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 17:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16AE1174744
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 15:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704EF1779B8;
	Mon, 17 Mar 2025 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="J7l8RECT"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECD01714AC;
	Mon, 17 Mar 2025 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226843; cv=none; b=EgP1rGYx3hl3E6YRRG2Zp+05V2Y2mIc4C9mAljtga6zfwDTXRu//0T3PwtOnz1/YDZw98rt3sHmQK8xZ2QWTWRSION0kCxFC1mZhHlJBT3nR2di0MD6XJghKqF7AuRUAiTz+KjasW2r1EHN4mDMU4v2S/dLr5kuEO8tjvyy2OBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226843; c=relaxed/simple;
	bh=n5wYDqdGMEJRH5NUhJc+2NwvLbn09ZJbYxSxcI8GrSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J8+qUq4L7mN6U+2IXNdMOizXKWWe+tzuemRbau/U0wzX/P92s8e5pd8ZhRF0cpotBmcUHXVwVyPlMeV48Cfja58qImUF0CmSJ3/A8pq83ZWxcH1SxOGYd13P+GfZjTD609Fmf10vvKQiHHDmav7mdzMbs98BUcyybKFkK5WFeVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=J7l8RECT; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 57FAD2E09477;
	Mon, 17 Mar 2025 17:53:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742226837;
	bh=VRDj7bi2CG45dn9CIeYEDKL2Bxp5rzeEmni4go+yChY=; h=From:To:Subject;
	b=J7l8RECT3LwTkTZCnQpDsX+YU0E2gH9nLSLP35bTBWJ4C95UWmDPG4DsYhawQVUgS
	 tyqBN/WKdf3tfV2uNNARQOGIEz9CrNml1IpN8xl4V4VmCa3B3ITSTdwrsChjwp5N1v
	 fUwyXgc1y9p7M5dsvMukUZZHdgrFn5nJFXz1QdCc=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:cbc0:999f:73ad:33bd) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
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
	linux-kernel@vger.kernel.org,
	sre@kernel.org,
	linux@weissschuh.net,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v5 00/13] hwmon: (oxpsensors) Add devices, features,
 fix ABI and move to platform/x86
Date: Mon, 17 Mar 2025 16:53:36 +0100
Message-ID: <20250317155349.1236188-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174222683684.22311.8452196421546063515@linux1587.grserver.gr>
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

---
V4: https://lore.kernel.org/all/20250311165406.331046-1-lkml@antheas.dev/
V3: https://lore.kernel.org/all/20250309112114.1177361-1-lkml@antheas.dev/

Changes since V4:
    - Fix nits by Hans
    - change inhibit-charge-s0 to inhibit-charge-awake
    - use devm_battery_hook_register and power_supply_unregister_extension
      (based on cros driver)
    - move charge behavior patches to the end to make the rest of the series
      easier to merge
    - CC platform-x86 and power maintainers

Changes since V3:
    - Fix nits by Derek
    - Remove the hwmon documentation as it is not required for platform
      drivers (suggested by Guenter)
    - Add ACPI_BATTERY and HWMON depends to Kconfig
      (reported by kernel robot)
    - Homogenize driver into following reverse xmas convention

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

Antheas Kapenekakis (13):
  hwmon: (oxp-sensors) Distinguish the X1 variants
  hwmon: (oxp-sensors) Add all OneXFly variants
  platform/x86: oxpec: Move hwmon/oxp-sensors to platform/x86
  ABI: testing: add tt_toggle and tt_led entries
  platform/x86: oxpec: Rename ec group to tt_toggle
  platform/x86: oxpec: Add turbo led support to X1 devices
  platform/x86: oxpec: Move pwm_enable read to its own function
  platform/x86: oxpec: Move pwm value read/write to separate functions
  platform/x86: oxpec: Move fan speed read to separate function
  platform/x86: oxpec: Adhere to sysfs-class-hwmon and enable pwm on 2
  platform/x86: oxpec: Follow reverse xmas convention for tt_toggle
  power: supply: add inhibit-charge-awake to charge_behaviour
  platform/x86: oxpec: Add charge threshold and behaviour to OneXPlayer

 Documentation/ABI/testing/sysfs-class-power   |  11 +-
 Documentation/ABI/testing/sysfs-platform-oxp  |  26 +
 Documentation/hwmon/index.rst                 |   2 +-
 Documentation/hwmon/oxp-sensors.rst           |  89 ---
 MAINTAINERS                                   |   7 +-
 drivers/hwmon/Kconfig                         |  11 -
 drivers/hwmon/Makefile                        |   1 -
 drivers/platform/x86/Kconfig                  |  13 +
 drivers/platform/x86/Makefile                 |   3 +
 .../oxp-sensors.c => platform/x86/oxpec.c}    | 628 ++++++++++++++----
 drivers/power/supply/power_supply_sysfs.c     |   1 +
 drivers/power/supply/test_power.c             |   1 +
 include/linux/power_supply.h                  |   1 +
 13 files changed, 542 insertions(+), 252 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-oxp
 delete mode 100644 Documentation/hwmon/oxp-sensors.rst
 rename drivers/{hwmon/oxp-sensors.c => platform/x86/oxpec.c} (52%)


base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
-- 
2.48.1


