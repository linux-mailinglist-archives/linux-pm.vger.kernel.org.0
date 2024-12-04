Return-Path: <linux-pm+bounces-18535-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5539E3B07
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 14:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D586166690
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 13:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4D81C0DF0;
	Wed,  4 Dec 2024 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aYLQL1LN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBA81BF804;
	Wed,  4 Dec 2024 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318269; cv=none; b=MaSKcogKEc0NSxCwcjCIqIL5f1/aqbpJ1lqurUL1Y6+ou/Y4BJYtU268CTtuKZeocXk83tebgUg1Kp0RdrvT0G3Bk9zdVtWCV/QHvRQLXreCAeBVVb9UUhpO/jgFsYz77aYb+6/aUrtJNjjb/s6DoRf0NBKWJ1E8+/T7z/mcgYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318269; c=relaxed/simple;
	bh=2sIl4hUKsGpsSrhOxEbQIR9sPIT+vh76PGVbhBJExds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9SwISS0bBpUYHGZP9JAgFMeOfe+e86iC49AXz9+SiGSWdyHbubESuFoge13g8278ckIPw93vOtb9QDGbz5m55SdYxV+cMtUBJcCDfKzNbwsN+cJPk0d+wHjn3BkzBH4Wv7WZsPxLsVW2In/gMqa8aFjeilhWYcvDqlVKvFkwrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aYLQL1LN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B43dRvJ031913;
	Wed, 4 Dec 2024 13:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qGpqctIihI63F5+LNGBGfHp/
	mrOxpfxfL6CeofKj2K0=; b=aYLQL1LN++dy+M4cSLDI/EyNLd6djA9iDqXbo6+v
	9oWY40UloP1WtMM6URy1MS1+7dI9RDUiECx1s8+q+d148Txy2cYx0m7Zt9hhK/iO
	oSIRGpIrGQErcyJDUQJiZYWRaRmS7IjlO5f/Iqierdm3cbHNwp3aIGE0u1Q9ieNN
	w1Kaf5uJF2znEolE1suqp64JP9c5JXJJi/RZx9zVRlbrDeBOaKgh3LuRHiskAK+V
	0/K3Qg07qg6Fgp019Xv8tDiFsQooH/g9ld/p/qu9aHJWfp+lmfZaDX3sOY7f8x4C
	cido0mkHjtubIPuF3H606CT0Sz/b1SEhNBUSDBadjtP6VQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439trbmrgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 13:17:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B4DHd4g027512
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Dec 2024 13:17:39 GMT
Received: from hu-janathot-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Dec 2024 05:17:33 -0800
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konradybcio@kernel.org>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC: <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>,
        <quic_anubhavg@quicinc.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH v4 2/4] arm64: dts: qcom: qcs6490-rb3gen: add and enable BT node
Date: Wed, 4 Dec 2024 18:47:04 +0530
Message-ID: <20241204131706.20791-3-quic_janathot@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241204131706.20791-1-quic_janathot@quicinc.com>
References: <20241204131706.20791-1-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9oWHS-9wMXLsOsFUP7vAaFUjpncYfYty
X-Proofpoint-ORIG-GUID: 9oWHS-9wMXLsOsFUP7vAaFUjpncYfYty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412040102

