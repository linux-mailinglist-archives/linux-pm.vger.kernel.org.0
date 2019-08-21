Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5D89873D
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 00:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbfHUWYn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 18:24:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39209 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731156AbfHUWYb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 18:24:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id i63so3700323wmg.4
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 15:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SZfK4Hg91c5el5MGv7c8euoA+RwD5KE0S9Rh7Yj1wX0=;
        b=JIROksQBn/wUgB6FfkE6PFnGUae4NRfjwm9rLA/bGdOTN4cOWEAV9H/tDUTkkgfXc1
         UpywIfXpUBBOvOm832InIZl9nO+GI37O1mhhEQ8uLOFHxrUNYrOwHTwKWRH+SJv9g7VS
         fad6UaQKVoNBYp9l1E+8dPJJ3YMCEZxaYniuAhvj2EBzEZAgihX4xSbTCkBye5NrtSIe
         lG7mFSnqTcmPGcmne+/qNo5CV5+OiGLEptTnn/v3ZzLBWpV1in83BdZlMAcPjwOCYGVg
         ak0WFEfRiE6eMm24s/lFnc2aZv1zlMXyc+rUWoFpWHVevd5tcqsuMMjc79K5Gro/gLYF
         Q+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SZfK4Hg91c5el5MGv7c8euoA+RwD5KE0S9Rh7Yj1wX0=;
        b=Exd2ezADiOEd/EaL8SI1FSkt+0jQMVg0mTvW1btMUwfUHFIGUifouNHGfi+gpgoC2s
         DZToGsnzDI5pGF3Pxh2kKkb4RujoL9oMQb1tFoMmt5ipPrXmKHIRPh28f54flUjSFL8z
         KJ5NugLvpGiD0E58TeobzCFwdLCc0Zo/tBdKHjGlkQswjzLOLRRi25g/84POLOYE6zrp
         LGG1fA4Gz/Kthvh4n8jP/8WCYp4uNDRm97jxjvwDO15BvWnncaXkxG6cbnQpiSi9ZN/X
         jnN29rhiXjpfXyPng32ODCv8mQvASTncJb+nia1JvifILZImQIdYjVxIG8dtvSJ+Admy
         oZtw==
X-Gm-Message-State: APjAAAU6GqgXio2td3JBp9AKEUxWkTnsc62lsLuOT34Eq2K70oFX1DYX
        j6w9ewAqU9w8W7KSJCI8rJD1Yw==
X-Google-Smtp-Source: APXvYqwXk/S55RI20FFYfg0q6r9Dp40s4hg452KGkBolKibnp7pp/4XabfkKiDeYLIelawNN91iDFQ==
X-Received: by 2002:a1c:61d4:: with SMTP id v203mr2444338wmb.164.1566426269301;
        Wed, 21 Aug 2019 15:24:29 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id f197sm3548549wme.22.2019.08.21.15.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 15:24:28 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v4 5/6] arm64: dts: amlogic: odroid-n2: add minimal thermal zone
Date:   Thu, 22 Aug 2019 00:24:20 +0200
Message-Id: <20190821222421.30242-6-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821222421.30242-1-glaroque@baylibre.com>
References: <20190821222421.30242-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add minimal thermal zone for two temperature sensor
One is located close to the DDR and the other one is
located close to the PLLs (between the CPU and GPU)

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 777bfb938854..8d7c73bad4aa 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -10,6 +10,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/meson-g12a-gpio.h>
 #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "hardkernel,odroid-n2", "amlogic,g12b";
@@ -20,6 +21,71 @@
 		ethernet0 = &ethmac;
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&cpu_temp>;
+
+			trips {
+				cpu_hot: cpu-hot {
+					temperature = <85000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "hot";
+				};
+
+				cpu_critical: cpu-critical {
+					temperature = <110000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_hot>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu100 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu101 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu102 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu103 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&cpu_critical>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu100 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu101 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu102 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu103 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		ddr-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&ddr_temp>;
+
+			trips {
+				ddr_critical: ddr-critical {
+					temperature = <110000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map {
+					trip = <&ddr_critical>;
+					cooling-device = <&mali THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -289,6 +355,7 @@
 	operating-points-v2 = <&cpu_opp_table_0>;
 	clocks = <&clkc CLKID_CPU_CLK>;
 	clock-latency = <50000>;
+	#cooling-cells = <2>;
 };
 
 &cpu1 {
@@ -296,6 +363,7 @@
 	operating-points-v2 = <&cpu_opp_table_0>;
 	clocks = <&clkc CLKID_CPU_CLK>;
 	clock-latency = <50000>;
+	#cooling-cells = <2>;
 };
 
 &cpu100 {
@@ -303,6 +371,7 @@
 	operating-points-v2 = <&cpub_opp_table_1>;
 	clocks = <&clkc CLKID_CPUB_CLK>;
 	clock-latency = <50000>;
+	#cooling-cells = <2>;
 };
 
 &cpu101 {
@@ -310,6 +379,7 @@
 	operating-points-v2 = <&cpub_opp_table_1>;
 	clocks = <&clkc CLKID_CPUB_CLK>;
 	clock-latency = <50000>;
+	#cooling-cells = <2>;
 };
 
 &cpu102 {
@@ -317,6 +387,7 @@
 	operating-points-v2 = <&cpub_opp_table_1>;
 	clocks = <&clkc CLKID_CPUB_CLK>;
 	clock-latency = <50000>;
+	#cooling-cells = <2>;
 };
 
 &cpu103 {
@@ -324,6 +395,7 @@
 	operating-points-v2 = <&cpub_opp_table_1>;
 	clocks = <&clkc CLKID_CPUB_CLK>;
 	clock-latency = <50000>;
+	#cooling-cells = <2>;
 };
 
 &ext_mdio {
@@ -378,6 +450,10 @@
 	};
 };
 
+&mali {
+	#cooling-cells = <2>;
+};
+
 &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmitx_hpd_pins>, <&hdmitx_ddc_pins>;
-- 
2.17.1

