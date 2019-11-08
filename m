Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6500F5B1B
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 23:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbfKHWkU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 17:40:20 -0500
Received: from inva021.nxp.com ([92.121.34.21]:57320 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731564AbfKHWkT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Nov 2019 17:40:19 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 30019200831;
        Fri,  8 Nov 2019 23:40:16 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 18B95200770;
        Fri,  8 Nov 2019 23:40:16 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0A283205CD;
        Fri,  8 Nov 2019 23:40:15 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 6/6] arm64: dts: imx8m: Add ddr controller nodes
Date:   Sat,  9 Nov 2019 00:39:56 +0200
Message-Id: <cfaee2ac845b07497a25f688915b60c9bb7c7ac1.1573252696.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1573252696.git.leonard.crestez@nxp.com>
References: <cover.1573252696.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1573252696.git.leonard.crestez@nxp.com>
References: <cover.1573252696.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is used by the imx-ddrc devfreq driver to implement dynamic
frequency scaling of DRAM.

Add a devfreq-event link to the dram PMU in order to support on-demand
scaling of ddrc based on measured dram bandwidth usage.

Support for proactive scaling via interconnect will come later. The
high-performance bus masters which need that (display, vpu, gpu) are not
yet enabled in upstream anyway.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts  | 18 ++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 13 +++++++++-
 .../boot/dts/freescale/imx8mn-ddr4-evk.dts    | 18 ++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     | 13 +++++++++-
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 24 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 13 +++++++++-
 6 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
index 28ab17a277bb..ecf0d385c164 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
@@ -75,10 +75,28 @@
 
 &A53_0 {
 	cpu-supply = <&buck2_reg>;
 };
 
+&ddrc {
+	operating-points-v2 = <&ddrc_opp_table>;
+
+	ddrc_opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp-25M {
+			opp-hz = /bits/ 64 <25000000>;
+		};
+		opp-100M {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+		opp-750M {
+			opp-hz = /bits/ 64 <750000000>;
+		};
+	};
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec1>;
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 6edbdfe2d0d7..0fffc6362c43 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -856,11 +856,22 @@
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		ddr-pmu@3d800000 {
+		ddrc: dram-controller@3d400000 {
+			compatible = "fsl,imx8mm-ddrc", "fsl,imx8m-ddrc";
+			reg = <0x3d400000 0x400000>;
+			clock-names = "core", "pll", "alt", "apb";
+			clocks = <&clk IMX8MM_CLK_DRAM_CORE>,
+				 <&clk IMX8MM_DRAM_PLL>,
+				 <&clk IMX8MM_CLK_DRAM_ALT>,
+				 <&clk IMX8MM_CLK_DRAM_APB>;
+			devfreq-events = <&ddr_pmu>;
+		};
+
+		ddr_pmu: ddr-pmu@3d800000 {
 			compatible = "fsl,imx8mm-ddr-pmu", "fsl,imx8m-ddr-pmu";
 			reg = <0x3d800000 0x400000>;
 			interrupt-parent = <&gic>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 		};
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
index 071949412caf..b051c927c11e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
@@ -15,10 +15,28 @@
 
 &A53_0 {
 	cpu-supply = <&buck2_reg>;
 };
 
+&ddrc {
+	operating-points-v2 = <&ddrc_opp_table>;
+
+	ddrc_opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp-25M {
+			opp-hz = /bits/ 64 <25000000>;
+		};
+		opp-100M {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+		opp-600M {
+			opp-hz = /bits/ 64 <600000000>;
+		};
+	};
+};
+
 &i2c1 {
 	pmic@4b {
 		compatible = "rohm,bd71847";
 		reg = <0x4b>;
 		pinctrl-0 = <&pinctrl_pmic>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index e91625063f8e..c952bfb906a7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -757,11 +757,22 @@
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		ddr-pmu@3d800000 {
+		ddrc: dram-controller@3d400000 {
+			compatible = "fsl,imx8mn-ddrc", "fsl,imx8m-ddrc";
+			reg = <0x3d400000 0x400000>;
+			clock-names = "core", "pll", "alt", "apb";
+			clocks = <&clk IMX8MN_CLK_DRAM_CORE>,
+				 <&clk IMX8MN_DRAM_PLL>,
+				 <&clk IMX8MN_CLK_DRAM_ALT>,
+				 <&clk IMX8MN_CLK_DRAM_APB>;
+			devfreq-events = <&ddr_pmu>;
+		};
+
+		ddr_pmu: ddr-pmu@3d800000 {
 			compatible = "fsl,imx8mn-ddr-pmu", "fsl,imx8m-ddr-pmu";
 			reg = <0x3d800000 0x400000>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index c36685916683..ee6dc5f07622 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -103,10 +103,34 @@
 
 &A53_3 {
 	cpu-supply = <&buck2_reg>;
 };
 
+&ddrc {
+	operating-points-v2 = <&ddrc_opp_table>;
+
+	ddrc_opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp-25M {
+			opp-hz = /bits/ 64 <25000000>;
+		};
+		opp-100M {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+		/*
+		 * On imx8mq B0 PLL can't be bypassed so low bus is 166M
+		 */
+		opp-166M {
+			opp-hz = /bits/ 64 <166935483>;
+		};
+		opp-800M {
+			opp-hz = /bits/ 64 <800000000>;
+		};
+	};
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec1>;
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 7f9319452b58..d2270e99098e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1111,11 +1111,22 @@
 			interrupt-controller;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-parent = <&gic>;
 		};
 
-		ddr-pmu@3d800000 {
+		ddrc: dram-controller@3d400000 {
+			compatible = "fsl,imx8mq-ddrc", "fsl,imx8m-ddrc";
+			reg = <0x3d400000 0x400000>;
+			clock-names = "core", "pll", "alt", "apb";
+			clocks = <&clk IMX8MQ_CLK_DRAM_CORE>,
+				 <&clk IMX8MQ_DRAM_PLL_OUT>,
+				 <&clk IMX8MQ_CLK_DRAM_ALT>,
+				 <&clk IMX8MQ_CLK_DRAM_APB>;
+			devfreq-events = <&ddr_pmu>;
+		};
+
+		ddr_pmu: ddr-pmu@3d800000 {
 			compatible = "fsl,imx8mq-ddr-pmu", "fsl,imx8m-ddr-pmu";
 			reg = <0x3d800000 0x400000>;
 			interrupt-parent = <&gic>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 		};
-- 
2.17.1

