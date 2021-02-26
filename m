Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9064326804
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 21:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhBZUJI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 15:09:08 -0500
Received: from m-r1.th.seeweb.it ([5.144.164.170]:43123 "EHLO
        m-r1.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhBZUI2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 15:08:28 -0500
Received: from localhost.localdomain (abab236.neoplus.adsl.tpnet.pl [83.6.165.236])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id C04681FED3;
        Fri, 26 Feb 2021 21:06:49 +0100 (CET)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 30/41] arm64: dts: qcom: sdm630-xperia-nile: Add all RPM and fixed regulators
Date:   Fri, 26 Feb 2021 21:04:00 +0100
Message-Id: <20210226200414.167762-31-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226200414.167762-1-konrad.dybcio@somainline.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Add all of the RPM PM660/PM660L regulators and the fixed ones,
defining the common electrical part of this platform.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../dts/qcom/sdm630-sony-xperia-nile.dtsi     | 395 +++++++++++++++++-
 1 file changed, 394 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
index 9ba359c848d0..b7f3da0d72e7 100644
--- a/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630-sony-xperia-nile.dtsi
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: BSD-3-Clause
 /*
- * Copyright (c) 2020, Konrad Dybcio
+ * Copyright (c) 2020, Konrad Dybcio <konrad.dybcio@somainline.org>
+ * Copyright (c) 2020, AngeloGioacchino Del Regno
+ *                     <angelogioacchino.delregno@somainline.org>
  */
 
 /dts-v1/;
@@ -39,6 +41,55 @@ framebuffer0: framebuffer@9d400000 {
 		};
 	};
 
+	board_vbat: vbat-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VBAT";
+
+		regulator-min-microvolt = <4000000>;
+		regulator-max-microvolt = <4000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	cam_vdig_imx300_219_vreg: cam_vdig_imx300_219_vreg {
+		compatible = "regulator-fixed";
+		regulator-name = "cam_vdig_imx300_219_vreg";
+		startup-delay-us = <0>;
+		enable-active-high;
+		gpio = <&tlmm 52 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cam_vdig_default>;
+	};
+
+	cam_vana_front_vreg: cam_vana_front_vreg {
+		compatible = "regulator-fixed";
+		regulator-name = "cam_vana_front_vreg";
+		startup-delay-us = <0>;
+		enable-active-high;
+		gpio = <&tlmm 51 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&imx219_vana_default>;
+	};
+
+	cam_vana_rear_vreg: cam_vana_rear_vreg {
+		compatible = "regulator-fixed";
+		regulator-name = "cam_vana_rear_vreg";
+		startup-delay-us = <0>;
+		enable-active-high;
+		gpio = <&tlmm 50 GPIO_ACTIVE_HIGH>;
+		regulator-always-on;
+		pinctrl-names = "default";
+		pinctrl-0 = <&imx300_vana_default>;
+	};
+
 	gpio_keys {
 		status = "okay";
 		compatible = "gpio-keys";
@@ -134,3 +185,345 @@ i2c@c1b6000 {
 		};
 	};
 };
