Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332DD45EF45
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 14:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377649AbhKZNlj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 08:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353010AbhKZNjj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 08:39:39 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF48C061D74
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 04:53:34 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u1so18390526wru.13
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 04:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JqNBsRcjQjHmu9oXUqgctJ3evIfScLc2vJGzdrITO90=;
        b=dLDhV5liGCZ76LlBpSkAzBU9LgymgyPqrdyHUjiYTllUJbF2eEAvdCfi39S0ogOBM1
         wR4aTZAQDovguDwarefYISn/oPMPzney5HN2Xw+oXeKBjpaopdGtzbijUDaUKn3ApB4P
         k7tJXfYA2OyTY5GpkfONcyVMxLo6b4LSBm+oBODjYgtj9GIhtM5+vmYCGzRKkRwwaO1x
         kUOAvuPUDTzD3UypQK8uIxDd+lW9Dhb9D+Lxe79ahetimSLWn5tEGCty4g2b3fAZykQ/
         p2PbJFkpAEJ70zvYOKT2lur7b9qPT/ooqONy4X7+AjlyaXTDtD4etlfQEMmEJ7Am3Iyf
         aDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JqNBsRcjQjHmu9oXUqgctJ3evIfScLc2vJGzdrITO90=;
        b=Q83UcNkRbK5RpoG78lez+Xqei2tSn1m4uT0UBoN7HF0cNjHqzUu8mcJjn9C/7F9k9z
         5tb0t/1YoxQUDEz4nAh0LW/k/fQ+r/CYsC+sXXxcwFvqZZq8+BtCWq0D3wxCV5UDrkXf
         7Ax0l7PlcykZaxobBDKZPc+QoVg7jHbFf54V/OmaSE/tcYxUaaGvWLgDmsod4LXFzS2B
         NTLiEUwhctJBcOmW4YMEt8i7sEUjDUlIotuqO68id3aF2G9fr7FyjK6k+/GPMrd8sPGw
         ZrL/lWxi5gvD7fhlIORhf+7p9hVA0IKI7dwGYEvFD/Ngu3/TEdQEj5RoBwM+UrNHIulo
         cBQA==
X-Gm-Message-State: AOAM530hXDfSJYKGHZqpddXfjh9hSyHPHLLx8/2k6v7HKsa5LWAJ43xf
        LOkW0FOCuKgnpSl3A9JEmeXbhg==
X-Google-Smtp-Source: ABdhPJyqgAOiPOiPv+WdJgOsIjJAGcEUjVDBfqjIFmod0Eo0eIRkOI68gPCCfwMhl1NfKgfEQXpo4g==
X-Received: by 2002:adf:dd87:: with SMTP id x7mr13933882wrl.158.1637931212868;
        Fri, 26 Nov 2021 04:53:32 -0800 (PST)
Received: from xps-9300.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n15sm11762083wmq.38.2021.11.26.04.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 04:53:32 -0800 (PST)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v4 1/2] dt-bindings: Add DT bindings for the DT-based virtual sensor driver
Date:   Fri, 26 Nov 2021 13:52:43 +0100
Message-Id: <20211126125244.126300-2-abailon@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211126125244.126300-1-abailon@baylibre.com>
References: <20211126125244.126300-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds the DT bindings for the DT-based virtual sensor driver.
This driver provides a way, using DT, to aggregate the temperature
of multiple thermal zones and get some useful data from it.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 .../thermal/virtual,thermal-sensor.yaml       | 86 +++++++++++++++++++
 include/dt-bindings/thermal/virtual-sensor.h  | 15 ++++
 2 files changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml
 create mode 100644 include/dt-bindings/thermal/virtual-sensor.h

diff --git a/Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml b/Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml
new file mode 100644
index 000000000000..b404fd4b2b38
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2021 BayLibre
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/virtual,thermal-sensor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtual thermal sensor binding
+
+maintainers:
+  - Alexandre Bailon <abailon@baylibre.com>
+
+description: |
+  The virtual thermal sensor device provides a way to aggregate the temperature
+  from multiple thermal zones. Basically, this could be used to get the
+  maximum, minimum or average temperature.
+
+allOf:
+  - $ref: thermal-sensor.yaml#
+
+properties:
+  compatible:
+    const: virtual,thermal-sensor
+
+  aggregation-function:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Used to select the operations to perform on the sensors to get the virtual
+      sensor temperature.
+    enum:
+      - VIRTUAL_THERMAL_SENSOR_MIN_VAL
+      - VIRTUAL_THERMAL_SENSOR_MAX_VAL
+      - VIRTUAL_THERMAL_SENSOR_AVG_VAL
+
+  thermal-sensors:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description:
+      The names of the thermal zone to aggregate.
+
+required:
+  - aggregation-function
+  - thermal-sensors
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/thermal/thermal.h>
+    #include <dt-bindings/thermal/virtual-sensor.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/mt8192-clk.h>
+
+    lvts: lvts@1100b000 {
+        compatible = "mediatek,mt6873-lvts";
+        reg = <0x1100b000 0x1000>;
+        clocks = <&infracfg CLK_INFRA_THERM>;
+        clock-names = "lvts_clk";
+        #thermal-sensor-cells = <1>;
+        interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+    cpu_max_sensor: cpu_max_sensor {
+      compatible = "virtual,thermal-sensor";
+      #thermal-sensor-cells = <1>;
+      aggregation-function = <VIRTUAL_THERMAL_SENSOR_MAX_VAL>;
+      thermal-sensors = "cpu1", "cpu2";
+    };
+
+    thermal_zones: thermal-zones {
+      cpu1 {
+        polling-delay = <0>; /* milliseconds */
+        polling-delay-passive = <0>; /* milliseconds */
+        thermal-sensors = <&lvts 0>;
+      };
+      cpu2 {
+        polling-delay = <0>; /* milliseconds */
+        polling-delay-passive = <0>; /* milliseconds */
+        thermal-sensors = <&lvts 1>;
+      };
+      cpu_max {
+        polling-delay = <0>; /* milliseconds */
+        polling-delay-passive = <0>; /* milliseconds */
+        thermal-sensors = <&cpu_max_sensor 0>;
+      };
+    };
+...
diff --git a/include/dt-bindings/thermal/virtual-sensor.h b/include/dt-bindings/thermal/virtual-sensor.h
new file mode 100644
index 000000000000..6254b2aa8f5c
--- /dev/null
+++ b/include/dt-bindings/thermal/virtual-sensor.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * This header provides constants for virtual thermal sensor bindings.
+ *
+ * Copyright (C) 2021 BayLibre
+ */
+
+#ifndef _DT_BINDINGS_THERMAL_VIRTUAL_SENSOR_H
+#define _DT_BINDINGS_THERMAL_VIRTUAL_SENSOR_H
+
+#define VIRTUAL_THERMAL_SENSOR_MIN_VAL 0
+#define VIRTUAL_THERMAL_SENSOR_MAX_VAL 1
+#define VIRTUAL_THERMAL_SENSOR_AVG_VAL 2
+
+#endif /* _DT_BINDINGS_THERMAL_VIRTUAL_SENSOR_H */
-- 
2.25.1

