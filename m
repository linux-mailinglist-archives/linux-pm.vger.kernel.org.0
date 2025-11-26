Return-Path: <linux-pm+bounces-38715-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4BBC89F02
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 14:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 722CC359518
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 13:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A3121D5B0;
	Wed, 26 Nov 2025 13:05:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69FB1E7C18;
	Wed, 26 Nov 2025 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764162341; cv=none; b=Y8mcgxVXcseTdqnpw+OkNel5kiW2FjDXAspfF5o9wgrruPD1CIp6F+QEFe9daJBQtLu357zOIhIwq4NrlxPFuFn2dukhubUO9VcC7x5OImfD3WpPqdjg3a0Gmb69Zjh8RBuPBYZ+qbW7FyOkZ/itnGtc74feeyX7quRFNOEGBHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764162341; c=relaxed/simple;
	bh=jdkjTDSMIvrVjOQiMzFRPocg2EyqFCWXQ33dCZzd9zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYNu6gXwFUNbcgjMJVtMOuUglYd4xQti/RNVahWNEUDctWkqlDnKaDBtqvGNmUshErVhMryiRLA2EZFV2Yo0vgmVcMYXDeNEOFbce9yhyjn8bCs8zFsVekOG6mr93d3DY3GpInGCWATUX25Ms1wahP/i1U6dDCYvVubI6XVr/HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: nkQIcIctR+uYSCql+k2lyg==
X-CSE-MsgGUID: 6nifkSgFRT+5l4F0asJwNw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 26 Nov 2025 22:05:39 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.98])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AAB85400EF6C;
	Wed, 26 Nov 2025 22:05:34 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 9/9] arm64: dts: renesas: r9a09g087: add TSU and thermal zones support
Date: Wed, 26 Nov 2025 15:03:56 +0200
Message-ID: <20251126130356.2768625-10-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com>
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
V3:
 * no changes

V2:
 * no changes

 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index 64a7f94ab316..c742a67663cc 100644
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
@@ -955,6 +970,37 @@ sdhi1_vqmmc: vqmmc-regulator {
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
2.52.0


