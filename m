Return-Path: <linux-pm+bounces-20622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EAAA14FE5
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 14:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A9B3A9047
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 13:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7EC1FFC5C;
	Fri, 17 Jan 2025 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3omWUm8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FD01FF7AC;
	Fri, 17 Jan 2025 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118901; cv=none; b=mUXzQVNBLmg6AvdqRVoEmTDl+UHux4mKkgDmFZJhu6s6Fq5YQgNQVvtPmWr41i58e9/AMpsn3kkRLmSmjxPCMcPbprs2NEoABPBX6k7KJSeZBpur5JD3ZlszLz2iEUezPFaky+6JducU8J5dLa2relKs40R9fgiJgMem8JlBYrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118901; c=relaxed/simple;
	bh=s0/CVJn5Z6GB25apRpp3jyDUE+HEG3h8rcgOQY8LjaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OfqtY3yyLgE9AzSnYBKtu6iY1uHTmiAMLbvpsShONEeDl5T67OtGb1q9PipCH2x6xjK2T0sBXfewGnYJYf+sVylLYhJGjEtrkzioFDbjy4frhosdMIBxjc31WZl1vDp5YJTKa7O+rGvAasfcdpKlrDF5B8mANUjEkOS6S87YyuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3omWUm8; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9e44654ae3so326025166b.1;
        Fri, 17 Jan 2025 05:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737118898; x=1737723698; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udekqa5IGYQ6//30MEBfC3nhcQXiHzNdob8oRA9txmE=;
        b=O3omWUm8PCEz2zqXwgxN/9TYGhO+QVHdudpWW/xNLGC/YY5bF53Ced+BsLSORthcQR
         LCoU9ovBLjwAeLmmvEvNqt62vsZ5KDiaviriGyZGES+aNyRFHRAsBfW/Aa7w1bF+BpkP
         Td2WvTag3IEvOjgkGmLivyP7wltpDi/8GUnlpkpPAj8fVuqFR+l64/oVqZ6O+ShyCuKr
         CL6ZDAi3VkhCxgYBK2Fl4Ki8GlMEtHtx2LQCQ+c379+0rY3ZyOEqvKfH3/9H12akJwcL
         LOkpuOeHSyw0Rg7fqsKaxLGn+nUSBjvdkqp1Q7C70e9lrohWdvfc0wqso+kf6tc0jXl/
         CsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737118898; x=1737723698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udekqa5IGYQ6//30MEBfC3nhcQXiHzNdob8oRA9txmE=;
        b=RgH/mHeACHiLXkGyb1gZScJ7KbgEaJpHVqC1bA/tQmRhralqGPDYMSqy7wSFucZ24L
         7VwaoTg0DNWk6Ej8cywBDo33vrrvZZOg7R1B06f+dzxj4cALaPXROEXKfXO4Z6334cJJ
         tP7e66NDzZUle9fVmKjWyZErr5QmvZpoaxIgdIgdK8IoX1JW0EBCQ8jCmSCrUk9O6Vqh
         LdjyCq3XWD6X2+IHVZoReVIvi1lcjFN1vERQDEV3OHPYd764xzhlP6F2+a1CzM01EvsF
         4BSQHQVFtEY0RNiHhYNaB2XTXnM7Wiu9UgexuNcs8ofbPmlR2U8utfYbVjuqP6kYocdO
         UoGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGJTIYZWi8ksQrqTaTuHz6IktoyJ2N0+G4zve+vBTW3nHvcQuM+NomnKzT/R9dRFrCe+8XBH/e17tjGroV@vger.kernel.org, AJvYcCVcpMk+StRYxJqMeD9VUzh7o6nzwV7+oYGdv6Rmysq3x5m1Wunuerry4eJDtm9nQHX9165xZ1IODPH8tQ8=@vger.kernel.org, AJvYcCVyKH0bLiWggx28zD9ZSKxmjpEFZt7WbVnTlVkqh7MFT9LUuOrwHqNgyffHIgONMIQA5DibFSlz9ctP@vger.kernel.org, AJvYcCXtEWje+2lph0+5QrSDXcppGCpM97TxrYOMjosWe407CotYQ9g+uB0S/NSz89GZKIG9VZF3ZX/eQ2w1JA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYFy93VFQ4ZflL8Qxu6D5OeaQSBZHNag1KBclmGcF0jI8oCsSM
	VAq3VVqcpxkFPwhuW0vWMe0b9k5xWnsMfTE14pjPVyPj/ed/kzzv
X-Gm-Gg: ASbGncvASfX2Dy9NpGD4Z+7WmpBZuqA4HhdtkWl1mCEQiupByyDBkwtOlISMRAQ8vt2
	4nlh1AzwbjcBNylAT9Kf4MPQZYFX19tM9v/nyFZhfSWKqLvoo6E++BbEq0XIBqmcR4vZxK0lHTj
	w4qKlnbtFbjDZdAbNuXACXDzUSUPI2A22+degh52sgnR+lyF67JC5/ZEwsO9baMbin9VS0yHFEU
	it7Q7Q6wfdm6moWjxVIhRbCC10r7Uq6qSqMD/nIA+LrqXqqCcX5A3expi07XdPI3VisO1zW1BkZ
	yD5+IR7LjdQEHP89SQJQZiwVaA==
