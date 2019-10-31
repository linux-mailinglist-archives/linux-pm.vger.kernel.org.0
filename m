Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2263EB9FB
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 23:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfJaWwa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 18:52:30 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51712 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfJaWwa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 31 Oct 2019 18:52:30 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E2AA720094A;
        Thu, 31 Oct 2019 23:52:27 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CB7382000BB;
        Thu, 31 Oct 2019 23:52:27 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id C50A5205E9;
        Thu, 31 Oct 2019 23:52:26 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC v5 09/10] arm64: dts: imx8m: Add NOC nodes
Date:   Fri,  1 Nov 2019 00:52:08 +0200
Message-Id: <68fd036712ea9b60109cf34ea04ff0abac6ed6c3.1572562150.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1572562150.git.leonard.crestez@nxp.com>
References: <cover.1572562150.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1572562150.git.leonard.crestez@nxp.com>
References: <cover.1572562150.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add initial support for dynamic frequency scaling of main NOC.

Make DDRC the parent of the NOC (using passive governor) so that the
main NOC is automatically scaled together with DDRC by default.

Support for proactive scaling via interconnect will come later.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 22 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 22 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 22 ++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 5404870d80d5..dc0ab49bbbd2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -138,10 +138,24 @@
 			clock-latency-ns = <150000>;
 			opp-suspend;
 		};
 	};
 
+	noc_opp_table: noc-opp-table {
+		compatible = "operating-points-v2";
+
+		opp-150M {
+			opp-hz = /bits/ 64 <150000000>;
+		};
+		opp-375M {
+			opp-hz = /bits/ 64 <375000000>;
+		};
+		opp-750M {
+			opp-hz = /bits/ 64 <750000000>;
+		};
+	};
+
 	memory@40000000 {
 		device_type = "memory";
 		reg = <0x0 0x40000000 0 0x80000000>;
 	};
 
@@ -772,10 +786,18 @@
 				status = "disabled";
 			};
 
 		};
 
+		noc: interconnect@32700000 {
+			compatible = "fsl,imx8mm-noc", "fsl,imx8m-noc";
+			reg = <0x32700000 0x100000>;
+			clocks = <&clk IMX8MM_CLK_NOC>;
+			devfreq = <&ddrc>;
+			operating-points-v2 = <&noc_opp_table>;
+		};
+
 		aips4: bus@32c00000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x32c00000 0x32c00000 0x400000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 344dd777635f..6b4a9ba2a8a5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -137,10 +137,24 @@
 			clock-latency-ns = <150000>;
 			opp-suspend;
 		};
 	};
 
+	noc_opp_table: noc-opp-table {
+		compatible = "operating-points-v2";
+
+		opp-100M {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+		opp-600M {
+			opp-hz = /bits/ 64 <600000000>;
+		};
+		opp-800M {
+			opp-hz = /bits/ 64 <800000000>;
+		};
+	};
+
 	memory@40000000 {
 		device_type = "memory";
 		reg = <0x0 0x40000000 0 0x80000000>;
 	};
 
@@ -668,10 +682,18 @@
 				status = "disabled";
 			};
 
 		};
 
+		noc: interconnect@32700000 {
+			compatible = "fsl,imx8mn-noc", "fsl,imx8m-noc";
+			reg = <0x32700000 0x100000>;
+			clocks = <&clk IMX8MN_CLK_NOC>;
+			devfreq = <&ddrc>;
+			operating-points-v2 = <&noc_opp_table>;
+		};
+
 		aips4: bus@32c00000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x32c00000 0x400000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 6ef1af41ef68..c42c67eb1d50 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -183,10 +183,24 @@
 			clock-latency-ns = <150000>;
 			opp-suspend;
 		};
 	};
 
+	noc_opp_table: noc-opp-table {
+		compatible = "operating-points-v2";
+
+		opp-133M {
+			opp-hz = /bits/ 64 <133333333>;
+		};
+		opp-400M {
+			opp-hz = /bits/ 64 <400000000>;
+		};
+		opp-800M {
+			opp-hz = /bits/ 64 <800000000>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-parent = <&gic>;
 		interrupt-affinity = <&A53_0>, <&A53_1>, <&A53_2>, <&A53_3>;
@@ -931,10 +945,18 @@
 				fsl,num-rx-queues = <3>;
 				status = "disabled";
 			};
 		};
 
+		noc: interconnect@32700000 {
+			compatible = "fsl,imx8mq-noc", "fsl,imx8m-noc";
+			reg = <0x32700000 0x100000>;
+			clocks = <&clk IMX8MQ_CLK_NOC>;
+			devfreq = <&ddrc>;
+			operating-points-v2 = <&noc_opp_table>;
+		};
+
 		bus@32c00000 { /* AIPS4 */
 			compatible = "fsl,imx8mq-aips-bus", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x32c00000 0x32c00000 0x400000>;
-- 
2.17.1

