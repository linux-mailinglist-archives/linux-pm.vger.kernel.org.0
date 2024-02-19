Return-Path: <linux-pm+bounces-4079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B82A885A783
	for <lists+linux-pm@lfdr.de>; Mon, 19 Feb 2024 16:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7538D28419B
	for <lists+linux-pm@lfdr.de>; Mon, 19 Feb 2024 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BED1383AB;
	Mon, 19 Feb 2024 15:36:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D70239840;
	Mon, 19 Feb 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357011; cv=none; b=VWpOOD3o48TriaTpSRWodopJGtwXBCKas1RIf+kC5uKp3ciyh19wAPBUG/YRvHhl2mL3giVz351KfyPS4rKQpJTTaX8sRBadUom39OMINnVj6XY6LajSOfhCl733KbmMoUEEFkbsmcbvVs4o8ad38dFzY95oR8grf+OsjZxPwME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357011; c=relaxed/simple;
	bh=FnjwIrCiUegrhGJ9QPXF/0eEn7GLU+V188gyihnPQWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uFZN3X840gUoVMaFu1jOJ3wykJDCLZJqthiIzBKd9MPMVcBSj1IRupByiI7v8rYSPavQAC799eoDp8xdEirq/s4EXLkqLEg/TsmK77OFHdolMuWmsa0szFJhi3cxEamFvY1o4DLoOB+o/kEUwXhqMcAfWUNeWpG+tNAu368Ey2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A031A1007;
	Mon, 19 Feb 2024 07:37:28 -0800 (PST)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C3A03F762;
	Mon, 19 Feb 2024 07:36:46 -0800 (PST)
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
Subject: [PATCH v5 1/7] soc: sunxi: sram: export register 0 for THS on H616
Date: Mon, 19 Feb 2024 15:36:33 +0000
Message-Id: <20240219153639.179814-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240219153639.179814-1-andre.przywara@arm.com>
References: <20240219153639.179814-1-andre.przywara@arm.com>
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
reported values down to the expected values.
The BSP code clears this bit in firmware (U-Boot), and has an explicit
comment about this, but offers no real explanation.

Experiments in U-Boot show that register 0x0 has no effect on the SRAM C
visibility: all tested bit settings still allow full read and write
access by the CPU to the whole of SRAM C. Only bit 24 of the register at
offset 0x4 makes all of SRAM C inaccessible by the CPU. So modelling
the THS switch functionality as an SRAM region would not reflect reality.

Since we should not rely on firmware settings, allow other code (the THS
driver) to access this register, by exporting it through the already
existing regmap. This mimics what we already do for the LDO control and
the EMAC register.

To avoid concurrent accesses to the same register at the same time, by
the SRAM switch code and the regmap code, use the same lock to protect
the access. The regmap subsystem allows to use an existing lock, so we
just need to hook in there.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/soc/sunxi/sunxi_sram.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 4458b2e0562b0..6eb6cf06278e6 100644
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
@@ -327,6 +332,20 @@ static bool sunxi_sram_regmap_accessible_reg(struct device *dev,
 	return false;
 }
 
+static void sunxi_sram_lock(void *_lock)
+{
+	spinlock_t *lock = _lock;
+
+	spin_lock(lock);
+}
+
+static void sunxi_sram_unlock(void *_lock)
+{
+	spinlock_t *lock = _lock;
+
+	spin_unlock(lock);
+}
+
 static struct regmap_config sunxi_sram_regmap_config = {
 	.reg_bits       = 32,
 	.val_bits       = 32,
@@ -336,6 +355,9 @@ static struct regmap_config sunxi_sram_regmap_config = {
 	/* other devices have no business accessing other registers */
 	.readable_reg	= sunxi_sram_regmap_accessible_reg,
 	.writeable_reg	= sunxi_sram_regmap_accessible_reg,
+	.lock		= sunxi_sram_lock,
+	.unlock		= sunxi_sram_unlock,
+	.lock_arg	= &sram_lock,
 };
 
 static int __init sunxi_sram_probe(struct platform_device *pdev)
-- 
2.25.1


