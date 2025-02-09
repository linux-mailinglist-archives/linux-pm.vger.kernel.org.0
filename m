Return-Path: <linux-pm+bounces-21606-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFBCA2E111
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 23:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778D9163F6D
	for <lists+linux-pm@lfdr.de>; Sun,  9 Feb 2025 22:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3331EB1A1;
	Sun,  9 Feb 2025 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI5IfY+G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E45814B96E;
	Sun,  9 Feb 2025 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739138828; cv=none; b=do4HT5JhCROV0buFO1wicbgPooePQmOTpEMRZyt0hTLq+hXykw6aEVN+CAVM5mIEmIagnbrjxPtzjH+9Ugid2nJcX9X0gndLHLM/0yMAR5WvJeBMjoWiAAlJMWP4I4H+zKIPslpeII1eOQ1UnOdnjgsbexT+0cQkKImdAN8mxYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739138828; c=relaxed/simple;
	bh=HSwTakDEq7geIH+aAtd+PpWDLojNiFPeJOnKu6Gghh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lO+eA72UV6hagv6HNnGEtGDF/IlwV3dK8klKXKkbFOjYL6uwRFef6q4iUNBZD6K5fORf9FSpMKO0AvunBVnILTbYHESoiHWcz4fdF8S4osUmvOF8cYDdlQJ8H3Hqycw8ap0GwA99dnsuCH0kQR5x1UukcVehKZqMCB1v0Az+HMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lI5IfY+G; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38dcf8009f0so1010657f8f.2;
        Sun, 09 Feb 2025 14:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739138825; x=1739743625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0SStEyTofDPhfx4JhlqbX9qCANFPRgD9nwadZXdsKAw=;
        b=lI5IfY+GoiiI0lRjU4mcRuscevOmS7EBcuvFsIZ6/dX50uzZqt7kuaZtWRRAXYDypa
         oSDhxsUhb14/ioQ8cC5OuBqTDKROgEO6pJ8qoBguvNmFSizmvvc3V9K7ADlgNJ7End/X
         z4KV4u8IRxgFRVWbqEUymdyLJTzrd3HTwqH7U7Nn3k8k+D9XBLcvc0rDiZcVtMTu5gHI
         LIaOgmi8W5HZBAn8aJ76GmNAHfcrSBxOIinJ+1FW7hAo+80oAQ4Ie85jS/jgL2sgV99b
         HLBehqngKEMySl/XwjBYhbyvvvGbCGmmJmx4M4GlPm/mtm5csqqfwJLsqcEADpSOZNUP
         sNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739138825; x=1739743625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SStEyTofDPhfx4JhlqbX9qCANFPRgD9nwadZXdsKAw=;
        b=gb1lkOkL55b7mHJFLImEym19EJqaqdahvlJSPaiKgRXXeDEsaieEPE6eTGW6XZxTox
         tHUrf1HDvnnotWYOKE02bpWaPpsv8aqxDUudvKqhlureXEXFXjrh/oQPrhApH0qBlov6
         CYPislZK/zSC6QjmO6n8ESXHjNM6xALa+x/+drT4dQVn+JDUtonf61AJ0H40hJdkTb6P
         f7fKJKWQ+Wiz6511lR0cOQNLrzlI572G8JrQEjgcquBpkG37KL8Sy+X6UT3b1zDoc4sy
         DkD2mtJNhXz2D54QQEoc4nSssxj4sGMdDnZfdWz7D8J3fdRX2v8Nc248g9v8FfZOdD9A
         hojg==
X-Forwarded-Encrypted: i=1; AJvYcCVbLBbnYAvz22ZaF8celTezjlPYed4k2XhumO09vbtqySAS4eE3pUXBwXfS+jvAelRjaLey9hi5BsgI@vger.kernel.org, AJvYcCXQimyTAwcNLDkmm5UhKBGdJVZhxAUkeeqEqTKnv8sfaoqyyRfF40efk0lERKDwfitUuSVDE88cVK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9fReGqDoIHdqgExJ4kDl4UcBxZySJXfXKzDGk0H7D6uUr1uGY
	x6Syj1LKalHWBqiIfvUPY/YJA7Tyo/3WNzwPZMIJDSvVLxq2qV2DyGS4PO+0
X-Gm-Gg: ASbGncto8ZhMfwnxCFtunsk5wZcHp9EyMNmbVOQR2I9GCU2jLSk9xuibVIPRt9bfC6z
	nLy7C8N7CcU3wJ2H1S0dD/GJXkvcdThh36toDKpoUYcDptt7baDmyhPIzt0vGiDqJgG9uTNwtBl
	ztxDdcdrmAZPaUTWpGh8Aikdab5mpvAZV8YHTQI69MlVvOBRmrbsVQ4r2Y9VNKM/jsVC9eYdQ05
	wDoVTRgpfIYruJYgl7+UR4/VkyJuySukxEdtvsdcnDeJeKSLV66BSYfCF4HcSTibbi55GGP3aCo
	ccXDDnB6G/DmegHrUfNniMQmyd2B
