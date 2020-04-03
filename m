Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C356519D0AA
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 09:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388689AbgDCHCF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 03:02:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35649 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388302AbgDCHCE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2020 03:02:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id k5so3097029pga.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2020 00:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TovlFSqP+LvCTVbEbiC0GqlPPnwZVGxe7En1uRnnnvQ=;
        b=qbq2T0rXbHmgO7X9Tru81R27QTNRp7Edb0a827EuRQJzslw070mK0AxF4oreSvB5Fz
         NNcLMEzKPkTFU70s20W0ApdhcLCRY/6kNa8V4ewSNFt49LDa+ClqGq+f0cNcuRcwF3CC
         9mHEMUri1ikEPIaReyEqbhBOOayT2D01LoWNF7psBsarleNs2t1WjikjmOxsDJskU/gY
         KQEgfKKaWOBjBogRFDLmpu5j8L0nqPBnpEkUYGB1VhM+ZfIjLVgllFb9CBrF3yJi6eqz
         zNjqNDpSbEsFst/kHrg0CtfckjuUCteGc/S6ObBZxzbbgVANt2/PmLlDkf5zlvIprhGC
         AqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TovlFSqP+LvCTVbEbiC0GqlPPnwZVGxe7En1uRnnnvQ=;
        b=MMwtwKfUukl+ULK0tiudRgReg4VnEt1MqRCQ3xLteXoofjHx0KwlqS+5j/vOICbPo3
         GZzYeVLxDmuEmRmTscsT8afZ4PkuE3qZdnvo3cDfNXHNySxX4L/8NtDYWjX70PjOoiJ8
         nDO0xObDHY3YZlls3JHl//fvqT2VrwRnkFN9qTqe9ekFiuQEHCPxDPFJUX3tmgL24IfO
         ife1VP5K3EQ9mGVUt7tuU6L/pA7OBmVsNjr16j/qeso5Zcq/ZQ+ZgyOOugxzP7eEk06n
         3dnHIKYAx1cXEzJ+ROPGDdXOhr25+aQ7QIbhkhT+efSIgD0Ypu2DRNkYdoBMoPOHurCo
         zo6Q==
X-Gm-Message-State: AGi0PubXqvWSy4w6UnnxuRwZOZlXLKM0c99NDGJXrx2avdwokqv062L/
        ekHbuDGH6gmnpTst5k5hOUzrzA==
X-Google-Smtp-Source: APiQypJ0GxjNSijwRL7Z7sOkijFoBozlKLOCy9QUU8Q6ytcrjpF6mG5T9MuJeG4FwW2M4bKOs+tt+A==
X-Received: by 2002:a63:ec44:: with SMTP id r4mr6591690pgj.425.1585897323639;
        Fri, 03 Apr 2020 00:02:03 -0700 (PDT)
Received: from localhost ([45.127.44.53])
        by smtp.gmail.com with ESMTPSA id c190sm5132826pfa.66.2020.04.03.00.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 00:02:02 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, lukasz.luba@arm.com, mka@chromium.org,
        daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 2/3] dt-bindings: thermal: Add yaml bindings for thermal cooling-devices
Date:   Fri,  3 Apr 2020 12:31:47 +0530
Message-Id: <7a9ead7fb67585fb70ab3ffd481e7d567e96970e.1585748882.git.amit.kucheria@linaro.org>
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

The property #cooling-cells is required in each device that acts as a
cooling device - whether active or passive. So any device that can
throttle its performance to passively reduce heat dissipation (e.g.
CPUs, GPUs) and any device that can actively dissipate heat at different
levels (e.g. fans) will contain this property.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 .../thermal/thermal-cooling-devices.yaml      | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml

diff --git a/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
new file mode 100644
index 0000000000000..5145883d932e6
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
+   - cooling-device: device used to dissipate heat either passively or actively
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
+                                    /* Corresponds to 1000MHz in OPP table */
+                                    cooling-device = <&CPU0 5 5>;
+                            };
+                    };
+            };
+
+            /* ... */
+    };
+...
-- 
2.20.1

