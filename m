Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E65B74B1D0
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jul 2023 15:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGGNdk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jul 2023 09:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGGNdj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2023 09:33:39 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833F91997;
        Fri,  7 Jul 2023 06:33:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31454996e06so1658072f8f.2;
        Fri, 07 Jul 2023 06:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688736815; x=1691328815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c9hpFrlnlug/9WZzxp4cQywLFY/2X0wy10GoiWFbyrY=;
        b=i2pYUcmHnIAu98D6YUsFZsfN14EeOU+pRiHhwx647oZYDJaFBWCODXEs1Of5yQnwtD
         Yjs+n5HHg5dvCVI+9ipx6qVjfhH722kPn0rqkWqxHWSBEnNvG9l1CXDHU64R3xtqh+ue
         EgcgvKpRgbuj+rQMw/GBTX13mZ3STydZIIMMcXxNicnBNbeM6fNSzlKEVv7VAQfAjTba
         2ZHHvwiroc504Ifn0TVUQV09CmwVZEyK9eFVHcd+9E5Sm1SGi3DBzvIKXptZJahOZgIX
         KKKI4GXd31lG0Y8m1HNRcuwPvYw0Btvpqmnx7IpO6WAwHDYCC/9aiQgTkMnwG8EFwBLo
         +hUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688736815; x=1691328815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c9hpFrlnlug/9WZzxp4cQywLFY/2X0wy10GoiWFbyrY=;
        b=ibgnwjhGg1L0lpsrwvS6kBUjNIV6NKndM7x6ExHY5up3F5Baa3pvG78odGQGedbubW
         2rmwvrx2EQ6dB0Avz7gk4UUcNhCtqqf1Hi66rPNjsVF0AmKpTvXtW8aiqiAtvIMuodoi
         vIo3DXTigzTCAFgcWWYvMMkI5K9yEE5MFFURLO1InVk1kYMvNr+nOw3tee2Dy5HTBG8N
         Ioqws0yQCHGIzvxDspEhfo63ouMmdyUQc03PZbSc1XN51xM9mPXqhMQKQVDS3xSdRUOM
         06JyawciTVh0htzI3KUpZewvbfhAC7lVjQLXbsJNBxgQA50fyGAqWPPeAB1kJoyuOSAs
         11OQ==
X-Gm-Message-State: ABy/qLbuwYEG8TLLeSEOQozow8mqpAv3wP6pbJ1g6JGZPZQXBZ9h4Xk+
        OuQDXvZ3nMvTYVJ6LXmtw8g=
X-Google-Smtp-Source: APBJJlG+pMtdjjM6lWub4/LOF7QOzasdcbSJUxS/N0pjmsUgpDrA5amndmEt7kUFMLuOZLdePcIVHw==
X-Received: by 2002:a5d:53c9:0:b0:311:180d:cf38 with SMTP id a9-20020a5d53c9000000b00311180dcf38mr3978731wrw.24.1688736814572;
        Fri, 07 Jul 2023 06:33:34 -0700 (PDT)
Received: from localhost (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c7405000000b003fa9554fb30sm2446188wmc.44.2023.07.07.06.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 06:33:34 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] dt-bindings: thermal: tegra: Convert to json-schema
Date:   Fri,  7 Jul 2023 15:33:33 +0200
Message-ID: <20230707133333.2998802-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Convert the Tegra thermal bindings from the free-form text format to
json-schema.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../thermal/nvidia,tegra124-soctherm.txt      | 238 ------------
 .../thermal/nvidia,tegra124-soctherm.yaml     | 366 ++++++++++++++++++
 2 files changed, 366 insertions(+), 238 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
