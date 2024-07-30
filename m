Return-Path: <linux-pm+bounces-11638-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312B9940958
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 09:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96915B21819
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 07:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258D3186289;
	Tue, 30 Jul 2024 07:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CaeSMfgW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD8319047F;
	Tue, 30 Jul 2024 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722323819; cv=none; b=pbodoT9xHdB34cJxMbPell0DtjLN1IdRusHflb6xbvDagAa28yAaODU8/JohCVKJr9wJyHsp8pG9cedGmAbocJkS+YIg3jWFpBBkJ05Z0iNdH09mw/TRRHBlVVauwOLaexAhiKP7nLpZmAxbGW/mAMBssyoo0EfCvVs+FJSHX1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722323819; c=relaxed/simple;
	bh=j70DctuNRLbx7zqOvOzjXNXvIeIZ/6u3oZJdvzR2L+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YBYnBNUYAEg5D5H/BLrExcPDi9FwxcUD61WBplkPBFlNorzk25fO4Hcj0SHPQO3GaKtP51J+gunI/Ns0f3QhkrGi0shiIX6es+HS3ezzsbEzxsBUJIZ623kyRO5zk40hUQCMZ9HBiNZXLETb+zCgJyOqXviO1gIazb8b/QuHZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CaeSMfgW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TMB4UV021303;
	Tue, 30 Jul 2024 07:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TC5Pie6SBEHKmDeQxUessXFsmWVkQksEii8LvE1Nez8=; b=CaeSMfgWAlxMM486
	oyfjnevtQevRV5DTk+kpgkG+9b5Occ+wu4Ww1AW26rxYLT6CRFjTjvixJKyzcxU5
	UE69pHt/iiYzBZCAoFrXgfcqCpFjjzvpz8O00qsrQf6aTHYQ3hAYBVRxopq/3vEI
	dG1Htm6kjGyikS7M0x+amqW0QUK43YTfc/AzDLXhXoA4cd2tsX93w474nyHARQ0W
	cJw2DA9PbiXxZuXnNcW5zE15EVfszl2/5hwSMYzzQ98MDBm1Cv/gCglw7vIOKD8N
	SPxW+LLd5mhqufxUF265rKgF0mSDgilu9PIul+LSPjALHfE+AYXICeEakUaIyA9R
	y5GhpQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mrfxpgcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 07:16:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46U7Gpak021994
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 07:16:51 GMT
Received: from tengfan-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Jul 2024 00:16:45 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
Date: Tue, 30 Jul 2024 15:16:10 +0800
Subject: [PATCH 1/2] dt-bindings: interconnect: qcom-bwmon: Document
 SA8775p bwmon compatibles
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240730-add_sa8775p_bwmon-v1-1-f4f878da29ae@quicinc.com>
References: <20240730-add_sa8775p_bwmon-v1-0-f4f878da29ae@quicinc.com>
In-Reply-To: <20240730-add_sa8775p_bwmon-v1-0-f4f878da29ae@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov
	<djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tengfei Fan <quic_tengfan@quicinc.com>
X-Mailer: b4 0.15-dev-a66ce
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722323802; l=1219;
 i=quic_tengfan@quicinc.com; s=20240709; h=from:subject:message-id;
 bh=j70DctuNRLbx7zqOvOzjXNXvIeIZ/6u3oZJdvzR2L+0=;
 b=57lJKNR0l/5CRgMtaH36xDTvke+25z1uLGryDDEZjRPAJ2wLV/bckZGtX1Wu7qp/oVRPFj+YW
 2xSjJMO1pPwCJ3Qw2qlRhtSWAhHFsA5jSDNSjMRbeWF/w8aOcwWYzme
X-Developer-Key: i=quic_tengfan@quicinc.com; a=ed25519;
 pk=4VjoTogHXJhZUM9XlxbCAcZ4zmrLeuep4dfOeKqQD0c=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3IYsQ0_GFfaM2unCErehjpUZCkgHIgr5
X-Proofpoint-ORIG-GUID: 3IYsQ0_GFfaM2unCErehjpUZCkgHIgr5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_07,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300053

Document the compatibles used to describe the bwmons present on the
SA8775p platform.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index 2cd1f5590fd9..189f5900ee50 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - qcom,qcm2290-cpu-bwmon
+              - qcom,sa8775p-cpu-bwmon
               - qcom,sc7180-cpu-bwmon
               - qcom,sc7280-cpu-bwmon
               - qcom,sc8280xp-cpu-bwmon
@@ -39,6 +40,7 @@ properties:
           - const: qcom,sdm845-bwmon    # BWMON v4, unified register space
       - items:
           - enum:
+              - qcom,sa8775p-llcc-bwmon
               - qcom,sc7180-llcc-bwmon
               - qcom,sc8280xp-llcc-bwmon
               - qcom,sm6350-cpu-bwmon

-- 
2.25.1


