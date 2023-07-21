Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4E075BDF5
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jul 2023 07:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjGUFsL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Jul 2023 01:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjGUFrt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2023 01:47:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083BE3A8E;
        Thu, 20 Jul 2023 22:47:19 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L5ge2K012103;
        Fri, 21 Jul 2023 05:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=aDrEGWzK5xW/XLzPrRNTbcEJP+wW9LlOvmNV/qztgfg=;
 b=PsKykelV0lvBWzc3dkYVKmfqjkTGfD625LepD+AdjX4+BTqpDMaLZPaiVs+pGOfP/3g6
 3jHXFjuG2EGANhjf1uMH4o6rg8YBpQuP3Pw6dQFJGiII2pEMxGDrU6kXrrSBzdhfUIo8
 ZvPmqZ2esRceSAmPfsulTtC3WRLH/t9sGHLqnRTo+W3/kdwZNgUgjJ2RakCi/sid+pAX
 OOrpSI9bq1ATw2vPKPhz7DCIU0sr3IEvKwf5XuVwFoCkL0Q6EmB410YwyJAMwY+fOweK
 DpKkdOU0fFDjqw1WWslDCc8Bu0nI5eEsAbVOuAjGOFGc1FoldpHfH+gvciSzqRJSyJ50 ww== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ryfyf0e0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 05:47:11 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L5lA7j004119
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 05:47:10 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 22:47:05 -0700
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
Subject: [PATCH v5 5/5] thermal/drivers/tsens: Add IPQ5332 support
Date:   Fri, 21 Jul 2023 11:16:19 +0530
Message-ID: <20230721054619.2366510-6-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721054619.2366510-1-quic_ipkumar@quicinc.com>
References: <20230721054619.2366510-1-quic_ipkumar@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tErFpnpXXBvAuBewA9U9SVv8gGtY-Hr9
X-Proofpoint-ORIG-GUID: tErFpnpXXBvAuBewA9U9SVv8gGtY-Hr9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_02,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210052
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

IPQ5332 uses tsens v2.3.3 IP and it is having combined interrupt.
It does not have RPM and kernel needs to take care of sensor
enablement, calibration. Hence introduced new feature_config,
ops and data for IPQ5332.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
[v5]:
	No changes.
[v4]:
	No changes.
[v3]:
	No changes.
[v2]:
	Added tsens_features for ipq5332 with VER_2_X_NO_RPM. Used
	hw_ids to mention the available sensors. Dropped v2 in
	ops_ipq5332.

 drivers/thermal/qcom/tsens-v2.c | 25 +++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c    |  3 +++
 drivers/thermal/qcom/tsens.h    |  2 +-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 7190e477b173..512839597ac6 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -69,6 +69,17 @@ static struct tsens_features ipq8074_feat = {
 	.trip_max_temp	= 204000,
 };
 
+static struct tsens_features ipq5332_feat = {
+	.ver_major	= VER_2_X_NO_RPM,
+	.crit_int	= 1,
+	.combo_int	= 1,
+	.adc		= 0,
+	.srot_split	= 1,
+	.max_sensors	= 16,
+	.trip_min_temp	= 0,
+	.trip_max_temp	= 204000,
+};
+
 static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 	/* ----- SROT ------ */
 	/* VERSION */
@@ -270,6 +281,20 @@ struct tsens_plat_data data_ipq8074 = {
 	.fields	= tsens_v2_regfields,
 };
 
+static const struct tsens_ops ops_ipq5332 = {
+	.init		= init_tsens_v2_no_rpm,
+	.get_temp	= get_temp_tsens_valid,
+	.calibrate	= tsens_v2_calibration,
+};
+
+struct tsens_plat_data data_ipq5332 = {
+	.num_sensors	= 5,
+	.ops		= &ops_ipq5332,
+	.hw_ids		= (unsigned int []){11, 12, 13, 14, 15},
+	.feat		= &ipq5332_feat,
+	.fields		= tsens_v2_regfields,
+};
+
 /* Kept around for backward compatibility with old msm8996.dtsi */
 struct tsens_plat_data data_8996 = {
 	.num_sensors	= 13,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 9dc0c2150948..af58a94628a8 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1106,6 +1106,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,ipq8074-tsens",
 		.data = &data_ipq8074,
+	}, {
+		.compatible = "qcom,ipq5332-tsens",
+		.data = &data_ipq5332,
 	}, {
 		.compatible = "qcom,mdm9607-tsens",
 		.data = &data_9607,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index b2e8f0f2b466..1dde363914cd 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -648,6 +648,6 @@ extern struct tsens_plat_data data_8226, data_8909, data_8916, data_8939, data_8
 extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;
 
 /* TSENS v2 targets */
-extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
+extern struct tsens_plat_data data_8996, data_ipq8074, data_ipq5332, data_tsens_v2;
 
 #endif /* __QCOM_TSENS_H__ */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

