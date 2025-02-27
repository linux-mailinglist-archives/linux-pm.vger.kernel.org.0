Return-Path: <linux-pm+bounces-23065-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E03A47DA0
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 13:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897E23A2EED
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 12:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0645522E3EC;
	Thu, 27 Feb 2025 12:25:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD5E22B581;
	Thu, 27 Feb 2025 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659130; cv=none; b=ieEsrD4lA5hMWyXm6UHGCD4odAy1TquWiF7MFWNK94mJ11cF7pR1s77F0xylsryUKl7IsuO1kQWtQaVlv0prifbPsBW5Tgq2eBKFojeJ2TkMIvPJnoyVhF2ZpAt4oRuZ5ZaiTFZeT75QX/PbV8NXKVZAhO1f4WbQcFRzcC3cDJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659130; c=relaxed/simple;
	bh=K08SbxcE4m1TxMr02BO5H3v9ElxL/XARHtXFx1lyTxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbyubz1a7lWaRbw/OXd0I2Ygb85f4c0Lh8wECY5rhjxjGCKTSqexXU8sCQZctjCMyw3osq5otzRMKV1detF6fYLfpexQW67B++O7E1hSOpAb2UocvT39D2IlG2y9ZdmDMtVWB3qSUKp2zxt7hX4cv8VFbL5+7nrGv3bQnIzjcgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: RG252z/3SoibSevHGW7hiw==
X-CSE-MsgGUID: VrzK82oZROymALWu3JMMtg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 27 Feb 2025 21:25:27 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.68])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CF66C4004CF4;
	Thu, 27 Feb 2025 21:25:19 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: john.madieu.xa@bp.renesas.com,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: john.madieu@gmail.com,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	biju.das.jz@bp.renesas.com
Subject: [PATCH v2 3/7] dt-bindings: thermal: r9a09g047-tsu: Document the TSU unit
Date: Thu, 27 Feb 2025 13:24:39 +0100
Message-ID: <20250227122453.30480-4-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227122453.30480-1-john.madieu.xa@bp.renesas.com>
References: <20250227122453.30480-1-john.madieu.xa@bp.renesas.com>
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

 .../thermal/renesas,r9a09g047-tsu.yaml        | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml

diff --git a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
new file mode 100644
index 000000000000..e786561ddbe3
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
@@ -0,0 +1,123 @@
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
+  renesas,tsu-operating-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description: |
+      TSU operating mode:
+      0: Mode 0 - Conversion started by software
+      1: Mode 1 - Conversion started by ELC trigger
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
+  - renesas,tsu-operating-mode
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
+        renesas,tsu-operating-mode = <0>;
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


