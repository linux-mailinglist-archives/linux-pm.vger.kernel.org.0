Return-Path: <linux-pm+bounces-19686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEE19FAF0F
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 15:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E58C166814
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 14:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECAA1ADFE3;
	Mon, 23 Dec 2024 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYepxaRv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78975CA64;
	Mon, 23 Dec 2024 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734962396; cv=none; b=DK2jD+OXoR7/KzWiaYgv+esn5BqabwU7KzZ6JJJI0pEWaP0BvLPL583z1zoca8lul00cXbC4FfUoJJTvAMAfNmVPYfl32pq811oZO0Jaoapw+Z4yXZdDu9YOdp0Z/q39Oi1HEMrFrL6HuLxe5DtZTnBhw0jm3GvM9qX9q4voa50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734962396; c=relaxed/simple;
	bh=gVYIDw4nl0vZlkyr4kKhxRZ3dzJS9tXCWluG2Wou9C4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DTku6mVcYdv/+qqh6Bdgfxqr8iRh20AiSSCVdcb+Gl2DZ9EKFA7NNquN0goI9liiefVIlHUeZ+2dZsL2OLvu0oUTHH4R0suc1YrrNbHYxNmhchcmsqQ5hJY+AKuUT9yowKu5QovG9ZWN2pjdprf2PhIkDlDtBiDqLmcJI0GX2EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYepxaRv; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso7983979a12.0;
        Mon, 23 Dec 2024 05:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734962392; x=1735567192; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H4sMu+Vc0a7FJGvF2NWz2Fht9i2oqMCMt4cbKaSWbbY=;
        b=SYepxaRvLdERLw0xLN017J4YoyWUayUCY3vpNSQr3fk4LMi3OP5Me1r2j9Z87vHDeQ
         mVoGRdrPX6g4oGfswdWtPzrFf/bQ848/7Q4nfT1GIFUdv5QERQanFrbE9aixUiUCWrin
         0ZZ46ZCx5Qr2kN9p0vq+U6SpzRwne1jWft0aS4FzLf63NBUdieNSfZr8/8AuXQyjE/Fm
         eLDqZ98rJVnzK45zmipbzT0I09feZaajmfwsDqHAl7c8kPE07gkvfLtdnFtQ5OHtLpq7
         s47f6VmJfLx0J1yRlfus9PaPeJ4KiXSxQAN9DQ3f8u4i7x3iiOw0URTbbDdAb1N6rxNp
         45eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734962392; x=1735567192;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4sMu+Vc0a7FJGvF2NWz2Fht9i2oqMCMt4cbKaSWbbY=;
        b=Fq1iYgxifEIwmv2/lxHFQyoO9/G7uNfU09oTsXwDlhJRZO5/YQLiT9VdcK6jWUlA8W
         TEJvtdhYYXMU+BQNZgLSgDqoQ3f+YqCOxkTfqbRju9UQHpqaYtGnw8LHNvuNS3hssKMe
         UyOxwhUwyqk4ns27VbjqDjw5Q/ekkK4oPmEfuvRsD07sB5VI5kZlgSblcXBQgYxoEGx7
         SOXQTIqYhBXMu87XkrW/VQin3cFOFE8b+kww0Nr7TH0Lo4ECv6qeOy0YgtRqgHZr7Dkh
         v7/yUoKz1ixzJ/70C2NLiGRHe45UHiAI8uPGZ3dmPJjLKss7DIQdAjLF1JSTIZCsU6wO
         1ofg==
X-Forwarded-Encrypted: i=1; AJvYcCVrj2kcpmmaQ8TLjwS1lROwBbVlwmFR5mHxe+4aBPzgSnwhCXhIADmj9v24z3AR1cbEkxCuzyRL33/mc5Dl@vger.kernel.org, AJvYcCW/G5CApUIf59808txvXwl0q/LfBAIu4X091At4DHXdj8QVFSyLBp+G1/WCcwuAAx6hW7zET7G8ZQrt+eg=@vger.kernel.org, AJvYcCWBkb+qs/UfHqIhdKMesGHO88CLTs3noKtz55gGQnEcJuAn37wciwP1NnOLuVb/n00CFiMCTSCXVYx5@vger.kernel.org, AJvYcCX1jKyj5l1d80HhUgfIQPYgIV1Ef2A5/gGKgxKiLOgDx0sXt2YUIjwPM/2G2iwhTQrIPB3MhjvmlPNysQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+/OXT+6afe/LeMshM8bkiGMrbpBL5f6PjSF8olA4g5PgZZR95
	tdLQ9qRVSxzfE+JA791fWNTrlRvMXzYQcVZ0NAOy2pfuij6s91Qge/fp0A==
X-Gm-Gg: ASbGncs7mTo090lAjc0v4vaov6lEF2kEe2VSAWviT+04+5Qob8a815sPhbN3oAkRKDg
	P+VTLweNf5zQAJgblVy4NY3E5Aho+rzoEP91IzkDqpkq58vm33Zv1EIlNQsQ0z79QXyeWIEEJwz
	pac4Anp7jHHXwaSn6MDSMFgc1t9DCDyPUZ4YHpjuO4oAsDJau66asEvHWoxd8f0ybMVCLINZXvl
	fwkdNDwpNzPXVxIJVKHDbbaBjpunco9E8VjYYKpr16SHYG7wuoLWLjdAiWB/RSzjs/Dm/mVrBlv
	xs/MOBJY3DxCFdbM7GWGS7xrhA==
