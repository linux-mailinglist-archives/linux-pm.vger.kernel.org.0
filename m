Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109BA235260
	for <lists+linux-pm@lfdr.de>; Sat,  1 Aug 2020 14:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgHAMcK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Aug 2020 08:32:10 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:63065 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729161AbgHAMcK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 1 Aug 2020 08:32:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596285129; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=vOImtBgeqdRnUROqMwdyXuAZ1BNGZF6kDhd29hTqD0E=; b=bdwznQt/T1eswkLYP2Yzn0naxOwTOzOoW6FwFHvG35lZK45p5CTQWgptdFWi0mbsmxgR2KjQ
 k2yxB0+yP/b8cgLx9apn4Zg0n3UpooeZ2VTnHOH6gpVzr8jF08uHNhpjKzIXklI5c03x9b0+
 snJ7NyELrqiRnA/rJgCf+st+SyA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f25608f2c24b37bbe5ba024 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 01 Aug 2020 12:31:11
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3812CC433CB; Sat,  1 Aug 2020 12:31:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E7FF0C43391;
        Sat,  1 Aug 2020 12:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E7FF0C43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     robh+dt@kernel.org, georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jonathan@marek.ca,
        linux-pm@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 3/7] interconnect: qcom: Lay the groundwork for adding EPSS support
Date:   Sat,  1 Aug 2020 18:00:45 +0530
Message-Id: <20200801123049.32398-4-sibis@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200801123049.32398-1-sibis@codeaurora.org>
References: <20200801123049.32398-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Lay the groundwork for adding Epoch Subsystem (EPSS) L3 support on
SM8250.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/interconnect/qcom/osm-l3.c | 37 +++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 00831c33e0fe5..27c9ece52efda 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -21,13 +21,13 @@
 #define LUT_MAX_ENTRIES			40U
 #define LUT_SRC				GENMASK(31, 30)
 #define LUT_L_VAL			GENMASK(7, 0)
-#define LUT_ROW_SIZE			32
 #define CLK_HW_DIV			2
 
-/* Register offsets */
+/* OSM Register offsets */
 #define REG_ENABLE			0x0
-#define REG_FREQ_LUT			0x110
-#define REG_PERF_STATE			0x920
+#define OSM_LUT_ROW_SIZE		32
+#define OSM_REG_FREQ_LUT		0x110
+#define OSM_REG_PERF_STATE		0x920
 
 #define OSM_L3_MAX_LINKS		1
 
@@ -37,6 +37,7 @@
 struct qcom_osm_l3_icc_provider {
 	void __iomem *base;
 	unsigned int max_state;
+	unsigned int reg_perf_state;
 	unsigned long lut_tables[LUT_MAX_ENTRIES];
 	struct icc_provider provider;
 };
@@ -60,6 +61,9 @@ struct qcom_icc_node {
 struct qcom_icc_desc {
 	struct qcom_icc_node **nodes;
 	size_t num_nodes;
+	unsigned int lut_row_size;
+	unsigned int reg_freq_lut;
+	unsigned int reg_perf_state;
 };
 
 #define DEFINE_QNODE(_name, _id, _buswidth, ...)			\
@@ -82,6 +86,9 @@ static struct qcom_icc_node *sdm845_osm_l3_nodes[] = {
 static const struct qcom_icc_desc sdm845_icc_osm_l3 = {
 	.nodes = sdm845_osm_l3_nodes,
 	.num_nodes = ARRAY_SIZE(sdm845_osm_l3_nodes),
+	.lut_row_size = OSM_LUT_ROW_SIZE,
+	.reg_freq_lut = OSM_REG_FREQ_LUT,
+	.reg_perf_state = OSM_REG_PERF_STATE,
 };
 
 DEFINE_QNODE(sc7180_osm_apps_l3, SC7180_MASTER_OSM_L3_APPS, 16, SC7180_SLAVE_OSM_L3);
@@ -95,6 +102,9 @@ static struct qcom_icc_node *sc7180_osm_l3_nodes[] = {
 static const struct qcom_icc_desc sc7180_icc_osm_l3 = {
 	.nodes = sc7180_osm_l3_nodes,
 	.num_nodes = ARRAY_SIZE(sc7180_osm_l3_nodes),
+	.lut_row_size = OSM_LUT_ROW_SIZE,
+	.reg_freq_lut = OSM_REG_FREQ_LUT,
+	.reg_perf_state = OSM_REG_PERF_STATE,
 };
 
 DEFINE_QNODE(sm8150_osm_apps_l3, SM8150_MASTER_OSM_L3_APPS, 32, SM8150_SLAVE_OSM_L3);
@@ -108,6 +118,9 @@ static struct qcom_icc_node *sm8150_osm_l3_nodes[] = {
 static const struct qcom_icc_desc sm8150_icc_osm_l3 = {
 	.nodes = sm8150_osm_l3_nodes,
 	.num_nodes = ARRAY_SIZE(sm8150_osm_l3_nodes),
+	.lut_row_size = OSM_LUT_ROW_SIZE,
+	.reg_freq_lut = OSM_REG_FREQ_LUT,
+	.reg_perf_state = OSM_REG_PERF_STATE,
 };
 
 static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
@@ -138,7 +151,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 			break;
 	}
 
-	writel_relaxed(index, qp->base + REG_PERF_STATE);
+	writel_relaxed(index, qp->base + qp->reg_perf_state);
 
 	return 0;
 }
@@ -193,9 +206,15 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	desc = device_get_match_data(&pdev->dev);
+	if (!desc)
+		return -EINVAL;
+
+	qp->reg_perf_state = desc->reg_perf_state;
+
 	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
-		info = readl_relaxed(qp->base + REG_FREQ_LUT +
-				     i * LUT_ROW_SIZE);
+		info = readl_relaxed(qp->base + desc->reg_freq_lut +
+				     i * desc->lut_row_size);
 		src = FIELD_GET(LUT_SRC, info);
 		lval = FIELD_GET(LUT_L_VAL, info);
 		if (src)
@@ -214,10 +233,6 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 	}
 	qp->max_state = i;
 
-	desc = device_get_match_data(&pdev->dev);
-	if (!desc)
-		return -EINVAL;
-
 	qnodes = desc->nodes;
 	num_nodes = desc->num_nodes;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

