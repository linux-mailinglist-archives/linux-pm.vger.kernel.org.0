Return-Path: <linux-pm+bounces-18147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 328929DA730
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 12:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB659281636
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 11:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761E11F9F5D;
	Wed, 27 Nov 2024 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VReTf/mQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83A01F9F55;
	Wed, 27 Nov 2024 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708309; cv=none; b=C8vGpkmRiC9yRj32n2XuxxDyQF/6EgCAXHHj19fwn/Jy+mweDZ+a+ixDhCyx+mWXS+2geQGHMhYSK61piRFTRz1XBfuPuqxr6TYS7kScnsBsXtx8F1VjPShaw0ckuM4w9g7q9afnzvMW76Wz/plshGuvAbsT/w4RGjJ7cRZgaVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708309; c=relaxed/simple;
	bh=ErPP9c4l3QF+6gCsJyaNXV9lUGfHlw8xtchr84nZNUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+2up/oaY/EuMF1HpHRDM2MGogeGQyn2dgfxk+LQwBmjmlumS8hDwn3sLotXRJPc/uYO/AxadZEhB8U6Zkjx9bvp/dz7r51QQsXdT49d1YZq2r9JYKyZRGAVdGrFgvCwfE0VXt0PFUMfLoDBXdFAFSqphD+89YBK8r3hpWfI3TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VReTf/mQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR8BnrL009576;
	Wed, 27 Nov 2024 11:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1L6EbXGa4gjKewlKK1VepByH
	J/Y1UHlLv72Bl04ORAU=; b=VReTf/mQlYe4hoPN57uXsB1rzLArhNZT6wVtqGY6
	sBE3SAnYzslWSZoM9nw7kugRp6e+uPd3JGT5U+xPuA4rGqqOyMcBmAIkyMylF5JA
	azVaRbHt+YJy4zU5vrmmVJJKnlxsQq7Ua9qlfV5ApmcuS+13AlWDmIhUkVqGnbkW
	FWSZqeThyeV3eDuDrjmgvjEe1Ze0MbN6FLaimdEsYyrfYH+0id6tGpYWwOPtlZGm
	w3Wfs/SflgQglf/50Y927/d7HrMxM201AFDef8lYnTeJRHgiJ0ryoiYeFUG/21vs
	i2pbhsqfIg90XMu1ocPplJ0z5P0Wlt4r3zTpl16OeNorXA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 435ffyu9ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 11:51:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ARBpcuC025967
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 11:51:38 GMT
Received: from hu-janathot-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 27 Nov 2024 03:51:32 -0800
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
Subject: [PATCH v4 2/2] regulator: dt-bindings: qcom,qca6390-pmu: document WCN6750
Date: Wed, 27 Nov 2024 17:21:07 +0530
Message-ID: <20241127115107.11549-3-quic_janathot@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241127115107.11549-1-quic_janathot@quicinc.com>
References: <20241127115107.11549-1-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _pBDr6Aqp9p_24q6N-01cBBsS6A7Uc-h
X-Proofpoint-ORIG-GUID: _pBDr6Aqp9p_24q6N-01cBBsS6A7Uc-h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411270097

Add description of the PMU node for the WCN6750 module.

Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
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

