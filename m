Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF6533F199
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhCQNtp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhCQNtN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771E6C061762;
        Wed, 17 Mar 2021 06:49:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 4EC8E1F451AE
Received: by jupiter.universe (Postfix, from userid 1000)
        id E8619480103; Wed, 17 Mar 2021 14:49:05 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 17/38] dt-bindings: power: supply: twl4030: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:48:43 +0100
Message-Id: <20210317134904.80737-18-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317134904.80737-1-sebastian.reichel@collabora.com>
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the binding to DT schema format.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/power/supply/twl-charger.txt     | 30 --------
 .../power/supply/twl4030-charger.yaml         | 68 +++++++++++++++++++
 2 files changed, 68 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/twl-charger.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/twl4030-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/twl-charger.txt b/Documentation/devicetree/bindings/power/supply/twl-charger.txt
deleted file mode 100644
index 3b4ea1b73b38..000000000000
--- a/Documentation/devicetree/bindings/power/supply/twl-charger.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-TWL BCI (Battery Charger Interface)
-
-The battery charger needs to interact with the USB phy in order
-to know when charging is permissible, and when there is a connection
-or disconnection.
-
-The choice of phy cannot be configured at a hardware level, so there
-is no value in explicit configuration in device-tree.  Rather
-if there is a sibling of the BCI node which is compatible with
-"ti,twl4030-usb", then that is used to determine when and how
-use USB power for charging.
-
-Required properties:
-- compatible:
-  - "ti,twl4030-bci"
-- interrupts: two interrupt lines from the TWL SIH (secondary
-  interrupt handler) - interrupts 9 and 2.
-
-Optional properties:
-- ti,bb-uvolt: microvolts for charging the backup battery.
-- ti,bb-uamp: microamps for charging the backup battery.
-
-Examples:
-
-bci {
-   compatible = "ti,twl4030-bci";
-   interrupts = <9>, <2>;
-   ti,bb-uvolt = <3200000>;
-   ti,bb-uamp = <150>;
-};
diff --git a/Documentation/devicetree/bindings/power/supply/twl4030-charger.yaml b/Documentation/devicetree/bindings/power/supply/twl4030-charger.yaml
new file mode 100644
index 000000000000..fe3f32a0ea79
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/twl4030-charger.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/twl4030-charger.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TWL4030 BCI (Battery Charger Interface)
+
+description: |
+  The battery charger needs to interact with the USB phy in order to know when
+  charging is permissible, and when there is a connection or disconnection.
+
+  The choice of phy cannot be configured at a hardware level, so there is no
+  value in explicit configuration in device-tree. Rather if there is a sibling
+  of the BCI node which is compatible with "ti,twl4030-usb", then that is used
+  to determine when and how use USB power for charging.
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: ti,twl4030-bci
+
+  interrupts:
+    minItems: 2
+    maxItems: 2
+
+  ti,bb-uvolt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: microvolts for charging the backup battery
+
+  ti,bb-uamp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: microamps for charging the backup battery
+
+  io-channels:
+    items:
+      - description: Accessory Charger Voltage Channel
+
+  io-channel-names:
+    items:
+      - const: vac
+
+  bci3v1-supply:
+    description: 3.1V USB regulator
+
+required:
+  - compatible
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic {
+      charger {
+        compatible = "ti,twl4030-bci";
+        interrupts = <9>, <2>;
+        ti,bb-uvolt = <3200000>;
+        ti,bb-uamp = <150>;
+        io-channels = <&twl_madc 11>;
+        io-channel-names = "vac";
+      };
+    };
-- 
2.30.2

