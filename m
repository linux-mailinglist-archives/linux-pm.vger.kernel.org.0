Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6BA18F4C0
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 13:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgCWMfl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 08:35:41 -0400
Received: from inva020.nxp.com ([92.121.34.13]:58642 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbgCWMfl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Mar 2020 08:35:41 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C78D91A0DF4;
        Mon, 23 Mar 2020 13:35:38 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 07A8D1A13C1;
        Mon, 23 Mar 2020 13:35:31 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B6D5640305;
        Mon, 23 Mar 2020 20:35:21 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, horia.geanta@nxp.com, peng.fan@nxp.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 3/3] arm64: dts: imx8mp: Add thermal zones support
Date:   Mon, 23 Mar 2020 20:28:24 +0800
Message-Id: <1584966504-21719-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584966504-21719-1-git-send-email-Anson.Huang@nxp.com>
References: <1584966504-21719-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

i.MX8MP has a TMU inside which supports two thermal zones, add support
for them.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change.
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 63 +++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9b1616e..175165b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/thermal/thermal.h>
 
 #include "imx8mp-pinfunc.h"
 
@@ -43,6 +44,7 @@
 			clocks = <&clk IMX8MP_CLK_ARM>;
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			#cooling-cells = <2>;
 		};
 
 		A53_1: cpu@1 {
@@ -53,6 +55,7 @@
 			clocks = <&clk IMX8MP_CLK_ARM>;
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			#cooling-cells = <2>;
 		};
 
 		A53_2: cpu@2 {
@@ -63,6 +66,7 @@
 			clocks = <&clk IMX8MP_CLK_ARM>;
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			#cooling-cells = <2>;
 		};
 
 		A53_3: cpu@3 {
@@ -73,6 +77,7 @@
 			clocks = <&clk IMX8MP_CLK_ARM>;
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			#cooling-cells = <2>;
 		};
 
 		A53_L2: l2-cache0 {
@@ -127,6 +132,57 @@
 		method = "smc";
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+			thermal-sensors = <&tmu 0x0>;
+			trips {
+				cpu_alert0: trip0 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_crit0: trip1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert0>;
+					cooling-device =
+						<&A53_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A53_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A53_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&A53_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		soc-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+			thermal-sensors = <&tmu 0x1>;
+			trips {
+				soc_alert0: trip0 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				soc_crit0: trip1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
@@ -215,6 +271,13 @@
 				gpio-ranges = <&iomuxc 0 114 30>;
 			};
 
+			tmu: tmu@30260000 {
+				compatible = "fsl,imx8mp-tmu";
+				reg = <0x30260000 0x10000>;
+				clocks = <&clk IMX8MP_CLK_TSENSOR_ROOT>;
+				#thermal-sensor-cells = <1>;
+			};
+
 			wdog1: watchdog@30280000 {
 				compatible = "fsl,imx8mp-wdt", "fsl,imx21-wdt";
 				reg = <0x30280000 0x10000>;
-- 
2.7.4

