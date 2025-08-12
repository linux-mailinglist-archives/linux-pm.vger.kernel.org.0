Return-Path: <linux-pm+bounces-32228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED02B23AD8
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 23:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58518687D04
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 21:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A641B2641FB;
	Tue, 12 Aug 2025 21:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5m1BuMA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD452F0695;
	Tue, 12 Aug 2025 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755035129; cv=none; b=aqFdzskRL+h74lR/z1TAuB9u8RT25csXCFuI6lUhhXrTVPO76xcGdVFt8xanz5k15n9ExukfeOflZIKiMMZ9dCTt8KuucvVPjIm9VKeY1MWBvpX1X6QcZFZhKAlb6P2sw9CniKg+Dx0GKvqFHOrvRNMRl3c3GwN1CcD9BcWkACU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755035129; c=relaxed/simple;
	bh=nLBNAD6e6ZtY/sPMB5/lm/O3sOQDQquTEbbPwEjlpE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ul4uS5PCQGfvnrryahK3oooUrRye7Fm5nW+JxnE2BIE2OW8zu1eBuyCPdtU7JWBG4cVHwUbOUjeadzvyTKARM68QH1UQ25s8KyA7PxGukbyQE6Bpfx4RW28wzAISqlobNqW4cL49+852FBDTrCELIh81NseYaTez+QUa+2s96iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5m1BuMA; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-30b6bd0a352so3735981fac.1;
        Tue, 12 Aug 2025 14:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755035127; x=1755639927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gorU7XJ9pBdmE8Ks9apeoV5DdUg3YQoanjxR648tULg=;
        b=I5m1BuMAagN0TZMWaANuf4/cqFE+CRPUCPHPcuB9G96VYHFs7xNLiOufH7YmGnObId
         V/YOlpUhEUD8NXjCeHMLSB+ca9gO1qPQdFTk6SWKBe3drckXXeG1facwBavXvXqs+mpy
         2kp5ucoarKmM3mGFYFu172gTnZAkzveMgE9ajN+3tGt4/MuFutJGrlsHIAk6e3W2wX+g
         z6aFbKYj434qSQJOitjRmxTQZ8TlRmiOSglkD44ubITmZ6d7/xFwio+YPLP0Iwjg/5ap
         gUSULrIh2MVgDNQiUoYjpvWpw8rscj7PJMELWfZnlu1C3Zjkpre6EsweMr0QHJmXl9eJ
         1Ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755035127; x=1755639927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gorU7XJ9pBdmE8Ks9apeoV5DdUg3YQoanjxR648tULg=;
        b=SyvLUV4OOvmPfPAaGhil0ShLRQ1mu7nUKzrw4/rofxzAdZq9FMo+2vCXivr9MnyVyO
         Vr5cUFnHWOduudRM+RgKjuQdol1l+BWmvfl07FeOPTpPq5KEspRPYF9ofbJhBGXkyV25
         mGA2LBe/VxJ/V02upDEwpRO9dmzh4sMcuVhNDXyK8n07/tYFoV3gBXP/BplTN52PmwqS
         aiv25Dmw3UJ3SgDR0Ya/70z2Dxo8ZlBlo9EsiYmJRLSUpXXtwtpDckfcrnB2GipWUtvw
         r8r4QNhNvKBHDeC6/wnOlAlJSyV6UEoDRCjOt3YJEXiBOhONopU3r8aioJ2aYsjUfxWI
         nHKg==
X-Forwarded-Encrypted: i=1; AJvYcCX7DCVdMDLlWP0zqozwof9+0hZwrdFv3quSpnig6x7oiSi5Mx4JNqgd9w4xUd64iZe9MpQ7P1qb2BlF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4kDDTkX6Lcu5cGuq3B8uSAsf9ZbPqQ30uLPvwxl2fzxzMyzkZ
	eL29dZrT8BWaiJf51Rc/cQLneQHfnpV6Pr6fhoDesKGst1nCu5V9JDcNTF5qKQ==
