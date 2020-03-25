Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C24A19212E
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 07:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgCYGfL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 02:35:11 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:34000 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYGfK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 02:35:10 -0400
Received: by mail-pj1-f45.google.com with SMTP id q16so2008419pje.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2020 23:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cUTwMh8vYUOuCdm83Oh+4utbVCeDW5nkMaz7OgaXqiA=;
        b=XrvKWaKgVCjcVg5NxnjxhOOyGfckchfa6NdqKzjA2rQWga/RhL7RsqYLXjVCBK3dXz
         R3aHEFbgCCB5aZMJtL2ZjF2y/cbS/E3QZrYYS3IlkwHH88GwZwY6Dtx3nbZGHAMu3w1Y
         2xzpbyFQawY5lWyXn5ifN6COr5on0z8xol5EULoxlKcYPRZIstapvHdcP4w/GBqOdgp4
         20aam8ZYfZvdLtjRJ+tlWRglRNm8Db21+MVaL0hvS+CHLB9B00Z9SYuje2ltTwrE5fmm
         0gIAbEIk+BPLY3AlQb8PKoQ9bpPo4/SZrVYWUpNmoNg3agpT149ugTSU3gl34O9ZzXba
         0oZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cUTwMh8vYUOuCdm83Oh+4utbVCeDW5nkMaz7OgaXqiA=;
        b=JsXB3MTE7BIahJlkkx3MCydo07lBHjuW3TQMbUCVWXrxeNLJ9/YFymfqxJVzUgHYHk
         vpK0aboeKOkJd4ss31tBKj8NAwUa+AlQvHDBPrrmZGcF8juPEk8XRbmC6/YKjcuKWjMw
         bD55ySYsCp13oc595vLTT5YrSD74j7UbRACCS7Vkk8ae7QkO6Pxx4CfmINRIaTOuJUjj
         oU67R37dscE0NonEMMNBenS/LHoVoHUgVrDMyFm5V8sVmZoGVZkEgIy+NPE0POGUNWav
         JYrZTJoGecK0OqridnKpH3cpleXZFn9XccZTQrC4mlCMcpCiwsqEfgJ+1dyWW4pYAoef
         o8qQ==
X-Gm-Message-State: ANhLgQ00zUBvylGGQfm9gHzf/P2NAxncmfjXKRL4zOR/684uIjSe7tFx
        y5oJV4PITdO2d6Q+XMLZmlGT2A==
X-Google-Smtp-Source: ADFU+vtb+J/TrZsEUd5QefQwVFupYMYwifUcaKKcGzNOC7HnfUEWePW5ryi03PucfxeLC9xr0dR2Fw==
X-Received: by 2002:a17:90a:da03:: with SMTP id e3mr1960501pjv.57.1585118108692;
        Tue, 24 Mar 2020 23:35:08 -0700 (PDT)
Received: from localhost ([103.195.202.71])
        by smtp.gmail.com with ESMTPSA id mn18sm3822619pjb.13.2020.03.24.23.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 23:35:07 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: thermal: Add yaml bindings for thermal cooling-devices
Date:   Wed, 25 Mar 2020 12:04:53 +0530
Message-Id: <1ee4240e29edefc36b5d410d4792971c2bb4c5d5.1585117436.git.amit.kucheria@linaro.org>
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

The property #cooling-cells is required in each device that acts as a
cooling device - whether active or passive. So any device that can
throttle its performance to passively reduce heat dissipation (e.g.
cpus, gpus) and any device that can actively dissipate heat at different
levels (e.g. fans) will contain this property.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 .../thermal/thermal-cooling-devices.yaml      | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml

diff --git a/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
new file mode 100644
index 000000000000..b5599f7859f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: (GPL-2.0)
+# Copyright 2020 Linaro Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/thermal-cooling-devices.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Thermal cooling device binding
+
+maintainers:
+  - Amit Kucheria <amitk@kernel.org>
+
+description: |
+  Thermal management is achieved in devicetree by describing the sensor hardware
+  and the software abstraction of cooling devices and thermal zones required to
+  take appropriate action to mitigate thermal overload.
+
+  The following node types are used to completely describe a thermal management
+  system in devicetree:
+   - thermal-sensor: device that measures temperature, has SoC-specific bindings
+   - cooling-device: device used to dissipate heat either passively or artively
+   - thermal-zones: a container of the following node types used to describe all
+     thermal data for the platform
+
+  This binding describes the cooling devices.
+
+  There are essentially two ways to provide control on power dissipation:
+    - Passive cooling: by means of regulating device performance. A typical
+      passive cooling mechanism is a CPU that has dynamic voltage and frequency
+      scaling (DVFS), and uses lower frequencies as cooling states.
+    - Active cooling: by means of activating devices in order to remove the
+      dissipated heat, e.g. regulating fan speeds.
+
+  Any cooling device has a range of cooling states (i.e. different levels of
+  heat dissipation). They also have a way to determine the state of cooling in
+  which the device is. For example, a fan's cooling states correspond to the
+  different fan speeds possible. Cooling states are referred to by single
+  unsigned integers, where larger numbers mean greater heat dissipation. The
+  precise set of cooling states associated with a device should be defined in
+  a particular device's binding.
+
+select: true
+
+properties:
+  "#cooling-cells":
+    description:
+        Must be 2, in order to specify minimum and maximum cooling state used in
+        the cooling-maps reference. The first cell is the minimum cooling state
+        and the second cell is the maximum cooling state requested.
+    const: 2
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/thermal/thermal.h>
+
+    // Example 1: Cpufreq cooling device on CPU0
+    cpus {
+            #address-cells = <2>;
+            #size-cells = <0>;
+
+            CPU0: cpu@0 {
+                    device_type = "cpu";
+                    compatible = "qcom,kryo385";
+                    reg = <0x0 0x0>;
+                    enable-method = "psci";
+                    cpu-idle-states = <&LITTLE_CPU_SLEEP_0
+                                       &LITTLE_CPU_SLEEP_1
+                                       &CLUSTER_SLEEP_0>;
+                    capacity-dmips-mhz = <607>;
+                    dynamic-power-coefficient = <100>;
+                    qcom,freq-domain = <&cpufreq_hw 0>;
+                    #cooling-cells = <2>;
+                    next-level-cache = <&L2_0>;
+                    L2_0: l2-cache {
+                            compatible = "cache";
+                            next-level-cache = <&L3_0>;
+                            L3_0: l3-cache {
+                                    compatible = "cache";
+                            };
+                    };
+          };
+
+          /* ... */
+
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
+                    };
+
+                    cooling-maps {
+                            map0 {
+                                    trip = <&cpu0_alert0>;
+                                    cooling-device = <&CPU0 THERMAL_NO_LIMIT
+                                                            THERMAL_NO_LIMIT>;
+                            };
+                    };
+            };
+
+            /* ... */
+    };
+...
-- 
2.20.1

