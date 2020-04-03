Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC08C19D0AE
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 09:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389165AbgDCHCK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 03:02:10 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:40766 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388302AbgDCHCK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2020 03:02:10 -0400
Received: by mail-pg1-f173.google.com with SMTP id t24so3078568pgj.7
        for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2020 00:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l1h6fRRJBqh4XQu4UKJVfQ1c7NUklIDlUPcnvMtodAE=;
        b=KAOgI47mhmaeZPpMgPZu5lxHkr/DQgjtN4Cuf6etoeoVJRJeintG38rTZzy+ObK3aA
         EoVyjaHmg3udHMPBKIoBscwNBmRR86p0Lb0ORBV+FRV9TiZsBsAfCMfe2Db+WaOhkg4I
         tag+ciAVClZvtYCZmJzo6Wg0X0M0dnexMAzrWqibUA5qLcpEpOjgjnexyput4VMiUCFj
         tGooz9Sfjf80eqd7HZqwqiKsig4u7LK4DvzlMxneupyQdgpbY7Dz9mZt2/1K2VtOsLy/
         i7BeqJTgJds6EoN2wXGMXY5pbL2GX0kukIW24gWXHqc2YRM+ERQAF1R0LZHc4Af9tFsL
         IUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l1h6fRRJBqh4XQu4UKJVfQ1c7NUklIDlUPcnvMtodAE=;
        b=ncVRWCd6zmOFIkDgHZD3+c+ScmrhXr4vrG7V+duVVK9e2b14YpfYqovctgRYObrUyk
         SCm/BPDP7xM9sO090ZGuJFh9x/sk5F0LxhemLWLWTUOZ+rv2wBjFBRaHUZVyMy5so2pP
         FSccr7r/CvRvFnj73cRolX7dU2eIYbc8LKOeMsaQuNpF+WnSm3StFW/zaCdQv8pI5RxX
         Sju3tLgQAPbsu4guJg9nBAZ5QnGWfTKlN/ZyVMRFOAZr1tr/9QkS5DAX1bhOBCls0I5/
         S7ytHNJxzgfYyzNqEaWYH1QvjAcYbJtKhc7SQVyKyqDtzk0S1DWMy67LA1yPCVJS/vXK
         GAHg==
X-Gm-Message-State: AGi0PuZqQqDX3vSLZJaH+dlyTDLtCZ8rk5lbbg5N+xFUtz7rkObrmRaO
        94CpQ8y+aRKz0VtqnTyj6m8pxg==
X-Google-Smtp-Source: APiQypLMrZKEwq4F1JdF2nJIfSq2/+huOYggfp7fD3EZNNWZpwE126NU17j3zPP4lqg2H2TKrefFiw==
X-Received: by 2002:a63:a361:: with SMTP id v33mr6696515pgn.324.1585897328422;
        Fri, 03 Apr 2020 00:02:08 -0700 (PDT)
Received: from localhost ([45.127.44.53])
        by smtp.gmail.com with ESMTPSA id a19sm5152553pfk.110.2020.04.03.00.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 00:02:07 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, lukasz.luba@arm.com, mka@chromium.org,
        daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 3/3] dt-bindings: thermal: Add yaml bindings for thermal zones
Date:   Fri,  3 Apr 2020 12:31:48 +0530
Message-Id: <44e5c68bc654ccaf88945f70dc875fa186dd1480.1585748882.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1585748882.git.amit.kucheria@linaro.org>
References: <cover.1585748882.git.amit.kucheria@linaro.org>
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
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 .../bindings/thermal/thermal-zones.yaml       | 341 ++++++++++++++++++
 1 file changed, 341 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
new file mode 100644
index 0000000000000..b8515d3eeaa2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -0,0 +1,341 @@
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
+      in the system, but acts as a container to link a thermal sensor device,
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
+        maxItems: 1
+        description:
+          The thermal sensor phandle and sensor specifier used to monitor this
+          thermal zone.
+
+      coefficients:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description:
+          An array of integers containing the coefficients of a linear equation
+          that binds all the sensors listed in this thermal zone.
+
+          The linear equation used is as follows,
+            z = c0 * x0 + c1 * x1 + ... + c(n-1) * x(n-1) + cn
+          where c0, c1, .., cn are the coefficients.
+
+          Coefficients default to 1 in case this property is not specified. The
+          coefficients are ordered and are matched with sensors by means of the
+          sensor ID. Additional coefficients are interpreted as constant offset.
+
+      sustainable-power:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          An estimate of the sustainable power (in mW) that this thermal zone
+          can dissipate at the desired control temperature. For reference, the
+          sustainable power of a 4-inch phone is typically 2000mW, while on a
+          10-inch tablet is around 4500mW.
+
+      trips:
+        type: object
+        description:
+          This node describes a set of points in the temperature domain at
+          which the thermal framework needs to take action. The actions to
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
+                  millicelsius. Any cooling action initiated by the framework is
+                  maintained until the temperature falls below
+                  (trip temperature - hysteresis). This potentially prevents a
+                  situation where the trip gets constantly triggered soon after
+                  cooling action is removed.
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
+                  The percentage contribution of the cooling devices at the
+                  specific trip temperature referenced in this map
+                  to this thermal zone
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
+                                    /* Corresponds to 1400MHz in OPP table */
+                                    cooling-device = <&CPU0 3 3>, <&CPU1 3 3>,
+                                                     <&CPU2 3 3>, <&CPU3 3 3>;
+                            };
+
+                            map1 {
+                                    trip = <&cpu0_alert1>;
+                                    /* Corresponds to 1000MHz in OPP table */
+                                    cooling-device = <&CPU0 5 5>, <&CPU1 5 5>,
+                                                     <&CPU2 5 5>, <&CPU3 5 5>;
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

