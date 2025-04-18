Return-Path: <linux-pm+bounces-25736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08912A9407D
	for <lists+linux-pm@lfdr.de>; Sat, 19 Apr 2025 01:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760081B61FCE
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 23:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331B7214801;
	Fri, 18 Apr 2025 23:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qRJtYn9T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA2C43AA9
	for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 23:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745020652; cv=none; b=scWzuW3qI0oXn5QJvZVKip7cBDGRjJyzkUYcROH+T9PKdsb3M5kio3FBfg/XNOZMhFXzk4fOyHnNiFUJcxmXSYoDCyCH4F1qiqQjK+BGtxF1CJM2LkPOtYxHvKnL28rLX8C8fYB2t8s7wd0ZdCDVMBp+PGiodV/DZVDEIovhfYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745020652; c=relaxed/simple;
	bh=S2VEHN6Z8B55QSoNsJTLvvgFATSdI8E7IhUrvFT/uLo=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=iFbjx2ZeazNlx2JFZAdlWwGpdUWwtp/flKFZmZJrdmH2HsZGIAa0KqAuQLyQSYxdI797n6RRO0nv0uLa/f5qvSFQkggR0Fw0itbSehg6W5Upms7XKH4RBF98Hkcu4BpPHt+QuK21HtPMkWxwLmzjkD5CvyLNaximOwSho1cvtuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qRJtYn9T; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47686580529so25026731cf.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 16:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745020647; x=1745625447; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rgJHzIzyaD1npkS46bS+JQBBaGuaTYEokeH33dSjs4g=;
        b=qRJtYn9TEXJdG7XCxPw2GeLTZ3RP3SotqJzpBYgaBYZo/seqksttIBpUQcqnp1Y3E9
         uIeABeqfbPxlj0OBw+DZgYdKIchFUFBZkokF1nUL+htpyKvisHPjSFtlxYm16enypDwK
         Si1/TuwFtVk/cO1HohtvZPtO08lnLHMno0WvVD6ydFm7dbi7Vfh8Yp+H8Z3S69Xry4DN
         4UVe3Uj7J3AqopkAIfqrtAv9jondtISeSc9o2+NXWLXY9LrBfoHHqTEaiKfMC20AXQpn
         W3oNNpDiopuTsfIOstzdKjjEpQOuiYJN7iIRf2lDP/h9t23eT78kVL/FnY2UtBNApiXn
         sRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745020647; x=1745625447;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rgJHzIzyaD1npkS46bS+JQBBaGuaTYEokeH33dSjs4g=;
        b=M/R72+MyXEqo2u5UpiSi/5qObbcDQybZuNhjlBICzAC5d2K/1s3OYfWrrhZGTemUxn
         jS1Osz+qkZpA2VkXgTUg8ig1ABwXt+9i/vYFtzRPknSZl/xdHrAHxl+3mR96cel4pkuN
         3OKsGJhbODlytv4ccMUWM9pXuvVO15ELU47PGCxU+Vy2DJWtPKgL5R2LMf6OamQ4jZlf
         G+rRLv4ogv1ynmpgEIxc0QRpa+yx+DxYjGp/3aaLFJF47Zo3HL1GgepeuQeVDXaizD0N
         Ruqaax5yUgLtfMR0NeVPqx0nYrucuPIy2wvJVUWH6PnLrU+RN7Pqz7tlDmYWLt/A8TTR
         vaiQ==
X-Gm-Message-State: AOJu0Yx1bLsgzultS6AcyxdIi05J9RmgUMrvVpAohNkMJIKHHudkrR5O
	6zPb1YkRHgqspKo61t2p5x3kjn1P+thwWqBs5V8xZ/yqkwCPsrrZ8yD65sZSHHg=
X-Gm-Gg: ASbGnctm6MBfyrNBmlucm4PzOK4p3kKfbKn4a8S1oDZJb7MZAQxAA0P3ROZmol8nNpL
	p0urSuAQYuLc001UUdqyupwPBxTHOZk/gLFNjQzbWkL+KhOsyr9l7L31uR5rkAHViLMrHgNgBWb
	SBkR4vUSPRq0GUb8g+y521Ee8VEZVUOu3BHYfCxS8HWproLTYyNTLL7J/cVHK0DZqagEKFt4H6l
	4caML78L+3il/ZdDRVSWJOE9A1VRQlw7lGdj9KojfmtiRuZonyJOfN9/IcVeDsm7WpIG8xWSAPP
	ur9b0Kr+qVY4TvxKy8ZKO8u6rjrEvN3fUgGhGISceQRKv0bXzyLGfnq3IiEmdyxv/5zEU7Pl0Mw
	fDII=
