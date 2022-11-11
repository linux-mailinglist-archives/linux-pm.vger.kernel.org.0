Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFE2625190
	for <lists+linux-pm@lfdr.de>; Fri, 11 Nov 2022 04:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiKKDZo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Nov 2022 22:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbiKKDZh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2022 22:25:37 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7647B5B5AF;
        Thu, 10 Nov 2022 19:25:36 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AB2q8OJ003886;
        Fri, 11 Nov 2022 03:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=XMTbhZHNv/gVflXRX6lccp2ciFrk5w07Om2GdeV9syY=;
 b=iTOpMngO3Nfku88iXgbErwlWa6sBRQc8E2Un5QMm9izhyqiWuMNGEv0y5iVhprXwtBSC
 ZgSUeYRWKO7NUy8AcB3UkvnyrGZqf0KDF1UDHKrk+A9IszdxKRnV4SkogyIOVIYH0eCD
 61NUq/fLX/1FYx8NQxxBBa+NQru/ARMDYSQfYxeGdmetItlKeTZmUN3yCs2eYi9OjXlo
 KSEDDtHG94jH04YhfQpAWcQJr6mdObY8AWNCnve1FimGhUq0XpNnQJo4BARzFEyRnZLN
 wOfVsFe50yTGJ5RyjVdVlPhjkqyNE7IAXNJX/dAvvKEmuXlLJHmaiYFmFZL5iVOmOdbD KQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ksah80f3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 03:25:26 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AB3PPcv011817
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 03:25:25 GMT
Received: from th-lint-050.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 10 Nov 2022 19:25:25 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 09/10] dt-bindings: interconnect: qcom,msm8998-bwmon: Add sc8280xp bwmon instances
Date:   Thu, 10 Nov 2022 19:25:14 -0800
Message-ID: <20221111032515.3460-10-quic_bjorande@quicinc.com>
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
X-Proofpoint-ORIG-GUID: JdUubdFtRe2_sQ_V1Xgkt4E2e-2B50e6
X-Proofpoint-GUID: JdUubdFtRe2_sQ_V1Xgkt4E2e-2B50e6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_14,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211110021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The sc8280xp platform has two BWMON instances, one v4 and one v5. Extend
the existing qcom,msm8998-bwmon and qcom,sc7280-llcc-bwmon to describe
these.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Tested-by: Steev Klimaszewski <steev@kali.org>
---

Changes since v1:
- Added "cpu" to compatible

 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index be29e0b80995..0c720dbde36e 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -25,9 +25,14 @@ properties:
       - items:
           - enum:
               - qcom,sc7280-cpu-bwmon
+              - qcom,sc8280xp-cpu-bwmon
               - qcom,sdm845-bwmon
           - const: qcom,msm8998-bwmon
       - const: qcom,msm8998-bwmon       # BWMON v4
+      - items:
+          - enum:
+              - qcom,sc8280xp-llcc-bwmon
+          - const: qcom,sc7280-llcc-bwmon
       - const: qcom,sc7280-llcc-bwmon   # BWMON v5
       - const: qcom,sdm845-llcc-bwmon   # BWMON v5
 
-- 
2.17.1

