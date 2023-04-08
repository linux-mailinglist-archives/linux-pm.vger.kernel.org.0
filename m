Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0CA6DBE09
	for <lists+linux-pm@lfdr.de>; Sun,  9 Apr 2023 01:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjDHXtj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 8 Apr 2023 19:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjDHXti (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Apr 2023 19:49:38 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2947ED8
        for <linux-pm@vger.kernel.org>; Sat,  8 Apr 2023 16:49:36 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m4so2282929lfj.13
        for <linux-pm@vger.kernel.org>; Sat, 08 Apr 2023 16:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680997775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6S1s6++auYDEENMMTggGEkaJU/UhT2an1W38jbLrPM=;
        b=TrGEAciPkxQ5wO0DePjfZko1Z7SWsCR5qaK/PB+meIHdt2Dw5O3tgBr6XhvZgzVJW1
         8WKJHtbNOdWb+7/xi5OhGqrk/pMHCIxP6gw1/NBxFKuq4sfamv04e0WNAtHpSG/Eisb6
         7SYhLM6xFDm+3iu+wy1ds2+tv7OtUmHPnKyCbuyWBeBsbRTVKSGDqx4Zt3SWviJU+fCQ
         HeO938T2MwvMYsqjnVWALeSOKr++v9ODfM5s0vUImTfnh1OY0pOg8z+Lyzc1vvmEmTF2
         6Ez2BtXmrQ4IRIOxLlharn2k0c2zi7z/OXRNE04fxD+OQpyJZ3y3KN41sUHtrju+WfEj
         RpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680997775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6S1s6++auYDEENMMTggGEkaJU/UhT2an1W38jbLrPM=;
        b=caC8vugwcOp5GSmYkXwZVp4yChX66HHygsUDZGjeufiy4pckLMQz9Da3vn5MumO1Q2
         V9d9wXVnKmMHeQod8IJmJAYfFTxbYeDRYuGlEPt5tKIXqzwNc4r5gz31u55Xx2Whgnhq
         TH3KUOF8B3qDwlWM1ssdi6VUP8AoCcKM1pbO8W0M99BvzV1LJzmVtrJADatlZMgz23Hf
         Dxr8icszoD/38Ni4XpXP6+Mla5eEsGihqEQCtvXCgNdBBqxGJQtSB2xCQ4+7BZVzs8tm
         0AQBXYxBkJaeUZXnNGDI5jo/SD/lX0KiWlnmaPJ1akmRfD/4QxSUOCEuSQEIFcNjXvHX
         mofw==
X-Gm-Message-State: AAQBX9e3qdNeWuF0v5fwVx3MNX/tqOz42cqXZnwBB9PqdakpNhuP28dO
        tNxRZOlRTIF48gs+hXRMg2dDCQ==
X-Google-Smtp-Source: AKy350YGEGr4P25ONAZuUKAPLjf95esIyFGPZdeHyZjf6wxUOnp3r26eFGsAQl7xjW2/sQ9e5go07Q==
X-Received: by 2002:ac2:482d:0:b0:4b6:e95b:5b41 with SMTP id 13-20020ac2482d000000b004b6e95b5b41mr795932lft.22.1680997774857;
        Sat, 08 Apr 2023 16:49:34 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id q26-20020ac2529a000000b004e7fa99f3f4sm1353008lfm.265.2023.04.08.16.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 16:49:34 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 2/4] iterconnect: add clk-based icc provider support
Date:   Sun,  9 Apr 2023 02:49:30 +0300
Message-Id: <20230408234932.2363302-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230408234932.2363302-1-dmitry.baryshkov@linaro.org>
References: <20230408234932.2363302-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For some devices it is useful to export clocks as interconect providers,
if the clock corresponds to bus bandwidth.

For example, on MSM8996 the cluster interconnect clock should be scaled
according to the cluster frequencies. Exporting it as an interconnect
allows one to properly describe this as the cluster bandwidth
requirements.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/Kconfig     |   6 ++
 drivers/interconnect/Makefile    |   2 +
 drivers/interconnect/icc-clk.c   | 168 +++++++++++++++++++++++++++++++
 include/linux/interconnect-clk.h |  22 ++++
 4 files changed, 198 insertions(+)
 create mode 100644 drivers/interconnect/icc-clk.c
 create mode 100644 include/linux/interconnect-clk.h

diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
index d637a89d4695..5faa8d2aecff 100644
--- a/drivers/interconnect/Kconfig
+++ b/drivers/interconnect/Kconfig
@@ -15,4 +15,10 @@ source "drivers/interconnect/imx/Kconfig"
 source "drivers/interconnect/qcom/Kconfig"
 source "drivers/interconnect/samsung/Kconfig"
 
+config INTERCONNECT_CLK
+	tristate
+	depends on COMMON_CLK
+	help
+	  Support for wrapping clocks into the interconnect nodes.
+
 endif
diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index 97d393fd638d..5604ce351a9f 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -7,3 +7,5 @@ obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
 obj-$(CONFIG_INTERCONNECT_IMX)		+= imx/
 obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
 obj-$(CONFIG_INTERCONNECT_SAMSUNG)	+= samsung/
