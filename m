Return-Path: <linux-pm+bounces-29192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E443AE2AF0
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 20:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1292D176989
	for <lists+linux-pm@lfdr.de>; Sat, 21 Jun 2025 18:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C92269880;
	Sat, 21 Jun 2025 18:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPUiHCTu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD75A1CAB3;
	Sat, 21 Jun 2025 18:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750529030; cv=none; b=Hm5s2UjOxx3j9euQ/KRc9itbn4StVjVB2Mz/CILKFRPjRjnW/hzwKByTHoicwcgmejqfjgi9EGCvze7j9XvUtm/x3h1vqOhFoFNVthIiF0Xq82kxWypTyLczy0s3EkD5noCK6yooKcFy4h5NM96aXNA1k82aKN71Z/sPqNaVqcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750529030; c=relaxed/simple;
	bh=zB/7QlHpIPmoheG3tIr1zNvJglXGxWEsHi8Mcd+ZN28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ra4S71h7id+RNvM+oCBeZc9QfonVp+IVzjSatRWUpNCAFxzMUqSvbBDxaiL4finbdc1oFDkMKVQtVac8yIOMqt6/PYjTJP31MfIqUC97Vo8FYVQ8JAu9amArS33F1aLHlDH4ekrcH62W0d+VBPHT1qB9BKHwuOLsQ5GcGqjG8Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPUiHCTu; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-73a5c3e1b7aso2048834a34.3;
        Sat, 21 Jun 2025 11:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750529027; x=1751133827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H0KfXV/NBkTDKDWD/tI/EX8MZ/lbEEpoIni8SgACMHs=;
        b=HPUiHCTuGe8b8W2lCWtJZxR8lDJ0sxp8+pwVFqTqNAoJt2OgQlExPNiz99z5FOavKm
         7uwEWP4/Fs3v2OOaQ8gdBTTt/LPlm8NOh0YlcBX4JdEHbG1y26az8vEuludzjD9zYlDZ
         S5628yN6HA+MMslTBxEw6AZz7i5a4YeMMDUIH23F9xNzeronz6Hsew+KYluzNuZ+JSv8
         a6nmUgZgK0UwIHQRYOHixXOMFOcwKnQlTY6/HvZtR4WHhp0g9HlRB6R5vktsDnwZP49t
         33StBoKhxnZIQolQDDhE7VUfb3mIC+yVlwBG0e64QrJ8MQ9HpnCigWkyQvklfESnaOvK
         Qq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750529027; x=1751133827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0KfXV/NBkTDKDWD/tI/EX8MZ/lbEEpoIni8SgACMHs=;
        b=lnmTnelfvm4Wtrqpe9I/df/+RCe8GUBX4JFidZfXz0cuE17LMUNDTKvzSIAFnNH/IL
         EYMyRSoVo22tjIxQN+OECocczKkEwFvAI0zHCL+BKrziHLt5CIqBB/Jx1v63HPcrfNXO
         xIoXumjI2EejkQRcXCMD66qxyRsP6tIHj+z7L8KaKBJW9PHCtcZ3Mw4//VNsCr8AhuRy
         PPhfrcC1c/5TVnX5B6lguPAZ2kAUQ/CjzOVw1jej1ZjzEdkUhtIXEVbZ1MNq7ESvfh3y
         jr7zBMbDw3zJQfBXpqOoJQL/vmhaAAS4gBoe569CRMb0lUC45vsYl8yt9lDjiFNbFTP7
         ckeA==
X-Forwarded-Encrypted: i=1; AJvYcCXJe2dAP+TiIY4PZ23MSZRAUXUcE/bRZeFKE7T5+w9ZFzc0gnNj/5sc3TxKSPkRv2Zz6mUyh6W4vk8e@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3szSNhCULepCE7eWf3sXiLFIDfFdAcjMEJ88+1oArUjRXMDlu
	BahwlIp+lh3p49s9xL/h1Nz//r7ksL1O9GOZAv6lKX39R7jPt+sEORp07NkK/w==
X-Gm-Gg: ASbGncvIbSicJmzq0aOyrDVaT9UFSv29189eHJ5mWecZZDMITjg64HfdukcC4FGl/D6
	A/tiDwdr7s+X6uqu5jd213kx4X6ttBqIH/5DA3lX4CnRVQYUDp+aKvL+n0xjV3UyKnroa8Vype4
	fhBaawZJTwMmkV/R5xkBoTNxauKgwYN8stcXgh08RDoIoJqQRp0GPfNNWihMpwSiImzXNWkh90J
	FsGa7lOLH3r0VMLwG5Dq1Rma6Kr+2cAVqfmahXCRMerD8Je8cQQio1zMHI2BTIcXONixaLV8gwV
	2TcSoMC7vcTEDSdahnk4VU6x1KdisMOs42+6fOItB+SnBGFRg5E08Jt1aq6k9VdkfRd/+4E=
X-Google-Smtp-Source: AGHT+IEpLQefJADPG3T9ukhtS1GxjWsZURA3VRvt3Yp99VT5aqi6GnzI066BJQk1hduPPv/oDf+1Mw==
X-Received: by 2002:a05:6830:2d84:b0:72b:87bd:ad5b with SMTP id 46e09a7af769-73a91a78267mr3701418a34.4.1750529027551;
        Sat, 21 Jun 2025 11:03:47 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a90ca8707sm782895a34.46.2025.06.21.11.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 11:03:47 -0700 (PDT)
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
Subject: [PATCH V2 0/5] Add Texas Instruments BQ25703A Charger
Date: Sat, 21 Jun 2025 13:01:14 -0500
Message-ID: <20250621180119.163423-1-macroalpha82@gmail.com>
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
---

Chris Morgan (5):
  dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A Charger
  mfd: bq257xx: Add support for BQ25703A core driver
  power: supply: bq257xx: Add support for BQ257XX charger manager
  regulator: bq257xx: Add bq257xx boost regulator driver
  arm64: dts: rockchip: Add USB and charger to Gameforce Ace

 .../devicetree/bindings/mfd/ti,bq25703a.yaml  | 123 +++
 .../dts/rockchip/rk3588s-gameforce-ace.dts    | 122 +++
 drivers/mfd/Kconfig                           |  11 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/bq257xx.c                         | 104 +++
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/bq257xx_charger.c        | 754 ++++++++++++++++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/bq257xx-regulator.c         | 188 +++++
 include/linux/mfd/bq257xx.h                   | 108 +++
 12 files changed, 1428 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
 create mode 100644 drivers/mfd/bq257xx.c
 create mode 100644 drivers/power/supply/bq257xx_charger.c
 create mode 100644 drivers/regulator/bq257xx-regulator.c
 create mode 100644 include/linux/mfd/bq257xx.h

-- 
2.43.0