+
+&rpm_requests {
+	pm660l-regulators {
+		compatible = "qcom,rpm-pm660l-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3_s4-supply = <&vph_pwr>;
+		vdd_s5-supply = <&vph_pwr>;
+		vdd_s6-supply = <&vph_pwr>;
+
+		vdd_l1_l9_l10-supply = <&vreg_s2b_1p05>;
+		vdd_l2-supply = <&vreg_bob>;
+		vdd_l3_l5_l7_l8-supply = <&vreg_bob>;
+		vdd_l4_l6-supply = <&vreg_bob>;
+		vdd_bob-supply = <&vph_pwr>;
+
+		vreg_s1b_1p125: s1 {
+			regulator-min-microvolt = <1125000>;
+			regulator-max-microvolt = <1125000>;
+			regulator-enable-ramp-delay = <200>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_s2b_1p05: s2 {
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1050000>;
+			regulator-enable-ramp-delay = <200>;
+			regulator-ramp-delay = <0>;
+		};
+
+		/*
+		 * At least on Nile's configuration, S3B/S4B (VDD_CX) and
+		 * S5B (VDD_MX) are managed only through RPM Power Domains.
+		 * Trying to set a voltage on the main supply will create
+		 * havoc and freeze the SoC.
+		 * In any case, reference voltages for these regulators are:
+		 * S3B/S4B: 0.870V
+		 * S5B: 0.915V
+		 */
+
+		/* LDOs */
+		vreg_l1b_0p925: l1 {
+			regulator-min-microvolt = <920000>;
+			regulator-max-microvolt = <928000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l2b_2p95: l2 {
+			/*
+			 * This regulator supports 1.648 - 3.104V on this board
+			 * but we set a max voltage of anything less than 2.7V
+			 * to satisfy a condition in sdhci.c that will disable
+			 * 3.3V SDHCI signaling, which happens to be not really
+			 * supported on the Xperia Nile/Ganges platform.
+			 */
+			regulator-min-microvolt = <1648000>;
+			regulator-max-microvolt = <2696000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l3b_3p0: l3 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-min-microamp = <200>;
+			regulator-max-microamp = <600000>;
+			regulator-system-load = <100000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l4b_29p5: l4 {
+			regulator-min-microvolt = <2944000>;
+			regulator-max-microvolt = <2952000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+
+			regulator-min-microamp = <200>;
+			regulator-max-microamp = <600000>;
+			regulator-system-load = <570000>;
+			regulator-allow-set-load;
+		};
+
+		/*
+		 * Downstream specifies a range of 1721-3600mV,
+		 * but the only assigned consumers are SDHCI2 VMMC
+		 * and Coresight QPDI that both request pinned 2.95V.
+		 * Tighten the range to 1.8-3.328 (closest to 3.3) to
+		 * make the mmc driver happy.
+		 */
+		vreg_l5b_29p5: l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3328000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l6b_3p3: l6 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_l7b_3p125: l7 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <3128000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_l8b_3p3: l8 {
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3400000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		/* L9B (870mV) is currently unused */
+		/* L10B (915mV) is currently unused */
+
+		vreg_bob: bob {
+			regulator-min-microvolt = <3304000>;
+			regulator-max-microvolt = <3624000>;
+			regulator-enable-ramp-delay = <500>;
+			regulator-ramp-delay = <0>;
+		};
+	};
+
+	pm660-regulators {
+		compatible = "qcom,rpm-pm660-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_s4-supply = <&vph_pwr>;
+		vdd_s5-supply = <&vph_pwr>;
+		vdd_s6-supply = <&vph_pwr>;
+
+		vdd_l1_l6_l7-supply = <&vreg_s5a_1p35>;
+		vdd_l2_l3-supply = <&vreg_s2b_1p05>;
+		vdd_l5-supply = <&vreg_s2b_1p05>;
+		vdd_l8_l9_l10_l11_l12_l13_l14-supply = <&vreg_s4a_2p04>;
+		vdd_l15_l16_l17_l18_l19-supply = <&vreg_bob>;
+
+		/*
+		 * S1A (FTAPC0), S2A (FTAPC1), S3A (HFAPC1) are managed
+		 * by the Core Power Reduction hardened (CPRh) and the
+		 * Operating State Manager (OSM) HW automatically.
+		 */
+
+		vreg_s4a_2p04: s4 {
+			regulator-min-microvolt = <2040000>;
+			regulator-max-microvolt = <2040000>;
+			regulator-enable-ramp-delay = <200>;
+			regulator-ramp-delay = <0>;
+			regulator-always-on;
+		};
+
+		vreg_s5a_1p35: s5 {
+			regulator-min-microvolt = <1224000>;
+			regulator-max-microvolt = <1350000>;
+			regulator-enable-ramp-delay = <200>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_s6a_0p87: s6 {
+			regulator-min-microvolt = <504000>;
+			regulator-max-microvolt = <992000>;
+			regulator-enable-ramp-delay = <150>;
+			regulator-ramp-delay = <0>;
+		};
+
+		/* LDOs */
+		vreg_l1a_1p225: l1 {
+			regulator-min-microvolt = <1226000>;
+			regulator-max-microvolt = <1250000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l2a_1p0: l2 {
+			regulator-min-microvolt = <944000>;
+			regulator-max-microvolt = <1008000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_l3a_1p0: l3 {
+			regulator-min-microvolt = <944000>;
+			regulator-max-microvolt = <1008000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_l5a_0p848: l5 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <952000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_l6a_1p3: l6 {
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1368000>;
+			regulator-allow-set-load;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_l7a_1p2: l7 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_l8a_1p8: l8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-system-load = <325000>;
+			regulator-allow-set-load;
+		};
+
+
+		vreg_l9a_1p8: l9 {
+			regulator-min-microvolt = <1804000>;
+			regulator-max-microvolt = <1896000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l10a_1p8: l10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1944000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l11a_1p8: l11 {
+			regulator-min-microvolt = <1784000>;
+			regulator-max-microvolt = <1944000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_l12a_1p8: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1944000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		/* This gives power to the LPDDR4: never turn it off! */
+		vreg_l13a_1p8: l13 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1944000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
+		vreg_l14a_1p8: l14 {
+			regulator-min-microvolt = <1710000>;
+			regulator-max-microvolt = <1904000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_l15a_1p8: l15 {
+			regulator-min-microvolt = <1648000>;
+			regulator-max-microvolt = <2952000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		/* L16A (2.70V) is unused */
+
+		vreg_l17a_1p8: l17 {
+			regulator-min-microvolt = <1648000>;
+			regulator-max-microvolt = <2952000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+		};
+
+		vreg_l18a_1v8: l18 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <10>;
+			regulator-min-microamp = <200>;
+			regulator-max-microamp = <50000>;
+			regulator-system-load = <10000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l19a_3p3: l19 {
+			regulator-min-microvolt = <3312000>;
+			regulator-max-microvolt = <3400000>;
+			regulator-enable-ramp-delay = <250>;
+			regulator-ramp-delay = <0>;
+			regulator-allow-set-load;
+		};
+	};
+};
+
+&tlmm {
+	gpio-reserved-ranges = <8 4>;
+
+	imx300_vana_default: imx300-vana-default {
+		pins = "gpio50";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
+	};
+
+	imx219_vana_default: imx219-vana-default {
+		pins = "gpio51";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
+	};
+
+	cam_vdig_default: cam-vdig-default {
+		pins = "gpio52";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
+	};
+};
-- 
2.30.1