X-Google-Smtp-Source: AGHT+IGaYGcJZM+92Cv8nPvpHOwYc6gunMtsp2ldN4nyyr8ek9G+l/o+4jLNm5KeXzDP/LDAiB9c+A==
X-Received: by 2002:a5d:5f88:0:b0:38d:dffc:c133 with SMTP id ffacd0b85a97d-38ddffcc58cmr305497f8f.44.1739138824394;
        Sun, 09 Feb 2025 14:07:04 -0800 (PST)
Received: from giga-mm.. ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbf2ed900sm10386544f8f.53.2025.02.09.14.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 14:07:03 -0800 (PST)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: soc@lists.linux.dev
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Sebastian Reichel <sre@kernel.org>,
	devicetree@vger.kernel.org,
	Haylen Chu <heylenay@outlook.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 00/10] arm64 support for Milk-V Duo Module 01 EVB
Date: Sun,  9 Feb 2025 23:06:25 +0100
Message-ID: <20250209220646.1090868-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds very basic support for Milk-V Duo Module 01 EVB [1] in
arm64 mode. The SoC (SG2000) is dual-arch, RiscV and ARM64, the latter has
been chosen because the upstream toolchain can be utilized.

Sophgo SG2000 seems to be a continuation of the Cvitek CV18xx series, same
peripherals with an addition of ARM64 core. Therefore it would be
beneficial not to copy-paste the peripherals' device-tree, but rather split
the most suitable riscv DT into ARCH-specific and peripherals parts and
just include the latter on the arm64 side.

This series adds the device-tree for Milk-V Duo Module 01 EVB, which
in turn contains Milk-V Duo Module 01 (separate .dtsi) on it, which has
SG2000 SoC inside (separate .dtsi).

This series has been tested with Sophgo-provided U-Boot binary [2]: it
boots from SD card, pinctrl, serial, GPIO drivers are functional (same
as for RiscV-based CV18xx SoCs).
New reset driver is provided as an alternative to the ATF PSCI handler,
which Sophgo only provides in binary form.

Partial SoC documentation is available [3].

This series lacks the support of:
- USB
- Audio
- Ethernet
- WiFi
- Bluetooth
- eMMC
- Video

It would probably make sense that the whole series would go into SOC tree,
even though technically nothing prevents the reboot/reset driver to come
in PM/reset tree. If everything would come together, `reboot` command would
work out of the box.

[1] https://milkv.io/docs/duo/getting-started/duo-module-01
[2] https://github.com/milkv-duo/duo-buildroot-sdk-v2/releases/
[3] https://github.com/sophgo/sophgo-doc/releases/download/sg2000-trm-v1.01/sg2000_trm_en.pdf

Alexander Sverdlin (10):
  arm64: Add SOPHGO SOC family Kconfig support
  riscv: dts: sophgo: cv18xx: Split into CPU core and peripheral parts
  arm64: dts: sophgo: Add initial SG2000 SoC device tree
  arm64: dts: sophgo: Add Duo Module 01
  arm64: dts: sophgo: Add Duo Module 01 Evaluation Board
  dt-bindings: mfd: syscon: Add Cvitek CV18xx rtcsys core and ctrl
    compatible
  dt-bindings: reset: sophgo: Add CV18xx reset controller
  riscv/arm64: dts: cv18xx: Add sysctl and reset nodes
  power: reset: cv18xx: New driver
  arm64: defconfig: Enable rudimentary Sophgo SG2000 support

 .../devicetree/bindings/mfd/syscon.yaml       |   4 +
 .../bindings/reset/sophgo,cv1800-reset.yaml   |  38 ++
 MAINTAINERS                                   |   1 +
 arch/arm64/Kconfig.platforms                  |  12 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/sophgo/Makefile           |   2 +
 arch/arm64/boot/dts/sophgo/sg2000.dtsi        |  79 +++++
 .../sophgo/sg2000_milkv_duo_module_01.dtsi    |  84 +++++
 .../sophgo/sg2000_milkv_duo_module_01_evb.dts |  30 ++
 arch/arm64/configs/defconfig                  |   3 +
 arch/riscv/boot/dts/sophgo/cv181x.dtsi        |   2 +-
 arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi | 329 ++++++++++++++++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        | 305 +---------------
 drivers/power/reset/Kconfig                   |  12 +
 drivers/power/reset/Makefile                  |   1 +
 drivers/power/reset/cv18xx-reset.c            |  89 +++++
 16 files changed, 689 insertions(+), 303 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/sophgo,cv1800-reset.yaml
 create mode 100644 arch/arm64/boot/dts/sophgo/Makefile
 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000.dtsi
 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000_milkv_duo_module_01.dtsi
 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000_milkv_duo_module_01_evb.dts
 create mode 100644 arch/riscv/boot/dts/sophgo/cv18xx-periph.dtsi
 create mode 100644 drivers/power/reset/cv18xx-reset.c

-- 
2.48.1


