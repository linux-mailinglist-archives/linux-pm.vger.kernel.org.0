Return-Path: <linux-pm+bounces-9089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323E79073A4
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 15:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C9D2898D5
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 13:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC66D14659D;
	Thu, 13 Jun 2024 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lVYHjfpX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEB9145FFD
	for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2024 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285064; cv=none; b=P9oA+i8aeSObNaw7JQdYQ5G9ev9wkK2J/OlmIHU9o2FZMetwm0OloL5GLj49wa6rR3CYQZI7AQY3DnpaFKZRMqmS/+wNt0k10vWiwHVaVfxeIwHUUsI4+t+9FVRq7/vJJwCxBucI+uUEb/F7CctTpeg5yWPXoDJQLAFRytDY0aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285064; c=relaxed/simple;
	bh=ei6MygeSgJsE+wcqS+H6XtwKC909xyCYznIa430bejg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZ+LYcO6NiXW2/aqKZbU9CUIeC4yV/M0yN+d52Vl45uIC3qQsBbgBcOsoP/bbaUCMyMnwQak7ud7A+JbdOF020k53r9O0eWga3Ezq8MH1W1TTokcj+ErcncJV987MAo6uszUw9xUqQ8GkUNRaDQzzEVGPMvPwXXZbDcXe4DvF6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lVYHjfpX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4218314a6c7so9888955e9.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Jun 2024 06:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718285061; x=1718889861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIdfAng31JZ7AXh+5wJJBwNTBQjKsoPR8mg2mxmZaFA=;
        b=lVYHjfpXkOBC6G1ZkUaQ+V7WtKaalI0UX/StJ63ftEgS53JTpaDbxmYKC4QhwUaXo4
         4JpN2r8r5xJugiOvqOjhJi7aEI3D8Asc5w0GVZ2fbMHj2qyoySpCkubNUr1A1JrKdBir
         lvyi9fR/C6snMQTOZplZyZGGmJpr8uDpKzHLvoKRbasEhFw6jFrI8M9scovaRQn+3fOu
         EbSQk2vqlrKn+FTPzNHlkYIQ/GgvUF/LjjDKGojpfPUXU6zvjA7NQTr7GEiZcr/wJbAt
         tGl+DpllKo39/DFAlJNIkgeMZg9ZQb4a/b1KtmcNCNzRw4BmmFk5DsaY0MnMNEEI/ZAj
         OMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718285061; x=1718889861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIdfAng31JZ7AXh+5wJJBwNTBQjKsoPR8mg2mxmZaFA=;
        b=XNJObQQV47/dbSn4s1t3oSy4hW0BluJGA09YRCpuvD19OoSInf/LrCTiEQWuWqYTlb
         mU8IErZFlXSr1ZbEgHQjVSSO9BYpYWfbxXUTMQuQupgcE4rbimb/Nz00IKdYO2WCO49s
         fl2Te4jBXXD67najypBNw91drVkDLyLAeJnjY+eS7whU/+/ZFaNc/Ybq30re5chsjnyy
         EkRYyR8muynW10aNxLqJtL6KKqN/3Ag9+pMqN6oyMP+5HzJZLjMp2t3UWcn3YKK8TN8r
         q0M1+AkUt2jT6NGs7Sv3aOApXOH+829+pbgCfgtG/D+X2FCZcZVUaqvQT+BuGLs6+Udr
         v2Gw==
X-Forwarded-Encrypted: i=1; AJvYcCV/5wchhzOkDhWkxjlKFxDhnWW8YFypE6GxkWOQ5kd/C94JeGNuyw4lg3jLG6OdnIyM2/2UiM3uO9zmmt2NYH+FFIwvezpkeXY=
X-Gm-Message-State: AOJu0Yz00SMiUClY1i6ru5J/u3LzsbzNzpvb4PmexgNuWE+EtTlBiv7X
	JoDs6iKrqUFi1fs+kHOLBrPax36hS9VcWJEfYYEwzS9LEAMojgJL4DQPFUzd3Wg=
X-Google-Smtp-Source: AGHT+IEaGyMoVlH5DAEAQTeEGpbxwW1clV0twr/chrl0KmoLh9fV5Vaxzf96/t1WHAqzFEyPkITxdw==
X-Received: by 2002:a05:600c:190d:b0:421:82ed:28d1 with SMTP id 5b1f17b1804b1-422867c02f1mr39073585e9.41.1718285061285;
        Thu, 13 Jun 2024 06:24:21 -0700 (PDT)
