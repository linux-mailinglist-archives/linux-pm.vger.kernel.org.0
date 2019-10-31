Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C18BEB9FC
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 23:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfJaWwb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 18:52:31 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56630 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbfJaWwb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 31 Oct 2019 18:52:31 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 064B81A0033;
        Thu, 31 Oct 2019 23:52:29 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E2F811A0212;
        Thu, 31 Oct 2019 23:52:28 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id DC7EB205E9;
        Thu, 31 Oct 2019 23:52:27 +0100 (CET)
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
Subject: [PATCH RFC v5 10/10] arm64: dts: imx8m: Add interconnect provider properties
Date:   Fri,  1 Nov 2019 00:52:09 +0200
Message-Id: <0023fc7eb7ab2375af08bf0f38dd55c02bb075d2.1572562150.git.leonard.crestez@nxp.com>
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

Add #interconnect-cells on main &noc so that it will probe the platform
interconnect providers. Other devices can request icc_paths like this:

	interconnects = <&noc BUS_MASTER_ID &noc BUS_SLAVE_ID>

And interconnect-node-id properties on &noc and &ddrc, the interconnect
provider will scan these and make PM QoS frequency requests in response
to bandwith request from other drivers.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 4 ++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 4 ++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index dc0ab49bbbd2..4a84db1bf6bd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -6,10 +6,11 @@
 #include <dt-bindings/clock/imx8mm-clock.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/interconnect/imx8mm.h>
 
 #include "imx8mm-pinfunc.h"
 
 / {
 	interrupt-parent = <&gic>;
@@ -791,10 +792,12 @@
 		noc: interconnect@32700000 {
 			compatible = "fsl,imx8mm-noc", "fsl,imx8m-noc";
 			reg = <0x32700000 0x100000>;
 			clocks = <&clk IMX8MM_CLK_NOC>;
 			devfreq = <&ddrc>;
+			#interconnect-cells = <1>;
+			interconnect-node-id = <IMX8MM_ICN_NOC>;
 			operating-points-v2 = <&noc_opp_table>;
 		};
 
 		aips4: bus@32c00000 {
 			compatible = "fsl,aips-bus", "simple-bus";
@@ -881,10 +884,11 @@
 		};
 
 		ddrc: dram-controller@3d400000 {
 			compatible = "fsl,imx8mm-ddrc", "fsl,imx8m-ddrc";
 			reg = <0x3d400000 0x400000>;
+			interconnect-node-id = <IMX8MM_ICS_DRAM>;
 			clock-names = "dram_core",
 				      "dram_pll",
 				      "dram_alt",
 				      "dram_apb";
 			clocks = <&clk IMX8MM_CLK_DRAM_CORE>,
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 6b4a9ba2a8a5..0fd96c976607 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -5,10 +5,11 @@
 
 #include <dt-bindings/clock/imx8mn-clock.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interconnect/imx8mn.h>
 
 #include "imx8mn-pinfunc.h"
 
 / {
 	interrupt-parent = <&gic>;
@@ -687,10 +688,12 @@
 		noc: interconnect@32700000 {
 			compatible = "fsl,imx8mn-noc", "fsl,imx8m-noc";
 			reg = <0x32700000 0x100000>;
 			clocks = <&clk IMX8MN_CLK_NOC>;
 			devfreq = <&ddrc>;
+			#interconnect-cells = <1>;
+			interconnect-node-id = <IMX8MN_ICN_NOC>;
 			operating-points-v2 = <&noc_opp_table>;
 		};
 
 		aips4: bus@32c00000 {
 			compatible = "fsl,aips-bus", "simple-bus";
@@ -790,10 +793,11 @@
 				      "dram_apb";
 			clocks = <&clk IMX8MN_CLK_DRAM_CORE>,
 				 <&clk IMX8MN_DRAM_PLL>,
 				 <&clk IMX8MN_CLK_DRAM_ALT>,
 				 <&clk IMX8MN_CLK_DRAM_APB>;
+			interconnect-node-id = <IMX8MN_ICS_DRAM>;
 			devfreq-events = <&ddr_pmu>;
 		};
 
 		ddr_pmu: ddr-pmu@3d800000 {
 			compatible = "fsl,imx8mn-ddr-pmu", "fsl,imx8m-ddr-pmu";
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index c42c67eb1d50..6ede02b44931 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -9,10 +9,11 @@
 #include <dt-bindings/reset/imx8mq-reset.h>
 #include <dt-bindings/gpio/gpio.h>
 #include "dt-bindings/input/input.h"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/interconnect/imx8mq.h>
 #include "imx8mq-pinfunc.h"
 
 / {
 	interrupt-parent = <&gpc>;
 
@@ -950,10 +951,12 @@
 		noc: interconnect@32700000 {
 			compatible = "fsl,imx8mq-noc", "fsl,imx8m-noc";
 			reg = <0x32700000 0x100000>;
 			clocks = <&clk IMX8MQ_CLK_NOC>;
 			devfreq = <&ddrc>;
+			#interconnect-cells = <1>;
+			interconnect-node-id = <IMX8MQ_ICN_NOC>;
 			operating-points-v2 = <&noc_opp_table>;
 		};
 
 		bus@32c00000 { /* AIPS4 */
 			compatible = "fsl,imx8mq-aips-bus", "simple-bus";
@@ -1144,10 +1147,11 @@
 				      "dram_apb";
 			clocks = <&clk IMX8MQ_CLK_DRAM_CORE>,
 				 <&clk IMX8MQ_DRAM_PLL_OUT>,
 				 <&clk IMX8MQ_CLK_DRAM_ALT>,
 				 <&clk IMX8MQ_CLK_DRAM_APB>;
+			interconnect-node-id = <IMX8MQ_ICS_DRAM>;
 			devfreq-events = <&ddr_pmu>;
 		};
 
 		ddr_pmu: ddr-pmu@3d800000 {
 			compatible = "fsl,imx8mq-ddr-pmu", "fsl,imx8m-ddr-pmu";
-- 
2.17.1

