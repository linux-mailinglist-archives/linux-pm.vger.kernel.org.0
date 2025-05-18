Return-Path: <linux-pm+bounces-27284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA157ABB20D
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 00:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28955174885
	for <lists+linux-pm@lfdr.de>; Sun, 18 May 2025 22:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3E2210F4B;
	Sun, 18 May 2025 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="CmfOmI/t"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D854C20E6E4
	for <linux-pm@vger.kernel.org>; Sun, 18 May 2025 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747606074; cv=none; b=geOcjf6iI89ly5hON8VMaTaNI66+Bc7gv0yNqO64xVxFnzrgX3ZfCY/fjw4VQxq2+YxX3skKDypGoNQkfSzuRZylQWdOhSPhBNL7cML214XMKY+ErQ9TIp6IckToKAvc0YA/3ZwbSZR6O1pryWIcSS4bi6koCx68cVLN3ROSD6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747606074; c=relaxed/simple;
	bh=zdjUX70/2vnzr8WWpb97lZD/S0KJr376bHXyAhB+Xng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oENPMl9ZmtDqD0fvtx84+LCeQ25OokR8ATDG/gF0PJYdw4RFAFQWg1keQFgsQSkRiuO7UU7RXPDq+SIGgmN6b13TCFUE4gDWh2SUjLcJYNYLObPsqGhT50Xv1Nc4xu3MS6G5Bvd8+7Vokq9x6ru06g3k/rNv+HyWpiY+O9Ibf8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=CmfOmI/t; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1747606071; bh=pxIzyIRGSrPy+fjzyg+1dQ5Aa4JTc3K1g+7QXk/QVO8=;
 b=CmfOmI/tPHp7WAoSJlawiUmCtQYKt4I+kcQdSQrHom1u1JYGrOpFn1W+3rrxMb/POtOjDbv+X
 UbJJEGXzcx9dK6CCVP153qKYbbpFfD3RdbLEPyUYbi4BJMlDCV5vjiR/oHH4yXpfcsxpXt2fjvC
 XmpkTzEGpwod+lEeZsRfZbLOsmfkH6F2Kf9VBa1Dkd5K9OeSU7LAPNoKWMcIZqjYYHVSqzM6d7U
 qSCWaOnZ5bPJeSOecwe5E94xqYLISfjawQZy92yM1VtzDF2C4uET2MWCqyw8/qhd3KwogOuMOUS
 UWtXUE19Fzy9NzdHl2qjh3dqZj/gLSUUwu/hVgzYaC/A==
X-Forward-Email-ID: 682a5a3778cae75fbd8d472e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] arm64: dts: rockchip: Enable more power domains for RK3528
Date: Sun, 18 May 2025 22:06:56 +0000
Message-ID: <20250518220707.669515-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250518220707.669515-1-jonas@kwiboo.se>
References: <20250518220707.669515-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe device power-domains and enable the PD_RKVENC, PD_VO and PD_VPU
power-domains on RK3528.

The PD_RKVDEC is used by RKVDEC and DDRPHY CRU, and is kept disabled to
prevent a full system reset trying to read the rate of the SCMI_CLK_DDR
clock.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 28 +++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index c13a6a566164..791cb9b1e8f1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -403,7 +403,6 @@ power-domain@RK3528_PD_RKVENC {
 					reg = <RK3528_PD_RKVENC>;
 					pm_qos = <&qos_rkvenc>;
 					#power-domain-cells = <0>;
-					status = "disabled";
 				};
 				power-domain@RK3528_PD_VO {
 					reg = <RK3528_PD_VO>;
@@ -417,7 +416,6 @@ power-domain@RK3528_PD_VO {
 						 <&qos_vdpp>,
 						 <&qos_vop>;
 					#power-domain-cells = <0>;
-					status = "disabled";
 				};
 				power-domain@RK3528_PD_VPU {
 					reg = <RK3528_PD_VPU>;
@@ -431,7 +429,6 @@ power-domain@RK3528_PD_VPU {
 						 <&qos_usb3otg>,
 						 <&qos_vpu>;
 					#power-domain-cells = <0>;
-					status = "disabled";
 				};
 			};
 		};
