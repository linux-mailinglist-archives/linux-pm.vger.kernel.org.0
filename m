Return-Path: <linux-pm+bounces-321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30F57FAF58
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 02:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742E0281950
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 01:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F9E15C9;
	Tue, 28 Nov 2023 01:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 585571B1;
	Mon, 27 Nov 2023 17:00:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B91BA139F;
	Mon, 27 Nov 2023 17:01:29 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2F953F6C4;
	Mon, 27 Nov 2023 17:00:39 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Botka <martin.botka@somainline.org>,
	Bob McChesney <bob@electricworry.net>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v3 2/6] dt-bindings: thermal: sun8i: Add H616 THS controller
Date: Tue, 28 Nov 2023 00:58:45 +0000
Message-Id: <20231128005849.19044-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20231128005849.19044-1-andre.przywara@arm.com>
References: <20231128005849.19044-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Botka <martin.botka@somainline.org>

This controller is similar to the H6, but covers four sensors and uses
slightly different calibration methods.
Also the H616 requires to poke a bit in the SYS_CFG register range for
correct operation, so add a "syscon" phandle property to point there.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../thermal/allwinner,sun8i-a83t-ths.yaml     | 30 ++++++++++++-------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
index fbd4212285e28..95a6ab9a5889b 100644
--- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
+++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
@@ -20,6 +20,7 @@ properties:
       - allwinner,sun50i-a100-ths
       - allwinner,sun50i-h5-ths
       - allwinner,sun50i-h6-ths
+      - allwinner,sun50i-h616-ths
 
   clocks:
     minItems: 1
@@ -63,6 +64,7 @@ allOf:
             enum:
               - allwinner,sun50i-a100-ths
               - allwinner,sun50i-h6-ths
+              - allwinner,sun50i-h616-ths
 
     then:
       properties:
@@ -80,6 +82,18 @@ allOf:
         clock-names:
           minItems: 2
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun50i-h616-ths
+
+    then:
+      properties:
+        syscon:
+          maxItems: 1
+          description: phandle to syscon device allowing access to SYS_CFG registers
+
   - if:
       properties:
         compatible:
@@ -97,16 +111,12 @@ allOf:
           const: 1
 
   - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - allwinner,sun8i-h3-ths
-              - allwinner,sun8i-r40-ths
-              - allwinner,sun50i-a64-ths
-              - allwinner,sun50i-a100-ths
-              - allwinner,sun50i-h5-ths
-              - allwinner,sun50i-h6-ths
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - allwinner,sun8i-a83t-ths
 
     then:
       required:
-- 
2.35.8


