Return-Path: <linux-pm+bounces-9479-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500B490D794
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 17:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639821C20CCC
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 15:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214A547A74;
	Tue, 18 Jun 2024 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JDrgD2RY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9448F481CD;
	Tue, 18 Jun 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725417; cv=none; b=r9KXQZIHGduyEO7LX2je/X0g3AWmbNYdxESUSfnyieE7Hq2Rg2iRzOgbm+0wtW9guz4p3o5yzukyNyXZ3YDQa7Yhrdtszm6ZnpaBV42PhnvlW2mx5zsYC1U+cnkT1VFrvlVWQ/A7GxaiKE4RLdmi1JeO8omrnMdiANF4C8Uq3m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725417; c=relaxed/simple;
	bh=w1xfBO+DlsYwaY6sJD5DdugPbAIEFeck3AOthuAGJfw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PESrW7gxPhq9jL9mHzDnILiOAbr//AAn3rpiqRiV1rcLuME2uT0V6QRdqVCQm3OWklWp2zL7H5fO2AMZLW6u0vxMbpNLbeZNjY1UJWJXv1DyGpko3CxkOtBAOjlL3Ko50xHuvEufJjIHOX9NhUxWvfma7ObsqJa9z3QGx8aXG34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JDrgD2RY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ICqmlf006339;
	Tue, 18 Jun 2024 15:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oki8BJUg9rIYs4X5TEOjWXXqjFlxRakbFrT/hxBPjqw=; b=JDrgD2RYfTTQybIn
	xdj8efX4KZVIsGlmMFfrVVfFzYvrGEsTZSCLO79pd8awJm0EvysOsAuSPbZH9ssP
	hbnoPWauaue9FszxnvGAIKjn1Q4k6Tq8LYgYKRkju6W5l5POP28unDUmu5ZFxFjg
	7ByzvOozgfYDyEwppgdfnAuOelKYwoZ4mxALLhjZHd/FpCpBsMKA+6v7vcCBcfak
	UchZZrmUxHqMpYtpXnbNKJWLSDcKDAsT/Jl72nTJ50qcag0rpQl0l51Ufy1OQ5M+
	Eyn+EFkoZfFnX/HCIv3Hi09ECBYevlvjQexSQlEmfe8kQvN4mCw9MF3ivauNAZMw
	pXgiNg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuamp0e98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 15:43:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45IFhUaK001369
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 15:43:30 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Jun 2024 08:43:25 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <srinivas.kandagatla@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <quic_sibis@quicinc.com>, <conor+dt@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <abel.vesa@linaro.org>
Subject: [PATCH V2 1/3] dt-bindings: interconnect: qcom,msm8998-bwmon: Add X1E80100 BWMON instances
Date: Tue, 18 Jun 2024 21:13:04 +0530
Message-ID: <20240618154306.279637-2-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618154306.279637-1-quic_sibis@quicinc.com>
References: <20240618154306.279637-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: G77rrkcjj0LOo-iuGXSMRuzLbMnLxthM
X-Proofpoint-GUID: G77rrkcjj0LOo-iuGXSMRuzLbMnLxthM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180118

Document X1E80100 BWMONs, which has multiple (one per cluster) BWMONv4
instances for the CPU->LLCC path and one BWMONv5 instance for LLCC->DDR
path. Also make the opp-table optional for the X1E cpu-bwmon instances,
since they use the same opp-table between them.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v2:
* Allow for opp-tables to be optional on X1E cpu-bwmon instances. [Konrad]
* Drop Rb from Krzysztof due to more bindings changes.

 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index 05067e197abe..090dbf8dca8b 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -35,6 +35,7 @@ properties:
               - qcom,sm8250-cpu-bwmon
               - qcom,sm8550-cpu-bwmon
               - qcom,sm8650-cpu-bwmon
+              - qcom,x1e80100-cpu-bwmon
           - const: qcom,sdm845-bwmon    # BWMON v4, unified register space
       - items:
           - enum:
@@ -44,6 +45,7 @@ properties:
               - qcom,sm8250-llcc-bwmon
               - qcom,sm8550-llcc-bwmon
               - qcom,sm8650-llcc-bwmon
+              - qcom,x1e80100-llcc-bwmon
           - const: qcom,sc7280-llcc-bwmon
       - const: qcom,sc7280-llcc-bwmon   # BWMON v5
       - const: qcom,sdm845-llcc-bwmon   # BWMON v5
@@ -72,7 +74,6 @@ required:
   - interconnects
   - interrupts
   - operating-points-v2
-  - opp-table
   - reg
 
 additionalProperties: false
@@ -100,6 +101,17 @@ allOf:
         reg-names:
           maxItems: 1
 
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - qcom,x1e80100-cpu-bwmon
+    then:
+      required:
+        - opp-table
+
 examples:
   - |
     #include <dt-bindings/interconnect/qcom,sdm845.h>
-- 
2.34.1


