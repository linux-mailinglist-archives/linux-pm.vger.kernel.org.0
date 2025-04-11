Return-Path: <linux-pm+bounces-25197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90149A850B0
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 02:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD0D1B68830
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 00:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53E01401C;
	Fri, 11 Apr 2025 00:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCOUiMHy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E9817BA1;
	Fri, 11 Apr 2025 00:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744332046; cv=none; b=seZcyq1EHLHJvtpEl9OFRK1rPJf2n8PvgjdBTLPjBJ0aNOCu3qtCMEZwwcRrpD/f3SoeK1T+yf9mbTNFL9SO1ng4V3L0Qrsk9HWcTbiTA02xulyoii1onKqEMAsQotnIdoTIJmWny8ckBSIRACKRe7IBavv+lixpC2L6l8BhrUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744332046; c=relaxed/simple;
	bh=Sr9C3AkfTXW+bU8fjxHLzXQi2OaODJymdItrPseCW/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRA3tPM4A5LuWWGECx/S/5MOflozrEICFVIbEkNVfs2hBJGn4Dhic4YLfqFrCT7Gbw5Bgs/1GQJjQjA1OJaRCikarHypKNL0twZoeCMKR189G3nLpNCwq7BNkSGxkIVmNT8XVovjCuAxB0AtUsV14UGdMFbJeIkDMO/AeYpNuas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCOUiMHy; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bfca745c7so12473021fa.0;
        Thu, 10 Apr 2025 17:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744332043; x=1744936843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqMMUOwQC1FQBaxF5Z+cbkCBiisCIHbCIXU0D1pZnrM=;
        b=NCOUiMHyIKUq+K5kG4KLDT27qG2AzFveUc3kFy76CxwCGOqGW63SLD7X5tCzK7AzF0
         IvVV3Ff1o5p+iFJINMcXUgJ9M5tqh/qpJYcQL4tUUc/+Ms9DLtlYjnm264aeczXYQh5V
         veg2Ot+cXdRmparwjTCydrQcoYDpF4uFv8mo6aKwi8dgx8OaKPsAW2zPLqKSuLfYECtx
         aKu4PCn1jsO+dJKGSd5ppT2nKwBnx19texwlFoGD/po6diWVVUElRvxaDRcrHQBl5Zg9
         TCUe2BZhP12Qa8yPhYd5AqyeA3A65H/PhXem9h1m0iQuHzxXLFWRAZUuBeJCdgbjYOLa
         srQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744332043; x=1744936843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqMMUOwQC1FQBaxF5Z+cbkCBiisCIHbCIXU0D1pZnrM=;
        b=eDKNcW1dLckJtKs0zJnG4rykaVwvnMuSUCZs5RnfG47Yy8poAsb3BA1BMwoVTSldIY
         7Zmm/b10Mh+m4BFXLYGoWZiR8rE+lawto19BiCqDGMO/ERY8imIuj6tLhO2pO92tiaCy
         PMY2QH83cPAT0pmhjztfLO3sjoP6MZgi/kMGAy0AWOT1Kyy3T+rpJB6Kd4+RfMdwMCop
         RYSxk9xb80HgPnV3w6zBA7aBeXLQM6aJ4RpAPCQFmKUwB40eEiAsT5cz5kNE3HERnjOd
         PDJ2ft9nawyw1etsyKAQSJqgK5pjh9fzDRy2qxmwjekM27ZI5B2yvkbll9+Iam9QHaBn
         mSYA==
X-Forwarded-Encrypted: i=1; AJvYcCUBhuFj7S5BnLB3gkP8GJKaa7Yjt7xYAFWxK4R9poS084NqBZDfM7O7zGvaEZOVpwBixYzptI3j/fhT@vger.kernel.org, AJvYcCUdmZQPXG854WJ0Smyl3HrQ2GkfAs4D82HP/C0mR6AnWXvCJDqBMr12uL+986ePv+yuW7u59cBfRWf8r5Uc@vger.kernel.org, AJvYcCVZZNHobTBAw7sTslFej+NRtqakO+jV9eN3XQO8PfRuwcRBTu+G7jL6m+0wVG2BBkPF6ONP3In4/tE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJBVJAPgCXzTjSxsttQcLPiy2gpyluWDtKxzH05GwW45boLA4M
	CUHc0wvplkF0jfMoSPg/CU3rr8vuIfRX0cgMll0veoHcY69RHiWI
