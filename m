Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802D42C5C4A
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 19:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405049AbgKZSy6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 13:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405027AbgKZSy5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 13:54:57 -0500
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EFDC0613D4;
        Thu, 26 Nov 2020 10:54:57 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id E775B4062F;
        Thu, 26 Nov 2020 19:46:36 +0100 (CET)
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
Subject: [PATCH 10/13] dt-bindings: soc: qcom: cpr3: Add bindings for CPR3 driver
Date:   Thu, 26 Nov 2020 19:45:56 +0100
Message-Id: <20201126184559.3052375-11-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126184559.3052375-1-angelogioacchino.delregno@somainline.org>
References: <20201126184559.3052375-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the bindings for the CPR3 driver to the documentation.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 .../bindings/soc/qcom/qcom,cpr3.yaml          | 226 ++++++++++++++++++
 1 file changed, 226 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
new file mode 100644
index 000000000000..58cd9a6e9bde
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
@@ -0,0 +1,226 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/qcom/qcom,cpr3.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Core Power Reduction v3/v4/Hardened (CPR3, CPR4, CPRh)
+
+description: |
+  CPR (Core Power Reduction) is a technology to reduce core power on a CPU
+  or other device. Each OPP of a device corresponds to a "corner" that has
+  a range of valid voltages for a particular frequency. While the device is
+  running at a particular frequency, CPR monitors dynamic factors such as
+  temperature, etc. and suggests or, in the CPR-Hardened case performs,
+  adjustments to the voltage to save power and meet silicon characteristic
+  requirements.
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,sdm630-cprh
+      - const: qcom,cpr3
+      - const: qcom,cpr4
+      - const: qcom,cprh
+
+  reg:
+    description: Base address and size of the CPR controller(s)
+    minItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-names:
+    - const: ref
+
+  clocks:
+    items:
+      - description: CPR reference clock
+
+  vdd-supply:
+    description: Autonomous Phase Control (APC) or other power supply
+
+  '#power-domain-cells':
+    const: 1
+
+  acc-syscon:
+    description: phandle to syscon for writing ACC settings
+
+  nvmem-cells:
+    minItems: 10
+    description: Cells containing the fuse corners and revision data
+
+  nvmem-cell-names:
+    minItems: 10
+
+  operating-points-v2: true
+
+required:
+  - compatible
+  - reg
+  - clock-names
+  - clocks
+  - "#power-domain-cells"
+  - nvmem-cells
+  - nvmem-cell-names
+  - operating-points-v2
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sdm660.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    cpus {
+        #address-cells = <2>;
+        #size-cells = <0>;
+
+        cpu@100 {
+            operating-points-v2 = <&cpu_gold_opp_table>;
+            power-domains = <&apc_cprh 0>;
+            power-domain-names = "cprh";
+        };
+
+        cpu@0 {
+            operating-points-v2 = <&cpu_silver_opp_table>;
+            power-domains = <&apc_cprh 1>;
+            power-domain-names = "cprh";
+        };
+    }
+
+    cpu_silver_opp_table: cpu-silver-opp-table {
+        compatible = "operating-points-v2";
+        opp-shared;
+
+        opp-1843200000 {
+            opp-hz = /bits/ 64 <1843200000>;
+            required-opps = <&cprh_opp3>;
+        };
+        opp-1094400000 {
+            opp-hz = /bits/ 64 <1094400000>;
+            required-opps = <&cprh_opp2>;
+        };
+        opp-300000000 {
+            opp-hz = /bits/ 64 <300000000>;
+            required-opps = <&cprh_opp1>;
+        };
+    };
+
+    cpu_gold_opp_table: cpu-gold-opp-table {
+        compatible = "operating-points-v2";
+        opp-shared;
+
+        opp-2208000000 {
+            opp-hz = /bits/ 64 <2208000000>;
+            required-opps = <&cprh_opp3>;
+        };
+        opp-1113600000 {
+            opp-hz = /bits/ 64 <1113600000>;
+            required-opps = <&cprh_opp2>;
+        };
+        opp-300000000 {
+            opp-hz = /bits/ 64 <300000000>;
+            required-opps = <&cprh_opp1>;
+        };
+    };
+
+    cprh_opp_table: cpr-hardened-opp-table {
+        compatible = "operating-points-v2-qcom-level";
+
+        cprh_opp1: opp1 {
+            opp-level = <1>;
+            qcom,opp-fuse-level = <1>;
+        };
+        cprh_opp2: opp2 {
+            opp-level = <2>;
+            qcom,opp-fuse-level = <2>;
+        };
+        cprh_opp3: opp3 {
+            opp-level = <3>;
+            qcom,opp-fuse-level = <2 3>;
+        };
+    }
+
+    apc_cprh: power-controller@179c4000 {
+        compatible = "qcom,sdm630-cprh", "qcom,cprh";
+        reg = <0x0179c4000 0x4000>, <0x0179c8000 0x4000>;
+        clocks = <&gcc GCC_HMSS_RBCPR_CLK>;
+        clock-names = "ref";
+        assigned-clocks = <&gcc GCC_HMSS_RBCPR_CLK>;
+        assigned-clock-rates = <19200000>;
+
+        #power-domain-cells = <1>;
+        operating-points-v2 = <&cprh_opp_table>;
+
+        nvmem-cells = <&cpr_efuse_speedbin>,
+                      <&cpr_fuse_revision>,
+                      <&cpr_quot00_perfcl>,
+                      <&cpr_quot01_perfcl>,
+                      <&cpr_quot02_perfcl>,
+                      <&cpr_quot03_perfcl>,
+                      <&cpr_quot04_perfcl>,
+                      <&cpr_quot_offset01_perfcl>,
+                      <&cpr_quot_offset02_perfcl>,
+                      <&cpr_quot_offset03_perfcl>,
+                      <&cpr_quot_offset04_perfcl>,
+                      <&cpr_init_voltage00_perfcl>,
+                      <&cpr_init_voltage01_perfcl>,
+                      <&cpr_init_voltage02_perfcl>,
+                      <&cpr_init_voltage03_perfcl>,
+                      <&cpr_init_voltage04_perfcl>,
+                      <&cpr_ro_sel00_perfcl>,
+                      <&cpr_ro_sel01_perfcl>,
+                      <&cpr_ro_sel02_perfcl>,
+                      <&cpr_ro_sel03_perfcl>,
+                      <&cpr_ro_sel04_perfcl>,
+                      <&cpr_quot00_pwrcl>,
+                      <&cpr_quot01_pwrcl>,
+                      <&cpr_quot02_pwrcl>,
+                      <&cpr_quot_offset01_pwrcl>,
+                      <&cpr_quot_offset02_pwrcl>,
+                      <&cpr_init_voltage00_pwrcl>,
+                      <&cpr_init_voltage01_pwrcl>,
+                      <&cpr_init_voltage02_pwrcl>,
+                      <&cpr_ro_sel00_pwrcl>,
+                      <&cpr_ro_sel01_pwrcl>,
+                      <&cpr_ro_sel02_pwrcl>;
+
+        nvmem-cell-names = "cpr_speed_bin",
+                           "cpr_fuse_revision",
+                           "cpr0_quotient1",
+                           "cpr0_quotient2",
+                           "cpr0_quotient3",
+                           "cpr0_quotient4",
+                           "cpr0_quotient5",
+                           "cpr0_quotient_offset2",
+                           "cpr0_quotient_offset3",
+                           "cpr0_quotient_offset4",
+                           "cpr0_quotient_offset5",
+                           "cpr0_init_voltage1",
+                           "cpr0_init_voltage2",
+                           "cpr0_init_voltage3",
+                           "cpr0_init_voltage4",
+                           "cpr0_init_voltage5",
+                           "cpr0_ring_osc1",
+                           "cpr0_ring_osc2",
+                           "cpr0_ring_osc3",
+                           "cpr0_ring_osc4",
+                           "cpr0_ring_osc5",
+                           "cpr1_quotient1",
+                           "cpr1_quotient2",
+                           "cpr1_quotient3",
+                           "cpr1_quotient_offset2",
+                           "cpr1_quotient_offset3",
+                           "cpr1_init_voltage1",
+                           "cpr1_init_voltage2",
+                           "cpr1_init_voltage3",
+                           "cpr1_ring_osc1",
+                           "cpr1_ring_osc2",
+                           "cpr1_ring_osc3";
+    };
+...
-- 
2.29.2

