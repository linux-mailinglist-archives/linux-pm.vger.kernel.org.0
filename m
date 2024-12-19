Return-Path: <linux-pm+bounces-19485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8989F74C1
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 07:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A507A169FFB
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 06:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AE7216E0D;
	Thu, 19 Dec 2024 06:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ny3Ibg4F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89937217F4B;
	Thu, 19 Dec 2024 06:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734589781; cv=none; b=YBKg2Bgu+vQPUd748uW+A3G0QCxxmNS2Q6lMCuIBlEjUkTUWjJ3qqKJDjZD91XukR4mRANz1fMoVk0s5sxxvVi3AKo5cXBw4epCCtz+HaVDFb0DzjD7MLjqqeZ/RQRvc3r9wxRwhIDcloGe5R8dEFuUE7x8hI1XlQ4A5Hmlokwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734589781; c=relaxed/simple;
	bh=3rbfcKqY5v058wP+nJyZwVkRNfyZ3mKZqLwzWNr9uUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+fqk+BMV2ZfqQm5/9xVMZ+SEhNze9qx70ILk+igAe1EpFfRMmEx5yO4gDrqICeNQe9UeLdIVlCRuAAk42n8dW0vNC6us5Rf3ZozBFm0/ZyWySgEY96Ohx+AkSINdoyrLxY6AEFPMqUpsF6LnVx8MlDQNgTeJ51sVFkVgYgBj1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ny3Ibg4F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIKKhJ4022236;
	Thu, 19 Dec 2024 06:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	okuYMGyXXehxNXnNfthDnRgb9bslY8Bsk6jsMwB+K9Q=; b=ny3Ibg4FE8mZsBLo
	oSu4WO0GLCI/G3IZyeVLz0h6D6DBE4T/W3zDa0kQs0TDv0MG5iWVr2Wo2nv9hCpQ
	JBfMo0tQPC6ejazj5vVYGDMCKAhM9+/2G6IzH580Kq17NMvlAcBc7kua0MegSYB6
	Ke8REcHDG5igO/RN3HkXeeMnFjIUo5FmhRD+wapoxFbrprTC8mp2i2Gl0JL4701M
	cf4ta7pdg+Cxly8aZdt0l8ClNZCUr5QYjK+QsbVBpWT9AKmsfj1suk1X+F5bTmwM
	y66EMOFEiFOj4R9VnWnJ5fgQgRscmrEG2M9P1fEVZtThz4xH1AacfkroAys0WD9P
	eZgrAQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43m5bns4d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 06:29:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BJ6TWWD014521
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 06:29:32 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 18 Dec 2024 22:29:27 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v10 6/7] arm64: dts: qcom: ipq5424: Add tsens node
Date: Thu, 19 Dec 2024 11:58:38 +0530
Message-ID: <20241219062839.747986-7-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219062839.747986-1-quic_mmanikan@quicinc.com>
References: <20241219062839.747986-1-quic_mmanikan@quicinc.com>
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
X-Proofpoint-GUID: rXj8yLA7f8zSO1cV-hE6H0K8e9OYHlwY
X-Proofpoint-ORIG-GUID: rXj8yLA7f8zSO1cV-hE6H0K8e9OYHlwY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=886 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190050

IPQ5424 has tsens v2.3.3 peripheral. This patch adds the tsens
node with nvmem cells for calibration data.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V10:
	- Pick up R-b tag
	- Moved interrupt properties above nvmem

 arch/arm64/boot/dts/qcom/ipq5424.dtsi | 87 +++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
index 5e219f900412..a4846dd904b5 100644
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
+			interrupts = <GIC_SPI 105 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "combined";
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
+			#qcom,sensors = <7>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq5424-tlmm";
 			reg = <0 0x01000000 0 0x300000>;
-- 
2.34.1


