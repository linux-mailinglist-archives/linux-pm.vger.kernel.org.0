Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E801C33F1A3
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhCQNtt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhCQNtN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BCCC061760;
        Wed, 17 Mar 2021 06:49:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 486261F44A27
Received: by jupiter.universe (Postfix, from userid 1000)
        id E2F764800FF; Wed, 17 Mar 2021 14:49:05 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 15/38] dt-bindings: power: supply: tps65090: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:48:41 +0100
Message-Id: <20210317134904.80737-16-sebastian.reichel@collabora.com>
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
 .../power/supply/tps65090-charger.yaml        | 36 +++++++++++++++++++
 .../bindings/power/supply/tps65090.txt        | 17 ---------
 2 files changed, 36 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/tps65090-charger.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/tps65090.txt

diff --git a/Documentation/devicetree/bindings/power/supply/tps65090-charger.yaml b/Documentation/devicetree/bindings/power/supply/tps65090-charger.yaml
new file mode 100644
index 000000000000..f2dd38bf078c
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/tps65090-charger.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/tps65090-charger.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: TPS65090 Frontend PMU with Switchmode Charger
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: ti,tps65090-charger
+
+  ti,enable-low-current-chrg:
+    type: boolean
+    description: |
+      Enables charging when a low current is detected while the default logic is to stop charging.
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic {
+      charger {
+        compatible = "ti,tps65090-charger";
+        ti,enable-low-current-chrg;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/tps65090.txt b/Documentation/devicetree/bindings/power/supply/tps65090.txt
deleted file mode 100644
index 8e5e0d3910df..000000000000
--- a/Documentation/devicetree/bindings/power/supply/tps65090.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-TPS65090 Frontend PMU with Switchmode Charger
-
-Required Properties:
--compatible: "ti,tps65090-charger"
-
-Optional Properties:
--ti,enable-low-current-chrg: Enables charging when a low current is detected
- while the default logic is to stop charging.
-
-This node is a subnode of the tps65090 PMIC.
-
-Example:
-
-	tps65090-charger {
-		compatible = "ti,tps65090-charger";
-		ti,enable-low-current-chrg;
-	};
-- 
2.30.2

