Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9492C9ED7
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 11:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388758AbgLAKJz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 05:09:55 -0500
Received: from comms.puri.sm ([159.203.221.185]:53350 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729615AbgLAKJy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Dec 2020 05:09:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 915D9E0399;
        Tue,  1 Dec 2020 02:02:30 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EI_47RiCRfNR; Tue,  1 Dec 2020 02:02:29 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, georgi.djakov@linaro.org,
        cdleonard@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH 1/6] arm64: dts: imx8m: Add NOC nodes
Date:   Tue,  1 Dec 2020 11:01:19 +0100
Message-Id: <20201201100124.4676-2-martin.kepplinger@puri.sm>
In-Reply-To: <20201201100124.4676-1-martin.kepplinger@puri.sm>
References: <20201201100124.4676-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

Add initial support for dynamic frequency scaling of main NOC.

Make DDRC the parent of the NOC (using passive governor) so that the
main NOC is automatically scaled together with DDRC by default.

Support for proactive scaling via interconnect will come on top.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm> (imx8mq)
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 22 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 22 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 22 ++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index c824f2615fe8..835b19f0ea42 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -921,6 +921,28 @@
 
 		};
 
+		noc: interconnect@32700000 {
+			compatible = "fsl,imx8mm-noc", "fsl,imx8m-noc";
+			reg = <0x32700000 0x100000>;
+			clocks = <&clk IMX8MM_CLK_NOC>;
+			devfreq = <&ddrc>;
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
 			reg = <0x32c00000 0x400000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index a06d2a6268e6..8e2d413f97d4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -772,6 +772,28 @@
 
 		};
 
+		noc: interconnect@32700000 {
+			compatible = "fsl,imx8mn-noc", "fsl,imx8m-noc";
+			reg = <0x32700000 0x100000>;
+			clocks = <&clk IMX8MN_CLK_NOC>;
+			devfreq = <&ddrc>;
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
 			reg = <0x32c00000 0x400000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index a841a023e8e0..d139a46ee8ce 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1158,6 +1158,28 @@
 			};
 		};
 
+		noc: interconnect@32700000 {
+			compatible = "fsl,imx8mq-noc", "fsl,imx8m-noc";
+			reg = <0x32700000 0x100000>;
+			clocks = <&clk IMX8MQ_CLK_NOC>;
+			devfreq = <&ddrc>;
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
 			reg = <0x32c00000 0x400000>;
-- 
2.20.1

