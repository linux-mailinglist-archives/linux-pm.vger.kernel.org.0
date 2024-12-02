Return-Path: <linux-pm+bounces-18323-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A5E9DFD90
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 10:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B02E6B235FC
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 09:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64411FAC5D;
	Mon,  2 Dec 2024 09:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvNXjOX6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37E01F949;
	Mon,  2 Dec 2024 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132888; cv=none; b=SHZ2JU7cPeOOsr9kpGjkcdJHDACmM8+noOBA0g/7A2vI2e4fucbtr84Xja8My3rOXE4mMLHrpvLHtYyy7GkE4mw8kJKfTQZwmJoDPNpnvpIdfstuLLXkJslUmotrUTMh4XJi9GBmm+Vf9pn7jSPJO8Vu86nYQt94LfERRXOmTT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132888; c=relaxed/simple;
	bh=GpuiRxKpKHEvDKdMNF5QTyrERvm/8NCuGObcOQW3KF8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oRiOkvCGOFwPd0phG4gzt8YnMUSVrE0pASlriIUzcR79vjXz60LP0r4OCDCUhZ+NVl5sM0BMl6bmprT5S1Y4iZVGD1+x3iR4Ks6tQFXkKMmSiGgHQI1vE82eLi+0Yg3OmeYeYSzxEcRAIOPpiFmxnSLaWHWWeCNbFnbj5LRZrpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvNXjOX6; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53df119675dso4711805e87.0;
        Mon, 02 Dec 2024 01:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733132885; x=1733737685; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ScD9lwLI9SiaA1iDKeA12JO9Y8oY8UnkZB8b2vIVxvU=;
        b=lvNXjOX67M8vY69owo4ql0n+oeVChb/YUuUz9k3bELjIM91GmEyR4t0Wv8bSq/eWV4
         vlJ+dFrrHWh7iO8bqQd7s+C75CnzTLT+Py/Y3jUVug3fufX88y+wrC8+7Hp1d2YPhhAX
         jRuB3za1dLP151xdxMC3fVixqhHn5fT1dNBcx2K5w3u1uEH3bexCZlZNo8YZfAFd+ebL
         mhiKn9Iukn+OAIZlc7H6s2W0jgWFgc47h2Gan6CDdUtJ0hTcn6bRh9Q1QyqTd3Y9TetP
         I3jPih9GOVUOT/XhmQrB9wCdqTyOL7cGu52HTD4wLX555SxIsVHgvfN5clH9WZhf20R4
         5mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733132885; x=1733737685;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ScD9lwLI9SiaA1iDKeA12JO9Y8oY8UnkZB8b2vIVxvU=;
        b=SPtQDSkqhWHQlcfadiQn2lxx03TIqnadbREyhUwKsBpAypamt96ET8mH+SICDQEu1O
         Lw70BQC7k+YTFgsYE3pAHfcKtCNlgSzI5xMcKv42KKcfSdk7iWN2L3/7V5lGxvMvqABb
         luKb6+nrFg2VP8MnhZ/jenDg0msJrd5/XlR1n6Dexd6UAspCZlW4V7ByTyzFvPC1+YBU
         EZywnEnotnWxjpBjXe22RKB6YxmISZL23s61p2URr/IDeMwgM2TAS/SPZLuXyu38e6XP
         I1ozSDZtZJp9hELL0TxEs4UaqZEeoXkbprJpD/UxC20Odp4bWw/BVr4nSq7cmANHbDBm
         eO8w==
