Return-Path: <linux-pm+bounces-36472-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE56BF1DD7
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 16:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9561D404160
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 14:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB4922A817;
	Mon, 20 Oct 2025 14:31:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAA71A239A;
	Mon, 20 Oct 2025 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970694; cv=none; b=r/TMjHL1c0lknFzsQnfADVF9/qmwKaZQbYN0TieMLkz3U1RaM5l0Z6KkIz/ayXHjU+I84Uo64b0o6V3uMOUnoGg9LhhBniOvemmeFPaSsYkRQ/Vi4NE/pQpdeeYmDi41ZXMNoVD8mZKLR989nblGN8PUbI55pu/K/nLdJluoqL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970694; c=relaxed/simple;
	bh=Bty+vvqO0kZ7CUd0Q2nqj5ngueUp9769n2FevdwMEyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGxYKNxFVmm4UAcHjlSQsn8kV64xFRIfVAclN/Mu47HYDiHfuNUdLt1ybF0hC49Ycd76FyjUw8aGQAjXMVwEaBvUE5YXCNuQZ1Tyvvxh5xmNyQY4oibtotuOuNJ5zC/+DQCCXQGo8pI/CNnTy/4wbujRWv9SYIbImqq0r+vHsOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: qPnqo77zQLGKHJRIXyqJhg==
X-CSE-MsgGUID: pMNaHPNaRwSsplcJ/xXfBw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Oct 2025 23:31:31 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.23])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 46A8F41CCD99;
	Mon, 20 Oct 2025 23:31:25 +0900 (JST)
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
Subject: [PATCH v2 3/3] arm64: dts: renesas: r9a09g057: Add TSU nodes
Date: Mon, 20 Oct 2025 14:31:07 +0000
Message-ID: <20251020143107.13974-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020143107.13974-1-ovidiu.panait.rb@renesas.com>
References: <20251020143107.13974-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/V2H SoC includes a Thermal Sensor Unit (TSU) block designed
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
v2 changes: none

 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
index e426b9978e22..e88cfc965415 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -65,6 +65,7 @@ cpu0: cpu@0 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G057_CA55_0_CORE_CLK0>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -75,6 +76,7 @@ cpu1: cpu@100 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G057_CA55_0_CORE_CLK1>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -85,6 +87,7 @@ cpu2: cpu@200 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G057_CA55_0_CORE_CLK2>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -95,6 +98,7 @@ cpu3: cpu@300 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G057_CA55_0_CORE_CLK3>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -285,6 +289,32 @@ sys: system-controller@10430000 {
 			resets = <&cpg 0x30>;
 		};
 
+		tsu0: thermal@11000000 {
+			compatible = "renesas,r9a09g057-tsu", "renesas,r9a09g047-tsu";
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
+			compatible = "renesas,r9a09g057-tsu", "renesas,r9a09g047-tsu";
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
 			compatible = "renesas,r9a09g057-xspi", "renesas,r9a09g047-xspi";
 			reg = <0 0x11030000 0 0x10000>,
@@ -1326,6 +1356,51 @@ stmmac_axi_setup: stmmac-axi-config {
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


