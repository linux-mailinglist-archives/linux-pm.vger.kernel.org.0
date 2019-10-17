Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A67E5DA61A
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 09:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407985AbfJQHMx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 03:12:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43398 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407986AbfJQHMt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 03:12:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id j18so992977wrq.10
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 00:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jtsw/4UntyGw67VLNOhcjzxELMgX+JeILTIqyblBVJA=;
        b=X5JinmjgIkKJQpv+P0y918lzg/UTXtP4Z13GlneUwVOYLulrog7RUzvQX265GH7ylP
         FsUKjc8aqMXvXm0tNHlejVzh4KUoqzLcG+3Co3q9WswjCUn6kRSVx7Fp0dNyBe4ScMYp
         IJLRVe28ScqUUH+UbM3v/n95UL+yg9ojO6ujD4TSCvTqkiZbG8+K4FqYqhfwq+gb6mbR
         bq2jT5OTuKVmGdztMKaQ40ByU2zJ8bYKRz/1RPNa0lrJXA2YNdItFfbdnDslFyLl2HTd
         ttPzG4qc8j2WhxAPmSwNGEhiLgzekgtWGOwWM33aH5BCSEvi0ZFipsLQaxljc+gN9sn+
         pwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jtsw/4UntyGw67VLNOhcjzxELMgX+JeILTIqyblBVJA=;
        b=BEpAz7gp5NF5B8m3BIdf62T/YXJK/5IqlFXbk/hOTOaL3QOwdoSBH0aQ+nS46D7mar
         kfMxrYd4aVW1c0fGttnie4CXjxSvLtGOiz/9LJ3MamI/nCJ/YT1WamqzZ8jMAimZjY+C
         Qz+1u/FlFLORy90A3GJtwWnPzc5QGTQ84XJUoSCDcrcCh5FrXzdE28w1vc8Mvv4YP6zs
         uAXAdGT9BxNEGF5znfB6WSeLXt2GHO48sKrkmRQqmfTZm18JpjtSb36wmSalPeLZT0xa
         sE+OXykOpB3iE3cLphHSYDGKH+/uqCEmzvzcUrrtAwkgcRc3AB8MYQYA1wJnvBiDfI7K
         wIYQ==
X-Gm-Message-State: APjAAAX18na/+WXfk2vUEoKCRdc8uwUrSgGi+ER0aZ4DBCfOn4/zwOra
        fiU9V+3+TQQQZsWvqCDYDutBS/r7Xnc=
X-Google-Smtp-Source: APXvYqyPWRtRA3k0xfBXvBUSlg1Os88tTfLyaCX/42y39vz4G0ZtDBffgj2tM1dmUbbG6BeCHtrXdQ==
X-Received: by 2002:a5d:4302:: with SMTP id h2mr1674992wrq.35.1571296366334;
        Thu, 17 Oct 2019 00:12:46 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id n22sm1156689wmk.19.2019.10.17.00.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 00:12:45 -0700 (PDT)
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
Subject: [PATCH v3 5/6] dt-bindings: leds: max77650: convert the binding document to yaml
Date:   Thu, 17 Oct 2019 09:12:33 +0200
Message-Id: <20191017071234.8719-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191017071234.8719-1-brgl@bgdev.pl>
References: <20191017071234.8719-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Convert the binding document for MAX77650 LED module to YAML.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../bindings/leds/leds-max77650.txt           | 57 ------------------
 .../bindings/leds/leds-max77650.yaml          | 58 +++++++++++++++++++
 2 files changed, 58 insertions(+), 57 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-max77650.txt b/Documentation/devicetree/bindings/leds/leds-max77650.txt
deleted file mode 100644
index 3a67115cc1da..000000000000
--- a/Documentation/devicetree/bindings/leds/leds-max77650.txt
+++ /dev/null
@@ -1,57 +0,0 @@
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
diff --git a/Documentation/devicetree/bindings/leds/leds-max77650.yaml b/Documentation/devicetree/bindings/leds/leds-max77650.yaml
new file mode 100644
index 000000000000..5a1e256185bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-max77650.yaml
@@ -0,0 +1,58 @@
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
-- 
2.23.0

