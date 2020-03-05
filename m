Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C151017A5CC
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2020 13:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgCEM47 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Mar 2020 07:56:59 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51667 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCEM47 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Mar 2020 07:56:59 -0500
Received: by mail-pj1-f67.google.com with SMTP id l8so2468995pjy.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2020 04:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YPje9xcPYfIamEpUGoSH/TcUKQBJFPYwji3i7uk9SdI=;
        b=EHt4DAgGtc8ZWbbUms/Azd5KsSQkQH56Vwm8e9HTZaNCV+GsiFiy3wkfP5ymusF9FR
         q0c9pXbn2AcjIXTcxk2jNH4DAbYGqdRx2oQNY5Amh84vt9TRg/0GNanxvEUn4tb2YIKM
         +dvpOYTDs70oZiZ7dRe6W63hbHfh1nue/w/p0hUj8vX+qNLcFnQu6Ad5iGdPp4/IPGAf
         pjxLSUBkWc761aiD10tMXEOSFPCW5SE7O4WB5Qyc8eqtWIrLpK+K1TxFV4gk4qgKlZHU
         JAoj7XtOgIATfwwruZ8DQD4qWdT8URKd+LIsSbLG+59717l7WjnfhsnyEGzj1WK0DgIT
         5sXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YPje9xcPYfIamEpUGoSH/TcUKQBJFPYwji3i7uk9SdI=;
        b=kt44f53PVB7twiyMDGojTO7eHYujIZDs03vO1gR2HB7lQLAdCtJPZh0XbqeVmScEJ4
         LVuOCI8ZdLg5Ay4dc72afrj/8IbELDCzqr8PUcvv2gjxpi5b+2JlsQY8eZQjmzVIXgxu
         N9A2fgNE9Firus7PYxbcy3lMLFCTlfchQIf2AcyhuQAfIE8VSVzldLiFCqqPygwMle98
         cbb2X8RVpjm1rTwt+VASWCFriPyEwn02Mpx5OXGP8+VKKhe2snLdJU7wJgpNjnqXM9xa
         RPBeE0g43RtUJetdelBw2wQMwjaDVn/smN+0ED3AFidW80dgjqGZmnkXj1n0PEE+LgTv
         7Aqg==
X-Gm-Message-State: ANhLgQ2wxhuRq2q93NYKwZIr79eOfqO0qLqqXkYFIzKkqNQqEpXOal7O
        DSWue0XoiSzEUyU8845Jd3GNIzEuM9Y=
X-Google-Smtp-Source: ADFU+vvPYdi7ZwmB0U0Sj6BPoR9D3pE/yA0/hXZrIVssSPjgpFaycsmnvIxiOf3TYBYNpoG36JlFLg==
X-Received: by 2002:a17:90a:bf09:: with SMTP id c9mr7953201pjs.96.1583413016741;
        Thu, 05 Mar 2020 04:56:56 -0800 (PST)
Received: from localhost ([103.195.202.216])
        by smtp.gmail.com with ESMTPSA id r12sm32030259pgu.93.2020.03.05.04.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 04:56:55 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: thermal: Add yaml bindings for thermal cooling-devices
Date:   Thu,  5 Mar 2020 18:26:42 +0530
Message-Id: <9a2052ee2afa43048bd4e2594d015fca6bbf5116.1583412540.git.amit.kucheria@linaro.org>
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

The property #cooling-cells is required in each device that acts as a
cooling device - whether active or passive. So any device that can
throttle its performance to passively reduce heat dissipation (e.g.
cpus, gpus) and any device that can actively dissipate heat at different
levels (e.g. fans) will contain this property.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 .../thermal/thermal-cooling-devices.yaml      | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml

diff --git a/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
new file mode 100644
index 0000000000000..4745ea4b41ae7
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
@@ -0,0 +1,114 @@
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

