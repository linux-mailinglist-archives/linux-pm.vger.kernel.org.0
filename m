Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4F319AE7D
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 17:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbgDAPGS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 11:06:18 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:38033 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732561AbgDAPGR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2020 11:06:17 -0400
Received: by mail-pf1-f174.google.com with SMTP id c21so58982pfo.5
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2020 08:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=50fAx/z8BiiJgV6xcMm5m+rS8cm1yPJaVkfUXd/vHrY=;
        b=uUFC1LJ297eYF2vxF2dM8YaGJnU8BZbyxKx+Eii29ZD59/X426H6cXu+tdEd252YCh
         eA2Psl6w3wjY25011e/gnFsFCXHjDikTffLDkNXxolfoXPPtYBOQYUxApiVk07iePAYL
         EddBoZJon2zI3fXy0YbLfEHfsRoNkMxx8b95jVnCSJ66VDPGgyUgwuoyvVUVGy5EiD77
         LzgH+FXmGiVgn2XL5NHOobOArtpBJxhE1DZTdhs0pkPfCZdoduy0xo4Y9KBXVNGvryy4
         3So605cBhLDZ12w6OoU0VlNMTkDO3hbDyLVDs1cqqi37fDA4ddnFnqwCA0F4RlDYgqGb
         ML3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=50fAx/z8BiiJgV6xcMm5m+rS8cm1yPJaVkfUXd/vHrY=;
        b=mhV7+ydR0cvb2i/0soXUr5mU5UucjjGikEGfX4J8OIAWIMdZ8mE4PJ9aw3+XqaG+p5
         GlC/ZaJ28f511DHE+zy2ZxqfVsIEpcZU8NpSCuYvFdHQ3DN+aiEiXpDZmW0fPvfdfvdr
         yB+TIVcLrBI+vxgpRvjUgk6mQJKHo0q9MQLeI3Q68jqL8232+fqvYtmy2ozpFZAZqAfH
         mh/qBVH23KEB4w9fcekfd1HrpiN3TUuj/Ekwa2OfyNWiHnTsOBsXsB/NF8zyiPGrVS40
         ayztT4aTYf6RLhlNWK1TSxk7cnLaRHBBJYDQXiLnHGZErWmw8lYECOI/I43VQm9D5KDt
         f2TQ==
X-Gm-Message-State: AGi0PuYjd9fy+ZPyIbFsw3sBSCzIsA/igaieOU2lHarKOR3oiREqLgac
        /cFqqluWNVI3L1wiWqtI9BHJrg==
X-Google-Smtp-Source: APiQypIQsqLxvMn1MwX2Fn7J9vSD8JLu14U+IgjPWfcW4RGsj9SifE+mxJ0dgoyNFUoK3kaqKtwvgA==
X-Received: by 2002:a62:6141:: with SMTP id v62mr4399117pfb.41.1585753573191;
        Wed, 01 Apr 2020 08:06:13 -0700 (PDT)
Received: from localhost ([45.127.45.126])
        by smtp.gmail.com with ESMTPSA id h11sm1786432pfq.56.2020.04.01.08.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 08:06:03 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lukasz.luba@arm.com, daniel.lezcano@linaro.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Talel Shenhar <talel@amazon.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] dt-bindings: thermal: Get rid of thermal.txt and replace references
Date:   Wed,  1 Apr 2020 20:35:50 +0530
Message-Id: <cbd70c2f0f5ddae0d8e418fcb1e03101e408f6c2.1585753313.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that we have yaml bindings for the thermal subsystem, get rid of the
old bindings (thermal.txt).

Replace all references to thermal.txt in the Documentation with a link
to the appropriate YAML bindings using the following search and replace
pattern:
 - If the reference is specific to the thermal-sensor-cells property,
 replace with a pointer to thermal-sensor.yaml
 - If the reference is to the cooling-cells property, replace with a
 pointer to thermal-cooling-devices.yaml
 - If the reference is generic thermal bindings, replace with a
 reference to thermal*.yaml.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 .../devicetree/bindings/arm/arm,scmi.txt      |   2 +-
 .../devicetree/bindings/arm/arm,scpi.txt      |   2 +-
 .../arm/marvell/ap80x-system-controller.txt   |   2 +-
 .../arm/marvell/cp110-system-controller.txt   |   2 +-
 .../bindings/cpufreq/cpufreq-dt.txt           |   3 +-
 .../bindings/cpufreq/cpufreq-mediatek.txt     |   4 +-
 .../devicetree/bindings/hwmon/gpio-fan.txt    |   3 +-
 .../devicetree/bindings/hwmon/lm90.txt        |   4 +-
 .../thermal/allwinner,sun8i-a83t-ths.yaml     |   2 +-
 .../bindings/thermal/amazon,al-thermal.txt    |   2 +-
 .../bindings/thermal/brcm,avs-ro-thermal.yaml |   2 +-
 .../bindings/thermal/brcm,bcm2835-thermal.txt |   2 +-
 .../bindings/thermal/hisilicon-thermal.txt    |   2 +-
 .../bindings/thermal/max77620_thermal.txt     |   6 +-
 .../bindings/thermal/mediatek-thermal.txt     |   2 +-
 .../thermal/nvidia,tegra124-soctherm.txt      |  10 +-
 .../thermal/nvidia,tegra186-bpmp-thermal.txt  |   2 +-
 .../bindings/thermal/qcom-spmi-temp-alarm.txt |   2 +-
 .../bindings/thermal/rockchip-thermal.txt     |   2 +-
 .../bindings/thermal/tango-thermal.txt        |   2 +-
 .../bindings/thermal/thermal-generic-adc.txt  |   2 +-
 .../devicetree/bindings/thermal/thermal.txt   | 586 ------------------
 .../bindings/thermal/uniphier-thermal.txt     |   2 +-
 23 files changed, 33 insertions(+), 615 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/thermal.txt

diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
index dc102c4e4a78b..5b488386dcdd8 100644
--- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
@@ -101,7 +101,7 @@ Required sub-node properties:
 [0] http://infocenter.arm.com/help/topic/com.arm.doc.den0056a/index.html
 [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
 [2] Documentation/devicetree/bindings/power/power-domain.yaml
-[3] Documentation/devicetree/bindings/thermal/thermal.txt
+[3] Documentation/devicetree/bindings/thermal/thermal*.yaml
 [4] Documentation/devicetree/bindings/sram/sram.yaml
 [5] Documentation/devicetree/bindings/reset/reset.txt
 
diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
index dd04d9d9a1b8e..bcd6c3ec471e6 100644
--- a/Documentation/devicetree/bindings/arm/arm,scpi.txt
+++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
@@ -108,7 +108,7 @@ Required properties:
 
 [0] http://infocenter.arm.com/help/topic/com.arm.doc.dui0922b/index.html
 [1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] Documentation/devicetree/bindings/thermal/thermal.txt
+[2] Documentation/devicetree/bindings/thermal/thermal*.yaml
 [3] Documentation/devicetree/bindings/sram/sram.yaml
 [4] Documentation/devicetree/bindings/power/power-domain.yaml
 
diff --git a/Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt
index 098d932fc9630..e31511255d8e3 100644
--- a/Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt
@@ -111,7 +111,7 @@ Thermal:
 --------
 
 For common binding part and usage, refer to
-Documentation/devicetree/bindings/thermal/thermal.txt
+Documentation/devicetree/bindings/thermal/thermal*.yaml
 
 The thermal IP can probe the temperature all around the processor. It
 may feature several channels, each of them wired to one sensor.
diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
index f982a8ed93968..a21f7709596c0 100644
--- a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
@@ -203,7 +203,7 @@ It is possible to setup an overheat interrupt by giving at least one
 critical point to any subnode of the thermal-zone node.
 
 For common binding part and usage, refer to
-Documentation/devicetree/bindings/thermal/thermal.txt
+Documentation/devicetree/bindings/thermal/thermal*.yaml
 
 Required properties:
 - compatible: must be one of:
diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
index 332aed8f4597a..56f4423743838 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
@@ -18,7 +18,8 @@ Optional properties:
   in unit of nanoseconds.
 - voltage-tolerance: Specify the CPU voltage tolerance in percentage.
 - #cooling-cells:
-     Please refer to Documentation/devicetree/bindings/thermal/thermal.txt.
+     Please refer to
+     Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml.
 
 Examples:
 
diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
index 0551c78619de8..ea4994b35207d 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
@@ -21,8 +21,8 @@ Optional properties:
 	       flow is handled by hardware, hence no software "voltage tracking" is
 	       needed.
 - #cooling-cells:
-	Please refer to Documentation/devicetree/bindings/thermal/thermal.txt
-	for detail.
+	For details, please refer to
+	Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
 
 Example 1 (MT7623 SoC):
 
diff --git a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt b/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
index 2becdcfdc840c..f4cfa350f6a14 100644
--- a/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
+++ b/Documentation/devicetree/bindings/hwmon/gpio-fan.txt
@@ -12,7 +12,8 @@ Optional properties:
 - alarm-gpios: This pin going active indicates something is wrong with
   the fan, and a udev event will be fired.
 - #cooling-cells: If used as a cooling device, must be <2>
-  Also see: Documentation/devicetree/bindings/thermal/thermal.txt
+  Also see:
+  Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
   min and max states are derived from the speed-map of the fan.
 
 Note: At least one the "gpios" or "alarm-gpios" properties must be set.
diff --git a/Documentation/devicetree/bindings/hwmon/lm90.txt b/Documentation/devicetree/bindings/hwmon/lm90.txt
index c76a7ac47c342..398dcb9657514 100644
--- a/Documentation/devicetree/bindings/hwmon/lm90.txt
+++ b/Documentation/devicetree/bindings/hwmon/lm90.txt
@@ -34,8 +34,8 @@ Optional properties:
               LM90 "-ALERT" pin output.
               See interrupt-controller/interrupts.txt for the format.
 
-- #thermal-sensor-cells: should be set to 1. See thermal/thermal.txt for
-	      details. See <include/dt-bindings/thermal/lm90.h> for the
+- #thermal-sensor-cells: should be set to 1. See thermal/thermal-sensor.yaml
+	      for details. See <include/dt-bindings/thermal/lm90.h> for the
 	      definition of the local, remote and 2nd remote sensor index
 	      constants.
 
diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
index 87369264feb96..44ba6765697d8 100644
--- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
+++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
@@ -50,7 +50,7 @@ properties:
   nvmem-cell-names:
     const: calibration
 
-  # See ./thermal.txt for details
+  # See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for details
   "#thermal-sensor-cells":
     enum:
       - 0
diff --git a/Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt b/Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
index 703979dbd577d..12fc4ef04837f 100644
--- a/Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
@@ -6,7 +6,7 @@ transaction.
 Required properties:
 - compatible: "amazon,al-thermal".
 - reg: The physical base address and length of the sensor's registers.
-- #thermal-sensor-cells: Must be 1. See ./thermal.txt for a description.
+- #thermal-sensor-cells: Must be 1. See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for a description.
 
 Example:
 	thermal: thermal {
diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
index f3e68ed03abf8..1ab5070c751d5 100644
--- a/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
@@ -23,7 +23,7 @@ properties:
   compatible:
     const: brcm,bcm2711-thermal
 
-  # See ./thermal.txt for details
+  # See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for details
   "#thermal-sensor-cells":
     const: 0
 
diff --git a/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
index da8c5b73ad105..a3e9ec5dc7ac4 100644
--- a/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
@@ -7,7 +7,7 @@ compatible: 		should be one of: "brcm,bcm2835-thermal",
 			"brcm,bcm2836-thermal" or "brcm,bcm2837-thermal"
 reg:			Address range of the thermal registers.
 clocks: 		Phandle of the clock used by the thermal sensor.
-#thermal-sensor-cells:	should be 0 (see thermal.txt)
+#thermal-sensor-cells:	should be 0 (see Documentation/devicetree/bindings/thermal/thermal-sensor.yaml)
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
index cef716a236f1a..4b19d80e6558b 100644
--- a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
@@ -9,7 +9,7 @@
   by /SOCTHERM/tsensor.
 - clock-names: Input clock name, should be 'thermal_clk'.
 - clocks: phandles for clock specified in "clock-names" property.
-- #thermal-sensor-cells: Should be 1. See ./thermal.txt for a description.
+- #thermal-sensor-cells: Should be 1. See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for a description.
 
 Example :
 
diff --git a/Documentation/devicetree/bindings/thermal/max77620_thermal.txt b/Documentation/devicetree/bindings/thermal/max77620_thermal.txt
index 323a3b3822aac..82ed5d4879666 100644
--- a/Documentation/devicetree/bindings/thermal/max77620_thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/max77620_thermal.txt
@@ -8,12 +8,12 @@ below threshold level.
 
 Required properties:
 -------------------
-#thermal-sensor-cells:	Please refer <devicetree/bindings/thermal/thermal.txt>
-			for more details.
+#thermal-sensor-cells:	For more details, please refer to
+			<devicetree/bindings/thermal/thermal-sensor.yaml>
 			The value must be 0.
 
 For more details, please refer generic thermal DT binding document
-<devicetree/bindings/thermal/thermal.txt>.
+<devicetree/bindings/thermal/thermal*.yaml>.
 
 Please refer <devicetree/bindings/mfd/max77620.txt> for mfd DT binding
 document for the MAX77620.
diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
index f8d7831f39740..1e249c42fae04 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
@@ -23,7 +23,7 @@ Required properties:
 - resets: Reference to the reset controller controlling the thermal controller.
 - mediatek,auxadc: A phandle to the AUXADC which the thermal controller uses
 - mediatek,apmixedsys: A phandle to the APMIXEDSYS controller.
-- #thermal-sensor-cells : Should be 0. See ./thermal.txt for a description.
+- #thermal-sensor-cells : Should be 0. See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for a description.
 
 Optional properties:
 - nvmem-cells: A phandle to the calibration data provided by a nvmem device. If
diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
index f02f38527a6b6..db880e7ed713e 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
@@ -28,9 +28,10 @@ Required properties :
   See ../reset/reset.txt for details.
 - reset-names : Must include the following entries:
   - soctherm
-- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description
-    of this property. See <dt-bindings/thermal/tegra124-soctherm.h> for a
-    list of valid values when referring to thermal sensors.
+- #thermal-sensor-cells : Should be 1. For a description of this property, see
+     Documentation/devicetree/bindings/thermal/thermal-sensor.yaml.
+    See <dt-bindings/thermal/tegra124-soctherm.h> for a list of valid values
+    when referring to thermal sensors.
 - throttle-cfgs: A sub-node which is a container of configuration for each
     hardware throttle events. These events can be set as cooling devices.
   * throttle events: Sub-nodes must be named as "light" or "heavy".
@@ -62,7 +63,8 @@ Required properties :
         TEGRA_SOCTHERM_THROT_LEVEL_MED (75%),
         TEGRA_SOCTHERM_THROT_LEVEL_HIGH (85%).
       - #cooling-cells: Should be 1. This cooling device only support on/off state.
-        See ./thermal.txt for a description of this property.
+        For a description of this property see:
+	Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
 
       Optional properties: The following properties are T210 specific and
       valid only for OCx throttle events.
diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt
index e17c07be270b7..fc87f6aa1b8f5 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt
@@ -8,7 +8,7 @@ exposed by BPMP.
 The BPMP thermal node must be located directly inside the main BPMP node. See
 ../firmware/nvidia,tegra186-bpmp.txt for details of the BPMP binding.
 
-This node represents a thermal sensor. See thermal.txt for details of the
+This node represents a thermal sensor. See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for details of the
 core thermal binding.
 
 Required properties:
diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
index 0273a92a2a849..2d5b2ad03314b 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
@@ -8,7 +8,7 @@ Required properties:
 - compatible:      Should contain "qcom,spmi-temp-alarm".
 - reg:             Specifies the SPMI address.
 - interrupts:      PMIC temperature alarm interrupt.
-- #thermal-sensor-cells: Should be 0. See thermal.txt for a description.
+- #thermal-sensor-cells: Should be 0. See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for a description.
 
 Optional properties:
 - io-channels:     Should contain IIO channel specifier for the ADC channel,
diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
index c6aac9bcacf1c..7f94669e9ebef 100644
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
@@ -24,7 +24,7 @@ Required properties:
 - pinctrl-1 : The "default" pinctrl state, it will be set after reset the
 	      TSADC controller.
 - pinctrl-2 : The "sleep" pinctrl state, it will be in for suspend.
-- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description.
+- #thermal-sensor-cells : Should be 1. See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for a description.
 
 Optional properties:
 - rockchip,hw-tshut-temp : The hardware-controlled shutdown temperature value.
diff --git a/Documentation/devicetree/bindings/thermal/tango-thermal.txt b/Documentation/devicetree/bindings/thermal/tango-thermal.txt
index 212198d4b9379..2c918d742867a 100644
--- a/Documentation/devicetree/bindings/thermal/tango-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/tango-thermal.txt
@@ -4,7 +4,7 @@ The SMP8758 SoC includes 3 instances of this temperature sensor
 (in the CPU, video decoder, and PCIe controller).
 
 Required properties:
-- #thermal-sensor-cells: Should be 0 (see thermal.txt)
+- #thermal-sensor-cells: Should be 0 (see Documentation/devicetree/bindings/thermal/thermal-sensor.yaml)
 - compatible: "sigma,smp8758-thermal"
 - reg: Address range of the thermal registers
 
diff --git a/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt b/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt
index 691a09db2fefc..e136946a2f4fd 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt
@@ -8,7 +8,7 @@ temperature using voltage-temperature lookup table.
 Required properties:
 ===================
 - compatible:		     Must be "generic-adc-thermal".
-- #thermal-sensor-cells:     Should be 1. See ./thermal.txt for a description
+- #thermal-sensor-cells:     Should be 1. See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for a description
 		             of this property.
 Optional properties:
 ===================
diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
deleted file mode 100644
index ca14ba959e0d0..0000000000000
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ /dev/null
@@ -1,586 +0,0 @@
-* Thermal Framework Device Tree descriptor
-
-This file describes a generic binding to provide a way of
-defining hardware thermal structure using device tree.
-A thermal structure includes thermal zones and their components,
-such as trip points, polling intervals, sensors and cooling devices
-binding descriptors.
-
-The target of device tree thermal descriptors is to describe only
-the hardware thermal aspects. The thermal device tree bindings are
-not about how the system must control or which algorithm or policy
-must be taken in place.
-
-There are five types of nodes involved to describe thermal bindings:
-- thermal sensors: devices which may be used to take temperature
-  measurements.
-- cooling devices: devices which may be used to dissipate heat.
-- trip points: describe key temperatures at which cooling is recommended. The
-  set of points should be chosen based on hardware limits.
-- cooling maps: used to describe links between trip points and cooling devices;
-- thermal zones: used to describe thermal data within the hardware;
-
-The following is a description of each of these node types.
-
-* Thermal sensor devices
-
-Thermal sensor devices are nodes providing temperature sensing capabilities on
-thermal zones. Typical devices are I2C ADC converters and bandgaps. These are
-nodes providing temperature data to thermal zones. Thermal sensor devices may
-control one or more internal sensors.
-
-Required property:
-- #thermal-sensor-cells: Used to provide sensor device specific information
-  Type: unsigned	 while referring to it. Typically 0 on thermal sensor
-  Size: one cell	 nodes with only one sensor, and at least 1 on nodes
-			 with several internal sensors, in order
-			 to identify uniquely the sensor instances within
-			 the IC. See thermal zone binding for more details
-			 on how consumers refer to sensor devices.
-
-* Cooling device nodes
-
-Cooling devices are nodes providing control on power dissipation. There
-are essentially two ways to provide control on power dissipation. First
-is by means of regulating device performance, which is known as passive
-cooling. A typical passive cooling is a CPU that has dynamic voltage and
-frequency scaling (DVFS), and uses lower frequencies as cooling states.
-Second is by means of activating devices in order to remove
-the dissipated heat, which is known as active cooling, e.g. regulating
-fan speeds. In both cases, cooling devices shall have a way to determine
-the state of cooling in which the device is.
-
-Any cooling device has a range of cooling states (i.e. different levels
-of heat dissipation). For example a fan's cooling states correspond to
-the different fan speeds possible. Cooling states are referred to by
-single unsigned integers, where larger numbers mean greater heat
-dissipation. The precise set of cooling states associated with a device
-should be defined in a particular device's binding.
-For more examples of cooling devices, refer to the example sections below.
-
-Required properties:
-- #cooling-cells:	Used to provide cooling device specific information
-  Type: unsigned	while referring to it. Must be at least 2, in order
-  Size: one cell	to specify minimum and maximum cooling state used
-			in the reference. The first cell is the minimum
-			cooling state requested and the second cell is
-			the maximum cooling state requested in the reference.
-			See Cooling device maps section below for more details
-			on how consumers refer to cooling devices.
-
-* Trip points
-
-The trip node is a node to describe a point in the temperature domain
-in which the system takes an action. This node describes just the point,
-not the action.
-
-Required properties:
-- temperature:		An integer indicating the trip temperature level,
-  Type: signed		in millicelsius.
-  Size: one cell
-
-- hysteresis:		A low hysteresis value on temperature property (above).
-  Type: unsigned	This is a relative value, in millicelsius.
-  Size: one cell
-
-- type:			a string containing the trip type. Expected values are:
-	"active":	A trip point to enable active cooling
-	"passive":	A trip point to enable passive cooling
-	"hot":		A trip point to notify emergency
-	"critical":	Hardware not reliable.
-  Type: string
-
-* Cooling device maps
-
-The cooling device maps node is a node to describe how cooling devices
-get assigned to trip points of the zone. The cooling devices are expected
-to be loaded in the target system.
-
-Required properties:
-- cooling-device:	A list of phandles of cooling devices with their specifiers,
-  Type: phandle +	referring to which cooling devices are used in this
-    cooling specifier	binding. In the cooling specifier, the first cell
-			is the minimum cooling state and the second cell
-			is the maximum cooling state used in this map.
-- trip:			A phandle of a trip point node within the same thermal
-  Type: phandle of	zone.
-   trip point node
-
-Optional property:
-- contribution:		The cooling contribution to the thermal zone of the
-  Type: unsigned	referred cooling device at the referred trip point.
-  Size: one cell	The contribution is a ratio of the sum
-			of all cooling contributions within a thermal zone.
-
-Note: Using the THERMAL_NO_LIMIT (-1UL) constant in the cooling-device phandle
-limit specifier means:
-(i)   - minimum state allowed for minimum cooling state used in the reference.
-(ii)  - maximum state allowed for maximum cooling state used in the reference.
-Refer to include/dt-bindings/thermal/thermal.h for definition of this constant.
-
-* Thermal zone nodes
-
-The thermal zone node is the node containing all the required info
-for describing a thermal zone, including its cooling device bindings. The
-thermal zone node must contain, apart from its own properties, one sub-node
-containing trip nodes and one sub-node containing all the zone cooling maps.
-
-Required properties:
-- polling-delay:	The maximum number of milliseconds to wait between polls
-  Type: unsigned	when checking this thermal zone.
-  Size: one cell
-
-- polling-delay-passive: The maximum number of milliseconds to wait
-  Type: unsigned	between polls when performing passive cooling.
-  Size: one cell
-
-- thermal-sensors:	A list of thermal sensor phandles and sensor specifier
-  Type: list of		used while monitoring the thermal zone.
-  phandles + sensor
-  specifier
-
-- trips:		A sub-node which is a container of only trip point nodes
-  Type: sub-node	required to describe the thermal zone.
-
-- cooling-maps:		A sub-node which is a container of only cooling device
-  Type: sub-node	map nodes, used to describe the relation between trips
-			and cooling devices.
-
-Optional property:
-- coefficients:		An array of integers (one signed cell) containing
-  Type: array		coefficients to compose a linear relation between
-  Elem size: one cell	the sensors listed in the thermal-sensors property.
-  Elem type: signed	Coefficients defaults to 1, in case this property
-			is not specified. A simple linear polynomial is used:
-			Z = c0 * x0 + c1 * x1 + ... + c(n-1) * x(n-1) + cn.
-
-			The coefficients are ordered and they match with sensors
-			by means of sensor ID. Additional coefficients are
-			interpreted as constant offset.
-
-- sustainable-power:	An estimate of the sustainable power (in mW) that the
-  Type: unsigned	thermal zone can dissipate at the desired
-  Size: one cell	control temperature.  For reference, the
-			sustainable power of a 4'' phone is typically
-			2000mW, while on a 10'' tablet is around
-			4500mW.
-
-Note: The delay properties are bound to the maximum dT/dt (temperature
-derivative over time) in two situations for a thermal zone:
-(i)  - when passive cooling is activated (polling-delay-passive); and
-(ii) - when the zone just needs to be monitored (polling-delay) or
-when active cooling is activated.
-
-The maximum dT/dt is highly bound to hardware power consumption and dissipation
-capability. The delays should be chosen to account for said max dT/dt,
-such that a device does not cross several trip boundaries unexpectedly
-between polls. Choosing the right polling delays shall avoid having the
-device in temperature ranges that may damage the silicon structures and
-reduce silicon lifetime.
-
-* The thermal-zones node
-
-The "thermal-zones" node is a container for all thermal zone nodes. It shall
-contain only sub-nodes describing thermal zones as in the section
-"Thermal zone nodes". The "thermal-zones" node appears under "/".
-
-* Examples
-
-Below are several examples on how to use thermal data descriptors
-using device tree bindings:
-
-(a) - CPU thermal zone
-
-The CPU thermal zone example below describes how to setup one thermal zone
-using one single sensor as temperature source and many cooling devices and
-power dissipation control sources.
-
-#include <dt-bindings/thermal/thermal.h>
-
-cpus {
-	/*
-	 * Here is an example of describing a cooling device for a DVFS
-	 * capable CPU. The CPU node describes its four OPPs.
-	 * The cooling states possible are 0..3, and they are
-	 * used as OPP indexes. The minimum cooling state is 0, which means
-	 * all four OPPs can be available to the system. The maximum
-	 * cooling state is 3, which means only the lowest OPPs (198MHz@0.85V)
-	 * can be available in the system.
-	 */
-	cpu0: cpu@0 {
-		...
-		operating-points = <
-			/* kHz    uV */
-			970000  1200000
-			792000  1100000
-			396000  950000
-			198000  850000
-		>;
-		#cooling-cells = <2>; /* min followed by max */
-	};
-	...
-};
-
-&i2c1 {
-	...
-	/*
-	 * A simple fan controller which supports 10 speeds of operation
-	 * (represented as 0-9).
-	 */
-	fan0: fan@48 {
-		...
-		#cooling-cells = <2>; /* min followed by max */
-	};
-};
-
-ocp {
-	...
-	/*
-	 * A simple IC with a single bandgap temperature sensor.
-	 */
-	bandgap0: bandgap@0000ed00 {
-		...
-		#thermal-sensor-cells = <0>;
-	};
-};
-
-thermal-zones {
-	cpu_thermal: cpu-thermal {
-		polling-delay-passive = <250>; /* milliseconds */
-		polling-delay = <1000>; /* milliseconds */
-
-		thermal-sensors = <&bandgap0>;
-
-		trips {
-			cpu_alert0: cpu-alert0 {
-				temperature = <90000>; /* millicelsius */
-				hysteresis = <2000>; /* millicelsius */
-				type = "active";
-			};
-			cpu_alert1: cpu-alert1 {
-				temperature = <100000>; /* millicelsius */
-				hysteresis = <2000>; /* millicelsius */
-				type = "passive";
-			};
-			cpu_crit: cpu-crit {
-				temperature = <125000>; /* millicelsius */
-				hysteresis = <2000>; /* millicelsius */
-				type = "critical";
-			};
-		};
-
-		cooling-maps {
-			map0 {
-				trip = <&cpu_alert0>;
-				cooling-device = <&fan0 THERMAL_NO_LIMIT 4>;
-			};
-			map1 {
-				trip = <&cpu_alert1>;
-				cooling-device = <&fan0 5 THERMAL_NO_LIMIT>, <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-			};
-		};
-	};
-};
-
-In the example above, the ADC sensor (bandgap0) at address 0x0000ED00 is
-used to monitor the zone 'cpu-thermal' using its sole sensor. A fan
-device (fan0) is controlled via I2C bus 1, at address 0x48, and has ten
-different cooling states 0-9. It is used to remove the heat out of
-the thermal zone 'cpu-thermal' using its cooling states
-from its minimum to 4, when it reaches trip point 'cpu_alert0'
-at 90C, as an example of active cooling. The same cooling device is used at
-'cpu_alert1', but from 5 to its maximum state. The cpu@0 device is also
-linked to the same thermal zone, 'cpu-thermal', as a passive cooling device,
-using all its cooling states at trip point 'cpu_alert1',
-which is a trip point at 100C. On the thermal zone 'cpu-thermal', at the
-temperature of 125C, represented by the trip point 'cpu_crit', the silicon
-is not reliable anymore.
-
-(b) - IC with several internal sensors
-
-The example below describes how to deploy several thermal zones based off a
-single sensor IC, assuming it has several internal sensors. This is a common
-case on SoC designs with several internal IPs that may need different thermal
-requirements, and thus may have their own sensor to monitor or detect internal
-hotspots in their silicon.
-
-#include <dt-bindings/thermal/thermal.h>
-
-ocp {
-	...
-	/*
-	 * A simple IC with several bandgap temperature sensors.
-	 */
-	bandgap0: bandgap@0000ed00 {
-		...
-		#thermal-sensor-cells = <1>;
-	};
-};
-
-thermal-zones {
-	cpu_thermal: cpu-thermal {
-		polling-delay-passive = <250>; /* milliseconds */
-		polling-delay = <1000>; /* milliseconds */
-
-				/* sensor       ID */
-		thermal-sensors = <&bandgap0     0>;
-
-		trips {
-			/* each zone within the SoC may have its own trips */
-			cpu_alert: cpu-alert {
-				temperature = <100000>; /* millicelsius */
-				hysteresis = <2000>; /* millicelsius */
-				type = "passive";
-			};
-			cpu_crit: cpu-crit {
-				temperature = <125000>; /* millicelsius */
-				hysteresis = <2000>; /* millicelsius */
-				type = "critical";
-			};
-		};
-
-		cooling-maps {
-			/* each zone within the SoC may have its own cooling */
-			...
-		};
-	};
-
-	gpu_thermal: gpu-thermal {
-		polling-delay-passive = <120>; /* milliseconds */
-		polling-delay = <1000>; /* milliseconds */
-
-				/* sensor       ID */
-		thermal-sensors = <&bandgap0     1>;
-
-		trips {
-			/* each zone within the SoC may have its own trips */
-			gpu_alert: gpu-alert {
-				temperature = <90000>; /* millicelsius */
-				hysteresis = <2000>; /* millicelsius */
-				type = "passive";
-			};
-			gpu_crit: gpu-crit {
-				temperature = <105000>; /* millicelsius */
-				hysteresis = <2000>; /* millicelsius */
-				type = "critical";
-			};
-		};
-
-		cooling-maps {
-			/* each zone within the SoC may have its own cooling */
-			...
-		};
-	};
-
-	dsp_thermal: dsp-thermal {
-		polling-delay-passive = <50>; /* milliseconds */
-		polling-delay = <1000>; /* milliseconds */
-
-				/* sensor       ID */
-		thermal-sensors = <&bandgap0     2>;
-
-		trips {
-			/* each zone within the SoC may have its own trips */
-			dsp_alert: dsp-alert {
-				temperature = <90000>; /* millicelsius */
-				hysteresis = <2000>; /* millicelsius */
-				type = "passive";
-			};
-			dsp_crit: gpu-crit {
-				temperature = <135000>; /* millicelsius */
-				hysteresis = <2000>; /* millicelsius */
-				type = "critical";
-			};
-		};
-
-		cooling-maps {
-			/* each zone within the SoC may have its own cooling */
-			...
-		};
-	};
-};
-
-In the example above, there is one bandgap IC which has the capability to
-monitor three sensors. The hardware has been designed so that sensors are
-placed on different places in the DIE to monitor different temperature
-hotspots: one for CPU thermal zone, one for GPU thermal zone and the
-other to monitor a DSP thermal zone.
-
-Thus, there is a need to assign each sensor provided by the bandgap IC
-to different thermal zones. This is achieved by means of using the
-#thermal-sensor-cells property and using the first cell of the sensor
-specifier as sensor ID. In the example, then, <bandgap 0> is used to
-monitor CPU thermal zone, <bandgap 1> is used to monitor GPU thermal
-zone and <bandgap 2> is used to monitor DSP thermal zone. Each zone
-may be uncorrelated, having its own dT/dt requirements, trips
-and cooling maps.
-
-
-(c) - Several sensors within one single thermal zone
-
-The example below illustrates how to use more than one sensor within
-one thermal zone.
-
-#include <dt-bindings/thermal/thermal.h>
-
-&i2c1 {
-	...
-	/*
-	 * A simple IC with a single temperature sensor.
-	 */
-	adc: sensor@49 {
-		...
-		#thermal-sensor-cells = <0>;
-	};
-};
-
-ocp {
-	...
-	/*
-	 * A simple IC with a single bandgap temperature sensor.
-	 */
-	bandgap0: bandgap@0000ed00 {
-		...
-		#thermal-sensor-cells = <0>;
-	};
-};
-
-thermal-zones {
-	cpu_thermal: cpu-thermal {
-		polling-delay-passive = <250>; /* milliseconds */
-		polling-delay = <1000>; /* milliseconds */
-
-		thermal-sensors = <&bandgap0>,	/* cpu */
-				  <&adc>;	/* pcb north */
-
-		/* hotspot = 100 * bandgap - 120 * adc + 484 */
-		coefficients =		<100	-120	484>;
-
-		trips {
-			...
-		};
-
-		cooling-maps {
-			...
-		};
-	};
-};
-
-In some cases, there is a need to use more than one sensor to extrapolate
-a thermal hotspot in the silicon. The above example illustrates this situation.
-For instance, it may be the case that a sensor external to CPU IP may be placed
-close to CPU hotspot and together with internal CPU sensor, it is used
-to determine the hotspot. Assuming this is the case for the above example,
-the hypothetical extrapolation rule would be:
-		hotspot = 100 * bandgap - 120 * adc + 484
-
-In other context, the same idea can be used to add fixed offset. For instance,
-consider the hotspot extrapolation rule below:
-		hotspot = 1 * adc + 6000
-
-In the above equation, the hotspot is always 6C higher than what is read
-from the ADC sensor. The binding would be then:
-        thermal-sensors =  <&adc>;
-
-		/* hotspot = 1 * adc + 6000 */
-	coefficients =		<1	6000>;
-
-(d) - Board thermal
-
-The board thermal example below illustrates how to setup one thermal zone
-with many sensors and many cooling devices.
-
-#include <dt-bindings/thermal/thermal.h>
-
-&i2c1 {
-	...
-	/*
-	 * An IC with several temperature sensor.
-	 */
-	adc_dummy: sensor@50 {
-		...
-		#thermal-sensor-cells = <1>; /* sensor internal ID */
-	};
-};
-
-thermal-zones {
-	batt-thermal {
-		polling-delay-passive = <500>; /* milliseconds */
-		polling-delay = <2500>; /* milliseconds */
-
-				/* sensor       ID */
-		thermal-sensors = <&adc_dummy     4>;
-
-		trips {
-			...
-		};
-
-		cooling-maps {
-			...
-		};
-	};
-
-	board_thermal: board-thermal {
-		polling-delay-passive = <1000>; /* milliseconds */
-		polling-delay = <2500>; /* milliseconds */
-
-				/* sensor       ID */
-		thermal-sensors = <&adc_dummy     0>, /* pcb top edge */
-				  <&adc_dummy     1>, /* lcd */
-				  <&adc_dummy     2>; /* back cover */
-		/*
-		 * An array of coefficients describing the sensor
-		 * linear relation. E.g.:
-		 * z = c1*x1 + c2*x2 + c3*x3
-		 */
-		coefficients =		<1200	-345	890>;
-
-		sustainable-power = <2500>;
-
-		trips {
-			/* Trips are based on resulting linear equation */
-			cpu_trip: cpu-trip {
-				temperature = <60000>; /* millicelsius */
-				hysteresis = <2000>; /* millicelsius */
-				type = "passive";
-			};
-			gpu_trip: gpu-trip {
-				temperature = <55000>; /* millicelsius */
-				hysteresis = <2000>; /* millicelsius */
-				type = "passive";
-			}
-			lcd_trip: lcp-trip {
-				temperature = <53000>; /* millicelsius */
-				hysteresis = <2000>; /* millicelsius */
-				type = "passive";
-			};
-			crit_trip: crit-trip {
-				temperature = <68000>; /* millicelsius */
-				hysteresis = <2000>; /* millicelsius */
-				type = "critical";
-			};
-		};
-
-		cooling-maps {
-			map0 {
-				trip = <&cpu_trip>;
-				cooling-device = <&cpu0 0 2>;
-				contribution = <55>;
-			};
-			map1 {
-				trip = <&gpu_trip>;
-				cooling-device = <&gpu0 0 2>;
-				contribution = <20>;
-			};
-			map2 {
-				trip = <&lcd_trip>;
-				cooling-device = <&lcd0 5 10>;
-				contribution = <15>;
-			};
-		};
-	};
-};
-
-The above example is a mix of previous examples, a sensor IP with several internal
-sensors used to monitor different zones, one of them is composed by several sensors and
-with different cooling devices.
diff --git a/Documentation/devicetree/bindings/thermal/uniphier-thermal.txt b/Documentation/devicetree/bindings/thermal/uniphier-thermal.txt
index ceb92a95727a8..68c4e1d564f38 100644
--- a/Documentation/devicetree/bindings/thermal/uniphier-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/uniphier-thermal.txt
@@ -10,7 +10,7 @@ Required properties:
   - "socionext,uniphier-ld20-thermal" : For UniPhier LD20 SoC
   - "socionext,uniphier-pxs3-thermal" : For UniPhier PXs3 SoC
 - interrupts : IRQ for the temperature alarm
-- #thermal-sensor-cells : Should be 0. See ./thermal.txt for details.
+- #thermal-sensor-cells : Should be 0. See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for details.
 
 Optional properties:
 - socionext,tmod-calibration: A pair of calibrated values referred from PVT,
-- 
2.20.1

