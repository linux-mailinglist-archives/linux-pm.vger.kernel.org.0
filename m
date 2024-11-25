Return-Path: <linux-pm+bounces-18099-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298B79D8B91
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 18:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E342B28A558
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 17:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310AD1BC9EE;
	Mon, 25 Nov 2024 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pPi/hVBs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F521BBBFD;
	Mon, 25 Nov 2024 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732556749; cv=none; b=fSvOGm91/DTcX8tp2V0yYJwPynPdr2Tvo1QIzTtkg8gzRgzpOUGiiElV81qyspIbfggxuFPlEqsvh8fEycpqJRrASn5Q7h4LbBuUCd2nxO+5czcQBjHZ+6v1xJWC8WFLp038CAYtNDu6nz0LfmJgmCmzvOxFSh5Bpm6212mrmzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732556749; c=relaxed/simple;
	bh=FwwZcY0cPnwNTbU0cFgdfCd2NNNVM7FlNChqIWNLbR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LucAYmx9Ah45DB5Cc4eZDpN3VFR2ByrukuJ23g/UTbEpVdxwsHotQSV25nTJ/qJ3tMej2BVkIP0Ah+Ky8zx240PMqHnzPUTfSPyj1OTp0IlR+lO5emWNkT9lYCmBPRmYIGGQRcVPBjYDtBr16vC1Bw1W/VhFiXYX75wvFkfgah8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pPi/hVBs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APBTHOA002921;
	Mon, 25 Nov 2024 17:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZyHTRqPh2pN10+6jNEkJf9ZWj66imrmapEemyyAR9nU=; b=pPi/hVBs46j90j3g
	ZMVv34yRGy51MFmhD0o1xasCWqoBLM6F09Lq1z/2xevzFxgMo1Q+o2t0hNp7WE1o
	eVzurNP+NTabk9E+DWcEhkgY4Mr6n2z3sR950SX+RgjJV/ba4dmdqMCs1s+ReQDA
	o7010tj6rRKUG2ugKIGNMfHzvtgqvvX7OO+eXU5GLiYpsee2KWKCFGujvLiE1hTf
	gYntJSVu3K3uWB4Cq7zS4p7BRhbUkjj6EuoP7MIJ2vcMgwirtqgSpi5EN2sA4mr9
	6M/epSPOR/n/2Vx/v1gZTayD3S3c+OSPQaCR7lLB8lz1bPixYgH3utAJdxxeNJ23
	jwJ5/A==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4336cfnp1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 17:45:44 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4APHjhkI032657
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 17:45:43 GMT
Received: from 4215f72c9660.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 25 Nov 2024 09:45:39 -0800
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
Subject: [PATCH V6 3/4] dt-bindings: interconnect: Add generic compatible qcom,epss-l3-perf
Date: Mon, 25 Nov 2024 17:45:10 +0000
Message-ID: <20241125174511.45-4-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241125174511.45-1-quic_rlaggysh@quicinc.com>
References: <20241125174511.45-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-GUID: sCV8rq9Q3vX2cXIIgYxro6GP15FkbvRM
X-Proofpoint-ORIG-GUID: sCV8rq9Q3vX2cXIIgYxro6GP15FkbvRM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411250147

EPSS instance on sc7280, sm8250 SoCs, use PERF_STATE register instead of
REG_L3_VOTE to scale L3 clocks, hence adding a new generic compatible
"qcom,epss-l3-perf" for these targets.

Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
---
 .../devicetree/bindings/interconnect/qcom,osm-l3.yaml      | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index 21dae0b92819..e24399ca110f 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -28,12 +28,15 @@ properties:
           - const: qcom,osm-l3
       - items:
           - enum:
-              - qcom,sc7280-epss-l3
               - qcom,sc8280xp-epss-l3
               - qcom,sm6375-cpucp-l3
-              - qcom,sm8250-epss-l3
               - qcom,sm8350-epss-l3
           - const: qcom,epss-l3
+      - items:
+          - enum:
+              - qcom,sc7280-epss-l3
+              - qcom,sm8250-epss-l3
+          - const: qcom,epss-l3-perf
 
   reg:
     maxItems: 1
-- 
2.39.2


