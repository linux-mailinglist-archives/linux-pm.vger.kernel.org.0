Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E537E333B10
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 12:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhCJLIo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 06:08:44 -0500
Received: from vsp-unauthed02.binero.net ([195.74.38.227]:32907 "EHLO
        vsp-unauthed02.binero.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhCJLIQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 06:08:16 -0500
X-Halon-ID: e06a4c7c-8190-11eb-b73f-0050569116f7
Authorized-sender: niklas.soderlund@fsdn.se
Received: from bismarck.berto.se (p54ac5521.dip0.t-ipconnect.de [84.172.85.33])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPA
        id e06a4c7c-8190-11eb-b73f-0050569116f7;
        Wed, 10 Mar 2021 12:08:15 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2] dt-bindings: thermal: rcar-gen3-thermal: Support five TSC nodes on r8a779a0
Date:   Wed, 10 Mar 2021 12:07:16 +0100
Message-Id: <20210310110716.3297544-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When adding support for V3U (r8a779a0) it was incorrectly recorded it
supports four nodes, while in fact it supports five. The fifth node is
named TSC0 and breaks the existing naming schema starting at 1. Work
around this by separately defining the reg property for V3U and others.

Restore the maximum number of nodes to three for other compatibles as
it was before erroneously increasing it for V3U.

Fixes: d7fdfb6541f3be88 ("dt-bindings: thermal: rcar-gen3-thermal: Add r8a779a0 support")
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
* Changes since v1
- The register layout for V3U is larger then for other SoCs, fix the
  example to reflect this. Thanks Geert for spotting this!
- Fix a bad copy-past in the register list in the example.
---
 .../bindings/thermal/rcar-gen3-thermal.yaml   | 43 +++++++++++++++----
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
index b33a76eeac4e4fed..f963204e0b162746 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
@@ -28,14 +28,7 @@ properties:
       - renesas,r8a77980-thermal # R-Car V3H
       - renesas,r8a779a0-thermal # R-Car V3U
 
-  reg:
-    minItems: 2
-    maxItems: 4
-    items:
-      - description: TSC1 registers
-      - description: TSC2 registers
-      - description: TSC3 registers
-      - description: TSC4 registers
+  reg: true
 
   interrupts:
     items:
@@ -71,8 +64,25 @@ if:
           enum:
             - renesas,r8a779a0-thermal
 then:
+  properties:
+    reg:
+      minItems: 2
+      maxItems: 3
+      items:
+        - description: TSC1 registers
+        - description: TSC2 registers
+        - description: TSC3 registers
   required:
     - interrupts
+else:
+  properties:
+    reg:
+      items:
+        - description: TSC0 registers
+        - description: TSC1 registers
+        - description: TSC2 registers
+        - description: TSC3 registers
+        - description: TSC4 registers
 
 additionalProperties: false
 
@@ -111,3 +121,20 @@ examples:
                     };
             };
     };
+  - |
+    #include <dt-bindings/clock/r8a779a0-cpg-mssr.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/r8a779a0-sysc.h>
+
+    tsc_r8a779a0: thermal@e6190000 {
+            compatible = "renesas,r8a779a0-thermal";
+            reg = <0xe6190000 0x200>,
+                  <0xe6198000 0x200>,
+                  <0xe61a0000 0x200>,
+                  <0xe61a8000 0x200>,
+                  <0xe61b0000 0x200>;
+            clocks = <&cpg CPG_MOD 919>;
+            power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
+            resets = <&cpg 919>;
+            #thermal-sensor-cells = <1>;
+    };
-- 
2.30.1

