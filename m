Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AF06FFDBA
	for <lists+linux-pm@lfdr.de>; Fri, 12 May 2023 02:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbjELANl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 May 2023 20:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239616AbjELANk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 May 2023 20:13:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671F5659C
        for <linux-pm@vger.kernel.org>; Thu, 11 May 2023 17:13:38 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f13d8f74abso10500404e87.0
        for <linux-pm@vger.kernel.org>; Thu, 11 May 2023 17:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683850416; x=1686442416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdUICkWxwUjuhvguH8xyDqg9XBNhUuJ2REN1syLS9vw=;
        b=S0JI8pIHiDDfAQyqo5n8SyLVtpVs8i1x4dltjWNMz6n8oiyi8O+rwbbvSX5covn/lG
         ogXh4BxnF0Fh+jyPAJirtXYFyyxkRrK6z6lxJFbAJdopZ0zYhD5MOMTYmbbw5Qg9TWBp
         i8MdeOnAgKSzB08XHO3zL4nxk9mKsKjIKJ0f8qFLC4fDeSNctsf31u5gj0VkcC/QfqRZ
         1ayjq4MmeNVOzXgIJdh94DoEipH3tlDv+oeC3b5HxsOSmmYiJJ/LMOjzkK6Axtx8cfpf
         C3VWAD8aMxMGFKZUk1coHl0Ij8hhYVeDDWdRnAqnSz3qqbnyBv0li/usAXDVWmoESHjG
         hRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683850416; x=1686442416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdUICkWxwUjuhvguH8xyDqg9XBNhUuJ2REN1syLS9vw=;
        b=NouS70/oi2wHPND9ptgZ965J/DatFX1qkXYaNKFi8Bme8zM/+m2Jd4AB5kw55UlNgO
         fjts0w4UeQZUw4Y3EfdU0NtJGvCfs3j+X8t11nqp1sXPELk0JT1OFHRNGLf8RDVatLx8
         6sJlQO4swcjYDoCzCXUKYtpOaTc1RHwTH7PCQGE7aDm92YTkvLu/iRoI/e74Qo7IvDMl
         UCMV5sUQQf3aezCMaYlEffsATGrmlvQce+TK85YJH0RWw/G9OMd+1rBYZmf+zSmT93AV
         NwKgnCEBcgyX/lBso6ziZyjICMBbSXSCRq8j42D0C589g7Vp9YsTAstW53qkx4LxRrRz
         6r/g==
X-Gm-Message-State: AC+VfDz8EmnPVsgeP0XryIChVFMelfc1TuUUqxQu05sWYR+mcOxI9uhN
        e8cWbByojh0x6d27cbA7lxRS6A==
X-Google-Smtp-Source: ACHHUZ4jKyaEkSkcBf4+gAXytzszVQic0VODR+8n7aItYYqrHpQhJWnlXNZaeJ3vn/2IJv1CtF3DNA==
X-Received: by 2002:a19:7403:0:b0:4ef:ff42:b13 with SMTP id v3-20020a197403000000b004efff420b13mr2890798lfe.65.1683850416500;
        Thu, 11 May 2023 17:13:36 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p15-20020ac246cf000000b004f13c3cb9ffsm1258109lfo.200.2023.05.11.17.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 17:13:35 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v6 2/4] interconnect: add clk-based icc provider support
Date:   Fri, 12 May 2023 03:13:32 +0300
Message-Id: <20230512001334.2983048-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512001334.2983048-1-dmitry.baryshkov@linaro.org>
References: <20230512001334.2983048-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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

Tested-by: Yassine Oudjana <y.oudjana@protonmail.com>
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
2.39.2

