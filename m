Return-Path: <linux-pm+bounces-14815-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBEC98713D
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 12:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A7162881F0
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 10:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72301AE85E;
	Thu, 26 Sep 2024 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy4Hdxbc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42441AE846;
	Thu, 26 Sep 2024 10:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346058; cv=none; b=nJkH0KVO9mBNnuUOr7Lcfv5JZkjE73jjVYQNwbDgYI+nj2IJsAmFllXGscfOs0xBAUqq4hPpxTzgRH6yyu5WNupN8JXsIE+bPRWLE5gZ7s82Cxm7o6GvVwQNGmS4zrDW5DbDCuINOGqwN6+C5U3OYCYfbXO7w8z2etfk62T0XR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346058; c=relaxed/simple;
	bh=uxXb5xMrAeZA/PGCI0cjUzdsJNW6qdUaqZhiqHlS0Us=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNdeeI66QudAQkd38D/Q/KibFFQ/XZ56ymIcSP1BZhHno5w8U3JLU7ptklKR0cdiT93LbwHTt80PE2hGsN4cBHiDutkaAfL7lnCtFx6A0Bl8hBDGrsmD1kOf1y10OMPxoHRbKZcUna8LJ63O+iU54rn1emZ7GS+Ccigz2YrFn6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hy4Hdxbc; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f754d4a6e4so9356471fa.3;
        Thu, 26 Sep 2024 03:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727346055; x=1727950855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCnK0YaRfOlDi/MQIp9RVs5sdcIVgQygzC7gFn5dGeU=;
        b=Hy4HdxbckSlUGQXa8zkTHVJVtVRFwGLgSBb5gfUOTQNd18qaua3wny3jJMM6dAdiya
         leM2tfqSfRBK9MAGjh+E6A2wUhuHkYqu9IednNBJ7Yh/QICqd/A7T7j3zmD9y3I9hHyb
         CyLqu3yAOLflyMNSHtuwQ9xIIzGkGdE9+/YzeJPEolBTWlTapiHNIrkYtjoSYz7rUGn0
         kGJMEK0k8a6cB1FYOzKkdfkTZPjlprJE/gmOA2a18XB/Spm80dJbCfirDjo9eSbLkQD7
         EmkQriJYkZqEUo+Lt/kGDKYZIUiYJ8Fbq75fFZYi4rgaoQPztugegqgh1+45NoZiIACi
         geTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727346055; x=1727950855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCnK0YaRfOlDi/MQIp9RVs5sdcIVgQygzC7gFn5dGeU=;
        b=m38Rq39OzBD98cUKzI4hVjtwant+S8ZU9QjDlkjSbN7dpquA/rwHDgoJyh0gFiOgeO
         Pm7KuhH6+kuJjoSW+LrwvAVAWCJBqsfTeciFwGccnLY2pneGv8vSgAwLV4F+dLbMJd1/
         PYiPpj20WrFM2GzcOVbswNFc6YwNiFLKrIrixNDFtHzN8hSnFFI9eOEDzeNMbmxxlkzg
         aDiSPSb1BHIG+1XMi6844Rr0io0HhpaDPbpXDUyVy9iCRTVxAeVUqRCVgQApMx6isirY
         DezVDAMK+2Imy3hmTARCZAq8HXu45JrgL/3To7SfqA9/nQW5AnbCu8JudaDZysRu966s
         WxRg==
X-Forwarded-Encrypted: i=1; AJvYcCUxjGxCgVJjMoDOv/My00zF7zyKLaCDnsC2q6cTZ6+f9sfJsT1lP2XIouqOBE3V7xpfXIov/8EZz2ROASLT@vger.kernel.org, AJvYcCVJvh5/R+RygzBFy7ysva50B8DQVO9QuiX1bssXegvcheoTG7b/JTLYAbhqjrelSfNcJrLfx4qSer4OFtY=@vger.kernel.org, AJvYcCVKu21mEmIH03G10314/LSd/+jBg6DWOKS8ylrPVAJzwWvVts8MigonF0FlBGNPZ+9vOk3MNTGu0Ea7dQ==@vger.kernel.org, AJvYcCWjnjelSWK6M3+SqQbu9FURu1BWO+I8tefrjgQ2RjY3qlZOCbiJUZTmWtXxgF3VmxY+1kF+FRaW9CWc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3foj6ryVUznqsQEnBbSz9Kfq5PTRqZrEIXVAiBdHjPSkyiMcJ
	aNQ/OHH3X0d2qQtSq7TOwcLoV3A+l+qX99Y5VOMRh0ud73miJtHk
X-Google-Smtp-Source: AGHT+IFLi7YOGKzuax+KcCUegsiaf2QaWmNNgn1R7oRerwNKtavza4YaP78iTb6sd/Szi7OA/3PUyg==
X-Received: by 2002:a05:6512:128b:b0:536:54df:bffa with SMTP id 2adb3069b0e04-5387755cc03mr3766963e87.45.1727346054440;
        Thu, 26 Sep 2024 03:20:54 -0700 (PDT)
