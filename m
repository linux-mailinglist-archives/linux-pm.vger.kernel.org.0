Return-Path: <linux-pm+bounces-870-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D0180BB3F
	for <lists+linux-pm@lfdr.de>; Sun, 10 Dec 2023 14:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04F99B20AAD
	for <lists+linux-pm@lfdr.de>; Sun, 10 Dec 2023 13:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EB4F9F5;
	Sun, 10 Dec 2023 13:48:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79EBED9;
	Sun, 10 Dec 2023 05:47:57 -0800 (PST)
X-IronPort-AV: E=Sophos;i="6.04,265,1695654000"; 
   d="scan'208";a="189797775"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 10 Dec 2023 22:47:56 +0900
Received: from localhost.localdomain (unknown [10.226.92.40])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BEC574003EBC;
	Sun, 10 Dec 2023 22:47:51 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Support Opensource <support.opensource@diasemi.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v5 6/8] dt-bindings: thermal: Convert da906{1,2} thermal to json-schema
Date: Sun, 10 Dec 2023 13:47:15 +0000
Message-Id: <20231210134717.94020-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231210134717.94020-1-biju.das.jz@bp.renesas.com>
References: <20231210134717.94020-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the da906{1,2} thermal device tree binding documentation to
json-schema.

Update MAINTAINERS entries and description by referring to
dlg,da9062-thermal.yaml binding file.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v4->v5:
 * No change.
v3->v4:
 * Restored the patch from v2.
 * Dropped example
 * Replaced enum->const for compatible property.
 * Added Rb tag from Rob and retained Rb tag as changes are trivial.
v2->v3:
 * Fixed bot errors related to MAINTAINERS entry, invalid doc
   references and thermal examples by merging patch#4.
v2:
 * New patch
---
 .../devicetree/bindings/mfd/da9062.txt        |  2 +-
 .../bindings/thermal/da9062-thermal.txt       | 36 -------------------
 .../bindings/thermal/dlg,da9062-thermal.yaml  | 35 ++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 4 files changed, 37 insertions(+), 38 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/da9062-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml

diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
index 154c31fa4443..c8a7f119ac84 100644
--- a/Documentation/devicetree/bindings/mfd/da9062.txt
+++ b/Documentation/devicetree/bindings/mfd/da9062.txt
@@ -88,7 +88,7 @@ Sub-nodes:
 
 - watchdog: See ../watchdog/dlg,da9062-watchdog.yaml
 
-- thermal : See ../thermal/da9062-thermal.txt
+- thermal : See ../thermal/dlg,da9062-thermal.yaml
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/thermal/da9062-thermal.txt b/Documentation/devicetree/bindings/thermal/da9062-thermal.txt
deleted file mode 100644
index e241bb5a5584..000000000000
--- a/Documentation/devicetree/bindings/thermal/da9062-thermal.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-* Dialog DA9062/61 TJUNC Thermal Module
-
-This module is part of the DA9061/DA9062. For more details about entire
-DA9062 and DA9061 chips see Documentation/devicetree/bindings/mfd/da9062.txt
-
-Junction temperature thermal module uses an interrupt signal to identify
-high THERMAL_TRIP_HOT temperatures for the PMIC device.
-
-Required properties:
-
-- compatible: should be one of the following valid compatible string lines:
-        "dlg,da9061-thermal", "dlg,da9062-thermal"
-        "dlg,da9062-thermal"
-
-Optional properties:
-
-- polling-delay-passive : Specify the polling period, measured in
-    milliseconds, between thermal zone device update checks.
-
-Example: DA9062
-
-	pmic0: da9062@58 {
-		thermal {
-			compatible = "dlg,da9062-thermal";
-			polling-delay-passive = <3000>;
-		};
-	};
-
-Example: DA9061 using a fall-back compatible for the DA9062 onkey driver
-
-	pmic0: da9061@58 {
-		thermal {
-			compatible = "dlg,da9061-thermal", "dlg,da9062-thermal";
-			polling-delay-passive = <3000>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml b/Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml
new file mode 100644
index 000000000000..206635f74850
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/dlg,da9062-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dialog DA9062/61 TJUNC Thermal Module
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+description: |
+  This module is part of the DA9061/DA9062. For more details about entire
+  DA9062 and DA9061 chips see Documentation/devicetree/bindings/mfd/da9062.txt
+
+  Junction temperature thermal module uses an interrupt signal to identify
+  high THERMAL_TRIP_HOT temperatures for the PMIC device.
+
+properties:
+  compatible:
+    oneOf:
+      - const: dlg,da9062-thermal
+      - items:
+          - const: dlg,da9061-thermal
+          - const: dlg,da9062-thermal
+
+  polling-delay-passive:
+    description:
+      Specify the polling period, measured in milliseconds, between
+      thermal zone device update checks.
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index e8782768368f..1b03f23d5474 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6117,7 +6117,7 @@ F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/dlg,da9*.yaml
 F:	Documentation/devicetree/bindings/regulator/dlg,slg51000.yaml
 F:	Documentation/devicetree/bindings/sound/da[79]*.txt
-F:	Documentation/devicetree/bindings/thermal/da90??-thermal.txt
+F:	Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml
 F:	Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.yaml
 F:	Documentation/hwmon/da90??.rst
 F:	drivers/gpio/gpio-da90??.c
-- 
2.39.2


