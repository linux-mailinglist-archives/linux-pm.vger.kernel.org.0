Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F632114C8
	for <lists+linux-pm@lfdr.de>; Wed,  1 Jul 2020 23:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgGAVLU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Jul 2020 17:11:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55718 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgGAVLL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2020 17:11:11 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 061LB7Jg047399;
        Wed, 1 Jul 2020 16:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593637867;
        bh=cD5TXouCVg1q0HzMinj05mqRDBS/uQ6TmZTJr7iuspY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Npfz64IliluT6h9hBK5yxNMt0z95Iim2aRaGT9g37lsOdlRHOZWz32xps+3GIjJPr
         s3c+fAT468ZgozDkX60zDxKiP9v32Gk/RQAi7PMlNxiw2w98KqZNYmIxs/pQhu8gwV
         qmd9JK0V6iBPrO3UKlPxLhEdE8SH3NLx9YHdkzpU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 061LB7ga108907
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Jul 2020 16:11:07 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 1 Jul
 2020 16:11:07 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 1 Jul 2020 16:11:07 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 061LB7YT050328;
        Wed, 1 Jul 2020 16:11:07 -0500
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
To:     <sre@kernel.org>, <pali@kernel.org>, <robh@kernel.org>
CC:     <afd@ti.com>, <r-rivera-matos@ti.com>, <dmurphy@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <sspatil@android.com>
Subject: [PATCH v15 2/4] dt-bindings: power: Convert battery.txt to battery.yaml
Date:   Wed, 1 Jul 2020 16:10:42 -0500
Message-ID: <20200701211044.18590-3-r-rivera-matos@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701211044.18590-1-r-rivera-matos@ti.com>
References: <20200701211044.18590-1-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Dan Murphy <dmurphy@ti.com>

Convert the battery.txt file to yaml and fix up the examples.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../bindings/power/supply/battery.txt         |  86 +---------
 .../bindings/power/supply/battery.yaml        | 157 ++++++++++++++++++
 2 files changed, 158 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/battery.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index 5e29595edd74..a9f80cc49068 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -1,87 +1,3 @@
-Battery Characteristics
-
-The devicetree battery node provides static battery characteristics.
-In smart batteries, these are typically stored in non-volatile memory
-on a fuel gauge chip. The battery node should be used where there is
-no appropriate non-volatile memory, or it is unprogrammed/incorrect.
-
-Upstream dts files should not include battery nodes, unless the battery
-represented cannot easily be replaced in the system by one of a
-different type. This prevents unpredictable, potentially harmful,
-behavior should a replacement that changes the battery type occur
-without a corresponding update to the dtb.
+The contents of this file has been moved to battery.yaml
 
 Please note that not all charger drivers respect all of the properties.
