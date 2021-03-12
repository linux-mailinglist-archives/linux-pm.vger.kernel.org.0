Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825653391FB
	for <lists+linux-pm@lfdr.de>; Fri, 12 Mar 2021 16:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhCLPox (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 10:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbhCLPoT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 10:44:19 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECA1C061574;
        Fri, 12 Mar 2021 07:44:18 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B0AFB1F46E80
Received: by jupiter.universe (Postfix, from userid 1000)
        id 7589148011C; Fri, 12 Mar 2021 16:44:08 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 34/38] dt-bindings: power: supply: olpc-battery: Convert to DT schema format
Date:   Fri, 12 Mar 2021 16:43:53 +0100
Message-Id: <20210312154357.1561730-35-sebastian.reichel@collabora.com>
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
2.30.1

