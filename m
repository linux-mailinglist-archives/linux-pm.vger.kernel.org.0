Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2FE59B22C
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 16:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390787AbfHWOhN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 10:37:13 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38522 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395343AbfHWOhM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Aug 2019 10:37:12 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 83E9D1A06DE;
        Fri, 23 Aug 2019 16:37:10 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 774DB1A06D9;
        Fri, 23 Aug 2019 16:37:10 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 98D90205D9;
        Fri, 23 Aug 2019 16:37:09 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
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
        kernel@pengutronix.de, linux-imx@nxp.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFCv4 7/7] arm64: dts: imx8mm: Add interconnect properties
Date:   Fri, 23 Aug 2019 17:37:00 +0300
Message-Id: <8c3fb831b3c146cf3267c05e4b1f6c88613dceed.1566570260.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1566570260.git.leonard.crestez@nxp.com>
References: <cover.1566570260.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1566570260.git.leonard.crestez@nxp.com>
References: <cover.1566570260.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add #interconnect-cells and interconnect-node-id properties on devfreq
nodes. The imx interconnect provider will scan these.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 5474c50784c2..8b5442d8b1b2 100644
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
 	compatible = "fsl,imx8mm";
@@ -806,10 +807,12 @@
 		noc: noc@32700000 {
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
@@ -896,10 +899,12 @@
 		};
 
 		ddrc: dram-controller@3d400000 {
 			compatible = "fsl,imx8mm-ddrc", "fsl,imx8m-ddrc";
 			reg = <0x3d400000 0x400000>;
+			#interconnect-cells = <1>;
+			interconnect-node-id = <IMX8MM_ICS_DRAM>;
 			clock-names = "dram_core",
 				      "dram_pll",
 				      "dram_alt",
 				      "dram_apb";
 			clocks = <&clk IMX8MM_CLK_DRAM_CORE>,
-- 
2.17.1

