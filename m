Return-Path: <linux-pm+bounces-18571-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AA29E455D
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 21:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44A9280A75
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 20:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E81202C58;
	Wed,  4 Dec 2024 20:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTTx3pmN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA50A202C3E;
	Wed,  4 Dec 2024 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343017; cv=none; b=PRdyhPIdQWZUwOYKnEcVg/kBtx6ctDqV0MtT0A4ZEbky7mOqh1nqnj9cPxvXCZe35HkS0DSloJv7L0Fvp45azmcXFrd0giRyUsibWcxPlWt9hZWgGhosX7gw9RYYymZRHMBQjD2OLwtuT7JD+zHUGqMLRFK2dhghiYnW8Mp5KRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343017; c=relaxed/simple;
	bh=GcPAJcmgQsBjnD+AeltEQCEM6kPYnV+50KF7wvNCGCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BXa1/mtXTTSOdgnPzNK02LzzF64wYV1IOofe7nhegAgV4YjUoaVUMYH64BJtDP+RY58vYL0eX9RS9vU0XRuZf/KIRr5XM5+xo70GlWAl2CWYbMo+MSE8TYCJZ5j2lZiJICMlnKVWFfNlKJr4Mz1PTLkp40BpQycPNjvlYMb4pXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTTx3pmN; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa55171d73cso248153466b.0;
        Wed, 04 Dec 2024 12:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733343014; x=1733947814; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1JX45dzAmc+NPmjYhR9w1uYk2gWb/yZatWB9+wvU9E=;
        b=NTTx3pmNPC/e7pq6yzCpxM9tj/YPw/3Oq9MtmRNdWpYTIFFzq4jay/SBCwlBtJHV6r
         lYkNiM7bTLwu6uYJ6xmBCB6EXKO3dn644Xepg0rJiob/gjlJB50+lI42+5Lnh3WLXv41
         rXVIFHnb5s+nt5iQ1lbPQFc0J9rRezfTl4/ycK/ED4ZWL5n7sHOkhoXYig5kz4oX8YD6
         rWYC6AhNVNYHN6L/Wlpc2bRgghHH/T6Uqz7lA3XZEXfwiQut2xeF28XQfq+sAjXN9tKJ
         YxKfB1VhUZzdhBm349LN92hsg/aHoFOP/t7CflUSDQZTmwITWUvtyr1S5kcxPTyCoVaP
         xVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343014; x=1733947814;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1JX45dzAmc+NPmjYhR9w1uYk2gWb/yZatWB9+wvU9E=;
        b=PMHQvMsCJcVjBOXJiGPfn0LZHT4ag73MKggdLkSO57jTygPLKe70UF8lGp/9buo2tV
         RRHAFmNplUU70Pnkw+v7jemQcmesU+Ogr8uO/DUs5u8b3Ksx2dud6i9rvXFeLYIprS57
         pidFHl650YFIBjQXnjoJLby9CL1WqkteOqlCyR6SNk/435AonJ58OPWS3O8AzRhTi1qh
         cLRJNykTbEBlkaojPjjelbfNa+rbcCbCzuOq6n+YTZUpaXZcPjRl06m4bIwSyqhKD2XI
         n03njmVpcSPNfzGjxsR9BBfmEXwpYuk3VcSHLZM/A7Ou5wijQwXMpTcTzorhYHvRmoHW
         hqAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiW2UoqxcdqSQ+5u6feH/RzpoodZp4KwhCLgOfSwZBG+v6iemOF08SNeLrv+nqZvPLj29KFUcJXsS7@vger.kernel.org, AJvYcCVHe1VafApXJau+a8hXIdWzyypJov2EXTHIArbkgD4GFFbdQAKfTa2WvPLMayfBVaEUztDrynyL+GeyoA0=@vger.kernel.org, AJvYcCXGz3tXedIlrip/550+L7t8DYDoa87FK4RyiAJJCzZKrshnhV85Es7PN5ir0a+8i2XL9hinaF/AJZPTg4qi@vger.kernel.org, AJvYcCXgLMJ1ed7EMRF+Zd6qnzqaEyI3a/2bQucU5heE2+ai6j3blKY/s9qSi74k/Tw356LvrW0Cs3Spi5nYhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YydeDzp5391jPFyQCOaz2PPs8OgRzpOiMoBKhrTJKwFhBG70ggM
	RdxkUHernHbo1fNhOgNe+nJk58rB8R347AlDgye9EAl8Rx+vmyD6Bt+P9Q==
