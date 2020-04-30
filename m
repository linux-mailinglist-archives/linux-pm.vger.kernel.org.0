Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9661C0039
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 17:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgD3P1W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 11:27:22 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50514 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgD3P1W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2020 11:27:22 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03UFRJBb071159;
        Thu, 30 Apr 2020 10:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588260439;
        bh=RR7cXm+NvfzNMNDKtyKq45cJ+sJveavEPZsYUiaQgSE=;
        h=From:To:CC:Subject:Date;
        b=Z0nBW1zLGUube+p9QD7mxXdcTUnW8t8MnvWj713SNQVmywLe58KvLRg+PlhulE/YM
         O4b2ny3xAcl8pfTI1zKZrMx918E+lwCX+6GFwOEc9fIPU6Dsw7NwDKh1/4qN0rLzqS
         cCySq2gyvw9+LhZjBHrqCajvV9fhsFIDXOsZr6LQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03UFRJCV018986;
        Thu, 30 Apr 2020 10:27:19 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 30
 Apr 2020 10:27:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 30 Apr 2020 10:27:19 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03UFRJeq125886;
        Thu, 30 Apr 2020 10:27:19 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH] dt-bindings: power: Convert power_supply text to yaml
Date:   Thu, 30 Apr 2020 10:18:41 -0500
Message-ID: <20200430151841.17453-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the power_supply.txt to power-supply.yaml.
This conversion entailed fixing up the binding to being yaml and dt
checker compliant.

Added a note in the power_supply.txt to reference the power-supply.yaml

CC: Rob Herring <robh@kernel.org>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../bindings/power/supply/power-supply.yaml   | 40 +++++++++++++++++++
 .../bindings/power/supply/power_supply.txt    | 25 +-----------
 2 files changed, 42 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/power-supply.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/power-supply.yaml b/Documentation/devicetree/bindings/power/supply/power-supply.yaml
new file mode 100644
index 000000000000..cfbc79833ed8
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/power-supply.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/power_supply.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Power Supply Core Support
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+properties:
+  power-supplies:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      This property is added to a supply in order to list the devices which
+      supply it power, referenced by their phandles.
+
+examples:
+  - |
+    power {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      usb_charger:power@e {
+        compatible = "some,usb-charger";
+        reg = <0xe>;
+      };
+
+      ac_charger:power@c {
+        compatible = "some,ac-charger";
+        reg = <0xc>;
+      };
+
+      battery:battery@b {
+        compatible = "some,battery";
+        reg = <0xb>;
+        power-supplies = <&usb_charger>, <&ac_charger>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/power/supply/power_supply.txt b/Documentation/devicetree/bindings/power/supply/power_supply.txt
index 8391bfa0edac..d9693e054509 100644
--- a/Documentation/devicetree/bindings/power/supply/power_supply.txt
+++ b/Documentation/devicetree/bindings/power/supply/power_supply.txt
@@ -1,23 +1,2 @@
-Power Supply Core Support
-
-Optional Properties:
- - power-supplies : This property is added to a supply in order to list the
-   devices which supply it power, referenced by their phandles.
-
-Example:
-
-	usb-charger: power@e {
-		compatible = "some,usb-charger";
-		...
-	};
-
-	ac-charger: power@c {
-		compatible = "some,ac-charger";
-		...
-	};
-
-	battery@b {
-		compatible = "some,battery";
-		...
-		power-supplies = <&usb-charger>, <&ac-charger>;
-	};
+This binding has been converted to yaml please see power-supply.yaml in this
+directory.
-- 
2.25.1

