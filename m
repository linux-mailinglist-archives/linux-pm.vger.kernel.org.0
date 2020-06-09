Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6371F3BCF
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 15:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgFINQ2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 09:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbgFINPC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 09:15:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD71C03E97C;
        Tue,  9 Jun 2020 06:15:00 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y11so23350788ljm.9;
        Tue, 09 Jun 2020 06:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZdqfFhous9LJ7xyXzWsP8eFwuiJA//aWLNwZ1NRylHU=;
        b=q/Q3279A8T1Aa8w1vceSd1gO393TTmCcEgws0BzThqIByXo/vuPlcJOPFWhCU0saMZ
         jv+ecsre/4BafUS4kfZlE10Zt6QK0Q1cI8tN2VfESJ3kly6ym3umTUd+LaLSZnNN6l1B
         RlL8EPg2JzZIsQbR+LInObnijGxqL+lY0er+vKCtenTFayHxRRhXYtZbRcp0aYkIVhNo
         qUdtEViVrn7vHLnD8qdQjY+4MJmcjIJN2lCYLkZ+ILmMwz7kJYvXbtjEGGOR9OVjwrp3
         AAWGtqXxFDPyn0GKioovqBw7eDiL1oet5XNnBZwHcj8Vawu1Kpc4Gsny/0tTfY6+sa/e
         7j0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZdqfFhous9LJ7xyXzWsP8eFwuiJA//aWLNwZ1NRylHU=;
        b=sBv0VIInHirLR4BOEfC8nbDNvtOfgZhH/FDxWFetFDXYcDW3DIi6mGaIx30YfRAis0
         /mx2isaDg3CPXFS/9F1YgrdB1JSJVe9id5Q/jwVyfBl2B9+gXSgV5z14MMG683ZuuTM/
         vboy8OZ4ymhtCnjvdXxN9xNHbsUvlvugwgWR+XAHoFcCOwu/5HqZHNphWIgXac6zfdJY
         EDkzhYA9wJykvCPbdx5zCOzYvfffYeQutITuUx6YJOUDhqZj//rubdwk/9Hk2LBNI9C+
         hXG+rcGRbrJ08wA6BGq3KAaPWXIln1Qnv6gZBGBLTF/v90wMphEU3Edd6g1voS3UsTQn
         G0Pw==
X-Gm-Message-State: AOAM532FXJ+SuBAu7zmWe2qn9AZNI9Q+4jGupV4GZ4rJMkpqzJZkQVV/
        7MigjsfjAfeA1qR9d+8NTQQ=
X-Google-Smtp-Source: ABdhPJxjCGqibKAhYqx6jWx/A2rwQ6iUlJAF96095Hdmp5JKgJSYQXIyGUkLftZy5G4Cb3bXJazPAg==
X-Received: by 2002:a05:651c:1044:: with SMTP id x4mr9579067ljm.409.1591708499227;
        Tue, 09 Jun 2020 06:14:59 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id l22sm4323522lji.120.2020.06.09.06.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:14:58 -0700 (PDT)
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
Subject: [PATCH v4 28/37] memory: tegra: Register as interconnect provider
Date:   Tue,  9 Jun 2020 16:13:55 +0300
Message-Id: <20200609131404.17523-29-digetx@gmail.com>
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
 drivers/memory/tegra/Kconfig |   1 +
 drivers/memory/tegra/mc.c    | 114 +++++++++++++++++++++++++++++++++++
 drivers/memory/tegra/mc.h    |   8 +++
 include/soc/tegra/mc.h       |   3 +
 4 files changed, 126 insertions(+)

diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
index 5bf75b316a2f..7055fdef2c32 100644
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
index 772aa021b5f6..7ef7ac9e103e 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -594,6 +594,118 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
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
+		goto err_msg;
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
+del_provider:
+	icc_provider_del(&mc->provider);
+err_msg:
+	dev_err(mc->dev, "failed to initialize ICC: %d\n", err);
+
+	return err;
+}
+
 static int tegra_mc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -702,6 +814,8 @@ static int tegra_mc_probe(struct platform_device *pdev)
 		}
 	}
 
+	tegra_mc_interconnect_setup(mc);
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

