Return-Path: <linux-pm+bounces-20566-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EA0A13F5D
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 17:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41A53A6BAA
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3271C22D4E2;
	Thu, 16 Jan 2025 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHtSyZZL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F8422CBF0;
	Thu, 16 Jan 2025 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044779; cv=none; b=j6eN8/7+daZln3GqZTuhpfCq3QdiJqLr99l3IQM8q9BR/aBiYVktfzfIaStd+DB2pP/6uI4QA/7y8U6ewGYja6kOZvqfocbToKeN2l7rw8HJ3Y/3q6E13uiP04d/DHgwq8alCT5NJthNvG+3e9bd7aWUHqfnRoHDMukVGSg10PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044779; c=relaxed/simple;
	bh=s0/CVJn5Z6GB25apRpp3jyDUE+HEG3h8rcgOQY8LjaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=abLA6z1fW1hmV0YQGJUxYPSyl3swRUNHt9I7QOLHGfVSujB442SQroOQggBELsJV2WsvcIu47ebq5BA7j4wIQ0t+YKDKWEYq9FpkXHh/pxtp8Zd1ak0Nga7ehOcrrX3sjIjLwNC6TpzU3iLePHcL/BEJ74//e9Ja7a7WzJrwN6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHtSyZZL; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df90so2003581a12.2;
        Thu, 16 Jan 2025 08:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737044775; x=1737649575; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udekqa5IGYQ6//30MEBfC3nhcQXiHzNdob8oRA9txmE=;
        b=dHtSyZZLFV3mQLl08fNMXm73gnKSFZq2dHxAWa+rU+oCSuJ5tjvkJac6D5tGkDVdOT
         IM8Uq4ynDkP/uYQhyUVvoOGnbCfSYzLOqTqTbSpMkTbjrsPVGvV2/d+TY3xLZZ+TlMQD
         UT+iR7AYq4CezlH1qebZ/6pX8wfQaA3N1hyrAgDIYB8RbgPII7bVltBDmOPxQylrsMKk
         6YxPKGbc76rzA0fhSIPcPtIJieTde20pX3tEPLH2XWZWrFZ7yJXnK5JiL6v7RwLG+C0w
         nfY1ynb8Hez2juQj39soxDdMhwOeRQHmp5J9gIoj8eqiVRTCi9odJlRGVHk9XPDKL6w0
         MOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737044775; x=1737649575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udekqa5IGYQ6//30MEBfC3nhcQXiHzNdob8oRA9txmE=;
        b=RrrXvzf9oKhluBZkWhMHRsGmKYbKDSgEiDNfXEVZl0mI4OtOAEjPCKnUB3DenqqToh
         fnvXXfE7OzHPssTR7uwN+5d+ia53qrc+Epon2pfQRjGU5QZmrTU421sVWKQUnMTO39Xn
         9PhOckdjZ1y3TczxK6e6d7dM/aFMV2zzdPfLLNQr9YXU0/Ifz708Uz2hzRKzWdEE1m74
         HRJP606HAuOJjVU0ckKMh2hgmBKye59stOKD5I4fnmKdGlhvf+QQBNxEoO0Yfv6i0o5r
         SfjXKJczmGmwBpHg6XDJvyAnNFRImNboiYyw7JxCH2rMnPE2cbWY0G9vqPs4el7CHA5e
         RUbA==
X-Forwarded-Encrypted: i=1; AJvYcCU6tv/F8MM4uXOSZxnL2+nPxBeWgnMJSr0kR7h41ja2c391ZLbphBfOtB+Pbi8NCuaFfz5QtIieboPU@vger.kernel.org, AJvYcCUTnOO2km8Z4hfyOCVVqkYBgVt6nEaUAr/iVZE3LpEryDfr1/6iGwIEvFc3qmYj2R6ujixozD9JoUvFTQ==@vger.kernel.org, AJvYcCV54LzCWYqDU96G3eLV42u3Rj7lPWPjKrukaDNvTCpDxMOHbHWR9zDjwteXkzPirjqlgnWg+sH6SDlzQXx6@vger.kernel.org, AJvYcCVzygpxkoghowiNJfWzdhkwfYMEmM96ys7WbpnhpuPk4kJmjCpvcoswmiDflhKg2w8+rGVQuYVC2HtddOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaehtv1d6yKHItZU6V/vCMiK/G1zPi4pg6m0h/uNk9gO3EzxBQ
	0v7ktDULWMu5nvvhO9VWWs7hv6pGdAlP5FCIgCWl9weJL74b+inS
X-Gm-Gg: ASbGnctn7fc5IBefmClAagIB4rlhSNzzmRq3DeOq8bdDvajdb1kDLsLwJKzI37m0/aX
	uV2VmyUy0/Md9v4Wcgml+AvNufbnstJLvWrGzkmFMOKXFEa1ttUBJ6KZd9niwAk+Y/ofddMOCEo
	kQO+6J47KGbwwOxBsv3Jb6/0LeImt8H1+arCbhJXL/J4LpxVY395wf9ySDkHZ009H+Vzhe6Vt9C
	A9P1S2H4NScfiXakcqDdd8KZOb4JN4KRD5RTAmxJm3AvS2cDENjeUcX5QtX5n1tt/jyazfDc27m
	mPhtaQZ+cM4mUml6qCzKO3gBZw==
X-Google-Smtp-Source: AGHT+IFJoR3f3ujGgARhH80rP1Wb0FEhA0x8iv12pHc8wCFje9C4OODYtADwY6vaqfpAp4+g60rz1g==
X-Received: by 2002:a17:907:3e9e:b0:aaf:86a2:651f with SMTP id a640c23a62f3a-ab2abdc0a2emr3539102666b.38.1737044775131;
        Thu, 16 Jan 2025 08:26:15 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384f29260sm16411666b.94.2025.01.16.08.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 08:26:14 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 16 Jan 2025 19:26:04 +0300
Subject: [PATCH v15 2/7] dt-bindings: mfd: add maxim,max77705
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-starqltechn_integration_upstream-v15-2-cf229de9f758@gmail.com>
References: <20250116-starqltechn_integration_upstream-v15-0-cf229de9f758@gmail.com>
In-Reply-To: <20250116-starqltechn_integration_upstream-v15-0-cf229de9f758@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737044771; l=6790;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=s0/CVJn5Z6GB25apRpp3jyDUE+HEG3h8rcgOQY8LjaM=;
 b=QW1HiHnj4Jj8T71Ye+78yB0eDjA0DiiOTh03JbqPNvr8hnE23WBaD0ogloaMJxZ/F4yC1vplT
 rFvv4Q4n9GpCaoRaWZZpmj4C4w/PW5Tfz3grLyw/mj3CyIew95G/tqj
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


