Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF03E6C2D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 07:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfJ1GHZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 02:07:25 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53470 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731635AbfJ1GHZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Oct 2019 02:07:25 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B2C5E200161;
        Mon, 28 Oct 2019 07:07:22 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 67BDB2006FD;
        Mon, 28 Oct 2019 07:07:09 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 324304029E;
        Mon, 28 Oct 2019 14:06:55 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, leonard.crestez@nxp.com,
        abel.vesa@nxp.com, ping.bai@nxp.com, daniel.baluta@nxp.com,
        jun.li@nxp.com, bjorn.andersson@linaro.org, olof@lixom.net,
        mripard@kernel.org, vkoul@kernel.org, jagan@amarulasolutions.com,
        dinguyen@kernel.org, marcin.juszkiewicz@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH RESEND 4/4] arm64: dts: imx8mm: Add thermal zone support
Date:   Mon, 28 Oct 2019 14:03:38 +0800
Message-Id: <1572242618-18806-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1572242618-18806-1-git-send-email-Anson.Huang@nxp.com>
References: <1572242618-18806-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add thermal zone and tmu node to support i.MX8MM thermal
driver, ONLY cpu thermal zone is supported, and cpu cooling
is also added.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 43 +++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 5ff9b6b..ade930f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -68,6 +68,7 @@
 			nvmem-cells = <&cpu_speed_grade>;
 			nvmem-cell-names = "speed_grade";
 			cpu-idle-states = <&cpu_pd_wait>;
+			#cooling-cells = <2>;
 		};
 
 		A53_1: cpu@1 {
@@ -80,6 +81,7 @@
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			cpu-idle-states = <&cpu_pd_wait>;
+			#cooling-cells = <2>;
 		};
 
 		A53_2: cpu@2 {
@@ -92,6 +94,7 @@
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			cpu-idle-states = <&cpu_pd_wait>;
+			#cooling-cells = <2>;
 		};
 
 		A53_3: cpu@3 {
@@ -104,6 +107,7 @@
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			cpu-idle-states = <&cpu_pd_wait>;
+			#cooling-cells = <2>;
 		};
 
 		A53_L2: l2-cache0 {
@@ -209,6 +213,38 @@
 		arm,no-tick-in-suspend;
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+			thermal-sensors = <&tmu>;
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
+	};
+
 	usbphynop1: usbphynop1 {
 		compatible = "usb-nop-xceiv";
 		clocks = <&clk IMX8MM_CLK_USB_PHY_REF>;
@@ -368,6 +404,13 @@
 				gpio-ranges = <&iomuxc 0 119 30>;
 			};
 
+			tmu: tmu@30260000 {
+				compatible = "fsl,imx8mm-tmu";
+				reg = <0x30260000 0x10000>;
+				clocks = <&clk IMX8MM_CLK_TMU_ROOT>;
+				#thermal-sensor-cells = <0>;
+			};
+
 			wdog1: watchdog@30280000 {
 				compatible = "fsl,imx8mm-wdt", "fsl,imx21-wdt";
 				reg = <0x30280000 0x10000>;
-- 
2.7.4

