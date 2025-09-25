Return-Path: <linux-pm+bounces-35367-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E80FB9FE33
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 16:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526405E2BC7
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 14:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E771B2D0C94;
	Thu, 25 Sep 2025 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IfW9SdJA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401822882CC;
	Thu, 25 Sep 2025 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809181; cv=none; b=i4WtdtvMcDOeITOUTD03sQlDN3AVBiwYJ1EsrEJQmkrKTumBBFFtrpz/rOE0Jx7yYE/R6HeXKc4Yl7l73u2sAc1wKv3xosaLLtskxQsuQuOU58rc+n96uLiuCjJDt3vnsIjmA0HHF3pJWpaQnpdzNRRlqemABs09NeuY22VhkBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809181; c=relaxed/simple;
	bh=zbX9HeXBf5PAa25ZrOi3yN855w8ttsdlvx0kKZu6ysA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MUyQDvmaqhkV1AnWinYLGANI5mss3A1wkMNAYHABW0ebAzq5ItzIpd4mTOWZ/l3k1dpGkOhDmYeoWew2EfwE4tkZl+mHINL+MWoZEILd+1XmpGulswgY3NcZcckJr0wPhxXLX0+79dMAUS4Dj8Qh2yKv44uuCl/XmNuAZkLTBLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IfW9SdJA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9D3Yl027304;
	Thu, 25 Sep 2025 14:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FNFEiFEUfgaN9aLjxirowQUkMf2efZX/MmaYd2145Lo=; b=IfW9SdJAaIwjIw7d
	oQAROXRAY/weu1i+vNaKu3Q941hgSillDjJ0TVgreAfpWXEvGSdV7LF3L7hjomfe
	6s+EAxCk55pukw9YkAJcimCqNqXKwu6CBo1BmIRWezhuVb4Az4P5zaWSNqIW/RMB
	p7u+LG8r/+CHysvgTz1kNkvWbNsyrUXOmgQZGTeoK8NHkqWlagWvKdOSulMSGlJC
	sB06JLJjw/CHERrTp2CLiXIbXYM8dLswUjmCkti7ZRWF+C2M/QbDVICgoH0tl+mc
	mer8uuZHDUZSzMwHEcgjryYTgG06vYSFYkJnw9Zs84/oDJzs+DFsJFQ7TtJjukrd
	XcU9Jg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv18c1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 14:06:03 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58PE62PW015790
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 14:06:02 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 25 Sep 2025 07:05:56 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 25 Sep 2025 22:05:36 +0800
Subject: [PATCH v6 02/10] dt-bindings: clock: Add "interconnect-cells"
 property in IPQ9574 example
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250925-qcom_ipq5424_nsscc-v6-2-7fad69b14358@quicinc.com>
References: <20250925-qcom_ipq5424_nsscc-v6-0-7fad69b14358@quicinc.com>
In-Reply-To: <20250925-qcom_ipq5424_nsscc-v6-0-7fad69b14358@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Varadarajan
 Narayanan" <quic_varada@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        "Manikanta Mylavarapu" <quic_mmanikan@quicinc.com>,
        Devi Priya
	<quic_devipriy@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Richard
 Cochran" <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <quic_kkumarcs@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_suruchia@quicinc.com>, Luo Jie
	<quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758809144; l=1160;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=zbX9HeXBf5PAa25ZrOi3yN855w8ttsdlvx0kKZu6ysA=;
 b=TwwKXczi+pB7+rwOdDUnTZiE4TryDhK03sio9j073re1KV0OY9abKFaOjYHRmqlQ8ik17a5q5
 QI0oNgvdINAC1339BIlnD51eijNDNxkFKtTGNP+hLLp0WB4K7sRYln3
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mss36OujeW6uA9ORhqLPeJRPvc-3QW6U
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d54c4c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8
 a=TKdP9mIMqFxeD0qFjnIA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX2XpJILFVN6FH
 a/aNedDYbUKKwfdTliEb+s6bSL8PNtlW0XPQ9/ROZgqQCOJW3fIcY3H2S19JrVwSLMtfMVjT9DF
 EGfgTJ5FL7i7Nl0eBbLLGmcKwkQuVP1K2a1/F7v9DbqxzpXR/YWRwPP/vI7E1ch5vx4pvq1XSBr
 VPpZfLkJlXwlEgb59ZUfeT7ADsTOa+33gvGEsg/pVXQYyNE2P46ALfOUv884s7CwMHSgjAQ373M
 ycF4/LUbZBqqajt2svgKln7TquKQdESQ321e5wKKg1PoasuOIcRfZfG9wXZsGfZzHqTHzmFeapB
 ebuW+4knN6ZNfHJflGNG9FyownINyhftAJs4cAocn0OTQkUnSHem6jyf6Y9w0GFEq4z7vI1ktLC
 dnLTAuYd
X-Proofpoint-ORIG-GUID: mss36OujeW6uA9ORhqLPeJRPvc-3QW6U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

The Networking Subsystem (NSS) clock controller acts as both a clock
provider and an interconnect provider. The #interconnect-cells property
is needed in the Device Tree Source (DTS) to ensure that client drivers
such as the PPE driver can correctly acquire ICC clocks from the NSS ICC
provider.

Add the #interconnect-cells property to the IPQ9574 Device Tree binding
example to complete it.

Fixes: 28300ecedce4 ("dt-bindings: clock: Add ipq9574 NSSCC clock and reset definitions")
Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
index 17252b6ea3be..5d35925e60d0 100644
--- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
@@ -94,5 +94,6 @@ examples:
                     "bus";
       #clock-cells = <1>;
       #reset-cells = <1>;
+      #interconnect-cells = <1>;
     };
 ...

-- 
2.34.1


