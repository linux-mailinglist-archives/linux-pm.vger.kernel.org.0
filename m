Return-Path: <linux-pm+bounces-29614-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF79AEA77A
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 21:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229864E362E
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 19:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFF42EFD8D;
	Thu, 26 Jun 2025 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnYe7yPY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA121C5F09;
	Thu, 26 Jun 2025 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750967768; cv=none; b=f19VIcHn8m1Q4MX9RMEGqZQaMyW5cBDJfaMDU0HbBXBCDrqC9c2D1YHp8pC7Otj6k7MmgGaderDuENpy25Vjc0DibUPn0bZ7Xfbp6loAeTxRTaerT0ZvQ5SWMPqb52Cez/fekhxng1L6Jo3VuEunUolzvHY7PwxR11OHbzrgOMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750967768; c=relaxed/simple;
	bh=X1Kj3oXzK/sHnfb7WSAnH8aI7lOTApcpAFqVP2q9HXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OohcAww2tPFMLCu5iO8LRxQ22CDtnTkh/KTmyT/Cpx0PWsLiLnFXoWab0o8RgaFLa63nov+jOnSPV/tQhn2TogYPuxk4uniJNKX8USuiskT/6418gpoNUbK5m9oA8MnID+bB+dGjOYZcG/zjk9nQB2y7/yH24cUTEroLxkm4xkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnYe7yPY; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6113e68da82so584826eaf.1;
        Thu, 26 Jun 2025 12:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750967766; x=1751572566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hk3radOrdiIbqfj9Koe35i0uF/bY0CW4+GPlMQ1CzR0=;
        b=EnYe7yPYtV69lI7u3Ky9BP30Mzg8vlGuCc1DDZZ1+lxGO1dh9VTZznIX2ZhZwaObja
         GvBRDRl590g8B3hcLCInQ/dpGh+5/8ofxcWpx3c4dAby5rYJNouo7pX/hzeyPefuRvTg
         Prez783wIm8I+G6LShnRXRcK1oQ79Ld2pA0oWia8/XfnFuaxauopZ1Ydo891TizDuQbO
         xmASOKic6wH6gQmh8ddb/Hbq74frKuDvjbwFcuFjuM6NKI1ufs7ph/jpvFlMa2noZbeO
         rEaQInmWF40VS1CyVIkcNZPPysdG/1AH/3WsfGVDglU5uNuMLagVAxncHtxnwhdxRC39
         /v2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750967766; x=1751572566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hk3radOrdiIbqfj9Koe35i0uF/bY0CW4+GPlMQ1CzR0=;
        b=cwBJP5W1qETl1wZ/g5rgnR95kOGcwIYBBZTzMn5PePxzJdFuFaRyvP2xFzj6eF6v3p
         ApImRn//XdF6v/AUbBiqFZR3XZ77TMxGSecQ0x4v0tyBkc36K+Tg9eHwcMNdL8jntYgK
         U/GM3lxvsmyP/PJOUAh4ahWnT1dpWPyryGJH+LD4aoGtMBgi+57D5+b485CIPWfjOck+
         Nc52nlbS6cOcunCe5aBHY42QGviqu/y4DaDxY1Fa0CuzKT4X1UhyN/+fcrgDTqf4u4Lt
         9EXoQhopI5gJYjTW3yxk36sepZyalm8zLeig43sSnNoRP3oapjfsdmuxPGiOjGpp1eBO
         CxRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaEcX8eKBkLJcdrai+hyD2GcFYgJp9bO8dbfVQVx89dx24X7gp5lGq2IFTQdmsjIvkvDV5jbFGCeV4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7l4dCzBvTS31Lo4q/LSR/BO+W7OWUjfeuY1fx7wnBSq33f7Fx
	0meLoW1C+NAJcZuBPyVzSZZNv7AcEOON9OdzLoVS8nxnQN2tZIQ3RvzuovnS5w==
X-Gm-Gg: ASbGncuVr7wpqDSD6lyOorRqXD1leqCiH0k6KtL9xL2Q/2IRHwDhy8RR4dAn4Lh0sG1
	RIxNEDwD9bL3BvPbDBrAVyqX90rM4yNPK77eHTOQ3B7hi5k6TH5QMlv2e2Obt/x/lGpUojyabXF
	VWlzWluV+fCgD64Gqca40nlr2PbwmltfZl8mVLMCic9Ao5eoca1Yhy6BONK4fHgNeMGf29BvnbN
	v4uVnHd1QluF39ePNp9pJbN4sAmsGQ0icTNKEHeLeyJTHWuE2sjQe8+L/KCKsglT5SAKKiGRmf+
	HRbyxba3y/mv/A74Eiioflwdtzs7XaSZLywlkR9wS5BKjXZe/P1EDeq6IiQtHJmZkjL3NvuojgF
	kmD9ddw==
X-Google-Smtp-Source: AGHT+IF5S5CU5Uz4mqpGNWHcGdAzqV7+uNsJZkPUL952E2bpu12FDSIRsUQQsy2Cu0EA2r19IrYvpw==
X-Received: by 2002:a05:6820:8189:b0:611:7385:77a0 with SMTP id 006d021491bc7-611b90a898fmr432166eaf.4.1750967765969;
        Thu, 26 Jun 2025 12:56:05 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:f978:7e9c:c207:c035])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-611b8582352sm66915eaf.22.2025.06.26.12.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 12:56:05 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	sre@kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lee@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V4 0/5] Add Texas Instruments BQ25703A Charger
Date: Thu, 26 Jun 2025 14:53:38 -0500
Message-ID: <20250626195343.54653-1-macroalpha82@gmail.com>
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
---

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
 drivers/mfd/bq257xx.c                         | 104 +++
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/bq257xx_charger.c        | 754 ++++++++++++++++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/bq257xx-regulator.c         | 189 +++++
 include/linux/mfd/bq257xx.h                   | 108 +++
 12 files changed, 1423 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
 create mode 100644 drivers/mfd/bq257xx.c
 create mode 100644 drivers/power/supply/bq257xx_charger.c
 create mode 100644 drivers/regulator/bq257xx-regulator.c
 create mode 100644 include/linux/mfd/bq257xx.h

-- 
2.43.0


