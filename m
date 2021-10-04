Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EF44210E7
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 16:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhJDOI1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 10:08:27 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:34301 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230380AbhJDOI0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 10:08:26 -0400
X-Greylist: delayed 3494 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Oct 2021 10:08:25 EDT
Received: from [77.244.183.192] (port=65250 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1mXNhd-004WfD-3W; Mon, 04 Oct 2021 15:08:21 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH 1/2] dt-bindings: power: supply: add Maxim MAX77976 battery charger
Date:   Mon,  4 Oct 2021 15:07:31 +0200
Message-Id: <20211004130732.950512-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add bindings for the Maxim MAX77976 I2C-controlled battery charger.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 .../bindings/power/supply/maxim,max77976.yaml | 41 +++++++++++++++++++
 MAINTAINERS                                   |  5 +++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml
new file mode 100644
index 000000000000..b508d9cc04a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/maxim,max77976.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX77976 Battery charger
+
+maintainers:
+  - Luca Ceresoli <luca@lucaceresoli.net>
+
+description: |
+  The Maxim MAX77976 is a 19Vin / 5.5A, 1-Cell Li+ battery charger
+  configured via I2C.
+
+properties:
+  compatible:
+    const: maxim,max77976
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@6b {
+        compatible = "maxim,max77976";
+        reg = <0x6b>;
+      };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index eeb4c70b3d5b..b3a3667cef46 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11388,6 +11388,11 @@ F:	Documentation/devicetree/bindings/*/*max77802.txt
 F:	drivers/regulator/max77802-regulator.c
 F:	include/dt-bindings/*/*max77802.h
 
+MAXIM MAX77976 BATTERY CHARGER
+M:	Luca Ceresoli <luca@lucaceresoli.net>
+S:	Supported
+F:	Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml
+
 MAXIM MUIC CHARGER DRIVERS FOR EXYNOS BASED BOARDS
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
 M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
-- 
2.25.1

