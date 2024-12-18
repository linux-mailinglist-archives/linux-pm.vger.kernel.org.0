Return-Path: <linux-pm+bounces-19417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 790089F6383
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 11:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACBC07A1325
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EE519CC11;
	Wed, 18 Dec 2024 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EjQv3nB2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B451619C553;
	Wed, 18 Dec 2024 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734518429; cv=none; b=VRdzvi5Nhvuz2F2Feu1TmGWgRt727XreshwCP1gj0Wi8qY8YlIGH7N2GJrV3HXqt9yEJcZI20np+nyefP6AGMJwwgCa9XXxcFxecAshkM6PmaNi+nJ9LrJBgU7u2LI9NvYtDsQXsyrIQIiXZ0BqKNf1DLfiYJ3K9iqH5+wP6jCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734518429; c=relaxed/simple;
	bh=fbXrTrWzl7QlrnTiX0RvjBuEPcVTQ5W+SjY2vAjPFBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=evOaxz48QzFzCP9RJWlyXpmI2fOCsyLI2irQCnT2JubQihHXiirORbNbCpMhKG1MOnAbP/Dg2G8k/3lsYBpKileGxIQb8r4OZWtZzD1T9uWMmX+XBri2yoIENxq1jbYzYijk+vV3rHu7hK95uUT3lwO1dMg0tzLK5hyURuSU9+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EjQv3nB2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI8mXRW027140;
	Wed, 18 Dec 2024 10:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jgOIofuQLDY+dan5yoGi9Dg0H0R4xXOJ1xub+dOB3pw=; b=EjQv3nB2vY68hSYu
	stvGHFP0iTwnLNfXQ1RufZmxoWp2kcAlCf7ZB6bKJk3dbDjx0IWbhpIH46pCIRax
	k3URBX07GAyRPn3yFqZMrBl8sHvfdEIVUQYj0P/glHCcsTfuO/8VcvixADLoGH3x
	7tqp1A0OIFla/eVlEDVaK2EMItJkSgO1QRDQxSsFTI4KZvFzsJZWUnrgs3sAdXcZ
	dM8DtzpR9thMrcx8BIqeO1G3sa6VCleywFTsFxP4+rG2BI0JYNlqZVSt9E0aMpr3
	3pXMzaRv6cMSmrUF19F9QYq6XjkyD5QqSrx6wQG0ESk1Ok4lM1H8+63wAC6hSgQi
	vYZ7Zg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ku7808vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:40:22 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BIAeLoF021272
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:40:22 GMT
Received: from lijuang2-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 18 Dec 2024 02:40:15 -0800
From: Lijuan Gao <quic_lijuang@quicinc.com>
Date: Wed, 18 Dec 2024 18:39:38 +0800
Subject: [PATCH 1/2] dt-bindings: interconnect: qcom-bwmon: Document QCS615
 bwmon compatibles
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241218-add_bwmon_support_for_qcs615-v1-1-680d798a19e5@quicinc.com>
References: <20241218-add_bwmon_support_for_qcs615-v1-0-680d798a19e5@quicinc.com>
In-Reply-To: <20241218-add_bwmon_support_for_qcs615-v1-0-680d798a19e5@quicinc.com>
To: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Lijuan Gao <quic_lijuang@quicinc.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734518412; l=1302;
 i=quic_lijuang@quicinc.com; s=20240827; h=from:subject:message-id;
 bh=fbXrTrWzl7QlrnTiX0RvjBuEPcVTQ5W+SjY2vAjPFBE=;
 b=2fmwdTTuCNWf+dBAUd/1sdxglhLZT0btlCpe0N7hJge/3WMZVgziTLHCXcIf/bSWgIB95va8a
 4jN5R3IRUF3CJe0/DLwjpECAOeCXy9Q7DYAnY3S1c6tjrPFXfo26dzv
X-Developer-Key: i=quic_lijuang@quicinc.com; a=ed25519;
 pk=1zeM8FpQK/J1jSFHn8iXHeb3xt7F/3GvHv7ET2RNJxE=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wnKpjHnr_QNmfYkT_y0Gjo4WUedfaKH1
X-Proofpoint-GUID: wnKpjHnr_QNmfYkT_y0Gjo4WUedfaKH1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412180085

Document QCS615 BWMONs, which includes one BWMONv4 instance for CPU to
LLCC path bandwidth monitoring and one BWMONv5 instance for LLCC to DDR
path bandwidth monitoring.

Signed-off-by: Lijuan Gao <quic_lijuang@quicinc.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index 251410aabf38..ff24b5ee2c66 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - qcom,qcm2290-cpu-bwmon
+              - qcom,qcs615-cpu-bwmon
               - qcom,qcs8300-cpu-bwmon
               - qcom,sa8775p-cpu-bwmon
               - qcom,sc7180-cpu-bwmon
@@ -41,6 +42,7 @@ properties:
           - const: qcom,sdm845-bwmon    # BWMON v4, unified register space
       - items:
           - enum:
+              - qcom,qcs615-llcc-bwmon
               - qcom,qcs8300-llcc-bwmon
               - qcom,sa8775p-llcc-bwmon
               - qcom,sc7180-llcc-bwmon

-- 
2.46.0


