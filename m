Return-Path: <linux-pm+bounces-32712-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA239B2DB7B
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 13:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFD247BDF3B
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 11:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4952FB97B;
	Wed, 20 Aug 2025 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8JNzrVj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A74E2F5307;
	Wed, 20 Aug 2025 11:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690189; cv=none; b=QkA9wLT2FI95pd9RsBdGSaX75DFLs3aU5vrc8aotiojtEvQogUWV4F+pA3cS8NTDRWRxKatdiSuHuLzM1L2RcJPQIYXuWZLY1T2k/K/8oEcKYLKhdvsByWNMr3dV0xQb3AornH3HkEOGkyynTTj6+W5Gm/zBlaZZOamZ70XYhnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690189; c=relaxed/simple;
	bh=3SRUxUwtu2/OABIaUtBynxiU7DmXOz1RmnCOODQVZfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/8vn/bZUzcVIq0R25pujk9Tnf7HZzaAJNnaDAEly+1S+uu8IbKhq9W44o0Nv3C/HVWuEtGJmrc1YilzYHpaCQJ0YTRAMytE9rqf8WDZaBBp6f3Dyi9pUG9M6iXVdUnAiN70aYbb2fz5NAJi+Stey5n5QfWjcHXV3B2QgEshC30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8JNzrVj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6188b690517so9592627a12.1;
        Wed, 20 Aug 2025 04:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755690185; x=1756294985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWbApeSuKNHR33R0EFawYahQbF8nPR5Jr4AKqmYg5qo=;
        b=g8JNzrVj/NrHyf9VpQg6Ix5zddE+Za7T9Q5nXUyWSoR1uHF6JSalre1OgxQqPxKuKE
         iFQUw6BKnz5nEZWwhwyxy9A1qjHMAntAd5OKkkqCuWtY9KUR/+nqnrqFAphkMaS5iAty
         nxoGmq98AD81x5oWjpbsYQTIuyU73pOY/2PZfBGQjuUEQPMbOI5oQr1VWbX36rY4kUqJ
         IdJuiD3sRhOMRm6k/ArSuTwglyisutiTeLfb5fxdpmRMtWz8Z0i102S/m6Voei7zDOZ1
         bbubnfwGxpSe8KIDLfMXFeQ+Abj/A9s2ZZzJAqwI8h4a8PKSMl0V5nzhxFTnrv4iHKqc
         D+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755690185; x=1756294985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWbApeSuKNHR33R0EFawYahQbF8nPR5Jr4AKqmYg5qo=;
        b=ktlkvz97z0ZTubvgq06pOOOgQkKK2klKAhFZRTlwW95tx6gNgUkGdF4rzEdDEAf7Du
         4ldJ5t0k27SXMbt+10YErBncYzRqevFiTis26rnGQMa3H3N1DL5kSnNEUTu8PkHEC+5J
         L4QV8FPDOAAu5cViURb19iTSEyY3S+hoppoDtv01yLLpjMJevNDfO4u+I/ihMkMkqaQA
         9egoEH4CZUWRBd/dcuWOjGEl49HfqxFzJEsJMNdLTJzYQ50RV28H/KjoVfnAT4LWwfcz
         4QAMr7fzfwlvULNpk8Dvu7E3qYqf7Vf7+BrW9jfDo1cgvkQKYgQS3wXn8KVdqV34urgU
         k9ng==
X-Forwarded-Encrypted: i=1; AJvYcCUL8tqT4Ic2UQvzXjt7NBtfqiARdjJD9dUUc+kXrPrtprolr/LZWGH5J9VLH5nddxS+Tq/JGsdkFwicf3Y=@vger.kernel.org, AJvYcCUjwq9BCMC2v0+OtLKz4hU03Ja9XAIcXRZGrR2My/u2eMUdYwopaIEywktKWmtsCizYFh/X4Vstrsf2@vger.kernel.org, AJvYcCXMCdMj4C54IcT2m8MKMOBk3rIvitnxxRiFA6BJkY1BRXyPEB16KYcfimdzLYnE6E/Uy9HBzWN9bOWnAVWo@vger.kernel.org
X-Gm-Message-State: AOJu0YzqLuqMSuH56mixcj49deitRuMyQuZc5aC4aZ4B8d3pBC8qc0Za
	7KXCkldTIl4+bZGFRU1dlrQ0TJ8x0WXZyRgAKntOpgJIqYmOAmf8Bwk0
X-Gm-Gg: ASbGncsDQouFH7l0Rmkia/0aG0VElN6U0XRwbsatJE3NEJ5o848++DI0SO+AGZuC86s
	hizEETo6wfsZ8NDf+qCaajc3qM7nQxvuez0ojfDf7gHDX1AcdePUeTeSeRuHFPxTJa/IwYOAgG5
	qT97ZtpKaqIuGxsIW7zvWARMBD/XqWu5Zpx6Vi4OaA/7ksNQ16Tc1IHTytcGtR/BYciGhBXHXAE
	fUSFmnWW10pmiiXfUWPKTVyq49gSsRS9Z2KyKFKWlre1BO9isW3dzKd4LdkAYeXeqnNAN1+ME6F
	TPWDRXbCFD2Xdh2QirkN7Y3Md2njJudNM1jTB66RyFxfgjog0/nioj+AJ9n5ohi7ZIoE6aHhtO6
	BGvVAiGRophyZEw==
X-Google-Smtp-Source: AGHT+IEAWJ6W3ynq0KlM+esaiuS1ibm+fZyVXcSbmZgIXfZtk1ihUS+V94rNIK9Rcu6kL3WIibXAfw==
X-Received: by 2002:a17:907:9626:b0:afc:a330:e423 with SMTP id a640c23a62f3a-afdf01a7b32mr181014066b.42.1755690184151;
        Wed, 20 Aug 2025 04:43:04 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded4ca695sm161769566b.90.2025.08.20.04.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:43:03 -0700 (PDT)
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
	Svyatoslav Ryhel <clamor95@gmail.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] ARM: tegra: Add SOCTHERM support on Tegra114
Date: Wed, 20 Aug 2025 14:42:31 +0300
Message-ID: <20250820114231.150441-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250820114231.150441-1-clamor95@gmail.com>
References: <20250820114231.150441-1-clamor95@gmail.com>
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
index 3ee51d7f3935..d9c51e6900d8 100644
--- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
@@ -5,6 +5,7 @@
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/tegra114-car.h>
+#include <dt-bindings/thermal/tegra114-soctherm.h>
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


