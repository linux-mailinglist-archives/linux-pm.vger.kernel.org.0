Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2F4C192131
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 07:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgCYGfP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 02:35:15 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:44674 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbgCYGfO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 02:35:14 -0400
Received: by mail-pf1-f179.google.com with SMTP id b72so551010pfb.11
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2020 23:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eeiOAr1bPpvgXy0vhV//U7er0O9Q5/zHZMycxpnng7U=;
        b=zVbM/vDoASONJRxczunDLcJbykdpbVYDWp56GDRY9NT+E8zkY3q9vTNyv8aitwIJ1W
         7KtR6atqm3ahQNF4+593dilj+M5S8i2Knwj0q15hhRlLTP91s72UqiBVgSk7E56wbCYO
         u03TEfoZWKTNbm3oYmUXG6HymfxcytpObA1CXRzxKCbDo0A4mxa8o2IDL7GzXquYfdki
         JgbTxZLMN4JutK7WaJzecvi6838TiupSJ+RALPTA5lhqVpwV+GGWlsrKOdqDtw1aWjIZ
         1Rq30KV+7vgkBlcDG9wzBSXnmLn1CSkC1ggDHBed0xhIpY8+rvMVjzh4+NDNFqa487j9
         0mHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eeiOAr1bPpvgXy0vhV//U7er0O9Q5/zHZMycxpnng7U=;
        b=qYfze2uCtsNkFIzBaG6vATgt319ZRGCwg1b+iEcOf6riomXgrfrn0iz9/5CaF9skiN
         uGUmW+5R0IsO1ymJM/RTdYSJ7hg//EH07l6UzFNg9g7G3u5+oyVmuj+VLMR68Qw2CWkT
         W62PYRdX+S4dkz7eXCDvpwt05bcuYhHukOaO8koTgjcHiJJZcDvZCCw+Rowu7mPufGvP
         w9ENcj42go6VkzAT8XQjb+7B8foWsuORx61oU/8/SVW3yq/nWjLIibHX6RVI1bHviP0Z
         dntyf4/f2hPONV4KCZsfbgZnhVjmQrTmX4+qUozm7sqQBWKZN1h2nKexhva08Jj+vfAj
         ANoQ==
X-Gm-Message-State: ANhLgQ0ov6DTdd6CjU5mQJk3yZL9EAUlPo3K6mSPw6Dzki2xENAdyplo
        t6NjDUTk/KZUey9jrr1+9Du2EQ==
X-Google-Smtp-Source: ADFU+vvvl1TC9EwH+BfAnIxTjtl8CuJxMiTIRZEDEth1Hm29rNHfOKYBJOE0Au5c5QF4PKDwk9Prag==
X-Received: by 2002:a63:7e1a:: with SMTP id z26mr1640261pgc.226.1585118112739;
        Tue, 24 Mar 2020 23:35:12 -0700 (PDT)
Received: from localhost ([103.195.202.71])
        by smtp.gmail.com with ESMTPSA id 184sm16020779pgb.52.2020.03.24.23.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 23:35:11 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 3/3] dt-bindings: thermal: Add yaml bindings for thermal zones
Date:   Wed, 25 Mar 2020 12:04:54 +0530
Message-Id: <9c447186008ef2e3f4c3e712458dc0ddcd8a8b03.1585117436.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1585117436.git.amit.kucheria@linaro.org>
References: <cover.1585117436.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As part of moving the thermal bindings to YAML, split it up into 3
bindings: thermal sensors, cooling devices and thermal zones.

The thermal-zone binding is a software abstraction to capture the
properties of each zone - how often they should be checked, the
temperature thresholds (trips) at which mitigation actions need to be
taken and the level of mitigation needed at those thresholds.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
Changes since v2:
- Addressed review comment from Rob
- Added required properties for thermal-zones node
- Added select: true to thermal-cooling-devices.yaml
- Fixed up example to pass dt_binding_check

 .../bindings/thermal/thermal-zones.yaml       | 324 ++++++++++++++++++
 1 file changed, 324 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
