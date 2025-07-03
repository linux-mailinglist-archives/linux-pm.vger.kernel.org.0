Return-Path: <linux-pm+bounces-30070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D151DAF7B27
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 17:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544B2561C23
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 15:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5367C2F2705;
	Thu,  3 Jul 2025 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIetxW8L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE0F2F0C40;
	Thu,  3 Jul 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555683; cv=none; b=Wy6w+87/J6h1dNL1y87M/opIZtXRylg5QmIK0qQ1HlH/5HFDNLEILWDGSHNNMlU8avYs9coaUStXIaOXbfoPso3FvMFBCeDuQ/JvhfP8lJtxsbowQMrKqmN9RTfG64/C9MS88glGj1vMzD9VSAuCCoi+1i2hkuKQgP5aiDg2k5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555683; c=relaxed/simple;
	bh=fhcxMBCx5MTr6SihPiwsz61YzqiTUdchgCWmq3QXsfM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rb7lA/pNqfhUZkYCIPQ4/DuI/aVoN1EtaA9LWxKwmtyvPN61u+kxAa26KBU+vXtPJdfw9ckiHopB6v1kOCSr43xLvpHsA+ohk1aY1yKLb/141IIIDH9k9UERd6Lwi4w5BeMJWrwSK9Ldc8EavYCOPyUSCkiakb2jZY3kpUMbZjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIetxW8L; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5550dca1241so43857e87.0;
        Thu, 03 Jul 2025 08:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751555679; x=1752160479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Etd5OO5QwEViSvNlV1qDwHk/jnF5rm8WMn4WLxwMFUs=;
        b=jIetxW8LmfdYFwMbzcHnbiSxUb3ejASN5rRJHmKo7e4iZEAhAKvmFCgeEpZ+8ULsn/
         X271r7mdml22BOMjO3C11+J8hzATeEAk0QHFN8k/G18XTqJyoyWHW5OOtjGEJtdVxVOx
         OLboHxrXp8ernsBPvneeVL1++AF1Ox06vHN4KmTa6Z/r0umS1zHRYfyq6r6CPIbs3wOi
         3gDJ4hqBiOTFa4qQ5H4f6fzGkfL2EGs6ZygjUOeN/NDIrBHaKLO93lrOaVCLrEaF8mxw
         O/eaijMvSoP1/DbFZAg575MRvzW6By9GC6cOZ3il9JgjpeVBw8cN9kfTQcO/MkHi5+D6
         sZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751555679; x=1752160479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Etd5OO5QwEViSvNlV1qDwHk/jnF5rm8WMn4WLxwMFUs=;
        b=TzssYlYEG7hAYs5MaLQcLBnueli9zYbZiiDhnvLnVwKE4KcFDmZf2AlPFZFL2kTRPY
         dbwnNepSVtlST9yhZsXMi1+ylvRGWzxhKAucNM1Sn3h7+D5IdADIlSzz1RSMBXYi/0vw
         p0AmFCM5jjcsgEukSTfE7wEFLDgIy5Xp86DAMIltGPa5Lp99w0Gy/aHY4+0kDL2yczFL
         w+3iGq8P1/kbMXwHJCE7Wkftb4ilyzOqkRxASv6UAcmqBIyJLyVGnzbLUUjI4LI+j1Jn
         BGwYziexg//cpL8lc1gf565DJdGmVl3KdFgxpJT20V6aHm3MrqOBISRghlI0sdms3m4f
         0a9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIVopV/HkFM6XhDWnPZ+7s8Ec7u9zm+eyRu03WOldEELj9nrvuXuUmycgpfE5D3sgZuWaxSNK6CxHCwWgR@vger.kernel.org, AJvYcCUl87DrfHf+1HvyJ74dE6mJHLMkvrmAun44xeEkUij2wc3WE6CI/Ly7LzsuZtFddPL4ggCMLEbwDjA=@vger.kernel.org, AJvYcCUvVO9SzLJHrCVe/6pQzcfNUosoPZyXXfgJQAMl2ulbrpD/ZLeKMKqbT+FuIDStzOybCnuHaVtz+ddS@vger.kernel.org
