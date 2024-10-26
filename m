Return-Path: <linux-pm+bounces-16499-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B030E9B181E
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 14:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E077F1C228A9
	for <lists+linux-pm@lfdr.de>; Sat, 26 Oct 2024 12:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E02A1D7998;
	Sat, 26 Oct 2024 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QPVzNWiX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A46E1D6DB7;
	Sat, 26 Oct 2024 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729945886; cv=none; b=Aumay5W+0v/GSM9a+mNcYoDO90LBNy0Ns7s4m/c90XhBeHGwlg4VVdc9SaBddwn14NJRRzBn0TRw9zYhn2nuf6OYZ40Qehm5VWEqo4OtSyi5KHsfYC60zjk698BRfLEZBt4r0dVBld18g2DRxF8S1aUGoZJZAjU/1dKWbqgYHLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729945886; c=relaxed/simple;
	bh=wQxIdkf7vDQudMCZe8uPswW11tw+NIjbaxkaNy6GmLY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQA9pc0p4q3uErZgxK+Ov2aQCO0d+0tXwfxq1BY+IC5lwmHTue+Ao0UWuIJQbhoESb/UjPnk/+PUHZDhm30/Ll/DRVbpgtj6jy/ZtoKuTQ6XAvddtID3DpvjOeyh0SUlqxdKGniWKgorxPCzQZ3FNe7gYlddWen+Hy573HZalNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QPVzNWiX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q4F1pR007614;
	Sat, 26 Oct 2024 12:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m3cF1b0P4tdJPK4CV2VpKzUcvJ9bQoHZ2hZW8vFcA60=; b=QPVzNWiXJnWHnUiP
	hK/3tyZ6dJXuGSBglpJhb2GrotsBNg8sGX89BtfPTRRvv0Rw+8+/0sfLtFZMzPow
	6SxsdS3n3e/1C57LBkk5OM9Q3HXtLYPged0QUzuVKUAGkWbSqvKocVf9Yt1i0bRI
	ignX5d+eXPPPLhmWLdY284AkIF08CXi6t4XRZys4Z9J/FRyeiI4oQZZE9f0ZaZLb
	ix9jgNaeudD2dHh3v/s/5oXRGiLzsuHJLLWey92xGPDLEeNgYf669Hx/9Lkw03/x
	r4DzV7tALwUK/2IW0wX8/ofxp/ftk8skcZBnjPn3VsqzRcgSP6eHcYDo7W4/Ezdq
	U24Qpg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42grgu8wf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 26 Oct 2024 12:31:20 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49QCVJ8s001340
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 26 Oct 2024 12:31:19 GMT
Received: from 55f3af46090c.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 26 Oct 2024 05:31:16 -0700
From: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>
CC: Sibi Sankar <quic_sibis@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 1/3] dt-bindings: interconnect: Add EPSS L3 compatible for SA8775P
Date: Sat, 26 Oct 2024 12:30:56 +0000
Message-ID: <20241026123058.28258-2-quic_rlaggysh@quicinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241026123058.28258-1-quic_rlaggysh@quicinc.com>
References: <20241026123058.28258-1-quic_rlaggysh@quicinc.com>
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
X-Proofpoint-ORIG-GUID: G-3xmfrRN_efss0g9ToRRiDCz7b_Kn6D
X-Proofpoint-GUID: G-3xmfrRN_efss0g9ToRRiDCz7b_Kn6D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410260106

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


