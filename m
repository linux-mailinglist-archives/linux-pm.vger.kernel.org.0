Return-Path: <linux-pm+bounces-4078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134D485A781
	for <lists+linux-pm@lfdr.de>; Mon, 19 Feb 2024 16:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E54280E8E
	for <lists+linux-pm@lfdr.de>; Mon, 19 Feb 2024 15:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84719383B0;
	Mon, 19 Feb 2024 15:36:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1638383A6;
	Mon, 19 Feb 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357008; cv=none; b=pDQpMT+MM/+AizdwziF8PQ10fJ9NSs7FhlKW2tumUI2BQKUlxd6XpqI2o3QhzxO5xyV5/C0z3B1q9XNq0pFhiQaURetei4ODRwAJKTNX/9CgN3zK6H6K40y5mfzF5jaa6UBYBg3VXaKfEFvVFG5TCxpRTyHjksGr0x69c+RyGBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357008; c=relaxed/simple;
	bh=36ZB6XOdVqWqVxQWay9hrTgUtWcTbyTL0Qc/nb4FMfE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sAhQ66GWATBIS+I187ncdicgGUJfeTvTWMFUDPCKsqHZjCe7yEqgM0vF4BNUrpmB7of5CQuUD5xQjiGxM+5490vDGrURknP4rs5ioshYRS9MlNj9QYGfNnEjoow+m0ap8g99EHblEV4Zi8dKmeznZxqRIx23WhXvOjqtD7MDieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4E4EFEC;
	Mon, 19 Feb 2024 07:37:25 -0800 (PST)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE9793F762;
	Mon, 19 Feb 2024 07:36:43 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Botka <martin.botka@somainline.org>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Bob McChesney <bob@electricworry.net>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v5 0/7] add support for H616 thermal system
Date: Mon, 19 Feb 2024 15:36:32 +0000
Message-Id: <20240219153639.179814-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this is v5 of this series originally by Martin, only some cosmetic
changes this time, for instance  mentioning experiments with the SRAM
controller registers to confirm that it's not an SRAM region which fixes
the temperature reporting issue.
See the Changelog below for more details.
==================

This series introduces support for the thermal sensors in the Allwinner
H616 SoCs, which includes its siblings H618 and T507. The actual
temperature reading turns out to be very similar to the H6 SoC, just
with support for two more sensors. One nasty complication is caused
by reports about temperatures above 200C, which are related to the
firmware being run (because the vendor U-Boot contains a hack avoiding
this problem). Some investigation and digging in BSP code later
we identified that bit 16 in register 0x3000000 (SYS_CFG) needs to be
cleared for the raw temperature register values to contain reasonable
values.
To achieve this, patch 1/7 exports this very register from the already
existing SRAM/syscon device. Patch 5/7 then adds code to the thermal
driver to find that device via a new DT property, and query its regmap
to clear bit 16 in there.
Patch 4/7 reworks the existing H6 calibration function to become
compatible with the H616, many thanks to Maksim for figuring this out.
This makes the actual enablement patch 6/7 very easy.

The rest of the patches are straightforward and build on Martin's
original work, with some simplifications, resulting in more code sharing.

Please have a look!

Cheers,
Andre

Changelog v4 .. v5:
- add tags
- extend commit message of SRAM controller patch (1/7)
- remove extra empty line (1/7)
- use global static constant for SRAM regmap field (5/7)

Changelog v3 .. v4:
- rebase on top of v6.8-rc2
- rework SYS_CFG bit poking patches to avoid syscon
- use sram lock for the SRAM driver regmap as well
- correctly advertise new allwinner,sram property in binding
- fix conditional definition of sram property
- new patch 4/7 to make the H6 and H616 calibrate functions compatible
- drop now obsolete definition of sun50i_h616_ths_calibrate()

Changelog v2 .. v3:
- rebase on top of v6.7-rc3
- add patches to clear bit 16 in SYS_CFG register 0x3000000
- add syscon to the binding documentation
- add patch explaining the unknown control register value

Changelog v1 .. v2:
- Fix typos
- Remove h616 calc and init functions
- Use TEMP_CALIB_MASK insteaf of 0xffff
- Adjust calibration function to new offset and scale
- Add proper comment to bindings patch
- Split delta calculations to 2 lines
- Add parentheses around caldata[2|3] >> 12
- Negate bindings if for clocks


Andre Przywara (3):
  soc: sunxi: sram: export register 0 for THS on H616
  thermal: sun8i: explain unknown H6 register value
  thermal: sun8i: add SRAM register access code

Maksim Kiselev (1):
  thermal: sun8i: extend H6 calibration to support 4 sensors

Martin Botka (3):
  dt-bindings: thermal: sun8i: Add H616 THS controller
  thermal: sun8i: add support for H616 THS controller
  arm64: dts: allwinner: h616: Add thermal sensor and zones

 .../thermal/allwinner,sun8i-a83t-ths.yaml     |  34 +++--
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |  88 +++++++++++++
 drivers/soc/sunxi/sunxi_sram.c                |  22 ++++
 drivers/thermal/sun8i_thermal.c               | 123 +++++++++++++++---
 4 files changed, 235 insertions(+), 32 deletions(-)

-- 
2.25.1


