Return-Path: <linux-pm+bounces-20091-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A02A05E2D
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 15:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6D43A5BDE
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 14:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E561FCF57;
	Wed,  8 Jan 2025 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6X5Js0+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7ED1FCFEE;
	Wed,  8 Jan 2025 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736345649; cv=none; b=PvOXQWMK1cZ+1vCnrb8yuGzzpv0E0pT8aB5pRVeUKPAXE7AV5Mq5QSVBIDSEJXJ2RoEKsCp+iJAPsm6tHn3P0G/uVlpbyY6ixiHeuM7THhGGh+JYX+rQvbQVr15vgX6M9E5/l193wiz3Gz+k0ONtfem+TkqckNeuXqicKFpquhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736345649; c=relaxed/simple;
	bh=S2M/D5WC7OKzlE8WtyyPUB4GyIRbAaMccUv3I3kP+sI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UeAmPYwgi2dIOABpknDVZva1T5cQvDUPEDildXpJcALuGiUN3hmqB5sFuaImkOYo2+21F9WIbNt9ys5FrV2KKn88t2V4E1Z6BbrN1DIlRwMFIHhurfQqffIfCKo4nkYVGOKAfSBQt60BAKkewHwdwF1RyXwEnlHlsJQSgv/BTX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6X5Js0+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaec61d0f65so273850966b.1;
        Wed, 08 Jan 2025 06:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736345644; x=1736950444; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FBIsZzHzzItzd268KVnO2EBwuFBH1uC72hJj445cEfk=;
        b=T6X5Js0+Vul+MXACHCAK/mL6AWlLQ3ZO+P+V9aMKi9UqJkBmQjkMq8XQY57eLDjojv
         CK2LvtLuwiJR+VIJ5EYPfGLxt/Z1ngoG42tENp2xugBX2QpV2/Taao/MakreMCRzrn9U
         VOMsSLLQ0LpoubHeK1srT5RI97RLIKW+LrsswYfJyi5ecNIO/d2cJimQ5IvbAmMf7Mgr
         v0B04Z8qeoWm19qirl1+YOcOhZ0nhbqPADmThJnEnKSmZBSGI9CgioUFIkXu3j81KLoe
         inrBEtnUdXM9oENff2XfIDiC4CBbQHJMO4pTtbs60u5NFHfIoC4o/EO5E6LdQGmko9e+
         dRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736345644; x=1736950444;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FBIsZzHzzItzd268KVnO2EBwuFBH1uC72hJj445cEfk=;
        b=EimBrLtnz74a8qRu70IkKnu+RyXszrJLL2d/uu+fRG0HmYkEIDGTML2g+AeOE/D95t
         8Np25dsR7u4gxTts7DnaJ+AMI3Xxnl6FHLkFs92BmSUKlnu0I2WF0a4psl/9wFSOFREJ
         89P7sgMs0ftKohc6kE7tfT7/Ny1MFqGnC8jSL1SI8iHiE7q209lch0N6an4vw0CpGNs/
         +ed+rXW5OrYbXDeoD1lHpf435Y2oPODr6izfZ3PstLyJPenZyL1/E8CABNwV5EdC5G6R
         EaXGl3chk8XJHOO4jcFBftkZjzM2YX/CSABXm20jvLW07zFwxVvswwW4RaXQRGFMVsaR
         esnQ==
X-Forwarded-Encrypted: i=1; AJvYcCURSLNBJ5c/Q/0bgGAUGZfDQhShz22sVwkaqNsqlqJLBL22/RWmWzs1Dn2gSgVpUFRP0z6LwYc8Akf1VQ==@vger.kernel.org, AJvYcCUqTyai4LdSs92qnW03JCIl6O0CNdZbx9gsyaHG9IvwMeohy/8MBP/eXz+hip1TgFcDNRVoATsvE+HlN/0=@vger.kernel.org, AJvYcCVczgNDwa8nHxhZFeAfN1RReVMWb5cFqhYJSiLeWgcxwPWJSu3mFMzBzjRxvHx/z4MKsq5/PmtOIGzER/XY@vger.kernel.org, AJvYcCWubEQHsoye1J3pGoQDTegR26O/gaY6DxL3LZS0j5vbA0FtFSIZPatGp4RJLjMGTjZRBABfOalPROYC@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ+8QefZoy9kRSrOB/wdYAVBy8dOGE0tiWmU4TETUKPY83ETV8
	MPc9GXZLP7+rcLrZVBqsdcl6iMM7CCP4is+7THajvhpTS5SQrd0v
X-Gm-Gg: ASbGncs2Hk+3zRgknvbQ4auHE91xT0+vyvOu+AwOEHVFi3UUHAxHN6MYBYkaI2J+vHC
	ObTbt3JH9ZmEcU75iUYsxOAEw5NgvS/SxCFvzQrDoCQkQ1PrQG7Iviy/aGUs+um5EcgaLy3GftX
	bnLfNDdm6GXsNr9hx1Ub1eJRVE8kajM3K5hvfTqoudn7I3r2RG9Jht4QeBzqEPC+3LUHHu5m72f
	ZLk4XGYpZ9j3b1v0qCI6UXHLlLkZtWV39G4cjej15ArPOJF+9tp/bdNSw9AB7kuTotgwRzmxTFc
	k4y/HiwkCVIhUBZ0iVErDdHhyg==
