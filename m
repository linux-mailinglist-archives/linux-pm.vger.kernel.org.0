Return-Path: <linux-pm+bounces-17618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A8A9CDCE8
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 11:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6949428200E
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 10:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDC01B6D12;
	Fri, 15 Nov 2024 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gLlY3ma5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D00E192B9D;
	Fri, 15 Nov 2024 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667302; cv=none; b=bqXhftG10BbXymxA1tpwFkJFXDK8wDsyx0sqAe5c22dxGz/R9D5Q05pNdB+cvQfTHIvVkPX3dU+7hcr7bR228wa0Y9ihJ9JjJ6XYAZ7XC+WdMZ208LNAWrAday5/tf1coKJOC9a2lFix/IMISpn0kgevRPn213Qvf/Ke3bO6huo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667302; c=relaxed/simple;
	bh=J/HSCvTVxrH0uvEn6CPxZjE3zVA5JKrxTtf8WRwaaZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/XvsO2MHmZVzp7pkoqAOmTs0ZJ8sCV3beCGevqcvPuVGA1hkwsxRMxa52M0bp5Em7w/5ycmgjkZ37xpNaxgtjRtWQmwN2yWfQdIF8/JM8uPHh5sWWOvXKXtXawdiCLFwLl0hVSzJCeJGFUPoUBjlGE1ULNnAwCRsZL+hCrraBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gLlY3ma5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF91rM9024655;
	Fri, 15 Nov 2024 10:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EuMJd+hnFbQqRU+XI/OaHifM1LY2kMbFtkNdKBj7hJI=; b=gLlY3ma5GSG42Fp2
	+HRA+pO1jLnDqbPdrwtiqIjbUyaeU+UsJwIUBmcAclheFab/zaoL73EyrZHUrg2D
	vR/TIxH9N/DKBQc7sirz5G0zX8vKm3PjE3y4/Hdnto2RpSyK7p8k3Z2LKhHFiSYl
	PrKQwHuMAHj6zMRpK1UzrbWR0vmXZB1RxtBMDmtn0Cnlgrn6thxudBL3VH4ERYYa
	3our+hWNDcYvKPecF/cOFVQ9wAc+X2suZsWc561gguxBnuoKTk7TmF76Doc2ZUXD
	9ldX6KlhSY3t2F+Cp2wbN7x2vIcUPwZslb/R9iquplqYAkDr5uH7Fg/Vdm0BLGUi
	IvbROg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42x3acga9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:41:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFAfD0O020365
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:41:13 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 15 Nov 2024 02:41:07 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v8 6/7] arm64: dts: qcom: ipq5424: Add tsens node
Date: Fri, 15 Nov 2024 16:09:56 +0530
Message-ID: <20241115103957.1157495-7-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115103957.1157495-1-quic_mmanikan@quicinc.com>
References: <20241115103957.1157495-1-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GWhup1Jvx1fmczHvB97MuFxcRGhMlFOR
X-Proofpoint-ORIG-GUID: GWhup1Jvx1fmczHvB97MuFxcRGhMlFOR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 mlxlogscore=717 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150091

IPQ5424 has tsens v2.3.3 peripheral. This patch adds the tsens
node with nvmem cells for calibration data.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V8:
	- Rename s9, s10, s11, s12, s13, s14, and s15 to tsens_sens9_off, tsens_sens10_off,
	  tsens_sens11_off, tsens_sens12_off, tsens_sens13_off, tsens_sens14_off, and
	  tsens_sens15_off respectively.

 arch/arm64/boot/dts/qcom/ipq5424.dtsi | 87 +++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
index 5e219f900412..4f2e103d48a4 100644
--- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
@@ -145,6 +145,93 @@ soc@0 {
 		#size-cells = <2>;
 		ranges = <0 0 0 0 0x10 0>;
 
+		efuse@a4000 {
+			compatible = "qcom,ipq5424-qfprom", "qcom,qfprom";
+			reg = <0 0x000a4000 0 0x741>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			tsens_sens9_off: s9@3dc {
+				reg = <0x3dc 0x1>;
+				bits = <4 4>;
+			};
+
+			tsens_sens10_off: s10@3dd {
+				reg = <0x3dd 0x1>;
+				bits = <0 4>;
+			};
+
+			tsens_sens11_off: s11@3dd {
+				reg = <0x3dd 0x1>;
+				bits = <4 4>;
+			};
+
+			tsens_sens12_off: s12@3de {
+				reg = <0x3de 0x1>;
+				bits = <0 4>;
+			};
+
+			tsens_sens13_off: s13@3de {
+				reg = <0x3de 0x1>;
+				bits = <4 4>;
+			};
+
+			tsens_sens14_off: s14@3e5 {
+				reg = <0x3e5 0x2>;
+				bits = <7 4>;
+			};
+
+			tsens_sens15_off: s15@3e6 {
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
+				      <&tsens_sens9_off>,
+				      <&tsens_sens10_off>,
+				      <&tsens_sens11_off>,
+				      <&tsens_sens12_off>,
+				      <&tsens_sens13_off>,
+				      <&tsens_sens14_off>,
+				      <&tsens_sens15_off>;
+			nvmem-cell-names = "mode",
+					   "base0",
+					   "base1",
+					   "tsens_sens9_off",
+					   "tsens_sens10_off",
+					   "tsens_sens11_off",
+					   "tsens_sens12_off",
+					   "tsens_sens13_off",
+					   "tsens_sens14_off",
+					   "tsens_sens15_off";
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


