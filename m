Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE59172EFF
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 04:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbgB1C7z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 21:59:55 -0500
Received: from inva021.nxp.com ([92.121.34.21]:35936 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730712AbgB1C7z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Feb 2020 21:59:55 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DF139201000;
        Fri, 28 Feb 2020 03:59:52 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4E1A720AA5F;
        Fri, 28 Feb 2020 03:59:37 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 840F1402AD;
        Fri, 28 Feb 2020 10:59:24 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        aford173@gmail.com, shengjiu.wang@nxp.com, ping.bai@nxp.com,
        jun.li@nxp.com, peng.fan@nxp.com, bjorn.andersson@linaro.org,
        olof@lixom.net, dinguyen@kernel.org, marcin.juszkiewicz@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 4/4] arm64: dts: imx8mm: Add thermal zone support
Date:   Fri, 28 Feb 2020 10:53:33 +0800
Message-Id: <1582858413-11906-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582858413-11906-1-git-send-email-Anson.Huang@nxp.com>
References: <1582858413-11906-1-git-send-email-Anson.Huang@nxp.com>
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
No change.
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 43 +++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index b3d0b29..e438095 100644
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
@@ -204,6 +208,38 @@
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
@@ -363,6 +399,13 @@
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

