Return-Path: <linux-pm+bounces-22157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A68A2A3713D
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 00:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5041616F984
	for <lists+linux-pm@lfdr.de>; Sat, 15 Feb 2025 23:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02F71FDA7E;
	Sat, 15 Feb 2025 23:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="kDI5ka04"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA69B1FCCE1;
	Sat, 15 Feb 2025 23:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739662531; cv=pass; b=p9bHaLB2Nh/7oERbOBRxKJVGUPjp4wIck++pQF3MJupruurXx1nqWMVrv0GRGudSLDLpFsSc6UnzDzdmO38uLXwrfDaHWQHaS4k8gqcG8mi5bRihsxC2Vh1u+9Jqbd1asLWrGvp5WvPEWbv/nuB+MuStSJJ5lWa69gqUE29V22Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739662531; c=relaxed/simple;
	bh=J6aDRKpFHvCt/SrA0G6krm2MZyuETOzJLkbkmn3oCdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PdEx+4nXPi14xfyI00cVovqrFvGXM+mTzB3KdloBei/Tt9/F1Bsc7he475MnJCa8cA64x9bRLjr/UOOXbOyNTPubwJNH+laaJvpQIYuNycMG88l/ulWaW/3dMw3UzMTQH6FIPv49vhwE4gaaV99bP50GZsIrx20Vps8pAlGDkgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=kDI5ka04; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739662512; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aFv4rUM8HzHqC0CcPeHNBZkJLFKYzYUH1zAdZi1xwzOWiS+0Y5ZwTJ0GHv5pHDjFnIuK8EILzPbzt7l8XmGnaPRVzsZURAWVT+Apw+VdtiRtSosb9eoLEXQTgOM9mE1SaVtdm0suq++Ys+A6ZC1he1+M41Hayh1zV/0kzUxm0zA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739662512; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8av1iXNMpvlvtcg8scR+m4/u77ONzUeOM2pGww4zkIw=; 
	b=dourin8Sf2DJ9HKzwJcgqVM90jmr/X1u4h9JepWnW3bjVLOvlPswWMEBaBw4AuTypt4Y9AnGtiZO3Cxd0ux6J3yORgDtzN3URFquOyn+iop3/FbrKzIC+F8nxd14GLWw41mHYE2bO3NNtGiGa+oVxn1JWIeJu/K9t0j8T85ttsU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739662512;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=8av1iXNMpvlvtcg8scR+m4/u77ONzUeOM2pGww4zkIw=;
	b=kDI5ka04HpnqwELOTw4cEJm+lkj7jT4ASVw/Nf0Ju56JXsREzgZpqW803mE07L92
	+9/BuW7kgryJOZ7J9JswByStD9SRV6CXAg6NmkIg8bHHG0PYcMTLN7UStJBwzo/5pTp
	ds7auqYn2NcEFXF/R/XfodtqG11MTqEbMZKFJgHg=
Received: by mx.zohomail.com with SMTPS id 1739662510999466.30832668154085;
	Sat, 15 Feb 2025 15:35:10 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Sun, 16 Feb 2025 00:34:51 +0100
Subject: [PATCH 2/6] arm64: dts: rockchip: Add thermal nodes to RK3576
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250216-rk3576-tsadc-upstream-v1-2-6ec969322a14@collabora.com>
References: <20250216-rk3576-tsadc-upstream-v1-0-6ec969322a14@collabora.com>
In-Reply-To: <20250216-rk3576-tsadc-upstream-v1-0-6ec969322a14@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 kernel@collabora.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

Add the TSADC node to the RK3576. Additionally, add everything the TSADC
needs to function, i.e. thermal zones, their trip points and maps, as
well as adjust the CPU cooling-cells property.

The polling-delay properties are set to 0 as we do have interrupts for
this TSADC on this particular SoC.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 164 ++++++++++++++++++++++++++++++-
 1 file changed, 162 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 29b47799849ad50540755d62622865d84226c6c4..73df515a3937414d89515b4ddccf71f33f6a4fe7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/power/rockchip,rk3576-power.h>
 #include <dt-bindings/reset/rockchip,rk3576-cru.h>
 #include <dt-bindings/soc/rockchip,boot-mode.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "rockchip,rk3576";
