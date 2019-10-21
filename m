Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 177A1DEC94
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 14:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfJUMou (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 08:44:50 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40362 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbfJUMon (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2019 08:44:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id b24so12630976wmj.5
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2019 05:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rhQapm9fDV832oC+He0CVqLo8g+PxtpKOAzMRPE4ljA=;
        b=SBC1Jrc19lIVahzliJlzcj/Hnqij4S94myxcPHBLA9zEUlN/GVXeoylmryNVMXOrJP
         AMqM0TmWJeJ2jnwQW5jjozOzz85wMSTmu/qeq19DwD6Fe83klABDaLc5I1muCg+3552A
         vBesukBR5YimyIIQuiQXj1aNW2bq1gtZkE7uDt2/axaLuQhQ5lDwT//z+kxpqfi7SOwJ
         B842g6llfCc43wexMtAHB2ULxyKqFl21aSlroUBkH/M6PxtxIlmFCxKcB97pcNaMrdDF
         U3T/VM2Pst7QUmtjBV0UHZLgvoenozdv3WjwfO8QDqoX+pREdnixx5AsqR6iw3jab1hf
         xanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rhQapm9fDV832oC+He0CVqLo8g+PxtpKOAzMRPE4ljA=;
        b=p0H4Du+xLUojKxLsUL7z7G0I8J5ICUWXqfoEcw4k0tM9OBokKQmgDNetSJJJqk0NRJ
         hiT+Q+59/Mkr1vbDjrV2F0Wi3S5ndyIm/eIgoOrJd/Tyj5T7sxJuN6t+TscbeCn7PaJp
         Rkjr2jsAHrS/wvhXCt5uA61bwdJa4qkOyU2UG07RaI0oqIYkzSJwi3COG1oNLMHZBD3q
         hFd2z+7i48D/1CSz0dC7RYWhVywaCxz3ttA0o7t3jv7GkudeGSxMYUff4746AJvmBsOx
         dwumlSt4bfDwG5t3SeuEckGSKiIfPF4stWAvvKjcJwt0p9HxViP2vAcdVS/2rPbRf92n
         +GRw==
X-Gm-Message-State: APjAAAV8lT5+s5HDoOHm+1MdpU/4WlEP/JQWMj9zw9qh2sQn+xKMPYeg
        K/fyGQDi1OjewvY346IJWF4Oyw==
X-Google-Smtp-Source: APXvYqy97iy8LODbmza0VVhEd9vUSnqiJRhFbIOhJEubSikBBqKyqGMAsMgyja4luXC1VK6jdC7/kw==
X-Received: by 2002:a7b:cc07:: with SMTP id f7mr18270855wmh.56.1571661879823;
        Mon, 21 Oct 2019 05:44:39 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a17sm10216150wmb.8.2019.10.21.05.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 05:44:39 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 5/6] dt-bindings: mfd: max77650: convert the binding document to yaml
Date:   Mon, 21 Oct 2019 14:44:27 +0200
Message-Id: <20191021124428.2541-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191021124428.2541-1-brgl@bgdev.pl>
References: <20191021124428.2541-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Convert the binding document for MAX77650 core MFD module to YAML.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../devicetree/bindings/mfd/max77650.txt      |  46 ------
 .../devicetree/bindings/mfd/max77650.yaml     | 149 ++++++++++++++++++
 2 files changed, 149 insertions(+), 46 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.yaml

diff --git a/Documentation/devicetree/bindings/mfd/max77650.txt b/Documentation/devicetree/bindings/mfd/max77650.txt
deleted file mode 100644
index b529d8d19335..000000000000
--- a/Documentation/devicetree/bindings/mfd/max77650.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-MAX77650 ultra low-power PMIC from Maxim Integrated.
-
-Required properties:
--------------------
-- compatible:		Must be "maxim,max77650"
-- reg:			I2C device address.
-- interrupts:		The interrupt on the parent the controller is
-			connected to.
-- interrupt-controller: Marks the device node as an interrupt controller.
-- #interrupt-cells:	Must be <2>.
-
-- gpio-controller:	Marks the device node as a gpio controller.
-- #gpio-cells:		Must be <2>. The first cell is the pin number and
-			the second cell is used to specify the gpio active
-			state.
-
-Optional properties:
---------------------
-gpio-line-names:	Single string containing the name of the GPIO line.
-
-The GPIO-controller module is represented as part of the top-level PMIC
-node. The device exposes a single GPIO line.
-
-For device-tree bindings of other sub-modules (regulator, power supply,
-LEDs and onkey) refer to the binding documents under the respective
-sub-system directories.
-
-For more details on GPIO bindings, please refer to the generic GPIO DT
-binding document <devicetree/bindings/gpio/gpio.txt>.
-
-Example:
---------
-
-	pmic@48 {
-		compatible = "maxim,max77650";
-		reg = <0x48>;
-
-		interrupt-controller;
-		interrupt-parent = <&gpio2>;
-		#interrupt-cells = <2>;
-		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-
-		gpio-controller;
-		#gpio-cells = <2>;
-		gpio-line-names = "max77650-charger";
-	};
diff --git a/Documentation/devicetree/bindings/mfd/max77650.yaml b/Documentation/devicetree/bindings/mfd/max77650.yaml
new file mode 100644
index 000000000000..4a70f875a6eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/max77650.yaml
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/max77650.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MAX77650 ultra low-power PMIC from Maxim Integrated.
+
+maintainers:
+  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
+
+description: |
+  MAX77650 is an ultra-low power PMIC providing battery charging and power
+  supply for low-power IoT and wearable applications.
+
+  The GPIO-controller module is represented as part of the top-level PMIC
+  node. The device exposes a single GPIO line.
+
+  For device-tree bindings of other sub-modules (regulator, power supply,
+  LEDs and onkey) refer to the binding documents under the respective
+  sub-system directories.
+
+properties:
+  compatible:
+    const: maxim,max77650
+
+  reg:
+    description:
+      I2C device address.
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+    description:
+      The first cell is the IRQ number, the second cell is the trigger type.
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+    description:
+      The first cell is the pin number and the second cell is used to specify
+      the gpio active state.
+
+  gpio-line-names:
+    maxItems: 1
+    description:
+      Single string containing the name of the GPIO line.
+
+  regulators:
+    $ref: ../regulator/max77650-regulator.yaml
+
+  charger:
+    $ref: ../power/supply/max77650-charger.yaml
+
+  leds:
+    $ref: ../leds/leds-max77650.yaml
+
+  onkey:
+    $ref: ../input/max77650-onkey.yaml
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+  - gpio-controller
+  - "#gpio-cells"
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/input/linux-event-codes.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@48 {
+            compatible = "maxim,max77650";
+            reg = <0x48>;
+
+            interrupt-controller;
+            interrupt-parent = <&gpio2>;
+            #interrupt-cells = <2>;
+            interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+            gpio-controller;
+            #gpio-cells = <2>;
+            gpio-line-names = "max77650-charger";
+
+            regulators {
+                compatible = "maxim,max77650-regulator";
+
+                max77650_ldo: regulator@0 {
+                    regulator-compatible = "ldo";
+                    regulator-name = "max77650-ldo";
+                    regulator-min-microvolt = <1350000>;
+                    regulator-max-microvolt = <2937500>;
+                };
+
+                max77650_sbb0: regulator@1 {
+                    regulator-compatible = "sbb0";
+                    regulator-name = "max77650-sbb0";
+                    regulator-min-microvolt = <800000>;
+                    regulator-max-microvolt = <1587500>;
+                };
+            };
+
+            charger {
+                compatible = "maxim,max77650-charger";
+                input-voltage-min-microvolt = <4200000>;
+                input-current-limit-microamp = <285000>;
+            };
+
+            leds {
+                compatible = "maxim,max77650-led";
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                    reg = <0>;
+                    label = "blue:usr0";
+                };
+
+                led@1 {
+                    reg = <1>;
+                    label = "red:usr1";
+                    linux,default-trigger = "heartbeat";
+                };
+
+                led@2 {
+                    reg = <2>;
+                    label = "green:usr2";
+                };
+            };
+
+            onkey {
+                compatible = "maxim,max77650-onkey";
+                linux,code = <KEY_END>;
+                maxim,onkey-slide;
+            };
+        };
+    };
-- 
2.23.0

