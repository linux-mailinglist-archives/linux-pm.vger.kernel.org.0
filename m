Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA95235244
	for <lists+linux-pm@lfdr.de>; Sat,  1 Aug 2020 14:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgHAMbK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Aug 2020 08:31:10 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:59426 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728680AbgHAMbJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Aug 2020 08:31:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596285069; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=mVmxSFp7kd3V5fOQJG5CkOAtdy9fgnp0DEOyZ54Uj/U=; b=u+N0zjXAQAd5utGr8pG5SoiKe8lY8P756OaBOV3bXATQn4s/tLceVCfcFu7AxDEydQ1rln0s
 UdzMroLxqLx+eOYJO0xm7AIUXFHtPYspX2Agn1CMCixQKbmprnEwPgMyln5JAcKKuH1wXXmR
 DeB80+F7z6ply9upxvoxhno2s50=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n17.prod.us-east-1.postgun.com with SMTP id
 5f25608c14acd1952bb778c5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 01 Aug 2020 12:31:08
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E518CC433CA; Sat,  1 Aug 2020 12:31:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 70C48C433CB;
        Sat,  1 Aug 2020 12:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 70C48C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     robh+dt@kernel.org, georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jonathan@marek.ca,
        linux-pm@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 2/7] interconnect: qcom: Add OSM L3 support on SM8150
Date:   Sat,  1 Aug 2020 18:00:44 +0530
Message-Id: <20200801123049.32398-3-sibis@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200801123049.32398-1-sibis@codeaurora.org>
References: <20200801123049.32398-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Operation State Manager (OSM) L3 interconnect provider support on
SM8150 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/interconnect/qcom/osm-l3.c | 15 +++++++++++++++
 drivers/interconnect/qcom/sm8150.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 96fb9ff5ff2e8..00831c33e0fe5 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -16,6 +16,7 @@
 
 #include "sc7180.h"
 #include "sdm845.h"
+#include "sm8150.h"
 
 #define LUT_MAX_ENTRIES			40U
 #define LUT_SRC				GENMASK(31, 30)
@@ -96,6 +97,19 @@ static const struct qcom_icc_desc sc7180_icc_osm_l3 = {
 	.num_nodes = ARRAY_SIZE(sc7180_osm_l3_nodes),
 };
 
+DEFINE_QNODE(sm8150_osm_apps_l3, SM8150_MASTER_OSM_L3_APPS, 32, SM8150_SLAVE_OSM_L3);
+DEFINE_QNODE(sm8150_osm_l3, SM8150_SLAVE_OSM_L3, 32);
+
+static struct qcom_icc_node *sm8150_osm_l3_nodes[] = {
+	[MASTER_OSM_L3_APPS] = &sm8150_osm_apps_l3,
+	[SLAVE_OSM_L3] = &sm8150_osm_l3,
+};
+
+static const struct qcom_icc_desc sm8150_icc_osm_l3 = {
+	.nodes = sm8150_osm_l3_nodes,
+	.num_nodes = ARRAY_SIZE(sm8150_osm_l3_nodes),
+};
+
 static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 {
 	struct qcom_osm_l3_icc_provider *qp;
@@ -258,6 +272,7 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 static const struct of_device_id osm_l3_of_match[] = {
 	{ .compatible = "qcom,sc7180-osm-l3", .data = &sc7180_icc_osm_l3 },
 	{ .compatible = "qcom,sdm845-osm-l3", .data = &sdm845_icc_osm_l3 },
+	{ .compatible = "qcom,sm8150-osm-l3", .data = &sm8150_icc_osm_l3 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, osm_l3_of_match);
diff --git a/drivers/interconnect/qcom/sm8150.h b/drivers/interconnect/qcom/sm8150.h
index 3e01ac76ae1db..97996f64d799c 100644
--- a/drivers/interconnect/qcom/sm8150.h
+++ b/drivers/interconnect/qcom/sm8150.h
@@ -148,5 +148,7 @@
 #define SM8150_SLAVE_VSENSE_CTRL_CFG		137
 #define SM8150_SNOC_CNOC_MAS			138
 #define SM8150_SNOC_CNOC_SLV			139
+#define SM8150_MASTER_OSM_L3_APPS		140
+#define SM8150_SLAVE_OSM_L3			141
 
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

