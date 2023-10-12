Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED897C7581
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 19:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379703AbjJLR7I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 13:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442083AbjJLR7B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 13:59:01 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D439DA;
        Thu, 12 Oct 2023 10:58:59 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5045cb9c091so1759230e87.3;
        Thu, 12 Oct 2023 10:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133538; x=1697738338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyhQeT2Qvu3JaM/lywdwlKCkrqLoyR35ZknL8vXUp7o=;
        b=RHmMq/fN1Wbhz2ahXoxQAfnNmPYqcZ2CGDTE2dDSSp8vJEEiadn+7UkMOsLbgBXzV9
         AzZLJckuOpzcWZQIJ9hGIsnVPK5hHMYgxYoK53KRjquyYh5vkj0SeTbccCElEJvzFuI9
         OwzO2vocoz+FZRnJfmVml4vus4fiHP8cKAKcc35ChE8m2IU+k7knKFOfzHVaKVJOfRtS
         eQp2T+cnikduQ7TMI6ResxlyUtMAvHD1RmNxv/1/gZla1VUWOeNPqstRyA/2LVfb3ssJ
         4ZZ/RUsYtPJSvrCUi6p4hMmbyCzC96q+hScqeEzTudJU7f8/hP+gQDbTIGbZm2UrmbiY
         7AyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133538; x=1697738338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyhQeT2Qvu3JaM/lywdwlKCkrqLoyR35ZknL8vXUp7o=;
        b=SC/MO3TFKeiO9tv1izKiXRQSD/IELm2zXY6q6/3CbhgNSpbSR8kK+Af+QgxCLlsnnj
         ob3SCFtV7QAmlLNhamvc4slMg6BHc6dLQnVVkbPjyDO6QzfEXbPoMn0qUbk2ai9xzLW9
         3Dp607rleKO5HGO47BBj8+gyqeh8XP/6pCIDnuR8PC4bNh8iljzbYwl2xv5s/n6fyUi2
         Fqzj+l101YfE0vVmbSYRbBcJK7zVT2V42ene9xKJF2UlaPFISVoGczVsSQmQMcsKVDF4
         rSDU4e/AJ9DX0+AzfdvGsyArvZdJcciDGbGKLCiCtx5TnVZtJ1H1wGa0QRRFchTXRWJY
         lsfg==
X-Gm-Message-State: AOJu0Yw3GFPXbB8NZxWuMsWqCQwUH2LC8r1EuoMrx95ffodWv9sSAo7i
        eFBfeH7bkGLwQMHQai77RnwSpHezMKo=
X-Google-Smtp-Source: AGHT+IEDWB5SUilJekZ+H+j50DzSV4z3auCmIG+miW9ZUad7m4/Nqf3+kXvAlTZZHpaDGp/MwvXngA==
X-Received: by 2002:a05:6512:2392:b0:503:3707:66ed with SMTP id c18-20020a056512239200b00503370766edmr28168481lfv.34.1697133537583;
        Thu, 12 Oct 2023 10:58:57 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id j18-20020a508a92000000b0053deb97e8e6sm2010343edj.28.2023.10.12.10.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:58:57 -0700 (PDT)
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
Subject: [PATCH v2 12/13] ARM: tegra: Rework SOCTHERM on Tegra124
Date:   Thu, 12 Oct 2023 19:58:35 +0200
Message-ID: <20231012175836.3408077-15-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012175836.3408077-1-thierry.reding@gmail.com>
References: <20231012175836.3408077-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 arch/arm/boot/dts/nvidia/tegra124.dtsi | 65 +++++++-------------------
 1 file changed, 18 insertions(+), 47 deletions(-)

diff --git a/arch/arm/boot/dts/nvidia/tegra124.dtsi b/arch/arm/boot/dts/nvidia/tegra124.dtsi
index 8f1fff373461..ea692eb09067 100644
--- a/arch/arm/boot/dts/nvidia/tegra124.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra124.dtsi
@@ -928,12 +928,11 @@ soctherm: thermal-sensor@700e2000 {
 		#thermal-sensor-cells = <1>;
 
 		throttle-cfgs {
-			throttle_heavy: heavy {
+			heavy {
 				nvidia,priority = <100>;
 				nvidia,cpu-throt-percent = <85>;
 				nvidia,gpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_HIGH>;
-
-				#cooling-cells = <2>;
+				temperature = <100000>;
 			};
 		};
 	};
@@ -1238,112 +1237,84 @@ cpu-thermal {
 			polling-delay-passive = <1000>;
 			polling-delay = <1000>;
 
-			thermal-sensors =
-				<&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
+			thermal-sensors = <&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
 
 			trips {
-				cpu-shutdown-trip {
+				critical {
 					temperature = <103000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
-				cpu_throttle_trip: throttle-trip {
+
+				hot {
 					temperature = <100000>;
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
 			polling-delay-passive = <1000>;
 			polling-delay = <1000>;
 
-			thermal-sensors =
-				<&soctherm TEGRA124_SOCTHERM_SENSOR_MEM>;
+			thermal-sensors = <&soctherm TEGRA124_SOCTHERM_SENSOR_MEM>;
 
 			trips {
-				mem-shutdown-trip {
+				critical {
 					temperature = <103000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
-				mem-throttle-trip {
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
 			polling-delay = <1000>;
 
-			thermal-sensors =
-				<&soctherm TEGRA124_SOCTHERM_SENSOR_GPU>;
+			thermal-sensors = <&soctherm TEGRA124_SOCTHERM_SENSOR_GPU>;
 
 			trips {
-				gpu-shutdown-trip {
+				critical {
 					temperature = <101000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
-				gpu_throttle_trip: throttle-trip {
+
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
 			polling-delay-passive = <1000>;
 			polling-delay = <1000>;
 
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
 
-- 
2.42.0

