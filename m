Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013B51F40B5
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 18:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgFIQ0a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 12:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgFIQ02 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 12:26:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD90C05BD1E;
        Tue,  9 Jun 2020 09:26:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id mb16so23074733ejb.4;
        Tue, 09 Jun 2020 09:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MEDumOW8rlV53QFTJTuU3hB3elSWZ9W7Lp49FxL9gNs=;
        b=tBNTV6b03NeT32oqAhtZ5aPnu+AnGj5nrPgDEJUj2Wa4wohiu2mHBDNYNaA0vigndw
         NidHbFFqajorCW4ULYUT1sE5O+e892DCcQNG5jGkbUywwRyKiK8NBW2XLJlCxubnkuoe
         maun7rdcX41X7XdUiPrVKFcytnagwVCKy9r5O9gpjf24UphGv+3vHs93GSuhp4F6NMDB
         v2/Vl2R2masgnZK0xrK/EVLmwr1FQjBMcRHKVXv9O85rS81UBvWSB60LqLnV6pFPTI4a
         RC9Wtc4Aw80nxRRaS4bw9hQQfLnV/oRx0fyFBgX6iDzBAvEA/HrbjygUJ1P8ENwdKwlh
         CQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MEDumOW8rlV53QFTJTuU3hB3elSWZ9W7Lp49FxL9gNs=;
        b=WzVapcHTlZiO+omS9aqiJUq+jeVus2xTWyQ3tL0lGFakxQeDlOjRHGoWYyIIZ3plGm
         uWMz1ZoQrnaRTEru3lh6WSIrhMRG2AF3t95jOytDCxhzkEkZg0/PUgdEu8Kmt7mPvU81
         faHQdfJEFJTZ32q8aKtatbb0ozB4Bj1KFw04m76FNGBgOomMMCTQsxl34VjQwBbJx+xH
         hI9GbJGDQrm6iN1kr5NOaTUQr3Wd71Wt1NAb9Jre8OtPBY9apyaotKDZDBrl5Cm0PklJ
         9kPbGjuXNo1qhHEd6G2D0sb/6wpmNs4zdXao6IvPsKrJ3gnVJngljnlI0V+Ge99qqzG3
         p/Vw==
X-Gm-Message-State: AOAM531hnkb0KntkCXnEuie5r+Y7JgJOQWNIT7LqqVkcY8q792zS7oMM
        XO1TGfQQpJWv6m/wkDoYsGE=
X-Google-Smtp-Source: ABdhPJzRycsSGhV2BA2PNvstJiNA/8XhsXAIspGjk9ku/vz7jHlm93xPIeCBEsLlASFAUwQn6aqOAQ==
X-Received: by 2002:a17:906:7d97:: with SMTP id v23mr96766ejo.199.1591719983311;
        Tue, 09 Jun 2020 09:26:23 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id y26sm15722331edv.91.2020.06.09.09.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 09:26:22 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: max77620: Convert to json-schema
Date:   Tue,  9 Jun 2020 18:26:21 +0200
Message-Id: <20200609162621.1769610-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Convert the Maxim MAX77620 PMIC device tree bindings from free-form text
format to json-schema.

This also pulls in the GPIO, regulator, pinmux and thermal bindings for
the corresponding subdevices into the top-level binding so that it can
be described more consistently.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/gpio/gpio-max77620.txt           |  25 -
 .../devicetree/bindings/mfd/max77620.txt      | 162 -----
 .../devicetree/bindings/mfd/max77620.yaml     | 662 ++++++++++++++++++
 .../bindings/pinctrl/pinctrl-max77620.txt     | 127 ----
 .../bindings/regulator/regulator-max77620.txt | 222 ------
 .../bindings/thermal/max77620_thermal.txt     |  70 --
 6 files changed, 662 insertions(+), 606 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-max77620.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77620.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/max77620.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-max77620.txt
 delete mode 100644 Documentation/devicetree/bindings/regulator/regulator-max77620.txt
 delete mode 100644 Documentation/devicetree/bindings/thermal/max77620_thermal.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-max77620.txt b/Documentation/devicetree/bindings/gpio/gpio-max77620.txt
