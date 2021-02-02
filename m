Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0ACD30B526
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 03:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhBBCSm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 21:18:42 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43080 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhBBCSl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 21:18:41 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1122HmEi048971;
        Mon, 1 Feb 2021 20:17:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612232268;
        bh=Piv6SAhmZ+9ZIfCN+toMF2WEzwxmxh617k2Fa/s+JJw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TByc13dLqey+hnnhEeYs/bCyzSAs9jVmJ0QVmuMgl0Qn17VIxb6NZpTYexjQfHxgF
         fbhLbxpC8QLMxUcx07yXAAHEY4fZrJJ/3poybBOsvw1o4rd9qh3RQxI78LUM20kUoG
         0sa4TWfVgmZfSsVN/WnzflgGVIKMDB9rd79i8bEA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1122Hm7O102413
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Feb 2021 20:17:48 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 1 Feb
 2021 20:17:48 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 1 Feb 2021 20:17:48 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1122HmSY050842;
        Mon, 1 Feb 2021 20:17:48 -0600
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <dmurphy@ti.com>, Rob Herring <robh@kernel.org>,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Subject: [PATCH v5 1/2] dt-bindings: power: Add the bq25790 dt bindings
Date:   Mon, 1 Feb 2021 20:17:46 -0600
Message-ID: <20210202021747.717-2-r-rivera-matos@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202021747.717-1-r-rivera-matos@ti.com>
References: <20210202021747.717-1-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Dan Murphy <dmurphy@ti.com>

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
2.30.0

