Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AC0402038
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 21:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343625AbhIFTGI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 15:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343621AbhIFTER (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 15:04:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414A5C0617AE
        for <linux-pm@vger.kernel.org>; Mon,  6 Sep 2021 12:03:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id g135so5215573wme.5
        for <linux-pm@vger.kernel.org>; Mon, 06 Sep 2021 12:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WJPXqkih2bJaRr2yhQLBvi2zA07HJWoA2pkyb7ChylM=;
        b=bg6lV7sE50Nr2U+QD0uTOfEvW+iyFeHfrLUy47SMYAiUEfu0swzA0ODqEfXnhHffJX
         WlCINz1Kilq7YW4KUvuT4XxrAd1X+C8MCeXJ9FmzsG+NspGJkJVNh+Ti1+HrCtnM9gua
         aAjFKyRTzMvE9qjl7yGbZQrrwD2l2hWQBC/bXluE96TTV3XzWG+KKI2buOuqI86N7urt
         mQ1FUpFgcQHMfHJIJSqBtCkqePC9BHgC9EhU/kvjapkojtMOh00BImptVjvbRc+MwHI/
         PxLC6fm0CqXlKAfHwcOv1yKOcdaLT++9vAhneCukLg7mDiplQMPF3yMDbZFRgLeJJvTZ
         1AEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJPXqkih2bJaRr2yhQLBvi2zA07HJWoA2pkyb7ChylM=;
        b=Rzn7htv1WZLoD8ft594UCMLsSQWyEdLUXwW44AYb6B1PZr98Eacb0TOFgZXTx+Ffdx
         +dXrYvM9kSMSkPmS5Rs4ljJSOO12YZerSuh/v+OLb62zKbqD0Pj7KScR4pias8Jyg7XZ
         x9eTh0U6kIymAe3bV9iOL7wGo77Gga6TbLjW+dO6rRZyLXpOJXjU8F+FwYTtZHQP5GUt
         C1HWNZBZ+27RTKz/Co2kD2n35KkFeY7JudiNEptgPOHe9YnnN1Jlaxit4p8QjX+OMO7x
         ZTfidg2/oa3NFTaYyx+VdmMQIRAm3PkRaiWyq5fUMorcXmaj0/0ZNncP3DVSfcxi2mZI
         tnYw==
X-Gm-Message-State: AOAM533Addv9yPp7VhlRosX6ZuETBJ3UgwnddKY/2jOc/q66DfhmgLDP
        0nUEuqSudu5QqNJo4dmaXHRRQQ==
X-Google-Smtp-Source: ABdhPJzIifJ7oHbMRU2md0J66dQ//E1bdiO5wrb3cuCq1BgT2CDfqxuSF79kolay0p1rTTRim1xPEA==
X-Received: by 2002:a05:600c:1c11:: with SMTP id j17mr531079wms.138.1630954989813;
        Mon, 06 Sep 2021 12:03:09 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3a81:3690:b885:8dcf:f8c6:7841])
        by smtp.gmail.com with ESMTPSA id p4sm324750wmc.11.2021.09.06.12.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 12:03:09 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, gpain@baylibre.com,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: Add bindings for the virtual thermal sensor
Date:   Mon,  6 Sep 2021 21:04:53 +0200
Message-Id: <20210906190454.114751-2-abailon@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210906190454.114751-1-abailon@baylibre.com>
References: <20210906190454.114751-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds the device tree bidings for the virtual thermal sensor.
The virtual sensor could be used to a temperature computed from
many thermal sensors.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 .../thermal/virtual,thermal-sensor.yaml       | 67 +++++++++++++++++++
 include/dt-bindings/thermal/virtual-sensor.h  | 15 +++++
 2 files changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml
 create mode 100644 include/dt-bindings/thermal/virtual-sensor.h

diff --git a/Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml b/Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml
new file mode 100644
index 0000000000000..848b5912c79f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/virtual,thermal-sensor.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2021 BayLibre
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/thermal-sensor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtual thermal sensor binding
+
+description: |
+  The virtual thermal sensor devices provide temperature sensing capabilities
+  based on hardware thermal sensors. Basically, this could be used to get the
+  maximum, minimum or average temperature of the hardware thermal sensors.
+properties:
+  "#thermal-sensor-cells":
+    description:
+      Used to uniquely identify a thermal sensor instance within an IC. Will be
+      0 on sensor nodes with only a single sensor and at least 1 on nodes
+      containing several internal sensors.
+    enum: [0, 1]
+
+  type:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Used to select the operations to perform on the sensors to get the virtual
+      sensor temperature.
+    enum:
+      - VIRTUAL_SENSOR_MIN
+      - VIRTUAL_SENSOR_MAX
+      - VIRTUAL_SENSOR_AVG
+
+  thermal-sensors:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      The thermal sensor phandle and sensor specifier used to monitor this
+      thermal zone.
+
+required:
+  - "#thermal-sensor-cells"
+  - type
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
+        #thermal-sensor-cells = <0>;
+        interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+    soc_max_sensor: soc_max_sensor {
+      compatible = "virtual,thermal-sensor";
+      #thermal-sensor-cells = <1>;
+      type = <VIRTUAL_SENSOR_MAX>;
+      thermal-sensors = <&lvts 0>, <&lvts 1>;
+    };
+...
diff --git a/include/dt-bindings/thermal/virtual-sensor.h b/include/dt-bindings/thermal/virtual-sensor.h
new file mode 100644
index 0000000000000..b3e4032f6f62b
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
+#define VIRTUAL_SENSOR_MIN 0
+#define VIRTUAL_SENSOR_MAX 1
+#define VIRTUAL_SENSOR_AVG 2
+
+#endif /* _DT_BINDINGS_THERMAL_VIRTUAL_SENSOR_H */
-- 
2.31.1

