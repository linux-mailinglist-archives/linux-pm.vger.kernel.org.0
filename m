Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8A1D100CD4
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 21:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfKRUHB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 15:07:01 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40442 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfKRUFq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2019 15:05:46 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2so20470511ljg.7;
        Mon, 18 Nov 2019 12:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wKn468nr2i6h8sTr6Rg9z7srsP/1nTrJr4onSkFRhrM=;
        b=kS9P13J1QW1JVGirOuxzkZSSrTkvRd5gz+pkBjDezAm+TFqLpj76qjEcs+6hWwQsIc
         C3d3bq88qiGwpN8gW+c86t9UQweQ8KDB1DI3rj624TGhs5pY11X8EdeqJYpTPplAEg4c
         g848E01m3vPV2dSRqN/GLIAUvjEKL3+nNCUjPTNhslpoRweJiCOXUgClzhb7oVtN6e2j
         6m8ft1GrH8i60pJ0z4G5WlvRexuobXMHT+SZZCsHB8ow9gysf6iLORM094qTBqkBHfez
         zQ3XvoM1lEnVktiz+dv2ruNKF3Y22i1QeHlBf8nu0qVxoq0ztFASzDrTZ7KzGdKH2QYz
         +V1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wKn468nr2i6h8sTr6Rg9z7srsP/1nTrJr4onSkFRhrM=;
        b=IVpJ+Ibkxd+fHBftYNrA6kdwmZwIw7hR4C8v/jCD+wNdMJMFwjNf2Y6Zjf3XPKsYcP
         7u+Ju5E/avYo53g+RqndvOlXP1K3LxRsDPEZIGLWIdmHPvExhmOAkh+98f/q8WP6UZjq
         QKDcjSjlhgph7IrV3dQb7MX24+j8E0B9Jr6BFT17dS6HtTTaGpPfxLVS4Sla1XJXAlrA
         RO6n/CDkLrTvIiqw8wFaBewqgXEDzeL8Berx3AH81vRbNZONS5S1gijDi9suSwuiQUNV
         pwMHsktmVm3n1cQ19Rg5sgb/TXBPcBRxo8HvBjB14b6ehZE3oYh82wlQLAI5SXn7cTPc
         9GrQ==
X-Gm-Message-State: APjAAAXOpcq7rEw96WEjdKC/g9g7UdNIpnynjxVYpZMcqyoHA+mU38gs
        pNiw7OdT9U3CQacADfm3Hdg=
X-Google-Smtp-Source: APXvYqx0QO3LCy1M9cMqDrlT+1ew03n5115y0K6a1DhFS61aLBr5yTQ3ed/bTYOiow3sG8icwiTP0g==
X-Received: by 2002:a2e:5451:: with SMTP id y17mr915326ljd.98.1574107542862;
        Mon, 18 Nov 2019 12:05:42 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:42 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 12/29] interconnect: Add memory interconnection providers for NVIDIA Tegra SoCs
Date:   Mon, 18 Nov 2019 23:02:30 +0300
Message-Id: <20191118200247.3567-13-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118200247.3567-1-digetx@gmail.com>
References: <20191118200247.3567-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All NVIDIA Tegra SoCs have identical topology in regards to memory
interconnection between memory clients and memory controllers.
The memory controller (MC) and external memory controller (EMC) are
providing memory clients with required memory bandwidth. The memory
controller performs arbitration between memory clients, while the
external memory controller transfers data from/to DRAM and pipes that
data from/to memory controller. Memory controller interconnect provider
aggregates bandwidth requests from memory clients and sends the aggregated
request to EMC provider that scales DRAM frequency in order to satisfy the
bandwidth requirement. Memory controller provider could adjust hardware
configuration for a more optimal arbitration depending on bandwidth
requirements from memory clients, but this is unimplemented for now.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/interconnect/Kconfig               |   1 +
 drivers/interconnect/Makefile              |   1 +
 drivers/interconnect/tegra/Kconfig         |   6 +
 drivers/interconnect/tegra/Makefile        |   4 +
 drivers/interconnect/tegra/tegra-icc-emc.c | 138 +++++++++++++++++++++
 drivers/interconnect/tegra/tegra-icc-mc.c  | 130 +++++++++++++++++++
 include/soc/tegra/mc.h                     |  26 ++++
 7 files changed, 306 insertions(+)
 create mode 100644 drivers/interconnect/tegra/Kconfig
 create mode 100644 drivers/interconnect/tegra/Makefile
 create mode 100644 drivers/interconnect/tegra/tegra-icc-emc.c
 create mode 100644 drivers/interconnect/tegra/tegra-icc-mc.c

diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
index bfa4ca3ab7a9..b11ca09665bb 100644
--- a/drivers/interconnect/Kconfig
+++ b/drivers/interconnect/Kconfig
@@ -12,5 +12,6 @@ menuconfig INTERCONNECT
 if INTERCONNECT
 
 source "drivers/interconnect/qcom/Kconfig"
+source "drivers/interconnect/tegra/Kconfig"
 
 endif
diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index 28f2ab0824d5..a37d419e262c 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -4,3 +4,4 @@ icc-core-objs				:= core.o
 
 obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
 obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
+obj-$(CONFIG_INTERCONNECT_TEGRA)	+= tegra/
diff --git a/drivers/interconnect/tegra/Kconfig b/drivers/interconnect/tegra/Kconfig
new file mode 100644
index 000000000000..b724781da71e
--- /dev/null
+++ b/drivers/interconnect/tegra/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config INTERCONNECT_TEGRA
+	bool "NVIDIA Tegra interconnect drivers"
+	depends on ARCH_TEGRA || COMPILE_TEST
+	help
+	  Say Y here to enable support for NVIDIA Tegra interconnect drivers.
diff --git a/drivers/interconnect/tegra/Makefile b/drivers/interconnect/tegra/Makefile
new file mode 100644
index 000000000000..74ff2e53dbdc
--- /dev/null
+++ b/drivers/interconnect/tegra/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_INTERCONNECT_TEGRA) += tegra-icc-mc.o
+obj-$(CONFIG_INTERCONNECT_TEGRA) += tegra-icc-emc.o
diff --git a/drivers/interconnect/tegra/tegra-icc-emc.c b/drivers/interconnect/tegra/tegra-icc-emc.c
new file mode 100644
index 000000000000..b594ce811153
--- /dev/null
+++ b/drivers/interconnect/tegra/tegra-icc-emc.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Author: Dmitry Osipenko <digetx@gmail.com>
+ * Copyright (C) 2019 GRATE-DRIVER project
+ */
+
+#include <dt-bindings/interconnect/tegra-icc.h>
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/interconnect-provider.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+
+#include <soc/tegra/mc.h>
+
+struct tegra_emc_provider {
+	struct icc_provider provider;
+	struct clk *clk;
+	unsigned int dram_data_bus_width_bytes;
+};
+
+static inline struct tegra_emc_provider *
+to_tegra_emc_provider(struct icc_provider *provider)
+{
+	return container_of(provider, struct tegra_emc_provider, provider);
+}
+
+static struct icc_node *
+tegra_emc_of_icc_xlate_onecell(struct of_phandle_args *spec, void *data)
+{
+	struct icc_provider *provider = data;
+	struct icc_node *node;
+
+	list_for_each_entry(node, &provider->nodes, node_list) {
+		if (node->id == spec->args[0])
+			return node;
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int tegra_emc_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	struct tegra_emc_provider *emc = to_tegra_emc_provider(dst->provider);
+	unsigned long long rate = icc_units_to_bps(dst->avg_bw);
+	unsigned int ddr = 2;
+	int err;
+
+	do_div(rate, ddr * emc->dram_data_bus_width_bytes);
+	rate = min_t(u64, rate, U32_MAX);
+
+	err = clk_set_min_rate(emc->clk, rate);
+	if (err)
+		return err;
+
+	err = clk_set_rate(emc->clk, rate);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int tegra_emc_icc_aggregate(struct icc_node *node,
+				   u32 tag, u32 avg_bw, u32 peak_bw,
+				   u32 *agg_avg, u32 *agg_peak)
+{
+	*agg_avg = min((u64)avg_bw + (*agg_avg), (u64)U32_MAX);
+	*agg_peak = max(*agg_peak, peak_bw);
+
+	return 0;
+}
+
+int tegra_icc_emc_setup_interconnect(struct device *emc_dev,
+				     unsigned int dram_data_bus_width_bytes)
+{
+	struct tegra_emc_provider *emc;
+	struct icc_node *node, *tmp;
+	int err;
+
+	emc = devm_kzalloc(emc_dev, sizeof(*emc), GFP_KERNEL);
+	if (!emc)
+		return -ENOMEM;
+
+	emc->clk = devm_clk_get(emc_dev, "emc");
+	err = PTR_ERR_OR_ZERO(emc->clk);
+	if (err)
+		return err;
+
+	emc->dram_data_bus_width_bytes = dram_data_bus_width_bytes;
+
+	emc->provider.dev = emc_dev;
+	emc->provider.set = tegra_emc_icc_set;
+	emc->provider.data = &emc->provider;
+	emc->provider.xlate = tegra_emc_of_icc_xlate_onecell;
+	emc->provider.aggregate = tegra_emc_icc_aggregate;
+
+	err = icc_provider_add(&emc->provider);
+	if (err)
+		return err;
+
+	/* create External Memory Controller node */
+	node = icc_node_create(TEGRA_ICC_EMC);
+	err = PTR_ERR_OR_ZERO(node);
+	if (err)
+		goto del_provider;
+
+	node->name = "EMC";
+	icc_node_add(node, &emc->provider);
+
+	/* link External Memory Controller with External Memory */
+	err = icc_link_create(node, TEGRA_ICC_EMEM);
+	if (err)
+		goto destroy_nodes;
+
+	/* create External Memory node */
+	node = icc_node_create(TEGRA_ICC_EMEM);
+	err = PTR_ERR_OR_ZERO(node);
+	if (err)
+		goto destroy_nodes;
+
+	node->name = "EMEM";
+	icc_node_add(node, &emc->provider);
+
+	return 0;
+
+destroy_nodes:
+	list_for_each_entry_safe(node, tmp, &emc->provider.nodes, node_list) {
+		icc_node_del(node);
+		icc_node_destroy(node->id);
+	}
+
+del_provider:
+	icc_provider_del(&emc->provider);
+
+	return err;
+}
diff --git a/drivers/interconnect/tegra/tegra-icc-mc.c b/drivers/interconnect/tegra/tegra-icc-mc.c
new file mode 100644
index 000000000000..f1ff8f98def3
--- /dev/null
+++ b/drivers/interconnect/tegra/tegra-icc-mc.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Author: Dmitry Osipenko <digetx@gmail.com>
+ * Copyright (C) 2019 GRATE-DRIVER project
+ */
+
+#include <dt-bindings/interconnect/tegra-icc.h>
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/interconnect-provider.h>
+#include <linux/of.h>
+
+#include <soc/tegra/mc.h>
+
+static struct icc_node *
+tegra_mc_of_icc_xlate_onecell(struct of_phandle_args *spec, void *data)
+{
+	struct icc_provider *provider = data;
+	struct icc_node *node;
+
+	list_for_each_entry(node, &provider->nodes, node_list) {
+		if (node->id == spec->args[0])
+			return node;
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int tegra_mc_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	return 0;
+}
+
+static int tegra_mc_icc_aggregate(struct icc_node *node,
+				  u32 tag, u32 avg_bw, u32 peak_bw,
+				  u32 *agg_avg, u32 *agg_peak)
+{
+	*agg_avg = min((u64)avg_bw + (*agg_avg), (u64)U32_MAX);
+	*agg_peak = max(*agg_peak, peak_bw);
+
+	return 0;
+}
+
+/*
+ * Memory Controller (MC) has few Memory Clients that are issuing memory
+ * bandwidth allocation requests to the MC interconnect provider. The MC
+ * provider aggregates the requests and then sends the aggregated request
+ * up to the External Memory Controller (EMC) interconnect provider which
+ * re-configures hardware interface to External Memory (EMEM) in accordance
+ * to the required bandwidth.
+ *
+ * Memory interconnect topology:
+ *
+ *               +----+
+ *   +-----+     |    |
+ *   | GPU +---->+    |
+ *   +-----+     |    |
+ *               |    |     +-----+     +------+
+ *    ...        | MC +---->+ EMC +---->+ EMEM |
+ *               |    |     +-----+     +------+
+ *  +------+     |    |
+ *  | DISP +---->+    |
+ *  +------+     |    |
+ *               +----+
+ */
+int tegra_icc_mc_setup_interconnect(struct tegra_mc *mc)
+{
+	struct icc_provider *provider;
+	struct icc_node *node, *tmp;
+	unsigned int i;
+	int err;
+
+	provider = devm_kzalloc(mc->dev, sizeof(*provider), GFP_KERNEL);
+	if (!provider)
+		return -ENOMEM;
+
+	provider->dev = mc->dev;
+	provider->set = tegra_mc_icc_set;
+	provider->data = provider;
+	provider->xlate = tegra_mc_of_icc_xlate_onecell;
+	provider->aggregate = tegra_mc_icc_aggregate;
+
+	err = icc_provider_add(provider);
+	if (err)
+		return err;
+
+	/* create Memory Controller node */
+	node = icc_node_create(TEGRA_ICC_MC);
+	err = PTR_ERR_OR_ZERO(node);
+	if (err)
+		goto del_provider;
+
+	node->name = "MC";
+	icc_node_add(node, provider);
+
+	/* link Memory Controller with External Memory Controller */
+	err = icc_link_create(node, TEGRA_ICC_EMC);
+	if (err)
+		goto destroy_nodes;
+
+	for (i = 0; i < mc->soc->num_icc_nodes; i++) {
+		/* create MC client node */
+		node = icc_node_create(mc->soc->icc_nodes[i].id);
+		err = PTR_ERR_OR_ZERO(node);
+		if (err)
+			goto destroy_nodes;
+
+		node->name = mc->soc->icc_nodes[i].name;
+		icc_node_add(node, provider);
+
+		/* link Memory Client with Memory Controller */
+		err = icc_link_create(node, TEGRA_ICC_MC);
+		if (err)
+			goto destroy_nodes;
+	}
+
+	return 0;
+
+destroy_nodes:
+	list_for_each_entry_safe(node, tmp, &provider->nodes, node_list) {
+		icc_node_del(node);
+		icc_node_destroy(node->id);
+	}
+
+del_provider:
+	icc_provider_del(provider);
+
+	return err;
+}
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 1238e35653d1..593954324259 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -141,6 +141,11 @@ struct tegra_mc_reset_ops {
 			    const struct tegra_mc_reset *rst);
 };
 
+struct tegra_mc_icc_node {
+	const char *name;
+	unsigned int id;
+};
+
 struct tegra_mc_soc {
 	const struct tegra_mc_client *clients;
 	unsigned int num_clients;
@@ -160,6 +165,9 @@ struct tegra_mc_soc {
 	const struct tegra_mc_reset_ops *reset_ops;
 	const struct tegra_mc_reset *resets;
 	unsigned int num_resets;
+
+	const struct tegra_mc_icc_node *icc_nodes;
+	unsigned int num_icc_nodes;
 };
 
 struct tegra_mc {
@@ -184,4 +192,22 @@ struct tegra_mc {
 int tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long rate);
 unsigned int tegra_mc_get_emem_device_count(struct tegra_mc *mc);
 
+#ifdef CONFIG_INTERCONNECT_TEGRA
+int tegra_icc_mc_setup_interconnect(struct tegra_mc *mc);
+int tegra_icc_emc_setup_interconnect(struct device *emc_dev,
+				     unsigned int dram_data_bus_width_bytes);
+#else
+static inline int tegra_icc_mc_setup_interconnect(struct tegra_mc *mc);
+{
+	return 0;
+}
+
+static inline int
+tegra_icc_emc_setup_interconnect(struct device *emc_dev,
+				 unsigned int dram_data_bus_width_bytes)
+{
+	return 0;
+}
+#endif
+
 #endif /* __SOC_TEGRA_MC_H__ */
-- 
2.23.0