Received: from blaptop.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f5f33c6esm25086225e9.4.2024.06.13.06.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 06:24:20 -0700 (PDT)
From: Alexandre Bailon <abailon@baylibre.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v4 4/4] ARM64: mt8195: Use thermal aggregation for big and little cpu
Date: Thu, 13 Jun 2024 15:24:10 +0200
Message-ID: <20240613132410.161663-5-abailon@baylibre.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240613132410.161663-1-abailon@baylibre.com>
References: <20240613132410.161663-1-abailon@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This uses the thermal aggregation for the mt8195 to get the maximal
temperature of big and little cpu clusters.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 210 +++--------------------
 1 file changed, 25 insertions(+), 185 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 5d8b68f86ce4..90778c609ceb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -3600,50 +3600,30 @@ dp_tx: dp-tx@1c600000 {
 	};
 
 	thermal_zones: thermal-zones {
-		cpu0-thermal {
+		cpu-little {
 			polling-delay = <1000>;
-			polling-delay-passive = <250>;
-			thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU0>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU0>,
+					  <&lvts_mcu MT8195_MCU_LITTLE_CPU1>,
+					  <&lvts_mcu MT8195_MCU_LITTLE_CPU2>,
+					  <&lvts_mcu MT8195_MCU_LITTLE_CPU3>;
+			sustainable-power = <1500>;
 
 			trips {
-				cpu0_alert: trip-alert {
-					temperature = <85000>;
+				cpu_little_threshold: trip-point {
+					temperature = <68000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu0_crit: trip-crit {
-					temperature = <100000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu0_alert>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-
-		cpu1-thermal {
-			polling-delay = <1000>;
-			polling-delay-passive = <250>;
-			thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU1>;
-
-			trips {
-				cpu1_alert: trip-alert {
+				cpu_little_target: target {
 					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu1_crit: trip-crit {
-					temperature = <100000>;
+				cpu_little_soc_max_crit: soc-max-crit {
+					temperature = <115000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
@@ -3651,7 +3631,7 @@ cpu1_crit: trip-crit {
 
 			cooling-maps {
 				map0 {
-					trip = <&cpu1_alert>;
+					trip = <&cpu_little_target>;
 					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 								<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 								<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
@@ -3660,170 +3640,30 @@ map0 {
 			};
 		};
 
-		cpu2-thermal {
+		cpu-big {
 			polling-delay = <1000>;
 			polling-delay-passive = <250>;
-			thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU2>;
+			thermal-sensors = <&lvts_mcu MT8195_MCU_BIG_CPU0>,
+					  <&lvts_mcu MT8195_MCU_BIG_CPU1>,
+					  <&lvts_mcu MT8195_MCU_BIG_CPU2>,
+					  <&lvts_mcu MT8195_MCU_BIG_CPU3>;
+			sustainable-power = <1500>;
 
 			trips {
-				cpu2_alert: trip-alert {
-					temperature = <85000>;
+				cpu_big_threshold: trip-point {
+					temperature = <68000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu2_crit: trip-crit {
-					temperature = <100000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu2_alert>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-
-		cpu3-thermal {
-			polling-delay = <1000>;
-			polling-delay-passive = <250>;
-			thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU3>;
-
-			trips {
-				cpu3_alert: trip-alert {
-					temperature = <85000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				cpu3_crit: trip-crit {
-					temperature = <100000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu3_alert>;
-					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-
-		cpu4-thermal {
-			polling-delay = <1000>;
-			polling-delay-passive = <250>;
-			thermal-sensors = <&lvts_mcu MT8195_MCU_BIG_CPU0>;
-
-			trips {
-				cpu4_alert: trip-alert {
+				cpu_big_target: target {
 					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
-				cpu4_crit: trip-crit {
-					temperature = <100000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu4_alert>;
-					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-
-		cpu5-thermal {
-			polling-delay = <1000>;
-			polling-delay-passive = <250>;
-			thermal-sensors = <&lvts_mcu MT8195_MCU_BIG_CPU1>;
-
-			trips {
-				cpu5_alert: trip-alert {
-					temperature = <85000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				cpu5_crit: trip-crit {
-					temperature = <100000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu5_alert>;
-					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-
-		cpu6-thermal {
-			polling-delay = <1000>;
-			polling-delay-passive = <250>;
-			thermal-sensors = <&lvts_mcu MT8195_MCU_BIG_CPU2>;
-
-			trips {
-				cpu6_alert: trip-alert {
-					temperature = <85000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				cpu6_crit: trip-crit {
-					temperature = <100000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu6_alert>;
-					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-								<&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-				};
-			};
-		};
-
-		cpu7-thermal {
-			polling-delay = <1000>;
-			polling-delay-passive = <250>;
-			thermal-sensors = <&lvts_mcu MT8195_MCU_BIG_CPU3>;
-
-			trips {
-				cpu7_alert: trip-alert {
-					temperature = <85000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-
-				cpu7_crit: trip-crit {
-					temperature = <100000>;
+				cpu_big_soc_max_crit: soc-max-crit {
+					temperature = <115000>;
 					hysteresis = <2000>;
 					type = "critical";
 				};
@@ -3831,7 +3671,7 @@ cpu7_crit: trip-crit {
 
 			cooling-maps {
 				map0 {
-					trip = <&cpu7_alert>;
+					trip = <&cpu_big_target>;
 					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 								<&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 								<&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-- 
2.44.1


