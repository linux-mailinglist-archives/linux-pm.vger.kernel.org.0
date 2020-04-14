Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2421A8E41
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 00:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634175AbgDNWJW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 18:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634156AbgDNWJA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 18:09:00 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473A8C061A0E
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2020 15:08:59 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r26so16256939wmh.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2020 15:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qKrrTjxTq2DaanA7D/Z8LJo2RnyGixxTxyQQd7KYF+Q=;
        b=ky7JzqAxzFlbteL2lCqTiA9yIwc4OTrN2IlfXatl0EhhaNCXRJ1pi3XvSI574/6YEn
         RTamWp5/5yBVaX7svzhbu5Zx7cXwS1dnLCXm9K7Xeo4BQfsn1EfIoariDlXJBjMrPB1h
         rnd37cJalZwh6YAu9Q49d/os1N0xyZHVFYkLbV/7MnOHvB6/Kue45GqjsqXt2q3tLolA
         D36BIEm5pe0iuRlfFJtwj4KBPKaPG+c6e7IRBKWzE+1MZupDhxrdqoDfQjQY0tq2Wd8d
         rechd02gUcKi1rwLKHSU4YXhY5uc1MuFczrqR4WjjFj3r1q0ueRqogs0/yGKBt7A2CSJ
         JjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qKrrTjxTq2DaanA7D/Z8LJo2RnyGixxTxyQQd7KYF+Q=;
        b=mt2vZTOqyqyXIxGkN5YUndGFOHjTiW8SrkbaNUfZ1elKcF4yk6RGD0Ux9Ixr5mdyit
         ZUDaheGvxdJRLArUsi1AefPLNuKNAtoyuv4fONhOSDWSCQIxJvStQzRqyP1ggKGqhmE/
         ErscP1Oa9ru6X4sE5YeAzYL5CPvgUwdyliDaNaC8i3QQzJ99zuLHNrylDHl3K6igDu2d
         IPTj/ShjTyJ15L1iEMauoWa1Gk0QY4ooe20Z5FUxj31MQh18OGjPdRnneQ+W+RLllVjh
         wOzTz2mf5+Or0VKv264ppPdsDgZVLhFsJ6seVfUHATVI82lewfYh4Gw4+sG3B/bxC19z
         kEtA==
X-Gm-Message-State: AGi0PuZUUdBJ/C7HV7jgKqbIgl9zXe0pBxafVkK+yxgCh68kTtvMDW4a
        pfqLw1SJxUxFAdTo9XaTiJmoag==
X-Google-Smtp-Source: APiQypIso6cYieAXB2y+b/ecomS6KQqRcgPqo3sIwyiW+hi0Scm6IA26i/fLhftACEB1zP/x9ZMwzg==
X-Received: by 2002:a1c:3885:: with SMTP id f127mr1882179wma.134.1586902137384;
        Tue, 14 Apr 2020 15:08:57 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id a7sm4099973wrs.61.2020.04.14.15.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 15:08:56 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/4] dt-bindings: thermal: Add the idle cooling device
Date:   Wed, 15 Apr 2020 00:08:31 +0200
Message-Id: <20200414220837.9284-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200414220837.9284-1-daniel.lezcano@linaro.org>
References: <20200414220837.9284-1-daniel.lezcano@linaro.org>
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

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
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

