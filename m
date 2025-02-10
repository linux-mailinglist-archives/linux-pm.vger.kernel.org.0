Return-Path: <linux-pm+bounces-21754-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D769CA2FCA5
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 23:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC8767A1C80
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 22:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76CB24E4B7;
	Mon, 10 Feb 2025 22:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ljp30hyj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B6E24E4AD;
	Mon, 10 Feb 2025 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739225405; cv=none; b=qcikKU9Y6ini38P7LyStGQTdT3NyTB0dJgfZ9jls0Q29tDC1acq+PNQicMHUp9jGlk6g5u6HgH32ZLgWjXKHjcdlXcyw/NofZxdcoGwQPul0IOfNbt0aSrtT3jIjNU+2SOYaeQ2pQfcAdYQXrImaHYbF2Y8+9YqTURc8eoDhW2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739225405; c=relaxed/simple;
	bh=n/w2b7Sjc7V9PG8urLEvcLmESDrzmi3ZtRXA0E0OXCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gGLUMvDGB126/7lNLG2r7O6Cg9Juv2CCPBUi0XS93jwWXI/lRriw0vxYo73oeFi/y+zLKVnxFgT7woDnUtgXb/ZjAzG/pHfOZSQXvFSePj+wbwSZx9+1SeOnKxoA3gOSbBZh6YLZBgUrDCpsXoRWNfb0I9ytrGw89MIGXRxlTC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ljp30hyj; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38dd0dc2226so2642579f8f.2;
        Mon, 10 Feb 2025 14:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739225402; x=1739830202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWyO6Omj46BLGouriEYcHBj4I5jL2cpuWdyYPhlUQ7g=;
        b=Ljp30hyj2R2HhHrCbgRh0X0TK+jaLlDUBPvii9g1i5zl/xB9LBE2BKPb3L/m5Or8Ya
         W42jQPGTvKmDqJkJPtBhCxOwtL76nqFD95Q1CWTuaI24E2RFbMWbCAXmNmO0AtaRzin2
         sQbs4+93xrPgtTVUTwQ6cV54dzQCd7lUaoOhQVh5DMog1b9oBXs1oFftUjph9DKHA/Rs
         hk5RMb1zeSxCEE9SwdOMxTr9x525441v0/GQh0/b7KDv1IhpEGafToDIyyIOcKP9qQLr
         FacTeywMyRIsoqId0+CD7PXIDe7y2aKejwKq1wQ6AOG1u0hZgj78nCNVDAIcJ98YKwTU
         EirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739225402; x=1739830202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWyO6Omj46BLGouriEYcHBj4I5jL2cpuWdyYPhlUQ7g=;
        b=D/IczUAgB8+u3nvAMj3p+59TsFJ9c0OYu1jpmL5y1MmcNfS+PQKOrDlnCfvMmmKuPE
         hf+RIilL4rq0436f6OzY7DnB9Y5yI8y+G0oZ2jpwVvMxWXvQV59Z/nmpPP2dCWW/nLTI
         ciHsB4ph73bB9XjvMjGxzOIbslSSMB5qkz9nboq/iUFc0+WoWtZkWDh43YI4DKQraKPS
         h6sh9xBN/vFnItUjX9ENsNFnbPUfuxhvb6XabUgm+8Ilmn42tYdcrG+w2cBke0haA4SP
         QZszRBp7m+xVFXIq8Ck3n+e0bD6ZHBontxW6+FIx/MasyJ1SCAfvLVbBNBUnFVb+2hKh
         0zoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6iXOXoEWWTRe2ySDTF+XFkkr4LN5DKm762q8zO4RSxdq0aeS9u8D35GYu8Wk8t091w6neLE7+NODd@vger.kernel.org, AJvYcCXAYRZzulS0EiPx6GQ+gb32m6C0ACf8PDmSn4itTTlkHkoOW/95GI86feYqxh2fYIiuzJekFjk2m6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuBFnP1Cq/AvRzSnHveBf7x8vsnrVV3056cKVnttlG/S2zQ4TX
	bmIFh+jLwazLFdbZgxd/vxReQI8RVXRR3oWBWIPc3Lt/nUz7ztOG
X-Gm-Gg: ASbGncvgcG5Sxszq+GvudA6P7CMVzHN362l+KAZyTCAhgc/s/BCHE62clG2LL4tQIy3
	qFheq96G/c6f6h1zc/XnUQaTdAyrytlMYzUQ/KqQ4BG2Q/mY+fv6kLaIycy+9FSZ458bIFAONHB
	r+hXuxyEZ03w2ri30QFsR7nKqF+B0LZVpo7M3ybvP7OZFK/1myBUGr5I8mGgUTFeJlkGxNJswN7
	AYhfpUyllOmxtKUS5izSsGYCjXvcsYrXD6CHhgs5wrZdvNOBVfY+of6q1xUpn6BaHlhIduPhsMH
	K3p8cGkUwB5a0L4D77Zp6zSJoUkv
X-Google-Smtp-Source: AGHT+IEMaGIcU19hT3jyRgsUsaV8XvP59su/yVG0KhKsBGbkZitk0/Jmb/o11eWD/isTEql3vIA+Cg==
X-Received: by 2002:a5d:6da4:0:b0:38d:dd32:c939 with SMTP id ffacd0b85a97d-38ddd32cd83mr6651606f8f.36.1739225401776;
        Mon, 10 Feb 2025 14:10:01 -0800 (PST)
Received: from giga-mm.. ([2a02:1210:861b:6f00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde1dfaesm13443450f8f.90.2025.02.10.14.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 14:10:01 -0800 (PST)
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
Subject: [PATCH v2 0/7] arm64 support for Milk-V Duo Module 01 EVB
Date: Mon, 10 Feb 2025 23:09:40 +0100
Message-ID: <20250210220951.1248533-1-alexander.sverdlin@gmail.com>
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
 arch/arm64/configs/defconfig                  |  5 +
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       | 64 ++++++++++---
 arch/riscv/boot/dts/sophgo/cv1812h.dtsi       | 64 ++++++++++---
 arch/riscv/boot/dts/sophgo/cv181x.dtsi        |  2 +-
 arch/riscv/boot/dts/sophgo/cv18xx-cpu.dtsi    | 57 ++++++++++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        | 91 +++++--------------
 arch/riscv/boot/dts/sophgo/sg2002.dtsi        | 64 ++++++++++---
 14 files changed, 451 insertions(+), 103 deletions(-)
 rename Documentation/devicetree/bindings/{riscv => soc/sophgo}/sophgo.yaml (80%)
 create mode 100644 arch/arm64/boot/dts/sophgo/Makefile
 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-module-01-evb.dts
 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-module-01.dtsi
 create mode 100644 arch/arm64/boot/dts/sophgo/sg2000.dtsi
 create mode 100644 arch/riscv/boot/dts/sophgo/cv18xx-cpu.dtsi

-- 
2.48.1


