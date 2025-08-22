Return-Path: <linux-pm+bounces-32924-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C04DB32536
	for <lists+linux-pm@lfdr.de>; Sat, 23 Aug 2025 00:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5141C85819
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 22:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E76293B73;
	Fri, 22 Aug 2025 22:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aatDAtCk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0891727602E;
	Fri, 22 Aug 2025 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755903419; cv=none; b=JifPMo29CY0eSSE2aQDL1KUxU0+YB/d8ZftMmzMbmJQk81toj5I1VwwGQwl/g+iKUE/f0NQ9I8REp46kuvhlN+1l5F73rrjLc97NxUeppZBstIOKvWXRo+uPBtCOhX1xS9nVF7BNVW0vNXc8CGHUKApXpfrJtexVJELEl5Hvak8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755903419; c=relaxed/simple;
	bh=gHngClbohUBDhpZCnSLFq65+31VngmVsFNga9uox2OY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LVsTz4+ou67gYN6N2abUutQS6ZuI/KftHfFjtLbJHADnhlBx/BfrO8p4gJtp79PhHvNS3zzlHX+6xoY6UazZ+sTGhz8K85eNs4rDX9s1iviMLOXUT2Ech0nCXI0WHBHQwvf+3jM6sqOvAe7KnvOxFl1dCupdHNVrsze3btG1gj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aatDAtCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11492C4CEED;
	Fri, 22 Aug 2025 22:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755903418;
	bh=gHngClbohUBDhpZCnSLFq65+31VngmVsFNga9uox2OY=;
	h=From:To:Cc:Subject:Date:From;
	b=aatDAtCkGxcAA6L7OMuypnWm9OpARtqQ7fy+8YYgfuoSFWT8Ol8BBbXzfxlj0X6io
	 gVghzcH/qzCAkX4KidVZi/yX7zTVMCAlNxx4SC+zhNRud/G76o3P8K/q39J6Hwe7du
	 y1YLYP+3qn1hiBqFUUFYYPL2j978/bea3TEl8ELXURjvc4lmU9CMedjlNAZ20mGlGf
	 hkgoJTOXpM+qpMOnUPPCGokMAQ2c8pXvPNMg+Yg9BOLX+b8QJVenTHz9tBK0PY7SJv
	 HYIzB9/eYKecEMmPYe7B+iGr3sEyuLA+dkp4HqZRpYCG7hWQGn7tDGy3V8gn6HgkR1
	 mkZRLBy2nGqTQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: thermal: Convert marvell,armada370-thermal to DT schema
Date: Fri, 22 Aug 2025 17:56:44 -0500
Message-ID: <20250822225645.766397-1-robh@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Marvell Armada 3xx/XP thermal binding to schema.

Drop the AP80x and CP110 as they have long been deprecated and have
been replaced by a new binding.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
  - Indicate the 2nd reg entry is 8 bytes long only (dropping deprecated
    4 bytes long).
---
 .../bindings/thermal/armada-thermal.txt       | 42 -------------------
 .../thermal/marvell,armada370-thermal.yaml    | 37 ++++++++++++++++
 2 files changed, 37 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/armada-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/marvell,armada370-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
deleted file mode 100644
index ab8b8fccc7af..000000000000
--- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-* Marvell Armada 370/375/380/XP thermal management
-
-Required properties:
-
-- compatible: Should be set to one of the following:
-    * marvell,armada370-thermal
-    * marvell,armada375-thermal
-    * marvell,armada380-thermal
-    * marvell,armadaxp-thermal
-    * marvell,armada-ap806-thermal
-    * marvell,armada-ap807-thermal
-    * marvell,armada-cp110-thermal
-
-Note: these bindings are deprecated for AP806/CP110 and should instead
-follow the rules described in:
-Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt
-Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
-
-- reg: Device's register space.
-  Two entries are expected, see the examples below. The first one points
-  to the status register (4B). The second one points to the control
-  registers (8B).
-  Note: The compatibles marvell,armada370-thermal,
-  marvell,armada380-thermal, and marvell,armadaxp-thermal must point to
-  "control MSB/control 1", with size of 4 (deprecated binding), or point
-  to "control LSB/control 0" with size of 8 (current binding). All other
-  compatibles must point to "control LSB/control 0" with size of 8.
-
-Examples:
-
-	/* Legacy bindings */
-	thermal@d0018300 {
-		compatible = "marvell,armada370-thermal";
-		reg = <0xd0018300 0x4
-		       0xd0018304 0x4>;
-	};
-
-	ap_thermal: thermal@6f8084 {
-		compatible = "marvell,armada-ap806-thermal";
-		reg = <0x6f808C 0x4>,
-		      <0x6f8084 0x8>;
-	};
diff --git a/Documentation/devicetree/bindings/thermal/marvell,armada370-thermal.yaml b/Documentation/devicetree/bindings/thermal/marvell,armada370-thermal.yaml
new file mode 100644
index 000000000000..337792859448
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/marvell,armada370-thermal.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/marvell,armada370-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Armada 3xx/XP thermal management
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+
+properties:
+  compatible:
+    enum:
+      - marvell,armada370-thermal
+      - marvell,armada375-thermal
+      - marvell,armada380-thermal
+      - marvell,armadaxp-thermal
+
+  reg:
+    items:
+      - description: status register (4B)
+      - description: control register (8B)
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    thermal@d0018300 {
+        compatible = "marvell,armada370-thermal";
+        reg = <0xd0018300 0x4>,
+              <0xd0018304 0x8>;
+    };
-- 
2.50.1


