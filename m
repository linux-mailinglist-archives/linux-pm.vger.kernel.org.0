Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CF51F0300
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jun 2020 00:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgFEWoK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jun 2020 18:44:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41692 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgFEWoK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jun 2020 18:44:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 415552A51AA
Received: by jupiter.universe (Postfix, from userid 1000)
        id 263574800FF; Sat,  6 Jun 2020 00:44:04 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 1/6] dt-bindings: power: supply: gpio-charger: convert to yaml
Date:   Sat,  6 Jun 2020 00:43:58 +0200
Message-Id: <20200605224403.181015-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605224403.181015-1-sebastian.reichel@collabora.com>
References: <20200605224403.181015-1-sebastian.reichel@collabora.com>
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
 .../bindings/power/supply/gpio-charger.txt    | 31 ----------
 .../bindings/power/supply/gpio-charger.yaml   | 58 +++++++++++++++++++
 2 files changed, 58 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/gpio-charger.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/gpio-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt b/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
deleted file mode 100644
index 0fb33b2c62a6..000000000000
--- a/Documentation/devicetree/bindings/power/supply/gpio-charger.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-gpio-charger
-
-Required properties :
- - compatible : "gpio-charger"
- - gpios : GPIO indicating the charger presence.
-   See GPIO binding in bindings/gpio/gpio.txt .
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
- - charge-status-gpios: GPIO indicating whether a battery is charging.
-
-Example:
-
-	usb_charger: charger {
-		compatible = "gpio-charger";
-		charger-type = "usb-sdp";
-		gpios = <&gpd 28 GPIO_ACTIVE_LOW>;
-		charge-status-gpios = <&gpc 27 GPIO_ACTIVE_LOW>;
-	};
-
-	battery {
-		power-supplies = <&usb_charger>;
-	};
diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
new file mode 100644
index 000000000000..78b167c62ab1
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
@@ -0,0 +1,58 @@
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
+description:
+  This binding is for all chargers, which are working more or less
+  autonomously, only providing some status GPIOs and possibly some
+  GPIOs for limited control over the charging process.
+
+properties:
+  compatible:
+    const: gpio-charger
+
+  charger-type:
+    enum:
+      - unknown
+      - battery
+      - ups
+      - mains
+      - usb-sdp                   # USB standard downstream port
+      - usb-dcp                   # USB dedicated charging port
+      - usb-cdp                   # USB charging downstream port
+      - usb-aca                   # USB accessory charger adapter
+    description:
+      Type of the charger, e.g. "mains" for a wall charger.
+
+  gpios:
+    maxItems: 1
+    description: GPIO indicating the charger presence
+
+  charge-status-gpios:
+    maxItems: 1
+    description: GPIO indicating the charging status
+
+required:
+  - compatible
+  - gpios
+
+additionalProperties: false
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
+    };
-- 
2.26.2