X-Gm-Gg: ASbGncuh4PY5Wa3pfYOXzUvbcV2OkuMezz1gqfJvpeaVrvc4PT0Z4i5i/QnAqu/Lsit
	MhfhzwMas282Li2tob5d7nfINQb62iwMyZ0vammBrww1hsXHjYRaEC7oFQMBLehJ5ObTRTaNnLY
	wxrOxowgJBsDjdmQYT8B4eUKI/LF3FnBjHmfre9yBPTzSjivSnvA1xQdprg37+PNb6gNZSS5YhE
	h5pmUQButOPLCLRFgroDgejDYCA1TzqnToSt2qI3D7czEw7FaniynitVrDZoqJ/FAGHQaOv39LY
	vR8T+dfIX0yaAeFRivcJPr5/ODEyVsigC4LwV55vN3hfUFcPCw==
X-Google-Smtp-Source: AGHT+IF33816+KiMMv+fNeFdW0EInDxjtilG9kyALznQ6Y0n6dpa1CvrQmH8HkK1cx1k6+UUsrWg3g==
X-Received: by 2002:a2e:a9a3:0:b0:302:2598:de91 with SMTP id 38308e7fff4ca-310499fb36bmr1693111fa.16.1744332042866;
        Thu, 10 Apr 2025 17:40:42 -0700 (PDT)
Received: from localhost.localdomain ([176.106.241.81])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f464ea5c6sm6344251fa.62.2025.04.10.17.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 17:40:42 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Subject: [PATCH 5/6] arm64: dts: allwinner: A523: Add thermal sensors and zones
Date: Fri, 11 Apr 2025 08:38:25 +0800
Message-ID: <20250411003827.782544-6-iuncuim@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411003827.782544-1-iuncuim@gmail.com>
References: <20250411003827.782544-1-iuncuim@gmail.com>
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

Add the thermal sensor configuration and the thermal zones

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 138 ++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index d626612bb..4f36032b2 100644
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
 
@@ -171,11 +180,39 @@ ccu: clock-controller@2001000 {
 			#reset-cells = <1>;
 		};
 
+		ths1: thermal-sensor@2009400 {
+			compatible = "allwinner,sun55i-a523-ths1";
+			reg = <0x02009400 0x400>;
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_GPADC1>;
+			clock-names = "bus", "gpadc";
+			resets = <&ccu RST_BUS_THS>;
+			nvmem-cells = <&ths_calibration>;
+			nvmem-cell-names = "calibration";
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
+			nvmem-cells = <&ths_calibration>;
+			nvmem-cell-names = "calibration";
+			#thermal-sensor-cells = <0>;
+		};
+
 		sid: efuse@3006000 {
 			compatible = "allwinner,sun50i-a523-sid", "allwinner,sun50i-a64-sid";
 			reg = <0x03006000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			ths_calibration: thermal-sensor-calibration@38 {
+				reg = <0x38 0x14>;
+			};
 		};
 
 		mmc0: mmc@4020000 {
@@ -602,4 +639,105 @@ rtc: rtc@7090000 {
 			#clock-cells = <1>;
 		};
 	};
+
+	thermal-zones {
+		cpu0_thermal: cpu0-thermal {
+			polling-delay-passive = <500>;
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
+			polling-delay-passive = <500>;
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
+			polling-delay-passive = <500>;
+			polling-delay = <1000>;
+			thermal-sensors = <&ths1 2>;
+			sustainable-power = <2400>;
+
+			trips {
+				gpu_temp_critical: gpu-trip-0 {
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


