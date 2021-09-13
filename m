Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037AE409AE8
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 19:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344259AbhIMRkA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 13:40:00 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44000 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245147AbhIMRjw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Sep 2021 13:39:52 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B7BE31A0393;
        Mon, 13 Sep 2021 19:38:34 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AA73A1A038F;
        Mon, 13 Sep 2021 19:38:34 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id DA8BE20363;
        Mon, 13 Sep 2021 19:38:33 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-serial@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 14/19] arm64: dts: imx8mq: Add all pl301 nodes
Date:   Mon, 13 Sep 2021 20:38:09 +0300
Message-Id: <1631554694-9599-15-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
References: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add all the pl301s found on i.MX8MQ, according to the bus diagram.
Each pl301 has its own clock, icc id and opp table. They are probed
by the imx-bus driver.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 202 ++++++++++++++++++++++
 1 file changed, 202 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index ab528665a217..a05bccbb1342 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1566,5 +1566,207 @@ ddr-pmu@3d800000 {
 			interrupt-parent = <&gic>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		pl301_main: pl301@0 {
+			compatible = "fsl,imx8m-nic";
+			clocks = <&clk IMX8MQ_CLK_MAIN_AXI>;
+			operating-points-v2 = <&pl301_main_opp_table>;
+			#interconnect-cells = <0>;
+			fsl,icc-id = <IMX8MQ_ICN_MAIN>;
+
+			pl301_main_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-25M {
+					opp-hz = /bits/ 64 <25000000>;
+				};
+				opp-133M {
+					opp-hz = /bits/ 64 <133333333>;
+				};
+				opp-333M {
+					opp-hz = /bits/ 64 <333333333>;
+				};
+			};
+		};
+
+		pl301_enet: pl301@1 {
+			compatible = "fsl,imx8m-nic";
+			clocks = <&clk IMX8MQ_CLK_ENET_AXI>;
+			operating-points-v2 = <&pl301_enet_opp_table>;
+			#interconnect-cells = <0>;
+			fsl,icc-id = <IMX8MQ_ICN_ENET>;
+
+			pl301_enet_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-25M {
+					opp-hz = /bits/ 64 <25000000>;
+				};
+				opp-266M {
+					opp-hz = /bits/ 64 <266666666>;
+				};
+			};
+		};
+
+		pl301_gpu: pl301@2 {
+			compatible = "fsl,imx8m-nic";
+			clocks = <&clk IMX8MQ_CLK_GPU_AXI>;
+			operating-points-v2 = <&pl301_gpu_opp_table>;
+			#interconnect-cells = <0>;
+			fsl,icc-id = <IMX8MQ_ICN_GPU>;
+
+			pl301_gpu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-25M {
+					opp-hz = /bits/ 64 <25000000>;
+				};
+				opp-800M {
+					opp-hz = /bits/ 64 <800000000>;
+				};
+			};
+		};
+
+		pl301_dc: pl301@3 {
+			compatible = "fsl,imx8m-nic";
+			clocks = <&clk IMX8MQ_CLK_DISP_AXI>;
+			operating-points-v2 = <&pl301_dc_opp_table>;
+			#interconnect-cells = <0>;
+			fsl,icc-id = <IMX8MQ_ICN_DCSS>;
+
+			pl301_dc_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-25M {
+					opp-hz = /bits/ 64 <25000000>;
+				};
+				opp-800M {
+					opp-hz = /bits/ 64 <800000000>;
+				};
+			};
+		};
+
+		/* PL301_DISPLAY (IPs other than DCSS, inside SUPERMIX) */
+		pl301_display: pl301@4 {
+			compatible = "fsl,imx8m-nic";
+			/* FIXME: don't know which clock yet */
+			clocks = <&clk IMX8MQ_CLK_DUMMY>;
+			operating-points-v2 = <&pl301_display_opp_table>;
+			#interconnect-cells = <0>;
+			fsl,icc-id = <IMX8MQ_ICN_DISPLAY>;
+
+			pl301_display_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-25M {
+					opp-hz = /bits/ 64 <25000000>;
+				};
+				opp-333M {
+					opp-hz = /bits/ 64 <333333333>;
+				};
+			};
+		};
+
+		pl301_audio: pl301@5 {
+			compatible = "fsl,imx8m-nic";
+			clocks = <&clk IMX8MQ_CLK_AUDIO_AHB>;
+			operating-points-v2 = <&pl301_audio_opp_table>;
+			#interconnect-cells = <0>;
+			fsl,icc-id = <IMX8MQ_ICN_AUDIO>;
+
+			pl301_audio_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-25M {
+					opp-hz = /bits/ 64 <25000000>;
+				};
+				opp-500M {
+					opp-hz = /bits/ 64 <500000000>;
+				};
+			};
+		};
+
+		pl301_video: pl301@6 {
+			compatible = "fsl,imx8m-nic";
+			clocks = <&clk IMX8MQ_CLK_VPU_BUS>;
+			operating-points-v2 = <&pl301_video_opp_table>;
+			#interconnect-cells = <0>;
+			fsl,icc-id = <IMX8MQ_ICN_VIDEO>;
+
+			pl301_video_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-25M {
+					opp-hz = /bits/ 64 <25000000>;
+				};
+				opp-500M {
+					opp-hz = /bits/ 64 <500000000>;
+				};
+			};
+		};
+
+		pl301_usb: pl301@7 {
+			compatible = "fsl,imx8m-nic";
+			clocks = <&clk IMX8MQ_CLK_USB_BUS>;
+			operating-points-v2 = <&pl301_usb_opp_table>;
+			#interconnect-cells = <0>;
+			fsl,icc-id = <IMX8MQ_ICN_USB>;
+
+			pl301_usb_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-25M {
+					opp-hz = /bits/ 64 <25000000>;
+				};
+				opp-128M {
+					opp-hz = /bits/ 64 <128000000>;
+				};
+				opp-500M {
+					opp-hz = /bits/ 64 <500000000>;
+				};
+			};
+		};
+
+		pl301_wakeup: pl301@8 {
+			compatible = "fsl,imx8m-nic";
+			/* FIXME: don't know which clock yet */
+			clocks = <&clk IMX8MQ_CLK_DUMMY>;
+			operating-points-v2 = <&pl301_wakeup_opp_table>;
+			#interconnect-cells = <0>;
+			fsl,icc-id = <IMX8MQ_ICN_WAKEUP>;
+
+			pl301_wakeup_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-25M {
+					opp-hz = /bits/ 64 <25000000>;
+				};
+				opp-133M {
+					opp-hz = /bits/ 64 <133333333>;
+				};
+			};
+		};
+
+		pl301_per_m: pl301@9 {
+			compatible = "fsl,imx8m-nic";
+			clocks = <&clk IMX8MQ_CLK_NAND_USDHC_BUS>;
+			operating-points-v2 = <&pl301_per_m_opp_table>;
+			#interconnect-cells = <0>;
+			fsl,icc-id = <IMX8MQ_ICN_PER_M>;
+
+			pl301_per_m_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-25M {
+					opp-hz = /bits/ 64 <25000000>;
+				};
+				opp-133M {
+					opp-hz = /bits/ 64 <133333333>;
+				};
+				opp-266M {
+					opp-hz = /bits/ 64 <266666666>;
+				};
+			};
+		};
 	};
 };
-- 
2.31.1

