Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67691439906
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 16:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhJYOuE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 10:50:04 -0400
Received: from marcansoft.com ([212.63.210.85]:38474 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230128AbhJYOuE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Oct 2021 10:50:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id F107142181;
        Mon, 25 Oct 2021 14:47:33 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH v2 2/8] dt-bindings: arm: apple: Add apple,pmgr binding
Date:   Mon, 25 Oct 2021 23:47:12 +0900
Message-Id: <20211025144718.157794-3-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025144718.157794-1-marcan@marcan.st>
References: <20211025144718.157794-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The PMGR block in Apple Silicon SoCs is responsible for SoC power
management. There are two PMGRs in T8103, with different register
layouts but compatible registers. In order to support this as well
as future SoC generations with backwards-compatible registers, we
declare these blocks as syscons and bind to individual registers
in child nodes. Each register controls one SoC device.

The respective apple compatibles are defined in case device-specific
quirks are necessary in the future, but currently these nodes are
expected to be bound by the generic syscon driver.

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../bindings/arm/apple/apple,pmgr.yaml        | 149 ++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml

diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
new file mode 100644
index 000000000000..e8b7776163fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/apple/apple,pmgr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple SoC Power Manager (PMGR)
+
+maintainers:
+  - Hector Martin <marcan@marcan.st>
+
+description: |
+  Apple SoCs include a PMGR block responsible for power management,
+  which can control various clocks, resets, power states, and
+  performance features. This node represents the PMGR as a syscon,
+  with sub-nodes representing individual features.
+
+  Apple SoCs may have a secondary "mini-PMGR"; it is represented
+  separately in the device tree, but works the same way.
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - apple,t8103-pmgr
+          - apple,t8103-minipmgr
+          - apple,pmgr
+
+  required:
+    - compatible
+
+properties:
+  $nodename:
+    pattern: "^power-management@[0-9a-f]+$"
+
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-pmgr
+          - apple,t8103-minipmgr
+      - const: apple,pmgr
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+patternProperties:
+  "power-controller@[0-9a-f]+$":
+    description: |
+      The individual power management domains within this controller
+    type: object
+    $ref: /power/apple,pmgr-pwrstate.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        power-management@23b700000 {
+            compatible = "apple,t8103-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+            #address-cells = <1>;
+            #size-cells = <1>;
+            reg = <0x2 0x3b700000 0x0 0x14000>;
+
+            ps_sio: power-controller@1c0 {
+                compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+                reg = <0x1c0 8>;
+                #power-domain-cells = <0>;
+                #reset-cells = <0>;
+                label = "sio";
+                apple,always-on;
+            };
+
+            ps_uart_p: power-controller@220 {
+                compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+                reg = <0x220 8>;
+                #power-domain-cells = <0>;
+                #reset-cells = <0>;
+                label = "uart_p";
+                power-domains = <&ps_sio>;
+            };
+
+            ps_uart0: power-controller@270 {
+                compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+                reg = <0x270 8>;
+                #power-domain-cells = <0>;
+                #reset-cells = <0>;
+                label = "uart0";
+                power-domains = <&ps_uart_p>;
+            };
+        };
+
+        power-management@23d280000 {
+            compatible = "apple,t8103-minipmgr", "apple,pmgr", "syscon", "simple-mfd";
+            #address-cells = <1>;
+            #size-cells = <1>;
+            reg = <0x2 0x3d280000 0x0 0xc000>;
+
+            ps_aop_filter: power-controller@4000 {
+                compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+                reg = <0x4000 8>;
+                #power-domain-cells = <0>;
+                #reset-cells = <0>;
+                label = "aop_filter";
+            };
+
+            ps_aop_base: power-controller@4010 {
+                compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+                reg = <0x4010 8>;
+                #power-domain-cells = <0>;
+                #reset-cells = <0>;
+                label = "aop_base";
+                power-domains = <&ps_aop_filter>;
+            };
+
+            ps_aop_shim: power-controller@4038 {
+                compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+                reg = <0x4038 8>;
+                #power-domain-cells = <0>;
+                #reset-cells = <0>;
+                label = "aop_shim";
+                power-domains = <&ps_aop_base>;
+            };
+
+            ps_aop_uart0: power-controller@4048 {
+                compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+                reg = <0x4048 8>;
+                #power-domain-cells = <0>;
+                #reset-cells = <0>;
+                label = "aop_uart0";
+                power-domains = <&ps_aop_shim>;
+            };
+        };
+    };
-- 
2.33.0

