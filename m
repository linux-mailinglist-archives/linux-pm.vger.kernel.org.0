Return-Path: <linux-pm+bounces-16771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E80869B6EDC
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 22:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E5C1F246E6
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 21:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91622144A7;
	Wed, 30 Oct 2024 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrYblMyN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829611CF287;
	Wed, 30 Oct 2024 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323847; cv=none; b=WJr/g9jrH8RuzaiKLZqxz5uZNtMQ5BRPG6XuhIDMdqzbJCUbVsK2FKHhEsySSSfFSoI6DokzZm1Wk+1MXwHBqDw8l0z5gXtFn6WIxH1dkkk/Fe8Leh0O2KKPvwhc/wZvPreIA0iQV5DnmfEOYKINLR/AKRBvHo63qa0yJWmOelQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323847; c=relaxed/simple;
	bh=Yil46cKSSY9OiR+Ylk5uEi+0gwQ0nhFw0CcQR8tdmCs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t1pTj7zAm8KxA3fXMJr/Adnv2v5XQ7wbGIe6+Gegf7mFkcuGE7Ad3iXM2GMKNezuK0f5RTY08qS49TO8op02zVAZsUBRYfVaAgGF5dSlYhRR53ipf/gxHSo22lKx/izqcn7cdVicENdqvWmGWIfq5GK8xiKiyGv9D7HjdEP0+1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrYblMyN; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539fb49c64aso498600e87.0;
        Wed, 30 Oct 2024 14:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730323843; x=1730928643; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QdLeGacNmj9gSA1G+x0yYbWbjhVksi4NO6qhx/FRG34=;
        b=mrYblMyNlQeIagEXgqMgliI5T0eSGp9+hGfcwO7FARZu2B/KorrVElbc0Np/SHq/V1
         TIDACLVvILTDb/sW3veCpK8zezWj20c+bs8Ypv0n708VTdJ3VAPP8cdgYOX2TuCUxLK+
         pqcjkkk08jcpcdSxzdhwAabVaCWpfnwl9A1Y5QJYf/lXBeoBUl1kYMl7Uza0Wk1IxoKd
         q5DSdN9vPzvCRK0NmZy+WLVss5TrmrlKkiB2GpBiNQhVPaqFbjiIGc6u9cmWKZUuC+jN
         QCL/qkP2r/YwVhdcTRIZEF66l+h+ehogpdcJsLu+En/zAv7utqAZP7AqPQV2Q/USLZ/7
         GjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323843; x=1730928643;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdLeGacNmj9gSA1G+x0yYbWbjhVksi4NO6qhx/FRG34=;
        b=DXuppcTZ2GpdFRoiCqHqjUkIwtfxuk2XWIW5qrh0aky/Oq/gpvD2g7nk0Ms4ZTRQZZ
         3rXcm2wKwZOWk7c/QwfLdCLshME6sYFAP2PE0wP3A16bLnFuC462mpFFmLreg+M8Ew3g
         O0zpnCAqvtcZ1LtZfE/vkMgkVbf1IdjLZTdhzRazTPaoNE8CQHA4N49VQIW3ZKQGsjxm
         mL0ZFEO6+bi8Rzt7yNq7Qi+zqU7oZThi9BbqrRw0MlLOHL8sl/FnMmsdoVuj8Pk4/v3D
         5xl/rYheuP6EAR1UH8Kxw5jn41Ro4hLV0MGGhJXm5B4n3+lZeUzp1Sve51tMZeYXI8U/
         wmPw==
X-Forwarded-Encrypted: i=1; AJvYcCV/+vq4yPxbGNFYKGrs2HAQi26pm3Tv1v03wQ5mw1hi5ClInft5EjbB7sKlv3Sf3bUqpCzzbTZCW0BMSA==@vger.kernel.org, AJvYcCVoJFLHrW2Q2fbOevv5V7iA6Ut5WXPFF9GUw33hV/s9AI0QhOA3wNS5cB60c1u+32juadw320elCwcT@vger.kernel.org, AJvYcCVwruoUR6XrX3ma4SFKe8Vmu3LgeSsnLgHgPunv38MVG/o/CizwNyMrOo3P2yQLSs1BHZAGeJ04o3NHb5w=@vger.kernel.org, AJvYcCWm76qxzzrqwQzrlyhifyNyP0Y0HqsmvXIICbKRzBnSejZC+bs2Jcl26vReLCrOtOj2ykcZjUaUTeOJBAC8@vger.kernel.org
X-Gm-Message-State: AOJu0YyOKDhFKNaCIi5DFtOrtpTmDc0upq7TT0x9b7XSQquAJCdgNNIr
	/J9E4/CeRoVE2v1dvY2rc72VXYggToNabVegmU7dHrPB5FmUhMdY
