Return-Path: <linux-pm+bounces-13193-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED33965208
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 23:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24341C212BA
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 21:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CD51BA278;
	Thu, 29 Aug 2024 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQwa3Ij/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC9F18A6CA;
	Thu, 29 Aug 2024 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967209; cv=none; b=Cm3WhMZpUcnO6RFmlUHTtGSjcdtRyPGq4BNikqbl6EKXCLB51r8is6NMqmKh7Vgww8Pp7+vT+Avof2Abj6rPyvqFqMzduZehjx2xmnVLh+mDA2LgI5yX5tjNsMlbg0ScOOrCvPfx81V7uGx/eUdGWasdYRdX4iQ2mmHcw6a/2qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967209; c=relaxed/simple;
	bh=uMOABccsv0CGhkuAK5IMzVYjSGjnxmQyGr84lsEyHe4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YBJribmQqOH2PhBAFzrQ4fdk9E+YQls0J1sDW3dd1zU51CSwy7MqUWyL/b1SANvtsORAW0hiOV/f02/BmbZJZUM5z5FLDgJ+/OL6nSWVK6aK9pLWu58eplp3pS8yHKSwi0VJFbqauXSxpYF5WRjZd7LqTpMtO2KmxI5j1jqQB68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQwa3Ij/; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3de13126957so745716b6e.0;
        Thu, 29 Aug 2024 14:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724967205; x=1725572005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M0YYJWdsykkJQYSuBZclguVClq53sTWOz1OT0+ZWJio=;
        b=hQwa3Ij/+iswhspPVL7+Res4TuwbRDQhUih3QFvDWRfe6qPcl6KYRnbxMK8xvvDteN
         SZ05SXEYdqOa5K0vcOcrnt/GW90opURHiMtQ+D+gRxagDuHOZJIQVTJ4b6VZDKYKGWkx
         ezzfcTe3AGiXvrzKsjD/zWeVOSkb2rKh6pIttAmDKxp0lb65fYPXdL9vmwfgA1l4qrD6
         zUH/mAFNMpmEo2Jsj699QoBvawOzIjKQTKc3Df/AMPFY0vY377VmIFEKyctg77kDFZ1C
         0RuId0pZ6pZAtbIz1lcELCVsak6lXsg9CJRQQ9A/WB7Yc4DlbF1bEbONKEaYN42a1LYM
         bLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724967205; x=1725572005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0YYJWdsykkJQYSuBZclguVClq53sTWOz1OT0+ZWJio=;
        b=Vr7dD9fpBO8DVhxQ6eoJccgrC4NBPDo4rT5U4bUuy1ebbIJsKYz5E9Wlay/2OIZXIF
         /X6NZW5fLaw0iw8C2nNFqTC2x66b8Hw3zuZF0b8AMItFVHXQpT2N0t47ip8uEuo4oX9y
         n1xyJDEv7qLBZAM9OnWbtmmOYDyE9hxjUvVeAebRz/IS4EZHrCduhVZ9Y7fxeUXPQ8lx
         j9VVHAog+CLVPg3JOQ1SHZsLg9OigEwEl/a2SPPpjIjegE6Jy61EfzFbGA3qngZbItcf
         TKYwmXDW60PYDT5BUBbt6zODooVzecWNLFaSdvQaJOQwDnqhdtbPc5a1SyYXKpNON743
         iSkw==
X-Forwarded-Encrypted: i=1; AJvYcCU8Y5BDt70+AXaVR2TxGbdSC29DDXMM6W/hg1J2gxhKnH5HvvZtgidHeJUjYj1CrV0fxMzrkwy3BICZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyFW0UspReei2f5Z670eKCiMTki/eR98v2fWWuoT5pO1QVEiB5L
	huhBNSCXS52+suTLVTK8KTQTrAMb76XR/PWn+gdDmAnQJDcUeFln8lpe5w==
X-Google-Smtp-Source: AGHT+IEcpnDIedn9yCIvoZonPjKKvmy+aM3xdG0uc6vRd2/+6Qj8u2W8MgUCryQJf1t88IyXpeJiDg==
X-Received: by 2002:a05:6808:17a2:b0:3d9:e1d1:1580 with SMTP id 5614622812f47-3df05da35c8mr4256965b6e.21.1724967204729;
        Thu, 29 Aug 2024 14:33:24 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df11865de3sm93097b6e.42.2024.08.29.14.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:33:24 -0700 (PDT)
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
Subject: [RFC 0/5] Add Texas Instruments BQ25703 Charger
Date: Thu, 29 Aug 2024 16:30:57 -0500
Message-Id: <20240829213102.448047-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the Texas Instruments BQ25703 charger manager. The
device integrates a boost converter with the charger manager. This
series adds the device as an MFD with separate regulator and power
supply drivers. This allows us to manage a circular dependency with
a type-c port manager which depends on the regulator for usb-otg
but supplies power to the bq25703 charger.

Requesting comments on this series as I want to confirm this is the
best way to integrate these functions.

Chris Morgan (5):
  dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A Charger
  mfd: bq257xx: Add support for BQ25703 core driver
  power: supply: bq257xx: Add support for BQ257XX charger manager
  regulator: bq257xx: Add bq257xx boost regulator driver
  arm64: dts: rockchip: Add USB and charger to Gameforce Ace

 .../devicetree/bindings/mfd/ti,bq25703a.yaml  | 143 +++
 .../dts/rockchip/rk3588s-gameforce-ace.dts    | 120 +++
 drivers/mfd/Kconfig                           |  11 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/bq257xx.c                         | 118 +++
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/bq257xx_charger.c        | 811 ++++++++++++++++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/bq257xx-regulator.c         | 195 +++++
 include/linux/mfd/bq257xx.h                   | 120 +++
 12 files changed, 1536 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
 create mode 100644 drivers/mfd/bq257xx.c
 create mode 100644 drivers/power/supply/bq257xx_charger.c
 create mode 100644 drivers/regulator/bq257xx-regulator.c
 create mode 100644 include/linux/mfd/bq257xx.h

-- 
2.34.1


