Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E395422D70
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 18:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbhJEQLQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 12:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbhJEQLP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 12:11:15 -0400
X-Greylist: delayed 576 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Oct 2021 09:09:24 PDT
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1BBC061749;
        Tue,  5 Oct 2021 09:09:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 617A2420CF;
        Tue,  5 Oct 2021 15:59:51 +0000 (UTC)
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
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 2/7] dt-bindings: power: Add apple,pmgr-pwrstate binding
Date:   Wed,  6 Oct 2021 00:59:18 +0900
Message-Id: <20211005155923.173399-3-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005155923.173399-1-marcan@marcan.st>
References: <20211005155923.173399-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This syscon child node represents a single SoC device controlled by the
PMGR block. This layout allows us to declare all device power state
controls (power/clock gating and reset) in the device tree, including
dependencies, instead of hardcoding it into the driver. The register
layout is uniform.

Each pmgr-pwrstate node provides genpd and reset features, to be
consumed by downstream device nodes.

Future SoCs are expected to use backwards compatible registers, and the
"apple,pmgr-pwrstate" represents any such interfaces (possibly with
additional features gated by the more specific compatible), allowing
them to be bound without driver updates. If a backwards incompatible
change is introduced in future SoCs, it will require a new compatible,
such as "apple,pmgr-pwrstate-v2".

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../bindings/power/apple,pmgr-pwrstate.yaml   | 117 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 118 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml

diff --git a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
new file mode 100644
index 000000000000..a14bf5f30ff0
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/apple,pmgr-pwrstate.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple SoC PMGR Power States
+
+maintainers:
+  - Hector Martin <marcan@marcan.st>
+
+allOf:
+  - $ref: "power-domain.yaml#"
+
+description: |
+  Apple SoCs include a PMGR block responsible for power management,
+  which can control various clocks, resets, power states, and
+  performance features. This binding describes the device power
+  state registers, which control power states and resets.
+
+  Each instance of a power controller within the PMGR syscon node
+  represents a generic power domain provider, as documented in
+  Documentation/devicetree/bindings/power/power-domain.yaml.
+  The provider controls a single SoC block. The power hierarchy is
+  represented via power-domains relationships between these nodes.
+
+  See Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
+  for the top-level PMGR node documentation.
+
+  IP cores belonging to a power domain should contain a
+  "power-domains" property that is a phandle for the
+  power domain node representing the domain.
+
+properties:
+  $nodename:
+    pattern: "^power-controller@[0-9a-f]+$"
+
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-pmgr-pwrstate
+      - const: apple,pmgr-pwrstate
+
+  reg:
+    maxItems: 1
+
+  "#power-domain-cells":
+    const: 0
+
+  "#reset-cells":
+    const: 0
+
+  power-domains:
+    description:
+      Reference to parent power domains. A domain may have multiple parents,
+      and all will be powered up when it is powered.
+
+  apple,domain-name:
+    description: |
+      Specifies the name of the SoC device being controlled. This is used to
+      name the power/reset domains.
+    $ref: /schemas/types.yaml#/definitions/string
+
+  apple,always-on:
+    description: |
+      Forces this power domain to always be powered up.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - "#power-domain-cells"
+  - "#reset-cells"
+  - "apple,domain-name"
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
+            #size-cells = <0>;
+            reg = <0x2 0x3b700000 0x0 0x14000>;
+
+            ps_sio: power-controller@1c0 {
+                compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+                reg = <0x1c0>;
+                #power-domain-cells = <0>;
+                #reset-cells = <0>;
+                apple,domain-name = "sio";
+                apple,always-on;
+            };
+
+            ps_uart_p: power-controller@220 {
+                compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+                reg = <0x220>;
+                #power-domain-cells = <0>;
+                #reset-cells = <0>;
+                apple,domain-name = "uart_p";
+                power-domains = <&ps_sio>;
+            };
+
+            ps_uart0: power-controller@270 {
+                compatible = "apple,t8103-pmgr-pwrstate", "apple,pmgr-pwrstate";
+                reg = <0x270>;
+                #power-domain-cells = <0>;
+                #reset-cells = <0>;
+                apple,domain-name = "uart0";
+                power-domains = <&ps_uart_p>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index d25598842d15..5fe53d9a2956 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1722,6 +1722,7 @@ F:	Documentation/devicetree/bindings/arm/apple.yaml
 F:	Documentation/devicetree/bindings/arm/apple/*
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
+F:	Documentation/devicetree/bindings/power/apple*
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/irqchip/irq-apple-aic.c
 F:	include/dt-bindings/interrupt-controller/apple-aic.h
-- 
2.33.0

