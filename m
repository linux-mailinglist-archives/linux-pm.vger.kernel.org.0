Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7FC76EA7D
	for <lists+linux-pm@lfdr.de>; Thu,  3 Aug 2023 15:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjHCNda (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Aug 2023 09:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjHCNcO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Aug 2023 09:32:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441693C1F;
        Thu,  3 Aug 2023 06:31:11 -0700 (PDT)
Received: from dggpemm100020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RGpz03117zrS8N;
        Thu,  3 Aug 2023 21:07:08 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100020.china.huawei.com (7.185.36.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 21:08:12 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 21:08:12 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next] interconnect: fix error handling in qnoc_probe()
Date:   Thu, 3 Aug 2023 21:05:21 +0800
Message-ID: <20230803130521.959487-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add missing clk_disable_unprepare() and clk_bulk_disable_unprepare()
in the error path in qnoc_probe(). And when qcom_icc_qos_set() fails,
it needs remove nodes and disable clks.

Fixes: 2e2113c8a64f ("interconnect: qcom: rpm: Handle interface clocks")
Fixes: 32882f657e78 ("interconnect: qcom: rpm: Set QoS registers only once")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/interconnect/qcom/icc-rpm.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 2c16917ba1fd..51f12b70cb4f 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -497,7 +497,7 @@ int qnoc_probe(struct platform_device *pdev)
 
 	ret = devm_clk_bulk_get(dev, qp->num_intf_clks, qp->intf_clks);
 	if (ret)
-		return ret;
+		goto err_disable_unprepare_clk;;
 
 	provider = &qp->provider;
 	provider->dev = dev;
@@ -512,13 +512,15 @@ int qnoc_probe(struct platform_device *pdev)
 	/* If this fails, bus accesses will crash the platform! */
 	ret = clk_bulk_prepare_enable(qp->num_intf_clks, qp->intf_clks);
 	if (ret)
-		return ret;
+		goto err_disable_unprepare_clk;
 
 	for (i = 0; i < num_nodes; i++) {
 		size_t j;
 
 		node = icc_node_create(qnodes[i]->id);
 		if (IS_ERR(node)) {
+			clk_bulk_disable_unprepare(qp->num_intf_clks,
+						   qp->intf_clks);
 			ret = PTR_ERR(node);
 			goto err_remove_nodes;
 		}
@@ -534,8 +536,11 @@ int qnoc_probe(struct platform_device *pdev)
 		if (qnodes[i]->qos.ap_owned &&
 		    qnodes[i]->qos.qos_mode != NOC_QOS_MODE_INVALID) {
 			ret = qcom_icc_qos_set(node);
-			if (ret)
-				return ret;
+			if (ret) {
+				clk_bulk_disable_unprepare(qp->num_intf_clks,
+							   qp->intf_clks);
+				goto err_remove_nodes;
+			}
 		}
 
 		data->nodes[i] = node;
@@ -563,6 +568,7 @@ int qnoc_probe(struct platform_device *pdev)
 	icc_provider_deregister(provider);
 err_remove_nodes:
 	icc_nodes_remove(provider);
+err_disable_unprepare_clk:
 	clk_disable_unprepare(qp->bus_clk);
 
 	return ret;
-- 
2.25.1

