Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1854C1971A0
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 03:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgC3BJt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 21:09:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43322 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbgC3BJs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 21:09:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id g27so16239083ljn.10;
        Sun, 29 Mar 2020 18:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X5VcCh6eWMr9J37Xsf4tsyddBbuWfmiDNSVOMhCKemo=;
        b=b5rOMWO+3GLaJSJN3NaO51/e76l80sUm8FMWOvxcEKGmHEDls6ROUnIqCrEKrzlJcO
         N3PpRx/tVJZfG5xi/5b5ATmYpg57lHcfXtTWLU2pgwb5yXTMjOkrvCZ9Nl1gS1mFKzX3
         kD9TdbPWtKhhH2vQhwAzD+EOvJTYYqf0u/Bk2V0Ic6UCo//nNh3ZvUwh9HoHo5t4Ercp
         NLfExVyx2nUkXADa1KDkSPQ90e+ZHK9nfVDyUUwJP+WDwkhDTS7Dk12fFIxsk3f4Y4SU
         /YvXCgp/d5fV2d45rT0Al30tw44Y5tfC+m34Yhtp7+JIUB6Rz11CxmIDyZpPI1mRJ4NC
         0iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X5VcCh6eWMr9J37Xsf4tsyddBbuWfmiDNSVOMhCKemo=;
        b=t33klstrevJ5eyGOT9LBoUSKml9Ep8El51yk5moXrcwZP+0mhYXzpuCSltf/crxVLK
         VrtjnYVsmP2IBfieVuIL8BOiNdhzRQOG6Kyw4wi7RX4Nt84cKJshkvwDCY98CBHFySPq
         SZq8xze/FNbuFyEcppnuSLQbfYmJ+QzmpOIla6B6fuyOb6fBwpn4ujpZ/oY6afGfLqpN
         OjcaDVLXlRRd8ZlXWXr4/vh2e1CRXi8fUTr908hd+kBMeADEX88OBTqOT837oYFgqOI0
         YAGO0pe6gGv0BWYrKp5g/2qy3gmRyOy0iKOwdfSzXJ2X3C1p451j76MLhZX3B3XJ9M3u
         agsQ==
X-Gm-Message-State: AGi0PubkCScq3nk/kc9XBFIGQ0SDoshl1EYtTlH7UKLzZJODuWW3rFiK
        +V+7oGosU2iedvEJxMFZrSU=
X-Google-Smtp-Source: APiQypKhd7xEcrpcg3+qT1NGCf3mvbNjU1UXyNo0WHIQkeyyHkHVYwc+qMtCRcL9+xBspJXRW6opGQ==
X-Received: by 2002:a2e:b4f1:: with SMTP id s17mr3231463ljm.283.1585530585762;
        Sun, 29 Mar 2020 18:09:45 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id f23sm2449005lja.60.2020.03.29.18.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:09:45 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 11/22] memory: tegra: Register as interconnect provider
Date:   Mon, 30 Mar 2020 04:08:53 +0300
Message-Id: <20200330010904.27643-12-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330010904.27643-1-digetx@gmail.com>
References: <20200330010904.27643-1-digetx@gmail.com>
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
index ec8403557ed4..bcf0478c5f5a 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -591,6 +591,117 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
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
@@ -699,6 +810,13 @@ static int tegra_mc_probe(struct platform_device *pdev)
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
index 957c6eb74ff9..bb13747cd96c 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -114,4 +114,12 @@ extern const struct tegra_mc_soc tegra132_mc_soc;
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
2.25.1

