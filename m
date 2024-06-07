Return-Path: <linux-pm+bounces-8794-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AC2900B63
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 19:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23EE91C2103E
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 17:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A016419CCFD;
	Fri,  7 Jun 2024 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DUwPl6lw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CE319AD95;
	Fri,  7 Jun 2024 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782034; cv=none; b=R2GQ6e/mYTBRMIvfVni3ocR1DHLsE9r+7jIMaLX57MF6be7YPTnLhs44hsfhyMVFcofhWOlXvLJQ+f81dBCmxxb93KA5NO+Cu7OwQXT9v+FOSyRMJGRzbrnksdiJpCL9wEh6spUaXgudL0c0MXYyORPuMvodpu2drvRTBYQeJzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782034; c=relaxed/simple;
	bh=FKk3o+t2VtcbmBRTLc5pUd9y25bQMEp6vTDFaMDrQAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dgo1/s2dQ++5F00vHC8aVnnCreAVz+UUYj0PbuyLy1Y0W5HXjEEnAlhokIrSZhpl0F+7W8Bp3iWBE6gnwm0JXBqmKUmWqVNTX/vcOPt/DdSc0Y7UQGK2S3nEteO9/UpRfuHJuEIktQ03j6xDo9b6WHT8lC8DkbOd3BHvdBCNO+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DUwPl6lw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457HZrMr021526;
	Fri, 7 Jun 2024 17:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4FKkT+e/28S7L0bKbRq7COMY
	fC09vC4M3GNUiYKkuwA=; b=DUwPl6lwesrZCP5QHmJdcSnW5sCZVaS4Kysa6+N7
	iNd2bAiuaI4lTNmdYv7XSKNZ81ICbEOE75Pleu+aH6VaGYqNe5ID51KJrXlWCF8g
	inPV3UeyGW0hWCQcY94MqMZVWZ0FY4c/nJy0B6cbkuRj5Ieq6IFDROMwnQ5E7zBW
	x82C5CZPKJA8p7vktgkL2sIUbqBJzGKMCblreXimczd8D/jphJrrr6kk4OTFtkGw
	1OblcW2qYv+684E+b9Oia5y7RRnwAaotzdPNCZCDogbIzTKpzkQx0M6Q04Zr6v+U
	2laotA48lEYCdrQ6EoJBzZsVrrOxMo5M3I6z+FsvrfBixg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ym0sf14ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 17:40:29 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 457HeS1l020581
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 17:40:28 GMT
Received: from hu-okukatla-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 7 Jun 2024 10:40:23 -0700
From: Odelu Kukatla <quic_okukatla@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Kees Cook <keescook@chromium.org>, <cros-qcom-dts-watchers@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>, <quic_rlaggysh@quicinc.com>,
        <quic_mdtipton@quicinc.com>, <quic_okukatla@quicinc.com>
Subject: [PATCH v5 3/4] dt-bindings: interconnect: add clock property to enable QOS on SC7280
Date: Fri, 7 Jun 2024 23:09:26 +0530
Message-ID: <20240607173927.26321-4-quic_okukatla@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240607173927.26321-1-quic_okukatla@quicinc.com>
References: <20240607173927.26321-1-quic_okukatla@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h4I0232PvMriS27JKmNuFAS6sTmUYmaI
X-Proofpoint-ORIG-GUID: h4I0232PvMriS27JKmNuFAS6sTmUYmaI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_10,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070130

Add clock property to enable the clocks required for accessing
QoS configuration registers.

Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
---
 .../interconnect/qcom,sc7280-rpmh.yaml        | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
index b135597d9489..9fce7203bd42 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
@@ -35,6 +35,10 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    minItems: 1
+    maxItems: 2
+
 required:
   - compatible
 
@@ -53,10 +57,50 @@ allOf:
       required:
         - reg
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7280-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS PHY AXI clock
+            - description: aggre USB3 PRIM AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7280-aggre2-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: RPMH CC IPA clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7280-aggre1-noc
+              - qcom,sc7280-aggre2-noc
+    then:
+      required:
+        - clocks
+    else:
+      properties:
+        clocks: false
+
 unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/qcom,gcc-sc7280.h>
     interconnect {
         compatible = "qcom,sc7280-clk-virt";
         #interconnect-cells = <2>;
@@ -69,3 +113,12 @@ examples:
         #interconnect-cells = <2>;
         qcom,bcm-voters = <&apps_bcm_voter>;
     };
+
+    interconnect@16e0000 {
+        reg = <0x016e0000 0x1c080>;
+        compatible = "qcom,sc7280-aggre1-noc";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+        clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+                 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
+    };
-- 
2.17.1