X-Gm-Gg: ASbGncs+N9D2lfiRNFVCvpMg7igpG+mkY4uHn8ujOScDhalLPM8bp/eyoNhu23eA6Mk
	HbOlADe07Fk7cCzqLm/v4ekMZtkC2U4GfkSfqKyhoxwb7YxWumiwL5rF4sHKcVwt0AuBEMj9qUp
	GORgBOUY9XSAVkUAFJRYGVT3oK3jrPQC7+HgoVefz5ZLTz8ixGXveWtwIGsHAaGDuODatfciWRy
	kX+kg/+kJ8Ag4FV3RI4h9Dl/MvGl35m76suQJV9Hs3kcLpj
X-Google-Smtp-Source: AGHT+IF5zZj32cneP8egZ7hKqsoLrc+A51m1eFy9C0nE1Ryy6P55W+1hax7X5o1AYGMeNCro6GtDmw==
X-Received: by 2002:a17:907:7da4:b0:a9a:6c41:50a8 with SMTP id a640c23a62f3a-aa621892191mr68048766b.17.1733343013831;
        Wed, 04 Dec 2024 12:10:13 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d0b7ce5584sm6266526a12.54.2024.12.04.12.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 12:10:12 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 04 Dec 2024 23:09:53 +0300
Subject: [PATCH v10 3/8] dt-bindings: mfd: add maxim,max77705
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-starqltechn_integration_upstream-v10-3-7de85e48e562@gmail.com>
References: <20241204-starqltechn_integration_upstream-v10-0-7de85e48e562@gmail.com>
In-Reply-To: <20241204-starqltechn_integration_upstream-v10-0-7de85e48e562@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733343003; l=6937;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=GcPAJcmgQsBjnD+AeltEQCEM6kPYnV+50KF7wvNCGCc=;
 b=sZ3R40P9FeOZX84YwAGGkjVXjtrRluQb4m+alR53tUIPU1AjthCCILyTaMCOAasV2HqIc7jjV
 HsOSKftjnBxCn0Ztg+5lLea8hi+ZxtPPB6wjdw9h5kthZ6sV66nS6Cs
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add maxim,max77705 binding.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
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
 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                                               |   1 +
 2 files changed, 193 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
new file mode 100644
index 000000000000..1bc026a01337
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
@@ -0,0 +1,192 @@
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
+  The Maxim MAX77705 is a Companion Power Management and Type-C
+  interface IC which includes charger, fuelgauge, LED, haptic motor driver and
+  Type-C management IC.
+
+properties:
+  compatible:
+    const: maxim,max77705
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  charger:
+    $ref: /schemas/power/supply/power-supply.yaml
+    unevaluatedProperties: false
+    properties:
+      compatible:
+        const: maxim,max77705-charger
+
+    required:
+      - compatible
+      - monitored-battery
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
+    required:
+      - compatible
+
+patternProperties:
+  "^fuel-gauge@[0-9a-f]+$":
+    $ref: /schemas/power/supply/maxim,max17042.yaml#
+    unevaluatedProperties: false
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
+            #address-cells = <1>;
+            #size-cells = <0>;
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
+            max77705_charger: charger {
+                compatible = "maxim,max77705-charger";
+                monitored-battery = <&battery>;
+            };
+
+            fuel-gauge@36 {
+                compatible = "maxim,max77705-battery";
+                reg = <0x36>;
+                power-supplies = <&max77705_charger>;
+                maxim,rsns-microohm = <5000>;
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
index 1240e75ecf4b..c3f66093edd1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14185,6 +14185,7 @@ B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/*/maxim,max14577.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
+F:	Documentation/devicetree/bindings/*/maxim,max77705*.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77843.yaml
 F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
 F:	drivers/*/*max77843.c

-- 
2.39.5


