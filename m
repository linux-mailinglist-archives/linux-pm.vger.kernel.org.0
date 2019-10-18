Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F393BDC110
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 11:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409847AbfJRJdQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 05:33:16 -0400
Received: from mail-sh.amlogic.com ([58.32.228.43]:32069 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409815AbfJRJdA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 05:33:00 -0400
Received: from droid13.amlogic.com (116.236.93.172) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.1591.10; Fri, 18 Oct 2019
 17:33:01 +0800
From:   Jianxin Pan <jianxin.pan@amlogic.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: [PATCH v3 3/4] soc: amlogic: Add support for Secure power domains controller
Date:   Fri, 18 Oct 2019 17:32:46 +0800
Message-ID: <1571391167-79679-4-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571391167-79679-1-git-send-email-jianxin.pan@amlogic.com>
References: <1571391167-79679-1-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [116.236.93.172]
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for the Amlogic Secure Power controller. In A1/C1 series, power
control registers are in secure domain, and should be accessed by smc.

Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
---
 drivers/soc/amlogic/Kconfig             |  13 ++
 drivers/soc/amlogic/Makefile            |   1 +
 drivers/soc/amlogic/meson-secure-pwrc.c | 204 ++++++++++++++++++++++++++++++++
 3 files changed, 218 insertions(+)
 create mode 100644 drivers/soc/amlogic/meson-secure-pwrc.c

diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
index bc2c912..6cb06e7 100644
--- a/drivers/soc/amlogic/Kconfig
+++ b/drivers/soc/amlogic/Kconfig
@@ -48,6 +48,19 @@ config MESON_EE_PM_DOMAINS
 	  Say yes to expose Amlogic Meson Everything-Else Power Domains as
 	  Generic Power Domains.
 
+config MESON_SECURE_PM_DOMAINS
+	bool "Amlogic Meson Secure Power Domains driver"
+	depends on ARCH_MESON || COMPILE_TEST
+	depends on PM && OF
+	depends on HAVE_ARM_SMCCC
+	default ARCH_MESON
+	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS_OF
+	help
+	  Support for the power controller on Amlogic A1/C1 series.
+	  Say yes to expose Amlogic Meson Secure Power Domains as Generic
+	  Power Domains.
+
 config MESON_MX_SOCINFO
 	bool "Amlogic Meson MX SoC Information driver"
 	depends on ARCH_MESON || COMPILE_TEST
diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
index de79d044..7b8c5d3 100644
--- a/drivers/soc/amlogic/Makefile
+++ b/drivers/soc/amlogic/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
 obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
 obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
 obj-$(CONFIG_MESON_EE_PM_DOMAINS) += meson-ee-pwrc.o
+obj-$(CONFIG_MESON_SECURE_PM_DOMAINS) += meson-secure-pwrc.o
diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
new file mode 100644
index 00000000..181b066
--- /dev/null
+++ b/drivers/soc/amlogic/meson-secure-pwrc.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Amlogic, Inc.
+ * Author: Jianxin Pan <jianxin.pan@amlogic.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/io.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <dt-bindings/power/meson-a1-power.h>
+#include <linux/arm-smccc.h>
+#include <linux/firmware/meson/meson_sm.h>
+
+#define PWRC_ON		1
+#define PWRC_OFF	0
+
+struct meson_secure_pwrc_domain {
+	struct generic_pm_domain base;
+	unsigned int index;
+	struct meson_secure_pwrc *pwrc;
+};
+
+struct meson_secure_pwrc {
+	struct meson_secure_pwrc_domain *domains;
+	struct genpd_onecell_data xlate;
+	struct meson_sm_firmware *fw;
+};
+
+struct meson_secure_pwrc_domain_desc {
+	unsigned int index;
+	unsigned int flags;
+	char *name;
+	bool (*is_off)(struct meson_secure_pwrc_domain *pwrc_domain);
+};
+
+struct meson_secure_pwrc_domain_data {
+	unsigned int count;
+	struct meson_secure_pwrc_domain_desc *domains;
+};
+
+static bool pwrc_secure_is_off(struct meson_secure_pwrc_domain *pwrc_domain)
+{
+	int sts = 1;
+
+	if (meson_sm_call(pwrc_domain->pwrc->fw, SM_PWRC_GET, &sts,
+			  pwrc_domain->index, 0, 0, 0, 0) < 0)
+		pr_err("failed to get power domain status\n");
+
+	return !!sts;
+}
+
+static int meson_secure_pwrc_off(struct generic_pm_domain *domain)
+{
+	int sts = 0;
+	struct meson_secure_pwrc_domain *pwrc_domain =
+		container_of(domain, struct meson_secure_pwrc_domain, base);
+
+	if (meson_sm_call(pwrc_domain->pwrc->fw, SM_PWRC_SET, NULL,
+	    pwrc_domain->index, PWRC_OFF, 0, 0, 0) < 0) {
+		pr_err("failed to set power domain off\n");
+		sts = -EINVAL;
+	}
+
+	return sts;
+}
+
+static int meson_secure_pwrc_on(struct generic_pm_domain *domain)
+{
+	int sts = 0;
+	struct meson_secure_pwrc_domain *pwrc_domain =
+		container_of(domain, struct meson_secure_pwrc_domain, base);
+
+	if (meson_sm_call(pwrc_domain->pwrc->fw, SM_PWRC_SET, NULL,
+	    pwrc_domain->index, PWRC_ON, 0, 0, 0) < 0) {
+		pr_err("failed to set power domain on\n");
+		sts = -EINVAL;
+	}
+
+	return sts;
+}
+
+#define SEC_PD(__name, __flag)			\
+[PWRC_##__name##_ID] =				\
+{						\
+	.name = #__name,			\
+	.index = PWRC_##__name##_ID,		\
+	.is_off = pwrc_secure_is_off,	\
+	.flags = __flag,			\
+}
+
+static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
+	SEC_PD(DSPA,	0),
+	SEC_PD(DSPB,	0),
+	/* UART should keep working in ATF after suspend and before resume */
+	SEC_PD(UART,	GENPD_FLAG_ALWAYS_ON),
+	/* DMC is for DDR PHY ana/dig and DMC, and should be always on */
+	SEC_PD(DMC,	GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(I2C,	0),
+	SEC_PD(PSRAM,	0),
+	SEC_PD(ACODEC,	0),
+	SEC_PD(AUDIO,	0),
+	SEC_PD(OTP,	0),
+	SEC_PD(DMA,	0),
+	SEC_PD(SD_EMMC,	0),
+	SEC_PD(RAMA,	0),
+	/* SRAMB is used as AFT runtime memory, and should be always on */
+	SEC_PD(RAMB,	GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(IR,	0),
+	SEC_PD(SPICC,	0),
+	SEC_PD(SPIFC,	0),
+	SEC_PD(USB,	0),
+	/* NIC is for NIC400, and should be always on */
+	SEC_PD(NIC,	GENPD_FLAG_ALWAYS_ON),
+	SEC_PD(PDMIN,	0),
+	SEC_PD(RSA,	0),
+};
+
+static int meson_secure_pwrc_probe(struct platform_device *pdev)
+{
+	int i;
+	struct device_node *sm_np;
+	struct meson_secure_pwrc *pwrc;
+	const struct meson_secure_pwrc_domain_data *match;
+
+	match = of_device_get_match_data(&pdev->dev);
+	if (!match) {
+		dev_err(&pdev->dev, "failed to get match data\n");
+		return -ENODEV;
+	}
+
+	sm_np = of_parse_phandle(pdev->dev.of_node, "secure-monitor", 0);
+	if (!sm_np) {
+		dev_err(&pdev->dev, "no secure-monitor node\n");
+		return -ENODEV;
+	}
+
+	pwrc = devm_kzalloc(&pdev->dev, sizeof(*pwrc), GFP_KERNEL);
+	if (!pwrc)
+		return -ENOMEM;
+
+	pwrc->fw = meson_sm_get(sm_np);
+	of_node_put(sm_np);
+	if (!pwrc->fw)
+		return -EPROBE_DEFER;
+
+	pwrc->xlate.domains = devm_kcalloc(&pdev->dev, match->count,
+					   sizeof(*pwrc->xlate.domains),
+					   GFP_KERNEL);
+	if (!pwrc->xlate.domains)
+		return -ENOMEM;
+
+	pwrc->domains = devm_kcalloc(&pdev->dev, match->count,
+				     sizeof(*pwrc->domains), GFP_KERNEL);
+	if (!pwrc->domains)
+		return -ENOMEM;
+
+	pwrc->xlate.num_domains = match->count;
+	platform_set_drvdata(pdev, pwrc);
+
+	for (i = 0 ; i < match->count ; ++i) {
+		struct meson_secure_pwrc_domain *dom = &pwrc->domains[i];
+
+		if (!match->domains[i].index)
+			continue;
+
+		dom->pwrc = pwrc;
+		dom->index = match->domains[i].index;
+		dom->base.name = match->domains[i].name;
+		dom->base.flags = match->domains[i].flags;
+		dom->base.power_on = meson_secure_pwrc_on;
+		dom->base.power_off = meson_secure_pwrc_off;
+
+		pm_genpd_init(&dom->base, NULL, match->domains[i].is_off(dom));
+
+		pwrc->xlate.domains[i] = &dom->base;
+	}
+
+	return of_genpd_add_provider_onecell(pdev->dev.of_node, &pwrc->xlate);
+}
+
+static struct meson_secure_pwrc_domain_data meson_secure_a1_pwrc_data = {
+	.domains = a1_pwrc_domains,
+	.count = ARRAY_SIZE(a1_pwrc_domains),
+};
+
+static const struct of_device_id meson_secure_pwrc_match_table[] = {
+	{
+		.compatible = "amlogic,meson-a1-pwrc",
+		.data = &meson_secure_a1_pwrc_data,
+	},
+	{ /* sentinel */ }
+};
+
+static struct platform_driver meson_secure_pwrc_driver = {
+	.probe = meson_secure_pwrc_probe,
+	.driver = {
+		.name		= "meson_secure_pwrc",
+		.of_match_table	= meson_secure_pwrc_match_table,
+	},
+};
+builtin_platform_driver(meson_secure_pwrc_driver);
-- 
2.7.4