X-Gm-Gg: ASbGncss0PNVA8Oun76NrFXJzmmdCxJbDEQOrnXz23biEja/nNmdtOc5uXAv0fyqsM5
	W19uIcb5H3YnVLz3f9dGj8gqjg9F5i8p0tVB79JOIbxcYo3fzXLq24Nt6gruuVQnnJCOzBovSXg
	/iHw/ZMAIm4UGy47f4deYmqmwvUUVrlmdPha645oXsZzoLMqsNPHuGD/2TCHPToNwfc4QGS5inZ
	7rsMq0ymK6JGfIqdK96CNxyyTOtBkB3ZRZkpi5TFmk6miDGvB9CVD+KWTb50t9LH52M6iGWVmFj
	gdOPQRW8JPVu76tjOsUQCNDDKWZAeXvhjUHx11ziXHHlBaGqfkrANcF5Wvnau0ZJv3LqPl7d7FV
	2I9zpt79rVTw7xwSPNH1zSeX42OAm3lfG9iy6EDcG8yMJTOkzRcAV
X-Google-Smtp-Source: AGHT+IFKN3KekUT9Wl4OUeEZLoTEscX14VE8cYp+aWp3cWz2mPuHWaB0SViDjcUk8/bHCAmKlMFdAg==
X-Received: by 2002:a05:6870:cb96:b0:2b8:78c0:2592 with SMTP id 586e51a60fabf-30cb5bc35fcmr491182fac.23.1755035126982;
        Tue, 12 Aug 2025 14:45:26 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:d904:cea9:a76b:d0a3])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30c10c7a694sm4092741fac.9.2025.08.12.14.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 14:45:26 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	broonie@kernel.org,
	lee@kernel.org,
	lgirdwood@gmail.com,
	sre@kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V6 0/5] Add Texas Instruments BQ25703A Charger
Date: Tue, 12 Aug 2025 16:42:55 -0500
Message-ID: <20250812214300.123129-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the Texas Instruments BQ25703A charger manager. The
device integrates a boost converter with the charger manager. This
series adds the device as an MFD with separate regulator and power
supply drivers. This allows us to manage a circular dependency with
a type-c port manager which depends on the regulator for usb-otg
but supplies power to the BQ25703A charger.

---
Changes since RFC
 - Corrected some minor issues with code and device-tree labels.
 - Replaced most of the manufacturer specific device-tree properties
   with monitored-battery properties.
Changes since V2
 - Added reference to power-supply.yaml and removed note for i2c
   address per recommendation from Sebastian.
 - Corrected documentation error for charger driver found by kernel
   test robot.
 - Corrected duplicate POWER_SUPPLY_USB_TYPE_PD entry and corrected
   ichg logic in power supply changed function.
 - Corrected missing linux/bitfield.h header in regulator driver found
   by kernel test robot.
Changes since V3
 - Changed name of regulator from usb_otg_vbus to just vbus to align
   with datasheet.
 - Additional cleanup of the device tree documentation.
Changes since V4
 - Replaced instances of dev_err followed by a return in the probe
   functions with a return of dev_err_probe instead.
 - Simplified cell definition of main driver for probe.
 - Updated copyright year to 2025 on copyright strings.
Changes since V5
 - Removed erroneous Reviewed-by tag from mfd patch.
 - Made mfd_cells static const in mfd probe function.
 - Removed unneeded enum from header file.

Chris Morgan (5):
  dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A Charger
  mfd: bq257xx: Add support for BQ25703A core driver
  power: supply: bq257xx: Add support for BQ257XX charger
  regulator: bq257xx: Add bq257xx boost regulator driver
  arm64: dts: rockchip: Add USB and charger to Gameforce Ace

 .../devicetree/bindings/mfd/ti,bq25703a.yaml  | 117 +++
 .../dts/rockchip/rk3588s-gameforce-ace.dts    | 122 +++
 drivers/mfd/Kconfig                           |  11 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/bq257xx.c                         |  97 +++
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/bq257xx_charger.c        | 750 ++++++++++++++++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/bq257xx-regulator.c         | 188 +++++
 include/linux/mfd/bq257xx.h                   | 104 +++
 12 files changed, 1407 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
 create mode 100644 drivers/mfd/bq257xx.c
 create mode 100644 drivers/power/supply/bq257xx_charger.c
 create mode 100644 drivers/regulator/bq257xx-regulator.c
 create mode 100644 include/linux/mfd/bq257xx.h

-- 
2.43.0


