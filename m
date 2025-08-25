Return-Path: <linux-pm+bounces-33013-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6606B33D03
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 12:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE843BFB83
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 10:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2E52E1744;
	Mon, 25 Aug 2025 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDA4KYTy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7604E2E040F;
	Mon, 25 Aug 2025 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118459; cv=none; b=VaGlBxamjkxk2RwsYxbOFMjnqogcUOwuXSNPvv/HTCNV91wrXnypJ0HABZrgenRmtXvpSe4pmuaC4iALLMBri+/oTHoDgEi/MgAw9aEsimC2N20kh9khU4wn05/hlhNzS9GePBplp+HAuULsHYlAEYsrdPN3AQNZBLtFkcj9wdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118459; c=relaxed/simple;
	bh=LiQDhV5f50/8Y18H5j2Jv/XJTXQqqr5RKG1oaz5HZEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m57nBjNmfTgm7/aRpipEfeFQUld3EZvdVQbOAu4W5OAjwsBJoO/M6rVzCCDWizBWFzr3ypsMy2UU7UIvAdZcKRIYxUCr4eE7PaBEBNjh7WGXWtnW/q8UrdVCc3206n1GRUMkqY3PFyVG2IxL6c57tYMH2CHLBLobD1hLFzahpS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDA4KYTy; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb78d5dcbso606390666b.1;
        Mon, 25 Aug 2025 03:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756118456; x=1756723256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4CtVhRMDKYM8zIqd1+1OnEIHPKtfkbQqhJ8+qtXKU4=;
        b=nDA4KYTy9vBa5K1QWxNE3p9UQ34rqmmfiHP8OvqFM2sXQE3M6x5ZsWQI5MMq3KOC6m
         PdevP2blB3XN5Se8+kSypyrFggrYRCw2dwgp9TyJEWLL9lM+aipP41CPV7QXndrmyduu
         8EMx6pWAZJCmFWhY5N+psaLnShz+IsQG8FxP3ETrvSShuuOj6S0PaBmYhq6eKZryLvBe
         8IA6v3PjDUQ2OKXYd7r4NlxIegN+gWiIggTGcz+JpYAO3FXcfPxyBw5SCIYV2/5qgQ+v
         JHjSnoiXbPnfXSkstLUEUNOMIMxKlK0njq0KzPAGGTNSjDLDEdqzAvAFJWHqO8Sl3gfp
         bMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756118456; x=1756723256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4CtVhRMDKYM8zIqd1+1OnEIHPKtfkbQqhJ8+qtXKU4=;
        b=h7VQGvfTpQ2an2XIKqdQQibGgu7TFDIvgdHDzoHZJng6QkNCY2TCSkIauUYYI5hIfy
         u61oyv3eLfQ+rg3w6agj1dBlSekWNLXsIW9t2KtbRpsto0dL64CnH9bS5Tsh/9Shefl4
         SbaejPQ1FZHBHzXhODhb33DwDMGlbsvpo2xAj280pWB7EyuxVTYxO7qNHzpIEgpvasTy
         8HvIizc7IhFOuY1AIDa9zygObXqF6oWRkRHfm+Rupw/T6CL1mv7+UuVYsCUrvWZ5sSgg
         XdqoYUOuyLsZcFa97tKQmIMPNVV5yBkQp1UejpiFy0wqV5DSGquR+aCah1l8KCEe+dJq
         8bdg==
X-Forwarded-Encrypted: i=1; AJvYcCWKuP2+87st6KVT5hdYxN8OgZ0DZpioHyZMEGJUrSD7CPvJ+Zcv1AhqttsXp//M6x/XixL3Sc+jWJ/4j6E=@vger.kernel.org, AJvYcCWkMgzXMX+CmuN8S7uQLKM8lljFjHx/CU/3S6Rx4WbThKgvWi/DZ8Ne1fWEA4vyNVjtjORZoeE5sDF4AjVz@vger.kernel.org, AJvYcCXkSWcXLkTptnEBqsGwwMSXLNglgFtf54T1p7T/Xic00Hwp9PKadTiVWrbSWTGqZeUsXDqPmkzkUc1C@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbvj8y8ubj1j4c1a98X4EMhpCpQmwtbcJADCVT2wZ7iNsQ6/78
	YwGqjNQI8IV19RtwP61kS67/0v44qvE5znP7ULoy7UazpZ2F+9AYnTt7
X-Gm-Gg: ASbGncuCb0V9GXPK21R1Zpnxchx8+rHuN9iiu00OohnH4QT2iN6PX4Q9JxN3k7u9R0W
	hfgu9iuyHb8ETMnfmzQcp76bRTV678RqqaR9So43Bd0/dESrNWQQq2641kh+AMjJ7SQK3dDblnh
	BKDFwN9dLzsXn77vHnEtYa2mIbWfEiVS6EJg7/lCrAS1cm04qNHfCIvlkH8JMoVMResE8TBRqr7
	Q4yAqjk/+AHQVb8qtUKufjHitF+K/0/ZN6Z+tQha+8u3JaDyyrLvDLKQtXLGsmrMdyyqf8WSfxU
	ZpKUQY4OwANK4NwLSUt+XR41N3OkCASo8UrzOJZI8DGPJxsRKJdCEWLBl3TxHjQOXttvJGFY7Ih
	ojW6nV6VCUjx29BXrUv5yrvne
X-Google-Smtp-Source: AGHT+IEeYr9TNk1VWe9Wo+X3NG7lISQ5/rcfCyk22+fD0nbjU56v5ZMUJZwenXbvl7cGuOACYB7uDQ==
X-Received: by 2002:a17:907:268b:b0:af9:c31b:c558 with SMTP id a640c23a62f3a-afe29537f96mr1026367266b.35.1756118455513;
        Mon, 25 Aug 2025 03:40:55 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe48fc0912sm531683166b.42.2025.08.25.03.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 03:40:55 -0700 (PDT)
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
Subject: [PATCH v4 6/6] ARM: tegra: add SOCTHERM support on Tegra114
Date: Mon, 25 Aug 2025 13:40:26 +0300
Message-ID: <20250825104026.127911-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825104026.127911-1-clamor95@gmail.com>
References: <20250825104026.127911-1-clamor95@gmail.com>
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
index 3ee51d7f3935..c666db564204 100644
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


