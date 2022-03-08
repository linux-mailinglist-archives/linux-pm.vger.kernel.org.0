Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286504D22B2
	for <lists+linux-pm@lfdr.de>; Tue,  8 Mar 2022 21:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350254AbiCHUey (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Mar 2022 15:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350257AbiCHUex (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 15:34:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DD33EF24
        for <linux-pm@vger.kernel.org>; Tue,  8 Mar 2022 12:33:55 -0800 (PST)
Date:   Tue, 08 Mar 2022 20:33:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646771634;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mCqe5BfeI3/LyK3ahoe7fJOX/IUQiCv/Q8eHsbtO/ic=;
        b=jl+A/YKg5ZdQ+HN7RBRxi7s2bU+G+N5L8u6l32O2Hfp8q2Tim9RuuhEEvI2XRswLGyjyF/
        IYh5kSydWRAtkIXjnpsG+vGeASaiptbKOHvm6jwOBvOZ7NCLl9s92UbSKXziRq/hSfRA37
        iNXYtpWYKKgRFJE4B5lx3/SwsmvdPJ/BQlz1/7YTCA9XldgdXn3XEsGGGloakjGXXhJJWw
        hFbEYwAItDtUf2rMzIX7LRMQUYstzN17qxOxqgGI7LxmlbhHo38cH/Umd37e8O66lH7HJy
        9CwrGE0KzfewFlzP1gV8qne5yB+djKD1jEsC0FXLnZmqIloDU/9mpdjGyOQaIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646771634;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mCqe5BfeI3/LyK3ahoe7fJOX/IUQiCv/Q8eHsbtO/ic=;
        b=s621dvKI+54lvTFFT4UA43k+IdlJa/cCaEQONrYVTDwRPcSu/c3Fa1KG6nPD6FDoFc9nyZ
        WWVxGRwzvcf7PdAg==
From:   "thermal-bot for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] dt-bindings: thermal: samsung: Convert to dtschema
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220122132554.65192-2-krzysztof.kozlowski@canonical.com>
References: <20220122132554.65192-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Message-ID: <164677163165.16921.894395116588462146.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     0fb74d0d21aaea1513eb8bfdbbde60113be4fcbc
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//0fb74d0d21aaea1513eb8bfdbbde60113be4fcbc
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
AuthorDate:    Sat, 22 Jan 2022 14:25:53 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 08 Mar 2022 21:26:08 +01:00

dt-bindings: thermal: samsung: Convert to dtschema

Convert the Samsung Exynos SoC Thermal Management Unit bindings to DT
schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220122132554.65192-2-krzysztof.kozlowski@canonical.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/thermal/exynos-thermal.txt          | 106 +----------------------------------------
 Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml | 184 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 184 insertions(+), 106 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/exynos-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
deleted file mode 100644
index 33004ce..0000000
--- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
+++ /dev/null
@@ -1,106 +0,0 @@
-* Exynos Thermal Management Unit (TMU)
-
-** Required properties:
-
-- compatible : One of the following:
-	       "samsung,exynos3250-tmu"
-	       "samsung,exynos4412-tmu"
-	       "samsung,exynos4210-tmu"
-	       "samsung,exynos5250-tmu"
-	       "samsung,exynos5260-tmu"
-	       "samsung,exynos5420-tmu" for TMU channel 0, 1 on Exynos5420
-	       "samsung,exynos5420-tmu-ext-triminfo" for TMU channels 2, 3 and 4
-			Exynos5420 (Must pass triminfo base and triminfo clock)
-               "samsung,exynos5433-tmu"
-	       "samsung,exynos7-tmu"
-- reg : Address range of the thermal registers. For soc's which has multiple
-	instances of TMU and some registers are shared across all TMU's like
-	interrupt related then 2 set of register has to supplied. First set
-	belongs	to register set of TMU instance and second set belongs to
-	registers shared with the TMU instance.
-
-  NOTE: On Exynos5420, the TRIMINFO register is misplaced for TMU
-	channels 2, 3 and 4
-	Use "samsung,exynos5420-tmu-ext-triminfo" in cases, there is a misplaced
-	register, also provide clock to access that base.
-
-	TRIMINFO at 0x1006c000 contains data for TMU channel 3
-	TRIMINFO at 0x100a0000 contains data for TMU channel 4
-	TRIMINFO at 0x10068000 contains data for TMU channel 2
-
-- interrupts : Should contain interrupt for thermal system
-- clocks : The main clocks for TMU device
-	-- 1. operational clock for TMU channel
-	-- 2. optional clock to access the shared registers of TMU channel
-	-- 3. optional special clock for functional operation
-- clock-names : Thermal system clock name
-	-- "tmu_apbif" operational clock for current TMU channel
-	-- "tmu_triminfo_apbif" clock to access the shared triminfo register
-		for current TMU channel
-	-- "tmu_sclk" clock for functional operation of the current TMU
-		channel
-
-The Exynos TMU supports generating interrupts when reaching given
-temperature thresholds. Number of supported thermal trip points depends
-on the SoC (only first trip points defined in DT will be configured):
- - most of SoC: 4
- - samsung,exynos5433-tmu: 8
- - samsung,exynos7-tmu: 8
-
-** Optional properties:
-
-- vtmu-supply: This entry is optional and provides the regulator node supplying
-		voltage to TMU. If needed this entry can be placed inside
-		board/platform specific dts file.
-
-Example 1):
-
-	tmu@100c0000 {
-		compatible = "samsung,exynos4412-tmu";
-		interrupt-parent = <&combiner>;
-		reg = <0x100C0000 0x100>;
-		interrupts = <2 4>;
-		clocks = <&clock 383>;
-		clock-names = "tmu_apbif";
-		vtmu-supply = <&tmu_regulator_node>;
-		#thermal-sensor-cells = <0>;
-	};
-
-Example 2): (In case of Exynos5420 "with misplaced TRIMINFO register")
-	tmu_cpu2: tmu@10068000 {
-		compatible = "samsung,exynos5420-tmu-ext-triminfo";
-		reg = <0x10068000 0x100>, <0x1006c000 0x4>;
-		interrupts = <0 184 0>;
-		clocks = <&clock 318>, <&clock 318>;
-		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-		#thermal-sensor-cells = <0>;
-	};
-
-	tmu_cpu3: tmu@1006c000 {
-		compatible = "samsung,exynos5420-tmu-ext-triminfo";
-		reg = <0x1006c000 0x100>, <0x100a0000 0x4>;
-		interrupts = <0 185 0>;
-		clocks = <&clock 318>, <&clock 319>;
-		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-		#thermal-sensor-cells = <0>;
-	};
-
-	tmu_gpu: tmu@100a0000 {
-		compatible = "samsung,exynos5420-tmu-ext-triminfo";
-		reg = <0x100a0000 0x100>, <0x10068000 0x4>;
-		interrupts = <0 215 0>;
-		clocks = <&clock 319>, <&clock 318>;
-		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-		#thermal-sensor-cells = <0>;
-	};
-
-Note: For multi-instance tmu each instance should have an alias correctly
-numbered in "aliases" node.
-
-Example:
-
-aliases {
-	tmuctrl0 = &tmuctrl_0;
-	tmuctrl1 = &tmuctrl_1;
-	tmuctrl2 = &tmuctrl_2;
-};
diff --git a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
new file mode 100644
index 0000000..17129f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
@@ -0,0 +1,184 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/samsung,exynos-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC Thermal Management Unit (TMU)
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+description: |
+  For multi-instance tmu each instance should have an alias correctly numbered
+  in "aliases" node.
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos3250-tmu
+      - samsung,exynos4412-tmu
+      - samsung,exynos4210-tmu
+      - samsung,exynos5250-tmu
+      - samsung,exynos5260-tmu
+        # For TMU channel 0, 1 on Exynos5420:
+      - samsung,exynos5420-tmu
+        # For TMU channels 2, 3 and 4 of Exynos5420:
+      - samsung,exynos5420-tmu-ext-triminfo
+      - samsung,exynos5433-tmu
+      - samsung,exynos7-tmu
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    minItems: 1
+    maxItems: 3
+
+  interrupts:
+    description: |
+      The Exynos TMU supports generating interrupts when reaching given
+      temperature thresholds. Number of supported thermal trip points depends
+      on the SoC (only first trip points defined in DT will be configured)::
+       - most of SoC: 4
+       - samsung,exynos5433-tmu: 8
+       - samsung,exynos7-tmu: 8
+    maxItems: 1
+
+  reg:
+    items:
+      - description: TMU instance registers.
+      - description: |
+          Shared TMU registers.
+
+          Note:: On Exynos5420, the TRIMINFO register is misplaced for TMU
+          channels 2, 3 and 4 Use "samsung,exynos5420-tmu-ext-triminfo" in
+          cases, there is a misplaced register, also provide clock to access
+          that base.
+          TRIMINFO at 0x1006c000 contains data for TMU channel 3
+          TRIMINFO at 0x100a0000 contains data for TMU channel 4
+          TRIMINFO at 0x10068000 contains data for TMU channel 2
+    minItems: 1
+
+  '#thermal-sensor-cells': true
+
+  vtmu-supply:
+    description: The regulator node supplying voltage to TMU.
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - interrupts
+  - reg
+
+allOf:
+  - $ref: /schemas/thermal/thermal-sensor.yaml
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5420-tmu-ext-triminfo
+    then:
+      properties:
+        clocks:
+          items:
+            - description:
+                Operational clock for TMU channel.
+            - description:
+                Optional clock to access the shared registers (e.g. TRIMINFO) of TMU
+                channel.
+        clock-names:
+          items:
+            - const: tmu_apbif
+            - const: tmu_triminfo_apbif
+        reg:
+          minItems: 2
+          maxItems: 2
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos5433-tmu
+              - samsung,exynos7-tmu
+    then:
+      properties:
+        clocks:
+          items:
+            - description:
+                Operational clock for TMU channel.
+            - description:
+                Optional special clock for functional operation of TMU channel.
+        clock-names:
+          items:
+            - const: tmu_apbif
+            - const: tmu_sclk
+        reg:
+          minItems: 1
+          maxItems: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos3250-tmu
+              - samsung,exynos4412-tmu
+              - samsung,exynos4210-tmu
+              - samsung,exynos5250-tmu
+              - samsung,exynos5260-tmu
+              - samsung,exynos5420-tmu
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 1
+        reg:
+          minItems: 1
+          maxItems: 1
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos4.h>
+
+    tmu@100c0000 {
+        compatible = "samsung,exynos4412-tmu";
+        reg = <0x100C0000 0x100>;
+        interrupt-parent = <&combiner>;
+        interrupts = <2 4>;
+        #thermal-sensor-cells = <0>;
+        clocks = <&clock CLK_TMU_APBIF>;
+        clock-names = "tmu_apbif";
+        vtmu-supply = <&ldo10_reg>;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    tmu@10068000 {
+        compatible = "samsung,exynos5420-tmu-ext-triminfo";
+        reg = <0x10068000 0x100>, <0x1006c000 0x4>;
+        interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+        #thermal-sensor-cells = <0>;
+        clocks = <&clock 318>, <&clock 318>; /* CLK_TMU */
+        clock-names = "tmu_apbif", "tmu_triminfo_apbif";
+        vtmu-supply = <&ldo7_reg>;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    tmu@10060000 {
+        compatible = "samsung,exynos5433-tmu";
+        reg = <0x10060000 0x200>;
+        interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+        #thermal-sensor-cells = <0>;
+        clocks = <&cmu_peris 3>, /* CLK_PCLK_TMU0_APBIF */
+                 <&cmu_peris 35>; /* CLK_SCLK_TMU0 */
+        clock-names = "tmu_apbif", "tmu_sclk";
+        vtmu-supply = <&ldo3_reg>;
+    };
