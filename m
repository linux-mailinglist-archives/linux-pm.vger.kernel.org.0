Return-Path: <linux-pm+bounces-3701-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D6884F7C8
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 15:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA4F283C35
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 14:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C9B69DFD;
	Fri,  9 Feb 2024 14:42:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DF03F9FD;
	Fri,  9 Feb 2024 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489754; cv=none; b=qE3CiP+gPU2ekYiP5PFQUcorbH2Af3FitHaE4ws3vCsAlP+xy062gkYY5enNsxz9PR8scvv/uw6nzev02GqP04DCwwUpTLuwd7LpcVqnjIanOsQ/Ivt1e7dyHaN42qGYQT7ORvn8G+Vs4hUrhlzg5jHu2CiFqqGzrpDUUN+2FZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489754; c=relaxed/simple;
	bh=JvnpiJSGUfd6e6IolgHdvQBQYhN0pvSEGQFh32BpkGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i42sFhT21kPNGFF7TBCV4ho1bkME8Xdu+CgZE6P02SF6f8w0IzlqsYGM4meuYEIquUobbuDH7JKSmnDfqdEvirlsAQUYYWyWhnu1hmUD7/B7xHsOKapDSnsp8CvAR7WaZTN0/YawXZtxX6UL+/sV/9fUCiDJjxSFrK99zDqNNL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BA47FEC;
	Fri,  9 Feb 2024 06:43:12 -0800 (PST)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 029FA3F5A1;
	Fri,  9 Feb 2024 06:42:27 -0800 (PST)
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
Subject: [PATCH v4 1/7] soc: sunxi: sram: export register 0 for THS on H616
Date: Fri,  9 Feb 2024 14:42:15 +0000
Message-Id: <20240209144221.3602382-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240209144221.3602382-1-andre.przywara@arm.com>
References: <20240209144221.3602382-1-andre.przywara@arm.com>
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
existing regmap. This mimics what we already do for the LDO control and
the EMAC register.

Since this bit is in the very same register as the actual SRAM switch,
we need to change the regmap lock to the SRAM lock. Fortunately regmap
has provisions for that, so we just need to hook in there.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/soc/sunxi/sunxi_sram.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 4458b2e0562b0..71cdd1b257eeb 100644
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
@@ -327,6 +332,21 @@ static bool sunxi_sram_regmap_accessible_reg(struct device *dev,
 	return false;
 }
 
+
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
@@ -336,6 +356,9 @@ static struct regmap_config sunxi_sram_regmap_config = {
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


