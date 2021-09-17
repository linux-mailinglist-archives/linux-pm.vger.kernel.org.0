Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACC740F330
	for <lists+linux-pm@lfdr.de>; Fri, 17 Sep 2021 09:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbhIQH1I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Sep 2021 03:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239272AbhIQH1H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Sep 2021 03:27:07 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF682C061764
        for <linux-pm@vger.kernel.org>; Fri, 17 Sep 2021 00:25:45 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id s24so6536181wmh.4
        for <linux-pm@vger.kernel.org>; Fri, 17 Sep 2021 00:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iAiAjfHULvSkEXET8f5wVsDWre5TWnookf/FICWyQDE=;
        b=ixOao/HZulX8ebkoTGjNSpcFgJG1iRiIvduv1Y7eHivIuEo3c2ap3UpWC3Az1Lg4NB
         wNFg1nG4mr0dBQLMW9MmBx3ueLUb1QvhQsjMG7+VNQ3d32TQ9qoW/87VpOPToT64Vt8O
         SjZfHh9gF1Ls6dhJRxS7JTJInCuSgmR+vd8Sj449yXJJNbk1EowhOiJbVi0Dr0pWrj2N
         /J+658YxnTuREpMnpZWC7tHMuZgyqyHNuNdEuz0VoOi+mR9mukLJwnzuAan30TOVsvgV
         b/+bEV1gHrGiJiK18b6/EC6HZpgcmpSa+dOUr6axiuP3WI4hzgIWZw4/8n4mBkLO24nP
         siYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iAiAjfHULvSkEXET8f5wVsDWre5TWnookf/FICWyQDE=;
        b=bZ0SrV1Gpny6/OV3mfw3QeSJ7mXOGU4tk591ofzOCysc/+y0WcQEp98NGRRvDPEw9V
         JDbZiX97xeQJYPHPlvOc+BBRvOW+6zRtQRThDflf7fQj7XFxtGvkM/UydibGZV9iCcvy
         CGC8Bf8PMDYGjuxNpPE0Yy1rE2rNwv3NOn1zrlobpWvfO3zlqx5EZMnVEP26Sn0hyDhp
         2xJdXlLUKYNxWvz0G6wh0zDcg2DmEHH2uXSt/eHFIIe5+9IdKDHlsskCx5Q7iV2GaLIu
         2Ao19A1DEYqFGieQqcdAscqJQU/QXBSjeHS0kT2Zs2dJL+hyWpDxnnw9RVKIl5we49OX
         65xA==
X-Gm-Message-State: AOAM532xZaa7TeO5V0wr/7bO8kHdllvl2RJuaDgpPERBMB9H95ROSqbf
        bXfA/hmpHA7GLqV/SPpcwTM5Rw==
X-Google-Smtp-Source: ABdhPJy8TEPcqC/LfpgvUg2g+F4guhtaGSbnKEk6mfPFIJuLJuNTSqsJWxCvZ8/1Qs15kf3OZxRmWA==
X-Received: by 2002:a7b:c107:: with SMTP id w7mr8895517wmi.91.1631863544393;
        Fri, 17 Sep 2021 00:25:44 -0700 (PDT)
Received: from localhost.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z19sm11777565wma.0.2021.09.17.00.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:25:43 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, khilman@baylibre.com, mka@chromium.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v2 1/2] dt-bindings: Add bindings for the virtual thermal sensor
Date:   Fri, 17 Sep 2021 09:27:31 +0200
Message-Id: <20210917072732.611140-2-abailon@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210917072732.611140-1-abailon@baylibre.com>
References: <20210917072732.611140-1-abailon@baylibre.com>
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
index 0000000000000..049620ed88a5b
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
+  aggregation-function:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Used to select the operations to perform on the sensors to get the virtual
+      sensor temperature.
+    enum:
+      - VIRTUAL_THERMAL_SENSOR_MIN
+      - VIRTUAL_THERMAL_SENSOR_MAX
+      - VIRTUAL_THERMAL_SENSOR_AVG
+
+  thermal-sensors:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      The thermal sensor phandle and sensor specifier used to monitor this
+      thermal zone.
+
+required:
+  - "#thermal-sensor-cells"
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
+        #thermal-sensor-cells = <0>;
+        interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+    soc_max_sensor: soc_max_sensor {
+      compatible = "virtual,thermal-sensor";
+      #thermal-sensor-cells = <1>;
+      aggregation-function = <VIRTUAL_THERMAL_SENSOR_MAX>;
+      thermal-sensors = <&lvts 0>, <&lvts 1>;
+    };
+...
diff --git a/include/dt-bindings/thermal/virtual-sensor.h b/include/dt-bindings/thermal/virtual-sensor.h
new file mode 100644
index 0000000000000..93f6dc2453b85
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
+#define VIRTUAL_THERMAL_SENSOR_MIN 0
+#define VIRTUAL_THERMAL_SENSOR_MAX 1
+#define VIRTUAL_THERMAL_SENSOR_AVG 2
+
+#endif /* _DT_BINDINGS_THERMAL_VIRTUAL_SENSOR_H */
-- 
2.31.1

