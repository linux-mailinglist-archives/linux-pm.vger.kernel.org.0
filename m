Return-Path: <linux-pm+bounces-3700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 030A884F7C4
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 15:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1DE2838E8
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212A16995B;
	Fri,  9 Feb 2024 14:42:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8477569966;
	Fri,  9 Feb 2024 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489752; cv=none; b=Vjlsi82cqX8Fj3FeJ0eqV17CuO4Xqt5yNvxffODpTB6/ysWAmdDg18HR8QvmhWhTL/5ebMAagVjV/dnmznt6hZ2ga4XFfZ8ozaFdCsP7AznwabzjwVloz2ZyDM1mmjwmxfOjhylBwGpQCbgrx8UBIa14CqHmmS2gUD3ZnRTu7Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489752; c=relaxed/simple;
	bh=OPRoRlQxMhEfWWGZv0FtyKC6agKr3mXCNBTqzLQCnlA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zj147RNjVzQzPaLjQRxurjwzDMmQHMd1c7OeNAUYX8azEFiEIBxtd6xlQFQlDCDgmlhsZng8Lr8trOt0aPCCdEoQUEdgt6NIa7JQTlZaPToW7lD85D0uHLxg58deevaI3PjxWgnBjRiqRd4Z2chnnR4d6w9pY2dCsYWt12iBaGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBFC2DA7;
	Fri,  9 Feb 2024 06:43:09 -0800 (PST)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40C793F5A1;
	Fri,  9 Feb 2024 06:42:25 -0800 (PST)
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
Subject: [PATCH v4 0/7] add support for H616 thermal system
Date: Fri,  9 Feb 2024 14:42:14 +0000
Message-Id: <20240209144221.3602382-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this is v4 of the series originally by Martin, complemented by patches
to fix the problem with way-too-high temperatures reported on
some boards, and some refactoring and simplifications, compared to the
original drop.

For the SYS_CFG bit poke code I now avoided the term "syscon" at all,
instead using "sram" instead, which seems to be less controversial. Apart
from that the register poke part hasn't changed much, but I hope it's more
acceptable now that it doesn't claim to be using a syscon device.

Many thanks to Maksim's investigation into the code, which revealed that
the calibrate functions between the H6 and H616 are actually the same,
just with support for more sensors. So his new patch 4/7 refactors the
existing function, to make it compatible to the H616, which makes the
actual support patch 6/7 very simple.

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

I am open to suggestions on how to solve this in a better way, but the
current solution works, and uses an existing driver and an existing
scheme (in the EMAC driver).

The rest of the patches are fairly straight-forward and build on
Martin's original work, with some simplifications, resulting in more
code sharing.

Please have a look!

Cheers,
Andre

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
 drivers/soc/sunxi/sunxi_sram.c                |  23 ++++
 drivers/thermal/sun8i_thermal.c               | 122 +++++++++++++++---
 4 files changed, 235 insertions(+), 32 deletions(-)

-- 
2.25.1


