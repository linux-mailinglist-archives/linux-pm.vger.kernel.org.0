Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74A4279B7D
	for <lists+linux-pm@lfdr.de>; Sat, 26 Sep 2020 19:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgIZRgT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Sep 2020 13:36:19 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:36660 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIZRgS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Sep 2020 13:36:18 -0400
Received: from relay11.mail.gandi.net (unknown [217.70.178.231])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 5DB433A0A10;
        Sat, 26 Sep 2020 17:36:16 +0000 (UTC)
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 412A0100002;
        Sat, 26 Sep 2020 17:35:52 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v3 1/2] dt-bindings: power: Convert ingenic,battery.txt to YAML
Date:   Sat, 26 Sep 2020 19:35:28 +0200
Message-Id: <20200926173529.25238-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the textual documentation of Device Tree bindings for the
Ingenic JZ47xx SoCs battery to YAML.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---

Changes:
    v2: move introduction of new compatibles into a separate patch
    
    v3: - drop description of `io-channels` property and set its maxItems,
        - remove redundant quotes in `io-channel-names` property,
        - drop `items` for `monitored-battery` property

 .../bindings/power/supply/ingenic,battery.txt | 31 -----------
 .../power/supply/ingenic,battery.yaml         | 55 +++++++++++++++++++
 2 files changed, 55 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt b/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
deleted file mode 100644
index 66430bf73815..000000000000
--- a/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-* Ingenic JZ47xx battery bindings
-
-Required properties:
-
-- compatible: Must be "ingenic,jz4740-battery".
-- io-channels: phandle and IIO specifier pair to the IIO device.
-  Format described in iio-bindings.txt.
-- monitored-battery: phandle to a "simple-battery" compatible node.
-
-The "monitored-battery" property must be a phandle to a node using the format
-described in battery.txt, with the following properties being required:
-
-- voltage-min-design-microvolt: Drained battery voltage.
-- voltage-max-design-microvolt: Fully charged battery voltage.
-
-Example:
-
-#include <dt-bindings/iio/adc/ingenic,adc.h>
-
-simple_battery: battery {
-	compatible = "simple-battery";
-	voltage-min-design-microvolt = <3600000>;
-	voltage-max-design-microvolt = <4200000>;
-};
-
-ingenic_battery {
-	compatible = "ingenic,jz4740-battery";
-	io-channels = <&adc INGENIC_ADC_BATTERY>;
-	io-channel-names = "battery";
-	monitored-battery = <&simple_battery>;
-};
diff --git a/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml b/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
new file mode 100644
index 000000000000..658ef92a5b82
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019-2020 Artur Rojek
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/ingenic,battery.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Ingenic JZ47xx battery bindings
+
+maintainers:
+  - Artur Rojek <contact@artur-rojek.eu>
+
+properties:
+  compatible:
+    const: ingenic,jz4740-battery
+
+  io-channels:
+    maxItems: 1
+
+  io-channel-names:
+    const: battery
+
+  monitored-battery:
+    description: >
+      phandle to a "simple-battery" compatible node.
+
+      This property must be a phandle to a node using the format described
+      in battery.txt, with the following properties being required:
+      - voltage-min-design-microvolt: drained battery voltage,
+      - voltage-max-design-microvolt: fully charged battery voltage.
+
+required:
+  - compatible
+  - io-channels
+  - io-channel-names
+  - monitored-battery
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/iio/adc/ingenic,adc.h>
+
+    simple_battery: battery {
+            compatible = "simple-battery";
+            voltage-min-design-microvolt = <3600000>;
+            voltage-max-design-microvolt = <4200000>;
+    };
+
+    ingenic-battery {
+            compatible = "ingenic,jz4740-battery";
+            io-channels = <&adc INGENIC_ADC_BATTERY>;
+            io-channel-names = "battery";
+            monitored-battery = <&simple_battery>;
+    };
-- 
2.28.0

