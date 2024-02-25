Return-Path: <linux-pm+bounces-4377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDDB862B6C
	for <lists+linux-pm@lfdr.de>; Sun, 25 Feb 2024 17:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52F91F21928
	for <lists+linux-pm@lfdr.de>; Sun, 25 Feb 2024 16:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C066175B6;
	Sun, 25 Feb 2024 16:07:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE07175B1;
	Sun, 25 Feb 2024 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708877279; cv=none; b=EpXhX3opREczX9wNTf22KG23MtuSdS2KhVg5LXnSnBxbKUjJid2WhS26kRMadFDpPpm3ydCFgKZ6ARNOfB1i2ftzspz6PQ/POHbxJGpDPkEOclrwpq3uinErVRB+0l5cqL1c8MnouMiLTzr3NWH9VncvMo4aAUZqmHAnbi4ydD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708877279; c=relaxed/simple;
	bh=W2CxVFArBSWuU/wZt+8ivEJxDw5MKX2fESn3uUFEG5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TpGkIymnBTl95N2DyGGlKH5/bWoCgOUDepxlMTcPGo5tGkcx7B4DflWb+cWg1X8PAI880M0CQrEJeT2eT0Lp9AQawzc5H1gs7f1pa+LER2vQCSuuvrIqpwu4njd3QbVPMmIrOxydTlAJCdi54k4EEcdEt/S1UGDAdrclsJ43Jo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F41E1063;
	Sun, 25 Feb 2024 08:08:29 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F25C53F73F;
	Sun, 25 Feb 2024 08:07:48 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Samuel Holland <samuel@sholland.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [RFC PATCH 1/1] clk: sunxi-ng: h6-r: add GPU power domain
Date: Sun, 25 Feb 2024 16:06:16 +0000
Message-Id: <20240225160616.15001-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240225160616.15001-1-andre.przywara@arm.com>
References: <20240225160616.15001-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner H616 features register 0x7010254 in the PRCM MMIO frame,
where bit 0 needs to be cleared to enable operation of the Mali GPU.
With this bit set (the reset default), any access to the Mali registers
hangs the bus and thus the whole system. The BSP code clears this bit
in U-Boot and their kernel never touches it again.

Register a power-domain device to control this bit. Since we claim this
MMIO region in the H6 R-CCU driver, add the code here, so that we don't
need to artificially split the MMIO range in the DT.
Since there seems to be at least one other register with similar behaviour
nearby (0x7010260), make the power domain take one cell, even though we
only support domain #0 for now.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c | 84 ++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
index 02b28cfc5525e..363fb7a71e9f5 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
@@ -4,9 +4,11 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 
 #include "ccu_common.h"
 #include "ccu_reset.h"
@@ -217,6 +219,86 @@ static const struct sunxi_ccu_desc sun50i_h616_r_ccu_desc = {
 	.num_resets	= ARRAY_SIZE(sun50i_h616_r_ccu_resets),
 };
 
+#define	PD_H616_GPU_REG			0x254
+
+struct sun50i_h616_ppu_pd {
+	struct generic_pm_domain	genpd;
+	void __iomem			*base;
+};
+
+#define to_sun50i_h616_ppu_pd(_genpd) \
+	container_of(_genpd, struct sun50i_h616_ppu_pd, genpd)
+
+static bool sun50i_h616_ppu_power_status(const struct sun50i_h616_ppu_pd *pd)
+{
+	return !readl(pd->base + PD_H616_GPU_REG);
+}
+
+static int sun50i_h616_ppu_pd_set_power(const struct sun50i_h616_ppu_pd *pd,
+					bool power_on)
+{
+	if (power_on)
+		writel(0, pd->base + PD_H616_GPU_REG);
+	else
+		writel(1, pd->base + PD_H616_GPU_REG);
+
+	return 0;
+}
+
+static int sun50i_h616_ppu_pd_power_on(struct generic_pm_domain *genpd)
+{
+	const struct sun50i_h616_ppu_pd *pd = to_sun50i_h616_ppu_pd(genpd);
+
+	return sun50i_h616_ppu_pd_set_power(pd, true);
+}
+
+static int sun50i_h616_ppu_pd_power_off(struct generic_pm_domain *genpd)
+{
+	const struct sun50i_h616_ppu_pd *pd = to_sun50i_h616_ppu_pd(genpd);
+
+	return sun50i_h616_ppu_pd_set_power(pd, false);
+}
+
+static int sun50i_h616_register_ppu(struct platform_device *pdev,
+				    void __iomem *base)
+{
+	struct device *dev = &pdev->dev;
+	struct genpd_onecell_data *ppu;
+	struct sun50i_h616_ppu_pd *pd;
+	int ret;
+
+	pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return -ENOMEM;
+
+	ppu = devm_kzalloc(dev, sizeof(*ppu), GFP_KERNEL);
+	if (!ppu)
+		return -ENOMEM;
+
+	ppu->domains = devm_kzalloc(dev, sizeof(*ppu->domains), GFP_KERNEL);
+	if (!ppu->domains)
+		return -ENOMEM;
+
+	ppu->num_domains = 1;
+	pd->genpd.name		= "GPU";
+	pd->genpd.power_off	= sun50i_h616_ppu_pd_power_off;
+	pd->genpd.power_on	= sun50i_h616_ppu_pd_power_on;
+	pd->base		= base;
+
+	ret = pm_genpd_init(&pd->genpd, NULL, !sun50i_h616_ppu_power_status(pd));
+	if (ret) {
+		dev_warn(dev, "Failed to add GPU power domain: %d\n", ret);
+		return ret;
+	}
+
+	ppu->domains[0] = &pd->genpd;
+	ret = of_genpd_add_provider_onecell(dev->of_node, ppu);
+	if (ret)
+		dev_warn(dev, "Failed to add provider: %d\n", ret);
+
+	return 0;
+}
+
 static int sun50i_h6_r_ccu_probe(struct platform_device *pdev)
 {
 	const struct sunxi_ccu_desc *desc;
@@ -230,6 +312,8 @@ static int sun50i_h6_r_ccu_probe(struct platform_device *pdev)
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
 
+	sun50i_h616_register_ppu(pdev, reg);
+
 	return devm_sunxi_ccu_probe(&pdev->dev, reg, desc);
 }
 
-- 
2.35.8


