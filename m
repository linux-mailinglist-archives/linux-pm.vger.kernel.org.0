Return-Path: <linux-pm+bounces-24121-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B982FA6362C
	for <lists+linux-pm@lfdr.de>; Sun, 16 Mar 2025 16:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C371C3AFD82
	for <lists+linux-pm@lfdr.de>; Sun, 16 Mar 2025 15:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCF11AF0A7;
	Sun, 16 Mar 2025 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNb8qZOD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D26019F489;
	Sun, 16 Mar 2025 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742137990; cv=none; b=mN2RXdw4N5kvsBPmu524RRdAYX8AAVLfyXuTK1nfMpTJzaYT80I0m3VQFmuTljnszkAM9MXOP16QNLF4c1iaTQ1jgmEXctNSEhnQ+3QE1Cko3A77IJE9VCly3R4BxN1NFbmIWacaKS+5y3tkYrZ/5Y+AcbyYO5PtZ5piRQxPIq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742137990; c=relaxed/simple;
	bh=8CBBywWLpZizJNj+z9ZtPQd+M4YuSb4aESlsynHJ0jA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGGBAhV9ozYMWxnhK+Pf70YN/v2wp4+1gIKXTRVcbCbz2H+bKuqyaEt0N6X8E+4Pa+c6M8MyBDhUrO+Ibqz7XUjNEay8usyBc6tpB5pFuEAhyBK+NQae9pXKx70QhiwlefztzWHW1X/2RMcsZgLIt/f+aIkODh321EUNVK0LAoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNb8qZOD; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso741574666b.1;
        Sun, 16 Mar 2025 08:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742137987; x=1742742787; darn=vger.kernel.org;
        h=resent-date:resent-to:resent-from:resent-cc
         :content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h/E+NEERZ+H3CAvZaK4gBU0W8710bx3dRofufwUO4os=;
        b=aNb8qZODJxgyElEjV5xSV5c2TOaVsEWAr4OPHnScE3Ab9rdh+cUEk5kfI/9cI9Mop2
         ZZo0/zP7M8WwImBwKtrppPfpWC+n6af9lqnqy/lmDvULBtQ4ZADf6R4HmCWDZ9pEF76r
         R7yaD91zaHOarlhIU4UO2obDm2zWNTZzB10SLz7ON8TIZS/dV9iOO5EQIcnRvH60DSRj
         A1ioRW3KagCSRyAeEBQ2UgnmSScmGGqCXO35MWdDXs9fNhRNQL8CcR20gx8LbVEI3qmk
         ytqlnZL/7Y0A9sICqrgwSMGrhhZCMv5oPPEQrxWBd8MdEopYhnIPdBeErhpae4EC39RP
         Q3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742137987; x=1742742787;
        h=resent-date:resent-to:resent-from:resent-cc
         :content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/E+NEERZ+H3CAvZaK4gBU0W8710bx3dRofufwUO4os=;
        b=wmZ1AfeE5BrLU+mWRUv4ox0DekOmFLRyHdnqjg58Rc4G+zD3Xc2QyR9Nt6z3X9YIfj
         cIG8cKCw04vY6mvXlGOPd5e9MlPUHF9Nr1DF3PZ1+Xk7lnEy+YrmY97IObXO5wjqiV0s
         39RQBpYQslRxfqkqpm2JR9s+GknG3R6yy7NRQcQbnCOQZFUdBgB9iFoUzleqnoXoof+5
         qwWC6LOJ+NuShvUfP4YAoRLK3LcRuSJQBvw2bvuAFXFsuaLymdCT0JNUVEPdAXn0aELC
         hEyjtf8JpEfarJenTLyj6RN2S/GRgaDx+zE9hBY4GJ5PaAP78BIHbJI2s7YRsHWnrRlX
         ww5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUI9e9GvN123sP7KnXJibuCIyQp6POP5YL3Rgtq9dwQYHOvVaUKhSx4zKEYM4NuMwWXJi2/N2hOXLM=@vger.kernel.org, AJvYcCXX2F1P3M72AXaQWVuYe9JWvrMKIbB0BI6ESFBxhk9h9qt4xJXEPHWEyNMRPaIjOR83VyBXLzPTtchU@vger.kernel.org
X-Gm-Message-State: AOJu0YycErVdlzh7dGWGcS+kONfnYGHIIx9t5G4B5w0si4Qz6g0A2hGW
	eP4Jzly06r2CtrqsLHWvmsdhzVAzzUm7Pqdxog983iHZOwpHu/qc
X-Gm-Gg: ASbGnctK6JQjwUlo1QRWVbc0tJO9khrlCRi33PSmrEJCh1osO62JfwhAxdrWM1BNxol
	bXLJ6iD35bJpHpZn0/Dvy+g2qUzvD+hD9aGT0k7FmweBpKk1sXC/FQMFdBcmOmAaSJDQHthcQrk
	8851qqn04kZ6M/uGZFe4oBvp+jiWxoy4LOZMpFYWW0I9aI+BUb7gSweY9e+G2IcQW4KTiZtTP45
	ljA99Pllj/DDkXoctHtNpmPBNOQVr4rABIJsKuy2sDe/5+EG5nxW+ybVjDUSn6T6Zu4El1SeZ9/
	xqm7KUaKKWHcRQw14ljfWa6+kkH/FdFuHtQU/iTHQiu5+YBeBcTCaxu6px+B9Q==
X-Google-Smtp-Source: AGHT+IGTS/IH9Jy4ptECuzHnoCjdt80rEBurz7L5YJD42LFJt0kfUTYwqPEosmk3ldjRVrtw0AYLZg==
X-Received: by 2002:a17:907:6ea9:b0:ac1:e07b:63ca with SMTP id a640c23a62f3a-ac3301e8ee8mr938663666b.22.1742137986263;
        Sun, 16 Mar 2025 08:13:06 -0700 (PDT)
Received: from giga-mm.home ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a46bb7sm517830566b.145.2025.03.16.08.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 08:13:05 -0700 (PDT)
Received: from giga-mm.. ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])       
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece270a66sm1559230a12.52.2025.02.13.10.22.14       
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);        Thu, 13
 Feb 2025 10:22:14 -0800 (PST)
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
Resent-Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>, Chen Wang	
 <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, Lee
 Jones	 <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp Zabel	
 <p.zabel@pengutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Paul Walmsley
 <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Sebastian Reichel <sre@kernel.org>, 
	devicetree@vger.kernel.org, Haylen Chu <heylenay@outlook.com>, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-pm@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>, Chao Wei	
 <chao.wei@sophgo.com>
Resent-From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Resent-To: sophgo@lists.linux.dev
Resent-Date: Sun, 16 Mar 2025 16:13:04 +0100
Resent-Message-Id: <20250316151310.2CCF11AF0A7@smtp.subspace.kernel.org>

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


