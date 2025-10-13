Return-Path: <linux-pm+bounces-36011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DD3BD68FD
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 00:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACFA18A2EF8
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 22:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D153128B6;
	Mon, 13 Oct 2025 21:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmQhHQb8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACE53128B0;
	Mon, 13 Oct 2025 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392704; cv=none; b=r+/tdwSI9aA9KA0B6j53Bnj+g2tHtAohe8CvmJfX3QJ/beB/sugEBt377du8EggwrbEzqTEMXIPcUPLsL3G2ywXMUTPjhOLbCId13YNIvJHefW3g5X/fs54EcUuwBPNfCtRc8sbBD+xqwVs+ZUkohaz3Nsdg0gBAI6QYMdxabwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392704; c=relaxed/simple;
	bh=Qwwb0fxds3+U+HFZynUuoCWlS0XpHe46OziiI8ARBSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdejldXbE0wmWsypLETgaXWDjnEiHchwxgSBFPrWdfBcHyuaf+6T8NszEgwSj8xNnqOQUlFnrBql9qiNLA/B3HhfLLG1FUHIrieENxihrFDSgzYe5D/oe24WKJnMCLRiXazP400oqh454/AKFyGN0J5Cj2Iy1fP4t749dT9kD+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmQhHQb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C45C2BCB1;
	Mon, 13 Oct 2025 21:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760392704;
	bh=Qwwb0fxds3+U+HFZynUuoCWlS0XpHe46OziiI8ARBSQ=;
	h=From:To:Cc:Subject:Date:From;
	b=lmQhHQb8IpHXk08n4f1k7re1bvW/g6B4N82qO223M8gwHBmaxlmpKuKY23/phuCyn
	 GMdMJw6PxcxNmdjq4ZZwduneZIgo7/TuygWYC5yt/K/VIAz9b/JlomJ39SIEcdZ2rn
	 mRxN85NIS8QZfoAK8wBlFh1a7lTymcsTMouS3BRCoKDIG2lxCibIDM39F4eeHx57cd
	 OC7ymKS6WSIOu3IPGruznOeefsYAcGyECJErHSv38i1rMOdw5bvbgmXcZn+Eh1DnOd
	 c3s0Ru109gzc6POndCJzXSLajNns60n365gQ9ZlnmKFiRqvBll2Y4ZZLiJnFCzXxsO
	 EHalN9k97N+AQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Talel Shenhar <talel@amazon.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: thermal: Convert amazon,al-thermal to DT schema
Date: Mon, 13 Oct 2025 16:58:18 -0500
Message-ID: <20251013215820.783272-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert amazon,al-thermal binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/thermal/amazon,al-thermal.txt    | 33 ------------
 .../bindings/thermal/amazon,al-thermal.yaml   | 50 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 51 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/amazon,al-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt b/Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
deleted file mode 100644
index 12fc4ef04837..000000000000
--- a/Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-Amazon's Annapurna Labs Thermal Sensor
-
-Simple thermal device that allows temperature reading by a single MMIO
-transaction.
-
-Required properties:
-- compatible: "amazon,al-thermal".
-- reg: The physical base address and length of the sensor's registers.
-- #thermal-sensor-cells: Must be 1. See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for a description.
-
-Example:
-	thermal: thermal {
-		compatible = "amazon,al-thermal";
-		reg = <0x0 0x05002860 0x0 0x1>;
-		#thermal-sensor-cells = <0x1>;
-	};
-
-	thermal-zones {
-		thermal-z0 {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-			thermal-sensors = <&thermal 0>;
-			trips {
-				critical {
-					temperature = <105000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-
-		};
-	};
-
diff --git a/Documentation/devicetree/bindings/thermal/amazon,al-thermal.yaml b/Documentation/devicetree/bindings/thermal/amazon,al-thermal.yaml
new file mode 100644
index 000000000000..6b5884d74dd6
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/amazon,al-thermal.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/amazon,al-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amazon Annapurna Labs Thermal Sensor
+
+maintainers:
+  - Talel Shenhar <talel@amazon.com>
+
+description:
+  Simple thermal device that allows temperature reading by a single MMIO
+  transaction.
+
+properties:
+  compatible:
+    items:
+      - const: amazon,al-thermal
+
+  reg:
+    maxItems: 1
+
+  '#thermal-sensor-cells':
+    const: 1
+
+additionalProperties: false
+
+examples:
+  - |
+    thermal: thermal@5002860 {
+        compatible = "amazon,al-thermal";
+        reg = <0x05002860 0x1>;
+        #thermal-sensor-cells = <0x1>;
+    };
+
+    thermal-zones {
+        z0-thermal {
+            polling-delay-passive = <250>;
+            polling-delay = <1000>;
+            thermal-sensors = <&thermal 0>;
+            trips {
+                critical {
+                    temperature = <105000>;
+                    hysteresis = <2000>;
+                    type = "critical";
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index e72a9e529625..866305dd1368 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -973,7 +973,7 @@ F:	drivers/edac/al_mc_edac.c
 AMAZON ANNAPURNA LABS THERMAL MMIO DRIVER
 M:	Talel Shenhar <talel@amazon.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
+F:	Documentation/devicetree/bindings/thermal/amazon,al-thermal.yaml
 F:	drivers/thermal/thermal_mmio.c
 
 AMAZON ETHERNET DRIVERS
-- 
2.51.0


