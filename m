Return-Path: <linux-pm+bounces-30715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D595B029AC
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 09:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86CD21C221E1
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 07:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267A0221281;
	Sat, 12 Jul 2025 07:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpaDtZfL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96732F5B;
	Sat, 12 Jul 2025 07:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752306046; cv=none; b=Gf4i3Vb8VfWXMKHUlJjY1IKH/oJa6m6OPasjUmQXu+8P+rFYDK2H7lXxpJl0uQDhQNYVPApJONSHDpqIR7u3D5Iu42lAH9+wSxA/lToJTvPWun2vMJF792z/mikxE3JC0xij2DBt+KTYM7HkezjGkEwbv8WQN4wX+b39+sxfBaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752306046; c=relaxed/simple;
	bh=RYWUgGRqFS9sarDXCDokhJZmRsKnFc7OwpkggH1fV9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OJT/j8xv4ausze9xZk4ctJGwvv7EHVgWdr14HA+bGBjZl/yKDFKz6jBIx2RWrh9OxlLXneh3ebQNTt3LyxmbXHb9sLMfeUp+fditUsPmoLky9w1YC1b6M8bisuHakQvhgSpNcxNngrul+WtYNwqcaskjlvjZfVwRml2y2uI0Qiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpaDtZfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73536C4CEF7;
	Sat, 12 Jul 2025 07:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752306045;
	bh=RYWUgGRqFS9sarDXCDokhJZmRsKnFc7OwpkggH1fV9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZpaDtZfLINLW9U8IzoDoZA8E1Xo2njN0jZgTNbUrUqxQJ/AUnOQlCk3znzu80txi6
	 LzjdUrEFumG2/k7TgVF4PlVeZef8YlZJ/DkS93VYOO1Z2jhxLmYwPtPqw0vBumQ4dp
	 AIOZZUp5OslCTDXdYA0dFudoZSUgglaslLEFburRLMsoBurjUiLe06RS3Cp/nTVBjj
	 OzGpGKoHhNZbj0aPTKV1mDZNrBU15r98KJG7ZoeeRkl+dxHLiQpqwMxd5ePTxDeiPk
	 SFRkpe1N2lFdDzO1HoWSsTg3m0QkUa8ppFCZNn2lqMQJKZRHqFWd9ttiynhpt6eWw8
	 aEdsUogQvi+zQ==
Received: by wens.tw (Postfix, from userid 1000)
	id BFCBA5FE81; Sat, 12 Jul 2025 15:40:42 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 3/5] pmdomain: sunxi: add driver for Allwinner A523's PCK-600 power controller
Date: Sat, 12 Jul 2025 15:40:19 +0800
Message-Id: <20250712074021.805953-4-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250712074021.805953-1-wens@kernel.org>
References: <20250712074021.805953-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

Allwinner A523 family has a second power controller, named PCK-600 in
the datasheets and BSP. It is likely based on ARM's PCK-600 hardware
block, with some additional delay controls. The only documentation for
this hardware is the BSP driver. The standard registers defined in ARM's
Power Policy Unit Architecture Specification line up. Some extra delay
controls are found in the reserved range of registers.

Add a driver for this power controller. Delay control register values
and power domain names are from the BSP driver.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v2:
- Fixed whitespace issue
- Added explanation about possible PCK-600 lineage and document
  references to driver
- Changed Kconfig option to tristate
- Rewrote Kconfig option help text to make it clear that the driver
  is required for certain peripherals to work
- Made it depend on ARCH_SUNXI or COMPILE_TEST
- Made it enabled by default for ARCH_SUNXI
- Renamed PPU_PWSR_PWR_STATUS to PPU_PWR_STATUS, and added a comment
  to note the macro is shared between two registers
---
 drivers/pmdomain/sunxi/Kconfig         |  11 ++
 drivers/pmdomain/sunxi/Makefile        |   1 +
 drivers/pmdomain/sunxi/sun55i-pck600.c | 234 +++++++++++++++++++++++++
 3 files changed, 246 insertions(+)
 create mode 100644 drivers/pmdomain/sunxi/sun55i-pck600.c

diff --git a/drivers/pmdomain/sunxi/Kconfig b/drivers/pmdomain/sunxi/Kconfig
index 43eecb3ea981..eb1ce2dd8e53 100644
--- a/drivers/pmdomain/sunxi/Kconfig
+++ b/drivers/pmdomain/sunxi/Kconfig
@@ -18,3 +18,14 @@ config SUN50I_H6_PRCM_PPU
 	  Say y to enable the Allwinner H6/H616 PRCM power domain driver.
 	  This is required to enable the Mali GPU in the H616 SoC, it is
 	  optional for the H6.
