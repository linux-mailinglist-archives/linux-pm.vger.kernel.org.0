Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC0D25EE58
	for <lists+linux-pm@lfdr.de>; Sun,  6 Sep 2020 16:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgIFOsM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Sep 2020 10:48:12 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:60921 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgIFOsI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Sep 2020 10:48:08 -0400
X-Originating-IP: 195.189.32.242
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 88D8040007;
        Sun,  6 Sep 2020 14:48:03 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2 1/2] dt-bindings: power: Convert ingenic,battery.txt to YAML
Date:   Sun,  6 Sep 2020 16:47:25 +0200
Message-Id: <20200906144726.8852-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the textual documentation of Device Tree bindings for the
Ingenic JZ47xx SoCs battery to YAML.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---

Changes:
    v2: move introduction of new compatibles into a separate patch

 .../bindings/power/supply/ingenic,battery.txt | 31 ----------
 .../power/supply/ingenic,battery.yaml         | 60 +++++++++++++++++++
 2 files changed, 60 insertions(+), 31 deletions(-)
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
index 000000000000..b4e0275ac63a
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
@@ -0,0 +1,60 @@
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
+    items:
+      - description: >
+          phandle and IIO specifier pair to the IIO device.
+          See Documentation/devicetree/bindings/iio/iio-bindings.txt for more
+          details.
+
+  io-channel-names:
+    const: "battery"
+
+  monitored-battery:
+    items:
+      - description: >
+          phandle to a "simple-battery" compatible node.
+
+          This property must be a phandle to a node using the format described
+          in battery.txt, with the following properties being required:
+          - voltage-min-design-microvolt: drained battery voltage,
+          - voltage-max-design-microvolt: fully charged battery voltage.
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

