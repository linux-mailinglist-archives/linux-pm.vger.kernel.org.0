Return-Path: <linux-pm+bounces-22027-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BECAEA34D8D
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 19:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3400E163DF6
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 18:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5052A245018;
	Thu, 13 Feb 2025 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I21OL9om"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC9324292A;
	Thu, 13 Feb 2025 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470939; cv=none; b=P+k8gdR544I5E4DzY4zpNmW1836s/gnRV4IFRE9WxpA5sZK/TTe5rXSFOtf/3ll+Vq0KqE/MzVu+AEPj5hJXYPqZtGB0pyIajdzCROHm3rsu/Fu3LnZ87s1ejSfebhZ3uo6ROb+pyK62NTwAWC8XodWTZJx5LMbcAldF8qSa2XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470939; c=relaxed/simple;
	bh=8CBBywWLpZizJNj+z9ZtPQd+M4YuSb4aESlsynHJ0jA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fam7p770QuqHSXg/qjMg+o/DHLjca/KYEWm2lYPnCFmMKDqtwbxMFKPZ8ZQxxMOA1qDGpwtHYaPFECNOTqAiI+bRX92T5EIoJDfOvWgzLnZ6akCNDjMPKN9/S/WXs0fBXjxrrEM3F98lQZ9dgEfHaFusXtA5jrSY/Cb2SmSrfAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I21OL9om; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5de5e3729ecso2418354a12.0;
        Thu, 13 Feb 2025 10:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739470935; x=1740075735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h/E+NEERZ+H3CAvZaK4gBU0W8710bx3dRofufwUO4os=;
        b=I21OL9omkLN1OzWpJa1dFSP1rYJoCsVrA1V1LHBR/rSNlAUL6V0+KBJWntcsZQhvnh
         DaY4wTJ3gJzNgJ+tU6lTl6ulK2XwaKnVqK63CGxLAxj+PjPB4uWg6t5P2N+p+r1p0hK3
         eycnJTZv86O7UB6K5ABuEKgNtFw/UucUZ/A7F3/cxEC/kTRs2xAUCS6JSHCFcYNoq1Ik
         wl0dGhMjmDx4daaXbzKN2J8Ii2S8G/w1p4TEE2JLz9x/jYNMEf/13RICj2eGpZb7zuyE
         QF4bLtbo7KyMY72PIU2PBbuqX/9eYyKYgGuVjy9SUT5VlIvu+8OXIvMoMie0OLg3Jimp
         HaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739470935; x=1740075735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/E+NEERZ+H3CAvZaK4gBU0W8710bx3dRofufwUO4os=;
        b=S/fFdZsoDponSUVIZ2H/Zmmq89ser6qdFnhFstNnP3XCTho5eNyKxkv6EoWPpnkmuQ
         U2fEcxSqC3nu5VFhaczI7EzGByxrjeZN9CvxCtxhR6IQc30J1fCjgiIQnoPr0c7oBQbp
         MRbLhpEHiIqrHRJU3efKrr0nVpiATLYtTvIAoopPgWTAzZ11VioKU0OHeh3qNRam9XLA
         gX8mB4RRKoYOdbrMKW21s/2sXkvXqA9MLoB+dl/hBBD8n7beySRgv0Z4KwrkC4Uje76x
         03BAyDg0mSnbW2KNiGJ3Xie+hQdtGG72ioYqg/hoM7aE3ekeQ6DTp8wn7IWumgu6WkyX
         I4gA==
X-Forwarded-Encrypted: i=1; AJvYcCVPz8eF2jEBXCGALK/p9/K0/ZoLmkxLqCmUZSTJ4Or5LlM6Sx1g7/xkPtFvfV/8YKZX+E8cmpVoF2NC@vger.kernel.org, AJvYcCXwW+Mve5PnV/oKrjklGlCFch4sCR2dMe/qoWCzZxm4mEJEsH4P8BuLgasbGEnTuOEnyW2TwWh2Evc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/7PCXGWEaZu0LpO+4q+0aeH1ljdZTvzl/hPtArevxnJYdC7m5
	gFLvm/sDP+2odNEJ1ca/ctM1c0dVLyKO5Lgj5jLq4BM4OjVnpLbV
X-Gm-Gg: ASbGncuFDiXWj4bkLDGSJAOVy/VLPGJaHxzFMvl93azxPd97ewQHu/CofjbbtjdYg+I
	+RKS8YGDpMJLfV73HumahWUneT0XGrAQncQCxKLRwqU6BvnqnkJ5siSxD3MYM832Lu575MpXqUp
	vr0KTFQiqTcQE2ynLebnjeSX/3czI/qNHzB9oEQm7ZIEqpGpVmY8x6DxavX/6dvYULHL1RlaaNG
	J9iVAOKK9aE+FhkyGGHHOQamPdPVIArTauDLaRCq78CGzAmMKgJle3iTTrQTkilZONCoEvjRPQM
	auk9hnmdvAN7FSZbIaynmkTNnq2b
X-Google-Smtp-Source: AGHT+IEINFZc6fZrjdeRXLHS2OjGj9ojjSsvveBDwdCRTKsop6kumf8PxLs+aNaP64+EA/5Ycanmxw==
X-Received: by 2002:a05:6402:3905:b0:5de:be17:8 with SMTP id 4fb4d7f45d1cf-5debe17e091mr5905623a12.23.1739470935200;
        Thu, 13 Feb 2025 10:22:15 -0800 (PST)
Received: from giga-mm.. ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece270a66sm1559230a12.52.2025.02.13.10.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 10:22:14 -0800 (PST)
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
Subject: [PATCH v4 0/7] arm64 support for Milk-V Duo Module 01 EVB
Date: Thu, 13 Feb 2025 19:22:01 +0100
Message-ID: <20250213182210.2098718-1-alexander.sverdlin@gmail.com>
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
v4:
- minimized patch 1/7 (cleanups dropped)
- cv18xx-cpu-intc.dtsi instead of cv18xx-cpu.dtsi+cv18xx-intc.dtsi in
patch 1/7
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
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       |  5 +
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi       |  5 +
 arch/riscv/boot/dts/sophgo/cv181x.dtsi        |  2 +-
 .../boot/dts/sophgo/cv18xx-cpu-intc.dtsi      | 54 +++++++++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        | 91 +++++--------------
 arch/riscv/boot/dts/sophgo/sg2002.dtsi        |  5 +
 14 files changed, 303 insertions(+), 70 deletions(-)
 rename Documentation/devicetree/bindings/{riscv => soc/sophgo}/sophgo.yaml (80%)
 create mode 100644 arch/arm64/boot/dts/sophgo/Makefile
 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-module-01-evb.dts
 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-module-01.dtsi
 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000.dtsi
 create mode 100644 arch/riscv/boot/dts/sophgo/cv18xx-cpu-intc.dtsi

-- 
2.48.1


