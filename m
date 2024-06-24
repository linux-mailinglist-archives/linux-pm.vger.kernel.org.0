Return-Path: <linux-pm+bounces-9886-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE38F914647
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 11:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEDA51C21EE7
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 09:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70D7135A69;
	Mon, 24 Jun 2024 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LWNHtv+i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CF51304B1;
	Mon, 24 Jun 2024 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719220984; cv=none; b=ZxK8GHPiz9Dt+hhyJ50KdBsCigwc+Z1/Yehtz1DqqgdGVwEK8nQQd+TIvdtPyUf+ORH3KujVZxvJYrPL6eC57SLfYA0T923uyIls8IeVT4V2PoONSUjsReHaTVkJvAsB8r+Gnh785TRVspPC/w4Cy+dQMGSFBoIsi4l6fwm3dfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719220984; c=relaxed/simple;
	bh=oGc6lY+Ff9IdgPaOaFsr4mAptGjbJWp1HLlO1RozNog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ouk2E8q0K15/XxyDDM3IvXaBN7hfrXw+rkU6yuqPS8VGOj4cnt1V6kEpqbYiGlnuurtFtyG/2O+i2yLp2v2gj6rUPLINhr6W6hg3XalEK7Qwm76sx0408/bIpBOLEoYhNoDrYKeARVk7gEdSSupe+qJwZp/dm4nC89hwAn7UwWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LWNHtv+i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O8YiKw022052;
	Mon, 24 Jun 2024 09:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k17xqWz59ODHMDEARsi76093dBrB6Gc1vYYc7kMODw8=; b=LWNHtv+iOJ3Yois5
	+JpHEINN7IFNhuzNmqxLzgY68KP1iul0QFsSOPMgleUITL1PFO6/JO9RuytGBuh8
	i98dQw9Lf1mPrKRJx35vhFIlitcXCcSANVrjddMoeX6xDeXNYIFCRmxZj5JSEDx7
	0IOqJngNmLl075m/UIrr7mp3CQ5V4Ee6BMjrNL0SatakRjwe9SwI5SKTjsbx2Yno
	StEfuk14FzbxJShY1uHWYrMZXjb4HEFSnvWqicPBbLoI0DtEwmlTmgDKBlZypvOc
	5NrBbyfnNzncVbqs/2hcZSJByp0FochPo2dILC4xZM9ZQ77WubscXgvlpTsgLtjN
	71TFzg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywpu131y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:23:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45O9MxTc028113
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:22:59 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Jun 2024 02:22:53 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <srinivas.kandagatla@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
        <quic_sibis@quicinc.com>, <conor+dt@kernel.org>,
        <abel.vesa@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 2/4] dt-bindings: interconnect: qcom,msm8998-bwmon: Add X1E80100 BWMON instances
Date: Mon, 24 Jun 2024 14:52:12 +0530
Message-ID: <20240624092214.146935-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624092214.146935-1-quic_sibis@quicinc.com>
References: <20240624092214.146935-1-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: LBqv10IvGg_gkBtRG2IMvbUiZj3zfe3N
X-Proofpoint-ORIG-GUID: LBqv10IvGg_gkBtRG2IMvbUiZj3zfe3N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_08,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240075

Document X1E80100 BWMONs, which has multiple (one per cluster) BWMONv4
instances for the CPU->LLCC path and one BWMONv5 instance for LLCC->DDR
path.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v3:
* Pickup Rb's and Tb's from the list.

 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml    | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index 9c248e1eabe2..2cd1f5590fd9 100644
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
-- 
2.34.1