Received: from [127.0.1.1] (mm-20-1-84-93.mgts.dynamic.pppoe.byfly.by. [93.84.1.20])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-537a85ee54esm759071e87.96.2024.09.26.03.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 03:20:53 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 26 Sep 2024 13:20:19 +0300
Subject: [PATCH v5 2/7] dt-bindings: mfd: add maxim,max77705
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-starqltechn_integration_upstream-v5-2-e0033f141d17@gmail.com>
References: <20240617-starqltechn_integration_upstream-v5-0-e0033f141d17@gmail.com>
In-Reply-To: <20240617-starqltechn_integration_upstream-v5-0-e0033f141d17@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727346045; l=5974;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=uxXb5xMrAeZA/PGCI0cjUzdsJNW6qdUaqZhiqHlS0Us=;
 b=WXRUTUfi2U1BjuENigKHUDmWDT0lBX+fbUF5LD0EuF/KT7VFRrJLiL8dbWy0RmsryYXiCJuqp
 w5uLmcubT2EArJjmQ14n3WaNxJBIoY3OLJ2fWM0M10TJd6g6E38kGk3
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add maxim,max77705 core binding part.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
Changes in v5:
- formatting changes
- add unevaluatedProperties: false for nodes referencing
  common schemas
- remove additionalProperties on nodes with
  unevaluatedProperties: false
- add min and max to led index
Changes in v4:
- change dts example intendation from tabs
 to spaces
- remove interrupt-names property
- remove obvious reg description
- split long(>80) lines
---
 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 177 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                                               |   1 +
 2 files changed, 178 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
new file mode 100644
index 000000000000..214515f84c85
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
@@ -0,0 +1,177 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/maxim,max77705.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77705 Companion Power Management IC and USB Type-C interface IC
+
+maintainers:
+  - Dzmitry Sankouski <dsankouski@gmail.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX77705 multi functional
+  device.
+
+  The Maxim MAX77705 is a Companion Power Management and Type-C
+  interface IC which includes charger, fuelgauge, LED, haptic motor driver and
+  Type-C management IC.
+
+properties:
+  compatible:
+    const: maxim,max77705
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  charger:
+    $ref: /schemas/power/supply/power-supply.yaml
+    unevaluatedProperties: true
+    properties:
+      compatible:
+        const: maxim,max77705-charger
+
+    required:
+      - compatible
+      - monitored-battery
+
+  fuel-gauge:
+    $ref: /schemas/power/supply/power-supply.yaml
+    type: object
+    unevaluatedProperties: true
+    description: MAX77705 fuel gauge with ModelGauge m5 EZ algorithm support.
+
+    properties:
+      compatible:
+        const: maxim,max77705-fuel-gauge
+
+      shunt-resistor-micro-ohms:
+        description:
+          The value of current sense resistor in microohms.
+
+    required:
+      - compatible
+      - shunt-resistor-micro-ohms
+      - monitored-battery
+      - power-supplies
+
+  haptic:
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: maxim,max77705-haptic
+
+      haptic-supply: true
+
+      pwms:
+        maxItems: 1
+
+    required:
+      - compatible
+      - haptic-supply
+      - pwms
+
+  leds:
+    type: object
+    additionalProperties: false
+    description:
+      Up to 4 LEDs supported. One LED is represented by one child node.
+
+    properties:
+      compatible:
+        const: maxim,max77705-led
+
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^led@[0-3]$":
+        $ref: /schemas/leds/common.yaml#
+        type: object
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            description: LED index.
+            minimum: 0
+            maximum: 3
+
+        required:
+          - reg
+
+    required:
+      - compatible
+      - "#address-cells"
+      - "#size-cells"
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@66 {
+            compatible = "maxim,max77705";
+            reg = <0x66>;
+            interrupt-parent = <&pm8998_gpios>;
+            interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+            pinctrl-0 = <&chg_int_default>;
+            pinctrl-names = "default";
+
+            leds {
+                compatible = "maxim,max77705-led";
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@1 {
+                    reg = <1>;
+                    label = "red:usr1";
+                };
+
+                led@2 {
+                    reg = <2>;
+                    label = "green:usr2";
+                };
+
+                led@3 {
+                    reg = <3>;
+                    label = "blue:usr3";
+                };
+            };
+
+            max77705_charger: charger {
+                compatible = "maxim,max77705-charger";
+                monitored-battery = <&battery>;
+            };
+
+            fuel-gauge {
+                compatible = "maxim,max77705-fuel-gauge";
+                monitored-battery = <&battery>;
+                power-supplies = <&max77705_charger>;
+                shunt-resistor-micro-ohms = <5000>;
+            };
+
+
+            haptic {
+                compatible = "maxim,max77705-haptic";
+                haptic-supply = <&vib_regulator>;
+                pwms = <&vib_pwm 0 50000>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 5e467ba71e3b..5e5829f28631 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14069,6 +14069,7 @@ B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/*/maxim,max14577.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
+F:	Documentation/devicetree/bindings/*/maxim,max77705*.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77843.yaml
 F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
 F:	drivers/*/*max77843.c

-- 
2.39.2


