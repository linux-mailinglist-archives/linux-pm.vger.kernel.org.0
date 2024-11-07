Return-Path: <linux-pm+bounces-17115-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6E39C0881
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 15:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72044282B4F
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 14:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8161F214416;
	Thu,  7 Nov 2024 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AIyS7j79"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD29212F05;
	Thu,  7 Nov 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988520; cv=none; b=sFgyzVqZSkBdM2t0JNNhzeGeEhnwgISXAC/LoZoxbRrlUg3sz6rXs1+GYQD5x7qzg+xDnZN/skwohmufmJUz4vMwicsMx2wESUNKYMezRrmxPwOFhB6RXprN1qnHjoYFMpDkRwoGhhVLG9nFkK+DcOKsLLs8RVy5es+sOxypAkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988520; c=relaxed/simple;
	bh=9dkuxgmDMyONG3GW6XsCc15b8OcxM+IDwI5uIb2GnbY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pt1Z7N2lSyVEy9WNoRm6tVPtUSW2xnzvO8+OEs7aSw9pnUbVCp5Ae8Scj8Kh5vcwU34aZA3/PJ+IF+/fiPIeE8Od+TIWdJs70DbAWrOWnPtM1xaQllDsa/5OqTKoBfZgS3m+UDQys51EOMllHlEeZz7uWSv8NUlB0K2FIAVjtyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AIyS7j79; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7AZSaQ004700;
	Thu, 7 Nov 2024 14:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	saZFZjq6UlnB6ncLyQUwADqYdmoYKVEpS+6KmixjEWs=; b=AIyS7j799Xk8u5Mg
	Dk+90lHFeV4i7KiQSdCZHFoZWASHeftvUt/Lr9it/k7uYB4sNKobe1SKwiYVpCff
	MwFMUJNTY77RHvuQXnoGTcWGkeSclKHa45/9ylx/JZr0hZJ5JUy6eH/+lpPqdcqm
	ckn/x1U0HGx8tfTXBUvgP4/NxNvb4hb/Z2t+/hZwJ4tDxSv5509slp85EPpSG2pv
	PdNPicg1LbI/SXXgsjEMaajidtx2BZMUPdqNtsk2guvC7iK38t59E07nj1s8ePVi
	TSW/xLG6Bl0S/aiPdpT8nTpHbGyL3EDimq8QFHohN8DQ1Q9Aq9wVIjs89hjdbat+
	PgWkWQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qfdx7rkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 14:06:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A7E6fHa005425
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 14:06:41 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 7 Nov 2024 06:06:35 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v7 6/7] arm64: dts: qcom: ipq5424: Add tsens node
Date: Thu, 7 Nov 2024 19:35:49 +0530
Message-ID: <20241107140550.3260859-7-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107140550.3260859-1-quic_mmanikan@quicinc.com>
References: <20241107140550.3260859-1-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4_oBVFbUPzHBE0NqjkV9oo-Yc6UNWSFW
X-Proofpoint-ORIG-GUID: 4_oBVFbUPzHBE0NqjkV9oo-Yc6UNWSFW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=762
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070110

IPQ5424 has tsens v2.3.3 peripheral. This patch adds the tsense
node with nvmem cells for calibration data.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V7:
	- No change

 arch/arm64/boot/dts/qcom/ipq5424.dtsi | 87 +++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
index 76af0d87e9a8..e97cf6529dd7 100644
--- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
@@ -137,6 +137,93 @@ soc@0 {
 		#size-cells = <2>;
 		ranges = <0 0 0 0 0x10 0>;
 
+		efuse@a4000 {
+			compatible = "qcom,ipq5424-qfprom", "qcom,qfprom";
+			reg = <0 0x000a4000 0 0x741>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			s9: s9@3dc {
+				reg = <0x3dc 0x1>;
+				bits = <4 4>;
+			};
+
+			s10: s10@3dd {
+				reg = <0x3dd 0x1>;
+				bits = <0 4>;
+			};
+
+			s11: s11@3dd {
+				reg = <0x3dd 0x1>;
+				bits = <4 4>;
+			};
+
+			s12: s12@3de {
+				reg = <0x3de 0x1>;
+				bits = <0 4>;
+			};
+
+			s13: s13@3de {
+				reg = <0x3de 0x1>;
+				bits = <4 4>;
+			};
+
+			s14: s14@3e5 {
+				reg = <0x3e5 0x2>;
+				bits = <7 4>;
+			};
+
+			s15: s15@3e6 {
+				reg = <0x3e6 0x1>;
+				bits = <3 4>;
+			};
+
+			tsens_mode: mode@419 {
+				reg = <0x419 0x1>;
+				bits = <0 3>;
+			};
+
+			tsens_base0: base0@419 {
+				reg = <0x419 0x2>;
+				bits = <3 10>;
+			};
+
+			tsens_base1: base1@41a {
+				reg = <0x41a 0x2>;
+				bits = <5 10>;
+			};
+		};
+
+		tsens: thermal-sensor@4a9000 {
+			compatible = "qcom,ipq5424-tsens";
+			reg = <0 0x004a9000 0 0x1000>,
+			      <0 0x004a8000 0 0x1000>;
+			nvmem-cells = <&tsens_mode>,
+				      <&tsens_base0>,
+				      <&tsens_base1>,
+				      <&s9>,
+				      <&s10>,
+				      <&s11>,
+				      <&s12>,
+				      <&s13>,
+				      <&s14>,
+				      <&s15>;
+			nvmem-cell-names = "mode",
+					   "base0",
+					   "base1",
+					   "s9",
+					   "s10",
+					   "s11",
+					   "s12",
+					   "s13",
+					   "s14",
+					   "s15";
+			interrupts = <GIC_SPI 105 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "combined";
+			#qcom,sensors = <7>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq5424-tlmm";
 			reg = <0 0x01000000 0 0x300000>;
-- 
2.34.1


