Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249C33391D9
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 16:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhCLPop (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 10:44:45 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55622 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbhCLPoO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 10:44:14 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9F2E91F46E99
Received: by jupiter.universe (Postfix, from userid 1000)
        id 47C204800E4; Fri, 12 Mar 2021 16:44:08 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 12/38] dt-bindings: power: supply: ds2760: Convert to DT schema format
Date:   Fri, 12 Mar 2021 16:43:31 +0100
Message-Id: <20210312154357.1561730-13-sebastian.reichel@collabora.com>
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
 .../bindings/power/supply/maxim,ds2760.txt    | 26 -----------
 .../bindings/power/supply/maxim,ds2760.yaml   | 45 +++++++++++++++++++
 2 files changed, 45 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,ds2760.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt b/Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt
deleted file mode 100644
index 55967a0bee11..000000000000
--- a/Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Devicetree bindings for Maxim DS2760
-====================================
-
-The ds2760 is a w1 slave device and must hence have its sub-node in DT
-under a w1 bus master node.
-
-The device exposes a power supply, so the details described in
-Documentation/devicetree/bindings/power/supply/power_supply.txt apply.
-
-Required properties:
-- compatible: must be "maxim,ds2760"
-
-Optional properties:
-- power-supplies:	Refers to one or more power supplies connected to
-			this battery.
-- maxim,pmod-enabled:	This boolean property enables the DS2760 to enter
-			sleep mode when the DQ line goes low for greater
-			than 2 seconds and leave sleep Mode when the DQ
-			line goes high.
-- maxim,cache-time-ms:	Time im milliseconds to cache the data for. When
-			this time expires, the values are read again from
-			the hardware. Defaults to 1000.
-- rated-capacity-microamp-hours:
-			The rated capacity of the battery, in mAh.
-			If not specified, the value stored in the
-			non-volatile chip memory is used.
diff --git a/Documentation/devicetree/bindings/power/supply/maxim,ds2760.yaml b/Documentation/devicetree/bindings/power/supply/maxim,ds2760.yaml
new file mode 100644
index 000000000000..3b3fb611393a
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,ds2760.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/maxim,ds2760.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Maxim DS2760 DT bindings
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+description: |
+  The ds2760 is a w1 slave device and must hence have its sub-node in
+  DT under a w1 bus master node.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: maxim,ds2760
+
+  maxim,pmod-enabled:
+    description: |
+      Allow the DS2760 to enter sleep mode when the DQ line goes low for more than 2 seconds
+      and leave sleep Mode when the DQ line goes high.
+    type: boolean
+
+  maxim,cache-time-ms:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Time im milliseconds to cache the data for.
+      When this time expires, the values are read again from the hardware.
+      Defaults to 1000.
+
+  rated-capacity-microamp-hours:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The rated capacity of the battery, in mAh.
+      If not specified, the value stored in the non-volatile chip memory is used.
+
+required:
+  - compatible
+
+unevaluatedProperties: false
-- 
2.30.1

