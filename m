Return-Path: <linux-pm+bounces-36980-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD752C14DA8
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 14:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E151421209
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 13:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61F03328F5;
	Tue, 28 Oct 2025 13:26:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B00331A50;
	Tue, 28 Oct 2025 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658016; cv=none; b=OrLWsDF0ERkscPl2fS/4ywZJzSLvLeF64SkN44pmci6jgm5eA9pAjHjTduqvGyBRkw80iziKgwltEwUBDsvdDcTw5iGcrpqHLl8XGSPRcDp3Syn4JScW7bzcrNXYjygKYBbDRKngGqV0eZJvPxw/+sr34o29eqrZvHLD6cR9cEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658016; c=relaxed/simple;
	bh=V4L/H30OuBlemwDlVM8ADYwYLpVGXZKR1xdAcxgluVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRZa9LgDKG+AuRbJGgX8ESaTZg31o5iZM34SwFmLqWzPziCaZs2CK4WreGeyBp9pdhsWEdqnrwLJhn9vs1jq3i7jYpR9944P3drMF+GP4gGjITlUAPRaeL9hFFKvhT/kMWd9PMjdtZWOuJJwbWgRGNjl6np7F+1DJDJratjsdPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: I4wMIvZwTSGVxiOVXjc90Q==
X-CSE-MsgGUID: BYQX+M04TrKSPZh6O30p3Q==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 28 Oct 2025 22:26:53 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.5])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A3F2C40078A8;
	Tue, 28 Oct 2025 22:26:48 +0900 (JST)
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
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v2 9/9] arm64: dts: renesas: r9a09g087: add TSU and thermal zones support
Date: Tue, 28 Oct 2025 15:25:17 +0200
Message-ID: <20251028132519.1472676-10-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028132519.1472676-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251028132519.1472676-1-cosmin-gabriel.tanislav.xa@renesas.com>
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
2.51.1


