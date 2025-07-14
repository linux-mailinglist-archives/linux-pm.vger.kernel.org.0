Return-Path: <linux-pm+bounces-30773-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B708CB0397D
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 10:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F92A18855A6
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 08:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB81F24113C;
	Mon, 14 Jul 2025 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gW5p75Zb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC51523BF83;
	Mon, 14 Jul 2025 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481398; cv=none; b=t+GGaar4lT1Q1A7bclfmby5TNp3WZujgj0ysSPnmoTWdbBJKYjKttENLN1r6Psxtfs1vL2fbELkkBQU3l2s91TXb7SEitZmF0Ff5MOSndxF+AgYOeXe6IctBp2wuMZrK8Mz00GRHvda1K9GcuW6VNKKQeiCbE+V9lH+nFXVrWKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481398; c=relaxed/simple;
	bh=RbHojCbVC/Hq/OqnG628eJg4f5VkM1uFiH8D9O341j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AukV3Vpc8UE4OcLWkO+6mSR4imZpdGXdR/o0rkCSXFGY9KeWkCnlTkQmhc+Z/YF4O6SiCrA0M9BGThqPfwGA49YTlLpIZmfBWeb15RgxfdDpfGZ0C6seYWx9iyre/CIgZMEqGWXJCoZqTRXRsE4+0tAqv3gD+dhQixRWd9VTkG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gW5p75Zb; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-553ba7f11cbso4059462e87.1;
        Mon, 14 Jul 2025 01:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752481395; x=1753086195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMm7DyHGHXbdPdoaT3XLOxvCXV+6TZVhfFm+ZVxjYW0=;
        b=gW5p75ZblDT/uG2PkuvKn3R+jQ+Bh1MPPmeDWj1JA1D2IIPGqE7MsRbp737qJSfzod
         d6gLGWuKj/Ek0eOJoxqQBBzVIDZQaO/blvaLjhUDGzXFdLOxTGdnO0n3y+b+1ozayvi6
         LubzhD8mxDdqVZABj51CBrcyVlKdkiR27MHZVTKlrYzFL97xz06RTLfS1nT3c27MZ9Zp
         bICNp6x4mzh2xDmZzzEg3qokJttjm0qxnyp1H2jjNXDIumFzRFcj0HWnJ03+8jVMis8+
         0U19g4g8P68wYHgYVRVr0/zt/IFmo373Sa4wjGWZAfWmTW4fwyPuixS3iJfTua5y3tOL
         iXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752481395; x=1753086195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMm7DyHGHXbdPdoaT3XLOxvCXV+6TZVhfFm+ZVxjYW0=;
        b=ZtX/5nMe1ERcA12rspt7nbvMn9pnRxtU8rrzPkvbTUwX0hUnYvoPqQqv6SDY/P8KoN
         h4bHfZBRuyvoierhmjXAVgW6TmuBL3tvUyVgH5GIfTZLJh8tlivlrOfMhibteEmqGPvj
         KiyZMGD7VH+GkT2ox2lW4HGGqGb/HIH4/OJPEmbEha0Z5HdQqTUoszwjOBF6cK9UYwTS
         n33lAMIK6yQq2xZhNa9oBsl/YCRQBGWD7PTYob0RomqmlTNW8SwVRcjNMyzyEWut5ukw
         lVzDT6yOQOOmRsC+UnRmSdhLabmJwGXWwBxLnoMgtBp4yUHYqi5TImkXSNuVH7PfwBw7
         GXPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ10g6KCEt/t+SUjRp1GLHf83TrZQiEahf7RuUZ9eq5dYizrZF03tUHRn18/N8nK6+9BV0Ew0q4gtb@vger.kernel.org, AJvYcCVzHf3L7SUvCLxhXRNpT/5GsaIyERavW9b6xY4XJ0KLeM7147pEcRS2O6AbSp8d5f0JH2ryKiSjgXcYQt0=@vger.kernel.org, AJvYcCXtOTWfqc0ZO0NgiB0HN6IEqRn46x28VC95e9CY7KhjaPgOn1viFNf0pY2KPFbadUz5jaLMJROeRKfcIUiV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+nVfcgG5ZWyj8RTr8UTPGQe8/YZu/17kyo9R2Rt6aGjWIKRfU
	Cu1AjRKMF8UvoPCEBj2Md9+eFexlrPtUe1aTEE45HlqEHORO4HJfiFw1
X-Gm-Gg: ASbGncsB+Lxn9dt1LnnvB+sqiLEnIMWJN7Zwq3bqtEeVlcpaPNUVzOYRhaui1e2zvEB
	t7zdF5cMJ3N26f2k5Wpr1AsO484eadTSPqmxrfKwKAIPC1LhlSj2ddKPnjFv+SHhLbO11x7sdM3
	/eVxUXbhSax1yKrlwS9XW8M9gyX2E5sQ9wY5CMEm1FvO8xLNLTxRKWB5H0IQogtrYH3/J8H9SB6
	QJNkVxR3IKoh4gXZD+e8+NtrXU7peh85UH8mIrgNRZ/Vlf4OOOx5O++Hykc+prkSUznu8NCf+tV
	2oEUM24ed9BAQN5krkdPWSNISsRKWnPaWcM978ktWyzxOjvXCkVg3B13U0JjOAru4nKmpzZHvbz
	aZxC93F7eYdVuIju4yZNMzTEh
X-Google-Smtp-Source: AGHT+IEe6S5kqUviV3u3C+WB/1UIJgAf9fqj+Tk6HiZAF5T3MEyPbDasWUUavrPThOLVynFogYcHqw==
X-Received: by 2002:a05:6512:2251:b0:553:2dce:3aad with SMTP id 2adb3069b0e04-55a044b4aa7mr2858473e87.7.1752481394700;
        Mon, 14 Jul 2025 01:23:14 -0700 (PDT)
Received: from xeon.. ([188.163.112.60])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c7bbd55sm1885717e87.23.2025.07.14.01.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 01:23:14 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] ARM: tegra: Add SOCTHERM support on Tegra114
Date: Mon, 14 Jul 2025 11:22:52 +0300
Message-ID: <20250714082252.9028-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714082252.9028-1-clamor95@gmail.com>
References: <20250714082252.9028-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SOCTHERM and thermal zones nodes into common Tegra 4 device tree.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/nvidia/tegra114.dtsi | 197 +++++++++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/nvidia/tegra114.dtsi
index 3ee51d7f3935..cb30a7948e19 100644
--- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
@@ -5,6 +5,7 @@
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/tegra114-car.h>
+#include <dt-bindings/thermal/tegra124-soctherm.h>
 #include <dt-bindings/soc/tegra-pmc.h>
 
 / {
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
+				nvidia,gpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_HIGH>;
+				#cooling-cells = <2>;
+			};
+
+			throttle_light: light {
+				nvidia,priority = <80>;
+				nvidia,cpu-throt-percent = <50>;
+				nvidia,gpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_MED>;
+				#cooling-cells = <2>;
+			};
+		};
+	};
+
 	dfll: clock@70110000 {
 		compatible = "nvidia,tegra114-dfll";
 		reg = <0x70110000 0x100>, /* DFLL control */
@@ -858,24 +899,28 @@ cpu0: cpu@0 {
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
 
@@ -888,6 +933,158 @@ pmu {
 		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors =
+				<&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
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
+				<&soctherm TEGRA124_SOCTHERM_SENSOR_MEM>;
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
+				<&soctherm TEGRA124_SOCTHERM_SENSOR_GPU>;
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
+				<&soctherm TEGRA124_SOCTHERM_SENSOR_PLLX>;
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


