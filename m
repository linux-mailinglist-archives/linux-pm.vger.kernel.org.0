Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D512A3AF79A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 23:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhFUVph (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 17:45:37 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:25281 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231453AbhFUVph (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Jun 2021 17:45:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624311802; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=70mj8tZUg2WHo1vCadgkpPEjBgFbjeyriK4L5ptGZfs=; b=w+Cf0q4wXWhVqI7UyEd+8ZPAWm3fdlkiSzG90+Fuw4W/PE3jPAT4nUVI5ZFR9osfdsUvDeQ6
 o6cThmjFCBT/BuoMUBF9P8X6cN8fX4yoobtKkC+lXBbrWltr8EGfFUgmrWhMKQl3BejPyawy
 vNFket1+6V214bOTKSdOM2syL9M=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60d107e7e570c056198b46f0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Jun 2021 21:43:03
 GMT
Sender: mdtipton=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 556DAC4338A; Mon, 21 Jun 2021 21:43:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B458C433F1;
        Mon, 21 Jun 2021 21:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B458C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     djakov@kernel.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        okukatla@codeaurora.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH] interconnect: qcom: icc-rpmh: Consolidate probe functions
Date:   Mon, 21 Jun 2021 14:42:41 -0700
Message-Id: <20210621214241.13521-1-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The current probe/remove functions are implemented separately for each
target, but they are almost identical. Replace them with common
functions that can be used across all rpmh targets.

Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>
---

Aside from cleaning up minor inconsistencies and formatting, the new functions
are identical to original per-target functions.

 drivers/interconnect/qcom/icc-rpmh.c | 93 ++++++++++++++++++++++++++
 drivers/interconnect/qcom/icc-rpmh.h |  2 +
 drivers/interconnect/qcom/sc7180.c   | 96 +--------------------------
 drivers/interconnect/qcom/sc7280.c   | 96 +--------------------------
 drivers/interconnect/qcom/sdm845.c   | 99 +---------------------------
 drivers/interconnect/qcom/sdx55.c    | 96 +--------------------------
 drivers/interconnect/qcom/sm8150.c   | 96 +--------------------------
 drivers/interconnect/qcom/sm8250.c   | 96 +--------------------------
 drivers/interconnect/qcom/sm8350.c   | 97 +--------------------------
 9 files changed, 109 insertions(+), 662 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index bf01d09dba6c..e1de186ecc78 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -7,6 +7,7 @@
 #include <linux/interconnect-provider.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 
 #include "bcm-voter.h"
@@ -184,4 +185,96 @@ int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(qcom_icc_bcm_init);
 
+int qcom_icc_rpmh_probe(struct platform_device *pdev)
+{
+	const struct qcom_icc_desc *desc;
+	struct device *dev = &pdev->dev;
+	struct icc_onecell_data *data;
+	struct icc_provider *provider;
+	struct qcom_icc_node **qnodes, *qn;
+	struct qcom_icc_provider *qp;
+	struct icc_node *node;
+	size_t num_nodes, i, j;
+	int ret;
+
+	desc = of_device_get_match_data(dev);
+	if (!desc)
+		return -EINVAL;
+
+	qnodes = desc->nodes;
+	num_nodes = desc->num_nodes;
+
+	qp = devm_kzalloc(dev, sizeof(*qp), GFP_KERNEL);
+	if (!qp)
+		return -ENOMEM;
+
+	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	provider = &qp->provider;
+	provider->dev = dev;
+	provider->set = qcom_icc_set;
+	provider->pre_aggregate = qcom_icc_pre_aggregate;
+	provider->aggregate = qcom_icc_aggregate;
+	provider->xlate_extended = qcom_icc_xlate_extended;
+	INIT_LIST_HEAD(&provider->nodes);
+	provider->data = data;
+
+	qp->dev = dev;
+	qp->bcms = desc->bcms;
+	qp->num_bcms = desc->num_bcms;
+
+	qp->voter = of_bcm_voter_get(qp->dev, NULL);
+	if (IS_ERR(qp->voter))
+		return PTR_ERR(qp->voter);
+
+	ret = icc_provider_add(provider);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < qp->num_bcms; i++)
+		qcom_icc_bcm_init(qp->bcms[i], dev);
+
+	for (i = 0; i < num_nodes; i++) {
+		qn = qnodes[i];
+		if (!qn)
+			continue;
+
+		node = icc_node_create(qn->id);
+		if (IS_ERR(node)) {
+			ret = PTR_ERR(node);
+			goto err;
+		}
+
+		node->name = qn->name;
+		node->data = qn;
+		icc_node_add(node, provider);
+
+		for (j = 0; j < qn->num_links; j++)
+			icc_link_create(node, qn->links[j]);
+
+		data->nodes[i] = node;
+	}
+
+	data->num_nodes = num_nodes;
+	platform_set_drvdata(pdev, qp);
+
+	return 0;
+err:
+	icc_nodes_remove(provider);
+	icc_provider_del(provider);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_icc_rpmh_probe);
+
+int qcom_icc_rpmh_remove(struct platform_device *pdev)
+{
+	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
+
+	icc_nodes_remove(&qp->provider);
+	return icc_provider_del(&qp->provider);
+}
+EXPORT_SYMBOL_GPL(qcom_icc_rpmh_remove);
+
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index e5f61ab989e7..4bfc060529ba 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -134,5 +134,7 @@ int qcom_icc_set(struct icc_node *src, struct icc_node *dst);
 struct icc_node_data *qcom_icc_xlate_extended(struct of_phandle_args *spec, void *data);
 int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev);
 void qcom_icc_pre_aggregate(struct icc_node *node);
