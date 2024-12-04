Return-Path: <linux-pm+bounces-18568-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739419E4554
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 21:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29684284600
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 20:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811341F03EF;
	Wed,  4 Dec 2024 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1BwHGaH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBE31F03DF;
	Wed,  4 Dec 2024 20:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343010; cv=none; b=nJxHaiSwlyCWLr748Ya5nQzoAxKtYab7jj+zFHrzbyfcaxSDl412bLP1ZDDLxnK2JdqpwiAMbBPR+TfCi6YZFTYy2u44RS8OjLr9lJQcyMuZ3vw86iEp3ow5g/i6W9wGn37ODBeeSrj270c3WIGAIr7Gf5qa7dThqiAddf4EJNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343010; c=relaxed/simple;
	bh=QPLa0r+6p8PLfccDRaeRG4DbcK4v55uLKkJBlNlcdC8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HBJIOwTNJ4Y1S170dga8IuzpxU0pi7cPm4lTBp5HQgR88ATBxscyj4Llu8TBauaQ3Vjolo95mTsTcMo9lj86mF/Kw9gs0/KuL0tYAP5yyUIeWalGrP8IdxfsZ7XIlkTTPcShCF2swCGIWGYxdvrxohLeHRldxpEgPWFsj7EdEDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1BwHGaH; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cf6f367f97so190165a12.0;
        Wed, 04 Dec 2024 12:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733343006; x=1733947806; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iR3FhZB90yY2CtQD1Z8nT3lcBvWhMlkfTygUbcwhlIE=;
        b=L1BwHGaHBlZ4r2uaSg9wed2d3+gO+BtaFTex0z82UWtvBKD2azHn52To95F8ErjZBs
         xK76Fs2I+ARdRuzO3jyh+a64wi1KHDBGR7hMfulDuYil2kreXAREQW24iLASNCcsSLqJ
         84voq7POuidsJvnYov6V62oHVkdx6iXw/WuHcVmvdxVHyRyJBFZsKKI0UBvH1UaJ7q8O
         /7Md7lWh0tc5Ezw+V38/KlMhQZjNUV8e8hjJMR4lZYK0RrBN/rKo+vyosyrcmA9Wvc3a
         y4jpaJuNrSjn7NtCQjg3xV+hJZXPSAS+512ovTq11uxmX00Ibr6W4z1vvsXKErINoJOK
         4Ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343006; x=1733947806;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iR3FhZB90yY2CtQD1Z8nT3lcBvWhMlkfTygUbcwhlIE=;
        b=DknCH2WYTzYiW3X7Rodik8+M4ZXmLOJEN9aC6lrFhtyRyBcmUBvdmLADFBUdrO+X8P
         zY4wUOOyWauxdelzbDPuZaRoU7q+o7IW4s3OAYq/89ddzNEEB45hqovRJ7dyK4eicxG5
         QnMYYdwyESoGmxMzU8bGmSS7KqY+miw2Epsm/E8xbgPN7iMIUQ/sI0EVeb/Yojvo5eNZ
         9hqmZQ7/rolIyApG3ndKqa3Jn41bN3E1pwOBwBvbCwxBBR+DjGmmgnmEgyaN7gmQQxpN
         Riax0DsGnlOQazZ5/6dCQ8pBNiSVbfMFeJmKRVnQnyij4WAoJZuYoaow3XgPcGF4Msez
         6p3g==
X-Forwarded-Encrypted: i=1; AJvYcCUAqQJ9bYBenKxSI5OVXHB4K3xwCPzP7BVAqSHOzcCH4lRfJVa0S+w2wEgQO5sRDshtQfdv8tMMaEz13kEE@vger.kernel.org, AJvYcCW1ne5tNPM1HXArXde72orQuitE/hnZ1zNnc/ReGSdgZkiCplEWpzrSHl++5hr0+Q/MYt2G8A3o9DKWMqc=@vger.kernel.org, AJvYcCW4U68grR7KtA3/p9cy8J5asYje014eBj5Fd4WSqhPC/daWr5fQeg5z5qXeupmMZW30Gp1kxeuif1XtCA==@vger.kernel.org, AJvYcCWv+2wwyooKPMUbp4IXLfSZ7ii+af/BZgZ4ghIRgpN2D3nzHV80U+C/2w/ybo9ULbJCouzfvHYnLC1V@vger.kernel.org
X-Gm-Message-State: AOJu0Yw91hrAl2i7xpsOb+qIZdEiiTSszLc/lXn5DvEvH+Qsy6coXn9P
	dEZhK5wAlFokyG9bYIPcclO/2Y84S/2DQ9aezNC4Mke/4ZBZMZJXjQcvGg==
X-Gm-Gg: ASbGncv6/yLpGFG3mir840XZegNNvZ7Jx4b0LmFUEuAwaTAoWY04OfZLoqRE2VOwH1S
	cgV8OjKwk90s55OrSVZDxDoFGHWjqpKdZj+b14RaO2qhuUJGpE1JdKBrnAczASBFxdJR2Pl6hBl
	kzWO9HmnvmPvQl3vktHZyXDdlLdBVLS7OPERcMEB6dgMggo3J7p2/K99G4Wls8Ufi6jZ4xY3vge
	dFSpiADkHgj36XCrviILBFtH+WwJqVA6000cTFzcwtknP0v