+
+config SUN55I_PCK600
+	tristate "Allwinner A523 PCK-600 power domain driver"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on PM
+	default ARCH_SUNXI
+	select PM_GENERIC_DOMAINS
+	help
+	  Say y to enable the PCK-600 power domain driver. This is required
+	  to enable power to certain peripherals, such as the display and
+	  video engines.
diff --git a/drivers/pmdomain/sunxi/Makefile b/drivers/pmdomain/sunxi/Makefile
index c1343e123759..e344b232fc9f 100644
--- a/drivers/pmdomain/sunxi/Makefile
+++ b/drivers/pmdomain/sunxi/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_SUN20I_PPU)		+= sun20i-ppu.o
 obj-$(CONFIG_SUN50I_H6_PRCM_PPU)	+= sun50i-h6-prcm-ppu.o
+obj-$(CONFIG_SUN55I_PCK600)		+= sun55i-pck600.o
diff --git a/drivers/pmdomain/sunxi/sun55i-pck600.c b/drivers/pmdomain/sunxi/sun55i-pck600.c
new file mode 100644
index 000000000000..c7ab51514531
--- /dev/null
+++ b/drivers/pmdomain/sunxi/sun55i-pck600.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Allwinner PCK-600 power domain support
+ *
+ * Copyright (c) 2025 Chen-Yu Tsai <wens@csie.org>
+ *
+ * The hardware is likely based on the Arm PCK-600 IP, since some of
+ * the registers match Arm's documents, with additional delay controls
+ * that are in registers listed as reserved.
+ *
+ * Documents include:
+ * - "Arm CoreLink PCK-600 Power Control Kit" TRM
+ * - "Arm Power Policy Unit" architecture specification (DEN0051E)
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/container_of.h>
+#include <linux/device.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/string_choices.h>
+
+#define PPU_PWPR    0x0
+#define PPU_PWSR    0x8
+#define PPU_DCDR0   0x170
+#define PPU_DCDR1   0x174
+
+/* shared definition for PPU_PWPR and PPU_PWSR */
+#define PPU_PWR_STATUS	GENMASK(3, 0)
+#define PPU_POWER_MODE_ON	0x8
+#define PPU_POWER_MODE_OFF	0x0
+
+#define PPU_REG_SIZE	0x1000
+
+struct sunxi_pck600_desc {
+	const char * const *pd_names;
+	unsigned int num_domains;
+	u32 logic_power_switch0_delay_offset;
+	u32 logic_power_switch1_delay_offset;
+	u32 off2on_delay_offset;
+	u32 device_ctrl0_delay;
+	u32 device_ctrl1_delay;
+	u32 logic_power_switch0_delay;
+	u32 logic_power_switch1_delay;
+	u32 off2on_delay;
+};
+
+struct sunxi_pck600_pd {
+	struct generic_pm_domain genpd;
+	struct sunxi_pck600 *pck;
+	void __iomem *base;
+};
+
+struct sunxi_pck600 {
+	struct device *dev;
+	struct genpd_onecell_data genpd_data;
+	struct sunxi_pck600_pd pds[];
+};
+
+#define to_sunxi_pd(gpd) container_of(gpd, struct sunxi_pck600_pd, genpd)
+
+static int sunxi_pck600_pd_set_power(struct sunxi_pck600_pd *pd, bool on)
+{
+	struct sunxi_pck600 *pck = pd->pck;
+	struct generic_pm_domain *genpd = &pd->genpd;
+	int ret;
+	u32 val, reg;
+
+	val = on ? PPU_POWER_MODE_ON : PPU_POWER_MODE_OFF;
+
+	reg = readl(pd->base + PPU_PWPR);
+	FIELD_MODIFY(PPU_PWR_STATUS, &reg, val);
+	writel(reg, pd->base + PPU_PWPR);
+
+	/* push write out to hardware */
+	reg = readl(pd->base + PPU_PWPR);
+
+	ret = readl_poll_timeout_atomic(pd->base + PPU_PWSR, reg,
+					FIELD_GET(PPU_PWR_STATUS, reg) == val,
+					0, 10000);
+	if (ret)
+		dev_err(pck->dev, "failed to turn domain \"%s\" %s: %d\n",
+			genpd->name, str_on_off(on), ret);
+
+	return ret;
+}
+
+static int sunxi_pck600_power_on(struct generic_pm_domain *domain)
+{
+	struct sunxi_pck600_pd *pd = to_sunxi_pd(domain);
+
+	return sunxi_pck600_pd_set_power(pd, true);
+}
+
+static int sunxi_pck600_power_off(struct generic_pm_domain *domain)
+{
+	struct sunxi_pck600_pd *pd = to_sunxi_pd(domain);
+
+	return sunxi_pck600_pd_set_power(pd, false);
+}
+
+static void sunxi_pck600_pd_setup(struct sunxi_pck600_pd *pd,
+				  const struct sunxi_pck600_desc *desc)
+{
+	writel(desc->device_ctrl0_delay, pd->base + PPU_DCDR0);
+	writel(desc->device_ctrl1_delay, pd->base + PPU_DCDR1);
+	writel(desc->logic_power_switch0_delay,
+	       pd->base + desc->logic_power_switch0_delay_offset);
+	writel(desc->logic_power_switch1_delay,
+	       pd->base + desc->logic_power_switch1_delay_offset);
+	writel(desc->off2on_delay, pd->base + desc->off2on_delay_offset);
+}
+
+static int sunxi_pck600_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct sunxi_pck600_desc *desc;
+	struct genpd_onecell_data *genpds;
+	struct sunxi_pck600 *pck;
+	struct reset_control *rst;
+	struct clk *clk;
+	void __iomem *base;
+	int i, ret;
+
+	desc = of_device_get_match_data(dev);
+
+	pck = devm_kzalloc(dev, struct_size(pck, pds, desc->num_domains), GFP_KERNEL);
+	if (!pck)
+		return -ENOMEM;
+
+	pck->dev = &pdev->dev;
+	platform_set_drvdata(pdev, pck);
+
+	genpds = &pck->genpd_data;
+	genpds->num_domains = desc->num_domains;
+	genpds->domains = devm_kcalloc(dev, desc->num_domains,
+				       sizeof(*genpds->domains), GFP_KERNEL);
+	if (!genpds->domains)
+		return -ENOMEM;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	rst = devm_reset_control_get_exclusive_released(dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(dev, PTR_ERR(rst), "failed to get reset control\n");
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
+
+	for (i = 0; i < desc->num_domains; i++) {
+		struct sunxi_pck600_pd *pd = &pck->pds[i];
+
+		pd->genpd.name = desc->pd_names[i];
+		pd->genpd.power_off = sunxi_pck600_power_off;
+		pd->genpd.power_on = sunxi_pck600_power_on;
+		pd->base = base + PPU_REG_SIZE * i;
+
+		sunxi_pck600_pd_setup(pd, desc);
+		ret = pm_genpd_init(&pd->genpd, NULL, false);
+		if (ret) {
+			dev_err_probe(dev, ret, "failed to initialize power domain\n");
+			goto err_remove_pds;
+		}
+
+		genpds->domains[i] = &pd->genpd;
+	}
+
+	ret = of_genpd_add_provider_onecell(dev_of_node(dev), genpds);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to add PD provider\n");
+		goto err_remove_pds;
+	}
+
+	return 0;
+
+err_remove_pds:
+	for (i--; i >= 0; i--)
+		pm_genpd_remove(genpds->domains[i]);
+
+	return ret;
+}
+
+static const char * const sun55i_a523_pck600_pd_names[] = {
+	"VE", "GPU", "VI", "VO0", "VO1", "DE", "NAND", "PCIE"
+};
+
+static const struct sunxi_pck600_desc sun55i_a523_pck600_desc = {
+	.pd_names = sun55i_a523_pck600_pd_names,
+	.num_domains = ARRAY_SIZE(sun55i_a523_pck600_pd_names),
+	.logic_power_switch0_delay_offset = 0xc00,
+	.logic_power_switch1_delay_offset = 0xc04,
+	.off2on_delay_offset = 0xc10,
+	.device_ctrl0_delay = 0xffffff,
+	.device_ctrl1_delay = 0xffff,
+	.logic_power_switch0_delay = 0x8080808,
+	.logic_power_switch1_delay = 0x808,
+	.off2on_delay = 0x8
+};
+
+static const struct of_device_id sunxi_pck600_of_match[] = {
+	{
+		.compatible	= "allwinner,sun55i-a523-pck-600",
+		.data		= &sun55i_a523_pck600_desc,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, sunxi_pck600_of_match);
+
+static struct platform_driver sunxi_pck600_driver = {
+	.probe = sunxi_pck600_probe,
+	.driver = {
+		.name   = "sunxi-pck-600",
+		.of_match_table = sunxi_pck600_of_match,
+		/* Power domains cannot be removed if in use. */
+		.suppress_bind_attrs = true,
+	},
+};
+module_platform_driver(sunxi_pck600_driver);
+
+MODULE_DESCRIPTION("Allwinner PCK-600 power domain driver");
+MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
+MODULE_LICENSE("GPL");
-- 
2.39.5


