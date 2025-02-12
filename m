Return-Path: <linux-pm+bounces-21992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A038BA332D4
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 23:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50753A4AB0
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 22:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FEE204591;
	Wed, 12 Feb 2025 22:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcbPqvgc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E6B202F7E;
	Wed, 12 Feb 2025 22:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739400248; cv=none; b=AR9zeOnqq7JDxyk7t0i3jflRpstC01iEz6WEV4sVD6JmmzYI3m2cwTlsnKMNJe0rFFL+EJLUzbdp2udAnOk7yh4V6VnPkcdepcNs7Qk869vJ7bddkAAui9h2iMjlpUlfkWezTG3hAqnDYKOXbMaDTa0cG9Uhw9urBEWNvJm4OpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739400248; c=relaxed/simple;
	bh=8XeVwHSw3fMh3jLSmwjruyUOp6GzMgE1kFJYTL7bjZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SC13y0bN19TNLettVHjdeZfmxM9H5KW2rC/E70dCA2g4vIWXf/pvjX2xHNYPCNC8UfaqYVyyF7JXtOxNlf01Kc5SEjH2m9mLY8NXGMRV+HU+tK9LrEho2ZWEaTGqhfl0aznWfwsQuFfGcjJxw6q3FtpDaCslPofH/wOTs2Il71Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcbPqvgc; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso305727a12.3;
        Wed, 12 Feb 2025 14:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739400245; x=1740005045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sD1Sd6cAP8Th7UTJsJpR3D3J20e2A9Te/LBbAhEgPjM=;
        b=BcbPqvgc+VgtXkrS4RN2hVfiHsE2O9p1sFpOtpmB0+AM1aJ94PaXuXk5P8wYK7LPhg
         e2wbdODL879I7Ut93gkH8ApJH0gcKHIKJyQLJ3EVXT3j8mt/e6wJyDzhgrpL1U+khl+d
         PIOdzvFNkP3mKTddAV2QG68NgbhqfWGPqYVRQvLycjSyQUV/ukL3RM0M0RQ6JRtpzW91
         K3bkhuML9m5TUb1ad9vf+nl/nSpr4VfqbTasNO+ePUjlqw7fl+JtVBAbIA+AMsj7NJeB
         KQgG96YzX6vv+ICJ8aOKZcLPa1QJk0bRPg/kg7CAzNLhirCZjjMO4jGz/hQNlE2VtRsu
         zDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739400245; x=1740005045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sD1Sd6cAP8Th7UTJsJpR3D3J20e2A9Te/LBbAhEgPjM=;
        b=rxMe232NqcWDGbUX2EOu/WXlFrgs09b9sf0dDgwTwzghEgLBtTiiCIfveL/feDhmEY
         xIfMuPxeLw3xwFajIQtZn04g8Cybqbm/J73EFPve7XJCsmTj6/49t7UtOV+3QQd5W9pK
         fZU68XSvo/nFHGhsfcWEumh9yR1hLvCYtkQIkPZtoMlsO/44uFTNNHHHUHi2NeXbbF+s
         CaPYAZS8u/UO9KrumFzjVU1Y3+S0QNPRzcptUK64036JboLha7b0BjsuMEPnSydfZMeh
         /StKFaedph6XSYMDD+NpugH4IxsObtwhG8ANa2oVQ5VHSQkZtfAtrw9llKVzyYpsWFuW
         wVyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKivaQxjZ4gPV5hU97jzrwXL3pmKihpwQ7pX0Jq3e7RJPXdlvW3MfNSLI8Cc90H7+Z8hYdJSqk/Crh@vger.kernel.org, AJvYcCX4zOgSd2ZKxflegzqDhwy/zmGY6xyjG8ogDznfuabbNLcczTHDmhcp3fhXO4dXr1fnloDR98LZEQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGFt16qooJSqctEtUsRZAuvwR7ZWWak/hqPMtPMOnnfTCNOGjp
	5oP81bppkVLpjY+r4bQ86noZuQmU69FjYcTBAUuntfDgEsl+4XR3vG/8iv1W
X-Gm-Gg: ASbGncuaICBB0EI99E/I+O99nYZeqhQUx8ZgRoAkzSnb42Ooc/9Ia4oLNKst/tgSr2p
	Mqzt0G3cHHDuygbNLHCT98oSQ8eOISFmMg9+UqWfBoWmiHCbeu/ofcIH1T0YtFy5LwprNJZfE0Q
	+XUgXqRejorq6ECE3SZCVuWnKEXpu1LHUzyCv0cwGgfYV2lnZhosRZzNi9HZrMWXvWwgcW0HZrU
	OG1vvc+TEsrVVQjtWj3b+OgZz75azqfjjy/6701z0/YiYotsQDrr70Ws7TJbqYTYq2Cyomu5/UG
	OsjnoXRbxWo7+b12SA+lMF2OJqWP
