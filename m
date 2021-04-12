Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974A935D3A9
	for <lists+linux-pm@lfdr.de>; Tue, 13 Apr 2021 01:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343958AbhDLXDs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 19:03:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48940 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244959AbhDLXDq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Apr 2021 19:03:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C61C91F453CD
Received: by jupiter.universe (Postfix, from userid 1000)
        id ED8B04800DE; Tue, 13 Apr 2021 01:03:21 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 6/6] dt-bindings: power: mfd: ab8500: Convert to DT schema format
Date:   Tue, 13 Apr 2021 01:03:20 +0200
Message-Id: <20210412230320.382885-7-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210412230320.382885-1-sebastian.reichel@collabora.com>
References: <20210412230320.382885-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the binding to DT schema format.

I slightly modified the binding by renaming the gpio node from
ab8500-gpio to ab8500-gpiocontroller, since the -gpio suffix
is used for gpio consumers.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/mfd/ab8500.txt        | 280 -------
 .../bindings/mfd/stericsson,ab8500.yaml       | 696 ++++++++++++++++++
 .../bindings/pinctrl/ste,abx500.txt           | 318 --------
 .../supply/stericsson,ab8500-battery.txt      |  34 -
 4 files changed, 696 insertions(+), 632 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/ab8500.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/ste,abx500.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/stericsson,ab8500-battery.txt