deleted file mode 100644
index 410e716fd3d2..000000000000
--- a/Documentation/devicetree/bindings/gpio/gpio-max77620.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-GPIO driver for MAX77620 Power management IC from Maxim Semiconductor.
-
-Device has 8 GPIO pins which can be configured as GPIO as well as the
-special IO functions.
-
-Required properties:
--------------------
-- gpio-controller : 	Marks the device node as a gpio controller.
-- #gpio-cells : 	Should be two.  The first cell is the pin number and
-			the second cell is used to specify the gpio polarity:
-				0 = active high
-				1 = active low
-For more details, please refer generic GPIO DT binding document
-<devicetree/bindings/gpio/gpio.txt>.
-
-Example:
---------
-#include <dt-bindings/mfd/max77620.h>
-...
-max77620@3c {
-	compatible = "maxim,max77620";
-
-	gpio-controller;
-	#gpio-cells = <2>;
-};
diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documentation/devicetree/bindings/mfd/max77620.txt
deleted file mode 100644
index 5a642a51d58e..000000000000
--- a/Documentation/devicetree/bindings/mfd/max77620.txt
+++ /dev/null
@@ -1,162 +0,0 @@
-MAX77620 Power management IC from Maxim Semiconductor.
-
-Required properties:
--------------------
-- compatible: Must be one of
-		"maxim,max77620"
-		"maxim,max20024"
-		"maxim,max77663"
-- reg: I2C device address.
-
-Optional properties:
--------------------
-- interrupts:		The interrupt on the parent the controller is
-			connected to.
-- interrupt-controller: Marks the device node as an interrupt controller.
-- #interrupt-cells:	is <2> and their usage is compliant to the 2 cells
-			variant of <../interrupt-controller/interrupts.txt>
-			IRQ numbers for different interrupt source of MAX77620
-			are defined at dt-bindings/mfd/max77620.h.
-
-- system-power-controller: Indicates that this PMIC is controlling the
-			   system power, see [1] for more details.
-
-[1] Documentation/devicetree/bindings/power/power-controller.txt
-
-Optional subnodes and their properties:
-=======================================
-
-Flexible power sequence configurations:
---------------------------------------
-The Flexible Power Sequencer (FPS) allows each regulator to power up under
-hardware or software control. Additionally, each regulator can power on
-independently or among a group of other regulators with an adjustable power-up
-and power-down delays (sequencing). GPIO1, GPIO2, and GPIO3 can be programmed
-to be part of a sequence allowing external regulators to be sequenced along
-with internal regulators. 32KHz clock can be programmed to be part of a
-sequence.
-
-The flexible sequencing structure consists of two hardware enable inputs
-(EN0, EN1), and 3 master sequencing timers called FPS0, FPS1 and FPS2.
-Each master sequencing timer is programmable through its configuration
-register to have a hardware enable source (EN1 or EN2) or a software enable
-source (SW). When enabled/disabled, the master sequencing timer generates
-eight sequencing events on different time periods called slots. The time
-period between each event is programmable within the configuration register.
-Each regulator, GPIO1, GPIO2, GPIO3, and 32KHz clock has a flexible power
-sequence slave register which allows its enable source to be specified as
-a flexible power sequencer timer or a software bit. When a FPS source of
-regulators, GPIOs and clocks specifies the enable source to be a flexible
-power sequencer, the power up and power down delays can be specified in
-the regulators, GPIOs and clocks flexible power sequencer configuration
-registers.
-
-When FPS event cleared (set to LOW), regulators, GPIOs and 32KHz
-clock are set into following state at the sequencing event that
-corresponds to its flexible sequencer configuration register.
-	Sleep state: 			In this state, regulators, GPIOs
-					and 32KHz clock get disabled at
-					the sequencing event.
-	Global Low Power Mode (GLPM):	In this state, regulators are set in
-					low power mode at the sequencing event.
-
-The configuration parameters of FPS is provided through sub-node "fps"
-and their child for FPS specific. The child node name for FPS are "fps0",
-"fps1", and "fps2" for FPS0, FPS1 and FPS2 respectively.
-
-The FPS configurations like FPS source, power up and power down slots for
-regulators, GPIOs and 32kHz clocks are provided in their respective
-configuration nodes which is explained in respective sub-system DT
-binding document.
-
-There is need for different FPS configuration parameters based on system
-state like when system state changed from active to suspend or active to
-power off (shutdown).
-
-Optional properties:
--------------------
--maxim,fps-event-source:		u32, FPS event source like external
-					hardware input to PMIC i.e. EN0, EN1 or
-					software (SW).
-					The macros are defined on
-						dt-bindings/mfd/max77620.h
-					for different control source.
-					- MAX77620_FPS_EVENT_SRC_EN0
-						for hardware input pin EN0.
-					- MAX77620_FPS_EVENT_SRC_EN1
-						for hardware input pin EN1.
-					- MAX77620_FPS_EVENT_SRC_SW
-						for software control.
-
--maxim,shutdown-fps-time-period-us:	u32, FPS time period in microseconds
-					when system enters in to shutdown
-					state.
-
--maxim,suspend-fps-time-period-us:	u32, FPS time period in microseconds
-					when system enters in to suspend state.
-
--maxim,device-state-on-disabled-event:	u32, describe the PMIC state when FPS
-					event cleared (set to LOW) whether it
-					should go to sleep state or low-power
-					state. Following are valid values:
-					- MAX77620_FPS_INACTIVE_STATE_SLEEP
-						to set the PMIC state to sleep.
-					- MAX77620_FPS_INACTIVE_STATE_LOW_POWER
-						to set the PMIC state to low
-						power.
-					Absence of this property or other value
-					will not change device state when FPS
-					event get cleared.
-
-Here supported time periods by device in microseconds are as follows:
-MAX77620 supports 40, 80, 160, 320, 640, 1280, 2560 and 5120 microseconds.
-MAX20024 supports 20, 40, 80, 160, 320, 640, 1280 and 2540 microseconds.
-MAX77663 supports 20, 40, 80, 160, 320, 640, 1280 and 2540 microseconds.
-
--maxim,power-ok-control: configure map power ok bit
-			1: Enables POK(Power OK) to control nRST_IO and GPIO1
-			POK function.
-			0: Disables POK control.
-			if property missing, do not configure MPOK bit.
-			If POK mapping is enabled for GPIO1/nRST_IO then,
-			GPIO1/nRST_IO pins are HIGH only if all rails
-			that have POK control enabled are HIGH.
-			If any of the rails goes down(which are enabled for POK
-			control) then, GPIO1/nRST_IO goes LOW.
-			this property is valid for max20024 only.
-
-For DT binding details of different sub modules like GPIO, pincontrol,
-regulator, power, please refer respective device-tree binding document
-under their respective sub-system directories.
-
-Example:
---------
-#include <dt-bindings/mfd/max77620.h>
-
-max77620@3c {
-	compatible = "maxim,max77620";
-	reg = <0x3c>;
-
-	interrupt-parent = <&intc>;
-	interrupts = <0 86 IRQ_TYPE_NONE>;
-
-	interrupt-controller;
-	#interrupt-cells = <2>;
-
-	fps {
-		fps0 {
-			maxim,shutdown-fps-time-period-us = <1280>;
-			maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN1>;
-		};
-
-		fps1 {
-			maxim,shutdown-fps-time-period-us = <1280>;
-			maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN0>;
-		};
-
-		fps2 {
-			maxim,shutdown-fps-time-period-us = <1280>;
-			maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_SW>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/mfd/max77620.yaml b/Documentation/devicetree/bindings/mfd/max77620.yaml
new file mode 100644
index 000000000000..ad2f58ce3d5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/max77620.yaml
@@ -0,0 +1,662 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/max77620.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Semiconductor MAX77620 Power Management IC
+
+maintainers:
+  - Rob Herring <robh+dt@kernel.org>
+
+description:
+  The Maxim MAX77620 is a system power management IC that can be used to
+  drive the power sequences need to boot an SoC as well as provide runtime
+  configurable power supplies for various aspects of that SoC.
+
+  In addition, the MAX77620 has 8 GPIO pins which can be configured as GPIO
+  as well as a set of special I/O functions.
+
+  The MAX77620 also supports alarm interrupts when its die temperature crosses
+  120° C and 140° C. These threshold temperatures are not configurable. The
+  device does not provide the real temperature of die, but merely indicates
+  whether the temperature is above or below the threshold levels.
+
+properties:
+  compatible:
+    enum:
+      - maxim,max77620
+      - maxim,max20024
+      - maxim,max77663
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: The interrupt on the parent the controller is connected to.
+    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+
+  interrupt-controller:
+    description: Marks the device node as an interrupt controller.
+
+  "#interrupt-cells":
+    description: Must be 2 and their usage is compliant to the 2 cells
+      variant of <../interrupt-controller/interrupts.txt>. IRQ numbers for
+      different interrupt source of MAX77620 are defined at
+      dt-bindings/mfd/max77620.h.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    const: 2
+
+  system-power-controller:
+    $ref: "/schemas/types.yaml#/definitions/flag"
+    description:
+      Indicates that this PMIC is controlling the system power, see
+      ../power/power-controller.txt for more details.
+
+  "#gpio-cells":
+    description: The first cell is the pin number and the second cell is used
+      to specify the GPIO polarity (0 = active high, 1 = active low).
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    const: 2
+
+  gpio-controller:
+    description: Marks the device node as a GPIO controller.
+    type: boolean
+
+  "#thermal-sensor-cells":
+    description: Please refer to ../thermal/thermal.txt for more details.
+    const: 0
+
+  fps:
+    description: |
+      The Flexible Power Sequencer (FPS) allows each regulator to power up
+      under hardware or software control. Additionally, each regulator can
+      power on independently or among a group of other regulators with an
+      adjustable power-up and power-down delays (sequencing). GPIO1, GPIO2,
+      and GPIO3 can be programmed to be part of a sequence allowing external
+      regulators to be sequenced along with internal regulators. 32KHz clock
+      can be programmed to be part of a sequence.
+
+      The flexible sequencing structure consists of two hardware enable
+      inputs (EN0, EN1), and 3 master sequencing timers called FPS0, FPS1
+      and FPS2. Each master sequencing timer is programmable through its
+      configuration register to have a hardware enable source (EN1 or EN2)
+      or a software enable source (SW). When enabled/disabled, the master
+      sequencing timer generates eight sequencing events on different time
+      periods called slots. The time period between each event is
+      programmable within the configuration register. Each regulator,
+      GPIO1, GPIO2, GPIO3, and 32KHz clock has a flexible power sequence
+      slave register which allows its enable source to be specified as a
+      flexible power sequencer timer or a software bit. When a FPS source
+      of regulators, GPIOs and clocks specifies the enable source to be a
+      flexible power sequencer, the power up and power down delays can be
+      specified in the regulators, GPIOs and clocks flexible power
+      sequencer configuration registers.
+
+      When FPS event cleared (set to LOW), regulators, GPIOs and 32KHz
+      clock are set into following state at the sequencing event that
+      corresponds to its flexible sequencer configuration register.
+
+      Sleep state: In this state, regulators, GPIOs and 32KHz clock get
+        disabled at the sequencing event.
+
+      Global Low Power Mode (GLPM): In this state, regulators are set in
+        low power mode at the sequencing event.
+
+      The configuration parameters of FPS is provided through sub-node
+      "fps" and their child for FPS specific. The child node name for FPS
+      are "fps0", "fps1", and "fps2" for FPS0, FPS1 and FPS2 respectively.
+
+      The FPS configurations like FPS source, power up and power down slots
+      for regulators, GPIOs and 32kHz clocks are provided in their respective
+      configuration nodes which is explained in respective sub-system DT
+      binding document.
+
+      There is need for different FPS configuration parameters based on
+      system state like when system state changed from active to suspend or
+      active to power off (shutdown).
+    type: object
+    properties:
+      maxim,fps-event-source:
+        description: |
+          FPS event source like external hardware input to PMIC i.e. EN0, EN1
+          or software (SW).
+
+          The macros are defined on dt-bindings/mfd/max77620.h for different
+          control source.
+
+          - MAX77620_FPS_EVENT_SRC_EN0: for hardware input pin EN0
+          - MAX77620_FPS_EVENT_SRC_EN1: for hardware input pin EN1
+          - MAX77620_FPS_EVENT_SRC_SW: for software control
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+
+      maxim,shutdown-fps-time-period-us:
+        description: FPS time period in microseconds when system enters into
+          shutdown state.
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+
+      maxim,suspend-fps-time-period-us:
+        description: FPS time period in microseconds when system enters into
+          suspend state.
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+
+      maxim,device-state-on-disabled-event:
+        description: |
+          Describe the PMIC state when FPS event cleared (set to LOW) whether
+          it should go to sleep state or low-power state. Following are valid
+          values:
+
+            - MAX77620_FPS_INACTIVE_STATE_SLEEP: to set the PMIC state to
+                sleep
+            - MAX77620_FPS_INACTIVE_STATE_LOW_POWER: to set the PMIC state to
+                low power
+
+          Absence of this property or other value will not change device state
+          when FPS event get cleared.
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+
+      maxim,power-ok-control:
+        description: |
+          Used to configure the map power OK bit.
+
+            - 1: Enables POK(Power OK) to control nRST_IO and GPIO1 POK
+                function.
+            - 0: Disables POK control.
+
+          If this property is missing, do not configure MPOK bit. If POK
+          mapping is enabled for GPIO1/nRST_IO then, GPIO1/nRST_IO pins are
+          HIGH only if all rails that have POK control enabled are HIGH.
+
+          If any of the rails goes down(which are enabled for POK control)
+          then, GPIO1/nRST_IO goes LOW. this property is valid for max20024
+          only.
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  regulators:
+    description: |
+      The MAX77620 has multiple DCDCs (sd[0-3]) and LDOs (ldo[0-8]). Details
+      about each of these regulators are defined using child nodes named after
+      the regulator under a top-level "regulators" node. Input supplies for
+      each of the regulators are defined in the "regulators" node.
+
+      Each subnode should contain the constraints and initialization details
+      for the corresponding regulator. The definition for each of these nodes
+      is defined using the standard bindings for regulators found in:
+
+        ../regulator/regulator.txt
+
+      Additional properties required to configure FPS parameters for SDs and
+      LDOs are defined below.
+    type: object
+    properties:
+      in-sd0-supply:
+        description: input supply for SD0, INA-SD0 or INB-SD0 pins
+
+      in-sd1-supply:
+        description: input supply for SD1
+
+      in-sd2-supply:
+        description: input supply for SD2
+
+      in-sd3-supply:
+        description: input supply for SD3
+
+      in-ld0-1-supply:
+        description: input supply for LDO0 and LDO1
+
+      in-ld2-supply:
+        description: input supply for LDO2
+
+      in-ld3-5-supply:
+        description: input supply for LDO3 and LDO5
+
+      in-ld4-6-supply:
+        description: input supply for LDO4 and LDO6
+
+      in-ld7-8-supply:
+        description: input supply for LDO7 and LDO8
+
+    patternProperties:
+      "^(sd[0-3]|ldo[0-8])$":
+        type: object
+        $ref: "/schemas/regulator/regulator.yaml"
+        properties:
+          maxim,active-fps-source:
+            description: |
+              FPS source for the regulators to get enabled/disabled when the
+              system is in active state. Valid values are:
+
+                - MAX77620_FPS_SRC_0: FPS source is FPS0.
+                - MAX77620_FPS_SRC_1: FPS source is FPS1.
+                - MAX77620_FPS_SRC_2: FPS source is FPS2.
+                - MAX77620_FPS_SRC_NONE: Regulator is not controlled by FPS
+                    events and it gets enabled/disabled by register access.
+
+              Absence of this property will leave the FPS configuration
+              register for that regulator at the default value.
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            enum: [ 0, 1, 2, 3 ]
+
+          maxim,active-fps-power-up-slot:
+            description: Sequencing event slot number on which the regulator
+              gets enabled when master FPS input event set to HIGH. Valid
+              values are 0 to 7. This is applicable if FPS source is selected
+              as FPS0, FPS1 or FPS2.
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
+
+          maxim,active-fps-power-down-slot:
+            description: Sequencing event slot number on which the regulator
+              gets disabled when master FPS input event set to LOW. Valid
+              values are 0 to 7. This is applicable if FPS source is selected
+              as FPS0, FPS1 or FPS2.
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
+
+          maxim,suspend-fps-source:
+            description: This is same as "maxim,active-fps-source" but the
+              value gets configured when the system enters suspend.
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            enum: [ 0, 1, 2, 3 ]
+
+          maxim,suspend-fps-power-up-slot:
+            description: This is same as "maxim,active-fps-power-up-slot" but
+              the value gets configured when the system enters suspend. This
+              is applicable if the suspend state FPS source is selected as
+              FPS0, FPS1 or FPS2.
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
+
+          maxim,suspend-fps-power-down-slot:
+            description: This is same as "maxim,active-fps-power-down-slot"
+              but this value gets configured when the system enters suspend.
+              This is applicable if the suspend state FPS source is selected
+              as FPS0, FPS1 or FPS2.
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
+
+          maxim,ramp-rate-setting:
+            description: |
+              Ramp rate (uV/us) setting to be configured for the device. The
+              platform may have a ramp rate different from that advertised if
+              it has design variation from Maxim's recommended rate. In this
+              case, the platform specific ramp rate is used for ramp time
+              calculation and this property is used for device register
+              configurations. The measured ramp rate of platform is provided
+              by the "regulator-ramp-delay" property as described in
+              <../regulator/regulator.txt>.
+
+              The Maxim Max77620 PMIC supports the following ramp delays:
+
+                - SD: 13.75 mV/us, 27.5 mV/us, 55 mV/us
+                - LDOs: 5 mV/us, 100 mV/us
+
+              Note: If the measured ramp delay is same as advertised ramp
+              delay then it is not required to provide the ramp delay with
+              property "maxim,ramp-rate-setting". The ramp rate can be
+              provided by the regulator-ramp-delay which will be used for
+              ramp time calculation for voltage change as well as for
+              device configuration.
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            enum: [ 5000, 13750, 27500, 55000, 100000 ]
+
+patternProperties:
+  "^gpio(@[0-9]+)?$":
+    type: object
+    properties:
+      gpio-hog:
+        $ref: "/schemas/types.yaml#/definitions/flag"
+
+      output-high:
+        $ref: "/schemas/types.yaml#/definitions/flag"
+
+      gpios:
+        $ref: "/schemas/types.yaml#/definitions/uint32-matrix"
+
+  "^pinmux(@[0-9]+)?$":
+    type: object
+    patternProperties:
+      "^gpio[0-7_]+$":
+        type: object
+        properties:
+          pins:
+            items:
+              pattern: "^gpio[0-7]$"
+            minItems: 1
+            maxItems: 8
+
+          function:
+            $ref: "/schemas/types.yaml#/definitions/string"
+            enum:
+              - gpio
+              - lpm-control-in
+              - fps-out
+              - 32k-out1
+              - sd0-dvs-in
+              - sd1-dvs-in
+              - reference-out
+
+          drive-push-pull:
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            enum: [ 0, 1 ]
+
+          drive-open-drain:
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            enum: [ 0, 1 ]
+
+          bias-pull-up:
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            enum: [ 0, 1 ]
+
+          bias-pull-down:
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            enum: [ 0, 1 ]
+
+          maxim,active-fps-source:
+            description: |
+              FPS source for the GPIOs to get enabled/disabled when the system
+              is in active state. Valid values are:
+
+                - MAX77620_FPS_SRC_0: FPS source is FPS0.
+                - MAX77620_FPS_SRC_1: FPS source is FPS1.
+                - MAX77620_FPS_SRC_2: FPS source is FPS2.
+                - MAX77620_FPS_SRC_NONE: GPIO is not controlled by FPS events
+                    and it gets enabled/disabled by register access.
+
+              Absence of this property will leave the FPS configuration
+              register for that GPIO at the default value.
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            enum: [ 0, 1, 2, 3, 4 ]
+
+          maxim,active-fps-power-up-slot:
+            description: Sequencing event slot number on which the GPIO gets
+              enabled when master FPS input event set to HIGH. Valid values
+              are 0 to 7. This is applicable if FPS source is selected as
+              FPS0, FPS1 or FPS2.
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
+
+          maxim,active-fps-power-down-slot:
+            description: Sequencing event slot number on which the GPIO gets
+              disabled when master FPS input event set to LOW. Valid values
+              are 0 to 7. This is applicable if FPS source is selected as
+              FPS0, FPS1 or FPS2.
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
+
+          maxim,suspend-fps-source:
+            description: This is same as "maxim,active-fps-source" but the
+              value gets configured when the system enters suspend.
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            enum: [ 0, 1, 2, 3, 4 ]
+
+          maxim,suspend-fps-power-up-slot:
+            description: This is same as "maxim,active-fps-power-up-slot" but
+              the value gets configured when the system enters suspend. This
+              is applicable if the suspend state FPS source is selected as
+              FPS0, FPS1 or FPS2.
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
+
+          maxim,suspend-fps-power-down-slot:
+            description: This is same as "maxim,active-fps-power-down-slot"
+              but this value gets configured when the system enters suspend.
+              This is applicable if the suspend state FPS source is selected
+              as FPS0, FPS1 or FPS2.
+            $ref: "/schemas/types.yaml#/definitions/uint32"
+            enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
+
+        required:
+          - pins
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: maxim,max77620
+    then:
+      properties:
+        fps:
+          properties:
+            maxim,shutdown-fps-time-period-us:
+              enum: [ 40, 80, 160, 320, 640, 1280, 2560, 5120 ]
+
+            maxim,suspend-fps-time-period-us:
+              enum: [ 40, 80, 160, 320, 640, 1280, 2560, 5120 ]
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: maxim,max20024
+    then:
+      properties:
+        fps:
+          properties:
+            maxim,shutdown-fps-time-period-us:
+              enum: [ 20, 40, 80, 160, 320, 640, 1280, 2540 ]
+
+            maxim,suspend-fps-time-period-us:
+              enum: [ 20, 40, 80, 160, 320, 640, 1280, 2540 ]
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: maxim,max77663
+    then:
+      properties:
+        fps:
+          properties:
+            maxim,shutdown-fps-time-period-us:
+              enum: [ 20, 40, 80, 160, 320, 640, 1280, 2540 ]
+
+            maxim,suspend-fps-time-period-us:
+              enum: [ 20, 40, 80, 160, 320, 640, 1280, 2540 ]
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/mfd/max77620.h>
+    #include <dt-bindings/thermal/thermal.h>
+
+    i2c@7000d000 {
+        reg = <0x7000d000 0x100>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic: pmic@3c {
+            compatible = "maxim,max77620";
+            reg = <0x3c>;
+
+            interrupt-parent = <&intc>;
+            interrupts = <GIC_SPI 86 IRQ_TYPE_NONE>;
+
+            #interrupt-cells = <2>;
+            interrupt-controller;
+
+            #gpio-cells = <2>;
+            gpio-controller;
+
+            #thermal-sensor-cells = <0>;
+
+            pinctrl-names = "default";
+            pinctrl-0 = <&default>;
+
+            fps {
+                fps0 {
+                    maxim,shutdown-fps-time-period-us = <1280>;
+                    maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN1>;
+                };
+
+                fps1 {
+                    maxim,shutdown-fps-time-period-us = <1280>;
+                    maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_EN0>;
+                };
+
+                fps2 {
+                    maxim,shutdown-fps-time-period-us = <1280>;
+                    maxim,fps-event-source = <MAX77620_FPS_EVENT_SRC_SW>;
+                };
+            };
+
+            default: pinmux {
+                gpio0 {
+                    pins = "gpio0";
+                    function = "gpio";
+                };
+
+                gpio1 {
+                    pins = "gpio1";
+                    function = "fps-out";
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
+                };
+
+                gpio2 {
+                    pins = "gpio2";
+                    function = "fps-out";
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
+                };
+            };
+
+            regulators {
+                in-ldo0-1-supply = <&sd2>;
+                in-ldo7-8-supply = <&sd2>;
+
+                sd0 {
+                    regulator-name = "vdd-core";
+                    regulator-min-microvolt = <600000>;
+                    regulator-max-microvolt = <1400000>;
+                    regulator-boot-on;
+                    regulator-always-on;
+                    maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
+                };
+
+                sd1 {
+                   regulator-name = "vddio-ddr";
+                   regulator-min-microvolt = <1200000>;
+                   regulator-max-microvolt = <1200000>;
+                   regulator-always-on;
+                   regulator-boot-on;
+                   maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
+                };
+
+                sd2 {
+                    regulator-name = "vdd-pre-reg";
+                    regulator-min-microvolt = <1350000>;
+                    regulator-max-microvolt = <1350000>;
+                };
+
+                sd3 {
+                    regulator-name = "vdd-1v8";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+                };
+
+                ldo0 {
+                    regulator-name = "avdd-sys";
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <1200000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+                };
+
+                ldo1 {
+                    regulator-name = "vdd-pex";
+                    regulator-min-microvolt = <1050000>;
+                    regulator-max-microvolt = <1050000>;
+                };
+
+                ldo2 {
+                    regulator-name = "vddio-sdmmc3";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3300000>;
+                };
+
+                ldo3 {
+                    regulator-name = "vdd-cam-hv";
+                    regulator-min-microvolt = <2800000>;
+                    regulator-max-microvolt = <2800000>;
+                };
+
+                ldo4 {
+                    regulator-name = "vdd-rtc";
+                    regulator-min-microvolt = <1250000>;
+                    regulator-max-microvolt = <1250000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+                };
+
+                ldo5 {
+                    regulator-name = "avdd-ts-hv";
+                    regulator-min-microvolt = <3000000>;
+                    regulator-max-microvolt = <3000000>;
+                };
+
+                ldo6 {
+                    regulator-name = "vdd-ts";
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <1800000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+                };
+
+                ldo7 {
+                    regulator-name = "vdd-gen-pll-edp";
+                    regulator-min-microvolt = <1050000>;
+                    regulator-max-microvolt = <1050000>;
+                    regulator-always-on;
+                    regulator-boot-on;
+                };
+
+                ldo8 {
+                    regulator-name = "vdd-hdmi-dp";
+                    regulator-min-microvolt = <1050000>;
+                    regulator-max-microvolt = <1050000>;
+                };
+            };
+        };
+    };
+
+    thermal-zones {
+        pmic-die {
+            polling-delay = <0>;
+            polling-delay-passive = <0>;
+            thermal-sensors = <&pmic>;
+
+            trips {
+                pmic_die_warn_temp_thresh: hot-die {
+                    temperature = <120000>;
+                    type = "hot";
+                    hysteresis = <0>;
+                };
+
+                pmic_die_crit_temp_thresh: cirtical-die {
+                    temperature = <140000>;
+                    type = "critical";
+                    hysteresis = <0>;
+                };
+            };
+
+            cooling-maps {
+                map0 {
+                    trip = <&pmic_die_warn_temp_thresh>;
+                    cooling-device = <&cool_dev THERMAL_NO_LIMIT
+                                                THERMAL_NO_LIMIT>;
+                    contribution = <100>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-max77620.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-max77620.txt
deleted file mode 100644
index 511fc234558b..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-max77620.txt
+++ /dev/null
@@ -1,127 +0,0 @@
-Pincontrol driver for MAX77620 Power management IC from Maxim Semiconductor.
-
-Device has 8 GPIO pins which can be configured as GPIO as well as the
-special IO functions.
-
-Please refer file <devicetree/bindings/pinctrl/pinctrl-bindings.txt>
-for details of the common pinctrl bindings used by client devices,
-including the meaning of the phrase "pin configuration node".
-
-Optional Pinmux properties:
---------------------------
-Following properties are required if default setting of pins are required
-at boot.
-- pinctrl-names: A pinctrl state named per <pinctrl-bindings.txt>.
-- pinctrl[0...n]: Properties to contain the phandle for pinctrl states per
-		<pinctrl-bindings.txt>.
-
-The pin configurations are defined as child of the pinctrl states node. Each
-sub-node have following properties:
-
-Required properties:
-------------------
-- pins: List of pins. Valid values of pins properties are:
-		      gpio0, gpio1, gpio2, gpio3, gpio4, gpio5, gpio6, gpio7.
-
-Optional properties:
--------------------
-Following are optional properties defined as pinmux DT binding document
-<pinctrl-bindings.txt>. Absence of properties will leave the configuration
-on default.
-	function,
-	drive-push-pull,
-	drive-open-drain,
-	bias-pull-up,
-	bias-pull-down.
-
-Valid values for function properties are:
-	gpio, lpm-control-in, fps-out, 32k-out, sd0-dvs-in, sd1-dvs-in,
-	reference-out
-
-Theres is also customised properties for the GPIO1, GPIO2 and GPIO3. These
-customised properties are required to configure FPS configuration parameters
-of these GPIOs. Please refer <devicetree/bindings/mfd/max77620.txt> for more
-detail of Flexible Power Sequence (FPS).
-
-- maxim,active-fps-source:		FPS source for the GPIOs to get
-					enabled/disabled when system is in
-					active state.  Valid values are:
-					- MAX77620_FPS_SRC_0,
-						FPS source is FPS0.
-					- MAX77620_FPS_SRC_1,
-						FPS source is FPS1
-					- MAX77620_FPS_SRC_2 and
-						FPS source is FPS2
-					- MAX77620_FPS_SRC_NONE.
-						GPIO is not controlled
-						by FPS events and it gets
-						enabled/disabled by register
-						access.
-					Absence of this property will leave
-					the FPS configuration register for that
-					GPIO to default configuration.
-
-- maxim,active-fps-power-up-slot:	Sequencing event slot number on which
-					the GPIO get enabled when
-					master FPS input event set to HIGH.
-					Valid values are 0 to 7.
-					This is applicable if FPS source is
-					selected as FPS0, FPS1 or FPS2.
-
-- maxim,active-fps-power-down-slot:	Sequencing event slot number on which
-					the GPIO get disabled when master
-					FPS input event set to LOW.
-					Valid values are 0 to 7.
-					This is applicable if FPS source is
-					selected as FPS0, FPS1 or FPS2.
-
-- maxim,suspend-fps-source:		This is same as property
-					"maxim,active-fps-source" but value
-					get configured when system enters in
-					to suspend state.
-
-- maxim,suspend-fps-power-up-slot:	This is same as property
-					"maxim,active-fps-power-up-slot" but
-					this value get configured into FPS
-					configuration register when system
-					enters into suspend.
-					This is applicable if suspend state
-					FPS source is selected as FPS0, FPS1 or
-
-- maxim,suspend-fps-power-down-slot:	This is same as property
-					"maxim,active-fps-power-down-slot" but
-					this value get configured into FPS
-					configuration register when system
-					enters into suspend.
-					This is applicable if suspend state
-					FPS source is selected as FPS0, FPS1 or
-					FPS2.
-
-Example:
---------
-#include <dt-bindings/mfd/max77620.h>
-...
-max77620@3c {
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&spmic_default>;
-
-	spmic_default: pinmux@0 {
-		pin_gpio0 {
-			pins = "gpio0";
-			function = "gpio";
-		};
-
-		pin_gpio1 {
-			pins = "gpio1";
-			function = "fps-out";
-			maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
-		};
-
-		pin_gpio2 {
-			pins = "gpio2";
-			function = "fps-out";
-			maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/regulator/regulator-max77620.txt b/Documentation/devicetree/bindings/regulator/regulator-max77620.txt
deleted file mode 100644
index 1c4bfe786736..000000000000
--- a/Documentation/devicetree/bindings/regulator/regulator-max77620.txt
+++ /dev/null
@@ -1,222 +0,0 @@
-Regulator DT binding for MAX77620 Power management IC from Maxim Semiconductor.
-
-Device has multiple DCDC(sd[0-3] and LDOs(ldo[0-8]). The input supply
-of these regulators are defined under parent device node.
-Details of regulator properties are defined as child node under
-sub-node "regulators" which is child node of device node.
-
-Please refer file <Documentation/devicetree/bindings/regulator/regulator.txt>
-for common regulator bindings used by client.
-
-Following are properties of parent node related to regulators.
-
-Optional properties:
--------------------
-The input supply of regulators are the optional properties on the
-parent device node. The input supply of these regulators are provided
-through following properties:
-in-sd0-supply:		Input supply for SD0, INA-SD0 or INB-SD0 pins.
-in-sd1-supply:		Input supply for SD1.
-in-sd2-supply:		Input supply for SD2.
-in-sd3-supply:		Input supply for SD3.
-in-ldo0-1-supply:	Input supply for LDO0 and LDO1.
-in-ldo2-supply:		Input supply for LDO2.
-in-ldo3-5-supply:	Input supply for LDO3 and LDO5
-in-ldo4-6-supply:	Input supply for LDO4 and LDO6.
-in-ldo7-8-supply:	Input supply for LDO7 and LDO8.
-
-Optional sub nodes for regulators under "regulators" subnode:
-------------------------------------------------------------
-The subnodes name is the name of regulator and it must be one of:
-	sd[0-3], ldo[0-8]
-
-Each sub-node should contain the constraints and initialization
-information for that regulator. The definition for each of these
-nodes is defined using the standard binding for regulators found at
-<Documentation/devicetree/bindings/regulator/regulator.txt>.
-
-Theres are also additional properties for SD/LDOs. These additional properties
-are required to configure FPS configuration parameters for SDs and LDOs.
-Please refer <devicetree/bindings/mfd/max77620.txt> for more detail of Flexible
-Power Sequence (FPS).
-Following are additional properties:
-
-- maxim,active-fps-source:		FPS source for the regulators to get
-					enabled/disabled when system is in
-					active state.  Valid values are:
-					- MAX77620_FPS_SRC_0,
-						FPS source is FPS0.
-					- MAX77620_FPS_SRC_1,
-						FPS source is FPS1
-					- MAX77620_FPS_SRC_2 and
-						FPS source is FPS2
-					- MAX77620_FPS_SRC_NONE.
-						Regulator is not controlled
-						by FPS events and it gets
-						enabled/disabled by register
-						access.
-					Absence of this property will leave
-					the FPS configuration register for that
-					regulator to default configuration.
-
-- maxim,active-fps-power-up-slot:	Sequencing event slot number on which
-					the regulator get enabled when
-					master FPS input event set to HIGH.
-					Valid values are 0 to 7.
-					This is applicable if FPS source is
-					selected as FPS0, FPS1 or FPS2.
-			
-- maxim,active-fps-power-down-slot:	Sequencing event slot number on which
-					the regulator get disabled when master
-					FPS input event set to LOW.
-					Valid values are 0 to 7.
-					This is applicable if FPS source is
-					selected as FPS0, FPS1 or FPS2.
-			
-- maxim,suspend-fps-source:		This is same as property
-					"maxim,active-fps-source" but value
-					get configured when system enters in
-					to suspend state.
-
-- maxim,suspend-fps-power-up-slot:	This is same as property
-					"maxim,active-fps-power-up-slot" but
-					this value get configured into FPS
-					configuration register when system
-					enters into suspend.
-					This is applicable if suspend state
-					FPS source is selected as FPS0, FPS1 or
-
-- maxim,suspend-fps-power-down-slot:	This is same as property
-					"maxim,active-fps-power-down-slot" but
-					this value get configured into FPS
-					configuration register when system
-					enters into suspend.
-					This is applicable if suspend state
-					FPS source is selected as FPS0, FPS1 or
-					FPS2.
-- maxim,ramp-rate-setting:		integer, ramp rate(uV/us) setting to be
-					configured to the device.
-					The platform may have different ramp
-					rate than advertised ramp rate if it has
-					design variation from Maxim's
-					recommended. On this case, platform
-					specific ramp rate is used for ramp time
-					calculation and this property is used
-					for device register configurations.
-					The measured ramp rate of platform is
-					provided by the regulator-ramp-delay
-					as described in <devicetree/bindings/
-					regulator/regulator.txt>.
-					Maxim Max77620 supports following ramp
-					delay:
-					  SD: 13.75mV/us, 27.5mV/us, 55mV/us
-					  LDOs: 5mV/us, 100mV/us
-
-Note: If the measured ramp delay is same as advertised ramp delay then it is not
-required to provide the ramp delay with property "maxim,ramp-rate-setting". The
-ramp rate can be provided by the regulator-ramp-delay which will be used for
-ramp time calculation for voltage change as well as for device configuration.
-
-Example:
---------
-#include <dt-bindings/mfd/max77620.h>
-...
-max77620@3c {
-	in-ldo0-1-supply = <&max77620_sd2>;
-	in-ldo7-8-supply = <&max77620_sd2>;
-	regulators {
-		sd0 {
-			regulator-name = "vdd-core";
-			regulator-min-microvolt = <600000>;
-			regulator-max-microvolt = <1400000>;
-			regulator-boot-on;
-			regulator-always-on;
-			maxim,active-fps-source = <MAX77620_FPS_SRC_1>;
-		};
-
-		sd1 {
-			regulator-name = "vddio-ddr";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			regulator-always-on;
-			regulator-boot-on;
-			maxim,active-fps-source = <MAX77620_FPS_SRC_0>;
-		};
-
-		sd2 {
-			regulator-name = "vdd-pre-reg";
-			regulator-min-microvolt = <1350000>;
-			regulator-max-microvolt = <1350000>;
-		};
-
-		sd3 {
-			regulator-name = "vdd-1v8";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-
-		ldo0 {
-			regulator-name = "avdd-sys";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-
-		ldo1 {
-			regulator-name = "vdd-pex";
-			regulator-min-microvolt = <1050000>;
-			regulator-max-microvolt = <1050000>;
-		};
-
-		ldo2 {
-			regulator-name = "vddio-sdmmc3";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <3300000>;
-		};
-
-		ldo3 {
-			regulator-name = "vdd-cam-hv";
-			regulator-min-microvolt = <2800000>;
-			regulator-max-microvolt = <2800000>;
-		};
-
-		ldo4 {
-			regulator-name = "vdd-rtc";
-			regulator-min-microvolt = <1250000>;
-			regulator-max-microvolt = <1250000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-
-		ldo5 {
-			regulator-name = "avdd-ts-hv";
-			regulator-min-microvolt = <3000000>;
-			regulator-max-microvolt = <3000000>;
-		};
-
-		ldo6 {
-			regulator-name = "vdd-ts";
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-
-		ldo7 {
-			regulator-name = "vdd-gen-pll-edp";
-			regulator-min-microvolt = <1050000>;
-			regulator-max-microvolt = <1050000>;
-			regulator-always-on;
-			regulator-boot-on;
-		};
-
-		ldo8 {
-			regulator-name = "vdd-hdmi-dp";
-			regulator-min-microvolt = <1050000>;
-			regulator-max-microvolt = <1050000>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/thermal/max77620_thermal.txt b/Documentation/devicetree/bindings/thermal/max77620_thermal.txt
deleted file mode 100644
index 323a3b3822aa..000000000000
--- a/Documentation/devicetree/bindings/thermal/max77620_thermal.txt
+++ /dev/null
@@ -1,70 +0,0 @@
-Thermal driver for MAX77620 Power management IC from Maxim Semiconductor.
-
-Maxim Semiconductor MAX77620 supports alarm interrupts when its
-die temperature crosses 120C and 140C. These threshold temperatures
-are not configurable. Device does not provide the real temperature
-of die other than just indicating whether temperature is above or
-below threshold level.
-
-Required properties:
--------------------
-#thermal-sensor-cells:	Please refer <devicetree/bindings/thermal/thermal.txt>
-			for more details.
-			The value must be 0.
-
-For more details, please refer generic thermal DT binding document
-<devicetree/bindings/thermal/thermal.txt>.
-
-Please refer <devicetree/bindings/mfd/max77620.txt> for mfd DT binding
-document for the MAX77620.
-
-Example:
---------
-#include <dt-bindings/mfd/max77620.h>
-#include <dt-bindings/thermal/thermal.h>
-...
-
-i2c@7000d000 {
-	spmic: max77620@3c {
-		compatible = "maxim,max77620";
-		:::::
-		#thermal-sensor-cells = <0>;
-		:::
-	};
-};
-
-cool_dev: cool-dev {
-	compatible = "cooling-dev";
-	#cooling-cells = <2>;
-};
-
-thermal-zones {
-	PMIC-Die {
-		polling-delay = <0>;
-		polling-delay-passive = <0>;
-		thermal-sensors = <&spmic>;
-
-		trips {
-			pmic_die_warn_temp_thresh: hot-die {
-				temperature = <120000>;
-				type = "hot";
-				hysteresis = <0>;
-			};
-
-			pmic_die_cirt_temp_thresh: cirtical-die {
-				temperature = <140000>;
-				type = "critical";
-				hysteresis = <0>;
-			};
-		};
-
-		cooling-maps {
-			map0 {
-				trip = <&pmic_die_warn_temp_thresh>;
-				cooling-device = <&cool_dev THERMAL_NO_LIMIT
-						  THERMAL_NO_LIMIT>;
-				contribution = <100>;
-			};
-		};
-	};
-};
-- 
2.24.1

