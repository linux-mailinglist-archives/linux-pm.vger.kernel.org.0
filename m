Return-Path: <linux-pm+bounces-41424-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHnfAgtqdmkVQgEAu9opvQ
	(envelope-from <linux-pm+bounces-41424-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 20:07:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E3D81DF4
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 20:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A58FD30036F9
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jan 2026 19:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2292EDD6C;
	Sun, 25 Jan 2026 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="eXHWiuKw"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26968223323;
	Sun, 25 Jan 2026 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769368070; cv=none; b=FfQa+zwlwcNskJaUkiT/28uayKFgWeTy47yxqCrsM05tVexa7VBilj9TxNdZEC6AiP4vB++cs8YaTGPZToFGFoYKAWLrDObj9f69QQCphDDBpujxIhdDunBStGmGxtBSrr4oMc+xLbksvhRV5NTLFr4Td4Y1TnmcbHmCiI3B5LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769368070; c=relaxed/simple;
	bh=gOabGOqylQEzWUFI9E2WI9zuCeUghVs8Jtc6PGUK2ts=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jaUK86GDM7+invnjbxm2lQV6QraEZxYQymwRplhsxNwMnIbaB4het3Y1tMU1BWeBmZttqo5SOzxSMN7pczUmWAHZCyJ/9Bi/Fj2bJan/vjJiX5j6UipaVkHtSWzlDIUT1SVikW0sgsuz9ibOo4UueG1KhqqVG06TIyWu0pkS52A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=eXHWiuKw; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 855FB28087;
	Sun, 25 Jan 2026 20:07:39 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4JwIcF_fh3ec; Sun, 25 Jan 2026 20:07:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1769368058; bh=gOabGOqylQEzWUFI9E2WI9zuCeUghVs8Jtc6PGUK2ts=;
	h=From:Subject:Date:To:Cc;
	b=eXHWiuKwZ523d2uk2ZJog7UW/jgoitjkna0p/pIvFqSs0yqx7eZ8ceXQ2tzD6E/73
	 B717Vuv2CCJRgYD4j+iV06RzY8gXF5hISgE1nKF6AFKjYF1CyWDSsBjSDNK3urP0JO
	 Deoalx+O1bEGYPLyFMzRZUsqIva3j4PXdB3NO4fGZgD0JwWGy7WRmXAklKeHNZvN98
	 AAZr7WOknEFCR378HFSAV1GWBLlHvjAQyoTzI8vY8jKASLE68/k29kEb3Rf+X9z0yI
	 E3KH2KG0BhNb8zzdkcNgbILaXm/+XkLTPxtz5A4B8tRy4Q7ggPnbuGtIC+PqAm4FgZ
	 eVle/GMjxgyow==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v2 00/12] Support for Samsung S2MU005 PMIC and its
 sub-devices
Date: Mon, 26 Jan 2026 00:37:07 +0530
Message-Id: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANtpdmkC/1XMQQ6CMBCF4auQWVvTaQGFlfcwLGo7wCygpEWiI
 b27lcSFy/8l79shUmCK0BY7BNo4sp9zqFMBdjTzQIJdblBSVYioRFTTU8pKLBNbIW196U39MFZ
 byJclUM+vg7t3uUeOqw/vQ9/wu/6g8h/aUEjRkMZr6bSRtrk5jsH79ezDAF1K6QOTYUiRqgAAA
 A==
X-Change-ID: 20251112-s2mu005-pmic-0c67fa6bac3c
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41424-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[disroot.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71E3D81DF4
X-Rspamd-Action: no action

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
mfd         - 05, 06, 07
led         - 01, 02, 08, 09, 10
extcon      - 03, 11
power       - 04, 12

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Changes in v2:
- Drop [v1 06/13], instead use regmap_irq_chip::get_irq_regs() 
- Remove references to driver in devicetree commits (Conor Dooley)
- Propagate errors of sec_pmic_store_rev() (André Draszik)
- Fix documentation language errors (Randy Dunlap)
- Link to v1: https://lore.kernel.org/r/20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org

---
Kaustabh Chakraborty (12):
      dt-bindings: leds: document Samsung S2M series PMIC flash LED device
      dt-bindings: leds: document Samsung S2M series PMIC RGB LED device
      dt-bindings: extcon: document Samsung S2M series PMIC extcon device
      dt-bindings: power: supply: document Samsung S2M series PMIC charger device
      dt-bindings: mfd: s2mps11: add documentation for S2MU005 PMIC
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
 drivers/extcon/extcon-s2m.c                        | 351 ++++++++++++++++
 drivers/leds/flash/Kconfig                         |  12 +
 drivers/leds/flash/Makefile                        |   1 +
 drivers/leds/flash/leds-s2m-flash.c                | 410 ++++++++++++++++++
 drivers/leds/rgb/Kconfig                           |  11 +
 drivers/leds/rgb/Makefile                          |   1 +
 drivers/leds/rgb/leds-s2m-rgb.c                    | 460 +++++++++++++++++++++
 drivers/mfd/sec-common.c                           |  57 ++-
 drivers/mfd/sec-i2c.c                              |  12 +
 drivers/mfd/sec-irq.c                              |  74 ++++
 drivers/power/supply/Kconfig                       |  11 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/s2m-charger.c                 | 213 ++++++++++
 include/linux/mfd/samsung/core.h                   |   2 +
 include/linux/mfd/samsung/irq.h                    |  66 +++
 include/linux/mfd/samsung/s2mu005.h                | 328 +++++++++++++++
 25 files changed, 2330 insertions(+), 11 deletions(-)
---
base-commit: ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea
change-id: 20251112-s2mu005-pmic-0c67fa6bac3c

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>


