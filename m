Return-Path: <linux-pm+bounces-11607-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43057940192
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 01:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3FA8B2176E
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 23:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA7318EFE7;
	Mon, 29 Jul 2024 23:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A6OGB9nS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CE614534B;
	Mon, 29 Jul 2024 23:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722294847; cv=none; b=TztJmfKV9IFd+rQhByugBVS43hMGDaHXhSR9PH3tMov2EwrKpJUjG2bA8eUJUxiW9ozvDYLeZPh7rLXytptEiYdBCnP9+Preq5KeclwjkusShRoduhEqgpPwQGGtb3yMJul6avOpwz8n9uGvRMUXH2tr9U7bHVDBUGfGN5w3uYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722294847; c=relaxed/simple;
	bh=ijSjufOsswESheH+2ZoP0PrD09K2sCq1L1U+izLzx5Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OADYniCpbwrfFM8vHz4Yj1d4SnOLqghl81qcFvSJ/YoTJuu2fDPvlgItXL0IJMki7MbPsRobvzAmuNJ6sDL8uGVDbJH2l7nWp5Vref8ikhVTX+63iEAZdVBZds4p5LnIr4AcenNNcxG4YgQYlgBJBcY57tfsyPEA4UxoECcz0Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A6OGB9nS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TChexQ000379;
	Mon, 29 Jul 2024 23:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/HRw74/o6A7AJZ/DnwPzNMuX06gBLRfFc+bmVnJUMvQ=; b=A6OGB9nS714fn82E
	HhLKsJxhQycekK7/s779ExGCbm7P/EPDLGKj3c35VP9HEPtSSk034azZ7qosM19u
	7lmT4Cw2/ws8uYsT1TTM69OkppN7q/qvJHIxvgaO2mcDYM29sfvtaLZFwF9gZaXu
	C7ovZGlS+JYIEfkoj/5Xh+AX2Krth9hvd1DwD2eiNtnBtnI1CIiN0PKaRn2JfQAY
	7gTT4mf662SeZUYXvLl9iRwVFrcxecxjBm2GsuNXQAS098coTc2Z6nQw0L2JgJ57
	TAnv04JG3fC5cSR70l60TAim3S18X789nBwDsIh9tIwRjtHW5IMd+qG2DJASg4Xk
	4rSPHg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mp8mww6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 23:13:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46TNDe6V017343
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 23:13:40 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Jul 2024 16:13:40 -0700
From: Anjelique Melendez <quic_amelende@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <amitk@kernel.org>, <thara.gopinath@gmail.com>, <andersson@kernel.org>
CC: <quic_collinsd@quicinc.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Anjelique
 Melendez" <quic_amelende@quicinc.com>
Subject: [PATCH 1/5] dt-bindings: qcom,spmi-temp-alarm: Add compatible for GEN2 rev2 temp alarm
Date: Mon, 29 Jul 2024 16:12:55 -0700
Message-ID: <20240729231259.2122976-2-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729231259.2122976-1-quic_amelende@quicinc.com>
References: <20240729231259.2122976-1-quic_amelende@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rFrlwARXzXrjoJ42pZc2kFrm4LCaYM3j
X-Proofpoint-ORIG-GUID: rFrlwARXzXrjoJ42pZc2kFrm4LCaYM3j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_20,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290159

Add compatible "qcom,spmi-temp-alarm-gen2-rev2" for SPMI temp alarm GEN2
revision 2 peripherals. GEN2 rev2 peripherals have individual temp DAC
registers to set temperature thresholds for over-temperature stages 1-3.
Registers are configured based on thermal zone trip definition.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 .../devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml   | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml b/Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
index 30b22151aa82..f9af88d51c2d 100644
--- a/Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
@@ -12,14 +12,16 @@ maintainers:
 description:
   QPNP temperature alarm peripherals are found inside of Qualcomm PMIC chips
   that utilize the Qualcomm SPMI implementation. These peripherals provide an
-  interrupt signal and status register to identify high PMIC die temperature.
+  interrupt signal and status registers to identify high PMIC die temperature.
 
 allOf:
   - $ref: thermal-sensor.yaml#
 
 properties:
   compatible:
-    const: qcom,spmi-temp-alarm
+    enum:
+      - qcom,spmi-temp-alarm
+      - qcom,spmi-temp-alarm-gen2-rev2
 
   reg:
     maxItems: 1
-- 
2.34.1


