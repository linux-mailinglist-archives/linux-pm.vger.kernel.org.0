Return-Path: <linux-pm+bounces-14643-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD46985465
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 09:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152F51C23199
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 07:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C61714A0AE;
	Wed, 25 Sep 2024 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p8YG+41F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E46768E7;
	Wed, 25 Sep 2024 07:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250325; cv=none; b=A8pn2ZMk5Dwim1wtlPICLbMKebKTBxWQIBZei7386HO45Q3I9kLFspCITqEHF6ZfnRD+1prnxJ3GpOztA4B5R+Y88uEks3C9Yu7bitefmLwdwkGcRRgmicVgjVPTEl2iIEwDLIt8bEAs1/jzWprB2936fBS+tHpd9HimrSTkujo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250325; c=relaxed/simple;
	bh=IE8ZVu2aiidjh+hRIBeJ/vw9AQM1Lg63nrhIP0/Uaaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=suz3CNKQCBJ6MtJT8Ksp5ZhdgZSvDH/b1RHiS2aEXy76FbcKFFBl2oaH3ryYCnwYbFJgC+SPagyAbtR+J+0VRAd8c7K0T1n3phK+qRJZ9qpBvW02bKDuTT3NDMi1/waXCX5w12VZ+2rq59tNBDX7UUgQ3kU+GeDhKbP5/WYVglg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=p8YG+41F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OI25XF013399;
	Wed, 25 Sep 2024 07:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=URXGrPY7ypUtdDqnCvuaAT
	HIgW9AP3ddNNq9J4c23OQ=; b=p8YG+41FMP4G4TasYReDsIadY5uzVUhRX4xbs/
	y6+9kWspjtAGr8MkdAJa+Z6sE2Y+g0Fe50xKrl+mEZmf5c6WfIKW1BHo6+dWqOFE
	HAm6EAAEoto0UKo8KPvjIYehy98rSdeOLkNatFT0Zv6cTT+0MGqh8znCTGyzVeWB
	hSA24aT3S1zXGnPV3y/2Ksq1B3Q3AEoMpIpLARP2h36j5z3eW0sY4E8nXFKCSlGV
	fKap7zXLptjifw/mdhr8epXplwLemVwO3jVuZ6+JhLa9W6mloEeaHweDi0gikbZj
	EyLF5TABxx2FOGTuVM5l6SHOmyWyweajWTdOm0Baqsu+fE4w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41spc2u4en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 07:45:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48P7jJbu001253
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 07:45:19 GMT
Received: from jingyw-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 25 Sep 2024 00:45:17 -0700
From: Jingyi Wang <quic_jingyw@quicinc.com>
Date: Wed, 25 Sep 2024 15:45:06 +0800
Subject: [PATCH] dt-bindings: interconnect: qcom-bwmon: Document QCS8300
 bwmon compatibles
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240925-qcs8300_bwmon_binding-v1-1-a7bfd94b2854@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAIG/82YC/x3MTQ5AMBBA4avIrDWptn6vIiKqg1kYtAkScXeN5
 bd474GAnjBAkzzg8aRAG0dkaQLjMvCMglw0KKmMrFUujjFUWsreXuvGvSV2xLMoTOYqNHbSZQG
 x3T1OdP/ftnvfDyLo2bRnAAAA
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov
	<djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <quic_tengfan@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jingyi Wang <quic_jingyw@quicinc.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727250316; l=1422;
 i=quic_jingyw@quicinc.com; s=20240910; h=from:subject:message-id;
 bh=IE8ZVu2aiidjh+hRIBeJ/vw9AQM1Lg63nrhIP0/Uaaw=;
 b=aRTjs8Zvo3qvyumphImuX18BBp/XI8y7mkkYzjZBhWOTOfEPxRzrGRCEIK2BG8wNfFGw7bQr7
 XmCks+84mhkAxTRKUqKRkyCBvfhVcyXL8DzDFl2gD59qRQh2RTyIPPS
X-Developer-Key: i=quic_jingyw@quicinc.com; a=ed25519;
 pk=ZRP1KgWMhlXXWlSYLoO7TSfwKgt6ke8hw5xWcSY+wLQ=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hDCOYzy3pQjHRyQHpjhFcjEiL5SLLOPp
X-Proofpoint-ORIG-GUID: hDCOYzy3pQjHRyQHpjhFcjEiL5SLLOPp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=907
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409250054

Document QCS8300 BWMONs, which has two BWMONv4 instances for the CPU->LLCC
path and one BWMONv5 instance for LLCC->DDR path.

Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index 189f5900ee50..251410aabf38 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - qcom,qcm2290-cpu-bwmon
+              - qcom,qcs8300-cpu-bwmon
               - qcom,sa8775p-cpu-bwmon
               - qcom,sc7180-cpu-bwmon
               - qcom,sc7280-cpu-bwmon
@@ -40,6 +41,7 @@ properties:
           - const: qcom,sdm845-bwmon    # BWMON v4, unified register space
       - items:
           - enum:
+              - qcom,qcs8300-llcc-bwmon
               - qcom,sa8775p-llcc-bwmon
               - qcom,sc7180-llcc-bwmon
               - qcom,sc8280xp-llcc-bwmon

---
base-commit: 4d0326b60bb753627437fff0f76bf1525bcda422
change-id: 20240925-qcs8300_bwmon_binding-641d8e4bf376

Best regards,
-- 
Jingyi Wang <quic_jingyw@quicinc.com>


