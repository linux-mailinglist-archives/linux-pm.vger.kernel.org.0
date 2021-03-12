Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BD93391DF
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 16:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhCLPor (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 10:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbhCLPoQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 10:44:16 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE9DC061574;
        Fri, 12 Mar 2021 07:44:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 3EFA51F46EC2
Received: by jupiter.universe (Postfix, from userid 1000)
        id 5687D480104; Fri, 12 Mar 2021 16:44:08 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH 18/38] dt-bindings: power: supply: n900-battery: Convert to DT schema format
Date:   Fri, 12 Mar 2021 16:43:37 +0100
Message-Id: <20210312154357.1561730-19-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
References: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the binding to DT schema format.

Cc: Pali Rohár <pali@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../power/supply/nokia,n900-battery.yaml      | 49 +++++++++++++++++++
 .../bindings/power/supply/rx51-battery.txt    | 25 ----------
 2 files changed, 49 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/nokia,n900-battery.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/rx51-battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/nokia,n900-battery.yaml b/Documentation/devicetree/bindings/power/supply/nokia,n900-battery.yaml
new file mode 100644
index 000000000000..4a1489f2b28d
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/nokia,n900-battery.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/nokia,n900-battery.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Nokia N900 battery
+
+maintainers:
+  - Pali Rohár <pali@kernel.org>
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: nokia,n900-battery
+
+  io-channels:
+    items:
+      - description: ADC channel for temperature reading
+      - description: ADC channel for battery size identification
+      - description: ADC channel to measure the battery voltage
+
+  io-channel-names:
+    items:
+      - const: temp
+      - const: bsi
+      - const: vbat
+
+required:
+  - compatible
+  - io-channels
+  - io-channel-names
+
+additionalProperties: false
+
+examples:
+  - |
+    battery {
+      compatible = "nokia,n900-battery";
+      io-channels = <&twl4030_madc 0>,
+                    <&twl4030_madc 4>,
+                    <&twl4030_madc 12>;
+      io-channel-names = "temp",
+                         "bsi",
+                         "vbat";
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/rx51-battery.txt b/Documentation/devicetree/bindings/power/supply/rx51-battery.txt
deleted file mode 100644
index 90438453db58..000000000000
--- a/Documentation/devicetree/bindings/power/supply/rx51-battery.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Binding for Nokia N900 battery
-
-The Nokia N900 battery status can be read via the TWL4030's A/D converter.
-
-Required properties:
-- compatible: Should contain one of the following:
- * "nokia,n900-battery"
-- io-channels: Should contain IIO channel specifiers
-               for each element in io-channel-names.
-- io-channel-names: Should contain the following values:
- * "temp" - The ADC channel for temperature reading
- * "bsi"  - The ADC channel for battery size identification
- * "vbat" - The ADC channel to measure the battery voltage
-
-Example from Nokia N900:
-
-battery: n900-battery {
-	compatible = "nokia,n900-battery";
-	io-channels = <&twl4030_madc 0>,
-		      <&twl4030_madc 4>,
-		      <&twl4030_madc 12>;
-	io-channel-names = "temp",
-			   "bsi",
-			   "vbat";
-};
-- 
2.30.1