-
-Required Properties:
- - compatible: Must be "simple-battery"
-
-Optional Properties:
- - over-voltage-threshold-microvolt: battery over-voltage limit
- - re-charge-voltage-microvolt: limit to automatically start charging again
- - voltage-min-design-microvolt: drained battery voltage
- - voltage-max-design-microvolt: fully charged battery voltage
- - energy-full-design-microwatt-hours: battery design energy
- - charge-full-design-microamp-hours: battery design capacity
- - trickle-charge-current-microamp: current for trickle-charge phase
- - precharge-current-microamp: current for pre-charge phase
- - precharge-upper-limit-microvolt: limit when to change to constant charging
- - charge-term-current-microamp: current for charge termination phase
- - constant-charge-current-max-microamp: maximum constant input current
- - constant-charge-voltage-max-microvolt: maximum constant input voltage
- - factory-internal-resistance-micro-ohms: battery factory internal resistance
- - ocv-capacity-table-0: An array providing the open circuit voltage (OCV)
-   of the battery and corresponding battery capacity percent, which is used
-   to look up battery capacity according to current OCV value. And the open
-   circuit voltage unit is microvolt.
- - ocv-capacity-table-1: Same as ocv-capacity-table-0
- ......
- - ocv-capacity-table-n: Same as ocv-capacity-table-0
- - ocv-capacity-celsius: An array containing the temperature in degree Celsius,
-   for each of the battery capacity lookup table. The first temperature value
-   specifies the OCV table 0, and the second temperature value specifies the
-   OCV table 1, and so on.
- - resistance-temp-table: An array providing the temperature in degree Celsius
-   and corresponding battery internal resistance percent, which is used to look
-   up the resistance percent according to current temperature to get a accurate
-   batterty internal resistance in different temperatures.
-
-Battery properties are named, where possible, for the corresponding
-elements in enum power_supply_property, defined in
-https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/power_supply.h
-
-Batteries must be referenced by chargers and/or fuel-gauges
-using a phandle. The phandle's property should be named
-"monitored-battery".
-
-Example:
-
-	bat: battery {
-		compatible = "simple-battery";
-		voltage-min-design-microvolt = <3200000>;
-		voltage-max-design-microvolt = <4200000>;
-		energy-full-design-microwatt-hours = <5290000>;
-		charge-full-design-microamp-hours = <1430000>;
-		precharge-current-microamp = <256000>;
-		charge-term-current-microamp = <128000>;
-		constant-charge-current-max-microamp = <900000>;
-		constant-charge-voltage-max-microvolt = <4200000>;
-		factory-internal-resistance-micro-ohms = <250000>;
-		ocv-capacity-celsius = <(-10) 0 10>;
-		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
-		ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
-		ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;
-		resistance-temp-table = <20 100>, <10 90>, <0 80>, <(-10) 60>;
-	};
-
-	charger: charger@11 {
-		....
-		monitored-battery = <&bat>;
-		...
-	};
-
-	fuel_gauge: fuel-gauge@22 {
-		....
-		monitored-battery = <&bat>;
-		...
-	};
diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml b/Documentation/devicetree/bindings/power/supply/battery.yaml
new file mode 100644
index 000000000000..497429c21fb6
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
@@ -0,0 +1,157 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/battery.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Battery Characteristics
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+description: |
+  The devicetree battery node provides static battery characteristics.
+  In smart batteries, these are typically stored in non-volatile memory
+  on a fuel gauge chip. The battery node should be used where there is
+  no appropriate non-volatile memory, or it is unprogrammed/incorrect.
+
+  Upstream dts files should not include battery nodes, unless the battery
+  represented cannot easily be replaced in the system by one of a
+  different type. This prevents unpredictable, potentially harmful,
+  behavior should a replacement that changes the battery type occur
+  without a corresponding update to the dtb.
+
+  Battery properties are named, where possible, for the corresponding elements
+  in enum power_supply_property, defined in include/linux/power_supply.h
+
+  Batteries must be referenced by chargers and/or fuel-gauges using a phandle.
+  The phandle's property should be named "monitored-battery".
+
+properties:
+  compatible:
+    const: simple-battery
+
+  over-voltage-threshold-microvolt:
+    description: battery over-voltage limit
+
+  re-charge-voltage-microvolt:
+    description: limit to automatically start charging again
+
+  voltage-min-design-microvolt:
+    description: drained battery voltage
+
+  voltage-max-design-microvolt:
+    description: fully charged battery voltage
+
+  energy-full-design-microwatt-hours:
+    description: battery design energy
+
+  charge-full-design-microamp-hours:
+    description: battery design capacity
+
+  trickle-charge-current-microamp:
+    description: current for trickle-charge phase
+
+  precharge-current-microamp:
+    description: current for pre-charge phase
+
+  precharge-upper-limit-microvolt:
+    description: limit when to change to constant charging
+
+  charge-term-current-microamp:
+    description: current for charge termination phase
+
+  constant-charge-current-max-microamp:
+    description: maximum constant input current
+
+  constant-charge-voltage-max-microvolt:
+    description: maximum constant input voltage
+
+  factory-internal-resistance-micro-ohms:
+    description: battery factory internal resistance
+
+  monitored-battery:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the battery node being monitored
+
+required:
+  - compatible
+
+patternProperties:
+  '^ocv-capacity-table-[0-100]$':
+    $ref: /schema/types.yaml#/definitions/uint32-matrix
+    description: |
+      An array providing the open circuit voltage (OCV)
+      of the battery and corresponding battery capacity percent, which is used
+      to look up battery capacity according to current OCV value. And the open
+      circuit voltage unit is microvolt.
+    maxItems: 100
+    items:
+      items:
+        - description: open circuit voltage (OCV) in microvolts
+        - description: battery capacity percent
+          maximum: 100
+
+  '^resistance-temp-table-[0-100]$':
+    $ref: /schema/types.yaml#/definitions/uint32-matrix
+    description: |
+      An array providing the temperature in degree Celsius
+      and corresponding battery internal resistance percent, which is used to
+      look up the resistance percent according to current temperature to get an
+      accurate batterty internal resistance in different temperatures.
+    maxItems: 100
+    items:
+      items:
+        - description: internal resistance percent
+        - description: battery capacity percent
+          maximum: 100
+
+  '^ocv-capacity-celsius-[0-100]$':
+    $ref: /schema/types.yaml#/definitions/uint32-array
+    description: |
+      An array containing the temperature in degree Celsius,
+      for each of the battery capacity lookup table.
+    maxItems: 100
+    items:
+      items:
+        - description: temperature in degree Celsius
+        - description: battery capacity percent
+          maximum: 100
+
+additionalProperties: false
+
+examples:
+  - |
+    power {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      battery:battery {
+        compatible = "simple-battery";
+        over-voltage-threshold-microvolt = <4500000>;
+        re-charge-voltage-microvolt = <250000>;
+        voltage-min-design-microvolt = <3200000>;
+        voltage-max-design-microvolt = <4200000>;
+        energy-full-design-microwatt-hours = <5290000>;
+        charge-full-design-microamp-hours = <1430000>;
+        precharge-current-microamp = <256000>;
+        precharge-upper-limit-microvolt = <2500000>;
+        charge-term-current-microamp = <128000>;
+        constant-charge-current-max-microamp = <900000>;
+        constant-charge-voltage-max-microvolt = <4200000>;
+        factory-internal-resistance-micro-ohms = <250000>;
+        ocv-capacity-celsius-0 = <(-10) 10>;
+        ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>;
+        resistance-temp-table-0 = <20 100>, <10 90>, <0 80>, <(-10) 60>;
+      };
+
+      charger@11 {
+        reg = <0x11>;
+        monitored-battery = <&battery>;
+      };
+
+      fuel-gauge@22 {
+        reg = <0x22>;
+        monitored-battery = <&battery>;
+      };
+    };
-- 
2.27.0