X-Google-Smtp-Source: AGHT+IGONb+S3gDuaOs0a2vWRCUKlXmXCB8sKa4OKfOwyynXyupYfg2NlJIa10pzg2JliqDRdBaz5A==
X-Received: by 2002:a05:6214:234a:b0:6e6:6505:ceb2 with SMTP id 6a1803df08f44-6f2c4698f84mr89456026d6.36.1745020647414;
        Fri, 18 Apr 2025 16:57:27 -0700 (PDT)
Received: from xanadu (modemcable179.17-162-184.mc.videotron.ca. [184.162.17.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2b0f11fsm15626246d6.39.2025.04.18.16.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 16:57:26 -0700 (PDT)
Date: Fri, 18 Apr 2025 19:57:25 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
    Matthias Brugger <matthias.bgg@gmail.com>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>
cc: linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH] dts: arm64: mediatek: thermal adjustments for MT8186, MT8188
 and MT8195
Message-ID: <prp38558-r53s-756p-o6n8-795o7q87sssr@onlyvoer.pbz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Adjust temperature threshold values. Provide the "switch on" thermal 
trip point to be used by the power allocator governor.

All numbers were provided by Mediatek.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index b91f88ffae..bfea811491 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -2229,22 +2229,23 @@ cpu-little0-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <150>;
 			thermal-sensors = <&lvts MT8186_LITTLE_CPU0>;
+			sustainable-power = <1500>;
 
 			trips {
-				cpu_little0_alert0: trip-alert0 {
-					temperature = <85000>;
+				cpu_little0_pa_switch_on: trip_pa_switch_on {
+					temperature = <58000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_little0_alert1: trip-alert1 {
-					temperature = <95000>;
+				cpu_little0_alert0: trip-alert {
+					temperature = <82000>;
 					hysteresis = <2000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				cpu_little0_crit: trip-crit {
-					temperature = <100000>;
+					temperature = <103000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
@@ -2267,22 +2268,23 @@ cpu-little1-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <150>;
 			thermal-sensors = <&lvts MT8186_LITTLE_CPU1>;
+			sustainable-power = <1500>;
 
 			trips {
-				cpu_little1_alert0: trip-alert0 {
-					temperature = <85000>;
+				cpu_little1_pa_switch_on: trip_pa_switch_on {
+					temperature = <58000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_little1_alert1: trip-alert1 {
-					temperature = <95000>;
+				cpu_little1_alert0: trip-alert {
+					temperature = <82000>;
 					hysteresis = <2000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				cpu_little1_crit: trip-crit {
-					temperature = <100000>;
+					temperature = <103000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
@@ -2305,22 +2307,23 @@ cpu-little2-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <150>;
 			thermal-sensors = <&lvts MT8186_LITTLE_CPU2>;
+			sustainable-power = <1500>;
 
 			trips {
-				cpu_little2_alert0: trip-alert0 {
-					temperature = <85000>;
+				cpu_little2_pa_switch_on: trip_pa_switch_on {
+					temperature = <58000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_little2_alert1: trip-alert1 {
-					temperature = <95000>;
+				cpu_little2_alert0: trip-alert {
+					temperature = <82000>;
 					hysteresis = <2000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				cpu_little2_crit: trip-crit {
-					temperature = <100000>;
+					temperature = <103000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
@@ -2454,22 +2457,23 @@ cpu-big0-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <100>;
 			thermal-sensors = <&lvts MT8186_BIG_CPU0>;
+			sustainable-power = <1500>;
 
 			trips {
-				cpu_big0_alert0: trip-alert0 {
-					temperature = <85000>;
+				cpu_big0_pa_switch_on: trip_pa_switch_on {
+					temperature = <58000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_big0_alert1: trip-alert1 {
-					temperature = <95000>;
+				cpu_big0_alert0: trip-alert {
+					temperature = <82000>;
 					hysteresis = <2000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				cpu_big0_crit: trip-crit {
-					temperature = <100000>;
+					temperature = <103000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
@@ -2488,22 +2492,23 @@ cpu-big1-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <100>;
 			thermal-sensors = <&lvts MT8186_BIG_CPU1>;
+			sustainable-power = <1500>;
 
 			trips {
-				cpu_big1_alert0: trip-alert0 {
-					temperature = <85000>;
+				cpu_big1_pa_switch_on: trip_pa_switch_on {
+					temperature = <58000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_big1_alert1: trip-alert1 {
-					temperature = <95000>;
+				cpu_big1_alert0: trip-alert {
+					temperature = <82000>;
 					hysteresis = <2000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				cpu_big1_crit: trip-crit {
-					temperature = <100000>;
+					temperature = <103000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 69a8423d38..c2ac47c77c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -472,22 +472,23 @@ cpu-little0-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <150>;
 			thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU0>;
+			sustainable-power = <1500>;
 
 			trips {
-				cpu_little0_alert0: trip-alert0 {
-					temperature = <85000>;
+				cpu_little0_pa_switch_on: trip-pa-switch_on {
+					temperature = <68000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_little0_alert1: trip-alert1 {
-					temperature = <95000>;
+				cpu_little0_alert0: trip-alert {
+					temperature = <85000>;
 					hysteresis = <2000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				cpu_little0_crit: trip-crit {
-					temperature = <100000>;
+					temperature = <115000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
@@ -510,22 +511,23 @@ cpu-little1-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <150>;
 			thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU1>;
+			sustainable-power = <1500>;
 
 			trips {
-				cpu_little1_alert0: trip-alert0 {
-					temperature = <85000>;
+				cpu_little1_pa_switch_on: trip-pa-switch_on {
+					temperature = <68000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_little1_alert1: trip-alert1 {
-					temperature = <95000>;
+				cpu_little1_alert0: trip-alert {
+					temperature = <85000>;
 					hysteresis = <2000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				cpu_little1_crit: trip-crit {
-					temperature = <100000>;
+					temperature = <115000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
@@ -548,22 +550,23 @@ cpu-little2-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <150>;
 			thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU2>;
+			sustainable-power = <1500>;
 
 			trips {
-				cpu_little2_alert0: trip-alert0 {
-					temperature = <85000>;
+				cpu_little2_pa_switch_on: trip-pa-switch_on {
+					temperature = <68000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_little2_alert1: trip-alert1 {
-					temperature = <95000>;
+				cpu_little2_alert0: trip-alert {
+					temperature = <85000>;
 					hysteresis = <2000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				cpu_little2_crit: trip-crit {
-					temperature = <100000>;
+					temperature = <115000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
@@ -586,22 +589,23 @@ cpu-little3-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <150>;
 			thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU3>;
+			sustainable-power = <1500>;
 
 			trips {
-				cpu_little3_alert0: trip-alert0 {
-					temperature = <85000>;
+				cpu_little3_pa_switch_on: trip-pa-switch_on {
+					temperature = <68000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_little3_alert1: trip-alert1 {
-					temperature = <95000>;
+				cpu_little3_alert0: trip-alert {
+					temperature = <85000>;
 					hysteresis = <2000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				cpu_little3_crit: trip-crit {
-					temperature = <100000>;
+					temperature = <115000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
@@ -624,22 +628,23 @@ cpu-big0-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <100>;
 			thermal-sensors = <&lvts_mcu MT8188_MCU_BIG_CPU0>;
+			sustainable-power = <1500>;
 
 			trips {
-				cpu_big0_alert0: trip-alert0 {
-					temperature = <85000>;
+				cpu_big0_pa_switch_on: trip-pa-switch_on {
+					temperature = <68000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_big0_alert1: trip-alert1 {
-					temperature = <95000>;
+				cpu_big0_alert0: trip-alert {
+					temperature = <85000>;
 					hysteresis = <2000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				cpu_big0_crit: trip-crit {
-					temperature = <100000>;
+					temperature = <115000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
@@ -658,22 +663,23 @@ cpu-big1-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <100>;
 			thermal-sensors = <&lvts_mcu MT8188_MCU_BIG_CPU1>;
+			sustainable-power = <1500>;
 
 			trips {
-				cpu_big1_alert0: trip-alert0 {
-					temperature = <85000>;
+				cpu_big1_pa_switch_on: trip-pa-switch_on {
+					temperature = <68000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu_big1_alert1: trip-alert1 {
-					temperature = <95000>;
+				cpu_big1_alert0: trip-alert {
+					temperature = <85000>;
 					hysteresis = <2000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				cpu_big1_crit: trip-crit {
-					temperature = <100000>;
+					temperature = <115000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 4f2dc0a755..06631760c2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -3729,16 +3729,23 @@ cpu0-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU0>;
+			sustainable-power = <1500>;
 
 			trips {
+				cpu0_pa_switch_on: trip_pa_switch_on {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+				};
+
 				cpu0_alert: trip-alert {
-					temperature = <85000>;
+					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
 				cpu0_crit: trip-crit {
-					temperature = <100000>;
+					temperature = <115000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
@@ -3759,16 +3766,23 @@ cpu1-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU1>;
+			sustainable-power = <1500>;
 
 			trips {
+				cpu1_pa_switch_on: trip_pa_switch_on {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+				};
+
 				cpu1_alert: trip-alert {
-					temperature = <85000>;
+					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
 				cpu1_crit: trip-crit {
-					temperature = <100000>;
+					temperature = <115000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
@@ -3789,16 +3803,23 @@ cpu2-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU2>;
+			sustainable-power = <1500>;
 
 			trips {
+				cpu2_pa_switch_on: trip_pa_switch_on {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+				};
+
 				cpu2_alert: trip-alert {
-					temperature = <85000>;
+					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
 				cpu2_crit: trip-crit {
-					temperature = <100000>;
+					temperature = <115000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
@@ -3819,16 +3840,23 @@ cpu3-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU3>;
+			sustainable-power = <1500>;
 
 			trips {
+				cpu3_pa_switch_on: trip_pa_switch_on {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+				};
+
 				cpu3_alert: trip-alert {
-					temperature = <85000>;
+					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
 				cpu3_crit: trip-crit {
-					temperature = <100000>;
+					temperature = <115000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
@@ -3849,16 +3877,23 @@ cpu4-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_mcu MT8195_MCU_BIG_CPU0>;
+			sustainable-power = <1500>;
 
 			trips {
+				cpu4_pa_switch_on: trip_pa_switch_on {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+				};
+
 				cpu4_alert: trip-alert {
-					temperature = <85000>;
+					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
 				cpu4_crit: trip-crit {
-					temperature = <100000>;
+					temperature = <115000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
@@ -3879,16 +3914,23 @@ cpu5-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_mcu MT8195_MCU_BIG_CPU1>;
+			sustainable-power = <1500>;
 
 			trips {
+				cpu5_pa_switch_on: trip_pa_switch_on {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+				};
+
 				cpu5_alert: trip-alert {
-					temperature = <85000>;
+					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
 				cpu5_crit: trip-crit {
-					temperature = <100000>;
+					temperature = <115000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
@@ -3909,16 +3951,23 @@ cpu6-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_mcu MT8195_MCU_BIG_CPU2>;
+			sustainable-power = <1500>;
 
 			trips {
+				cpu6_pa_switch_on: trip_pa_switch_on {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+				};
+
 				cpu6_alert: trip-alert {
-					temperature = <85000>;
+					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
 				cpu6_crit: trip-crit {
-					temperature = <100000>;
+					temperature = <115000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
@@ -3939,16 +3988,23 @@ cpu7-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <250>;
 			thermal-sensors = <&lvts_mcu MT8195_MCU_BIG_CPU3>;
+			sustainable-power = <1500>;
 
 			trips {
+				cpu7_pa_switch_on: trip_pa_switch_on {
+						temperature = <68000>;
+						hysteresis = <2000>;
+						type = "passive";
+				};
+
 				cpu7_alert: trip-alert {
-					temperature = <85000>;
+					temperature = <90000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
 				cpu7_crit: trip-crit {
-					temperature = <100000>;
+					temperature = <115000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};

