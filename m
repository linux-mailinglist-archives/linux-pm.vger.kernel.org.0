Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565FD2A6A85
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbgKDQvV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731710AbgKDQuW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:50:22 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43005C0613D3;
        Wed,  4 Nov 2020 08:50:22 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id 184so28007207lfd.6;
        Wed, 04 Nov 2020 08:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dwM+BH63iFB6NT97t3rk8gXNpTHb4QcSkO89Wg0FDqo=;
        b=PKWZw32IWFFPBHrJWLiH3QMniRI5HZXDHH1uO33hvMmwuL5NkiA71A5Xyg1SuQdNjK
         dyvecGA5QBJWO+Wzkqt5AvetPtk9gXntHF1e97q2EFDJjnQgkm1lDRQkU7shulEphk0m
         5Md1sYerqa1FhXKPM/HL6OISpc2nhWPytszfCy4tKqhGBdx1oyHOO05iBFHMv9dsBsiD
         Id7+qldbCl5NN3fS2/Alc1Y1GOQqVi3JIxEMeOELs4NKiDaPt10Fx49hEsx59uS/1F8V
         oftP2Ui6kn7KgMn1tsGeS80mRnFR3otKd0USGNhhadVvEnGYRVTWyj4IQl7tsnBnR6s9
         r9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dwM+BH63iFB6NT97t3rk8gXNpTHb4QcSkO89Wg0FDqo=;
        b=pGRYG7DJtskEZ0RgbBq1YKUi4M0Lpi+QLaHb3Zt03H0OLWn7Ef4rhIn1/QXFHFq2lp
         qs50LNk6Zp5ajVnIiZT9LPIwsj+NFzOmK1asSH0ftMJS+nNrBfHBX/+bae9qJKchFa7B
         K53TDvKBV0z1S3jt0H3cZyiTeoaMfsVYZRQJAyl7Gp27tweBABdW++7EB0T35qEdMJWB
         53A5bsCXatf9AhCXuPTTDhNvkDL4mL3T3s2wFWig8jomGK1Gn0sKqEhfX3a8XsirljjE
         QTpekLICezjEndNYnn2TbS3fa7SQX6IB+HoyPiBKDXd49oZGI0oxNQGlVKicoqaeg27s
         IcCA==
X-Gm-Message-State: AOAM530kh6i5j1muwaq18xc5QAa23EHs05bym0VNDy78uHszeqN3AlO5
        p85P15AVPIkKPzoWjorkM255ULmBKEU=
X-Google-Smtp-Source: ABdhPJwTeJVX8tXUs2moF68+OM+fRykRqSq9Ie0wMPjfFUqXtRd2yMc0IbwCuNLgLMrKT4FmQLrs2w==
X-Received: by 2002:ac2:4465:: with SMTP id y5mr9557952lfl.437.1604508620660;
        Wed, 04 Nov 2020 08:50:20 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:50:20 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 42/47] memory: tegra124: Support interconnect framework
Date:   Wed,  4 Nov 2020 19:49:18 +0300
Message-Id: <20201104164923.21238-43-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now Internal and External memory controllers are memory interconnection
providers. This allows us to use interconnect API for tuning of memory
configuration. EMC driver now supports OPPs and DVFS.

Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/Kconfig        |   1 +
 drivers/memory/tegra/tegra124-emc.c | 325 +++++++++++++++++++++++++++-
 drivers/memory/tegra/tegra124.c     |  82 ++++++-
 3 files changed, 396 insertions(+), 12 deletions(-)

diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
index b5824c6cf664..7c3c6467b9db 100644
--- a/drivers/memory/tegra/Kconfig
+++ b/drivers/memory/tegra/Kconfig
@@ -36,6 +36,7 @@ config TEGRA124_EMC
 	tristate "NVIDIA Tegra124 External Memory Controller driver"
 	default y
 	depends on TEGRA_MC && ARCH_TEGRA_124_SOC
+	select PM_OPP
 	help
 	  This driver is for the External Memory Controller (EMC) found on
 	  Tegra124 chips. The EMC controls the external DRAM on the board.
diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index edfbf6d6d357..0cc4efbce975 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -12,20 +12,26 @@
 #include <linux/clk/tegra.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
+#include <linux/interconnect-provider.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/sort.h>
 #include <linux/string.h>
 
 #include <soc/tegra/fuse.h>
 #include <soc/tegra/mc.h>
 
