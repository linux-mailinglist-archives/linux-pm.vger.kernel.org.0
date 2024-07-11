Return-Path: <linux-pm+bounces-10989-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 364D192E718
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 13:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5EDE2816EB
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 11:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D700416CD3A;
	Thu, 11 Jul 2024 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="adMMNq9U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592FC15F407;
	Thu, 11 Jul 2024 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697604; cv=none; b=FGyhlunQzAvTNYpM7Co4MJLF1JL8dmuKCfFlwvO30e0sBRGmnvjDX79ucWFlhrx8HBdQpgVmf009K3nm37DIxUKyQb+lg/nBioujTuALPuPTntCaq1NgD3SNU8d/U2dEf4EkppZ75IvboVCsSYYuRGeqGklMrQzVNPQpz0TOMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697604; c=relaxed/simple;
	bh=V8PpKGvd8DyuYmIHy7YOTRp1qOgrbB6vlWM+4TKGa5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cul+7sFrb8SlcEq5weYBBvbu6jOW3m9Yw76rRqTBqXq3FcX9mZzHGJ//OIrFOfykCz2aO2MnYLv/3bFoJewI7dncJai1wYAWd8edpSugU8J8OU/BpFJqpd0s4GXqoB++OH4yW1uyDaSU6JjlGwKoOdF3qQNEtnZiS/VksIAWlnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=adMMNq9U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B4ndXD021870;
	Thu, 11 Jul 2024 11:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MtMoVviX81IClTs7nn8uR+E++UymYIJefIjPRcxroV4=; b=adMMNq9UEp0s0FX0
	8DjIl3Sm/gwS2gIHj0gdLUbnX6Duoh5143/4X69z/K5Lj9mCA+ydwuxeLXLw+bqH
	nfaslmQBGt/wCHF04hVt5CJ3A3M6qMDys8hEfz/+MkdPSC2G4Es7DpuDzqB1x7m2
	/KqRs/371OLkrU/m6T8TC9cZoCQ0/lnZ9tKNQbszLTx64RvqUYRwDddFeyEgHip4
	HQbHI2gJIyqAxMLme3er1A801AMCZRD+2RaKTamT4i+ZlsGcWUQHgbcbOMF33Ym8
	gSJ9V11LBfdbpclqOdtrkAGiFZXDTFJqqUjZWVIMaIDP1S1FmuNXMBm0hezykHqP
	GGMaGQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wmmvc4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 11:33:18 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46BBXH2Y018613
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 11:33:17 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 11 Jul 2024 04:33:12 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <konrad.dybcio@linaro.org>,
        <djakov@kernel.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v2 4/4] arm64: dts: qcom: ipq5332: Add icc provider ability to gcc
Date: Thu, 11 Jul 2024 17:02:39 +0530
Message-ID: <20240711113239.3063546-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711113239.3063546-1-quic_varada@quicinc.com>
References: <20240711113239.3063546-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: LruPSK25B0FPTkRehdQHBUI0oVG3hAFB
X-Proofpoint-ORIG-GUID: LruPSK25B0FPTkRehdQHBUI0oVG3hAFB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_06,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110082

IPQ SoCs dont involve RPM in managing NoC related clocks and
there is no NoC scaling. Linux itself handles these clocks.
However, these should not be exposed as just clocks and align
with other Qualcomm SoCs that handle these clocks from a
interconnect provider.

Hence include icc provider capability to the gcc node so that
peripherals can use the interconnect facility to enable these
clocks. Change USB to use the icc-clk framework for the iface
clock.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 573656587c0d..f58fd70be826 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/qcom,apss-ipq.h>
 #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interconnect/qcom,ipq5332.h>
 
 / {
 	interrupt-parent = <&intc>;
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


