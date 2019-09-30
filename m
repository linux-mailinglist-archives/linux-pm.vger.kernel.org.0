Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17F47C2139
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 15:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbfI3NDd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 09:03:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51294 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731069AbfI3NDC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 09:03:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so13337938wme.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2019 06:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LYsu0lDWKxQ5G5EtJe6rqenJarRBonlZ3Wzg4XP51lM=;
        b=vkzdkYyv2bRGrVpXlSpwKW1x1i3bMfFqKHl5cSYQBhEh1uUC6r5j8/n3/+ZXRdqJKI
         avVUnCaR9hEQ4nmnEfQxdbaNF+0LwMEuhcodmBd2yOmBm6H4CskDhXbXwL/JXuLCC+qR
         EcUhrKv8nFvLg+trHNhrJGlgpXJH5odOS/q+9QvOgsBXS7oZGUz6JPGClRKCSokZ8xGh
         tA0tpnyV2ZKmFfjPLEpBrR6GCcNH3BVvREjdz+H7UGfLx38NYx/O2wwy4AwYuqnS25Ov
         ZaxDDwlAQswY1AdeOZA4X2+zZuqQBQfi3VCUQtoNdz1hMsSWRsbKf8Lbnwc6c1YAwDK1
         RYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LYsu0lDWKxQ5G5EtJe6rqenJarRBonlZ3Wzg4XP51lM=;
        b=e9MiemDmgAooWgTH8EmSiFGsEmYR7upQ4Kh0J6/ktW2lcfDnFkIm+5ZBplZYYQILug
         T1K6CThBGKEzrfNYY/aqaqi1VGbtK3vBr8rHqxINh/airLTw2qCuKpQvepWDcife+1kB
         CT4imgUHiNE7N/EQbGbExWyCdOaVFVFjtgFpdjqPrKu7kZBRhJONjom44wlxOfmsj6cI
         eJr8XLOKb3BtLMxckqc6cYAM9cAny5hYay5jJq6/9r/xa7tC3HwYMewtKis5gLIRholx
         xz2JxuFUs60CFvVUMYrmjceeWAQZPUQ6yM/sSMxm15mMZWMvqcDcKlfeSfFovVnCkfvi
         lCRA==
X-Gm-Message-State: APjAAAUY4VctIjJbVJds4DazxTAvk6bUtoBRrt5AYc4u31gc21MN5+BU
        M09TtrOW9GzJtpVlAV5vg04eVg==
X-Google-Smtp-Source: APXvYqyvZKOkmn0n9oatNC3JwQ6hUqFw5xzAHpgRsWRv/OpnGW9BxVRR9MkFoMz95vAimW545q6P+Q==
X-Received: by 2002:a1c:cc0e:: with SMTP id h14mr17436338wmb.117.1569848578775;
        Mon, 30 Sep 2019 06:02:58 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id e6sm10654756wrp.91.2019.09.30.06.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 06:02:58 -0700 (PDT)
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
Subject: [PATCH 1/6] dt-bindings: mfd: max77650: convert the binding document to yaml
Date:   Mon, 30 Sep 2019 15:02:41 +0200
Message-Id: <20190930130246.4860-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190930130246.4860-1-brgl@bgdev.pl>
References: <20190930130246.4860-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Convert the binding document for max77650 core mfd module to yaml.

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

