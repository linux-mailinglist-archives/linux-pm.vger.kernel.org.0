Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9D118E165
	for <lists+linux-pm@lfdr.de>; Sat, 21 Mar 2020 13:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgCUMxb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Mar 2020 08:53:31 -0400
Received: from mail.manjaro.org ([176.9.38.148]:37106 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgCUMxb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 21 Mar 2020 08:53:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id A3DCF37E5076;
        Sat, 21 Mar 2020 13:53:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9sqKkhprte8k; Sat, 21 Mar 2020 13:53:26 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH v6 2/3] dt-bindings: power: supply: add cw2015_battery bindings
Date:   Sat, 21 Mar 2020 13:52:40 +0100
Message-Id: <20200321125241.3072123-3-t.schramm@manjaro.org>
In-Reply-To: <20200321125241.3072123-1-t.schramm@manjaro.org>
References: <20200321125241.3072123-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds the dts binding schema for the cw2015 fuel gauge.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 .../bindings/power/supply/cw2015_battery.yaml | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
new file mode 100644
index 000000000000..4a265d4234b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/cw2015_battery.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Battery driver for CW2015 shuntless fuel gauge by CellWise.
+
+maintainers:
+  - Tobias Schramm <t.schramm@manjaro.org>
+
+description: |
+  The driver can utilize information from a simple-battery linked via a
+  phandle in monitored-battery. If specified the driver uses the
+  charge-full-design-microamp-hours property of the battery.
+
+properties:
+  compatible:
+    const: cellwise,cw2015
+
+  reg:
+    maxItems: 1
+
+  cellwise,battery-profile:
+    description: |
+      This property specifies characteristics of the battery used. The format
+      of this binary blob is kept secret by CellWise. The only way to obtain
+      it is to mail two batteries to a test facility of CellWise and receive
+      back a test report with the binary blob.
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/uint8-array
+    items:
+      - minItems: 64
+        maxItems: 64
+
+  cellwise,monitor-interval-ms:
+    description:
+      Specifies the interval in milliseconds gauge values are polled at
+    minimum: 250
+
+  power-supplies:
+    description:
+      Specifies supplies used for charging the battery connected to this gauge
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/phandle-array
+      - minItems: 1
+        maxItems: 8 # Should be enough
+
+  monitored-battery:
+    description:
+      Specifies the phandle of a simple-battery connected to this gauge
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        cw2015@62 {
+            compatible = "cellwise,cw201x";
+            reg = <0x62>;
+            cellwise,battery-profile = /bits/ 8 <
+                0x17 0x67 0x80 0x73 0x6E 0x6C 0x6B 0x63
+                0x77 0x51 0x5C 0x58 0x50 0x4C 0x48 0x36
+                0x15 0x0C 0x0C 0x19 0x5B 0x7D 0x6F 0x69
+                0x69 0x5B 0x0C 0x29 0x20 0x40 0x52 0x59
+                0x57 0x56 0x54 0x4F 0x3B 0x1F 0x7F 0x17
+                0x06 0x1A 0x30 0x5A 0x85 0x93 0x96 0x2D
+                0x48 0x77 0x9C 0xB3 0x80 0x52 0x94 0xCB
+                0x2F 0x00 0x64 0xA5 0xB5 0x11 0xF0 0x11
+           >;
+           cellwise,monitor-interval-ms = <5000>;
+           monitored-battery = <&bat>;
+           power-supplies = <&mains_charger>, <&usb_charger>;
+       };
+    };
+
-- 
2.24.1

