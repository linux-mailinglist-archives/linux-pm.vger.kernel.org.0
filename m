Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E691249E73
	for <lists+linux-pm@lfdr.de>; Wed, 19 Aug 2020 14:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgHSMpR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Aug 2020 08:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbgHSMoy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2020 08:44:54 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA25C061342
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2020 05:44:53 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id HQks230014C55Sk06QksPS; Wed, 19 Aug 2020 14:44:52 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NSV-0002NE-US; Wed, 19 Aug 2020 14:44:51 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1k8NSV-0005FI-SE; Wed, 19 Aug 2020 14:44:51 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] dt-bindings: thermal: rcar-thermal: Improve schema validation
Date:   Wed, 19 Aug 2020 14:44:50 +0200
Message-Id: <20200819124450.20123-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

  - Document missing "#thermal-sensor-cells",
  - Factor out common required properties,
  - "interrupts", "clocks", and "power-domains" are required on R-Mobile
    APE6, too,
  - Invert logic to simplify descriptions,
  - Add "additionalProperties: false".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v2:
  - Add Reviewed-by.
---
 .../bindings/thermal/rcar-thermal.yaml        | 53 ++++++++++++-------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml b/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
index 0994693d240f9ff4..88787b98992fe7c9 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
@@ -59,25 +59,40 @@ properties:
   resets:
     maxItems: 1
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - renesas,thermal-r8a73a4 # R-Mobile APE6
-          - renesas,thermal-r8a7779 # R-Car H1
-then:
-  required:
-    - compatible
-    - reg
-else:
-  required:
-    - compatible
-    - reg
-    - interrupts
-    - clocks
-    - power-domains
-    - resets
+  '#thermal-sensor-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - renesas,thermal-r8a73a4 # R-Mobile APE6
+                - renesas,thermal-r8a7779 # R-Car H1
+    then:
+      required:
+        - resets
+        - '#thermal-sensor-cells'
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: renesas,thermal-r8a7779 # R-Car H1
+    then:
+      required:
+        - interrupts
+        - clocks
+        - power-domains
+
+additionalProperties: false
 
 examples:
   # Example (non interrupt support)
-- 
2.17.1

