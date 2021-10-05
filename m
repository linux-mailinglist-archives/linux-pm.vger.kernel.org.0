Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C4C422D76
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 18:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbhJEQLR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 12:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbhJEQLP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 12:11:15 -0400
X-Greylist: delayed 576 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Oct 2021 09:09:24 PDT
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2CAC06174E;
        Tue,  5 Oct 2021 09:09:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 650CB41EA7;
        Tue,  5 Oct 2021 15:59:46 +0000 (UTC)
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
Subject: [PATCH 1/7] dt-bindings: arm: apple: Add apple,pmgr binding
Date:   Wed,  6 Oct 2021 00:59:17 +0900
Message-Id: <20211005155923.173399-2-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005155923.173399-1-marcan@marcan.st>
References: <20211005155923.173399-1-marcan@marcan.st>
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

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../bindings/arm/apple/apple,pmgr.yaml        | 74 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml

diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
new file mode 100644
index 000000000000..0304164e4140
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
@@ -0,0 +1,74 @@
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
+required:
+  - compatible
+  - reg
+
+additionalProperties: true
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
+        };
+
+        power-management@23b700000 {
+            compatible = "apple,t8103-minipmgr", "apple,pmgr", "syscon", "simple-mfd";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            reg = <0x2 0x3d280000 0x0 0xc000>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index abdcbcfef73d..d25598842d15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1719,6 +1719,7 @@ B:	https://github.com/AsahiLinux/linux/issues
 C:	irc://irc.oftc.net/asahi-dev
 T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/apple.yaml
+F:	Documentation/devicetree/bindings/arm/apple/*
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	arch/arm64/boot/dts/apple/
-- 
2.33.0

