Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948642849AC
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 11:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgJFJvB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 05:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJFJu6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 05:50:58 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E205C0613D1
        for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2020 02:50:57 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id h2so956975pll.11
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 02:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mycjQb93JeYpVYCRmqAervRMhPA70rTAQD2ylQgQobQ=;
        b=DH5cXDdLsP5zV5SH9Edi6Wjky4+cSm892NocSCE6yVfQTGSHN+Hh2vpyV0E9V7c8u0
         068xGZbUHbiEmpQgjwru7RF8jXgc65PktOfNJ2HYF9y7gXr+aCrk2DI8VyxaqK0JhqF9
         HA6hOict0YsCwTk8SwBh9Lj74QbYj6rngx3Fj0NjYICFW2TJ3WwK/zjLJU1x3/Pb38U3
         KBm/knfgz1RW++FrQ3Wi54HA5Iq3Wo8uVXZ+Hsj7gmYJRZz/cvzJYDBzrbxUj6WMspF9
         CAqRtPBUKxVXiW9Ehq7kJEqzluwO8GRcrI+Yttgr3iCz1G3MhfaWdZYone+c8G9hAs5g
         taSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mycjQb93JeYpVYCRmqAervRMhPA70rTAQD2ylQgQobQ=;
        b=kxO9S0RglS/v5ynIc3UtBE+4GaPtYxrSd+bPJcaXLznfVEGVI9HBYvOex8Un2Na7DR
         iISD5usAPP0YPIhHAxXAZDYWzjZZdjRDxgADH/9w32UYhAzqnjFIy5R885nu1j/kUlKT
         zmgisecG2x1jBsp9F1qCHlm7ro6dBX9NbOTxJ1oZhksEkeQH0cubyDgHwKNimVXbpLuK
         LVKv0NS6yf+Dy+GZDxEmTEU8FGTCp5UVE9tywgZKgFsb0rJF/LRvOyelMYBogDQeJRA0
         8xHH0wLGNmrZjw+tJi8UW09Bs2vWTGvreOTHON8tmmes4oVgiJ6NEjU+n1ISiBFlfWiI
         TrEQ==
X-Gm-Message-State: AOAM532pTFAbVbS96P2HlC4Tk4KB1kkR2QcrQ6C/mxm146WvTSb+BGCp
        mDjohIcmo3q/YJ+9WBqH3FoU
X-Google-Smtp-Source: ABdhPJyDgiy7IGlwkfN5RgDJvsMp5VpBk/wuDaejJivnre1JvscceD3vX4ijlMiU0qpmoSbtS+53dg==
X-Received: by 2002:a17:902:9b83:b029:d2:439c:3b7d with SMTP id y3-20020a1709029b83b02900d2439c3b7dmr2438063plp.39.1601977856354;
        Tue, 06 Oct 2020 02:50:56 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6e9d:8f58:948:749c:4eeb:26a])
        by smtp.gmail.com with ESMTPSA id e19sm2979783pfl.135.2020.10.06.02.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 02:50:55 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to YAML bindings
Date:   Tue,  6 Oct 2020 15:20:47 +0530
Message-Id: <20201006095047.30242-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert Qualcomm cpufreq devicetree binding to YAML.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/cpufreq/cpufreq-qcom-hw.txt      | 172 --------------
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 212 ++++++++++++++++++
 2 files changed, 212 insertions(+), 172 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
