Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C22BE17A5D0
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2020 13:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCEM5D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Mar 2020 07:57:03 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53142 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgCEM5C (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Mar 2020 07:57:02 -0500
Received: by mail-pj1-f67.google.com with SMTP id lt1so2467763pjb.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2020 04:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jRlUncaH+JbfpzbykeZUqo1ECa5C+qSIDXtQ4Uv6t6U=;
        b=p86SMEFrZyVIA/egXTcVNPeHiuo9PQHR5U4x5w1koSHSJ0eMmrWDwwhYuyF1Grjlnf
         Sgn5u1mp7wZGOIhLBmMR7qSactHvwoQ9X1L9uRuaENEx91owCXbRxZOarzWdPXjwskP9
         CYbgyuKwD/+lUvhDOuf3ZLd+LrWlVHD9Dy/QkECPIwRMm9vf2NIbfR/qS+ay+zfBTjyq
         rxOBu1xV0BrHJxdr7Kt5rpAdhT8E//KAn8p7162GsjgPBeYzlhlOH6EgWTXSxJzUHDkY
         RvvTd7sPOH7byyAuonwNUvdOiNSrItRFQ7r9oHW1QTHZ2VYoVlb+in80RCToKi4xPXGo
         BkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jRlUncaH+JbfpzbykeZUqo1ECa5C+qSIDXtQ4Uv6t6U=;
        b=PHy0rjvKzc2A/vjC5lqO3S26b5ni2KXYy9+8oFV4hr3viBzeQEO1eXIAOJtrYgNN0Q
         nZfwBAqWpUDv3y4x3bq8FG9w6YROQEAvSjdEjKvYZOEl+jayLgdKucyc5Edbfw0oQIlj
         8f/rQrgWXEcgzaM9qvEJKGVKjD0gsvvq6P1nHalOoqhov8+PZ4bxWIgcWyyH91oVTVVh
         zLpEu8OVtavWd/yrVDQu5dEbEgPHZhbEiaXPjSaXAnYtfldDhEdj1E6iuq0J/nF4H6Cn
         kQfSKIoCxN5FGQBudvD8krNnfU/IJ70Fqr6zmGNljgJFHNW3oEHFZ02s0ZDFxTb0NyRc
         fiiw==
X-Gm-Message-State: ANhLgQ3gsAv2I6ps2vbsZzhxvb0wPIUzOEAAzyMvYofo1iRpmJ46lr4m
        iImdzBxKcQqw67lJWApCmWUfRQ==
X-Google-Smtp-Source: ADFU+vs8Qha1XeeXZZA19WT2v6N385wbYLD4vydtcleubJ7KnAHk1Hsb8SexOspFuxRmA6UDqdDRDQ==
X-Received: by 2002:a17:90a:d104:: with SMTP id l4mr8913840pju.60.1583413021112;
        Thu, 05 Mar 2020 04:57:01 -0800 (PST)
Received: from localhost ([103.195.202.216])
        by smtp.gmail.com with ESMTPSA id gc22sm6459965pjb.0.2020.03.05.04.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 04:57:00 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: thermal: Add yaml bindings for thermal zones
Date:   Thu,  5 Mar 2020 18:26:43 +0530
Message-Id: <8a0cfe9e3018f7996c1563035bee76048941beb4.1583412540.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1583412540.git.amit.kucheria@linaro.org>
References: <cover.1583412540.git.amit.kucheria@linaro.org>
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
 .../bindings/thermal/thermal-zones.yaml       | 325 ++++++++++++++++++
 1 file changed, 325 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
new file mode 100644
index 0000000000000..f8f3b72bc3119
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -0,0 +1,325 @@
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
+                    minimum: -273000
+                    maximum: 200000
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
+                    enum:
+                        # active: enable active cooling e.g. fans
+                        - active
+                        # passive: enable passive cooling e.g. throttling cpu
+                        - passive
+                        # hot: send notification to driver if .notify
+                        #      callback registered
+                        - hot
+                        # critical: send notification to driver if .notify
+                        #           callback registered and trigger a shutdown
+                        - critical
+                    description: |
+                      There are four valid trip types: active, passive, hot,
+                      critical.
+
+                      The critical trip type is used to set the maximum
+                      temperature threshold above which the HW becomes
+                      unstable and underlying firmware might even trigger a
+                      reboot. Hitting the critical threshold triggers a system
+                      shutdown.
+
+                      The hot trip type can be used to send a notification to
+                      the thermal driver (if a .notify callback is registered).
+                      The action to be taken is left to the driver.
+
+                      The passive trip type can be used to slow down HW e.g. run
+                      the CPU, GPU, bus at a lower frequency.
+
+                      The active trip type can be used to control other HW to
+                      help in cooling e.g. fans can be sped up or slowed down
+
+                required:
+                  - temperature
+                  - hysteresis
+                  - type
+
+            additionalProperties: false
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
+            additionalProperties: false
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

