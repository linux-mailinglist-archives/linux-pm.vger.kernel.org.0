Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5005E458026
	for <lists+linux-pm@lfdr.de>; Sat, 20 Nov 2021 20:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhKTTu0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Nov 2021 14:50:26 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:5237 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229488AbhKTTu0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Nov 2021 14:50:26 -0500
X-IronPort-AV: E=Sophos;i="5.87,251,1631545200"; 
   d="scan'208";a="100913346"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Nov 2021 04:47:21 +0900
Received: from localhost.localdomain (unknown [10.226.92.12])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4B33740E1DB4;
        Sun, 21 Nov 2021 04:47:18 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: thermal: Document Renesas RZ/G2L TSU
Date:   Sat, 20 Nov 2021 19:47:10 +0000
Message-Id: <20211120194711.9073-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211120194711.9073-1-biju.das.jz@bp.renesas.com>
References: <20211120194711.9073-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document the Thermal Sensor Unit(TSU) in the RZ/G2L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
 * No change
---
 .../bindings/thermal/rzg2l-thermal.yaml       | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml b/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
new file mode 100644
index 000000000000..ccab9511a042
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/rzg2l-thermal.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/rzg2l-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L Thermal Sensor Unit
+
+description:
+  On RZ/G2L SoCs, the thermal sensor unit (TSU) measures the
+  temperature(Tj) inside the LSI.
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a07g044-tsu # RZ/G2{L,LC}
+      - const: renesas,rzg2l-tsu
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - power-domains
+  - resets
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+
+    tsu: thermal@10059400 {
+            compatible = "renesas,r9a07g044-tsu",
+                         "renesas,rzg2l-tsu";
+            reg = <0x10059400 0x400>;
+            clocks = <&cpg CPG_MOD R9A07G044_TSU_PCLK>;
+            resets = <&cpg R9A07G044_TSU_PRESETN>;
+            power-domains = <&cpg>;
+            #thermal-sensor-cells = <1>;
+    };
+
+    thermal-zones {
+            cpu-thermal {
+                    polling-delay-passive = <250>;
+                    polling-delay = <1000>;
+                    thermal-sensors = <&tsu 0>;
+
+                    trips {
+                            sensor_crit: sensor-crit {
+                                    temperature = <125000>;
+                                    hysteresis = <1000>;
+                                    type = "critical";
+                            };
+                    };
+            };
+    };
-- 
2.17.1