deleted file mode 100644
index 9299028ee712..000000000000
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
+++ /dev/null
@@ -1,172 +0,0 @@
-Qualcomm Technologies, Inc. CPUFREQ Bindings
-
-CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
-SoCs to manage frequency in hardware. It is capable of controlling frequency
-for multiple clusters.
-
-Properties:
-- compatible
-	Usage:		required
-	Value type:	<string>
-	Definition:	must be "qcom,cpufreq-hw" or "qcom,cpufreq-epss".
-
-- clocks
-	Usage:		required
-	Value type:	<phandle> From common clock binding.
-	Definition:	clock handle for XO clock and GPLL0 clock.
-
-- clock-names
-	Usage:		required
-	Value type:	<string> From common clock binding.
-	Definition:	must be "xo", "alternate".
-
-- reg
-	Usage:		required
-	Value type:	<prop-encoded-array>
-	Definition:	Addresses and sizes for the memory of the HW bases in
-			each frequency domain.
-- reg-names
-	Usage:		Optional
-	Value type:	<string>
-	Definition:	Frequency domain name i.e.
-			"freq-domain0", "freq-domain1".
-
-- #freq-domain-cells:
-	Usage:		required.
-	Definition:	Number of cells in a freqency domain specifier.
-
-* Property qcom,freq-domain
-Devices supporting freq-domain must set their "qcom,freq-domain" property with
-phandle to a cpufreq_hw followed by the Domain ID(0/1) in the CPU DT node.
-
-
-Example:
-
-Example 1: Dual-cluster, Quad-core per cluster. CPUs within a cluster switch
-DCVS state together.
-
-/ {
-	cpus {
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		CPU0: cpu@0 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x0>;
-			enable-method = "psci";
-			next-level-cache = <&L2_0>;
-			qcom,freq-domain = <&cpufreq_hw 0>;
-			L2_0: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-				L3_0: l3-cache {
-				      compatible = "cache";
-				};
-			};
-		};
-
-		CPU1: cpu@100 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x100>;
-			enable-method = "psci";
-			next-level-cache = <&L2_100>;
-			qcom,freq-domain = <&cpufreq_hw 0>;
-			L2_100: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-			};
-		};
-
-		CPU2: cpu@200 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x200>;
-			enable-method = "psci";
-			next-level-cache = <&L2_200>;
-			qcom,freq-domain = <&cpufreq_hw 0>;
-			L2_200: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-			};
-		};
-
-		CPU3: cpu@300 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x300>;
-			enable-method = "psci";
-			next-level-cache = <&L2_300>;
-			qcom,freq-domain = <&cpufreq_hw 0>;
-			L2_300: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-			};
-		};
-
-		CPU4: cpu@400 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x400>;
-			enable-method = "psci";
-			next-level-cache = <&L2_400>;
-			qcom,freq-domain = <&cpufreq_hw 1>;
-			L2_400: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-			};
-		};
-
-		CPU5: cpu@500 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x500>;
-			enable-method = "psci";
-			next-level-cache = <&L2_500>;
-			qcom,freq-domain = <&cpufreq_hw 1>;
-			L2_500: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-			};
-		};
-
-		CPU6: cpu@600 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x600>;
-			enable-method = "psci";
-			next-level-cache = <&L2_600>;
-			qcom,freq-domain = <&cpufreq_hw 1>;
-			L2_600: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-			};
-		};
-
-		CPU7: cpu@700 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x700>;
-			enable-method = "psci";
-			next-level-cache = <&L2_700>;
-			qcom,freq-domain = <&cpufreq_hw 1>;
-			L2_700: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-			};
-		};
-	};
-
- soc {
-	cpufreq_hw: cpufreq@17d43000 {
-		compatible = "qcom,cpufreq-hw";
-		reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
-		reg-names = "freq-domain0", "freq-domain1";
-
-		clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
-		clock-names = "xo", "alternate";
-
-		#freq-domain-cells = <1>;
-	};
-}
diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
new file mode 100644
index 000000000000..a11c69a29b5d
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -0,0 +1,212 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cpufreq/cpufreq-qcom-hw.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. CPUFREQ
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description: |
+
+  CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
+  SoCs to manage frequency in hardware. It is capable of controlling frequency
+  for multiple clusters.
+
+properties:
+  compatible:
+    oneOf:
+      - description: v1 of CPUFREQ HW
+        items:
+          - const: qcom,cpufreq-hw
+
+      - description: v2 of CPUFREQ HW (EPSS)
+        items:
+          - enum:
+              - qcom,sm8250-cpufreq-epss
+          - const: qcom,cpufreq-epss
+
+  reg:
+    minItems: 2
+    maxItems: 3
+    items:
+      - description: Frequency domain 0 register region
+      - description: Frequency domain 1 register region
+      - description: Frequency domain 2 register region
+
+  reg-names:
+    minItems: 2
+    maxItems: 3
+    items:
+      - const: freq-domain0
+      - const: freq-domain1
+      - const: freq-domain2
+
+  clocks:
+    items:
+      - description: XO Clock
+      - description: GPLL0 Clock
+
+  clock-names:
+    items:
+      - const: xo
+      - const: alternate
+
+  '#freq-domain-cells':
+    const: 1
+
+  qcom,freq-domain:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
+    description:
+      Devices supporting freq-domain must set their "qcom,freq-domain"
+      property with phandle to a cpufreq_hw followed by the Domain ID(0/1)
+      in the CPU DT node.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - '#freq-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+
+    // Example 1: Dual-cluster, Quad-core per cluster. CPUs within a cluster
+    // switch DCVS state together.
+    cpus {
+      #address-cells = <2>;
+      #size-cells = <0>;
+
+      CPU0: cpu@0 {
+        device_type = "cpu";
+        compatible = "qcom,kryo385";
+        reg = <0x0 0x0>;
+        enable-method = "psci";
+        next-level-cache = <&L2_0>;
+        qcom,freq-domain = <&cpufreq_hw 0>;
+        L2_0: l2-cache {
+          compatible = "cache";
+          next-level-cache = <&L3_0>;
+          L3_0: l3-cache {
+            compatible = "cache";
+          };
+        };
+      };
+
+      CPU1: cpu@100 {
+        device_type = "cpu";
+        compatible = "qcom,kryo385";
+        reg = <0x0 0x100>;
+        enable-method = "psci";
+        next-level-cache = <&L2_100>;
+        qcom,freq-domain = <&cpufreq_hw 0>;
+        L2_100: l2-cache {
+          compatible = "cache";
+          next-level-cache = <&L3_0>;
+        };
+      };
+
+      CPU2: cpu@200 {
+        device_type = "cpu";
+        compatible = "qcom,kryo385";
+        reg = <0x0 0x200>;
+        enable-method = "psci";
+        next-level-cache = <&L2_200>;
+        qcom,freq-domain = <&cpufreq_hw 0>;
+        L2_200: l2-cache {
+          compatible = "cache";
+          next-level-cache = <&L3_0>;
+        };
+      };
+
+      CPU3: cpu@300 {
+        device_type = "cpu";
+        compatible = "qcom,kryo385";
+        reg = <0x0 0x300>;
+        enable-method = "psci";
+        next-level-cache = <&L2_300>;
+        qcom,freq-domain = <&cpufreq_hw 0>;
+        L2_300: l2-cache {
+          compatible = "cache";
+          next-level-cache = <&L3_0>;
+        };
+      };
+
+      CPU4: cpu@400 {
+        device_type = "cpu";
+        compatible = "qcom,kryo385";
+        reg = <0x0 0x400>;
+        enable-method = "psci";
+        next-level-cache = <&L2_400>;
+        qcom,freq-domain = <&cpufreq_hw 1>;
+        L2_400: l2-cache {
+          compatible = "cache";
+          next-level-cache = <&L3_0>;
+        };
+      };
+
+      CPU5: cpu@500 {
+        device_type = "cpu";
+        compatible = "qcom,kryo385";
+        reg = <0x0 0x500>;
+        enable-method = "psci";
+        next-level-cache = <&L2_500>;
+        qcom,freq-domain = <&cpufreq_hw 1>;
+        L2_500: l2-cache {
+          compatible = "cache";
+          next-level-cache = <&L3_0>;
+        };
+      };
+
+      CPU6: cpu@600 {
+        device_type = "cpu";
+        compatible = "qcom,kryo385";
+        reg = <0x0 0x600>;
+        enable-method = "psci";
+        next-level-cache = <&L2_600>;
+        qcom,freq-domain = <&cpufreq_hw 1>;
+        L2_600: l2-cache {
+          compatible = "cache";
+          next-level-cache = <&L3_0>;
+        };
+      };
+
+      CPU7: cpu@700 {
+        device_type = "cpu";
+        compatible = "qcom,kryo385";
+        reg = <0x0 0x700>;
+        enable-method = "psci";
+        next-level-cache = <&L2_700>;
+        qcom,freq-domain = <&cpufreq_hw 1>;
+        L2_700: l2-cache {
+          compatible = "cache";
+          next-level-cache = <&L3_0>;
+        };
+      };
+    };
+
+    soc {
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      cpufreq@17d43000 {
+        compatible = "qcom,cpufreq-hw";
+        reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
+        reg-names = "freq-domain0", "freq-domain1";
+
+        clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+        clock-names = "xo", "alternate";
+
+        #freq-domain-cells = <1>;
+      };
+    };
+...
-- 
2.17.1

