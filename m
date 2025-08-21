Return-Path: <linux-pm+bounces-32804-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5718FB2F657
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 13:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E67BD4E4102
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 11:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D9C3101AB;
	Thu, 21 Aug 2025 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="HRMBcbdh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46FA2EAD13;
	Thu, 21 Aug 2025 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775173; cv=none; b=l8D8aMxSAda1pKNOu+mvgrP5EdoyBO3RmAidj6Oqmc3xJRz19oUZJhfoDDwxGy4lW1I7W3DVaqqF/lykxZzw7bhPOwWNXdUg+IxunD9TOlLE2EDc86nvD3NC7fkJs3W74LQVFdIB2sZQi4QwfrOdgafaZvYwvbjSwZaaDjQce4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775173; c=relaxed/simple;
	bh=ltOzTcCBfRkX10R/lyEKFJpX0p777NieNYnVvTBOVVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iA3uyLP7/mg9OGwOCj+Ig7HRcK6YpkjrSO+SmjOUd3m7WgTQUqG3R146nS17HGbVvWM7YeeM+8tQERTtgVVkvgbXgvgZn9KlviVGz/BcTnev5qlb+VQlzmoagPgbatl18HC0n8DAH6Q8cy/j+8Cy8M+G977JG6ZYvrcijXf9oGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=HRMBcbdh; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=886NQPusS7/gCejkcBaOqU+vHQk2PxjE0dtYFfU6vZc=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1755775105; v=1; x=1756207105;
 b=HRMBcbdh0Z/jqAT///yLWIWu+xpiE2OI4lhywLgA/k9KZEVQtb4t1h/PDNCflxGGdH13+DYe
 JBThENc9dd+TZGMrLhwCqOEJ4L8c+jGgrgBp4NJ61c6J4Y7fKx9hDo8lnigwcpv5q1q8xH2qmyk
 rB954PQxSefMkNWR/fSDY4QhOFatorsehOrcwlb5n8eY9wXMTBFACBsP7cYSJrOfvYZWa+dsKV0
 oQIfb5ZfpXikZLuV2CJi8FtJv0/K6+oL9capFk0xPXZgXEQB+XnZm9xt++0syHlRSGDDXNKdJ1J
 hpOHyQK9ahIc+IVbLH77DbSFPXHSLplTHPEPaeTLyKQpA==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id d0d6586a; Thu, 21 Aug 2025 13:18:25 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Thu, 21 Aug 2025 13:17:45 +0200
Subject: [PATCH v2 3/4] clk: mmp: Add PXA1908 power domain driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-pxa1908-genpd-v2-3-eba413edd526@dujemihanovic.xyz>
References: <20250821-pxa1908-genpd-v2-0-eba413edd526@dujemihanovic.xyz>
In-Reply-To: <20250821-pxa1908-genpd-v2-0-eba413edd526@dujemihanovic.xyz>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11794;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=ltOzTcCBfRkX10R/lyEKFJpX0p777NieNYnVvTBOVVc=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBnLGerMpsqnFySHhp0N+a73acdax/vtvpGv+K7OvcFxR
 uO0yKd1HaUsDGJcDLJiiiy5/x2v8X4W2bo9e5kBzBxWJpAhDFycAjCRwHsM/12FNeLYqm/Zy12d
 P/9FNK/5D90HaVfL7oXteH2mWsl5twYjwx/uawu5m0+sKmh4VL+hdLH9tNDXK2oNpmnqpvKIT1f
 t4QYA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Marvell's PXA1908 SoC has a few power domains for its VPU, GPU, image
processor and DSI PHY. Add a driver to control these.

Also create a separate Kconfig entry for the PXA1908 clock drivers to
allow satisfying the driver's dependencies.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
v2:
- Move to clk subsystem, instantiate the driver from the APMU clock
  driver
