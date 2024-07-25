Return-Path: <linux-pm+bounces-11397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3400693C057
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 12:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F841F258E5
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2024 10:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D36199247;
	Thu, 25 Jul 2024 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q8n8TJmp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D2C481A3;
	Thu, 25 Jul 2024 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721904364; cv=none; b=SEIe+bAiUrHCbKaKNbDx7Kf4Y/pzy7Ax79Ddv+rADi6TxA5N4E/wvjP8TJnjdycc/gtoLWibRF3lOTdf6xjacxhn9tN6NEedn1LGL5MOEgVKq0dFldwEaQWZZmW3LTl5FDBsm6KQwNizk2jZshYtgmYPi8qcJFLlMG+n38R0Ins=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721904364; c=relaxed/simple;
	bh=X7SdgXP+Ykz0MNqMNEuIqRMBWfWQgWTopkdn4v2pSdY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YHLjdZjRwbkFLBN6lo8M1YQjPi7SoTmJmUUkw5+L/PAMsH205kCAoYxtf0wZf2TB7Y/2qRI15Q41d2U5G1XOxKkgqvlKiTzE8Zm2zuTaVK99JIVpEs0P3dxJu81GW9OcrHX0N9wo0BTs/XjrfmQDvz/ZtCBEKd0oPJcYIGHifH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q8n8TJmp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P7fZxe032510;
	Thu, 25 Jul 2024 10:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4DV1+yzPyU5o2ZWOQBgmNNOYk8keWOYIv4AoxwjIA2E=; b=Q8n8TJmpanxsLyWD
	+xk0zdjo7gG8rmLI90J/USjI5csOyYI2ntlU8VR2gRaNUs9N+EYDANT02I+whpWA
	iaUACJOGBONYUE2Yn7MFWI3k6S4hjIpopIFLXGPc51ZaGJiDTqVN8rPffMcXwSro
	WrqAwdvC86vkYRNBqSmj5cuq6uGCZlHoyZ+vMkdhLd3VIFm4G+qHnpC0DbbaLEAU
	QeS1NSeYiy0MIOFO8tM9MbzxxGBxiD+Nnb5G6WIDSt10beoAGlAav2I+Db3RmD4/
	Qa3xnSBG2eCAD+seFaDuhWSDPJk3Me6qHellOMrh4+jzqFbByO6EJw5/GkudBsHY
	21PX2A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40k5nvt6wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 10:45:57 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46PAjvpV004213
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 10:45:57 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Jul 2024 03:45:51 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <quic_wcheng@quicinc.com>,
        <quic_kathirav@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v5 2/5] dt-bindings: usb: qcom,dwc3: Update ipq5332 clock details
Date: Thu, 25 Jul 2024 16:15:25 +0530
Message-ID: <20240725104528.3504967-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725104528.3504967-1-quic_varada@quicinc.com>
References: <20240725104528.3504967-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: y1TCRerbHuvHj5QVKmJ5uUvlu29EZ8G8
X-Proofpoint-ORIG-GUID: y1TCRerbHuvHj5QVKmJ5uUvlu29EZ8G8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_11,2024-07-25_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=757 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250072

USB uses icc-clk framework to enable the NoC interface clock.
Hence the 'iface' clock is removed from the list of clocks.
Update the clock-names list accordingly.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v5: Use ipq4019-dwc3 clock details for ipq5332 instead of new one
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index efde47a5b145..aef42dacc202 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -164,6 +164,7 @@ allOf:
           contains:
             enum:
               - qcom,ipq4019-dwc3
+              - qcom,ipq5332-dwc3
     then:
       properties:
         clocks:
@@ -267,7 +268,6 @@ allOf:
           contains:
             enum:
               - qcom,ipq5018-dwc3
-              - qcom,ipq5332-dwc3
               - qcom,msm8994-dwc3
               - qcom,qcs404-dwc3
     then:
-- 
2.34.1