X-Google-Smtp-Source: AGHT+IE/0MJeaxP/WuE2aKrJO0CYeSkglLrzQtFGylmakkVnYBharaA2ihXxMSG9BQTGiqGpaFi6tA==
X-Received: by 2002:a05:6512:1256:b0:535:6a34:b8c3 with SMTP id 2adb3069b0e04-53b348b9fecmr14142980e87.5.1730323843215;
        Wed, 30 Oct 2024 14:30:43 -0700 (PDT)
Received: from [127.0.1.1] (leased-line-46-53-189-50.telecom.by. [46.53.189.50])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9e564c5410sm687266b.57.2024.10.30.14.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 14:30:42 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v8 0/7] Add support for Maxim Integrated MAX77705 PMIC
Date: Thu, 31 Oct 2024 00:30:35 +0300
Message-Id: <20241031-starqltechn_integration_upstream-v8-0-2fa666c2330e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHulImcC/43QTW7DIBAF4KtErEs1gPlJVr1HVUWAwUaycQrEa
 hX57sWR2lrNol6+kfjeMDeUXQouo9PhhpKbQw5TrEE9HZDtdewcDm3NiAJtQBCJc9HpfSjO9vE
 cYnFd0qW+OV8vuSSnR2ysEoqDod4xVBmjs8Mm6Wj7CsXrMNThJTkfPu69r2819yGXKX3e15jZO
 v1uVP83zgwDdswLISgQqe1LN+owPNtpRCs+N7/gkbAdYFNB2lLnW265kvIvyLcb7rjJzNcNARj
 zpCEteQDFD0gA9oCigtAyZTgcwfIHUG5AuufLsoJH47VmvtFEwxZcluULbUwzWykCAAA=
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730323840; l=4026;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=Yil46cKSSY9OiR+Ylk5uEi+0gwQ0nhFw0CcQR8tdmCs=;
 b=2N8t1oACRdjZ8WTm9vHajt9miQpTDhzhx806caKmU/t7wT5TV2V4RWsYUoS4B9o4CdF+8eafb
 lnDnQfLKwPTB2VSi593Mkddb4R/vE0Et6pPI7TOffe6J+5sb0l4W0L/
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
      power: supply: add undervoltage health status property
      dt-bindings: mfd: add maxim,max77705
      mfd: Add new driver for MAX77705 PMIC
      input: max77693: add max77705 haptic support
      power: supply: max77705: Add charger driver for Maxim 77705
      power: supply: max77705: Add fuel gauge driver for Maxim 77705
      leds: max77705: Add LEDs support

 Documentation/ABI/testing/sysfs-class-power               |   2 +-
 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 174 ++++++++++++++++++++++++++++++++++++
 MAINTAINERS                                               |   4 +
 drivers/input/misc/Kconfig                                |   4 +-
 drivers/input/misc/Makefile                               |   1 +
 drivers/input/misc/max77693-haptic.c                      |  15 +++-
 drivers/leds/Kconfig                                      |   6 ++
 drivers/leds/Makefile                                     |   1 +
 drivers/leds/leds-max77705.c                              | 167 ++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig                                       |  12 +++
 drivers/mfd/Makefile                                      |   2 +
 drivers/mfd/max77705.c                                    | 222 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/supply/Kconfig                              |  13 +++
 drivers/power/supply/Makefile                             |   2 +
 drivers/power/supply/max77705_charger.c                   | 598 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/supply/max77705_fuel_gauge.c                | 363 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c                 |   1 +
 include/linux/mfd/max77693-common.h                       |   5 +-
 include/linux/mfd/max77705-private.h                      | 199 +++++++++++++++++++++++++++++++++++++++++
 include/linux/power/max77705_charger.h                    | 216 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/power/max77705_fuelgauge.h                  |  71 +++++++++++++++
 include/linux/power_supply.h                              |   1 +
 22 files changed, 2074 insertions(+), 5 deletions(-)
---
base-commit: 86e3904dcdc7e70e3257fc1de294a1b75f3d8d04
change-id: 20240617-starqltechn_integration_upstream-bc86850b2fe3

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


