Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE1FC2129
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 15:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbfI3NDG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 09:03:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50692 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731092AbfI3NDG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 09:03:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id 5so13341776wmg.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2019 06:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zCXYF953/vPYwz7eiQFUSs/AEguNESyV96474n4IASY=;
        b=Nf+gaIXC0Ge/0BwRg9S/STvB6+9x02OEyJfwicPnb2ADufpdrmo1vfw+tYoQLsxxJ5
         5J4EjdPlP0rFxxFSexrYwZzTo5oXdX5EwgyQfHg9F21ZI9v8b1j4wtWm6C0VIUNaVB7f
         z2hYt7MBqAbNQkf+phMS5i3LywrehGo3y8a5z1RaPZ82gsF/Bx2JD+DMo6vou7CPXzQN
         sya1shbs/pjzjbzKs/nJ488uwxA1KCYAeLAuoz6h+eKPxL+q+fvymMKKxpOJ5LcM2xQ5
         3lSJJtz8j500+wft6PJYCtXXQ0QVa7CIuyQJOBbLKodGskE+BYV1vVN5uBLG3an/yC6E
         C99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zCXYF953/vPYwz7eiQFUSs/AEguNESyV96474n4IASY=;
        b=WRcAkFHDX+TfFZnN43pvr0id6PEZj8jyWMf8D5zsSvMXmmVdwhEr/IziYFWjjqGPlS
         l6WrGHJdZp4+OjnGAjkWNtqmg9n6j0S3U2rnV8vcLzgx9EX/PCKyFynCriYmmJvj0YEJ
         F/8RxFiGp/blRE1l8tKN+N6g6KAFIM1H6hO7fQ3xYCPYe55D5e8VEwMKTMR/Zp7uDdOf
         kjpRoydgKie/lpuhlorgdvMFIk8uDfXbOZmq6I/BL+2WWOpAqMZz6lOzai92ZRd2PaMC
         10hujKseR+Umqj5YfO7r+emoTQSO9oLpQZ096o17qNg1StGGA5HnTwwo8tIY9K/N//kR
         tA2Q==
X-Gm-Message-State: APjAAAVKp3yoG6ZRDmYnJE7T+Ne58VvFNdzfOM/3vTpVZ9qVYedopfbN
        9jMlWYvTmDPr2WSBz7SBX/4gXw==
X-Google-Smtp-Source: APXvYqx2obH7hRkkN4bY0nbY+Nu/cmpaQYw5+2PMIJMC3OXw+Li14HL6JkwFIeJb93ckMDFPY5G6tA==
X-Received: by 2002:a05:600c:238a:: with SMTP id m10mr18382086wma.51.1569848583334;
        Mon, 30 Sep 2019 06:03:03 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id e6sm10654756wrp.91.2019.09.30.06.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 06:03:02 -0700 (PDT)
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
Subject: [PATCH 5/6] dt-bindings: leds: max77650: convert the binding document to yaml
Date:   Mon, 30 Sep 2019 15:02:45 +0200
Message-Id: <20190930130246.4860-6-brgl@bgdev.pl>
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

Convert the binding document for max77650 LED module to yaml.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../bindings/leds/leds-max77650.txt           | 58 +------------
 .../bindings/leds/leds-max77650.yaml          | 82 +++++++++++++++++++
 2 files changed, 83 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-max77650.txt b/Documentation/devicetree/bindings/leds/leds-max77650.txt
index 3a67115cc1da..33d6ff23f0ef 100644
--- a/Documentation/devicetree/bindings/leds/leds-max77650.txt
+++ b/Documentation/devicetree/bindings/leds/leds-max77650.txt
@@ -1,57 +1 @@
-LED driver for MAX77650 PMIC from Maxim Integrated.
-
-This module is part of the MAX77650 MFD device. For more details
-see Documentation/devicetree/bindings/mfd/max77650.txt.
-
-The LED controller is represented as a sub-node of the PMIC node on
-the device tree.
-
-This device has three current sinks.
-
-Required properties:
---------------------
-- compatible:		Must be "maxim,max77650-led"
-- #address-cells:	Must be <1>.
-- #size-cells:		Must be <0>.
-
-Each LED is represented as a sub-node of the LED-controller node. Up to
-three sub-nodes can be defined.
-
-Required properties of the sub-node:
-------------------------------------
-
-- reg:			Must be <0>, <1> or <2>.
-
-Optional properties of the sub-node:
-------------------------------------
-
-- label:		See Documentation/devicetree/bindings/leds/common.txt
-- linux,default-trigger: See Documentation/devicetree/bindings/leds/common.txt
-
-For more details, please refer to the generic GPIO DT binding document
-<devicetree/bindings/gpio/gpio.txt>.
-
-Example:
---------
-
-	leds {
-		compatible = "maxim,max77650-led";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		led@0 {
-			reg = <0>;
-			label = "blue:usr0";
-		};
-
-		led@1 {
-			reg = <1>;
-			label = "red:usr1";
-			linux,default-trigger = "heartbeat";
-		};
-
-		led@2 {
-			reg = <2>;
-			label = "green:usr2";
-		};
-	};
+This file has been moved to leds-max77650.yaml.
diff --git a/Documentation/devicetree/bindings/leds/leds-max77650.yaml b/Documentation/devicetree/bindings/leds/leds-max77650.yaml
new file mode 100644
index 000000000000..bb541ff67f80
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-max77650.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/leds-max77650.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LED driver for MAX77650 PMIC from Maxim Integrated.
+
+maintainers:
+  - Bartosz Golaszewski <bgolaszewski@baylibre.com>
+
+description: |
+  This module is part of the MAX77650 MFD device. For more details
+  see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+  The LED controller is represented as a sub-node of the PMIC node on
+  the device tree.
+
+  This device has three current sinks.
+
+properties:
+  compatible:
+    const: maxim,max77650-led
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^led@[0-2]$":
+    type: object
+    description: |
+      Properties for a single LED.
+
+    properties:
+      reg:
+        description:
+          Index of the LED.
+        maxItems: 1
+        minimum: 0
+        maximum: 2
+
+      label:
+        $ref: "/schemas/types.yaml#/definitions/string"
+        description:
+          The label of this LED.
+
+      linux,default-trigger:
+        $ref: "/schemas/types.yaml#/definitions/string"
+        description:
+          String defining the default trigger assigned to this LED.
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+
+examples:
+  - |
+    leds {
+        compatible = "maxim,max77650-led";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led@0 {
+            reg = <0>;
+            label = "blue:usr0";
+        };
+
+        led@1 {
+            reg = <1>;
+            label = "red:usr1";
+            linux,default-trigger = "heartbeat";
+        };
+
+        led@2 {
+            reg = <2>;
+            label = "green:usr2";
+        };
+    };
-- 
2.23.0