X-Gm-Message-State: AOJu0YyD+y/95uYjMlSDMVI35NeQKomMt9P1yYMH9hP6j5UUpXR7M+si
	uEmNkkwnfS1YB2JEYg57qZ6fstCgVzWDTn2QL0OvTqbXWBpcv3HqBV9u
X-Gm-Gg: ASbGncuOZdAEcZWSzZIihJtuj0PZmtR985pcgjQ2fky7Wa1/jlNmCd9xZTls/097/yk
	6HqstbkXn7tIWGKQk89cZmFE6/P7PSvBtvydKcePdZBa1Alw+3ksjKt7C8a1rsUOP1b5fNOHr3Y
	+dEWkR1Q1zM+VpzqhwG0hD1fvXRlIoH/ojiEA7ndN/9Bptmkt3/7/qvpbrtdPlNBjfRQgwzcMbx
	uIS3yPsRAH4viQ7HYtWPy7BeipllJwkbff727kxLhJS+54f+NRImfGM+BOuIliciUwtvnaAS3BD
	3LcrI/OCp+7EW16hGu+iPfSwI1Zops/z2Gs44+kTC1uy4/6HubTkVgy6eKrGes22F8GA7Ak=
X-Google-Smtp-Source: AGHT+IGqnSEbj2pT+ZjtFNv4wrIx8GjJh5Qeal1y0PD2vdZ9VqbHrLg+OvYQhguC06zFZbvQAjK7cw==
X-Received: by 2002:a05:6512:1041:b0:553:35ca:5922 with SMTP id 2adb3069b0e04-5562ef79572mr1349079e87.56.1751555679179;
        Thu, 03 Jul 2025 08:14:39 -0700 (PDT)
