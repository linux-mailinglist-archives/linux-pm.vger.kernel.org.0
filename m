Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202BB1D11EE
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 13:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbgEML4S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 07:56:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48100 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbgEML4R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 07:56:17 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D313D2A28AB
Received: by jupiter.universe (Postfix, from userid 1000)
        id 718004800EB; Wed, 13 May 2020 13:56:13 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 2/2] dt-bindings: power: supply: gpio-charger: convert to yaml
Date:   Wed, 13 May 2020 13:56:01 +0200
Message-Id: <20200513115601.360642-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513115601.360642-1-sebastian.reichel@collabora.com>
References: <20200513115601.360642-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the gpio-charger bindings from text format to
new YAML based representation.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/power/supply/gpio-charger.txt    | 38 ----------
 .../bindings/power/supply/gpio-charger.yaml   | 75 +++++++++++++++++++
 2 files changed, 75 insertions(+), 38 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/gpio-charger.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/gpio-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
deleted file mode 100644
index dbfd29029f69..000000000000
--- a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-gpio-charger
-
-Required properties :
- - compatible : "gpio-charger"
- - charger-type : power supply type, one of
-     unknown
-     battery
-     ups
-     mains
-     usb-sdp (USB standard downstream port)
-     usb-dcp (USB dedicated charging port)
-     usb-cdp (USB charging downstream port)
-     usb-aca (USB accessory charger adapter)
-
-Optional properties:
- - gpios : GPIO indicating the charger presence.
-   See GPIO binding in bindings/gpio/gpio.txt .
- - charge-status-gpios: GPIO indicating whether a battery is charging.
- - charge-current-limit-gpios: Output GPIOs specifiers for limiting the charge current
- - charge-current-limit-mapping: List of touples with current in uA and a GPIO bitmap (in this order).
-                                The GPIOs are encoded in the same order as specified in charge-current-limit-gpios.
-				The touples must be provided in descending order of the current limit.
-
-Example:
-
-	usb_charger: charger {
-		compatible = "gpio-charger";
-		charger-type = "usb-sdp";
-		gpios = <&gpd 28 GPIO_ACTIVE_LOW>;
-		charge-status-gpios = <&gpc 27 GPIO_ACTIVE_LOW>;
-
-		charge-current-limit-gpios = <&gpioA 11 GPIO_ACTIVE_HIGH>, <&gpioA 12 GPIO_ACTIVE_HIGH>;
-		charge-current-limit-mapping = <2500000 0x00>, <700000 0x01>, <0 0x02>;
-	};
-
-	battery {
-		power-supplies = <&usb_charger>;
-	};
diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
new file mode 100644
index 000000000000..14fb3e54f861
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/gpio-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: simple battery chargers only communicating through GPIOs
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+description: |
+  This binding is for all chargers, which are working more
+  or less autonomously, only providing some status GPIOs
+  and possibly some GPIOs for limited control over the
+  charging process.
+
+properties:
+  compatible:
+    const: gpio-charger
+
+  charger-type:
+    oneOf:
+      - const: unknown
+      - const: battery
+      - const: ups
+      - const: mains
+      - const: usb-sdp                   # USB standard downstream port
+      - const: usb-dcp                   # USB dedicated charging port
+      - const: usb-cdp                   # USB charging downstream port
+      - const: usb-aca                   # USB accessory charger adapter
+
+  gpios:
+    maxItems: 1
+    description: GPIO indicating the charger presence
+
+  charge-status-gpios:
+    maxItems: 1
+    description: GPIO indicating the charging status
+
+  charge-current-limit-gpios:
+    minItems: 1
+    maxItems: 32
+    description: GPIOs used for current limiting
+
+  charge-current-limit-mapping:
+    description: List of touples with current in uA and a GPIO bitmap (in
+      this order). The GPIOs are encoded in the same order as specified in
+      charge-current-limit-gpios. The touples must be provided in descending
+      order of the current limit.
+    $ref: "/meta-schemas/cell.yaml#array"
+
+required:
+  - compatible
+additionalProperties: false
+
+dependencies:
+  charge-current-limit-gpios: [ charge-current-limit-mapping ]
+  charge-current-limit-mapping: [ charge-current-limit-gpios ]
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    charger {
+      compatible = "gpio-charger";
+      charger-type = "usb-sdp";
+
+      gpios = <&gpd 28 GPIO_ACTIVE_LOW>;
+      charge-status-gpios = <&gpc 27 GPIO_ACTIVE_LOW>;
+
+      charge-current-limit-gpios = <&gpioA 11 GPIO_ACTIVE_HIGH>,
+                                   <&gpioA 12 GPIO_ACTIVE_HIGH>;
+      charge-current-limit-mapping = <2500000 0x00>, <700000 0x01>, <0 0x02>;
+    };
-- 
2.26.2

