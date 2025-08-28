Return-Path: <linux-pm+bounces-33242-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95606B39A4D
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 12:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4787C7638
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 10:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8B630FF26;
	Thu, 28 Aug 2025 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qa674isH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E4930C608;
	Thu, 28 Aug 2025 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377284; cv=none; b=kNGA3cqYVVs4u1ChNC5aeY2j8Mh8uZX7csnkuji0aOoLuuf3XJWbM9whaNxPyW7OE3HqYU7s6Lv/vymYmj+aU2OthmwCkBJnSLBWycVzDAkCnOpMa6X30y7yJaTqLreEeJT9tHOXQJ0xsP5wRjc7ThgCxsnGLAHDvEmVSTDVcRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377284; c=relaxed/simple;
	bh=nGMJ7M1v2vqAMZ6tBiUApreO1m1/mHNpggu4tQCR91g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=uS04K+ACeXcV1rd5PuAnFXtoxmI0Pkc316h79G8vylPd4gkiGeYoK6yZw0SSu98mfZi92nc4/Q+pABg7CKSLozoAmozW+Rj+xuxUwnqOcjI7jdKkf7eswRGodruPTErzP9NzdUik31O2qUYK7Q2clSNlBJfOt8b0dCAU/WQ+qTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qa674isH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S61gu0008302;
	Thu, 28 Aug 2025 10:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KfGNV1zTaVSq1hXkWZRdnyMtROKugBei619LdnrI2Jo=; b=Qa674isHNlH7NeJE
	hsSsO7yKTrxm5Ly58/Bmqxw3i5JGOdEsZWWL9Wef2EoxibkuxwuGVkoGv3+9m/9v
	MIb+qpAwm+7BJ07TQRjV1eajEg5y7ZCHXYxSAm4e97DJ0HjaH4943gaHzqvUQAOc
	ZysPoo0aijG9n5eQAYWxm28EdKS2qySIFCzoqxmB6vjxs/Bpufe1uPinA0FHC2Z3
	n2NtUve1ZafAYGbR8+GfF0gFKKtwsonr8ql0AmWaRj3+iAD+0PqXjCVK4PTOsXfB
	7bhvb7c/fxpTSb25Zx3LXw2U2L2fkeoa1QVbUsobmP6o5kGdTl3AKiTeGHLevcmf
	LMj0dQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48sh8ap5w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 10:34:31 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SAYUHa029847
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 10:34:30 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 03:34:24 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 28 Aug 2025 18:32:22 +0800
Subject: [PATCH v4 09/10] arm64: dts: qcom: ipq5424: Add NSS clock
 controller node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250828-qcom_ipq5424_nsscc-v4-9-cb913b205bcb@quicinc.com>
References: <20250828-qcom_ipq5424_nsscc-v4-0-cb913b205bcb@quicinc.com>
In-Reply-To: <20250828-qcom_ipq5424_nsscc-v4-0-cb913b205bcb@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756377205; l=1949;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=nGMJ7M1v2vqAMZ6tBiUApreO1m1/mHNpggu4tQCR91g=;
 b=WeEcVmWbwQL6mC9HiKdDMyMP+WF6G3BuVKbl233v4DhVdWNkFOLW7Ia9BFywM7+n3IogQVTe1
 bYkn6r4IUlSC1aAdX5k2+wC/I2N60+uhhGWwQMFdz8srsesTyFDGxpd
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=cLDgskeN c=1 sm=1 tr=0 ts=68b030b7 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=pA3aE4n4XothnxmHxHYA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDE1MyBTYWx0ZWRfX5DqyGa7Oi9WM
 OcTVqlOS1q3xNgtRkDR3rDO+aLhJHqKSNTTuUWhzqv1kyWfG1eF1ohPliH2Ioifyjdd3NfBaYFX
 1brTbCfxBlFs0/QbYiv2RajJBSpa4gQ5KaqNvnoienEMhrTV2NHWcExGWvpZtxsAslzzrDce8xP
 KiuyxInFP28zHJnd+oUMlvbeymptZRjhaUJ+rYxKR/y8xyRHgyZKXuOsh6jCy8Mhnp/yOhfbzsh
 3ozYwzzBkVXTx58OXaJi4hRjqJKvkh+jehrDi8wDl+0ltjtRuNpgGzsehDdPYdDdj59pHb/OI9i
 tIJNSnAfuECLOIXAmYEld1/2uXpipuDlUZ12CdPYcClnmQAs8Lz/vvk8pX00u7cyOhlhT1AJcmx
 7HTIAzx9
X-Proofpoint-GUID: niHl8mDFfiZN6oR-pWrUCxxCJpmEkck-
X-Proofpoint-ORIG-GUID: niHl8mDFfiZN6oR-pWrUCxxCJpmEkck-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260153

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


