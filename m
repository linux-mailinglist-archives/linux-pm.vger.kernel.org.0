Return-Path: <linux-pm+bounces-33855-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4A3B4423B
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 18:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7B3A44583
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 16:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E24C2D12EA;
	Thu,  4 Sep 2025 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQeLaCbu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A6915B0EC;
	Thu,  4 Sep 2025 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002091; cv=none; b=eBuuVMrwlyjTUaWjydB01qK/aiDFO+HqnjyD7+wXEztSNH46cjP5Ex9S6jf4zHr/f90qou21sKnP3bWqfQjBCuwI7EKQXz8bx3YLcPo8frHyTkyZJHfjzFjutpAYO2HVUiDm5flk0w/M/w0XzrxJvzpZeR7NPXC/Eyfs0DVxGVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002091; c=relaxed/simple;
	bh=hjfEhzugQD19ibBRchiFnAbtH7EF4Igl+FxrYCdziFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ezUv0tGB12xZsOLVDx0yg8iJCyNHIhgdhItNI96MbBF+2LrMz6AgqfgSMjVsgsW1TRNobswQI8RgsoNKVXPIPaBMd3U//IbuO4LRZ/QSaBT+KS1OLk2wqiE+xBN124bhixy/dpxD1yM4AMbEbiVRdakPdFa54F9gumOpZEjy6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQeLaCbu; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-31d8778ce02so340120fac.1;
        Thu, 04 Sep 2025 09:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757002089; x=1757606889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dnLQTlyK5KH3ehk4moKP2An86eSERrKdK5nAInHs2V4=;
        b=mQeLaCbuiA9jk7l2dv3YQd9SIWtfuFAWKKLTefvgTZDRkZgVBpU6wX31njPG7bUEHm
         L89Sfee+XlUSC9x5uMvHRnkHtVhi/KuWvf8Z9N0kCz5WKZr163NH/6wq6WldS5ko86Et
         jjDMAvb08ITOD7StvG5aCis4Ga9NBRiC2X5PqyQvudzyw0di00jbQi4w+20ziJzAW2y7
         lAqI/b2fJBMMlS6tuWoPjvrM/yZaeAUDxm8ojSK0H2LAM3ENC9gQIHKU0dYwUyIXU9eV
         ZbD04WhM3bo7pw7Btx+xDH0uZ9rt1eiU8Uea+HnVQcrV1d0czXjyiQyXF5K/r9R9I1+W
         1Vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757002089; x=1757606889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dnLQTlyK5KH3ehk4moKP2An86eSERrKdK5nAInHs2V4=;
        b=uBPQujDzgypItZ0I83L4nVeZVQNURVPymBapt7z7VSw2syYPxX96Gg6kh4LMDwBEy2
         T6BlpXG+/o1WkA8VpTFqt+zh5PvaIO0zjDI4XiFu9cPYLhQgDEEuSJwXbpp74+qynh5q
         mM7Lx6cp4bP3BfO+/yePIPpeBCkKCSg5nlP3KqFoBLBn+OZFmE6tVMVhtvFXc2LY0KXG
         hhtBC4fxdDliOdfzi4vFNO1Gu+rea/zl/Y6KaK46otiGUHORnLFZoENSyBFZlKZagJOx
         RIxQgL0T2+nluhii9wAlFUfi1R+Gr0ZjS5y9eJ2QGzEP74eQk+lB+EhaWFjfNtY1XaT2
         ezXw==
X-Forwarded-Encrypted: i=1; AJvYcCW0htnKCs94GLJkm3JA0am/imV9peUc9yHublFT2oHti6vkkHvaWYro5tkBRXha+lzOfAu0abGMGdjg@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc5J+1l7+hbxizQdn/SFjNuq/ZO74l/gN0GV12VdBbmtpjXEz0
	VsyaH0+9dUXvBKJVBIxT7J45nLIWOVzzPWMOFfFMNpfE/c5RV8BaRuhPXEgjiA==
X-Gm-Gg: ASbGncs4qhXKUDIHYkQ5HfTGhiIVvKsEZuw6sQqcx9DBXdJmkUMzXiSuH++Xcwz2oVF
	kMiWyiNRjv5EXUHfWaYuu02+mIcNk7PAvvXg7elG6zlk3VlXYK5kPwxqQv40AFxFWrDxugA1ubB
	OtDyljqGCs7rEzwU+EJdAxXsznpQZpHVldIWxiqRs+oS8yAEqYyk2aFXyOWYdNGLT9QYgu2yOB7
	D5cZeq+Jw4tulX1TEgiYtyksZejwA3K2vHg5OgyzHrijA130mYomokc3lgKhD1G80tltnIIPaEY
	CaPsJzGB9J8gUM9jl+sUGvKbj+EkCMWu+0CNOyDgS0UKPKspVQb39+AsJp/8a4ZtbjEx0kJ2Wjs
	xxJxQmg7C1ZUd55fnE26ZlpIKkih7pf6cbRLn7sZskzN5z9dlIDiM
X-Google-Smtp-Source: AGHT+IHAQn8TOWyz0EjpBcfuRhkynnc9V07I0DmI0NICnfkyTH8REAuzTc1BBFIjCRqvT5UC1qY6Zg==
X-Received: by 2002:a05:6870:7308:b0:2c2:4d73:ec43 with SMTP id 586e51a60fabf-31f3bc02ed3mr118866fac.15.1757002087843;
        Thu, 04 Sep 2025 09:08:07 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:c51e:64e3:dc5d:9652])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-319b5fcbf6asm2437593fac.20.2025.09.04.09.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:08:07 -0700 (PDT)
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
Subject: [PATCH v8 0/5] Add Texas Instruments BQ25703A Charger
Date: Thu,  4 Sep 2025 11:05:25 -0500
Message-ID: <20250904160530.66178-1-macroalpha82@gmail.com>
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
Changes since V6
 - Fixed https://lore.kernel.org/all/202508181503.GrRD2T4C-lkp@intel.com/
   by explicitly setting the register in question to 0 and adding a
   note to describe the change.
 - Fixed https://lore.kernel.org/all/202508210308.Lw2Klipk-lkp@intel.com/
   by changing an IS_ERR_OR_NULL() to just an IS_ERR().
 - Fixed https://lore.kernel.org/all/202508141051.hwl2Erq6-lkp@intel.com/
   by removing the uninitalized variable in question which is not
   needed.
Changes since V7:
 - Changed regmap cache type in mfd to REGCACHE_MAPLE.
 - Corrected mfd_cell struct location.
 - Added whitespace for readability. 

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
 drivers/mfd/bq257xx.c                         |  99 +++
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/bq257xx_charger.c        | 755 ++++++++++++++++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/bq257xx-regulator.c         | 186 +++++
 include/linux/mfd/bq257xx.h                   | 104 +++
 12 files changed, 1412 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
 create mode 100644 drivers/mfd/bq257xx.c
 create mode 100644 drivers/power/supply/bq257xx_charger.c
 create mode 100644 drivers/regulator/bq257xx-regulator.c
 create mode 100644 include/linux/mfd/bq257xx.h

-- 
2.43.0


