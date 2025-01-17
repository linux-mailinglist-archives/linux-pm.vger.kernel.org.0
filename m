Return-Path: <linux-pm+bounces-20620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 139EDA14FDB
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 14:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406791884151
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 13:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980AC1FF5F5;
	Fri, 17 Jan 2025 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuYXK+Fy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0221FECBA;
	Fri, 17 Jan 2025 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118898; cv=none; b=BGMNyHkP70MRmPdWYWQXJ17oLn+repuVHp5XMeDaed+ILdCGxat0Md/gqSEfjHzpRvBFLujpyAUdWbZn8v8Rxo342MA89uHbAhWhFygvRKcrvtYtakS/J19uSIGJXYZOHJPESiTS3bBSyw+rTFpsRO1FaWdPXWwcwZmv8kv1VAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118898; c=relaxed/simple;
	bh=eML8C6F/kh0+kXWw3zY/UTNhac7WwIgPmyRnkQeHFfU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qmixsA8EeUApOtKnqmNZ7HSs2oUsswlSnHiGyXSyF291Bbe1sK780VEYANnmCiOu8NNaCtfHf2ZNOnem7hS852Qp0vjgbeCL/togV7BTOAt2si3mh65pO4RYRoUbG/L9OqgrLmNJlTPWid2rsrEpmf38LYZrgvPWoICTsIx2RM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuYXK+Fy; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa68b513abcso390599566b.0;
        Fri, 17 Jan 2025 05:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737118895; x=1737723695; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gkyNfohXeoUnLWsbvYEmNcOtAOsYqcZedm8Co8xdVVs=;
        b=QuYXK+FyRInSO5/vdN6g6X2IEjQY/nvVsdTtGdSElKrbLpdkfE5vG2bmgKblJlCVnP
         srQRHGi255ZJBSPod66oIGPTawKeQ0+u468xg7UDVlOId28D8cNAEC/s3Wiwi8hGYgM6
         TQckJnyYcVSfGSUgTwECgoSeYyL5RV21Ey1yZZTZ3uzanw/NwfMUptnJhLj8lY+o0LYO
         mEAdmSjfBZP11koEnqs3qA41ifNB91V6mfN5M2eqGSm5MO+psXncXJrP8FIkR/2Slf4G
         91LSoIK4gmlShGghzszg8ay9wpY6+wha8bqVBAV8COuAwa/t+JBdM4LwP3O4VJXnBxEt
         mohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737118895; x=1737723695;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkyNfohXeoUnLWsbvYEmNcOtAOsYqcZedm8Co8xdVVs=;
        b=ISzebEQPeurwHUDwpjy7/LiaLifoX1kXhyPNmH3S0DOaf/oaWG8lU/QrgYTC7wdCDG
         5m/7hB9f27bVE32j4h/9KV2zkZxK7S3VUgCpMjH/Zols8tLqVJzfuJzssiOnjNfjYZFa
         umSS5cESukddmyq+wBXrrWmeqbxXAei7wyoeA+dsN/lkpnh98F3rvQ468iRYJRmtnrfM
         Qf3mVQ6NLj/nGhDzTQ+V7C+wV/7qsA8Mg06/C/Xa9Q/jv7tgh8u+0wGJ6ANKXT0DZ1bf
         Rj4IwF2t7vGNAzk7Mt6uFhDBf4cBQ5Kf7FVIAFQ6FXjJgpgBcIpT9hL73wNNfg+IcJgk
         xx5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUx2ahn/5lpmXflaNR9zGmNbEODkabN3Dg2lhSTgHxAH1JPwsq9ThLOJbNlH1IH83sihKLgT9dWP+bl@vger.kernel.org, AJvYcCV5frgz8LzOkJL+Khva0XsfzDVpCAFyhozmB+7EAD232OkE8QYi362CXf0xHCVft27NiqrJLxA4A2CGAX7f@vger.kernel.org, AJvYcCVooRq7dAZ6U0ff7Gjz1pOLYY+j9RRCaDKC4f4CeZi0F4pxBxOMxRL8vXxFrrhaLrnoEbRPqRwNSu4ojwM=@vger.kernel.org, AJvYcCXyeb3ip4gNvE5QnxSej8L85+nAlPoMNTdyR88ErMTvCj7j7VcIGpq8DIvjQUmqR7QJbDko/D4/wmqvyA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4K2yJfWJ0rIvBfaao1hRDLhEZpe21NUQkNSAFlOrGzUzJrA5a
	Ji/5sI94mHeQ7VEAwWSH4sXyv3CgtFO/x2v6yQ/6aOvtMGEoMT4v
X-Gm-Gg: ASbGncsSz7RGpO9hfqTODY95aO2S7509YJk5gX4up8GvjnVp2zyzMXwHGqCCi7kG9MJ
	eTIdg6QXhYGHyzpCdU/REX1prZ0dwACUDwtIzSXjyzv8IcMuDRU4b3b6IicQiTj8qdzBWNb6fn4
	PhdHU9nD4A/V8nArtF227ANsbg84XnqrqjU29oVOVBdegTl5pepEyejaGozmaAnXATbNeOb8NMk
	JpY+WU39r5gxMJ5T/eup2dGA651L4o4B1Lxne/BnZjSUqT5ebDpXeX/47uE6CxTiL/I/MAlhOs4
	jwDu1PqVWBL5/RHIZxh50/5Q8w==
