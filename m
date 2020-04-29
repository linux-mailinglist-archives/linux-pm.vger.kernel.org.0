Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45E91BD9BF
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 12:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgD2KhN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 06:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD2KhM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 06:37:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57E2C035493
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 03:37:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x17so1892297wrt.5
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 03:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uw1e05S8KatpGPOOd/irQmwNBAm1B+DP9MNoizxV2OU=;
        b=eUH/mXizgIYj8EmR9kncyzWIwY2AwvUW1fw776agYWymjhRz0tuizHx7JCyGmz9dhE
         NX9Zq2vwkwA1CC7+b1LXT3m1VphgWZ7nwKfnHAvSB7g3FmH4eEsdZWur+gqJcnPbXpQA
         ISY6UFnLV56wLNznKUWVxs3A9N14NsRkpPhGndyB2iDIllyQSYJe4rrbUQ8gjSck5b3D
         5uKjCN8g26CKB0NbMwqJf2hkwrtYDhDZqBvAiPbz/PEhvD9hbi9whM4pimqh7Xsbvb6s
         G4iomcOiZXNL1Vc9QTGBX78RmxIZHpKT9j0ZBnL1LjrC7trCIvzI+SY5uij7BIPtSUQu
         CFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Uw1e05S8KatpGPOOd/irQmwNBAm1B+DP9MNoizxV2OU=;
        b=BnU7FcytohlQH3Gaal6F3m6qxQf2oEvYwvKW1xoNNPfLcgnqINo7WV77LPyGpHaK5Y
         kwn7rkatYXN1Y8f8iNcTvka2lXWlYo+LXpWpuBCupoGKntIVzw76c0NFpw4MUW54aLle
         /DxXNz8fZunE/X0YEq4rvSN1AXMEt3PQDVrzs8LFUolFo4XbHtqseBr5gXXrQSDKEUIs
         L/EJ/zNY789oA45FxocX5vqnpma0YNnTUKPbzCsLjYiMXk0CAsJG7Q7p0EKgS/o7WvOR
         wXF726XeYL6z/EaqmPKPDHMYmzPjKGToVjMXOhQiFb7nxaV5N8kdZJJMijaludV81FpT
         p6yw==
X-Gm-Message-State: AGi0Pub6jLiJhdaDvdy53A29mL4B4v4hHIEcr+FFPUcQ88u06LlwL3IK
        4pjii+zrlD4Dv5vv8QxyJZPxgw==
X-Google-Smtp-Source: APiQypIRQ2H5DPDaNrKlkpwyTjU5Mm7vVZtMl+9/1EoZpCSOImgpdBMycYdvWOJWpBFo8XvgJqioZw==
X-Received: by 2002:adf:f34f:: with SMTP id e15mr39230195wrp.275.1588156628996;
        Wed, 29 Apr 2020 03:37:08 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:d494:5741:b700:698f])
        by smtp.gmail.com with ESMTPSA id f23sm6899576wml.4.2020.04.29.03.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 03:37:08 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     lukasz.luba@arm.com, Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/4] dt-bindings: thermal: Add the idle cooling device
Date:   Wed, 29 Apr 2020 12:36:40 +0200
Message-Id: <20200429103644.5492-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429103644.5492-1-daniel.lezcano@linaro.org>
References: <20200429103644.5492-1-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Some devices are not able to cool down by reducing their voltage /
frequency because it could be not available or the system does not
allow voltage scaling. In this configuration, it is not possible to
use this strategy and the idle injection cooling device can be used
instead.

One idle cooling device is now present for the CPU as implemented by
the combination of the idle injection framework belonging to the power
capping framework and the thermal cooling device. The missing part is
the DT binding providing a way to describe how the cooling device will
work on the system.

A first iteration was done by making the cooling device to point to
the idle state. Unfortunately it does not make sense because it would
need to duplicate the idle state description for each CPU in order to
have a different phandle and make the thermal internal framework
happy.

It was proposed to add an cooling-cells to <3>, unfortunately the
thermal framework is expecting a value of <2> as stated by the
documentation and it is not possible from the cooling device generic
code to loop this third value to the back end cooling device.

Another proposal was to add a child 'thermal-idle' node as the SCMI
does. This approach allows to have a self-contained configuration for
the idle cooling device without colliding with the cpufreq cooling
device which is based on the CPU node. In addition, it allows to have
the cpufreq cooling device and the idle cooling device to co-exist
together as shown in the example.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 - V4:
   - Added Rob Herring reviewed-by
 - V3:
   - Removed extra line with tab inside
 - V2:
   - Fixed comment type
   - Added dual license
   - Fixed description s/begins to/should/
   - Changed name s/duration/duration-us/
   - Changed name s/latency/exit-latency-us/
   - Removed types for latency / duration
   - Fixed s/idle-thermal/thermal-idle/
