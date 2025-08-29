Return-Path: <linux-pm+bounces-33360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1BFB3B1DE
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 06:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8691B27FBD
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 04:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BDF227E82;
	Fri, 29 Aug 2025 04:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYkb/zHe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632EE21CC6A;
	Fri, 29 Aug 2025 04:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440093; cv=none; b=SbOeGJmRkuVemWs7LCbLpI9GFw6ljzL8eOde6Vwr5RR+6xFnUNcXyF5BCUEom/1xIT0OzG1WtUy5oLu6BgJDLW2X2F4VjaxjRUkCGn5SQH3LjokXYH5ffa72qhDRbKtQOfh4swEJzYB6vX6sWakZ7QIv9gX3/Wwg0W75EqYRfXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440093; c=relaxed/simple;
	bh=MERXsoEUodhweJb4Tbi551odD0Siv4fe2oAahFFP0Oo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CEHaY9z2AxtACUG3UdPCstlzVatNYJg3DYFf2guAeJugdPJtlnq+6tVNz1Jy1ItJznLUl4cqW75GS/dNEeAj+/wqon64iz1hWSJcY9F8B0xV8X59COBc+6GsdnY/gt1Jon77QrC0wjObE68DkTEhe+H4mpMeaCEexO4jMlR/MXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYkb/zHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBED6C4CEFD;
	Fri, 29 Aug 2025 04:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756440092;
	bh=MERXsoEUodhweJb4Tbi551odD0Siv4fe2oAahFFP0Oo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JYkb/zHea72EYVi1syHAq+sgGEnzB8HVTAox97VvaBjyfYEHK9e2uz9HqTqKb4TGu
	 ocVM/zf8/HyPbPo0G+DxXrcpEEcXp9IOThmpooBO9nDMBEzgzwZwomD2zMaqGNBR1c
	 Wz7cAgdf2DbG2g0PZNnR+mSBdqIoNsltbUiohk78RczSkl9meSacW1UA62HDva0lZt
	 aDtJ+TXswVewbZUTfUlnRjHpRsy/n+TCI5peUUWl8IkLOjFJIea7kLjexgnSOJJlGR
	 ++xcYXx3zRcgY4rt9fOaX34unvHvwURISTnO2OGP+ProKb/F07vziHkvtT3PxwkA0o
	 GoxSbdYZx8H7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1885CA0FFE;
	Fri, 29 Aug 2025 04:01:32 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Thu, 28 Aug 2025 23:01:30 -0500
Subject: [PATCH RFC 4/7] memory: tegra210: Support interconnect framework
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-t210-actmon-v1-4-aeb19ec1f244@gmail.com>
References: <20250828-t210-actmon-v1-0-aeb19ec1f244@gmail.com>
In-Reply-To: <20250828-t210-actmon-v1-0-aeb19ec1f244@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Osipenko <digetx@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756440091; l=15478;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=SnjAIVksjduuEmYYRoSdY0xIqNDYLKcJPNWEnKh6lvU=;
 b=pDbGwhN2YmuuIgvRNFKapDLzbVbVFFxodp7A2mzIK2YkDEPvWZryRYUk5RPIMrzGZqrPqmKsz
 0a5Xpd6rVJaCtlqqKSm1nek2kUSkkFKXw/qQWLuqgm3ccIVH+AsJHKX
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

This makes mc and emc interconnect providers and allows for dynamic
memory clock scaling.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/memory/tegra/Kconfig             |   1 +
 drivers/memory/tegra/tegra210-emc-core.c | 276 ++++++++++++++++++++++++++++++-
 drivers/memory/tegra/tegra210-emc.h      |  25 +++
 drivers/memory/tegra/tegra210.c          |  81 +++++++++
 4 files changed, 381 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
index fc5a277918267ee8240f9fb9efeb80275db4790b..2d0be29afe2b9ebf9a0630ef7fb6fb43ff359499 100644
--- a/drivers/memory/tegra/Kconfig
+++ b/drivers/memory/tegra/Kconfig
@@ -55,6 +55,7 @@ config TEGRA210_EMC
 	tristate "NVIDIA Tegra210 External Memory Controller driver"
 	depends on ARCH_TEGRA_210_SOC || COMPILE_TEST
 	select TEGRA210_EMC_TABLE
+	select PM_OPP
 	help
 	  This driver is for the External Memory Controller (EMC) found on
 	  Tegra210 chips. The EMC controls the external DRAM on the board.
