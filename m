Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FACA3464EA
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 17:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhCWQWG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 12:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbhCWQVk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 12:21:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA07DC061763
        for <linux-pm@vger.kernel.org>; Tue, 23 Mar 2021 09:21:39 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y6so24163612eds.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Mar 2021 09:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pIkIqJMv+IeqQ7Qaqj74AFsyLZNrmWG/hrULA7PoUF8=;
        b=IBOGlU05IAY7uP9kFbtn/IrP3XlcRGHvzVEqe8VLC/JgJbmPLt69YYpS0TS/4Yp2Uh
         smEVbrVSKYlioZYyYXGXHAOmf429kRx7RX2dndQ4QDTntudWurBMHT4s5CAWv8C4bUTw
         9JDevl/OCtfzDrHgQjH812JF+kkVbxG0m5YatAIG9WhUgVYTKazO4mrI2hyQ9JvJu3sO
         QIlPQOeaslZir8sGlPcPTVQVkZsZCBGfBcQ9NDhOcfck86hiryNVS6FJkqIeiFVAGlaq
         OzXYxG6fzhxm0xRa9JMZ7g3NqJm5kH33Kzfbbg7yfwQRWDDWkKy6r7qHDRW9HBDXezF+
         y3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pIkIqJMv+IeqQ7Qaqj74AFsyLZNrmWG/hrULA7PoUF8=;
        b=uk2BUm3VyD1OZtnejhrJuQrdqYSeHKxm29wVci0q9vZ9EGGX48sn1FtVBx4Scai7Mn
         rm6zEPSCjyaygAHR72ePLRpeFshdKI/Vwsqi+PD0Zm7RaEqDCTgOvDfbe740UTvhQt+6
         qSLPwbj5YXrKwWGNS89B4L2uDctldKfiOizmx7beJpl7xrrwHUd/y78sMW2fHpD30fb4
         eG3Krve77HTDyPHTWHJJ0cqpm8AXLRr6zCkc3Q8ZUfOk8XIvDZgd3OkpmCiFjF12UBYY
         GhWCAHZcpxExVLHrocVY/Tl3OFrwI7LC7h0PJ4dYteYmGSxlbOWXXCztMUzzTQlqVWcj
         AIIQ==
X-Gm-Message-State: AOAM532CFtt9DTVdoV+ALVhBgDRNCY1j5MqehMJXQixe3DmIp7zK+WGU
        r6R3jPj9zdiWqakW+jO+tfr9xw==
X-Google-Smtp-Source: ABdhPJxIJz6WDNFfHOcDGKzvkmTmSGZB050ydF8z/8nkBeddWleVo56bS9+h5kKWR6IiaDBieDinkQ==
X-Received: by 2002:aa7:cd0e:: with SMTP id b14mr5510911edw.354.1616516498483;
        Tue, 23 Mar 2021 09:21:38 -0700 (PDT)
Received: from localhost.localdomain ([37.120.1.234])
        by smtp.gmail.com with ESMTPSA id v8sm13073478edq.76.2021.03.23.09.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 09:21:38 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     amitk@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vinod.koul@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Robert Foss <robert.foss@linaro.org>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 2/2] arm64: dts: qcom: sm8350: Add thermal zones and throttling support
Date:   Tue, 23 Mar 2021 17:20:55 +0100
Message-Id: <20210323162052.1143515-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.31.0.30.g398dba342d.dirty
In-Reply-To: <20210323162052.1143515-1-robert.foss@linaro.org>
References: <20210323162052.1143515-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

sm8350 has 29 thermal sensors split across two tsens controllers. Add
the thermal zones to expose them and wireup the cpus to throttle their
frequencies on crossing passive temperature thresholds.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---

Changes since v1:
 - Vinod: Remove comment

