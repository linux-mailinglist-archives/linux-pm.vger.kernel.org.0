Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66EBE59533
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 09:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfF1HkK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 03:40:10 -0400
Received: from inva020.nxp.com ([92.121.34.13]:55130 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbfF1HkJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jun 2019 03:40:09 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AA7961A0DC4;
        Fri, 28 Jun 2019 09:40:08 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9D9231A0346;
        Fri, 28 Jun 2019 09:40:08 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B4496205D5;
        Fri, 28 Jun 2019 09:40:07 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFCv2 8/8] arm64: dts: imx8mm: Add devfreq-imx nodes
Date:   Fri, 28 Jun 2019 10:39:56 +0300
Message-Id: <f5714b11a0f46b20cef3cad0cf615bc1093499de.1561707104.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1561707104.git.leonard.crestez@nxp.com>
References: <cover.1561707104.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1561707104.git.leonard.crestez@nxp.com>
References: <cover.1561707104.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The imx8mm has multiple buses which can be scaled with some degree of
independence. Expose them as devfreq devices for userspace scaling.

It shouldn't be possible to get the system in a non-working state this
way. It is primarily aimed at testing and fine performance tuning.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 54 +++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 3b4b112814f7..aa9ed418652d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -121,10 +121,32 @@
 			opp-supported-hw = <0x8>, <0x7>;
 			clock-latency-ns = <150000>;
 		};
 	};
 
+	ddrc_opp_table: ddrc-opp-table {
+		compatible = "operating-points-v2";
+
+		opp-25M {
+			opp-hz = /bits/ 64 <25000000>;
+		};
+		opp-750M {
+			opp-hz = /bits/ 64 <750000000>;
+		};
+	};
+
+	noc_opp_table: noc-opp-table {
+		compatible = "operating-points-v2";
+
+		opp-150M {
+			opp-hz = /bits/ 64 <150000000>;
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
 
@@ -748,10 +770,35 @@
 				status = "disabled";
 			};
 
 		};
 
+		pl301_main: nic@32000000 {
+			compatible = "fsl,imx8mm-nic";
+			reg = <0x32000000 0x100000>;
+			clocks = <&clk IMX8MM_CLK_MAIN_AXI>;
+		};
+
+		pl301_wakeup: nic@32100000 {
+			compatible = "fsl,imx8mm-nic";
+			reg = <0x32100000 0x100000>;
+			clocks = <&clk IMX8MM_CLK_AHB>;
+		};
+
+		pl301_enet: nic@32400000 {
+			compatible = "fsl,imx8mm-nic";
+			reg = <0x32400000 0x100000>;
+			clocks = <&clk IMX8MM_CLK_ENET_AXI>;
+		};
+
+		noc: noc@32700000 {
+			compatible = "fsl,imx8mm-noc";
+			reg = <0x32700000 0x100000>;
+			clocks = <&clk IMX8MM_CLK_NOC>;
+			operating-points-v2 = <&noc_opp_table>;
+		};
+
 		aips4: bus@32c00000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x32c00000 0x32c00000 0x400000>;
@@ -835,7 +882,14 @@
 			      <0x38880000 0xc0000>; /* GICR (RD_base + SGI_base) */
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		ddrc: dram-controller@3d400000 {
+			compatible = "fsl,imx8mm-ddrc";
+			reg = <0x3d400000 0x400000>;
+			clocks = <&clk IMX8MM_CLK_DRAM>;
+			operating-points-v2 = <&ddrc_opp_table>;
+		};
 	};
 };
-- 
2.17.1

