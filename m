Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40183391E1
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 16:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhCLPor (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 10:44:47 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55642 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhCLPoQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 10:44:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 3E8D91F46EC0
Received: by jupiter.universe (Postfix, from userid 1000)
        id 51937480102; Fri, 12 Mar 2021 16:44:08 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 16/38] dt-bindings: power: supply: tps65217: Convert to DT schema format
Date:   Fri, 12 Mar 2021 16:43:35 +0100
Message-Id: <20210312154357.1561730-17-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
References: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the binding to DT schema format.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../power/supply/tps65217-charger.yaml        | 43 +++++++++++++++++++
 .../power/supply/tps65217_charger.txt         | 17 --------
 2 files changed, 43 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/tps65217_charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml b/Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml
new file mode 100644
index 000000000000..a33408c3a407
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/tps65217-charger.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/tps65217-charger.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TPS65217 Charger
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: ti,tps65217-charger
+
+  interrupts:
+    minItems: 2
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: USB
+      - const: AC
+      
+required:
+  - compatible
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic {
+      charger {
+        compatible = "ti,tps65217-charger";
+        interrupts = <0>, <1>;
+        interrupt-names = "USB", "AC";
+      };
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt b/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
deleted file mode 100644
index a11072c5a866..000000000000
--- a/Documentation/devicetree/bindings/power/supply/tps65217_charger.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-TPS65217 Charger
-
-Required Properties:
--compatible: "ti,tps65217-charger"
--interrupts: TPS65217 interrupt numbers for the AC and USB charger input change.
-             Should be <0> for the USB charger and <1> for the AC adapter.
--interrupt-names: Should be "USB" and "AC"
-
-This node is a subnode of the tps65217 PMIC.
-
-Example:
-
-	tps65217-charger {
-		compatible = "ti,tps65217-charger";
-		interrupts = <0>, <1>;
-		interrupt-names = "USB", "AC";
-	};
-- 
2.30.1

