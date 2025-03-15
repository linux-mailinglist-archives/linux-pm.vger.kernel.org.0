Return-Path: <linux-pm+bounces-24090-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C43EA628E1
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 09:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2BE3BCD94
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 08:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0631F1818;
	Sat, 15 Mar 2025 08:17:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200D01EF0B4;
	Sat, 15 Mar 2025 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742026669; cv=none; b=W+ly7EHprfmCQxV7aIBoDKQp4+FnRsKOQyTPvuBGJONWAw39o9FLvOxXzMLLFHIYh0mGrU7FSb9zy07wNzYATcBpE+PwqzbPJK/d0uOztxcrqeHfTbih+dpkhIbAZf0WT0+arTgipZRtETrQvZyFGzom5/pPAIRBu3fN7LMQYB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742026669; c=relaxed/simple;
	bh=aypuAsf8AVVJUw4BnRKla4KADrAf34nBoz0sSRBjTik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foJhIzqGQsEuwpTfBR5HP4bSy43C+kPa+IKT76W68NqUU14iLtWDvJOFi0Ps6A7q/c7La3c69SQ1WhEtNz87L10PA2Dz5VTz/vLaIThB/XtdJ/RgvoX3mDg7mC4v4pnzbzkQLSVko9/e6wRGbMuotIYtqVYMf6wP6lItO4x4EQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: IKCSRS0mTamNy3UlhnwbqQ==
X-CSE-MsgGUID: htoSzWasQxuJedpiFLW9Lg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 15 Mar 2025 17:12:44 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.58])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 86D5241BFA40;
	Sat, 15 Mar 2025 17:12:39 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: geert+renesas@glider.be,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: magnus.damm@gmail.com,
	devicetree@vger.kernel.org,
	john.madieu@gmail.com,
	rui.zhang@intel.com,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	sboyd@kernel.org,
	biju.das.jz@bp.renesas.com,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH v3 2/6] dt-bindings: thermal: r9a09g047-tsu: Document the TSU unit
Date: Sat, 15 Mar 2025 09:12:12 +0100
Message-ID: <20250315081225.92118-3-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315081225.92118-1-john.madieu.xa@bp.renesas.com>
References: <20250315081225.92118-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/G3E SoC includes a Thermal Sensor Unit (TSU) block designed
to measure the junction temperature. The device provides real-time temperature
measurements for thermal management, utilizing a single dedicated channel
(channel 1) for temperature sensing.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
v1 -> v2:
 * Fix reg property specifier to get rid of yamlint warnings
 * Fix IRQ name to reflect TSU expectations

v2 -> v3:
 * Remove useless 'renesas,tsu-operating-mode' property 
 
 .../thermal/renesas,r9a09g047-tsu.yaml        | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml

diff --git a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
new file mode 100644
index 000000000000..46f0646d1c4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
@@ -0,0 +1,113 @@
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
+    description: |
+      Interrupt specifiers for the TSU:
+      - S12TSUADI1: Conversion complete interrupt signal (pulse)
+      - S12TSUADCMPI1: Comparison result interrupt signal (level)
+
+  interrupt-names:
+    items:
+      - const: adi
+      - const: adcmpi
+
+  "#thermal-sensor-cells":
+    const: 0
+
+  renesas,tsu-calibration-sys:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Phandle to the system controller (sys) that contains the TSU
+      calibration values used for temperature calculations.
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
+  - renesas,tsu-calibration-sys
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/renesas,r9a09g047-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    tsu: thermal@14002000 {
+        compatible = "renesas,r9a09g047-tsu";
+        reg = <0x14002000 0x1000>;
+        clocks = <&cpg CPG_MOD 0x10a>;
+        resets = <&cpg 0xf8>;
+        power-domains = <&cpg>;
+        interrupts = <GIC_SPI 250 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "adi", "adcmpi";
+        #thermal-sensor-cells = <0>;
+        renesas,tsu-calibration-sys = <&sys>;
+    };
+
+    thermal-zones {
+        cpu-thermal {
+            polling-delay = <1000>;
+            polling-delay-passive = <250>;
+            thermal-sensors = <&tsu>;
+
+            cooling-maps {
+                map0 {
+                    trip = <&target>;
+                    cooling-device = <&cpu0 0 3>, <&cpu1 0 3>,
+                                     <&cpu2 0 3>, <&cpu3 0 3>;
+                    contribution = <1024>;
+                };
+            };
+
+            trips {
+                target: trip-point {
+                    temperature = <95000>;
+                    hysteresis = <1000>;
+                    type = "passive";
+                };
+
+                sensor_crit: sensor-crit {
+                    temperature = <120000>;
+                    hysteresis = <1000>;
+                    type = "critical";
+                };
+            };
+        };
+    };
-- 
2.25.1


