Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 652361971BB
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 03:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgC3BJ4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 21:09:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45491 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgC3BJy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 21:09:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id t17so16314658ljc.12;
        Sun, 29 Mar 2020 18:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVJ9yyE9K29bjnDrPjNdExCXsCR6dQskyYaw3z4hZMU=;
        b=F7nQYiIaHaST/H7lR7YpTTa4yZjR1j5Co4uSUtl0sgMnIvNo+M+8NFbhKOUavfmm/K
         L8+5mcmop875YhcV806hvT5NeLKYsURWzYro4YNtmtxxThG3DBQSRBJ//NBhVa/Okk96
         blIweno/JmI2vIHcs2M+M4ocr7ITywTV95X+8QFqxcqUksEe66nTgUuojF5u3kqHxspg
         1NjfQIp6xQcVYJng1r5m8wGrvQ5T6aaEVHyUeWn/zN01OXK9w0VoPkj6PF9Aa6GCc3Ip
         jy5pmksmf3z4WB4zU7CpLFG/vX4jxXtz8+Luys44rcz0vmCYu5W2IWhL6O6ANdqxBHPh
         KN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVJ9yyE9K29bjnDrPjNdExCXsCR6dQskyYaw3z4hZMU=;
        b=jh8QoreotbNhDq380wY0xiDEH3/1qJ5o5q+mo85zlYEOl47QUe6CfzcaIuB49YntDW
         v7vuczRCikjU4imnlCAErGdc4RuqNYUQElc8YYueUkUUv+FlFmKrXQYQJeTrZkIYoJS+
         R5Z1gJZB1ddPNu28bzFfIU+woGTpix130LG/sZFU31Sh2fY8yzrLBJscw01hLlG0HUTY
         e9w0lUvVU1j4AfzJoAZuQ4VnjO4Bx1351pw7k+Od+vXbMv/Ibwka3+1xJbJYYdEc0UfZ
         J14rnEVNHVjgROrFQTs2aCvuWVL+qSkxl9RrVwoVYuS20IL8/UF5Mx4p+n/yustbV99P
         3Taw==
X-Gm-Message-State: AGi0PuYCLpk6i7m8pSxy64fx2q7n3Z8yA9ogINfeniyY2cgkNB50H0i1
        XZnWFMLTLPK8jYdz00TISL8=
X-Google-Smtp-Source: APiQypIW79Ltthny3GKQ7ecV2+YYx75UJ9/u2MNZafMabV+CzVs4wTMFMrkD4t5ow3wMmWRR3u68tQ==
X-Received: by 2002:a2e:88cb:: with SMTP id a11mr5830944ljk.245.1585530592036;
        Sun, 29 Mar 2020 18:09:52 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f23sm2449005lja.60.2020.03.29.18.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:09:51 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 17/22] memory: tegra30-emc: Register as interconnect provider
Date:   Mon, 30 Mar 2020 04:08:59 +0300
Message-Id: <20200330010904.27643-18-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330010904.27643-1-digetx@gmail.com>
References: <20200330010904.27643-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now external memory controller is a memory interconnection provider.
This allows us to use interconnect API to change memory configuration.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra30-emc.c | 115 +++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 69698665d431..5a4106173a75 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -14,6 +14,7 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/interconnect-provider.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -327,6 +328,7 @@ struct tegra_emc {
 	struct device *dev;
 	struct tegra_mc *mc;
 	struct notifier_block clk_nb;
+	struct icc_provider provider;
 	struct clk *clk;
 	void __iomem *regs;
 	unsigned int irq;
@@ -1264,6 +1266,112 @@ static void tegra_emc_debugfs_init(struct tegra_emc *emc)
 			    emc, &tegra_emc_debug_max_rate_fops);
 }
 
+static inline struct tegra_emc *
+to_tegra_emc_provider(struct icc_provider *provider)
+{
+	return container_of(provider, struct tegra_emc, provider);
+}
+
+static struct icc_node *
+emc_of_icc_xlate_onecell(struct of_phandle_args *spec, void *data)
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
+	emc->provider.xlate = emc_of_icc_xlate_onecell;
+	emc->provider.aggregate = emc_icc_aggregate;
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
+
+del_provider:
+	icc_provider_del(&emc->provider);
+
+	return err;
+}
+
 static int tegra_emc_probe(struct platform_device *pdev)
 {
 	struct platform_device *mc;
@@ -1344,6 +1452,13 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, emc);
 	tegra_emc_debugfs_init(emc);
 
+	if (IS_ENABLED(CONFIG_INTERCONNECT)) {
+		err = tegra_emc_interconnect_init(emc);
+		if (err)
+			dev_err(&pdev->dev, "failed to initialize ICC: %d\n",
+				err);
+	}
+
 	return 0;
 
 unset_cb:
-- 
2.25.1

