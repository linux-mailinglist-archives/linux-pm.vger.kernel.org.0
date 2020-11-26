Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E4A2C5DD3
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 23:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388014AbgKZWai (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 17:30:38 -0500
Received: from bin-mail-out-06.binero.net ([195.74.38.229]:36802 "EHLO
        bin-mail-out-06.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387992AbgKZWai (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 17:30:38 -0500
X-Halon-ID: fe6e0644-3036-11eb-a78a-0050569116f7
Authorized-sender: niklas.soderlund@fsdn.se
Received: from bismarck.berto.se (p4fca2458.dip0.t-ipconnect.de [79.202.36.88])
        by bin-vsp-out-03.atm.binero.net (Halon) with ESMTPA
        id fe6e0644-3036-11eb-a78a-0050569116f7;
        Thu, 26 Nov 2020 23:30:32 +0100 (CET)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 1/3] dt-bindings: thermal: rcar-gen3-thermal: Add r8a779a0 support
Date:   Thu, 26 Nov 2020 23:30:26 +0100
Message-Id: <20201126223028.3119044-2-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126223028.3119044-1-niklas.soderlund+renesas@ragnatech.se>
References: <20201126223028.3119044-1-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for R-Car V3U. The V3U IP differs a bit from its siblings in
such way that it have 4 TSC nodes and the interrupts are not routed to
the INTC-AP but to the ECM.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 .../bindings/thermal/rcar-gen3-thermal.yaml     | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
index f386f2a7c06c95c7..b33a76eeac4e4fed 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
@@ -26,13 +26,16 @@ properties:
       - renesas,r8a77961-thermal # R-Car M3-W+
       - renesas,r8a77965-thermal # R-Car M3-N
       - renesas,r8a77980-thermal # R-Car V3H
+      - renesas,r8a779a0-thermal # R-Car V3U
+
   reg:
     minItems: 2
-    maxItems: 3
+    maxItems: 4
     items:
       - description: TSC1 registers
       - description: TSC2 registers
       - description: TSC3 registers
+      - description: TSC4 registers
 
   interrupts:
     items:
@@ -55,12 +58,22 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
   - clocks
   - power-domains
   - resets
   - "#thermal-sensor-cells"
 
+if:
+  not:
+    properties:
+      compatible:
+        contains:
+          enum:
+            - renesas,r8a779a0-thermal
+then:
+  required:
+    - interrupts
+
 additionalProperties: false
 
 examples:
-- 
2.29.2