+
+obj-$(CONFIG_INTERCONNECT_CLK)		+= icc-clk.o
diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
new file mode 100644
index 000000000000..0db3b654548b
--- /dev/null
+++ b/drivers/interconnect/icc-clk.c
@@ -0,0 +1,168 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/interconnect-clk.h>
+#include <linux/interconnect-provider.h>
+
+struct icc_clk_node {
+	struct clk *clk;
+	bool enabled;
+};
+
+struct icc_clk_provider {
+	struct icc_provider provider;
+	int num_clocks;
+	struct icc_clk_node clocks[];
+};
+
+#define to_icc_clk_provider(_provider) \
+	container_of(_provider, struct icc_clk_provider, provider)
+
+static int icc_clk_set(struct icc_node *src, struct icc_node *dst)
+{
+	struct icc_clk_node *qn = src->data;
+	int ret;
+
+	if (!qn || !qn->clk)
+		return 0;
+
+	if (!src->peak_bw) {
+		if (qn->enabled)
+			clk_disable_unprepare(qn->clk);
+		qn->enabled = false;
+
+		return 0;
+	}
+
+	if (!qn->enabled) {
+		ret = clk_prepare_enable(qn->clk);
+		if (ret)
+			return ret;
+		qn->enabled = true;
+	}
+
+	return clk_set_rate(qn->clk, icc_units_to_bps(src->peak_bw));
+}
+
+static int icc_clk_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
+{
+	struct icc_clk_node *qn = node->data;
+
+	if (!qn || !qn->clk)
+		*peak = INT_MAX;
+	else
+		*peak = Bps_to_icc(clk_get_rate(qn->clk));
+
+	return 0;
+}
+
+/**
+ * icc_clk_register() - register a new clk-based interconnect provider
+ * @dev: device supporting this provider
+ * @first_id: an ID of the first provider's node
+ * @num_clocks: number of instances of struct icc_clk_data
+ * @data: data for the provider
+ *
+ * Registers and returns a clk-based interconnect provider. It is a simple
+ * wrapper around COMMON_CLK framework, allowing other devices to vote on the
+ * clock rate.
+ *
+ * Return: 0 on success, or an error code otherwise
+ */
+struct icc_provider *icc_clk_register(struct device *dev,
+				      unsigned int first_id,
+				      unsigned int num_clocks,
+				      const struct icc_clk_data *data)
+{
+	struct icc_clk_provider *qp;
+	struct icc_provider *provider;
+	struct icc_onecell_data *onecell;
+	struct icc_node *node;
+	int ret, i, j;
+
+	onecell = devm_kzalloc(dev, struct_size(onecell, nodes, 2 * num_clocks), GFP_KERNEL);
+	if (!onecell)
+		return ERR_PTR(-ENOMEM);
+
+	qp = devm_kzalloc(dev, struct_size(qp, clocks, num_clocks), GFP_KERNEL);
+	if (!qp)
+		return ERR_PTR(-ENOMEM);
+
+	qp->num_clocks = num_clocks;
+
+	provider = &qp->provider;
+	provider->dev = dev;
+	provider->get_bw = icc_clk_get_bw;
+	provider->set = icc_clk_set;
+	provider->aggregate = icc_std_aggregate;
+	provider->xlate = of_icc_xlate_onecell;
+	INIT_LIST_HEAD(&provider->nodes);
+	provider->data = onecell;
+
+	icc_provider_init(provider);
+
+	for (i = 0, j = 0; i < num_clocks; i++) {
+		qp->clocks[i].clk = data[i].clk;
+
+		node = icc_node_create(first_id + j);
+		if (IS_ERR(node)) {
+			ret = PTR_ERR(node);
+			goto err;
+		}
+
+		node->name = devm_kasprintf(dev, GFP_KERNEL, "%s_master", data[i].name);
+		node->data = &qp->clocks[i];
+		icc_node_add(node, provider);
+		/* link to the next node, slave */
+		icc_link_create(node, first_id + j + 1);
+		onecell->nodes[j++] = node;
+
+		node = icc_node_create(first_id + j);
+		if (IS_ERR(node)) {
+			ret = PTR_ERR(node);
+			goto err;
+		}
+
+		node->name = devm_kasprintf(dev, GFP_KERNEL, "%s_slave", data[i].name);
+		/* no data for slave node */
+		icc_node_add(node, provider);
+		onecell->nodes[j++] = node;
+	}
+
+	onecell->num_nodes = j;
+
+	ret = icc_provider_register(provider);
+	if (ret)
+		goto err;
+
+	return provider;
+
+err:
+	icc_nodes_remove(provider);
+
+	return ERR_PTR(ret);
+}
+
+/**
+ * icc_clk_unregister() - unregister a previously registered clk interconnect provider
+ * @provider: provider returned by icc_clk_register()
+ */
+void icc_clk_unregister(struct icc_provider *provider)
+{
+	struct icc_clk_provider *qp = container_of(provider, struct icc_clk_provider, provider);
+	int i;
+
+	icc_provider_deregister(&qp->provider);
+	icc_nodes_remove(&qp->provider);
+
+	for (i = 0; i < qp->num_clocks; i++) {
+		struct icc_clk_node *qn = &qp->clocks[i];
+
+		if (qn->enabled)
+			clk_disable_unprepare(qn->clk);
+	}
+}
diff --git a/include/linux/interconnect-clk.h b/include/linux/interconnect-clk.h
new file mode 100644
index 000000000000..0cd80112bea5
--- /dev/null
+++ b/include/linux/interconnect-clk.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Ltd.
+ */
+
+#ifndef __LINUX_INTERCONNECT_CLK_H
+#define __LINUX_INTERCONNECT_CLK_H
+
+struct device;
+
+struct icc_clk_data {
+	struct clk *clk;
+	const char *name;
+};
+
+struct icc_provider *icc_clk_register(struct device *dev,
+				      unsigned int first_id,
+				      unsigned int num_clocks,
+				      const struct icc_clk_data *data);
+void icc_clk_unregister(struct icc_provider *provider);
+
+#endif
-- 
2.30.2

