Return-Path: <linux-pm+bounces-31292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8749B0E229
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 18:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F51E188E2EE
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 16:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102AB27E1D0;
	Tue, 22 Jul 2025 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB1HTTVp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7633827B4E4;
	Tue, 22 Jul 2025 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753203039; cv=none; b=XJmXnx8eJLX3EYfZC0r5r0EZOfaBrArzDjbiyNWw83eU8koUzFnt6hx3NWwdRdTOk050iDulO/VSVGMBPNPCcXMaCAvogL6cW4d8768N3H+rGUPwOuXbwPAmfvhaWONbeJz2VSAl/tUb18FuAcxnt7+56wmwe/AYJGus0D0gpcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753203039; c=relaxed/simple;
	bh=ElJaagNu/dp1z4ELL61pMs6Nv70Ml29RGYD2ilayrmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VdVWmFB9JWU+IEYUXi7li8hZSXLcybKG2EpwWrzTZdveW6/J5EzWTsSSBhdsvd33gcmBSNvlCJR7BlHy52AFXP79C3LhlIjP0HOpLxv2cs406HnXsLwuQ0XmsxldmmKKcTUJr8zbJn1M/ISbJkjuSPNVcXEHxcPvfP9P6GFIFFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YB1HTTVp; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-73e55e829fcso3231045a34.1;
        Tue, 22 Jul 2025 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753203035; x=1753807835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wE6+8XmJrJLyyTjnrj6vJNfHXKK/OC8GAtAhiKrkwI4=;
        b=YB1HTTVpuLr7VFnja/DmsbV5x2KalL0wdapfB/RmruYGEUzkSWpqP0jEDOX/mb0ZSu
         6sxkM4zwMaCOkoiwfplw781J2sVCOLP8C2Wr90EKMnzj/WdOOgFmjeV0v9kwVDnzOECp
         9lQBxErkVQw1i8TdozAgl4UkG6Zs7RKPf/7UcOJBAeTthOcL9yBGTDvB2Ue1pjSdcg7Y
         Eyv68ClNVn40cf8JW3946VS2vcMgQovJHwG3i0RaF76w0p9Vl5Rv36iX/ij2HCqf/dY+
         gWk9oNuE7WCQ2mC/ZQS3UNBDjL8nI6zVKQ7kZFwd2q6k6FCnV8JdQdrAOzzSbuXW7LcT
         +I3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753203035; x=1753807835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wE6+8XmJrJLyyTjnrj6vJNfHXKK/OC8GAtAhiKrkwI4=;
        b=SqSmup0XUlKNV6b27raa9oqYHNKEcCyab5v5EahpBjd+Bl3et6PpQOgNwW7c+eTEc1
         u80cUppL6JOxJnJbvaz7wc+X+FVHzz3LvAyt7RdGp/CuWGfgAkduOIAclo1oHcrC5p12
         sVAwwOBPEoLrE6TKO9d/kEBpJswYSB9mzZgYZm4US4UrknsE2WkJSe7fvNfsFGmu5qwo
         7HSpfeWOBZsqGF62BdiOPL+MefDN7J7EtZNrxPachKa2IPrxYVTuvzVqxmzVJdIzpcO9
         4nXFrH4Gq5/gmNaMjezmmjts2W3Pad4dKOTD8/vkHXPZLN9mMSOHa6PGmk+3ZK3lrZUA
         UixA==
X-Forwarded-Encrypted: i=1; AJvYcCWcjAcGAUfyv5uBDURZ4aWDpHqwKFK/Q3hGD9ok5bhE4APSOQphnRwu/9sxxc+XlMTCMopWB7v7wPD9@vger.kernel.org
X-Gm-Message-State: AOJu0YwAy1qOsxLztFD6EI3MxQwN6yHcxfIiOT+CDXCrOra8JuYNdUJS
	oKNKwLwMtmfJN5qOUYDWmj+bI1xhRjH2zHOcyQqDObs56QZgIOR1Bs6HXAe+cQ==
X-Gm-Gg: ASbGncsAJM8n3dW06hom8mPCe09oQqmPS5FlNq+i3PxsuWAEMHvRDKaxqoq2km3ogot
	dwVD5pA0E6fbb10OkH9/Xo0kHbM9W4eLwJeqptJ3wVc2wYMqE1FffYwSDKjTFuUuj3z/xEtXNQQ
	Cl1p/MBDBsXUagfOJGDbisygDDFs20OZ9/RzY8MuI54moOny6mHrN8YbQjRLOkDm1XqloEfC3nJ
	sv/Jiy/BEAx1s/l2OKSk5Bk366mJyvxQ2Dy4qedIoazU9o84pwL5oah4GECwAgcnSBdyhUlB+Hq
	PvqUmaas2vTMiBmPiz4/uGecfkD/5Pk+jWuZ2ERHYJZ0ho6axqCrR5xg1LjOcRV0nhr7W67cBZY
	enjmuvKbLExaMSr/o9ngf3kt6P9v2pBb1lN1E3GVZUc3S7U/20m1y
X-Google-Smtp-Source: AGHT+IFdRQHUeOzT2eHd7/mPpbKpQC1Y3MFgripQcUYTDiczT+d3dOOvJZ6Im4NIu3Rx4qRA/3uJ1w==
X-Received: by 2002:a05:6808:15aa:b0:40b:a456:e71d with SMTP id 5614622812f47-41cf0abae38mr18637114b6e.35.1753203035197;
        Tue, 22 Jul 2025 09:50:35 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:a130:f3a0:d203:abc8])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd59531d8sm2935217b6e.42.2025.07.22.09.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 09:50:34 -0700 (PDT)
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
Subject: [PATCH v5 0/5] Add Texas Instruments BQ25703A Charger
Date: Tue, 22 Jul 2025 11:48:07 -0500
Message-ID: <20250722164813.2110874-1-macroalpha82@gmail.com>
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
 include/linux/mfd/bq257xx.h                   | 108 +++
 12 files changed, 1411 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
 create mode 100644 drivers/mfd/bq257xx.c
 create mode 100644 drivers/power/supply/bq257xx_charger.c
 create mode 100644 drivers/regulator/bq257xx-regulator.c
 create mode 100644 include/linux/mfd/bq257xx.h

-- 
2.43.0


