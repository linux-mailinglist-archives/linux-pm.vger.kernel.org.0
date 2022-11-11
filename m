Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270B062517A
	for <lists+linux-pm@lfdr.de>; Fri, 11 Nov 2022 04:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbiKKDZi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Nov 2022 22:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKKDZg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2022 22:25:36 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E3B5986F;
        Thu, 10 Nov 2022 19:25:35 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AB30IBR026295;
        Fri, 11 Nov 2022 03:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=21gznBidJgOp+lY7dRKxNVqo8NnKeDXbJ2Zba5+03ws=;
 b=PZGU8EAE+VkTC6sUkd8K4u8Vwek7CsVZLxf0urTYKQ1u9OMdH5aV/5/dWCvGT+jqf04N
 Q1+o3nzyD05T51qqXDmonwVpk/l55CRdfVzStZqzaZO8/G1deauuzTnXp5UU3jzRpmiC
 sEbBW8l2wBRgc7R1Yvs8V10YcKeOYRbHBE53APq1/04MLx0Ny277A4dCuDiqRVh7SnU2
 QFdxn8V38Z1Ay7sCPB/xlDeBND5xvJHhUK2GmWmYEku4vHGjvqerGqB3e6iIAqyeLnlT
 wAg9jAbwHf9t/LiD81kZmHtEKK11x4v6R9d0IO2gH3UfMxIzatO9wRi6W6czyoi7OvWo nQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ksah3rfq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 03:25:23 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AB3PMfm014382
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 03:25:22 GMT
Received: from th-lint-050.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 10 Nov 2022 19:25:22 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        "Johan Hovold" <johan+linaro@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 03/10] interconnect: qcom: osm-l3: Add per-core EPSS L3 support
Date:   Thu, 10 Nov 2022 19:25:08 -0800
Message-ID: <20221111032515.3460-4-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221111032515.3460-1-quic_bjorande@quicinc.com>
References: <20221111032515.3460-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: w_XU5dY0tTApx7XTHDpBGyjJaJ3FLrA0
X-Proofpoint-ORIG-GUID: w_XU5dY0tTApx7XTHDpBGyjJaJ3FLrA0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_14,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 clxscore=1015 mlxscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211110021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The EPSS instance in e.g. SM8350 and SC8280XP has per-core L3 voting
enabled. In this configuration, the "shared" vote is done using the
REG_L3_VOTE register instead of PERF_STATE.

Rename epss_l3 to clarify that it's affecting the PERF_STATE register
and add a new L3_VOTE description. Given platform lineage it's assumed
that the L3_VOTE-based case will be the predominant one, so use this for
a new generic qcom,epss-l3 compatible.

While adding the EPSS generic, also add qcom,osm-l3.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Tested-by: Steev Klimaszewski <steev@kali.org>
---

Changes since v1:
- None

 drivers/interconnect/qcom/osm-l3.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 7d6844253241..469be732a00b 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -34,6 +34,7 @@
 
 /* EPSS Register offsets */
 #define EPSS_LUT_ROW_SIZE		4
+#define EPSS_REG_L3_VOTE		0x90
 #define EPSS_REG_FREQ_LUT		0x100
 #define EPSS_REG_PERF_STATE		0x320
 
@@ -112,7 +113,7 @@ static const struct qcom_osm_l3_desc osm_l3 = {
 	.reg_perf_state = OSM_REG_PERF_STATE,
 };
 
-static const struct qcom_osm_l3_desc epss_l3 = {
+static const struct qcom_osm_l3_desc epss_l3_perf_state = {
 	.nodes = epss_l3_nodes,
 	.num_nodes = ARRAY_SIZE(epss_l3_nodes),
 	.lut_row_size = EPSS_LUT_ROW_SIZE,
@@ -120,6 +121,14 @@ static const struct qcom_osm_l3_desc epss_l3 = {
 	.reg_perf_state = EPSS_REG_PERF_STATE,
 };
 
+static const struct qcom_osm_l3_desc epss_l3_l3_vote = {
+	.nodes = epss_l3_nodes,
+	.num_nodes = ARRAY_SIZE(epss_l3_nodes),
+	.lut_row_size = EPSS_LUT_ROW_SIZE,
+	.reg_freq_lut = EPSS_REG_FREQ_LUT,
+	.reg_perf_state = EPSS_REG_L3_VOTE,
+};
+
 static int qcom_osm_l3_set(struct icc_node *src, struct icc_node *dst)
 {
 	struct qcom_osm_l3_icc_provider *qp;
@@ -285,12 +294,14 @@ static int qcom_osm_l3_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id osm_l3_of_match[] = {
+	{ .compatible = "qcom,epss-l3", .data = &epss_l3_l3_vote },
+	{ .compatible = "qcom,osm-l3", .data = &osm_l3 },
 	{ .compatible = "qcom,sc7180-osm-l3", .data = &osm_l3 },
-	{ .compatible = "qcom,sc7280-epss-l3", .data = &epss_l3 },
+	{ .compatible = "qcom,sc7280-epss-l3", .data = &epss_l3_perf_state },
 	{ .compatible = "qcom,sdm845-osm-l3", .data = &osm_l3 },
 	{ .compatible = "qcom,sm8150-osm-l3", .data = &osm_l3 },
 	{ .compatible = "qcom,sc8180x-osm-l3", .data = &osm_l3 },
-	{ .compatible = "qcom,sm8250-epss-l3", .data = &epss_l3 },
+	{ .compatible = "qcom,sm8250-epss-l3", .data = &epss_l3_perf_state },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, osm_l3_of_match);
-- 
2.17.1

