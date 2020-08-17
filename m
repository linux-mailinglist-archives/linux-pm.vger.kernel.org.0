Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B31724750F
	for <lists+linux-pm@lfdr.de>; Mon, 17 Aug 2020 21:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404168AbgHQTSm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 15:18:42 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53118 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387473AbgHQTS1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2020 15:18:27 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07HJIE8w003381;
        Mon, 17 Aug 2020 14:18:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1597691894;
        bh=4JAd00xMiWrjvk4rZNCeC62B1mGwyRj0ceLiUfWiEyw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KHItjRgFleFmDsE9dlxLeOe4Livzma9D8/Aq823EOdA3mF6c0HN6IJElEn30q/gzP
         iEp2yyL0dmrmTL4vYjodBH3hkxbQ7z7bRpcjQ9HxlA0IQ8jG16kkoxKxV4GmEZVm3Y
         rSGFZi9+r5O3h+uAPCDRg/ns8yfM/I/Z9/gmuszw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07HJIEGI087266;
        Mon, 17 Aug 2020 14:18:14 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 17
 Aug 2020 14:18:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 17 Aug 2020 14:18:13 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07HJID9I119292;
        Mon, 17 Aug 2020 14:18:13 -0500
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
To:     <sre@kernel.org>, <robh+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <dmurphy@ti.com>, Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Subject: [PATCH v1 1/2] dt-bindings: power: Add the bq256xx dt bindings
Date:   Mon, 17 Aug 2020 14:17:22 -0500
Message-ID: <20200817191723.22416-2-r-rivera-matos@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817191723.22416-1-r-rivera-matos@ti.com>
References: <20200817191723.22416-1-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
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
 .../bindings/power/supply/bq256xx.yaml        | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq256xx.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/bq256xx.yaml b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
new file mode 100644
index 000000000000..67db4ba9fdb6
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq256xx.yaml
@@ -0,0 +1,99 @@
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
+  ti,watchdog-timer:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Watchdog timer in milli seconds. 0 (default) disables the watchdog
+    minimum: 0
+    maximum: 160000
+    enum: [ 0, 40000, 80000, 160000]
+
+  input-voltage-limit-microvolt:
+    description: |
+       Minimum input voltage limit in micro volts with a 100000 micro volt step
+    minimum: 3900000
+    maximum: 5400000
+
+  input-current-limit-microamp:
+    description: |
+       Maximum input current limit in micro amps with a 100000 micro amp step
+    minimum: 100000
+    maximum: 3200000
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    bat: battery {
+      compatible = "simple-battery";
+      constant-charge-current-max-microamp = <2040000>;
+      constant-charge-voltage-max-microvolt = <4352000>;
+      precharge-current-microamp = <180000>;
+      termination-current-microamp = <180000>;
+    };
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+      pinctrl-names = "default";
+      pinctrl-0 = <&i2c2_pins>;
+
+      status = "okay";
+      clock-frequency = <400000>;
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      bq25601@6b {
+        compatible = "ti,bq25601";
+        reg = <0x6b>;
+        monitored-battery = <&bat>;
+
+        interrupt-parent = <&gpio1>;
+        interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+        watchdog-timer = <40000>;
+
+        input-voltage-limit-microvolt = <4500000>;
+        input-current-limit-microamp = <2400000>;
+       };
+    };
+...
-- 
2.28.0

