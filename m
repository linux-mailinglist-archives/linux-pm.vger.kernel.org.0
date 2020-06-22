Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82046202EB9
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 05:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731216AbgFVDAY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Jun 2020 23:00:24 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:59029 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731156AbgFVDAY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jun 2020 23:00:24 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.569625-0.000627772-0.429747;FP=0|0|0|0|0|-1|-1|-1;HT=e01l10434;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.HqMydez_1592794774;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.HqMydez_1592794774)
          by smtp.aliyun-inc.com(10.147.40.44);
          Mon, 22 Jun 2020 11:00:15 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        srinivas.kandagatla@linaro.org, linus.walleij@linaro.org,
        anarsoul@gmail.com, tiny.windzz@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        p.zabel@pengutronix.de, clabbe@baylibre.com, icenowy@aosc.io,
        megous@megous.com, karlp@tweak.net.au, bage@linutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        huangshuosheng@allwinnertech.com, liyong@allwinnertech.com,
        Frank Lee <frank@allwinnertech.com>
Subject: [PATCH v2 09/11] arm64: allwinner: A100: add the basical Allwinner A100 DTSI file
Date:   Mon, 22 Jun 2020 10:59:05 +0800
Message-Id: <20200622025907.32574-10-frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200622025907.32574-1-frank@allwinnertech.com>
References: <20200622025907.32574-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Allwinner A100 is a new SoC with Cortex-A53 cores, this commit adds
the basical DTSI file of it, including the clock, i2c, pins, sid, ths,
and UART support.

Signed-off-by: Frank Lee <frank@allwinnertech.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 337 +++++++++++++++++++++++++
 1 file changed, 337 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