X-Google-Smtp-Source: AGHT+IF/2tW7mX1skotjDF56i5TZwvWrs8uzZSq805YoYHF0vPmt0LBTEpx33iKT2A6M3izTaz+h3w==
X-Received: by 2002:a17:907:7b81:b0:aa5:44a8:9ae7 with SMTP id a640c23a62f3a-ab38b3d64e3mr218766366b.47.1737118897250;
        Fri, 17 Jan 2025 05:01:37 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384d2d69fsm166289166b.79.2025.01.17.05.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 05:01:36 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 17 Jan 2025 16:01:29 +0300
Subject: [PATCH v16 2/7] dt-bindings: mfd: add maxim,max77705
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-starqltechn_integration_upstream-v16-2-11afa877276c@gmail.com>
References: <20250117-starqltechn_integration_upstream-v16-0-11afa877276c@gmail.com>
In-Reply-To: <20250117-starqltechn_integration_upstream-v16-0-11afa877276c@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737118892; l=6790;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=s0/CVJn5Z6GB25apRpp3jyDUE+HEG3h8rcgOQY8LjaM=;
 b=5IT9b0bHeUlMnmH3kjpeKeuUK3h4IBtzra3m7MxugkflVn2cFNwG+StkZoc3vTMjmO0EcH/b1
 29I/6iT8dNFAQE1DhuX5A9cFY8b7S+Y3lgNNNvWBiDrUT/44A5ekXoD
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add maxim,max77705 binding part, containing leds controller and haptics.
Charger and fuel gauge are separate device, thus not included.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v14:
- add reviewed trailers
- move "patternProperties" after the "properties:" block

Changes in v13:
- drop unused address-cells and size-cells properties

Changes in v12:
- revert: description: mention this is a part
- adjust commit message

Changes in v12:
- move fuelgauge bindings to separate patch because separate device
- move charger bindings to separate patch because separate device
- description: mention this is a part

Changes in v11:
- remove reviewed tags because of major changes
- none of children are supposed to have addresses, all nodes are
unit-less

Changes in v10:
- leds: replace label with color and function properties
- leds: add support for leds-class-multicolor
- move fuelgauge node to patternProperties "^fuel-gauge@[0-9a-f]+$"
  to comply with max17042 binding

Changes in v9:
- replace max77705 fuel gauge with max17042
- remove monitored battery because not supported by max17042

Changes in v8:
- fix leds compatible

Changes in v6:
- unevaluatedProperties must be false
- drop excessive sentence from description,
  just describe the device
- change leds compatible to maxim,max77705-rgb

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
 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 158 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                                               |   1 +
 2 files changed, 159 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
new file mode 100644
index 000000000000..0ec89f0adc64
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
@@ -0,0 +1,158 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/maxim,max77705.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77705 Companion Power Management and USB Type-C interface
+
+maintainers:
+  - Dzmitry Sankouski <dsankouski@gmail.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX77705.
+
+  Maxim MAX77705 is a Companion Power Management and Type-C
+  interface IC which includes charger, fuelgauge, LED, haptic motor driver and
+  Type-C management.
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
+      Up to 4 LED channels supported.
+
+    properties:
+      compatible:
+        const: maxim,max77705-rgb
+
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+      multi-led:
+        type: object
+        $ref: /schemas/leds/leds-class-multicolor.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          "#address-cells":
+            const: 1
+
+          "#size-cells":
+            const: 0
+
+        patternProperties:
+          "^led@[0-3]$":
+            type: object
+            $ref: /schemas/leds/common.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              reg:
+                maxItems: 1
+
+            required:
+              - reg
+
+    patternProperties:
+      "^led@[0-3]$":
+        type: object
+        $ref: /schemas/leds/common.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            maxItems: 1
+
+        required:
+          - reg
+
+    required:
+      - compatible
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
+                compatible = "maxim,max77705-rgb";
+
+                multi-led {
+                    color = <LED_COLOR_ID_RGB>;
+                    function = LED_FUNCTION_STATUS;
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    led@1 {
+                        reg = <1>;
+                        color = <LED_COLOR_ID_RED>;
+                    };
+
+                    led@2 {
+                        reg = <2>;
+                        color = <LED_COLOR_ID_GREEN>;
+                    };
+
+                    led@3 {
+                        reg = <3>;
+                        color = <LED_COLOR_ID_BLUE>;
+                    };
+                };
+            };
+
+            haptic {
+                compatible = "maxim,max77705-haptic";
+                haptic-supply = <&vib_regulator>;
+                pwms = <&vib_pwm 0 50000>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 6e04c83eb5cb..08a9548cd49c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14184,6 +14184,7 @@ B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/*/maxim,max14577.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
+F:	Documentation/devicetree/bindings/*/maxim,max77705*.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77843.yaml
 F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
 F:	drivers/*/*max77843.c

-- 
2.39.5


