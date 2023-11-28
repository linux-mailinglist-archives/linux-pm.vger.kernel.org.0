Return-Path: <linux-pm+bounces-320-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA6F7FAF57
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 02:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD11AB210D9
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 01:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3265B110B;
	Tue, 28 Nov 2023 01:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B23D3135;
	Mon, 27 Nov 2023 17:00:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15428C15;
	Mon, 27 Nov 2023 17:01:27 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F15683F6C4;
	Mon, 27 Nov 2023 17:00:36 -0800 (PST)
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
Subject: [PATCH v3 1/6] soc: sunxi: sram: export register 0 for THS on H616
Date: Tue, 28 Nov 2023 00:58:44 +0000
Message-Id: <20231128005849.19044-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20231128005849.19044-1-andre.przywara@arm.com>
References: <20231128005849.19044-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner H616 SoC contains a mysterious bit at register offset 0x0
in the SRAM control block. If bit 16 is set (the reset value), the
temperature readings of the THS are way off, leading to reports about
200C, at normal ambient temperatures. Clearing this bits brings the
reported values down to reasonable ranges.
The BSP code clears this bit in firmware (U-Boot), and has an explicit
comment about this, but offers no real explanation.

Since we should not rely on firmware settings, allow other code (the THS
driver) to access this register, by exporting it through the already
existing syscon regmap. This mimics what we already do for the LDO
control and the EMAC register.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/soc/sunxi/sunxi_sram.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 4458b2e0562b0..24eba9ebf9f5a 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -287,6 +287,7 @@ EXPORT_SYMBOL(sunxi_sram_release);
 struct sunxi_sramc_variant {
 	int num_emac_clocks;
 	bool has_ldo_ctrl;
+	bool has_ths_offset;
 };
 
 static const struct sunxi_sramc_variant sun4i_a10_sramc_variant = {
@@ -308,8 +309,10 @@ static const struct sunxi_sramc_variant sun50i_a64_sramc_variant = {
 
 static const struct sunxi_sramc_variant sun50i_h616_sramc_variant = {
 	.num_emac_clocks = 2,
+	.has_ths_offset = true,
 };
 
+#define SUNXI_SRAM_THS_OFFSET_REG	0x0
 #define SUNXI_SRAM_EMAC_CLOCK_REG	0x30
 #define SUNXI_SYS_LDO_CTRL_REG		0x150
 
@@ -318,6 +321,8 @@ static bool sunxi_sram_regmap_accessible_reg(struct device *dev,
 {
 	const struct sunxi_sramc_variant *variant = dev_get_drvdata(dev);
 
+	if (reg == SUNXI_SRAM_THS_OFFSET_REG && variant->has_ths_offset)
+		return true;
 	if (reg >= SUNXI_SRAM_EMAC_CLOCK_REG &&
 	    reg <  SUNXI_SRAM_EMAC_CLOCK_REG + variant->num_emac_clocks * 4)
 		return true;
-- 
2.35.8


