Return-Path: <linux-pm+bounces-23062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B227DA47D98
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 13:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B84E188A9FC
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 12:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD8322B59F;
	Thu, 27 Feb 2025 12:25:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3B7225417;
	Thu, 27 Feb 2025 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659114; cv=none; b=jQVU1aA4rMtCF6KoFWRvm+WlMtOai3o8a+fOLa5iLfMk+XCIaZwm6X2IAn+sbZ58TH75KklUVZcqrg1jzZcVkKbWncfHlbPdTQ/1dEOuAvNEvv9PYspU99cB0kG+mCyxlVxAmeUGyANYDUzHM5ANJ2af6vITaQttbYfMsoNYtdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659114; c=relaxed/simple;
	bh=b3Eu3PVFgwBHfl2UMMUVPYQlp/YZioJOW4+lpM9Dmxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Voy+E8boGP1ekQha/2irPmxEs++5beNnXWi1WPEioUnKGVQY6zxxQIKQM12kVHAbGxyv7G8Fv5lphq5Uy6Xs9rkvp+8lyMUTQefLJFaVLeiHh2iYvZfqLiSHY3VRLLswgVloD5IEQYinDYZYYcMb8JiaLN4c1J/ny/3YdPn81Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: znxM1xLTR3mpvimHHn6aDw==
X-CSE-MsgGUID: ml/HIhIST4aCimY9fdisBQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 27 Feb 2025 21:25:03 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.68])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C581840029C3;
	Thu, 27 Feb 2025 21:24:56 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: john.madieu.xa@bp.renesas.com,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: john.madieu@gmail.com,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	biju.das.jz@bp.renesas.com
Subject: [PATCH v2 0/7] thermal: renesas: Add support fot RZ/G3E
Date: Thu, 27 Feb 2025 13:24:36 +0100
Message-ID: <20250227122453.30480-1-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series adds support for the temperature sensor unit (TSU) found on the
Renesas RZ/G3E SoC.

The series consists of 7 patches (some of which are not related to the thermal
framework) that progressively add TSU support as follows:
- patch 1/7:    adds syscon/regmap support for accessing system controller
                registers, enabling access to TSU calibration values
- patch 2/7:    adds clock and reset signals to the CPG driver

- patch 3/7:    adds dt-bindings
- patch 4/7:    adds the actual TSU driver for the RZ/G3E
- patch 5/6:    adds safety mechanism to make sure we we protect the chip in
                case of consecutive read failures
- patch 6-7/7:  add DT node and defconfig enablement


Changes:

v1 -> v2
 * Fix yaml warnings from dt-binding
 * Update IRQ names to reflect TSU expectations

Regards,

John Madieu (7):
  soc: renesas: rz-sysc: add syscon/regmap support
  clk: renesas: r9a09g047: Add clock and reset signals for the TSU IP
  dt-bindings: thermal: r9a09g047-tsu: Document the TSU unit
  thermal: renesas: rzg3e: Add thermal driver for the Renesas RZ/G3E SoC
  thermal: renesas: rzg3e: Add safety check when reading temperature
  arm64: dts: renesas: r9a09g047: Add TSU node
  arm64: defconfig: Enable RZ/G3E thermal

 .../thermal/renesas,r9a09g047-tsu.yaml        | 123 +++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  49 ++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/clk/renesas/r9a09g047-cpg.c           |   3 +
 drivers/soc/renesas/Kconfig                   |   1 +
 drivers/soc/renesas/r9a09g047-sys.c           |   1 +
 drivers/soc/renesas/rz-sysc.c                 |  30 +-
 drivers/soc/renesas/rz-sysc.h                 |   2 +
 drivers/thermal/renesas/Kconfig               |   7 +
 drivers/thermal/renesas/Makefile              |   1 +
 drivers/thermal/renesas/rzg3e_thermal.c       | 479 ++++++++++++++++++
 12 files changed, 703 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
 create mode 100644 drivers/thermal/renesas/rzg3e_thermal.c

-- 
2.25.1


