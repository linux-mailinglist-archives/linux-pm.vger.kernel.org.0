Return-Path: <linux-pm+bounces-33219-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C1EB39368
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 07:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DBA61C24B0B
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 05:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F312848AE;
	Thu, 28 Aug 2025 05:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpiAZHEt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C02327F758;
	Thu, 28 Aug 2025 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756360286; cv=none; b=a5BXySluKNc52+IhLAbqXbLysIz195iFQSLCSYHATk1puPYDiMOdYhjblNtpPIiM8h6SKWQeS3qPmgpfQdttnyVppsE70aLJfwTv49fEsSYyzoHn71AA8SUyOLK6uvNGDAFFwVYBtB/FayM6vBq6AC2qBx7bLqCkKBCHLDGxq2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756360286; c=relaxed/simple;
	bh=uSrvLfGYAEQvygK2xrU4Fab3coJ6pZyN3+8ZdmHQIKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giI2I+LeBIwcKrSI6lnl1+oY1E6bZ95Ncl77bdac+0Yywxw8EehpOvNpYQDWBqRFQCxd2R9g+uHkCErUURqHPukhYyrG69zA1zP1Ilc4jB8BAIyLUBeYBH9+/QnTUM3OUR3dfiddYv/CgAck6deS0W2EOQ6Q3EzfVMUVlhF3M8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpiAZHEt; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afeee20b7c0so15289466b.3;
        Wed, 27 Aug 2025 22:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756360282; x=1756965082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydaDOYhRsSp2SwQZUd4YQ2tvzm+TRqbiO3wKhkLnB/E=;
        b=NpiAZHEtbT3oqpDY5Spj2YKpaKbWnofOqcihqOuIKbXBVimrXV5DSN+775mfAusoWj
         7kqHxYAM0zGcoshCsKTBMz82v9d5zHjNfvIBfKpiILgNZPlcnd1oUrT765UP/lFrIP0f
         c9fJM/pBKtSwPTE//01CrUNVki1Pnkg5u4MlpCTMfacI/8HFuAG5PvZMykV9Ov/8SOq5
         yUCz9B+dHh/G8T2k96K1yL9TYRbWyxTDVxbJ16tuamIKMPMwBpQt9M9SUHiDxd3K8nWI
         bu16d/gnu6QLT03h0u1Dz+9CievkGrKodDMl3cVfSKdcpizp5gMzWmkHAn7Clm9Y5hgv
         0cUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756360282; x=1756965082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydaDOYhRsSp2SwQZUd4YQ2tvzm+TRqbiO3wKhkLnB/E=;
        b=KHjzlQRqf0+6jCP/klUqyfk1SQH7wUfFJZtztVO8sWL9I5lFm9qfHb49I+ELMaovUG
         3JKwSNpWD7bSD/Dde7JEweL0iBSmnuZz85uiqCd1DonFS2Ev5D4ShzCjvG5j4eU/J50g
         u9Kl416UngYNItAB1joUpuL+8MjOeFLsPjJQ0YqOtorPGdxpKZY6hrBstIis4fHUOTgy
         wy3wvmpjlz0thyEqIjqCjzPd1xNOw9QRBJpZJpL6cyFoAILsn0oGW7W5MCJoEq1S7XLA
         jNiX0pjjmJhaajW/UieQIz3L5GBxzp0BK4wYMM+Qx/zyr6K0sLdfNrna4Pxnm+vbbxkz
         Kg3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcXib5rh7dm6Bd+1HOOEV5vdxEuT0PFyEt+biID7WN0D4xsJpWU/GV0XLcs/qeuuwHgZLH7NfjZ5lnYfqh@vger.kernel.org, AJvYcCWclh6Md6NR9SAPLxgHa2nb3SoKAYt4COXIxuSKm3d/67YK6hqwWKSW0qLppmwGaYbzr7T07DBREC+myYs=@vger.kernel.org, AJvYcCXnuYTtyqJ45hgDsBfDuRnYuSj4BSfX4yOyV9fy6KVBSStNyi0bE4MRy1SDtdGPEUb+IqdGfYm0qi7F@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0OwlNoK/+LhkIXQYVe15tHct+HnHymqIyO4u7Ph0rjIVY9YEv
	Qv8bR3O0epyqQJdvz2goAEiCYABl/Vtqx8YVg7g9bBcR29nB6M9EO/y1
X-Gm-Gg: ASbGncvKeu/BpNXcp8cKxAlWzVEb78BiIp40IuVzNss7rHxsY7e3tEkyxwt6+6Bbd40
	nIt2mP3I0J1W0nvDTNsplZUTCiO/un8DHFa0rSLLsD+7eKgG04/g358bt2AThVhHghgqW10ZHcu
	95N8wTjLQCiHAkdor+6pcBpnkKwsZpgMimiy12nRQ0LcySAfIXNJ2mEF9S4ZGRuQP7HhyHGR4Nw
	VESUj8lx55LEypEgIs/gmXBlAxb8UgzaERNWepY3j8pLe5ZIKn6XUR2KvGZsopKJS4WHctIMzgN
	eVg4bdF4ONpyCkAI3TgG81K/u16CyNxH2K4QawfpJCEtMPVAzkq8rnH9Lz5zye/RP1FfhHX6eOg
	9PLsZgQRqFrSgFA==
X-Google-Smtp-Source: AGHT+IGidJrXeQ3vVfhmgwkpCRo0gfs8WyDQ+l8ndzlYOCnEhlAjRPFUZYGfTLK9lDR5UGvP0qdNsA==
X-Received: by 2002:a17:907:d87:b0:afe:b3be:90f3 with SMTP id a640c23a62f3a-afeb3be960emr747013166b.10.1756360282241;
        Wed, 27 Aug 2025 22:51:22 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe72c35ebdsm927942666b.7.2025.08.27.22.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 22:51:21 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/6] ARM: tegra: Add SOCTHERM support on Tegra114