+#include "mc.h"
+
 #define EMC_FBIO_CFG5				0x104
 #define	EMC_FBIO_CFG5_DRAM_TYPE_MASK		0x3
 #define	EMC_FBIO_CFG5_DRAM_TYPE_SHIFT		0
+#define EMC_FBIO_CFG5_DRAM_WIDTH_X64		BIT(4)
 
 #define EMC_INTSTATUS				0x0
 #define EMC_INTSTATUS_CLKCHANGE_COMPLETE	BIT(4)
@@ -461,6 +467,17 @@ struct emc_timing {
 	u32 emc_zcal_interval;
 };
 
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
 struct tegra_emc {
 	struct device *dev;
 
@@ -471,6 +488,7 @@ struct tegra_emc {
 	struct clk *clk;
 
 	enum emc_dram_type dram_type;
+	unsigned int dram_bus_width;
 	unsigned int dram_num;
 
 	struct emc_timing last_timing;
@@ -482,6 +500,17 @@ struct tegra_emc {
 		unsigned long min_rate;
 		unsigned long max_rate;
 	} debugfs;
+
+	struct icc_provider provider;
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
 
 /* Timing change sequence functions */
@@ -870,6 +899,14 @@ static void emc_read_current_timing(struct tegra_emc *emc,
 static int emc_init(struct tegra_emc *emc)
 {
 	emc->dram_type = readl(emc->regs + EMC_FBIO_CFG5);
+
+	if (emc->dram_type & EMC_FBIO_CFG5_DRAM_WIDTH_X64)
+		emc->dram_bus_width = 64;
+	else
+		emc->dram_bus_width = 32;
+
+	dev_info(emc->dev, "%ubit DRAM bus\n", emc->dram_bus_width);
+
 	emc->dram_type &= EMC_FBIO_CFG5_DRAM_TYPE_MASK;
 	emc->dram_type >>= EMC_FBIO_CFG5_DRAM_TYPE_SHIFT;
 
@@ -1009,6 +1046,83 @@ tegra_emc_find_node_by_ram_code(struct device_node *node, u32 ram_code)
 	return NULL;
 }
 
+static void tegra_emc_rate_requests_init(struct tegra_emc *emc)
+{
+	unsigned int i;
+
+	for (i = 0; i < EMC_RATE_TYPE_MAX; i++) {
+		emc->requested_rate[i].min_rate = 0;
+		emc->requested_rate[i].max_rate = ULONG_MAX;
+	}
+}
+
+static int emc_request_rate(struct tegra_emc *emc,
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
+	/*
+	 * EMC rate-changes should go via OPP API because it manages voltage
+	 * changes.
+	 */
+	err = dev_pm_opp_set_rate(emc->dev, min_rate);
+	if (err)
+		return err;
+
+	emc->requested_rate[type].min_rate = new_min_rate;
+	emc->requested_rate[type].max_rate = new_max_rate;
+
+	return 0;
+}
+
+static int emc_set_min_rate(struct tegra_emc *emc, unsigned long rate,
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
+static int emc_set_max_rate(struct tegra_emc *emc, unsigned long rate,
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
@@ -1081,7 +1195,7 @@ static int tegra_emc_debug_min_rate_set(void *data, u64 rate)
 	if (!tegra_emc_validate_rate(emc, rate))
 		return -EINVAL;
 
-	err = clk_set_min_rate(emc->clk, rate);
+	err = emc_set_min_rate(emc, rate, EMC_RATE_DEBUG);
 	if (err < 0)
 		return err;
 
@@ -1111,7 +1225,7 @@ static int tegra_emc_debug_max_rate_set(void *data, u64 rate)
 	if (!tegra_emc_validate_rate(emc, rate))
 		return -EINVAL;
 
-	err = clk_set_max_rate(emc->clk, rate);
+	err = emc_set_max_rate(emc, rate, EMC_RATE_DEBUG);
 	if (err < 0)
 		return err;
 
@@ -1129,15 +1243,6 @@ static void emc_debugfs_init(struct device *dev, struct tegra_emc *emc)
 	unsigned int i;
 	int err;
 
-	emc->clk = devm_clk_get(dev, "emc");
-	if (IS_ERR(emc->clk)) {
-		if (PTR_ERR(emc->clk) != -ENODEV) {
-			dev_err(dev, "failed to get EMC clock: %ld\n",
-				PTR_ERR(emc->clk));
-			return;
-		}
-	}
-
 	emc->debugfs.min_rate = ULONG_MAX;
 	emc->debugfs.max_rate = 0;
 
@@ -1177,6 +1282,182 @@ static void emc_debugfs_init(struct device *dev, struct tegra_emc *emc)
 			    emc, &tegra_emc_debug_max_rate_fops);
 }
 
+static inline struct tegra_emc *
+to_tegra_emc_provider(struct icc_provider *provider)
+{
+	return container_of(provider, struct tegra_emc, provider);
+}
+
+static struct icc_node_data *
+emc_of_icc_xlate_extended(struct of_phandle_args *spec, void *data)
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
+	struct tegra_emc *emc = to_tegra_emc_provider(dst->provider);
+	unsigned long long peak_bw = icc_units_to_bps(dst->peak_bw);
+	unsigned long long avg_bw = icc_units_to_bps(dst->avg_bw);
+	unsigned long long rate = max(avg_bw, peak_bw);
+	unsigned int dram_data_bus_width_bytes;
+	const unsigned int ddr = 2;
+	int err;
+
+	/*
+	 * Tegra124 EMC runs on a clock rate of SDRAM bus. This means that
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
+static int tegra_emc_interconnect_init(struct tegra_emc *emc)
+{
+	const struct tegra_mc_soc *soc = emc->mc->soc;
+	struct icc_node *node;
+	int err;
+
+	emc->provider.dev = emc->dev;
+	emc->provider.set = emc_icc_set;
+	emc->provider.data = &emc->provider;
+	emc->provider.aggregate = soc->icc_ops->aggregate;
+	emc->provider.xlate_extended = emc_of_icc_xlate_extended;
+
+	err = icc_provider_add(&emc->provider);
+	if (err)
+		goto err_msg;
+
+	/* create External Memory Controller node */
+	node = icc_node_create(TEGRA_ICC_EMC);
+	if (IS_ERR(node)) {
+		err = PTR_ERR(node);
+		goto del_provider;
+	}
+
+	node->name = "External Memory Controller";
+	icc_node_add(node, &emc->provider);
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
+	icc_node_add(node, &emc->provider);
+
+	return 0;
+
+remove_nodes:
+	icc_nodes_remove(&emc->provider);
+del_provider:
+	icc_provider_del(&emc->provider);
+err_msg:
+	dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
+
+	return err;
+}
+
+static int tegra_emc_opp_table_init(struct tegra_emc *emc)
+{
+	u32 hw_version = BIT(tegra_sku_info.soc_speedo_id);
+	struct opp_table *opp_table, *hw_opp_table;
+	const char *rname = "core";
+	int err;
+
+	/*
+	 * Legacy device-trees don't have OPP table and EMC driver isn't
+	 * useful in this case.
+	 */
+	if (!device_property_present(emc->dev, "operating-points-v2")) {
+		dev_err(emc->dev,
+			"OPP table not found, please update your device tree\n");
+		return -ENODEV;
+	}
+
+	/* voltage scaling is optional */
+	if (device_property_present(emc->dev, "core-supply"))
+		opp_table = dev_pm_opp_set_regulators(emc->dev, &rname, 1);
+	else
+		opp_table = dev_pm_opp_get_opp_table(emc->dev);
+
+	if (IS_ERR(opp_table))
+		return dev_err_probe(emc->dev, PTR_ERR(opp_table),
+				     "failed to prepare OPP table\n");
+
+	hw_opp_table = dev_pm_opp_set_supported_hw(emc->dev, &hw_version, 1);
+	err = PTR_ERR_OR_ZERO(hw_opp_table);
+	if (err) {
+		dev_err(emc->dev, "failed to set supported HW: %d\n", err);
+		goto put_table;
+	}
+
+	err = dev_pm_opp_of_add_table(emc->dev);
+	if (err) {
+		dev_err(emc->dev, "failed to add OPP table: %d\n", err);
+		goto put_hw;
+	}
+
+	dev_info(emc->dev, "OPP HW ver. 0x%x, current clock rate %lu MHz\n",
+		 hw_version, clk_get_rate(emc->clk) / 1000000);
+
+	/* first dummy rate-set initializes voltage state */
+	err = dev_pm_opp_set_rate(emc->dev, clk_get_rate(emc->clk));
+	if (err) {
+		dev_err(emc->dev, "failed to initialize OPP clock: %d\n", err);
+		goto remove_table;
+	}
+
+	return 0;
+
+remove_table:
+	dev_pm_opp_of_remove_table(emc->dev);
+put_hw:
+	dev_pm_opp_put_supported_hw(opp_table);
+put_table:
+	dev_pm_opp_put_regulators(opp_table);
+
+	return err;
+}
+
 static int tegra_emc_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
@@ -1188,6 +1469,7 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	if (!emc)
 		return -ENOMEM;
 
+	mutex_init(&emc->rate_lock);
 	emc->dev = &pdev->dev;
 
 	emc->regs = devm_platform_ioremap_resource(pdev, 0);
@@ -1231,9 +1513,24 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	tegra124_clk_set_emc_callbacks(tegra_emc_prepare_timing_change,
 				       tegra_emc_complete_timing_change);
 
+	emc->clk = devm_clk_get(&pdev->dev, "emc");
+	if (IS_ERR(emc->clk)) {
+		err = PTR_ERR(emc->clk);
+		dev_err(&pdev->dev, "failed to get EMC clock: %d\n", err);
+		goto unset_cb;
+	}
+
+	err = tegra_emc_opp_table_init(emc);
+	if (err)
+		goto unset_cb;
+
+	tegra_emc_rate_requests_init(emc);
+
 	if (IS_ENABLED(CONFIG_DEBUG_FS))
 		emc_debugfs_init(&pdev->dev, emc);
 
+	tegra_emc_interconnect_init(emc);
+
 	/*
 	 * Don't allow the kernel module to be unloaded. Unloading adds some
 	 * extra complexity which doesn't really worth the effort in a case of
@@ -1242,6 +1539,11 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	try_module_get(THIS_MODULE);
 
 	return 0;
+
+unset_cb:
+	tegra124_clk_set_emc_callbacks(NULL, NULL);
+
+	return err;
 };
 
 static struct platform_driver tegra_emc_driver = {
@@ -1250,6 +1552,7 @@ static struct platform_driver tegra_emc_driver = {
 		.name = "tegra-emc",
 		.of_match_table = tegra_emc_of_match,
 		.suppress_bind_attrs = true,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(tegra_emc_driver);
diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index e2389573d3c0..459211f50c08 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -4,7 +4,8 @@
  */
 
 #include <linux/of.h>
-#include <linux/mm.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
 
 #include <dt-bindings/memory/tegra124-mc.h>
 
@@ -1010,6 +1011,83 @@ static const struct tegra_mc_reset tegra124_mc_resets[] = {
 	TEGRA124_MC_RESET(GPU,       0x970, 0x974,  2),
 };
 
+static int tegra124_mc_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	/* TODO: program PTSA */
+	return 0;
+}
+
+static int tegra124_mc_icc_aggreate(struct icc_node *node, u32 tag, u32 avg_bw,
+				    u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
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
+tegra124_mc_of_icc_xlate_extended(struct of_phandle_args *spec, void *data)
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
+static const struct tegra_mc_icc_ops tegra124_mc_icc_ops = {
+	.xlate_extended = tegra124_mc_of_icc_xlate_extended,
+	.aggregate = tegra124_mc_icc_aggreate,
+	.set = tegra124_mc_icc_set,
+};
+
 #ifdef CONFIG_ARCH_TEGRA_124_SOC
 static const unsigned long tegra124_mc_emem_regs[] = {
 	MC_EMEM_ARB_CFG,
@@ -1061,6 +1139,7 @@ const struct tegra_mc_soc tegra124_mc_soc = {
 	.reset_ops = &tegra_mc_reset_ops_common,
 	.resets = tegra124_mc_resets,
 	.num_resets = ARRAY_SIZE(tegra124_mc_resets),
+	.icc_ops = &tegra124_mc_icc_ops,
 };
 #endif /* CONFIG_ARCH_TEGRA_124_SOC */
 
@@ -1091,5 +1170,6 @@ const struct tegra_mc_soc tegra132_mc_soc = {
 	.reset_ops = &tegra_mc_reset_ops_common,
 	.resets = tegra124_mc_resets,
 	.num_resets = ARRAY_SIZE(tegra124_mc_resets),
+	.icc_ops = &tegra124_mc_icc_ops,
 };
 #endif /* CONFIG_ARCH_TEGRA_132_SOC */
-- 
2.27.0

