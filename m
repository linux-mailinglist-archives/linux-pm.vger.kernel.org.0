Return-Path: <linux-pm+bounces-10907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C9C92CA80
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 08:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E1128148D
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 06:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E82B5F876;
	Wed, 10 Jul 2024 06:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ndAQGUYh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0511581749;
	Wed, 10 Jul 2024 06:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720591927; cv=none; b=qRYCEzJ9AbqOWxxyB9Vscv4SwhS7MLMHiNHNYFcBe8wEmNA6CQrtQAoiqe9lKtLfPpLFUDDsuAFc8uqLFeUkZtbAeFFiyviSWitvp7YPeSqUu11lwOd3lOHmZoEIqdRrJqzLeO1YHcL43tWywVisuVrVxWBxcGdCUS6YTrefeY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720591927; c=relaxed/simple;
	bh=8QAiUetgH+uMQr+3WPYPyfbPiCKY4Fxd2pJPqi7I88M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJ5OSUnBTTQLNcT7jCCOrQnKD7XML+ym9ToJZVsJFEPI5qnDqT+sAwfsLx1yR9d0d0hPtDuTGqcYd1aVancgRvElocwXZwjPj0Ts5cVMyf8CYQlhrAsB7ybjbHRtrt2JiDrbQo6TOTfOmRhn0pb0uwejJwCxlClD4x+XFvwufaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ndAQGUYh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A3fjO4003747;
	Wed, 10 Jul 2024 06:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8votFYtWC5ZVkTh4pE34LQoGOOCgrCEPwPBfDeW49Lw=; b=ndAQGUYh6TKzEYkJ
	vH/0sB1dlIHX+fCQKjDePw+Vu7uC8gmLTQK/9hTnf2S0cfd+eygAyTM5Skeg1VhH
	MpXw4rNCdyIDiE01dL5OO8MqfPqwZ5dcxAX1jn8UYUv1mWZonPK+lIrwFDbDGCCZ
	+PvvOnEs7QPPu3r6V3U/CiFr/ytWmuaBLD5tGpyr596SG2tqulqTB+2kY5OJRk5I
	bZP6+X2Qw1JZWcrH4L2qm+iGJ8szJObPpA9dPUAC7yPr7kPj+F1cCttfE0Ibye6v
	sfxbaoAIhfjkXGO5nHnChC6O2EBYaSL28+ayclsZW+IbaXjLJ9c9mUeEuXdfO4Mj
	9KeJFA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 408w0rb7yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 06:11:55 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46A6BreT031426
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 06:11:53 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 9 Jul 2024 23:11:46 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <ilia.lin@kernel.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <quic_rjendra@quicinc.com>, <danila@jiaxyga.com>,
        <quic_varada@quicinc.com>, <neil.armstrong@linaro.org>,
        <otto.pflueger@abscue.de>, <abel.vesa@linaro.org>, <luca@z3ntu.xyz>,
        <geert+renesas@glider.be>, <stephan.gerhold@kernkonzept.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 4/9] dt-bindings: soc: qcom: cpr3: Add bindings for IPQ9574
Date: Wed, 10 Jul 2024 11:40:57 +0530
Message-ID: <20240710061102.1323550-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710061102.1323550-1-quic_varada@quicinc.com>
References: <20240710061102.1323550-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: MEV-HsgeALnFRM8UiJzjeRixweU1AFZR
X-Proofpoint-GUID: MEV-HsgeALnFRM8UiJzjeRixweU1AFZR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100046

Add the bindings for the IPQ9574 CPR3 driver to the documentation.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v5: Add Reviewed-by

v4: Change compatible string to cpr4 instead of cprh
    Not adding Reviewed-By as compatible string changed

v2: Constrained nvmem-cells and the other variant.
    Removed unnecessary blank line.
---
 .../bindings/soc/qcom/qcom,cpr3.yaml          | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
index 2e6712aa1c58..c00373948901 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
@@ -24,6 +24,7 @@ properties:
       - const: qcom,cpr4
       - items:
           - enum:
+              - qcom,ipq9574-cpr4
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
+              - qcom,ipq9574-cpr4
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


