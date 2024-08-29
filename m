Return-Path: <linux-pm+bounces-13140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D5E963E90
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 10:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952171C20833
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 08:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D418A18E364;
	Thu, 29 Aug 2024 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gSBEwpLR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C5618C923;
	Thu, 29 Aug 2024 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920204; cv=none; b=Yl8VfKXd+pM/CR1LcLAsJpbGaP1mmNbb59fFLQlFHNZoT8iggaGDTWLO02+efWUHHLqkhD6FVkK0Nieh/581/1ZkMakp2e5N5fu3VgeRabZY1E4LW8ss4WxIimpbWty1VtMDB0+7HRend0CrF+VbSVByPOu6UT4S028XoINHleY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920204; c=relaxed/simple;
	bh=hVHIM9XdKlqo5sk1kMMefBhr3QHeX2M/W5PaMccLzNs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8T+h053eEiXEyQnS2mSQ7uexZ/Ys/N3DCSXhso/wWfsb18vpxlSTlh7fQ5QXZc0TZHkPFjkwnpffTuDBT4iojj0MYjZL8V8T7udWKCCEirVoSu7VUal9Xkq4LqTD6j2oHDpmryr0hT0xHJV3XhjABzBRcHNt1l28JjJREElvLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gSBEwpLR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47T89G4L032541;
	Thu, 29 Aug 2024 08:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZiN2QbnqSd3fiwtFQn74qn/q4Iio+aKsqQ9BUidaYC8=; b=gSBEwpLRDBtzQY3p
	9u7q2gJZdyYw8+oUlAk1gJ6xfuJSUddB0Xl9qNpp1FZ5LZE70NOZgq596UdFVwBc
	4tNzXNQqnwnu+cEwSxmnIlT8ky4FHhh4SuDyfWhcSnWTUaiOax1A5LL3dOjAjxgX
	Eugwy2/KVZBudXFiC3kE8yuHpyN45X2jYOVLP3u2xdOseHbuZru3ABjR2eUiauEF
	A0btDtTfivlNm/jJwSRQSSf/erBVQv47UDxDXxBrxsH7frZ3oS9sUlHwPvb07gcT
	scgXBlekSa8IDWRRikp8VcX6d78yVoPxfIG26VWw9st1URMi2iSAGZyG7olSe455
	rjvtRw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419puw4hbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 08:29:50 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47T8TnI4008349
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 08:29:49 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 29 Aug 2024 01:29:42 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konradybcio@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <djakov@kernel.org>, <richardcochran@gmail.com>,
        <geert+renesas@glider.be>, <dmitry.baryshkov@linaro.org>,
        <neil.armstrong@linaro.org>, <arnd@arndb.de>,
        <nfraprado@collabora.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        Varadarajan Narayanan
	<quic_varada@quicinc.com>
Subject: [PATCH v5 7/8] arm64: dts: qcom: ipq5332: add support for the NSSCC
Date: Thu, 29 Aug 2024 13:58:29 +0530
Message-ID: <20240829082830.56959-8-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829082830.56959-1-quic_varada@quicinc.com>
References: <20240829082830.56959-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 0iNSpchXImXs5vLLrVdHeMzTFhryKthK
X-Proofpoint-GUID: 0iNSpchXImXs5vLLrVdHeMzTFhryKthK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 spamscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408290062

From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>

Describe the NSS clock controller node and it's relevant external
clocks.

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v5: Remove #power-domain-cells
    Add #interconnect-cells
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 71328b223531..1cc614de845c 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -16,6 +16,18 @@ / {
 	#size-cells = <2>;
 
 	clocks {
+		cmn_pll_nss_200m_clk: cmn-pll-nss-200m-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <200000000>;
+			#clock-cells = <0>;
+		};
+
+		cmn_pll_nss_300m_clk: cmn-pll-nss-300m-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <300000000>;
+			#clock-cells = <0>;
+		};
+
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
@@ -479,6 +491,22 @@ frame@b128000 {
 				status = "disabled";
 			};
 		};
+
+		nsscc: clock-controller@39b00000 {
+			compatible = "qcom,ipq5332-nsscc";
+			reg = <0x39b00000 0x80000>;
+			clocks = <&cmn_pll_nss_200m_clk>,
+				 <&cmn_pll_nss_300m_clk>,
+				 <&gcc GPLL0_OUT_AUX>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <&xo_board>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#interconnect-cells = <1>;
+		};
 	};
 
 	timer {
-- 
2.34.1


