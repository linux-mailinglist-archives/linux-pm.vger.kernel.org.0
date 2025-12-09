Return-Path: <linux-pm+bounces-39338-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 509DCCAF688
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 10:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09B2C308DAF1
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 09:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1A82D0C82;
	Tue,  9 Dec 2025 09:11:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3F928B4FD;
	Tue,  9 Dec 2025 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765271502; cv=none; b=fqN+O6MASbeeumYZn1xwmzmPFwI+gxIz5iL7bkmy0+YPOSYzGxiOmr/lmn3o0Ps58iCSwgVgHApUd7EcExP7j0M1MiOAsXWf/G1bW9olksxZU2GQWBSMTvu75aNvrX7rIjWstQ6ceoQz+naU4tWJiCT/9FpTHfX4IHjqFgmSBU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765271502; c=relaxed/simple;
	bh=yRkqzoKV3n6zFPJocmJIqr17hOM4ahDb5J7rmZJnUa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uR68/c5vMbHhlGF7U+/KtcmN8xua1HcBvWaqeLggcMI8YXgMCYiPKEVR/lO8keSD8AWBG0e/fjShpt8Ghp0ibCuONBt0em7Ypu6bqZ8HbVGh8B2PFXcWFsVP5ShRzevGTPyqgdUcZyl7pVD0vfUyJSqelM030R9ghQ6Ywe935R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: QggkPq7eTByu+mLvWXrxfQ==
X-CSE-MsgGUID: KoiSG0bKTUyae2CfrXvZyA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 09 Dec 2025 18:11:39 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.124])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 638B740071EC;
	Tue,  9 Dec 2025 18:11:34 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: john.madieu.xa@bp.renesas.com,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: renesas: r9a09g056: Add TSU nodes
Date: Tue,  9 Dec 2025 09:11:15 +0000
Message-ID: <20251209091115.8541-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209091115.8541-1-ovidiu.panait.rb@renesas.com>
References: <20251209091115.8541-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/V2N SoC includes a Thermal Sensor Unit (TSU) block designed
to measure the junction temperature. The device provides real-time
temperature measurements for thermal management, utilizing two dedicated
channels for temperature sensing:
- TSU0, which is located near the DRP-AI block
- TSU1, which is located near the CPU and DRP-AI block

Since TSU1 is physically closer the CPU and the highest temperature
spot, it is used for CPU throttling through a passive trip and cooling
map. TSU0 is configured only with a critical trip.

Add TSU nodes along with thermal zones and keep them enabled in the SoC
DTSI.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
index 8781c2fa7313..5035ffdda79b 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g056.dtsi
@@ -83,6 +83,7 @@ cpu0: cpu@0 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G056_CA55_0_CORE_CLK0>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -93,6 +94,7 @@ cpu1: cpu@100 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G056_CA55_0_CORE_CLK1>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -103,6 +105,7 @@ cpu2: cpu@200 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G056_CA55_0_CORE_CLK2>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -113,6 +116,7 @@ cpu3: cpu@300 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G056_CA55_0_CORE_CLK3>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -211,6 +215,32 @@ sys: system-controller@10430000 {
 			resets = <&cpg 0x30>;
 		};
 
+		tsu0: thermal@11000000 {
+			compatible = "renesas,r9a09g056-tsu", "renesas,r9a09g047-tsu";
+			reg = <0 0x11000000 0 0x1000>;
+			interrupts = <GIC_SPI 248 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "adi", "adcmpi";
+			clocks = <&cpg CPG_MOD 0x109>;
+			resets = <&cpg 0xf7>;
+			power-domains = <&cpg>;
+			#thermal-sensor-cells = <0>;
+			renesas,tsu-trim = <&sys 0x320>;
+		};
+
+		tsu1: thermal@14002000 {
+			compatible = "renesas,r9a09g056-tsu", "renesas,r9a09g047-tsu";
+			reg = <0 0x14002000 0 0x1000>;
+			interrupts = <GIC_SPI 250 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "adi", "adcmpi";
+			clocks = <&cpg CPG_MOD 0x10a>;
+			resets = <&cpg 0xf8>;
+			power-domains = <&cpg>;
+			#thermal-sensor-cells = <0>;
+			renesas,tsu-trim = <&sys 0x330>;
+		};
+
 		xspi: spi@11030000 {
 			compatible = "renesas,r9a09g056-xspi", "renesas,r9a09g047-xspi";
 			reg = <0 0x11030000 0 0x10000>,
@@ -964,6 +994,51 @@ stmmac_axi_setup: stmmac-axi-config {
 		snps,blen = <16 8 4 0 0 0 0>;
 	};
 
+	thermal-zones {
+		sensor1_thermal: sensor1-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&tsu0>;
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
+		sensor2_thermal: sensor2-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&tsu1>;
+
+			cooling-maps {
+				map0 {
+					trip = <&sensor2_target>;
+					cooling-device = <&cpu0 0 3>, <&cpu1 0 3>,
+							 <&cpu2 0 3>, <&cpu3 0 3>;
+					contribution = <1024>;
+				};
+			};
+
+			trips {
+				sensor2_target: trip-point {
+					temperature = <95000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				sensor2_crit: sensor2-crit {
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
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-- 
2.51.0


