Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0275133F1A0
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhCQNts (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbhCQNtN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D89EC06175F;
        Wed, 17 Mar 2021 06:49:13 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id BCC711F44EEB
Received: by jupiter.universe (Postfix, from userid 1000)
        id DA8D64800E4; Wed, 17 Mar 2021 14:49:05 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 12/38] dt-bindings: power: supply: ds2760: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:48:38 +0100
Message-Id: <20210317134904.80737-13-sebastian.reichel@collabora.com>
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
 .../bindings/power/supply/maxim,ds2760.txt    | 26 -----------
 .../bindings/power/supply/maxim,ds2760.yaml   | 43 +++++++++++++++++++
 2 files changed, 43 insertions(+), 26 deletions(-)
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
index 000000000000..818647edf63d
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,ds2760.yaml
@@ -0,0 +1,43 @@
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
+    description: |
+      Time im milliseconds to cache the data for.
+      When this time expires, the values are read again from the hardware.
+      Defaults to 1000.
+
+  rated-capacity-microamp-hours:
+    description: |
+      The rated capacity of the battery, in mAh.
+      If not specified, the value stored in the non-volatile chip memory is used.
+
+required:
+  - compatible
+
+unevaluatedProperties: false
-- 
2.30.2

