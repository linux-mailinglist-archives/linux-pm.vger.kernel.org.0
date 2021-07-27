Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA4C3D71E0
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jul 2021 11:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbhG0J0J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Jul 2021 05:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236027AbhG0J0J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jul 2021 05:26:09 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40965C061760;
        Tue, 27 Jul 2021 02:26:08 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h8so14481488ede.4;
        Tue, 27 Jul 2021 02:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EoeHY/3nuAUWfIArvanaCJFU5UlahVcN4a6IXN0XWGI=;
        b=rEq3M3Qu26IkonEhacBOomR34niv7k8EOGnpiudPzh0HCJVRk2OtyiNgW+gptaDpEu
         n5g9UHvnYTbv7kws7v0i3wNxNZBuobNrhxOuNGgk4iOabYTIKCifpa74NiGYQfLGFAnM
         Xd0RS/5Kt7zppmUmtR47p+NJ/Jog8pI6oCW2M1jL8vawOEZ2X3FFg3P8kgNNutU1syYH
         mtIZ3/XLyenLn5tGF50uyj1AEbzQeiQEdihxMqF2UL0S3v9CyHo9qk3Xys5ioNxfN4br
         fC8MPQwsk6k2yiR7/4nhCczzpbvGWAxvzmdmrLnJLsdNeovoHCsL3NQSDVUJEWDdrlP+
         xE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EoeHY/3nuAUWfIArvanaCJFU5UlahVcN4a6IXN0XWGI=;
        b=Tg3e68UcW47avqVtfDLEG2is7b8XuRUVBB8B2bFnI9JarYbEMVp3f/8eZKc9XJVqpD
         mL9ktOQiI4Swt2OotkGSPW8MPl0pxxl5Yau3Hunc41hjFBDVhEj7x7l4HwL77ASLZ6In
         +WiEIFh6gfFF9S6MJvYHnUotXXKBFIx08p506gAshPyAxnV3hr+lZZzHrUqK6rAXJ3aM
         X7qruCEwjsm5Qh3yn8vMa6rWxSAHTpcE5EX8O+qeStAj3pcXL5lVxum5F/nEDBqFJUDO
         apVjZIM/0MGI1LSnaVDoTxmELUjcULXyd/R1zikqHFietpq7Woubx41T7owq5HrsD+au
         4MYg==
X-Gm-Message-State: AOAM533Tb91VT5yh9KSR8FvevwpEO9/A6eEVzcKKLaW41xRPFP+ZcXaS
        OcWxQ9uthYnx9AvobrzcmUY=
X-Google-Smtp-Source: ABdhPJztKkfC5r4MvyKXKqYiqP4NxRiiapj7qR9oRaQthogY1RtrHB/HyIRUaKz6OW+b6EUIG1DfXA==
X-Received: by 2002:a05:6402:3507:: with SMTP id b7mr2683602edd.293.1627377966784;
        Tue, 27 Jul 2021 02:26:06 -0700 (PDT)
Received: from stitch.. ([82.192.166.82])
        by smtp.gmail.com with ESMTPSA id g3sm692369ejp.2.2021.07.27.02.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 02:26:06 -0700 (PDT)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: mfd: convert tps65086.txt to YAML
Date:   Tue, 27 Jul 2021 11:25:51 +0200
Message-Id: <20210727092554.1059305-2-kernel@esmil.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210727092554.1059305-1-kernel@esmil.dk>
References: <20210727092554.1059305-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This converts the tps65086.txt binding description to YAML schema so
dts files can be verified automatically.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 .../devicetree/bindings/mfd/ti,tps65086.yaml  | 127 ++++++++++++++++++
 .../devicetree/bindings/mfd/tps65086.txt      |  54 --------
 2 files changed, 127 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/tps65086.txt

