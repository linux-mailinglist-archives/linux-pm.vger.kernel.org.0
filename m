Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FC34294EA
	for <lists+linux-pm@lfdr.de>; Mon, 11 Oct 2021 18:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhJKQ7v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Oct 2021 12:59:51 -0400
Received: from marcansoft.com ([212.63.210.85]:56578 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232884AbhJKQ7t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Oct 2021 12:59:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id F3A2042462;
        Mon, 11 Oct 2021 16:57:40 +0000 (UTC)
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
Subject: [RFC PATCH 3/9] dt-bindings: clock: Add apple,cluster-clk binding
Date:   Tue, 12 Oct 2021 01:57:01 +0900
Message-Id: <20211011165707.138157-4-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011165707.138157-1-marcan@marcan.st>
References: <20211011165707.138157-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This device represents the CPU performance state switching mechanism as
a clock controller, to be used with the standard cpufreq-dt
infrastructure.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../bindings/clock/apple,cluster-clk.yaml     | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/apple,cluster-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/apple,cluster-clk.yaml b/Documentation/devicetree/bindings/clock/apple,cluster-clk.yaml
new file mode 100644
index 000000000000..9a8b863dadc0
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/apple,cluster-clk.yaml
@@ -0,0 +1,115 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/apple,cluster-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CPU cluster frequency scaling for Apple SoCs
+
+maintainers:
+  - Hector Martin <marcan@marcan.st>
+
+description: |
+  Apple SoCs control CPU cluster frequencies by using a performance state
+  index. This node represents the feature as a clock controller, and uses
+  a reference to the CPU OPP table to translate clock frequencies into
+  performance states. This allows the CPUs to use the standard cpufreq-dt
+  mechanism for frequency scaling.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-cluster-clk
+      - const: apple,cluster-clk
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 0
+
+  operating-points-v2:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      A reference to the OPP table used for the CPU cluster controlled by this
+      device instance. The table should contain an `opp-level` property for
+      every OPP, which represents the p-state index used by the hardware to
+      represent this performance level.
+
+      OPPs may also have a `required-opps` property (see power-domains).
+
+  power-domains:
+    maxItems: 1
+    description:
+      An optional reference to a power domain provider that links its
+      performance state to the CPU cluster performance state. This is typically
+      a memory controller. If set, the `required-opps` property in the CPU
+      frequency OPP nodes will be used to change the performance state of this
+      provider state in tandem with CPU frequency changes.
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - operating-points-v2
+
+additionalProperties: false
+
+
+examples:
+  - |
+    pcluster_opp: opp-table-1 {
+        compatible = "operating-points-v2";
+        opp-shared;
+
+        opp01 {
+            opp-hz = /bits/ 64 <600000000>;
+            opp-microvolt = <781000>;
+            opp-level = <1>;
+            clock-latency-ns = <8000>;
+            required-opps = <&mcc_lowperf>;
+        };
+        /* intermediate p-states omitted */
+        opp15 {
+            opp-hz = /bits/ 64 <3204000000>;
+            opp-microvolt = <1081000>;
+            opp-level = <15>;
+            clock-latency-ns = <56000>;
+            required-opps = <&mcc_highperf>;
+        };
+    };
+
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
+
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
+
+        clk_pcluster: clock-controller@211e20000 {
+            compatible = "apple,t8103-cluster-clk", "apple,cluster-clk";
+            #clock-cells = <0>;
+            reg = <0x2 0x11e20000 0x0 0x4000>;
+            operating-points-v2 = <&pcluster_opp>;
+            power-domains = <&mcc>;
+        };
+    };
-- 
2.33.0