Add a node for the PMU module of the WCN6750 present on the
qcs6490-rb3gen board and assign its power outputs to the Bluetooth
module.

Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 165 ++++++++++++++++++-
 1 file changed, 164 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 27695bd54220..07650648214e 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause
 /*
- * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 /dts-v1/;
@@ -33,6 +33,7 @@
 
 	aliases {
 		serial0 = &uart5;
+		serial1 = &uart7;
 	};
 
 	chosen {
@@ -217,6 +218,63 @@
 		regulator-min-microvolt = <3700000>;
 		regulator-max-microvolt = <3700000>;
 	};
+
+	wcn6750-pmu {
+		compatible = "qcom,wcn6750-pmu";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_en>;
+		vddaon-supply = <&vreg_s7b_0p972>;
+		vddasd-supply = <&vreg_l11c_2p8>;
+		vddpmu-supply = <&vreg_s7b_0p972>;
+		vddrfa0p8-supply = <&vreg_s7b_0p972>;
+		vddrfa1p2-supply = <&vreg_s8b_1p272>;
+		vddrfa1p7-supply = <&vreg_s1b_1p872>;
+		vddrfa2p2-supply = <&vreg_s1c_2p19>;
+
+		bt-enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
+
+		regulators {
+			vreg_pmu_rfa_cmn: ldo0 {
+				regulator-name = "vreg_pmu_rfa_cmn";
+			};
+
+			vreg_pmu_aon_0p59: ldo1 {
+				regulator-name = "vreg_pmu_aon_0p59";
+			};
+
+			vreg_pmu_wlcx_0p8: ldo2 {
+				regulator-name = "vreg_pmu_wlcx_0p8";
+			};
+
+			vreg_pmu_wlmx_0p85: ldo3 {
+				regulator-name = "vreg_pmu_wlmx_0p85";
+			};
+
+			vreg_pmu_btcmx_0p85: ldo4 {
+				regulator-name = "vreg_pmu_btcmx_0p85";
+			};
+
+			vreg_pmu_rfa_0p8: ldo5 {
+				regulator-name = "vreg_pmu_rfa_0p8";
+			};
+
+			vreg_pmu_rfa_1p2: ldo6 {
+				regulator-name = "vreg_pmu_rfa_1p2";
+			};
+
+			vreg_pmu_rfa_1p7: ldo7 {
+				regulator-name = "vreg_pmu_rfa_1p7";
+			};
+
+			vreg_pmu_pcie_0p9: ldo8 {
+				regulator-name = "vreg_pmu_pcie_0p9";
+			};
+
+			vreg_pmu_pcie_1p8: ldo9 {
+				regulator-name = "vreg_pmu_pcie_1p8";
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -758,6 +816,39 @@
 	status = "okay";
 };
 
+&qup_uart7_cts {
+	/*
+	 * Configure a bias-bus-hold on CTS to lower power
+	 * usage when Bluetooth is turned off. Bus hold will
+	 * maintain a low power state regardless of whether
+	 * the Bluetooth module drives the pin in either
+	 * direction or leaves the pin fully unpowered.
+	 */
+	bias-bus-hold;
+};
+
+&qup_uart7_rts {
+	/* We'll drive RTS, so no pull */
+	drive-strength = <2>;
+	bias-disable;
+};
+
+&qup_uart7_rx {
+	/*
+	 * Configure a pull-up on RX. This is needed to avoid
+	 * garbage data when the TX pin of the Bluetooth module is
+	 * in tri-state (module powered off or not driving the
+	 * signal yet).
+	 */
+	bias-pull-up;
+};
+
+&qup_uart7_tx {
+	/* We'll drive TX, so no pull */
+	drive-strength = <2>;
+	bias-disable;
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -801,12 +892,84 @@
 &tlmm {
 	gpio-reserved-ranges = <32 2>, /* ADSP */
 			       <48 4>; /* NFC */
+	bt_en: bt-en-state {
+		pins = "gpio85";
+		function = "gpio";
+		output-low;
+		bias-disable;
+	};
+	qup_uart7_sleep: qup_uart7_sleep {
+		qup_uart7_sleep_cts: qup-uart7-sleep-cts-state {
+			pins = "gpio28";
+			function = "gpio";
+			/*
+			 * Configure a bias-bus-hold on CTS to lower power
+			 * usage when Bluetooth is turned off. Bus hold will
+			 * maintain a low power state regardless of whether
+			 * the Bluetooth module drives the pin in either
+			 * direction or leaves the pin fully unpowered.
+			 */
+			bias-bus-hold;
+		};
+
+		qup_uart7_sleep_rts: qup-uart7-sleep-rts-state {
+			pins = "gpio29";
+			function = "gpio";
+			/*
+			 * Configure pull-down on RTS. As RTS is active low
+			 * signal, pull it low to indicate the BT SoC that it
+			 * can wakeup the system anytime from suspend state by
+			 * pulling RX low (by sending wakeup bytes).
+			 */
+			bias-pull-down;
+		};
+
+		qup_uart7_sleep_rx: qup-uart7-sleep-rx-state {
+			pins = "gpio31";
+			function = "gpio";
+			/*
+			 * Configure a pull-up on RX. This is needed to avoid
+			 * garbage data when the TX pin of the Bluetooth module
+			 * is floating which may cause spurious wakeups.
+			 */
+			bias-pull-up;
+		};
+
+		qup_uart7_sleep_tx: qup-uart7-sleep-tx-state {
+			pins = "gpio30";
+			function = "gpio";
+			/*
+			 * Configure pull-up on TX when it isn't actively driven
+			 * to prevent BT SoC from receiving garbage during sleep.
+			 */
+			bias-pull-up;
+		};
+	};
 };
 
 &uart5 {
 	status = "okay";
 };
 
+&uart7 {
+	/delete-property/interrupts;
+	interrupts-extended = <&intc GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>,
+				<&tlmm 31 IRQ_TYPE_EDGE_FALLING>;
+	pinctrl-1 = <&qup_uart7_sleep>;
+	pinctrl-names = "default", "sleep";
+	status = "okay";
+	bluetooth: bluetooth {
+		compatible = "qcom,wcn6750-bt";
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		max-speed = <3200000>;
+	};
+};
+
 &usb_1 {
 	status = "okay";
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


