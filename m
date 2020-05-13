Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E56C1D1E29
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 20:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390426AbgEMS4j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 14:56:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51982 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390411AbgEMS4i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 14:56:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A6BB12A2A71
Received: by jupiter.universe (Postfix, from userid 1000)
        id 9BA0048012E; Wed, 13 May 2020 20:56:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 19/19] dt-bindings: power: sbs-battery: Convert to yaml
Date:   Wed, 13 May 2020 20:56:15 +0200
Message-Id: <20200513185615.508236-20-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513185615.508236-1-sebastian.reichel@collabora.com>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert sbs-battery bindings to YAML.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../power/supply/sbs,sbs-battery.yaml         | 83 +++++++++++++++++++
 .../bindings/power/supply/sbs_sbs-battery.txt | 30 -------
 2 files changed, 83 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml b/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml
new file mode 100644
index 000000000000..205bc826bd20
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/sbs,sbs-battery.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SBS compliant battery
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+description: |
+  Battery compatible with the smart battery system specifications
+
+properties:
+
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - ti,bq20z65
+              - ti,bq20z75
+          - enum:
+              - sbs,sbs-battery
+      - items:
+          - const: sbs,sbs-battery
+
+  reg:
+    maxItems: 1
+
+  sbs,i2c-retry-count:
+    description:
+      The number of times to retry I2C transactions on I2C IO failure.
+    default: 0
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+
+  sbs,poll-retry-count:
+    description:
+      The number of times to try looking for new status after an external
+      change notification.
+    default: 0
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+
+  sbs,battery-detect-gpios:
+    description:
+      GPIO which signals battery detection. If this is not supplied, the bus
+      needs to be polled to detect the battery.
+    maxItems: 1
+
+  sbs,disable-charger-broadcasts:
+    description:
+      SBS batteries by default send broadcast messages to SBS compliant chargers to
+      configure max. charge current/voltage. If your hardware does not have an SBS
+      compliant charger it should be disabled via this property to avoid blocking
+      the bus. Also some SBS battery fuel gauges are known to have a buggy multi-
+      master implementation.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        battery@b {
+            compatible = "ti,bq20z75", "sbs,sbs-battery";
+            reg = <0xb>;
+            sbs,i2c-retry-count = <2>;
+            sbs,poll-retry-count = <10>;
+            sbs,battery-detect-gpios = <&gpio 122 GPIO_ACTIVE_HIGH>;
+            sbs,disable-charger-broadcasts;
+       };
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
deleted file mode 100644
index a5093ccef5c5..000000000000
--- a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-SBS sbs-battery
-~~~~~~~~~~
-
-Required properties :
- - compatible: "<vendor>,<part-number>", "sbs,sbs-battery" as fallback. The
-     part number compatible string might be used in order to take care of
-     vendor specific registers.
-     Known <vendor>,<part-number>:
-       ti,bq20z65
-       ti,bq20z75
-
-Optional properties :
- - sbs,i2c-retry-count : The number of times to retry i2c transactions on i2c
-   IO failure.
- - sbs,poll-retry-count : The number of times to try looking for new status
-   after an external change notification.
- - sbs,battery-detect-gpios : The gpio which signals battery detection and
-   a flag specifying its polarity.
- - sbs,disable-charger-broadcasts: for systems without sbs compliant chargers
-
-Example:
-
-	battery@b {
-		compatible = "ti,bq20z75", "sbs,sbs-battery";
-		reg = <0xb>;
-		sbs,i2c-retry-count = <2>;
-		sbs,poll-retry-count = <10>;
-		sbs,battery-detect-gpios = <&gpio-controller 122 1>;
-		sbs,disable-charger-broadcasts;
-	}
-- 
2.26.2