+int qcom_icc_rpmh_probe(struct platform_device *pdev);
+int qcom_icc_rpmh_remove(struct platform_device *pdev);
 
 #endif
diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index 8d9044ed18ab..12d59c36df53 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -504,98 +504,6 @@ static struct qcom_icc_desc sc7180_system_noc = {
 	.num_bcms = ARRAY_SIZE(system_noc_bcms),
 };
 
-static int qnoc_probe(struct platform_device *pdev)
-{
-	const struct qcom_icc_desc *desc;
-	struct icc_onecell_data *data;
-	struct icc_provider *provider;
-	struct qcom_icc_node **qnodes;
-	struct qcom_icc_provider *qp;
-	struct icc_node *node;
-	size_t num_nodes, i;
-	int ret;
-
-	desc = device_get_match_data(&pdev->dev);
-	if (!desc)
-		return -EINVAL;
-
-	qnodes = desc->nodes;
-	num_nodes = desc->num_nodes;
-
-	qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
-	if (!qp)
-		return -ENOMEM;
-
-	data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	provider = &qp->provider;
-	provider->dev = &pdev->dev;
-	provider->set = qcom_icc_set;
-	provider->pre_aggregate = qcom_icc_pre_aggregate;
-	provider->aggregate = qcom_icc_aggregate;
-	provider->xlate_extended = qcom_icc_xlate_extended;
-	INIT_LIST_HEAD(&provider->nodes);
-	provider->data = data;
-
-	qp->dev = &pdev->dev;
-	qp->bcms = desc->bcms;
-	qp->num_bcms = desc->num_bcms;
-
-	qp->voter = of_bcm_voter_get(qp->dev, NULL);
-	if (IS_ERR(qp->voter))
-		return PTR_ERR(qp->voter);
-
-	ret = icc_provider_add(provider);
-	if (ret) {
-		dev_err(&pdev->dev, "error adding interconnect provider\n");
-		return ret;
-	}
-
-	for (i = 0; i < qp->num_bcms; i++)
-		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
-
-	for (i = 0; i < num_nodes; i++) {
-		size_t j;
-
-		if (!qnodes[i])
-			continue;
-
-		node = icc_node_create(qnodes[i]->id);
-		if (IS_ERR(node)) {
-			ret = PTR_ERR(node);
-			goto err;
-		}
-
-		node->name = qnodes[i]->name;
-		node->data = qnodes[i];
-		icc_node_add(node, provider);
-
-		for (j = 0; j < qnodes[i]->num_links; j++)
-			icc_link_create(node, qnodes[i]->links[j]);
-
-		data->nodes[i] = node;
-	}
-	data->num_nodes = num_nodes;
-
-	platform_set_drvdata(pdev, qp);
-
-	return 0;
-err:
-	icc_nodes_remove(provider);
-	icc_provider_del(provider);
-	return ret;
-}
-
-static int qnoc_remove(struct platform_device *pdev)
-{
-	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
-
-	icc_nodes_remove(&qp->provider);
-	return icc_provider_del(&qp->provider);
-}
-
 static const struct of_device_id qnoc_of_match[] = {
 	{ .compatible = "qcom,sc7180-aggre1-noc",
 	  .data = &sc7180_aggre1_noc},
@@ -628,8 +536,8 @@ static const struct of_device_id qnoc_of_match[] = {
 MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
-	.probe = qnoc_probe,
-	.remove = qnoc_remove,
+	.probe = qcom_icc_rpmh_probe,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sc7180",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
index 8d1b55c3705c..f8b34f6cbb0d 100644
--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -1802,98 +1802,6 @@ static struct qcom_icc_desc sc7280_system_noc = {
 	.num_bcms = ARRAY_SIZE(system_noc_bcms),
 };
 
-static int qnoc_probe(struct platform_device *pdev)
-{
-	const struct qcom_icc_desc *desc;
-	struct icc_onecell_data *data;
-	struct icc_provider *provider;
-	struct qcom_icc_node **qnodes;
-	struct qcom_icc_provider *qp;
-	struct icc_node *node;
-	size_t num_nodes, i;
-	int ret;
-
-	desc = device_get_match_data(&pdev->dev);
-	if (!desc)
-		return -EINVAL;
-
-	qnodes = desc->nodes;
-	num_nodes = desc->num_nodes;
-
-	qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
-	if (!qp)
-		return -ENOMEM;
-
-	data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	provider = &qp->provider;
-	provider->dev = &pdev->dev;
-	provider->set = qcom_icc_set;
-	provider->pre_aggregate = qcom_icc_pre_aggregate;
-	provider->aggregate = qcom_icc_aggregate;
-	provider->xlate_extended = qcom_icc_xlate_extended;
-	INIT_LIST_HEAD(&provider->nodes);
-	provider->data = data;
-
-	qp->dev = &pdev->dev;
-	qp->bcms = desc->bcms;
-	qp->num_bcms = desc->num_bcms;
-
-	qp->voter = of_bcm_voter_get(qp->dev, NULL);
-	if (IS_ERR(qp->voter))
-		return PTR_ERR(qp->voter);
-
-	ret = icc_provider_add(provider);
-	if (ret) {
-		dev_err(&pdev->dev, "error adding interconnect provider\n");
-		return ret;
-	}
-
-	for (i = 0; i < qp->num_bcms; i++)
-		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
-
-	for (i = 0; i < num_nodes; i++) {
-		size_t j;
-
-		if (!qnodes[i])
-			continue;
-
-		node = icc_node_create(qnodes[i]->id);
-		if (IS_ERR(node)) {
-			ret = PTR_ERR(node);
-			goto err;
-		}
-
-		node->name = qnodes[i]->name;
-		node->data = qnodes[i];
-		icc_node_add(node, provider);
-
-		for (j = 0; j < qnodes[i]->num_links; j++)
-			icc_link_create(node, qnodes[i]->links[j]);
-
-		data->nodes[i] = node;
-	}
-	data->num_nodes = num_nodes;
-
-	platform_set_drvdata(pdev, qp);
-
-	return 0;
-err:
-	icc_nodes_remove(provider);
-	icc_provider_del(provider);
-	return ret;
-}
-
-static int qnoc_remove(struct platform_device *pdev)
-{
-	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
-
-	icc_nodes_remove(&qp->provider);
-	return icc_provider_del(&qp->provider);
-}
-
 static const struct of_device_id qnoc_of_match[] = {
 	{ .compatible = "qcom,sc7280-aggre1-noc",
 	  .data = &sc7280_aggre1_noc},
@@ -1924,8 +1832,8 @@ static const struct of_device_id qnoc_of_match[] = {
 MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
-	.probe = qnoc_probe,
-	.remove = qnoc_remove,
+	.probe = qcom_icc_rpmh_probe,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sc7280",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 366870150cbd..d2195079c228 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -440,101 +440,6 @@ static const struct qcom_icc_desc sdm845_system_noc = {
 	.num_bcms = ARRAY_SIZE(system_noc_bcms),
 };
 
-static int qnoc_probe(struct platform_device *pdev)
-{
-	const struct qcom_icc_desc *desc;
-	struct icc_onecell_data *data;
-	struct icc_provider *provider;
-	struct qcom_icc_node **qnodes;
-	struct qcom_icc_provider *qp;
-	struct icc_node *node;
-	size_t num_nodes, i;
-	int ret;
-
-	desc = device_get_match_data(&pdev->dev);
-	if (!desc)
-		return -EINVAL;
-
-	qnodes = desc->nodes;
-	num_nodes = desc->num_nodes;
-
-	qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
-	if (!qp)
-		return -ENOMEM;
-
-	data = devm_kzalloc(&pdev->dev, struct_size(data, nodes, num_nodes),
-			    GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	provider = &qp->provider;
-	provider->dev = &pdev->dev;
-	provider->set = qcom_icc_set;
-	provider->pre_aggregate = qcom_icc_pre_aggregate;
-	provider->aggregate = qcom_icc_aggregate;
-	provider->xlate_extended = qcom_icc_xlate_extended;
-	INIT_LIST_HEAD(&provider->nodes);
-	provider->data = data;
-
-	qp->dev = &pdev->dev;
-	qp->bcms = desc->bcms;
-	qp->num_bcms = desc->num_bcms;
-
-	qp->voter = of_bcm_voter_get(qp->dev, NULL);
-	if (IS_ERR(qp->voter)) {
-		dev_err(&pdev->dev, "bcm_voter err:%ld\n", PTR_ERR(qp->voter));
-		return PTR_ERR(qp->voter);
-	}
-
-	ret = icc_provider_add(provider);
-	if (ret) {
-		dev_err(&pdev->dev, "error adding interconnect provider\n");
-		return ret;
-	}
-
-	for (i = 0; i < qp->num_bcms; i++)
-		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
-
-	for (i = 0; i < num_nodes; i++) {
-		size_t j;
-
-		if (!qnodes[i])
-			continue;
-
-		node = icc_node_create(qnodes[i]->id);
-		if (IS_ERR(node)) {
-			ret = PTR_ERR(node);
-			goto err;
-		}
-
-		node->name = qnodes[i]->name;
-		node->data = qnodes[i];
-		icc_node_add(node, provider);
-
-		for (j = 0; j < qnodes[i]->num_links; j++)
-			icc_link_create(node, qnodes[i]->links[j]);
-
-		data->nodes[i] = node;
-	}
-	data->num_nodes = num_nodes;
-
-	platform_set_drvdata(pdev, qp);
-
-	return 0;
-err:
-	icc_nodes_remove(provider);
-	icc_provider_del(provider);
-	return ret;
-}
-
-static int qnoc_remove(struct platform_device *pdev)
-{
-	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
-
-	icc_nodes_remove(&qp->provider);
-	return icc_provider_del(&qp->provider);
-}
-
 static const struct of_device_id qnoc_of_match[] = {
 	{ .compatible = "qcom,sdm845-aggre1-noc",
 	  .data = &sdm845_aggre1_noc},
@@ -557,8 +462,8 @@ static const struct of_device_id qnoc_of_match[] = {
 MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
-	.probe = qnoc_probe,
-	.remove = qnoc_remove,
+	.probe = qcom_icc_rpmh_probe,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sdm845",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sdx55.c b/drivers/interconnect/qcom/sdx55.c
index a5a122ee3d21..03d604f84cc5 100644
--- a/drivers/interconnect/qcom/sdx55.c
+++ b/drivers/interconnect/qcom/sdx55.c
@@ -235,98 +235,6 @@ static const struct qcom_icc_desc sdx55_ipa_virt = {
 	.num_bcms = ARRAY_SIZE(ipa_virt_bcms),
 };
 
-static int qnoc_probe(struct platform_device *pdev)
-{
-	const struct qcom_icc_desc *desc;
-	struct icc_onecell_data *data;
-	struct icc_provider *provider;
-	struct qcom_icc_node **qnodes;
-	struct qcom_icc_provider *qp;
-	struct icc_node *node;
-	size_t num_nodes, i;
-	int ret;
-
-	desc = device_get_match_data(&pdev->dev);
-	if (!desc)
-		return -EINVAL;
-
-	qnodes = desc->nodes;
-	num_nodes = desc->num_nodes;
-
-	qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
-	if (!qp)
-		return -ENOMEM;
-
-	data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	provider = &qp->provider;
-	provider->dev = &pdev->dev;
-	provider->set = qcom_icc_set;
-	provider->pre_aggregate = qcom_icc_pre_aggregate;
-	provider->aggregate = qcom_icc_aggregate;
-	provider->xlate = of_icc_xlate_onecell;
-	INIT_LIST_HEAD(&provider->nodes);
-	provider->data = data;
-
-	qp->dev = &pdev->dev;
-	qp->bcms = desc->bcms;
-	qp->num_bcms = desc->num_bcms;
-
-	qp->voter = of_bcm_voter_get(qp->dev, NULL);
-	if (IS_ERR(qp->voter))
-		return PTR_ERR(qp->voter);
-
-	ret = icc_provider_add(provider);
-	if (ret) {
-		dev_err(&pdev->dev, "error adding interconnect provider\n");
-		return ret;
-	}
-
-	for (i = 0; i < qp->num_bcms; i++)
-		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
-
-	for (i = 0; i < num_nodes; i++) {
-		size_t j;
-
-		if (!qnodes[i])
-			continue;
-
-		node = icc_node_create(qnodes[i]->id);
-		if (IS_ERR(node)) {
-			ret = PTR_ERR(node);
-			goto err;
-		}
-
-		node->name = qnodes[i]->name;
-		node->data = qnodes[i];
-		icc_node_add(node, provider);
-
-		for (j = 0; j < qnodes[i]->num_links; j++)
-			icc_link_create(node, qnodes[i]->links[j]);
-
-		data->nodes[i] = node;
-	}
-	data->num_nodes = num_nodes;
-
-	platform_set_drvdata(pdev, qp);
-
-	return 0;
-err:
-	icc_nodes_remove(provider);
-	icc_provider_del(provider);
-	return ret;
-}
-
-static int qnoc_remove(struct platform_device *pdev)
-{
-	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
-
-	icc_nodes_remove(&qp->provider);
-	return icc_provider_del(&qp->provider);
-}
-
 static const struct of_device_id qnoc_of_match[] = {
 	{ .compatible = "qcom,sdx55-mc-virt",
 	  .data = &sdx55_mc_virt},
@@ -341,8 +249,8 @@ static const struct of_device_id qnoc_of_match[] = {
 MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
-	.probe = qnoc_probe,
-	.remove = qnoc_remove,
+	.probe = qcom_icc_rpmh_probe,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sdx55",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sm8150.c b/drivers/interconnect/qcom/sm8150.c
index c76b2c7f9b10..2a85f53802b5 100644
--- a/drivers/interconnect/qcom/sm8150.c
+++ b/drivers/interconnect/qcom/sm8150.c
@@ -502,98 +502,6 @@ static struct qcom_icc_desc sm8150_system_noc = {
 	.num_bcms = ARRAY_SIZE(system_noc_bcms),
 };
 
-static int qnoc_probe(struct platform_device *pdev)
-{
-	const struct qcom_icc_desc *desc;
-	struct icc_onecell_data *data;
-	struct icc_provider *provider;
-	struct qcom_icc_node **qnodes;
-	struct qcom_icc_provider *qp;
-	struct icc_node *node;
-	size_t num_nodes, i;
-	int ret;
-
-	desc = device_get_match_data(&pdev->dev);
-	if (!desc)
-		return -EINVAL;
-
-	qnodes = desc->nodes;
-	num_nodes = desc->num_nodes;
-
-	qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
-	if (!qp)
-		return -ENOMEM;
-
-	data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	provider = &qp->provider;
-	provider->dev = &pdev->dev;
-	provider->set = qcom_icc_set;
-	provider->pre_aggregate = qcom_icc_pre_aggregate;
-	provider->aggregate = qcom_icc_aggregate;
-	provider->xlate = of_icc_xlate_onecell;
-	INIT_LIST_HEAD(&provider->nodes);
-	provider->data = data;
-
-	qp->dev = &pdev->dev;
-	qp->bcms = desc->bcms;
-	qp->num_bcms = desc->num_bcms;
-
-	qp->voter = of_bcm_voter_get(qp->dev, NULL);
-	if (IS_ERR(qp->voter))
-		return PTR_ERR(qp->voter);
-
-	ret = icc_provider_add(provider);
-	if (ret) {
-		dev_err(&pdev->dev, "error adding interconnect provider\n");
-		return ret;
-	}
-
-	for (i = 0; i < qp->num_bcms; i++)
-		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
-
-	for (i = 0; i < num_nodes; i++) {
-		size_t j;
-
-		if (!qnodes[i])
-			continue;
-
-		node = icc_node_create(qnodes[i]->id);
-		if (IS_ERR(node)) {
-			ret = PTR_ERR(node);
-			goto err;
-		}
-
-		node->name = qnodes[i]->name;
-		node->data = qnodes[i];
-		icc_node_add(node, provider);
-
-		for (j = 0; j < qnodes[i]->num_links; j++)
-			icc_link_create(node, qnodes[i]->links[j]);
-
-		data->nodes[i] = node;
-	}
-	data->num_nodes = num_nodes;
-
-	platform_set_drvdata(pdev, qp);
-
-	return 0;
-err:
-	icc_nodes_remove(provider);
-	icc_provider_del(provider);
-	return ret;
-}
-
-static int qnoc_remove(struct platform_device *pdev)
-{
-	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
-
-	icc_nodes_remove(&qp->provider);
-	return icc_provider_del(&qp->provider);
-}
-
 static const struct of_device_id qnoc_of_match[] = {
 	{ .compatible = "qcom,sm8150-aggre1-noc",
 	  .data = &sm8150_aggre1_noc},
@@ -622,8 +530,8 @@ static const struct of_device_id qnoc_of_match[] = {
 MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
-	.probe = qnoc_probe,
-	.remove = qnoc_remove,
+	.probe = qcom_icc_rpmh_probe,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sm8150",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
index cc558fec74e3..8dfb5dea562a 100644
--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -518,98 +518,6 @@ static struct qcom_icc_desc sm8250_system_noc = {
 	.num_bcms = ARRAY_SIZE(system_noc_bcms),
 };
 
-static int qnoc_probe(struct platform_device *pdev)
-{
-	const struct qcom_icc_desc *desc;
-	struct icc_onecell_data *data;
-	struct icc_provider *provider;
-	struct qcom_icc_node **qnodes;
-	struct qcom_icc_provider *qp;
-	struct icc_node *node;
-	size_t num_nodes, i;
-	int ret;
-
-	desc = device_get_match_data(&pdev->dev);
-	if (!desc)
-		return -EINVAL;
-
-	qnodes = desc->nodes;
-	num_nodes = desc->num_nodes;
-
-	qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
-	if (!qp)
-		return -ENOMEM;
-
-	data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	provider = &qp->provider;
-	provider->dev = &pdev->dev;
-	provider->set = qcom_icc_set;
-	provider->pre_aggregate = qcom_icc_pre_aggregate;
-	provider->aggregate = qcom_icc_aggregate;
-	provider->xlate = of_icc_xlate_onecell;
-	INIT_LIST_HEAD(&provider->nodes);
-	provider->data = data;
-
-	qp->dev = &pdev->dev;
-	qp->bcms = desc->bcms;
-	qp->num_bcms = desc->num_bcms;
-
-	qp->voter = of_bcm_voter_get(qp->dev, NULL);
-	if (IS_ERR(qp->voter))
-		return PTR_ERR(qp->voter);
-
-	ret = icc_provider_add(provider);
-	if (ret) {
-		dev_err(&pdev->dev, "error adding interconnect provider\n");
-		return ret;
-	}
-
-	for (i = 0; i < qp->num_bcms; i++)
-		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
-
-	for (i = 0; i < num_nodes; i++) {
-		size_t j;
-
-		if (!qnodes[i])
-			continue;
-
-		node = icc_node_create(qnodes[i]->id);
-		if (IS_ERR(node)) {
-			ret = PTR_ERR(node);
-			goto err;
-		}
-
-		node->name = qnodes[i]->name;
-		node->data = qnodes[i];
-		icc_node_add(node, provider);
-
-		for (j = 0; j < qnodes[i]->num_links; j++)
-			icc_link_create(node, qnodes[i]->links[j]);
-
-		data->nodes[i] = node;
-	}
-	data->num_nodes = num_nodes;
-
-	platform_set_drvdata(pdev, qp);
-
-	return 0;
-err:
-	icc_nodes_remove(provider);
-	icc_provider_del(provider);
-	return ret;
-}
-
-static int qnoc_remove(struct platform_device *pdev)
-{
-	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
-
-	icc_nodes_remove(&qp->provider);
-	return icc_provider_del(&qp->provider);
-}
-
 static const struct of_device_id qnoc_of_match[] = {
 	{ .compatible = "qcom,sm8250-aggre1-noc",
 	  .data = &sm8250_aggre1_noc},
@@ -638,8 +546,8 @@ static const struct of_device_id qnoc_of_match[] = {
 MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
-	.probe = qnoc_probe,
-	.remove = qnoc_remove,
+	.probe = qcom_icc_rpmh_probe,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sm8250",
 		.of_match_table = qnoc_of_match,
diff --git a/drivers/interconnect/qcom/sm8350.c b/drivers/interconnect/qcom/sm8350.c
index 579b6ce8e046..3e26a2175b28 100644
--- a/drivers/interconnect/qcom/sm8350.c
+++ b/drivers/interconnect/qcom/sm8350.c
@@ -510,99 +510,6 @@ static struct qcom_icc_desc sm8350_system_noc = {
 	.num_bcms = ARRAY_SIZE(system_noc_bcms),
 };
 
-static int qnoc_probe(struct platform_device *pdev)
-{
-	const struct qcom_icc_desc *desc;
-	struct icc_onecell_data *data;
-	struct icc_provider *provider;
-	struct qcom_icc_node **qnodes;
-	struct qcom_icc_provider *qp;
-	struct icc_node *node;
-	size_t num_nodes, i;
-	int ret;
-
-	desc = of_device_get_match_data(&pdev->dev);
-	if (!desc)
-		return -EINVAL;
-
-	qnodes = desc->nodes;
-	num_nodes = desc->num_nodes;
-
-	qp = devm_kzalloc(&pdev->dev, sizeof(*qp), GFP_KERNEL);
-	if (!qp)
-		return -ENOMEM;
-
-	data = devm_kcalloc(&pdev->dev, num_nodes, sizeof(*node), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	provider = &qp->provider;
-	provider->dev = &pdev->dev;
-	provider->set = qcom_icc_set;
-	provider->pre_aggregate = qcom_icc_pre_aggregate;
-	provider->aggregate = qcom_icc_aggregate;
-	provider->xlate = of_icc_xlate_onecell;
-	INIT_LIST_HEAD(&provider->nodes);
-	provider->data = data;
-
-	qp->dev = &pdev->dev;
-	qp->bcms = desc->bcms;
-	qp->num_bcms = desc->num_bcms;
-
-	qp->voter = of_bcm_voter_get(qp->dev, NULL);
-	if (IS_ERR(qp->voter))
-		return PTR_ERR(qp->voter);
-
-	ret = icc_provider_add(provider);
-	if (ret) {
-		dev_err(&pdev->dev, "error adding interconnect provider\n");
-		return ret;
-	}
-
-	for (i = 0; i < qp->num_bcms; i++)
-		qcom_icc_bcm_init(qp->bcms[i], &pdev->dev);
-
-	for (i = 0; i < num_nodes; i++) {
-		size_t j;
-
-		if (!qnodes[i])
-			continue;
-
-		node = icc_node_create(qnodes[i]->id);
-		if (IS_ERR(node)) {
-			ret = PTR_ERR(node);
-			goto err;
-		}
-
-		node->name = qnodes[i]->name;
-		node->data = qnodes[i];
-		icc_node_add(node, provider);
-
-		for (j = 0; j < qnodes[i]->num_links; j++)
-			icc_link_create(node, qnodes[i]->links[j]);
-
-		data->nodes[i] = node;
-	}
-	data->num_nodes = num_nodes;
-
-	platform_set_drvdata(pdev, qp);
-
-	return ret;
-
-err:
-	icc_nodes_remove(provider);
-	icc_provider_del(provider);
-	return ret;
-}
-
-static int qnoc_remove(struct platform_device *pdev)
-{
-	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
-
-	icc_nodes_remove(&qp->provider);
-	return icc_provider_del(&qp->provider);
-}
-
 static const struct of_device_id qnoc_of_match[] = {
 	{ .compatible = "qcom,sm8350-aggre1-noc", .data = &sm8350_aggre1_noc},
 	{ .compatible = "qcom,sm8350-aggre2-noc", .data = &sm8350_aggre2_noc},
@@ -619,8 +526,8 @@ static const struct of_device_id qnoc_of_match[] = {
 MODULE_DEVICE_TABLE(of, qnoc_of_match);
 
 static struct platform_driver qnoc_driver = {
-	.probe = qnoc_probe,
-	.remove = qnoc_remove,
+	.probe = qcom_icc_rpmh_probe,
+	.remove = qcom_icc_rpmh_remove,
 	.driver = {
 		.name = "qnoc-sm8350",
 		.of_match_table = qnoc_of_match,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

