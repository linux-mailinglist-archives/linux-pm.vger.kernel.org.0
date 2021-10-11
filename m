Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569FD4294F8
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 18:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhJKRBH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 13:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbhJKRAK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 13:00:10 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4343FC061570;
        Mon, 11 Oct 2021 09:58:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id AD71E425BD;
        Mon, 11 Oct 2021 16:58:03 +0000 (UTC)
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
Subject: [RFC PATCH 7/9] clk: apple: Add clk-apple-cluster driver to manage CPU p-states
Date:   Tue, 12 Oct 2021 01:57:05 +0900
Message-Id: <20211011165707.138157-8-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011165707.138157-1-marcan@marcan.st>
References: <20211011165707.138157-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This driver exposes the CPU performance state switching hardware in
Apple SoCs as a clock controller that can be used together with the
generic cpufreq-dt mechanism to implement cpufreq support. It also
supports binding to an apple-mcc instance, to increase memory controller
performance when the CPUs are in the highest performance states.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/clk/Kconfig             |   9 ++
 drivers/clk/Makefile            |   1 +
 drivers/clk/clk-apple-cluster.c | 184 ++++++++++++++++++++++++++++++++
 3 files changed, 194 insertions(+)
 create mode 100644 drivers/clk/clk-apple-cluster.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c5b3dc97396a..f3c8ad041f91 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -390,6 +390,15 @@ config COMMON_CLK_K210
 	help
 	  Support for the Canaan Kendryte K210 RISC-V SoC clocks.
 
+config COMMON_CLK_APPLE_CLUSTER
+	bool "Clock driver for Apple SoC CPU clusters"
+	depends on ARCH_APPLE || COMPILE_TEST
+	select CPUFREQ_DT
+	default ARCH_APPLE
+	help
+	  This driver supports CPU cluster frequency switching on Apple SoC
+	  platforms.
+
 source "drivers/clk/actions/Kconfig"
 source "drivers/clk/analogbits/Kconfig"
 source "drivers/clk/baikal-t1/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index e42312121e51..6dba8c2052c7 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_COMMON_CLK_FIXED_MMIO)	+= clk-fixed-mmio.o
 obj-$(CONFIG_COMMON_CLK_FSL_FLEXSPI)	+= clk-fsl-flexspi.o
 obj-$(CONFIG_COMMON_CLK_FSL_SAI)	+= clk-fsl-sai.o
 obj-$(CONFIG_COMMON_CLK_GEMINI)		+= clk-gemini.o
+obj-$(CONFIG_COMMON_CLK_APPLE_CLUSTER)	+= clk-apple-cluster.o
 obj-$(CONFIG_COMMON_CLK_ASPEED)		+= clk-aspeed.o
 obj-$(CONFIG_MACH_ASPEED_G6)		+= clk-ast2600.o
 obj-$(CONFIG_ARCH_HIGHBANK)		+= clk-highbank.o