X-Google-Smtp-Source: AGHT+IFWrnLkooE8eVfiyJJbxoQb90dlsRX0YevdFQ8WrSrE/Bt8DnkU9PNNgcUyAlckMZQFg1odBw==
X-Received: by 2002:a05:6402:5d1:b0:5d0:9d7b:2064 with SMTP id 4fb4d7f45d1cf-5d81e5230f9mr13305901a12.1.1734962392146;
        Mon, 23 Dec 2024 05:59:52 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701ca31sm4911485a12.88.2024.12.23.05.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 05:59:51 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v13 00/10] Add support for Maxim Integrated MAX77705 PMIC
Date: Mon, 23 Dec 2024 16:59:37 +0300
Message-Id: <20241223-starqltechn_integration_upstream-v13-0-fbc610c70832@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMlsaWcC/43TzW7bMAwA4FcJfJ4GUn+Wctp7DEWhHyoxEDut7
 Bgdirz76ARbveQwXwxIgj9SFPnZjFQ7Gpv97rOpNHdjdx54gerbrknHMBxIdJk3GglSg8VWjFO
 o76eJ0nF47YaJDjVM/NPr5W2cKoVexOSsMxBlIdUwE8NIItYwpCNDw+V04s23SqX7uAX++cLrY
 zdO5/rrlseslt0/Ed3/I85KgCBVrLUSsA3px6EP3el7OvfNgs/6C/SoNoCaQZkllWyScW37CJp
 1hhtqMpslQwClCmrM+ATavyACbAEtg5CViwY8JPMEtitQbrlyy6CPJQRVdMAAj6BbgQo3gG6pY
 Qn8KEkqBfQI+i+QPxtAzyBnlpOKgWR0jyDCWtQbROQaijaTM6QdGSufSFyTfguJTOYExjsnHQE
 +kXJFbuodlEvzZMfNq3Xx+p+LX+/DVOn9wsM73SfqPnN83nfTfufQmKipKG1tAZLOkyspebJkZ
 eHnzokoJNmsZ36/u2WI4ETUog8f2IKWwiuwJbUmlEB7HoOX6/U32FT610QEAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734962389; l=6913;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=gVYIDw4nl0vZlkyr4kKhxRZ3dzJS9tXCWluG2Wou9C4=;
 b=r4LRsPh/75tKdQUmtYWm0hoA1nLUWfPdo5FL5jG9l2U/sonJPC9Fp6UDC6uy+xhNjjB2CBUb0
 BDwbYPJx0EACNIYTwNJ1mLxXGuVCYDug0R3UK6KRfDLNnTsY5Adutqv
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
Changes in v13:
- revert: max17042 binding: split in 2 files, so its binding code can be reused
- include previously removed patch:
  'dt-bindings: power: supply: max17042: add max77705 support'
- use same of_node for matching simple-mfd-i2c and setting max17042
  driver
- Link to v12: https://lore.kernel.org/r/20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com

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
Dzmitry Sankouski (10):
      power: supply: add undervoltage health status property
      dt-bindings: power: supply: max17042: add max77705 support
      dt-bindings: power: supply: add maxim,max77705 charger
      dt-bindings: mfd: add maxim,max77705
      power: supply: max17042: add max77705 fuel gauge support
      power: supply: max77705: Add charger driver for Maxim 77705
      mfd: simple-mfd-i2c: Add MAX77705 support
      mfd: Add new driver for MAX77705 PMIC
      input: max77693: add max77705 haptic support
      leds: max77705: Add LEDs support

 Documentation/ABI/testing/sysfs-class-power                        |   2 +-
 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml          | 166 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml |   1 +
 Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml |  50 +++++++++++++++++++++++++++
 MAINTAINERS                                                        |   4 +++
 drivers/input/misc/Kconfig                                         |   4 +--
 drivers/input/misc/Makefile                                        |   1 +
 drivers/input/misc/max77693-haptic.c                               |  15 +++++++-
 drivers/leds/Kconfig                                               |   8 +++++
 drivers/leds/Makefile                                              |   1 +
 drivers/leds/leds-max77705.c                                       | 267 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig                                                |  13 +++++++
 drivers/mfd/Makefile                                               |   2 ++
 drivers/mfd/max77705.c                                             | 209 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/simple-mfd-i2c.c                                       |  11 ++++++
 drivers/power/supply/Kconfig                                       |   6 ++++
 drivers/power/supply/Makefile                                      |   1 +
 drivers/power/supply/max17042_battery.c                            |   3 ++
 drivers/power/supply/max77705_charger.c                            | 576 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c                          |   1 +
 include/linux/mfd/max77693-common.h                                |   4 ++-
 include/linux/mfd/max77705-private.h                               | 195 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/power/max77705_charger.h                             | 194 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/power_supply.h                                       |   1 +
 24 files changed, 1730 insertions(+), 5 deletions(-)
---
base-commit: 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2
change-id: 20240617-starqltechn_integration_upstream-bc86850b2fe3
prerequisite-change-id: 20241108-b4-max17042-9306fc75afae:v5
prerequisite-patch-id: a78c51c4a1b48756c00cbc3d56b9e019577e4a6b
prerequisite-patch-id: 4437ee0157cd29081ea8a9cc18cabef7b7caab3f

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


