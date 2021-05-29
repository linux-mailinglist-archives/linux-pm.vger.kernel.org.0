Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBA9394D77
	for <lists+linux-pm@lfdr.de>; Sat, 29 May 2021 19:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhE2RMZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 May 2021 13:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhE2RMX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 May 2021 13:12:23 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6987EC0613ED;
        Sat, 29 May 2021 10:10:46 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id e2so9257120ljk.4;
        Sat, 29 May 2021 10:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SZjslNJj0RrvMEBltMfpTerrLG/TtMo8+YaLhqfm6kQ=;
        b=TDW8ZzXYDp2oc6DphvUGC+WHNYNIMexOtligeBq3SVRlKqHVDXAU08brKpUsnjayP1
         WZ2iW0bZqX567d6cDo96Sx/yAEe6kTsvl2AIWbyo8uUHUegAk9pJbYvFrBjYrUxgLCoo
         /2NTQtZu4gU9kQJPMtBqmsIcDCki0lQSor+a9BqDxLB1ftMp4x/Q2t/Th2BTIIOzsZ72
         wpu6VdfwiuJjrldsWyXTnvXHVk4pvgURytckbegPRkzME/FCSHXP+SeFj1JpQFPWP8r7
         RdVwdAFA01GYoRA/CluHzJSS1FQRDmlopxQgz37IsI/BEb8eQ6xolHmmesiUYHp1mUxh
         rYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SZjslNJj0RrvMEBltMfpTerrLG/TtMo8+YaLhqfm6kQ=;
        b=QfbUDqPmB3eywMQ8YxiHmfDeceug3vn6vjGm9OOUGYwDrVNfDAEDLooKSCg8IH05b5
         YGCn5k8atR5WOIwOdK3zQANB+mrLGBdutklJx0jrSYbCEtUPj34aH7WGTSLqUT65mFTK
         IuwuQAT1Mr9tyUO4D9MqctEgIK8u/iHhmbqdeAJKvtbJKqroWERlunKLGagHAEh2/OiD
         GM405k44Db4ln1B1s36EYfuLFxwBhU9s9GBvqN9jfHQ2q9utmvzUotlNpnKk32ROlCji
         vCPVTWH0IOUyTEEJGj+SFDtfDwOsT9kBfrvDwu1jZHBGlNCRKt+pmCSnvazxKjqcT5MO
         XWyA==
X-Gm-Message-State: AOAM530sahC7aL8kWvSaQAOeyfLjOl/4aW7oGjsZcGGw/6B+J5YYn/cl
        l0/pHIHwP3h/Jjwqs7xNt8I=
X-Google-Smtp-Source: ABdhPJxfszUulR2F0ddmj6BL948l0w7cS2dxVOk69YLRIId7Ube1bp7zOyHXXYO8qkXKORXezYDvGg==
X-Received: by 2002:a2e:8717:: with SMTP id m23mr11079864lji.161.1622308244846;
        Sat, 29 May 2021 10:10:44 -0700 (PDT)
Received: from localhost.localdomain (46-138-84-89.dynamic.spd-mgts.ru. [46.138.84.89])
        by smtp.gmail.com with ESMTPSA id h12sm901715ljh.130.2021.05.29.10.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 10:10:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Ion Agorria <ion@agorria.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 7/7] ARM: tegra: Add SoC thermal sensor to Tegra30 device-trees
Date:   Sat, 29 May 2021 20:09:55 +0300
Message-Id: <20210529170955.32574-8-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210529170955.32574-1-digetx@gmail.com>
References: <20210529170955.32574-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the on-chip SoC thermal sensor to Tegra30 device-trees. Now CPU
temperature reporting and thermal throttling is available on all Tegra30
devices universally.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30-ouya.dts | 16 +++++
 arch/arm/boot/dts/tegra30.dtsi     | 93 ++++++++++++++++++++++++++++--
 2 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-ouya.dts b/arch/arm/boot/dts/tegra30-ouya.dts