X-Google-Smtp-Source: AGHT+IGew9eYcM2URi/21CyZAiBNRVDDORJCErtMKBXGaipTpLhYOkMN7qo1rF4n3H1ilggRuIN5EA==
X-Received: by 2002:a05:6402:2748:b0:5dc:c3c2:225e with SMTP id 4fb4d7f45d1cf-5dec9d3eb64mr723602a12.8.1739400234330;
        Wed, 12 Feb 2025 14:43:54 -0800 (PST)
Received: from giga-mm.. ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4e02sm119914a12.3.2025.02.12.14.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 14:43:53 -0800 (PST)
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
	linux-pm@vger.kernel.org,
	Jisheng Zhang <jszhang@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>
Subject: [PATCH v3 0/7] arm64 support for Milk-V Duo Module 01 EVB
Date: Wed, 12 Feb 2025 23:43:32 +0100
Message-ID: <20250212224347.1767819-1-alexander.sverdlin@gmail.com>
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
boots from SD card; pinctrl, serial, GPIO drivers are functional (same
as for RiscV-based CV18xx SoCs).

Partial SoC documentation is available [3].

This series lacks the support of:
- USB
- Audio
- Ethernet
- WiFi
- Bluetooth
- eMMC
- Video
- "reboot" functionality

It would probably make sense that the series will go into ARM SOC tree.

Changelog:
v3:
- &cpus node has been moved into cv18xx-cpu.dtsi, &plic and &clint nodes
were moved into cv18xx-intc.dtsi to reduce code duplication;
v2:
- dropped all patches related to the new reboot driver and corresponding DT
and bindings;
- grouped DT-related and config-related patches together;
- added patch moving sophgo.yaml from riscv into soc (to share it with
ARM); added SG2000 SoC and Milk-V Duo Module 01 EVB into it;
- other changes are documented in the corresponding patches;

[1] https://milkv.io/docs/duo/getting-started/duo-module-01
[2] https://github.com/milkv-duo/duo-buildroot-sdk-v2/releases/
[3] https://github.com/sophgo/sophgo-doc/releases/download/sg2000-trm-v1.01/sg2000_trm_en.pdf

Alexander Sverdlin (7):
  riscv: dts: sophgo: cv18xx: Move RiscV-specific part into SoCs' .dtsi
    files
  dt-bindings: soc: sophgo: Move SoCs/boards from riscv into soc, add
    SG2000
  arm64: dts: sophgo: Add initial SG2000 SoC device tree
  arm64: dts: sophgo: Add Duo Module 01
  arm64: dts: sophgo: Add Duo Module 01 Evaluation Board
  arm64: Add SOPHGO SOC family Kconfig support
  arm64: defconfig: Enable rudimentary Sophgo SG2000 support

 .../{riscv => soc/sophgo}/sophgo.yaml         |  7 +-
 arch/arm64/Kconfig.platforms                  |  6 ++
 arch/arm64/boot/dts/Makefile                  |  1 +
 arch/arm64/boot/dts/sophgo/Makefile           |  2 +
 .../sophgo/sg2000-milkv-duo-module-01-evb.dts | 31 +++++++
 .../sophgo/sg2000-milkv-duo-module-01.dtsi    | 85 +++++++++++++++++
 arch/arm64/boot/dts/sophgo/sg2000.dtsi        | 75 +++++++++++++++
 arch/arm64/configs/defconfig                  |  4 +
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       | 28 +++---
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi       | 28 +++---
 arch/riscv/boot/dts/sophgo/cv181x.dtsi        |  2 +-
 arch/riscv/boot/dts/sophgo/cv18xx-cpu.dtsi    | 36 ++++++++
 arch/riscv/boot/dts/sophgo/cv18xx-intc.dtsi   | 23 +++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        | 91 +++++--------------
 arch/riscv/boot/dts/sophgo/sg2002.dtsi        | 34 ++++---
 15 files changed, 347 insertions(+), 106 deletions(-)
 rename Documentation/devicetree/bindings/{riscv => soc/sophgo}/sophgo.yaml (80%)
 create mode 100644 arch/arm64/boot/dts/sophgo/Makefile
 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-module-01-evb.dts
 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-module-01.dtsi
 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000.dtsi
 create mode 100644 arch/riscv/boot/dts/sophgo/cv18xx-cpu.dtsi
 create mode 100644 arch/riscv/boot/dts/sophgo/cv18xx-intc.dtsi

-- 
2.48.1