@@ -113,9 +114,9 @@ cpu_l0: cpu@0 {
 			capacity-dmips-mhz = <485>;
 			clocks = <&scmi_clk ARMCLK_L>;
 			operating-points-v2 = <&cluster0_opp_table>;
-			#cooling-cells = <2>;
 			dynamic-power-coefficient = <120>;
 			cpu-idle-states = <&CPU_SLEEP>;
+			#cooling-cells = <2>;
 		};
 
 		cpu_l1: cpu@1 {
@@ -127,6 +128,7 @@ cpu_l1: cpu@1 {
 			clocks = <&scmi_clk ARMCLK_L>;
 			operating-points-v2 = <&cluster0_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
+			#cooling-cells = <2>;
 		};
 
 		cpu_l2: cpu@2 {
@@ -138,6 +140,7 @@ cpu_l2: cpu@2 {
 			clocks = <&scmi_clk ARMCLK_L>;
 			operating-points-v2 = <&cluster0_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
+			#cooling-cells = <2>;
 		};
 
 		cpu_l3: cpu@3 {
@@ -149,6 +152,7 @@ cpu_l3: cpu@3 {
 			clocks = <&scmi_clk ARMCLK_L>;
 			operating-points-v2 = <&cluster0_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
+			#cooling-cells = <2>;
 		};
 
 		cpu_b0: cpu@100 {
@@ -159,9 +163,9 @@ cpu_b0: cpu@100 {
 			capacity-dmips-mhz = <1024>;
 			clocks = <&scmi_clk ARMCLK_B>;
 			operating-points-v2 = <&cluster1_opp_table>;
-			#cooling-cells = <2>;
 			dynamic-power-coefficient = <320>;
 			cpu-idle-states = <&CPU_SLEEP>;
+			#cooling-cells = <2>;
 		};
 
 		cpu_b1: cpu@101 {
@@ -173,6 +177,7 @@ cpu_b1: cpu@101 {
 			clocks = <&scmi_clk ARMCLK_B>;
 			operating-points-v2 = <&cluster1_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
+			#cooling-cells = <2>;
 		};
 
 		cpu_b2: cpu@102 {
@@ -184,6 +189,7 @@ cpu_b2: cpu@102 {
 			clocks = <&scmi_clk ARMCLK_B>;
 			operating-points-v2 = <&cluster1_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
+			#cooling-cells = <2>;
 		};
 
 		cpu_b3: cpu@103 {
@@ -195,6 +201,7 @@ cpu_b3: cpu@103 {
 			clocks = <&scmi_clk ARMCLK_B>;
 			operating-points-v2 = <&cluster1_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP>;
+			#cooling-cells = <2>;
 		};
 
 		idle-states {
@@ -431,6 +438,143 @@ psci {
 		method = "smc";
 	};
 
+	thermal_zones: thermal-zones {
+		/* sensor near the center of the SoC */
+		package_thermal: package-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsadc 0>;
+
+			trips {
+				package_crit: package-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		/* sensor for cluster1 (big Cortex-A72 cores) */
+		bigcore_thermal: bigcore-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsadc 1>;
+
+			trips {
+				bigcore_alert: bigcore-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				bigcore_crit: bigcore-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&bigcore_alert>;
+					cooling-device =
+						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_b2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_b3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		/* sensor for cluster0 (little Cortex-A53 cores) */
+		littlecore_thermal: littlecore-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsadc 2>;
+
+			trips {
+				littlecore_alert: littlecore-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				littlecore_crit: littlecore-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&littlecore_alert>;
+					cooling-device =
+						<&cpu_l0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_l1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_l2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu_l3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		gpu_thermal: gpu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsadc 3>;
+
+			trips {
+				gpu_alert: gpu-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu_crit: gpu-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu_alert>;
+					cooling-device =
+						<&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		npu_thermal: npu-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsadc 4>;
+
+			trips {
+				npu_crit: npu-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		ddr_thermal: ddr-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&tsadc 5>;
+
+			trips {
+				ddr_crit: ddr-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
@@ -1694,6 +1838,22 @@ saradc: adc@2ae00000 {
 			status = "disabled";
 		};
 
+		tsadc: tsadc@2ae70000 {
+			compatible = "rockchip,rk3576-tsadc";
+			reg = <0x0 0x2ae70000 0x0 0x400>;
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru CLK_TSADC>, <&cru PCLK_TSADC>;
+			clock-names = "tsadc", "apb_pclk";
+			assigned-clocks = <&cru CLK_TSADC>;
+			assigned-clock-rates = <2000000>;
+			resets = <&cru SRST_P_TSADC>, <&cru SRST_TSADC>;
+			reset-names = "tsadc-apb", "tsadc";
+			#thermal-sensor-cells = <1>;
+			rockchip,hw-tshut-temp = <120000>;
+			rockchip,hw-tshut-mode = <0>; /* tshut mode 0:CRU 1:GPIO */
+			rockchip,hw-tshut-polarity = <0>; /* tshut polarity 0:LOW 1:HIGH */
+		};
+
 		i2c9: i2c@2ae80000 {
 			compatible = "rockchip,rk3576-i2c", "rockchip,rk3399-i2c";
 			reg = <0x0 0x2ae80000 0x0 0x1000>;

-- 
2.48.1


