Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243C02E197F
	for <lists+linux-pm@lfdr.de>; Wed, 23 Dec 2020 08:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgLWHub (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Dec 2020 02:50:31 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:39608 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727063AbgLWHua (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Dec 2020 02:50:30 -0500
X-UUID: 1a5e53b3d5fc4ffb82e6143b380b4e74-20201223
X-UUID: 1a5e53b3d5fc4ffb82e6143b380b4e74-20201223
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 103042784; Wed, 23 Dec 2020 15:49:46 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Dec 2020 15:49:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Dec 2020 15:49:44 +0800
From:   Michael Kao <michael.kao@mediatek.com>
To:     <michael.kao@mediatek.com>, <fan.chen@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <srv_heupstream@mediatek.com>
CC:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hsinyi@chromium.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] arm64: dts: mt8192: add thermal zones, cooling map and trips
Date:   Wed, 23 Dec 2020 15:49:44 +0800
Message-ID: <20201223074944.2061-1-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8E7BA1A4355ECF794BD325262EBA2101F308FC3C1D5B35C546490E00817293EF2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add thermal zone node to support mt8192 read temperature.
Thermal throttle will start at 68C and the
target temperature is 85C.

This patch depends on [1].

[1]https://patchwork.kernel.org/project/linux-mediatek/patch/20201221061018.18503-3-Yz.Wu@mediatek.com/

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 169 +++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 4a0d941aec30..4020e40a092a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "mediatek,mt8192";
@@ -42,6 +43,7 @@
 			clock-frequency = <1701000000>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@100 {
@@ -52,6 +54,7 @@
 			clock-frequency = <1701000000>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@200 {
@@ -62,6 +65,7 @@
 			clock-frequency = <1701000000>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@300 {
@@ -72,6 +76,7 @@
 			clock-frequency = <1701000000>;
 			next-level-cache = <&l2_0>;
 			capacity-dmips-mhz = <530>;
+			#cooling-cells = <2>;
 		};
 
 		cpu4: cpu@400 {
@@ -82,6 +87,7 @@
 			clock-frequency = <2171000000>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
+			#cooling-cells = <2>;
 		};
 
 		cpu5: cpu@500 {
@@ -92,6 +98,7 @@
 			clock-frequency = <2171000000>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
+			#cooling-cells = <2>;
 		};
 
 		cpu6: cpu@600 {
@@ -102,6 +109,7 @@
 			clock-frequency = <2171000000>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
+			#cooling-cells = <2>;
 		};
 
 		cpu7: cpu@700 {
@@ -112,6 +120,7 @@
 			clock-frequency = <2171000000>;
 			next-level-cache = <&l2_1>;
 			capacity-dmips-mhz = <1024>;
+			#cooling-cells = <2>;
 		};
 
 		cpu-map {
@@ -178,6 +187,140 @@
 		method = "smc";
 	};
 
+	thermal-zones {
+		soc_max {
+			polling-delay = <1000>; /* milliseconds */
+			polling-delay-passive = <1000>; /* milliseconds */
+			thermal-sensors = <&lvts 0>;
+			sustainable-power = <1500>;
+
+			trips {
+				threshold: trip-point@0 {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				target: target@1 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				soc_max_crit: soc_max_crit@0 {
+					temperature = <115000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&target>;
+					cooling-device = <&cpu0
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+							 <&cpu1
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+							 <&cpu2
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+							 <&cpu3
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>;
+					contribution = <3072>;
+				};
+				map1 {
+					trip = <&target>;
+					cooling-device = <&cpu4
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+							 <&cpu5
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+							 <&cpu6
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>,
+							 <&cpu7
+						THERMAL_NO_LIMIT
+						THERMAL_NO_LIMIT>;
+					contribution = <1024>;
+				};
+			};
+		};
+		cpu_big1 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 1>;
+		};
+		cpu_big2 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 2>;
+		};
+		cpu_big3 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 3>;
+		};
+		cpu_big4 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 4>;
+		};
+		cci1 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 5>;
+		};
+		cci2 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 6>;
+		};
+		cpu_little1 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 7>;
+		};
+		cpu_little2 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 8>;
+		};
+		apu {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 9>;
+		};
+		mlda {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 10>;
+		};
+		gpu1 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 11>;
+		};
+		gpu2 {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 12>;
+		};
+		infra {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 13>;
+		};
+		camsys {
+			polling-delay = <0>; /* milliseconds */
+			polling-delay-passive = <0>; /* milliseconds */
+			thermal-sensors = <&lvts 14>;
+		};
+	};
+
 	timer: timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
@@ -224,6 +367,10 @@
 			compatible = "mediatek,mt8192-infracfg", "syscon";
 			reg = <0 0x10001000 0 0x1000>;
 			#clock-cells = <1>;
+			ti,reset-bits = <
+				0x120 0 0x124 0 0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE)
+				0x730 12 0x734 12 0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE)
+			>;
 		};
 
 		pericfg: syscon@10003000 {
@@ -318,6 +465,24 @@
 			status = "disabled";
 		};
 
+		lvts: lvts@1100b000 {
+			compatible = "mediatek,mt6873-lvts";
+			#thermal-sensor-cells = <1>;
+			reg = <0 0x1100b000 0 0x1000>,
+			      <0 0x11278000 0 0x1000>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>,
+				<GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			clocks = <&infracfg CLK_INFRA_THERM>;
+			clock-names = "lvts_clk";
+
+			resets = <&infracfg_rst 0>,
+				 <&infracfg_rst 1>;
+
+			nvmem-cells = <&lvts_e_data1>;
+			nvmem-cell-names = "e_data1";
+		};
+
 		spi1: spi@11010000 {
 			compatible = "mediatek,mt8192-spi",
 				     "mediatek,mt6765-spi";
@@ -425,6 +590,10 @@
 		efuse: efuse@11c10000 {
 			compatible = "mediatek,mt8192-efuse",
 				     "mediatek,efuse";
+
+			lvts_e_data1: data1 {
+				reg = <0x1C0 0x58>;
+			};
 		};
 
 		i2c3: i2c3@11cb0000 {
-- 
2.18.0

