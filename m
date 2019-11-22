Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A20B0107A1E
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2019 22:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfKVVpd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Nov 2019 16:45:33 -0500
Received: from inva020.nxp.com ([92.121.34.13]:39158 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfKVVpd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Nov 2019 16:45:33 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6870F1A02E5;
        Fri, 22 Nov 2019 22:45:31 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5A8901A025D;
        Fri, 22 Nov 2019 22:45:31 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 4216F20465;
        Fri, 22 Nov 2019 22:45:30 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
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
        Silvano di Ninno <silvano.dininno@nxp.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 5/5] arm64: dts: imx8m: Add ddr controller nodes
Date:   Fri, 22 Nov 2019 23:45:04 +0200
Message-Id: <23e46c12c98947315229c20dea6784ad40d294c4.1574458460.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1574458460.git.leonard.crestez@nxp.com>
References: <cover.1574458460.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1574458460.git.leonard.crestez@nxp.com>
References: <cover.1574458460.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is used by the imx-ddrc devfreq driver to implement dynamic
frequency scaling of DRAM.

Support for proactive scaling via interconnect will come later. The
high-performance bus masters which need that (display, vpu, gpu) are
mostly not yet enabled in upstream anyway.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts  | 18 ++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 10 ++++++++
 .../boot/dts/freescale/imx8mn-ddr4-evk.dts    | 18 ++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi     | 10 ++++++++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 24 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 10 ++++++++
 6 files changed, 90 insertions(+)

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
index 6edbdfe2d0d7..3d4802375715 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -856,10 +856,20 @@
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		ddrc: memory-controller@3d400000 {
+			compatible = "fsl,imx8mm-ddrc", "fsl,imx8m-ddrc";
+			reg = <0x3d400000 0x400000>;
+			clock-names = "core", "pll", "alt", "apb";
+			clocks = <&clk IMX8MM_CLK_DRAM_CORE>,
+				 <&clk IMX8MM_DRAM_PLL>,
+				 <&clk IMX8MM_CLK_DRAM_ALT>,
+				 <&clk IMX8MM_CLK_DRAM_APB>;
+		};
+
 		ddr-pmu@3d800000 {
 			compatible = "fsl,imx8mm-ddr-pmu", "fsl,imx8m-ddr-pmu";
 			reg = <0x3d800000 0x400000>;
 			interrupt-parent = <&gic>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
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
index e91625063f8e..3a79fdddc72b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -757,10 +757,20 @@
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		ddrc: memory-controller@3d400000 {
+			compatible = "fsl,imx8mn-ddrc", "fsl,imx8m-ddrc";
+			reg = <0x3d400000 0x400000>;
+			clock-names = "core", "pll", "alt", "apb";
+			clocks = <&clk IMX8MN_CLK_DRAM_CORE>,
+				 <&clk IMX8MN_DRAM_PLL>,
+				 <&clk IMX8MN_CLK_DRAM_ALT>,
+				 <&clk IMX8MN_CLK_DRAM_APB>;
+		};
+
 		ddr-pmu@3d800000 {
 			compatible = "fsl,imx8mn-ddr-pmu", "fsl,imx8m-ddr-pmu";
 			reg = <0x3d800000 0x400000>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
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
index 7f9319452b58..d1fcf9887f8b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1111,10 +1111,20 @@
 			interrupt-controller;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-parent = <&gic>;
 		};
 
+		ddrc: memory-controller@3d400000 {
+			compatible = "fsl,imx8mq-ddrc", "fsl,imx8m-ddrc";
+			reg = <0x3d400000 0x400000>;
+			clock-names = "core", "pll", "alt", "apb";
+			clocks = <&clk IMX8MQ_CLK_DRAM_CORE>,
+				 <&clk IMX8MQ_DRAM_PLL_OUT>,
+				 <&clk IMX8MQ_CLK_DRAM_ALT>,
+				 <&clk IMX8MQ_CLK_DRAM_APB>;
+		};
+
 		ddr-pmu@3d800000 {
 			compatible = "fsl,imx8mq-ddr-pmu", "fsl,imx8m-ddr-pmu";
 			reg = <0x3d800000 0x400000>;
 			interrupt-parent = <&gic>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.17.1

