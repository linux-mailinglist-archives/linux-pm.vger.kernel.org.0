Return-Path: <linux-pm+bounces-17851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 021A99D4BEC
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 12:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2FC91F21E75
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2024 11:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644731D357B;
	Thu, 21 Nov 2024 11:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pX+RRDVj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A091D31BA;
	Thu, 21 Nov 2024 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188638; cv=none; b=OJnU7gppaO32iKmpkHnEs4lHqosCq7VkQLUVB/C7qb8CEGcZ/eL74q0FRMHdYxaRB38wTu32hUObZKoWmvV/Brn6CNkWnjCo28O4K+eLeKRY+05oTb4T+Q7WaCkn6e22lizQoGTYs+CLYeRuVULaLfJQZWgLlSIK01P6wrxs2uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188638; c=relaxed/simple;
	bh=wQxIdkf7vDQudMCZe8uPswW11tw+NIjbaxkaNy6GmLY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m2NwZNAiUWCSPxcef+6OpSchWdJNPr8mVtRAx2qy9tJuFFFngFqnB3UcrmhkP8/HLUBcnAtj46k98dA5Nz2zlGu7kfh5BXVrGp9W9v08HR6RN9sFBTDpSeQnKubbryRkSjliZmKY+9V+w53vsYjY3Al/3nnpwP7RXkoRSfN3wH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pX+RRDVj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AL8jLSj007124;
	Thu, 21 Nov 2024 11:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m3cF1b0P4tdJPK4CV2VpKzUcvJ9bQoHZ2hZW8vFcA60=; b=pX+RRDVjxt0mhmdn
	eY7yvfs1ldbPE0iPY54WX4eiOp3/9UA4Kp54xcKB0ntrCHeOBYs1IT8dqYieQ/YR
	GfWD5dT4dh61to2jG6Teo7vXsfLuWMP8BysEH9Mt3Pf8Kll72OtsQXvIzApLf2wQ
	3vjuknGZgzvU7N90QGYkzeKZ/1hnjtosOBkueXzzK1s5sRPMQOpr9dWKFhDKpW1p
	/fVZfu69+QuS86e14cMOdfbZ4IzcdQTDq+27K5c8Ir4JUM0n6ON2h6X8Wml4zJ7D
	J76Rh+Qu841HcVz28sVp0kbDGaPWtV3VqvbOh+D/0aLcUZLa5UmgIYTm4Zv0rVAL
	KkTU7Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y815k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 11:30:33 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ALBUW4Z018283
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 11:30:32 GMT
Received: from 41ee23f3c785.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 21 Nov 2024 03:30:27 -0800
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>
CC: Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton
	<quic_mdtipton@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V5 1/4] dt-bindings: interconnect: Add EPSS L3 compatible for SA8775P
Date: Thu, 21 Nov 2024 11:30:03 +0000
Message-ID: <20241121113006.28520-2-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241121113006.28520-1-quic_rlaggysh@quicinc.com>
References: <20241121113006.28520-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-ORIG-GUID: -6KeCoKRRVQhceixXIw4R0clMHZ89kbB
X-Proofpoint-GUID: -6KeCoKRRVQhceixXIw4R0clMHZ89kbB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411210090

Add Epoch Subsystem (EPSS) L3 interconnect provider binding on
SA8775P SoCs.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 .../devicetree/bindings/interconnect/qcom,osm-l3.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index 21dae0b92819..042ca44c32ec 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -34,6 +34,10 @@ properties:
               - qcom,sm8250-epss-l3
               - qcom,sm8350-epss-l3
           - const: qcom,epss-l3
+      - items:
+          - enum:
+              - qcom,sa8775p-epss-l3
+          - const: qcom,epss-l3-perf
 
   reg:
     maxItems: 1
-- 
2.39.2


