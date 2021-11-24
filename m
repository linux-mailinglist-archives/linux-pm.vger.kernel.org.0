Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09D845B595
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 08:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241258AbhKXHib (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 02:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241286AbhKXHiZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 02:38:25 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48562C06175B;
        Tue, 23 Nov 2021 23:35:14 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id EF4234267B;
        Wed, 24 Nov 2021 07:35:07 +0000 (UTC)
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
Subject: [PATCH v3 07/11] dt-bindings: arm: apple: Add apple,pmgr binding
Date:   Wed, 24 Nov 2021 16:34:17 +0900
Message-Id: <20211124073419.181799-8-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211124073419.181799-1-marcan@marcan.st>
References: <20211124073419.181799-1-marcan@marcan.st>
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
 .../bindings/arm/apple/apple,pmgr.yaml        | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml

diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
new file mode 100644
index 000000000000..b6b5d3a912b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
@@ -0,0 +1,134 @@
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
+  Apple SoCs include PMGR blocks responsible for power management,
+  which can control various clocks, resets, power states, and
+  performance features. This node represents the PMGR as a syscon,
+  with sub-nodes representing individual features.
+
+properties:
+  $nodename:
+    pattern: "^power-management@[0-9a-f]+$"
+
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-pmgr
+          - apple,t6000-pmgr
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
+    description:
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
+            compatible = "apple,t8103-pmgr", "apple,pmgr", "syscon", "simple-mfd";
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