diff --git a/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
new file mode 100644
index 000000000000..9f6e1349eadc
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,tps65086.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TPS65086 Power Management Integrated Circuit (PMIC)
+
+maintainers:
+  - Emil Renner Berthing <kernel@esmil.dk>
+
+properties:
+  compatible:
+    const: ti,tps65086
+
+  reg:
+    const: 0x5e
+    description: I2C slave address
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description: |
+      The first cell is the IRQ number. The second cell is the flags,
+      encoded as trigger masks from ../interrupt-controller/interrupts.txt.
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+    description: |
+      The first cell is the pin number and the second cell is used to specify
+      flags.  See ../gpio/gpio.txt for more information.
+
+  regulators:
+    type: object
+    description: |
+      List of child nodes that specify the regulator initialization data.
+      Child nodes must be named after their hardware counterparts:
+      buck[1-6], ldoa[1-3], swa1, swb[1-2], and vtt.
+      Each child node is defined using the standard binding for regulators and
+      the optional regulator properties defined below.
+
+    patternProperties:
+      "^buck[1-6]$":
+        type: object
+        $ref: ../regulator/regulator.yaml
+
+        properties:
+          regulator-name: true
+          regulator-boot-on: true
+          regulator-always-on: true
+          regulator-min-microvolt: true
+          regulator-max-microvolt: true
+          ti,regulator-step-size-25mv:
+            type: boolean
+            description: |
+              Set this if the regulator is factory set with a 25mv step voltage
+              mapping.
+          ti,regulator-decay:
+            type: boolean
+            description: |
+              Set this if the output needs to decay, default is for the output
+              to slew down.
+
+        additionalProperties: false
+
+      "^(ldoa[1-3]|swa1|swb[1-2]|vtt)$":
+        type: object
+        $ref: ../regulator/regulator.yaml
+
+        properties:
+          regulator-name: true
+          regulator-boot-on: true
+          regulator-always-on: true
+          regulator-min-microvolt: true
+          regulator-max-microvolt: true
+
+        additionalProperties: false
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
+  - gpio-controller
+  - '#gpio-cells'
+  - regulators
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic: pmic@5e {
+            compatible = "ti,tps65086";
+            reg = <0x5e>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            gpio-controller;
+            #gpio-cells = <2>;
+
+            regulators {
+                buck1 {
+                    regulator-name = "vcc1";
+                    regulator-min-microvolt = <1600000>;
+                    regulator-max-microvolt = <1600000>;
+                    regulator-boot-on;
+                    ti,regulator-decay;
+                    ti,regulator-step-size-25mv;
+                };
+            };
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/mfd/tps65086.txt b/Documentation/devicetree/bindings/mfd/tps65086.txt
deleted file mode 100644
index 67eac0ed32df..000000000000
--- a/Documentation/devicetree/bindings/mfd/tps65086.txt
+++ /dev/null
@@ -1,54 +0,0 @@
-* TPS65086 Power Management Integrated Circuit (PMIC) bindings
-
-Required properties:
- - compatible		: Should be "ti,tps65086".
- - reg			: I2C slave address.
- - interrupts		: The interrupt line the device is connected to.
- - interrupt-controller	: Marks the device node as an interrupt controller.
- - #interrupt-cells	: The number of cells to describe an IRQ, should be 2.
-			    The first cell is the IRQ number.
-			    The second cell is the flags, encoded as trigger
-			    masks from ../interrupt-controller/interrupts.txt.
- - gpio-controller      : Marks the device node as a GPIO Controller.
- - #gpio-cells          : Should be two.  The first cell is the pin number and
-                            the second cell is used to specify flags.
-                            See ../gpio/gpio.txt for more information.
- - regulators:          : List of child nodes that specify the regulator
-                            initialization data. Child nodes must be named
-                            after their hardware counterparts: buck[1-6],
-                            ldoa[1-3], swa1, swb[1-2], and vtt. Each child
-                            node is defined using the standard binding for
-                            regulators and the optional regulator properties
-                            defined below.
-
-Optional regulator properties:
- - ti,regulator-step-size-25mv	: This is applicable for buck[1-6], set this
-				    if the regulator is factory set with a 25mv
-				    step voltage mapping.
- - ti,regulator-decay		: This is applicable for buck[1-6], set this if
-				    the output needs to decay, default is for
-				    the output to slew down.
-
-Example:
-
-	pmic: tps65086@5e {
-		compatible = "ti,tps65086";
-		reg = <0x5e>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		gpio-controller;
-		#gpio-cells = <2>;
-
-		regulators {
-			buck1 {
-				regulator-name = "vcc1";
-				regulator-min-microvolt = <1600000>;
-				regulator-max-microvolt = <1600000>;
-				regulator-boot-on;
-				ti,regulator-decay;
-				ti,regulator-step-size-25mv;
-			};
-		};
-	};
-- 
2.32.0

