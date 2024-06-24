Return-Path: <linux-pm+bounces-9853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2389141A0
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 07:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59403284873
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 05:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F3B134B6;
	Mon, 24 Jun 2024 05:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hmuI66dX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3FA17BD5;
	Mon, 24 Jun 2024 05:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719205422; cv=none; b=Pso+aztD+M5O73QKboqkZrq9sWSw39e+wZzWNvvr0nebtpLrR9u9S07ldhQ0NXdPHIeLKdnxUKQCHu4ZhkXCsWOnJkjuLIaIgKzOwL8eD5avY43vYWdPzM17x27KoaeBTdpaMlAEcFc31Ni/7dpd1cbrfyJDu8aotpzYEY1qm5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719205422; c=relaxed/simple;
	bh=AC0LLx3q7EziaxtktCIgcn0Anh4eIFksSp7KfaONLy4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o6cRFxiZncVrG2xNyCFYM02y6wafnM/tT0yuVuKE8KKaDzK2JCfAea959OL8pq/bYr0f/5ncGTVmANm1MPA+o72WMBNNjOd/A1bd4rHYlz5Zl2+OsemiosRpI3BnZJxjzPbET6QmmJ8yFC0cigUzP1MRCsIg6bUOTPuzdqnv+nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hmuI66dX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NMpdtp025140;
	Mon, 24 Jun 2024 05:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UCP9rts/BDE3wakT8VGlzfdNQNJ3FQCt3q9FiGRrwA0=; b=hmuI66dXXu5l3rN4
	fcQ7XJdOzC9H4Pwm+bm70WIabjUmhna5vIRkuyn1fZ+fiPmyZcYtOmzpcDNnNlc7
	9RYJ3wwevxSfzDZeKdtLCMsH8vX3EId5LznRDJaYllYXuSZv0FXZYa84v5nEgbPS
	xdaIfy1eU2M0rBp3+18hNap0cMhff5XTtrojFPhTAiIR3wRJGTpicfIR1JbPqZj8
	AHzkUM6hSRk2eUx4DAi060UhvGmmy/cDEVf79+8Tl73bv6UMcQZO0rgNQPsqyqmC
	bA1OYu8lLmy4eD4vvJ2qvXkeQrVcxxkA7hjOrbOJneB1+M0dMcHx80iNmw72KnJO
	JXkf8w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnxgtnsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 05:03:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45O53U1r019676
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 05:03:31 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 23 Jun 2024 22:03:24 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <abel.vesa@linaro.org>, <otto.pflueger@abscue.de>,
        <quic_rohiagar@quicinc.com>, <quic_varada@quicinc.com>,
        <luca@z3ntu.xyz>, <quic_ipkumar@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/7] dt-bindings: power: rpmpd: Add IPQ9574 power domains
Date: Mon, 24 Jun 2024 10:32:48 +0530
Message-ID: <20240624050254.2942959-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624050254.2942959-1-quic_varada@quicinc.com>
References: <20240624050254.2942959-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NiqaclOLfQ7uP7GRbu4_7nmyNjZd2Vjl
X-Proofpoint-ORIG-GUID: NiqaclOLfQ7uP7GRbu4_7nmyNjZd2Vjl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=986 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240038

Add the compatibles and indexes for the rpmpd in IPQ9574.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v2: Add Reviewed-by
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 include/dt-bindings/power/qcom-rpmpd.h                  | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 929b7ef9c1bc..e20ba25fa094 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,ipq9574-rpmpd
           - qcom,mdm9607-rpmpd
           - qcom,msm8226-rpmpd
           - qcom,msm8909-rpmpd
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 608087fb9a3d..0538370bfbb4 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -402,6 +402,9 @@
 #define QCM2290_VDD_LPI_CX	6
 #define QCM2290_VDD_LPI_MX	7
 
+/* IPQ9574 Power Domains */
+#define IPQ9574_VDDAPC		0
+
 /* RPM SMD Power Domain performance levels */
 #define RPM_SMD_LEVEL_RETENTION       16
 #define RPM_SMD_LEVEL_RETENTION_PLUS  32
-- 
2.34.1