Received: from localhost.localdomain ([212.192.12.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384ae15esm725e87.178.2025.07.03.08.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 08:14:38 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 8/8] arm64: dts: allwinner: A523: Add thermal sensors and zones
Date: Thu,  3 Jul 2025 23:11:32 +0800
Message-ID: <20250703151132.2642378-9-iuncuim@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703151132.2642378-1-iuncuim@gmail.com>
References: <20250703151132.2642378-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

The A523 processor has two temperature controllers, THS0 and THS1.
THS0 has only one temperature sensor, which is located in the DRAM.

THS1 does have 3 sensors:
ths1_0 - "big" cores
ths1_1 - "little" cores
ths1_2 - gpu

Add the thermal sensor configuration and the thermal zones.
Trips temperature, polling-delay and sustainable-power parameters are derived
from the manufacturer's BSP.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 154 ++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index 295292d67..a1304c55c 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/clock/sun55i-a523-r-ccu.h>
 #include <dt-bindings/reset/sun55i-a523-ccu.h>
 #include <dt-bindings/reset/sun55i-a523-r-ccu.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -22,6 +23,7 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			reg = <0x000>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@100 {
@@ -29,6 +31,7 @@ cpu1: cpu@100 {
 			device_type = "cpu";
 			reg = <0x100>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@200 {
@@ -36,6 +39,7 @@ cpu2: cpu@200 {
 			device_type = "cpu";
 			reg = <0x200>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@300 {
@@ -43,6 +47,7 @@ cpu3: cpu@300 {
 			device_type = "cpu";
 			reg = <0x300>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 		};
 
 		cpu4: cpu@400 {
@@ -50,6 +55,7 @@ cpu4: cpu@400 {
 			device_type = "cpu";
 			reg = <0x400>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 		};
 
 		cpu5: cpu@500 {
@@ -57,6 +63,7 @@ cpu5: cpu@500 {
 			device_type = "cpu";
 			reg = <0x500>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 		};
 
 		cpu6: cpu@600 {
@@ -64,6 +71,7 @@ cpu6: cpu@600 {
 			device_type = "cpu";
 			reg = <0x600>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 		};
 
 		cpu7: cpu@700 {
@@ -71,6 +79,7 @@ cpu7: cpu@700 {
 			device_type = "cpu";
 			reg = <0x700>;
 			enable-method = "psci";
+			#cooling-cells = <2>;
 		};
 	};
 
@@ -181,12 +190,46 @@ ccu: clock-controller@2001000 {
 			#reset-cells = <1>;
 		};
 
+		ths1: thermal-sensor@2009400 {
+			compatible = "allwinner,sun55i-a523-ths1";
+			reg = <0x02009400 0x400>;
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_GPADC1>;
+			clock-names = "bus", "gpadc";
+			resets = <&ccu RST_BUS_THS>;
+			nvmem-cells = <&ths_calibration0>, <&ths_calibration1>;
+			nvmem-cell-names = "calibration",
+				     "calibration-second-part";
+			#thermal-sensor-cells = <1>;
+		};
+
+		ths0: thermal-sensor@200a000 {
+			compatible = "allwinner,sun55i-a523-ths0";
+			reg = <0x0200a000 0x400>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_GPADC0>;
+			clock-names = "bus", "gpadc";
+			resets = <&ccu RST_BUS_THS>;
+			nvmem-cells = <&ths_calibration0>, <&ths_calibration1>;
+			nvmem-cell-names = "calibration",
+				     "calibration-second-part";
+			#thermal-sensor-cells = <0>;
+		};
+
 		sid: efuse@3006000 {
 			compatible = "allwinner,sun55i-a523-sid",
 				     "allwinner,sun50i-a64-sid";
 			reg = <0x03006000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			ths_calibration0: ths-calibration0@38 {
+				reg = <0x38 0x8>;
+			};
+
+			ths_calibration1: ths-calibration1@44 {
+				reg = <0x44 0x8>;
+			};
 		};
 
 		mmc0: mmc@4020000 {
@@ -644,4 +687,115 @@ rtc: rtc@7090000 {
 			#clock-cells = <1>;
 		};
 	};
+
+	thermal-zones {
+		cpu0_thermal: cpu0-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <1000>;
+			thermal-sensors = <&ths1 1>;
+			sustainable-power = <1200>;
+
+			trips {
+				cpu0_threshold: cpu-trip-0 {
+					temperature = <70000>;
+					type = "passive";
+					hysteresis = <0>;
+				};
+				cpu0_target: cpu-trip-1 {
+					temperature = <90000>;
+					type = "passive";
+					hysteresis = <0>;
+				};
+				cpu0_critical: cpu-trip-2 {
+					temperature = <110000>;
+					type = "critical";
+					hysteresis = <0>;
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu0_target>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu4_thermal: cpu4-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <1000>;
+			thermal-sensors = <&ths1 0>;
+			sustainable-power = <1600>;
+
+			trips {
+				cpu4_threshold: cpu-trip-0 {
+					temperature = <70000>;
+					type = "passive";
+					hysteresis = <0>;
+				};
+				cpu4_target: cpu-trip-1 {
+					temperature = <90000>;
+					type = "passive";
+					hysteresis = <0>;
+				};
+				cpu4_critical: cpu-trip-2 {
+					temperature = <110000>;
+					type = "critical";
+					hysteresis = <0>;
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu4_target>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		gpu-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <1000>;
+			thermal-sensors = <&ths1 2>;
+			sustainable-power = <2400>;
+
+			gpu-trips {
+				gpu_temp_threshold: gpu-trip-0 {
+					temperature = <60000>;
+					type = "passive";
+					hysteresis = <0>;
+				};
+				gpu_temp_target: gpu-trip-1 {
+					temperature = <90000>;
+					type = "passive";
+					hysteresis = <0>;
+				};
+				gpu_temp_critical: gpu-trip-2 {
+					temperature = <110000>;
+					type = "critical";
+					hysteresis = <0>;
+				};
+			};
+		};
+
+		ddr-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths0>;
+
+			trips {
+				ddr_temp_critical: ddr-trip-0 {
+					temperature = <110000>;
+					type = "critical";
+					hysteresis = <0>;
+				};
+			};
+		};
+	};
 };
-- 
2.49.0


