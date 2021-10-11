Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7734294E7
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 18:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhJKQ7n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 12:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhJKQ7m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Oct 2021 12:59:42 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E8EC061570;
        Mon, 11 Oct 2021 09:57:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 510E642446;
        Mon, 11 Oct 2021 16:57:35 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/9] dt-bindings: memory-controller: Add apple,mcc binding
Date:   Tue, 12 Oct 2021 01:57:00 +0900
Message-Id: <20211011165707.138157-3-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011165707.138157-1-marcan@marcan.st>
References: <20211011165707.138157-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This device represents the memory controller in Apple SoCs, and is
chiefly in charge of adjusting performance characteristics according to
system demand.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../memory-controllers/apple,mcc.yaml         | 80 +++++++++++++++++++
 .../opp/apple,mcc-operating-points.yaml       | 62 ++++++++++++++
 2 files changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/apple,mcc.yaml
 create mode 100644 Documentation/devicetree/bindings/opp/apple,mcc-operating-points.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/apple,mcc.yaml b/Documentation/devicetree/bindings/memory-controllers/apple,mcc.yaml
new file mode 100644
index 000000000000..0774f10e65ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/apple,mcc.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/apple,mcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple SoC MCC memory controller performance controls
+
+maintainers:
+  - Hector Martin <marcan@marcan.st>
+
+description: |
+  Apple SoCs contain a multichannel memory controller that can have its
+  configuration changed to adjust to changing performance requirements from
+  the rest of the SoC. This node represents the controller and provides a
+  power domain provider that downstream devices can use to adjust the memory
+  controller performance level.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-mcc
+      - const: apple,mcc
+
+  reg:
+    maxItems: 1
+
+  "#power-domain-cells":
+    const: 0
+
+  operating-points-v2:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      A reference to the OPP table describing the memory controller performance
+      levels. Each OPP node should contain an `apple,memory-perf-config`
+      property that contains the configuration values for that performance
+      level.
+
+  apple,num-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The number of memory channels in use.
+
+required:
+  - compatible
+  - reg
+  - "#power-domain-cells"
+  - operating-points-v2
+  - apple,num-channels
+
+additionalProperties: false
+
+examples:
+  # See clock/apple,cluster-clock.yaml for an example of downstream usage.
+  - |
+    mcc_opp: opp-table-2 {
+        compatible = "operating-points-v2";
+
+        mcc_lowperf: opp0 {
+            opp-level = <0>;
+            apple,memory-perf-config = <0x813057f 0x1800180>;
+        };
+        mcc_highperf: opp1 {
+            opp-level = <1>;
+            apple,memory-perf-config = <0x133 0x55555340>;
+        };
+    };
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mcc: memory-controller@200200000 {
+            compatible = "apple,t8103-mcc", "apple,mcc";
+            #power-domain-cells = <0>;
+            reg = <0x2 0x200000 0x0 0x200000>;
+            operating-points-v2 = <&mcc_opp>;
+            apple,num-channels = <8>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/opp/apple,mcc-operating-points.yaml b/Documentation/devicetree/bindings/opp/apple,mcc-operating-points.yaml
new file mode 100644
index 000000000000..babf27841bb7
--- /dev/null
+++ b/Documentation/devicetree/bindings/opp/apple,mcc-operating-points.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/opp/apple,mcc-operating-points.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple SoC memory controller OPP bindings
+
+maintainers:
+  - Hector Martin <marcan@marcan.st>
+
+description: |
+  Apple SoCs can have their memory controller performance adjusted depending on
+  system requirements. These performance states are represented by specific
+  memory controller register values. The apple-mcc driver uses these values
+  to change the MCC performance.
+
+allOf:
+  - $ref: opp-v2-base.yaml#
+
+properties:
+  compatible:
+    const: apple,mcc-operating-points
+
+required:
+  - compatible
+
+patternProperties:
+  "opp[0-9]+":
+    type: object
+
+    properties:
+      opp-level: true
+      apple,memory-perf-config:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description: |
+          A pair of register values used to configure this performance state.
+        minItems: 2
+        maxItems: 2
+
+    required:
+      - opp-level
+      - apple,memory-perf-config
+
+    unevaluatedProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    mcc_opp: opp-table-2 {
+        compatible = "operating-points-v2";
+
+        mcc_lowperf: opp0 {
+            opp-level = <0>;
+            apple,memory-perf-config = <0x813057f 0x1800180>;
+        };
+        mcc_highperf: opp1 {
+            opp-level = <1>;
+            apple,memory-perf-config = <0x133 0x55555340>;
+        };
+    };
-- 
2.33.0

