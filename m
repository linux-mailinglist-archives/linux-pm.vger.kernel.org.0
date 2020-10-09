Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49629288BB2
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 16:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388967AbgJIOlQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Oct 2020 10:41:16 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47316 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388848AbgJIOlP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Oct 2020 10:41:15 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 099EfDs7130278;
        Fri, 9 Oct 2020 09:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602254473;
        bh=CqA3/3irziC+4BcEaHbe20GdHaKIvMNwdaUsujUpDGI=;
        h=From:To:CC:Subject:Date;
        b=eZKgqzau8RPAvbAm2vii+BVWsDl+rBQLSDnmtCYfZNPQXNazr3lUyaIaOaD6e9qaF
         mT6ORe6dBKzGIvWIxorC/gWl2xCE/qyDe9nx/jtH9MC056rm9ZFbl8TVR9PL/kBUYS
         au+PzXc7xhfblV01nDHNDGXMV72YXW674B6SGsiw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 099EfDlK079112
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Oct 2020 09:41:13 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 9 Oct
 2020 09:41:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 9 Oct 2020 09:41:13 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 099EfDUY109157;
        Fri, 9 Oct 2020 09:41:13 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        Dan Murphy <dmurphy@ti.com>,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Subject: [PATCH v4 1/2] dt-bindings: power: Add the bq25790 dt bindings
Date:   Fri, 9 Oct 2020 09:41:11 -0500
Message-ID: <20201009144112.3007-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the bindings for the bq25790.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../bindings/power/supply/bq25790.yaml        | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq25790.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/bq25790.yaml b/Documentation/devicetree/bindings/power/supply/bq25790.yaml
new file mode 100644
index 000000000000..6d9178ce5a2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq25790.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/bq25790.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TI BQ25790 Switch Mode Buck-Boost Charger
+
+maintainers:
+  - Dan Murphy <dmurphy@ti.com>
+
+description: |
+  BQ25790 is a highly integrated switch-mode buck-boost charger for 1-4 cell
+  Li-ion batteries and Li-polymer batteries. The device charges a battery from a
+  wide range of input sources including legacy USB adapters to high voltage USB
+  PD adapters and traditional barrel adapters.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,bq25790
+      - ti,bq25792
+
+  reg:
+    maxItems: 1
+
+  ti,watchdog-timeout-ms:
+    default: 0
+    description: |
+      Watchdog timer in milli seconds. 0 (default) disables the watchdog.
+    minimum: 0
+    maximum: 160000
+    enum: [ 0, 500, 1000, 2000, 20000, 40000, 80000, 160000]
+
+  input-voltage-limit-microvolt:
+    description: |
+      Minimum input voltage limit in micro volts with a 100000 micro volt step.
+    minimum: 3600000
+    maximum: 22000000
+
+  input-current-limit-microamp:
+    description: |
+      Maximum input current limit in micro amps with a 100000 micro amp step.
+    minimum: 100000
+    maximum: 3300000
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
+unevaluatedProperties: false
+
+examples:
+  - |
+    bat: battery {
+      compatible = "simple-battery";
+      constant-charge-current-max-microamp = <2000000>;
+      constant-charge-voltage-max-microvolt = <4200000>;
+      precharge-current-microamp = <160000>;
+      charge-term-current-microamp = <160000>;
+    };
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      bq25790: charger@6b {
+          compatible = "ti,bq25790";
+          reg = <0x6b>;
+          interrupt-parent = <&gpio1>;
+          interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+          ti,watchdog-timeout-ms = <2000>;
+          input-current-limit-microamp = <3000000>;
+          input-voltage-limit-microvolt = <4500000>;
+          monitored-battery = <&bat>;
+      };
+    };
+
+...
-- 
2.28.0.585.ge1cfff676549

