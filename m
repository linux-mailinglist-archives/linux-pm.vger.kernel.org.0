Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356B233F1B7
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhCQNt4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:49:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56186 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhCQNtP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:15 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 2BED01F44A03
Received: by jupiter.universe (Postfix, from userid 1000)
        id 22D2048011C; Wed, 17 Mar 2021 14:49:06 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 34/38] dt-bindings: power: supply: olpc-battery: Convert to DT schema format
Date:   Wed, 17 Mar 2021 14:49:00 +0100
Message-Id: <20210317134904.80737-35-sebastian.reichel@collabora.com>
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
 .../bindings/power/supply/olpc-battery.yaml   | 27 +++++++++++++++++++
 .../bindings/power/supply/olpc_battery.txt    |  5 ----
 2 files changed, 27 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/olpc-battery.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/olpc_battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/olpc-battery.yaml b/Documentation/devicetree/bindings/power/supply/olpc-battery.yaml
new file mode 100644
index 000000000000..0bd7bf3b8e1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/olpc-battery.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/olpc-battery.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: OLPC Battery
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: olpc,xo1.5-battery
+          - const: olpc,xo1-battery
+      - items:
+          - const: olpc,xo1-battery
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/power/supply/olpc_battery.txt b/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
deleted file mode 100644
index 8d87d6b35a98..000000000000
--- a/Documentation/devicetree/bindings/power/supply/olpc_battery.txt
+++ /dev/null
@@ -1,5 +0,0 @@
-OLPC battery
-~~~~~~~~~~~~
-
-Required properties:
-  - compatible : "olpc,xo1-battery" or "olpc,xo1.5-battery"
-- 
2.30.2