@@ -455,6 +452,7 @@ uart1: serial@ff9f8000 {
 			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&dmac 10>, <&dmac 11>;
+			power-domains = <&power RK3528_PD_RKVENC>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			status = "disabled";
@@ -467,6 +465,7 @@ uart2: serial@ffa00000 {
 			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&dmac 12>, <&dmac 13>;
+			power-domains = <&power RK3528_PD_VPU>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			status = "disabled";
@@ -479,6 +478,7 @@ uart3: serial@ffa08000 {
 			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&dmac 14>, <&dmac 15>;
+			power-domains = <&power RK3528_PD_RKVENC>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			status = "disabled";
@@ -491,6 +491,7 @@ uart4: serial@ffa10000 {
 			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&dmac 16>, <&dmac 17>;
+			power-domains = <&power RK3528_PD_VO>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			status = "disabled";
@@ -503,6 +504,7 @@ uart5: serial@ffa18000 {
 			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&dmac 18>, <&dmac 19>;
+			power-domains = <&power RK3528_PD_VPU>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			status = "disabled";
@@ -515,6 +517,7 @@ uart6: serial@ffa20000 {
 			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&dmac 20>, <&dmac 21>;
+			power-domains = <&power RK3528_PD_VPU>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			status = "disabled";
@@ -527,6 +530,7 @@ uart7: serial@ffa28000 {
 			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&dmac 22>, <&dmac 23>;
+			power-domains = <&power RK3528_PD_VPU>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			status = "disabled";
@@ -539,6 +543,7 @@ i2c0: i2c@ffa50000 {
 			clocks = <&cru CLK_I2C0>, <&cru PCLK_I2C0>;
 			clock-names = "i2c", "pclk";
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&power RK3528_PD_RKVENC>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -551,6 +556,7 @@ i2c1: i2c@ffa58000 {
 			clocks = <&cru CLK_I2C1>, <&cru PCLK_I2C1>;
 			clock-names = "i2c", "pclk";
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&power RK3528_PD_RKVENC>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -577,6 +583,7 @@ i2c3: i2c@ffa68000 {
 			clocks = <&cru CLK_I2C3>, <&cru PCLK_I2C3>;
 			clock-names = "i2c", "pclk";
 			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&power RK3528_PD_VPU>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -591,6 +598,7 @@ i2c4: i2c@ffa70000 {
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c4_xfer>;
+			power-domains = <&power RK3528_PD_VO>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -603,6 +611,7 @@ i2c5: i2c@ffa78000 {
 			clocks = <&cru CLK_I2C5>, <&cru PCLK_I2C5>;
 			clock-names = "i2c", "pclk";
 			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&power RK3528_PD_VPU>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -615,6 +624,7 @@ i2c6: i2c@ffa80000 {
 			clocks = <&cru CLK_I2C6>, <&cru PCLK_I2C6>;
 			clock-names = "i2c", "pclk";
 			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&power RK3528_PD_VPU>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -629,6 +639,7 @@ i2c7: i2c@ffa88000 {
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c7_xfer>;
+			power-domains = <&power RK3528_PD_VO>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -720,6 +731,7 @@ saradc: adc@ffae0000 {
 			clocks = <&cru CLK_SARADC>, <&cru PCLK_SARADC>;
 			clock-names = "saradc", "apb_pclk";
 			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&power RK3528_PD_VPU>;
 			resets = <&cru SRST_P_SARADC>;
 			reset-names = "saradc-apb";
 			#io-channel-cells = <1>;
@@ -740,6 +752,7 @@ gmac0: ethernet@ffbd0000 {
 			interrupt-names = "macirq", "eth_wake_irq";
 			phy-handle = <&rmii0_phy>;
 			phy-mode = "rmii";
+			power-domains = <&power RK3528_PD_VO>;
 			resets = <&cru SRST_A_MAC_VO>;
 			reset-names = "stmmaceth";
 			rockchip,grf = <&vo_grf>;
@@ -798,6 +811,7 @@ gmac1: ethernet@ffbe0000 {
 			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq", "eth_wake_irq";
+			power-domains = <&power RK3528_PD_VPU>;
 			resets = <&cru SRST_A_MAC>;
 			reset-names = "stmmaceth";
 			rockchip,grf = <&vpu_grf>;
@@ -848,6 +862,7 @@ sdhci: mmc@ffbf0000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&emmc_bus8>, <&emmc_clk>, <&emmc_cmd>,
 				    <&emmc_strb>;
+			power-domains = <&power RK3528_PD_VPU>;
 			resets = <&cru SRST_C_EMMC>, <&cru SRST_H_EMMC>,
 				 <&cru SRST_A_EMMC>, <&cru SRST_B_EMMC>,
 				 <&cru SRST_T_EMMC>;
@@ -869,6 +884,7 @@ sdio0: mmc@ffc10000 {
 			max-frequency = <200000000>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&sdio0_bus4>, <&sdio0_clk>, <&sdio0_cmd>;
+			power-domains = <&power RK3528_PD_VPU>;
 			resets = <&cru SRST_H_SDIO0>;
 			reset-names = "reset";
 			status = "disabled";
@@ -888,6 +904,7 @@ sdio1: mmc@ffc20000 {
 			max-frequency = <200000000>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&sdio1_bus4>, <&sdio1_clk>, <&sdio1_cmd>;
+			power-domains = <&power RK3528_PD_VPU>;
 			resets = <&cru SRST_H_SDIO1>;
 			reset-names = "reset";
 			status = "disabled";
@@ -908,6 +925,7 @@ sdmmc: mmc@ffc30000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&sdmmc_bus4>, <&sdmmc_clk>, <&sdmmc_cmd>,
 				    <&sdmmc_det>;
+			power-domains = <&power RK3528_PD_VO>;
 			resets = <&cru SRST_H_SDMMC0>;
 			reset-names = "reset";
 			rockchip,default-sample-phase = <90>;
@@ -961,6 +979,7 @@ gpio1: gpio@ffaf0000 {
 				gpio-ranges = <&pinctrl 0 32 32>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				power-domains = <&power RK3528_PD_VPU>;
 			};
 
 			gpio2: gpio@ffb00000 {
@@ -973,6 +992,7 @@ gpio2: gpio@ffb00000 {
 				gpio-ranges = <&pinctrl 0 64 32>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				power-domains = <&power RK3528_PD_VO>;
 			};
 
 			gpio3: gpio@ffb10000 {
@@ -985,6 +1005,7 @@ gpio3: gpio@ffb10000 {
 				gpio-ranges = <&pinctrl 0 96 32>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				power-domains = <&power RK3528_PD_VPU>;
 			};
 
 			gpio4: gpio@ffb20000 {
@@ -997,6 +1018,7 @@ gpio4: gpio@ffb20000 {
 				gpio-ranges = <&pinctrl 0 128 32>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				power-domains = <&power RK3528_PD_RKVENC>;
 			};
 		};
 	};
-- 
2.49.0


