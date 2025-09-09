Return-Path: <linux-pm+bounces-34240-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAC3B4AC4F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 13:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B771895D2F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 11:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D0B322A0B;
	Tue,  9 Sep 2025 11:39:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2E4321F30;
	Tue,  9 Sep 2025 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417961; cv=none; b=b0ZP1cPD1f3f37pyamAfhlj6ai+v9i+BjHQrRJy5h7f9UnikuJBq1VlXc2BumYJvPlkU9KMKsqu2oxgEbpFSkw0gt1LLmBcA8xEg8XtyPtVpuXUmY2GT1jul3ch0UMfYOBjw8jqmBJJNfP4eY2KN6TN7TxDBHchR3D3mE5HxK4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417961; c=relaxed/simple;
	bh=CHPbTooWowOL079vaBy/qBwFT7KJeeIl2InuLMLVYvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSJ7jaoZOZ03ZXwAhDo1k+zErZLiN7CLmEZR7n0LjO1l0NtiBRhXUgsd/YRc2pn2epRYTnKhAzM8z/azCLu3U8FtZeZdCS717WnUF8up9W9nNS/66IHaT46/8l+QtvThL+U7HuaTiEfUm/10CAjkbfXjCJkIwx858nhj76eSL6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: XG4teax0ScWfSw974WDPmA==
X-CSE-MsgGUID: Q86cjfVuTQOozpLkHMby7w==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 09 Sep 2025 20:39:17 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.24.0.1])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 47829400753A;
	Tue,  9 Sep 2025 20:39:09 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: catalin.marinas@arm.com,
	conor+dt@kernel.org,
	daniel.lezcano@linaro.org,
	geert+renesas@glider.be,
	krzk+dt@kernel.org,
	lukasz.luba@arm.com,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	p.zabel@pengutronix.de,
	robh@kernel.org,
	rui.zhang@intel.com,
	sboyd@kernel.org,
	will@kernel.org
Cc: biju.das.jz@bp.renesas.com,
	devicetree@vger.kernel.org,
	john.madieu@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	rafael@kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH v8 3/4] arm64: dts: renesas: r9a09g047: Add TSU node
Date: Tue,  9 Sep 2025 13:38:38 +0200
Message-ID: <20250909113840.122785-4-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909113840.122785-1-john.madieu.xa@bp.renesas.com>
References: <20250909113840.122785-1-john.madieu.xa@bp.renesas.com>
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
v3 -> v4: no changes
v5: no changes
v6: no changes
v7: updated both property name and specifier (<phandle offset>) for trim property.
v8: removed #address-cells property

 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047.dtsi b/arch/arm64/boot/dts/renesas/r9a09g047.dtsi
index e4fac7e0d764..7bf0b4a6c67a 100644
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
 
@@ -412,6 +416,19 @@ wdt3: watchdog@13000400 {
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
+			renesas,tsu-trim = <&sys 0x330>;
+		};
+
 		i2c0: i2c@14400400 {
 			compatible = "renesas,riic-r9a09g047", "renesas,riic-r9a09g057";
 			reg = <0 0x14400400 0 0x400>;
@@ -970,6 +987,37 @@ stmmac_axi_setup: stmmac-axi-config {
 		snps,blen = <16 8 4 0 0 0 0>;
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


