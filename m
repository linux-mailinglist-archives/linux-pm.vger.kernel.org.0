Return-Path: <linux-pm+bounces-36703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0047DBFFE1A
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 10:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16C0E353C7B
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 08:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016D62FE061;
	Thu, 23 Oct 2025 08:21:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18622FF152;
	Thu, 23 Oct 2025 08:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207678; cv=none; b=f8hG6l5eWUPb3njBISuR7bx/dQUPeyZNkbIfp2JR5vVtvvFGrSRpKoI+EwFWp3JMnlAuhAj7iq7x05GmXUuJfreLn/MlEXa7XxtWu/TgZrR/hKQVlnMizBQgRZZ/8uv+1nA4pDLJhiYJhgk+JWzL6igklSd2u3lTHM5AeFaISOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207678; c=relaxed/simple;
	bh=Pg7tjeq7r3AX9QT2iM2Pps0AvibFReG3mtK6Z/Newus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ab24PIh/GiAFt5d6BB/ROVzJzMM49cN8WzJEOHG4xNKxVO4qrQVzVhlGsQMJAU5u0AGZPFApzPqizdxXADi70iQKV+RdOiWCukkEeQYoV7EMF1WWkaT8M8/jMOpfn+/OqMlYXIDDbtDFWfLi5Y+N6jUVyVOeWh3DeZ1BZA4iuAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: Ir7V6Xz6RZG6rhRsZ9GM8g==
X-CSE-MsgGUID: kc63CY+wQVOikdpb03IcJA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 23 Oct 2025 17:21:11 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.77])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0A230417DE80;
	Thu, 23 Oct 2025 17:21:05 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: 
Cc: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 10/10] arm64: dts: renesas: r9a09g087: add TSU and thermal zones support
Date: Thu, 23 Oct 2025 11:19:24 +0300
Message-ID: <20251023081925.2412325-11-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251023081925.2412325-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251023081925.2412325-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/N2H (R9A09G087) SoC includes a Temperature Sensor Unit
(TSU). The device provides real-time temperature measurements for
thermal management, utilizing a single dedicated channel for temperature
sensing.

The TSU loads calibration data via SMC SIP.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index 5eef8c18037e..db117b6f75a1 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -36,6 +36,7 @@ cpu0: cpu@0 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_CA55C0>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -46,6 +47,7 @@ cpu1: cpu@100 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_CA55C1>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -56,6 +58,7 @@ cpu2: cpu@200 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_CA55C2>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -66,6 +69,7 @@ cpu3: cpu@300 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_CA55C3>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -244,6 +248,17 @@ wdt5: watchdog@80083400 {
 			status = "disabled";
 		};
 
+		tsu: thermal@80086000 {
+			compatible = "renesas,r9a09g087-tsu", "renesas,r9a09g077-tsu";
+			reg = <0 0x80086000 0 0x1000>;
+			interrupts = <GIC_SPI 713 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 714 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "adi", "adcmpi";
+			clocks = <&cpg CPG_MOD 307>;
+			power-domains = <&cpg>;
+			#thermal-sensor-cells = <0>;
+		};
+
 		i2c0: i2c@80088000 {
 			compatible = "renesas,riic-r9a09g087", "renesas,riic-r9a09g077";
 			reg = <0 0x80088000 0 0x400>;
@@ -844,6 +859,37 @@ sdhi1_vqmmc: vqmmc-regulator {
 		};
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&tsu>;
+
+			cooling-maps {
+				map0 {
+					trip = <&target>;
+					cooling-device = <&cpu0 0 1>, <&cpu1 0 1>,
+							 <&cpu2 0 1>, <&cpu3 0 1>;
+					contribution = <1024>;
+				};
+			};
+
+			trips {
+				target: trip-point {
+					temperature = <95000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				sensor_crit: sensor-crit {
+					temperature = <120000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	stmmac_axi_setup: stmmac-axi-config {
 		snps,lpi_en;
 		snps,wr_osr_lmt = <0xf>;
-- 
2.51.1.dirty


