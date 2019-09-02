Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA41A5A20
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 17:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbfIBPDt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 11:03:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729942AbfIBPDt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Sep 2019 11:03:49 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5E4C217D7;
        Mon,  2 Sep 2019 15:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567436627;
        bh=bFvoIVZPGocM61oupTglGGc0FyftmOcB63lyHubofMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PUhcqiku0QyWkiMJnjfhQ4itM+KUUMw0nfVKOlctNuI8bPPeGjg65V9TVpA/koFw/
         kffWv61cg0CE1w5mmQk6Zf8svohVkFnKFRcNRRiX0j11uP4vnOEKR7IdNa5aCDDSph
         E0YUoOa3g/npCAyJzrgGyc4yk6Vl3IsyHgKmUk7U=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] dt-bindings: power: syscon-poweroff: Convert bindings to json-schema
Date:   Mon,  2 Sep 2019 17:03:36 +0200
Message-Id: <20190902150336.3600-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190902150336.3600-1-krzk@kernel.org>
References: <20190902150336.3600-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the Syscon poweroff bindings to DT schema format using
json-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/power/reset/syscon-poweroff.txt  | 30 --------
 .../bindings/power/reset/syscon-poweroff.yaml | 68 +++++++++++++++++++
 2 files changed, 68 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt b/Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt
deleted file mode 100644
index 022ed1f3bc80..000000000000
--- a/Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Generic SYSCON mapped register poweroff driver
-
-This is a generic poweroff driver using syscon to map the poweroff register.
-The poweroff is generally performed with a write to the poweroff register
-defined by the register map pointed by syscon reference plus the offset
-with the value and mask defined in the poweroff node.
-
-Required properties:
-- compatible: should contain "syscon-poweroff"
-- regmap: this is phandle to the register map node
-- offset: offset in the register map for the poweroff register (in bytes)
-- value: the poweroff value written to the poweroff register (32 bit access)
-
-Optional properties:
-- mask: update only the register bits defined by the mask (32 bit)
-
-Legacy usage:
-If a node doesn't contain a value property but contains a mask property, the
-mask property is used as the value.
-
-Default will be little endian mode, 32 bit access only.
-
-Examples:
-
-	poweroff {
-	   compatible = "syscon-poweroff";
-	   regmap = <&regmapnode>;
-	   offset = <0x0>;
-	   mask = <0x7a>;
-	};
diff --git a/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml b/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml
new file mode 100644
index 000000000000..9336ffcf3ac8
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/syscon-poweroff.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/syscon-poweroff.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic SYSCON mapped register poweroff driver
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+description: |+
+  This is a generic poweroff driver using syscon to map the poweroff register.
+  The poweroff is generally performed with a write to the poweroff register
+  defined by the register map pointed by syscon reference plus the offset
+  with the value and mask defined in the poweroff node.
+  Default will be little endian mode, 32 bit access only.
+
+properties:
+  compatible:
+    const: syscon-poweroff
+
+  mask:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Update only the register bits defined by the mask (32 bit).
+    maxItems: 1
+
+  offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Offset in the register map for the poweroff register (in bytes).
+    maxItems: 1
+
+  regmap:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the register map node.
+    maxItems: 1
+
+  value:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The poweroff value written to the poweroff register (32 bit access).
+    maxItems: 1
+
+required:
+  - compatible
+  - regmap
+  - offset
+
+allOf:
+  - if:
+      properties:
+        value:
+          not:
+            type: array
+    then:
+      required:
+        - mask
+    else:
+      required:
+        - value
+
+examples:
+  - |
+    poweroff {
+      compatible = "syscon-poweroff";
+      regmap = <&regmapnode>;
+      offset = <0x0>;
+      mask = <0x7a>;
+    };
-- 
2.17.1

