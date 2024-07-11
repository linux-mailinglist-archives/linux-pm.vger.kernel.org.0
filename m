Return-Path: <linux-pm+bounces-10987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C9892E6E6
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 13:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B77D1C22C39
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 11:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCB215ECE3;
	Thu, 11 Jul 2024 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T+na4dxC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEF915ECCE;
	Thu, 11 Jul 2024 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697593; cv=none; b=Ia5wZfDfgdRmk4jiJUHb9JWD+l6MK/FxkG9kgvux+W4WKy9fXCgmtL2VTod4O9edDwzR49lJj0qiEVOKtTs4Bkw0koXK4m8jOVk7RjoqcaR7A5/aeGGj24hHgcJzW1W8/lGKyGltLWBePMk2YbtsNQav/n1jUrYGkJ4QzJuWNZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697593; c=relaxed/simple;
	bh=yX5pmZYErsCMHV537RL2GPmMpkV0rbWbPsCU+VAzMrg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJ5p5LzARTyzjyu3joLaku+0m0S6PpZ1kXzk54/MP/cppw1K7fFEkVHubETGdv/0nfZ6XCW4yPjhRy3g1UkR+H/AQf/MSNsOSwhiJTi7F2RqZDlsITSHodn5NTjzLnxim1l+F0b/8B4MWtVyr/60NHTZjoEfzNbtP+DTKYylbqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T+na4dxC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B4mn6m011426;
	Thu, 11 Jul 2024 11:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hJ6q/YE5nVpy7s+dSUUBbXZJ5cvIgbCFF6+6h8CTk1E=; b=T+na4dxCbn6L9F19
	ETHUeeX+K4vc0RWuJqORV58RFXRD9b25MPyrXmuSd0CUn084yLRGEuBCKdEVKH/o
	/0/3kOMKlwGDdesDr3mZvpRWx8KcWlHXxV+fPo/x6gcs9ezSyZLG3mXPQHrbxSZ1
	fsFXPRv4EtskkBAsuH6MjsWIumwb2Ygd/JpPflSMQhYGGnoaKoxhYUFP1Oi/bI+Z
	275OHYDX2qqRlelsd5snIvLpNZa/7GlASuEVxgGf74pjv64/D0tKFH86oWuIlvvz
	DFtZvbZE+dGKrAqYMw0StNVWQnq5w/HqsUMcoRU0H521S7wPa46Na5wxfvs+ZB6M
	cgCq1w==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 409vydtf04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 11:33:08 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46BBX6qV002291
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 11:33:06 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 11 Jul 2024 04:33:01 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v2 2/4] dt-bindings: usb: qcom,dwc3: Update ipq5332 clock details
Date: Thu, 11 Jul 2024 17:02:37 +0530
Message-ID: <20240711113239.3063546-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711113239.3063546-1-quic_varada@quicinc.com>
References: <20240711113239.3063546-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: JwgIdDMGZrmKCUTJfqUn68pKKYPvHgaI
X-Proofpoint-ORIG-GUID: JwgIdDMGZrmKCUTJfqUn68pKKYPvHgaI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_06,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110082

USB uses icc-clk framework to enable the NoC interface clock.
Hence the 'iface' clock is removed from the list of clocks.
Update the clock-names list accordingly.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 .../devicetree/bindings/usb/qcom,dwc3.yaml      | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index efde47a5b145..6c5f962bbcf9 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -220,6 +220,22 @@ allOf:
             - const: sleep
             - const: mock_utmi
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq5332-dwc3
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: core
+            - const: sleep
+            - const: mock_utmi
+
   - if:
       properties:
         compatible:
@@ -267,7 +283,6 @@ allOf:
           contains:
             enum:
               - qcom,ipq5018-dwc3
-              - qcom,ipq5332-dwc3
               - qcom,msm8994-dwc3
               - qcom,qcs404-dwc3
     then:
-- 
2.34.1


