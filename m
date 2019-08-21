Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 544CE9873F
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 00:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbfHUWYp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 18:24:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34466 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731127AbfHUWYa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 18:24:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id s18so3504422wrn.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 15:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LEBx2vHRiP3hDZBSXgO5N6WbayFm3N+ToBekBZ2ae80=;
        b=mlNmHTuJUeaodKjc91t3wg+4JlBjT/LH+VA758Zj6nkiE7hXrsWI/mSxhdJF3LlIfN
         KGTZ59i6+y2dJ/rTaDixhBoJB3jwQWQ6Qk1P9wL8pX3ki70kmJQA6PaumDOSdqxM1sJw
         RBX29FFspJP8EmIp98jni0A8vu8/y3PXcfWROn+QcuL44TG6kAnFtk89g890x2IWr9As
         stZpX47MV0NOEajpdVd7wmyFvRp7rKyf7xnXNRwoAgoVrisjSFgKOSSdF16OERnyjwHV
         to4DG4Odnat6/NCIvXuA24WV4w6iWwdkokI9KY2AprKRkD+NAWfrO2kkQuXkmHbfNtKJ
         oaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LEBx2vHRiP3hDZBSXgO5N6WbayFm3N+ToBekBZ2ae80=;
        b=MEuSDiiL1xSja5nlgletGSyc2gmeTpJfh7Wb1E9eI+LrZfpapAooiQ58sQ/RLT9dvr
         XpAvwp15Sf+PTnkaiaU7OiFAVnYned+Jcw1rtA/up+UcP/0j6Q77p/+z6kKvdbvS4uwR
         dItn1FFT0yHeKsQ1MdXGtMi45uV55NaEsfNjyKzpwCclfSZALuffsB91kXwar+a2IBp3
         Ptd/0FjJAKY81xM0/sVptqztbv3Rty4l5S6Q/M7p+R5pg+R18ICc1mABD2XpxUaLNSxc
         B7BlLNmQ3Kxl/boXhmDrp1kwwgN6XqYzDcRvV6QAQVY+5fMxO+fI31exaL6Q7HsSRYFw
         olJQ==
X-Gm-Message-State: APjAAAUzv1YTHqSF7aZoL+NTWGvGZAYXTqxKi7h0ZbqTYa8SGZKgJQt6
        Ck43rm2D6Dr8tHqfeg14n/4MDQ==
X-Google-Smtp-Source: APXvYqw01wEmbQ6VScaWNUUHN/sT9b2JnBtntU+d7a3SpWfg23SXzSKw7uEKuW+VufQEHQl/yQQFog==
X-Received: by 2002:adf:e787:: with SMTP id n7mr19204372wrm.57.1566426268223;
        Wed, 21 Aug 2019 15:24:28 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id f197sm3548549wme.22.2019.08.21.15.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 15:24:27 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v4 4/6] arm64: dts: meson: sei510: Add minimal thermal zone
Date:   Thu, 22 Aug 2019 00:24:19 +0200
Message-Id: <20190821222421.30242-5-glaroque@baylibre.com>
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
 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index c9fa23a56562..35d2ebbd6d4e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -10,6 +10,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/meson-g12a-gpio.h>
 #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "seirobotics,sei510", "amlogic,g12a";
@@ -33,6 +34,67 @@
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
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&cpu_critical>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
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
 	mono_dac: audio-codec-0 {
 		compatible = "maxim,max98357a";
 		#sound-dai-cells = <0>;
@@ -321,6 +383,7 @@
 	operating-points-v2 = <&cpu_opp_table>;
 	clocks = <&clkc CLKID_CPU_CLK>;
 	clock-latency = <50000>;
+	#cooling-cells = <2>;
 };
 
 &cpu1 {
@@ -328,6 +391,7 @@
 	operating-points-v2 = <&cpu_opp_table>;
 	clocks = <&clkc CLKID_CPU_CLK>;
 	clock-latency = <50000>;
+	#cooling-cells = <2>;
 };
 
 &cpu2 {
@@ -335,6 +399,7 @@
 	operating-points-v2 = <&cpu_opp_table>;
 	clocks = <&clkc CLKID_CPU_CLK>;
 	clock-latency = <50000>;
+	#cooling-cells = <2>;
 };
 
 &cpu3 {
@@ -342,6 +407,7 @@
 	operating-points-v2 = <&cpu_opp_table>;
 	clocks = <&clkc CLKID_CPU_CLK>;
 	clock-latency = <50000>;
+	#cooling-cells = <2>;
 };
 
 &cvbs_vdac_port {
@@ -368,6 +434,10 @@
 	status = "okay";
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

