Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA0A235253
	for <lists+linux-pm@lfdr.de>; Sat,  1 Aug 2020 14:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgHAMb2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Aug 2020 08:31:28 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36350 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729050AbgHAMb1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 1 Aug 2020 08:31:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596285086; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=T3gsh8DJJ2SBdn1sHsz2kpKTvtzE7ro3caTw1+lXGdA=; b=Coxry305QLZdSF0DHRtbz2m9d7NDtLJnQ6wppD2kkEbqkZ1rsnUbwbkblKw/d6qgVOeaBjJM
 p6vDaHX6ke9oxnDcFfZfSq/w5I8jUfQ1sVCUDgdTs90bMh8Wpe0INyXO+U7NVs5ZN0Lmmei1
 SJubWEjWQry/GRN5W1A04QcSq9w=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-east-1.postgun.com with SMTP id
 5f256098d2bd131f68145832 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 01 Aug 2020 12:31:20
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E19DCC433A0; Sat,  1 Aug 2020 12:31:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4834C433AF;
        Sat,  1 Aug 2020 12:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4834C433AF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     robh+dt@kernel.org, georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jonathan@marek.ca,
        linux-pm@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 5/7] interconnect: qcom: Add EPSS L3 support on SM8250
Date:   Sat,  1 Aug 2020 18:00:47 +0530
Message-Id: <20200801123049.32398-6-sibis@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200801123049.32398-1-sibis@codeaurora.org>
References: <20200801123049.32398-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Epoch Subsystem (EPSS) L3 interconnect provider support on
SM8250 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/interconnect/qcom/osm-l3.c | 23 +++++++++++++++++++++++
 drivers/interconnect/qcom/sm8250.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 27c9ece52efda..cbf4ef04491df 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -17,6 +17,7 @@
 #include "sc7180.h"
 #include "sdm845.h"
 #include "sm8150.h"
+#include "sm8250.h"
 
 #define LUT_MAX_ENTRIES			40U
 #define LUT_SRC				GENMASK(31, 30)
@@ -29,6 +30,11 @@
 #define OSM_REG_FREQ_LUT		0x110
 #define OSM_REG_PERF_STATE		0x920
 
+/* EPSS Register offsets */
+#define EPSS_LUT_ROW_SIZE		4
+#define EPSS_REG_FREQ_LUT		0x100
+#define EPSS_REG_PERF_STATE		0x320
+
 #define OSM_L3_MAX_LINKS		1
 
 #define to_qcom_provider(_provider) \
@@ -123,6 +129,22 @@ static const struct qcom_icc_desc sm8150_icc_osm_l3 = {
 	.reg_perf_state = OSM_REG_PERF_STATE,
 };
 
+DEFINE_QNODE(sm8250_epss_apps_l3, SM8250_MASTER_EPSS_L3_APPS, 32, SM8250_SLAVE_EPSS_L3);
+DEFINE_QNODE(sm8250_epss_l3, SM8250_SLAVE_EPSS_L3, 32);
+
+static struct qcom_icc_node *sm8250_epss_l3_nodes[] = {
+	[MASTER_EPSS_L3_APPS] = &sm8250_epss_apps_l3,
+	[SLAVE_EPSS_L3_SHARED] = &sm8250_epss_l3,
+};
+
+static const struct qcom_icc_desc sm8250_icc_epss_l3 = {
+	.nodes = sm8250_epss_l3_nodes,
+	.num_nodes = ARRAY_SIZE(sm8250_epss_l3_nodes),
+	.lut_row_size = EPSS_LUT_ROW_SIZE,
+	.reg_freq_lut = EPSS_REG_FREQ_LUT,
+	.reg_perf_state = EPSS_REG_PERF_STATE,
+};
+
 static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 {
 	struct qcom_osm_l3_icc_provider *qp;
@@ -288,6 +310,7 @@ static const struct of_device_id osm_l3_of_match[] = {
 	{ .compatible = "qcom,sc7180-osm-l3", .data = &sc7180_icc_osm_l3 },
 	{ .compatible = "qcom,sdm845-osm-l3", .data = &sdm845_icc_osm_l3 },
 	{ .compatible = "qcom,sm8150-osm-l3", .data = &sm8150_icc_osm_l3 },
+	{ .compatible = "qcom,sm8250-epss-l3", .data = &sm8250_icc_epss_l3 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, osm_l3_of_match);
diff --git a/drivers/interconnect/qcom/sm8250.h b/drivers/interconnect/qcom/sm8250.h
index 7eb6c709c30d1..b31fb431a20fc 100644
--- a/drivers/interconnect/qcom/sm8250.h
+++ b/drivers/interconnect/qcom/sm8250.h
@@ -158,5 +158,7 @@
 #define SM8250_SLAVE_VSENSE_CTRL_CFG		147
 #define SM8250_SNOC_CNOC_MAS			148
 #define SM8250_SNOC_CNOC_SLV			149
+#define SM8250_MASTER_EPSS_L3_APPS		150
+#define SM8250_SLAVE_EPSS_L3			151
 
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

