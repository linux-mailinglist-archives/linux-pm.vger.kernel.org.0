Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E827257F05
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 18:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgHaQs6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 12:48:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46852 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgHaQs6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 12:48:58 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07VGmubf073858;
        Mon, 31 Aug 2020 11:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598892536;
        bh=4HoIcctLaShxkLjkPz4Yz7X2DMMtsOQr6kedO4NFTrA=;
        h=From:To:CC:Subject:Date;
        b=W+IzOnZQSoxNn8L1pHcznAGe8HBx4EtgoSWYHhjHiIOLGF+vhrYzQWAmGDnxL8s1v
         O50SQVG84545icv4q8ErW3zBVnAOaDCIadrQkaMUHu106aZIklBGcWXvVIpJ58f9I/
         syjBsMu5VZI4KSLCmh4pKVf1Q3AhWjVj9hwgygrU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07VGmuVa024422;
        Mon, 31 Aug 2020 11:48:56 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 31
 Aug 2020 11:48:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 31 Aug 2020 11:48:55 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07VGmtSQ016068;
        Mon, 31 Aug 2020 11:48:55 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>, <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <r-rivera-matos@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] dt-binding: bq25980: Add the bq25980 flash charger
Date:   Mon, 31 Aug 2020 11:48:48 -0500
Message-ID: <20200831164849.31313-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add yaml for the bq25980 flash charger.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../bindings/power/supply/bq25980.yaml        | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq25980.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/bq25980.yaml b/Documentation/devicetree/bindings/power/supply/bq25980.yaml
new file mode 100644
index 000000000000..f6b3dd4093ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq25980.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/bq25980.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TI BQ25980 Flash Charger
+
+maintainers:
+  - Dan Murphy <dmurphy@ti.com>
+  - Ricardo Rivera-Matos <r-rivera-matos@ti.com>
+
+description: |
+  The BQ25980, BQ25975, and BQ25960 are a series of flash chargers intended
+  for use in high-power density portable electronics. These inductorless
+  switching chargers can provide over 97% efficiency by making use of the
+  switched capacitor architecture.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ti,bq25980
+      - ti,bq25975
+      - ti,bq25960
+
+  reg:
+    maxItems: 1
+
+  ti,watchdog-timeout-ms:
+    description: |
+      Watchdog timer in milli seconds. 0 disables the watchdog.
+    default: 0
+    minimum: 0
+    maximum: 300000
+    enum: [ 0, 5000, 10000, 50000, 300000]
+
+  ti,sc-ovp-limit-microvolt:
+    description: |
+      Minimum input voltage limit in micro volts with a when the charger is in
+      switch cap mode. 100000 micro volt step.
+    default: 17800000
+    minimum: 14000000
+    maximum: 22000000
+
+  ti,sc-ocp-limit-microamp:
+    description: |
+      Maximum input current limit in micro amps with a 100000 micro amp step.
+    minimum: 100000
+    maximum: 3300000
+
+  ti,bypass-ovp-limit-microvolt:
+    description: |
+      Minimum input voltage limit in micro volts with a when the charger is in
+      switch cap mode. 50000 micro volt step.
+    minimum: 7000000
+    maximum: 12750000
+
+  ti,bypass-ocp-limit-microamp:
+    description: |
+      Maximum input current limit in micro amps with a 100000 micro amp step.
+    minimum: 100000
+    maximum: 3300000
+
+  ti,bypass-enable:
+    type: boolean
+    description: Enables bypass mode at boot time
+
+  interrupts:
+    description: |
+      Indicates that the device state has changed.
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
+unevaluatedProperties: false
+
+examples:
+  - |
+    bat: battery {
+      compatible = "simple-battery";
+      constant-charge-current-max-microamp = <4000000>;
+      constant-charge-voltage-max-microvolt = <8400000>;
+      precharge-current-microamp = <160000>;
+      charge-term-current-microamp = <160000>;
+    };
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      bq25980: charger@65 {
+          compatible = "ti,bq25980";
+          reg = <0x65>;
+          interrupt-parent = <&gpio1>;
+          interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+          ti,watchdog-timer = <0>;
+          ti,sc-ocp-limit-microamp = <2000000>;
+          ti,sc-ovp-limit-microvolt = <17800000>;
+          monitored-battery = <&bat>;
+      };
+    };
+
+...
-- 
2.28.0

