Return-Path: <linux-pm+bounces-23087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4452A48393
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22A3169F4B
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 15:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51861AC435;
	Thu, 27 Feb 2025 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pRcKd7+N"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198981AAA05;
	Thu, 27 Feb 2025 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671569; cv=none; b=TAZjqAg5/7nnai4ByP4cJVPv8JSnoFFlilL2u5YGK6GEN8RNumyHbtz3JoqLzpqhGrntS9B2RFYWkEn5MpEA1gE/fO9929b/FqsnMAt292PX65vlAg4N7Yb9PG3ycSDu3Yuw03nGfkYz/sqTcz7JvY/pMcWbOz8BVZLD/r1vOSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671569; c=relaxed/simple;
	bh=ZpjANrkvsSnHCk6h/AbL6jM93e39NH50QwlC+ZXsiUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RyV/2W3VHvz6NzR5HwItiR3xwQgWzO1EdRuAk9ga+e+WyDtZaQI4KSyErfuvwiituxUHvfftOb/EwlUcvWqW4HQQpWmv8mUVjFAcWONMctKZ82NVOP2vNh32A5EjX+P6HWv+qoNUq4f23BlSCrOV5KAbgRwPHI38HTNZsdjdVrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pRcKd7+N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R8ftHx011791;
	Thu, 27 Feb 2025 15:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6tGP+sqFgniXRjVGKZE3XbgZS6XrIMuMCDwtYl/eIWM=; b=pRcKd7+NwptSfZYQ
	5PSLP5t49P8ElMD6P5MbL6wqCHgJKSqy7kIGnAee7Doz2rfUNz8PmnRhdLKqQFps
	v9yb9dPuLXxsuMYYGlNQuPRKnXvjXmNMsx61JdpAI+7zP0zGpM1ZJccvaN9MUqzQ
	fOeuDuwRfL9rnNmMRuGQWyBizgqxzx4H222OeV/ksT9K7RIDZUyMqyqk3nO3VB+K
	A6XwhcnTGm8HhZnLqSKfxRG3WZK4k5GyW4GmJPsXcnzDKWgSBD8sgWnKZsBZqmvc
	X4HDX3g2L/MbeITyFt1OrRcatXPhkMAxMSDH/z2zK73FHXfkKMuCGvESnyS8GGAS
	1n3YLg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prke88e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 15:52:44 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51RFqhZT029927
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 15:52:43 GMT
Received: from 0d558f49c4ed.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 27 Feb 2025 07:52:38 -0800
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>
CC: Odelu Kukatla <quic_okukatla@quicinc.com>,
        Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>,
        Mike Tipton <mdtipton@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Sibi Sankar
	<quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Raviteja Laggyshetty
	<quic_rlaggysh@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH V9 1/7] dt-bindings: interconnect: Add EPSS L3 compatible for SA8775P
Date: Thu, 27 Feb 2025 15:52:07 +0000
Message-ID: <20250227155213.404-2-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227155213.404-1-quic_rlaggysh@quicinc.com>
References: <20250227155213.404-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-GUID: 4Bj7UTujf7BUmlp1hsQ5VJYSf_i6PX44
X-Proofpoint-ORIG-GUID: 4Bj7UTujf7BUmlp1hsQ5VJYSf_i6PX44
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270120

Add Epoch Subsystem (EPSS) L3 interconnect provider binding on
SA8775P SoCs.
The L3 instance on the SA8775P SoC is similar to those on SoCs
like SM8250 and SC7280. These SoCs use the PERF register instead
of L3_REG for programming the performance level, which is managed
in the data associated with the target-specific compatibles.
Since the hardware remains the same across all EPSS-supporting SoCs,
the generic compatible is retained for all SoCs.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index 4ac0863205b3..cd4bb912e0dc 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -28,6 +28,7 @@ properties:
           - const: qcom,osm-l3
       - items:
           - enum:
+              - qcom,sa8775p-epss-l3
               - qcom,sc7280-epss-l3
               - qcom,sc8280xp-epss-l3
               - qcom,sm6375-cpucp-l3
-- 
2.43.0


