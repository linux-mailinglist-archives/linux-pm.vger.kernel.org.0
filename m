Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4EF3FDF22
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 17:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343905AbhIAP5I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 11:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343834AbhIAP5H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 11:57:07 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84318C061760;
        Wed,  1 Sep 2021 08:56:10 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id C388E200CF;
        Wed,  1 Sep 2021 17:56:08 +0200 (CEST)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, sboyd@kernel.org, vireshk@kernel.org,
        agross@kernel.org, nm@ti.com, ilia.lin@kernel.org,
        niklas.cassel@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH 2/2] dt-bindings: opp: Add binding for qcom-cpu-opp
Date:   Wed,  1 Sep 2021 17:55:59 +0200
Message-Id: <20210901155559.627491-2-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210901155559.627491-1-angelogioacchino.delregno@somainline.org>
References: <20210901155559.627491-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds a binding documenting operating-points-v2-kryo-cpu in a
qcom-cpu-opp.yaml file. Logic is to add any new Qualcomm SoCs CPU
related OPP compatibles in here.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 .../devicetree/bindings/opp/qcom-cpu-opp.yaml | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/qcom-cpu-opp.yaml

diff --git a/Documentation/devicetree/bindings/opp/qcom-cpu-opp.yaml b/Documentation/devicetree/bindings/opp/qcom-cpu-opp.yaml
new file mode 100644
index 000000000000..b4d83b64228c
--- /dev/null
+++ b/Documentation/devicetree/bindings/opp/qcom-cpu-opp.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/opp/qcom-cpu-opp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. CPU OPP bindings
+
+maintainers:
+  - Ilia Lin <ilia.lin@kernel.org>
+
+allOf:
+  - $ref: opp-v2-base.yaml#
+
+properties:
+  compatible:
+    const: operating-points-v2-kryo-cpu
+
+  nvmem-cells:
+    description: |
+      A phandle pointing to a nvmem-cells node representing the efuse
+      registers that has information about the speedbin that is used
+      to select the right frequency/voltage value pair.
+    maxItems: 1
+
+  opp-shared: true
+
+required:
+  - compatible
+
+patternProperties:
+  '^opp-?[0-9]+$':
+    type: object
+
+    properties:
+      clock-latency-ns: true
+      opp-hz: true
+      opp-microvolt: true
+      opp-supported-hw: true
+      required-opps: true
+
+    required:
+      - opp-hz
+
+    unevaluatedProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    cpu_opp_table: opp-table-cpu {
+        compatible = "operating-points-v2-kryo-cpu";
+        opp-shared;
+
+        opp-1094400000 {
+            opp-hz = /bits/ 64 <1094400000>;
+            required-opps = <&cpr_opp1>;
+        };
+        opp-1248000000 {
+            opp-hz = /bits/ 64 <1248000000>;
+            required-opps = <&cpr_opp2>;
+        };
+        opp-1401600000 {
+            opp-hz = /bits/ 64 <1401600000>;
+            required-opps = <&cpr_opp3>;
+        };
+    };
+...
-- 
2.32.0

