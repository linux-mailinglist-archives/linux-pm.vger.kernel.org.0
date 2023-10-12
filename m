Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF9F7C757B
	for <lists+linux-pm@lfdr.de>; Thu, 12 Oct 2023 19:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442095AbjJLR7G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Oct 2023 13:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442118AbjJLR67 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2023 13:58:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC4CE1;
        Thu, 12 Oct 2023 10:58:57 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99c3c8adb27so201336966b.1;
        Thu, 12 Oct 2023 10:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697133536; x=1697738336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKiw2SIAdmYLlpLe2esjmaSazy2c7GkFD1/5AuLgOtE=;
        b=ApDil+YP/32EPGs5rSPkRfnXBxTLBmbjwNDrRmixTA1YmBD5v1tM5+puMmVtXkVocv
         6MEL1dTOk9iEMLW0ByaazWAovRFTJlKKnr2ZHhQcTFuULkh0VHvB6qdfa9s2cpGBv08h
         s66HpEN9V/OI+3NCFfPA7ttfK6iDT1MYVIKbAFYsbc/5B8neK77fDn8wmiIOJw5LcEFp
         SSgF6RkmQXBBRlYqU0DbYeDzhvrt3wRWZz/nhohTmGNlrK0kK2jwkfy+nGFlszcS+Kqq
         eEz0D40e8G82yK7zxlhrlSTmL7a92mcsvbxBWX7tn1oYd30hTpJRBY3U5hhUA4mRmJmx
         EveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133536; x=1697738336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKiw2SIAdmYLlpLe2esjmaSazy2c7GkFD1/5AuLgOtE=;
        b=kxxT9DPqghQPBBXz3YLCESVugpouOdrAnKs0S00S5OGzaN6HcqusqqjGQSqbXF3jRu
         GXkKkXSXi7muhzCJ5IQT+y9hGjgKQKGb/MXFZTPpHgnqPFvMAkgO5OQEV7R3o2uCwwKf
         ysBZ+5/JNC3TF2wGmhKxJ1rno7Muiporyj1CoPt9DbkEyA955x3s8mQpQ+eoVM4lVbg1
         J0N0Lp+Y37izbUNP1PcnRCQq3DDNraIz2sdDW/Rg6GVJZS3BFceeJtHtlEpUdyh3nTG2
         Bdyy1BjhRIb/zDsJlGqSYMJLfQ55yNLjI5JPNfLp3cu7CZHjjIzohk5ACmWZNfpnIUAc
         SHiQ==
X-Gm-Message-State: AOJu0Yx7OG1GcO9PHTGwTJdIlHVVIIk5gyFXriN2z7Aiy4eC3WqiSOys
        asnGtvnVfuL3viXrL5xG3A3GjdhxoVU=
X-Google-Smtp-Source: AGHT+IF0e5xKq2P16Vtt9Ls2WN/hfRSVK1Ftx69WnQPeMeeFbqnaOMAdZH8IT9Qyc4gV6xoELd0boQ==
X-Received: by 2002:a17:906:31cc:b0:9b2:b2f8:85dc with SMTP id f12-20020a17090631cc00b009b2b2f885dcmr20511001ejf.34.1697133535619;
        Thu, 12 Oct 2023 10:58:55 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u25-20020a1709063b9900b0099bc2d1429csm11386902ejf.72.2023.10.12.10.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:58:55 -0700 (PDT)
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
Subject: [PATCH v2 11/13] ARM: tegra: Rework SOCTHERM on Tegra124
Date:   Thu, 12 Oct 2023 19:58:33 +0200
Message-ID: <20231012175836.3408077-13-thierry.reding@gmail.com>
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
Changes in v2:
- update for DT bindings changes

 arch/arm/boot/dts/nvidia/tegra124.dtsi | 68 ++++++++------------------
 1 file changed, 21 insertions(+), 47 deletions(-)

diff --git a/arch/arm/boot/dts/nvidia/tegra124.dtsi b/arch/arm/boot/dts/nvidia/tegra124.dtsi
index 8f1fff373461..6af944fe6769 100644
--- a/arch/arm/boot/dts/nvidia/tegra124.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra124.dtsi
@@ -928,12 +928,14 @@ soctherm: thermal-sensor@700e2000 {
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
+				temperature-millicelsius = <100000>;
+				hysteresis-millicelsius = <4000>;
 			};
 		};
 	};
@@ -1238,112 +1240,84 @@ cpu-thermal {
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

