Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C896F6E23E4
	for <lists+linux-pm@lfdr.de>; Fri, 14 Apr 2023 14:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjDNM6E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Apr 2023 08:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjDNM6D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2023 08:58:03 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11547B440;
        Fri, 14 Apr 2023 05:57:37 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id eo6-20020a05600c82c600b003ee5157346cso11863124wmb.1;
        Fri, 14 Apr 2023 05:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681477055; x=1684069055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9jnq8O0akNCWZMABiiTnkNejKYtKjmdQ2nEC4Lqzp0=;
        b=cA8fDJ+JgnHhvSPxA06aLZSDb0khbYbV2M+mrSDtzvxjZY+5F2un5hx+d1r1q5ehlo
         SnqifMdCJ8xHyJMiISIPIl5EwjzO0M9lWrQ31H1XMmoohjavupmRFaN5oBnSUcMGVFkH
         I1aEtW41IzkThWHHCwLCFrlmPoFqN4amueFMULBGd37eVpcJJ2gUgP1EmEOmNSNhmCDC
         Pn4NyU+YIUfMOSYR5vN1Pb2dG2XkTFqYtanXsATbmuWpUNaBe9xg60KZGRBQkJhot8f9
         8b7ssQZDRopfldzitwj4t4sgJtNWH4yWBP/CtyJVT2vvp0WmsnwS+lmxuU2+Ur+pKnGw
         oRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681477055; x=1684069055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9jnq8O0akNCWZMABiiTnkNejKYtKjmdQ2nEC4Lqzp0=;
        b=WLeBlr7Bf5K8vNY9QRDbK4HD9+VxMbb6+dRl/rXALE9HX0BfYpUpYBragdj1xCvPxS
         CyftvVSJG/37Z3Qz1mcESIOASOrzgen54U/Heu1ecBzDFllSYS6k472KxAmuwOy03f5q
         bI1DAInqAv/JbYauL92oc16kznxEDjUovZbpaAGV//NeoOXQEblYIRn9+8zAIPltLJ9G
         vh3U2cIlgsovvDrNzzDSBCYZDD07z70WiY3G3iEiJIphHvbB47dCUIrPnade7x7zzr6W
         2Z2N/rlFQWW1crOMfF0ChufGwgLq6jWCh/TSf22dxy6Qsi+nTWABBqBAy+gegKoKXGvU
         YZzQ==
X-Gm-Message-State: AAQBX9eFYDt1fEv/KLpRmHSv+/9BY+0oFv3tJAFK7RFzwh1J+AzZDW4T
        GtrRPKQm+MUOX1mRYVojUok=
X-Google-Smtp-Source: AKy350a9Rr1bUDeCJa6T9WaGvNXmh3sJHwl53o03Rjd5QeZNjD26b0HeTFHgqn0XQhSbUNS1f0ctBA==
X-Received: by 2002:a7b:ce10:0:b0:3ed:2606:d236 with SMTP id m16-20020a7bce10000000b003ed2606d236mr4504790wmc.38.1681477055469;
        Fri, 14 Apr 2023 05:57:35 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id k7-20020a05600c1c8700b003ee1acdaf95sm8033494wms.36.2023.04.14.05.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:57:35 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 09/10] arm64: tegra: Rework SOCTHERM on Tegra132 and Tegra210
Date:   Fri, 14 Apr 2023 14:57:20 +0200
Message-Id: <20230414125721.1043589-10-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230414125721.1043589-1-thierry.reding@gmail.com>
References: <20230414125721.1043589-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm64/boot/dts/nvidia/tegra132.dtsi | 63 +++++-------------
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 83 +++++++-----------------
 2 files changed, 39 insertions(+), 107 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index 8b78be8f4f9d..11ebf7517df1 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -876,11 +876,10 @@ soctherm: thermal-sensor@700e2000 {
 		#thermal-sensor-cells = <1>;
 
 		throttle-cfgs {
-			throttle_heavy: heavy {
+			heavy {
 				nvidia,priority = <100>;
 				nvidia,cpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_HIGH>;
-
-				#cooling-cells = <2>;
+				temperature = <102000>;
 			};
 		};
 	};
@@ -1136,114 +1135,84 @@ cpu-thermal {
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
index 0e463b3cbe01..af5460c74184 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -1331,12 +1331,11 @@ soctherm: thermal-sensor@700e2000 {
 		#thermal-sensor-cells = <1>;
 
 		throttle-cfgs {
-			throttle_heavy: heavy {
+			heavy {
 				nvidia,priority = <100>;
 				nvidia,cpu-throt-percent = <85>;
 				nvidia,gpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_HIGH>;
-
-				#cooling-cells = <2>;
+				temperature = <98500>;
 			};
 		};
 	};
@@ -2032,73 +2031,53 @@ cpu-thermal {
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
+				passive {
 					cooling-device = <&emc 1 1>;
-					trip = <&dram_throttle>;
+					trip = <&emc_throttle_trip>;
 				};
 			};
 		};
@@ -2107,58 +2086,42 @@ gpu-thermal {
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
2.40.0

