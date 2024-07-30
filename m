Return-Path: <linux-pm+bounces-11623-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF839407CC
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 07:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F41A28311A
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 05:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB76C18EFF1;
	Tue, 30 Jul 2024 05:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ky/7/GQJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188A818E758;
	Tue, 30 Jul 2024 05:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722318534; cv=none; b=rC8NuAK1hKP5qtZ+PqfOcTZfbF1oNcRWT9IEl9F0qJWZWjUXYKjFWZ4TmADCkDyB27+b3c7RuuWSY3SpVKWNMdnA++FcuC4wY/2d0MMx/D1NZcFShBGLCNOlgvcPFA9fP9pNA+uDnJ2I6D8UhWDEXUHPvDsY2IHYevDelTxIyIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722318534; c=relaxed/simple;
	bh=/1z7It3jLDJjgvq6vWKUgV7/ctwfQvQk+SSDph7wbds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0/AoxgS0Uqdeo4UDP7vQbeFUNtA1BkxPD85A5LV5ZX4V2pqbSKDWqbq0gUpuQTdIEZw7TzgEmKY09kzv8fYGeQ1E2o0pfZG/3j+SvN0mTGp5Z8/W/T61NmUawjkbtwqJ6LZzQKPmQRkUJ8zH5VHNBkNQzWYQ4B2NWw/dAaJ8/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ky/7/GQJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TKAG6U032660;
	Tue, 30 Jul 2024 05:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P/kue94PYQM7Ik2vvWkmFkiSey7S6st6umBRUCRsacA=; b=ky/7/GQJTSDjvmE0
	2kBaJeAmOdwVselVwuNLXCFgVPi3qljNDlEltesm1Acnbda2ffwBC+s2sGcd/eGE
	AGFADuNz+62ECL09Ep1geq6280kzX6/LnE3bKKIHoQxR+OWrR2p1FVPBrjseCaV0
	WrkY3se75stNICqY4cbwyI3h66zf5Fk4paBxVi8hWacAvcJ0tBYMIRjAmVRZauBG
	HqzQGLoV0I7EGiduguxH8RZ2YWtFUClbhprcGF5jWn5bQ7vU1tMvBKwRPiu0Cv/L
	wHDar/gA1gKfYXRdzVosCYQuKdGjb+30tKzzYKcYuyxCnysmpY/lpGp+s8T35DgQ
	HSRvZw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mrfxpa3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 05:48:47 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46U5mka3010909
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 05:48:46 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Jul 2024 22:48:40 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <quic_wcheng@quicinc.com>,
        <quic_kathirav@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 2/5] dt-bindings: usb: qcom,dwc3: Update ipq5332 clock details
Date: Tue, 30 Jul 2024 11:18:14 +0530
Message-ID: <20240730054817.1915652-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730054817.1915652-1-quic_varada@quicinc.com>
References: <20240730054817.1915652-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: 71P2KIO1OaAbQniBi-tqlsJqqw6c0n3H
X-Proofpoint-ORIG-GUID: 71P2KIO1OaAbQniBi-tqlsJqqw6c0n3H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_05,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300042

Unlike MSM SoC, IPQ SoC doesn't use RPM to aggregate bandwidth
requests and scale the NoC frequency. The NoCs are turned on and
set to a specific frequency at boot time and that is used for the
lifetime of the system. Hence interconnect was not considered
previously.

The same approach was used for PCIe and at that point the
consensus was to move to interconnect. Hence implemented the ICC
driver and updating the existing USB driver to use the ICC
driver.

USB uses icc-clk framework to enable the NoC interface clock.
Hence the 'iface' clock is removed from the list of clocks.
Update the clock-names list accordingly.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v6: Update commit message
    Add 'Reviewed-by: Krzysztof Kozlowski'

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


