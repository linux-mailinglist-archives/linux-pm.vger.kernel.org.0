Return-Path: <linux-pm+bounces-35374-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEE4B9FEB8
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 16:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0338C1C24DEB
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 14:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D19E2E8E13;
	Thu, 25 Sep 2025 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EonB2vso"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B9C2868A9;
	Thu, 25 Sep 2025 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809228; cv=none; b=qR5XVWlK5JxlAS2QSGY7RcPaevcMV3mmRs/iYtWZJgA/glqzAyCYQ7lFb5LFQADMAoIzQi0dfHo/+TUtlOm6nA57HP3DxcxlPHTTN1onHqgPtvQ8OHg6tUnaGde1cquRaTcIoQWACcFxtjfwQ3kdc7BrSwdcjKmiZGe2D9oRtas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809228; c=relaxed/simple;
	bh=nGMJ7M1v2vqAMZ6tBiUApreO1m1/mHNpggu4tQCR91g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nGlBIKUAES45unbJe3M50zGOlcl7lhgqe7bbHVtPspVfG1ZhSGuJcREMYQrA565q9Fq5CXr/Ft4Y+lHIm+ckKXXFy7g6EoC5zlSg3PBA+LE01TsUBU92RPvaimvz3Bbat4C/QIIhew9+EvvSTDIBnX8bbcqxbcSbc4Uh4epQ974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EonB2vso; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9jEkD025075;
	Thu, 25 Sep 2025 14:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KfGNV1zTaVSq1hXkWZRdnyMtROKugBei619LdnrI2Jo=; b=EonB2vsoP4YcmIm7
	K3LMZKS+hD25WbtNPotWmRYe16AnRA87gKjQLdg9IfHlTNK2jYcYRRSS6AJscbEx
	NLDMydFk+4O++BUMBPhTjTl6MACBOKypihY+Q8ehBCSDvMu8drotFtctCFcAJvbB
	KYtc3CGb8tcMYA7iZOu1XABEnL5gvaSP8SZyrz/KR7IeZTPl0kktvnWvg1b5r5vF
	7r6FbnqLf7ya+8TaSFl8F+Pdcms3qGSKbBA4/EsGL2/f71vGlZp+2GAPEjVctdFG
	MhAA/soJTHumsO2W8ZuH8wM0ZllAJZCyFh6eey8y7FureMwHCQEPo02ZVKSwYTEs
	akxmLQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyf0p4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 14:06:47 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58PE6ktt023338
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 14:06:46 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 25 Sep 2025 07:06:39 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 25 Sep 2025 22:05:43 +0800
Subject: [PATCH v6 09/10] arm64: dts: qcom: ipq5424: Add NSS clock
 controller node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250925-qcom_ipq5424_nsscc-v6-9-7fad69b14358@quicinc.com>
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
	<quic_luoj@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758809144; l=1949;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=nGMJ7M1v2vqAMZ6tBiUApreO1m1/mHNpggu4tQCR91g=;
 b=dXdmcN+aoBuuKMA71VlNNl5sWEXJgI+FXP53ho2hJ+OWWK4bXS5bRM3xbU1LOIycXcvc7XuYP
 9Lxyam1jqqaBsWYALc6r3ERiV7MIqntEVsCNWQAqVOoDsqE7RgRXg6X
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: E6rEPdH_-MNGs_UcpHoEU8rhzm9D9QD5
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d54c77 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=pA3aE4n4XothnxmHxHYA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX7nFgEdhLyZGJ
 y0eecWuGS17Xb8lHe7PuBmvjwqjCixb4jbpFnWGs8PDlBADa61zTFNt75dPuBbzJa8lxL3hSGnK
 AViQw8O0jYupAOHUbmvwe8u0ccbbrXmGMQjK2lv4vpxcs0EZb4k1PkrD+lXnDhrj81SfeIRsAiX
 H6TBX/s5hNVwvsfkN1LZ6xZ3E4t0IUoh1w/+SzSSZdYgf7mqEXD2Y7GKJcJF+lefrk8j2sN6oWh
 qbEa1iW5nCvlFVkjzxNWDQ1RgXyBC6SDTK5m3BMfrELalpykyuvaiDFuBW2p/4hoVArSVxyjbPw
 e0x7XSR7qH60ZbAj1ZPR9xJ/w0BNu98+blowHCZKEOFMggP6ZODBR/8pcfI0UEU84LvkOSrmUS1
 ECEwIDA0
X-Proofpoint-ORIG-GUID: E6rEPdH_-MNGs_UcpHoEU8rhzm9D9QD5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

NSS clock controller provides the clocks and resets to the networking
hardware blocks on the IPQ5424, such as PPE (Packet Process Engine) and
UNIPHY (PCS) blocks.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5424.dtsi | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
index 67877fbbdf3a..ea7b3b6bc756 100644
--- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
@@ -3,7 +3,7 @@
  * IPQ5424 device tree source
  *
  * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2022-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -809,6 +809,36 @@ apss_clk: clock-controller@fa80000 {
 			#interconnect-cells = <1>;
 		};
 
+		clock-controller@39b00000 {
+			compatible = "qcom,ipq5424-nsscc";
+			reg = <0 0x39b00000 0 0x100000>;
+			clocks = <&cmn_pll IPQ5424_XO_24MHZ_CLK>,
+				 <&cmn_pll IPQ5424_NSS_300MHZ_CLK>,
+				 <&cmn_pll IPQ5424_PPE_375MHZ_CLK>,
+				 <&gcc GPLL0_OUT_AUX>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <&gcc GCC_NSSCC_CLK>;
+			clock-names = "xo",
+				      "nss",
+				      "ppe",
+				      "gpll0_out",
+				      "uniphy0_rx",
+				      "uniphy0_tx",
+				      "uniphy1_rx",
+				      "uniphy1_tx",
+				      "uniphy2_rx",
+				      "uniphy2_tx",
+				      "bus";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#interconnect-cells = <1>;
+		};
+
 		pcie3: pcie@40000000 {
 			compatible = "qcom,pcie-ipq5424", "qcom,pcie-ipq9574";
 			reg = <0x0 0x40000000 0x0 0xf1c>,

-- 
2.34.1