Date: Thu, 28 Aug 2025 08:51:04 +0300
Message-ID: <20250828055104.8073-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250828055104.8073-1-clamor95@gmail.com>
References: <20250828055104.8073-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SOCTHERM and thermal zones nodes into common Tegra 4 device tree.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm/boot/dts/nvidia/tegra114.dtsi | 197 +++++++++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/nvidia/tegra114.dtsi
index c429478eb122..c3f540b29c69 100644
--- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/tegra114-car.h>
 #include <dt-bindings/soc/tegra-pmc.h>
+#include <dt-bindings/thermal/tegra114-soctherm.h>
 
 / {
 	compatible = "nvidia,tegra114";
@@ -694,6 +695,46 @@ mipi: mipi@700e3000 {
 		#nvidia,mipi-calibrate-cells = <1>;
 	};
 
+	soctherm: thermal-sensor@700e2000 {
+		compatible = "nvidia,tegra114-soctherm";
+		reg = <0x700e2000 0x600>, /* SOC_THERM reg_base */
+		      <0x60006000 0x400>; /* CAR reg_base */
+		reg-names = "soctherm-reg", "car-reg";
+		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "thermal", "edp";
+		clocks = <&tegra_car TEGRA114_CLK_TSENSOR>,
+			 <&tegra_car TEGRA114_CLK_SOC_THERM>;
+		clock-names = "tsensor", "soctherm";
+		resets = <&tegra_car 78>;
+		reset-names = "soctherm";
+
+		assigned-clocks = <&tegra_car TEGRA114_CLK_TSENSOR>,
+				  <&tegra_car TEGRA114_CLK_SOC_THERM>;
+		assigned-clock-rates = <500000>, <51000000>;
+
+		assigned-clock-parents = <&tegra_car TEGRA114_CLK_CLK_M>,
+					 <&tegra_car TEGRA114_CLK_PLL_P>;
+
+		#thermal-sensor-cells = <1>;
+
+		throttle-cfgs {
+			throttle_heavy: heavy {
+				nvidia,priority = <100>;
+				nvidia,cpu-throt-percent = <80>;
+				nvidia,gpu-throt-level = <TEGRA114_SOCTHERM_THROT_LEVEL_HIGH>;
+				#cooling-cells = <2>;
+			};
+
+			throttle_light: light {
+				nvidia,priority = <80>;
+				nvidia,cpu-throt-percent = <50>;
+				nvidia,gpu-throt-level = <TEGRA114_SOCTHERM_THROT_LEVEL_MED>;
+				#cooling-cells = <2>;
+			};
+		};
+	};
+
 	dfll: clock@70110000 {
 		compatible = "nvidia,tegra114-dfll";
 		reg = <0x70110000 0x100>, /* DFLL control */
@@ -857,24 +898,28 @@ cpu0: cpu@0 {
 			clock-names = "cpu_g", "cpu_lp", "pll_x", "pll_p", "dfll";
 			/* FIXME: what's the actual transition time? */
 			clock-latency = <300000>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <1>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <2>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <3>;
+			#cooling-cells = <2>;
 		};
 	};
 
@@ -887,6 +932,158 @@ pmu {
 		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors =
+				<&soctherm TEGRA114_SOCTHERM_SENSOR_CPU>;
+
+			trips {
+				cpu-shutdown-trip {
+					temperature = <102000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+
+				cpu_throttle_trip: cpu-throttle-trip {
+					temperature = <100000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+
+				cpu_balanced_trip: cpu-balanced-trip {
+					temperature = <90000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_throttle_trip>;
+					cooling-device = <&throttle_heavy 1 1>;
+				};
+
+				map1 {
+					trip = <&cpu_balanced_trip>;
+					cooling-device = <&throttle_light 1 1>;
+				};
+			};
+		};
+
+		mem-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors =
+				<&soctherm TEGRA114_SOCTHERM_SENSOR_MEM>;
+
+			trips {
+				mem-shutdown-trip {
+					temperature = <102000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+
+				mem_throttle_trip: mem-throttle-trip {
+					temperature = <100000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+
+				mem_balanced_trip: mem-balanced-trip {
+					temperature = <90000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				/*
+				 * There are currently no cooling maps,
+				 * because there are no cooling devices.
+				 */
+			};
+		};
+
+		gpu-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors =
+				<&soctherm TEGRA114_SOCTHERM_SENSOR_GPU>;
+
+			trips {
+				gpu-shutdown-trip {
+					temperature = <102000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+
+				gpu_throttle_trip: gpu-throttle-trip {
+					temperature = <100000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+
+				gpu_balanced_trip: gpu-balanced-trip {
+					temperature = <90000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu_throttle_trip>;
+					cooling-device = <&throttle_heavy 1 1>;
+				};
+
+				map1 {
+					trip = <&gpu_balanced_trip>;
+					cooling-device = <&throttle_light 1 1>;
+				};
+			};
+		};
+
+		pllx-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors =
+				<&soctherm TEGRA114_SOCTHERM_SENSOR_PLLX>;
+
+			trips {
+				pllx-shutdown-trip {
+					temperature = <102000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+
+				pllx_throttle_trip: pllx-throttle-trip {
+					temperature = <100000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+
+				pllx_balanced_trip: pllx-balanced-trip {
+					temperature = <90000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				/*
+				 * There are currently no cooling maps,
+				 * because there are no cooling devices.
+				 */
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts =
-- 
2.48.1


