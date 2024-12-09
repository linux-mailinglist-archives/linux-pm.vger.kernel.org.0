Return-Path: <linux-pm+bounces-18804-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D539E906B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 11:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910201886F66
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 10:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633C621A933;
	Mon,  9 Dec 2024 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X0AP4h7+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF5821767D;
	Mon,  9 Dec 2024 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740534; cv=none; b=BqP3+DdZXKQNHx1P+w85tAQqDn4Uz0ywMaeSkQtLE+a84RQULg5lhOdPUqCEamuDw36t2AMkmu8osW5537PZafNkrqhfZb9PfclvfBg8apukPYgjLmHlPnvII651wtaKM1P6PSIpOq8tHlqC/WM6XwOqb9J7zUY2YmQLdGaJ5rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740534; c=relaxed/simple;
	bh=d3pWDs1LdTANjzMQ2C6+0ExYZcZpdoqgXlbwhr5c8kc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kzXT/sD1zq5vahPrBEgBQ958fFudDbZOmwsmEe4R+Mgp3u2bc0LbMC2uN6V6hPR95u89MLAkt5MK5wF5mUnqGwhB8Qj7A4cwLzR7HecJCE8T2yO7n1XEitrV6ioRye2PbYvnNTAHnVlxzAPINe+sjjuQrQ8dPqzYK2DapO+hrog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X0AP4h7+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9AVur0011600;
	Mon, 9 Dec 2024 10:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y+D+KIjJmqBOFmxiM/RgL1kv/Ntwsp6HYIiRz2aR1l4=; b=X0AP4h7+XZg1cPjV
	Z7oQ2EI+hCjH8AADIsha9fQBnqW8afnw1x/SSk8xhxWNIzxTAzq5zedzxuzUjWbM
	RqlR000wH33ncA6Yz8R1TvwMYL0Ej8DQ+1amtR6pIBP1DkRfCw3Wi6qenmXomAdP
	YOHiNtrJ2Og8VXwCP+VGD+P28FKww3oeAE3bO4STCJM7AOhl8g6fKxjW/+8HYKE1
	Vgxd/FVS/twpxKl3G9HV+9YQW1OOWoMORKlnXxpUUXTLX8u72tKDMUXXrYCap+to
	Sc5S8eds8L8/yPPU3VggSWQRqls8TwSdz1vfJB34YDv8NZnR/S9dTglNXjnq2Dpj
	wUeHcQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cdc6cc6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 10:35:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B9AZONC006956
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 10:35:24 GMT
Received: from hu-janathot-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Dec 2024 02:35:18 -0800
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konradybcio@kernel.org>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v5 1/4] =?UTF-8?q?regulator:=C2=B7dt-bindings:=C2=B7qcom,q?= =?UTF-8?q?ca6390-pmu:=C2=B7document=20wcn6750-pmu?=
Date: Mon, 9 Dec 2024 16:04:52 +0530
Message-ID: <20241209103455.9675-2-quic_janathot@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209103455.9675-1-quic_janathot@quicinc.com>
References: <20241209103455.9675-1-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gQe9RCEXt0gTbcDrM9i_nhhjDARLz_nY
X-Proofpoint-GUID: gQe9RCEXt0gTbcDrM9i_nhhjDARLz_nY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090082

Add description of the PMU node for the WCN6750B module.

Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/regulator/qcom,qca6390-pmu.yaml  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
index ca401a209cca..47c425c9fff1 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     enum:
       - qcom,qca6390-pmu
+      - qcom,wcn6750-pmu
       - qcom,wcn6855-pmu
       - qcom,wcn7850-pmu
 
@@ -27,6 +28,9 @@ properties:
   vddaon-supply:
     description: VDD_AON supply regulator handle
 
+  vddasd-supply:
+    description: VDD_ASD supply regulator handle
+
   vdddig-supply:
     description: VDD_DIG supply regulator handle
 
@@ -42,6 +46,9 @@ properties:
   vddio1p2-supply:
     description: VDD_IO_1P2 supply regulator handle
 
+  vddrfa0p8-supply:
+    description: VDD_RFA_0P8 supply regulator handle
+
   vddrfa0p95-supply:
     description: VDD_RFA_0P95 supply regulator handle
 
@@ -51,12 +58,18 @@ properties:
   vddrfa1p3-supply:
     description: VDD_RFA_1P3 supply regulator handle
 
+  vddrfa1p7-supply:
+    description: VDD_RFA_1P7 supply regulator handle
+
   vddrfa1p8-supply:
     description: VDD_RFA_1P8 supply regulator handle
 
   vddrfa1p9-supply:
     description: VDD_RFA_1P9 supply regulator handle
 
+  vddrfa2p2-supply:
+    description: VDD_RFA_2P2 supply regulator handle
+
   vddpcie1p3-supply:
     description: VDD_PCIE_1P3 supply regulator handle
 
@@ -119,6 +132,20 @@ allOf:
         - vddpcie1p3-supply
         - vddpcie1p9-supply
         - vddio-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,wcn6750-pmu
+    then:
+      required:
+        - vddaon-supply
+        - vddasd-supply
+        - vddpmu-supply
+        - vddrfa0p8-supply
+        - vddrfa1p2-supply
+        - vddrfa1p7-supply
+        - vddrfa2p2-supply
   - if:
       properties:
         compatible:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


