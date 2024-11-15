Return-Path: <linux-pm+bounces-17613-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 776139CDCD5
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 11:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2111F2390D
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 10:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817651B4F0A;
	Fri, 15 Nov 2024 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ok/cdHIv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D9F1B3942;
	Fri, 15 Nov 2024 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667254; cv=none; b=rsyz6adRpnMpnCn7fe0Rw1Yiq0SKCCUMkAEPhLipcIvNEtUx/LVUxxNqj0IPHS5VenYk7zUwqlH3bBQkbAZqT3HMXx5ad1OzzcbW47JoO7abHaGAawl2nbdV7ndKlMmw3cUYkobJaFPrk1pp8niGlZT9VQu3WijlxU8k60qIlpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667254; c=relaxed/simple;
	bh=bPpyDM7YAaLp9ErMT2k1vEOLxUsMSTzExtYUkQ5mn9Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+Zaz98xalvBpD9wJJoT/rMs0ky1gT1vpUFfdLBCymeJz+j6tKAcF0erHKMNbqS8Be+BCcKNS5J05p8TqhBQFHNR75JdePXJ12Ia+15DdFkq12J51qGuNxb08ytkgroS3wRxXQ5cyUKY6VlS5pXm9BKMYbaAdQp/G280i+3IrwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ok/cdHIv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF8fLNP000936;
	Fri, 15 Nov 2024 10:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	451YCx5dGG3xrn0Yt9QrH5yaM9bGwIGPtQkGYzngoRE=; b=ok/cdHIv2FDh3+4i
	eBOfHeXLdbOP0icS0CHbxsfG+CDqF9CDp6kDsM5CwMQPnUsJTnhl441W4idZI09h
	/BwJca+tzy3E84aU+0w00Zfi0Lp2FCBCgSX3KHYfds8E5JGejUjBVXqTLDCBrk3h
	OlrN3D7yKwFub8znO1huzeXVaWcBYMAg+RrYewxrKHq0iwqNUehpIn8zmr64PaDO
	yvQbI0Q1GErKvqSkvBVoGJ/HagV7FjaMCsC/II0fDjVjpzTasevT4oQg4KHuVa2Y
	kA3lMJpO/x2yk4GwFOTiYCAp2l1kYXYnMROSo8Cdwyf8KV0WBVqfo8GREJpeSCIP
	nNFtWw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42w9sv5khh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:40:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFAejPj019920
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:40:45 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 15 Nov 2024 02:40:39 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v8 1/7] dt-bindings: thermal: tsens: Add ipq5332, ipq5424 compatible
Date: Fri, 15 Nov 2024 16:09:51 +0530
Message-ID: <20241115103957.1157495-2-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115103957.1157495-1-quic_mmanikan@quicinc.com>
References: <20241115103957.1157495-1-quic_mmanikan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Cqx4Z1eRNtLmCXJflp_ShywmodWnjWXV
X-Proofpoint-GUID: Cqx4Z1eRNtLmCXJflp_ShywmodWnjWXV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150090

From: Praveenkumar I <quic_ipkumar@quicinc.com>

The IPQ5332 and IPQ5424 use TSENS v2.3.3 IP with combined interrupt.
RPM is not available in these SoCs, hence adding new compatible
to have the sensor enablement and calibration function. Also add
nvmem-cell-names.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V8:
	- Replace '^s[0-9]+$' with '^tsens_sens[0-9]+_off$'.
	  Based on the review comments, the sensor names have been renamed.
	  For example 's9' has been renamed to 'tsens_sens9_off'.

 .../bindings/thermal/qcom-tsens.yaml           | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index a12fddc81955..04a8deb70dd1 100644
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
+          - pattern: '^tsens_sens[0-9]+_off$'
+          - pattern: '^tsens_sens[0-9]+_off$'
+          - pattern: '^tsens_sens[0-9]+_off$'
+          - pattern: '^tsens_sens[0-9]+_off$'
+          - pattern: '^tsens_sens[0-9]+_off$'
+          - pattern: '^tsens_sens[0-9]+_off$'
+          - pattern: '^tsens_sens[0-9]+_off$'
 
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


