Return-Path: <linux-pm+bounces-18015-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB8F9D7AE3
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 06:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640E0162C40
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 05:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016DA13CFA6;
	Mon, 25 Nov 2024 05:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YDP2C/kM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6337E170A23;
	Mon, 25 Nov 2024 05:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732511297; cv=none; b=MYNVUfOFNPlVmyiuIkdzDileCWz5fSfUW4NE9hiUAgN/CD4xKNauLjPnhyXvUZg6gpFc2BBpPwpsJrSz+dCyY5N9stE8fHnXbWEKbK8K/JEkpIRYIlu+WKm9j7r+MAYRtSh/CfdTqo7HON2PjjJDvGPJX8jWrbmXMdgLQ9iHL1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732511297; c=relaxed/simple;
	bh=3RwTOV1VL41b5PVejbcg2ypFkF3eYxxsFiVIYffPKFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAM1ubam6LOh5KLn0TwpOZSFRsj5ZImcVf+pvFIeXURnf+qoqN2WIryZz54JiGHGkvt+90+MZt1jNq307w5RJo0WOR9FoE0LS/zRoSljJ4wqoe3weC9z4drFw868+mtZkSU5L5CPrhfAQl7vlcScPjbQNShL75NQr9i6ZUWwALg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YDP2C/kM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AONg0KJ002125;
	Mon, 25 Nov 2024 05:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T0zjW8JolJOh8R+nmAqLYooi+x+x07uSxm2w1teoKvE=; b=YDP2C/kMvhHlCF5a
	A1P2kGgTzkC7xVZ37Q3wxEX5XmEl01EJo74Kx48C1hlFlpq2GwsPz2HJbNCaZGar
	qULUJE+bUDoLzxwLXGsxW4SI1doqdAwAVVpYYWA6g45vNYLtQL/dPds2HrGCzuop
	0lAhuApNAJ2BMIvK0S8y6EnvayagG9lIMqwRS+96paVdFYN92nq3rc9A7loteVrs
	9+BZTdfr7ox2+P3ub8KUt8CksA/B94RF6mvAMt96rwu+wB4nV3AbOdS5u/fB1NNj
	dUqgSv3u7PfUtBljpJOhHMYiVbShC8kIJxxO3Mus3wv/G4ukUnVqW0+9wg0HfTWO
	8ZcseA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4336mxbej4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 05:08:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AP587EF001090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 05:08:07 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 24 Nov 2024 21:08:02 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v9 2/7] dt-bindings: nvmem: Add compatible for IPQ5424
Date: Mon, 25 Nov 2024 10:37:23 +0530
Message-ID: <20241125050728.3699241-3-quic_mmanikan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: zYzWn8rjMFzbkK4dwC0bpowCgfscPOhH
X-Proofpoint-GUID: zYzWn8rjMFzbkK4dwC0bpowCgfscPOhH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250041

Document the QFPROM block found on IPQ5424

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V9:
	- No change

 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 80845c722ae4..507671a75cb7 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -20,6 +20,7 @@ properties:
           - qcom,apq8064-qfprom
           - qcom,apq8084-qfprom
           - qcom,ipq5332-qfprom
+          - qcom,ipq5424-qfprom
           - qcom,ipq6018-qfprom
           - qcom,ipq8064-qfprom
           - qcom,ipq8074-qfprom
-- 
2.34.1