index e767ac227a81..d792ce5c64c0 100644
--- a/arch/arm/boot/dts/tegra30-ouya.dts
+++ b/arch/arm/boot/dts/tegra30-ouya.dts
@@ -468,6 +468,22 @@ map1 {
 				};
 			};
 		};
+
+		tsensor-channel0 {
+			trips {
+				dvfs-alert {
+					temperature = <70000>;
+				};
+
+				cpu-div2-throttle {
+					temperature = <75000>;
+				};
+
+				soc-critical {
+					temperature = <90000>;
+				};
+			};
+		};
 	};
 
 	vdd_12v_in: vdd_12v_in {
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index c577c191be4b..6becbadef210 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -5,6 +5,7 @@
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/tegra-pmc.h>
+#include <dt-bindings/thermal/thermal.h>
 
 #include "tegra30-peripherals-opp.dtsi"
 
@@ -800,6 +801,21 @@ fuse@7000f800 {
 		reset-names = "fuse";
 	};
 
+	tsensor: tsensor@70014000 {
+		compatible = "nvidia,tegra30-tsensor";
+		reg = <0x70014000 0x500>;
+		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA30_CLK_TSENSOR>;
+		resets = <&tegra_car TEGRA30_CLK_TSENSOR>;
+
+		assigned-clocks = <&tegra_car TEGRA30_CLK_TSENSOR>;
+		assigned-clock-parents = <&tegra_car TEGRA30_CLK_CLK_M>;
+		assigned-clock-rates = <500000>;
+
+		#thermal-sensor-cells = <1>;
+		#cooling-cells = <2>;
+	};
+
 	hda@70030000 {
 		compatible = "nvidia,tegra30-hda";
 		reg = <0x70030000 0x10000>;
@@ -1062,32 +1078,36 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0>;
 			clocks = <&tegra_car TEGRA30_CLK_CCLK_G>;
+			#cooling-cells = <2>;
 		};
 
-		cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <1>;
 			clocks = <&tegra_car TEGRA30_CLK_CCLK_G>;
+			#cooling-cells = <2>;
 		};
 
-		cpu@2 {
+		cpu2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <2>;
 			clocks = <&tegra_car TEGRA30_CLK_CCLK_G>;
+			#cooling-cells = <2>;
 		};
 
-		cpu@3 {
+		cpu3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <3>;
 			clocks = <&tegra_car TEGRA30_CLK_CCLK_G>;
+			#cooling-cells = <2>;
 		};
 	};
 
@@ -1102,4 +1122,69 @@ pmu {
 				     <&{/cpus/cpu@2}>,
 				     <&{/cpus/cpu@3}>;
 	};
+
+	thermal-zones {
+		tsensor-channel0 {
+			polling-delay-passive = <1000>; /* milliseconds */
+			polling-delay = <5000>; /* milliseconds */
+
+			thermal-sensors = <&tsensor 0>;
+
+			trips {
+				level1_trip: dvfs-alert {
+					/* throttle at 67C until temperature drops to 66.8C */
+					temperature = <67000>;
+					hysteresis = <200>;
+					type = "passive";
+				};
+
+				level2_trip: cpu-div2-throttle {
+					/* hardware CPU x2 freq throttle at 70C */
+					temperature = <70000>;
+					hysteresis = <200>;
+					type = "hot";
+				};
+
+				soc-critical {
+					/* hardware shut down at 80C */
+					temperature = <80000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&level1_trip>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&actmon THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&level2_trip>;
+					cooling-device = <&tsensor THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		tsensor-channel1 {
+			status = "disabled";
+
+			polling-delay-passive = <1000>; /* milliseconds */
+			polling-delay = <0>; /* milliseconds */
+
+			thermal-sensors = <&tsensor 1>;
+
+			trips {
+				dvfs-alert {
+					temperature = <80000>;
+					hysteresis = <200>;
+					type = "passive";
+				};
+			};
+		};
+	};
 };
-- 
2.30.2

