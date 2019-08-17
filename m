Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC7C791395
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2019 00:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfHQWrJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Aug 2019 18:47:09 -0400
Received: from inva021.nxp.com ([92.121.34.21]:52906 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfHQWrI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 17 Aug 2019 18:47:08 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5586F20010A;
        Sun, 18 Aug 2019 00:47:05 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6E19E200689;
        Sun, 18 Aug 2019 00:46:57 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A61EA40319;
        Sun, 18 Aug 2019 06:46:47 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, leonard.crestez@nxp.com,
        abel.vesa@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 6/6] arm64: dts: imx8mn: Add cpu-freq support
Date:   Sat, 17 Aug 2019 18:28:20 -0400
Message-Id: <1566080900-2539-6-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566080900-2539-1-git-send-email-Anson.Huang@nxp.com>
References: <1566080900-2539-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add A53 OPP table, cpu regulator and speed grading node to
support cpu-freq driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts |  4 +++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi         | 41 +++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
index 10ebf77..11c705d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
@@ -27,6 +27,10 @@
 	};
 };
 
+&A53_0 {
+	cpu-supply = <&buck2_reg>;
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 1d8899b..785f4c4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -51,6 +51,9 @@
 			clocks = <&clk IMX8MN_CLK_ARM>;
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			operating-points-v2 = <&a53_opp_table>;
+			nvmem-cells = <&cpu_speed_grade>;
+			nvmem-cell-names = "speed_grade";
 		};
 
 		A53_1: cpu@1 {
@@ -61,6 +64,7 @@
 			clocks = <&clk IMX8MN_CLK_ARM>;
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			operating-points-v2 = <&a53_opp_table>;
 		};
 
 		A53_2: cpu@2 {
@@ -71,6 +75,7 @@
 			clocks = <&clk IMX8MN_CLK_ARM>;
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			operating-points-v2 = <&a53_opp_table>;
 		};
 
 		A53_3: cpu@3 {
@@ -81,6 +86,7 @@
 			clocks = <&clk IMX8MN_CLK_ARM>;
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
+			operating-points-v2 = <&a53_opp_table>;
 		};
 
 		A53_L2: l2-cache0 {
@@ -88,6 +94,35 @@
 		};
 	};
 
+	a53_opp_table: opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <850000>;
+			opp-supported-hw = <0xb00>, <0x7>;
+			clock-latency-ns = <150000>;
+			opp-suspend;
+		};
+
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt = <950000>;
+			opp-supported-hw = <0x300>, <0x7>;
+			clock-latency-ns = <150000>;
+			opp-suspend;
+		};
+
+		opp-1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <1000000>;
+			opp-supported-hw = <0x100>, <0x3>;
+			clock-latency-ns = <150000>;
+			opp-suspend;
+		};
+	};
+
 	memory@40000000 {
 		device_type = "memory";
 		reg = <0x0 0x40000000 0 0x80000000>;
@@ -288,6 +323,12 @@
 				compatible = "fsl,imx8mn-ocotp", "fsl,imx7d-ocotp", "syscon";
 				reg = <0x30350000 0x10000>;
 				clocks = <&clk IMX8MN_CLK_OCOTP_ROOT>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				cpu_speed_grade: speed-grade@10 {
+					reg = <0x10 4>;
+				};
 			};
 
 			anatop: anatop@30360000 {
-- 
2.7.4

