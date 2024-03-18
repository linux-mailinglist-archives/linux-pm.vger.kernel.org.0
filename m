Return-Path: <linux-pm+bounces-5004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 844CB87E183
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 02:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E928F1F213B2
	for <lists+linux-pm@lfdr.de>; Mon, 18 Mar 2024 01:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295D11400D;
	Mon, 18 Mar 2024 01:13:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4136D12B75;
	Mon, 18 Mar 2024 01:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710724387; cv=none; b=ZMFqo0zyZXzPrxWLF4iNb2Ft82I0+ff7nXphBor0NQ8oO5Yq7rOomdjHqyQeR2Xb/FLfGZRR4PRyXbiwLFvC0VFzy/8RdW5AZnSyYiwME/3G/v3yY3heBYI5dkcYTycwUiGwxD3CRlLeKfNdIOx8ap8ia8fMt5DcAaOZtBOjl6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710724387; c=relaxed/simple;
	bh=c6Kwkq3WL0INbuU41EI7TMtL8/QiidFBT4o8X/LHrrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h4fpFnNDCeolpTE5Hhfg5Y8tp1ghxo1RX5GVjyUTenS9AY/tRJkn5PjHQsrfnsS7d2J7oikU3S+vHXCkhAfcsfraEqZFE0fsCVqvlvwT8GuDRyxMwtoJkeDWlAYX+nmu1N2ev026xY5fo4hM5SEHRTceeNceBq9Yi/D3BB+Pjz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44E421480;
	Sun, 17 Mar 2024 18:13:39 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D6CF3F23F;
	Sun, 17 Mar 2024 18:13:02 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	Martin Botka <martin.botka@somainline.org>,
	Martin Botka <martin.botka1@gmail.com>
Subject: [PATCH v2 3/8] dt-bindings: opp: Describe H616 OPPs and opp-supported-hw
Date: Mon, 18 Mar 2024 01:12:23 +0000
Message-Id: <20240318011228.2626-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240318011228.2626-1-andre.przywara@arm.com>
References: <20240318011228.2626-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Botka <martin.botka@somainline.org>

The Allwinner H616 uses a similar NVMEM based mechanism to determine the
silicon revision, which is required to select the right frequency /
voltage pair for the OPPs.
However it limits the maximum frequency for some speedbins, which
requires to introduce the opp-supported-hw property.

Add this property to the list of allowed properties, also drop the
requirement for the revision specific opp-microvolt properties, since
they won't be needed if using opp-supported-hw. When using this
property, we also might have multiple OPP nodes per frequency, so relax
the OPP node naming to allow a single letter suffix.

Also use to opportunity to adjust some wording, and drop a sentence
referring to the Linux driver and the OPP subsystem.

Shorten the existing example and add another example, showcasing the
opp-supported-hw property.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../allwinner,sun50i-h6-operating-points.yaml | 89 ++++++++++---------
 1 file changed, 47 insertions(+), 42 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
index 51f62c3ae1947..d5439a3f696bc 100644
--- a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
+++ b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
@@ -13,25 +13,25 @@ maintainers:
 description: |
   For some SoCs, the CPU frequency subset and voltage value of each
   OPP varies based on the silicon variant in use. Allwinner Process
-  Voltage Scaling Tables defines the voltage and frequency value based
-  on the speedbin blown in the efuse combination. The
-  sun50i-cpufreq-nvmem driver reads the efuse value from the SoC to
-  provide the OPP framework with required information.
+  Voltage Scaling Tables define the voltage and frequency values based
+  on the speedbin blown in the efuse combination.
 
 allOf:
   - $ref: opp-v2-base.yaml#
 
 properties:
   compatible:
-    const: allwinner,sun50i-h6-operating-points
+    enum:
+      - allwinner,sun50i-h6-operating-points
+      - allwinner,sun50i-h616-operating-points
 
   nvmem-cells:
     description: |
       A phandle pointing to a nvmem-cells node representing the efuse
-      registers that has information about the speedbin that is used
+      register that has information about the speedbin that is used
       to select the right frequency/voltage value pair. Please refer
-      the for nvmem-cells bindings
-      Documentation/devicetree/bindings/nvmem/nvmem.txt and also
+      to the nvmem-cells bindings in
+      Documentation/devicetree/bindings/nvmem/nvmem.yaml and also the
       examples below.
 
   opp-shared: true
