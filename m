Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1A6919ADF1
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 16:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733071AbgDAOdZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 10:33:25 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40356 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732749AbgDAOdY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Apr 2020 10:33:24 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 067971A0EA3;
        Wed,  1 Apr 2020 16:33:23 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E0B1F1A0E8F;
        Wed,  1 Apr 2020 16:33:22 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D18C320507;
        Wed,  1 Apr 2020 16:33:21 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
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
        Silvano di Ninno <silvano.dininno@nxp.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 8/8] arm64: dts: imx8m: Add NOC nodes
Date:   Wed,  1 Apr 2020 17:33:07 +0300
Message-Id: <c167baa48d6830cf32b9ac51968eeadd684ebf2d.1585751281.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585751281.git.leonard.crestez@nxp.com>
References: <cover.1585751281.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1585751281.git.leonard.crestez@nxp.com>
References: <cover.1585751281.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add nodes for the main interconnect of the imx8m series chips.

These nodes are bound to by devfreq and interconnect drivers.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 24 +++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 24 +++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 24 +++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 175c28ae10cf..41047b6709b6 100644
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
@@ -860,10 +861,33 @@
 				status = "disabled";
 			};
 
 		};
 
+		noc: interconnect@32700000 {
+			compatible = "fsl,imx8mm-noc", "fsl,imx8m-noc";
+			reg = <0x32700000 0x100000>;
+			clocks = <&clk IMX8MM_CLK_NOC>;
+			fsl,ddrc = <&ddrc>;
+			#interconnect-cells = <1>;
+			operating-points-v2 = <&noc_opp_table>;
+
+			noc_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-150M {
+					opp-hz = /bits/ 64 <150000000>;
+				};
+				opp-375M {
+					opp-hz = /bits/ 64 <375000000>;
+				};
+				opp-750M {
+					opp-hz = /bits/ 64 <750000000>;
+				};
+			};
+		};
+
 		aips4: bus@32c00000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x32df0000 0x10000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 88e7d74e077f..e8a55956813f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -6,10 +6,11 @@
 #include <dt-bindings/clock/imx8mn-clock.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/interconnect/imx8mn.h>
 
 #include "imx8mn-pinfunc.h"
 
 / {
 	interrupt-parent = <&gic>;
@@ -751,10 +752,33 @@
 				status = "disabled";
 			};
 
 		};
 
+		noc: interconnect@32700000 {
+			compatible = "fsl,imx8mn-noc", "fsl,imx8m-noc";
+			reg = <0x32700000 0x100000>;
+			clocks = <&clk IMX8MN_CLK_NOC>;
+			fsl,ddrc = <&ddrc>;
+			#interconnect-cells = <1>;
+			operating-points-v2 = <&noc_opp_table>;
+
+			noc_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100M {
+					opp-hz = /bits/ 64 <100000000>;
+				};
+				opp-600M {
+					opp-hz = /bits/ 64 <600000000>;
+				};
+				opp-800M {
+					opp-hz = /bits/ 64 <800000000>;
+				};
+			};
+		};
+
 		aips4: bus@32c00000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x32df0000 0x10000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index ea93bc4b7d7e..3a208feec74c 100644
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
 
@@ -1026,10 +1027,33 @@
 				fsl,num-rx-queues = <3>;
 				status = "disabled";
 			};
 		};
 
+		noc: interconnect@32700000 {
+			compatible = "fsl,imx8mq-noc", "fsl,imx8m-noc";
+			reg = <0x32700000 0x100000>;
+			clocks = <&clk IMX8MQ_CLK_NOC>;
+			fsl,ddrc = <&ddrc>;
+			#interconnect-cells = <1>;
+			operating-points-v2 = <&noc_opp_table>;
+
+			noc_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-133M {
+					opp-hz = /bits/ 64 <133333333>;
+				};
+				opp-400M {
+					opp-hz = /bits/ 64 <400000000>;
+				};
+				opp-800M {
+					opp-hz = /bits/ 64 <800000000>;
+				};
+			};
+		};
+
 		bus@32c00000 { /* AIPS4 */
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x32df0000 0x10000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.17.1