new file mode 100644
index 000000000000..5632304dcf62
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -0,0 +1,324 @@
+# SPDX-License-Identifier: (GPL-2.0)
+# Copyright 2020 Linaro Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
+$schema: http://devicetree.org/meta-schemas/base.yaml#
+
+title: Thermal zone binding
+
+maintainers:
+  - Amit Kucheria <amitk@kernel.org>
+
+description: |
+  Thermal management is achieved in devicetree by describing the sensor hardware
+  and the software abstraction of cooling devices and thermal zones required to
+  take appropriate action to mitigate thermal overloads.
+
+  The following node types are used to completely describe a thermal management
+  system in devicetree:
+   - thermal-sensor: device that measures temperature, has SoC-specific bindings
+   - cooling-device: device used to dissipate heat either passively or actively
+   - thermal-zones: a container of the following node types used to describe all
+     thermal data for the platform
+
+  This binding describes the thermal-zones.
+
+  The polling-delay properties of a thermal-zone are bound to the maximum dT/dt
+  (temperature derivative over time) in two situations for a thermal zone:
+    1. when passive cooling is activated (polling-delay-passive)
+    2. when the zone just needs to be monitored (polling-delay) or when
+       active cooling is activated.
+
+  The maximum dT/dt is highly bound to hardware power consumption and
+  dissipation capability. The delays should be chosen to account for said
+  max dT/dt, such that a device does not cross several trip boundaries
+  unexpectedly between polls. Choosing the right polling delays shall avoid
+  having the device in temperature ranges that may damage the silicon structures
+  and reduce silicon lifetime.
+
+properties:
+  $nodename:
+    const: thermal-zones
+    description:
+      A /thermal-zones node is required in order to use the thermal framework to
+      manage input from the various thermal zones in the system in order to
+      mitigate thermal overload conditions. It does not represent a real device
+      in the system, but acts as a container to link thermal sensor devices,
+      platform-data regarding temperature thresholds and the mitigation actions
+      to take when the temperature crosses those thresholds.
+
+patternProperties:
+  "^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$":
+    type: object
+    description:
+      Each thermal zone node contains information about how frequently it
+      must be checked, the sensor responsible for reporting temperature for
+      this zone, one sub-node containing the various trip points for this
+      zone and one sub-node containing all the zone cooling-maps.
+
+    properties:
+      polling-delay:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The maximum number of milliseconds to wait between polls when
+          checking this thermal zone. Setting this to 0 disables the polling
+          timers setup by the thermal framework and assumes that the thermal
+          sensors in this zone support interrupts.
+
+      polling-delay-passive:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The maximum number of milliseconds to wait between polls when
+          checking this thermal zone while doing passive cooling. Setting
+          this to 0 disables the polling timers setup by the thermal
+          framework and assumes that the thermal sensors in this zone
+          support interrupts.
+
+      thermal-sensors:
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        description:
+          A list of thermal sensor phandles and sensor specifiers used to
+          monitor this thermal zone.
+
+      trips:
+        type: object
+        description:
+          This node describes a set of points in the temperature domain at
+          which the thermal framework needs to takes action. The actions to
+          be taken are defined in another node called cooling-maps.
+
+        patternProperties:
+          "^[a-zA-Z][a-zA-Z0-9\\-_]{0,63}$":
+            type: object
+
+            properties:
+              temperature:
+                $ref: /schemas/types.yaml#/definitions/int32
+                minimum: -273000
+                maximum: 200000
+                description:
+                  An integer expressing the trip temperature in millicelsius.
+
+              hysteresis:
+                $ref: /schemas/types.yaml#/definitions/uint32
+                description:
+                  An unsigned integer expressing the hysteresis delta with
+                  respect to the trip temperature property above, also in
+                  millicelsius.
+
+              type:
+                $ref: /schemas/types.yaml#/definitions/string
+                enum:
+                  - active   # enable active cooling e.g. fans
+                  - passive  # enable passive cooling e.g. throttling cpu
+                  - hot      # send notification to driver
+                  - critical # send notification to driver, trigger shutdown
+                description: |
+                  There are four valid trip types: active, passive, hot,
+                  critical.
+
+                  The critical trip type is used to set the maximum
+                  temperature threshold above which the HW becomes
+                  unstable and underlying firmware might even trigger a
+                  reboot. Hitting the critical threshold triggers a system
+                  shutdown.
+
+                  The hot trip type can be used to send a notification to
+                  the thermal driver (if a .notify callback is registered).
+                  The action to be taken is left to the driver.
+
+                  The passive trip type can be used to slow down HW e.g. run
+                  the CPU, GPU, bus at a lower frequency.
+
+                  The active trip type can be used to control other HW to
+                  help in cooling e.g. fans can be sped up or slowed down
+
+            required:
+              - temperature
+              - hysteresis
+              - type
+            additionalProperties: false
+
+        additionalProperties: false
+
+      cooling-maps:
+        type: object
+        description:
+          This node describes the action to be taken when a thermal zone
+          crosses one of the temperature thresholds described in the trips
+          node. The action takes the form of a mapping relation between a
+          trip and the target cooling device state.
+
+        patternProperties:
+          "^map[-a-zA-Z0-9]*$":
+            type: object
+
+            properties:
+              trip:
+                $ref: /schemas/types.yaml#/definitions/phandle
+                description:
+                  A phandle of a trip point node within this thermal zone.
+
+              cooling-device:
+                $ref: /schemas/types.yaml#/definitions/phandle-array
+                description:
+                  A list of cooling device phandles along with the minimum
+                  and maximum cooling state specifiers for each cooling
+                  device. Using the THERMAL_NO_LIMIT (-1UL) constant in the
+                  cooling-device phandle limit specifier lets the framework
+                  use the minimum and maximum cooling state for that cooling
+                  device automatically.
+
+              contribution:
+                $ref: /schemas/types.yaml#/definitions/uint32
+                minimum: 0
+                maximum: 100
+                description:
+                  The contribution of the cooling devices at the trip
+                  temperature, both referenced in this map, to this thermal
+                  zone as a percentage.
+
+            required:
+              - trip
+              - cooling-device
+            additionalProperties: false
+
+    required:
+      - polling-delay
+      - polling-delay-passive
+      - thermal-sensors
+      - trips
+    additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/thermal/thermal.h>
+
+    // Example 1: SDM845 TSENS
+    soc: soc@0 {
+            #address-cells = <2>;
+            #size-cells = <2>;
+
+            /* ... */
+
+            tsens0: thermal-sensor@c263000 {
+                    compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+                    reg = <0 0x0c263000 0 0x1ff>, /* TM */
+                          <0 0x0c222000 0 0x1ff>; /* SROT */
+                    #qcom,sensors = <13>;
+                    interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>,
+                                 <GIC_SPI 508 IRQ_TYPE_LEVEL_HIGH>;
+                    interrupt-names = "uplow", "critical";
+                    #thermal-sensor-cells = <1>;
+            };
+
+            tsens1: thermal-sensor@c265000 {
+                    compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+                    reg = <0 0x0c265000 0 0x1ff>, /* TM */
+                          <0 0x0c223000 0 0x1ff>; /* SROT */
+                    #qcom,sensors = <8>;
+                    interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>,
+                                 <GIC_SPI 509 IRQ_TYPE_LEVEL_HIGH>;
+                    interrupt-names = "uplow", "critical";
+                    #thermal-sensor-cells = <1>;
+            };
+    };
+
+    /* ... */
+
+    thermal-zones {
+            cpu0-thermal {
+                    polling-delay-passive = <250>;
+                    polling-delay = <1000>;
+
+                    thermal-sensors = <&tsens0 1>;
+
+                    trips {
+                            cpu0_alert0: trip-point0 {
+                                    temperature = <90000>;
+                                    hysteresis = <2000>;
+                                    type = "passive";
+                            };
+
+                            cpu0_alert1: trip-point1 {
+                                    temperature = <95000>;
+                                    hysteresis = <2000>;
+                                    type = "passive";
+                            };
+
+                            cpu0_crit: cpu_crit {
+                                    temperature = <110000>;
+                                    hysteresis = <1000>;
+                                    type = "critical";
+                            };
+                    };
+
+                    cooling-maps {
+                            map0 {
+                                    trip = <&cpu0_alert0>;
+                                    cooling-device = <&CPU0 THERMAL_NO_LIMIT
+                                                            THERMAL_NO_LIMIT>,
+                                                     <&CPU1 THERMAL_NO_LIMIT
+                                                            THERMAL_NO_LIMIT>,
+                                                     <&CPU2 THERMAL_NO_LIMIT
+                                                            THERMAL_NO_LIMIT>,
+                                                     <&CPU3 THERMAL_NO_LIMIT
+                                                            THERMAL_NO_LIMIT>;
+                            };
+
+                            map1 {
+                                    trip = <&cpu0_alert1>;
+                                    cooling-device = <&CPU0 THERMAL_NO_LIMIT
+                                                            THERMAL_NO_LIMIT>,
+                                                     <&CPU1 THERMAL_NO_LIMIT
+                                                            THERMAL_NO_LIMIT>,
+                                                     <&CPU2 THERMAL_NO_LIMIT
+                                                            THERMAL_NO_LIMIT>,
+                                                     <&CPU3 THERMAL_NO_LIMIT
+                                                            THERMAL_NO_LIMIT>;
+                            };
+                    };
+            };
+
+            /* ... */
+
+            cluster0-thermal {
+                    polling-delay-passive = <250>;
+                    polling-delay = <1000>;
+
+                    thermal-sensors = <&tsens0 5>;
+
+                    trips {
+                            cluster0_alert0: trip-point0 {
+                                    temperature = <90000>;
+                                    hysteresis = <2000>;
+                                    type = "hot";
+                            };
+                            cluster0_crit: cluster0_crit {
+                                    temperature = <110000>;
+                                    hysteresis = <2000>;
+                                    type = "critical";
+                            };
+                    };
+            };
+
+            /* ... */
+
+            gpu-top-thermal {
+                    polling-delay-passive = <250>;
+                    polling-delay = <1000>;
+
+                    thermal-sensors = <&tsens0 11>;
+
+                    trips {
+                            gpu1_alert0: trip-point0 {
+                                    temperature = <90000>;
+                                    hysteresis = <2000>;
+                                    type = "hot";
+                            };
+                    };
+            };
+    };
+...
-- 
2.20.1

