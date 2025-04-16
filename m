Return-Path: <linux-pm+bounces-25583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CE4A90EE6
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 00:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8AC17356D
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 22:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED402459DA;
	Wed, 16 Apr 2025 22:49:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65E32459C8;
	Wed, 16 Apr 2025 22:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744843781; cv=none; b=taKIbTZD9l/bddHtFn0dV+AzDdDICzvwqI3IC6Boxd7fRLwijBjQrvBVswfsHj9d+PG0GNyarjnY8oW1gwMIJjgd9RbrX+648UuLdouZIk4w2vW9UFfeECdOMdMWEkzmPEe6wG3IZSmKG6ZsDW1MaG9zX76VLq+lYOZ1gQ0+7nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744843781; c=relaxed/simple;
	bh=7weWLXk7c6y0ME4BXpMOEVQwbrfxw3i+g+HB2RW2+lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHXVQsTN4J+Cszp+Hr/weYnxoXJtIwA4GrqBCCG6YslntHhsJlSqBKqcbmr5F4Kibl8uvAqQqTd1hg2LEc+vp4DwoTsxVoA9YyhWOLqIA/JtMlWKl3wAEqHuBeq2qav0BlIRGRf5m5WzEWR37PrkqDrRTfyYX5fjKiW2EXkKWHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33E951515;
	Wed, 16 Apr 2025 15:49:37 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98D173F66E;
	Wed, 16 Apr 2025 15:49:37 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Philippe Simons <simons.philippe@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 2/4] pmdomain: sunxi: add H6 PRCM PPU driver
Date: Wed, 16 Apr 2025 23:48:37 +0100
Message-ID: <20250416224839.9840-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250416224839.9840-1-andre.przywara@arm.com>
References: <20250416224839.9840-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Allwinner Power Reset Clock Management (RPCM) block contains a few
bits that control some power domains. The most prominent one is the one
for the Mali GPU. On the Allwinner H6 this domain is enabled at reset, so
we didn't care about it so far, but the H616 defaults to it being disabled.

Add a power domain driver for those bits. Some BSP code snippets and
some spare documentation describe three bits, slightly different between
the H6 and H616, so add three power domains for each SoC, connected to
their compatible string.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/pmdomain/sunxi/Kconfig              |  10 +
 drivers/pmdomain/sunxi/Makefile             |   1 +
 drivers/pmdomain/sunxi/sun50i-h6-prcm-ppu.c | 208 ++++++++++++++++++++
 3 files changed, 219 insertions(+)
 create mode 100644 drivers/pmdomain/sunxi/sun50i-h6-prcm-ppu.c

diff --git a/drivers/pmdomain/sunxi/Kconfig b/drivers/pmdomain/sunxi/Kconfig
index 17781bf8d86d7..43eecb3ea9819 100644
--- a/drivers/pmdomain/sunxi/Kconfig
+++ b/drivers/pmdomain/sunxi/Kconfig
@@ -8,3 +8,13 @@ config SUN20I_PPU
 	help
 	  Say y to enable the PPU power domain driver. This saves power
 	  when certain peripherals, such as the video engine, are idle.
