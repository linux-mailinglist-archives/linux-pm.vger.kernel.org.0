Return-Path: <linux-pm+bounces-32017-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE08B1CAE9
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 19:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4E6561554
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 17:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BCD29CB3E;
	Wed,  6 Aug 2025 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="ppBdqxcr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26CF1E5B72;
	Wed,  6 Aug 2025 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501717; cv=none; b=NGzlG33X0Cyfd1qNdgjgDcOc17H+9BNYmFUro2tAYzlXn4o0twjwoDgYp+sn1/DntI8AWn2VsuqSIJhI5SbNzeLX+Q1O8yqGUmet8Y0fgMiK2AwKWs8QocstZXY682yPYwxNwvzFpgvA1MppTkey/ooS2/eIGHfSleCSKZmq4Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501717; c=relaxed/simple;
	bh=E+XE8dpUP0CEk/XQFr1q2ddKC232C+8ijVTUXYignNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kJZ6l9XRYEdkfkaY2ZTKgp+WD9IqsC/q2IptmuB1RlQ+pM0I1YOcRVjMeulfPYKHXKZiBbUXr1hmnqa4Htrfuu2hqY5iV5fCng8QlmztNC4FfkUGhacmoxAEgmIDkKdih6+KMOuSAnTx2e2uY8unBBfdOUEocDN6D4kvpB6rWQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=ppBdqxcr; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=fDC+kUIre6ckl9jlN/ZVjuvYTYKw9eYYTx4lP7+Sulw=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1754501631; v=1; x=1754933631;
 b=ppBdqxcrLvL7Gt5hwAvh49DiGssR1eeAdHA8b5/yPZuiefZ6I7lIyWq8jmFESDPClCNvEgR/
 EkfPHddhNKKPcmSluR20YsmFb0RFNXmVgpJ4NXYAvzebEuH7Zt7eC1bcCNsIt73PQ3TEzHGm3zU
 GnJLxaTa0Ggu1fynsoNC3XU++cVrHDL2FgVafab4ks3OKPEWoVPOL30nhW+PseVQzKlSawEZ1ou
 jEjbTq3gjt2ZluNG5MfcYAVim3JC9Y7C5Bi9cZsslbXe4OEjiAzWJYNuH5IoiajDxgk6vPLb1DR
 5k4up1IwBKbWF8BXUSh1qjQ074JKfHsbSehsw6bE10TTA==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id c5f03fd3; Wed, 06 Aug 2025 19:33:51 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Wed, 06 Aug 2025 19:33:22 +0200
Subject: [PATCH RFC 3/5] pmdomain: marvell: Add PXA1908 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250806-pxa1908-genpd-v1-3-16409309fc72@dujemihanovic.xyz>
References: <20250806-pxa1908-genpd-v1-0-16409309fc72@dujemihanovic.xyz>
In-Reply-To: <20250806-pxa1908-genpd-v1-0-16409309fc72@dujemihanovic.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12221;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=E+XE8dpUP0CEk/XQFr1q2ddKC232C+8ijVTUXYignNE=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBmTJ/6R2nxls2dWR/axXqmP+VEMIp88pFVtnC7++MI1S
 yLrxE7njlIWBjEuBlkxRZbc/47XeD+LbN2evcwAZg4rE8gQBi5OAZhI9wOG/64HV9xeZFCh1i/n
 rbtDwvzc+hlr3yZqrG63Wp9wJux57n1Ghl3hu7fMWZ3Y7b9VeCnj25mc83JFNVeuXiyuGO1kafT
 0AycA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Marvell's PXA1908 SoC has a few power domains for its VPU, GPU, image
processor and DSI PHY. Add a driver to control these.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 drivers/pmdomain/Kconfig                           |   1 +
 drivers/pmdomain/Makefile                          |   1 +
 drivers/pmdomain/marvell/Kconfig                   |  16 +
 drivers/pmdomain/marvell/Makefile                  |   3 +
 .../pmdomain/marvell/pxa1908-power-controller.c    | 347 +++++++++++++++++++++
 5 files changed, 368 insertions(+)

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 91f04ace35d4b024fafdf6af4e26a179640eb82f..23076ae90e6641dea8e5dbc851d041cd7929cee6 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -7,6 +7,7 @@ source "drivers/pmdomain/apple/Kconfig"
 source "drivers/pmdomain/arm/Kconfig"
 source "drivers/pmdomain/bcm/Kconfig"
 source "drivers/pmdomain/imx/Kconfig"
+source "drivers/pmdomain/marvell/Kconfig"
 source "drivers/pmdomain/mediatek/Kconfig"
 source "drivers/pmdomain/qcom/Kconfig"
 source "drivers/pmdomain/renesas/Kconfig"
