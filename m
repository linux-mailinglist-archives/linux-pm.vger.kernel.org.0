Return-Path: <linux-pm+bounces-22736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2D1A40A0F
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 17:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF2A17F0A3
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2025 16:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83D7207A14;
	Sat, 22 Feb 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="E8wyQwe/"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE47019E975;
	Sat, 22 Feb 2025 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740241812; cv=none; b=ACqF0vF6mEY0Vfwvv9rsbA4DVaOFRGpNXWvvq8T8K0o0V+FF0l7dTlnRlWkMgd5883L2XaWDZkUMurAlFT2sQmSm8CZoHpauQk1x7WGsImY2exXvETLWxkEt4CEAbKLAXkJW+1Dxh7h0kuqj0j257ueuNogL1TQ/vdi691W1hx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740241812; c=relaxed/simple;
	bh=jyqvHSFqOFsY1PXsSSN904r8wYVR6DvtzhnRyZ+hGf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fM5kGUrxkLjmAH0PuhYjR1asoxYXnjzTghqqs/vi6NkHQ9HswwJWpb+0L6Yc9xBbqXeTxnlWEPBq2UgEIZewh5af6ISH7Gmjxt2GJ5lIwYC8qDQ49eTPWn8NHzBJZnTeJMcLOxKoFcxn4GNyR4mxU9jMEKbZqRpUHMaThbNRoyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=E8wyQwe/; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:cbc0:999f:73ad:33bd])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 4FC342E08C2F;
	Sat, 22 Feb 2025 18:20:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740241223;
	bh=6qQL+zKQxfhiEopyGjxPkJmskcBXM7Vdkt09g7USSlE=; h=From:To:Subject;
	b=E8wyQwe/oB/HRGLEyE5ri2VrVxtXndjLoKtw6BfBeyPYethHCnhqruMNwXTVynaWr
	 WAeLSx9Aa9je7B1/nop/2M+KF4RpLnIJmwBDtGDvoHb3W9u4Q+WmfKz7XfMeNANJRq
	 wGAuKXWe8vI0jdNJTALfrPAkxClfYGlhulvI/3co=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:cbc0:999f:73ad:33bd) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: linux-hwmon@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
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
Subject: [PATCH v2 00/12] hwmon: (oxpsensors) Add devices, features,
 fix ABI and move to platform/x86
Date: Sat, 22 Feb 2025 17:18:11 +0100
Message-ID: <20250222161824.172511-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174024122356.13470.8646678086481011352@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

This four part series updates the oxpsensors module to bring it in line
with its Windows OneXPlayer counterpart. First, it adds support for all
2024, 2025 OneXPlayer handhelds and their special variants.

Then, it adds the new charge limiting and bypass features that were first
introduced in the X1 and retrofit to older OneXFly variants and for
controlling the turbo led found in the X1 models. For Bypass, it adds a new
bypass variant BypassS0 that is only active while the device is in the S0
state.

Then, it performs a minor refactor by moving around switch statements
into their own functions, in order to allow for fixing the pwm1_enable ABI
in the final patch. Currently, pwm1_enable sets the fan to auto with the
value 0 and allows manual control with the value 1. This patch makes it
so 0 sets the fan to full speed, 1 sets the fan to manual control, and
2 sets the fan to auto. This requires both setting enable and the fan
speed when the enable sysfs is written to as 0, hence the refactor.

As this is a breaking ABI change and there is userspace software relying
on this previous behavior, the last patch also changes the /name of the
hwmon endpoint to "oxp_ec" from "oxpec" (mirroring WMI module conventions)
such that userspace software that relied on the previous behavior can be
retrofit to the new kernel while enabling correct functionality on old
and new kernels. Failing that, software that is not updated will just
stop controlling the fans, ensuring no malignant behavior.

Finally, the oxp-sensors module is converted into the oxpec platform driver
in order for it to stay as a single unit. Then, the appropriate
documentation for it is added.

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
  ABI: testing: sysfs-class-power: add BypassS0 charge_type
  hwmon: (oxp-sensors) Add charge threshold and bypass to OneXPlayer
  hwmon: (oxp-sensors) Rename ec group to tt_toggle
  hwmon: (oxp-sensors) Add turbo led support to X1 devices
  hwmon: (oxp-sensors) Move pwm_enable read to its own function
  hwmon: (oxp-sensors) Move pwm value read/write to separate functions
  hwmon: (oxp-sensors) Move fan speed read to separate function
  hwmon: (oxp-sensors) Adhere to sysfs-class-hwmon and enable pwm on 2
  platform/x86: oxpec: Move hwmon/oxp-sensors to platform/x86
  ABI: testing: add tt_toggle and tt_led entries

 Documentation/ABI/testing/sysfs-class-power   |   6 +-
 Documentation/ABI/testing/sysfs-platform-oxp  |  29 +
 Documentation/hwmon/index.rst                 |   2 +-
 Documentation/hwmon/oxp-sensors.rst           |  89 ---
 Documentation/hwmon/oxpec.rst                 |  67 ++
 MAINTAINERS                                   |   7 +-
 drivers/hwmon/Kconfig                         |  11 -
 drivers/hwmon/Makefile                        |   1 -
 drivers/platform/x86/Kconfig                  |  11 +
 drivers/platform/x86/Makefile                 |   3 +
 .../oxp-sensors.c => platform/x86/oxpec.c}    | 664 ++++++++++++++----
 11 files changed, 649 insertions(+), 241 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-oxp
 delete mode 100644 Documentation/hwmon/oxp-sensors.rst
 create mode 100644 Documentation/hwmon/oxpec.rst
 rename drivers/{hwmon/oxp-sensors.c => platform/x86/oxpec.c} (52%)

-- 
2.48.1


