Return-Path: <linux-pm+bounces-19378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF89B9F53A1
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 18:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B03177A58B6
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 17:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814641F76DF;
	Tue, 17 Dec 2024 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ovpe+cV1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814D11F75A6;
	Tue, 17 Dec 2024 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456637; cv=none; b=pwwF23yQ7AprpKcHDbuZaNLbRZlpA98mTJi7fv0/BMuuvwDqvyJ0uu2/N3z++zdOnqzfvD2xiw/XGpjSOG0I2EcAjr/+65hUrqZ8yA87nPI6w/1k9hhyORLAtg7Tvt/F8TU2zHRVbVSH0Pjg0QfujkYQ52UhwTEWKWMM69ywoMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456637; c=relaxed/simple;
	bh=zgjQXb39cHz+vwjb7186pA2Yvsy5IoBBrsqy0T+30sY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bjaGA1qOydR7adRPyBf0zM1ROOXyAci6kXlNzysQj4Z//DXT/XeQ9bJ7rwew0yLcyVOOLBfgIEemBHyDk1xeKaHqhQ25yqLgs1fhbRkljVZ2dqz94mBJ+CiQ9mCxq6IN8UkL2Nb8ngv7gJ/Xch12prbaL6O97lE7q+j+jNPUzy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ovpe+cV1; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so12281694a12.1;
        Tue, 17 Dec 2024 09:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734456634; x=1735061434; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Li56ffbmLz6sJozt7Yl68NZFlCWV0JeWHRWPEui3yjM=;
        b=Ovpe+cV1S3WkRoTISpqR18K35II+DNaEdz5o+2XaGONvzECF5Kbx4JJjcMJu3gHZ1y
         Ftte4hzkAvV14Jff7hNkyha/TajrBLO/JWHG3qwdVY76hhN0Bgaft3WXC3Lc37wRnFof
         yDAZUXwfEhcqAT97PI5Hu/aZKON16wrQTLtXayOx3a/WN77lvIEfYcad23BCzKOptENo
         i53V2qT4sxu8iN2dEuVTvZttoDMPmse5V1opRy/7EMlskvh8jdyTcuUbpvZ/uv9Y1RcE
         TMc1i6XAv4ySDf3y9hvgPOioiKgqRwIkoASFPufXplrhVAi9wYNVilb1fXBlNvUg4mYY
         gQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456634; x=1735061434;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Li56ffbmLz6sJozt7Yl68NZFlCWV0JeWHRWPEui3yjM=;
        b=JWBppXCw0cyAL8r0MP3aYpitBmJZ34QZlwvqmHa3kdMSM5SjtyOI3chtxa2VIjAMr2
         Vh0Vm9p5SDUNqAqjV+f1j1oH+6ZcrzupPIIWE/iy8Wc1FVlAV8eufI8yGoa7eLllK6JZ
         RZXC8LdbIy1ISI2x8yCnWDZ5S+TeYe8qG5VjGDbFApFO9tNXMSHLD84aTYgDvR7PxzTx
         ow/J7sagmboabCEt+D/vy4zC4qanlC95R2EKPYptWl2qm5rc+78h2kxLVveYm/SfDFIH
         fo8XOMVDyFDznQ4W4Lw5ZcKZ8gEjS+3+JEqvDTopN5TX7KoHlEwC/3jpouxVL1Nj8q9C
         yg6w==
X-Forwarded-Encrypted: i=1; AJvYcCVTBNFvA+trsg7A5Cshja7QOo47HEFjp+ASIfcPIaJwQOL5yI0FQnSakEdtrR/KNCNXVwdQjVY6Fqo7fU1h@vger.kernel.org, AJvYcCVdMjyqWrlpixI1C+zlL88liUDvdXGJ/7gIMJ5UR0d7Cz/Gcj+7clAqArg6W0aLLk9GbAbpAG7CtLoI@vger.kernel.org, AJvYcCWGPyS9zalw7tZxIgDYHwlAjzO+MNMPI8Rcj43ZlN87q5YOCR/21XNfSgfhybIPIVe9Pc49wX0h0kdcfg==@vger.kernel.org, AJvYcCXvEe3MajYqMs+Em1h8O0luFP3uRtke8Jt16/VHtgVtkry5kbK2bQccItWSJXGApHMd/LibRvO4qNZHt3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFbrAKX1ifrlvWKjZDt+dqxbnz8N605VOTMwf+xlaa2kJhPXvD
	hZgxCSEgbDT61QJ64wuw8Tu1JZUYKBOxLXj4T2gKvk8IUZ4fETEg
X-Gm-Gg: ASbGncv2tfuR12ZlKG4bOyIP38yBeheBMM2EDrJBanEO3DxISJJOZAWt48eb8FwYYPZ
	NywGMjvIhm2nuDTffmA0UIMMlf6LJswNDIQ9ZWxZEk+RoNEStBvNv0lchK9S1cQigofmsH5BQnE
	ti7GNm5N8mntpmdyT7JHmJGQwReV4tczJtutPedSR/6OQC8zoSECTDZcanybQuid3ZoOwXmmQGf
	ugH2Ji/VYErLzfXMp0spQt2qsGhKsNyeoJg8n/8Tagm0fH+0KmUpoU=
