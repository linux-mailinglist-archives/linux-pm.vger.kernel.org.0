Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446823B4AB9
	for <lists+linux-pm@lfdr.de>; Sat, 26 Jun 2021 00:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFYWui (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Jun 2021 18:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhFYWug (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jun 2021 18:50:36 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3D0C061767;
        Fri, 25 Jun 2021 15:48:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t3so15498846edc.7;
        Fri, 25 Jun 2021 15:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dR80kVehOdx/x2VVdmW6gMUYIEIHf9stq/Tuqmgz73g=;
        b=l/KVoqhJi9y+dCw8stg/+wrEMRRHU7HgGahj+G7CEukYhWNjg0/DDNWUYC3id1vXTj
         X1ZKrgmpFMIGtf5vn/kbUL0eIPZDeOhcWNcfpZK23u+9/wX+AD8Cu36u5VcvcCOf9YvK
         7ImOyGv36tFX6ycDkD6aDVzU3ClxFIh8+XaXYx4wRbyb15wx+jHX1gI/KN/A5nkyVqK/
         Qu1qcb/4Hht5V11dxdJEpHNQUowGsn0WbfuPtgPBVvYE7XqlKeTHAZzla/wN4Xk+PBGV
         NcIluFHjFEIO4RTB/PzDNY4f43AVedaDUrWyoD456FZuh1BgPOaqts0S2INAPsRdJvdV
         korw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dR80kVehOdx/x2VVdmW6gMUYIEIHf9stq/Tuqmgz73g=;
        b=fOT34nQnylKQ9xGNoj3lDzen9Cdu6OtMuf3F4ARs4uPwU6zAX7k9iq9B1DMu7cpNui
         YGGtImgw2LzyQ0YbKQaEp7jZLRcTwU7UZMRWZEFLUoD+U0iV6kWP6nt1V+8/hcWT5tR5
         XBv/wREPapT1IWqLZ0UAc+lwKJf3GVNOOzpILME1OBbZVW4YIEQKewMnxd5VmAXA5jWo
         PKMkYfgdgpMs8tceO2zGyI5hcmOygZj8ThthTwexGN2JOi/J0wosUlsxHjgdVuqMu2MS
         HseXpN8wftvVytoyYYXJqCodCrOP6lYiCrsrJy6XJYD3Ce8ca3hFr9yWTeltjfxbQNVO
         BxFQ==
X-Gm-Message-State: AOAM533kkOUpx44/KreTekOPde7lHtXFT2AsMPOMINhorepEeRtHeovS
        5SoVDZ0Ui/G5cIjQ4md54C4=
X-Google-Smtp-Source: ABdhPJwhW2ixLOeJvmFQKHCdluE4GE/s8tC1qRVDvuLaljtCsUuHRO4bigEtwFVQRMVCknexklyc5A==
X-Received: by 2002:a05:6402:90b:: with SMTP id g11mr17982157edz.336.1624661291117;
        Fri, 25 Jun 2021 15:48:11 -0700 (PDT)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id w1sm4719399edr.62.2021.06.25.15.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 15:48:10 -0700 (PDT)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: mfd: convert tps65086.txt to YAML
Date:   Sat, 26 Jun 2021 00:47:42 +0200
Message-Id: <20210625224744.1020108-2-kernel@esmil.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210625224744.1020108-1-kernel@esmil.dk>
References: <20210625224744.1020108-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This converts the tps65086.txt binding description to YAML schema so
dts files can be verified automatically.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
@Andrew: The dt-bindings meta schema requires a maintainer entry. I hope
it's ok that I've added you, otherwise I don't know who should be
listed.

 .../devicetree/bindings/mfd/ti,tps65086.yaml  | 127 ++++++++++++++++++
 .../devicetree/bindings/mfd/tps65086.txt      |  54 --------
 2 files changed, 127 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/tps65086.txt

diff --git a/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
new file mode 100644
index 000000000000..ba638bd10a58
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
+  - Andrew F. Davis <afd@ti.com>
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
+        pmic: tps65086@5e {
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

