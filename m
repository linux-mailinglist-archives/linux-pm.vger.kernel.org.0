Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 910DD19AA97
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 13:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732447AbgDALPt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 07:15:49 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:45357 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732444AbgDALPt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2020 07:15:49 -0400
Received: by mail-pf1-f175.google.com with SMTP id r14so9467179pfl.12
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2020 04:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y5rp/BICQeEFC95frY5/x3/iojI34G4jygp7Vh5S5sQ=;
        b=Yga5g6vIlypTJkcyP7gycGOc9WlFEQyH+0IVQFE5aWyfDZS24YtOSCeuCmuHX5AeXM
         VsaiN7gsuVsm0cEITQkNgmowbGlT4T/n7522sVjjB0gmgZrSyzTYrElFhxPZ4JgjHF4I
         bQGjyGYQDeUAVtrQQUGjhmoZRxXmATjBgwZWJ2YHERc2le2ykwi5LzBcZFaAuIKHR2xk
         056gvjynCcCVuer6qm5EMBQd9SkoIlAN2IZnx0WaLXrhXR9iF6cChPCXwMavenaqJxec
         dSh7V+8Vr708eiYX1DzGN3oIDTqb0aHc5gRQLlG8Xf2RG1QKfdWxd+kfUKdkS9UYYRQD
         B2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y5rp/BICQeEFC95frY5/x3/iojI34G4jygp7Vh5S5sQ=;
        b=O6bQJgWsfU7V8Gcsmj5z0NroLA3EQSDh2PYU4EEPwLY7l9SntKE323YHwlJq1oDcky
         8F2Ih3XSc0+vtUpPfouRbfFC56pOu55tTjWiiSqilf/m/+X4lfdX2eR3MIb+VnWfeB0q
         npqKlb104xjfLFPp2/iqHTsGQdP3DuqJTyDyyyaIhl81X0WtILFv/RNcrFwWPE9YiLKM
         FXgZIT1g6mgIcveORyIHhHyQyucuOlwt8SgCZs+RMNrz3lAUuL/m14CacTjyiDoX5AB0
         jDDikNkFneHkFyvvZcqdjytdV8B2iDWwXH0x1dPIjajy8peldfXmOEVVIxmrMTwN5nkZ
         WB9w==
X-Gm-Message-State: ANhLgQ3jp+ZfotNn6Lv39ehD757BezzuFVhsHY9iun63hSiPF7bTRKUR
        Fije9GNDov6cEMVpUUKS2zNDyLXwN2g=
X-Google-Smtp-Source: ADFU+vuvtxckvL9WqY/DCTgFUMssRGqxPC2es6d6x5yvwkdskruYByxPFlHP4rXXqr1cPacakiJxxw==
X-Received: by 2002:a63:8048:: with SMTP id j69mr22516800pgd.410.1585739746563;
        Wed, 01 Apr 2020 04:15:46 -0700 (PDT)
Received: from localhost ([103.195.202.232])
        by smtp.gmail.com with ESMTPSA id u4sm1230326pgu.5.2020.04.01.04.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 04:15:45 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, lukasz.luba@arm.com, mka@chromium.org,
        daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 3/3] dt-bindings: thermal: Add yaml bindings for thermal zones
Date:   Wed,  1 Apr 2020 16:45:27 +0530
Message-Id: <af3625a9cdf1a8f0e433d67e3d785b03aae7bc82.1585738725.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1585738725.git.amit.kucheria@linaro.org>
References: <cover.1585738725.git.amit.kucheria@linaro.org>
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
---
Changes since v3:
 - Clarify example by using cooling state numbers and a comment
 - Restrict thermal-sensors to a single reference to reflect actual code
   where there is a one-to-one mapping between sensors and thermal zones
 - Add two optional properties that were missed in earlier submissions:
   coefficients and sustainable-power
 - Improve description of hysteresis and contribution properties

 .../bindings/thermal/thermal-zones.yaml       | 341 ++++++++++++++++++
 1 file changed, 341 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
new file mode 100644
index 0000000000000..302170d79fe94
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
+          Coefficients default to 1, in case this property is not specified. The
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
+                                    /* Corresponds to 1400MHz in OPP table */
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

