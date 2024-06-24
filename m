Return-Path: <linux-pm+bounces-9854-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B389141A8
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 07:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C661C22C63
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 05:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161F716415;
	Mon, 24 Jun 2024 05:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GONRvK3L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44FC199B9;
	Mon, 24 Jun 2024 05:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719205428; cv=none; b=gu/Vf0hrm9pVT3IrRucKk2AfYZRCR977Gu+SB33xPgHQ2GvGYlnxk7wAaf8Ui/MaBNuX0JIOiJpnwGzqHRpx7t4unvz8oMGx46eNguxtTxbNmM8fzA9qSulrSMytfNYATdL7GW2YGb2D+S8Mh9E/yddUAERv/JErQ6c+xcWBss4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719205428; c=relaxed/simple;
	bh=ztfUcoULB/YgNfJdRAHyJ7pcIU/OMOsuWIK7F7I551w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHDK6GEqRf9gqdwOm+wsdhfeCnH/vEUIdAHh2jPnNeSRHDu7OQLDeeI7HmoS9b48h5CFvGb3520zax0aYwXwSuh5oGBcBYpDqA7dSn02RiywXqcSeA4DAryexETnDw1Qb8B7dtppqzmqlgK0TY+gqPsWFkWiweRCHdI9E9aVvxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GONRvK3L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NNNa9H021649;
	Mon, 24 Jun 2024 05:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iMkUDRIL5Fp6c7nWmGD18/VQ7MnmoxRhTQjla6Ax7/A=; b=GONRvK3LtAJ8aGAe
	s3PhawKGVqLvulyLXxq232HIAgTh4JH4aDSW7Egrg3Ho/uS/DRJyTHi85VJQC8p4
	GYXVy0IQZhROtu//v+abLzgMhwYPg8EMHbNv2y2EiKJvXNC4YeADFqlG+DcXd6K5
	gfT+/42J3iSCOrrjaHjwgG+q6yGEreoxV3uUwxC7AQyBfhUVUInjWPjex3sXKdTp
	UbqM/RIdHCWVITWLjI0bJ8L8RYhut/GfBwYvXks8wiOSqdngkVO0xHTIts+/aXAg
	Mcx9ToJlzpSXjOxa6ACQ9L+0+DHmReSr7XX5e9MSAaHQ7K5Q2R37W1iq6h3febuf
	c9WabA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywmaetw5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 05:03:38 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45O53bQS029071
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 05:03:37 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 23 Jun 2024 22:03:31 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <abel.vesa@linaro.org>, <otto.pflueger@abscue.de>,
        <quic_rohiagar@quicinc.com>, <quic_varada@quicinc.com>,
        <luca@z3ntu.xyz>, <quic_ipkumar@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v2 2/7] dt-bindings: soc: qcom: cpr3: Add bindings for IPQ9574
Date: Mon, 24 Jun 2024 10:32:49 +0530
Message-ID: <20240624050254.2942959-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624050254.2942959-1-quic_varada@quicinc.com>
References: <20240624050254.2942959-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gt1PSffGIrvAe5ns1RCAt3dKIg8YWpcs
X-Proofpoint-GUID: gt1PSffGIrvAe5ns1RCAt3dKIg8YWpcs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406240038

Add the bindings for the IPQ9574 CPR3 driver to the documentation.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v2: Constrained nvmem-cells and the other variant.
    Removed unnecessary blank line.
---
 .../bindings/soc/qcom/qcom,cpr3.yaml          | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
index acf2e294866b..f72addaa0ca2 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
@@ -24,6 +24,7 @@ properties:
       - const: qcom,cpr4
       - items:
           - enum:
+              - qcom,ipq9574-cprh
               - qcom,msm8998-cprh
               - qcom,sdm630-cprh
           - const: qcom,cprh
@@ -52,9 +53,11 @@ properties:
 
   nvmem-cells:
     description: Cells containing the fuse corners and revision data
+    minItems: 17
     maxItems: 32
 
   nvmem-cell-names:
+    minItems: 17
     maxItems: 32
 
   operating-points-v2: true
@@ -74,6 +77,36 @@ required:
 additionalProperties: false
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq9574-cprh
+    then:
+      properties:
+        nvmem-cells:
+          maxItems: 17
+        nvmem-cell-names:
+          items:
+            - const: cpr_speed_bin
+            - const: cpr_fuse_revision
+            - const: cpr0_quotient1
+            - const: cpr0_quotient2
+            - const: cpr0_quotient3
+            - const: cpr0_quotient4
+            - const: cpr0_quotient_offset2
+            - const: cpr0_quotient_offset3
+            - const: cpr0_quotient_offset4
+            - const: cpr0_init_voltage1
+            - const: cpr0_init_voltage2
+            - const: cpr0_init_voltage3
+            - const: cpr0_init_voltage4
+            - const: cpr0_ring_osc1
+            - const: cpr0_ring_osc2
+            - const: cpr0_ring_osc3
+            - const: cpr0_ring_osc4
+
   - if:
       properties:
         compatible:
@@ -82,6 +115,8 @@ allOf:
               - qcom,msm8998-cprh
     then:
       properties:
+        nvmem-cells:
+          minItems: 32
         nvmem-cell-names:
           items:
             - const: cpr_speed_bin
-- 
2.34.1


