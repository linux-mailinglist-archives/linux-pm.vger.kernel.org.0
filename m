Return-Path: <linux-pm+bounces-21429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AC5A29904
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 19:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B06D17A018E
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 18:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B8D1FF7CF;
	Wed,  5 Feb 2025 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QgVzoGt6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EA91FF61A;
	Wed,  5 Feb 2025 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738780100; cv=none; b=deIYoBIliLgqV/T7aRaWZaaAmT+azsaofqZnRRWjO4vczE+wJ8nO6jMsYVxMB/eihUS3tM4IuU9AlZrjj1xdmhIMzF7aXdAhhoA4VIIphtezaGxzyD73bDrgbXS8b9iO2s8j2afqyIR+rd8t8SoumxS6Q/Hd9dLmu7pUZlv4pqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738780100; c=relaxed/simple;
	bh=Wt3WOZtnYx1lYV4UehWviEAJPo6kdFHKlThAHrCrl/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vCwZdZTAn19Lgk0Qw+jVHr4Yz9oTjMbZzedzhBnf3yWC8ttS7MbJ72gYKSmiC24J4H3uwALSRs8tdgBGudg/+XyzFogif0Dn4QbSJEbkyKuDW+VAS/tGsPwqfvHm2kRAdmZt3MY+roaYAvXlgh5BJfBS3MNSNho4ztlBGxUVE/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QgVzoGt6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515BOdKn024555;
	Wed, 5 Feb 2025 18:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I10c2WLWsGvwgGWS0Ooh81W6XZMBlLL0tayi+aKKv3o=; b=QgVzoGt6FfjlCHMf
	ZtlJ1r6FUAQhXigXPBaGCGwrRREo8pVxH5iu+b1AfqWhsXdXcNiKeCpigmJ+bSbg
	uXXYt/AZYHy4TXGPIh/+A36YLNhqVlKa2JpkeHQfTihzD2s11gKOZOEdHJa85mLK
	TZs1EMFVpsaHroajHxhclh1JM0ElUvKNczK2p0ZnldJOeYXbGBGYn6kKTCOIgxkH
	D7UCdwgPFj7mbKdtx+LXqCR1f5ihu7HyqpgzsrKVg0gl8rWztzNE95dIO6N/4kCO
	zTcq7COZ5a+uIPpI6Ox2rhio6RB7DrXI1bND4IXsKvqDuuy9R5VYbPtO3GGd5Spj
	vKl8Bw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44m73b91y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 18:28:12 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 515ISBqU007085
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Feb 2025 18:28:11 GMT
Received: from c194c8e2f407.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 5 Feb 2025 10:28:07 -0800
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
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        "Andrew Halaney" <ahalaney@redhat.com>,
        Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V8 1/7] dt-bindings: interconnect: Add EPSS L3 compatible for SA8775P
Date: Wed, 5 Feb 2025 18:27:37 +0000
Message-ID: <20250205182743.915-2-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250205182743.915-1-quic_rlaggysh@quicinc.com>
References: <20250205182743.915-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-ORIG-GUID: tGrWX0xoZmKltZicGmgAG_3PlGO5POuj
X-Proofpoint-GUID: tGrWX0xoZmKltZicGmgAG_3PlGO5POuj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050141

Add Epoch Subsystem (EPSS) L3 interconnect provider binding on
SA8775P SoCs.
The L3 instance on the SA8775P SoC is similar to those on SoCs
like SM8250 and SC7280. These SoCs use the PERF register instead
of L3_REG for programming the performance level, which is managed
in the data associated with the target-specific compatibles.
Since the hardware remains the same across all EPSS-supporting SoCs,
the generic compatible is retained for all SoCs.

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
2.39.2


