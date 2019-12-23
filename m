Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA36129659
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2019 14:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfLWNQu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Dec 2019 08:16:50 -0500
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:64670 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726798AbfLWNQt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2019 08:16:49 -0500
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 23 Dec 2019 18:45:12 +0530
Received: from c-rkambl-linux1.qualcomm.com ([10.242.50.190])
  by ironmsg01-blr.qualcomm.com with ESMTP; 23 Dec 2019 18:44:48 +0530
Received: by c-rkambl-linux1.qualcomm.com (Postfix, from userid 2344811)
        id E6151121E; Mon, 23 Dec 2019 18:44:46 +0530 (IST)
From:   Rajeshwari <rkambl@codeaurora.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanm@codeaurora.org, sivaa@codeaurora.org, manafm@codeaurora.org,
        Rajeshwari <rkambl@codeaurora.org>
Subject: [PATCH 1/2] arm64: dts: qcom: sc7180:  Add critical interrupt and cooling maps for TSENS in SC7180.
Date:   Mon, 23 Dec 2019 18:44:30 +0530
Message-Id: <1577106871-19863-2-git-send-email-rkambl@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577106871-19863-1-git-send-email-rkambl@codeaurora.org>
References: <1577106871-19863-1-git-send-email-rkambl@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Rajeshwari <rkambl@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 289 +++++++++++++++++++++++++++++------
 1 file changed, 239 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 3676bfd..e419ca0 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -78,6 +79,7 @@
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_0: l2-cache {
 				compatible = "cache";
@@ -94,6 +96,7 @@
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_100>;
+			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_100: l2-cache {
 				compatible = "cache";
@@ -107,6 +110,7 @@
 			reg = <0x0 0x200>;
 			enable-method = "psci";
 			next-level-cache = <&L2_200>;
+			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_200: l2-cache {
 				compatible = "cache";
@@ -120,6 +124,7 @@
 			reg = <0x0 0x300>;
 			enable-method = "psci";
 			next-level-cache = <&L2_300>;
+			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_300: l2-cache {
 				compatible = "cache";
@@ -133,6 +138,7 @@
 			reg = <0x0 0x400>;
 			enable-method = "psci";
 			next-level-cache = <&L2_400>;
+			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_400: l2-cache {
 				compatible = "cache";
@@ -146,6 +152,7 @@
 			reg = <0x0 0x500>;
 			enable-method = "psci";
 			next-level-cache = <&L2_500>;
+			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			L2_500: l2-cache {
 				compatible = "cache";
@@ -159,6 +166,7 @@
 			reg = <0x0 0x600>;
 			enable-method = "psci";
 			next-level-cache = <&L2_600>;
+			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_600: l2-cache {
 				compatible = "cache";
@@ -172,6 +180,7 @@
 			reg = <0x0 0x700>;
 			enable-method = "psci";
 			next-level-cache = <&L2_700>;
+			#cooling-cells = <2>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			L2_700: l2-cache {
 				compatible = "cache";
@@ -1058,8 +1067,9 @@
 			reg = <0 0x0c263000 0 0x1ff>, /* TM */
 				<0 0x0c222000 0 0x1ff>; /* SROT */
 			#qcom,sensors = <15>;
-			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "uplow";
+			interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow","critical";
 			#thermal-sensor-cells = <1>;
 		};
 
@@ -1068,8 +1078,9 @@
 			reg = <0 0x0c265000 0 0x1ff>, /* TM */
 				<0 0x0c223000 0 0x1ff>; /* SROT */
 			#qcom,sensors = <10>;
-			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "uplow";
+			interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow","critical";
 			#thermal-sensor-cells = <1>;
 		};
 
@@ -1301,277 +1312,455 @@
 	};
 
 	thermal-zones {
-		cpu0-thermal {
+		cpu_0_0-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 1>;
 
 			trips {
-				cpu0_alert0: trip-point0 {
+				cpu_0_0_alert0: trip-point0 {
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu0_alert1: trip-point1 {
+				cpu_0_0_alert1: trip-point1 {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu0_crit: cpu_crit {
+				cpu_0_0_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_0_0_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu_0_0_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
-		cpu1-thermal {
+		cpu_0_1-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 2>;
 
 			trips {
-				cpu1_alert0: trip-point0 {
+				cpu_0_1_alert0: trip-point0 {
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu1_alert1: trip-point1 {
+				cpu_0_1_alert1: trip-point1 {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu1_crit: cpu_crit {
+				cpu_0_1_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_0_1_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu_0_1_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
-		cpu2-thermal {
+		cpu_0_2-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 3>;
 
 			trips {
-				cpu2_alert0: trip-point0 {
+				cpu_0_2_alert0: trip-point0 {
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu2_alert1: trip-point1 {
+				cpu_0_2_alert1: trip-point1 {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu2_crit: cpu_crit {
+				cpu_0_2_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_0_2_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu_0_2_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
-		cpu3-thermal {
+		cpu_0_3-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 4>;
 
 			trips {
-				cpu3_alert0: trip-point0 {
+				cpu_0_3_alert0: trip-point0 {
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu3_alert1: trip-point1 {
+				cpu_0_3_alert1: trip-point1 {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu3_crit: cpu_crit {
+				cpu_0_3_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_0_3_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu_0_3_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
-		cpu4-thermal {
+		cpu_0_4-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 5>;
 
 			trips {
-				cpu4_alert0: trip-point0 {
+				cpu_0_4_alert0: trip-point0 {
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu4_alert1: trip-point1 {
+				cpu_0_4_alert1: trip-point1 {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu4_crit: cpu_crit {
+				cpu_0_4_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_0_4_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu_0_4_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
-		cpu5-thermal {
+		cpu_0_5-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 6>;
 
 			trips {
-				cpu5_alert0: trip-point0 {
+				cpu_0_5_alert0: trip-point0 {
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu5_alert1: trip-point1 {
+				cpu_0_5_alert1: trip-point1 {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu5_crit: cpu_crit {
+				cpu_0_5_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_0_5_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu_0_5_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
-		cpu6-thermal {
+		cpu_1_0-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 9>;
 
 			trips {
-				cpu6_alert0: trip-point0 {
+				cpu_1_0_alert0: trip-point0 {
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu6_alert1: trip-point1 {
+				cpu_1_0_alert1: trip-point1 {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu6_crit: cpu_crit {
+				cpu_1_0_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_1_0_alert0>;
+					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu_1_0_alert1>;
+					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
-		cpu7-thermal {
+		cpu_1_1-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 10>;
 
 			trips {
-				cpu7_alert0: trip-point0 {
+				cpu_1_1_alert0: trip-point0 {
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu7_alert1: trip-point1 {
+				cpu_1_1_alert1: trip-point1 {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu7_crit: cpu_crit {
+				cpu_1_1_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_1_1_alert0>;
+					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu_1_1_alert1>;
+					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
-		cpu8-thermal {
+		cpu_1_2-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 11>;
 
 			trips {
-				cpu8_alert0: trip-point0 {
+				cpu_1_2_alert0: trip-point0 {
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu8_alert1: trip-point1 {
+				cpu_1_2_alert1: trip-point1 {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu8_crit: cpu_crit {
+				cpu_1_2_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_1_2_alert0>;
+					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu_1_2_alert1>;
+					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
-		cpu9-thermal {
+		cpu_1_3-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 12>;
 
 			trips {
-				cpu9_alert0: trip-point0 {
+				cpu_1_3_alert0: trip-point0 {
 					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu9_alert1: trip-point1 {
+				cpu_1_3_alert1: trip-point1 {
 					temperature = <95000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu9_crit: cpu_crit {
+				cpu_1_3_crit: cpu_crit {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_1_3_alert0>;
+					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu_1_3_alert1>;
+					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
-		aoss0-thermal {
+		aoss_0-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
@@ -1586,7 +1775,7 @@
 			};
 		};
 
-		cpuss0-thermal {
+		cpuss_0-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
@@ -1606,7 +1795,7 @@
 			};
 		};
 
-		cpuss1-thermal {
+		cpuss_1-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
@@ -1626,7 +1815,7 @@
 			};
 		};
 
-		gpuss0-thermal {
+		gpuss_0-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
@@ -1641,7 +1830,7 @@
 			};
 		};
 
-		gpuss1-thermal {
+		gpuss_1-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
@@ -1656,7 +1845,7 @@
 			};
 		};
 
-		aoss1-thermal {
+		aoss_1-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

