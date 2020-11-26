Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0942C5C3B
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 19:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405038AbgKZSzO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 13:55:14 -0500
Received: from relay07.th.seeweb.it ([5.144.164.168]:42291 "EHLO
        relay07.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405033AbgKZSy7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 13:54:59 -0500
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 2B91D4063F;
        Thu, 26 Nov 2020 19:46:38 +0100 (CET)
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
Subject: [PATCH 13/13] dt-bindings: cpufreq: qcom-hw: Add bindings for 8998
Date:   Thu, 26 Nov 2020 19:45:59 +0100
Message-Id: <20201126184559.3052375-14-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126184559.3052375-1-angelogioacchino.delregno@somainline.org>
References: <20201126184559.3052375-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The OSM programming addition has been done under the
qcom,cpufreq-hw-8998 compatible name: specify the requirement
of two additional register spaces for this functionality.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 .../bindings/cpufreq/qcom,cpufreq-hw.yaml     | 31 ++++++++++++++++---
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml b/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml
index 94a56317b14b..f64cea73037e 100644
--- a/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml
@@ -23,17 +23,21 @@ properties:
           - qcom,cpufreq-epss
 
   reg:
+    description: Base address and size of the RBCPR register region
     minItems: 2
     maxItems: 2
 
   reg-names:
     description:
-      Frequency domain register region for each domain.
-    items:
-      - const: "freq-domain0"
-      - const: "freq-domain1"
+      Frequency domain register region for each domain. If OSM programming
+      does not happen in the bootloader and has to be done in this driver,
+      then also the OSM domain region osm-domain[0-1] has to be provided.
+    minItems: 2
+    maxItems: 2
 
   clock-names:
+    minItems: 2
+    maxItems: 2
     - const: xo
     - const: ref
 
@@ -53,9 +57,28 @@ properties:
       property with phandle to a cpufreq_hw followed by the Domain ID(0/1)
       in the CPU DT node.
 
+allOf:
+ - if:
+     properties:
+       reg-names:
+         contains:
+           const: qcom,cpufreq-hw-8998
+   then:
+     properties:
+       reg:
+         minItems: 4
+         maxItems: 4
+       reg-names:
+         items:
+           - const: "freq-domain0"
+           - const: "freq-domain1"
+           - const: "osm-domain0"
+           - const: "osm-domain1"
+
 required:
   - compatible
   - reg
+  - reg-names
   - clock-names
   - clocks
   - "#freq-domain-cells"
-- 
2.29.2

