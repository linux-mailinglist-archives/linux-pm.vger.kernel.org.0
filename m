Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EBA1F3BAF
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgFINPu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgFINPF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:15:05 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E359C08C5C7;
        Tue,  9 Jun 2020 06:15:04 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 82so12449694lfh.2;
        Tue, 09 Jun 2020 06:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I7K6pP+VtdggFZCsP3lFDVTttDH/0LC9bYXS86TOH5s=;
        b=gpz1dVmGBS0JAbbGjI2zfwNKRCHvLrspiNt4fq2GRSzA391Qr0vfeCTsyIRAer/4Ve
         RoqJunmdCHCAQAA9wAQiT/GqKQexWEMILhCBxSpo5KImBza98KvVbpTbROSO/RgquH97
         4H12d9Zdmeh0ybgb4V57JH+9eVjoyGCpU3dxNeBR24H+MZUCGsQasFyrEu6SG1p6EC/r
         Lf2EQJ3XGzL3c9RdCSw43hN6Nwb7Y6qqSyZ3jABVwF6GRXKyLSR+Z/YmuesJBAha9NDf
         Nx0E7I4lN8MkNzdkcJEe1vQXLCgxnobtv59F+yJxfWXtP9aMWVxESrCrYHffyPROP/J9
         JvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I7K6pP+VtdggFZCsP3lFDVTttDH/0LC9bYXS86TOH5s=;
        b=sm2UnNANBb77lMmYshiVRMOuV2b+FXKJS2O9xRtbhtSYOh4KkKwgFZ74yf5FWryGt7
         JiIRnVWz2sjl4ZLZg3CYmgzpdhFgV3mBvg1tv0MZ3UynPdn8JRTtUHG6VBPka/qKCuaZ
         bP44pu39tMk0Ch732xVcQYfRx+6YDNYUTJ9yci5N9jr77kr2l21ZVCNYeVVh1mWhDyiS
         L91K2ylMxOvpapCmpnlOgWo7+nX22fe3BKW22zlo8OuPAyy1iYbZUenDt5BfZvzL4qGh
         Z+zbDA5OlkU7VOoqgK7s0PttoJIeWdOu6+0PqRl1XYLxKtqRmk6eMog77RudHYz6iPNK
         3PWQ==
X-Gm-Message-State: AOAM533dpaULwMXZkN+N/w7Fln7b0mrzjl1AlOsxNeHUVZLI4B1ZJ6yw
        98lUgUUPwjJ9OWl7PTa5Yxs=
X-Google-Smtp-Source: ABdhPJwPGbudINukH8h1BPvKKcnsUFOEztbYVGuIQyCRXoLqJ2LoTQ2Y/j1f0h4O68zrJBXYiJqVZg==
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr15731902lfc.142.1591708502997;
        Tue, 09 Jun 2020 06:15:02 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:15:02 -0700 (PDT)
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
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 31/37] memory: tegra20-emc: Register as interconnect provider
Date:   Tue,  9 Jun 2020 16:13:58 +0300
Message-Id: <20200609131404.17523-32-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609131404.17523-1-digetx@gmail.com>
References: <20200609131404.17523-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now memory controller is a memory interconnection provider. This allows us
to use interconnect API in order to change memory configuration.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 110 +++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 6cd3d50145dc..ef0f5a69f24b 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -9,6 +9,7 @@
 #include <linux/clk/tegra.h>
 #include <linux/debugfs.h>
 #include <linux/err.h>
+#include <linux/interconnect-provider.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -148,6 +149,7 @@ struct emc_timing {
 struct tegra_emc {
 	struct device *dev;
 	struct notifier_block clk_nb;
+	struct icc_provider provider;
 	struct clk *clk;
 	void __iomem *regs;
 
@@ -661,6 +663,113 @@ static void tegra_emc_debugfs_init(struct tegra_emc *emc)
 			    emc, &tegra_emc_debug_max_rate_fops);
 }
 
+static inline struct tegra_emc *
+to_tegra_emc_provider(struct icc_provider *provider)
+{
+	return container_of(provider, struct tegra_emc, provider);
+}
+
+static struct icc_node *
+emc_of_icc_xlate(struct of_phandle_args *spec, void *data)
+{
+	struct icc_provider *provider = data;
+	struct icc_node *node;
+
+	/* External Memory is the only possible ICC route */
+	list_for_each_entry(node, &provider->nodes, node_list) {
+		if (node->id == TEGRA_ICC_EMEM)
+			return node;
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int emc_icc_set(struct icc_node *src, struct icc_node *dst)
+{
+	struct tegra_emc *emc = to_tegra_emc_provider(dst->provider);
+	unsigned long long rate = icc_units_to_bps(dst->avg_bw);
+	unsigned int dram_data_bus_width_bytes = 4;
+	unsigned int ddr = 2;
+	int err;
+
+	do_div(rate, ddr * dram_data_bus_width_bytes);
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
+static int emc_icc_aggregate(struct icc_node *node,
+			     u32 tag, u32 avg_bw, u32 peak_bw,
+			     u32 *agg_avg, u32 *agg_peak)
+{
+	*agg_avg = min((u64)avg_bw + (*agg_avg), (u64)U32_MAX);
+	*agg_peak = max(*agg_peak, peak_bw);
+
+	return 0;
+}
+
+static int tegra_emc_interconnect_init(struct tegra_emc *emc)
+{
+	struct icc_node *node;
+	int err;
+
+	/* older device-trees don't have interconnect properties */
+	if (!of_find_property(emc->dev->of_node, "#interconnect-cells", NULL))
+		return 0;
+
+	emc->provider.dev = emc->dev;
+	emc->provider.set = emc_icc_set;
+	emc->provider.data = &emc->provider;
+	emc->provider.xlate = emc_of_icc_xlate;
+	emc->provider.aggregate = emc_icc_aggregate;
+
+	err = icc_provider_add(&emc->provider);
+	if (err)
+		goto err_msg;
+
+	/* create External Memory Controller node */
+	node = icc_node_create(TEGRA_ICC_EMC);
+	err = PTR_ERR_OR_ZERO(node);
+	if (err)
+		goto del_provider;
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
+	err = PTR_ERR_OR_ZERO(node);
+	if (err)
+		goto remove_nodes;
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
 static int tegra_emc_init_mc_timings(struct tegra_emc *emc)
 {
 	struct tegra_mc_timing *timing;
@@ -766,6 +875,7 @@ static int tegra_emc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, emc);
 	tegra_emc_debugfs_init(emc);
+	tegra_emc_interconnect_init(emc);
 
 	/*
 	 * Don't allow the kernel module to be unloaded. Unloading adds some
-- 
2.26.0

