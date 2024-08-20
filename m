Return-Path: <linux-pm+bounces-12511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ECA957D0F
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 07:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC37F1C23D39
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 05:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351211547D1;
	Tue, 20 Aug 2024 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A1WGTIvE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C5214B949;
	Tue, 20 Aug 2024 05:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724133465; cv=none; b=fKkZ14u73gAAVePPg+MP0HX2/6dXj7Xe5tqhDalDPSOzu7WHLFnqvyCMAQAkfdxrnvuqMYMLFQ6dJ1N1zkqRM5csR/h9kku1PRHA7jj6se2+ffY0st3k4a2jFo/MsnpepyJXsDqdx3Jh3TeZN3cMB9AN5z0oIC4M+tAPM7QxwpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724133465; c=relaxed/simple;
	bh=8QAiUetgH+uMQr+3WPYPyfbPiCKY4Fxd2pJPqi7I88M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5O9ID2H4l/S6GewZRcnS2FXJLIyzKytq85QzfbH492F208LWPokwQosXP03jgOD3AR81Pvl0LkfPAAJf7V7KKZSVMeRnyr92fFZiovMcVQrvjH83vbKgG5ecOJKIFqJrQOfJLuOb5YcV2ZZnHnEm3ik13tcsN29llLDetthGAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A1WGTIvE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K1UiXS000449;
	Tue, 20 Aug 2024 05:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8votFYtWC5ZVkTh4pE34LQoGOOCgrCEPwPBfDeW49Lw=; b=A1WGTIvEoMzMnQwl
	qpNmGxI0/Ck2Q99BLxa+cZLtfN/mkFV/R/RogGrl0WcDGn+1cu3RGHuIgziYNkL6
	Idr3IdGs1l6xurM9Iyki4dWncnMGFsc/bzHCcpBML9I6kJOyEQWoUuhtnzafGE6Y
	xhjxapGS9x4jhz3s+NcZkvGZ2+nrRW2ySRqfvnIUfpnG5MuhEWUKQF2ZW0c+jN8y
	IPFftSnVo+YqvZhFyhHnC89q6YWQ0dk2bYS4p6mIChIu8VOFy82TcidImOxWEU1f
	W3MV/DKKRj8KIKbSWfHVrp+mLR0N6FoGbDZqT6q4S5d2ZrbJlFQFjewf3T6wotlJ
	Fu/8Ww==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 412hjdem2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 05:57:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47K5vdvH024213
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 05:57:39 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 19 Aug 2024 22:57:34 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <konradybcio@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ilia.lin@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ulf.hansson@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 3/7] dt-bindings: soc: qcom: cpr3: Add bindings for IPQ9574
Date: Tue, 20 Aug 2024 11:27:01 +0530
Message-ID: <20240820055705.3922754-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820055705.3922754-1-quic_varada@quicinc.com>
References: <20240820055705.3922754-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: HSVl4nBaG8qjBHDcD5ehBfCmMFsQ4XlD
X-Proofpoint-ORIG-GUID: HSVl4nBaG8qjBHDcD5ehBfCmMFsQ4XlD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408200044

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


