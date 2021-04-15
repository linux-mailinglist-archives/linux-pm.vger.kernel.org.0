Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3311C360819
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 13:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhDOLRr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 07:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhDOLRq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Apr 2021 07:17:46 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B27C061574;
        Thu, 15 Apr 2021 04:17:23 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 12so38452150lfq.13;
        Thu, 15 Apr 2021 04:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TsCuWVYYGZ+z5B25Adbpxqkag7yfmBZOxizqUEO4+lg=;
        b=Jp0e8ryUaqky6IA6wUPbBhkwCutpFRRb4k/sWjdejhOOxPgq8sAmL1lrNBXgLs5KXM
         y5jQTsAp2lyd91xJCY9ivPfjlCZ4FswakvKK/YgUap2bUoqHI/L5I38ho5/ob7Au5LTW
         MMewRX8o9ZQqlFYo5MWr4OczBmwcNoXi1V4/3IiGOo40LnJzjkaAHJsmxYHl7pcl23Oq
         6vtXr6HUAtdG2YjrQQP4bDBTRJvhKhHEewL/B5sFXNdLzRkiT+DICStFESDf66XYr7s1
         wHP0TgdT4q38FwOBt2E3IXa55KndJTM7GLY151f6YQJQU+jxxMj8crnEcn3qaTTEQEzR
         a0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TsCuWVYYGZ+z5B25Adbpxqkag7yfmBZOxizqUEO4+lg=;
        b=oypYVqxgBK09p+cvqVbYoZ66sMIgaoi8qwmGisu2gZps13qb3gieY7bVTUrjHESnlD
         pfIBsydPIcviduklw01uzxf/Salz/uQh4YPJ5kqsn8QV4hnhM0j3ElknfqANYk628G8s
         o7RqxzEcvY0BQycd7GoIvDVl0X5zkLCI3eyrpCV1LQPW5U9zJdW7Jeog9S4UN5VUdeuD
         jaH6FaQprjI0hdzfrrkIvmEaOizXgZ5tnb36XQvb0oxy7RtOcQM7q0Ny28Z87IPTDPrJ
         T4eEEQvTb3JKRF6hj47GKnTW1NynYZ8UkLcLKXJeOD5VLe3n+1pjogiCXqXXWY2rf6Q1
         OH7g==
X-Gm-Message-State: AOAM532aiXSv7uotVYE9ut4XiAdlbNhYXSkOmJZ+juVNZprmSsXt0h7l
        bW+ZE2NFdlIdMVPrRF86CRUo/E0rHDk=
X-Google-Smtp-Source: ABdhPJyQBzxR4OVwZbKcFM8W4BGoWs4MGk4EsqcKcLCDPgJ2LD6M/J7D4pTw0koVi32IpKaW3eX2EQ==
X-Received: by 2002:ac2:5dc9:: with SMTP id x9mr2204779lfq.215.1618485441716;
        Thu, 15 Apr 2021 04:17:21 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id o11sm577234ljg.42.2021.04.15.04.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 04:17:21 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: thermal: brcm,ns-thermal: convert to the json-schema
Date:   Thu, 15 Apr 2021 13:16:55 +0200
Message-Id: <20210415111655.4273-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This helps validating DTS files.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/thermal/brcm,ns-thermal.txt      | 37 ------------
 .../bindings/thermal/brcm,ns-thermal.yaml     | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/brcm,ns-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,ns-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.txt
deleted file mode 100644
index 68e047170039..000000000000
--- a/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-* Broadcom Northstar Thermal
-
-This binding describes thermal sensor that is part of Northstar's DMU (Device
-Management Unit).
-
-Required properties:
-- compatible : Must be "brcm,ns-thermal"
-- reg : iomem address range of PVTMON registers
-- #thermal-sensor-cells : Should be <0>
-
-Example:
-
-thermal: thermal@1800c2c0 {
-	compatible = "brcm,ns-thermal";
-	reg = <0x1800c2c0 0x10>;
-	#thermal-sensor-cells = <0>;
-};
-
-thermal-zones {
-	cpu_thermal: cpu-thermal {
-		polling-delay-passive = <0>;
-		polling-delay = <1000>;
-		coefficients = <(-556) 418000>;
-		thermal-sensors = <&thermal>;
-
-		trips {
-			cpu-crit {
-				temperature	= <125000>;
-				hysteresis	= <0>;
-				type		= "critical";
-			};
-		};
-
-		cooling-maps {
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.yaml b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.yaml
new file mode 100644
index 000000000000..50143e2f6bcb
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/brcm,ns-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Northstar Thermal
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+description:
+  Thermal sensor that is part of Northstar's DMU (Device Management Unit).
+
+allOf:
+  - $ref: thermal-sensor.yaml#
+
+properties:
+  compatible:
+    const: brcm,ns-thermal
+
+  reg:
+    description: PVTMON registers range
+
+  "#thermal-sensor-cells":
+    const: 0
+
+unevaluatedProperties: false
+
+required:
+  - reg
+
+examples:
+  - |
+    thermal: thermal@1800c2c0 {
+        compatible = "brcm,ns-thermal";
+        reg = <0x1800c2c0 0x10>;
+        #thermal-sensor-cells = <0>;
+    };
+
+    thermal-zones {
+        cpu-thermal {
+            polling-delay-passive = <0>;
+            polling-delay = <1000>;
+            coefficients = <(-556) 418000>;
+            thermal-sensors = <&thermal>;
+
+            trips {
+                cpu-crit {
+                    temperature = <125000>;
+                    hysteresis = <0>;
+                    type = "critical";
+                };
+            };
+
+            cooling-maps {
+            };
+        };
+    };
-- 
2.26.2

