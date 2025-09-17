Return-Path: <linux-pm+bounces-34901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EC3B811AA
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 19:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9DA4A4789
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 17:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F372FC865;
	Wed, 17 Sep 2025 17:02:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF532F7AD8;
	Wed, 17 Sep 2025 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758128565; cv=none; b=E6fIUY50bw4cxcpb9RNYLWGKFYMQzAg9DJopsR3Omf2Cn1syTyhYP/cJxU8hhTAnZdZ3CXcHdMpZ89++uuZ6NHtkpXyYvkXOu+D6YFCyqRsxT2S+8sV4FyvCKomHp1qi7kdo63brMbKZiTnsqrCljBh9MXqB/VjotFdhMt3S8mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758128565; c=relaxed/simple;
	bh=1SGx0xIwlaa8m7ATinq4XIghhs+hVzTe4HlcKqIhlgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxWNqU47+NZT4AGeAtSBkx06HJsDUf4tO2rhPlxPnpxMSoZEPVDEfpBzrO8nysHIT1FkfLOZ1q/JF+LmuODpOSPtWhnDlWVtkWUc4HUO7zUzZzDOWP1dyUL9poAnfFkSzl5o+jejH0cPe0chGO25tT+qHFoSxIeQKXMCxY1ma9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: eyWncZA4RLiDJjAMgMijAw==
X-CSE-MsgGUID: 1Rhq3pxARFGjXwNTYTkTpQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 18 Sep 2025 02:02:41 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.24.0.45])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CD9D14009A35;
	Thu, 18 Sep 2025 02:02:35 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: conor+dt@kernel.org,
	daniel.lezcano@linaro.org,
	geert+renesas@glider.be,
	krzk+dt@kernel.org,
	lukasz.luba@arm.com,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	robh@kernel.org,
	rui.zhang@intel.com,
	sboyd@kernel.org,
	will@kernel.org
Cc: biju.das.jz@bp.renesas.com,
	catalin.marinas@arm.com,
	devicetree@vger.kernel.org,
	john.madieu@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	p.zabel@pengutronix.de,
	rafael@kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH v9 1/4] dt-bindings: thermal: r9a09g047-tsu: Document the TSU unit
Date: Wed, 17 Sep 2025 19:01:55 +0200
Message-ID: <20250917170202.197929-2-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917170202.197929-1-john.madieu.xa@bp.renesas.com>
References: <20250917170202.197929-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/G3E SoC includes a Thermal Sensor Unit (TSU) block designed
to measure the junction temperature. The device provides real-time
temperature measurements for thermal management, utilizing a single
dedicated channel (channel 1) for temperature sensing.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v1 -> v2:
 * Fixes reg property specifier to get rid of yamlint warnings
 * Fixes IRQ name to reflect TSU expectations

v2 -> v3:
 * Removees useless 'renesas,tsu-operating-mode' property 

v3 -> v4:
 * Fixes commit message
 * Fixes interrupt description
 * Removes trip point definition

v5: no changes
v6: no changes
v7: Adds documentation for 'renesas,tsu-trim' and removes Rb tag from Krzysztof
    due to this change

v8: Address Rob's comments (about node naming and line wrapping) and collect
    Rb tag

v9: No changes

 .../thermal/renesas,r9a09g047-tsu.yaml        | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml

diff --git a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
new file mode 100644
index 000000000000..8d3f3c24f0f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/renesas,r9a09g047-tsu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G3E Temperature Sensor Unit (TSU)
+
+maintainers:
+  - John Madieu <john.madieu.xa@bp.renesas.com>
+
+description:
+  The Temperature Sensor Unit (TSU) is an integrated thermal sensor that
+  monitors the chip temperature on the Renesas RZ/G3E SoC. The TSU provides
+  real-time temperature measurements for thermal management.
+
+properties:
+  compatible:
+    const: renesas,r9a09g047-tsu
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Conversion complete interrupt signal (pulse)
+      - description: Comparison result interrupt signal (level)
+
+  interrupt-names:
+    items:
+      - const: adi
+      - const: adcmpi
+
+  "#thermal-sensor-cells":
+    const: 0
+
+  renesas,tsu-trim:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to system controller
+          - description: offset of trim registers
+    description:
+      Phandle and offset to the system controller containing the TSU
+      calibration trim values. The offset points to the first trim register
+      (OTPTSU1TRMVAL0), with the second trim register (OTPTSU1TRMVAL1) located
+      at offset + 4.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - power-domains
+  - interrupts
+  - interrupt-names
+  - "#thermal-sensor-cells"
+  - renesas,tsu-trim
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/renesas,r9a09g047-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    thermal-sensor@14002000 {
+        compatible = "renesas,r9a09g047-tsu";
+        reg = <0x14002000 0x1000>;
+        clocks = <&cpg CPG_MOD 0x10a>;
+        resets = <&cpg 0xf8>;
+        power-domains = <&cpg>;
+        interrupts = <GIC_SPI 250 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "adi", "adcmpi";
+        #thermal-sensor-cells = <0>;
+        renesas,tsu-trim = <&sys 0x330>;
+    };
-- 
2.25.1


