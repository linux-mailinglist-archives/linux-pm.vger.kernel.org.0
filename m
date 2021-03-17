Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010BA33F180
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhCQNtg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:49:36 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56156 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbhCQNtL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B48BE1F44E67
Received: by jupiter.universe (Postfix, from userid 1000)
        id D4CC44800E2; Wed, 17 Mar 2021 14:49:05 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 10/38] dt-bindings: power: supply: sbs-charger: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:48:36 +0100
Message-Id: <20210317134904.80737-11-sebastian.reichel@collabora.com>
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
 .../power/supply/sbs,sbs-charger.yaml         | 55 +++++++++++++++++++
 .../bindings/power/supply/sbs_sbs-charger.txt | 21 -------
 2 files changed, 55 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-charger.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/sbs,sbs-charger.yaml b/Documentation/devicetree/bindings/power/supply/sbs,sbs-charger.yaml
new file mode 100644
index 000000000000..cb73ffa4778e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/sbs,sbs-charger.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/sbs,sbs-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SBS compliant charger
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+description: |
+  Charger compatible with the smart battery system specifications
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - lltc,ltc4100
+          - enum:
+              - sbs,sbs-charger
+      - items:
+          - const: sbs,sbs-charger
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        charger@9 {
+            compatible = "lltc,ltc4100", "sbs,sbs-charger";
+            reg = <0x9>;
+            interrupt-parent = <&gpio6>;
+            interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+       };
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt
deleted file mode 100644
index 84e74151eef2..000000000000
--- a/Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-SBS sbs-charger
-~~~~~~~~~~
-
-Required properties:
- - compatible: "<vendor>,<part-number>", "sbs,sbs-charger" as fallback. The part
-     number compatible string might be used in order to take care of vendor
-     specific registers.
-
-Optional properties:
-- interrupts: Interrupt mapping for GPIO IRQ. Use in conjunction with
-    "interrupt-parent". If an interrupt is not provided the driver will switch
-    automatically to polling.
-
-Example:
-
-	ltc4100@9 {
-		compatible = "lltc,ltc4100", "sbs,sbs-charger";
-		reg = <0x9>;
-		interrupt-parent = <&gpio6>;
-		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
-	};
-- 
2.30.2

