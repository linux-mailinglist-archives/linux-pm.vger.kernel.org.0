Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F98F6E23E8
	for <lists+linux-pm@lfdr.de>; Fri, 14 Apr 2023 14:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjDNM6L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Apr 2023 08:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjDNM6I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2023 08:58:08 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860D8B46A;
        Fri, 14 Apr 2023 05:57:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j16so2866935wms.0;
        Fri, 14 Apr 2023 05:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681477056; x=1684069056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMs4htTs+n807Qxv9wy5B+iV59lczbMdJjiqtA7CgWY=;
        b=H4dMMARGwEbB3rtkUy3jrLYXf8TheuPZeauo1lHhG8NiBviIOmrfDrlJ2kbzoLJcTl
         EIqSZFCUv+EmTdTT4jvm8nghBTiJHkRFc6l4ZvRStEOu0DqqMaPgz+P2N4SSjxUMlZ4f
         PFoSG1TwnMZx+bRkwbqb2Rzpc14rMnwu0Qai+BGQqpxX4ep3+VR032qdrzBVbZpm00vd
         +tOiW2+Qs4Z23MXhVtD6LB03xNAyQ7t9nmExn+fC3GZnqVdWPMtPzkPXUDcLsAcpgwyI
         plQs5rwcDLgzvyosLab9bs0+lXVSPnH8vQeDAYWN4V7kI92ipqZQz7/8jKmNt7lZUX3r
         TeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681477056; x=1684069056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMs4htTs+n807Qxv9wy5B+iV59lczbMdJjiqtA7CgWY=;
        b=XQUKJzj+Pz1dzpZ/tDFT9YhyMeLM0nBI4dkTG+HEfAu3P3NkvvgAO4UzNickHJyoHt
         PUlmNl7DBYhe3qbzG1oUoC0em5UO7Z2xj1PjH3SOfhLdgPtSBtkMTMq1+2ZA6kfm7WKe
         iOv0lrZZdoRN8r3nfraUHR8WklNLZy3UVwICh3laUDdc70p+qHdA9L7mhzNxtxzIHIQ+
         Cvxqh5lLR504mPpic+DiVXQYhEF/Ky/dj+SUh/u4qwn6q3C3qTJlVgnO5k4I+meVq+rX
         MIad3lk+LM1U5PUjHjojwBZPuJVS+Rb37xI/g53zFXODmnJNMhf2dC59/2fCPyS3x7m5
         BFBQ==
X-Gm-Message-State: AAQBX9fWs+stuXoD4+GsO2C5BFKbtne94+ihqKChlcy7umuj3RJO1e/3
        jJm+0aZpipA6cfLpvbbz8S8=
X-Google-Smtp-Source: AKy350btVpQD6kyqa52bpUzBZoidiHySS9CWllmEGLe/YsZ90XPXR+tH7RIO5dErD1F+JlLYJyhHJg==
X-Received: by 2002:a05:600c:3788:b0:3f0:a08e:811b with SMTP id o8-20020a05600c378800b003f0a08e811bmr4580876wmr.13.1681477056509;
        Fri, 14 Apr 2023 05:57:36 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c19cf00b003ede3f5c81fsm7932788wmq.41.2023.04.14.05.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:57:36 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 10/10] ARM: tegra: Rework SOCTHERM on Tegra124
Date:   Fri, 14 Apr 2023 14:57:21 +0200
Message-Id: <20230414125721.1043589-11-thierry.reding@gmail.com>
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
 arch/arm/boot/dts/tegra124.dtsi | 65 +++++++++------------------------
 1 file changed, 18 insertions(+), 47 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index b3fbecf5c818..656361b4ac01 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -932,12 +932,11 @@ soctherm: thermal-sensor@700e2000 {
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
@@ -1242,112 +1241,84 @@ cpu-thermal {
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
2.40.0

