Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E247C757F
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 19:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379700AbjJLR7I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 13:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441880AbjJLR7A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 13:59:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E70CC;
        Thu, 12 Oct 2023 10:58:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-991c786369cso202855866b.1;
        Thu, 12 Oct 2023 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133537; x=1697738337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVzyZzlDuYEkptZGqcx0Bq/Ar7BF6s953A2pcoZKKXY=;
        b=drIifiMafZrsIjGp9RpVApJsCrB3vHJBQ5uddLOlHljjxWshz7CAkm43egG0CfQanO
         fn1H4MUKRSBrtgnnQ9x6TmoJPmDUdX5zZhFGfzqWKaqBrS9fO3pyEPqM9sj6FW8WWQXL
         ItTGL7EEHhxjl94HDiqR+v4HZejc1OqyEbNzBpvGiM0SyFac9XQL07Zq1cqAuupYXBEW
         UeZ23wRao3X/RWGnRdl7mK2G4d6OcPJxKGQ0kwLXnI44fxXa7fP2qPDutZvW3PPABPgI
         UazY8RwJKknJuG//KRV0F4NOPkSlcQ7SoFL/griCBEgb81/bpVu0PaXGmurQ0ZPrTNnU
         Z3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133537; x=1697738337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVzyZzlDuYEkptZGqcx0Bq/Ar7BF6s953A2pcoZKKXY=;
        b=SqDQDn5pJ2WeffKuTEUhJsD6g+thrFEgUzIHeUBWfU37od30zc4GEVB1dHCKuIl7Ph
         12ZkqFhoG/F4T//kgxl9SO5c6l7q1MHdroCrs4p3+tuTlsRkkfMjIlRTMqARhSkvESZR
         TEiEcnVxDNWobOyMxPyaS2WgqJjMpFDyt4HRIcRQ65S2nTTiYu7xzH5s2pQeDqrC2UQq
         vUH2onVs9Bhn9V7ul/8MZA6MkJ8KfxYJHR4I42oGUJLd6cG7fJ+bsd2zYvb3gipzFBPD
         Gw9PDB6C4aF3xSI5SsRLpeo9n70fgUNuibQbqoMkOAItVoWWpbRRtP7YswWrOTa4PWGz
         9WYQ==
X-Gm-Message-State: AOJu0YzqU6DJ4+Ksu3L4buYgJvNdt6VnqZmLHE8ri+6vqsBpPuzB3w7L
        XKK4p4RoLABRYst5gXVdTHE=
X-Google-Smtp-Source: AGHT+IFKIRpKXkW+YYeeHvhLeru5zUzaWheSxL0agNr9ZQE/GqPSCzcyPPFip0DXVi6mCInocN1m/Q==
X-Received: by 2002:a17:906:7389:b0:9ae:406c:3420 with SMTP id f9-20020a170906738900b009ae406c3420mr20562098ejl.30.1697133536647;
        Thu, 12 Oct 2023 10:58:56 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id sd23-20020a170906ce3700b009b2b9af0784sm11250813ejb.110.2023.10.12.10.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:58:56 -0700 (PDT)
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
Subject: [PATCH v2 12/13] arm64: tegra: Rework SOCTHERM on Tegra132 and Tegra210
Date:   Thu, 12 Oct 2023 19:58:34 +0200
Message-ID: <20231012175836.3408077-14-thierry.reding@gmail.com>
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
Changes in v2:
- update for DT bindings changes

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

