Return-Path: <linux-pm+bounces-10506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C597592565E
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 11:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541221F28415
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 09:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819141422B7;
	Wed,  3 Jul 2024 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VBkxqZzJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F112413D2B2;
	Wed,  3 Jul 2024 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998294; cv=none; b=Vs6nCibz3uXMAKdIr4Us6l1BlrQH6mIz4yPFSDcsEXwBgBtk3hBGN5R4gnf4NfUqs25KgOncn36ZoN6gfFZOW0qw6PCF/fL8snDsnLHx+TYEZ8ewApZrF1uakAAPYzw6jTtqaz48gBb89VcKnT811Ibisa5Xo71NiJ6ufBbvL9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998294; c=relaxed/simple;
	bh=W7advhL4QCHBchPmbAff5A6rLE3IgCwJcFcXfkn/JiA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SHdEK5qOlzwqCGWR3DLoRCZrpO4v/RIG2yaxzJVK/CKYYbzmGjbl5g6htYwWhzD35kdDAPaEoz/ckyq8muetT2pVYtXxQTTLY6t5UXG7YLTAXxfIMDjkAdAstPm3sWGx3fBuYXny1z+idgvbMiUAfJ736jwa149kjhzH86cPNMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VBkxqZzJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4637pKb8026062;
	Wed, 3 Jul 2024 09:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S6TqHg3HfpXwkXiPXdTNuAc0r0by1KLrjiPkv9lmfUg=; b=VBkxqZzJXVjuy3gX
	Yvn0wbrVWRuHI38YWNesRuvnyuSLeT8smNUMtwyzpN4qbhRlNsrwSAELmw22SE7k
	wagZ8+r3S/oeAyii1OnG56E8Z+j/Z+4h7ohRfUVbal4lmtyoC2/cLF0GY7mUznwt
	/OhARvjXhCSyFUkF3tlOk4ud0Y0ZqgnZxiIu+nGNm7qhwiy/hirYQT51xrLpW5GC
	lVHyMTRpNlNVER/qh63niKV6d9bbGz2Kshmk7ORlX4cosRC0jwwZboS4YOidn8v4
	m9zmGez6XVlAeP2liP7I9YzMdG4VZ/B0PK3nGI+CSfeMwxgFj9bgF7wFaljRim8r
	uoDHzQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4027mnrnkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 09:17:59 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4639HwHB017851
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 09:17:58 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 3 Jul 2024 02:17:50 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <vireshk@kernel.org>, <nm@ti.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <ilia.lin@kernel.org>, <rafael@kernel.org>, <ulf.hansson@linaro.org>,
        <quic_sibis@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_rohiagar@quicinc.com>, <abel.vesa@linaro.org>,
        <otto.pflueger@abscue.de>, <danila@jiaxyga.com>,
        <quic_varada@quicinc.com>, <quic_ipkumar@quicinc.com>,
        <luca@z3ntu.xyz>, <stephan.gerhold@kernkonzept.com>, <nks@flawful.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH v4 04/10] dt-bindings: soc: qcom: cpr3: Add bindings for IPQ9574
Date: Wed, 3 Jul 2024 14:46:45 +0530
Message-ID: <20240703091651.2820236-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703091651.2820236-1-quic_varada@quicinc.com>
References: <20240703091651.2820236-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: m1QMgbM0B8rAjt9IQQhd21DY1kJuSY-4
X-Proofpoint-GUID: m1QMgbM0B8rAjt9IQQhd21DY1kJuSY-4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_05,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030068

Add the bindings for the IPQ9574 CPR3 driver to the documentation.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v4: Change compatible string to cpr4 instead of cprh
    Not adding Reviewed-By as compatible string changed

v2: Constrained nvmem-cells and the other variant.
    Removed unnecessary blank line.
---
 .../bindings/soc/qcom/qcom,cpr3.yaml          | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
index acf2e294866b..b875a7633f31 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
@@ -24,6 +24,7 @@ properties:
       - const: qcom,cpr4
       - items:
           - enum:
+              - qcom,ipq9574-cpr4
               - qcom,msm8998-cprh
               - qcom,sdm630-cprh
           - const: qcom,cprh
@@ -52,9 +53,11 @@ properties:
 
   nvmem-cells:
     description: Cells containing the fuse corners and revision data
+    minItems: 17
     maxItems: 32
 
   nvmem-cell-names:
+    minItems: 17
     maxItems: 32
 
   operating-points-v2: true
@@ -74,6 +77,36 @@ required:
 additionalProperties: false
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq9574-cpr4
+    then:
+      properties:
+        nvmem-cells:
+          maxItems: 17
+        nvmem-cell-names:
+          items:
+            - const: cpr_speed_bin
+            - const: cpr_fuse_revision
+            - const: cpr0_quotient1
+            - const: cpr0_quotient2
+            - const: cpr0_quotient3
+            - const: cpr0_quotient4
+            - const: cpr0_quotient_offset2
+            - const: cpr0_quotient_offset3
+            - const: cpr0_quotient_offset4
+            - const: cpr0_init_voltage1
+            - const: cpr0_init_voltage2
+            - const: cpr0_init_voltage3
+            - const: cpr0_init_voltage4
+            - const: cpr0_ring_osc1
+            - const: cpr0_ring_osc2
+            - const: cpr0_ring_osc3
+            - const: cpr0_ring_osc4
+
   - if:
       properties:
         compatible:
@@ -82,6 +115,8 @@ allOf:
               - qcom,msm8998-cprh
     then:
       properties:
+        nvmem-cells:
+          minItems: 32
         nvmem-cell-names:
           items:
             - const: cpr_speed_bin
-- 
2.34.1


