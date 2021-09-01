Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30773FDF1C
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 17:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343837AbhIAP5H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 11:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245022AbhIAP5H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 11:57:07 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA35C061575;
        Wed,  1 Sep 2021 08:56:10 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 574061FAF9;
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
Subject: [PATCH 1/2] dt-bindings: opp: qcom-opp: Convert to DT schema
Date:   Wed,  1 Sep 2021 17:55:58 +0200
Message-Id: <20210901155559.627491-1-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rewrite the qcom-opp as qcom-level-opp in dt schema format.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 .../bindings/opp/qcom-level-opp.yaml          | 68 +++++++++++++++++++
 .../devicetree/bindings/opp/qcom-opp.txt      | 19 ------
 2 files changed, 68 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/opp/qcom-level-opp.yaml
 delete mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt

diff --git a/Documentation/devicetree/bindings/opp/qcom-level-opp.yaml b/Documentation/devicetree/bindings/opp/qcom-level-opp.yaml
new file mode 100644
index 000000000000..65dd2d5d9566
--- /dev/null
+++ b/Documentation/devicetree/bindings/opp/qcom-level-opp.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/opp/qcom-level-opp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm OPP bindings for fuse and voltage level OPPs
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
+  - Niklas Cassel <niklas.cassel@linaro.org>
+
+allOf:
+  - $ref: opp-v2-base.yaml#
+
+properties:
+  compatible:
+    const: operating-points-v2-qcom-level
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
+      opp-level: true
+      qcom,opp-fuse-level:
+        description:
+          At least one positive value representing the fuse corner or level
+          associated with this OPP node. In case this is used for CPR >=v3,
+          multiple array entries are referring to different CPR threads.
+          Sometimes several corners/levels shares a certain fuse
+          corner/level. A fuse corner/level contains e.g. ref uV, min uV,
+          and max uV.
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+
+    required:
+      - opp-level
+      - qcom,opp-fuse-level
+
+    unevaluatedProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    cpr_opp_table: opp-table-cpr {
+        compatible = "operating-points-v2-qcom-level";
+
+        cpr_opp1: opp1 {
+            opp-level = <1>;
+            qcom,opp-fuse-level = <1>;
+        };
+        cpr_opp2: opp2 {
+            opp-level = <2>;
+            qcom,opp-fuse-level = <2>;
+        };
+        cpr_opp3: opp3 {
+            opp-level = <3>;
+            qcom,opp-fuse-level = <3>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/opp/qcom-opp.txt b/Documentation/devicetree/bindings/opp/qcom-opp.txt
deleted file mode 100644
index 41d3e4ff2dc3..000000000000
--- a/Documentation/devicetree/bindings/opp/qcom-opp.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-Qualcomm OPP bindings to describe OPP nodes
-
-The bindings are based on top of the operating-points-v2 bindings
-described in Documentation/devicetree/bindings/opp/opp-v2-base.yaml
-Additional properties are described below.
-
-* OPP Table Node
-
-Required properties:
-- compatible: Allow OPPs to express their compatibility. It should be:
-  "operating-points-v2-qcom-level"
-
-* OPP Node
-
-Required properties:
-- qcom,opp-fuse-level: A positive value representing the fuse corner/level
-  associated with this OPP node. Sometimes several corners/levels shares
-  a certain fuse corner/level. A fuse corner/level contains e.g. ref uV,
-  min uV, and max uV.
-- 
2.32.0

