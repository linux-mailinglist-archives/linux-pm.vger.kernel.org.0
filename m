Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D35B43FF1C
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 17:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhJ2PMP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 11:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhJ2PMP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Oct 2021 11:12:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D59C061767
        for <linux-pm@vger.kernel.org>; Fri, 29 Oct 2021 08:09:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v17so16573077wrv.9
        for <linux-pm@vger.kernel.org>; Fri, 29 Oct 2021 08:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=65re5EzQGAdkPLN7hMXkAQ3icqHMSFGYa86wA7lZ4I4=;
        b=CurLuYaIzEDUCOQi6MO3LpgAu+Rq7qgusjDId7KoyBNvGUd0F8Imz4KY4UCI+Ei1Ab
         u6HJaz5XGEEFZVdEARrs+enVicemGaqtMqiOeqt0z4kUz9j9z5bRGxkgc2elTwgwTabh
         XND9fPrjF07QQn7me+SNUqE1o81A/6d25wOTBuZoAA+/X1nxxwhUUGiKtcATGtnTx0ZX
         UUIYTKphbBEcXdRLOF5i+exLJ3jGCoO+tfogT8fjWvVSAPbiM0PL7DCvKVdnIM224Maq
         42Fl5HyJnF0ceyewZR6LFQWMcgk9h8KSYTAp+LO9P0dcL2cLswttpUrHv5U6TZtwozkM
         UEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=65re5EzQGAdkPLN7hMXkAQ3icqHMSFGYa86wA7lZ4I4=;
        b=yX3P2hAPp+ADDRAsLqQwxiFgOkv2DM87PLYfvRyRtXP1NxYJVfliYOxKorjY7P4qlR
         ShmiHKItRb1drQZhJFJDm+yO1D8Ek9hKPkBH+iKaKxAo3hJ7tDBpi8AMZNaiXOQUrRdm
         fOYk7+hcSiCyxOnslggVW+cos11EeXbSgq6kl8TfGNdxHpXBz6Ihj8W53MTfJM7wd/9p
         18OKqOMDNLBovbwIlYLZO0JkPwkUjmihC9P3wS7d6ScQdt+/C1f82CoCIqUkEmoh+1T8
         VnyIhDEUAdVIquersULxEqmWWY98IAkAmMAlC374B4cWF9++rQqxuv7xcQq5zHot5sk4
         XSYg==
X-Gm-Message-State: AOAM533KDIMpb1hvCugsJq/jOIGGQewgqKK3GHw+iO+zSzGPBUaAT7c0
        qqJCjm1uTjwxcY9o07nnFOXN5Q==
X-Google-Smtp-Source: ABdhPJyGx1YeY0OGBszJhQRmDO0Tdrt3KFB93AhI/QkUrUO6PrIiWG/Bm6a6CU0Ofq6J1gOf7zVRtw==
X-Received: by 2002:a5d:400e:: with SMTP id n14mr2205973wrp.368.1635520184729;
        Fri, 29 Oct 2021 08:09:44 -0700 (PDT)
Received: from xps-9300.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b7sm7091906wrv.72.2021.10.29.08.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 08:09:44 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v3 1/2] dt-bindings: Add DT bindings for the DT-based virtual sensor driver
Date:   Fri, 29 Oct 2021 17:08:56 +0200
Message-Id: <20211029150857.504891-2-abailon@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211029150857.504891-1-abailon@baylibre.com>
References: <20211029150857.504891-1-abailon@baylibre.com>
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
2.32.0

