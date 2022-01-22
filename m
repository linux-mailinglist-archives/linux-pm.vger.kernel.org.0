Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA44D496C8A
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jan 2022 14:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiAVN0D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Jan 2022 08:26:03 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49350
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229878AbiAVN0B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Jan 2022 08:26:01 -0500
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 883E23F32C
        for <linux-pm@vger.kernel.org>; Sat, 22 Jan 2022 13:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642857960;
        bh=qMPVOSN/se7fxiU7Eel+utwh2dkH0vLVYgqibYh49Io=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=gORPjssh8lygbCRcyjwYQkX8Lzy9wMQsGYPmJPplAUHuJT5BQ9sV0ATKthYnxkuAE
         BCM+j0j234+fRmgkOgenfxQE92DFMmGv0C9XDsVhaVJI80P0BfZ8qANQcK0c+6g3co
         HJxjGi6r3Ud/5ddist+lnHIYF5abdsegl1iwCEhxlLvXz6hwWe1KfWCxnO5F8fxVnj
         X9j7fMrTwuYbCGm+zONg3mlylh8W3JxTxIeWDBs/L+f/6Ug2blEHYfSN4JD9CsHj0v
         Z1vM1zgoikittfsOrMGaGrn0Ye6mKId/6myQQQdGHkc5Qf4iBPctklOZNas4ML1Wqk
         yRB7sT+WkxDPQ==
Received: by mail-ej1-f72.google.com with SMTP id l18-20020a1709063d3200b006a93f7d4941so952204ejf.1
        for <linux-pm@vger.kernel.org>; Sat, 22 Jan 2022 05:26:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qMPVOSN/se7fxiU7Eel+utwh2dkH0vLVYgqibYh49Io=;
        b=oPcaqOL3EZDBu5WVvIpxmGqMvMZW8gnu6lERlDFRv06rRiE7GSU/g9796RVa+RPLs9
         KhGuI8WorQVnOjJCsYfYAn682AvUFXqpyxIcblkmTIQjUFtYxPTuOT7ctZ8233RXz3yv
         C0X9cb9FqbBmIwIFRuZAQNc3XCww95nfUyKyaWkaXhWBNgpcD1AYoEpuzNVizUwq1nrI
         grCaw6HvzfoUzUaqlBHyN3nuqqK74Yd5aKhfM52tqYvrpv/tPKkQvBIFkr1E91XrWbO5
         YFatZyF09D4TPkX5q4LRVwr2s8UpiItqGzARPA261jkszyClXNdLpI9BU0Hd6bflhXqq
         BQZw==
X-Gm-Message-State: AOAM531sA4h13kK+dKVPcM2zmVshh+d592mUIHe8ugC7alHHSf28SMwE
        VvvgtAoAMPpbXDiOBqo4CFsZCLi/PVRdMe0Ne8EVzo8i8sMlnpxkClz0b0EQ3/v/JbHOPkvtAYv
        c5vx+e4TR1CTahD1elKLgZsgkiZINrHQiSFaC
X-Received: by 2002:a17:906:950e:: with SMTP id u14mr6747403ejx.550.1642857960014;
        Sat, 22 Jan 2022 05:26:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxZw0Dm7uCQiXI4dK7y6ZZ8nCq8doB9qAhMC326Qi3vViLAH4BB14pfXZsePnc307aNmyelA==
X-Received: by 2002:a17:906:950e:: with SMTP id u14mr6747390ejx.550.1642857959765;
        Sat, 22 Jan 2022 05:25:59 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v2sm2373060ejb.114.2022.01.22.05.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 05:25:59 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: thermal: samsung: convert to dtschema
Date:   Sat, 22 Jan 2022 14:25:53 +0100
Message-Id: <20220122132554.65192-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220122132554.65192-1-krzysztof.kozlowski@canonical.com>
References: <20220122132554.65192-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the Samsung Exynos SoC Thermal Management Unit bindings to DT
schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/thermal/exynos-thermal.txt       | 106 ----------
 .../thermal/samsung,exynos-thermal.yaml       | 184 ++++++++++++++++++
 2 files changed, 184 insertions(+), 106 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/exynos-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
deleted file mode 100644
index 33004ce7e5df..000000000000
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
index 000000000000..17129f75d962
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
-- 
2.32.0