X-Google-Smtp-Source: AGHT+IGN5ub7/b3vVgZTZkdC325QVuadaCeOdvgBw3Q5H5tJyhbYyejZJrjnJfi97x9wWVLI8lGkIg==
X-Received: by 2002:a17:907:7e91:b0:aa6:a572:49fd with SMTP id a640c23a62f3a-ab38b3ce71cmr239874166b.54.1737118894436;
        Fri, 17 Jan 2025 05:01:34 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384d2d69fsm166289166b.79.2025.01.17.05.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 05:01:34 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v16 0/7] Add support for Maxim Integrated MAX77705 PMIC
Date: Fri, 17 Jan 2025 16:01:27 +0300
Message-Id: <20250117-starqltechn_integration_upstream-v16-0-11afa877276c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKdUimcC/43UzW7bMAwA4FcpfJ4HUv/aae8xDIV+qMRA4rSyY
 7Qo8u6ju6314sN0MSAB/khKIt+6iepAU/ft4a2rtAzTcBl5gebLQ5eOYTxQP2Te6AQIBQZtP82
 hPp9mSsfxcRhnOtQw80+P16dprhTOfUzOOA1RFJIdMzFM1McaxnRkaLyeTrz5VKkML++Bf/zk9
 XGY5kt9fc9jkevu34ju/xEX2UNPshhjBKAN6fvhHIbT13Q5dyu+qE/Qo2wAFYMiCypZJ+2svQf
 1NsOGM1n0miGAlAUVZtyB5gNEgBbQMAhZuqjBQ9I70G5A0VKyZdDHEoIsKmCAe9BtQIkNoFvPs
 AS+lCSkBLoH/SfInwbQM8iZ5SRjIBHdPYiwFVWDiHyGvc3kNClH2ogdiVvSt5DIZE6gvXPCEeC
 OFBuy6e2gWB9Pdvx4lSpe7QuXG7LpsnHtmBKTQUgWnNwX/tEyGhBaehDXnimGnKIkIHuzI/WGR
 NNCrl2TihA+ky9W/1P47fcUqfR85ak1/xklt9svL40SmdMEAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737118892; l=6669;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=eML8C6F/kh0+kXWw3zY/UTNhac7WwIgPmyRnkQeHFfU=;
 b=b+0rFU68U3GKN5vId3OnCsxMSaD/h2NRLJaFikxeQ69uBvFFq0cGrgP13iz4IdCb8in4oU+O6
 ejppfEYGv5xB5Tj/k1UOHnwQO/nKsyY38W7aesmGM/jv0xNoIS2AZG5
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
Changes in v16:
- cleanup review fixes
- Link to v15: https://lore.kernel.org/r/20250116-starqltechn_integration_upstream-v15-0-cf229de9f758@gmail.com

Changes in v15:
- update copyright year
- fix mA/mV in charing driver
- rebase on latest linux-power-supply tree
- various formatting and optimization review comments fixes
- Link to v14: https://lore.kernel.org/r/20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com

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
Dzmitry Sankouski (7):
      dt-bindings: power: supply: add maxim,max77705 charger
      dt-bindings: mfd: add maxim,max77705
      power: supply: max77705: Add charger driver for Maxim 77705
      mfd: simple-mfd-i2c: Add MAX77705 support
      mfd: Add new driver for MAX77705 PMIC
      input: max77693: add max77705 haptic support
      leds: max77705: Add LEDs support

 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml          | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml |  50 +++++++++++++++++++++++++++
 MAINTAINERS                                                        |   4 +++
 drivers/input/misc/Kconfig                                         |   6 ++--
 drivers/input/misc/max77693-haptic.c                               |  13 ++++++-
 drivers/leds/Kconfig                                               |   8 +++++
 drivers/leds/Makefile                                              |   1 +
 drivers/leds/leds-max77705.c                                       | 279 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig                                                |  13 +++++++
 drivers/mfd/Makefile                                               |   1 +
 drivers/mfd/max77705.c                                             | 182 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/simple-mfd-i2c.c                                       |  11 ++++++
 drivers/power/supply/Kconfig                                       |   6 ++++
 drivers/power/supply/Makefile                                      |   1 +
 drivers/power/supply/max77705_charger.c                            | 581 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/max77693-common.h                                |   4 ++-
 include/linux/mfd/max77705-private.h                               | 195 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/power/max77705_charger.h                             | 195 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 18 files changed, 1703 insertions(+), 5 deletions(-)
---
base-commit: 260d7c5e5392ac41c94152005d416172ba0a906d
change-id: 20240617-starqltechn_integration_upstream-bc86850b2fe3

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


