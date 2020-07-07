Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0798B217A5D
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jul 2020 23:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgGGV3p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jul 2020 17:29:45 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49190 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgGGV3n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2020 17:29:43 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 067LTfrs004891;
        Tue, 7 Jul 2020 16:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594157381;
        bh=RLwIAehcXxgMONZs8WT0zyvf7kMDbvxzalt0l62/GGE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bjkm7fYODWp3HttGV9H8UZ72BRCl1lbKM01VupRFF1DBpUtz3/gUPOCYnyytm34QV
         Ys2xdi7gwJ//Ok9ogYNzRU5c9MtCj+6kZQLbPqHX/jvwYLecBjj3a9agfSm2U+RRU5
         nQrA6rPFQED6SbxRvQ7H6D2oKdd3s6v6a9UQ/Vhc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 067LTfi7047415;
        Tue, 7 Jul 2020 16:29:41 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 7 Jul
 2020 16:29:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 7 Jul 2020 16:29:41 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 067LTfc2113158;
        Tue, 7 Jul 2020 16:29:41 -0500
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
To:     <sre@kernel.org>, <pali@kernel.org>, <robh@kernel.org>
CC:     <afd@ti.com>, <r-rivera-matos@ti.com>, <dmurphy@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <sspatil@android.com>
Subject: [PATCH v16 3/4] dt-bindings: power: Add the bindings for the bq2515x family of chargers.
Date:   Tue, 7 Jul 2020 16:29:13 -0500
Message-ID: <20200707212914.31540-4-r-rivera-matos@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707212914.31540-1-r-rivera-matos@ti.com>
References: <20200707212914.31540-1-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The BQ2515X family of devices are highly integrated battery management
ICs that integrate the most common functions for wearable devices
namely a charger, an output voltage rail, ADC for battery and system
monitoring, and a push-button controller.

Datasheets:
http://www.ti.com/lit/ds/symlink/bq25150.pdf
http://www.ti.com/lit/ds/symlink/bq25155.pdf

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
---
 .../bindings/power/supply/bq2515x.yaml        | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/bq2515x.yaml b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
new file mode 100644
index 000000000000..75a56773be4a
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/bq2515x.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TI bq2515x 500-mA Linear charger family
+
+maintainers:
+  - Dan Murphy <dmurphy@ti.com>
+  - Ricardo Rivera-Matos <r-rivera-matos@ti.com>
+
+description: |
+  The BQ2515x family is a highly integrated battery charge management IC that
+  integrates the most common functions for wearable devices, namely a charger,
+  an output voltage rail, ADC for battery and system monitoring, and
+  push-button controller.
+
+  Specifications about the charger can be found at:
+    http://www.ti.com/lit/ds/symlink/bq25150.pdf
+    http://www.ti.com/lit/ds/symlink/bq25155.pdf
+
+properties:
+  compatible:
+    enum:
+      - ti,bq25150
+      - ti,bq25155
+
+  reg:
+    maxItems: 1
+    description: I2C address of the charger.
+
+  ac-detect-gpios:
+    description: |
+       GPIO used for connecting the bq2515x device PG (AC Detect)
+       pin.
+    maxItems: 1
+
+  reset-gpios:
+    description: GPIO used for hardware reset.
+    maxItems: 1
+
+  powerdown-gpios:
+    description: GPIO used for low power mode of IC.
+    maxItems: 1
+
+  charge-enable-gpios:
+    description: GPIO used to turn on and off charging.
+    maxItems: 1
+
+  input-current-limit-microamp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Maximum input current in micro Amps.
+    minimum: 50000
+    maximum: 500000
+
+  monitored-battery:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the battery node being monitored
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
+      constant-charge-current-max-microamp = <50000>;
+      precharge-current-microamp = <2500>;
+      constant-charge-voltage-max-microvolt = <4000000>;
+    };
+    #include <dt-bindings/gpio/gpio.h>
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      bq25150: charger@6b {
+        compatible = "ti,bq25150";
+        reg = <0x6b>;
+        monitored-battery = <&bat>;
+        input-current-limit-microamp = <100000>;
+
+        ac-detect-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+        reset-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+        powerdown-gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
+        charge-enable-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
+      };
+    };
-- 
2.27.0