diff --git a/Documentation/devicetree/bindings/mfd/ab8500.txt b/Documentation/devicetree/bindings/mfd/ab8500.txt
deleted file mode 100644
index d2a6e835c257..000000000000
--- a/Documentation/devicetree/bindings/mfd/ab8500.txt
+++ /dev/null
@@ -1,280 +0,0 @@
-* AB8500 Multi-Functional Device (MFD)
-
-Required parent device properties:
-- compatible             : contains "stericsson,ab8500" or "stericsson,ab8505";
-- interrupts             : contains the IRQ line for the AB8500
-- interrupt-controller   : describes the AB8500 as an Interrupt Controller (has its own domain)
-- #interrupt-cells       : should be 2, for 2-cell format
-                            - The first cell is the AB8500 local IRQ number
-                            - The second cell is used to specify optional parameters
-                              - bits[3:0] trigger type and level flags:
-                                  1 = low-to-high edge triggered
-                                  2 = high-to-low edge triggered
-                                  4 = active high level-sensitive
-                                  8 = active low level-sensitive
-
-The AB8500 consists of a large and varied group of sub-devices:
-
-Device                     IRQ Names              Supply Names   Description
-------                     ---------              ------------   -----------
-ab8500-bm                :                      :              : Battery Manager
-ab8500-btemp             :                      :              : Battery Temperature
-ab8500-charger           :                      :              : Battery Charger
-ab8500-codec             :                      :              : Audio Codec
-ab8500-fg                : 			: vddadc       : Fuel Gauge
-			 : NCONV_ACCU           :	       : Accumulate N Sample Conversion
-			 : BATT_OVV		:	       : Battery Over Voltage
-			 : LOW_BAT_F		:	       : LOW threshold battery voltage
-			 : CC_INT_CALIB		:	       : Coulomb Counter Internal Calibration
-			 : CCEOC		:	       : Coulomb Counter End of Conversion
-ab8500-btemp		 :			: vtvout       : Battery Temperature
-			 : BAT_CTRL_INDB        :              : Battery Removal Indicator
-			 : BTEMP_LOW            :              : Btemp < BtempLow, if battery temperature is lower than -10°C
-			 : BTEMP_LOW_MEDIUM     :              : BtempLow < Btemp < BtempMedium,if battery temperature is between -10 and 0°C
-			 : BTEMP_MEDIUM_HIGH    :	       : BtempMedium < Btemp < BtempHigh,if battery temperature is between 0°C and MaxTemp
-			 : BTEMP_HIGH           :              : Btemp > BtempHigh, if battery temperature is higher than MaxTemp
-ab8500-charger		 :			: vddadc       : Charger interface
-			 : MAIN_CH_UNPLUG_DET	:	       : main charger unplug detection management (not in 8505)
-			 : MAIN_CHARGE_PLUG_DET	:	       : main charger plug detection management (not in 8505)
-			 : MAIN_EXT_CH_NOT_OK	:	       : main charger not OK
-			 : MAIN_CH_TH_PROT_R	:	       : Die temp is above main charger
-			 : MAIN_CH_TH_PROT_F	:	       : Die temp is below main charger
-			 : VBUS_DET_F		:	       : VBUS falling detected
-			 : VBUS_DET_R		:	       : VBUS rising detected
-			 : USB_LINK_STATUS	:	       : USB link status has changed
-			 : USB_CH_TH_PROT_R	:	       : Die temp is above usb charger
-			 : USB_CH_TH_PROT_F	:	       : Die temp is below usb charger
-			 : USB_CHARGER_NOT_OKR	:	       : allowed USB charger not ok detection
-			 : VBUS_OVV		:	       : Overvoltage on Vbus ball detected (USB charge is stopped)
-			 : CH_WD_EXP		:	       : Charger watchdog detected
-ab8500-gpadc             : HW_CONV_END          : vddadc       : Analogue to Digital Converter
-                           SW_CONV_END          :              :
-ab8500-gpio              :                      :              : GPIO Controller (AB8500)
-ab8505-gpio              :                      :              : GPIO Controller (AB8505)
-ab8500-ponkey            : ONKEY_DBF            :              : Power-on Key
-                           ONKEY_DBR            :              :
-ab8500-pwm               :                      :              : Pulse Width Modulator
-ab8500-regulator         :                      :              : Regulators (AB8500)
-ab8505-regulator         :                      :              : Regulators (AB8505)
-ab8500-rtc               : 60S                  :              : Real Time Clock
-                         : ALARM                :              :
-ab8500-sysctrl           :                      :              : System Control
-ab8500-usb               : ID_WAKEUP_R          : vddulpivio18 : Universal Serial Bus
-                         : ID_WAKEUP_F          : v-ape        :
-                         : VBUS_DET_F           : musb_1v8     :
-                         : VBUS_DET_R           :              :
-                         : USB_LINK_STATUS      :              :
-                         : USB_ADP_PROBE_PLUG   :              :
-                         : USB_ADP_PROBE_UNPLUG :              :
-
-Required child device properties:
-- compatible             : "stericsson,ab8500-[bm|btemp|charger|fg|gpadc|gpio|ponkey|
-                                               pwm|regulator|rtc|sysctrl|usb]";
-
-  A few child devices require ADC channels from the GPADC node. Those follow the
-  standard bindings from iio/iio-bindings.txt and iio/adc/adc.txt
-
-  abx500-temp		 : io-channels "aux1" and "aux2" for measuring external
-			   temperatures.
-  ab8500-fg		 : io-channel "main_bat_v" for measuring main battery voltage,
-  ab8500-btemp		 : io-channels "btemp_ball" and "bat_ctrl" for measuring the
-			   battery voltage.
-  ab8500-charger	 : io-channels "main_charger_v", "main_charger_c", "vbus_v",
-			   "usb_charger_c" for measuring voltage and current of the
-			   different charging supplies.
-
-Optional child device properties:
-- interrupts             : contains the device IRQ(s) using the 2-cell format (see above)
-- interrupt-names        : contains names of IRQ resource in the order in which they were
-                           supplied in the interrupts property
-- <supply_name>-supply   : contains a phandle to the regulator supply node in Device Tree
-
-Non-standard child device properties:
- - Audio CODEC:
-   - stericsson,amic[1|2]-type-single-ended : Single-ended Analoge Mic (default: differential)
-   - stericsson,amic1a-bias-vamic2          : Analoge Mic wishes to use a non-standard Vamic
-   - stericsson,amic1b-bias-vamic2          : Analoge Mic wishes to use a non-standard Vamic
-   - stericsson,amic2-bias-vamic1           : Analoge Mic wishes to use a non-standard Vamic
-   - stericsson,earpeice-cmv                : Earpeice voltage (only: 950 | 1100 | 1270 | 1580)
-
-ab8500 {
-         compatible = "stericsson,ab8500";
-         interrupts = <0 40 0x4>;
-         interrupt-controller;
-         #interrupt-cells = <2>;
-
-         ab8500-rtc {
-                 compatible = "stericsson,ab8500-rtc";
-                 interrupts = <17 0x4
-                               18 0x4>;
-                 interrupt-names = "60S", "ALARM";
-         };
-
-        ab8500-gpadc {
-                compatible = "stericsson,ab8500-gpadc";
-                interrupts = <32 0x4
-                              39 0x4>;
-                interrupt-names = "HW_CONV_END", "SW_CONV_END";
-                vddadc-supply = <&ab8500_ldo_tvout_reg>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		#io-channel-cells = <1>;
-
-		/* GPADC channels */
-		bat_ctrl: channel@1 {
-			reg = <0x01>;
-		};
-		btemp_ball: channel@2 {
-			reg = <0x02>;
-		};
-		main_charger_v: channel@3 {
-			reg = <0x03>;
-		};
-		acc_detect1: channel@4 {
-			reg = <0x04>;
-		};
-		acc_detect2: channel@5 {
-			reg = <0x05>;
-		};
-		adc_aux1: channel@6 {
-			reg = <0x06>;
-		};
-		adc_aux2: channel@7 {
-			reg = <0x07>;
-		};
-		main_batt_v: channel@8 {
-			reg = <0x08>;
-		};
-		vbus_v: channel@9 {
-			reg = <0x09>;
-		};
-		main_charger_c: channel@a {
-			reg = <0x0a>;
-		};
-		usb_charger_c: channel@b {
-			reg = <0x0b>;
-		};
-		bk_bat_v: channel@c {
-			reg = <0x0c>;
-		};
-		die_temp: channel@d {
-			reg = <0x0d>;
-		};
-		usb_id: channel@e {
-			reg = <0x0e>;
-		};
-		xtal_temp: channel@12 {
-			reg = <0x12>;
-		};
-		vbat_true_meas: channel@13 {
-			reg = <0x13>;
-		};
-		bat_ctrl_and_ibat: channel@1c {
-			reg = <0x1c>;
-		};
-		vbat_meas_and_ibat: channel@1d {
-			reg = <0x1d>;
-		};
-		vbat_true_meas_and_ibat: channel@1e {
-			reg = <0x1e>;
-		};
-		bat_temp_and_ibat: channel@1f {
-			reg = <0x1f>;
-		};
-        };
-
-	ab8500_temp {
-		compatible = "stericsson,abx500-temp";
-		io-channels = <&gpadc 0x06>,
-			      <&gpadc 0x07>;
-		io-channel-name = "aux1", "aux2";
-	};
-
-	ab8500_battery: ab8500_battery {
-		stericsson,battery-type = "LIPO";
-		thermistor-on-batctrl;
-	};
-
-	ab8500_fg {
-		compatible = "stericsson,ab8500-fg";
-		battery	   = <&ab8500_battery>;
-		io-channels = <&gpadc 0x08>;
-		io-channel-name = "main_bat_v";
-	};
-
-	ab8500_btemp {
-		compatible = "stericsson,ab8500-btemp";
-		battery	   = <&ab8500_battery>;
-		io-channels = <&gpadc 0x02>,
-			      <&gpadc 0x01>;
-		io-channel-name = "btemp_ball",
-				"bat_ctrl";
-	};
-
-	ab8500_charger {
-		compatible	= "stericsson,ab8500-charger";
-		battery		= <&ab8500_battery>;
-		vddadc-supply	= <&ab8500_ldo_tvout_reg>;
-		io-channels = <&gpadc 0x03>,
-			      <&gpadc 0x0a>,
-			      <&gpadc 0x09>,
-			      <&gpadc 0x0b>;
-		io-channel-name = "main_charger_v",
-				"main_charger_c",
-				"vbus_v",
-				"usb_charger_c";
-	};
-
-        ab8500-usb {
-                compatible = "stericsson,ab8500-usb";
-                interrupts = < 90 0x4
-                               96 0x4
-                               14 0x4
-                               15 0x4
-                               79 0x4
-                               74 0x4
-                               75 0x4>;
-                interrupt-names = "ID_WAKEUP_R",
-                                  "ID_WAKEUP_F",
-                                  "VBUS_DET_F",
-                                  "VBUS_DET_R",
-                                  "USB_LINK_STATUS",
-                                  "USB_ADP_PROBE_PLUG",
-                                  "USB_ADP_PROBE_UNPLUG";
-                vddulpivio18-supply = <&ab8500_ldo_intcore_reg>;
-                v-ape-supply = <&db8500_vape_reg>;
-                musb_1v8-supply = <&db8500_vsmps2_reg>;
-        };
-
-        ab8500-ponkey {
-                compatible = "stericsson,ab8500-ponkey";
-                interrupts = <6 0x4
-                              7 0x4>;
-                interrupt-names = "ONKEY_DBF", "ONKEY_DBR";
-        };
-
-        ab8500-sysctrl {
-                compatible = "stericsson,ab8500-sysctrl";
-        };
-
-        ab8500-pwm {
-                compatible = "stericsson,ab8500-pwm";
-        };
-
-	codec: ab8500-codec {
-		compatible = "stericsson,ab8500-codec";
-
-		stericsson,earpeice-cmv = <950>; /* Units in mV. */
-	};
-
-        ab8500-regulators {
-                compatible = "stericsson,ab8500-regulator";
-
-                ab8500_ldo_aux1_reg: ab8500_ldo_aux1 {
-                        /*
-                         * See: Documentation/devicetree/bindings/regulator/regulator.txt
-                         * for more information on regulators
-                         */
-                };
-        };
-};
diff --git a/Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml b/Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml
new file mode 100644
index 000000000000..80d33f21d72f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/stericsson,ab8500.yaml
@@ -0,0 +1,696 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/mfd/stericsson,ab8500.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: AB8500 Multi-Functional Device
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+  - Lee Jones <lee.jones@linaro.org>
+
+properties:
+  compatible:
+    enum:
+      - stericsson,ab8500
+      - stericsson,ab8505
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    description: First cell is IRQ number, second cell is flags
+    const: 2
+
+  clock-controller:
+    type: object
+    properties:
+      compatible:
+        const: stericsson,ab8500-clk
+
+      "#clock-cells":
+        const: 1
+
+    required:
+      - compatible
+      - "#clock-cells"
+
+    additionalProperties: false
+
+  ab8500-rtc:
+    type: object
+    properties:
+      compatible:
+        const: stericsson,ab8500-rtc
+
+      interrupts:
+        maxItems: 2
+
+      interrupt-names:
+        items:
+          - const: 60S
+          - const: ALARM
+
+    required:
+      - compatible
+      - interrupts
+      - interrupt-names
+
+    additionalProperties: false
+
+  ab8500-gpadc:
+    type: object
+    properties:
+      compatible:
+        const: stericsson,ab8500-gpadc
+
+      interrupts:
+        minItems: 1
+        maxItems: 2
+
+      interrupt-names:
+        minItems: 1
+        maxItems: 2
+        items:
+          anyOf:
+            - const: HW_CONV_END
+            - const: SW_CONV_END
+
+      vddadc-supply:
+        description: analog supply
+
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+      "#io-channel-cells":
+        const: 1
+
+    required:
+      - compatible
+
+    patternProperties:
+      "^channel@[0-9a-f]+$":
+        type: object
+        properties:
+          reg:
+            maxItems: 1
+
+        required:
+          - reg
+
+        additionalProperties: false
+
+    additionalProperties: false
+
+  ab8500_temp:
+    type: object
+    properties:
+      compatible:
+        const: stericsson,abx500-temp
+
+      interrupts:
+        maxItems: 1
+
+      interrupt-names:
+        items:
+          - const: ABX500_TEMP_WARM
+
+      io-channels:
+        maxItems: 2
+
+      io-channel-names:
+        items:
+          - const: aux1
+          - const: aux2
+
+    required:
+      - compatible
+
+    additionalProperties: false
+
+  ab8500_btemp:
+    type: object
+    $ref: ../power/supply/stericsson,ab8500-btemp.yaml
+
+  ab8500_charger:
+    type: object
+    $ref: ../power/supply/stericsson,ab8500-charger.yaml
+
+  ab8500_fg:
+    type: object
+    $ref: ../power/supply/stericsson,ab8500-fg.yaml
+
+  ab8500_chargalg:
+    type: object
+    $ref: ../power/supply/stericsson,ab8500-chargalg.yaml
+
+  ab8500_battery:
+    type: object
+    properties:
+      stericsson,battery-type:
+        description: battery chemistry
+        enum:
+          - UNKNOWN
+          - NiMH
+          - LION
+          - LIPO
+          - LiFe
+          - NiCd
+          - LiMn
+
+      thermistor-on-batctrl:
+        type: boolean
+        description:
+          if set 'batctrl' is used for thermal measurement, otherwise 'btemp'
+          is used for thermal measurement.
+
+    additionalProperties: false
+
+  ab8500_usb:
+    type: object
+    properties:
+      compatible:
+        const: stericsson,ab8500-usb
+
+      interrupts:
+        maxItems: 7
+
+      interrupt-names:
+        items:
+          - const: ID_WAKEUP_R
+          - const: ID_WAKEUP_F
+          - const: VBUS_DET_F
+          - const: VBUS_DET_R
+          - const: USB_LINK_STATUS
+          - const: USB_ADP_PROBE_PLUG
+          - const: USB_ADP_PROBE_UNPLUG
+
+      vddulpivio18-supply:
+        description: 1.8V VIO
+
+      v-ape-supply:
+        description: V-APE
+
+      musb_1v8-supply:
+        description: MUSB 1.8V
+
+      clocks:
+        maxItems: 1
+
+      clock-names:
+        items:
+          - const: sysclk
+
+    additionalProperties: false
+
+  ab8500-ponkey:
+    type: object
+    properties:
+      compatible:
+        const: stericsson,ab8500-poweron-key
+
+      interrupts:
+        maxItems: 2
+
+      interrupt-names:
+        items:
+          - const: ONKEY_DBF
+          - const: ONKEY_DBR
+
+    additionalProperties: false
+
+  ab8500-sysctrl:
+    type: object
+    properties:
+      compatible:
+        const: stericsson,ab8500-sysctrl
+
+    additionalProperties: false
+
+  ab8500-debugfs:
+    type: object
+    properties:
+      compatible:
+        const: stericsson,ab8500-debug
+
+    additionalProperties: false
+
+  ab8500-codec:
+    type: object
+    properties:
+      compatible:
+        const: stericsson,ab8500-codec
+
+      V-AUD-supply:
+        description: V-AUD supply
+
+      V-AMIC1-supply:
+        description: V-AMIC1 supply
+
+      V-AMIC2-supply:
+        description: V-AMIC2 supply
+
+      V-DMIC-supply:
+        description: V-DMIC supply
+
+      clocks:
+        maxItems: 1
+
+      clock-names:
+        items:
+          - const: audioclk
+
+      stericsson,earpeice-cmv:
+        description: earpiece voltage in mV
+        enum: [950, 1100, 1270, 1580]
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+    additionalProperties: false
+
+  ab8500-ext-regulators:
+    type: object
+    properties:
+      compatible:
+        const: stericsson,ab8500-ext-regulator
+
+    patternProperties:
+      "^ab8500_ext[1-3]$":
+        $ref: /schemas/regulator/regulator.yaml
+
+    additionalProperties: false
+
+patternProperties:
+  "^ab8500-pwm(-[1-3])?$":
+    type: object
+    properties:
+      compatible:
+        const: stericsson,ab8500-pwm
+
+      clocks:
+        maxItems: 1
+
+      clock-names:
+        items:
+          - const: intclk
+
+    additionalProperties: false
+  "^ab850[05]-gpiocontroller$":
+    type: object
+    properties:
+      compatible:
+        enum:
+          - stericsson,ab8500-gpio
+          - stericsson,ab8505-gpio
+          - stericsson,ab8540-gpio
+          - stericsson,ab9540-gpio
+
+      gpio-controller: true
+
+      "#gpio-cells":
+        const: 2
+
+    required:
+      - compatible
+      - gpio-controller
+      - "#gpio-cells"
+
+    patternProperties:
+      "^.*$":
+        $ref: "/schemas/pinctrl/pincfg-node.yaml"
+
+    additionalProperties: false
+
+  "^ab850[05]-regulators$":
+    type: object
+    properties:
+      compatible:
+        enum:
+          - stericsson,ab8500-regulator
+          - stericsson,ab8505-regulator
+
+      vin-supply:
+        description: input supply
+
+    patternProperties:
+      "^ab8500_ldo_adc$|^ab8500_ldo_aux[1-8]$|^ab8500_ldo_intcore$|^ab8500_ldo_tvout$|^ab8500_ldo_audio$|^ab8500_ldo_anamic[12]$|^ab8500_ldo_dmic$|^ab8500_ldo_ana$":
+        $ref: /schemas/regulator/regulator.yaml
+
+    additionalProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/mfd/dbx500-prcmu.h>
+    #include <dt-bindings/clock/ste-ab8500.h>
+    ab8500 {
+        compatible = "stericsson,ab8500";
+        interrupt-parent = <&intc>;
+        interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+
+        ab8500_clock: clock-controller {
+            compatible = "stericsson,ab8500-clk";
+            #clock-cells = <1>;
+        };
+
+        ab8500_gpio: ab8500-gpiocontroller {
+            compatible = "stericsson,ab8500-gpio";
+            gpio-controller;
+            #gpio-cells = <2>;
+        };
+
+        ab8500-rtc {
+            compatible = "stericsson,ab8500-rtc";
+            interrupts = <17 IRQ_TYPE_LEVEL_HIGH>,
+                         <18 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "60S", "ALARM";
+        };
+
+        gpadc: ab8500-gpadc {
+            compatible = "stericsson,ab8500-gpadc";
+            interrupts = <32 IRQ_TYPE_LEVEL_HIGH>,
+                         <39 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "HW_CONV_END", "SW_CONV_END";
+            vddadc-supply = <&ab8500_ldo_tvout_reg>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            #io-channel-cells = <1>;
+
+            /* GPADC channels */
+            bat_ctrl: channel@1 {
+                reg = <0x01>;
+            };
+            btemp_ball: channel@2 {
+                reg = <0x02>;
+            };
+            main_charger_v: channel@3 {
+                reg = <0x03>;
+            };
+            acc_detect1: channel@4 {
+                reg = <0x04>;
+            };
+            acc_detect2: channel@5 {
+                reg = <0x05>;
+            };
+            adc_aux1: channel@6 {
+                reg = <0x06>;
+            };
+            adc_aux2: channel@7 {
+                reg = <0x07>;
+            };
+            main_batt_v: channel@8 {
+                reg = <0x08>;
+            };
+            vbus_v: channel@9 {
+                reg = <0x09>;
+            };
+            main_charger_c: channel@a {
+                reg = <0x0a>;
+            };
+            usb_charger_c: channel@b {
+                reg = <0x0b>;
+            };
+            bk_bat_v: channel@c {
+                reg = <0x0c>;
+            };
+            die_temp: channel@d {
+                reg = <0x0d>;
+            };
+            usb_id: channel@e {
+                reg = <0x0e>;
+            };
+            xtal_temp: channel@12 {
+                reg = <0x12>;
+            };
+            vbat_true_meas: channel@13 {
+                reg = <0x13>;
+            };
+            bat_ctrl_and_ibat: channel@1c {
+                reg = <0x1c>;
+            };
+            vbat_meas_and_ibat: channel@1d {
+                reg = <0x1d>;
+            };
+            vbat_true_meas_and_ibat: channel@1e {
+                reg = <0x1e>;
+            };
+            bat_temp_and_ibat: channel@1f {
+                reg = <0x1f>;
+            };
+        };
+
+        ab8500_temp {
+            compatible = "stericsson,abx500-temp";
+            interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "ABX500_TEMP_WARM";
+            io-channels = <&gpadc 0x06>,
+                          <&gpadc 0x07>;
+            io-channel-names = "aux1", "aux2";
+        };
+
+        ab8500_battery: ab8500_battery {
+            stericsson,battery-type = "LIPO";
+            thermistor-on-batctrl;
+        };
+
+        ab8500_fg {
+            compatible = "stericsson,ab8500-fg";
+            interrupts = <24 IRQ_TYPE_LEVEL_HIGH>,
+                         <8 IRQ_TYPE_LEVEL_HIGH>,
+                         <28 IRQ_TYPE_LEVEL_HIGH>,
+                         <27 IRQ_TYPE_LEVEL_HIGH>,
+                         <26 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "NCONV_ACCU",
+                              "BATT_OVV",
+                              "LOW_BAT_F",
+                              "CC_INT_CALIB",
+                              "CCEOC";
+            battery = <&ab8500_battery>;
+            io-channels = <&gpadc 0x08>;
+            io-channel-names = "main_bat_v";
+        };
+
+        ab8500_btemp {
+            compatible = "stericsson,ab8500-btemp";
+            interrupts = <20 IRQ_TYPE_LEVEL_HIGH>,
+                         <80 IRQ_TYPE_LEVEL_HIGH>,
+                         <83 IRQ_TYPE_LEVEL_HIGH>,
+                         <81 IRQ_TYPE_LEVEL_HIGH>,
+                         <82 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "BAT_CTRL_INDB",
+                              "BTEMP_LOW",
+                              "BTEMP_HIGH",
+                              "BTEMP_LOW_MEDIUM",
+                              "BTEMP_MEDIUM_HIGH";
+            battery = <&ab8500_battery>;
+            io-channels = <&gpadc 0x02>,
+                          <&gpadc 0x01>;
+            io-channel-names = "btemp_ball",
+                            "bat_ctrl";
+        };
+
+        ab8500_charger {
+            compatible = "stericsson,ab8500-charger";
+            interrupts = <10 IRQ_TYPE_LEVEL_HIGH>,
+                         <11 IRQ_TYPE_LEVEL_HIGH>,
+                         <0 IRQ_TYPE_LEVEL_HIGH>,
+                         <107 IRQ_TYPE_LEVEL_HIGH>,
+                         <106 IRQ_TYPE_LEVEL_HIGH>,
+                         <14 IRQ_TYPE_LEVEL_HIGH>,
+                         <15 IRQ_TYPE_LEVEL_HIGH>,
+                         <79 IRQ_TYPE_LEVEL_HIGH>,
+                         <105 IRQ_TYPE_LEVEL_HIGH>,
+                         <104 IRQ_TYPE_LEVEL_HIGH>,
+                         <89 IRQ_TYPE_LEVEL_HIGH>,
+                         <22 IRQ_TYPE_LEVEL_HIGH>,
+                         <21 IRQ_TYPE_LEVEL_HIGH>,
+                         <16 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "MAIN_CH_UNPLUG_DET",
+                              "MAIN_CHARGE_PLUG_DET",
+                              "MAIN_EXT_CH_NOT_OK",
+                              "MAIN_CH_TH_PROT_R",
+                              "MAIN_CH_TH_PROT_F",
+                              "VBUS_DET_F",
+                              "VBUS_DET_R",
+                              "USB_LINK_STATUS",
+                              "USB_CH_TH_PROT_R",
+                              "USB_CH_TH_PROT_F",
+                              "USB_CHARGER_NOT_OKR",
+                              "VBUS_OVV",
+                              "CH_WD_EXP",
+                              "VBUS_CH_DROP_END";
+            battery = <&ab8500_battery>;
+            vddadc-supply = <&ab8500_ldo_tvout_reg>;
+            io-channels = <&gpadc 0x03>,
+                          <&gpadc 0x0a>,
+                          <&gpadc 0x09>,
+                          <&gpadc 0x0b>;
+            io-channel-names = "main_charger_v",
+                            "main_charger_c",
+                            "vbus_v",
+                            "usb_charger_c";
+        };
+
+        ab8500_chargalg {
+            compatible = "stericsson,ab8500-chargalg";
+            battery = <&ab8500_battery>;
+        };
+
+        ab8500_usb {
+            compatible = "stericsson,ab8500-usb";
+            interrupts = <90 IRQ_TYPE_LEVEL_HIGH>,
+                         <96 IRQ_TYPE_LEVEL_HIGH>,
+                         <14 IRQ_TYPE_LEVEL_HIGH>,
+                         <15 IRQ_TYPE_LEVEL_HIGH>,
+                         <79 IRQ_TYPE_LEVEL_HIGH>,
+                         <74 IRQ_TYPE_LEVEL_HIGH>,
+                         <75 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "ID_WAKEUP_R",
+                              "ID_WAKEUP_F",
+                              "VBUS_DET_F",
+                              "VBUS_DET_R",
+                              "USB_LINK_STATUS",
+                              "USB_ADP_PROBE_PLUG",
+                              "USB_ADP_PROBE_UNPLUG";
+            vddulpivio18-supply = <&ab8500_ldo_intcore_reg>;
+            v-ape-supply = <&db8500_vape_reg>;
+            musb_1v8-supply = <&db8500_vsmps2_reg>;
+            clocks = <&prcmu_clk PRCMU_SYSCLK>;
+            clock-names = "sysclk";
+        };
+
+        ab8500-ponkey {
+            compatible = "stericsson,ab8500-poweron-key";
+            interrupts = <6 IRQ_TYPE_LEVEL_HIGH>,
+                         <7 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "ONKEY_DBF", "ONKEY_DBR";
+        };
+
+        ab8500-sysctrl {
+            compatible = "stericsson,ab8500-sysctrl";
+        };
+
+        ab8500-pwm-1 {
+            compatible = "stericsson,ab8500-pwm";
+            clocks = <&ab8500_clock AB8500_SYSCLK_INT>;
+            clock-names = "intclk";
+        };
+
+        ab8500-pwm-2 {
+            compatible = "stericsson,ab8500-pwm";
+            clocks = <&ab8500_clock AB8500_SYSCLK_INT>;
+            clock-names = "intclk";
+        };
+
+        ab8500-pwm-3 {
+            compatible = "stericsson,ab8500-pwm";
+            clocks = <&ab8500_clock AB8500_SYSCLK_INT>;
+            clock-names = "intclk";
+        };
+
+        ab8500-debugfs {
+            compatible = "stericsson,ab8500-debug";
+        };
+
+        codec: ab8500-codec {
+            compatible = "stericsson,ab8500-codec";
+
+            V-AUD-supply = <&ab8500_ldo_audio_reg>;
+            V-AMIC1-supply = <&ab8500_ldo_anamic1_reg>;
+            V-AMIC2-supply = <&ab8500_ldo_anamic2_reg>;
+            V-DMIC-supply = <&ab8500_ldo_dmic_reg>;
+
+            clocks = <&ab8500_clock AB8500_SYSCLK_AUDIO>;
+            clock-names = "audioclk";
+
+            stericsson,earpeice-cmv = <950>; /* Units in mV. */
+        };
+
+        ext_regulators: ab8500-ext-regulators {
+            compatible = "stericsson,ab8500-ext-regulator";
+
+            ab8500_ext1_reg: ab8500_ext1 {
+                regulator-min-microvolt = <1800000>;
+                regulator-max-microvolt = <1800000>;
+                regulator-boot-on;
+                regulator-always-on;
+            };
+
+            ab8500_ext2_reg: ab8500_ext2 {
+                regulator-min-microvolt = <1360000>;
+                regulator-max-microvolt = <1360000>;
+                regulator-boot-on;
+                regulator-always-on;
+            };
+
+            ab8500_ext3_reg: ab8500_ext3 {
+                regulator-min-microvolt = <3400000>;
+                regulator-max-microvolt = <3400000>;
+                regulator-boot-on;
+            };
+        };
+
+        ab8500-regulators {
+            compatible = "stericsson,ab8500-regulator";
+            vin-supply = <&ab8500_ext3_reg>;
+
+            // supplies to the display/camera
+            ab8500_ldo_aux1_reg: ab8500_ldo_aux1 {
+                regulator-min-microvolt = <2500000>;
+                regulator-max-microvolt = <2900000>;
+                regulator-boot-on;
+                /* BUG: If turned off MMC will be affected. */
+                regulator-always-on;
+            };
+
+            // supplies to the on-board eMMC
+            ab8500_ldo_aux2_reg: ab8500_ldo_aux2 {
+                regulator-min-microvolt = <1100000>;
+                regulator-max-microvolt = <3300000>;
+            };
+
+            // supply for VAUX3; SDcard slots
+            ab8500_ldo_aux3_reg: ab8500_ldo_aux3 {
+                regulator-min-microvolt = <1100000>;
+                regulator-max-microvolt = <3300000>;
+            };
+
+            // supply for v-intcore12; VINTCORE12 LDO
+            ab8500_ldo_intcore_reg: ab8500_ldo_intcore {
+            };
+
+            // supply for tvout; gpadc; TVOUT LDO
+            ab8500_ldo_tvout_reg: ab8500_ldo_tvout {
+            };
+
+            // supply for ab8500-vaudio; VAUDIO LDO
+            ab8500_ldo_audio_reg: ab8500_ldo_audio {
+            };
+
+            // supply for v-anamic1 VAMIC1 LDO
+            ab8500_ldo_anamic1_reg: ab8500_ldo_anamic1 {
+            };
+
+            // supply for v-amic2; VAMIC2 LDO; reuse constants for AMIC1
+            ab8500_ldo_anamic2_reg: ab8500_ldo_anamic2 {
+            };
+
+            // supply for v-dmic; VDMIC LDO
+            ab8500_ldo_dmic_reg: ab8500_ldo_dmic {
+            };
+
+            // supply for U8500 CSI/DSI; VANA LDO
+            ab8500_ldo_ana_reg: ab8500_ldo_ana {
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pinctrl/ste,abx500.txt b/Documentation/devicetree/bindings/pinctrl/ste,abx500.txt
deleted file mode 100644
index 87697420439e..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/ste,abx500.txt
+++ /dev/null
@@ -1,318 +0,0 @@
-ST Ericsson abx500 pinmux controller
-
-Required properties:
-- compatible: "stericsson,ab8500-gpio",  "stericsson,ab8540-gpio",
-	      "stericsson,ab8505-gpio", "stericsson,ab9540-gpio",
-
-Please refer to pinctrl-bindings.txt in this directory for details of the
-common pinctrl bindings used by client devices, including the meaning of the
-phrase "pin configuration node".
-
-ST Ericsson's pin configuration nodes use the generic pin multiplexing
-and pin configuration bindings, see pinctrl-bindings.txt
-
-Example board file extract:
-
-&pinctrl_abx500 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&sysclkreq2_default_mode>, <&sysclkreq3_default_mode>, <&gpio3_default_mode>, <&sysclkreq6_default_mode>, <&pwmout1_default_mode>, <&pwmout2_default_mode>, <&pwmout3_default_mode>, <&adi1_default_mode>, <&dmic12_default_mode>, <&dmic34_default_mode>, <&dmic56_default_mode>, <&sysclkreq5_default_mode>, <&batremn_default_mode>, <&service_default_mode>, <&pwrctrl0_default_mode>, <&pwrctrl1_default_mode>, <&pwmextvibra1_default_mode>, <&pwmextvibra2_default_mode>, <&gpio51_default_mode>, <&gpio52_default_mode>, <&gpio53_default_mode>, <&gpio54_default_mode>, <&pdmclkdat_default_mode>;
-
-	sysclkreq2 {
-		sysclkreq2_default_mode: sysclkreq2_default {
-			default_mux {
-				function = "sysclkreq";
-				groups = "sysclkreq2_d_1";
-			};
-			default_cfg {
-				pins = "GPIO1";
-				bias-disable;
-			};
-		};
-	};
-	sysclkreq3 {
-		sysclkreq3_default_mode: sysclkreq3_default {
-			default_mux {
-				function = "sysclkreq";
-				groups = "sysclkreq3_d_1";
-			};
-			default_cfg {
-				pins = "GPIO2";
-				output-low;
-			};
-		};
-	};
-	gpio3 {
-		gpio3_default_mode: gpio3_default {
-			default_mux {
-				function = "gpio";
-				groups = "gpio3_a_1";
-			};
-			default_cfg {
-				pins = "GPIO3";
-				output-low;
-			};
-		};
-	};
-	sysclkreq6 {
-		sysclkreq6_default_mode: sysclkreq6_default {
-			default_mux {
-				function = "sysclkreq";
-				groups = "sysclkreq6_d_1";
-			};
-			default_cfg {
-				pins = "GPIO4";
-				bias-disable;
-			};
-		};
-	};
-	pwmout1 {
-		pwmout1_default_mode: pwmout1_default {
-			default_mux {
-				function = "pwmout";
-				groups = "pwmout1_d_1";
-			};
-			default_cfg {
-				pins = "GPIO14";
-				output-low;
-			};
-		};
-	};
-	pwmout2 {
-		pwmout2_default_mode: pwmout2_default {
-			pwmout2_default_mux {
-				function = "pwmout";
-				groups = "pwmout2_d_1";
-			};
-			pwmout2_default_cfg {
-				pins = "GPIO15";
-				output-low;
-			};
-		};
-	};
-	pwmout3 {
-		pwmout3_default_mode: pwmout3_default {
-			pwmout3_default_mux {
-				function = "pwmout";
-				groups = "pwmout3_d_1";
-			};
-			pwmout3_default_cfg {
-				pins = "GPIO16";
-				output-low;
-			};
-		};
-	};
-	adi1 {
-
-		adi1_default_mode: adi1_default {
-			adi1_default_mux {
-				function = "adi1";
-				groups = "adi1_d_1";
-			};
-			adi1_default_cfg1 {
-				pins = "GPIO17","GPIO19","GPIO20";
-				bias-disable;
-			};
-			adi1_default_cfg2 {
-				pins = "GPIO18";
-				output-low;
-			};
-		};
-	};
-	dmic12 {
-		dmic12_default_mode: dmic12_default {
-			dmic12_default_mux {
-				function = "dmic";
-				groups = "dmic12_d_1";
-			};
-			dmic12_default_cfg1 {
-				pins = "GPIO27";
-				output-low;
-			};
-			dmic12_default_cfg2 {
-				pins = "GPIO28";
-				bias-disable;
-			};
-		};
-	};
-	dmic34 {
-		dmic34_default_mode: dmic34_default {
-			dmic34_default_mux {
-				function = "dmic";
-				groups = "dmic34_d_1";
-			};
-			dmic34_default_cfg1 {
-				pins = "GPIO29";
-				output-low;
-			};
-			dmic34_default_cfg2 {
-				pins = "GPIO30";
-				bias-disable;{
-
-			};
-		};
-	};
-	dmic56 {
-		dmic56_default_mode: dmic56_default {
-			dmic56_default_mux {
-				function = "dmic";
-				groups = "dmic56_d_1";
-			};
-			dmic56_default_cfg1 {
-				pins = "GPIO31";
-				output-low;
-			};
-			dmic56_default_cfg2 {
-				pins = "GPIO32";
-				bias-disable;
-			};
-		};
-	};
-	sysclkreq5 {
-		sysclkreq5_default_mode: sysclkreq5_default {
-			sysclkreq5_default_mux {
-				function = "sysclkreq";
-				groups = "sysclkreq5_d_1";
-			};
-			sysclkreq5_default_cfg {
-				pins = "GPIO42";
-				output-low;
-			};
-		};
-	};
-	batremn {
-		batremn_default_mode: batremn_default {
-			batremn_default_mux {
-				function = "batremn";
-				groups = "batremn_d_1";
-			};
-			batremn_default_cfg {
-				pins = "GPIO43";
-				bias-disable;
-			};
-		};
-	};
-	service {
-		service_default_mode: service_default {
-			service_default_mux {
-				function = "service";
-				groups = "service_d_1";
-			};
-			service_default_cfg {
-				pins = "GPIO44";
-				bias-disable;
-			};
-		};
-	};
-	pwrctrl0 {
-		pwrctrl0_default_mux: pwrctrl0_mux {
-			pwrctrl0_default_mux {
-				function = "pwrctrl";
-				groups = "pwrctrl0_d_1";
-			};
-		};
-		pwrctrl0_default_mode: pwrctrl0_default {
-			pwrctrl0_default_cfg {
-				pins = "GPIO45";
-				bias-disable;
-			};
-		};
-	};
-	pwrctrl1 {
-		pwrctrl1_default_mux: pwrctrl1_mux {
-			pwrctrl1_default_mux {
-				function = "pwrctrl";
-				groups = "pwrctrl1_d_1";
-			};
-		};
-		pwrctrl1_default_mode: pwrctrl1_default {
-			pwrctrl1_default_cfg {
-				pins = "GPIO46";
-				bias-disable;
-			};
-		};
-	};
-	pwmextvibra1 {
-		pwmextvibra1_default_mode: pwmextvibra1_default {
-			pwmextvibra1_default_mux {
-				function = "pwmextvibra";
-				groups = "pwmextvibra1_d_1";
-			};
-			pwmextvibra1_default_cfg {
-				pins = "GPIO47";
-				bias-disable;
-			};
-		};
-	};
-	pwmextvibra2 {
-		pwmextvibra2_default_mode: pwmextvibra2_default {
-			pwmextvibra2_default_mux {
-				function = "pwmextvibra";
-				groups = "pwmextvibra2_d_1";
-			};
-			pwmextvibra1_default_cfg {
-				pins = "GPIO48";
-				bias-disable;
-			};
-		};
-	};
-	gpio51 {
-		gpio51_default_mode: gpio51_default {
-				gpio51_default_mux {
-				function = "gpio";
-				groups = "gpio51_a_1";
-			};
-			gpio51_default_cfg {
-				pins = "GPIO51";
-				output-low;
-			};
-		};
-	};
-	gpio52 {
-		gpio52_default_mode: gpio52_default {
-			gpio52_default_mux {
-				function = "gpio";
-				groups = "gpio52_a_1";
-			};
-			gpio52_default_cfg {
-				pins = "GPIO52";
-				bias-pull-down;
-			};
-		};
-	};
-	gpio53 {
-		gpio53_default_mode: gpio53_default {
-			gpio53_default_mux {
-				function = "gpio";
-				groups = "gpio53_a_1";
-			};
-			gpio53_default_cfg {
-				pins = "GPIO53";
-				bias-pull-down;
-			};
-		};
-	};
-	gpio54 {
-		gpio54_default_mode: gpio54_default {
-			gpio54_default_mux {
-				function = "gpio";
-				groups = "gpio54_a_1";
-			};
-			gpio54_default_cfg {
-				pins = "GPIO54";
-				output-low;
-			};
-		};
-	};
-	pdmclkdat {
-		pdmclkdat_default_mode: pdmclkdat_default {
-			pdmclkdat_default_mux {
-				function = "pdm";
-				groups = "pdmclkdat_d_1";
-			};
-			pdmclkdat_default_cfg {
-				pins = "GPIO55", "GPIO56";
-				bias-disable;
-			};
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-battery.txt b/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-battery.txt
deleted file mode 100644
index ee125cb0e46d..000000000000
--- a/Documentation/devicetree/bindings/power/supply/stericsson,ab8500-battery.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-AB85000 PMIC contains a node, which contains shared
-information about the battery connected to the PMIC.
-The node has no compatible property.
-
-Properties of this node are:
-
-thermistor-on-batctrl:
-	A boolean value indicating thermistor interface	to battery
-
-	Note:
-	'btemp' and 'batctrl' are the pins interfaced for battery temperature
-	measurement, 'btemp' signal is used when NTC(negative temperature
-	coefficient) resister is interfaced external to battery whereas
-	'batctrl' pin is used when NTC resister is internal to battery.
-
-	Example:
-	ab8500_battery: ab8500_battery {
-		thermistor-on-batctrl;
-	};
-	indicates: NTC resister is internal to battery, 'batctrl' is used
-		for thermal measurement.
-
-	The absence of property 'thermal-on-batctrl' indicates
-	NTC resister is external to battery and  'btemp' signal is used
-	for thermal measurement.
-
-battery-type:
-	This shall be the battery manufacturing technology type,
-	allowed types are:
-		"UNKNOWN" "NiMH" "LION" "LIPO" "LiFe" "NiCd" "LiMn"
-	Example:
-	ab8500_battery: ab8500_battery {
-		stericsson,battery-type = "LIPO";
-	}
-- 
2.30.2

