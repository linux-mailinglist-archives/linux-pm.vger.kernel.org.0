Return-Path: <linux-pm+bounces-18145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E372E9DA736
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 12:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6973BB23822
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 11:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA531F9AB9;
	Wed, 27 Nov 2024 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nCaST0KG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A30A1917F1;
	Wed, 27 Nov 2024 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708303; cv=none; b=NOtQvqchG+eo03T/iXY7GfATST1Eq1IHI2R53ocpDSFMLY+fxkSEpsSHpg4uugdm3PLgpOpWzUGjjxFBcdww3B8uB4oeJKmBdI/dji0MrInTyrGvsRBojEgLZQ2wj6Cj8xqRjWjrM4ZO2kFmCUufSqI+LYOJnNcKLSBVhiWIpkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708303; c=relaxed/simple;
	bh=XNcjXJ2Ie3hLm11kDF+lzwds13RJcEg/X9oUNaxCuA4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDxKd1jZp3zgLnXWWA6pAAELQeJGsHuFGV5iJDOaGq4ifwKyVRSAAhUi2qPukWG0d+lZ/vAVg2+YNvL0/6BZJnobRZiA7sJ8U7vJ7A//QeuBiqA2Oj/AwPZ6Wh4/LkPAjUTNW9aaKgQJg4/xxNZJWCCfwcxxwER6MEIujTSwjVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nCaST0KG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ARAg0EL017247;
	Wed, 27 Nov 2024 11:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Y225L4jROYRtJ/8StcLSyEnT
	M0rYsgkVn5k3JdinNow=; b=nCaST0KGZaw4mQWfJ4B6Qo/82OHlO1HxIt05DzPQ
	2e25YBEXsloSs38bI6o7iofL3Av3GaMYTOWQgsD3Y/ZZIc6F4uIjDmg6oiI0C6d9
	iTtJ0W4YJzAkI7RHlwHDIhzpLnuZilA1do1GSaqkpxn1+atbtWhQQ1C8qu0Izte7
	ygzK592mp1f7TpDFr9WzyxxorsYuhU/Ncat/Eo8lzXvB1vgIIKIqD6zjxa2t5zZU
	ppLErw28FC8IQ5/Z8paHHAoPhZWcGhHJSj1FG9qwg2AFt1W5EJ9Q7fM5V03viJ1c
	OOgmlDtzO5q8slBX0AcRJzERs+PkEwIxLrS9HRon21z8TA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4361wcg7a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 11:51:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ARBpX2n016589
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 11:51:33 GMT
Received: from hu-janathot-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 27 Nov 2024 03:51:27 -0800
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
Subject: [PATCH v4 1/2] arm64: dts: qcom: qcs6490-rb3gen2: enable Bluetooth
Date: Wed, 27 Nov 2024 17:21:06 +0530
Message-ID: <20241127115107.11549-2-quic_janathot@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241127115107.11549-1-quic_janathot@quicinc.com>
References: <20241127115107.11549-1-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 57l9K9AT0lbqxZU56J0-rbRHxXXduAbj
X-Proofpoint-ORIG-GUID: 57l9K9AT0lbqxZU56J0-rbRHxXXduAbj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 clxscore=1011 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411270097

Add a PMU node for the WCN6750 module present on the qcs6490-rb3gen board
and use the power sequencer for the same.

Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 174 ++++++++++++++++++-
 drivers/bluetooth/hci_qca.c                  |   2 +-
 drivers/power/sequencing/pwrseq-qcom-wcn.c   |  22 +++
 3 files changed, 196 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 27695bd54220..6807bf347241 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause
 /*
- * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 /dts-v1/;
@@ -32,7 +32,9 @@
 	chassis-type = "embedded";
 
 	aliases {
+		bluetooth0 = &bluetooth;
 		serial0 = &uart5;
+		serial1 = &uart7;
 	};
 
 	chosen {
@@ -217,6 +219,64 @@
 		regulator-min-microvolt = <3700000>;
 		regulator-max-microvolt = <3700000>;
 	};
+
+	 wcn6750-pmu {
+		compatible = "qcom,wcn6750-pmu";
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_en>, <&sw_ctrl>;
+		vddaon-supply = <&vreg_s7b_0p972>;
+		vddasd-supply = <&vreg_l11c_2p8>;
+		vddpmu-supply = <&vreg_s7b_0p972>;
+		vddrfa0p8-supply = <&vreg_s7b_0p972>;
+		vddrfa1p2-supply = <&vreg_s8b_1p272>;
+		vddrfa1p7-supply = <&vreg_s1b_1p872>;
+		vddrfa2p2-supply = <&vreg_s1c_2p19>;
+
+		bt-enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
+		wlan-enable-gpios = <&tlmm 86 GPIO_ACTIVE_HIGH>;
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
@@ -758,6 +818,39 @@
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
@@ -801,12 +894,91 @@
 &tlmm {
 	gpio-reserved-ranges = <32 2>, /* ADSP */
 			       <48 4>; /* NFC */