deleted file mode 100644
index aea4a2a178b9..000000000000
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
+++ /dev/null
@@ -1,238 +0,0 @@
-Tegra124 SOCTHERM thermal management system
-
-The SOCTHERM IP block contains thermal sensors, support for polled
-or interrupt-based thermal monitoring, CPU and GPU throttling based
-on temperature trip points, and handling external overcurrent
-notifications. It is also used to manage emergency shutdown in an
-overheating situation.
-
-Required properties :
-- compatible : For Tegra124, must contain "nvidia,tegra124-soctherm".
-  For Tegra132, must contain "nvidia,tegra132-soctherm".
-  For Tegra210, must contain "nvidia,tegra210-soctherm".
-- reg : Should contain at least 2 entries for each entry in reg-names:
-  - SOCTHERM register set
-  - Tegra CAR register set: Required for Tegra124 and Tegra210.
-  - CCROC register set: Required for Tegra132.
-- reg-names :  Should contain at least 2 entries:
-  - soctherm-reg
-  - car-reg
-  - ccroc-reg
-- interrupts : Defines the interrupt used by SOCTHERM
-- clocks : Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names : Must include the following entries:
-  - tsensor
-  - soctherm
-- resets : Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names : Must include the following entries:
-  - soctherm
-- #thermal-sensor-cells : Should be 1. For a description of this property, see
-     Documentation/devicetree/bindings/thermal/thermal-sensor.yaml.
-    See <dt-bindings/thermal/tegra124-soctherm.h> for a list of valid values
-    when referring to thermal sensors.
-- throttle-cfgs: A sub-node which is a container of configuration for each
-    hardware throttle events. These events can be set as cooling devices.
-  * throttle events: Sub-nodes must be named as "light" or "heavy".
-      Properties:
-      - nvidia,priority: Each throttles has its own throttle settings, so the
-        SW need to set priorities for various throttle, the HW arbiter can select
-        the final throttle settings.
-        Bigger value indicates higher priority, In general, higher priority
-        translates to lower target frequency. SW needs to ensure that critical
-        thermal alarms are given higher priority, and ensure that there is
-        no race if priority of two vectors is set to the same value.
-        The range of this value is 1~100.
-      - nvidia,cpu-throt-percent: This property is for Tegra124 and Tegra210.
-        It is the throttling depth of pulse skippers, it's the percentage
-        throttling.
-      - nvidia,cpu-throt-level: This property is only for Tegra132, it is the
-        level of pulse skippers, which used to throttle clock frequencies. It
-        indicates cpu clock throttling depth, and the depth can be programmed.
-        Must set as following values:
-        TEGRA_SOCTHERM_THROT_LEVEL_LOW, TEGRA_SOCTHERM_THROT_LEVEL_MED
-        TEGRA_SOCTHERM_THROT_LEVEL_HIGH, TEGRA_SOCTHERM_THROT_LEVEL_NONE
-      - nvidia,gpu-throt-level: This property is for Tegra124 and Tegra210.
-        It is the level of pulse skippers, which used to throttle clock
-        frequencies. It indicates gpu clock throttling depth and can be
-        programmed to any of the following values which represent a throttling
-        percentage:
-        TEGRA_SOCTHERM_THROT_LEVEL_NONE (0%)
-        TEGRA_SOCTHERM_THROT_LEVEL_LOW (50%),
-        TEGRA_SOCTHERM_THROT_LEVEL_MED (75%),
-        TEGRA_SOCTHERM_THROT_LEVEL_HIGH (85%).
-      - #cooling-cells: Should be 1. This cooling device only support on/off state.
-        For a description of this property see:
-	Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
-
-      Optional properties: The following properties are T210 specific and
-      valid only for OCx throttle events.
-      - nvidia,count-threshold: Specifies the number of OC events that are
-        required for triggering an interrupt. Interrupts are not triggered if
-        the property is missing. A value of 0 will interrupt on every OC alarm.
-      - nvidia,polarity-active-low: Configures the polarity of the OC alaram
-        signal. If present, this means assert low, otherwise assert high.
-      - nvidia,alarm-filter: Number of clocks to filter event. When the filter
-        expires (which means the OC event has not occurred for a long time),
-        the counter is cleared and filter is rearmed. Default value is 0.
-      - nvidia,throttle-period-us: Specifies the number of uSec for which
-        throttling is engaged after the OC event is deasserted. Default value
-        is 0.
-
-Optional properties:
-- nvidia,thermtrips : When present, this property specifies the temperature at
-  which the soctherm hardware will assert the thermal trigger signal to the
-  Power Management IC, which can be configured to reset or shutdown the device.
-  It is an array of pairs where each pair represents a tsensor id followed by a
-  temperature in milli Celcius. In the absence of this property the critical
-  trip point will be used for thermtrip temperature.
-
-Note:
-- the "critical" type trip points will be used to set the temperature at which
-the SOC_THERM hardware will assert a thermal trigger if the "nvidia,thermtrips"
-property is missing. When the thermtrips property is present, the breach of a
-critical trip point is reported back to the thermal framework to implement
-software shutdown.
-
-- the "hot" type trip points will be set to SOC_THERM hardware as the throttle
-temperature. Once the temperature of this thermal zone is higher
-than it, it will trigger the HW throttle event.
-
-Example :
-
-	soctherm@700e2000 {
-		compatible = "nvidia,tegra124-soctherm";
-		reg = <0x0 0x700e2000 0x0 0x600  /* SOC_THERM reg_base */
-			0x0 0x60006000 0x0 0x400 /* CAR reg_base */
-		reg-names = "soctherm-reg", "car-reg";
-		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&tegra_car TEGRA124_CLK_TSENSOR>,
-			<&tegra_car TEGRA124_CLK_SOC_THERM>;
-		clock-names = "tsensor", "soctherm";
-		resets = <&tegra_car 78>;
-		reset-names = "soctherm";
-
-		#thermal-sensor-cells = <1>;
-
-		nvidia,thermtrips = <TEGRA124_SOCTHERM_SENSOR_CPU 102500
-				     TEGRA124_SOCTHERM_SENSOR_GPU 103000>;
-
-		throttle-cfgs {
-			/*
-			 * When the "heavy" cooling device triggered,
-			 * the HW will skip cpu clock's pulse in 85% depth,
-			 * skip gpu clock's pulse in 85% level
-			 */
-			throttle_heavy: heavy {
-				nvidia,priority = <100>;
-				nvidia,cpu-throt-percent = <85>;
-				nvidia,gpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_HIGH>;
-
-				#cooling-cells = <1>;
-			};
-
-			/*
-			 * When the "light" cooling device triggered,
-			 * the HW will skip cpu clock's pulse in 50% depth,
-			 * skip gpu clock's pulse in 50% level
-			 */
-			throttle_light: light {
-				nvidia,priority = <80>;
-				nvidia,cpu-throt-percent = <50>;
-				nvidia,gpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_LOW>;
-
-				#cooling-cells = <1>;
-			};
-
-			/*
-			 * If these two devices are triggered in same time, the HW throttle
-			 * arbiter will select the highest priority as the final throttle
-			 * settings to skip cpu pulse.
-			 */
-
-			throttle_oc1: oc1 {
-				nvidia,priority = <50>;
-				nvidia,polarity-active-low;
-				nvidia,count-threshold = <100>;
-				nvidia,alarm-filter = <5100000>;
-				nvidia,throttle-period-us = <0>;
-				nvidia,cpu-throt-percent = <75>;
-				nvidia,gpu-throt-level =
-						<TEGRA_SOCTHERM_THROT_LEVEL_MED>;
-                        };
-		};
-	};
-
-Example: referring to Tegra132's "reg", "reg-names" and "throttle-cfgs" :
-
-	soctherm@700e2000 {
-		compatible = "nvidia,tegra132-soctherm";
-		reg = <0x0 0x700e2000 0x0 0x600  /* SOC_THERM reg_base */
-			0x0 0x70040000 0x0 0x200>; /* CCROC reg_base */;
-		reg-names = "soctherm-reg", "ccroc-reg";
-
-		throttle-cfgs {
-			/*
-			 * When the "heavy" cooling device triggered,
-			 * the HW will skip cpu clock's pulse in HIGH level
-			 */
-			throttle_heavy: heavy {
-				nvidia,priority = <100>;
-				nvidia,cpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_HIGH>;
-
-				#cooling-cells = <1>;
-			};
-
-			/*
-			 * When the "light" cooling device triggered,
-			 * the HW will skip cpu clock's pulse in MED level
-			 */
-			throttle_light: light {
-				nvidia,priority = <80>;
-				nvidia,cpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_MED>;
-
-				#cooling-cells = <1>;
-			};
-
-			/*
-			 * If these two devices are triggered in same time, the HW throttle
-			 * arbiter will select the highest priority as the final throttle
-			 * settings to skip cpu pulse.
-			 */
-
-		};
-	};
-
-Example: referring to thermal sensors :
-
-       thermal-zones {
-                cpu {
-                        polling-delay-passive = <1000>;
-                        polling-delay = <1000>;
-
-                        thermal-sensors =
-                                <&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
-
-			trips {
-				cpu_shutdown_trip: shutdown-trip {
-					temperature = <102500>;
-					hysteresis = <1000>;
-					type = "critical";
-				};
-
-				cpu_throttle_trip: throttle-trip {
-					temperature = <100000>;
-					hysteresis = <1000>;
-					type = "hot";
-				};
-			};
-
-			cooling-maps {
-				map0 {
-					trip = <&cpu_throttle_trip>;
-					cooling-device = <&throttle_heavy 1 1>;
-				};
-			};
-                };
-	};
diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
new file mode 100644
index 000000000000..4677ad6645a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
@@ -0,0 +1,366 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/nvidia,tegra124-soctherm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra124 SOCTHERM Thermal Management System
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+
+description: The SOCTHERM IP block contains thermal sensors, support for
+  polled or interrupt-based thermal monitoring, CPU and GPU throttling based
+  on temperature trip points, and handling external overcurrent notifications.
+  It is also used to manage emergency shutdown in an overheating situation.
+
+properties:
+  compatible:
+    enum:
+      - nvidia,tegra124-soctherm
+      - nvidia,tegra132-soctherm
+      - nvidia,tegra210-soctherm
+
+  reg:
+    minItems: 2
+    maxItems: 2
+
+  reg-names:
+    minItems: 2
+    maxItems: 2
+
+  interrupts:
+    items:
+      - description: module interrupt
+      - description: EDP interrupt
+
+  interrupt-names:
+    items:
+      - const: thermal
+      - const: edp
+
+  clocks:
+    items:
+      - description: thermal sensor clock
+      - description: module clock
+
+  clock-names:
+    items:
+      - const: tsensor
+      - const: soctherm
+
+  resets:
+    items:
+      - description: module reset
+
+  reset-names:
+    items:
+      - const: soctherm
+
+  "#thermal-sensor-cells":
+    const: 1
+
+  throttle-cfgs:
+    $ref: thermal-cooling-devices.yaml
+    description: A sub-node which is a container of configuration for each
+      hardware throttle events. These events can be set as cooling devices.
+      Throttle event sub-nodes must be named as "light" or "heavy".
+    patternProperties:
+      "^(light|heavy)$":
+        type: object
+        properties:
+          nvidia,priority:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            minimum: 1
+            maximum: 100
+            description: Each throttles has its own throttle settings, so the
+              SW need to set priorities for various throttle, the HW arbiter
+              can select the final throttle settings. Bigger value indicates
+              higher priority, In general, higher priority translates to lower
+              target frequency. SW needs to ensure that critical thermal
+              alarms are given higher priority, and ensure that there is no
+              race if priority of two vectors is set to the same value.
+
+          nvidia,cpu-throt-percent:
+            description: This property is for Tegra124 and Tegra210. It is the
+              throttling depth of pulse skippers, it's the percentage
+              throttling.
+
+          nvidia,cpu-throt-level:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: This property is only for Tegra132, it is the level
+              of pulse skippers, which used to throttle clock frequencies. It
+              indicates cpu clock throttling depth, and the depth can be
+              programmed.
+            enum:
+              # none (TEGRA_SOCTHERM_THROT_LEVEL_NONE)
+              - 0
+              # low (TEGRA_SOCTHERM_THROT_LEVEL_LOW)
+              - 1
+              # medium (TEGRA_SOCTHERM_THROT_LEVEL_MED)
+              - 2
+              # high (TEGRA_SOCTHERM_THROT_LEVEL_HIGH)
+              - 3
+
+          nvidia,gpu-throt-level:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: This property is for Tegra124 and Tegra210. It is the
+              level of pulse skippers, which used to throttle clock
+              frequencies. It indicates gpu clock throttling depth and can be
+              programmed to any of the following values which represent a
+              throttling percentage.
+            enum:
+              # none (0%, TEGRA_SOCTHERM_THROT_LEVEL_NONE)
+              - 0
+              # low (50%, TEGRA_SOCTHERM_THROT_LEVEL_LOW)
+              - 1
+              # medium (75%, TEGRA_SOCTHERM_THROT_LEVEL_MED)
+              - 2
+              # high (85%, TEGRA_SOCTHERM_THROT_LEVEL_HIGH)
+              - 3
+
+          # optional
+          # Tegra210 specific and valid only for OCx throttle events
+          nvidia,count-threshold:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: Specifies the number of OC events that are required
+              for triggering an interrupt. Interrupts are not triggered if the
+              property is missing. A value of 0 will interrupt on every OC
+              alarm.
+
+          nvidia,polarity-active-low:
+            $ref: /schemas/types.yaml#/definitions/flag
+            description: Configures the polarity of the OC alaram signal. If
+              present, this means assert low, otherwise assert high.
+
+          nvidia,alarm-filter:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: Number of clocks to filter event. When the filter
+              expires (which means the OC event has not occurred for a long
+              time), the counter is cleared and filter is rearmed.
+            default: 0
+
+          nvidia,throttle-period-us:
+            description: Specifies the number of microseconds for which
+              throttling is engaged after the OC event is deasserted.
+            default: 0
+
+  # optional
+  nvidia,thermtrips:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description: |
+      When present, this property specifies the temperature at which the
+      SOCTHERM hardware will assert the thermal trigger signal to the Power
+      Management IC, which can be configured to reset or shutdown the device.
+      It is an array of pairs where each pair represents a tsensor ID followed
+      by a temperature in milli Celcius. In the absence of this property the
+      critical trip point will be used for thermtrip temperature.
+
+      Note:
+      - the "critical" type trip points will be used to set the temperature at
+        which the SOCTHERM hardware will assert a thermal trigger if the
+        "nvidia,thermtrips" property is missing.  When the thermtrips property
+        is present, the breach of a critical trip point is reported back to
+        the thermal framework to implement software shutdown.
+
+      - the "hot" type trip points will be set to SOCTHERM hardware as the
+        throttle temperature.  Once the temperature of this thermal zone is
+        higher than it, it will trigger the HW throttle event.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - "#thermal-sensor-cells"
+
+allOf:
+  - $ref: thermal-sensor.yaml
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra124-soctherm
+              - nvidia,tegra210-soctherm
+    then:
+      properties:
+        reg:
+          items:
+            - description: SOCTHERM register set
+            - description: clock and reset controller registers
+
+        reg-names:
+          items:
+            - const: soctherm-reg
+            - const: car-reg
+
+    else:
+      properties:
+        reg:
+          items:
+            - description: SOCTHERM register set
+            - description: CCROC registers
+
+        reg-names:
+          items:
+            - const: soctherm-reg
+            - const: ccroc-reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra124-car.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/thermal/tegra124-soctherm.h>
+
+    soctherm@700e2000 {
+        compatible = "nvidia,tegra124-soctherm";
+        reg = <0x700e2000 0x600>, /* SOC_THERM reg_base */
+              <0x60006000 0x400>; /* CAR reg_base */
+        reg-names = "soctherm-reg", "car-reg";
+        interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "thermal", "edp";
+        clocks = <&tegra_car TEGRA124_CLK_TSENSOR>,
+                 <&tegra_car TEGRA124_CLK_SOC_THERM>;
+        clock-names = "tsensor", "soctherm";
+        resets = <&tegra_car 78>;
+        reset-names = "soctherm";
+
+        #thermal-sensor-cells = <1>;
+
+        nvidia,thermtrips = <TEGRA124_SOCTHERM_SENSOR_CPU 102500>,
+                            <TEGRA124_SOCTHERM_SENSOR_GPU 103000>;
+
+        throttle-cfgs {
+            /*
+             * When the "heavy" cooling device triggered,
+             * the HW will skip cpu clock's pulse in 85% depth,
+             * skip gpu clock's pulse in 85% level
+             */
+            heavy {
+                nvidia,priority = <100>;
+                nvidia,cpu-throt-percent = <85>;
+                nvidia,gpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_HIGH>;
+
+                #cooling-cells = <2>;
+            };
+
+            /*
+             * When the "light" cooling device triggered,
+             * the HW will skip cpu clock's pulse in 50% depth,
+             * skip gpu clock's pulse in 50% level
+             */
+            light {
+                nvidia,priority = <80>;
+                nvidia,cpu-throt-percent = <50>;
+                nvidia,gpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_LOW>;
+
+                #cooling-cells = <2>;
+            };
+
+            /*
+             * If these two devices are triggered in same time, the HW throttle
+             * arbiter will select the highest priority as the final throttle
+             * settings to skip cpu pulse.
+             */
+
+            oc1 {
+                nvidia,priority = <50>;
+                nvidia,polarity-active-low;
+                nvidia,count-threshold = <100>;
+                nvidia,alarm-filter = <5100000>;
+                nvidia,throttle-period-us = <0>;
+                nvidia,cpu-throt-percent = <75>;
+                nvidia,gpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_MED>;
+            };
+        };
+    };
+
+  # referring to Tegra132's "reg", "reg-names" and "throttle-cfgs"
+  - |
+    thermal-sensor@700e2000 {
+        compatible = "nvidia,tegra132-soctherm";
+        reg = <0x700e2000 0x600>, /* SOC_THERM reg_base */
+              <0x70040000 0x200>; /* CCROC reg_base */
+        reg-names = "soctherm-reg", "ccroc-reg";
+        interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "thermal", "edp";
+        clocks = <&tegra_car TEGRA124_CLK_TSENSOR>,
+                 <&tegra_car TEGRA124_CLK_SOC_THERM>;
+        clock-names = "tsensor", "soctherm";
+        resets = <&tegra_car 78>;
+        reset-names = "soctherm";
+        #thermal-sensor-cells = <1>;
+
+        throttle-cfgs {
+            /*
+             * When the "heavy" cooling device triggered,
+             * the HW will skip cpu clock's pulse in HIGH level
+             */
+            heavy {
+                nvidia,priority = <100>;
+                nvidia,cpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_HIGH>;
+
+                #cooling-cells = <2>;
+            };
+
+            /*
+             * When the "light" cooling device triggered,
+             * the HW will skip cpu clock's pulse in MED level
+             */
+            light {
+                nvidia,priority = <80>;
+                nvidia,cpu-throt-level = <TEGRA_SOCTHERM_THROT_LEVEL_MED>;
+
+                #cooling-cells = <2>;
+            };
+
+            /*
+             * If these two devices are triggered in same time, the HW throttle
+             * arbiter will select the highest priority as the final throttle
+             * settings to skip cpu pulse.
+             */
+        };
+    };
+
+  # referring to thermal sensors
+  - |
+    thermal-zones {
+        cpu-thermal {
+            polling-delay-passive = <1000>;
+            polling-delay = <1000>;
+
+            thermal-sensors = <&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
+
+            trips {
+                cpu_shutdown_trip: shutdown-trip {
+                    temperature = <102500>;
+                    hysteresis = <1000>;
+                    type = "critical";
+                };
+
+                cpu_throttle_trip: throttle-trip {
+                    temperature = <100000>;
+                    hysteresis = <1000>;
+                    type = "hot";
+                };
+            };
+
+            cooling-maps {
+                map0 {
+                    trip = <&cpu_throttle_trip>;
+                    cooling-device = <&throttle_heavy 1 1>;
+                };
+            };
+        };
+    };
-- 
2.41.0