X-Forwarded-Encrypted: i=1; AJvYcCVoUPL198VMnbNpoGL8zvMmegrk67XNk25hxgxnK1bbA73CCmoaDGiYUcs8CFI8ahW9Atz+HGaTJFp5itI=@vger.kernel.org, AJvYcCWPtP4UWD+r0roT5Fu6eN574y7NtGXgbuJpf2bDU3xrmarO6u76dA/XujKlYbHhN4ydREk3MvNPi5SIoiLo@vger.kernel.org, AJvYcCXCR/wRgNV4Jp5PtWRd8l/euvBWlDGANGqUN18BxSsrkMMFUh67FYcEkK4tUfT/y4r7BeLGSDh7oUfyBQ==@vger.kernel.org, AJvYcCXMEzlQMdK8autRtnCHSqAbeTjB26M2o7YIIJqPEo5Wxzrv3ZaaKJetCYt8599IhY4D3mDN4SkAQ+RE@vger.kernel.org
X-Gm-Message-State: AOJu0YxfKCYsi5ni/q0Zo5Dvhow7kFJjfBltZufz6Zz38UlhZ7t/iNs3
	81MF6kaW6Da1f5ABHuHuNhLs6WFWRMX0oUSiq9M0RBpjggqi0SCl
X-Gm-Gg: ASbGncu1oyb7qfOj5UzFb/qMXMgjbt/W80muSTNZZC0VBor6rSoWxB7kSirCzMD2Tm1
	0nuH0Gvs+TqUgSOg69isyzttH6avfktQeg0oXbh1FIm1g8ZKRoUzzl1gKoB29m5zkfgpGYXJGGD
	OWgTzED06I7bX7JedVi/RiAtz41YW8O7XQoWU1yMXgvWwZbuRez6kgTWKxyE16Iy03LCJKMPILG
	SoSBiVf3o7l09is2ai6fOJIDhFV6p9DRGiYUz7AwlNg5hAJ
X-Google-Smtp-Source: AGHT+IGBBCQpyC6YYZFydkHbVoyJnSEFFoGYo8/wlqTkDjH3EeFk+xoPGmCGIx5aY9ktaAtUxmOWnw==
X-Received: by 2002:a05:6512:3e05:b0:53d:edf6:c560 with SMTP id 2adb3069b0e04-53df00dc8b4mr9798289e87.29.1733132884528;
        Mon, 02 Dec 2024 01:48:04 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa599957594sm487059766b.197.2024.12.02.01.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:48:04 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v9 0/9] Add support for Maxim Integrated MAX77705 PMIC
Date: Mon, 02 Dec 2024 12:47:53 +0300
Message-Id: <20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEqCTWcC/43SS27DIBAG4KtErEs1PAzYq96jiqIBQ4xkOwl2r
 FRR7l6cqK2VLOrlgPhmgP9KBp+iH0i1uZLkpzjEQ5+L8m1DXIP93tNY55pw4BIU03QYMZ3a0bu
 m38V+9PuEYz6zOx+HMXnsqHVGmQIsD16QzFgcPLUJe9dkqD+3bV48Jh/i5d73c5vrJg7jIX3dx
 5jEvPrT0fzfcRIUqBdBKcWBaXQf+w5j++4OHZnxSf6BJRMrQJlBXnMf6sIVRutnsFhOuOJNpmK
 eEECIwCSr2QuofkEGsAZUGYRaGFtACa54AfUC5GuurDNY2oAogkSG8AyaBSjYCtDMbxgwf4rjQ
 oBfgrdHBJI/nXPixkcOHknJ+10cq02QRjmDyJQ1TPOghK1rp4ExheBMqVEHEYCTZVKrzX1ABoZ
 aSTu8MA2S01KACk4XGNBXOQ3b2+0bPnwrBvkCAAA=
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733132883; l=4756;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=GpuiRxKpKHEvDKdMNF5QTyrERvm/8NCuGObcOQW3KF8=;
 b=zGAthYwACb3XoEKMBLjXVmyytbGHHdO7Fw1pjBPYlAHJ/6AvALWSz+A6dWgdBQuCMSYgA03Ax
 dQCDyL6eHzYCXxRpHU9hpWSJJ1Z6DsdMNk//bZH/VtGnF4Uro68cfIA
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

