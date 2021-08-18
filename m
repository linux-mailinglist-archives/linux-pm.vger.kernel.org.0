Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD223EF7BE
	for <lists+linux-pm@lfdr.de>; Wed, 18 Aug 2021 03:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbhHRB6O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 21:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbhHRB6N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 21:58:13 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FBFC0613CF
        for <linux-pm@vger.kernel.org>; Tue, 17 Aug 2021 18:57:37 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i9so1109616lfg.10
        for <linux-pm@vger.kernel.org>; Tue, 17 Aug 2021 18:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YYvAhJOldSZLXUhaHTuPPBBpuvIgh+JpKftKBre0BsE=;
        b=H6yOoukBFnrqhGHBUe7he2mV6HWDDx/t2ql7Gp7Xqi9mJ/d4pIsr6L/ryMXUkui42Z
         CDQSVeFINpmWx7rCgvnLMQjif6rU0Ncpla3/UI/LTn1IIzWjykOP6yEaRPrSOrLUIBmL
         Gn92sFy2ZFzvCDWGSIqEidWSZgKult//Rq9lvgBbkMlreDRSZBXt5VlpNMBdCxo8+vld
         BP5h+VTshWVDqXpXQdsEa5ffbZwFX1PHSUpkRfnByEp0bL0pQq00XfEwfrhjFtQzaiDV
         PXOBrIzL1fPlBt0F6gQgx+f6l2jkWUjoB8udrtauqfOoVKg/LGW7X+q0gI/n4Da+bv9t
         FJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YYvAhJOldSZLXUhaHTuPPBBpuvIgh+JpKftKBre0BsE=;
        b=qStrwAoIWw1CcVhuRCK3lrVyEk75+OlZyrIxhW5/ydW3P/7nAciYnb/JkZ0NfD5Zl0
         ww4u4QCxI5wKbKv2KmbTYNspVCpr8H9TsQguhPnTj6mYh34h0OwFml0gU+WDLPiuIiIJ
         viqpobg7Q5HVpxNXv5ynmXqfC6h8Kceb2E6cIKFi9vMmWRhnDWY2UzNWpJuBGxXAxkDn
         H4PpfavRdT3FXRhTxjwsqVKXFkR9aUfOldUkzKz/SBXebNSAp5W3T0uGT566V5VYGdoT
         WKdnNyUJomft3cE67mKgK1sXzUP+WmcF31e6tsjiIhAa2ChtmnbmxzLQF6EnQg/J55Qn
         TmAg==
X-Gm-Message-State: AOAM533K1dwAtf8IhwjSEp1X8vKxvXZRvVTxbC6vyf2hsiMy9roB3bRl
        HIdY0Qv1dY1vDK1v5w8+uA10vw==
X-Google-Smtp-Source: ABdhPJx9qxvukEWCw7GrqxloXOYdy1WdTQ0VSHe/PTYeFk3sPWhaxe1racjtoA9GcmvFDTf30a2N8g==
X-Received: by 2002:a05:6512:110b:: with SMTP id l11mr4518482lfg.199.1629251855515;
        Tue, 17 Aug 2021 18:57:35 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y8sm349500lfh.249.2021.08.17.18.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 18:57:35 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 1/5] interconnect: icc-rpm: move bus clocks handling into qnoc_probe
Date:   Wed, 18 Aug 2021 04:57:28 +0300
Message-Id: <20210818015732.1717810-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210818015732.1717810-1-dmitry.baryshkov@linaro.org>
References: <20210818015732.1717810-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

All icc-rpm drivers use the same set of bus clocks. Move handling of bus
clocks to qnoc_probe. This both simplifies the code and allows using
qnoc_probe as device's probe funcion.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 22 ++++++++++++++--------
 drivers/interconnect/qcom/icc-rpm.h |  5 ++---
 drivers/interconnect/qcom/msm8916.c | 13 +------------
 drivers/interconnect/qcom/msm8939.c | 13 +------------
 drivers/interconnect/qcom/qcs404.c  | 13 +------------
 5 files changed, 19 insertions(+), 47 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 54de49ca7808..394f515cc88d 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -86,8 +86,11 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	return 0;
 }
 
