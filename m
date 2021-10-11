Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410454294F3
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 18:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbhJKRA5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 13:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbhJKRAE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 13:00:04 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90622C061570;
        Mon, 11 Oct 2021 09:58:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 0B91D424EC;
        Mon, 11 Oct 2021 16:57:57 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/9] memory: apple: Add apple-mcc driver to manage MCC perf in Apple SoCs
Date:   Tue, 12 Oct 2021 01:57:04 +0900
Message-Id: <20211011165707.138157-7-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011165707.138157-1-marcan@marcan.st>
References: <20211011165707.138157-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This driver binds to the memory controller hardware in Apple SoCs such
as the Apple M1, and provides a power domain that downstream devices can
use to change the performance state of the memory controller.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/memory/Kconfig     |   9 +++
 drivers/memory/Makefile    |   1 +
 drivers/memory/apple-mcc.c | 130 +++++++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+)
 create mode 100644 drivers/memory/apple-mcc.c

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 72c0df129d5c..48ef3d563a1c 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -30,6 +30,15 @@ config ARM_PL172_MPMC
 	  If you have an embedded system with an AMBA bus and a PL172
 	  controller, say Y or M here.
 
+config APPLE_MCC
+	tristate "Apple SoC MCC driver"
+	default y if ARCH_APPLE
+	select PM_GENERIC_DOMAINS
+	depends on ARCH_APPLE || COMPILE_TEST
+	help
+	  This driver manages performance tuning for the memory controller in
+	  Apple SoCs, such as the Apple M1.
+
 config ATMEL_SDRAMC
 	bool "Atmel (Multi-port DDR-)SDRAM Controller"
 	default y if ARCH_AT91
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index bc7663ed1c25..947840cbd2d4 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -8,6 +8,7 @@ ifeq ($(CONFIG_DDR),y)
 obj-$(CONFIG_OF)		+= of_memory.o
 endif
 obj-$(CONFIG_ARM_PL172_MPMC)	+= pl172.o
+obj-$(CONFIG_APPLE_MCC)		+= apple-mcc.o
 obj-$(CONFIG_ATMEL_SDRAMC)	+= atmel-sdramc.o
 obj-$(CONFIG_ATMEL_EBI)		+= atmel-ebi.o
 obj-$(CONFIG_BRCMSTB_DPFE)	+= brcmstb_dpfe.o
diff --git a/drivers/memory/apple-mcc.c b/drivers/memory/apple-mcc.c
new file mode 100644
index 000000000000..55959f034b9a
--- /dev/null
+++ b/drivers/memory/apple-mcc.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Apple SoC MCC memory controller performance control driver
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_opp.h>
+
+#define APPLE_MCC_PERF_CONFIG1  0xdc4
+#define APPLE_MCC_PERF_CONFIG2  0xdbc
+#define APPLE_MCC_CHANNEL(x)	((x) * 0x40000)
+
+struct apple_mcc {
+	struct device *dev;
+	struct generic_pm_domain genpd;
+	void __iomem *reg_base;
+	u32 num_channels;
+};
+
+#define to_apple_mcc(_genpd) container_of(_genpd, struct apple_mcc, genpd)
+
+static int apple_mcc_set_performance_state(struct generic_pm_domain *genpd, unsigned int state)
+{
+	struct apple_mcc *mcc = to_apple_mcc(genpd);
+	struct dev_pm_opp *opp;
+	struct device_node *np;
+	u32 perf_config[2];
+	unsigned int i;
+
+	dev_dbg(mcc->dev, "switching to perf state %d\n", state);
+
+	opp = dev_pm_opp_find_level_exact(&mcc->genpd.dev, state);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	np = dev_pm_opp_get_of_node(opp);
+	if (of_property_read_u32_array(np, "apple,memory-perf-config",
+		perf_config, ARRAY_SIZE(perf_config))) {
+		dev_err(mcc->dev, "missing apple,memory-perf-config property");
+		of_node_put(np);
+		return -EINVAL;
+	}
+	of_node_put(np);
+
+	for (i = 0; i < mcc->num_channels; i++) {
+		writel_relaxed(perf_config[0],
+			       mcc->reg_base + APPLE_MCC_CHANNEL(i) + APPLE_MCC_PERF_CONFIG1);
+		writel_relaxed(perf_config[1],
+			       mcc->reg_base + APPLE_MCC_CHANNEL(i) + APPLE_MCC_PERF_CONFIG2);
+	}
+
+	return 0;
+}
+
+static unsigned int apple_mcc_opp_to_performance_state(struct generic_pm_domain *genpd,
+						       struct dev_pm_opp *opp)
+{
+	return dev_pm_opp_get_level(opp);
+}
+
+static int apple_mcc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct apple_mcc *mcc;
+	int ret;
+
+	mcc = devm_kzalloc(dev, sizeof(*mcc), GFP_KERNEL);
+	if (!mcc)
+		return -ENOMEM;
+
+	mcc->reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mcc->reg_base))
+		return PTR_ERR(mcc->reg_base);
+
+	if (of_property_read_u32(node, "apple,num-channels", &mcc->num_channels)) {
+		dev_err(dev, "missing apple,num-channels property\n");
+		return -ENOENT;
+	}
+
+	mcc->dev = dev;
+	mcc->genpd.name = "apple-mcc-perf";
+	mcc->genpd.opp_to_performance_state = apple_mcc_opp_to_performance_state;
+	mcc->genpd.set_performance_state = apple_mcc_set_performance_state;
+
+	ret = pm_genpd_init(&mcc->genpd, NULL, false);
+	if (ret < 0) {
+		dev_err(dev, "pm_genpd_init failed\n");
+		return ret;
+	}
+
+	ret = of_genpd_add_provider_simple_noclk(node, &mcc->genpd);
+	if (ret < 0) {
+		dev_err(dev, "of_genpd_add_provider_simple failed\n");
+		return ret;
+	}
+
+	dev_info(dev, "Apple MCC performance driver initialized\n");
+
+	return 0;
+}
+
+static const struct of_device_id apple_mcc_of_match[] = {
+	{ .compatible = "apple,mcc" },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, apple_mcc_of_match);
+
+static struct platform_driver apple_mcc_driver = {
+	.probe = apple_mcc_probe,
+	.driver = {
+		.name = "apple-mcc",
+		.of_match_table = apple_mcc_of_match,
+	},
+};
+
+MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
+MODULE_DESCRIPTION("MCC memory controller performance tuning driver for Apple SoCs");
+MODULE_LICENSE("GPL v2");
+
+module_platform_driver(apple_mcc_driver);
-- 
2.33.0

