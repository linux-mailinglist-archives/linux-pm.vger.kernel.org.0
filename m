Return-Path: <linux-pm+bounces-16945-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9929BB4F6
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 13:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC59D280F4D
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 12:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5431B85E2;
	Mon,  4 Nov 2024 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dqP+J86r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1059A1632C0;
	Mon,  4 Nov 2024 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724314; cv=none; b=rpYVzXXySpu+bApx4BPqwyblKWXtYSW+bFaFF1awpyZM7YCoFBbpcJBcMxsPngHGJJkUm6AMhtPpzq8b7AplVhEv2qmOAo3GvU4zeKUvwk6k04PxvvusmyNU/Ia7+KjXnjE5BVHSNHtfjVVWHYtkyyRxQYnXEBkJXpo0YScIa+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724314; c=relaxed/simple;
	bh=pjvH9VijHcYq7JbMATDSD45EqXoep6i40aFZ3zUslYM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iLhODwU+MojY3nCHio7KCweM3mapMAx1zulEHWwgNOM3yMYedbTOyhF9deFCLJk4VZ99xjGvFN+chnsrckR2qllbhiQDnxubtGRMcaXfT49Icj+HXs/lZ6AsfEuHbxN8hwyPkcwKWtuuwR0CS26lE1Le9N0sYCfYuZiT15McGaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dqP+J86r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4BuFnI020683;
	Mon, 4 Nov 2024 12:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ofntPASB1WXkjQfzFi93kATJnAvCwncwYT2qGPYkYUI=; b=dqP+J86r8gnmveWh
	NBVDqI94HXVAmHrheiS0cT+6tLC19NvHj0+vAsele20ELtW3SzZnKnv/+bmO9vxr
	0+wDjW/zr75Z3bRwS5KBz40wRYcBAfb6EuivyX8uP8worQOIWErJFEipG/4UMten
	J36goN8kFnmyy8wsBG0dykZ6p0baQ2uV3Qp3b6k/MRLGq1YknTI4f3NzqXCV+IeQ
	N/gHIPENcczFretPoo1qhZquMpnFmsSYHKP3LsW0Ze0oqio3gf8T+vt9Oj2lfhYq
	DURZAlQSa2LednrNv+YKT96PraUDPBxUmpyXhaomDjb6vFtuXy3MHI+v8t9eMGRg
	h95hcw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd2849cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 12:45:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A4Cj1DS014961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Nov 2024 12:45:01 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 4 Nov 2024 04:44:56 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v6 4/7] arm64: dts: qcom: ipq5332: Add tsens node
Date: Mon, 4 Nov 2024 18:14:10 +0530
Message-ID: <20241104124413.2012794-5-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104124413.2012794-1-quic_mmanikan@quicinc.com>
References: <20241104124413.2012794-1-quic_mmanikan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: UISgOxtiewSA6diSTnoEAP9czchF3c3P
X-Proofpoint-GUID: UISgOxtiewSA6diSTnoEAP9czchF3c3P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=832
 clxscore=1015 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040111

From: Praveenkumar I <quic_ipkumar@quicinc.com>

IPQ5332 has tsens v2.3.3 peripheral. This patch adds the tsense
node with nvmem cells for calibration data.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
Changes in V6:
	- No change

 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 66 +++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index d3c3e215a15c..94dca05fdc2a 100644
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
+			reg = <0x4a9000 0x1000>,
+			      <0x4a8000 0x1000>;
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