- Drop clock handling
- Squash MAINTAINERS patch
---
 MAINTAINERS                             |   5 +
 drivers/clk/Kconfig                     |   1 +
 drivers/clk/mmp/Kconfig                 |  14 ++
 drivers/clk/mmp/Makefile                |   5 +-
 drivers/clk/mmp/clk-pxa1908-apmu.c      |   2 +-
 drivers/clk/mmp/clk.h                   |   2 +
 drivers/clk/mmp/pxa1908-power-domains.c | 253 ++++++++++++++++++++++++++++++++
 7 files changed, 280 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index daf520a13bdf6a991c0160a96620f40308c29ee0..309090a5ba6c03a2c00d3e39a896748958ffa593 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2869,9 +2869,14 @@ ARM/Marvell PXA1908 SOC support
 M:	Duje Mihanović <duje@dujemihanovic.xyz>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+C:	ircs://irc.oftc.net/pxa1908-mainline
+F:	Documentation/devicetree/bindings/clock/marvell,pxa1908.yaml
 F:	arch/arm64/boot/dts/marvell/mmp/
+F:	drivers/clk/mmp/Kconfig
 F:	drivers/clk/mmp/clk-pxa1908*.c
+F:	drivers/clk/mmp/pxa1908-power-domains.c
 F:	include/dt-bindings/clock/marvell,pxa1908.h
+F:	include/dt-bindings/power/marvell,pxa1908-power.h
 
 ARM/Mediatek RTC DRIVER
 M:	Eddie Huang <eddie.huang@mediatek.com>
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 4d56475f94fc1e28823fe6aee626a96847d4e6d5..68a9641fc649a23013b2d8a9e9f5ecb31d623abb 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -511,6 +511,7 @@ source "drivers/clk/imx/Kconfig"
 source "drivers/clk/ingenic/Kconfig"
 source "drivers/clk/keystone/Kconfig"
 source "drivers/clk/mediatek/Kconfig"
+source "drivers/clk/mmp/Kconfig"
 source "drivers/clk/meson/Kconfig"
 source "drivers/clk/mstar/Kconfig"
 source "drivers/clk/microchip/Kconfig"
diff --git a/drivers/clk/mmp/Kconfig b/drivers/clk/mmp/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..9dca5b50fd15a1d2ca71163c649a51592da15021
--- /dev/null
+++ b/drivers/clk/mmp/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config COMMON_CLK_PXA1908
+	bool "Clock driver for Marvell PXA1908"
+	depends on ARCH_MMP || COMPILE_TEST
+	depends on OF
+	default y if ARCH_MMP && ARM64
+	select PM
+	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS_OF
+	select REGMAP_MMIO
+	help
+	  This driver supports the Marvell PXA1908 SoC clocks. The SoC's power
+	  domains are also supported by the driver.
diff --git a/drivers/clk/mmp/Makefile b/drivers/clk/mmp/Makefile
index 062cd87fa8ddcc6808b6236f8c4dd524aaf02030..0b9ad29087ff23b8dc247bfd38f0e55382e16759 100644
--- a/drivers/clk/mmp/Makefile
+++ b/drivers/clk/mmp/Makefile
@@ -11,4 +11,7 @@ obj-$(CONFIG_MACH_MMP_DT) += clk-of-pxa168.o clk-of-pxa910.o
 obj-$(CONFIG_COMMON_CLK_MMP2) += clk-of-mmp2.o clk-pll.o pwr-island.o
 obj-$(CONFIG_COMMON_CLK_MMP2_AUDIO) += clk-audio.o
 
