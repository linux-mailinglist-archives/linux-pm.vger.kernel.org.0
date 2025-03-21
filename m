Return-Path: <linux-pm+bounces-24386-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41822A6BDB9
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 15:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C146346361D
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 14:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5522022A81F;
	Fri, 21 Mar 2025 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3fFdsKb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6428D22423F;
	Fri, 21 Mar 2025 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568839; cv=none; b=bjcq0+BzkeapPAYn8Lvrp/tL4k4wqjvaRd+0++roO38/vtAV4OARRJMgjCBrgpkVPepgcUmdvHBZxSRH4YmhIRryjVkuaZI5+XBbi1lhZ3jxIHXBcBFwRWugONmNzIaKKglXQbQM4OLNrQzcIrGqfplxdX08zlsEYsMh9gbk+Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568839; c=relaxed/simple;
	bh=LAZXLdh33TVoWxNdnrnsbyHRdRcyvTKSeX7w1LJ/e7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPC1JiIU5xcZmPKvD01ua6zeHd8/T6x6UfKtZwisoWDAisFAiAAGMajvIC9Ft4bEpS+Izzbp97bSA8twtOTUhYuv5BUWtCf2s742UcEqJO1KnGCW5hnhN3zzO3n79Zb0FDsgyRIqaXDpuMmesS9h4NCAuxeyin9EPFjHz+zOfls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3fFdsKb; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso3667220a12.3;
        Fri, 21 Mar 2025 07:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742568836; x=1743173636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fe2kbPTwvVNBxhNjMkTSBSLSKQIjeOhcHFESCXzkbkM=;
        b=S3fFdsKb5+9cwotDpPcW2IDeXckPWErw2yG7UrdUMxF5+uVPgz6OGocN7uDU7LZCrL
         GFglHLJILT29eQn1v6C2MuvTjwf78XrN8aE6Ebl/rkhAydkOPBjTp1MJPZGnSTHb9psJ
         B45zEk8JEf2qp+lccJrFVleoXD3RPQGgM89kc+QlXHmNdCgP6LooBTknAm6VlDLopA2n
         Lht8r/TFWB/on+ZqNYIDcDs4eHC0Tpz52/p/f3+vK8sd8W1U+dOFSXZyot2liDo0sLin
         KlPO7gPNlJ8+qOsrD9+i0iLkNXo8RkPODtg0KTnYPAfyuwhf4eM8ejFXqAHr5pHUdqHV
         W6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742568836; x=1743173636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fe2kbPTwvVNBxhNjMkTSBSLSKQIjeOhcHFESCXzkbkM=;
        b=bLY0oon9WSnxfWW/2HAtXFdbTz56oT18gz/0OlIGL0CkPe1Yz4xxcpFHY/KlWmPM9D
         ITG3WAkpP36RHSIh9Oa8U50O8raJRW1HMA9re3yCE6YyCCMw9v46LYE6Cb0wgKqOZPRz
         p1WVuCa/7hntRnCnFBawf7Ge8uf7WtcaCbVCP4vjWvHH6I0BuxMkRxVJCFZuUilFAag8
         XNajn6UK1KFyMrSOtLHZpkKtDLYNVLnJpNR+Xv0lSYPfaitg+mPD9wuhhb/al3nCjTWj
         QRZXHx9ezimPrprb941ZJhn5xlrPMJ2VcufM9rRz0NuR4J6j/YciYkM13ZsRjA53Jre2
         Q2RA==
X-Forwarded-Encrypted: i=1; AJvYcCUqmPmv+YuAWlid1mqO+iC+wq8z1ijHcDM6vydTKWz2pX6cet9ctyDe3fojdhZ6CNZRbgYDd337HUIHNBM=@vger.kernel.org, AJvYcCVsKVxQE1Sru8rPFHTidTdKnsRaPHo5ttNd+1hnhfOeGJZ+uNXMw1hKAMajztov4ak3vrnv1kNuGAVa@vger.kernel.org, AJvYcCXdymBKluVesqLNcOppbz28hvZ6/n6ZirHnIXZDOZQcDSSGuBoV94G7qce4puMqyb+4u+DF8WJqAD7LUZok@vger.kernel.org
X-Gm-Message-State: AOJu0YxsBm1U/nbch+f+qj4lt8H0cGJ9lYJmhU+fzwlBtLGpi8d4EfB4
	iBBR6eZBHOJ2k6Qicm/LappJ5zqgJecsxDDJDxgS9+f+Fsu/13GZ
