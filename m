Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6C89CB6E1
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 11:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388128AbfJDJBh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 05:01:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33914 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388123AbfJDJBY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2019 05:01:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id y135so9097102wmc.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Oct 2019 02:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gKlncKkeKiOPhKAIhttqbr6HYS2dTyRQP+4Baa5xLmI=;
        b=BSv5Bycmn4XtgAhc6+7VYH4IbEvzSwbW2t+hZmS2GoP+VLplDuZF103AwDwHjtjW4V
         q4gJrMYJPkkiFHyNjhp/zm0QuBXfOMO5PaXUJhdIy6XUuxufRovFlvp2C59lEyXSuvcw
         Kd29tObmyi6qJDb17C09EvX7ko4jurraqABZsn16WrjpHBkZXTUL3PhTE7A3JnDzBVdc
         fLZi1uUHFLh7oLJHx3RB87oPPEUtd4gPkmF/WB6hHoKv97bLTJE3UuqZiQmAH9Q4sDeC
         t1nRvr7AZnpwjKwqB4XY1L3eX9sLtponVvNE2z2Td6P1RqQGnYNQcDR4wu2joV7BI4IQ
         scKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gKlncKkeKiOPhKAIhttqbr6HYS2dTyRQP+4Baa5xLmI=;
        b=NaOJh9QjXSgtSxzRxldmFi+XT+jkrcIB/DJEO/X5y5TKllwPUoOqkTiv0Bt/pq6JW8
         cwBXkFe1KN7UNYnMGNYmCxuZyMJLv2nu3GWRj8uONlrS4EziZZzrr56WFyeaH3HtbD4T
         0wTssw077BFalQAQ1KWLH7L87Q9iCynA0wJfM9KoeK69TkuFSn4QQv2D9PrqBkiFM4mk
         y3H/rSusvbiVoz67imhmX7XVL0/LDOb/vG25NednUZk5FTJo5Sf7gsnPEa25nD+vByNr
         9lVVXTcBeMV+vnmWHLRm85VKpkQU/i5yOdIvIcSc8fW3LmT8SNemgvFt/86E5yW87VF/
         BbVg==
X-Gm-Message-State: APjAAAWtj9emiY4AcHISiYPC8Pvde5ltCCn94HVkctekGP6jfjIhiEr4
        da4PHYNg6U1ACtvZxUhjgoup3g==
X-Google-Smtp-Source: APXvYqx8aNzo3ZYZjTc1LIfBgqGsmtdQFK4IhoYvZX3PB6pFJxFE5P7+1MnQrQAZfG0vVA7IaIiSbA==
X-Received: by 2002:a1c:a8d8:: with SMTP id r207mr9701863wme.135.1570179681779;
        Fri, 04 Oct 2019 02:01:21 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v8sm7765170wra.79.2019.10.04.02.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 02:01:21 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v7 4/7] arm64: dts: meson: g12: Add minimal thermal zone
Date:   Fri,  4 Oct 2019 11:01:11 +0200
Message-Id: <20191004090114.30694-5-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004090114.30694-1-glaroque@baylibre.com>
References: <20191004090114.30694-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add minimal thermal zone for two temperature sensor
One is located close to the DDR and the other one is
located close to the PLLs (between the CPU and GPU)

Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 0660d9ef6a86..a98c16e163c2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
 #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -94,6 +95,61 @@
 		#size-cells = <2>;
 		ranges;
 
+		thermal-zones {
+			cpu_thermal: cpu-thermal {
+				polling-delay = <1000>;
+				polling-delay-passive = <100>;
+				thermal-sensors = <&cpu_temp>;
+
+				trips {
+					cpu_passive: cpu-passive {
+						temperature = <85000>; /* millicelsius */
+						hysteresis = <2000>; /* millicelsius */
+						type = "passive";
+					};
+
+					cpu_hot: cpu-hot {
+						temperature = <95000>; /* millicelsius */
+						hysteresis = <2000>; /* millicelsius */
+						type = "hot";
+					};
+
+					cpu_critical: cpu-critical {
+						temperature = <110000>; /* millicelsius */
+						hysteresis = <2000>; /* millicelsius */
+						type = "critical";
+					};
+				};
+			};
+
+			ddr_thermal: ddr-thermal {
+				polling-delay = <1000>;
+				polling-delay-passive = <100>;
+				thermal-sensors = <&ddr_temp>;
+
+				trips {
+					ddr_passive: ddr-passive {
+						temperature = <85000>; /* millicelsius */
+						hysteresis = <2000>; /* millicelsius */
+						type = "passive";
+					};
+
+					ddr_critical: ddr-critical {
+						temperature = <110000>; /* millicelsius */
+						hysteresis = <2000>; /* millicelsius */
+						type = "critical";
+					};
+				};
+
+				cooling-maps {
+					map {
+						trip = <&ddr_passive>;
+						cooling-device = <&mali THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					};
+				};
+			};
+		};
+
 		ethmac: ethernet@ff3f0000 {
 			compatible = "amlogic,meson-axg-dwmac",
 				     "snps,dwmac-3.70a",
@@ -2412,6 +2468,7 @@
 			assigned-clock-rates = <0>, /* Do Nothing */
 					       <800000000>,
 					       <0>; /* Do Nothing */
+			#cooling-cells = <2>;
 		};
 	};
 
-- 
2.17.1