X-Google-Smtp-Source: AGHT+IG/THk3QRaLsPQW1hxq8HhBGiFmhhJpz/lCgwFAw1u9aWQ+3jAeZb4tPtMfAfuGxAS0Q7/hcQ==
X-Received: by 2002:a17:907:368c:b0:aa6:8dcb:365c with SMTP id a640c23a62f3a-ab2abc8ea50mr269165366b.49.1736345643363;
        Wed, 08 Jan 2025 06:14:03 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0efe4941sm2500562666b.95.2025.01.08.06.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:14:02 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v14 00/10] Add support for Maxim Integrated MAX77705 PMIC
Date: Wed, 08 Jan 2025 17:13:44 +0300
Message-Id: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABmIfmcC/43UzW7bMAwA4FcJfJ4HUv/Kae8xFIV+qMRA4rS2Y
 3Qo8u6jE2z14sN0MSAJ/kRKpD6bkYaOxma/+2wGmruxu/Q8QPVt16Rj6A/UdpknGgFCgUHbjlM
 Y3k8TpWP/2vUTHYYw8U+v17dxGiic25iccRqiKCQbZmIYqY1D6NORof56OvHk20Cl+7hv/POFx
 8dunC7Dr3scs1xm/+zo/r/jLFtoSRZjjAC0If04nEN3+p4u52bBZ/UFepQVoGJQZEEl66Sdtc+
 gXkdYcSazXiIEkLKgwowb0PwFEaAGNAxCli5q8JD0BrQrUNSkbBn0sYQgiwoY4Bl0K1BiBeiWM
 yyBLyUJKYGeQf8F8qcC9AxyZDnJGEhE9wwirEVVISKfYWszOU3KkTZiQ+Ka9DUkMpkTaO+ccAS
 4IcWKrKodFEvxZMfFq1Txapu4XJFVl41Lx5SYDEKy4OQ/id8e/TnQ+5Xfg+nRpI825vVzN+13D
 rWOiopUxhQg4Ty5kpInQ0YUrqCciEISzfoZ2e/uESK4Nqr2HD7QghKtl2BKsjqUQHtuhJfb7Tc
 Eb2ZelwQAAA==
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
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736345640; l=6507;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=S2M/D5WC7OKzlE8WtyyPUB4GyIRbAaMccUv3I3kP+sI=;
 b=q4Hp4HP7r3L4yw2pTuBnZqDF/BxZhgCEn8laM/mgmjv/wxrOFbQ1bqfggjw2ybv7SRSdhajnB
 XgG6pmUuAoMDMzj92CGzh9C/oAh/Ud85zS+RDL5mYNcxLEzpO79RQGx
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
Changes in v14:
- binding review fixes
- add trailers
- Link to v13: https://lore.kernel.org/r/20241223-starqltechn_integration_upstream-v13-0-fbc610c70832@gmail.com

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
 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml          | 158 +++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml |   1 +
 Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml |  50 ++++++++++
 MAINTAINERS                                                        |   4 +
 drivers/input/misc/Kconfig                                         |   4 +-
 drivers/input/misc/Makefile                                        |   1 +
 drivers/input/misc/max77693-haptic.c                               |  15 ++-
 drivers/leds/Kconfig                                               |   8 ++
 drivers/leds/Makefile                                              |   1 +
 drivers/leds/leds-max77705.c                                       | 267 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig                                                |  13 +++
 drivers/mfd/Makefile                                               |   2 +
 drivers/mfd/max77705.c                                             | 209 +++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/simple-mfd-i2c.c                                       |  11 +++
 drivers/power/supply/Kconfig                                       |   6 ++
 drivers/power/supply/Makefile                                      |   1 +
 drivers/power/supply/max17042_battery.c                            |   3 +
 drivers/power/supply/max77705_charger.c                            | 576 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c                          |   1 +
 include/linux/mfd/max77693-common.h                                |   4 +-
 include/linux/mfd/max77705-private.h                               | 195 ++++++++++++++++++++++++++++++++++++++
 include/linux/power/max77705_charger.h                             | 194 ++++++++++++++++++++++++++++++++++++++
 include/linux/power_supply.h                                       |   1 +
 24 files changed, 1722 insertions(+), 5 deletions(-)
---
base-commit: 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2
change-id: 20240617-starqltechn_integration_upstream-bc86850b2fe3
prerequisite-change-id: 20241108-b4-max17042-9306fc75afae:v6
prerequisite-patch-id: a78c51c4a1b48756c00cbc3d56b9e019577e4a6b
prerequisite-patch-id: 4437ee0157cd29081ea8a9cc18cabef7b7caab3f

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


