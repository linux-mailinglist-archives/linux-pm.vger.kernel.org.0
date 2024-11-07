Return-Path: <linux-pm+bounces-17112-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C189A9C0875
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 15:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A161F22BC5
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 14:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6744B212EEF;
	Thu,  7 Nov 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lmpotgzM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C1212657;
	Thu,  7 Nov 2024 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988518; cv=none; b=o3mXTNMC3MviYTulcC554vtNF6hg0sFvMwbpxL7EfJcYCD/NRsJ3VSE4R+58jNpm7h8+kOxAR02Z2FfRpIZwngCuPJzccp07erm4oqUirt3eeJ+GZZS0Np0Hxh6fsmBB+RMRs0IGM7wyGJlwbWGs2ldJOfYSEbUtGNymErQPjRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988518; c=relaxed/simple;
	bh=EGtnAGbilcLgeXqlbA2f5Le21/t6rZNREcXFxkdO3So=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EP6++KnxO6pz347QkKNdjYM1mx9D5JMwgpaE6OaEYErj7EhPCfMAgIICd1JyHEKT/mGwcB3VOWXpvT9BkcFmf8tSDJmSe3rrWHoEqjzkOHyfR28ElB1vvMnX/+gwwSRKuEXX1fAequQv3DQh9kZSVRzNQZaVox7LZEVPjVIJNW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lmpotgzM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A79uOoe004697;
	Thu, 7 Nov 2024 14:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uFGqWk05VjlBMWdnkjat2q7pG9vzCnBcOVjTbPMXGdQ=; b=lmpotgzMy/a580jL
	zpIGDBMnKPs3Hs3bqkclvO7xV1euS4hCwqMHnQ4XU5LbijtcDiCLGidbi7EDwXoR
	e0I2SFwUH1g/NTZbSSnmBwLVTsLwnzOB0X0qCXG3zEBryOuPKBo8ZOD+YNB/Eb1O
	fECGsOmH1t9TrKplfjngaIGlPDKa9V6LQy/qp6cG2yIWxGuWBfzIcYAi89BIqAYE
	F34usr1CHVBZIqIyb3T8AUYzYVDnNaPChLjVgwe41jTPAS8WhCm5uMkWrApsbhUP
	3sujoHf2poBa1vyOVMKlmjbQ9oOgz95L95nWyKz3GrvTANImKTAy3lJotI30g91K
	Vb/jdQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qfdx7rju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 14:06:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A7E6UBo011580
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 14:06:30 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 7 Nov 2024 06:06:25 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v7 4/7] arm64: dts: qcom: ipq5332: Add tsens node
Date: Thu, 7 Nov 2024 19:35:47 +0530
Message-ID: <20241107140550.3260859-5-quic_mmanikan@quicinc.com>
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
X-Proofpoint-GUID: li-HoYJg5o3IQp1KY1fnjd3rKGN3PsKE
X-Proofpoint-ORIG-GUID: li-HoYJg5o3IQp1KY1fnjd3rKGN3PsKE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=804
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070110

From: Praveenkumar I <quic_ipkumar@quicinc.com>

IPQ5332 has tsens v2.3.3 peripheral. This patch adds the tsense
node with nvmem cells for calibration data.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V7:
	- Modify the address format in the reg field of the tsens
	  node by prepending two zero's to the address.

 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 66 +++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index d3c3e215a15c..897b961d5879 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -177,6 +177,46 @@ cpu_speed_bin: cpu-speed-bin@1d {
 				reg = <0x1d 0x2>;
 				bits = <7 2>;
 			};
+
+			s11: s11@3a5 {
+				reg = <0x3a5 0x1>;
+				bits = <4 4>;
+			};
+
+			s12: s12@3a6 {
+				reg = <0x3a6 0x1>;
+				bits = <0 4>;
+			};
+
+			s13: s13@3a6 {
+				reg = <0x3a6 0x1>;
+				bits = <4 4>;
+			};
+
+			s14: s14@3ad {
+				reg = <0x3ad 0x2>;
+				bits = <7 4>;
+			};
+
+			s15: s15@3ae {
+				reg = <0x3ae 0x1>;
+				bits = <3 4>;
+			};
+
+			tsens_mode: mode@3e1 {
+				reg = <0x3e1 0x1>;
+				bits = <0 3>;
+			};
+
+			tsens_base0: base0@3e1 {
+				reg = <0x3e1 0x2>;
+				bits = <3 10>;
+			};
+
+			tsens_base1: base1@3e2 {
+				reg = <0x3e2 0x2>;
+				bits = <5 10>;
+			};
 		};
 
 		rng: rng@e3000 {
@@ -186,6 +226,32 @@ rng: rng@e3000 {
 			clock-names = "core";
 		};
 
+		tsens: thermal-sensor@4a9000 {
+			compatible = "qcom,ipq5332-tsens";
+			reg = <0x004a9000 0x1000>,
+			      <0x004a8000 0x1000>;
+			nvmem-cells = <&tsens_mode>,
+				      <&tsens_base0>,
+				      <&tsens_base1>,
+				      <&s11>,
+				      <&s12>,
+				      <&s13>,
+				      <&s14>,
+				      <&s15>;
+			nvmem-cell-names = "mode",
+					   "base0",
+					   "base1",
+					   "s11",
+					   "s12",
+					   "s13",
+					   "s14",
+					   "s15";
+			interrupts = <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "combined";
+			#qcom,sensors = <5>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq5332-tlmm";
 			reg = <0x01000000 0x300000>;
-- 
2.34.1


