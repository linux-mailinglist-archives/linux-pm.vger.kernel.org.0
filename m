Return-Path: <linux-pm+bounces-19480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B46A9F74AE
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 07:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0572169EF4
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 06:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E62216E0D;
	Thu, 19 Dec 2024 06:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RkhrC87f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3B71F868D;
	Thu, 19 Dec 2024 06:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734589758; cv=none; b=MnwlVhUl2UudIy8hWWweOTu07A37Ean9jD64IRk1VD2thv1ncXsJ5SI28SHI3j272q4pKnyGidRSwDPLKYB4pzYzN53HRK4tbcJtYKqKpjX0XkG/T3Hc/Wsi9tmIPirFFOZg5666KHRwve/rxDqEEYPh/qrRZtC8J7FDIcIY7Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734589758; c=relaxed/simple;
	bh=/93rOhI3cAQ6F7TqcvoSrolcUuFMUarP7kW1xq9zlps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoWT+c/jqmt/8VHvnIWnSmki9SQ84P2IxTpqhzPRLxTC1o+IMf0eXhWAnQN4uFbmo0+aS8O7+7Uq4UCxmgGX+iezkntSKMFi935XjUZTHXwWW0iPfYH5DP8l4G9lmOOljQunKoW0Rv9+9wVYst4YroDWMnmqi4rEZgnAEitjF6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RkhrC87f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ1ldro029666;
	Thu, 19 Dec 2024 06:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SC48z/fHnBFNAUj1EIP4/oIg3SrchsrqLbLJ7HLqc/A=; b=RkhrC87fpN4bzyPI
	3XZty6ssC7Fp1Zki3KNAFdPpChlR6jymkChCPodNqtcXGXXD6J/A3Bxw5fr7zkGL
	+XZgoF6dRrwMNMqg52H3fbDPn1RGmrvGDxIS+HEhwVci/7Hqr99tBjJ3PyZdX1OP
	yEtk3Oe7dRMBovL+g4bxLNY6huzc3WPUpGmDXLZNqYA0LSusJkGuTvTJW4XE4igK
	0bwqkwWHOkERa6Z1d4ZReXtG5pimR59GI3WPM6zIpUHZihmgRhs8juRlTh5DebY4
	Mmu9fOeeKqOigkHZTXpnBvpuHsKhTgWnOHrkhCw6ujxmIXdr7BOFx383o9scdCkq
	YQSzXA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ma4wrhar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 06:29:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BJ6T5ZA019845
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 06:29:05 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 18 Dec 2024 22:28:59 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v10 1/7] dt-bindings: thermal: tsens: Add ipq5332, ipq5424 compatible
Date: Thu, 19 Dec 2024 11:58:33 +0530
Message-ID: <20241219062839.747986-2-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219062839.747986-1-quic_mmanikan@quicinc.com>
References: <20241219062839.747986-1-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jyKN9mxDaaUBv_y-Ejjct9uDGLD5qP9u
X-Proofpoint-ORIG-GUID: jyKN9mxDaaUBv_y-Ejjct9uDGLD5qP9u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190050

From: Praveenkumar I <quic_ipkumar@quicinc.com>

The IPQ5332 and IPQ5424 use TSENS v2.3.3 IP with combined interrupt.
RPM is not available in these SoCs, hence adding new compatible
to have the sensor enablement and calibration function. Also add
nvmem-cell-names.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V10:
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


