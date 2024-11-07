Return-Path: <linux-pm+bounces-17113-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE8C9C0878
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 15:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540ED282C07
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 14:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B4A213140;
	Thu,  7 Nov 2024 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g0QcjcTq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941C0212D16;
	Thu,  7 Nov 2024 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988519; cv=none; b=Kx1OUPTaWCXL9Z3rMJS+2cXUXB6j5rDEBdGkuFipHUmRddwWZfwj1+b5aj+HMIzI7JE0B0oyDz4bJPtHQtSrAD1MTsXIkGyJKvNxYsALhV/g5Z4hywAequrE1ckKQXPZbXNvFO9wCk5W+NwJoXQ8eHQvL9CE54HP1symjYvjQGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988519; c=relaxed/simple;
	bh=kJ6guzrFCsScuZNhhCti17+r3yUP3gRpY6//7izWuy0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFvrHXi+yrNzriGmDvQ44dzGtf8DTnfhv1RRIKBuwP+hMOTOtGmK9vpUAPNuVgF30ty04GvLD8dgLQlfgdcat05OZdl0N5lymxDasWiSqn9BMGIXJ+ZGpNdYqUFmqSmOSwlripW+Fyn567aUVSoIcGx2idtlhbxcfmP0R6NnkIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g0QcjcTq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7BmCos004090;
	Thu, 7 Nov 2024 14:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DQVClUQP/7E/wnUg2zUxEG9i7zrGRLb+G0ONBzsr2Lw=; b=g0QcjcTqTdfLeOSt
	2DvAlGSjGGeGuG/FqB+Ewmz8We4F56iETSmN37jeEBSbPn7fJoKlkGZqdmE1RTUr
	eCwUYNv+wCtynNwrTn7ZvjEcKF59LEMFGw+d+JJgunx6zKNNIvMfhVhBRrJk6vXz
	HTlWwPe0Oj3Qat6d7hcmoPx/77SixdzhKXGL/fn2QHBqxEvRoCaNs37THUPlzQbw
	pni+J7dp8tsnzzgd8c7VOePzYPpD7R9x5Vot4SMSQ+JjR3/vcXLLmEvSc7HDWrSw
	U3u4xUaE62GCWxUFdgWYRfVm2C5jilGmbdzMs3fUm+x/txEQgG/v2EuvOLmDTm0q
	/pV+aQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qhbufds3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 14:06:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A7E6FQV025680
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 14:06:15 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 7 Nov 2024 06:06:10 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v7 1/7] dt-bindings: thermal: tsens: Add ipq5332, ipq5424 compatible
Date: Thu, 7 Nov 2024 19:35:44 +0530
Message-ID: <20241107140550.3260859-2-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107140550.3260859-1-quic_mmanikan@quicinc.com>
References: <20241107140550.3260859-1-quic_mmanikan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: z2lbQa67gGxVv0ZU7xzVXDRYmzzIUabH
X-Proofpoint-GUID: z2lbQa67gGxVv0ZU7xzVXDRYmzzIUabH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070110

From: Praveenkumar I <quic_ipkumar@quicinc.com>

The IPQ5332 and IPQ5424 use TSENS v2.3.3 IP with combined interrupt.
RPM is not available in these SoCs, hence adding new compatible
to have the sensor enablement and calibration function. Also add
nvmem-cell-names.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V7:
	- Pick up R-b tag

 .../bindings/thermal/qcom-tsens.yaml           | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index a12fddc81955..c9570d647fea 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -73,6 +73,8 @@ properties:
 
       - description: v2 of TSENS with combined interrupt
         enum:
+          - qcom,ipq5332-tsens
+          - qcom,ipq5424-tsens
           - qcom,ipq8074-tsens
 
       - description: v2 of TSENS with combined interrupt
@@ -209,6 +211,18 @@ properties:
           - const: s9_p2_backup
           - const: s10_p1_backup
           - const: s10_p2_backup
+      - minItems: 8
+        items:
+          - const: mode
+          - const: base0
+          - const: base1
+          - pattern: '^s[0-9]+$'
+          - pattern: '^s[0-9]+$'
+          - pattern: '^s[0-9]+$'
+          - pattern: '^s[0-9]+$'
+          - pattern: '^s[0-9]+$'
+          - pattern: '^s[0-9]+$'
+          - pattern: '^s[0-9]+$'
 
   "#qcom,sensors":
     description:
@@ -268,6 +282,8 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,ipq5332-tsens
+              - qcom,ipq5424-tsens
               - qcom,ipq8074-tsens
     then:
       properties:
@@ -283,6 +299,8 @@ allOf:
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


