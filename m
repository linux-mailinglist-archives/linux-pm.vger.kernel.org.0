Return-Path: <linux-pm+bounces-33419-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4142BB3C08C
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 18:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C66B7A7FCB
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 16:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9198F3314A7;
	Fri, 29 Aug 2025 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="ZemcYvlc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31600322C9A;
	Fri, 29 Aug 2025 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484556; cv=none; b=SHWpmLB728TDPAMCN0kDL3YTa/hKIuy1IxmrfbLMg0zH6UmaGumTYPk2u6mA9bXTZzdmlqdLe3poWhN4/WCFcRbV+4MDyFnAawNX11ZmNWey3xbVtTH56WTQRtdi5kON1Hm/EaAxIqaa6JUuAuag3fnzguZOVYMwMr6OfjuejCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484556; c=relaxed/simple;
	bh=gaKwnEjy3q2LAzP0hxaYPN5rEw13O1EeGkCpOyoJKis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EA4U49cZoMqTpEqQzBZYGEjikxhhJ1X+EmERZJpsKLxCxyTzF8YBYgwKNzPlwreKokRo37R7/Wsmn+RL76GhRpgTMg2lsjZb/0lcPKyqSe3wsRtbtZFV4aF+HJ3r79OcT/F25s8mjy3HEeAAedG/zAkopaKGg5nk6DFzHNpveuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=ZemcYvlc; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=HcWbbFlqnPXoUdQoecbfucY7K6eTmd3Ok5/71jH8nuw=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1756484470; v=1; x=1756916470;
 b=ZemcYvlcZjbzoUrPHfQO13eVlj5U7pjrrP8LsnwDhPIqiB7CopBxplkJWAjBqMZxn5QFKwTM
 fU9jZB0ARnLtX2A9ZOm77sHP/e2+QQsHiN1qt43klvY5g092u1/dY57hBTTh9N1hTnJurIOWQ9p
 dzNXyUH83nbm10n6PI+ElFMh8gHk30WhMmCCvcIu5oq/Q2j1NdDhfx30Xy3BFUVk9GC8qZMx7Rr
 2uKuXojqsjQ2cye9rVA59GAl/D4QreQdUwdXtEF6GRxq20Ay22aHzTEZ/DZIDBCormCUidWC1/n
 g70zRMXYTzXG4NoMUFzn2xxP0IhPZj6WymdtEzOUwjb0g==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id a40bcf2b; Fri, 29 Aug 2025 18:21:10 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Fri, 29 Aug 2025 18:21:05 +0200
Subject: [PATCH v3 2/4] pmdomain: marvell: Add PXA1908 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250829-pxa1908-genpd-v3-2-2aacaaaca271@dujemihanovic.xyz>
References: <20250829-pxa1908-genpd-v3-0-2aacaaaca271@dujemihanovic.xyz>
In-Reply-To: <20250829-pxa1908-genpd-v3-0-2aacaaaca271@dujemihanovic.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11546;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=gaKwnEjy3q2LAzP0hxaYPN5rEw13O1EeGkCpOyoJKis=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBkbLxc7Jx00nSbQXxEjk3F9ueDPvbdCTt646zarWkIv7
 eye95wWHaUsDGJcDLJiiiy5/x2v8X4W2bo9e5kBzBxWJpAhDFycAjCRY28Z/jtfdZ3xXjz+oPqh
 vh+zjS/zPptxwOPGjLOLn6ur/LGyXq/O8JOROeHE2ozzl76FvmfzmRixwHcdh6xDdSyvxwFOX/m
 jykwA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Marvell's PXA1908 SoC has a few power domains for its VPU, GPU, image
processor and DSI PHY. Add a driver to control these.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
v3:
- Move driver back to pmdomain subsystem, use auxiliary bus to
  instantiate the driver
- Drop redundant 'struct device' pointer in 'struct pxa1908_pd'
- Fix pxa1908_pd_is_on() for DSI domain
- Replace usleep_range() with fsleep()
- Use dev_err_probe() where sensible

v2:
- Move to clk subsystem, instantiate the driver from the APMU clock
  driver
- Drop clock handling
- Squash MAINTAINERS patch
---
 MAINTAINERS                                        |   1 +
 drivers/pmdomain/Kconfig                           |   1 +
 drivers/pmdomain/Makefile                          |   1 +
 drivers/pmdomain/marvell/Kconfig                   |  18 ++
 drivers/pmdomain/marvell/Makefile                  |   3 +
 .../pmdomain/marvell/pxa1908-power-controller.c    | 268 +++++++++++++++++++++
 6 files changed, 292 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 88f7bd50686eb1f6bcd4f34c6827f27ad44ea4e8..34e5e218e83e0ed9882b111f5251601dd6549d4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2871,6 +2871,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm64/boot/dts/marvell/mmp/
 F:	drivers/clk/mmp/clk-pxa1908*.c
