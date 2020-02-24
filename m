Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF4A5169F32
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 08:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgBXH0A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 02:26:00 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41887 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbgBXHZ4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 02:25:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id t14so3682479plr.8
        for <linux-pm@vger.kernel.org>; Sun, 23 Feb 2020 23:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J1gAzTYfSIPQWBo5afUVA7fbeA6fOiqj7Y8eCbgr5WQ=;
        b=Qn6AqQ1HolgmgiER4czPVmMw1y7AzSpzYl5JzzWyI16mnEjGkzrEx3Vnk+MNDX4BbT
         M4S6EzHkI1MLZpcS5W/Hq9vOghtcgsKmP67bEj9rZDh8EXFbKSyYRYJ4aMlN1GwI2g60
         pl1nl45YntLmjrRcujhaoi0reGDb/Y9vnhuA+OCAK4l/0BXDLjFOgrqXAIilITF4gKkn
         BtIf/5adaEWovn2prsDh63wA2U0DNXlnA2UdieB+n/am8fSxqLEYjdNHEQ/u2YUYtIoz
         UCaQH/m8v2kIfggdYzSOXvYz2GRZ4RJ/uc2Vlg+caN5eIKBSIy7PBU1wMlncDsoEPlEi
         bwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J1gAzTYfSIPQWBo5afUVA7fbeA6fOiqj7Y8eCbgr5WQ=;
        b=DMbjiAoGs50hTQ1PpHTisX85MExmuK5NOP22aG3RDS+JNspxDhSWDMXuaJnZHVAEy7
         IPV/WDAjinqiqdB+4ArJjh7iLH5V+DjA/iIATqDf0e1OZSPCI9r7JnPUJkMcmN/6w3Wl
         J9lYRaabVM5nHrLZ5oA1VFQpPgs7bRC0/CxFmjK3sl+5FjfNjfxouYmeAXO6J2DZqzuQ
         s9ELlWj8q8CUxIcxOzwcmWXL0HVxIKMsIomxqEBVHmeNYKKHetAKd+/pHVHnvmSATOI/
         Q9kpK94xsvkNuQr7WILFkzxBca7d9674NeBqigiC7zdRkebP8aN0v+4Ai2RJCzPbAHyg
         NaBw==
X-Gm-Message-State: APjAAAV77MPVJDjzSbsMun1GTl/xUxMlOCvgoqOt+jgAAGDSKPCegUAI
        8x/i77PD+/W/J/8qKk/v+7gWkw==
X-Google-Smtp-Source: APXvYqyYdLmanIqj6aKVNUA2vF4Ylji4MeLP4dTsLHYQQX8i2z0K2Qky7Vvj8EouL56tkcxxVxTBFQ==
X-Received: by 2002:a17:90a:3a86:: with SMTP id b6mr18448172pjc.96.1582529154491;
        Sun, 23 Feb 2020 23:25:54 -0800 (PST)
Received: from localhost ([45.127.44.57])
        by smtp.gmail.com with ESMTPSA id q6sm11408012pfh.127.2020.02.23.23.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 23:25:53 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC PATCH v1 3/3] dt-bindings: thermal: Add yaml bindings for thermal zones
Date:   Mon, 24 Feb 2020 12:55:37 +0530
Message-Id: <59d24f8ec98e29d119c5cbdb2abe6d4644cc51cf.1582528977.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582528977.git.amit.kucheria@linaro.org>
References: <cover.1582528977.git.amit.kucheria@linaro.org>
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
 .../bindings/thermal/thermal-zones.yaml       | 302 ++++++++++++++++++
 1 file changed, 302 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