-obj-$(CONFIG_ARCH_MMP) += clk-of-pxa1928.o clk-pxa1908-apbc.o clk-pxa1908-apbcp.o clk-pxa1908-apmu.o clk-pxa1908-mpmu.o
+obj-$(CONFIG_COMMON_CLK_PXA1908) += clk-pxa1908-apbc.o clk-pxa1908-apbcp.o \
+	clk-pxa1908-mpmu.o clk-pxa1908-apmu.o pxa1908-power-domains.o
+
+obj-$(CONFIG_ARCH_MMP) += clk-of-pxa1928.o
diff --git a/drivers/clk/mmp/clk-pxa1908-apmu.c b/drivers/clk/mmp/clk-pxa1908-apmu.c
index d3a070687fc5b9fb5338f377f82e7664ca0aac29..3d4494cfc9bc28e1e614a11f56aa3d211fb6ec26 100644
--- a/drivers/clk/mmp/clk-pxa1908-apmu.c
+++ b/drivers/clk/mmp/clk-pxa1908-apmu.c
@@ -98,7 +98,7 @@ static int pxa1908_apmu_probe(struct platform_device *pdev)
 
 	pxa1908_axi_periph_clk_init(pxa_unit);
 
-	return 0;
+	return pxa1908_pd_register(&pdev->dev);
 }
 
 static const struct of_device_id pxa1908_apmu_match_table[] = {
diff --git a/drivers/clk/mmp/clk.h b/drivers/clk/mmp/clk.h
index c83cec169ddc5e3fcd0561cf857f248178c25b68..6d3d089a0372fa48c8f61aceacdd1b2059f2c8dd 100644
--- a/drivers/clk/mmp/clk.h
+++ b/drivers/clk/mmp/clk.h
@@ -258,4 +258,6 @@ struct generic_pm_domain *mmp_pm_domain_register(const char *name,
 		u32 power_on, u32 reset, u32 clock_enable,
 		unsigned int flags, spinlock_t *lock);
 
+int pxa1908_pd_register(struct device *dev);
+
 #endif
diff --git a/drivers/clk/mmp/pxa1908-power-domains.c b/drivers/clk/mmp/pxa1908-power-domains.c
new file mode 100644
index 0000000000000000000000000000000000000000..9f698a17e5a920d0472b74fce137b42cae0569d2
--- /dev/null
+++ b/drivers/clk/mmp/pxa1908-power-domains.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2025 Duje Mihanović <duje@dujemihanovic.xyz>
+ */
+
+#include <linux/container_of.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/regmap.h>
+#include <linux/units.h>
+
+#include <dt-bindings/power/marvell,pxa1908-power.h>
+
+#include "clk.h"
+
+/* VPU, GPU, ISP */
+#define APMU_PWR_CTRL_REG	0xd8
+#define APMU_PWR_BLK_TMR_REG	0xdc
+#define APMU_PWR_STATUS_REG	0xf0
+
+/* DSI */
+#define APMU_DEBUG		0x88
+#define DSI_PHY_DVM_MASK	BIT(31)
+
+#define POWER_ON_LATENCY_US	300
+#define POWER_OFF_LATENCY_US	20
+
+#define NR_DOMAINS	5
+
+struct pxa1908_pd_ctrl {
+	struct genpd_onecell_data onecell_data;
+	struct generic_pm_domain *domains[NR_DOMAINS];
+	struct regmap *base;
+};
+
+struct pxa1908_pd_data {
+	u32 reg_clk_res_ctrl;
+	u32 hw_mode;
+	u32 pwr_state;
+	bool keep_on;
+	int id;
+};
+
+struct pxa1908_pd {
+	const struct pxa1908_pd_data data;
+	struct pxa1908_pd_ctrl *ctrl;
+	struct generic_pm_domain genpd;
+	struct device *dev;
+	bool initialized;
+	int num_clks;
+};
+
+static bool pxa1908_pd_is_on(struct pxa1908_pd *pd)
+{
+	struct pxa1908_pd_ctrl *ctrl = pd->ctrl;
+
+	return regmap_test_bits(ctrl->base, APMU_PWR_STATUS_REG, pd->data.pwr_state);
+}
+
+static int pxa1908_pd_power_on(struct generic_pm_domain *genpd)
+{
+	struct pxa1908_pd *pd = container_of(genpd, struct pxa1908_pd, genpd);
+	struct pxa1908_pd_ctrl *ctrl = pd->ctrl;
+	const struct pxa1908_pd_data *data = &pd->data;
+	unsigned int status;
+	int ret = 0;
+
+	regmap_set_bits(ctrl->base, data->reg_clk_res_ctrl, data->hw_mode);
+	if (data->id != PXA1908_POWER_DOMAIN_ISP)
+		regmap_write(ctrl->base, APMU_PWR_BLK_TMR_REG, 0x20001fff);
+	regmap_set_bits(ctrl->base, APMU_PWR_CTRL_REG, data->pwr_state);
+
+	usleep_range(POWER_ON_LATENCY_US, POWER_ON_LATENCY_US * 2);
+
+	ret = regmap_read_poll_timeout(ctrl->base, APMU_PWR_STATUS_REG, status,
+				       status & data->pwr_state, 6, 25 * USEC_PER_MSEC);
+	if (ret == -ETIMEDOUT)
+		dev_err(pd->dev, "timed out powering on domain '%s'\n", pd->genpd.name);
+
+	return ret;
+}
+
+static int pxa1908_pd_power_off(struct generic_pm_domain *genpd)
+{
+	struct pxa1908_pd *pd = container_of(genpd, struct pxa1908_pd, genpd);
+	struct pxa1908_pd_ctrl *ctrl = pd->ctrl;
+	const struct pxa1908_pd_data *data = &pd->data;
+	unsigned int status;
+	int ret;
+
+	regmap_clear_bits(ctrl->base, APMU_PWR_CTRL_REG, data->pwr_state);
+
+	usleep_range(POWER_OFF_LATENCY_US, POWER_OFF_LATENCY_US * 2);
+
+	ret = regmap_read_poll_timeout(ctrl->base, APMU_PWR_STATUS_REG, status,
+				       !(status & data->pwr_state), 6, 25 * USEC_PER_MSEC);
+	if (ret == -ETIMEDOUT) {
+		dev_err(pd->dev, "timed out powering off domain '%s'\n", pd->genpd.name);
+		return ret;
+	}
+
+	return regmap_clear_bits(ctrl->base, data->reg_clk_res_ctrl, data->hw_mode);
+}
+
+static inline int pxa1908_dsi_power_on(struct generic_pm_domain *genpd)
+{
+	struct pxa1908_pd *pd = container_of(genpd, struct pxa1908_pd, genpd);
+	struct pxa1908_pd_ctrl *ctrl = pd->ctrl;
+
+	return regmap_set_bits(ctrl->base, APMU_DEBUG, DSI_PHY_DVM_MASK);
+}
+
+static inline int pxa1908_dsi_power_off(struct generic_pm_domain *genpd)
+{
+	struct pxa1908_pd *pd = container_of(genpd, struct pxa1908_pd, genpd);
+	struct pxa1908_pd_ctrl *ctrl = pd->ctrl;
+
+	return regmap_clear_bits(ctrl->base, APMU_DEBUG, DSI_PHY_DVM_MASK);
+}
+
+#define DOMAIN(_id, _name, ctrl, mode, state) \
+	[_id] = { \
+		.data = { \
+			.reg_clk_res_ctrl = ctrl, \
+			.hw_mode = BIT(mode), \
+			.pwr_state = BIT(state), \
+			.id = _id, \
+		}, \
+		.genpd = { \
+			.name = _name, \
+			.power_on = pxa1908_pd_power_on, \
+			.power_off = pxa1908_pd_power_off, \
+		}, \
+	}
+
+static struct pxa1908_pd domains[NR_DOMAINS] = {
+	DOMAIN(PXA1908_POWER_DOMAIN_VPU, "vpu", 0xa4, 19, 2),
+	DOMAIN(PXA1908_POWER_DOMAIN_GPU, "gpu", 0xcc, 11, 0),
+	DOMAIN(PXA1908_POWER_DOMAIN_GPU2D, "gpu2d", 0xf4, 11, 6),
+	DOMAIN(PXA1908_POWER_DOMAIN_ISP, "isp", 0x38, 15, 4),
+	[PXA1908_POWER_DOMAIN_DSI] = {
+		.genpd = {
+			.name = "dsi",
+			.power_on = pxa1908_dsi_power_on,
+			.power_off = pxa1908_dsi_power_off,
+			/*
+			 * TODO: There is no DSI driver written yet and until then we probably
+			 * don't want to power off the DSI PHY ever.
+			 */
+			.flags = GENPD_FLAG_ALWAYS_ON,
+		},
+		.data = {
+			/* See above. */
+			.keep_on = true,
+		},
+	},
+};
+
+static void pxa1908_pd_cleanup(struct pxa1908_pd_ctrl *ctrl)
+{
+	struct pxa1908_pd *pd;
+	int ret;
+
+	for (int i = NR_DOMAINS - 1; i >= 0; i--) {
+		pd = &domains[i];
+
+		if (!pd->initialized)
+			continue;
+
+		ret = pm_genpd_remove(&pd->genpd);
+		if (ret)
+			dev_err(pd->dev, "failed to remove domain '%s': %d\n",
+				pd->genpd.name, ret);
+		if (pxa1908_pd_is_on(pd) && !pd->data.keep_on)
+			pxa1908_pd_power_off(&pd->genpd);
+	}
+}
+
+static int
+pxa1908_pd_init(struct pxa1908_pd_ctrl *ctrl, int id, struct device *dev)
+{
+	struct pxa1908_pd *pd = &domains[id];
+	int ret;
+
+	pd->dev = dev;
+	pd->ctrl = ctrl;
+	ctrl->domains[id] = &pd->genpd;
+
+	/* Make sure the state of the hardware is synced with the domain table above. */
+	if (pd->data.keep_on) {
+		ret = pd->genpd.power_on(&pd->genpd);
+		if (ret) {
+			dev_err(dev, "failed to power on domain '%s': %d\n", pd->genpd.name, ret);
+			return ret;
+		}
+	} else {
+		if (pxa1908_pd_is_on(pd)) {
+			dev_warn(dev,
+				 "domain '%s' is on despite being default off; powering off\n",
+				 pd->genpd.name);
+
+			ret = pxa1908_pd_power_off(&pd->genpd);
+			if (ret) {
+				dev_err(dev, "failed to power off domain '%s': %d\n",
+					pd->genpd.name, ret);
+				return ret;
+			}
+		}
+	}
+
+	ret = pm_genpd_init(&pd->genpd, NULL, !pd->data.keep_on);
+	if (ret) {
+		dev_err(dev, "domain '%s' failed to initialize: %d\n", pd->genpd.name, ret);
+		return ret;
+	}
+
+	pd->initialized = true;
+
+	return 0;
+}
+
+int pxa1908_pd_register(struct device *dev)
+{
+	struct pxa1908_pd_ctrl *ctrl;
+	int ret;
+
+	ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	ctrl->base = syscon_node_to_regmap(dev->of_node);
+	if (IS_ERR(ctrl->base)) {
+		dev_err(dev, "no regmap available\n");
+		return PTR_ERR(ctrl->base);
+	}
+
+	ctrl->onecell_data.domains = ctrl->domains;
+	ctrl->onecell_data.num_domains = NR_DOMAINS;
+
+	for (int i = 0; i < NR_DOMAINS; i++) {
+		ret = pxa1908_pd_init(ctrl, i, dev);
+		if (ret)
+			goto err;
+	}
+
+	return of_genpd_add_provider_onecell(dev->of_node, &ctrl->onecell_data);
+
+err:
+	pxa1908_pd_cleanup(ctrl);
+	return ret;
+}

-- 
2.50.1


