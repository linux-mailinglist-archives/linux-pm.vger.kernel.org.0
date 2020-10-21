Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1574294E57
	for <lists+linux-pm@lfdr.de>; Wed, 21 Oct 2020 16:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442640AbgJUOQF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Oct 2020 10:16:05 -0400
Received: from atl4mhfb03.myregisteredsite.com ([209.17.115.119]:53314 "EHLO
        atl4mhfb03.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408411AbgJUOQE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2020 10:16:04 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2020 10:16:03 EDT
Received: from jax4mhob22.registeredsite.com (jax4mhob22.registeredsite.com [64.69.218.110])
        by atl4mhfb03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id 09LEAvFi020929
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2020 10:10:57 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.204])
        by jax4mhob22.registeredsite.com (8.14.4/8.14.4) with ESMTP id 09LEAsfm028023
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2020 10:10:54 -0400
Received: (qmail 5719 invoked by uid 0); 21 Oct 2020 14:10:54 -0000
X-TCPREMOTEIP: 83.128.90.119
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO phenom.domain?not?set.invalid) (mike@milosoftware.com@83.128.90.119)
  by 0 with ESMTPA; 21 Oct 2020 14:10:54 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     sre@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] dt-bindings: power/supply: Add ltc4162-l-charger
Date:   Wed, 21 Oct 2020 16:10:30 +0200
Message-Id: <20201021141030.27751-1-mike.looijmans@topic.nl>
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
 .../bindings/power/supply/ltc4162-l.yaml      | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
new file mode 100644
index 000000000000..a23dd6f3fae0
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
@@ -0,0 +1,60 @@
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
+  lltc,rsnsb:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Battery sense resistor in milli Ohm.
+    minimum: 1
+
+  lltc,rsnsi:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Input current sense resistor in milli Ohm.
+    minimum: 1
+
+required:
+  - compatible
+  - reg
+  - lltc,rsnsb
+  - lltc,rsnsi
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
+              reg =  <0x68>;
+              lltc,rsnsb = <10>;
+              lltc,rsnsi = <16>;
+      };
+    };
-- 
2.17.1

