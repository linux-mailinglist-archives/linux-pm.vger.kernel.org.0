Return-Path: <linux-pm+bounces-21687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E5EA2EC3D
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 13:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FAD418892CD
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 12:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46508225A43;
	Mon, 10 Feb 2025 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZEEQuJ8B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24F5225417;
	Mon, 10 Feb 2025 12:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739189137; cv=none; b=M6NxNzTGOKrB2ystt9DwRq7lVVZXaLX9PKyQxl3hAI13yWhGCtcoIgxxiNPEKz4yOX6+vqkCKV+0ouwYOfouylvdopqnfzaqFL5Px4GWFvBYe9nFJN+nH2xQ/WcyrjwdExwl2AqVQyJz6dGdeKruVWDAblyJuxn5GLHGz+izq90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739189137; c=relaxed/simple;
	bh=Ad7omMYIlyiw9qKvaOMY2OgZKuLpj9TmOQjOmQgKiB0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Teflw7OgKTqTuNuru/XqOFmS5dE3SwnjbP3a50Dk3U0aHks/9m3IBKXOciOWdtPxokmUOeHCKADe0M1MKOJAI5V3AU8fdGd9OJKWDHgGn7zXFXltTnrMI9C6+Fz3v8uZKxw7wMBzWNF2FONdLkg+pYUGrc1GbtFkQO9rJM/SQYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZEEQuJ8B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AAkGft011113;
	Mon, 10 Feb 2025 12:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tt5b9L//vpdGe1fusKlMcLbmtmU6XGx0Jmn8NfXIZ+U=; b=ZEEQuJ8B3z5JlnjR
	lKFEY9/qX5S3ftMxYrxHk6vs5kqbH7KCPPFCduFSNeKAA1VFwcXHN4R1du90Sc05
	KJg4/79K1f4VxgUsRjGFufxq2qWIsHdxQYcK9A5aNIuJkxJoDDPSAEhJ03770wkN
	oUtNhlvOMpRPHuoGO87ZgYVN/WUZfWidfBHYta5p8oCWwZFervkPnJVCmzOlpno1
	CpllwclBzMI8NkmHbmdRnYw+E6LbgtVRO8yah/W4LblmAws96O7Okf0S40DZw8yS
	zR5t59X6Je4a7GScrx5AwrmfvTtE9NA1RY6ThF4aDO2nuQBT8AIXJ44ziYIURMIj
	V7WigQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44q8ky9e3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 12:05:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51AC5RBJ010409
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 12:05:27 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 10 Feb 2025 04:05:22 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <amitk@kernel.org>, <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v11 5/6] arm64: dts: qcom: ipq5424: Add tsens node
Date: Mon, 10 Feb 2025 17:34:35 +0530
Message-ID: <20250210120436.821684-6-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210120436.821684-1-quic_mmanikan@quicinc.com>
References: <20250210120436.821684-1-quic_mmanikan@quicinc.com>
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
X-Proofpoint-GUID: eUvwlLDkbE3I-nybi5LNUV4glwVTiydI
X-Proofpoint-ORIG-GUID: eUvwlLDkbE3I-nybi5LNUV4glwVTiydI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_07,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxlogscore=762 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100102

IPQ5424 has tsens v2.3.3 peripheral. This patch adds the tsens
node with nvmem cells for calibration data.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V11:
	- Rebased on linux-next tip.

 arch/arm64/boot/dts/qcom/ipq5424.dtsi | 87 +++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
index 7034d378b1ef..774386d785d5 100644
--- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
@@ -152,6 +152,93 @@ soc@0 {
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
 		rng: rng@4c3000 {
 			compatible = "qcom,ipq5424-trng", "qcom,trng";
 			reg = <0 0x004c3000 0 0x1000>;
-- 
2.34.1


