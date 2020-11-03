Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952292A3F0A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 09:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgKCIhN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 03:37:13 -0500
Received: from jax4mhob17.registeredsite.com ([64.69.218.105]:33684 "EHLO
        jax4mhob17.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727470AbgKCIhM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2020 03:37:12 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.204])
        by jax4mhob17.registeredsite.com (8.14.4/8.14.4) with ESMTP id 0A38b9Y0128883
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-pm@vger.kernel.org>; Tue, 3 Nov 2020 03:37:09 -0500
Received: (qmail 20239 invoked by uid 0); 3 Nov 2020 08:37:09 -0000
X-TCPREMOTEIP: 83.128.90.119
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO phenom.domain?not?set.invalid) (mike@milosoftware.com@83.128.90.119)
  by 0 with ESMTPA; 3 Nov 2020 08:37:09 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sre@kernel.org, robh+dt@kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH v4] dt-bindings: power/supply: Add ltc4162-l-charger
Date:   Tue,  3 Nov 2020 09:37:06 +0100
Message-Id: <20201103083706.29380-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for the LTC4162-L Li-Ion battery charger. The driver allows
reading back telemetry and to set some charging options like the input
current limit.

This adds the devicetree bindings.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
v2: Use microohms, add lltc,cell-count
v3: Fix example dts to match description
v4: Update "required" list to include micro-ohms

 .../bindings/power/supply/ltc4162-l.yaml      | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
new file mode 100644
index 000000000000..1f88c9e013f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2020 Topic Embedded Products
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/ltc4162-l.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Linear Technology (Analog Devices) LTC4162-L Charger
+
+maintainers:
+  - Mike Looijmans <mike.looijmans@topic.nl>
+
+description: |
+  The LTC ® 4162-L is an advanced monolithic synchronous step-down switching
+  battery charger and PowerPath (TM) manager that seamlessly manages power
+  distribution between input sources such as wall adapters, backplanes, solar
+  panels, etc., and a rechargeable Lithium-Ion/Polymer battery.
+
+  Specifications about the charger can be found at:
+    https://www.analog.com/en/products/ltc4162-s.html
+
+properties:
+  compatible:
+    enum:
+      - lltc,ltc4162-l
+
+  reg:
+    maxItems: 1
+    description: I2C address of the charger.
+
+  lltc,rsnsb-micro-ohms:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Battery sense resistor in microohm.
+    minimum: 1000
+
+  lltc,rsnsi-micro-ohms:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Input current sense resistor in microohm.
+    minimum: 1000
+
+  lltc,cell-count:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Number of battery cells. If not provided, will be obtained from the chip
+      once the external power is applied. Omit this when the number of cells
+      is somewhat dynamic. Without it, several measurements will return 0 until
+      the charger is connected to an external supply.
+
+required:
+  - compatible
+  - reg
+  - lltc,rsnsb-micro-ohms
+  - lltc,rsnsi-micro-ohms
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      charger: battery-charger@68 {
+              compatible = "lltc,ltc4162-l";
+              reg = <0x68>;
+              lltc,rsnsb-micro-ohms = <10000>;
+              lltc,rsnsi-micro-ohms = <16000>;
+              lltc,cell-count = <2>;
+      };
+    };
-- 
2.17.1

