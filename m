Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BB67C757D
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 19:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442138AbjJLR7H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 13:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442133AbjJLR67 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 13:58:59 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D4FD8;
        Thu, 12 Oct 2023 10:58:56 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso220307866b.2;
        Thu, 12 Oct 2023 10:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133535; x=1697738335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQuQUPOK41L8ruCThuwtkRFjbwLr0TuEAepWZfSMkPo=;
        b=PHNcE7C/o4LtzspoLqrhHdyJWGqg5TUwu6fBdwJv6lNCGbCelL2Wt18dU4YasY85fM
         FOd2j5Uukt2U93izLl34JnbZ6aisXv03rHejYcHieXLUcF22XU3TPpBt6VY6oSVnUz1u
         mPNI8qXjwsFVDdWj4FQPaIOgWJsFWyPcNizalkOtHj0FafrsnDj6MXgYdTLK6Vi0XgYU
         xLHLE/k1ykCFA3iya6ujnK7aNX3JKsdoLG733CmI/cV2KVu/PqkqoWjZSKfPTgbEE8ti
         /Md8KUzw+Ys6gZXefgVVyqwRTdD4PnMwnKoejtzq9y6wqaXX3wWTawJkVY3pn7F2GnOK
         zXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133535; x=1697738335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQuQUPOK41L8ruCThuwtkRFjbwLr0TuEAepWZfSMkPo=;
        b=wAVaiKCy/+MqsUiBEdayHKSdEvFCTHWuEkm9Z70QYbbkJ4tw1O269wF3PszEUj2YQQ
         dy3dRXGdGg27g8MrDf5ox8gkhDN1xa3R2o+QPlx6BVh7yxVUSUqa8Vw0TPGtFKGOvFCr
         giGmGMgWLJplQjNquJMBF1HT7qt7PEZSnEMfRrKGIsWFO3aQKUfhV/sVCKxp6Q2o1PmI
         VN5eFnQLfLwYZyUCxAk1YizEmpC1cMgbndsbrwayOLXKE029sCSux7WKbQv6dOFbK9vr
         1AzwTiCEeAFGrDhzTY1XFh77WtgdHA7dmrN3H30FxcsD4/EPJ2QWrBWnhXd/1YnPCmgK
         xtnw==
X-Gm-Message-State: AOJu0YyXLenoTC8JvxiiVd7eZSYEblOKCs0KXbNoaRWmr0nPg5AHp9ac
        5Vjyrx7o13cXfub46xAD97J90d75kC8=
X-Google-Smtp-Source: AGHT+IEA8/jn9S/lT9WfviI/mRMO3oKFAi8T0/gg6HfHQNpik2syq5btlK0iOgrRA+7BOaMq3R53aA==
X-Received: by 2002:a17:906:768e:b0:9b2:f38d:c44b with SMTP id o14-20020a170906768e00b009b2f38dc44bmr21178653ejm.24.1697133534697;
        Thu, 12 Oct 2023 10:58:54 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id br13-20020a170906d14d00b0099cb349d570sm11337214ejb.185.2023.10.12.10.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:58:54 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 11/13] arm64: tegra: Rework SOCTHERM on Tegra132 and Tegra210
Date:   Thu, 12 Oct 2023 19:58:32 +0200
Message-ID: <20231012175836.3408077-12-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012175836.3408077-1-thierry.reding@gmail.com>
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The "heavy throttle" cooling device that SOCTHERM uses isn't a cooling
device in the traditional sense. It's an automatic mechanism that cannot
be actively controlled. Do not expose it as a cooling device and instead
of tying it to a specific trip point, hard-code the temperature at which
the automatic throttling will begin.

