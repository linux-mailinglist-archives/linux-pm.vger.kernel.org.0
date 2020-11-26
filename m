Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF192C5C3D
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 19:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405068AbgKZSy7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 13:54:59 -0500
Received: from relay07.th.seeweb.it ([5.144.164.168]:33483 "EHLO
        relay07.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405006AbgKZSy6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 13:54:58 -0500
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 53D6340635;
        Thu, 26 Nov 2020 19:46:37 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        jorge.ramirez-ortiz@linaro.org, broonie@kernel.org,
        lgirdwood@gmail.com, daniel.lezcano@linaro.org, nks@flawful.org,
        bjorn.andersson@linaro.org, agross@kernel.org, robh+dt@kernel.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net,
        konrad.dybcio@somainline.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org, phone-devel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH 11/13] dt-bindings: cpufreq: Convert qcom-cpufreq-hw to YAML binding
Date:   Thu, 26 Nov 2020 19:45:57 +0100
Message-Id: <20201126184559.3052375-12-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126184559.3052375-1-angelogioacchino.delregno@somainline.org>
References: <20201126184559.3052375-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the qcom-cpufreq-hw documentation to YAML binding as
qcom,cpufreq-hw.yaml.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 .../bindings/cpufreq/cpufreq-qcom-hw.txt      | 173 +---------------
 .../bindings/cpufreq/qcom,cpufreq-hw.yaml     | 196 ++++++++++++++++++
 2 files changed, 197 insertions(+), 172 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
