Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB50D1970B0
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 00:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgC2WHL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Mar 2020 18:07:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35899 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbgC2WHL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 18:07:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so18934641wrs.3
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2020 15:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xqOYJnZwZ6nCjA/xlHPb8mgZN2nsbbT0ZoaYXOpkuLo=;
        b=IpzvSj93LGGqfX/pEFFDBqxz2oGLAVMgMH+pkbxOXiDK3OPs3SQPYdJcwOKRpS564O
         i+wJZiYEEeFnPD2EvGnsCDiamlX74r9xB6Lx7U6Q2qXLf+s3OIglehymhCdGKilxWPNR
         9UuCACT3A1A/y4s+ZwsfvyLtaJyOrvLadae5e8LiPn8MBha7ofJ+J7wCd3HwOgR/k3a8
         TK12ZIohUYrUq+KCqnZptjCVYDyNodp8QClv9BmnekHASLRc8Q4g8Kr2J9bkgXeqXmmJ
         dKORQNKnbqMjlNejrNub2lzQR2GxGJMNaPh0FY2SeLs1eT2eytNJqQlBJWxki7XLFbz9
         tnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xqOYJnZwZ6nCjA/xlHPb8mgZN2nsbbT0ZoaYXOpkuLo=;
        b=bmUBByXllxJR+D5Dq56CFXERlpSHJKj3SSsvdVqBh396kDefZ115/NzSec82k9cRgP
         lGq6DmZyt1FELAZBx9rkGg9I8JlVOo8GP/EKe80PyJhiRteagkzzEJ+f/H8g4sF0FBmp
         Z8gdO83Z/RRvejTD8P8v6/+x8jr4q5RdqsPiXeuBhsbZ2OU62gEP5dWf203bMTBgzhxC
         2k3Z19d/wkfd2LDFximF7GVD9CXl7p/K+bVq2p9iVzeqbyxC/xAHLKfXAJ1Vt6our4Yl
         voYquhlX/X6zhFAk6WOOfoQDmvnIVQhsdle0mhfdq6XNVAMDPlzQgyf0K7FAcbtKqHQB
         DzFQ==
X-Gm-Message-State: ANhLgQ0eV/RzRnmlGeA+YTgBKAnuRhnI96uOS2B4o6BQP/wlQ0ZQFVWi
        3JvEx38mjovE821hrmtSn3XrCw==
X-Google-Smtp-Source: ADFU+vu6IEW9IGES8IzwqBpA2MZlxUSPxSmcSdZEmeqfayfoxno1bZvmFyd211/q2428O8w4EnqkLw==
X-Received: by 2002:adf:9465:: with SMTP id 92mr11523032wrq.122.1585519626825;
        Sun, 29 Mar 2020 15:07:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:78b1:4459:6959:42d0])
        by smtp.gmail.com with ESMTPSA id j188sm20026740wmj.36.2020.03.29.15.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 15:07:06 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, robh@kernel.org
Cc:     daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] dt-bindings: thermal: Add the idle cooling device
Date:   Mon, 30 Mar 2020 00:03:18 +0200
Message-Id: <20200329220324.8785-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200329220324.8785-1-daniel.lezcano@linaro.org>
References: <20200329220324.8785-1-daniel.lezcano@linaro.org>
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
together as showed in the example.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../bindings/thermal/thermal-idle.yaml        | 145 ++++++++++++++++++
 1 file changed, 145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-idle.yaml

diff --git a/Documentation/devicetree/bindings/thermal/thermal-idle.yaml b/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
new file mode 100644
index 000000000000..f9f59cfa3c36
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/thermal-idle.yaml
@@ -0,0 +1,145 @@
+# SPDX-License-Identifier: (GPL-2.0)
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
+        A /thermal-idle node describes the idle cooling device properties to
+        cool down efficiently the attached thermal zone.
+
+   '#cooling-cells':
+      const: 2
+      description: |
+         Must be 2, in order to specify minimum and maximum cooling state used in
+         the cooling-maps reference. The first cell is the minimum cooling state
+         and the second cell is the maximum cooling state requested.
+
+   duration:
+      $ref: /schemas/types.yaml#/definitions/uint32
+      description: |
+         The idle duration in microsecond the device begins to cool down.
+
+   latency:
+      $ref: /schemas/types.yaml#/definitions/uint32
+      description: |
+         The exit latency constraint in microsecond for the injected
+         idle state for the device.
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
+                         idle-thermal {
+                                 #cooling-cells = <2>;
+                                 duration = <10000>;
+                                 latency = <500>;
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
+                        idle-thermal {
+                                #cooling-cells = <2>;
+                                duration = <10000>;
+                                latency = <500>;
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
+                             cooling-device = <&{/cpus/cpu@100/idle-thermal} 0 15 >,
+                                              <&{/cpus/cpu@101/idle-thermal} 0 15>;
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

