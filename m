Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D6429DC03
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 01:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbgJ2AS7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 20:18:59 -0400
Received: from newton.telenet-ops.be ([195.130.132.45]:33722 "EHLO
        newton.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731804AbgJ1WpU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:45:20 -0400
X-Greylist: delayed 4199 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Oct 2020 18:45:19 EDT
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by newton.telenet-ops.be (Postfix) with ESMTPS id 4CLt293WF3zMqtjD
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 16:35:45 +0100 (CET)
Received: from ramsan.of.borg ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id lTbj2300a4C55Sk01Tbj7o; Wed, 28 Oct 2020 16:35:45 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kXnUF-000pP4-F7; Wed, 28 Oct 2020 16:35:43 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kXnUF-007HhG-1D; Wed, 28 Oct 2020 16:35:43 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3] dt-bindings: thermal: rcar-thermal: Improve schema validation
Date:   Wed, 28 Oct 2020 16:35:41 +0100
Message-Id: <20201028153541.1736279-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

  - Factor out common required properties,
  - "interrupts", "clocks", and "power-domains" are required on R-Mobile
    APE6, too,
  - Invert logic to simplify descriptions.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas Söderlund <niklas.soderlund@ragnatech.se>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v3:
  - Rebase on top of commit 5be478f9c24fbdf8 ("dt-bindings: Another
    round of adding missing 'additionalProperties'"),

v2:
  - Add Reviewed-by.
---
 .../bindings/thermal/rcar-thermal.yaml        | 48 +++++++++++--------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml b/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
index 7e9557ac0e4a011c..927de79ab4b56e37 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
@@ -62,25 +62,35 @@ properties:
   "#thermal-sensor-cells":
     const: 0
 
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
 
 additionalProperties: false
 
-- 
2.25.1

