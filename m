Return-Path: <linux-pm+bounces-24087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02A3A628BE
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 09:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E490A17A566
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 08:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3FB1DF994;
	Sat, 15 Mar 2025 08:13:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FCE1C860F;
	Sat, 15 Mar 2025 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742026384; cv=none; b=bD7gNFXAS7y2mh9rPODdfkX4xcZ3JIzwYy5eI+lXtbe9u6se+BNiW9urzvIvWvSX31bHSKHm3Va5rlaL8VW20EcHYOklRW77sppk2Gqcokg7wTww5IBECrSngvZKz8wNDbxPc2EOAEDkpRkBJ+bughtwjebzd2FziM3JKbFHrO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742026384; c=relaxed/simple;
	bh=erGtLpcQB3i+4RLubw5o5z1gJDfAFuDuVIGplQZyu6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ag4ohJ3Zc6uM2eAx1FEeORrofy3wWL+1yzdFkid2OgH1U7bBmFiFUmMZsTyGtBlvKG1U0aV4rebq59+mWqKRaWfsZG+flhFgG5LmwYjrTDXfTYPVSbIJaHTZ8CzQ1H00QK9ccFvZ2RK6N246hFEyMW+1mbj3p6vvqqCDUcNPRiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: isV4w/dgSyuBMnEkxrXCuA==
X-CSE-MsgGUID: AvIAZGJeTkCq6ob+FuX4bg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 15 Mar 2025 17:13:00 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.58])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7FD9F41BFA47;
	Sat, 15 Mar 2025 17:12:55 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: geert+renesas@glider.be,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: magnus.damm@gmail.com,
	devicetree@vger.kernel.org,
	john.madieu@gmail.com,
	rui.zhang@intel.com,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	sboyd@kernel.org,
	biju.das.jz@bp.renesas.com,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH v3 5/6] arm64: dts: renesas: r9a09g047: Add TSU node
Date: Sat, 15 Mar 2025 09:12:15 +0100
Message-ID: <20250315081225.92118-6-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315081225.92118-1-john.madieu.xa@bp.renesas.com>
References: <20250315081225.92118-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add TSU node along with thermal zones and keep it enabled in the SoC DTSI.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
v1 -> v2: Fix IRQ names
v2 -> v3: remove useless 'renesas,tsu-operating-mode' property'

 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
index a6b83e057a40..c49214cb7936 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
@@ -64,6 +64,7 @@ cpu0: cpu@0 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G047_CA55_0_CORECLK0>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -74,6 +75,7 @@ cpu1: cpu@100 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G047_CA55_0_CORECLK1>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -84,6 +86,7 @@ cpu2: cpu@200 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G047_CA55_0_CORECLK2>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -94,6 +97,7 @@ cpu3: cpu@300 {
 			next-level-cache = <&L3_CA55>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE R9A09G047_CA55_0_CORECLK3>;
+			#cooling-cells = <2>;
 			operating-points-v2 = <&cluster0_opp>;
 		};
 
@@ -302,6 +306,19 @@ wdt3: watchdog@13000400 {
 			status = "disabled";
 		};
 
+		tsu: thermal@14002000 {
+			compatible = "renesas,r9a09g047-tsu";
+			reg = <0 0x14002000 0 0x1000>;
+			interrupts = <GIC_SPI 250 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "adi", "adcmpi";
+			clocks = <&cpg CPG_MOD 0x10a>;
+			resets = <&cpg 0xf8>;
+			power-domains = <&cpg>;
+			#thermal-sensor-cells = <0>;
+			renesas,tsu-calibration-sys = <&sys>;
+		};
+
 		i2c0: i2c@14400400 {
 			compatible = "renesas,riic-r9a09g047", "renesas,riic-r9a09g057";
 			reg = <0 0x14400400 0 0x400>;
@@ -502,6 +519,37 @@ gic: interrupt-controller@14900000 {
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
+					cooling-device = <&cpu0 0 3>, <&cpu1 0 3>,
+							 <&cpu2 0 3>, <&cpu3 0 3>;
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
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts-extended = <&gic GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-- 
2.25.1