index 9299028ee712..bd4e81f6f835 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
@@ -1,172 +1 @@
-Qualcomm Technologies, Inc. CPUFREQ Bindings
-
-CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
-SoCs to manage frequency in hardware. It is capable of controlling frequency
-for multiple clusters.
-
-Properties:
-- compatible
-	Usage:		required
-	Value type:	<string>
-	Definition:	must be "qcom,cpufreq-hw" or "qcom,cpufreq-epss".
-
-- clocks
-	Usage:		required
-	Value type:	<phandle> From common clock binding.
-	Definition:	clock handle for XO clock and GPLL0 clock.
-
-- clock-names
-	Usage:		required
-	Value type:	<string> From common clock binding.
-	Definition:	must be "xo", "alternate".
-
-- reg
-	Usage:		required
-	Value type:	<prop-encoded-array>
-	Definition:	Addresses and sizes for the memory of the HW bases in
-			each frequency domain.
-- reg-names
-	Usage:		Optional
-	Value type:	<string>
-	Definition:	Frequency domain name i.e.
-			"freq-domain0", "freq-domain1".
-
-- #freq-domain-cells:
-	Usage:		required.
-	Definition:	Number of cells in a freqency domain specifier.
-
-* Property qcom,freq-domain
-Devices supporting freq-domain must set their "qcom,freq-domain" property with
-phandle to a cpufreq_hw followed by the Domain ID(0/1) in the CPU DT node.
-
-
-Example:
-
-Example 1: Dual-cluster, Quad-core per cluster. CPUs within a cluster switch
-DCVS state together.
-
-/ {
-	cpus {
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		CPU0: cpu@0 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x0>;
-			enable-method = "psci";
-			next-level-cache = <&L2_0>;
-			qcom,freq-domain = <&cpufreq_hw 0>;
-			L2_0: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-				L3_0: l3-cache {
-				      compatible = "cache";
-				};
-			};
-		};
-
-		CPU1: cpu@100 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x100>;
-			enable-method = "psci";
-			next-level-cache = <&L2_100>;
-			qcom,freq-domain = <&cpufreq_hw 0>;
-			L2_100: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-			};
-		};
-
-		CPU2: cpu@200 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x200>;
-			enable-method = "psci";
-			next-level-cache = <&L2_200>;
-			qcom,freq-domain = <&cpufreq_hw 0>;
-			L2_200: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-			};
-		};
-
-		CPU3: cpu@300 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x300>;
-			enable-method = "psci";
-			next-level-cache = <&L2_300>;
-			qcom,freq-domain = <&cpufreq_hw 0>;
-			L2_300: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-			};
-		};
-
-		CPU4: cpu@400 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x400>;
-			enable-method = "psci";
-			next-level-cache = <&L2_400>;
-			qcom,freq-domain = <&cpufreq_hw 1>;
-			L2_400: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-			};
-		};
-
-		CPU5: cpu@500 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x500>;
-			enable-method = "psci";
-			next-level-cache = <&L2_500>;
-			qcom,freq-domain = <&cpufreq_hw 1>;
-			L2_500: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-			};
-		};
-
-		CPU6: cpu@600 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x600>;
-			enable-method = "psci";
-			next-level-cache = <&L2_600>;
-			qcom,freq-domain = <&cpufreq_hw 1>;
-			L2_600: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-			};
-		};
-
-		CPU7: cpu@700 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x700>;
-			enable-method = "psci";
-			next-level-cache = <&L2_700>;
-			qcom,freq-domain = <&cpufreq_hw 1>;
-			L2_700: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-			};
-		};
-	};
-
- soc {
-	cpufreq_hw: cpufreq@17d43000 {
-		compatible = "qcom,cpufreq-hw";
-		reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
-		reg-names = "freq-domain0", "freq-domain1";
-
-		clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
-		clock-names = "xo", "alternate";
-
-		#freq-domain-cells = <1>;
-	};
-}
+This file has been moved to qcom,cpufreq-hw.yaml
diff --git a/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml b/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml
new file mode 100644
index 000000000000..94a56317b14b
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml
@@ -0,0 +1,196 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/cpufreq/qcom,cpufreq-hw.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Technologies, Inc. CPUFREQ HW Bindings
+
+description: |
+  CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
+  SoCs to manage frequency in hardware. It is capable of controlling frequency
+  for multiple clusters.
+
+maintainers:
+  - TBD
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,cpufreq-hw
+          - qcom,cpufreq-hw-8998
+          - qcom,cpufreq-epss
+
+  reg:
+    minItems: 2
+    maxItems: 2
+
+  reg-names:
+    description:
+      Frequency domain register region for each domain.
+    items:
+      - const: "freq-domain0"
+      - const: "freq-domain1"
+
+  clock-names:
+    - const: xo
+    - const: ref
+
+  clocks:
+    maxItems: 2
+
+  '#freq-domain-cells':
+    description: Number of cells in a freqency domain specifier.
+    const: 1
+
+  operating-points-v2: true
+
+  qcom,freq-domain:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: |
+      Devices supporting freq-domain must set their "qcom,freq-domain"
+      property with phandle to a cpufreq_hw followed by the Domain ID(0/1)
+      in the CPU DT node.
+
+required:
+  - compatible
+  - reg
+  - clock-names
+  - clocks
+  - "#freq-domain-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    // Example 1: Dual-cluster, Quad-core per cluster. CPUs within a
+    //            cluster switch DCVS state together.
+
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
+
+    cpus {
+        #address-cells = <2>;
+        #size-cells = <0>;
+
+        CPU0: cpu@0 {
+            device_type = "cpu";
+            compatible = "qcom,kryo385";
+            reg = <0x0 0x0>;
+            enable-method = "psci";
+            next-level-cache = <&L2_0>;
+            qcom,freq-domain = <&cpufreq_hw 0>;
+            L2_0: l2-cache {
+                compatible = "cache";
+                next-level-cache = <&L3_0>;
+                L3_0: l3-cache {
+                      compatible = "cache";
+                };
+            };
+        };
+
+        CPU1: cpu@100 {
+            device_type = "cpu";
+            compatible = "qcom,kryo385";
+            reg = <0x0 0x100>;
+            enable-method = "psci";
+            next-level-cache = <&L2_100>;
+            qcom,freq-domain = <&cpufreq_hw 0>;
+            L2_100: l2-cache {
+                compatible = "cache";
+                next-level-cache = <&L3_0>;
+            };
+        };
+
+        CPU2: cpu@200 {
+            device_type = "cpu";
+            compatible = "qcom,kryo385";
+            reg = <0x0 0x200>;
+            enable-method = "psci";
+            next-level-cache = <&L2_200>;
+            qcom,freq-domain = <&cpufreq_hw 0>;
+            L2_200: l2-cache {
+                compatible = "cache";
+                next-level-cache = <&L3_0>;
+            };
+        };
+
+        CPU3: cpu@300 {
+            device_type = "cpu";
+            compatible = "qcom,kryo385";
+            reg = <0x0 0x300>;
+            enable-method = "psci";
+            next-level-cache = <&L2_300>;
+            qcom,freq-domain = <&cpufreq_hw 0>;
+            L2_300: l2-cache {
+                compatible = "cache";
+                next-level-cache = <&L3_0>;
+            };
+        };
+
+        CPU4: cpu@400 {
+            device_type = "cpu";
+            compatible = "qcom,kryo385";
+            reg = <0x0 0x400>;
+            enable-method = "psci";
+            next-level-cache = <&L2_400>;
+            qcom,freq-domain = <&cpufreq_hw 1>;
+            L2_400: l2-cache {
+                compatible = "cache";
+                next-level-cache = <&L3_0>;
+            };
+        };
+
+        CPU5: cpu@500 {
+            device_type = "cpu";
+            compatible = "qcom,kryo385";
+            reg = <0x0 0x500>;
+            enable-method = "psci";
+            next-level-cache = <&L2_500>;
+            qcom,freq-domain = <&cpufreq_hw 1>;
+            L2_500: l2-cache {
+                compatible = "cache";
+                next-level-cache = <&L3_0>;
+            };
+        };
+
+        CPU6: cpu@600 {
+            device_type = "cpu";
+            compatible = "qcom,kryo385";
+            reg = <0x0 0x600>;
+            enable-method = "psci";
+            next-level-cache = <&L2_600>;
+            qcom,freq-domain = <&cpufreq_hw 1>;
+            L2_600: l2-cache {
+                compatible = "cache";
+                next-level-cache = <&L3_0>;
+            };
+        };
+
+        CPU7: cpu@700 {
+            device_type = "cpu";
+            compatible = "qcom,kryo385";
+            reg = <0x0 0x700>;
+            enable-method = "psci";
+            next-level-cache = <&L2_700>;
+            qcom,freq-domain = <&cpufreq_hw 1>;
+            L2_700: l2-cache {
+                compatible = "cache";
+                next-level-cache = <&L3_0>;
+            };
+        };
+    };
+
+    soc {
+        cpufreq_hw: cpufreq@17d43000 {
+            compatible = "qcom,cpufreq-hw";
+            reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
+            reg-names = "freq-domain0", "freq-domain1";
+
+            clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+            clock-names = "xo", "alternate";
+
+            #freq-domain-cells = <1>;
+    };
+...
-- 
2.29.2

