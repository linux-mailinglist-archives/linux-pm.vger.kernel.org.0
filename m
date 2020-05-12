Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD801CFE44
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 21:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgELT2z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 15:28:55 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38476 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELT2z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 15:28:55 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04CJSr8T034787;
        Tue, 12 May 2020 14:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589311733;
        bh=jZjd7h80nVi36Y+cNiTClb8casFOv10sTc57U6QdgU8=;
        h=From:To:CC:Subject:Date;
        b=icy0+cnBqiyCsFbbGNLnyzEe0+nG1qOsA0HttsktTmtO0pewWOtL5A33DS/0RwbRo
         phbA9okDKnLPCODAdw1of5isFHgo2rKud3VNJ1S171vaJ2hy6jTURNuSgmcvaL8TZB
         EUQqFV9ip/4AzCrEOWLrUFNnH77Z2yxG1d2tKA7Y=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04CJSrXb069890
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 14:28:53 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 May 2020 14:28:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 May 2020 14:28:52 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04CJSqrd051392;
        Tue, 12 May 2020 14:28:52 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [RESEND PATCH v3] dt-bindings: power: Convert bq27xxx dt to yaml
Date:   Tue, 12 May 2020 14:19:00 -0500
Message-ID: <20200512191900.966-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the bq27xxx.txt to yaml format

CC: Pali Rohár <pali@kernel.org>
CC: Andrew F. Davis <afd@ti.com>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v3 - Added power supply reference to yaml, fixed the deprecated compatibles,
I did not change any compatibles as discussed in the list these should come in
separate patches - https://lore.kernel.org/patchwork/patch/1237912/

 .../bindings/power/supply/bq27xxx.txt         | 56 ------------
 .../bindings/power/supply/bq27xxx.yaml        | 91 +++++++++++++++++++
 2 files changed, 91 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/bq27xxx.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
deleted file mode 100644
index 4fa8e08df2b6..000000000000
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-TI BQ27XXX fuel gauge family
-
-Required properties:
-- compatible: contains one of the following:
- * "ti,bq27200" - BQ27200
- * "ti,bq27210" - BQ27210
- * "ti,bq27500" - deprecated, use revision specific property below
- * "ti,bq27510" - deprecated, use revision specific property below
- * "ti,bq27520" - deprecated, use revision specific property below
- * "ti,bq27500-1" - BQ27500/1
- * "ti,bq27510g1" - BQ27510-g1
- * "ti,bq27510g2" - BQ27510-g2
- * "ti,bq27510g3" - BQ27510-g3
- * "ti,bq27520g1" - BQ27520-g1
- * "ti,bq27520g2" - BQ27520-g2
- * "ti,bq27520g3" - BQ27520-g3
- * "ti,bq27520g4" - BQ27520-g4
- * "ti,bq27521" - BQ27521
- * "ti,bq27530" - BQ27530
- * "ti,bq27531" - BQ27531
- * "ti,bq27541" - BQ27541
- * "ti,bq27542" - BQ27542
- * "ti,bq27546" - BQ27546
- * "ti,bq27742" - BQ27742
- * "ti,bq27545" - BQ27545
- * "ti,bq27411" - BQ27411
- * "ti,bq27421" - BQ27421
- * "ti,bq27425" - BQ27425
- * "ti,bq27426" - BQ27426
- * "ti,bq27441" - BQ27441
- * "ti,bq27621" - BQ27621
-- reg: integer, I2C address of the fuel gauge.
-
-Optional properties:
-- monitored-battery: phandle of battery characteristics node
-    The fuel gauge uses the following battery properties:
-    + energy-full-design-microwatt-hours
-    + charge-full-design-microamp-hours
-    + voltage-min-design-microvolt
-  Both or neither of the *-full-design-*-hours properties must be set.
-  See Documentation/devicetree/bindings/power/supply/battery.txt
-
-Example:
-
-	bat: battery {
-		compatible = "simple-battery";
-		voltage-min-design-microvolt = <3200000>;
-		energy-full-design-microwatt-hours = <5290000>;
-		charge-full-design-microamp-hours = <1430000>;
-	};
-
-	bq27510g3: fuel-gauge@55 {
-		compatible = "ti,bq27510g3";
-		reg = <0x55>;
-		monitored-battery = <&bat>;
-	};
diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
new file mode 100644
index 000000000000..03d1020a2e47
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/bq27xxx.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TI BQ27XXX fuel gauge family
+
+maintainers:
+  - Pali Rohár <pali@kernel.org>
+  - Andrew F. Davis <afd@ti.com>
+  - Sebastian Reichel <sre@kernel.org>
+
+description: |
+  Support various Texas Instruments fuel gauge devices that share similar
+  register maps and power supply properties
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,bq27200
+      - ti,bq27210
+      - ti,bq27500 # deprecated, use revision specific property below
+      - ti,bq27510 # deprecated, use revision specific property below
+      - ti,bq27520 # deprecated, use revision specific property below
+      - ti,bq27500-1
+      - ti,bq27510g1
+      - ti,bq27510g2
+      - ti,bq27510g3
+      - ti,bq27520g1
+      - ti,bq27520g2
+      - ti,bq27520g3
+      - ti,bq27520g4
+      - ti,bq27521
+      - ti,bq27530
+      - ti,bq27531
+      - ti,bq27541
+      - ti,bq27542
+      - ti,bq27546
+      - ti,bq27742
+      - ti,bq27545
+      - ti,bq27411
+      - ti,bq27421
+      - ti,bq27425
+      - ti,bq27426
+      - ti,bq27441
+      - ti,bq27621
+
+  reg:
+    maxItems: 1
+    description: integer, I2C address of the fuel gauge.
+
+  monitored-battery:
+    description: |
+       phandle of battery characteristics node.
+       The fuel gauge uses the following battery properties:
+       - energy-full-design-microwatt-hours
+       - charge-full-design-microamp-hours
+       - voltage-min-design-microvolt
+       Both or neither of the *-full-design-*-hours properties must be set.
+       See Documentation/devicetree/bindings/power/supply/battery.txt
+
+  power-supplies: true
+
+required:
+  - compatible
+  - reg
+additionalProperties: false
+
+examples:
+  - |
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      bat: battery {
+        compatible = "simple-battery";
+        voltage-min-design-microvolt = <3200000>;
+        energy-full-design-microwatt-hours = <5290000>;
+        charge-full-design-microamp-hours = <1430000>;
+      };
+
+      bq27510g3: fuel-gauge@55 {
+        compatible = "ti,bq27510g3";
+        reg = <0x55>;
+        monitored-battery = <&bat>;
+      };
+    };
-- 
2.25.1