diff --git a/drivers/clk/clk-apple-cluster.c b/drivers/clk/clk-apple-cluster.c
new file mode 100644
index 000000000000..9e9be38f13b2
--- /dev/null
+++ b/drivers/clk/clk-apple-cluster.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Apple SoC CPU cluster performance state driver
+ *
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_opp.h>
+
+#define APPLE_CLUSTER_PSTATE    0x20
+#define APPLE_CLUSTER_PSTATE_BUSY	BIT(31)
+#define APPLE_CLUSTER_PSTATE_SET	BIT(25)
+#define APPLE_CLUSTER_PSTATE_DESIRED2	GENMASK(15, 12)
+#define APPLE_CLUSTER_PSTATE_DESIRED1	GENMASK(3, 0)
+
+struct apple_cluster_clk {
+	struct clk_hw hw;
+	struct device *dev;
+	void __iomem *reg_base;
+	bool has_pd;
+};
+
+#define to_apple_cluster_clk(_hw) container_of(_hw, struct apple_cluster_clk, hw)
+
+#define APPLE_CLUSTER_SWITCH_TIMEOUT 100
+
+static int apple_cluster_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+					 unsigned long parent_rate)
+{
+	struct apple_cluster_clk *cluster = to_apple_cluster_clk(hw);
+	struct dev_pm_opp *opp;
+	unsigned int level;
+	u64 reg;
+
+	opp = dev_pm_opp_find_freq_floor(cluster->dev, &rate);
+
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	level = dev_pm_opp_get_level(opp);
+
+	dev_dbg(cluster->dev, "set_rate: %ld -> %d\n", rate, level);
+
+	if (readq_poll_timeout(cluster->reg_base + APPLE_CLUSTER_PSTATE, reg,
+			       !(reg & APPLE_CLUSTER_PSTATE_BUSY), 2,
+			       APPLE_CLUSTER_SWITCH_TIMEOUT)) {
+		dev_err(cluster->dev, "timed out waiting for busy flag\n");
+		return -EIO;
+	}
+
+	reg &= ~(APPLE_CLUSTER_PSTATE_DESIRED1 | APPLE_CLUSTER_PSTATE_DESIRED2);
+	reg |= FIELD_PREP(APPLE_CLUSTER_PSTATE_DESIRED1, level);
+	reg |= FIELD_PREP(APPLE_CLUSTER_PSTATE_DESIRED2, level);
+	reg |= APPLE_CLUSTER_PSTATE_SET;
+
+	writeq_relaxed(reg, cluster->reg_base + APPLE_CLUSTER_PSTATE);
+
+	if (cluster->has_pd)
+		dev_pm_genpd_set_performance_state(cluster->dev,
+						   dev_pm_opp_get_required_pstate(opp, 0));
+
+	return 0;
+}
+
+static unsigned long apple_cluster_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct apple_cluster_clk *cluster = to_apple_cluster_clk(hw);
+	struct dev_pm_opp *opp;
+	u64 reg;
+
+	reg = readq_relaxed(cluster->reg_base + APPLE_CLUSTER_PSTATE);
+
+	opp = dev_pm_opp_find_level_exact(cluster->dev,
+					  FIELD_GET(APPLE_CLUSTER_PSTATE_DESIRED1, reg));
+
+	if (IS_ERR(opp)) {
+		dev_err(cluster->dev, "failed to find level: 0x%llx (%ld)\n", reg, PTR_ERR(opp));
+		return 0;
+	}
+
+	return dev_pm_opp_get_freq(opp);
+}
+
+static long apple_cluster_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+						  unsigned long *parent_rate)
+{
+	struct apple_cluster_clk *cluster = to_apple_cluster_clk(hw);
+	struct dev_pm_opp *opp;
+
+	opp = dev_pm_opp_find_freq_floor(cluster->dev, &rate);
+
+	if (IS_ERR(opp)) {
+		dev_err(cluster->dev, "failed to find rate: %ld (%ld)\n", rate, PTR_ERR(opp));
+		return PTR_ERR(opp);
+	}
+
+	return rate;
+}
+
+static const struct clk_ops apple_cluster_clk_ops = {
+	.set_rate = apple_cluster_clk_set_rate,
+	.recalc_rate = apple_cluster_clk_recalc_rate,
+	.round_rate = apple_cluster_clk_round_rate,
+};
+
+static int apple_cluster_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct apple_cluster_clk *cluster;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	int ret;
+
+	memset(&init, 0, sizeof(init));
+	cluster = devm_kzalloc(dev, sizeof(*cluster), GFP_KERNEL);
+	if (!cluster)
+		return -ENOMEM;
+
+	cluster->dev = dev;
+	cluster->reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(cluster->reg_base))
+		return PTR_ERR(cluster->reg_base);
+
+	hw = &cluster->hw;
+	hw->init = &init;
+
+	init.name = pdev->name;
+	init.num_parents = 0;
+	init.ops = &apple_cluster_clk_ops;
+	init.flags = 0;
+
+	ret = dev_pm_opp_of_add_table_noclk(dev, 0);
+	if (ret < 0) {
+		dev_err(dev, "failed to get opp table\n");
+		return ret;
+	}
+
+	cluster->has_pd = of_property_read_bool(node, "power-domains");
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_clk_hw_register(dev, hw);
+	if (ret) {
+		dev_err(dev, "failed to register clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id apple_cluster_clk_of_match[] = {
+	{ .compatible = "apple,cluster-clk" },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, apple_cluster_clk_of_match);
+
+static struct platform_driver apple_cluster_clk_driver = {
+	.probe = apple_cluster_clk_probe,
+	.driver = {
+		.name = "apple-cluster-clk",
+		.of_match_table = apple_cluster_clk_of_match,
+	},
+};
+
+MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
+MODULE_DESCRIPTION("CPU cluster performance state driver for Apple SoCs");
+MODULE_LICENSE("GPL v2");
+
+module_platform_driver(apple_cluster_clk_driver);
-- 
2.33.0

