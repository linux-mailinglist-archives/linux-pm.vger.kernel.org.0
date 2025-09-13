Return-Path: <linux-pm+bounces-34594-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEEBB56314
	for <lists+linux-pm@lfdr.de>; Sat, 13 Sep 2025 23:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A51C172D37
	for <lists+linux-pm@lfdr.de>; Sat, 13 Sep 2025 21:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC39283FF9;
	Sat, 13 Sep 2025 21:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1E4NQlw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0CB28150A
	for <linux-pm@vger.kernel.org>; Sat, 13 Sep 2025 21:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757798189; cv=none; b=H31XLo07Yi0SIjZF+He9CzDoWC6JygqhYxe6AFPqzPUsf9Lpio34AGVQtAG3jI6n5oMtsrkdWbr2TyBkjNG8L6+wDALZNAJ0MKunO1nudw5eTrWrvEGnFdbPovIy5mu6awK/R9ALOHpgmcCAf4V3Js4L4T4/xuGkeSq+CkyQpD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757798189; c=relaxed/simple;
	bh=FbsSrDbIsf254X9ygdyJmab114sPqVBUJEm/ZgXYp8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nYHDIeLokB+09CITIer0whOU2B6rxR8WqklLJvEE5xLXaj4aiS1mZxNDELx67U/dJ4MGIQYodtoU4KkRbFGVrqurvKV+G3liTMsLReEK13A2HLKHy8FFG+nXX3e7K3R7BF0LMOVHiYmdEuga8pGoUZ0Jz39RBSXat1uq6GM8B/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1E4NQlw; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso20950585e9.2
        for <linux-pm@vger.kernel.org>; Sat, 13 Sep 2025 14:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757798184; x=1758402984; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hRPSMDhrgBlR28GcWuNEsdGj0gTClNNcrvrMo8tfw8k=;
        b=d1E4NQlwGwqFQ+WFnRgJY+NevmBkdDUJxOjIgNxpwg/zCJwxo0jwOXYF36yA425h9X
         5R+w/DwhaJ1gwHOpolMPsUedXKyEhEvDfANnNEeH20HPYCEGpHKdELDteSho43F40uql
         pqdqlZsrOOHQ0cEDysNSk/erMEFLIMFezm7KWqFYoNbw5rYLMYiUUFckM9x5nSBUE95w
         UeqkiYZJ8e8uBVqbpajytEy0gIZr3Vur+D68hwC1f81UMrtfzAcTb/DEgwyGB91f83Rd
         Ib4hrnrfrEnbR4dC3C3XbPMQp1df8HuJQfIWhGMd1cTjejxJw+BhgBs1d7VQ2ubJaxcW
         7heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757798184; x=1758402984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRPSMDhrgBlR28GcWuNEsdGj0gTClNNcrvrMo8tfw8k=;
        b=ANbfGG7ZP7XA2mdIHu7tog8Mdbw5GUyQDO70wLaP5eyBTHGXxccgiEaDbH2vHo+IXW
         7flZ9w8MPAt7QY6bNWQ7jghRYao5Y39hVrpz4QHokQle3R5QeRc2xAL4xr1xN1xs3peL
         V1nnIJ4CW6HULMJyJDnGjFNOjslBUvqfKtPhk0mvyoQoc7GxB89hpT78YE6C5R1S6ADD
         fLlPAhofForGF+QMrhqbAG9fdN/SSvNhsoN8D22XhUBGjUjizgwWFmLlkFWYASYNNiSL
         sOfZToNw6AmJ5wFcXqAj1TLrv/dejnxnFKJ9tvcxs3gcV63Cdnh+ubPZAlpE5u5qKi2f
         XGLg==
X-Forwarded-Encrypted: i=1; AJvYcCVXeulizsTCX9t6Ftvr/gALxG6QMBGvuMYVJ0gqzP9r9/PPsIdrw17BWSRoEbNjcXKJS9um/n3cVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyrXdcpnLGmwOaDc9fMdvgW4TEg9uZuCFv8qH7yoXVe9mbQXar
	EgyfSypI4lvp/2BUw9yd+HiAMQpFg3w20Wm/GZKOQIkLzmIKeKAwLruS