diff --git a/drivers/pmdomain/Makefile b/drivers/pmdomain/Makefile
index 7030f44a49df9e91b1c9d1b6d12690a6248671fb..ebc802f13eb953db750f5a9507caa64c637a957a 100644
--- a/drivers/pmdomain/Makefile
+++ b/drivers/pmdomain/Makefile
@@ -5,6 +5,7 @@ obj-y					+= apple/
 obj-y					+= arm/
 obj-y					+= bcm/
 obj-y					+= imx/
+obj-y					+= marvell/
 obj-y					+= mediatek/
 obj-y					+= qcom/
 obj-y					+= renesas/
diff --git a/drivers/pmdomain/marvell/Kconfig b/drivers/pmdomain/marvell/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..be2036726cc563ba2a3d1a82ca24763e2148fec2
--- /dev/null
+++ b/drivers/pmdomain/marvell/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menu "Marvell PM Domains"
+	depends on ARCH_MMP || COMPILE_TEST
+
+config PXA1908_PM_DOMAINS
+	tristate "Marvell PXA1908 power domains"
+	depends on OF
+	depends on PM
+	default ARCH_MMP && ARM64
+	select REGMAP
+	select PM_GENERIC_DOMAINS
+	help
+	  Say Y here to enable support for Marvell PXA1908's power domains.
+
+endmenu
diff --git a/drivers/pmdomain/marvell/Makefile b/drivers/pmdomain/marvell/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..6163bcbcb00ca7256e4c893117b7443b6fb195e7
--- /dev/null
+++ b/drivers/pmdomain/marvell/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_PXA1908_PM_DOMAINS)	+= pxa1908-power-controller.o
diff --git a/drivers/pmdomain/marvell/pxa1908-power-controller.c b/drivers/pmdomain/marvell/pxa1908-power-controller.c
new file mode 100644
index 0000000000000000000000000000000000000000..a8940e6dc2eaad2b14e9e6d8aa875c11e114b9dd
--- /dev/null
+++ b/drivers/pmdomain/marvell/pxa1908-power-controller.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2025 Duje Mihanović <duje@dujemihanovic.xyz>
+ */
+
+#include <linux/clk.h>
+#include <linux/container_of.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of.h>
+#include <linux/of_clk.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/regmap.h>
+#include <linux/units.h>
+
+#include <dt-bindings/power/marvell,pxa1908-power.h>
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
+struct pxa1908_pd_ctrl {
+	struct genpd_onecell_data onecell_data;
+	struct regmap *base;
+	struct generic_pm_domain *domains[];
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
+	struct generic_pm_domain genpd;
+	struct clk_bulk_data *clks;
+	struct device *dev;
+	bool initialized;
+	int num_clks;
+};
+
+static bool pxa1908_pd_is_on(struct pxa1908_pd *pd)
+{
+	struct pxa1908_pd_ctrl *ctrl = dev_get_drvdata(pd->dev);
+
+	return regmap_test_bits(ctrl->base, APMU_PWR_STATUS_REG, pd->data.pwr_state);
+}
+
+static int pxa1908_pd_power_on(struct generic_pm_domain *genpd)
+{
+	struct pxa1908_pd *pd = container_of(genpd, struct pxa1908_pd, genpd);
+	struct pxa1908_pd_ctrl *ctrl = dev_get_drvdata(pd->dev);
+	const struct pxa1908_pd_data *data = &pd->data;
+	unsigned int status;
+	int ret = 0;
+
+	if (pd->clks)
+		ret = clk_bulk_prepare_enable(pd->num_clks, pd->clks);
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
+	if (pd->clks)
+		clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
+
+	return ret;
+}
+
+static int pxa1908_pd_power_off(struct generic_pm_domain *genpd)
+{
+	struct pxa1908_pd *pd = container_of(genpd, struct pxa1908_pd, genpd);
+	struct pxa1908_pd_ctrl *ctrl = dev_get_drvdata(pd->dev);
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
+	regmap_clear_bits(ctrl->base, data->reg_clk_res_ctrl, data->hw_mode);
+
+	return 0;
+}
+
+static int pxa1908_dsi_power_on(struct generic_pm_domain *genpd)
+{
+	struct pxa1908_pd *pd = container_of(genpd, struct pxa1908_pd, genpd);
+	struct pxa1908_pd_ctrl *ctrl = dev_get_drvdata(pd->dev);
+
+	if (pd->clks) {
+		int ret = clk_bulk_prepare_enable(pd->num_clks, pd->clks);
+
+		if (ret) {
+			dev_err(pd->dev, "failed to enable clocks for domain '%s': %d\n",
+				pd->genpd.name, ret);
+			return ret;
+		}
+	}
+
+	regmap_set_bits(ctrl->base, APMU_DEBUG, DSI_PHY_DVM_MASK);
+
+	return 0;
+}
+
+static int pxa1908_dsi_power_off(struct generic_pm_domain *genpd)
+{
+	struct pxa1908_pd *pd = container_of(genpd, struct pxa1908_pd, genpd);
+	struct pxa1908_pd_ctrl *ctrl = dev_get_drvdata(pd->dev);
+
+	regmap_clear_bits(ctrl->base, APMU_DEBUG, DSI_PHY_DVM_MASK);
+
+	if (pd->clks)
+		clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
+
+	return 0;
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
+static struct pxa1908_pd domains[] = {
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
+	for (int i = ARRAY_SIZE(domains) - 1; i >= 0; i--) {
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
+
+		clk_bulk_put_all(pd->num_clks, pd->clks);
+	}
+}
+
+static int
+pxa1908_pd_init(struct pxa1908_pd_ctrl *ctrl, struct device_node *node, struct device *dev)
+{
+	struct pxa1908_pd *pd;
+	int clk_idx = 0, ret;
+	u32 id;
+
+	ret = of_property_read_u32(node, "reg", &id);
+	if (ret) {
+		dev_err(dev, "failed to get domain id from reg: %d\n", ret);
+		return ret;
+	}
+
+	if (id >= ARRAY_SIZE(domains)) {
+		dev_err(dev, "invalid domain id %d\n", id);
+		return ret;
+	}
+
+	pd = &domains[id];
+	pd->dev = dev;
+	pd->num_clks = of_clk_get_parent_count(node);
+	ctrl->domains[id] = &pd->genpd;
+
+	if (pd->num_clks > 0) {
+		pd->clks = devm_kcalloc(dev, pd->num_clks, sizeof(*pd->clks), GFP_KERNEL);
+		if (!pd->clks)
+			return -ENOMEM;
+	}
+
+	for (int i = 0; i < pd->num_clks; i++) {
+		struct clk *clk = of_clk_get(node, i);
+
+		if (IS_ERR(clk)) {
+			ret = PTR_ERR(clk);
+			dev_err(dev, "failed to get clk for domain '%s': %d\n",
+				pd->genpd.name, ret);
+			goto err;
+		}
+
+		pd->clks[clk_idx++].clk = clk;
+	}
+
+	/* Make sure the state of the hardware is synced with the domain table above. */
+	if (pd->data.keep_on) {
+		ret = pd->genpd.power_on(&pd->genpd);
+		if (ret) {
+			dev_err(dev, "failed to power on domain '%s': %d\n", pd->genpd.name, ret);
+			goto err;
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
+				goto err;
+			}
+		}
+	}
+
+	ret = pm_genpd_init(&pd->genpd, NULL, !pd->data.keep_on);
+	if (ret) {
+		dev_err(dev, "domain '%s' failed to initialize: %d\n", pd->genpd.name, ret);
+		goto err;
+	}
+
+	pd->initialized = true;
+
+	return 0;
+
+err:
+	clk_bulk_put_all(pd->num_clks, pd->clks);
+	return ret;
+}
+
+static int pxa1908_pd_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pxa1908_pd_ctrl *ctrl;
+	struct device_node *node;
+	int ret;
+
+	ctrl = devm_kzalloc(dev, struct_size(ctrl, domains, ARRAY_SIZE(domains)), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	ctrl->base = syscon_node_to_regmap(dev->parent->of_node);
+	if (IS_ERR(ctrl->base)) {
+		dev_err(dev, "no regmap available\n");
+		return PTR_ERR(ctrl->base);
+	}
+
+	platform_set_drvdata(pdev, ctrl);
+
+	ctrl->onecell_data.domains = ctrl->domains;
+	ctrl->onecell_data.num_domains = ARRAY_SIZE(domains);
+
+	for_each_available_child_of_node(dev->of_node, node) {
+		ret = pxa1908_pd_init(ctrl, node, dev);
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
+
+static void pxa1908_pd_remove(struct platform_device *pdev)
+{
+	pxa1908_pd_cleanup(platform_get_drvdata(pdev));
+}
+
+static const struct of_device_id pxa1908_pd_match[] = {
+	{
+		.compatible = "marvell,pxa1908-power-controller",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pxa1908_pd_match);
+
+static struct platform_driver pxa1908_pd_driver = {
+	.probe = pxa1908_pd_probe,
+	.remove = pxa1908_pd_remove,
+	.driver = {
+		.name = "pxa1908-power-controller",
+		.of_match_table = pxa1908_pd_match,
+	},
+};
+module_platform_driver(pxa1908_pd_driver);
+
+MODULE_AUTHOR("Duje Mihanović <duje@dujemihanovic.xyz>");
+MODULE_DESCRIPTION("Marvell PXA1908 power domain driver");
+MODULE_LICENSE("GPL");

-- 
2.50.1


