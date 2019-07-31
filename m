Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76DD97C6C2
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 17:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfGaPfi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 11:35:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52518 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbfGaPfh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 11:35:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so61279217wms.2
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 08:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+6gJ8AQ+8bL1C5uonG6TfemRUot9hgKsCIvxaaOHaM0=;
        b=bpMaWmEB0gYIdBRiCkZ0Njf50rEB/8dTwJKP8YnC2iKk5DZgQ4+wDGjKSBizhNT5mX
         5GxGglVZYHkf88xrTqV8T/3QUt1mywoY6JqqDc/OKAJqSwtvZ1StvCgO9WI0vG9Kxs3A
         pECJgUpFI+b/qMezVjG8piiGEminumNEOX7DAd0cIWFhtI8azf2cZ10uBUfyDiaKnfun
         8EoKqZhkC+SrY1GkwKqvhnujO/2XsiMSfQxhLC1QEP+jDtVmKO5MkjQob+3GpcofwES2
         Pgl19CK+52aBci57jDSOaFoYw6kvlG0doYNoCs3+h9/SYq5UF2DFkd3KsXEXrYMrIPDk
         x4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+6gJ8AQ+8bL1C5uonG6TfemRUot9hgKsCIvxaaOHaM0=;
        b=lR5w3RN/YXKtj6Ic9pAJPqVGPL1E1r/aVabHw+6jkEhFfNcRJ4raudMYkldaMhU8bP
         KiF4mtW0KJpuAOLHDo8VqU3FZeQldfDHWnMX/eZM1daStYw99qk/D0qVinlFv3GBmfAA
         YQCroMTed1Ep7qNTXPAqIM+IFYzPELzRavZI+PGGdNZiAwk0qmyGD3TIeWDLL/V60+fO
         /TPNlxkiVXcWapPTY7CViS/5xZTf4+ssg7N88cSfWEy0KdVqBC9mhBl5vwnn0+qVxIVc
         zdm2j/Jsy3kYqj8fPIHIYaWHcIdDT+Tt7dGbI+PMay64c3QqmuXRzdAqQ0YARv9N5Ifj
         Oujg==
X-Gm-Message-State: APjAAAX57FxFRBejADgY72Rlsokwxk1Sa2ITNWhrsMwaW8gv5egt/1Qq
        VdvpHB0RC9oeFZte8SMFQG+xVw==
X-Google-Smtp-Source: APXvYqyYRH+0jfs9jqLCSAGYzhF4F4uTSWpyjE70mkciabVgvyHCM1+INRysUBYEzO59vgmjq2qfAQ==
X-Received: by 2002:a7b:c081:: with SMTP id r1mr62192131wmh.76.1564587335879;
        Wed, 31 Jul 2019 08:35:35 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i13sm62834396wrr.73.2019.07.31.08.35.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 08:35:35 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     daniel.lezcano@linaro.org, khilman@baylibre.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/6] arm64: dts: meson: sei510: Add minimal thermal zone
Date:   Wed, 31 Jul 2019 17:35:27 +0200
Message-Id: <20190731153529.30159-5-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731153529.30159-1-glaroque@baylibre.com>
References: <20190731153529.30159-1-glaroque@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add minimal thermal zone for DDR and CPU sensor

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 979449968a5f..2c16a2cba0a3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -10,6 +10,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/meson-g12a-gpio.h>
 #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	compatible = "seirobotics,sei510", "amlogic,g12a";
@@ -33,6 +34,53 @@
 		ethernet0 = &ethmac;
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <100>;
+			thermal-sensors = <&cpu_temp>;
+
+			trips {
+				cpu_critical: cpu-critical {
+					temperature = <110000>; /* millicelsius */
+					hysteresis = <2000>; /* millicelsius */
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map {
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
@@ -321,6 +369,7 @@
 	operating-points-v2 = <&cpu_opp_table>;
 	clocks = <&clkc CLKID_CPU_CLK>;
 	clock-latency = <50000>;
+	#cooling-cells = <2>;
 };
 
 &cpu1 {
@@ -328,6 +377,7 @@
 	operating-points-v2 = <&cpu_opp_table>;
 	clocks = <&clkc CLKID_CPU_CLK>;
 	clock-latency = <50000>;
+	#cooling-cells = <2>;
 };
 
 &cpu2 {
@@ -335,6 +385,7 @@
 	operating-points-v2 = <&cpu_opp_table>;
 	clocks = <&clkc CLKID_CPU_CLK>;
 	clock-latency = <50000>;
+	#cooling-cells = <2>;
 };
 
 &cpu3 {
@@ -342,6 +393,7 @@
 	operating-points-v2 = <&cpu_opp_table>;
 	clocks = <&clkc CLKID_CPU_CLK>;
 	clock-latency = <50000>;
+	#cooling-cells = <2>;
 };
 
 &cvbs_vdac_port {
@@ -368,6 +420,10 @@
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

