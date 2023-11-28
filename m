Return-Path: <linux-pm+bounces-319-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9877FAF54
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 02:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AEEC2816DB
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 01:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F06415AF;
	Tue, 28 Nov 2023 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DBFBC2;
	Mon, 27 Nov 2023 17:00:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6774E2F4;
	Mon, 27 Nov 2023 17:01:24 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BA9A3F6C4;
	Mon, 27 Nov 2023 17:00:34 -0800 (PST)
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
	Bob McChesney <bob@electricworry.net>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v3 0/6] Add support for H616 Thermal system
Date: Tue, 28 Nov 2023 00:58:43 +0000
Message-Id: <20231128005849.19044-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this is v3 of the series by Martin, now complemented by patches to fix
the problem with way-too-high temperatures reported on some boards. This
seems to be related to the firmware being run, because the vendor U-Boot
contains a hack avoiding this problem. Some investigation and digging
in BSP code later we identified that bit 16 in register 0x3000000
(SYS_CFG) needs to be cleared for the raw temperature register values to
contain reasonable values.
To achieve this, patch 1/6 exports this very register from the already
existing syscon device. Patch 4/6 then adds code to the thermal driver
to find the syscon device via a new DT property, and query its regmap to
clear bit 16 in there.

I am not fully convinced this is the best solution, but it works for me.
What leaves a bit of a bitter taste is that the SRAM driver (the one
exporting the regmap) also uses this register, to switch some SRAM C
region to the video engine (VE). Experiments show that only bit 0 in
this register is doing this job, so the current mask covering the 31
LSBs should probably be amended to only cover bit 0.
Another solution could be to model this bit as an SRAM switch, and let
the THS driver claim some (dummy?) SRAM region from the syscon/SRAM driver
directly. While this sounds cleaner to some degree, I don't think there
is really such a THS SRAM region, so it's not fully correct either.

I would appreciate any feedback on this, happy to implement the other
approach, if that's desired.

The rest of the patches is mostly unchanged from Martin's v2, just
updated and massaged the commit messages a bit. I also added patch 3/6
to document some so-far unknown register value.

Please have a look!

Cheers,
Andre

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
  thermal: sun8i: add syscon register access code

Martin Botka (3):
  dt-bindings: thermal: sun8i: Add H616 THS controller
  thermal: sun8i: add support for H616 THS controller
  arm64: dts: allwinner: h616: Add thermal sensor and zones

 .../thermal/allwinner,sun8i-a83t-ths.yaml     |  30 ++--
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |  88 ++++++++++
 drivers/soc/sunxi/sunxi_sram.c                |   5 +
 drivers/thermal/sun8i_thermal.c               | 152 ++++++++++++++++--
 4 files changed, 252 insertions(+), 23 deletions(-)

-- 
2.35.8