X-Gm-Gg: ASbGncuRhP/4rOEQ+Qe7kpl35CTLxM8Ac7MCU55X3VlDn9aqaw0GlFfJCw4iFXb0bsK
	6ncYkuGFa93cHv/6eZ+M5b5pIjWXiOg+STK2vXtDB68qpj1PJMuG9btBlvQXdckfYws0HULq1Ek
	496vNxfWngGxqfNLO8piLwQOp32IEI8M6g1EusDJhg8soxM2D7JjajEiD1SwQjwUTkngibGLG2g
	NMkfi4zt9nWTH/hgDv2k0IEEY6yqs9bcaJQZsPwt8pqTgAvZitiRJuPOgol7jWlvXhz1+oQWQcU
	qSXm7avWo81Ij43grmEB4kcRja8XNQ3HDX8enub1Jgz6JeXd63c9ezErsfUHhR1Ev1qi9LX9B6H
	rdzgZF0vxpIcKGfhfeXY9I/PQEDG/8D9CLdU5+SxGxivBrryjnFuy
X-Google-Smtp-Source: AGHT+IGn5Ct9i7dOW4IgjxA/5Yvs0me0MDivcN7ezFGBgxTgSHfWsOUNBtqLrEb3nQ0wFvqCLJX0Sw==
X-Received: by 2002:a05:600c:5248:b0:45d:d9ab:b85a with SMTP id 5b1f17b1804b1-45f211e520bmr76729935e9.7.1757798183876;
        Sat, 13 Sep 2025 14:16:23 -0700 (PDT)
