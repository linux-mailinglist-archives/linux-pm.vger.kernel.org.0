Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 122B8D7B4D
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 18:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388009AbfJOQXe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 12:23:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50448 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387879AbfJOQXJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 12:23:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id 5so21581328wmg.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2019 09:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ex0SLXkZGXD3DFPb0/08PvEQYRToQtcPv9JSualxRuI=;
        b=BIJz1e/fCpl0NKvbL/GHwCFIzcJBblO+Nq6Cpv7EOXKlPk5kR2etqCqSpAVdnEafjy
         kuN+I3NsQr7MQzEmyfvk9SThXgsbwcHTjjjRNp/I1wwoFYCI+c+l7GthAeXxBESBEd5c
         NFrZYAkBvgHkaNDbRD4cGcJ4By4LGi+jq1aiMkORXyjKoqlZQkPYr5waREf2DTtMQJPZ
         2li2D6JTV4YhOD0s94JVlr9I5JiECTT4MnBLD9bX8aemqQgKJFrbPZ4uG4363CJYPJ+V
         /obMJ9e+AZG3RhubBMkscKFBZ6asziB4WpXFo9Gca1hdKfHJDvFvI3YUIn9isgVu21Xy
         3z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ex0SLXkZGXD3DFPb0/08PvEQYRToQtcPv9JSualxRuI=;
        b=sz8V3Akt2sCgXpaImfLtNgaq7DwOeefBg6Lt1wpXuH1rLdVLpLWkDfxhjzQgRhbVTC
         hd87QUNsM9c/UH5Ix8e7hnFdJuMqz4OeLw+11ljpfXAtQeEovFNVndcmd8senR2mh2Ht
         RAQ1Eb14bDa3mTwYw4aWTeo62L9DSRvzJV1XFJ1Mhn2yN5CtN8RVBnH8J7FaUQsXxd9I
         thSl3LuEvh201Kc08QoGgTkzwe8v2az5FIaE75mxCVLzWd3Bt3ttgEHrLWTVryj9uJZ1
         a/Z8rULRORrGl9A6E0sL48j32hHEc8s5lpsTVay/mSWY5w9yik+L6voeuwVTm9DLEnmh
         xfXA==
X-Gm-Message-State: APjAAAXftNDI1ynbDx/nV6ADkdATb+SYPc3aXgaN77xxv+cEQ+M79t0P
        zyeSUyts+Ap5u/uOlsi9eKLI/w==
X-Google-Smtp-Source: APXvYqxTfL2KaH12S3EeWh7aakG4qW2zEmhcGsL4Xn/pS39512jhH6exXh3kAyTmONoMUp1g+FGl5A==
X-Received: by 2002:a1c:f201:: with SMTP id s1mr19060581wmc.59.1571156587196;
        Tue, 15 Oct 2019 09:23:07 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id x129sm41427605wmg.8.2019.10.15.09.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 09:23:06 -0700 (PDT)
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
Subject: [PATCH v2 1/6] dt-bindings: mfd: max77650: convert the binding document to yaml
Date:   Tue, 15 Oct 2019 18:22:55 +0200
Message-Id: <20191015162300.22024-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015162300.22024-1-brgl@bgdev.pl>
References: <20191015162300.22024-1-brgl@bgdev.pl>
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
 .../devicetree/bindings/mfd/max77650.txt      | 47 +----------
 .../devicetree/bindings/mfd/max77650.yaml     | 83 +++++++++++++++++++
 2 files changed, 84 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.yaml

diff --git a/Documentation/devicetree/bindings/mfd/max77650.txt b/Documentation/devicetree/bindings/mfd/max77650.txt
index b529d8d19335..080871686b3b 100644
--- a/Documentation/devicetree/bindings/mfd/max77650.txt
+++ b/Documentation/devicetree/bindings/mfd/max77650.txt
@@ -1,46 +1 @@
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
+This file has been moved to max77650.yaml.
diff --git a/Documentation/devicetree/bindings/mfd/max77650.yaml b/Documentation/devicetree/bindings/mfd/max77650.yaml
new file mode 100644
index 000000000000..5186ad287ec7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/max77650.yaml
@@ -0,0 +1,83 @@
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
+  This document describes the DT properties of the core MFD controller.
+
+  The GPIO-controller module is represented as part of the top-level PMIC
+  node. The device exposes a single GPIO line.
+
+  For device-tree bindings of other sub-modules (regulator, power supply,
+  LEDs and onkey) refer to the binding documents under the respective
+  sub-system directories.
+
+  For more details on GPIO bindings, please refer to the generic GPIO DT
+  binding document <devicetree/bindings/gpio/gpio.txt>.
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
+    description:
+      The interrupt on the parent the controller is connected to.
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
+    $ref: '/schemas/types.yaml#/definitions/string-array'
+    maxItems: 1
+    description:
+      Single string containing the name of the GPIO line.
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
+    pmic@48 {
+        compatible = "maxim,max77650";
+        reg = <0x48>;
+
+        interrupt-controller;
+        interrupt-parent = <&gpio2>;
+        #interrupt-cells = <2>;
+        interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-line-names = "max77650-charger";
+    };
-- 
2.23.0

