Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 522D917BB0C
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 12:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgCFLAa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 06:00:30 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:37770 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFLAa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Mar 2020 06:00:30 -0500
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id Az0T2200F5USYZQ06z0TPW; Fri, 06 Mar 2020 12:00:27 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jAAiR-0004Ax-EW; Fri, 06 Mar 2020 12:00:27 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jAAiR-0006Rt-CJ; Fri, 06 Mar 2020 12:00:27 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Magnus Damm <magnus.damm@gmail.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] arm64: dts: renesas: r8a77961: Add thermal nodes
Date:   Fri,  6 Mar 2020 12:00:25 +0100
Message-Id: <20200306110025.24747-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a device node for the Thermal Sensor/Chip Internal Voltage Monitor
in the R-Car M3-W+ (R8A77961) SoC, and describe the thermal zones.

According to the R-Car Gen3 Hardware Manual Errata for Revision 2.00 of
Jan 31, 2020, the thermal parameters for R-Car M3-W+ are the same as for
R-Car M3-W.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
It's a bit cold in Magnus' lab:

/ # grep . /sys/devices/virtual/thermal/thermal_zone?/temp
/sys/devices/virtual/thermal/thermal_zone0/temp:17000
/sys/devices/virtual/thermal/thermal_zone1/temp:19000
/sys/devices/virtual/thermal/thermal_zone2/temp:18000
---
 arch/arm64/boot/dts/renesas/r8a77961.dtsi | 80 +++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77961.dtsi b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
index b6915319a61c8bf0..2f016458f57d3a33 100644
--- a/arch/arm64/boot/dts/renesas/r8a77961.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
@@ -474,6 +474,20 @@
 			#power-domain-cells = <1>;
 		};
 
+		tsc: thermal@e6198000 {
+			compatible = "renesas,r8a77961-thermal";
+			reg = <0 0xe6198000 0 0x100>,
+			      <0 0xe61a0000 0 0x100>,
+			      <0 0xe61a8000 0 0x100>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 522>;
+			power-domains = <&sysc R8A77961_PD_ALWAYS_ON>;
+			resets = <&cpg 522>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		intc_ex: interrupt-controller@e61c0000 {
 			#interrupt-cells = <2>;
 			interrupt-controller;
@@ -785,6 +799,7 @@
 			status = "disabled";
 		};
 
+
 		pwm1: pwm@e6e31000 {
 			reg = <0 0xe6e31000 0 8>;
 			#pwm-cells = <2>;
@@ -1073,6 +1088,71 @@
 		};
 	};
 
+	thermal-zones {
+		sensor_thermal1: sensor-thermal1 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsc 0>;
+			sustainable-power = <3874>;
+
+			trips {
+				sensor1_crit: sensor1-crit {
+					temperature = <120000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		sensor_thermal2: sensor-thermal2 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsc 1>;
+			sustainable-power = <3874>;
+
+			trips {
+				sensor2_crit: sensor2-crit {
+					temperature = <120000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+
+		sensor_thermal3: sensor-thermal3 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsc 2>;
+			sustainable-power = <3874>;
+
+			cooling-maps {
+				map0 {
+					trip = <&target>;
+					cooling-device = <&a57_0 2 4>;
+					contribution = <1024>;
+				};
+				map1 {
+					trip = <&target>;
+					cooling-device = <&a53_0 0 2>;
+					contribution = <1024>;
+				};
+			};
+			trips {
+				target: trip-point1 {
+					temperature = <100000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				sensor3_crit: sensor3-crit {
+					temperature = <120000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
-- 
2.17.1