X-Google-Smtp-Source: AGHT+IGbmpjnWqINLhHyNtnj1V6xjerVH6TdYVp4iAsNlQKpZQx7fxXtFUG9DShJxtKvTG7Z+ZcwRQ==
X-Received: by 2002:a17:907:3f94:b0:aa5:b1bb:10db with SMTP id a640c23a62f3a-aabdc833a85mr365893666b.1.1734456633481;
        Tue, 17 Dec 2024 09:30:33 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aab95d813afsm470444166b.0.2024.12.17.09.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:30:33 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v12 00/11] Add support for Maxim Integrated MAX77705 PMIC
Date: Tue, 17 Dec 2024 20:29:58 +0300
Message-Id: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABa1YWcC/43TzW7bMAwA4FcJfJ4GUv/Oqe8xFAUlUYmBxGltx
 +hQ5N3HJNhqJIf5IkA09JGixa9m5KHjsdluvpqB527sTr1sUP/YNHlP/Y5VVyTQaNAWPAY1TjR
 8HCbO+/6t6yfeDTTJobfz+zgNTEeVcvTRQdKVTSNMopFVGqjPe4H68+EgwfeBa/d5S/zrVfb7b
 pxOw+9bHbO5Rv9mjP/POBsFik313mvAQPlld6Tu8DOfjs0Vn+032KJZAVoBddFci8suhvAIumW
 FK3oyu2uFAMZUtFjwCfT/QARYA3oBoZiYHLSQ3RMYFqBec+UgYJsqkamWkOARjAvQ4AowXntYS
 X5K1sYAP4LtNyjLCrAVUCor2SRineIjiLAU7QoRpYcqFI6ObWTn9ROJS7JdQ6KQJYNrY9SRAZf
 k5f7yB/44y6RN9+d/HxD5fuym7aba6HMkQp8iBl29SaXkAIieIMc2UKimgm6WA7rd3CpEiCpZd
 aRPDGC1ag34moOjSryVIXi9XP4AFnVqNfEDAAA=
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734456631; l=6970;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=zgjQXb39cHz+vwjb7186pA2Yvsy5IoBBrsqy0T+30sY=;
 b=dHHzJl44Y4W6inDdXOjQVyw5Nt9wBo691dDpwKxwN2p2bXIvRHcI3c9zT4muKPVs+MeL4ZZvc
 Z+0S9ugy+nXAywN9XSi3bL4VKlf66j8t6P3b3kwlxWF9eWYvOZY77Gm
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
Changes in v12:
- charger: move out of mfd because separate device
- charger: add it's own binding file
- fuel gauge: move to simple-mfd-i2c along with additional measurement
  capabilities, which will be implemented in max77705-hwmon driver
- fix review comments
- reorder commits to stick mfd together
- Link to v11: https://lore.kernel.org/r/20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com

Changes in v11:
- charger: code review fixes
- max17042 binding: split in 2 files, so its binding code can be reused
  in MFD bindings
- Link to v10: https://lore.kernel.org/r/20241204-starqltechn_integration_upstream-v10-0-7de85e48e562@gmail.com

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
Dzmitry Sankouski (11):
      power: supply: add undervoltage health status property
      dt-bindings: power: supply: max17042: split on 2 files
      dt-bindings: power: supply: add maxim,max77705 charger
      dt-bindings: mfd: add maxim,max77705 core
      dt-bindings: mfd: add maxim,max77705 sensors
      power: supply: max17042: add max77705 fuel gauge support
      power: supply: max77705: Add charger driver for Maxim 77705
      mfd: simple-mfd-i2c: Add MAX77705 support
      mfd: Add new driver for MAX77705 PMIC
      input: max77693: add max77705 haptic support
      leds: max77705: Add LEDs support

 Documentation/ABI/testing/sysfs-class-power                               |   2 +-
 Documentation/devicetree/bindings/mfd/maxim,max77705-sensors.yaml         |  60 +++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml                 | 166 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/power/supply/maxim,max17042-common.yaml |  54 ++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml        |  43 ++---------------------
 Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml        |  50 ++++++++++++++++++++++++++
 MAINTAINERS                                                               |   6 +++-
 drivers/input/misc/Kconfig                                                |   4 +--
 drivers/input/misc/Makefile                                               |   1 +
 drivers/input/misc/max77693-haptic.c                                      |  15 +++++++-
 drivers/leds/Kconfig                                                      |   8 +++++
 drivers/leds/Makefile                                                     |   1 +
 drivers/leds/leds-max77705.c                                              | 267 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig                                                       |  13 +++++++
 drivers/mfd/Makefile                                                      |   2 ++
 drivers/mfd/max77705.c                                                    | 209 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/simple-mfd-i2c.c                                              |  11 ++++++
 drivers/power/supply/Kconfig                                              |   6 ++++
 drivers/power/supply/Makefile                                             |   1 +
 drivers/power/supply/max17042_battery.c                                   |   3 ++
 drivers/power/supply/max77705_charger.c                                   | 576 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c                                 |   1 +
 include/linux/mfd/max77693-common.h                                       |   4 ++-
 include/linux/mfd/max77705-private.h                                      | 195 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/power/max77705_charger.h                                    | 194 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/power_supply.h                                              |   1 +
 26 files changed, 1847 insertions(+), 46 deletions(-)
---
base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
change-id: 20240617-starqltechn_integration_upstream-bc86850b2fe3
prerequisite-change-id: 20241108-b4-max17042-9306fc75afae:v4
prerequisite-patch-id: a78c51c4a1b48756c00cbc3d56b9e019577e4a6b
prerequisite-patch-id: 735d52c3137c5e474f3601adf010f9fe2f3f7036

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


