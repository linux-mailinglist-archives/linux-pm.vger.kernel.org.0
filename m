Return-Path: <linux-pm+bounces-34268-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 749FDB4FDB3
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 15:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2E937ADFF4
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 13:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31D53570CC;
	Tue,  9 Sep 2025 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dMDLxSg6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD79D356913;
	Tue,  9 Sep 2025 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425282; cv=none; b=Jq1IaQa0L1SHs9L7qy0lB/ChHtGSke+g/R8vWLnbujOGSHmCjJKVoPEZZudY5EUH4C8HRlMAHQZDrIbUlLI8pPUb63VGrNeX+ruf12QMc9b+r+jFyV95Mi75A7+vxMclHPFqKXnrgYG3y3gCv+9JlBXZgB9zSgwx0JKpDbJs6gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425282; c=relaxed/simple;
	bh=nGMJ7M1v2vqAMZ6tBiUApreO1m1/mHNpggu4tQCR91g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UlXfscEfl+fZQ2LtbFLF2te/YkvmJBgyj8kUzc5MOxzgEzZ/OJ5r2mJRqYZ2pAkDBUPKh60axWvk2wSY3mT2+uale51ewGD9+RpmEPmfRKMF/b/f7XVFjG9j8CY2q25nU8mvYN3+4tAxaIdxBNzmBuEUl7qH61PGpxXEfljxBxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dMDLxSg6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LR2g020094;
	Tue, 9 Sep 2025 13:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KfGNV1zTaVSq1hXkWZRdnyMtROKugBei619LdnrI2Jo=; b=dMDLxSg660itUR78
	aEBKGOZv2mAnfXvrrTNU2Lgmbvat2t50TtkR1OxOO4U+wualKN/IBRnyWVoJLAXH
	NudhOBz46PCJBPKGZHPRdtM7UAQ9qrYAIyYyWTB7WzUjGSsAOt+v6ExQ70sLSgBG
	uAEBoElhE9S3wZZsJq93zGJLpcCKCV30fPJY19CiKbOTyKOcq+jHF+/XurfedQak
	cQy9/VwjhbQWzNHioCkWil2lcHjmyaHU/rVRx2thUYQhQmxm0FlovclIwdK34to6
	hL3GYcvhDJrxCpgYZdxbv19eB+X27ToPlRJXfujFBClPC0iH3RBvEEetJ7sRqAQV
	XmcODQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc24d6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 13:41:05 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 589Df4Hn026246
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Sep 2025 13:41:04 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 9 Sep 2025 06:40:18 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Tue, 9 Sep 2025 21:39:18 +0800
Subject: [PATCH v5 09/10] arm64: dts: qcom: ipq5424: Add NSS clock
 controller node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250909-qcom_ipq5424_nsscc-v5-9-332c49a8512b@quicinc.com>
References: <20250909-qcom_ipq5424_nsscc-v5-0-332c49a8512b@quicinc.com>
In-Reply-To: <20250909-qcom_ipq5424_nsscc-v5-0-332c49a8512b@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757425161; l=1949;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=nGMJ7M1v2vqAMZ6tBiUApreO1m1/mHNpggu4tQCR91g=;
 b=p9JYQE958GkOkTflY6MgD/jFMkwBc+dIrdhFTrzy2zk11OIl5VYvXeSoyBTVv95xcfKnkCupZ
 egt+5Xsm7QCB8xSOm4qI4wbyPBmIAnA7MMkYlYu/l/DSmDbR6gAzHGx
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68c02e71 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=pA3aE4n4XothnxmHxHYA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Z6fMyNfFW15HdbvsMbTx9tLT6YaFpQXW
X-Proofpoint-GUID: Z6fMyNfFW15HdbvsMbTx9tLT6YaFpQXW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfX+lThwLEWWgTF
 w5k7n+0J8eFjUVuO404jUXEuYS9dnpf4ZCOcnd3+IsYLmmaxxjd4dH3vwAzKmekAmYWbucDkyCY
 SD/50lAJvhKHbLXobTo77ZVmlbx2mys27Uj4RNGih6bAW4+gQz+rfJZb0Z7jJPdI1JgUvQKM6FW
 jkxAm+ydJk/TxzfeCyw9kJeFVP8f8r76pDzpYFz28dCxhtWoWA+7irUDJ1nFFPFuzoKMCaqZdvd
 hgBTGXOQseD+a3q4+8YGHgHqxa5ThJvS7erCVBEFLJwMN0fd6z+UGN9AOVdtqisBaJZJo2NfpeA
 D/3uEMnNNHLcbtRK+zUp+xAJ1zEU/D8pD8LQU2GMvqxeQRHFCRmnadsWMIQbpEcpkLvPTg5n1iL
 hiC41GDS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094

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


