Return-Path: <linux-pm+bounces-11626-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F3C9407E0
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 07:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05594283C7E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 05:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEF119007E;
	Tue, 30 Jul 2024 05:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jzCFVLGh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BFB169AE6;
	Tue, 30 Jul 2024 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722318551; cv=none; b=s0cfqP1Q/geHIGdIyLbIrUSUTYPs7vo9GF8mtG9ue3MmWsgCSWDKd5/eWZ94Dp0hyK0pRkfOLXFqU8hwK2Btlbc+TE00h/hAIEku27BhCA8Jo1nYIoMFA6Doefm6fiKjWOPdOD42PK7PixnVWboHeSn2X4xi/wYAW6vmFSmR67M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722318551; c=relaxed/simple;
	bh=VgiJR7kEM+cnGMiBj+lSW8qPAhtGTOoj5UWbY5zfUyI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxYzq5P1Rum18xxXJMO487qwUN+6GdKdd7aCjQs2/IoIxXLz4qPJ7k/wrYJZJoJC2dHDeCAyrzJg4L+SE4Y6DPdiN1ZWGtZ+hB/oaeWn8OEZ2cdHuldJkLwOy2vClbDhNytE/XHF+jpJHPMDnhUs9mpoARMm0o4i9lCmNWIm0hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jzCFVLGh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TNaRqQ022117;
	Tue, 30 Jul 2024 05:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9ifLbZTRgpqGEv2r30ppykhhVp36eH3TXwx0BaaMj7o=; b=jzCFVLGhPliU7z+D
	SyCVGfM9DuGjYbScMmtugN8NlCSgFPM7yHHk5WNpZr1SVwKCAtasqjLXv/7uL6Al
	9L9ZKNS6GLDA0oZ93TM7C8rU+Is2YrN8m31hWEXRQW86f3oTl2/2NpynADBU+aHF
	ySHlJR8NaCEhRFlZ36z4pIYQt28dycgHepBL6+fKaCRT6EBoetJ295Fr6EcgesFC
	+06adfzaA9DKc4J10wEHi2hbVCwprI4i3n7xegN6Sg56ZesY+xxl9ck7PF190R+c
	/VMg4tJu/T8o+zwp2ukTE0G9/zL1xlj2jNe+NnijAD5V0fSDz/DMuF3xps1012uR
	eIEP0A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mp8mxjjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 05:49:05 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46U5n4AI024209
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 05:49:04 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Jul 2024 22:48:58 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <quic_wcheng@quicinc.com>,
        <quic_kathirav@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v6 5/5] arm64: dts: qcom: ipq5332: Add icc provider ability to gcc
Date: Tue, 30 Jul 2024 11:18:17 +0530
Message-ID: <20240730054817.1915652-6-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730054817.1915652-1-quic_varada@quicinc.com>
References: <20240730054817.1915652-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HFUttdHwRQjPoYf0Kf1JR5C6O2vw1nhf
X-Proofpoint-ORIG-GUID: HFUttdHwRQjPoYf0Kf1JR5C6O2vw1nhf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_05,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300042

IPQ SoCs dont involve RPM in managing NoC related clocks and
there is no NoC scaling. Linux itself handles these clocks.
However, these should not be exposed as just clocks and align
with other Qualcomm SoCs that handle these clocks from a
interconnect provider.

Hence include icc provider capability to the gcc node so that
peripherals can use the interconnect facility to enable these
clocks. Change USB to use the icc-clk framework for the iface
clock.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v3: Fix #include file order
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 573656587c0d..7e8f9d578382 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/clock/qcom,apss-ipq.h>
 #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
+#include <dt-bindings/interconnect/qcom,ipq5332.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
@@ -208,6 +209,7 @@ gcc: clock-controller@1800000 {
 			reg = <0x01800000 0x80000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			#interconnect-cells = <1>;
 			clocks = <&xo_board>,
 				 <&sleep_clk>,
 				 <0>,
@@ -327,11 +329,9 @@ usb: usb@8af8800 {
 					  "dm_hs_phy_irq";
 
 			clocks = <&gcc GCC_USB0_MASTER_CLK>,
-				 <&gcc GCC_SNOC_USB_CLK>,
 				 <&gcc GCC_USB0_SLEEP_CLK>,
 				 <&gcc GCC_USB0_MOCK_UTMI_CLK>;
 			clock-names = "core",
-				      "iface",
 				      "sleep",
 				      "mock_utmi";
 
@@ -342,6 +342,9 @@ usb: usb@8af8800 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			interconnects = <&gcc MASTER_SNOC_USB &gcc SLAVE_SNOC_USB>,
+					<&gcc MASTER_SNOC_USB &gcc SLAVE_SNOC_USB>;
+			interconnect-names = "usb-ddr", "apps-usb";
 
 			status = "disabled";
 
-- 
2.34.1


