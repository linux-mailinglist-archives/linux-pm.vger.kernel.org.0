Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE683391E8
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 16:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhCLPos (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 10:44:48 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55656 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbhCLPoQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 10:44:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 446521F46EC4
Received: by jupiter.universe (Postfix, from userid 1000)
        id 582A5480105; Fri, 12 Mar 2021 16:44:08 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com, David Lechner <david@lechnology.com>
Subject: [PATCH 19/38] dt-bindings: power: supply: lego-ev3-battery: Convert to DT schema format
Date:   Fri, 12 Mar 2021 16:43:38 +0100
Message-Id: <20210312154357.1561730-20-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
References: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
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
2.30.1

