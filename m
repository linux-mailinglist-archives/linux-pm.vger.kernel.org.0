Return-Path: <linux-pm+bounces-3702-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5184084F7C7
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 15:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0B37B23ED2
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 14:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983BD6A009;
	Fri,  9 Feb 2024 14:42:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939BE2E405;
	Fri,  9 Feb 2024 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489755; cv=none; b=AMLHaYpF+8faNZ5AgvmkoRVpHGJ9CsGWpRiU6wolpYrlmMM2INy4lRx2wVQ4+/09hYWyIovFBwLV9iV9509xh+BvlMHuJzplFE2BPfZa3Zac6Bf0KL21Fqi5r+fyWw2OrFxea4cJfzRoMAuf8M9zsgrZkTAyTRnnJPNxJXbWYkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489755; c=relaxed/simple;
	bh=MuSDgDmHEEnfV1hdGWl7KkTcfsnRXbDiq1GWkmyvqxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=byUnMC3wA+OquPWfL1xxFqk0QWx8YKN+bx+QLC8D/ogwU/XfNKjtVAAayp4Booge6Q+PGtbHImGuKRNuQsfQyCxancUSXgGcn4DN52EdAr8yjSnbO6BLOvCrendt3VJsOQv+h73tb8ocs4TB+Euy0vvW/UUQDj5GdX6+7lzVfyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D729DA7;
	Fri,  9 Feb 2024 06:43:15 -0800 (PST)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B78723F5A1;
	Fri,  9 Feb 2024 06:42:30 -0800 (PST)
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
	Maksim Kiselev <bigunclemax@gmail.com>,
	Bob McChesney <bob@electricworry.net>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v4 2/7] dt-bindings: thermal: sun8i: Add H616 THS controller
Date: Fri,  9 Feb 2024 14:42:16 +0000
Message-Id: <20240209144221.3602382-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240209144221.3602382-1-andre.przywara@arm.com>
References: <20240209144221.3602382-1-andre.przywara@arm.com>
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
correct operation, so add a phandle property to point there.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../thermal/allwinner,sun8i-a83t-ths.yaml     | 34 +++++++++++++------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
index 9b2272a9ec15d..6b3aea6d73b07 100644
--- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
+++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
@@ -21,6 +21,7 @@ properties:
       - allwinner,sun50i-a100-ths
       - allwinner,sun50i-h5-ths
       - allwinner,sun50i-h6-ths
+      - allwinner,sun50i-h616-ths
 
   clocks:
     minItems: 1
@@ -50,6 +51,10 @@ properties:
   nvmem-cell-names:
     const: calibration
 
+  allwinner,sram:
+    maxItems: 1
+    description: phandle to device controlling temperate offset SYS_CFG register
+
   # See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for details
   "#thermal-sensor-cells":
     enum:
@@ -65,6 +70,7 @@ allOf:
               - allwinner,sun20i-d1-ths
               - allwinner,sun50i-a100-ths
               - allwinner,sun50i-h6-ths
+              - allwinner,sun50i-h616-ths
 
     then:
       properties:
@@ -82,6 +88,17 @@ allOf:
         clock-names:
           minItems: 2
 
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: allwinner,sun50i-h616-ths
+
+    then:
+      properties:
+        allwinner,sram: false
+
   - if:
       properties:
         compatible:
@@ -101,17 +118,12 @@ allOf:
           const: 1
 
   - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - allwinner,sun8i-h3-ths
-              - allwinner,sun8i-r40-ths
-              - allwinner,sun20i-d1-ths
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
2.25.1


