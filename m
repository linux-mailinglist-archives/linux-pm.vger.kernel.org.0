Return-Path: <linux-pm+bounces-20274-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3B6A0A4A5
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 17:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B171188BE60
	for <lists+linux-pm@lfdr.de>; Sat, 11 Jan 2025 16:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47861B2182;
	Sat, 11 Jan 2025 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O17PcWSl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919561B2184;
	Sat, 11 Jan 2025 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736612109; cv=none; b=anODo+RRbjMPWv2jYVdqU4jHx45XC4U1ISIsfoMh3L54ld6GboF9t9owzLBTWyNYkv/Hl6/PoYCXIrxr50SoWy9CjUmzeyb2WFstNPKwaJ5L0blpaCOjyE1EWjiToaeI47cs4YQ8Uw0pG2n8PI00xV+g1BmwgqnZRNQGb9fuhvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736612109; c=relaxed/simple;
	bh=h2kzfShbY+qmHX/y4NEs8u08Si9FlnqsM3crhkhlwVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrZ/IrL/NDbsLSTz1dyIMIt5qBELO88ZAr9coiAUt2Zw0I15TOU4+SOJknS0fVhbSNBSY+0xEaPGyc7icFq2onCNeCVcxeJbMD7m+V6HhRBZ8ZkxGTe2Tts9gZb7jUR8ZI7phqWt0zu4KyydH45JYKQ86rNq6G1SlwOWIdh2juA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O17PcWSl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50BDt2aC025053;
	Sat, 11 Jan 2025 16:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eOMpmWbAruPxIm6z1uRwAcRJwsCmhMZwJIHPma/mPrg=; b=O17PcWSlFJQFiCBY
	pGy9pnBnJQNcYezjttlfFIY7TABFprIv8waPDHz+Nd1SnaHsPOAE9PkkW2AZ2/PD
	KNDVg2byMihlL4CX3z9wDGHoiDpl3YiCTFkNTpWt1DFVH3s4N8X9x7DBFDm9hc3Q
	RaKVPHqkvPurxC2s3aA3Oh6iL5EXCiUIGjxCjxjHnZgKHsqePhfg19Mx0UYqQdyq
	ymbZBJj+cwH8moQ7zKSJOcPlPS1F/ROnbPqvDRZ572kn8nJgDs9lqvcPELhFwBwH
	DVwR4EFMKQBnYIjAF2gTG4FO5r28j6JkLPg2Ax4bNIT1Vx8cUEwht2hhAvUFgg6b
	G3w9fw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 443hjdgshj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jan 2025 16:15:04 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50BGF4Tg025487
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Jan 2025 16:15:04 GMT
Received: from 4206f847eb12.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 11 Jan 2025 08:14:59 -0800
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        "Mike
 Tipton" <mdptipton@quicinc.com>,
        Vivek Aknurwar <viveka@quicinc.com>
CC: Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V7 3/5] dt-bindings: interconnect: Add EPSS L3 compatible for SA8775P
Date: Sat, 11 Jan 2025 16:14:27 +0000
Message-ID: <20250111161429.51-4-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250111161429.51-1-quic_rlaggysh@quicinc.com>
References: <20250111161429.51-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-ORIG-GUID: PZcD8TbaKN8aSW47zw9j7RTLBlUn0XzD
X-Proofpoint-GUID: PZcD8TbaKN8aSW47zw9j7RTLBlUn0XzD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 mlxlogscore=979 lowpriorityscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501110138

Add Epoch Subsystem (EPSS) L3 interconnect provider binding on
SA8775P SoCs.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index 21dae0b92819..94f7f283787a 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -33,6 +33,7 @@ properties:
               - qcom,sm6375-cpucp-l3
               - qcom,sm8250-epss-l3
               - qcom,sm8350-epss-l3
+              - qcom,sa8775p-epss-l3
           - const: qcom,epss-l3
 
   reg:
-- 
2.39.2


