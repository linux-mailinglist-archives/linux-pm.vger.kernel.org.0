Return-Path: <linux-pm+bounces-17616-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F349CDCE2
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 11:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C602280D88
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 10:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C03C1B6CEE;
	Fri, 15 Nov 2024 10:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fT8SEvsv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41E91BC07A;
	Fri, 15 Nov 2024 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667273; cv=none; b=SWX00xsvS5Ms8cZ7WRXWsOxsakHvGt4xVLo4Ok83sGdD14o8DIK92LVG4gI8R0TYCRzaar0BYPEfDp9au9O+BqkryZWB66a9rrGvQKjTNrRKrpdY5TB22Ocri8/b7W4i7TmAIYKShWJ0FLjtOUbwabEFf15vG1ZVM30k1z7BK0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667273; c=relaxed/simple;
	bh=oA+Q+7WAHPf8g6s/aUXqPDoEBBRtRoq00ZT/0wWskE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAVDl93Rq+ul+BlrUE82cby2vReALxzmW5M3Hiu5KQrjMN6jH8YKaVH7YrAwIVQ2A2JqtueAXR1MiqTtxG0yfk/jbAdUXSdiOg9Og+8VHDIZLFdvZ1b7tjXkNg8LUs+1UawGBZDtiFXtzjr7FYjocCu2PELEzNh0w/kQrzYaISI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fT8SEvsv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF91kpT023970;
	Fri, 15 Nov 2024 10:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vXyNhkdJwQM6Ee8xzhdUwwTIQ3CtUTzsWkTfYG+vRao=; b=fT8SEvsvsFjHskov
	l/pL+9jmQVESD57hP0DFlcKJK9r2l1e5C/ZEvT/cBMQG1MGtVkJKJe2FFZzBtALp
	Pr1SG8kSLe2eNFowkX2bDV42b2ZL6XFi8GGX1gzHGEPxUMQhXC9IgELIZzEZPQGQ
	AVQW63GbJ4klGRyZIQYwtC8oPJ01lnleVDsODxhceoEDRbbZOE/ZGtXu21poP3Io
	5QXZtIaHTejpHC6bo+9KlP6io1o7KjqBU8QBL96g8T3J/4yl63pd3WU8XpukRXmN
	65lzOPLqxaX68uayXnfnjn8xalzBOXU2hy29jjL6E+HkxgzbqOwgDU1ZsMmTGucB
	XZ5fig==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42x3acga71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:41:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFAf2Cr020078
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:41:02 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 15 Nov 2024 02:40:56 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v8 4/7] arm64: dts: qcom: ipq5332: Add tsens node
Date: Fri, 15 Nov 2024 16:09:54 +0530
Message-ID: <20241115103957.1157495-5-quic_mmanikan@quicinc.com>
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
X-Proofpoint-GUID: LOOoAOoAMjpQUNFsLb_ze9-tH9iDs9_Q
X-Proofpoint-ORIG-GUID: LOOoAOoAMjpQUNFsLb_ze9-tH9iDs9_Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 mlxlogscore=787 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150090

From: Praveenkumar I <quic_ipkumar@quicinc.com>

IPQ5332 has tsens v2.3.3 peripheral. This patch adds the tsens
node with nvmem cells for calibration data.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V8:
	- Rename s11, s12, s13, s14,and s15 to tsens_sens11_off, tsens_sens12_off,
	  tsens_sens13_off, tsens_sens14_off, and tsens_sens15_off respectively.

 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 66 +++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index d3c3e215a15c..d643dafe5846 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -177,6 +177,46 @@ cpu_speed_bin: cpu-speed-bin@1d {
 				reg = <0x1d 0x2>;
 				bits = <7 2>;
 			};
+
+			tsens_sens11_off: s11@3a5 {
+				reg = <0x3a5 0x1>;
+				bits = <4 4>;
+			};
+
+			tsens_sens12_off: s12@3a6 {
+				reg = <0x3a6 0x1>;
+				bits = <0 4>;
+			};
+
+			tsens_sens13_off: s13@3a6 {
+				reg = <0x3a6 0x1>;
+				bits = <4 4>;
+			};
+
+			tsens_sens14_off: s14@3ad {
+				reg = <0x3ad 0x2>;
+				bits = <7 4>;
+			};
+
+			tsens_sens15_off: s15@3ae {
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
+				      <&tsens_sens11_off>,
+				      <&tsens_sens12_off>,
+				      <&tsens_sens13_off>,
+				      <&tsens_sens14_off>,
+				      <&tsens_sens15_off>;
+			nvmem-cell-names = "mode",
+					   "base0",
+					   "base1",
+					   "tsens_sens11_off",
+					   "tsens_sens12_off",
+					   "tsens_sens13_off",
+					   "tsens_sens14_off",
+					   "tsens_sens15_off";
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