Changes since v2:
 - Vinod: Add r-b
 - Konrad: Use lower case hex addresses
 - Really remove comments


 arch/arm64/boot/dts/qcom/sm8350.dtsi | 826 +++++++++++++++++++++++++++
 1 file changed, 826 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 4abdba78cec1..3b53066285ce 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/power/qcom-aoss-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -46,6 +47,7 @@ CPU0: cpu@0 {
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			#cooling-cells = <2>;
 			L2_0: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -62,6 +64,7 @@ CPU1: cpu@100 {
 			enable-method = "psci";
 			next-level-cache = <&L2_100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			#cooling-cells = <2>;
 			L2_100: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -75,6 +78,7 @@ CPU2: cpu@200 {
 			enable-method = "psci";
 			next-level-cache = <&L2_200>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			#cooling-cells = <2>;
 			L2_200: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -88,6 +92,7 @@ CPU3: cpu@300 {
 			enable-method = "psci";
 			next-level-cache = <&L2_300>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			#cooling-cells = <2>;
 			L2_300: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -101,6 +106,7 @@ CPU4: cpu@400 {
 			enable-method = "psci";
 			next-level-cache = <&L2_400>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			#cooling-cells = <2>;
 			L2_400: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -114,6 +120,7 @@ CPU5: cpu@500 {
 			enable-method = "psci";
 			next-level-cache = <&L2_500>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			#cooling-cells = <2>;
 			L2_500: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -128,6 +135,7 @@ CPU6: cpu@600 {
 			enable-method = "psci";
 			next-level-cache = <&L2_600>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			#cooling-cells = <2>;
 			L2_600: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -141,6 +149,7 @@ CPU7: cpu@700 {
 			enable-method = "psci";
 			next-level-cache = <&L2_700>;
 			qcom,freq-domain = <&cpufreq_hw 2>;
+			#cooling-cells = <2>;
 			L2_700: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
@@ -682,6 +691,28 @@ pdc: interrupt-controller@b220000 {
 			interrupt-controller;
 		};
 
+		tsens0: thermal-sensor@c222000 {
+			compatible = "qcom,sm8350-tsens", "qcom,tsens-v2";
+			reg = <0 0x0c263000 0 0x1ff>, /* TM */
+			      <0 0x0c222000 0 0x8>; /* SROT */
+			#qcom,sensors = <15>;
+			interrupts = <&pdc 26 IRQ_TYPE_LEVEL_HIGH>,
+				     <&pdc 28 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens1: thermal-sensor@c223000 {
+			compatible = "qcom,sm8350-tsens", "qcom,tsens-v2";
+			reg = <0 0x0c265000 0 0x1ff>, /* TM */
+			      <0 0x0c223000 0 0x8>; /* SROT */
+			#qcom,sensors = <14>;
+			interrupts = <&pdc 27 IRQ_TYPE_LEVEL_HIGH>,
+				     <&pdc 29 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
+			#thermal-sensor-cells = <1>;
+		};
+
 		aoss_qmp: qmp@c300000 {
 			compatible = "qcom,sm8350-aoss-qmp";
 			reg = <0 0x0c300000 0 0x100000>;
@@ -1280,6 +1311,801 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 		};
 	};
 
+	thermal-zones {
+		cpu0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 1>;
+
+			trips {
+				cpu0_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu0_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu0_crit: cpu_crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu0_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu0_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 2>;
+
+			trips {
+				cpu1_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu1_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu1_crit: cpu_crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu1_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu1_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 3>;
+
+			trips {
+				cpu2_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu2_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu2_crit: cpu_crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu2_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu2_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu3-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 4>;
+
+			trips {
+				cpu3_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu3_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu3_crit: cpu_crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu3_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu3_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu4-top-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 7>;
+
+			trips {
+				cpu4_top_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu4_top_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu4_top_crit: cpu_crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu4_top_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu4_top_alert1>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu5-top-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 8>;
+
+			trips {
+				cpu5_top_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu5_top_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu5_top_crit: cpu_crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu5_top_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu5_top_alert1>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu6-top-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 9>;
+
+			trips {
+				cpu6_top_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu6_top_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu6_top_crit: cpu_crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu6_top_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu6_top_alert1>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu7-top-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 10>;
+
+			trips {
+				cpu7_top_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu7_top_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu7_top_crit: cpu_crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu7_top_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu7_top_alert1>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu4-bottom-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 11>;
+
+			trips {
+				cpu4_bottom_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu4_bottom_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu4_bottom_crit: cpu_crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu4_bottom_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu4_bottom_alert1>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu5-bottom-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 12>;
+
+			trips {
+				cpu5_bottom_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu5_bottom_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu5_bottom_crit: cpu_crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu5_bottom_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu5_bottom_alert1>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu6-bottom-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 13>;
+
+			trips {
+				cpu6_bottom_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu6_bottom_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu6_bottom_crit: cpu_crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu6_bottom_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu6_bottom_alert1>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu7-bottom-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 14>;
+
+			trips {
+				cpu7_bottom_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu7_bottom_alert1: trip-point1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu7_bottom_crit: cpu_crit {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu7_bottom_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+				map1 {
+					trip = <&cpu7_bottom_alert1>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		aoss0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 0>;
+
+			trips {
+				aoss0_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		cluster0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 5>;
+
+			trips {
+				cluster0_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				cluster0_crit: cluster0_crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cluster1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 6>;
+
+			trips {
+				cluster1_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				cluster1_crit: cluster1_crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		aoss1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 0>;
+
+			trips {
+				aoss1_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		gpu-thermal-top {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 1>;
+
+			trips {
+				gpu1_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+			};
+		};
+
+		gpu-thermal-bottom {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 2>;
+
+			trips {
+				gpu2_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+			};
+		};
+
+		nspss1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 3>;
+
+			trips {
+				nspss1_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+			};
+		};
+
+		nspss2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 4>;
+
+			trips {
+				nspss2_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+			};
+		};
+
+		nspss3-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 5>;
+
+			trips {
+				nspss3_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <1000>;
+					type = "hot";
+				};
+			};
+		};
+
+		video-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 6>;
+
+			trips {
+				video_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		mem-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 7>;
+
+			trips {
+				mem_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		modem1-thermal-top {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 8>;
+
+			trips {
+				modem1_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		modem2-thermal-top {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 9>;
+
+			trips {
+				modem2_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		modem3-thermal-top {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 10>;
+
+			trips {
+				modem3_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		modem4-thermal-top {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 11>;
+
+			trips {
+				modem4_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		camera-thermal-top {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 12>;
+
+			trips {
+				camera1_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		camera-thermal-bottom {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 13>;
+
+			trips {
+				camera2_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
-- 
2.31.0.30.g398dba342d.dirty

