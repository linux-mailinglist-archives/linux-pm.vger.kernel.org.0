Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294E433F193
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhCQNtm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:49:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56196 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhCQNtN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 549F81F451B0
Received: by jupiter.universe (Postfix, from userid 1000)
        id EE4E2480105; Wed, 17 Mar 2021 14:49:05 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com, David Lechner <david@lechnology.com>
Subject: [PATCHv2 19/38] dt-bindings: power: supply: lego-ev3-battery: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:48:45 +0100
Message-Id: <20210317134904.80737-20-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317134904.80737-1-sebastian.reichel@collabora.com>
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the binding to DT schema format.

Cc: David Lechner <david@lechnology.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../power/supply/lego,ev3-battery.yaml        | 55 +++++++++++++++++++
 .../power/supply/lego_ev3_battery.txt         | 21 -------
 2 files changed, 55 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/lego,ev3-battery.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/lego_ev3_battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/lego,ev3-battery.yaml b/Documentation/devicetree/bindings/power/supply/lego,ev3-battery.yaml
new file mode 100644
index 000000000000..518eabb63588
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/lego,ev3-battery.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/lego,ev3-battery.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: LEGO MINDSTORMS EV3 Battery
+
+maintainers:
+  - David Lechner <david@lechnology.com>
+  - Sebastian Reichel <sre@kernel.org>
+
+description: |
+  LEGO MINDSTORMS EV3 has some built-in capability for monitoring the battery.
+  It uses 6 AA batteries or a special Li-ion rechargeable battery pack that is
+  detected by a key switch in the battery compartment.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: lego,ev3-battery
+
+  io-channels:
+    items:
+      - description: ADC channel for battery voltage
+      - description: ADC channel for battery current
+
+  io-channel-names:
+    items:
+      - const: voltage
+      - const: current
+
+  rechargeable-gpios:
+    maxItems: 1
+    description: Rechargeable battery indication gpio
+
+required:
+  - compatible
+  - io-channels
+  - io-channel-names
+  - rechargeable-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    battery {
+      compatible = "lego,ev3-battery";
+      io-channels = <&adc 4>, <&adc 3>;
+      io-channel-names = "voltage", "current";
+      rechargeable-gpios = <&gpio 136 GPIO_ACTIVE_LOW>;
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/lego_ev3_battery.txt b/Documentation/devicetree/bindings/power/supply/lego_ev3_battery.txt
deleted file mode 100644
index 5485633b1faa..000000000000
--- a/Documentation/devicetree/bindings/power/supply/lego_ev3_battery.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-LEGO MINDSTORMS EV3 Battery
-~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-LEGO MINDSTORMS EV3 has some built-in capability for monitoring the battery.
-It uses 6 AA batteries or a special Li-ion rechargeable battery pack that is
-detected by a key switch in the battery compartment.
-
-Required properties:
- - compatible: Must be "lego,ev3-battery"
- - io-channels: phandles to analog inputs for reading voltage and current
- - io-channel-names: Must be "voltage", "current"
- - rechargeable-gpios: phandle to the rechargeable battery indication gpio
-
-Example:
-
-	battery {
-		compatible = "lego,ev3-battery";
-		io-channels = <&adc 4>, <&adc 3>;
-		io-channel-names = "voltage", "current";
-		rechargeable-gpios = <&gpio 136 GPIO_ACTIVE_LOW>;
-	};
-- 
2.30.2