@@ -41,21 +41,23 @@ required:
   - nvmem-cells
 
 patternProperties:
-  "^opp-[0-9]+$":
+  "^opp-[0-9]+(-[a-z])?$":
     type: object
 
     properties:
       opp-hz: true
       clock-latency-ns: true
+      opp-microvolt: true
+      opp-supported-hw:
+        description: |
+          A single 32 bit bitmap value, representing compatible HW, one
+          bit per speed bin index.
 
     patternProperties:
       "^opp-microvolt-speed[0-9]$": true
 
     required:
       - opp-hz
-      - opp-microvolt-speed0
-      - opp-microvolt-speed1
-      - opp-microvolt-speed2
 
     unevaluatedProperties: false
 
@@ -77,58 +79,61 @@ examples:
             opp-microvolt-speed2 = <800000>;
         };
 
-        opp-720000000 {
+        opp-1080000000 {
             clock-latency-ns = <244144>; /* 8 32k periods */
-            opp-hz = /bits/ 64 <720000000>;
+            opp-hz = /bits/ 64 <1080000000>;
 
-            opp-microvolt-speed0 = <880000>;
-            opp-microvolt-speed1 = <820000>;
-            opp-microvolt-speed2 = <800000>;
+            opp-microvolt-speed0 = <1060000>;
+            opp-microvolt-speed1 = <880000>;
+            opp-microvolt-speed2 = <840000>;
         };
 
-        opp-816000000 {
+        opp-1488000000 {
             clock-latency-ns = <244144>; /* 8 32k periods */
-            opp-hz = /bits/ 64 <816000000>;
+            opp-hz = /bits/ 64 <1488000000>;
 
-            opp-microvolt-speed0 = <880000>;
-            opp-microvolt-speed1 = <820000>;
-            opp-microvolt-speed2 = <800000>;
+            opp-microvolt-speed0 = <1160000>;
+            opp-microvolt-speed1 = <1000000>;
+            opp-microvolt-speed2 = <960000>;
         };
+    };
+
+  - |
+    opp-table {
+        compatible = "allwinner,sun50i-h616-operating-points";
+        nvmem-cells = <&speedbin_efuse>;
+        opp-shared;
 
-        opp-888000000 {
+        opp-480000000 {
             clock-latency-ns = <244144>; /* 8 32k periods */
-            opp-hz = /bits/ 64 <888000000>;
+            opp-hz = /bits/ 64 <480000000>;
 
-            opp-microvolt-speed0 = <940000>;
-            opp-microvolt-speed1 = <820000>;
-            opp-microvolt-speed2 = <800000>;
+            opp-microvolt = <900000>;
+            opp-supported-hw = <0x1f>;
         };
 
-        opp-1080000000 {
+        opp-792000000-l {
             clock-latency-ns = <244144>; /* 8 32k periods */
-            opp-hz = /bits/ 64 <1080000000>;
+            opp-hz = /bits/ 64 <792000000>;
 
-            opp-microvolt-speed0 = <1060000>;
-            opp-microvolt-speed1 = <880000>;
-            opp-microvolt-speed2 = <840000>;
+            opp-microvolt = <900000>;
+            opp-supported-hw = <0x02>;
         };
 
-        opp-1320000000 {
+        opp-792000000-h {
             clock-latency-ns = <244144>; /* 8 32k periods */
-            opp-hz = /bits/ 64 <1320000000>;
+            opp-hz = /bits/ 64 <792000000>;
 
-            opp-microvolt-speed0 = <1160000>;
-            opp-microvolt-speed1 = <940000>;
-            opp-microvolt-speed2 = <900000>;
+            opp-microvolt = <940000>;
+            opp-supported-hw = <0x10>;
         };
 
-        opp-1488000000 {
+        opp-1512000000 {
             clock-latency-ns = <244144>; /* 8 32k periods */
-            opp-hz = /bits/ 64 <1488000000>;
+            opp-hz = /bits/ 64 <1512000000>;
 
-            opp-microvolt-speed0 = <1160000>;
-            opp-microvolt-speed1 = <1000000>;
-            opp-microvolt-speed2 = <960000>;
+            opp-microvolt = <1100000>;
+            opp-supported-hw = <0x0a>;
         };
     };
 
-- 
2.35.8


