Return-Path: <linux-pm+bounces-18014-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 857829D7AE0
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 06:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3DB4B21D62
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 05:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57576158DC4;
	Mon, 25 Nov 2024 05:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nibFLhB8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD60D156243;
	Mon, 25 Nov 2024 05:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732511293; cv=none; b=LgUEp6SPmFzMTNpFxrlVmgKwcaRdChcIsxPLGK5VNNaOL8dsY3paTllHpLyD6z0B4oRHJ1trxAxtiBrgQgiLmT7B/yhZKuMsPAk2jRYy3v27CG0qW/5ltYOKXtdgdlJnViFTDxJUaKJaPtZGLsTxQWy7g+jq2ktaTqAXCzjezSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732511293; c=relaxed/simple;
	bh=q/RSdP4usXFXcCIK+6kb16deIBmM5TO0OGkFiQOJGVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IvD2sCm7iVn07DMPDrtYhVuo7IwgyBIg8LIlFHnwBQqub+0zp+H6nukJNkWB8KJB6kGfaZiUvFzD/DPqifRlMWpWBgvLoncZbdXV1h/TlPi07HyHuM2FtuW5KkoOaqIGSlD4928JC1fh9dy5I3FPCOoRu7dGLsLLm5VGAXx5QTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nibFLhB8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AOKmxhf006831;
	Mon, 25 Nov 2024 05:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q1/y+m4mJEoZqxl8zqoG+BMgC0Jf9bp7oSTEWf4BXYU=; b=nibFLhB8Ws8F7sP7
	NSL/eO3e/8/4SKhLdu/yXPnIYqEURoWHPZDngpLnIKCC0p49l619bo9/IGQnuBu5
	Xp+5kaSCPiVRZZRb7S7zsKf0ovevShXPuxHsTE6IffQxn1bNouCvRGN3gvqYfEvP
	9MnL87vV5W8+TMG2Bo1qwZreQ94b6KqETF7wSFaGflkHAPtBcc9F2Gen8nvtGsTx
	qYnaLVYmOAVfQmLQ/M8SO47rTN1wBV/46tK3mbDLfuMpfmKsbqQoF7n+WlvtuZyG
	7QfAwoe/uy5w/PUL5+BDM4n02UhdhjEYRUDrWj6Sn8lRnwOnVzeGW/SJhZiQw4sb
	FAVcVA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4336mxbehx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 05:08:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AP581UM007277
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 05:08:01 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 24 Nov 2024 21:07:56 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v9 1/7] dt-bindings: thermal: tsens: Add ipq5332, ipq5424 compatible
Date: Mon, 25 Nov 2024 10:37:22 +0530
Message-ID: <20241125050728.3699241-2-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125050728.3699241-1-quic_mmanikan@quicinc.com>
References: <20241125050728.3699241-1-quic_mmanikan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: xloGhS0s5_cciz722ihy528YKJqAHFtD
X-Proofpoint-GUID: xloGhS0s5_cciz722ihy528YKJqAHFtD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250041

From: Praveenkumar I <quic_ipkumar@quicinc.com>

The IPQ5332 and IPQ5424 use TSENS v2.3.3 IP with combined interrupt.
RPM is not available in these SoCs, hence adding new compatible
to have the sensor enablement and calibration function. Also add
nvmem-cell-names.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V9:
	- No change

 .../bindings/thermal/qcom-tsens.yaml           | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index ed5de0f92a9e..81bcdb586c36 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -75,6 +75,8 @@ properties:
 
       - description: v2 of TSENS with combined interrupt
         enum:
+          - qcom,ipq5332-tsens
+          - qcom,ipq5424-tsens
           - qcom,ipq8074-tsens
 
       - description: v2 of TSENS with combined interrupt
@@ -211,6 +213,18 @@ properties:
           - const: s9_p2_backup
           - const: s10_p1_backup
           - const: s10_p2_backup
+      - minItems: 8
+        items:
+          - const: mode
+          - const: base0
+          - const: base1
+          - pattern: '^tsens_sens[0-9]+_off$'
+          - pattern: '^tsens_sens[0-9]+_off$'
+          - pattern: '^tsens_sens[0-9]+_off$'
+          - pattern: '^tsens_sens[0-9]+_off$'
+          - pattern: '^tsens_sens[0-9]+_off$'
+          - pattern: '^tsens_sens[0-9]+_off$'
+          - pattern: '^tsens_sens[0-9]+_off$'
 
   "#qcom,sensors":
     description:
@@ -270,6 +284,8 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,ipq5332-tsens
+              - qcom,ipq5424-tsens
               - qcom,ipq8074-tsens
     then:
       properties:
@@ -285,6 +301,8 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,ipq5332-tsens
+              - qcom,ipq5424-tsens
               - qcom,ipq8074-tsens
               - qcom,tsens-v0_1
               - qcom,tsens-v1
-- 
2.34.1