X-Gm-Gg: ASbGncs8B/i/3054Zx/o4T5fBqk3v+U+Csz8Q5gjkAXsoajLGqFSull60WmkyBr4YOy
	AzGQFTBd8+ZRaFD8HZx8w4DNNORVFMJptsDE6CrrulMMMlD+zZZ/psezQbTvMvM7F+Xkyp5plYN
	vslmFYz6JRAmpY5Qnf/NsdBKBs9REiEYD6ZAD+n61VO1Uaopjh78g78htFjoisfUl2U/3tQvjIX
	OrQkUF9DRLcUlt2b/u1kQa50eVz1N1fMkEOp5Lxkn3qaoV571HPQINR3+xvxjmXh/JrAt67lwYS
	PneXPK8x4LXmpZezRoZJI5rSvPACjq0bLMap
X-Google-Smtp-Source: AGHT+IEUbbaGuykcwI2+6K7THB2Xr1pAs3mKKDYroo/RmpQx3kMBZkIbx7+47szKzFfZODxKlY7kvQ==
X-Received: by 2002:a17:907:2d20:b0:ac2:af42:4719 with SMTP id a640c23a62f3a-ac3f226e059mr307664166b.21.1742568835416;
        Fri, 21 Mar 2025 07:53:55 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbe038dsm163224666b.138.2025.03.21.07.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:53:55 -0700 (PDT)
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
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] ARM: tegra: Add SOCTHERM support on Tegra114
Date: Fri, 21 Mar 2025 16:53:26 +0200
Message-ID: <20250321145326.113211-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321145326.113211-1-clamor95@gmail.com>
References: <20250321145326.113211-1-clamor95@gmail.com>
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
 arch/arm/boot/dts/nvidia/tegra114.dtsi | 204 +++++++++++++++++++++++++
 1 file changed, 204 insertions(+)

diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/nvidia/tegra114.dtsi
index d95c1f99731e..7a4c5da76080 100644
--- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
@@ -5,6 +5,7 @@
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/tegra114-car.h>
+#include <dt-bindings/thermal/tegra124-soctherm.h>
 #include <dt-bindings/soc/tegra-pmc.h>
 
 #include "tegra114-peripherals-opp.dtsi"
@@ -263,6 +264,7 @@ actmon: actmon@6000c800 {
 		operating-points-v2 = <&emc_bw_dfs_opp_table>;
 		interconnects = <&mc TEGRA114_MC_MPCORER &emc>;
 		interconnect-names = "cpu-read";
+		#cooling-cells = <2>;
 	};
 
 	gpio: gpio@6000d000 {
@@ -711,6 +713,48 @@ mipi: mipi@700e3000 {
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
+
+				#cooling-cells = <2>;
+			};
+
+			throttle_light: light {
+				nvidia,priority = <80>;
+				nvidia,cpu-throt-percent = <50>;
+				nvidia,gpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_MED>;
+
+				#cooling-cells = <2>;
+			};
+		};
+	};
+
 	dfll: clock@70110000 {
 		compatible = "nvidia,tegra114-dfll";
 		reg = <0x70110000 0x100>, /* DFLL control */
@@ -875,24 +919,32 @@ cpu0: cpu@0 {
 			clock-names = "cpu_g", "cpu_lp", "pll_x", "pll_p", "dfll";
 			/* FIXME: what's the actual transition time? */
 			clock-latency = <300000>;
+
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <1>;
+
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <2>;
+
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <3>;
+
+			#cooling-cells = <2>;
 		};
 	};
 
@@ -905,6 +957,158 @@ pmu {
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
2.43.0


