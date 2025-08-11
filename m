Return-Path: <linux-pm+bounces-32137-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB84B20149
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 10:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796AC17CF79
	for <lists+linux-pm@lfdr.de>; Mon, 11 Aug 2025 08:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099E32DCC08;
	Mon, 11 Aug 2025 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+2obA3X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D392DC341;
	Mon, 11 Aug 2025 08:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899493; cv=none; b=hT4fhpYkQOd7F583GDOs+j/Jga7V9qcGQF/ljkqPV9gSe64aF4L1UfQV4PLxWj4bd7x3dHXeEbKZurCbRmmlS5WObdw0OASEPRcn+BjgREO5e+++QLA7TouJn4Zk5bJpqAbU378XILEMj4Vl34q60aRw3dZjN+cbGS6e5XGP5lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899493; c=relaxed/simple;
	bh=RbHojCbVC/Hq/OqnG628eJg4f5VkM1uFiH8D9O341j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trTWe/OKCNK9NtKmWGmWIIIoL3efOuZUbHSQsR1dpsxEM5yXntRYkMzXHKTy57ARJcaEub8kIPHMHwXqmqFK8NsDFkZgn2cmbALR9auOH8w2zosPLFjtvC9edkSfEKh8SYtGnHfoFOlN5seJve+ntB13bVD+Hj8H4gsiEb9f9Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+2obA3X; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-af949bdf36cso644662566b.0;
        Mon, 11 Aug 2025 01:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754899490; x=1755504290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMm7DyHGHXbdPdoaT3XLOxvCXV+6TZVhfFm+ZVxjYW0=;
        b=R+2obA3XcQLW/smPe4vCqc97FwGdxnjR21w8f4zwxRKWmfAQibHvTzlxcaodcCQ3H7
         NSg2UF4dGvGx9/k52xSHRFg6is41gN9P17GuDfNTiC1IQ/X7L05pljqhbQTgVDDvoG7P
         X1TatK+f6w6LTpJMCT5RkautHJQYpccM9uCBdeV+NKOWapLFe6TmWvSARpiRGqjsfey1
         y+eteOsHDrK1yX2qmpcmc+e/+PubMbiS2P0LKNgZFzTQprFypwykF44ktuoO8sSg0JzN
         NT6jgrHDnpeTDjSUgqgJQYDQtalB4TszEeKFf0s3RIomqIQNtwJrtI6gKFyJV3qYJgpo
         uK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754899490; x=1755504290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMm7DyHGHXbdPdoaT3XLOxvCXV+6TZVhfFm+ZVxjYW0=;
        b=KOwJ8VKqJUHJATwd+39EtxFcOC0CFAYD6Muab1xrbweUaE5kAYUKCeIIf4rimkBZ/4
         1eIgl9W7FFvr2KmeLuvbdv6DevkqpLysw0BHRtLbU2DieksA0sTHbGbH+kGhDXUIYWX9
         11Dp3JKTls9dghA4pynRQaWr4/Lh8u92GwykjSqOhoId3LRcg4SgZfVDF0MwQNs6MAIL
         oWhCl74IKG0w/m0X5PEP4fdQddws99uXQod4vhMQJqqmkODN2yqY74704nV+kD8PzCVh
         Fn9TBEhMMGmnzFZbK/WQcQGklQBdltl9aCkbYLaWz10Bil8+/MDK43V5A2OvYShU8UP0
         T/fA==
X-Forwarded-Encrypted: i=1; AJvYcCVCkciEm/cqD7eAeRPh01tjuGWwzcB5pi8F2Bg8ORq2MiG2Z9y9NeF7z/nwXMDS0aYZrTyK5ooIxp1Ffsbu@vger.kernel.org, AJvYcCVIqGIyOOFCtiKdppyq+gWWhv47ygfCeGsCW4or/JgILESgk+vW13iCPwxRM1UGabFuQEhtye7ugQbtSsg=@vger.kernel.org, AJvYcCVyrGFe97vq1i1sBagBOGGaaLMmR7t2xfwJBnL7gSH2+kgdvcgxc4XTqpDLDVeH1+IzAKWpTH/L8abd@vger.kernel.org
X-Gm-Message-State: AOJu0YzN55dE+D/Ypx3+wFMsJk4MOXwerpSDy05EuZEvro5myfldUsea
	cBo8YyU3Yq0oDduybbxoFmr0e+a0ngrDoth66m+3b6WVJTYWsrHmTo1WRl491g==
X-Gm-Gg: ASbGncskVvFwVMLJqNpAvkhug+HVHJ5kyJFdGlaW061bu1VaCgDh7mRda1NLugyf6gF
	rWoACE1ISlFjtrZeQ66EMTyII89LaijmZNeO1x5IAAsN6qx6zsep1PfM1+WhTAUBVf1zE5hH7q0
	6bvrsrou3SYz2KS21qdLpY1pPagyj8QZIYa1yDMJpDo3SmYtgSR/PvSOdqFNOsiw13KaUE2NMcR
	4N9Ipw9ARogteTVJaiduRKxtDN/+NzkWO1bAEbXKB4wWGZTod9P+0lWQz7lV4ID2/XOEcMk8o7k
	AlReqPN0QeKgd6fiYnZnLEkqJVOit2kbspAUUESoN1yBPp9pLXDHFRrbNEkwfoYUSya1LyFNYro
	85fqLhqAB3t5TeA==
X-Google-Smtp-Source: AGHT+IEKBOwgF0Ougql9krLNeAJjJZxwKSUYe0nyazt7AroKIiMiI6rgNtqZdtvsF7sZSNmkZ+X14Q==
X-Received: by 2002:a17:907:7f90:b0:af2:9a9d:2857 with SMTP id a640c23a62f3a-af9c6375b94mr1083286366b.3.1754899490106;
        Mon, 11 Aug 2025 01:04:50 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c081sm1956446566b.97.2025.08.11.01.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 01:04:49 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5 RESEND] ARM: tegra: Add SOCTHERM support on Tegra114
Date: Mon, 11 Aug 2025 11:04:22 +0300
Message-ID: <20250811080422.12300-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250811080422.12300-1-clamor95@gmail.com>
References: <20250811080422.12300-1-clamor95@gmail.com>
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


