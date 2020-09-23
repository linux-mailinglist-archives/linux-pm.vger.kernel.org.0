Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA01275BB0
	for <lists+linux-pm@lfdr.de>; Wed, 23 Sep 2020 17:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgIWPYY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Sep 2020 11:24:24 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33134 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgIWPYY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Sep 2020 11:24:24 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NFOMee022569;
        Wed, 23 Sep 2020 10:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600874662;
        bh=XG7Whd3Om2bowv6dtVLcdP2kjKd0zNjYwmu0Q6trzE4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZRRWb3PsCewnvjibfnHw25ezNbsKro8T3RMUGgguAec+972+hKRphNgbOEKdUH/n9
         TLMb/Xy0OKzQ1JiF+RwJcBmJF79WISOt+L1wbSZQzcmK6secoEpbGkmLMSuWnGlBJg
         hug2YzWlUDXYtlTf84K4/m8uNCgkig1bzEqy5fZw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NFOMIL105524;
        Wed, 23 Sep 2020 10:24:22 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 10:24:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 10:24:21 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NFOLur101795;
        Wed, 23 Sep 2020 10:24:21 -0500
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
To:     <sre@kernel.org>, <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <dmurphy@ti.com>, Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Subject: [PATCH v4 1/2] dt-bindings: power: Add the bq256xx dt bindings
Date:   Wed, 23 Sep 2020 10:24:15 -0500
Message-ID: <20200923152416.24822-2-r-rivera-matos@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923152416.24822-1-r-rivera-matos@ti.com>
References: <20200923152416.24822-1-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the bindings for the bq256xx series of battery charging ICs.

Datasheets:
- https://www.ti.com/lit/ds/symlink/bq25600.pdf
- https://www.ti.com/lit/ds/symlink/bq25601.pdf
- https://www.ti.com/lit/ds/symlink/bq25600d.pdf
- https://www.ti.com/lit/ds/symlink/bq25601d.pdf
- https://www.ti.com/lit/ds/symlink/bq25611d.pdf
- https://www.ti.com/lit/ds/symlink/bq25618.pdf
- https://www.ti.com/lit/ds/symlink/bq25619.pdf

Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>

---

v4 - documents monitored-battery and interrupts, fixes example for
ti,watchdog-timeout-ms

 .../bindings/power/supply/bq256xx.yaml        | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq256xx.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
new file mode 100644
index 000000000000..18b54783e11a
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/bq256xx.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TI bq256xx Switch Mode Buck Charger
+
+maintainers:
+  - Ricardo Rivera-Matos <r-rivera-matos@ti.com>
+
+description: |
+  The bq256xx devices are a family of highly-integrated battery charge
+  management and system power management ICs for single cell Li-ion and Li-
+  polymer batteries.
+
+  Datasheets:
+    - https://www.ti.com/lit/ds/symlink/bq25600.pdf
+    - https://www.ti.com/lit/ds/symlink/bq25601.pdf
+    - https://www.ti.com/lit/ds/symlink/bq25600d.pdf
+    - https://www.ti.com/lit/ds/symlink/bq25601d.pdf
+    - https://www.ti.com/lit/ds/symlink/bq25611d.pdf
+    - https://www.ti.com/lit/ds/symlink/bq25618.pdf
+    - https://www.ti.com/lit/ds/symlink/bq25619.pdf
+
+properties:
+  compatible:
+    enum:
+      - ti,bq25600
+      - ti,bq25601
+      - ti,bq25600d
+      - ti,bq25601d
+      - ti,bq25611d
+      - ti,bq25618
+      - ti,bq25619
+
+  reg:
+    maxItems: 1
+
+  ti,watchdog-timeout-ms:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+    description: |
+      Watchdog timer in ms. 0 (default) disables the watchdog
+    minimum: 0
+    maximum: 160000
+    enum: [ 0, 40000, 80000, 160000]
+
+  input-voltage-limit-microvolt:
+    description: |
+       Minimum input voltage limit in µV with a 100000 µV step
+    minimum: 3900000
+    maximum: 5400000
+
+  input-current-limit-microamp:
+    description: |
+       Maximum input current limit in µA with a 100000 µA step
+    minimum: 100000
+    maximum: 3200000
+
+  monitored-battery:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the battery node being monitored
+
+  interrupts:
+    maxItems: 1
+    description: |
+      Interrupt sends an active low, 256 μs pulse to host to report the charger
+      device status and faults.
+
+required:
+  - compatible
+  - reg
+  - monitored-battery
+
+additionalProperties: false
+
+examples:
+  - |
+    bat: battery {
+      compatible = "simple-battery";
+      constant-charge-current-max-microamp = <2040000>;
+      constant-charge-voltage-max-microvolt = <4352000>;
+      precharge-current-microamp = <180000>;
+      charge-term-current-microamp = <180000>;
+    };
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+
+      clock-frequency = <400000>;
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@6b {
+        compatible = "ti,bq25601";
+        reg = <0x6b>;
+        monitored-battery = <&bat>;
+
+        interrupt-parent = <&gpio1>;
+        interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+        ti,watchdog-timeout-ms = <40000>;
+
+        input-voltage-limit-microvolt = <4500000>;
+        input-current-limit-microamp = <2400000>;
+       };
+    };
+...
-- 
2.28.0