-int qnoc_probe(struct platform_device *pdev, size_t cd_size, int cd_num,
-	       const struct clk_bulk_data *cd)
+static const char * const bus_clocks[] = {
+	"bus", "bus_a",
+};
+
+int qnoc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct qcom_icc_desc *desc;
@@ -97,6 +100,8 @@ int qnoc_probe(struct platform_device *pdev, size_t cd_size, int cd_num,
 	struct qcom_icc_provider *qp;
 	struct icc_node *node;
 	size_t num_nodes, i;
+	const char * const * cds;
+	int cd_num;
 	int ret;
 
 	/* wait for the RPM proxy */
@@ -110,7 +115,10 @@ int qnoc_probe(struct platform_device *pdev, size_t cd_size, int cd_num,
 	qnodes = desc->nodes;
 	num_nodes = desc->num_nodes;
 
-	qp = devm_kzalloc(dev, sizeof(*qp), GFP_KERNEL);
+	cds = bus_clocks;
+	cd_num = ARRAY_SIZE(bus_clocks);
+
+	qp = devm_kzalloc(dev, struct_size(qp, bus_clks, cd_num), GFP_KERNEL);
 	if (!qp)
 		return -ENOMEM;
 
@@ -119,12 +127,10 @@ int qnoc_probe(struct platform_device *pdev, size_t cd_size, int cd_num,
 	if (!data)
 		return -ENOMEM;
 
-	qp->bus_clks = devm_kmemdup(dev, cd, cd_size,
-				    GFP_KERNEL);
-	if (!qp->bus_clks)
-		return -ENOMEM;
-
+	for (i = 0; i < cd_num; i++)
+		qp->bus_clks[i].id = cds[i];
 	qp->num_clks = cd_num;
+
 	ret = devm_clk_bulk_get(dev, qp->num_clks, qp->bus_clks);
 	if (ret)
 		return ret;
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 79a6f68249c1..f4b05c20c097 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -22,8 +22,8 @@
  */
 struct qcom_icc_provider {
 	struct icc_provider provider;
-	struct clk_bulk_data *bus_clks;
 	int num_clks;
+	struct clk_bulk_data bus_clks[];
 };
 
 /**
@@ -66,8 +66,7 @@ struct qcom_icc_desc {
 	}
 
 
-int qnoc_probe(struct platform_device *pdev, size_t cd_size, int cd_num,
-	       const struct clk_bulk_data *cd);
+int qnoc_probe(struct platform_device *pdev);
 int qnoc_remove(struct platform_device *pdev);
 
 #endif
diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
index fc3689c8947a..fc0d48d2997a 100644
--- a/drivers/interconnect/qcom/msm8916.c
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -105,11 +105,6 @@ enum {
 	MSM8916_SNOC_PNOC_SLV,
 };
 
-static const struct clk_bulk_data msm8916_bus_clocks[] = {
-	{ .id = "bus" },
-	{ .id = "bus_a" },
-};
-
 DEFINE_QNODE(bimc_snoc_mas, MSM8916_BIMC_SNOC_MAS, 8, -1, -1, MSM8916_BIMC_SNOC_SLV);
 DEFINE_QNODE(bimc_snoc_slv, MSM8916_BIMC_SNOC_SLV, 8, -1, -1, MSM8916_SNOC_INT_0, MSM8916_SNOC_INT_1);
 DEFINE_QNODE(mas_apss, MSM8916_MASTER_AMPSS_M0, 8, -1, -1, MSM8916_SLAVE_EBI_CH0, MSM8916_BIMC_SNOC_MAS, MSM8916_SLAVE_AMPSS_L2);
@@ -305,12 +300,6 @@ static struct qcom_icc_desc msm8916_pcnoc = {
 	.num_nodes = ARRAY_SIZE(msm8916_pcnoc_nodes),
 };
 
-static int msm8916_qnoc_probe(struct platform_device *pdev)
-{
-	return qnoc_probe(pdev, sizeof(msm8916_bus_clocks),
-			  ARRAY_SIZE(msm8916_bus_clocks), msm8916_bus_clocks);
-}
-
 static const struct of_device_id msm8916_noc_of_match[] = {
 	{ .compatible = "qcom,msm8916-bimc", .data = &msm8916_bimc },
 	{ .compatible = "qcom,msm8916-pcnoc", .data = &msm8916_pcnoc },
@@ -320,7 +309,7 @@ static const struct of_device_id msm8916_noc_of_match[] = {
 MODULE_DEVICE_TABLE(of, msm8916_noc_of_match);
 
 static struct platform_driver msm8916_noc_driver = {
-	.probe = msm8916_qnoc_probe,
+	.probe = qnoc_probe,
 	.remove = qnoc_remove,
 	.driver = {
 		.name = "qnoc-msm8916",
diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
index 20f31a1b4192..4a5a2ec64960 100644
--- a/drivers/interconnect/qcom/msm8939.c
+++ b/drivers/interconnect/qcom/msm8939.c
@@ -110,11 +110,6 @@ enum {
 	MSM8939_SNOC_PNOC_SLV,
 };
 
-static const struct clk_bulk_data msm8939_bus_clocks[] = {
-	{ .id = "bus" },
-	{ .id = "bus_a" },
-};
-
 DEFINE_QNODE(bimc_snoc_mas, MSM8939_BIMC_SNOC_MAS, 8, -1, -1, MSM8939_BIMC_SNOC_SLV);
 DEFINE_QNODE(bimc_snoc_slv, MSM8939_BIMC_SNOC_SLV, 16, -1, 2, MSM8939_SNOC_INT_0, MSM8939_SNOC_INT_1);
 DEFINE_QNODE(mas_apss, MSM8939_MASTER_AMPSS_M0, 16, -1, -1, MSM8939_SLAVE_EBI_CH0, MSM8939_BIMC_SNOC_MAS, MSM8939_SLAVE_AMPSS_L2);
@@ -326,12 +321,6 @@ static struct qcom_icc_desc msm8939_pcnoc = {
 	.num_nodes = ARRAY_SIZE(msm8939_pcnoc_nodes),
 };
 
-static int msm8939_qnoc_probe(struct platform_device *pdev)
-{
-	return qnoc_probe(pdev, sizeof(msm8939_bus_clocks),
-			  ARRAY_SIZE(msm8939_bus_clocks), msm8939_bus_clocks);
-}
-
 static const struct of_device_id msm8939_noc_of_match[] = {
 	{ .compatible = "qcom,msm8939-bimc", .data = &msm8939_bimc },
 	{ .compatible = "qcom,msm8939-pcnoc", .data = &msm8939_pcnoc },
@@ -342,7 +331,7 @@ static const struct of_device_id msm8939_noc_of_match[] = {
 MODULE_DEVICE_TABLE(of, msm8939_noc_of_match);
 
 static struct platform_driver msm8939_noc_driver = {
-	.probe = msm8939_qnoc_probe,
+	.probe = qnoc_probe,
 	.remove = qnoc_remove,
 	.driver = {
 		.name = "qnoc-msm8939",
diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index 36a7e30a00be..0f2fff230b13 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -92,11 +92,6 @@ enum {
 	QCS404_SLAVE_LPASS,
 };
 
-static const struct clk_bulk_data qcs404_bus_clocks[] = {
-	{ .id = "bus" },
-	{ .id = "bus_a" },
-};
-
 DEFINE_QNODE(mas_apps_proc, QCS404_MASTER_AMPSS_M0, 8, 0, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
 DEFINE_QNODE(mas_oxili, QCS404_MASTER_GRAPHICS_3D, 8, -1, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
 DEFINE_QNODE(mas_mdp, QCS404_MASTER_MDP_PORT0, 8, -1, -1, QCS404_SLAVE_EBI_CH0, QCS404_BIMC_SNOC_SLV);
@@ -269,12 +264,6 @@ static struct qcom_icc_desc qcs404_snoc = {
 };
 
 
-static int qcs404_qnoc_probe(struct platform_device *pdev)
-{
-	return qnoc_probe(pdev, sizeof(qcs404_bus_clocks),
-			  ARRAY_SIZE(qcs404_bus_clocks), qcs404_bus_clocks);
-}
-
 static const struct of_device_id qcs404_noc_of_match[] = {
 	{ .compatible = "qcom,qcs404-bimc", .data = &qcs404_bimc },
 	{ .compatible = "qcom,qcs404-pcnoc", .data = &qcs404_pcnoc },
@@ -284,7 +273,7 @@ static const struct of_device_id qcs404_noc_of_match[] = {
 MODULE_DEVICE_TABLE(of, qcs404_noc_of_match);
 
 static struct platform_driver qcs404_noc_driver = {
-	.probe = qcs404_qnoc_probe,
+	.probe = qnoc_probe,
 	.remove = qnoc_remove,
 	.driver = {
 		.name = "qnoc-qcs404",
-- 
2.32.0