+
+config SUN50I_H6_PRCM_PPU
+	tristate "Allwinner H6 PRCM power domain driver"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on PM
+	select PM_GENERIC_DOMAINS
+	help
+	  Say y to enable the Allwinner H6/H616 PRCM power domain driver.
+	  This is required to enable the Mali GPU in the H616 SoC, it is
+	  optional for the H6.
diff --git a/drivers/pmdomain/sunxi/Makefile b/drivers/pmdomain/sunxi/Makefile
index ec1d7a2fb21db..c1343e1237599 100644
--- a/drivers/pmdomain/sunxi/Makefile
+++ b/drivers/pmdomain/sunxi/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_SUN20I_PPU)		+= sun20i-ppu.o
+obj-$(CONFIG_SUN50I_H6_PRCM_PPU)	+= sun50i-h6-prcm-ppu.o
diff --git a/drivers/pmdomain/sunxi/sun50i-h6-prcm-ppu.c b/drivers/pmdomain/sunxi/sun50i-h6-prcm-ppu.c
new file mode 100644
index 0000000000000..d59644499dfe0
--- /dev/null
+++ b/drivers/pmdomain/sunxi/sun50i-h6-prcm-ppu.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) Arm Ltd. 2024
+ *
+ * Allwinner H6/H616 PRCM power domain driver.
+ * This covers a few registers inside the PRCM (Power Reset Clock Management)
+ * block that control some power rails, most prominently for the Mali GPU.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/reset.h>
+
+/*
+ * The PRCM block covers multiple devices, starting with some clocks,
+ * then followed by the power rails.
+ * The clocks are covered by a different driver, so this driver's MMIO range
+ * starts later in the PRCM MMIO frame, not at the beginning of it.
+ * To keep the register offsets consistent with other PRCM documentation,
+ * express the registers relative to the beginning of the whole PRCM, and
+ * subtract the PPU offset this driver is bound to.
+ */
+#define PD_H6_PPU_OFFSET		0x250
+#define PD_H6_VDD_SYS_REG		0x250
+#define PD_H616_ANA_VDD_GATE			BIT(4)
+#define PD_H6_CPUS_VDD_GATE			BIT(3)
+#define PD_H6_AVCC_VDD_GATE			BIT(2)
+#define PD_H6_GPU_REG			0x254
+#define PD_H6_GPU_GATE				BIT(0)
+
+struct sun50i_h6_ppu_pd {
+	struct generic_pm_domain	genpd;
+	void __iomem			*reg;
+	u32				gate_mask;
+	bool				negated;
+};
+
+#define FLAG_PPU_ALWAYS_ON	BIT(0)
+#define FLAG_PPU_NEGATED	BIT(1)
+
+struct sun50i_h6_ppu_desc {
+	const char *name;
+	u32 offset;
+	u32 mask;
+	unsigned int flags;
+};
+
+static const struct sun50i_h6_ppu_desc sun50i_h6_ppus[] = {
+	{ "AVCC", PD_H6_VDD_SYS_REG, PD_H6_AVCC_VDD_GATE },
+	{ "CPUS", PD_H6_VDD_SYS_REG, PD_H6_CPUS_VDD_GATE },
+	{ "GPU", PD_H6_GPU_REG, PD_H6_GPU_GATE },
+};
+static const struct sun50i_h6_ppu_desc sun50i_h616_ppus[] = {
+	{ "PLL", PD_H6_VDD_SYS_REG, PD_H6_AVCC_VDD_GATE,
+		FLAG_PPU_ALWAYS_ON | FLAG_PPU_NEGATED },
+	{ "ANA", PD_H6_VDD_SYS_REG, PD_H616_ANA_VDD_GATE, FLAG_PPU_ALWAYS_ON },
+	{ "GPU", PD_H6_GPU_REG, PD_H6_GPU_GATE, FLAG_PPU_NEGATED },
+};
+
+struct sun50i_h6_ppu_data {
+	const struct sun50i_h6_ppu_desc *descs;
+	int nr_domains;
+};
+
+static const struct sun50i_h6_ppu_data sun50i_h6_ppu_data = {
+	.descs = sun50i_h6_ppus,
+	.nr_domains = ARRAY_SIZE(sun50i_h6_ppus),
+};
+
+static const struct sun50i_h6_ppu_data sun50i_h616_ppu_data = {
+	.descs = sun50i_h616_ppus,
+	.nr_domains = ARRAY_SIZE(sun50i_h616_ppus),
+};
+
+#define to_sun50i_h6_ppu_pd(_genpd) \
+	container_of(_genpd, struct sun50i_h6_ppu_pd, genpd)
+
+static bool sun50i_h6_ppu_power_status(const struct sun50i_h6_ppu_pd *pd)
+{
+	bool bit = readl(pd->reg) & pd->gate_mask;
+
+	return bit ^ pd->negated;
+}
+
+static int sun50i_h6_ppu_pd_set_power(const struct sun50i_h6_ppu_pd *pd,
+				      bool set_bit)
+{
+	u32 reg = readl(pd->reg);
+
+	if (set_bit)
+		writel(reg | pd->gate_mask, pd->reg);
+	else
+		writel(reg & ~pd->gate_mask, pd->reg);
+
+	return 0;
+}
+
+static int sun50i_h6_ppu_pd_power_on(struct generic_pm_domain *genpd)
+{
+	const struct sun50i_h6_ppu_pd *pd = to_sun50i_h6_ppu_pd(genpd);
+
+	return sun50i_h6_ppu_pd_set_power(pd, !pd->negated);
+}
+
+static int sun50i_h6_ppu_pd_power_off(struct generic_pm_domain *genpd)
+{
+	const struct sun50i_h6_ppu_pd *pd = to_sun50i_h6_ppu_pd(genpd);
+
+	return sun50i_h6_ppu_pd_set_power(pd, pd->negated);
+}
+
+static int sun50i_h6_ppu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct genpd_onecell_data *ppu;
+	struct sun50i_h6_ppu_pd *pds;
+	const struct sun50i_h6_ppu_data *data;
+	void __iomem *base;
+	int ret, i;
+
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
+	pds = devm_kcalloc(dev, data->nr_domains, sizeof(*pds), GFP_KERNEL);
+	if (!pds)
+		return -ENOMEM;
+
+	ppu = devm_kzalloc(dev, sizeof(*ppu), GFP_KERNEL);
+	if (!ppu)
+		return -ENOMEM;
+
+	ppu->num_domains = data->nr_domains;
+	ppu->domains = devm_kcalloc(dev, data->nr_domains,
+				    sizeof(*ppu->domains), GFP_KERNEL);
+	if (!ppu->domains)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ppu);
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	for (i = 0; i < data->nr_domains; i++) {
+		struct sun50i_h6_ppu_pd *pd = &pds[i];
+		const struct sun50i_h6_ppu_desc *desc = &data->descs[i];
+
+		pd->genpd.name		= desc->name;
+		pd->genpd.power_off	= sun50i_h6_ppu_pd_power_off;
+		pd->genpd.power_on	= sun50i_h6_ppu_pd_power_on;
+		if (desc->flags & FLAG_PPU_ALWAYS_ON)
+			pd->genpd.flags = GENPD_FLAG_ALWAYS_ON;
+		pd->negated		= !!(desc->flags & FLAG_PPU_NEGATED);
+		pd->reg			= base + desc->offset - PD_H6_PPU_OFFSET;
+		pd->gate_mask		= desc->mask;
+
+		ret = pm_genpd_init(&pd->genpd, NULL,
+				    !sun50i_h6_ppu_power_status(pd));
+		if (ret) {
+			dev_warn(dev, "Failed to add %s power domain: %d\n",
+				 desc->name, ret);
+			goto out_remove_pds;
+		}
+		ppu->domains[i] = &pd->genpd;
+	}
+
+	ret = of_genpd_add_provider_onecell(dev->of_node, ppu);
+	if (!ret)
+		return 0;
+
+	dev_warn(dev, "Failed to add provider: %d\n", ret);
+out_remove_pds:
+	for (i--; i >= 0; i--)
+		pm_genpd_remove(&pds[i].genpd);
+
+	return ret;
+}
+
+static const struct of_device_id sun50i_h6_ppu_of_match[] = {
+	{ .compatible	= "allwinner,sun50i-h6-prcm-ppu",
+	  .data		= &sun50i_h6_ppu_data },
+	{ .compatible	= "allwinner,sun50i-h616-prcm-ppu",
+	  .data		= &sun50i_h616_ppu_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sun50i_h6_ppu_of_match);
+
+static struct platform_driver sun50i_h6_ppu_driver = {
+	.probe	= sun50i_h6_ppu_probe,
+	.driver	= {
+		.name			= "sun50i-h6-prcm-ppu",
+		.of_match_table		= sun50i_h6_ppu_of_match,
+		/* Power domains cannot be removed while they are in use. */
+		.suppress_bind_attrs	= true,
+	},
+};
+module_platform_driver(sun50i_h6_ppu_driver);
+
+MODULE_AUTHOR("Andre Przywara <andre.przywara@arm.com>");
+MODULE_DESCRIPTION("Allwinner H6 PRCM power domain driver");
+MODULE_LICENSE("GPL");
-- 
2.46.3