diff --git a/drivers/memory/tegra/tegra210-emc-core.c b/drivers/memory/tegra/tegra210-emc-core.c
index e96ca4157d48182574310f8caf72687bed7cc16a..b2ae35353ff5e0059b2ec5ab719c55b23b05bb6a 100644
--- a/drivers/memory/tegra/tegra210-emc-core.c
+++ b/drivers/memory/tegra/tegra210-emc-core.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/slab.h>
 #include <linux/thermal.h>
 #include <soc/tegra/fuse.h>
@@ -1569,6 +1570,79 @@ static int tegra210_emc_set_rate(struct device *dev,
 	return 0;
 }
 
+static void tegra_emc_rate_requests_init(struct tegra210_emc *emc)
+{
+	unsigned int i;
+
+	for (i = 0; i < EMC_RATE_TYPE_MAX; i++) {
+		emc->requested_rate[i].min_rate = 0;
+		emc->requested_rate[i].max_rate = ULONG_MAX;
+	}
+}
+
+static int emc_request_rate(struct tegra210_emc *emc,
+			    unsigned long new_min_rate,
+			    unsigned long new_max_rate,
+			    enum emc_rate_request_type type)
+{
+	struct emc_rate_request *req = emc->requested_rate;
+	unsigned long min_rate = 0, max_rate = ULONG_MAX;
+	unsigned int i;
+	int err;
+
+	/* select minimum and maximum rates among the requested rates */
+	for (i = 0; i < EMC_RATE_TYPE_MAX; i++, req++) {
+		if (i == type) {
+			min_rate = max(new_min_rate, min_rate);
+			max_rate = min(new_max_rate, max_rate);
+		} else {
+			min_rate = max(req->min_rate, min_rate);
+			max_rate = min(req->max_rate, max_rate);
+		}
+	}
+
+	if (min_rate > max_rate) {
+		dev_err_ratelimited(emc->dev, "%s: type %u: out of range: %lu %lu\n",
+				    __func__, type, min_rate, max_rate);
+		return -ERANGE;
+	}
+
+	err = clk_set_rate(emc->clk, min_rate);
+	if (err)
+		return err;
+
+	emc->requested_rate[type].min_rate = new_min_rate;
+	emc->requested_rate[type].max_rate = new_max_rate;
+
+	return 0;
+}
+
+static int emc_set_min_rate(struct tegra210_emc *emc, unsigned long rate,
+			    enum emc_rate_request_type type)
+{
+	struct emc_rate_request *req = &emc->requested_rate[type];
+	int ret;
+
+	mutex_lock(&emc->rate_lock);
+	ret = emc_request_rate(emc, rate, req->max_rate, type);
+	mutex_unlock(&emc->rate_lock);
+
+	return ret;
+}
+
+static int emc_set_max_rate(struct tegra210_emc *emc, unsigned long rate,
+			    enum emc_rate_request_type type)
+{
+	struct emc_rate_request *req = &emc->requested_rate[type];
+	int ret;
+
+	mutex_lock(&emc->rate_lock);
+	ret = emc_request_rate(emc, req->min_rate, rate, type);
+	mutex_unlock(&emc->rate_lock);
+
+	return ret;
+}
+
 /*
  * debugfs interface
  *
@@ -1641,7 +1715,7 @@ static int tegra210_emc_debug_min_rate_set(void *data, u64 rate)
 	if (!tegra210_emc_validate_rate(emc, rate))
 		return -EINVAL;
 
-	err = clk_set_min_rate(emc->clk, rate);
+	err = emc_set_min_rate(emc, rate, EMC_RATE_DEBUG);
 	if (err < 0)
 		return err;
 
@@ -1671,7 +1745,7 @@ static int tegra210_emc_debug_max_rate_set(void *data, u64 rate)
 	if (!tegra210_emc_validate_rate(emc, rate))
 		return -EINVAL;
 
-	err = clk_set_max_rate(emc->clk, rate);
+	err = emc_set_max_rate(emc, rate, EMC_RATE_DEBUG);
 	if (err < 0)
 		return err;
 
@@ -1758,6 +1832,188 @@ static void tegra210_emc_debugfs_init(struct tegra210_emc *emc)
 			    &tegra210_emc_debug_temperature_fops);
 }
 
+static inline struct tegra210_emc *
+to_tegra210_emc_provider(struct icc_provider *provider)
+{
+	return container_of(provider, struct tegra210_emc, icc_provider);
+}
+
+static struct icc_node_data *
+emc_of_icc_xlate_extended(const struct of_phandle_args *spec, void *data)
+{
+	struct icc_provider *provider = data;
+	struct icc_node_data *ndata;
+	struct icc_node *node;
+
+	/* External Memory is the only possible ICC route */
+	list_for_each_entry(node, &provider->nodes, node_list) {
+		if (node->id != TEGRA_ICC_EMEM)
+			continue;
+
+		ndata = kzalloc(sizeof(*ndata), GFP_KERNEL);
+		if (!ndata)
+			return ERR_PTR(-ENOMEM);
+
+		/*
+		 * SRC and DST nodes should have matching TAG in order to have
+		 * it set by default for a requested path.
+		 */
+		ndata->tag = TEGRA_MC_ICC_TAG_ISO;
+		ndata->node = node;
+
+		return ndata;
+	}
+
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
+static int emc_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	struct tegra210_emc *emc = to_tegra210_emc_provider(dst->provider);
+	unsigned long long peak_bw = icc_units_to_bps(dst->peak_bw);
+	unsigned long long avg_bw = icc_units_to_bps(dst->avg_bw);
+	unsigned long long rate = max(avg_bw, peak_bw);
+	unsigned int dram_data_bus_width_bytes;
+	const unsigned int ddr = 2;
+	int err;
+
+	/*
+	 * Tegra210 EMC runs on a clock rate of SDRAM bus. This means that
+	 * EMC clock rate is twice smaller than the peak data rate because
+	 * data is sampled on both EMC clock edges.
+	 */
+	dram_data_bus_width_bytes = emc->dram_bus_width / 8;
+	do_div(rate, ddr * dram_data_bus_width_bytes);
+	rate = min_t(u64, rate, U32_MAX);
+
+	err = emc_set_min_rate(emc, rate, EMC_RATE_ICC);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int tegra_emc_icc_get_init_bw(struct icc_node *node, u32 *avg, u32 *peak)
+{
+	*avg = 0;
+	*peak = 0;
+
+	return 0;
+}
+
+static int tegra_emc_interconnect_init(struct tegra210_emc *emc)
+{
+	const struct tegra_mc_soc *soc = emc->mc->soc;
+	struct icc_node *node;
+	int err;
+
+	emc->icc_provider.dev = emc->dev;
+	emc->icc_provider.set = emc_icc_set;
+	emc->icc_provider.data = &emc->icc_provider;
+	emc->icc_provider.aggregate = soc->icc_ops->aggregate;
+	emc->icc_provider.xlate_extended = emc_of_icc_xlate_extended;
+	emc->icc_provider.get_bw = tegra_emc_icc_get_init_bw;
+
+	icc_provider_init(&emc->icc_provider);
+
+	/* create External Memory Controller node */
+	node = icc_node_create(TEGRA_ICC_EMC);
+	if (IS_ERR(node)) {
+		err = PTR_ERR(node);
+		goto err_msg;
+	}
+
+	node->name = "External Memory Controller";
+	icc_node_add(node, &emc->icc_provider);
+
+	/* link External Memory Controller to External Memory (DRAM) */
+	err = icc_link_create(node, TEGRA_ICC_EMEM);
+	if (err)
+		goto remove_nodes;
+
+	/* create External Memory node */
+	node = icc_node_create(TEGRA_ICC_EMEM);
+	if (IS_ERR(node)) {
+		err = PTR_ERR(node);
+		goto remove_nodes;
+	}
+
+	node->name = "External Memory (DRAM)";
+	icc_node_add(node, &emc->icc_provider);
+
+	err = icc_provider_register(&emc->icc_provider);
+	if (err)
+		goto remove_nodes;
+
+	return 0;
+
+remove_nodes:
+	icc_nodes_remove(&emc->icc_provider);
+err_msg:
+	dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
+
+	return err;
+}
+
+static int tegra_emc_opp_table_init(struct tegra210_emc *emc)
+{
+	u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
+	struct dev_pm_opp *opp;
+	unsigned long rate;
+	int opp_token, err, max_opps, i;
+
+	err = dev_pm_opp_set_supported_hw(emc->dev, &hw_version, 1);
+	if (err < 0) {
+		dev_err(emc->dev, "failed to set OPP supported HW: %d\n", err);
+		return err;
+	}
+	opp_token = err;
+
+	err = dev_pm_opp_of_add_table(emc->dev);
+	if (err) {
+		if (err == -ENODEV)
+			dev_err(emc->dev, "OPP table not found, please update your device tree\n");
+		else
+			dev_err(emc->dev, "failed to add OPP table: %d\n", err);
+
+		goto put_hw_table;
+	}
+
+	max_opps = dev_pm_opp_get_opp_count(emc->dev);
+	if (max_opps <= 0) {
+		dev_err(emc->dev, "Failed to add OPPs\n");
+		goto remove_table;
+	}
+
+	if (emc->num_timings != max_opps) {
+		dev_err(emc->dev, "OPP table does not match emc table\n");
+		goto remove_table;
+	}
+
+	for (i = 0; i < emc->num_timings; i++) {
+		rate = emc->timings[i].rate * 1000;
+		opp = dev_pm_opp_find_freq_exact(emc->dev, rate, true);
+		if (IS_ERR(opp)) {
+			dev_err(emc->dev, "Rate %lu not found in OPP table\n", rate);
+			goto remove_table;
+		}
+
+		dev_pm_opp_put(opp);
+	}
+
+	dev_info_once(emc->dev, "OPP HW ver. 0x%x, current clock rate %lu MHz\n",
+		      hw_version, clk_get_rate(emc->clk) / 1000000);
+
+	return 0;
+
+remove_table:
+	dev_pm_opp_of_remove_table(emc->dev);
+put_hw_table:
+	dev_pm_opp_put_supported_hw(opp_token);
+
+	return err;
+}
+
 static void tegra210_emc_detect(struct tegra210_emc *emc)
 {
 	u32 value;
@@ -1774,6 +2030,13 @@ static void tegra210_emc_detect(struct tegra210_emc *emc)
 	value = emc_readl(emc, EMC_FBIO_CFG5);
 	emc->dram_type = value & 0x3;
 
+	if (value & EMC_FBIO_CFG5_DRAM_WIDTH_X64)
+		emc->dram_bus_width = 64;
+	else
+		emc->dram_bus_width = 32;
+
+	dev_info_once(emc->dev, "%ubit DRAM bus\n", emc->dram_bus_width);
+
 	/* probe the number of channels */
 	value = emc_readl(emc, EMC_FBIO_CFG7);
 
@@ -1964,8 +2227,16 @@ static int tegra210_emc_probe(struct platform_device *pdev)
 
 	timer_setup(&emc->training, tegra210_emc_train, 0);
 
+	err = tegra_emc_opp_table_init(emc);
+	if (err)
+		return err;
+
+	tegra_emc_rate_requests_init(emc);
+
 	tegra210_emc_debugfs_init(emc);
 
+	tegra_emc_interconnect_init(emc);
+
 	cd = devm_thermal_of_cooling_device_register(emc->dev, np, "emc", emc,
 						     &tegra210_emc_cd_ops);
 	if (IS_ERR(cd)) {
@@ -2050,6 +2321,7 @@ static struct platform_driver tegra210_emc_driver = {
 		.name = "tegra210-emc",
 		.of_match_table = tegra210_emc_of_match,
 		.pm = &tegra210_emc_pm_ops,
+		.sync_state = icc_sync_state,
 	},
 	.probe = tegra210_emc_probe,
 	.remove = tegra210_emc_remove,
diff --git a/drivers/memory/tegra/tegra210-emc.h b/drivers/memory/tegra/tegra210-emc.h
index 8988bcf1529072a7bdc93b185ebe0d51d82c1763..270362268c557056fa9bccea0f228c08630411ae 100644
--- a/drivers/memory/tegra/tegra210-emc.h
+++ b/drivers/memory/tegra/tegra210-emc.h
@@ -8,6 +8,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk/tegra.h>
+#include <linux/interconnect-provider.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
 
@@ -105,6 +106,7 @@
 #define EMC_FBIO_CFG5_DRAM_TYPE_SHIFT				0
 #define EMC_FBIO_CFG5_DRAM_TYPE_MASK				\
 	(0x3 << EMC_FBIO_CFG5_DRAM_TYPE_SHIFT)
+#define EMC_FBIO_CFG5_DRAM_WIDTH_X64				BIT(4)
 #define EMC_FBIO_CFG5_CMD_TX_DIS				BIT(8)
 
 #define EMC_PDEX2CKE						0x118
@@ -784,6 +786,17 @@ enum {
 #define TRIM_REGS_SIZE 138
 #define BURST_REGS_SIZE 221
 
+enum emc_rate_request_type {
+	EMC_RATE_DEBUG,
+	EMC_RATE_ICC,
+	EMC_RATE_TYPE_MAX,
+};
+
+struct emc_rate_request {
+	unsigned long min_rate;
+	unsigned long max_rate;
+};
+
 struct tegra210_emc_per_channel_regs {
 	u16 bank;
 	u16 offset;
@@ -906,6 +919,7 @@ struct tegra210_emc {
 	unsigned int num_channels;
 	unsigned int num_devices;
 	unsigned int dram_type;
+	unsigned int dram_bus_width;
 
 	struct tegra210_emc_timing *last;
 	struct tegra210_emc_timing *next;
@@ -932,6 +946,17 @@ struct tegra210_emc {
 	} debugfs;
 
 	struct tegra210_clk_emc_provider provider;
+
+	struct icc_provider icc_provider;
+
+	/*
+	 * There are multiple sources in the EMC driver which could request
+	 * a min/max clock rate, these rates are contained in this array.
+	 */
+	struct emc_rate_request requested_rate[EMC_RATE_TYPE_MAX];
+
+	/* protect shared rate-change code path */
+	struct mutex rate_lock;
 };
 
 struct tegra210_emc_sequence {
diff --git a/drivers/memory/tegra/tegra210.c b/drivers/memory/tegra/tegra210.c
index 8ab6498dbe7d2f410d4eb262926c18b77edb0b3d..c5f079b60363f86b9b1382182e71bfcea9e19829 100644
--- a/drivers/memory/tegra/tegra210.c
+++ b/drivers/memory/tegra/tegra210.c
@@ -3,6 +3,9 @@
  * Copyright (C) 2015 NVIDIA CORPORATION.  All rights reserved.
  */
 
+#include <linux/of.h>
+#include <linux/device.h>
+
 #include <dt-bindings/memory/tegra210-mc.h>
 
 #include "mc.h"
@@ -1273,6 +1276,83 @@ static const struct tegra_mc_reset tegra210_mc_resets[] = {
 	TEGRA210_MC_RESET(TSECB,     0x970, 0x974, 13),
 };
 
+static int tegra210_mc_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	/* TODO: program PTSA */
+	return 0;
+}
+
+static int tegra210_mc_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+				     u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	/*
+	 * ISO clients need to reserve extra bandwidth up-front because
+	 * there could be high bandwidth pressure during initial filling
+	 * of the client's FIFO buffers.  Secondly, we need to take into
+	 * account impurities of the memory subsystem.
+	 */
+	if (tag & TEGRA_MC_ICC_TAG_ISO)
+		peak_bw = tegra_mc_scale_percents(peak_bw, 400);
+
+	*agg_avg += avg_bw;
+	*agg_peak = max(*agg_peak, peak_bw);
+
+	return 0;
+}
+
+static struct icc_node_data *
+tegra210_mc_of_icc_xlate_extended(const struct of_phandle_args *spec, void *data)
+{
+	struct tegra_mc *mc = icc_provider_to_tegra_mc(data);
+	const struct tegra_mc_client *client;
+	unsigned int i, idx = spec->args[0];
+	struct icc_node_data *ndata;
+	struct icc_node *node;
+
+	list_for_each_entry(node, &mc->provider.nodes, node_list) {
+		if (node->id != idx)
+			continue;
+
+		ndata = kzalloc(sizeof(*ndata), GFP_KERNEL);
+		if (!ndata)
+			return ERR_PTR(-ENOMEM);
+
+		client = &mc->soc->clients[idx];
+		ndata->node = node;
+
+		switch (client->swgroup) {
+		case TEGRA_SWGROUP_DC:
+		case TEGRA_SWGROUP_DCB:
+		case TEGRA_SWGROUP_PTC:
+		case TEGRA_SWGROUP_VI:
+			/* these clients are isochronous by default */
+			ndata->tag = TEGRA_MC_ICC_TAG_ISO;
+			break;
+
+		default:
+			ndata->tag = TEGRA_MC_ICC_TAG_DEFAULT;
+			break;
+		}
+
+		return ndata;
+	}
+
+	for (i = 0; i < mc->soc->num_clients; i++) {
+		if (mc->soc->clients[i].id == idx)
+			return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	dev_err(mc->dev, "invalid ICC client ID %u\n", idx);
+
+	return ERR_PTR(-EINVAL);
+}
+
+static const struct tegra_mc_icc_ops tegra210_mc_icc_ops = {
+	.xlate_extended = tegra210_mc_of_icc_xlate_extended,
+	.aggregate = tegra210_mc_icc_aggregate,
+	.set = tegra210_mc_icc_set,
+};
+
 const struct tegra_mc_soc tegra210_mc_soc = {
 	.clients = tegra210_mc_clients,
 	.num_clients = ARRAY_SIZE(tegra210_mc_clients),
@@ -1286,5 +1366,6 @@ const struct tegra_mc_soc tegra210_mc_soc = {
 	.reset_ops = &tegra_mc_reset_ops_common,
 	.resets = tegra210_mc_resets,
 	.num_resets = ARRAY_SIZE(tegra210_mc_resets),
+	.icc_ops = &tegra210_mc_icc_ops,
 	.ops = &tegra30_mc_ops,
 };

-- 
2.50.1