+	bt_en: bt-en-state {
+		pins = "gpio85";
+		function = "gpio";
+		output-low;
+		bias-disable;
+	};
+
+	qup_uart7_sleep_cts: qup-uart7-sleep-cts-state {
+		pins = "gpio28";
+		function = "gpio";
+		/*
+		 * Configure a bias-bus-hold on CTS to lower power
+		 * usage when Bluetooth is turned off. Bus hold will
+		 * maintain a low power state regardless of whether
+		 * the Bluetooth module drives the pin in either
+		 * direction or leaves the pin fully unpowered.
+		 */
+		bias-bus-hold;
+	};
+
+	qup_uart7_sleep_rts: qup-uart7-sleep-rts-state {
+		pins = "gpio29";
+		function = "gpio";
+		/*
+		 * Configure pull-down on RTS. As RTS is active low
+		 * signal, pull it low to indicate the BT SoC that it
+		 * can wakeup the system anytime from suspend state by
+		 * pulling RX low (by sending wakeup bytes).
+		 */
+		bias-pull-down;
+	};
+
+	qup_uart7_sleep_rx: qup-uart7-sleep-rx-state {
+		pins = "gpio31";
+		function = "gpio";
+		/*
+		 * Configure a pull-up on RX. This is needed to avoid
+		 * garbage data when the TX pin of the Bluetooth module
+		 * is floating which may cause spurious wakeups.
+		 */
+		bias-pull-up;
+	};
+
+	qup_uart7_sleep_tx: qup-uart7-sleep-tx-state {
+		pins = "gpio30";
+		function = "gpio";
+		/*
+		 * Configure pull-up on TX when it isn't actively driven
+		 * to prevent BT SoC from receiving garbage during sleep.
+		 */
+		bias-pull-up;
+	};
+
+	sw_ctrl: sw-ctrl-state {
+		pins = "gpio86";
+		function = "gpio";
+		bias-pull-down;
+	};
 };
 
 &uart5 {
 	status = "okay";
 };
 
+&uart7 {
+	status = "okay";
+	/delete-property/interrupts;
+	interrupts-extended = <&intc GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>,
+				<&tlmm 31 IRQ_TYPE_EDGE_FALLING>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-1 = <&qup_uart7_sleep_cts>, <&qup_uart7_sleep_rts>,
+			<&qup_uart7_sleep_tx>, <&qup_uart7_sleep_rx>;
+
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
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 37129e6cb0eb..fbf8840fa534 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2346,6 +2346,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_WCN6750:
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*
 			 * Backward compatibility with old DT sources. If the
@@ -2365,7 +2366,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN3990:
 	case QCA_WCN3991:
 	case QCA_WCN3998:
-	case QCA_WCN6750:
 		qcadev->bt_power->dev = &serdev->dev;
 		err = qca_init_regulators(qcadev->bt_power, data->vregs,
 					  data->num_vregs);
diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index 682a9beac69e..e38da79f0ada 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -293,6 +293,24 @@ static const struct pwrseq_qcom_wcn_pdata pwrseq_wcn6855_of_data = {
 	.targets = pwrseq_qcom_wcn6855_targets,
 };
 
+static const char *const pwrseq_wcn6750_vregs[] = {
+	"vddaon",
+	"vddasd",
+	"vddpmu",
+	"vddrfa0p8",
+	"vddrfa1p2",
+	"vddrfa1p7",
+	"vddrfa2p2",
+};
+
+static const struct pwrseq_qcom_wcn_pdata pwrseq_wcn6750_of_data = {
+	.vregs = pwrseq_wcn6750_vregs,
+	.num_vregs = ARRAY_SIZE(pwrseq_wcn6750_vregs),
+	.pwup_delay_ms = 50,
+	.gpio_enable_delay_ms = 5,
+	.targets = pwrseq_qcom_wcn_targets,
+};
+
 static const char *const pwrseq_wcn7850_vregs[] = {
 	"vdd",
 	"vddio",
@@ -431,6 +449,10 @@ static const struct of_device_id pwrseq_qcom_wcn_of_match[] = {
 		.compatible = "qcom,wcn7850-pmu",
 		.data = &pwrseq_wcn7850_of_data,
 	},
+	{
+		.compatible = "qcom,wcn6750-pmu",
+		.data = &pwrseq_wcn6750_of_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pwrseq_qcom_wcn_of_match);
-- 

