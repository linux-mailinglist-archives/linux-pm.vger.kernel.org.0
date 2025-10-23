Return-Path: <linux-pm+bounces-36702-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E68BFFE08
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 10:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2E11A60071
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 08:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8320D2FE049;
	Thu, 23 Oct 2025 08:21:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E0D2FDC29;
	Thu, 23 Oct 2025 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207667; cv=none; b=R4UQL35kKuM/EkZF/hDTr+cJR9hACZY8O6XbKfaH+AL7+2k9EWrNJXZN5YtS8wFsRNF/OaFoj3aCT2jKtOK1B3Gm1SdcqQjP/F6ljkXWsMqN7UG4pcUaDUfkUTTtT9UqCXsLmAr9FfOtuTF+CwaOst0DlIhFGUrzh+SjBfLoo3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207667; c=relaxed/simple;
	bh=LVA7GW9F8kSaUEOhYwNRsN+xXvpmnUqTQ2XuynWD3yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ab8bpX/3J2+/J26rx/oHh//Q086umVmoTA+g5mMzc2hauW6cQZ5krjWVR/PM6vmoZ2iG7nuSe4sVddoS5It6zV4DRqnDWLuR/vbkUtZND907P8NYVDQrJcKOMaBMY/uOsOmgQl2yog0qUjAsvinl7tI2b1BAHyFCq4bWBNtQ/PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: JFA/p9RvSr6WN9k7w2zS5g==
X-CSE-MsgGUID: Rq2fLBgjTiqzZImYTs6fVQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 23 Oct 2025 17:21:04 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.77])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id F2878417CA94;
	Thu, 23 Oct 2025 17:20:58 +0900 (JST)
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
Subject: [PATCH 09/10] arm64: dts: renesas: r9a09g077: add TSU and thermal zones support
Date: Thu, 23 Oct 2025 11:19:23 +0300
Message-ID: <20251023081925.2412325-10-cosmin-gabriel.tanislav.xa@renesas.com>
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

The Renesas RZ/T2H (R9A09G077) SoC includes a Temperature Sensor Unit
(TSU). The device provides real-time temperature measurements for
thermal management, utilizing a single dedicated channel for temperature
sensing.

The TSU loads calibration data via SMC SIP.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
index bb030bfed090..42ee9f299837 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -36,6 +36,7 @@ cpu0: cpu@0 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_CA55C0>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -46,6 +47,7 @@ cpu1: cpu@100 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_CA55C1>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -56,6 +58,7 @@ cpu2: cpu@200 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_CA55C2>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -66,6 +69,7 @@ cpu3: cpu@300 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_CA55C3>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -244,6 +248,17 @@ wdt5: watchdog@80083400 {
 			status = "disabled";
 		};
 
+		tsu: thermal@80086000 {
+			compatible = "renesas,r9a09g077-tsu";
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
 			compatible = "renesas,riic-r9a09g077";
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


