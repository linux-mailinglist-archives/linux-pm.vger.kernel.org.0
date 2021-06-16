Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32183AA3D8
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 21:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbhFPTHo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 15:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbhFPTHm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 15:07:42 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84B7C061574;
        Wed, 16 Jun 2021 12:05:34 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id r5so6048193lfr.5;
        Wed, 16 Jun 2021 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D90UFhsacTVshn6p9/Z2whQb2PME8KBmF7aqJRvgxxk=;
        b=HeSBQ3KSULU7O3+Zub7WEp92A4a5BKP+lpQjN6vCOKWALQzgkKYUSAcOpii68+nIXn
         4t2pkNVNAX7Cig9hd4XrtMkBzwqFu/CzzQbnb1/cyw6uAQeGPZ8st7G43h//2b85jR9a
         mp7sJcTuM08eFPnuWmVGrqY4nVTqXLDwKOJNY208NrNzPGTuKC8/QhDmYEr5wjKSLGru
         W883vIZAxQAN7adohrhW4J7HTBbHDNKN7Fmkr7+SfhQkqIzcIPkBUCejz3yTDC5gEsIK
         D713PPR6NWlfuKKqcV1mI1v3Asvl4NZYfgWWZ81WToxY/vXPMOzNkaQ+AyC7uL9BUDlN
         EtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D90UFhsacTVshn6p9/Z2whQb2PME8KBmF7aqJRvgxxk=;
        b=H3fC2JXVQRfJOCc70oYH4dtOgSQ9wpB0HH8Kntli2Fzu+Ik5iORZalHLIXno+Sw4Yb
         ToK2Iww7D1Xxkx0N5o1xQ8SOaOHlRaCGQeBjhUhhPXOJKPTwdsEeEe/msoQ1BDRVt5fg
         FtR2gwcRrk9aCBJ49bRHK/28m5Nbh1GJ9BZM+WLoOt51eQFIbVjy0jUAyzoEpMcP+8QI
         tBGBAD8QGkVzQxTkW3DLBf/XO2l90LhM4tJa8tQX0c8H9eWWJyaa2lkFORd9lLc4Hmpz
         WFFos1+DLJTYD03cafHIbA4U9GywQXaMea2Ky62BFZ/SBV8XHMrkerP6KjFdN3OMCXjb
         //Hg==
X-Gm-Message-State: AOAM533JqnUQNOtvhHOCuhxwT31DlL0L8vVlMkiqyfpZHSbD/u+ikJJ0
        1mOTOWGJmM8iUu90hwW/xPs=
X-Google-Smtp-Source: ABdhPJw/wpYLL9eX5hYjEcQr4sKSGPA5j7h8Mt/KKQsxKdT1nwDh5vA6cwnUutXp5qIHVyxuDlqrkA==
X-Received: by 2002:a05:6512:3588:: with SMTP id m8mr909981lfr.309.1623870333294;
        Wed, 16 Jun 2021 12:05:33 -0700 (PDT)
Received: from localhost.localdomain (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.gmail.com with ESMTPSA id e20sm365951ljk.67.2021.06.16.12.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 12:05:33 -0700 (PDT)
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
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v4 6/6] ARM: tegra: Add SoC thermal sensor to Tegra30 device-trees
Date:   Wed, 16 Jun 2021 22:04:17 +0300
Message-Id: <20210616190417.32214-7-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616190417.32214-1-digetx@gmail.com>
References: <20210616190417.32214-1-digetx@gmail.com>
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
 arch/arm/boot/dts/tegra30.dtsi | 87 ++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index c577c191be4b..404b6ecc9c20 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -5,6 +5,7 @@
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/tegra-pmc.h>
+#include <dt-bindings/thermal/thermal.h>
 
 #include "tegra30-peripherals-opp.dtsi"
 
@@ -800,6 +801,20 @@ fuse@7000f800 {
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
+	};
+
 	hda@70030000 {
 		compatible = "nvidia,tegra30-hda";
 		reg = <0x70030000 0x10000>;
@@ -1062,32 +1077,36 @@ cpus {
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
 
@@ -1102,4 +1121,64 @@ pmu {
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
+					/* throttle at 80C until temperature drops to 79.8C */
+					temperature = <80000>;
+					hysteresis = <200>;
+					type = "passive";
+				};
+
+				level2_trip: cpu-div2-throttle {
+					/* hardware CPU x2 freq throttle at 85C */
+					temperature = <85000>;
+					hysteresis = <200>;
+					type = "hot";
+				};
+
+				level3_trip: soc-critical {
+					/* hardware shut down at 90C */
+					temperature = <90000>;
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