The Maxim MAX77705 is a Companion Power Management and Type-C
interface IC which includes charger, fuelgauge, LED, haptic motor driver and
Type-C management IC. It's used in Samsung S series smart phones
starting from S9 model.

Add features:
  - charger
  - fuelgauge
  - haptic
  - led

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v9:
- fuel gauge: use max17042 driver instead of separate max77705
- fix kernel bot error
- charger: enable interrupt after power supply registration
- add dependency on max17042 patch series
- Link to v8: https://lore.kernel.org/r/20241031-starqltechn_integration_upstream-v8-0-2fa666c2330e@gmail.com

Changes in v8:
- Fix comment style
- join line where possible to fit in 100 chars
- Link to v7: https://lore.kernel.org/r/20241023-starqltechn_integration_upstream-v7-0-9bfaa3f4a1a0@gmail.com

Changes in v7:
- Fix review comments
- Link to v6: https://lore.kernel.org/r/20241007-starqltechn_integration_upstream-v6-0-0d38b5090c57@gmail.com

Changes in v6:
- fix binding review comments
- update trailers
- Link to v5: https://lore.kernel.org/r/20240617-starqltechn_integration_upstream-v5-0-e0033f141d17@gmail.com

Changes in v5:
- Split patchset per subsystem
- Link to v4: https://lore.kernel.org/r/20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com

Changes in v4:
- Rewrite max77705, max77705_charger, max77705_fuel_gauge from scratch
- Reorder patches:
  - squash max77705 subdevice bindings in core file because
    no resources there
  - split device tree changes
- Use _ as space for filenames in power/supply like the majority
- Link to v3: https://lore.kernel.org/r/20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com

---
Dzmitry Sankouski (9):
      power: supply: add undervoltage health status property
      dt-bindings: power: supply: max17042: add max77705 support
      dt-bindings: power: supply: max17042: remove reg from required
      dt-bindings: mfd: add maxim,max77705
      power: supply: max17042: add max77705 fuel gauge support
      mfd: Add new driver for MAX77705 PMIC
      input: max77693: add max77705 haptic support
      power: supply: max77705: Add charger driver for Maxim 77705
      leds: max77705: Add LEDs support

 Documentation/ABI/testing/sysfs-class-power                        |   2 +-
 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml          | 155 +++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml |   2 +-
 MAINTAINERS                                                        |   4 +
 drivers/input/misc/Kconfig                                         |   4 +-
 drivers/input/misc/Makefile                                        |   1 +
 drivers/input/misc/max77693-haptic.c                               |  15 ++-
 drivers/leds/Kconfig                                               |   6 ++
 drivers/leds/Makefile                                              |   1 +
 drivers/leds/leds-max77705.c                                       | 167 ++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig                                                |  12 +++
 drivers/mfd/Makefile                                               |   2 +
 drivers/mfd/max77705.c                                             | 242 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/supply/Kconfig                                       |   6 ++
 drivers/power/supply/Makefile                                      |   1 +
 drivers/power/supply/max17042_battery.c                            |   3 +
 drivers/power/supply/max77705_charger.c                            | 599 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c                          |   1 +
 include/linux/mfd/max77693-common.h                                |   5 +-
 include/linux/mfd/max77705-private.h                               | 199 ++++++++++++++++++++++++++++++++++++++
 include/linux/power/max77705_charger.h                             | 216 +++++++++++++++++++++++++++++++++++++++++
 include/linux/power_supply.h                                       |   1 +
 22 files changed, 1638 insertions(+), 6 deletions(-)
---
base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
change-id: 20240617-starqltechn_integration_upstream-bc86850b2fe3
prerequisite-change-id: 20241108-b4-max17042-9306fc75afae:v4
prerequisite-patch-id: a78c51c4a1b48756c00cbc3d56b9e019577e4a6b
prerequisite-patch-id: 735d52c3137c5e474f3601adf010f9fe2f3f7036

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


