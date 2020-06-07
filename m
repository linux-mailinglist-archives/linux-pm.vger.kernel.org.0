Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F601F0E75
	for <lists+linux-pm@lfdr.de>; Sun,  7 Jun 2020 20:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgFGS5v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Jun 2020 14:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbgFGS5u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:50 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD68C08C5C4;
        Sun,  7 Jun 2020 11:57:48 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y11so16108473ljm.9;
        Sun, 07 Jun 2020 11:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zu8zcLzab2nky23oTkyq/JPkN4v7BrCRZp2+Obr3fiA=;
        b=DOKyOQNer/zLsytt2CtiLQxDatfRaM1IHVCbUjSgMruv+PyV+myqSq2LrqWw8i3mo0
         dnGsIYy5WNVPkurnlmDB8Y3tvDqAQ1JA7cMvexYWVhS8bEwzWnuEfco6wXmb1CYiAKPK
         7VG2Z7x0PKIlfD8Qhg9taNCq3p/e6mwXRx/o7wqTuvy5oYgsLJ9p2mB0AEXLKtDyf7OM
         QYcTLYjuJ2MCy4Vw7tLbmF6S+wfyQglpBDLnoHGngjHKXOE9R8MM7GgKKTEI1TgdzjMm
         BNsVGA8sxKYn3plDBJh8XqQiWrt4ulBgoqWSR6mGK6L9ETzYHTyUHaKv8buJL+7rz3mi
         c1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zu8zcLzab2nky23oTkyq/JPkN4v7BrCRZp2+Obr3fiA=;
        b=HcW31R0lttF3tcOCgfPoxaOcuRQWPvtmsDdHSpGHX4cNUY/SvM9csxA1766k3QfZci
         R0yDmB8qLGtC2ULg3Ou8NRvA/sl9P8pnUVRb1b0glXRjcPNy/GgCrRHKjTfPIrpzQhk7
         2UvFOqTI4vc1bWx8ujXPDm8GhfXSyEg9cS8OfQxI0PJnF3lXrev7SpTc6iNxfu6m7TU1
         Vhq2lJakGNIewmlcD4X+Ch5kIKVRJZ/SlBktkUdsmRI+ZTT13tQHM/YbOsq4gN7jWn5a
         SiG6PzFiAhVzTf6xjEQgqUKWqUtaFzxryy+GIl/O1j/s2iCqcCrQpZSfAOwOUD3+b+kx
         OSyQ==
X-Gm-Message-State: AOAM530vmyGj1wag9IW6L6ZXpdRi0irYQLYQYGv9N/z73HUyMM25ysnk
        MXzR5erfBo3B2vyG+30Ivmg=
X-Google-Smtp-Source: ABdhPJzM7w5yk48XguXHy2I5EJHZgxcTxClFZWkb0s7Oa253z4ARE5Trro9tQyL9eI9KOPayl7iuPA==
X-Received: by 2002:a2e:8115:: with SMTP id d21mr9774165ljg.167.1591556267398;
        Sun, 07 Jun 2020 11:57:47 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:46 -0700 (PDT)
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
Subject: [PATCH v3 28/39] memory: tegra: Register as interconnect provider
Date:   Sun,  7 Jun 2020 21:55:19 +0300
Message-Id: <20200607185530.18113-29-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
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
 drivers/memory/tegra/mc.c | 118 ++++++++++++++++++++++++++++++++++++++
 drivers/memory/tegra/mc.h |   8 +++
 include/soc/tegra/mc.h    |   3 +
 3 files changed, 129 insertions(+)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 772aa021b5f6..645b5fd1e14b 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -594,6 +594,117 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
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
+	struct icc_onecell_data *data;
+	struct icc_node *node;
+	unsigned int num_nodes;
+	unsigned int i;
+	int err;
+
+	/* older device-trees don't have interconnect properties */
+	if (!of_find_property(mc->dev->of_node, "#interconnect-cells", NULL))
+		return 0;
+
+	num_nodes = mc->soc->num_clients;
+
+	data = devm_kzalloc(mc->dev, struct_size(data, nodes, num_nodes),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	mc->provider.dev = mc->dev;
+	mc->provider.set = tegra_mc_icc_set;
+	mc->provider.data = data;
+	mc->provider.xlate = of_icc_xlate_onecell;
+	mc->provider.aggregate = tegra_mc_icc_aggregate;
+
+	err = icc_provider_add(&mc->provider);
+	if (err)
+		return err;
+
+	/* create Memory Controller node */
+	node = icc_node_create(TEGRA_ICC_MC);
+	err = PTR_ERR_OR_ZERO(node);
+	if (err)
+		goto del_provider;
+
+	node->name = "Memory Controller";
+	icc_node_add(node, &mc->provider);
+
+	/* link Memory Controller to External Memory Controller */
+	err = icc_link_create(node, TEGRA_ICC_EMC);
+	if (err)
+		goto remove_nodes;
+
+	for (i = 0; i < num_nodes; i++) {
+		/* create MC client node */
+		node = icc_node_create(mc->soc->clients[i].id);
+		err = PTR_ERR_OR_ZERO(node);
+		if (err)
+			goto remove_nodes;
+
+		node->name = mc->soc->clients[i].name;
+		icc_node_add(node, &mc->provider);
+
+		/* link Memory Client to Memory Controller */
+		err = icc_link_create(node, TEGRA_ICC_MC);
+		if (err)
+			goto remove_nodes;
+
+		data->nodes[i] = node;
+	}
+	data->num_nodes = num_nodes;
+
+	return 0;
+
+remove_nodes:
+	icc_nodes_remove(&mc->provider);
+
+del_provider:
+	icc_provider_del(&mc->provider);
+
+	return err;
+}
+
 static int tegra_mc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -702,6 +813,13 @@ static int tegra_mc_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_INTERCONNECT)) {
+		err = tegra_mc_interconnect_setup(mc);
+		if (err)
+			dev_err(&pdev->dev, "failed to initialize ICC: %d\n",
+				err);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index afa3ba45c9e6..abeb6a2cc36a 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -115,4 +115,12 @@ extern const struct tegra_mc_soc tegra132_mc_soc;
 extern const struct tegra_mc_soc tegra210_mc_soc;
 #endif
 
+/*
+ * These IDs are for internal use of Tegra's ICC, the values are chosen
+ * such that they don't conflict with the device-tree ICC node IDs.
+ */
+#define TEGRA_ICC_EMC		1000
+#define TEGRA_ICC_EMEM		2000
+#define TEGRA_ICC_MC		3000
+
 #endif /* MEMORY_TEGRA_MC_H */
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 1238e35653d1..71de023f9f47 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -7,6 +7,7 @@
 #define __SOC_TEGRA_MC_H__
 
 #include <linux/err.h>
+#include <linux/interconnect-provider.h>
 #include <linux/reset-controller.h>
 #include <linux/types.h>
 
@@ -178,6 +179,8 @@ struct tegra_mc {
 
 	struct reset_controller_dev reset;
 
+	struct icc_provider provider;
+
 	spinlock_t lock;
 };
 
-- 
2.26.0

