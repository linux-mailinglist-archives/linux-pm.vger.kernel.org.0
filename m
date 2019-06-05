Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04B1435A89
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 12:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfFEKhS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 06:37:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60812 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727176AbfFEKhR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jun 2019 06:37:17 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4437820077E;
        Wed,  5 Jun 2019 12:37:15 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 37A56200787;
        Wed,  5 Jun 2019 12:37:15 +0200 (CEST)
Received: from jana.ea.freescale.net (gw_auto.ea.freescale.net [10.171.94.100])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B478A205FA;
        Wed,  5 Jun 2019 12:37:14 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Jacky Bai <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/5] ARM: dts: imx7d: Update cpufreq OPP table
Date:   Wed,  5 Jun 2019 13:37:08 +0300
Message-Id: <be47ecfba98b4adacd39e4a6a85897cd4ee0ec88.1559730963.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1559730963.git.leonard.crestez@nxp.com>
References: <cover.1559730963.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1559730963.git.leonard.crestez@nxp.com>
References: <cover.1559730963.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

According to latest docs imx7d chips can go from 800 to 1200 mhz.
Maximum frequency is determined from two speed grading bits present in
OCOTP fuses at same location as other imx chips.

Also update to "typical" voltages from latest datasheet, 25mv higher
than current dts.

All imx7s parts are still fixed at 800mhz

Based on:
* IMX7DCEC Rev. 6, 03/2019
* IMX7SCEC Rev. 6, 03/2019
* IMX7DRM Rev. 1, 01/2018 Page 1102

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 16 +++++++++++++---
 arch/arm/boot/dts/imx7s.dtsi |  4 ++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index f33b560821b8..42528d2812a2 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -10,10 +10,12 @@
 	cpus {
 		cpu0: cpu@0 {
 			clock-frequency = <996000000>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			#cooling-cells = <2>;
+			nvmem-cells = <&cpu_speed_grade>;
+			nvmem-cell-names = "speed_grade";
 		};
 
 		cpu1: cpu@1 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
@@ -37,19 +39,27 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
 		opp-792000000 {
 			opp-hz = /bits/ 64 <792000000>;
-			opp-microvolt = <975000>;
+			opp-microvolt = <1000000>;
 			clock-latency-ns = <150000>;
+			opp-supported-hw = <0xf>, <0xf>;
 		};
 
 		opp-996000000 {
 			opp-hz = /bits/ 64 <996000000>;
-			opp-microvolt = <1075000>;
+			opp-microvolt = <1100000>;
 			clock-latency-ns = <150000>;
-			opp-suspend;
+			opp-supported-hw = <0xc>, <0xf>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1225000>;
+			clock-latency-ns = <150000>;
+			opp-supported-hw = <0x8>, <0xf>;
 		};
 	};
 
 	usbphynop2: usbphynop2 {
 		compatible = "usb-nop-xceiv";
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index d8b4eb67146d..5b8292670b4b 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -549,10 +549,14 @@
 				};
 
 				tempmon_temp_grade: temp-grade@10 {
 					reg = <0x10 0x4>;
 				};
+
+				cpu_speed_grade: speed-grade@10 {
+					reg = <0x10 0x4>;
+				};
 			};
 
 			anatop: anatop@30360000 {
 				compatible = "fsl,imx7d-anatop", "fsl,imx6q-anatop",
 					"syscon", "simple-bus";
-- 
2.7.4

