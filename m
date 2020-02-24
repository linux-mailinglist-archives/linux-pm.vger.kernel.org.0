Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 249E1169F06
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 08:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgBXHUg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 02:20:36 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34483 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbgBXHUg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 02:20:36 -0500
Received: by mail-pg1-f195.google.com with SMTP id j4so4670040pgi.1
        for <linux-pm@vger.kernel.org>; Sun, 23 Feb 2020 23:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hYyHTVUj+djldG9B+Pq0Lr60baNa5Q3EKWfIUDYwvYI=;
        b=GBymmIvHQzBNttVSYVv5zYioRedO0qpWmadZ/xeDiAucUdzezkn4nxbRFUhmMKf00D
         M17Xo2FZ5pHqokQN78baFSHtO9nZlinJUCND5Tx+CFDRe7zUGjnuROC9dk57mGzeOw3q
         XESDdIvXfpEyX8U2CgweKbYC5mpJfvkzEby+4DNo02a9SXZepISxcRuOM3lnERl9+135
         +i95uUJynJ1Dr80pEIK9k6oP+C6kuIHOJ+JZwWTCX3EMYQP317WV3pJxJah7N4x2RITG
         5QOSnApOEjcT+tZyYyo/XEgsfNcknaQRWmF//fvBCv/yupJ3LHDDiuck/yokcmCgMUQ3
         LKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hYyHTVUj+djldG9B+Pq0Lr60baNa5Q3EKWfIUDYwvYI=;
        b=X6IGYSU5UgB8ozK7GiIaA3ubINKazrtiSbXNsSDdxbTUMcfHmP/BZ8ElV5a1Fe7dPH
         WBH70DhqCWxcVFQfSuh7Rn5IiNp9k4HGTmvi/GhmkCIcJo6rK+QLhzlS6OnhYK4/YkqZ
         T3xj1x5J6kDiY4IDlUOABXtoMk9IY3Eh8mCkEo34nwlEG82eXffAztFF+erccLTcFt/Q
         GgqQqRsTKRLph6J6MFi8JOXzgnzjEJ3GdflUdbvA2di+11fUfmL6nRzj3V0dPLQJ4u59
         r+h29sHBHmFW+Rtjmr/VQmp8TUKHZ/5noC/KPUqqUAgTlvX6FKHYvUYgY+YO4jUJFe9w
         W7Yg==
X-Gm-Message-State: APjAAAWdm2Wd+aiLxEuhI7OedNNQoba9h0aTDOd6tRZVwHxk/649c41B
        0FKxyAXUAob0JyqJ68V8ZUphzQ==
X-Google-Smtp-Source: APXvYqwvFRvxv26RRNm47hP/leNjWMWg+BVjynUNfAbz416mcQ1C+oJMs4zsslhD7uvy/ML9iVbIUw==
X-Received: by 2002:a63:82c2:: with SMTP id w185mr16660957pgd.382.1582528835465;
        Sun, 23 Feb 2020 23:20:35 -0800 (PST)
Received: from localhost ([45.127.44.57])
        by smtp.gmail.com with ESMTPSA id l69sm11142310pgd.1.2020.02.23.23.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 23:20:34 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC PATCH v5 1/3] dt-bindings: thermal: Add yaml bindings for thermal sensors
Date:   Mon, 24 Feb 2020 12:50:25 +0530
Message-Id: <11f9128efef92b427d93a563d5b53b62c4c01888.1582527752.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1582527752.git.amit.kucheria@linaro.org>
References: <cover.1582527752.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As part of moving the thermal bindings to YAML, split it up into 3
bindings: thermal sensors, cooling devices and thermal zones.

The property #thermal-sensor-cells is required in each device that acts
as a thermal sensor. It is used to uniquely identify the instance of the
thermal sensor inside the system.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 .../bindings/thermal/thermal-sensor.yaml      | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-sensor.yaml

diff --git a/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml b/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
new file mode 100644
index 000000000000..ac32f54f2f98
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0 OR MIT)
+# Copyright 2020 Linaro Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/thermal-sensor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Thermal sensor binding
+
+maintainers:
+  - Amit Kucheria <amitk@kernel.org>
+
+description: |
+  Thermal management is achieved in devicetree by describing the sensor hardware
+  and the software abstraction of thermal zones required to take appropriate
+  action to mitigate thermal overloads.
+
+  The following node types are used to completely describe a thermal management
+  system in devicetree:
+   - thermal-sensor: device that measures temperature, has SoC-specific bindings
+   - cooling-device: device used to dissipate heat either passively or artively
+   - thermal-zones: a container of the following node types used to describe all
+     thermal data for the platform
+
+  This binding describes the thermal-sensor.
+
+  Thermal sensor devices provide temperature sensing capabilities on thermal
+  zones. Typical devices are I2C ADC converters and bandgaps. Thermal sensor
+  devices may control one or more internal sensors.
+
+properties:
+  "#thermal-sensor-cells":
+    description:
+      Used to uniquely identify a thermal sensor instance within an IC. Will be
+      0 on sensor nodes with only a single sensor and at least 1 on nodes
+      containing several internal sensors.
+    enum: [0, 1]
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    // Example 1: SDM845 TSENS
+    soc: soc@0 {
+            #address-cells = <2>;
+            #size-cells = <2>;
+
+            /* ... */
+
+            tsens0: thermal-sensor@c263000 {
+                    compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+                    reg = <0 0x0c263000 0 0x1ff>, /* TM */
+                          <0 0x0c222000 0 0x1ff>; /* SROT */
+                    #qcom,sensors = <13>;
+                    interrupts = <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
+                    interrupt-names = "uplow";
+                    #thermal-sensor-cells = <1>;
+            };
+
+            tsens1: thermal-sensor@c265000 {
+                    compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+                    reg = <0 0x0c265000 0 0x1ff>, /* TM */
+                          <0 0x0c223000 0 0x1ff>; /* SROT */
+                    #qcom,sensors = <8>;
+                    interrupts = <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH>;
+                    interrupt-names = "uplow";
+                    #thermal-sensor-cells = <1>;
+            };
+    };
+...
-- 
2.20.1

