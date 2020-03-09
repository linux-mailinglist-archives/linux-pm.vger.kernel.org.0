Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F79117E4B9
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2020 17:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCIQZF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Mar 2020 12:25:05 -0400
Received: from mail.manjaro.org ([176.9.38.148]:44342 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgCIQZF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Mar 2020 12:25:05 -0400
X-Greylist: delayed 1243 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Mar 2020 12:25:05 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id C3FCE370239A;
        Mon,  9 Mar 2020 17:04:37 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S4uHlTtv556r; Mon,  9 Mar 2020 17:04:34 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH v2 1/2] dt-bindings: power: supply: cw2015_battery: add device tree binding documentation
Date:   Mon,  9 Mar 2020 17:03:45 +0100
Message-Id: <20200309160346.2203680-2-t.schramm@manjaro.org>
In-Reply-To: <20200309160346.2203680-1-t.schramm@manjaro.org>
References: <20200309160346.2203680-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds the dts binding schema for the cw2015 fuel gauge.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 .../bindings/power/supply/cw2015_battery.yaml | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
new file mode 100644
index 000000000000..ebd4814ea58d
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/cw2015_battery.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Battery driver for CW2015 shuntless fule gauge by CellWise.
+
+maintainers:
+  - Tobias Schramm <t.schramm@manjaro.org>
+
+description: |
+  The driver can utilize information from a simple-battery linked via a
+  phandle in monitored-battery. If specified the driver uses the
+  charge-full-design-microamp-hours property of the battery.
+
+  The contents of the byte array in cellwise,bat-config-info describes
+  characteristics of the battery used. The format of this binary blob
+  is not publicly descibed and currently unknown.
+
+properties:
+  compatible:
+    const: cellwise,cw2015
+
+  reg:
+    items:
+      - description: i2c address
+
+  cellwise,bat-config-info:
+    description:
+      Specifies the binary battery parameter blob
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/uint8-array
+    items:
+      - minItems: 64
+        maxItems: 64
+
+  cellwise,monitor-interval-ms:
+    description:
+      Specifies the interval in milliseconds gauge values are polled at
+    $ref: /schemas/types.yaml#/definitions/uint32
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
+            cellwise,bat-config-info = /bits/ 8 <
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

