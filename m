Return-Path: <linux-pm+bounces-10041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EA6917E78
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 12:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F94284C41
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 10:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839861802DF;
	Wed, 26 Jun 2024 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="irPBsogX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67EC1662F2;
	Wed, 26 Jun 2024 10:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398475; cv=none; b=vBA4B59gWXLdHWU3Ng20hyPgj19WHkFBpSwcSc4Fj7W1uYFYcMo0NPfFumZ9BjQxGjqy9T5wWMdfxrAFPyPqBy0mv6dUlBskUMz2diWmFJDHL2qHMR93APYFOt8oEYtkY3+bERQ4gLZ14IOXKFVBaVaAjlj1WoGAYIbXbaK6d/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398475; c=relaxed/simple;
	bh=ztfUcoULB/YgNfJdRAHyJ7pcIU/OMOsuWIK7F7I551w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyOboygOtZDJwq6AieG6ch9tBbdLKqP1WChMzSXNEZHmNIOEPW8ncWl4vYnjvkurnewHMvph2Tfz1VrsMye/zxD0+ADu8sGlTVmgcz+FVwx4L6sRyPtc4MElV7dOC/7hRPVIlhcJVQpIGDS1r3V53OWHmo6NvVMMJWjDSO8j76s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=irPBsogX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q3n9Vt002405;
	Wed, 26 Jun 2024 10:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iMkUDRIL5Fp6c7nWmGD18/VQ7MnmoxRhTQjla6Ax7/A=; b=irPBsogXJp9Y6TBX
	QjVnYG6s7FQzmelEiPI1CCW4bzqwD4+zEILFkkldvTVMQEIp6WmUeKrKYuSuDaI2
	CP0K1krQosSa5sukarTO2a2Ra4lSxZg04KwixOfeJCobzZ6YoKnBxjuceorBo34D
	JEd4pw+Q/5j+MYvaSQtqoEe+tvQ9rzvw2yg4pCKzbjdWAK7Mlu8DugXiO6zs1tG2
	yHx/niLFrSRg5BSPilO+XtB7gbtpdDKf9AUsX/SIbyLS1Y8SuJzEKqb2Sk+3NMNH
	fgiGIJWGgmX7hZQkKfasFHTCecO0OmyLEJf9sycHgvKO/ZPaW9yCi21KJbNgaqAx
	20KIAA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400bdq915n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 10:41:04 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QAf3SC018992
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 10:41:03 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Jun 2024 03:40:55 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ilia.lin@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ulf.hansson@linaro.org>,
        <quic_sibis@quicinc.com>, <otto.pflueger@abscue.de>,
        <neil.armstrong@linaro.org>, <luca@z3ntu.xyz>, <abel.vesa@linaro.org>,
        <danila@jiaxyga.com>, <quic_varada@quicinc.com>,
        <quic_ipkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v3 4/9] dt-bindings: soc: qcom: cpr3: Add bindings for IPQ9574
Date: Wed, 26 Jun 2024 16:09:57 +0530
Message-ID: <20240626104002.420535-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626104002.420535-1-quic_varada@quicinc.com>
References: <20240626104002.420535-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wnGZlTkePrTzN3OrwwVNGra2bRSDha9O
X-Proofpoint-GUID: wnGZlTkePrTzN3OrwwVNGra2bRSDha9O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_05,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406260081

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


