Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1748C33F1E5
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhCQN4d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhCQN4B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:56:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FE0C06175F;
        Wed, 17 Mar 2021 06:56:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9215B1F451D7
Received: by jupiter.universe (Postfix, from userid 1000)
        id 0754A48010D; Wed, 17 Mar 2021 14:49:06 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 24/38] dt-bindings: power: supply: ucs1002: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:48:50 +0100
Message-Id: <20210317134904.80737-25-sebastian.reichel@collabora.com>
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
 .../power/supply/microchip,ucs1002.txt        | 27 ----------
 .../power/supply/microchip,ucs1002.yaml       | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/microchip,ucs1002.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
deleted file mode 100644
index 1d284ad816bf..000000000000
--- a/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Microchip UCS1002 USB Port Power Controller
-
-Required properties:
-- compatible		: Should be "microchip,ucs1002";
-- reg			: I2C slave address
-
-Optional properties:
-- interrupts		: A list of interrupts lines present (could be either
-			  corresponding to A_DET# pin, ALERT# pin, or both)
-- interrupt-names	: A list of interrupt names. Should contain (if
-			  present):
-			  - "a_det" for line connected to A_DET# pin
-			  - "alert" for line connected to ALERT# pin
-			  Both are expected to be IRQ_TYPE_EDGE_BOTH
-Example:
-
-&i2c3 {
-	charger@32 {
-		compatible = "microchip,ucs1002";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ucs1002_pins>;
-		reg = <0x32>;
-		interrupts-extended = <&gpio5 2 IRQ_TYPE_EDGE_BOTH>,
-				      <&gpio3 21 IRQ_TYPE_EDGE_BOTH>;
-		interrupt-names = "a_det", "alert";
-	};
-};
diff --git a/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.yaml b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.yaml
new file mode 100644
index 000000000000..b9bd1591ed7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/microchip,ucs1002.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip UCS1002 USB Port Power Controller
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+properties:
+  compatible:
+    const: microchip,ucs1002
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 2
+
+  interrupt-names:
+    oneOf:
+      - items:
+          - const: a_det
+          - const: alert
+      - const: a_det
+      - const: alert
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
+        charger@32 {
+            compatible = "microchip,ucs1002";
+            reg = <0x32>;
+            interrupts-extended = <&gpio5 2 IRQ_TYPE_EDGE_BOTH>,
+                                  <&gpio3 21 IRQ_TYPE_EDGE_BOTH>;
+            interrupt-names = "a_det", "alert";
+       };
+    };
-- 
2.30.2