---
 .../bindings/thermal/thermal-idle.yaml        | 145 ++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-idle.yaml

diff --git a/Documentation/devicetree/bindings/thermal/thermal-idle.yaml b/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
new file mode 100644
index 000000000000..7a922f540934
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
@@ -0,0 +1,145 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2020 Linaro Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/thermal-idle.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Thermal idle cooling device binding
+
+maintainers:
+  - Daniel Lezcano <daniel.lezcano@linaro.org>
+
+description: |
+  The thermal idle cooling device allows the system to passively
+  mitigate the temperature on the device by injecting idle cycles,
+  forcing it to cool down.
+
+  This binding describes the thermal idle node.
+
+properties:
+   $nodename:
+     const: thermal-idle
+     description: |
+        A thermal-idle node describes the idle cooling device properties to
+        cool down efficiently the attached thermal zone.
+
+   '#cooling-cells':
+      const: 2
+      description: |
+         Must be 2, in order to specify minimum and maximum cooling state used in
+         the cooling-maps reference. The first cell is the minimum cooling state
+         and the second cell is the maximum cooling state requested.
+
+   duration-us:
+      description: |
+         The idle duration in microsecond the device should cool down.
+
+   exit-latency-us:
+      description: |
+         The exit latency constraint in microsecond for the injected
+         idle state for the device. It is the latency constraint to
+         apply when selecting an idle state from among all the present
+         ones.
+
+required:
+  - '#cooling-cells'
+
+examples:
+  - |
+    #include <dt-bindings/thermal/thermal.h>
+
+    // Example: Combining idle cooling device on big CPUs with cpufreq cooling device
+    cpus {
+            #address-cells = <2>;
+            #size-cells = <0>;
+
+            /* ... */
+
+                 cpu_b0: cpu@100 {
+                         device_type = "cpu";
+                         compatible = "arm,cortex-a72";
+                         reg = <0x0 0x100>;
+                         enable-method = "psci";
+                         capacity-dmips-mhz = <1024>;
+                         dynamic-power-coefficient = <436>;
+                         #cooling-cells = <2>; /* min followed by max */
+                         cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+                         thermal-idle {
+                                 #cooling-cells = <2>;
+                                 duration-us = <10000>;
+                                 exit-latency-us = <500>;
+                         };
+                };
+
+                cpu_b1: cpu@101 {
+                        device_type = "cpu";
+                        compatible = "arm,cortex-a72";
+                        reg = <0x0 0x101>;
+                        enable-method = "psci";
+                        capacity-dmips-mhz = <1024>;
+                        dynamic-power-coefficient = <436>;
+                        #cooling-cells = <2>; /* min followed by max */
+                        cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+                        thermal-idle {
+                                #cooling-cells = <2>;
+                                duration-us = <10000>;
+                                exit-latency-us = <500>;
+                        };
+                 };
+
+          /* ... */
+
+    };
+
+    /* ... */
+
+    thermal_zones {
+         cpu_thermal: cpu {
+                polling-delay-passive = <100>;
+                polling-delay = <1000>;
+
+                /* ... */
+
+                trips {
+                        cpu_alert0: cpu_alert0 {
+                                    temperature = <65000>;
+                                    hysteresis = <2000>;
+                                    type = "passive";
+                        };
+
+                        cpu_alert1: cpu_alert1 {
+                                    temperature = <70000>;
+                                    hysteresis = <2000>;
+                                    type = "passive";
+                        };
+
+                        cpu_alert2: cpu_alert2 {
+                                    temperature = <75000>;
+                                    hysteresis = <2000>;
+                                    type = "passive";
+                        };
+
+                        cpu_crit: cpu_crit {
+                                    temperature = <95000>;
+                                    hysteresis = <2000>;
+                                    type = "critical";
+                        };
+                };
+
+                cooling-maps {
+                        map0 {
+                             trip = <&cpu_alert1>;
+                             cooling-device = <&{/cpus/cpu@100/thermal-idle} 0 15 >,
+                                              <&{/cpus/cpu@101/thermal-idle} 0 15>;
+                        };
+
+                        map1 {
+                             trip = <&cpu_alert2>;
+                             cooling-device =
+                                        <&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+                                        <&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+                       };
+                };
+          };
+    };
-- 
2.17.1