new file mode 100644
index 0000000..5133897
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (c) 2020 Frank Lee <frank@allwinnertech.com>
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/sun50i-a100-ccu.h>
+#include <dt-bindings/clock/sun50i-a100-r-ccu.h>
+#include <dt-bindings/reset/sun50i-a100-ccu.h>
+#include <dt-bindings/reset/sun50i-a100-r-ccu.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,armv8";
+			device_type = "cpu";
+			reg = <0x0>;
+			enable-method = "psci";
+		};
+
+		cpu@1 {
+			compatible = "arm,armv8";
+			device_type = "cpu";
+			reg = <0x1>;
+			enable-method = "psci";
+		};
+
+		cpu@2 {
+			compatible = "arm,armv8";
+			device_type = "cpu";
+			reg = <0x2>;
+			enable-method = "psci";
+		};
+
+		cpu@3 {
+			compatible = "arm,armv8";
+			device_type = "cpu";
+			reg = <0x3>;
+			enable-method = "psci";
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	iosc: internal-osc-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <16000000>;
+		clock-accuracy = <300000000>;
+		clock-output-names = "iosc";
+		#clock-cells = <0>;
+	};
+
+	dcxo24M: dcxo24M_clk {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "dcxo24M";
+		#clock-cells = <0>;
+	};
+
+	osc32k: osc32k_clk {
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		clock-output-names = "osc32k";
+		#clock-cells = <0>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 14
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 11
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 10
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ccu: clock@3001000 {
+			compatible = "allwinner,sun50i-a100-ccu";
+			reg = <0x0 0x03001000 0x0 0x1000>;
+			clocks = <&dcxo24M>, <&osc32k>, <&iosc>;
+			clock-names = "hosc", "losc", "iosc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		gic: interrupt-controller@3021000 {
+			compatible = "arm,gic-400";
+			reg = <0x0 0x03021000 0x0 0x1000>,
+			      <0x0 0x03022000 0x0 0x2000>,
+			      <0x0 0x03024000 0x0 0x2000>,
+			      <0x0 0x03026000 0x0 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
+						 IRQ_TYPE_LEVEL_HIGH)>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
+		sid@3006000 {
+			compatible = "allwinner,sun50i-a100-sid";
+			reg = <0x0 0x03006000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ths_calibration: calib@14 {
+				reg = <0x14 8>;
+			};
+		};
+
+		pio: pinctrl@300b000 {
+			compatible = "allwinner,sun50i-a100-pinctrl";
+			reg = <0x0 0x0300b000 0x0 0x400>;
+			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_APB1>, <&dcxo24M>, <&osc32k>;
+			clock-names = "apb", "hosc", "losc";
+			gpio-controller;
+			#gpio-cells = <3>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+
+			uart0_pb_pins: uart0-pb-pins {
+				pins = "PB9", "PB10";
+				function = "uart0";
+			};
+		};
+
+		uart0: serial@5000000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x05000000 0x0 0x400>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART0>;
+			resets = <&ccu RST_BUS_UART0>;
+			status = "disabled";
+		};
+
+		uart1: serial@5000400 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x05000400 0x0 0x400>;
+			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART1>;
+			resets = <&ccu RST_BUS_UART1>;
+			status = "disabled";
+		};
+
+		uart2: serial@5000800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x05000800 0x0 0x400>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART2>;
+			resets = <&ccu RST_BUS_UART2>;
+			status = "disabled";
+		};
+
+		uart3: serial@5000c00 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x05000c00 0x0 0x400>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART3>;
+			resets = <&ccu RST_BUS_UART3>;
+			status = "disabled";
+		};
+
+		uart4: serial@5001000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x05001000 0x0 0x400>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART4>;
+			resets = <&ccu RST_BUS_UART4>;
+			status = "disabled";
+		};
+
+		i2c0: i2c@5002000 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x0 0x05002000 0x0 0x400>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C0>;
+			resets = <&ccu RST_BUS_I2C0>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c1: i2c@5002400 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x0 0x05002400 0x0 0x400>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C1>;
+			resets = <&ccu RST_BUS_I2C1>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c2: i2c@5002800 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x0 0x05002800 0x0 0x400>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C2>;
+			resets = <&ccu RST_BUS_I2C2>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c3: i2c@5002c00 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x0 0x05002c00 0x0 0x400>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C3>;
+			resets = <&ccu RST_BUS_I2C3>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		ths: thermal-sensor@5070400 {
+			compatible = "allwinner,sun50i-a100-ths";
+			reg = <0x0 0x05070400 0x0 0x100>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_THS>;
+			clock-names = "bus";
+			resets = <&ccu RST_BUS_THS>;
+			nvmem-cells = <&ths_calibration>;
+			nvmem-cell-names = "calibration";
+			#thermal-sensor-cells = <1>;
+		};
+
+		r_ccu: clock@7010000 {
+			compatible = "allwinner,sun50i-a100-r-ccu";
+			reg = <0x0 0x07010000 0x0 0x300>;
+			clocks = <&dcxo24M>, <&osc32k>, <&iosc>,
+				 <&ccu CLK_PLL_PERIPH0>;
+			clock-names = "hosc", "losc", "iosc", "pll-periph";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		r_pio: pinctrl@7022000 {
+			compatible = "allwinner,sun50i-a100-r-pinctrl";
+			reg = <0x0 0x07022000 0x0 0x400>;
+			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&r_ccu CLK_R_APB1>, <&dcxo24M>, <&osc32k>;
+			clock-names = "apb", "hosc", "losc";
+			gpio-controller;
+			#gpio-cells = <3>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+
+			r_i2c0_pins: r-i2c0-pins {
+				pins = "PL0", "PL1";
+				function = "s_i2c0";
+			};
+
+			r_i2c1_pins: r-i2c1-pins {
+				pins = "PL8", "PL9";
+				function = "s_i2c1";
+			};
+		};
+
+		r_i2c0: i2c@7081400 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x0 0x07081400 0x0 0x400>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C0>;
+			resets = <&ccu RST_BUS_I2C0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_i2c0_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		r_i2c1: i2c@7081800 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x0 0x07081800 0x0 0x400>;
+			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C1>;
+			resets = <&ccu RST_BUS_I2C1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_i2c1_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	thermal-zones {
+		cpu_thermal_zone {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 0>;
+		};
+		gpu_thermal_zone{
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 1>;
+		};
+		ddr_thermal_zone{
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 2>;
+		};
+	};
+};
-- 
1.9.1

