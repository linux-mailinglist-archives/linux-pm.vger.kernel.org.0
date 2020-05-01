Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49061C1BF0
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 19:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbgEARhz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 13:37:55 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47060 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgEARhz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 13:37:55 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 041Hbsiw029531;
        Fri, 1 May 2020 12:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588354674;
        bh=kl6qxjXpK8WjVJ4rxTSpNCEet+Pn0TlP5V/ouUJcsA0=;
        h=From:To:CC:Subject:Date;
        b=tSnPkGiYiB4BbC7Jl6xNHDULDeETvYTe2x6bX3D5mABtgKNdko8nLjffJspd/1F6s
         ambWdSFwAohmPmtGrGQAcGN3xzYiMVM/vWT984qu2ipFIhzI0HpsnSBaMvHdSL8aV7
         zdvPejHxeF8DqcvH9UFOoVsEqRV7g6gEhjcsqXds=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 041HbsU7046998
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 May 2020 12:37:54 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 1 May
 2020 12:37:53 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 1 May 2020 12:37:54 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 041Hbr8J087346;
        Fri, 1 May 2020 12:37:53 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2] dt-bindings: power: Convert power_supply text to yaml
Date:   Fri, 1 May 2020 12:29:13 -0500
Message-ID: <20200501172913.23537-1-dmurphy@ti.com>
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

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../bindings/power/supply/power-supply.yaml   | 40 +++++++++++++++++++
 .../bindings/power/supply/power_supply.txt    | 25 +-----------
 2 files changed, 42 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/power-supply.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/power-supply.yaml b/Documentation/devicetree/bindings/power/supply/power-supply.yaml
new file mode 100644
index 000000000000..3bb02bb3a2d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/power-supply.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/power-supply.yaml#"
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
+      usb_charger:charger@e {
+        compatible = "some,usb-charger";
+        reg = <0xe>;
+      };
+
+      ac_charger:charger@c {
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

