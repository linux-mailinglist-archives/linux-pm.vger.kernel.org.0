Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772F233925A
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 16:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhCLPwh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 10:52:37 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55840 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbhCLPw3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 10:52:29 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 7D3041F46E74
Received: by jupiter.universe (Postfix, from userid 1000)
        id 6D943480119; Fri, 12 Mar 2021 16:44:08 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 31/38] dt-bindings: power: supply: lt3651: Convert to DT schema format
Date:   Fri, 12 Mar 2021 16:43:50 +0100
Message-Id: <20210312154357.1561730-32-sebastian.reichel@collabora.com>
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
 .../power/supply/lltc,lt3651-charger.yaml     | 44 +++++++++++++++++++
 .../bindings/power/supply/lt3651-charger.txt  | 29 ------------
 2 files changed, 44 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/lltc,lt3651-charger.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/lt3651-charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/lltc,lt3651-charger.yaml b/Documentation/devicetree/bindings/power/supply/lltc,lt3651-charger.yaml
new file mode 100644
index 000000000000..e2d8d2aebb73
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/lltc,lt3651-charger.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/lltc,lt3651-charger.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Analog Devices LT3651 Charger Power Supply bindings
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    enum:
+      - lltc,lt3651-charger
+      - lltc,ltc3651-charger  # deprecated, use lltc,lt3651-charger
+
+  lltc,acpr-gpios:
+    maxItems: 1
+
+  lltc,fault-gpios:
+    maxItems: 1
+
+  lltc,chrg-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - lltc,acpr-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    charger {
+      compatible = "lltc,lt3651-charger";
+      lltc,acpr-gpios = <&gpio0 68 GPIO_ACTIVE_LOW>;
+      lltc,fault-gpios = <&gpio0 64 GPIO_ACTIVE_LOW>;
+      lltc,chrg-gpios = <&gpio0 63 GPIO_ACTIVE_LOW>;
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/lt3651-charger.txt b/Documentation/devicetree/bindings/power/supply/lt3651-charger.txt
deleted file mode 100644
index 40811ff8de10..000000000000
--- a/Documentation/devicetree/bindings/power/supply/lt3651-charger.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Analog Devices LT3651 Charger Power Supply bindings: lt3651-charger
-
-Required properties:
-- compatible: Should contain one of the following:
- * "lltc,ltc3651-charger", (DEPRECATED: Use "lltc,lt3651-charger")
- * "lltc,lt3651-charger"
- - lltc,acpr-gpios: Connect to ACPR output. See remark below.
-
-Optional properties:
- - lltc,fault-gpios: Connect to FAULT output. See remark below.
- - lltc,chrg-gpios: Connect to CHRG output. See remark below.
-
-The lt3651 outputs are open-drain type and active low. The driver assumes the
-GPIO reports "active" when the output is asserted, so if the pins have been
-connected directly, the GPIO flags should be set to active low also.
-
-The driver will attempt to aquire interrupts for all GPIOs to detect changes in
-line state. If the system is not capabale of providing interrupts, the driver
-cannot report changes and userspace will need to periodically read the sysfs
-attributes to detect changes.
-
-Example:
-
-	charger: battery-charger {
-		compatible = "lltc,lt3651-charger";
-		lltc,acpr-gpios = <&gpio0 68 GPIO_ACTIVE_LOW>;
-		lltc,fault-gpios = <&gpio0 64 GPIO_ACTIVE_LOW>;
-		lltc,chrg-gpios = <&gpio0 63 GPIO_ACTIVE_LOW>;
-	};
-- 
2.30.1

