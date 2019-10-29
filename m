Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16DD0E9088
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 21:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfJ2UDF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 16:03:05 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60056 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfJ2UDF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 16:03:05 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9TK338K088307;
        Tue, 29 Oct 2019 15:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572379383;
        bh=y49m7ZpWcPJRbHzJ5NyQ2rYAhLlPDo7yM8vHzQkdWVM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=afrHLPweEXrdOEpyTD99KiKCeKtVttg2g+CvasU7FwiUw++SEWz3evJIdVSY8/5+U
         uSM4STsNBX4rtoEE1XLtcNhJfki1OBquicZXq2lKwIEYt+LlbaQWgZkLGHnNqVqC/6
         NPxUoot6Tde0cuzzwAkGJCTu72BSc4qqlgXXgpg4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9TK33ZS021582
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Oct 2019 15:03:03 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 29
 Oct 2019 15:02:50 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 29 Oct 2019 15:02:50 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9TK33Jb033223;
        Tue, 29 Oct 2019 15:03:03 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: power: Add the bq2515x family dt bindings
Date:   Tue, 29 Oct 2019 15:02:00 -0500
Message-ID: <20191029200201.24483-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.22.0.214.g8dca754b1e
In-Reply-To: <20191029200201.24483-1-dmurphy@ti.com>
References: <20191029200201.24483-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the bindings for the bq25150 and bq25155 500mA
charging ICs from Texas Instruments.

Datasheet:
http://www.ti.com/lit/ds/symlink/bq25150.pdf
http://www.ti.com/lit/ds/symlink/bq25155.pdf

Signed-off-by: Dan Murphy <dmurphy@ti.com>
CC: Rob Herring <robh@kernel.org>
---

v2 - Converted to yaml format and removed ti,* properties for already defined
properties

 .../bindings/power/supply/bq2515x.yaml        | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/bq2515x.yaml b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
new file mode 100644
index 000000000000..4e6225056f45
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq2515x.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2019 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/bq2515x.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TI bq2515x 500-mA Linear charger family
+
+maintainers:
+  - Dan Murphy <dmurphy@ti.com>
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
+
+  pg-gpios:
+    description: |
+       GPIO used for connecting the bq2515x device PG (Power Good)
+       pin.  This pin should be used if possible as this is the
+       recommended way to obtain the charger's input PG state.
+       If this pin is not specified a software-based approach for PG
+       detection is used.
+
+  reset-gpios:
+    description: |
+       GPIO used for hardware reset.
+
+  low-power-gpios:
+    description: |
+       GPIO used for low power mode of IC.
+
+  charge-enable-gpios:
+    description: |
+       GPIO used to turn on and off charging.
+
+  constant-charge-current-max-microamp:
+    description: |
+       Maximum charging current in micro Amps.
+    minimum: 50000
+    maximum: 600000
+
+  voltage-max-design-microvolt:
+    description: |
+       Maximum charging voltage in micro volts.
+    minimum: 3600000
+    maximum: 4600000
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      charger@6b {
+          compatible = "ti,bq25150";
+          reg = <0x6b>;
+
+          pg-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+          reset-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+          low-power-gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
+          charge-enable-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
+          constant-charge-current-max-microamp = <300000>;
+          voltage-max-design-microvolt = <4200000>;
+      };
+    };
-- 
2.22.0.214.g8dca754b1e

