Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713AF1E6FA4
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 00:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437377AbgE1WyS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 18:54:18 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36898 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437362AbgE1WyO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 18:54:14 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04SMs9O5103633;
        Thu, 28 May 2020 17:54:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590706449;
        bh=NwzbfBxZO6Fv/RgiI97+y9ukXOLrBcZkNusGCGUythU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fBDn1SdRmFBJB7+awuy7rrqNrvB+q5jCvDRHsWj4W2sWX7S9Gm7Ysh3i+S57LP9us
         nS1KUZ13ki2XZ0xFwH+kBiXUgqD58X2oblAYu4optdRwfctXU7X9IUM6pO0bJGdq0c
         U2Vq1N/CYsmRH1TCV+krdiec+bGmm4phOXtK/Owo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04SMs9s3100300
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 17:54:09 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 28
 May 2020 17:54:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 28 May 2020 17:54:08 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04SMs8k1101796;
        Thu, 28 May 2020 17:54:08 -0500
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
To:     <sre@kernel.org>, <pali@kernel.org>, <robh@kernel.org>
CC:     <afd@ti.com>, <r-rivera-matos@ti.com>, <dmurphy@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <sspatil@android.com>
Subject: [PATCH v12 3/4] dt-bindings: power: Add the bindings for the bq2515x family of chargers.
Date:   Thu, 28 May 2020 17:53:49 -0500
Message-ID: <20200528225350.661-4-r-rivera-matos@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528225350.661-1-r-rivera-matos@ti.com>
References: <20200528225350.661-1-r-rivera-matos@ti.com>
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

Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
---
 .../bindings/power/supply/bq2515x.yaml        | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/bq2515x.yaml b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
new file mode 100644
index 000000000000..19cb336d581e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
@@ -0,0 +1,91 @@
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
+    $ref: battery.yaml#
+
+required:
+  - compatible
+  - reg
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
2.26.2

