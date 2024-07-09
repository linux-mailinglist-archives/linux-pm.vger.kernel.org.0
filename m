Return-Path: <linux-pm+bounces-10876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE9E92BB0B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 15:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7622C1C221D4
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCA6158DC3;
	Tue,  9 Jul 2024 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mlrTIL60"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1362815575C;
	Tue,  9 Jul 2024 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720531738; cv=none; b=YWhepFMqR2s5z5ahh6zr2dmWuVa28h8XCEmGDLGrAv76u4FMQnZm6o8T9rKoz5QPJKqqpBrvX7wbXDxFU55UzBBIcY9PsUXDgQr7CqxnP6PPDX4t8MyGapmd/oL8R4OMoc1Dzk3s1ZENWxXRQj0UTl66zNR6Sx6MC3HfwVilAMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720531738; c=relaxed/simple;
	bh=qMCQJ8/1W0T+qinMhKdzHXZpxT8NAUMWZnSBg5EdCs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=J3p62TSLlXc+2rBx4m2s5CbeNi7+A9rQprD3EvwLJ0kuk+Dcb+rH33IRHO4ecJeRMxw1D1FJhmkDM+gLTnWxHkTXTx3S49Lf2/e2m4+AKTCMP4gzX8xciIj3r/FEFVSRrSUx1JDMY/ziptMy7nPdqcOCGJj8cdoqZC+cR8dsLQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mlrTIL60; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469C1jcW019778;
	Tue, 9 Jul 2024 13:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=W0mUc/NZ8nWBiqNkMx/aeR
	j3Y9YfGZ/OpsggO7tODLw=; b=mlrTIL60CfNoP+0YdiDQD9jzO2XW9S8yyVV70N
	2qGoDRdBoLuYeWMtHRa18aRcpJrdPUEWgQ+mzY6CZVNuKAdZBJ58+rk3fRzzQGb4
	Vq8L4usE2GYVZp720ZK/B3CtD4MY6khkpkvLL3uWATq9MItNH0FUOQxyPIkRStAc
	2zE9r5gPj7aFEiAaKu9f65ROH3M7EwrN723T92SnFn8iwZ7qhlWLWQg4YY0q+mEI
	vduajzeEJTNFHB/BkyF2oJFwymXwUH/uFkXbNhbp/Mqi+ujn9+QAIThpD9d5gmi5
	2O9e0n9/1apJ/wQ5cscflxlx8t17f89oR9xEZ2hszSOFVtow==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406y3hea1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 13:28:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469DSkct005166
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 13:28:46 GMT
Received: from tengfan-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 9 Jul 2024 06:28:40 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
Date: Tue, 9 Jul 2024 21:28:02 +0800
Subject: [PATCH v2] dt-bindings: thermal: qcom-tsens: document the QCS9100
 Temperature Sensor
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240709-document_qcs9100_tsens_compatible-v2-1-f09a143161c1@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOE6jWYC/zXNSwqDMBSF4a1Ixo1cUyXaUfdRJJjkqhdqfCRKi
 7j3RqHD7wzOvzOPC6Fnj2RnC27kaXQR4pYw0zeuQ042mgkQOUiouB3NOqALaja+ygBU8Oi8MuM
 wNYH0G7kGqQtpK51bw+LPtGBLn6vxqqN78mFcvldyy871/34HUZQFpCKTAqDkGZ9XMiqg69rGP
 U+QM2lssfo4jh/IX1GCvQAAAA==
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath
	<thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Daniel
 Lezcano" <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <kernel@quicinc.com>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tengfei Fan <quic_tengfan@quicinc.com>
X-Mailer: b4 0.15-dev-a66ce
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720531719; l=2432;
 i=quic_tengfan@quicinc.com; s=20240709; h=from:subject:message-id;
 bh=qMCQJ8/1W0T+qinMhKdzHXZpxT8NAUMWZnSBg5EdCs4=;
 b=2N+GHc10NYnv1DJ2uhbr4H0Gjvmqr36dhj4pv/sERioKWkuu8+308ENvo2rZyNli8W2Qe/HyO
 cHObo8BRr2FBid0JrCNnbI3hN8jt+9May11n296rMTj/Opty7xXCmrb
X-Developer-Key: i=quic_tengfan@quicinc.com; a=ed25519;
 pk=4VjoTogHXJhZUM9XlxbCAcZ4zmrLeuep4dfOeKqQD0c=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TjQTb69L34v6Jlnc53reh9E_L3FV5h0I
X-Proofpoint-GUID: TjQTb69L34v6Jlnc53reh9E_L3FV5h0I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_03,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090086

Document the Temperature Sensor (TSENS) on the QCS9100 Platform.
QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
platform use non-SCMI resource. In the future, the SA8775p platform will
move to use SCMI resources and it will have new sa8775p-related device
tree. Consequently, introduce "qcom,qcs9100-tsens" to describe non-SCMI
based tsens.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
Introduce support for the QCS9100 SoC device tree (DTSI) and the
QCS9100 RIDE board DTS. The QCS9100 is a variant of the SA8775p.
While the QCS9100 platform is still in the early design stage, the
QCS9100 RIDE board is identical to the SA8775p RIDE board, except it
mounts the QCS9100 SoC instead of the SA8775p SoC.

The QCS9100 SoC DTSI is directly renamed from the SA8775p SoC DTSI, and
all the compatible strings will be updated from "SA8775p" to "QCS9100".
The QCS9100 device tree patches will be pushed after all the device tree
bindings and device driver patches are reviewed.

The final dtsi will like:
https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-3-quic_tengfan@quicinc.com/

The detailed cover letter reference:
https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
---
Changes in v2:
  - Split huge patch series into different patch series according to
    subsytems
  - Update patch commit message

prevous disscussion here:
[1] v1: https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 99d9c526c0b6..ace2cf1975c4 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -51,6 +51,7 @@ properties:
               - qcom,msm8996-tsens
               - qcom,msm8998-tsens
               - qcom,qcm2290-tsens
+              - qcom,qcs9100-tsens
               - qcom,sa8775p-tsens
               - qcom,sc7180-tsens
               - qcom,sc7280-tsens

---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240709-document_qcs9100_tsens_compatible-b07b57d9b4dc

Best regards,
-- 
Tengfei Fan <quic_tengfan@quicinc.com>