X-Google-Smtp-Source: AGHT+IEUUgdhIfO47YE8X0YhH4Y6sYmYrtouHL+4ILHkEsbtMSf1sDjiOZAZuFHaFJt/fsJw5HCJAw==
X-Received: by 2002:a05:6402:2743:b0:5cf:bb9e:cca7 with SMTP id 4fb4d7f45d1cf-5d10cb9ae01mr9440108a12.28.1733343005941;
        Wed, 04 Dec 2024 12:10:05 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d0b7ce5584sm6266526a12.54.2024.12.04.12.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 12:10:04 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v10 0/8] Add support for Maxim Integrated MAX77705 PMIC
Date: Wed, 04 Dec 2024 23:09:50 +0300
Message-Id: <20241204-starqltechn_integration_upstream-v10-0-7de85e48e562@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAA+3UGcC/43SUW+DIBAH8K/S+DyWAxTQp32PpWkOhEqitkVru
 jT97jvbbDXdw3wh4Qy/O/B/zQafoh+yanPNkp/iEA89bTi8bTLXYL/3LNZUyASIHBTXbBgxndr
 Ru6bfxX70+4QjHdqdj8OYPHbMOqNMAVYELzNiLA6e2YS9awjqz21LxWPyIV7ujT+3tG/iMB7S1
 32OSc7Vn47m/46TZMC8DEopAVyj+9h3GNt3d+iyGZ/yJ1hyuQLMCRS18KEuXGG0fgWL5YQr3mQ
 q5gkBpAw85zX/A6pfkAOsARWBUEtjCyjBFX9AvQDFmitrAksbEGXIkSO8gmYBSr4CNPMbBqSf4
 oSU4F/B8gnSsgIsCaTJaictemHNErw9MpX86UwZHh/BekSPvndxrDYhN8oZRK6s4VoEJW1dOw2
 cKwRnSo06yAAiW0a/2twH5GCYzVmHF64hF6yUoILTBQb0FcVre7t9AxPTlTlLAwAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733343003; l=4992;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=QPLa0r+6p8PLfccDRaeRG4DbcK4v55uLKkJBlNlcdC8=;
 b=OfzIXUB5S/YQ9pEPQ6Qro0CsjNNBncwzoUVtA9/KvcXXCUgVb6o/U0EhiWdnnLnBAv/sU5Lvi
 iEnds+4/x/WD6acv8E8Q9X+S2g0kQZzK8imBMFQk2BWSvTCRdguMzbf
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
Changes in v10:
- drop NACKed 'dt-bindings: power: supply: max17042: remove reg from
  required' patch
- review fixes
- use dev_err_probe for errors in probe functions
- Link to v9: https://lore.kernel.org/r/20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com

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
Dzmitry Sankouski (8):
      power: supply: add undervoltage health status property
      dt-bindings: power: supply: max17042: add max77705 support
      dt-bindings: mfd: add maxim,max77705
      power: supply: max17042: add max77705 fuel gauge support
      mfd: Add new driver for MAX77705 PMIC
      input: max77693: add max77705 haptic support
      power: supply: max77705: Add charger driver for Maxim 77705
      leds: max77705: Add LEDs support

 Documentation/ABI/testing/sysfs-class-power                        |   2 +-
 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml          | 192 +++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml |   1 +
 MAINTAINERS                                                        |   4 +
 drivers/input/misc/Kconfig                                         |   4 +-
 drivers/input/misc/Makefile                                        |   1 +
 drivers/input/misc/max77693-haptic.c                               |  15 ++-
 drivers/leds/Kconfig                                               |   6 ++
 drivers/leds/Makefile                                              |   1 +
 drivers/leds/leds-max77705.c                                       | 267 +++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig                                                |  12 +++
 drivers/mfd/Makefile                                               |   2 +
 drivers/mfd/max77705.c                                             | 233 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/supply/Kconfig                                       |   6 ++
 drivers/power/supply/Makefile                                      |   1 +
 drivers/power/supply/max17042_battery.c                            |   3 +
 drivers/power/supply/max77705_charger.c                            | 590 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c                          |   1 +
 include/linux/mfd/max77693-common.h                                |   4 +-
 include/linux/mfd/max77705-private.h                               | 194 +++++++++++++++++++++++++++++++++++++
 include/linux/power/max77705_charger.h                             | 194 +++++++++++++++++++++++++++++++++++++
 include/linux/power_supply.h                                       |   1 +
 22 files changed, 1729 insertions(+), 5 deletions(-)
---
base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
change-id: 20240617-starqltechn_integration_upstream-bc86850b2fe3
prerequisite-change-id: 20241108-b4-max17042-9306fc75afae:v4
prerequisite-patch-id: a78c51c4a1b48756c00cbc3d56b9e019577e4a6b
prerequisite-patch-id: 735d52c3137c5e474f3601adf010f9fe2f3f7036

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


