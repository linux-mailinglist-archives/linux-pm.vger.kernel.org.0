Return-Path: <linux-pm+bounces-37971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 591FEC59997
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 20:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AEC5F3442D0
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 19:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E3731814F;
	Thu, 13 Nov 2025 19:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="KOikJ6xR"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67011313529;
	Thu, 13 Nov 2025 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060732; cv=none; b=BSvNFEF2Rx0QWaUt5MpBxH6sUkjrwz/yQoZ6Iew98oV64Yi+B2O9f6PDmSG2GZT6+2hoXbLN2pJbc+MHhBsD3KQnuMFBDUaLevEZstmefPahjbVswzqXoxZS6tPA+8tPqm6Ze60xKoWc/wV+SinNl34nXwkDlfYwwg51oQ5dyxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060732; c=relaxed/simple;
	bh=xbsJgSP/qfdSCYvBFIjxcuGK2HLNSgntGJrudJXGpGE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CYOC5lAtDCGigBPTqm0ELRXfyiC19P6cNKVr8GqB2kAL8HXtmjpTs5yel4tkydZCJ9UtnvWF9kRQiolpFBsu+sHQjI9lpW9c+sJ2TxcPmAwSHNzWP74GQzmBz0Iy8YKGdD5qlbHXqBYcfTvtGCKWjvXd7mcmM2fpCFsuguvO0/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=KOikJ6xR; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A4006264C2;
	Thu, 13 Nov 2025 20:05:27 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cVVbP0EOnFVw; Thu, 13 Nov 2025 20:05:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1763060727; bh=xbsJgSP/qfdSCYvBFIjxcuGK2HLNSgntGJrudJXGpGE=;
	h=From:Subject:Date:To:Cc;
	b=KOikJ6xRJHpCFTI/IIBv1x8rSDYBLfgSMh9rKWcN5FiFD9GTD+S8ktgGR3JSvzm84
	 0xdJl1jE+pMK76FoZ2piHSO1IccpEXEQ9bomElLgh80726rKxRTd1jTcs1XdUlmUQq
	 AGxS5iDOodDd7gTXYQwxQoGoPD6i/F3dplQeTi30OGt09aAg8h2ySEvuuDQl8//u4I
	 C1mc8Qz8pFJjwdYv/908gh3ceaDLKOc7qDCTMRJBd5QKFNSl0+cw/ZqzKKIZNUvQY1
	 t3SXCgcS4PGfrFYdP0lqTqV5lPCTYXQer6mnf0hUuc9W00h+xJIgfx84VLvn37Y5OB
	 4xSuRWpJTsTpw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 00/13] Support for Samsung S2MU005 PMIC and its sub-devices
Date: Fri, 14 Nov 2025 00:35:01 +0530
Message-Id: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN0rFmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQ0Mj3WKj3FIDA1PdgtzMZF2DZDPztESzpMRk42QloJaCotS0zAqwcdG
 xtbUAuSre+V4AAAA=
X-Change-ID: 20251112-s2mu005-pmic-0c67fa6bac3c
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763060713; l=4075;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=xbsJgSP/qfdSCYvBFIjxcuGK2HLNSgntGJrudJXGpGE=;
 b=BtLrXuFPHG7bSTiR5t6fQiSMgXQ+caOKS4PELrmBT94oWUNgGzcGPA3OMy56H2k1iPz9Y0ktH
 dTdDg5YNfc3BqiZIqypdiFUb4NME3nHGoQx3bnRuOHcdyzmAGCjy6E+
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

S2MU005 is an MFD chip manufactured by Samsung Electronics. This is
found in various devices manufactured by Samsung and others, including
all Exynos 7870 devices. It is known to have the following features:

1. Two LED channels with adjustable brightness for use as a torch, or a
   flash strobe.
2. An RGB LED with 8-bit channels. Usually programmed as a notification
   indicator.
3. An MUIC, which works with USB micro-B (and USB-C?). For the micro-B
   variant though, it measures the ID-GND resistance using an internal
   ADC.
4. A charger device, which reports if charger is online, voltage,
   resistance, etc.

This patch series implements a lot of these features. Naturally, this
series touches upon a lot of subsystems. The 'parent' is the MFD driver,
so the subsystems have some form of dependency to the MFD driver, so
they are not separable.

Here are the subsystems corresponding to the patch numbers:
dt-bindings - 01, 02, 03, 04, 05
mfd         - 05, 06, 07, 08
rtc         - 06
led         - 01, 02, 09, 10, 11
extcon      - 03, 12
power       - 04, 13

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Kaustabh Chakraborty (13):
      dt-bindings: leds: document Samsung S2M series PMIC flash LED device
      dt-bindings: leds: document Samsung S2M series PMIC RGB LED device
      dt-bindings: extcon: document Samsung S2M series PMIC extcon device
      dt-bindings: power: supply: document Samsung S2M series PMIC charger device
      dt-bindings: mfd: s2mps11: add documentation for S2MU005 PMIC
      mfd: sec-irq: add support for creating multiple IRQ chips
      mfd: sec: add support for S2MU005 PMIC
      mfd: sec: store hardware revision in sec_pmic_dev and add S2MU005 support
      leds: flash: add support for Samsung S2M series PMIC flash LED device
      leds: rgb: add support for Samsung S2M series PMIC RGB LED device
      Documentation: leds: document pattern behavior of Samsung S2M series PMIC RGB LEDs
      extcon: add support for Samsung S2M series PMIC extcon devices
      power: supply: add support for Samsung S2M series PMIC charger device

 .../bindings/extcon/samsung,s2mu005-muic.yaml      |  35 ++
 .../bindings/leds/samsung,s2mu005-flash.yaml       |  52 +++
 .../bindings/leds/samsung,s2mu005-rgb.yaml         |  34 ++
 .../devicetree/bindings/mfd/samsung,s2mps11.yaml   | 103 ++++-
 .../power/supply/samsung,s2mu005-charger.yaml      |  35 ++
 Documentation/leds/index.rst                       |   1 +
 Documentation/leds/leds-s2m-rgb.rst                |  60 +++
 drivers/extcon/Kconfig                             |  10 +
 drivers/extcon/Makefile                            |   1 +
 drivers/extcon/extcon-s2m.c                        | 355 ++++++++++++++++
 drivers/leds/flash/Kconfig                         |  12 +
 drivers/leds/flash/Makefile                        |   1 +
 drivers/leds/flash/leds-s2m-flash.c                | 413 ++++++++++++++++++
 drivers/leds/rgb/Kconfig                           |  11 +
 drivers/leds/rgb/Makefile                          |   1 +
 drivers/leds/rgb/leds-s2m-rgb.c                    | 462 +++++++++++++++++++++
 drivers/mfd/sec-common.c                           |  41 +-
 drivers/mfd/sec-i2c.c                              |  29 ++
 drivers/mfd/sec-irq.c                              | 234 ++++++++---
 drivers/power/supply/Kconfig                       |  11 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/s2m-charger.c                 | 216 ++++++++++
 drivers/rtc/rtc-s5m.c                              |  15 +-
 include/linux/mfd/samsung/core.h                   |   9 +-
 include/linux/mfd/samsung/irq.h                    |  94 +++++
 include/linux/mfd/samsung/s2mu005.h                | 328 +++++++++++++++
 26 files changed, 2487 insertions(+), 77 deletions(-)
---
base-commit: 131f3d9446a6075192cdd91f197989d98302faa6
change-id: 20251112-s2mu005-pmic-0c67fa6bac3c

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>