new file mode 100644
index 000000000000..bc1ce8e41324
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -0,0 +1,302 @@
+# SPDX-License-Identifier: (GPL-2.0 OR MIT)
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
+   - cooling-device: device used to dissipate heat either passively or artively
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
+  thermal-zones:
+    type: object
+    description:
+      A /thermal-zones node is required in order to use the thermal framework to
+      manage input from the various thermal zones in the system in order to
+      mitigate thermal overload conditions. It does not represent a real device
+      in the system, but acts as a container to link thermal sensor devices,
+      platform-data regarding temperature thresholds and the mitigation actions
+      to take when the temperature crosses those thresholds.
+
+    properties:
+      $nodename:
+        pattern: "^[a-zA-Z][a-zA-Z0-9,\\-]{1,12}-thermal$"
+        type: object
+        description:
+          Each thermal zone node contains information about how frequently it
+          must be checked, the sensor responsible for reporting temperature for
+          this zone, one sub-node containing the various trip points for this
+          zone and one sub-node containing all the zone cooling-maps.
+
+        properties:
+          polling-delay:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            minimum: 0
+            description:
+              The maximum number of milliseconds to wait between polls when
+              checking this thermal zone. Setting this to 0 disables the polling
+              timers setup by the thermal framework and assumes that the thermal
+              sensors in this zone support interrupts.
+
+          polling-delay-passive:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            minimum: 0
+            description:
+              The maximum number of milliseconds to wait between polls when
+              checking this thermal zone while doing passive cooling. Setting
+              this to 0 disables the polling timers setup by the thermal
+              framework and assumes that the thermal sensors in this zone
+              support interrupts.
+
+          thermal-sensors:
+            $ref: /schemas/types.yaml#/definitions/phandle-array
+            description:
+              A list of thermal sensor phandles and sensor specifiers used to
+              monitor this thermal zone.
+
+          trips:
+            type: object
+            description:
+              This node describes a set of points in the temperature domain at
+              which the thermal framework needs to takes action. The actions to
+              be taken are defined in another node called cooling-maps.
+
+            patternProperties:
+              "^[a-zA-Z][a-zA-Z0-9,+\\._]{0,63}$":
+                type: object
+
+                properties:
+                  temperature:
+                    $ref: /schemas/types.yaml#/definitions/int32
+                    description:
+                      An integer expressing the trip temperature in millicelsius.
+
+                  hysteresis:
+                    $ref: /schemas/types.yaml#/definitions/uint32
+                    description:
+                      An unsigned integer expressing the hysteresis delta with
+                      respect to the trip temperature property above, also in
+                      millicelsius.
+
+                  type:
+                    oneOf:
+                      - items:
+                        - enum:
+                            - active
+                            - passive
+                            - hot
+                            - critical
+                    description: |
+                      There are four valid trip types,
+                       - active   - enable active cooling e.g. fans
+                       - passive  - enable passive cooling e.g. throttling cpu
+                       - hot      - send notification to driver if .notify
+                                    callback registered
+                       - critical - send notification to driver if .notify
+                                    callback registered and trigger a shutdown
+
+                required:
+                  - temperature
+                  - hysteresis
+                  - type
+
+          cooling-maps:
+            type: object
+            description:
+              This node describes the action to be taken when a thermal zone
+              crosses one of the temperature thresholds described in the trips
+              node. The action takes the form of a mapping relation between a
+              trip and the target cooling device state.
+
+            patternProperties:
+              "^map[0-9][-a-zA-Z0-9]*$":
+                type: object
+
+                properties:
+                  trip:
+                    $ref: /schemas/types.yaml#/definitions/phandle
+                    description:
+                      A phandle of a trip point node within this thermal zone.
+
+                  cooling-device:
+                    $ref: /schemas/types.yaml#/definitions/phandle-array
+                    description:
+                      A list of cooling device phandles along with the minimum
+                      and maximum cooling state specifiers for each cooling
+                      device. Using the THERMAL_NO_LIMIT (-1UL) constant in the
+                      cooling-device phandle limit specifier lets the framework
+                      use the minimum and maximum cooling state for that cooling
+                      device automatically.
+
+                  contribution:
+                    $ref: /schemas/types.yaml#/definitions/uint32
+                    minimum: 0
+                    maximum: 100
+                    description:
+                      The contribution of the cooling devices at the trip
+                      temperature, both referenced in this map, to this thermal
+                      zone as a percentage.
+
+                required:
+                  - trip
+                  - cooling-device
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
+                    interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
+                    interrupt-names = "uplow";
+                    #thermal-sensor-cells = <1>;
+            };
+
+            tsens1: thermal-sensor@c265000 {
+                    compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+                    reg = <0 0x0c265000 0 0x1ff>, /* TM */
+                          <0 0x0c223000 0 0x1ff>; /* SROT */
+                    #qcom,sensors = <8>;
+                    interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>;
+                    interrupt-names = "uplow";
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
+            gpu-thermal-top {
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

