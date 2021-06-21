Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39363AE681
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 11:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhFUJzN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 05:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFUJzN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 05:55:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD69C061574
        for <linux-pm@vger.kernel.org>; Mon, 21 Jun 2021 02:52:59 -0700 (PDT)
Date:   Mon, 21 Jun 2021 09:52:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624269178;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6jYZE0xyBEiIv0IsKhUv3pcac/wVCF70h/VNchThUAY=;
        b=qikr0F4qhkPd3asRmFsqcd3GnTKGr0aT1jgLaGAIJfl4F+K+Hw2EoW0gyZiZLfWvxdGom0
        jN1ehw8HD14u5maVSfMvNBxS2iI7Y+7QNIajlXcQdBmydSHpnYLfC/lOB4HQnPa+RvJTTb
        pWzvAGRj/CitiNPrZzbzSpVvtaLiwVbJ4Q0UTy8bkwM+vERfl+Tvol4V84GSJfKIuSqZit
        /lGRjKurrGhGM3UMsUMCPT0T4nXu23uUWCkViH/hDThhNB/yheytcePAWjfBzyv5I9W5eG
        MgUZSTqw7zAradLYBhYoguzZ0TJwWvc6tPQYjcVQRGsaBjlE3uL02OMhndjMvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624269178;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6jYZE0xyBEiIv0IsKhUv3pcac/wVCF70h/VNchThUAY=;
        b=YY0qwEiWhoChrqFzG+thW0xnHefW0rqcEC8X9a8Z7lbBVENWRg7zRCOLDd85FIXTkAEcDn
        yyOvdcui9Bit7ZAg==
From:   "thermal-bot for Ezequiel Garcia" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: convert
 rockchip-thermal to json-schema
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210506175514.168365-3-ezequiel@collabora.com>
References: <20210506175514.168365-3-ezequiel@collabora.com>
MIME-Version: 1.0
Message-ID: <162426917740.395.15720523016927121585.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     6b65dc242d00b408ebbf79d0b7a16ed3f25109ec
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//6b65dc242d00b408ebbf79d0b7a16ed3f25109ec
Author:        Ezequiel Garcia <ezequiel@collabora.com>
AuthorDate:    Thu, 06 May 2021 14:55:12 -03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 21 Jun 2021 11:49:43 +02:00

dt-bindings: thermal: convert rockchip-thermal to json-schema

Convert Rockchip Thermal sensor dt-bindings to YAML.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210506175514.168365-3-ezequiel@collabora.com
---
 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt  | 85 +---------------------------------------------------------------
 Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 95 insertions(+), 85 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
deleted file mode 100644
index 7f94669..0000000
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
index 0000000..8385e8a
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
