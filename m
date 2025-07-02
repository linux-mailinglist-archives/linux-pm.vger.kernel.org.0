Return-Path: <linux-pm+bounces-29998-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F05AF65B9
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 01:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60884819AF
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 23:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36344246327;
	Wed,  2 Jul 2025 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdpJ23gs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083772DE70A;
	Wed,  2 Jul 2025 23:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497228; cv=none; b=VXBw1FGgqtl5hAzMfYbfehF+8bIJMGJzIcIkq0BwQLb1Vv/M5TT52I9u0Lg6AgSHXUM7Kr9faB+hIQ8h0KM3hzZjUQEMugFF39+80SHd2+qSsG9dN/b/az/TTwZ1brExkS5Qyr0Jax90b8Te57yQqGEhs9C06bkVVQii+716MOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497228; c=relaxed/simple;
	bh=YoxFkvvT3uGhs9+nxoPloOtRn0pJtIA5kzHG983qo/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rczV0tumZGB64/bc7oH1qA/C7UbTi0A5ow/YmBX3HmekaiM+qnSJZ9SWUASWKwxuVXyNVHm/h2o/NrVafJBZlyK19U8y9SLb22IDsPrQ4g7XiBeFqzt7MQMANPQ0dwb+2Cj1VHfnB9Nmyp93k4gLmMUUijisiYVq3gTkj4fUqaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdpJ23gs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1D8C4CEE7;
	Wed,  2 Jul 2025 23:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751497227;
	bh=YoxFkvvT3uGhs9+nxoPloOtRn0pJtIA5kzHG983qo/8=;
	h=From:To:Cc:Subject:Date:From;
	b=LdpJ23gskwvtzo+wI4ZdwYtzxGN3XBWPweYW/AjiS5g5Og+WK1qiwTA5T99m0foMN
	 dCrosyxmzEEuGSN3hvbdD/sFScH/4vki5rsnInDGIwYgbpsMlj2wF4uTFLpzfxuLk1
	 mRV386m2m/W5L8+IehWoaZ2bzWiR8XNNMC0yhuY8Q43Er4mpDtzqRcoCrKYzjUwQGs
	 96WHuvtEML0++8EpClnY5eG3OpSO+RNZalQ8b36CBsqw5Q/15HCJ2GwI93g5dY4rG2
	 EcyGVAOmAloo3KTvzqITUEPcTUGoaI3rawRKcWUHH+vE0bH32i4bHB9ZTke0VDIxH1
	 z0HmnMm2Wqs1Q==
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
Subject: [PATCH] dt-bindings: thermal: Convert marvell,armada370-thermal to DT schema
Date: Wed,  2 Jul 2025 17:55:27 -0500
Message-ID: <20250702225530.2858649-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
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
index 000000000000..2f55b7252e51
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
+      - description: control register (4B or 8B)
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
+        reg = <0xd0018300 0x4
+               0xd0018304 0x4>;
+    };
-- 
2.47.2