While at it, clean up the trip point names to reflect the names used by
the thermal device tree bindings.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra132.dtsi | 66 ++++++------------
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 86 +++++++-----------------
 2 files changed, 45 insertions(+), 107 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index 7e24a212c7e4..105e01be341b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -878,11 +878,13 @@ soctherm: thermal-sensor@700e2000 {
 		#thermal-sensor-cells = <1>;
 
 		throttle-cfgs {
-			throttle_heavy: heavy {
+			heavy {
 				nvidia,priority = <100>;
 				nvidia,cpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_HIGH>;
-
-				#cooling-cells = <2>;
+				nvidia,thermal-zones = <&{/thermal-zones/cpu-thermal}>,
+						       <&{/thermal-zones/gpu-thermal}>;
+				temperature-millicelsius = <102000>;
+				hysteresis-millicelsius = <4000>;
 			};
 		};
 	};
@@ -1138,114 +1140,84 @@ cpu-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <0>;
 
-			thermal-sensors =
-				<&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
+			thermal-sensors = <&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
 
 			trips {
-				cpu_shutdown_trip {
+				critical {
 					temperature = <105000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 
-				cpu_throttle_trip: throttle-trip {
+				hot {
 					temperature = <102000>;
 					hysteresis = <1000>;
 					type = "hot";
 				};
 			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu_throttle_trip>;
-					cooling-device = <&throttle_heavy 1 1>;
-				};
-			};
 		};
 
 		mem-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 
-			thermal-sensors =
-				<&soctherm TEGRA124_SOCTHERM_SENSOR_MEM>;
+			thermal-sensors = <&soctherm TEGRA124_SOCTHERM_SENSOR_MEM>;
 
 			trips {
-				mem_shutdown_trip {
+				critical {
 					temperature = <101000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
-				mem_throttle_trip {
+
+				hot {
 					temperature = <99000>;
 					hysteresis = <1000>;
 					type = "hot";
 				};
 			};
-
-			cooling-maps {
-				/*
-				 * There are currently no cooling maps,
-				 * because there are no cooling devices.
-				 */
-			};
 		};
 
 		gpu-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <0>;
 
-			thermal-sensors =
-				<&soctherm TEGRA124_SOCTHERM_SENSOR_GPU>;
+			thermal-sensors = <&soctherm TEGRA124_SOCTHERM_SENSOR_GPU>;
 
 			trips {
-				gpu_shutdown_trip {
+				critical {
 					temperature = <101000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 
-				gpu_throttle_trip: throttle-trip {
+				hot {
 					temperature = <99000>;
 					hysteresis = <1000>;
 					type = "hot";
 				};
 			};
-
-			cooling-maps {
-				map0 {
-					trip = <&gpu_throttle_trip>;
-					cooling-device = <&throttle_heavy 1 1>;
-				};
-			};
 		};
 
 		pllx-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 
-			thermal-sensors =
-				<&soctherm TEGRA124_SOCTHERM_SENSOR_PLLX>;
+			thermal-sensors = <&soctherm TEGRA124_SOCTHERM_SENSOR_PLLX>;
 
 			trips {
-				pllx_shutdown_trip {
+				critical {
 					temperature = <105000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
-				pllx_throttle_trip {
+
+				hot {
 					temperature = <99000>;
 					hysteresis = <1000>;
 					type = "hot";
 				};
 			};
-
-			cooling-maps {
-				/*
-				 * There are currently no cooling maps,
-				 * because there are no cooling devices.
-				 */
-			};
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 47f8268e46bf..b340579594e4 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1329,12 +1329,14 @@ soctherm: thermal-sensor@700e2000 {
 		#thermal-sensor-cells = <1>;
 
 		throttle-cfgs {
-			throttle_heavy: heavy {
+			heavy {
 				nvidia,priority = <100>;
 				nvidia,cpu-throt-percent = <85>;
 				nvidia,gpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_HIGH>;
-
-				#cooling-cells = <2>;
+				nvidia,thermal-zones = <&{/thermal-zones/cpu-thermal}>,
+						       <&{/thermal-zones/gpu-thermal}>;
+				temperature-millicelsius = <98500>;
+				hysteresis-millicelsius = <4000>;
 			};
 		};
 	};
@@ -2032,73 +2034,53 @@ cpu-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <0>;
 
-			thermal-sensors =
-				<&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
+			thermal-sensors = <&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
 
 			trips {
-				cpu-shutdown-trip {
+				critical {
 					temperature = <102500>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 
-				cpu_throttle_trip: throttle-trip {
+				hot {
 					temperature = <98500>;
 					hysteresis = <1000>;
 					type = "hot";
 				};
 			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu_throttle_trip>;
-					cooling-device = <&throttle_heavy 1 1>;
-				};
-			};
 		};
 
 		mem-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 
-			thermal-sensors =
-				<&soctherm TEGRA124_SOCTHERM_SENSOR_MEM>;
+			thermal-sensors = <&soctherm TEGRA124_SOCTHERM_SENSOR_MEM>;
 
 			trips {
-				dram_nominal: mem-nominal-trip {
-					temperature = <50000>;
-					hysteresis = <1000>;
-					type = "passive";
-				};
-
-				dram_throttle: mem-throttle-trip {
-					temperature = <70000>;
-					hysteresis = <1000>;
-					type = "active";
+				critical {
+					temperature = <103000>;
+					hysteresis = <0>;
+					type = "critical";
 				};
 
-				mem-hot-trip {
+				hot {
 					temperature = <100000>;
 					hysteresis = <1000>;
 					type = "hot";
 				};
 
-				mem-shutdown-trip {
-					temperature = <103000>;
-					hysteresis = <0>;
-					type = "critical";
+				emc_throttle_trip: passive {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
 				};
 			};
 
 			cooling-maps {
-				dram-passive {
-					cooling-device = <&emc 0 0>;
-					trip = <&dram_nominal>;
-				};
-
-				dram-active {
+				map-passive {
 					cooling-device = <&emc 1 1>;
-					trip = <&dram_throttle>;
+					trip = <&emc_throttle_trip>;
 				};
 			};
 		};
@@ -2107,58 +2089,42 @@ gpu-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <0>;
 
-			thermal-sensors =
-				<&soctherm TEGRA124_SOCTHERM_SENSOR_GPU>;
+			thermal-sensors = <&soctherm TEGRA124_SOCTHERM_SENSOR_GPU>;
 
 			trips {
-				gpu-shutdown-trip {
+				critical {
 					temperature = <103000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 
-				gpu_throttle_trip: throttle-trip {
+				hot {
 					temperature = <100000>;
 					hysteresis = <1000>;
 					type = "hot";
 				};
 			};
-
-			cooling-maps {
-				map0 {
-					trip = <&gpu_throttle_trip>;
-					cooling-device = <&throttle_heavy 1 1>;
-				};
-			};
 		};
 
 		pllx-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 
-			thermal-sensors =
-				<&soctherm TEGRA124_SOCTHERM_SENSOR_PLLX>;
+			thermal-sensors = <&soctherm TEGRA124_SOCTHERM_SENSOR_PLLX>;
 
 			trips {
-				pllx-shutdown-trip {
+				critical {
 					temperature = <103000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 
-				pllx-throttle-trip {
+				hot {
 					temperature = <100000>;
 					hysteresis = <1000>;
 					type = "hot";
 				};
 			};
-
-			cooling-maps {
-				/*
-				 * There are currently no cooling maps,
-				 * because there are no cooling devices.
-				 */
-			};
 		};
 	};
 
-- 
2.42.0

