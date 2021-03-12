Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A89F3391EC
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 16:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhCLPou (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 10:44:50 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55676 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhCLPoR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 10:44:17 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 564561F46EC8
Received: by jupiter.universe (Postfix, from userid 1000)
        id 63CD4480113; Fri, 12 Mar 2021 16:44:08 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 26/38] dt-bindings: power: supply: pm8941-coincell: Convert to DT schema format
Date:   Fri, 12 Mar 2021 16:43:45 +0100
Message-Id: <20210312154357.1561730-27-sebastian.reichel@collabora.com>
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
 .../power/supply/qcom,coincell-charger.txt    | 48 ---------------
 .../power/supply/qcom,pm8941-coincell.yaml    | 58 +++++++++++++++++++
 2 files changed, 58 insertions(+), 48 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/qcom,coincell-charger.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,coincell-charger.txt b/Documentation/devicetree/bindings/power/supply/qcom,coincell-charger.txt
deleted file mode 100644
index 747899223262..000000000000
--- a/Documentation/devicetree/bindings/power/supply/qcom,coincell-charger.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-Qualcomm Coincell Charger:
-
-The hardware block controls charging for a coincell or capacitor that is
-used to provide power backup for certain features of the power management
-IC (PMIC)
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be: "qcom,pm8941-coincell"
-
-- reg:
-	Usage: required
-	Value type: <u32>
-	Definition: base address of the coincell charger registers
-
-- qcom,rset-ohms:
-	Usage: required
-	Value type: <u32>
-	Definition: resistance (in ohms) for current-limiting resistor
-		must be one of: 800, 1200, 1700, 2100
-
-- qcom,vset-millivolts:
-	Usage: required
-	Value type: <u32>
-	Definition: voltage (in millivolts) to apply for charging
-		must be one of: 2500, 3000, 3100, 3200
-
-- qcom,charger-disable:
-	Usage: optional
-	Value type: <boolean>
-	Definition: defining this property disables charging
-
-This charger is a sub-node of one of the 8941 PMIC blocks, and is specified
-as a child node in DTS of that node.  See ../mfd/qcom,spmi-pmic.txt and
-../mfd/qcom-pm8xxx.txt
-
-Example:
-
-	pm8941@0 {
-		coincell@2800 {
-			compatible = "qcom,pm8941-coincell";
-			reg = <0x2800>;
-
-			qcom,rset-ohms = <2100>;
-			qcom,vset-millivolts = <3000>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml
new file mode 100644
index 000000000000..bcaf3be1f647
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pm8941-coincell.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/qcom,pm8941-coincell.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Coincell Charger
+
+description: |
+  The hardware block controls charging for a coincell or capacitor that is
+  used to provide power backup for certain features of the power management
+  IC (PMIC)
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+properties:
+  compatible:
+    const: qcom,pm8941-coincell
+
+  reg:
+    maxItems: 1
+
+  qcom,rset-ohms:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: resistance (in ohms) for current-limiting resistor
+    enum: [ 800, 1200, 1700, 2100 ]
+
+  qcom,vset-millivolts:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: voltage (in millivolts) to apply for charging
+    enum: [ 2500, 3000, 3100, 3200 ]
+
+  qcom,charger-disable:
+    type: boolean
+    description: defining this property disables charging
+
+required:
+  - compatible
+  - reg
+  - qcom,rset-ohms
+  - qcom,vset-millivolts
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@2800 {
+        compatible = "qcom,pm8941-coincell";
+        reg = <0x2800>;
+        qcom,rset-ohms = <2100>;
+        qcom,vset-millivolts = <3000>;
+      };
+    };
-- 
2.30.1