Received: from Radijator.localdomain ([93.140.65.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e014ac468sm65403145e9.0.2025.09.13.14.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 14:16:23 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Date: Sat, 13 Sep 2025 23:12:49 +0200
Subject: [PATCH v4 2/4] pmdomain: marvell: Add PXA1908 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250913-pxa1908-genpd-v4-2-55e4cf32f619@dujemihanovic.xyz>
References: <20250913-pxa1908-genpd-v4-0-55e4cf32f619@dujemihanovic.xyz>
In-Reply-To: <20250913-pxa1908-genpd-v4-0-55e4cf32f619@dujemihanovic.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11858;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=s4HrTeVpqN7u98RpTsl8VxYA+1XpjoqSONdA9Q+y97U=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlH7yv999zI+slIjc9EObVH5coCHm5Ok+YpAr57EmfZc
 cfLrDjbUcrCIMbFICumyJL73/Ea72eRrduzlxnAzGFlAhnCwMUpABMJYGRkmCh4W+TGlc1BWVxx
 zN/4Vu/9MMNuduUqbbPrjQuOsy95ksrwz+wuw+KOhiP9F/lWljbmmny+3/t2UR57yLUb+ofvvzr
 ZxQ8A
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

From: Duje Mihanović <duje@dujemihanovic.xyz>

Marvell's PXA1908 SoC has a few power domains for its VPU, GPU, image
processor and DSI PHY. Add a driver to control these.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
v4:
- Drop usage of &genpd->dev
- Macros for poll sleep and timeout delays
- Configure domains before registering
- Clean up includes

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
 .../pmdomain/marvell/pxa1908-power-controller.c    | 274 +++++++++++++++++++++
 6 files changed, 298 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6f1d29c42c2eccf7fad489fd6a9b2c74fb24e4ff..5b0e4767639b24d89fa760020a9681e5c2001a6e 100644
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
index 0000000000000000000000000000000000000000..ff5e6e82d3f8df2b373a362e0460ccb9e196d9ce
--- /dev/null
+++ b/drivers/pmdomain/marvell/pxa1908-power-controller.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2025 Duje Mihanović <duje@dujemihanovic.xyz>
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/container_of.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/pm_domain.h>
+#include <linux/regmap.h>
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
+#define POWER_POLL_TIMEOUT_US	(25 * USEC_PER_MSEC)
+#define POWER_POLL_SLEEP_US	6
+
+#define NR_DOMAINS	5
+
+#define to_pxa1908_pd(_genpd) container_of(_genpd, struct pxa1908_pd, genpd)
+
+struct pxa1908_pd_ctrl {
+	struct generic_pm_domain *domains[NR_DOMAINS];
+	struct genpd_onecell_data onecell_data;
+	struct regmap *base;
+	struct device *dev;
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
+	struct pxa1908_pd_ctrl *ctrl;
+	struct generic_pm_domain genpd;
+	bool initialized;
+};
+
+static inline bool pxa1908_pd_is_on(struct pxa1908_pd *pd)
+{
+	struct pxa1908_pd_ctrl *ctrl = pd->ctrl;
+
+	return pd->data.id != PXA1908_POWER_DOMAIN_DSI
+		? regmap_test_bits(ctrl->base, APMU_PWR_STATUS_REG, pd->data.pwr_state)
+		: regmap_test_bits(ctrl->base, APMU_DEBUG, DSI_PHY_DVM_MASK);
+}
+
+static int pxa1908_pd_power_on(struct generic_pm_domain *genpd)
+{
+	struct pxa1908_pd *pd = to_pxa1908_pd(genpd);
+	const struct pxa1908_pd_data *data = &pd->data;
+	struct pxa1908_pd_ctrl *ctrl = pd->ctrl;
+	unsigned int status;
+	int ret = 0;
+
+	regmap_set_bits(ctrl->base, data->reg_clk_res_ctrl, data->hw_mode);
+	if (data->id != PXA1908_POWER_DOMAIN_ISP)
+		regmap_write(ctrl->base, APMU_PWR_BLK_TMR_REG, 0x20001fff);
+	regmap_set_bits(ctrl->base, APMU_PWR_CTRL_REG, data->pwr_state);
+
+	ret = regmap_read_poll_timeout(ctrl->base, APMU_PWR_STATUS_REG, status,
+				       status & data->pwr_state, POWER_POLL_SLEEP_US,
+				       POWER_ON_LATENCY_US + POWER_POLL_TIMEOUT_US);
+	if (ret == -ETIMEDOUT)
+		dev_err(ctrl->dev, "timed out powering on domain '%s'\n", pd->genpd.name);
+
+	return ret;
+}
+
+static int pxa1908_pd_power_off(struct generic_pm_domain *genpd)
+{
+	struct pxa1908_pd *pd = to_pxa1908_pd(genpd);
+	const struct pxa1908_pd_data *data = &pd->data;
+	struct pxa1908_pd_ctrl *ctrl = pd->ctrl;
+	unsigned int status;
+	int ret;
+
+	regmap_clear_bits(ctrl->base, APMU_PWR_CTRL_REG, data->pwr_state);
+
+	ret = regmap_read_poll_timeout(ctrl->base, APMU_PWR_STATUS_REG, status,
+				       !(status & data->pwr_state), POWER_POLL_SLEEP_US,
+				       POWER_OFF_LATENCY_US + POWER_POLL_TIMEOUT_US);
+	if (ret == -ETIMEDOUT) {
+		dev_err(ctrl->dev, "timed out powering off domain '%s'\n", pd->genpd.name);
+		return ret;
+	}
+
+	return regmap_clear_bits(ctrl->base, data->reg_clk_res_ctrl, data->hw_mode);
+}
+
+static inline int pxa1908_dsi_power_on(struct generic_pm_domain *genpd)
+{
+	struct pxa1908_pd *pd = to_pxa1908_pd(genpd);
+	struct pxa1908_pd_ctrl *ctrl = pd->ctrl;
+
+	return regmap_set_bits(ctrl->base, APMU_DEBUG, DSI_PHY_DVM_MASK);
+}
+
+static inline int pxa1908_dsi_power_off(struct generic_pm_domain *genpd)
+{
+	struct pxa1908_pd *pd = to_pxa1908_pd(genpd);
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
+			dev_err(&auxdev->dev, "failed to remove domain '%s': %d\n",
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
+	pd->ctrl = ctrl;
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
+	ret = pm_genpd_init(&pd->genpd, NULL, !pd->data.keep_on);
+	if (ret)
+		return dev_err_probe(dev, ret, "domain '%s' failed to initialize\n",
+				     pd->genpd.name);
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
+	ctrl->dev = dev;
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


