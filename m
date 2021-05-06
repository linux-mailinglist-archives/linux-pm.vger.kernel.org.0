Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067D63759C1
	for <lists+linux-pm@lfdr.de>; Thu,  6 May 2021 19:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbhEFR4q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 May 2021 13:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbhEFR4p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 May 2021 13:56:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFB2C061761;
        Thu,  6 May 2021 10:55:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id E6D081F43B82
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Kever Yang <kever.yang@rock-chips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com
Subject: [PATCH v2 2/4] dt-bindings: thermal: convert rockchip-thermal to json-schema
Date:   Thu,  6 May 2021 14:55:12 -0300
Message-Id: <20210506175514.168365-3-ezequiel@collabora.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210506175514.168365-1-ezequiel@collabora.com>
References: <20210506175514.168365-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert Rockchip Thermal sensor dt-bindings to YAML.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 .../bindings/thermal/rockchip-thermal.txt     | 85 -----------------
 .../bindings/thermal/rockchip-thermal.yaml    | 95 +++++++++++++++++++
 2 files changed, 95 insertions(+), 85 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
deleted file mode 100644
index 7f94669e9ebe..000000000000
--- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
+++ /dev/null
@@ -1,85 +0,0 @@
-* Temperature Sensor ADC (TSADC) on rockchip SoCs
-
-Required properties:
-- compatible : should be "rockchip,<name>-tsadc"
-   "rockchip,px30-tsadc":   found on PX30 SoCs
-   "rockchip,rv1108-tsadc": found on RV1108 SoCs
-   "rockchip,rk3228-tsadc": found on RK3228 SoCs
-   "rockchip,rk3288-tsadc": found on RK3288 SoCs
-   "rockchip,rk3328-tsadc": found on RK3328 SoCs
-   "rockchip,rk3368-tsadc": found on RK3368 SoCs
-   "rockchip,rk3399-tsadc": found on RK3399 SoCs
-- reg : physical base address of the controller and length of memory mapped
-	region.
-- interrupts : The interrupt number to the cpu. The interrupt specifier format
-	       depends on the interrupt controller.
-- clocks : Must contain an entry for each entry in clock-names.
-- clock-names : Shall be "tsadc" for the converter-clock, and "apb_pclk" for
-		the peripheral clock.
-- resets : Must contain an entry for each entry in reset-names.
-	   See ../reset/reset.txt for details.
-- reset-names : Must include the name "tsadc-apb".
-- pinctrl-names : The pin control state names;
-- pinctrl-0 : The "init" pinctrl state, it will be set before device probe.
-- pinctrl-1 : The "default" pinctrl state, it will be set after reset the
-	      TSADC controller.
-- pinctrl-2 : The "sleep" pinctrl state, it will be in for suspend.
-- #thermal-sensor-cells : Should be 1. See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for a description.
-
-Optional properties:
-- rockchip,hw-tshut-temp : The hardware-controlled shutdown temperature value.
-- rockchip,hw-tshut-mode : The hardware-controlled shutdown mode 0:CRU 1:GPIO.
-- rockchip,hw-tshut-polarity : The hardware-controlled active polarity 0:LOW
-			       1:HIGH.
-- rockchip,grf : The phandle of the syscon node for the general register file.
-
-Exiample:
-tsadc: tsadc@ff280000 {
-	compatible = "rockchip,rk3288-tsadc";
-	reg = <0xff280000 0x100>;
-	interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
-	clock-names = "tsadc", "apb_pclk";
-	resets = <&cru SRST_TSADC>;
-	reset-names = "tsadc-apb";
-	pinctrl-names = "init", "default", "sleep";
-	pinctrl-0 = <&otp_gpio>;
-	pinctrl-1 = <&otp_out>;
-	pinctrl-2 = <&otp_gpio>;
-	#thermal-sensor-cells = <1>;
-	rockchip,hw-tshut-temp = <95000>;
-	rockchip,hw-tshut-mode = <0>;
-	rockchip,hw-tshut-polarity = <0>;
-};
-
-Example: referring to thermal sensors:
-thermal-zones {
-	cpu_thermal: cpu_thermal {
-		polling-delay-passive = <1000>; /* milliseconds */
-		polling-delay = <5000>; /* milliseconds */
-
-		/* sensor	ID */
-		thermal-sensors = <&tsadc	1>;
-
-		trips {
-			cpu_alert0: cpu_alert {
-				temperature = <70000>; /* millicelsius */
-				hysteresis = <2000>; /* millicelsius */
-				type = "passive";
-			};
-			cpu_crit: cpu_crit {
-				temperature = <90000>; /* millicelsius */
-				hysteresis = <2000>; /* millicelsius */
-				type = "critical";
-			};
-		};
-
-		cooling-maps {
-			map0 {
-				trip = <&cpu_alert0>;
-				cooling-device =
-				    <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
-			};
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
new file mode 100644
index 000000000000..8385e8ac03e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/rockchip-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Temperature Sensor ADC (TSADC) on Rockchip SoCs
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    enum:
+      - rockchip,px30-tsadc # PX30 SoCs
+      - rockchip,rv1108-tsadc # RV1108 SoCs
+      - rockchip,rk3228-tsadc # RK3228 SoCs
+      - rockchip,rk3288-tsadc # RK3288 SoCs
+      - rockchip,rk3328-tsadc # RK3328 SoCs
+      - rockchip,rk3368-tsadc # RK3368 SoCs
+      - rockchip,rk3399-tsadc # RK3399 SoCs
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: tsadc
+      - const: apb_pclk
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: tsadc-apb
+
+  "#thermal-sensor-cells":
+    const: 1
+
+  rockchip,grf:
+    description: The phandle of the syscon node for the general register file.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  rockchip,hw-tshut-temp:
+    description: The hardware-controlled shutdown temperature value.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  rockchip,hw-tshut-mode:
+    description: The hardware-controlled shutdown mode 0:CRU 1:GPIO.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
+  rockchip,hw-tshut-polarity:
+    description: The hardware-controlled active polarity 0:LOW 1:HIGH.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/rk3288-cru.h>
+
+    tsadc: tsadc@ff280000 {
+        compatible = "rockchip,rk3288-tsadc";
+        reg = <0xff280000 0x100>;
+        interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
+        clock-names = "tsadc", "apb_pclk";
+        resets = <&cru SRST_TSADC>;
+        reset-names = "tsadc-apb";
+        #thermal-sensor-cells = <1>;
+        rockchip,hw-tshut-temp = <95000>;
+        rockchip,hw-tshut-mode = <0>;
+        rockchip,hw-tshut-polarity = <0>;
+    };
-- 
2.30.0

