Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01F2244224
	for <lists+linux-pm@lfdr.de>; Fri, 14 Aug 2020 02:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgHNAHi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 20:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgHNAHg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:36 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E770C061383;
        Thu, 13 Aug 2020 17:07:36 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b11so3938888lfe.10;
        Thu, 13 Aug 2020 17:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O23JkLbWUuVXs4gkNyk0xOw8Jw239Wdxi4mqPy4JqjU=;
        b=jGvznWsXQm73GmmlqzTcsZiPusXvcI/vTw4GzBqDu7eTN2eNJrqZH41AK5NkV6ffX/
         f9Q/lVYfOhZbVHzv5xfok0P6yOcMnXZB51M8Dsb47ZFKtSEmHunU08X70/E93W2rwehv
         ejUReQWqo0HpP1zuWdmFefrz2SRj6CLrRrddAqULzReZaz0cgtDLqWAY08JdKBIjMEzE
         vWWiaNW/IOky4U06LOETD03CETgVGsWRjS3pA0bBBH7MQRZB820O23YeJWluyrszh4T6
         4tiWMIvaqjdsxeCNRMhHd8QbndVTPcbKw/JY/z8kIQgdd7vwswvC1Ap90Z4Dtjfc+7Rp
         Jj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O23JkLbWUuVXs4gkNyk0xOw8Jw239Wdxi4mqPy4JqjU=;
        b=XNVDruRmKdNLahaISnpW7G5nD46kw978nodZiabCtjntannINBRk+A4ueaGnkPJU0u
         +uaI4f8LbhS4XY32GJdMeT+z6AVMZz8K91/hd//h3eSodJ2VK+p1bkSqlOsynzXJakk2
         L39PWjETxle9RPTPS6Nu6bHOl4ayjrIel+rQaCWl+GEqPEUMn9k0vK7L+M3E2zyZvJ1C
         BinRA61//SJHNEFCPpcW/89eqk2f9HTCe1jQCApxsWXrvm1P+KC2/IJF0LwoBbKSpLP6
         FRB7CNMeXPJPsvM+fHvN+gBx9KCuWRcjNOa6B/ObVPH4JrDZwXX9q6AlMejUExiDsyIJ
         50IA==
X-Gm-Message-State: AOAM5310qat5lj9BYnBSHgTmm9s7kCcCRksRNVLWtDDhDZcfK9KPlSiN
        BpHbNV67y6xmHlOxQBnASavmYng6
X-Google-Smtp-Source: ABdhPJwTodhiQiEYufw9IavmQ4xKAqKYfu4EDd61XUdA7Xmn1airjSHSSDiRCouzKq7gQPw+F+0gxA==
X-Received: by 2002:ac2:5991:: with SMTP id w17mr3331378lfn.153.1597363654780;
        Thu, 13 Aug 2020 17:07:34 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:34 -0700 (PDT)
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
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 30/36] memory: tegra20-emc: Register as interconnect provider
Date:   Fri, 14 Aug 2020 03:06:15 +0300
Message-Id: <20200814000621.8415-31-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
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
index 89e077d797e7..437d9d789941 100644
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
@@ -773,6 +882,7 @@ static int tegra_emc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, emc);
 	tegra_emc_debugfs_init(emc);
+	tegra_emc_interconnect_init(emc);
 
 	/*
 	 * Don't allow the kernel module to be unloaded. Unloading adds some
-- 
2.27.0

