Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEAE2A6AA6
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 17:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731627AbgKDQuM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 11:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731614AbgKDQuK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:50:10 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AC2C0613D4;
        Wed,  4 Nov 2020 08:50:10 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id y184so26066572lfa.12;
        Wed, 04 Nov 2020 08:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xF3849VzaoUkwlJVQxMK0p9EE4An5iO4TNW5KJUNqkI=;
        b=UE6ahmZUXgLanUgmwbF1+Kd66O+g7zjrTXzmDdlckuUHhusQSlWDArUYNSyxEO9mBg
         p9DTK3RPcrOKbkp4WVtFIyRjUIYh+zG04OEDAj8SR7PIsP0G5w//GxalgPcJ7iIGnAS7
         Bsnuw7azSvuq+HkpLF6+JuSlVN+jDrewSBMSrFKS3kMzT7mquDt7y4KZdxCOCJ++Xzot
         /HXkQiStUWUKjAOkBMUTZdU3YEcDq9/V8mP2/QqqfJRlrKoO4VPZycbqygy2csUsu2r/
         dA11SxFk9K0LYanmtP5jr4I4hq/QQlY0xR6dTHl+gMMXa5+1jotKsGk067DesV+lXOTT
         sQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xF3849VzaoUkwlJVQxMK0p9EE4An5iO4TNW5KJUNqkI=;
        b=Yz0aVdMiRS18TB5f6HgOP/3QYSNOAj1mQd912KQxgfcnE3j+Fh2IRaHMM4b2NlUkQL
         d82VfOUBdW6Q7w0W0NIUQN8DKeQKTVUjfrfr9cuKCpK0oxb26pnenxAKDw2bKzK14GWn
         JLNoCZYu+yJfWXr4RE1ciDyuRTz0nkKcwfTP8gU23E4YhpLTGejPnHW4MvTaB8S4JOWN
         LkrPirKKz79aOVb222arWOi8MU4E+a4cRePX27K4hQUX5OiRAJnGfDGlOBCAdr71tAlk
         Ib4tpLR/NM4nxJyujV87l2x5d15CQoefWa/54Qv7zjaVnLbHNyDLe0G9sA5ofMTn7rnT
         pfOQ==
X-Gm-Message-State: AOAM530L4nofMYon2UyO2FKBxt5cw7e9agt4WsqXPK3vHeokA2KwZjr0
        1glyfTYMrU5TfWyW5KPVVf4=
X-Google-Smtp-Source: ABdhPJyIRbpopM66GwgNH/xaZzCBjvCrNQQGoQ0QhDsmeMrJWLANUvsikptUHHjPcycTxkBTX+YRyw==
X-Received: by 2002:a19:3ce:: with SMTP id 197mr13207lfd.364.1604508608569;
        Wed, 04 Nov 2020 08:50:08 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:50:08 -0800 (PST)
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
Subject: [PATCH v7 32/47] memory: tegra-mc: Add interconnect framework
Date:   Wed,  4 Nov 2020 19:49:08 +0300
Message-Id: <20201104164923.21238-33-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add common SoC-agnostic ICC framework which turns Tegra Memory Controller
into a memory interconnection provider. This allows us to use interconnect
API for tuning of memory configurations.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/Kconfig |   1 +
 drivers/memory/tegra/mc.c    | 100 +++++++++++++++++++++++++++++++++++
 drivers/memory/tegra/mc.h    |  22 ++++++++
 include/soc/tegra/mc.h       |  17 ++++++
 4 files changed, 140 insertions(+)

diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
index 9f0a96bf9ccc..b38e5255effe 100644
--- a/drivers/memory/tegra/Kconfig
+++ b/drivers/memory/tegra/Kconfig
@@ -3,6 +3,7 @@ config TEGRA_MC
 	bool "NVIDIA Tegra Memory Controller support"
 	default y
 	depends on ARCH_TEGRA
+	select INTERCONNECT
 	help
 	  This driver supports the Memory Controller (MC) hardware found on
 	  NVIDIA Tegra SoCs.
diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 998f9148ecb8..a7e6a8e4c95a 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -639,6 +639,101 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/*
+ * Memory Controller (MC) has few Memory Clients that are issuing memory
+ * bandwidth allocation requests to the MC interconnect provider. The MC
+ * provider aggregates the requests and then sends the aggregated request
+ * up to the External Memory Controller (EMC) interconnect provider which
+ * re-configures hardware interface to External Memory (EMEM) in accordance
+ * to the required bandwidth. Each MC interconnect node represents an
+ * individual Memory Client.
+ *
+ * Memory interconnect topology:
+ *
+ *               +----+
+ * +--------+    |    |
+ * | TEXSRD +--->+    |
+ * +--------+    |    |
+ *               |    |    +-----+    +------+
+ *    ...        | MC +--->+ EMC +--->+ EMEM |
+ *               |    |    +-----+    +------+
+ * +--------+    |    |
+ * | DISP.. +--->+    |
+ * +--------+    |    |
+ *               +----+
+ */
+static int tegra_mc_interconnect_setup(struct tegra_mc *mc)
+{
+	struct icc_node *node;
+	unsigned int i;
+	int err;
+
+	/* older device-trees don't have interconnect properties */
+	if (!device_property_present(mc->dev, "#interconnect-cells") ||
+	    !mc->soc->icc_ops)
+		return 0;
+
+	mc->provider.dev = mc->dev;
+	mc->provider.data = &mc->provider;
+	mc->provider.set = mc->soc->icc_ops->set;
+	mc->provider.aggregate = mc->soc->icc_ops->aggregate;
+	mc->provider.xlate_extended = mc->soc->icc_ops->xlate_extended;
+
+	err = icc_provider_add(&mc->provider);
+	if (err)
+		return err;
+
+	/* create Memory Controller node */
+	node = icc_node_create(TEGRA_ICC_MC);
+	if (IS_ERR(node)) {
+		err = PTR_ERR(node);
+		goto del_provider;
+	}
+
+	node->name = "Memory Controller";
+	icc_node_add(node, &mc->provider);
+
+	/* link Memory Controller to External Memory Controller */
+	err = icc_link_create(node, TEGRA_ICC_EMC);
+	if (err)
+		goto remove_nodes;
+
+	for (i = 0; i < mc->soc->num_clients; i++) {
+		/* create MC client node */
+		node = icc_node_create(mc->soc->clients[i].id);
+		if (IS_ERR(node)) {
+			err = PTR_ERR(node);
+			goto remove_nodes;
+		}
+
+		node->name = mc->soc->clients[i].name;
+		icc_node_add(node, &mc->provider);
+
+		/* link Memory Client to Memory Controller */
+		err = icc_link_create(node, TEGRA_ICC_MC);
+		if (err)
+			goto remove_nodes;
+	}
+
+	/*
+	 * MC driver is registered too early, so early that generic driver
+	 * syncing doesn't work for the MC. But it doesn't really matter
+	 * since syncing works for the EMC drivers, hence we can sync the
+	 * MC driver by ourselves and then EMC will complete syncing of
+	 * the whole ICC state.
+	 */
+	icc_sync_state(mc->dev);
+
+	return 0;
+
+remove_nodes:
+	icc_nodes_remove(&mc->provider);
+del_provider:
+	icc_provider_del(&mc->provider);
+
+	return err;
+}
+
 static int tegra_mc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -727,6 +822,11 @@ static int tegra_mc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to register reset controller: %d\n",
 			err);
 
+	err = tegra_mc_interconnect_setup(mc);
+	if (err < 0)
+		dev_err(&pdev->dev, "failed to initialize interconnect: %d\n",
+			err);
+
 	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_SMMU) && mc->soc->smmu) {
 		mc->smmu = tegra_smmu_probe(&pdev->dev, mc->soc->smmu, mc);
 		if (IS_ERR(mc->smmu)) {
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index afa3ba45c9e6..33e40d600592 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -78,6 +78,20 @@
 
 #define MC_TIMING_UPDATE				BIT(0)
 
+static inline u32 tegra_mc_scale_percents(u64 val, unsigned int percents)
+{
+	val = val * percents;
+	do_div(val, 100);
+
+	return min_t(u64, val, U32_MAX);
+}
+
+static inline struct tegra_mc *
+icc_provider_to_tegra_mc(struct icc_provider *provider)
+{
+	return container_of(provider, struct tegra_mc, provider);
+}
+
 static inline u32 mc_readl(struct tegra_mc *mc, unsigned long offset)
 {
 	return readl_relaxed(mc->regs + offset);
@@ -115,4 +129,12 @@ extern const struct tegra_mc_soc tegra132_mc_soc;
 extern const struct tegra_mc_soc tegra210_mc_soc;
 #endif
 
+/*
+ * These IDs are for internal use of Tegra ICC drivers. The ID numbers are
+ * chosen such that they don't conflict with the device-tree ICC node IDs.
+ */
+#define TEGRA_ICC_MC		1000
+#define TEGRA_ICC_EMC		1001
+#define TEGRA_ICC_EMEM		1002
+
 #endif /* MEMORY_TEGRA_MC_H */
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index d9395af98143..43876216de34 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -6,7 +6,9 @@
 #ifndef __SOC_TEGRA_MC_H__
 #define __SOC_TEGRA_MC_H__
 
+#include <linux/bits.h>
 #include <linux/err.h>
+#include <linux/interconnect-provider.h>
 #include <linux/reset-controller.h>
 #include <linux/types.h>
 
@@ -141,6 +143,17 @@ struct tegra_mc_reset_ops {
 			    const struct tegra_mc_reset *rst);
 };
 
+#define TEGRA_MC_ICC_TAG_DEFAULT				0
+#define TEGRA_MC_ICC_TAG_ISO					BIT(0)
+
+struct tegra_mc_icc_ops {
+	int (*set)(struct icc_node *src, struct icc_node *dst);
+	int (*aggregate)(struct icc_node *node, u32 tag, u32 avg_bw,
+			 u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
+	struct icc_node_data *(*xlate_extended)(struct of_phandle_args *spec,
+						void *data);
+};
+
 struct tegra_mc_soc {
 	const struct tegra_mc_client *clients;
 	unsigned int num_clients;
@@ -160,6 +173,8 @@ struct tegra_mc_soc {
 	const struct tegra_mc_reset_ops *reset_ops;
 	const struct tegra_mc_reset *resets;
 	unsigned int num_resets;
+
+	const struct tegra_mc_icc_ops *icc_ops;
 };
 
 struct tegra_mc {
@@ -178,6 +193,8 @@ struct tegra_mc {
 
 	struct reset_controller_dev reset;
 
+	struct icc_provider provider;
+
 	spinlock_t lock;
 };
 
-- 
2.27.0

