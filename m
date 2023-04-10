Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055CD6DCBEB
	for <lists+linux-pm@lfdr.de>; Mon, 10 Apr 2023 22:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjDJUAY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Apr 2023 16:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjDJUAW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2023 16:00:22 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6401FDD
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 13:00:19 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q15so2680611ljp.5
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 13:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681156817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKmjFE2HtWohin9kxgOPiueeSHMo67vsdwgEdddjDs0=;
        b=o/iGEuJFDfe+kganhwAuNdt6X+FutLQ0zOaKoGcV5P2PvxtMehmX4gq3h3471uS6XJ
         khsgM0dhpcNBI/r4B34KlEGcYQENxT79ulXef5luFo6twYlMHe1IdwEW3Pqq1b5s4oOZ
         VT3Uxwck94OVMVdZZf1iUhFY6UvevX2cEuzngU+vR3WYQ6ZpAIXcBdqjr9RbIMR98+wl
         pJIy6pVPVBXz71jLUFmtqRLLDYMrRO+NSsUytuCI7VPkVf268kfEbgYkcFdCSsdICQZ1
         WQ9IgWedfZVOLlFgIyzf1t120Z6oHCkH8SDo/t1iVrLNxgIiYbtNnxR3pCTyLv8R1447
         qifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681156817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKmjFE2HtWohin9kxgOPiueeSHMo67vsdwgEdddjDs0=;
        b=7gKlzJ+Q5YndPEDrPWnDfz7dhY8LrFilZgID20efWTRPMA8AGCGrZ6IHK85v++CVH7
         rAGpMZxrFvY4u9/5AbYGUvIdPdzN0A8BGwaObBbPbd2ixj8auZH041Vqghj9m8lp6b3E
         PE2BNLirNbQDlJCmDI86T11fLwMURSnM997LIVtg3FO5i/HrM12PxtVuWwdJ92G4LiwU
         gdUgFbfjuKNiOzqnnFag9UGCcfMU7yvxPyJRsIeqWv5ax2FQkTZFZctq1WevMXr7XQuU
         zjVJJuefa1rkS45EVsVYIggbE/qoOyDywwm1JjnkQDonjskfuwXJy5KzDVzlCj0dkAjM
         fbiA==
X-Gm-Message-State: AAQBX9ej51WSDzCNXKdv5OGXG9N/sjA5mjtzXrcBEkneepBnvwurbuNu
        +S71xKYETfXbyBCJzBFMkqJaenQNOcbPFXhFiCA=
X-Google-Smtp-Source: AKy350aXPgBLGmXGG0T2wx80lrUREkRJcYFdNpPklRDF2gScOTuZIP3gESBeeOlcltkINi4MKLXzIw==
X-Received: by 2002:a2e:b0c7:0:b0:2a7:8301:a977 with SMTP id g7-20020a2eb0c7000000b002a78301a977mr662435ljl.49.1681156817362;
        Mon, 10 Apr 2023 13:00:17 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id z2-20020a2e8e82000000b002a7729eea3dsm973482ljk.88.2023.04.10.13.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 13:00:16 -0700 (PDT)
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
Subject: [PATCH v5 2/4] interconnect: add clk-based icc provider support
Date:   Mon, 10 Apr 2023 23:00:12 +0300
Message-Id: <20230410200014.432418-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230410200014.432418-1-dmitry.baryshkov@linaro.org>
References: <20230410200014.432418-1-dmitry.baryshkov@linaro.org>
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

For some devices it is useful to export clocks as interconnect providers,
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