+F:	drivers/pmdomain/marvell/
 F:	include/dt-bindings/clock/marvell,pxa1908.h
 F:	include/dt-bindings/power/marvell,pxa1908-power.h
 
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
index 0000000000000000000000000000000000000000..6c4084c826670266b7d948438f6e6d76acb416e2
--- /dev/null
+++ b/drivers/pmdomain/marvell/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menu "Marvell PM Domains"
+	depends on ARCH_MMP || COMPILE_TEST
+
+config PXA1908_PM_DOMAINS
+	tristate "Marvell PXA1908 power domains"
+	depends on OF
+	depends on PM
+	default y if ARCH_MMP && ARM64
+	select AUXILIARY_BUS
+	select MFD_SYSCON
+	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS_OF
+	help
+	  Say Y here to enable support for Marvell PXA1908's power domanis.
+
+endmenu
diff --git a/drivers/pmdomain/marvell/Makefile b/drivers/pmdomain/marvell/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..22c25013f6c856a2ca01a121e830279ee88eb0ed
--- /dev/null
+++ b/drivers/pmdomain/marvell/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_PXA1908_PM_DOMAINS) += pxa1908-power-controller.o
diff --git a/drivers/pmdomain/marvell/pxa1908-power-controller.c b/drivers/pmdomain/marvell/pxa1908-power-controller.c
new file mode 100644
index 0000000000000000000000000000000000000000..29134629861abcf46959f9dcc98d3f05a4cc5b72
--- /dev/null
+++ b/drivers/pmdomain/marvell/pxa1908-power-controller.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2025 Duje Mihanović <duje@dujemihanovic.xyz>
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/container_of.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mod_devicetable.h>
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
+#define NR_DOMAINS	5
+
+struct pxa1908_pd_ctrl {
+	struct generic_pm_domain *domains[NR_DOMAINS];
+	struct genpd_onecell_data onecell_data;
+	struct regmap *base;
+};
+
+struct pxa1908_pd_data {
+	u32 reg_clk_res_ctrl;
+	u32 pwr_state;
+	u32 hw_mode;
+	bool keep_on;
+	int id;
+};
+
+struct pxa1908_pd {
+	const struct pxa1908_pd_data data;
+	struct generic_pm_domain genpd;
+	bool initialized;
+};
+
+static inline bool pxa1908_pd_is_on(struct pxa1908_pd *pd)
+{
+	struct pxa1908_pd_ctrl *ctrl = dev_get_drvdata(&pd->genpd.dev);
+
+	return pd->data.id != PXA1908_POWER_DOMAIN_DSI
+		? regmap_test_bits(ctrl->base, APMU_PWR_STATUS_REG, pd->data.pwr_state)
+		: regmap_test_bits(ctrl->base, APMU_DEBUG, DSI_PHY_DVM_MASK);
+}
+
+static int pxa1908_pd_power_on(struct generic_pm_domain *genpd)
+{
+	struct pxa1908_pd *pd = container_of(genpd, struct pxa1908_pd, genpd);
+	struct pxa1908_pd_ctrl *ctrl = dev_get_drvdata(&genpd->dev);
+	const struct pxa1908_pd_data *data = &pd->data;
+	unsigned int status;
+	int ret = 0;
+
+	regmap_set_bits(ctrl->base, data->reg_clk_res_ctrl, data->hw_mode);
+	if (data->id != PXA1908_POWER_DOMAIN_ISP)
+		regmap_write(ctrl->base, APMU_PWR_BLK_TMR_REG, 0x20001fff);
+	regmap_set_bits(ctrl->base, APMU_PWR_CTRL_REG, data->pwr_state);
+
+	fsleep(POWER_ON_LATENCY_US);
+
+	ret = regmap_read_poll_timeout(ctrl->base, APMU_PWR_STATUS_REG, status,
+				       status & data->pwr_state, 6, 25 * USEC_PER_MSEC);
+	if (ret == -ETIMEDOUT)
+		dev_err(&genpd->dev, "timed out powering on domain '%s'\n", pd->genpd.name);
+
+	return ret;
+}
+
+static int pxa1908_pd_power_off(struct generic_pm_domain *genpd)
+{
+	struct pxa1908_pd *pd = container_of(genpd, struct pxa1908_pd, genpd);
+	struct pxa1908_pd_ctrl *ctrl = dev_get_drvdata(&genpd->dev);
+	const struct pxa1908_pd_data *data = &pd->data;
+	unsigned int status;
+	int ret;
+
+	regmap_clear_bits(ctrl->base, APMU_PWR_CTRL_REG, data->pwr_state);
+
+	fsleep(POWER_OFF_LATENCY_US);
+
+	ret = regmap_read_poll_timeout(ctrl->base, APMU_PWR_STATUS_REG, status,
+				       !(status & data->pwr_state), 6, 25 * USEC_PER_MSEC);
+	if (ret == -ETIMEDOUT) {
+		dev_err(&genpd->dev, "timed out powering off domain '%s'\n", pd->genpd.name);
+		return ret;
+	}
+
+	return regmap_clear_bits(ctrl->base, data->reg_clk_res_ctrl, data->hw_mode);
+}
+
+static inline int pxa1908_dsi_power_on(struct generic_pm_domain *genpd)
+{
+	struct pxa1908_pd_ctrl *ctrl = dev_get_drvdata(&genpd->dev);
+
+	return regmap_set_bits(ctrl->base, APMU_DEBUG, DSI_PHY_DVM_MASK);
+}
+
+static inline int pxa1908_dsi_power_off(struct generic_pm_domain *genpd)
+{
+	struct pxa1908_pd_ctrl *ctrl = dev_get_drvdata(&genpd->dev);
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
+static void pxa1908_pd_remove(struct auxiliary_device *auxdev)
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
+		if (pxa1908_pd_is_on(pd) && !pd->data.keep_on)
+			pxa1908_pd_power_off(&pd->genpd);
+
+		ret = pm_genpd_remove(&pd->genpd);
+		if (ret)
+			dev_err(&pd->genpd.dev, "failed to remove domain '%s': %d\n",
+				pd->genpd.name, ret);
+	}
+}
+
+static int
+pxa1908_pd_init(struct pxa1908_pd_ctrl *ctrl, int id, struct device *dev)
+{
+	struct pxa1908_pd *pd = &domains[id];
+	int ret;
+
+	ctrl->domains[id] = &pd->genpd;
+
+	ret = pm_genpd_init(&pd->genpd, NULL, !pd->data.keep_on);
+	if (ret)
+		return dev_err_probe(dev, ret, "domain '%s' failed to initialize\n",
+				     pd->genpd.name);
+
+	dev_set_drvdata(&pd->genpd.dev, ctrl);
+
+	/* Make sure the state of the hardware is synced with the domain table above. */
+	if (pd->data.keep_on) {
+		ret = pd->genpd.power_on(&pd->genpd);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to power on domain '%s'\n",
+					     pd->genpd.name);
+	} else {
+		if (pxa1908_pd_is_on(pd)) {
+			dev_warn(dev,
+				 "domain '%s' is on despite being default off; powering off\n",
+				 pd->genpd.name);
+
+			ret = pd->genpd.power_off(&pd->genpd);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "failed to power off domain '%s'\n",
+						     pd->genpd.name);
+		}
+	}
+
+	pd->initialized = true;
+
+	return 0;
+}
+
+static int
+pxa1908_pd_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *aux_id)
+{
+	struct pxa1908_pd_ctrl *ctrl;
+	struct device *dev = &auxdev->dev;
+	int ret;
+
+	ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	auxiliary_set_drvdata(auxdev, ctrl);
+
+	ctrl->base = syscon_node_to_regmap(dev->parent->of_node);
+	if (IS_ERR(ctrl->base))
+		return dev_err_probe(dev, PTR_ERR(ctrl->base), "no regmap available\n");
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
+	return of_genpd_add_provider_onecell(dev->parent->of_node, &ctrl->onecell_data);
+
+err:
+	pxa1908_pd_remove(auxdev);
+	return ret;
+}
+
+static const struct auxiliary_device_id pxa1908_pd_id[] = {
+	{ .name = "clk_pxa1908_apmu.power" },
+	{ }
+};
+MODULE_DEVICE_TABLE(auxiliary, pxa1908_pd_id);
+
+static struct auxiliary_driver pxa1908_pd_driver = {
+	.probe = pxa1908_pd_probe,
+	.remove = pxa1908_pd_remove,
+	.id_table = pxa1908_pd_id,
+};
+module_auxiliary_driver(pxa1908_pd_driver);
+
+MODULE_AUTHOR("Duje Mihanović <duje@dujemihanovic.xyz>");
+MODULE_DESCRIPTION("Marvell PXA1908 power domain driver");
+MODULE_LICENSE("GPL");

-- 
2.51.0


