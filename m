Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19DE9D7B3C
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 18:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbfJOQXP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 12:23:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46538 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387906AbfJOQXP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 12:23:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id o18so24575053wrv.13
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2019 09:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XUVahl6lQQfTwOULvlZwTKr25yI+4iuUdZYRUHEnntA=;
        b=zCAjIvinDVzNO70l4dp4gdcj7ySO2afbkHfthwm3r0kDIWzIuRkaNoBPOD6Tdpwkct
         5JC+DH9JW1irmJT7dEoZfQ9bXhs7yEPHGFmD+P8i9MbXsvvSV1Am5NRtyhzZAnDm7t50
         XNRCg59aJCEDRTDKxHmQDAuELIdUCdCLaXrRJhYQW1h8JQuyHRyHNHXadCrtMlsddHXy
         +xrwk+23oq8yM0sBjM1LVL/5owuYZ5/maEXsPee8fT+przZja6dclnhdirJAvytk1b1y
         z5vj8kbXhdfvdXEuocs+Tbg2g0+factEQ0zAxKrwVNNwWfOOLBr/MK2sm/4IQHifoord
         Dpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XUVahl6lQQfTwOULvlZwTKr25yI+4iuUdZYRUHEnntA=;
        b=FAo9VhZENQ92TtET2hOs+iVjfV80erCz47fO0flS0EjNiJ7bKXf5D0rWtqUPKWEJbG
         DW4y+QQ5v1Plw083bEVrhWSitR1YVnTCDugPV+yhL2wxb6/YtKq3CsNleSbCeRKuZwOX
         sPTlqWa/Kweaj1Ay7iM5o2GIzE41lkt2dbTC6LrSNgnWGHtIqbhuslKJ0rMxEdSdQ/L9
         g5QswzN2LaGzZH2VPrpRvH78zVgXzhzjkJhVuph20HuZFn/YG1D+0DZc2E33BMfZ/b/6
         p1TtovwOcL95LRRu2bYCzcwYz+n/xRhvAth1OwgQbeUWc+911vviKvjhjlGZA/c600oQ
         TRGg==
X-Gm-Message-State: APjAAAV9RblGAjvakHGflGzmo/5Yxny+wBWUeuRVZbg6+6FW9MA6Ej29
        v4LoniSnCbxWqgL/NPuKZBENlQ==
X-Google-Smtp-Source: APXvYqz2Rob4YSpRXeHsKe26sy8nQbqz8YkEL/sdbtCMLS/ttbTE1Pxl35Q5vvol6+WBRY/oxToMHg==
X-Received: by 2002:a5d:42c2:: with SMTP id t2mr3755409wrr.251.1571156592681;
        Tue, 15 Oct 2019 09:23:12 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id x129sm41427605wmg.8.2019.10.15.09.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 09:23:12 -0700 (PDT)
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
Subject: [PATCH v2 5/6] dt-bindings: leds: max77650: convert the binding document to yaml
Date:   Tue, 15 Oct 2019 18:22:59 +0200
Message-Id: <20191015162300.22024-6-brgl@bgdev.pl>
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

Convert the binding document for MAX77650 LED module to YAML.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Sebastian Reichel <sre@kernel.org>
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

