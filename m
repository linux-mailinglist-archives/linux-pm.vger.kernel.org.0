Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF882F38BA
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 19:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405483AbhALSXm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 13:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406564AbhALSXV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 13:23:21 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AEBC0617A4
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 10:22:25 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id A4FC33EEEB;
        Tue, 12 Jan 2021 19:21:03 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, nks@flawful.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, manivannan.sadhasivam@linaro.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v3 15/15] dt-bindings: cpufreq: qcom-hw: Add bindings for 8998
Date:   Tue, 12 Jan 2021 19:20:52 +0100
Message-Id: <20210112182052.481888-16-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112182052.481888-1-angelogioacchino.delregno@somainline.org>
References: <20210112182052.481888-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The OSM programming addition has been done under the
qcom,cpufreq-hw-8998 compatible name: specify the requirement
of two additional register spaces for this functionality.
This implementation, with the same compatible, has been
tested on MSM8998 and SDM630.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 66 +++++++++++++++----
 1 file changed, 52 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index bc81b6203e27..17fd6a6cefb0 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -18,6 +18,10 @@ description: |
 properties:
   compatible:
     oneOf:
+      - description: Non-secure v1 of CPUFREQ HW
+        items:
+          - const: qcom,cpufreq-hw-8998
+
       - description: v1 of CPUFREQ HW
         items:
           - const: qcom,cpufreq-hw
@@ -28,21 +32,9 @@ properties:
               - qcom,sm8250-cpufreq-epss
           - const: qcom,cpufreq-epss
 
-  reg:
-    minItems: 2
-    maxItems: 3
-    items:
-      - description: Frequency domain 0 register region
-      - description: Frequency domain 1 register region
-      - description: Frequency domain 2 register region
+  reg: {}
 
-  reg-names:
-    minItems: 2
-    maxItems: 3
-    items:
-      - const: freq-domain0
-      - const: freq-domain1
-      - const: freq-domain2
+  reg-names: {}
 
   clocks:
     items:
@@ -57,6 +49,52 @@ properties:
   '#freq-domain-cells':
     const: 1
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: qcom,cpufreq-hw-8998
+then:
+  properties:
+    reg:
+      minItems: 2
+      maxItems: 6
+      items:
+        - description: Frequency domain 0 register region
+        - description: Operating State Manager domain 0 register region
+        - description: Frequency domain 1 register region
+        - description: Operating State Manager domain 1 register region
+        - description: PLL ACD domain 0 register region (if ACD programming required)
+        - description: PLL ACD domain 1 register region (if ACD programming required)
+
+    reg-names:
+      minItems: 2
+      maxItems: 6
+      items:
+        - const: "osm-domain0"
+        - const: "freq-domain0"
+        - const: "osm-domain1"
+        - const: "freq-domain1"
+        - const: "osm-acd0"
+        - const: "osm-acd1"
+
+else:
+  properties:
+    reg:
+      minItems: 2
+      maxItems: 3
+      items:
+        - description: Frequency domain 0 register region
+        - description: Frequency domain 1 register region
+        - description: Frequency domain 2 register region
+    reg-names:
+      minItems: 2
+      maxItems: 3
+      items:
+        - const: "freq-domain0"
+        - const: "freq-domain1"
+        - const: "freq-domain2"
+
 required:
   - compatible
   - reg
-- 
2.29.2

