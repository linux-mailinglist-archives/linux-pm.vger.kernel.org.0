Return-Path: <linux-pm+bounces-32815-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AB3B30006
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 18:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A341117504E
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 16:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBD32DE1E0;
	Thu, 21 Aug 2025 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfAImD05"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD6C2E1F01;
	Thu, 21 Aug 2025 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793633; cv=none; b=jJILK6BDhl6zA+Ht3Fx5v9xExKWVUPaz3iXcK1VL2Ejncd3axuOSSvm5TFx5I+MzLfxlJ5Up52+ksmfNdddPEGvt3pr6hnED7I6emE3b1xjwBuOIm8oiLSKu6l71n1AOamXnkmtZdgsH68wQ0ptZj1GXHw3FFM4OwGbmskvwt1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793633; c=relaxed/simple;
	bh=bCQpwCwdck6LIWfrHIW6QTcX7DrlLFlcWKZ3Q6OK0yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F6sXI5fHW4yE0mT/LJWSndzb1O18EnGafTWm50ZhUM5GoW7DmHwT7lU07JizC3g1KmQbJgpy9dyBUXhzaKe/YmVGKJaeaTOUEHPn8a4WDyJmkBKb5nP71rxscBM+biVx1WK83R6cmJqGDwe2traGEdKLy7oCzXGO6StMpUyjOaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfAImD05; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-61da74ac09fso325651eaf.2;
        Thu, 21 Aug 2025 09:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755793630; x=1756398430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7rDfudab0Rnv+u7UbZXT7P8jD4VCVEkrRQzMtk5eqfI=;
        b=TfAImD05EbhzLrwHC1RxL0fElVBWruOED5bcSWQKr9p5gxIVlMYTRr8uLLTDWp00Qi
         /kA0MwMUAV8m8z9BLLFelx0Dd2pFGC8KEouEzRUKyhmlhqyhrw1tLDLBxGx2HA4ZHf63
         EQHExR+XtdUT+dLn3OO9wWx8cBIwGJsgUPKaoQ6L/5kfdPnxIhrDOo8b+VI3YJq8Sz/J
         gVMMn2OjxlQCPCSJb4bKIvWwZWKLsbPbUIhuJZahgVV3p+3VFHxz+76uAC4JDMUSgcBO
         acZa4fWOp4K892HWFImcGlJe5YrucsHIj5E9ZZNHNJpWgbSCasMeds9wC5yr6DR6Kxq2
         p1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755793630; x=1756398430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rDfudab0Rnv+u7UbZXT7P8jD4VCVEkrRQzMtk5eqfI=;
        b=CprofGFK9/tz0CqI94bCS3inbSKmSy88+EYN/JXfztHvU9KnczilqCp27cV+6jYvxC
         Z3dcRBLzKysIZKSitiHx0zb3e8kltKfOXgd0z1Uei1AJMFM7ZixJihrdQVnEN1uwTcb7
         bXpvqQjV7gbDX13Z9S3Kp8y5U0D7GkHR7xw8ZphqjGsJfXCki5qPpRKuXRwSxTSLiFkz
         wxDND9eEHPJjS4Pl0SKbDEfOW+ZHWLtfHKXCqv0s/slXt9GLuERBNylfthD8kbRtAQLv
         9zD96ILsMuvdqODOpO6iM79X/Hvmom3NQmI8fRtQcLSKfX7jxWF6xH6xjhOx2M9CA1vK
         9TWg==
X-Forwarded-Encrypted: i=1; AJvYcCWg0NweMynzppIaJgllYbZ7rYSeUbnvCEKPngPuMHpg03ZhfBt6v6ShaE3JV5PBp5Nu/AYrvlK3E1FH@vger.kernel.org
X-Gm-Message-State: AOJu0YzVeoFJQX/b1iu6v1osqWBJUZHDVz1uDjXvN5XYKhM5iz1UP2Xc
	DDoGtgVF30SrDvBtg+yKV42LuoicA27Nl1D76qcPn23wYs4lAOcBq0H/
X-Gm-Gg: ASbGnct4a5Zof6icyfiQJLGIidn3vcyLaiqPDk132hipvaTC7ZiYNVD086ui6G6RICt
	WByBrPh63gJxx1EkpIPO+3AP1gYx3pvoeeBbVaJr7qt0fiOv2L0hJEcKps/s+S5FW3hNOzwGFKf
	fvTwGWUI195eb+JXQfhYvwUN6Ow7sOxXfi5yqU9PZnXjQ/HM6GqdohYLlq5e2mvUipAuWmA4P63
	244PoROPF53KCYtpc/NYH1GyRgU6W5GJwbC6W6kIt1rXRJDYu07Lu9YS5UHPz0pPLow9h7UpJNY
	pvnORfhfbp2MDrqdUDYcE4E+Th8tFFSPdMuD26Y1RfDVubfijyR9jIEOqfvMP0Pk1+vsOqbv63c
	p/DoYT1dyN6ngBDmagqOV2pf8FoyIWrJ39QIFxX6t4g==
X-Google-Smtp-Source: AGHT+IG73zSN/nhg/OopgpRubjqGh/97oOizfrl/ctEg8LtrijqSvexogQEljBFDid+qxvaN3Al9vA==
X-Received: by 2002:a05:6820:506:b0:61b:9ca6:5beb with SMTP id 006d021491bc7-61dab2e69camr1106388eaf.4.1755793630455;
        Thu, 21 Aug 2025 09:27:10 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:b19a:18c8:26b9:21c7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61bec14b3cesm1674706eaf.27.2025.08.21.09.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 09:27:10 -0700 (PDT)
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
Subject: [PATCH V7 0/5] Add Texas Instruments BQ25703A Charger
Date: Thu, 21 Aug 2025 11:24:43 -0500
Message-ID: <20250821162448.117621-1-macroalpha82@gmail.com>
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
 drivers/power/supply/bq257xx_charger.c        | 755 ++++++++++++++++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/bq257xx-regulator.c         | 186 +++++
 include/linux/mfd/bq257xx.h                   | 104 +++
 12 files changed, 1410 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
 create mode 100644 drivers/mfd/bq257xx.c
 create mode 100644 drivers/power/supply/bq257xx_charger.c
 create mode 100644 drivers/regulator/bq257xx-regulator.c
 create mode 100644 include/linux/mfd/bq257xx.h

-- 
2.43.0


