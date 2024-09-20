Return-Path: <linux-pm+bounces-14507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE7597D079
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 06:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4671C238FE
	for <lists+linux-pm@lfdr.de>; Fri, 20 Sep 2024 04:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB4439AEB;
	Fri, 20 Sep 2024 04:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IP0sxIBy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260D838382;
	Fri, 20 Sep 2024 04:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726805404; cv=none; b=j3ETcn63ugUVyYBgev9hCkagx7sS7XtYbNIk8LhnXcp9N8XxqvQed3/BaZkWP/2Z1hsCsVuJDx7RybZH0umoIzZ0PYER/VsqiYZr4+VFpT5En4e/zG0dDt27Z/cijvg3KdHKjM06B2SfHcfwilPjTKwHxAXZVeM1AlZ52r0Hjz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726805404; c=relaxed/simple;
	bh=fXh0IOsWmtSixs5iQZqOcOSLHZggfj3AT+mm62bypJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XErOlmEBT0JC7cYdbAeWeNJxvu/+c9xvkOTmYdOw+S2kDf49ZQkIArLPOQ6pq+yzpqZ6trOstBRAjFoER5Hn74BaoDtzoLPHtyv01rWcXGD0GfhOsg2MLxQ6uLYGl/IonxumU0g286GeF52icRASHPV7dolC/JAmahkqo0Bj8Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IP0sxIBy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JJ465X017296;
	Fri, 20 Sep 2024 04:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M9T3WnW2e29PHZshmHGysd0bjD+oVWzmhy3XzwkHMxo=; b=IP0sxIByjNXPBL6T
	vbrhi2byAFyfCxoEpj4Ck3XW93y6yTz6Rl1af/n+aSV+kh1qDL0T6cBVjC6Me0jP
	gOYjL5tmZgLyqMQyBYzxSDxTJP93Yd40TMhfz0kIqDBiFZsP5P+PKK3B7ESVoGX4
	Qyw7Ry7/YC2fBtxN3iQSade8BBCZ4//a3zGw2oSj97Zl7KX0IW1aJlpEuluVhCEX
	GJsncgqau3yRjj4niUg8ImXJsV+kWNNsSPiwxjRlKsvxTyXZHiR3w49To4PbDiwq
	QlKYc9DQDBZzckuDgQVAe3NRrGQR/uEW79aeUgKB6kD/p/LsdCuMViAboAjRSY8h
	VeI2jA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4hhfn8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 04:09:58 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48K49uVE020918
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 04:09:56 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 19 Sep 2024 21:09:50 -0700
From: Tingguo Cheng <quic_tingguoc@quicinc.com>
Date: Fri, 20 Sep 2024 12:08:42 +0800
Subject: [PATCH 1/2] dt-bindings: power: qcom,rpmpd: document qcs615 RPMh
 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240920-add_qcs615_powerdomains_driver_support-v1-1-8846efaf9454@quicinc.com>
References: <20240920-add_qcs615_powerdomains_driver_support-v1-0-8846efaf9454@quicinc.com>
In-Reply-To: <20240920-add_qcs615_powerdomains_driver_support-v1-0-8846efaf9454@quicinc.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_fenglinw@quicinc.com>,
        <quic_tingweiz@quicinc.com>, Tingguo Cheng <quic_tingguoc@quicinc.com>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726805386; l=861;
 i=quic_tingguoc@quicinc.com; s=20240917; h=from:subject:message-id;
 bh=fXh0IOsWmtSixs5iQZqOcOSLHZggfj3AT+mm62bypJA=;
 b=DGxu3S0tLVLqAQveNGzKl3V0Ueh/72tByfihqXxxARzqTMz+nFiRw4g1Ykg3gLMD8twURzm/c
 YBGbQ0Zai5yAnv64UlGeHNDftCnqummtBX+PtveTyP513aBlf9Jeqn0
X-Developer-Key: i=quic_tingguoc@quicinc.com; a=ed25519;
 pk=PiFYQPN5GCP7O6SA43tuKfHAbl9DewSKOuQA/GiHQrI=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xOdP2YV5jnwjq3sh3AfFSgPOXBGDZV65
X-Proofpoint-ORIG-GUID: xOdP2YV5jnwjq3sh3AfFSgPOXBGDZV65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409200026

Add compatible string for the RPMh power domains on qcs615 platform.

Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 929b7ef9c1bcdae8194adfdfd6114573ab4d59cd..b4f4ea905667a94806f632166db54384bc9de8e3 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -32,6 +32,7 @@ properties:
           - qcom,msm8998-rpmpd
           - qcom,qcm2290-rpmpd
           - qcom,qcs404-rpmpd
+          - qcom,qcs615-rpmhpd
           - qcom,qdu1000-rpmhpd
           - qcom,qm215-rpmpd
           - qcom,sa8155p-rpmhpd

-- 
2.34.1


