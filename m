Return-Path: <linux-pm+bounces-18327-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC0D9DFDA2
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 10:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E530D1631E1
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 09:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9112A1FC7FA;
	Mon,  2 Dec 2024 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJ3OgW0j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E61A1FC0FE;
	Mon,  2 Dec 2024 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132893; cv=none; b=GHwTQukh6uHexlx3FbP5GEaoIkZK2NK5WqY4OsAysmBBXEtyHcnsyfmGoNkzxjEZ0cVxPLQYNlm9LkVgx8NhIqJvEPvwJZWYNq0MPF0WOMkbgBMAWda9xmuY+FNFSLlzFSCbTlfPoNkGMLqmblre/9Dis0rwPHSFGB6YYmkc//0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132893; c=relaxed/simple;
	bh=kSoIMsEyI5FQ+mbQvFip9d0Bq8H/VWKwGdAEJhaEXzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uvk0wjFcN/CtouIvG1sy/dS+Y8rzNq7ZHMl1Dg/xOIlDSRGS5zPygU3Y8Qk8QpaXGX3Zno2oDiqVkSVZ1alWdI9zdSIQz7TgnqJJBqeXukLpFKG+Nsbc3usPD4poHO7kbI2PKxQayQtEZRfXwX7TIGVFhUZsLns5oqoEhdnz2EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJ3OgW0j; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso535980066b.1;
        Mon, 02 Dec 2024 01:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733132890; x=1733737690; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ROh+ssRkigaZFqJs0rde83s3PLdGc63hrLp1rlTw+Eg=;
        b=YJ3OgW0jJmvEi6v5e3/tsiaj0hh8xI2t6C/tpdM/ToUfkNE3kevi293tICKpDE5kAI
         gKZhoIxqbOkOntp3XmJPf/1EqcoPXG5AAAX/9/QR1GH7xhV3n8rs+0IxR/fttye8mMxH
         gohPqi/NVEb2iYqbAIpAP7UblToZ2msURrTF1gxXEbZ+sH9ag3m39t03f6cH97ml9kNt
         bMuTmqzeRcIT5MjSzAPWH3p73vqs+30T2CTYGIvuy4vz29Gk1DQSoFY4I1Su0YMYJ72z
         vQVpDrn5yp0EUwaMGY2v/FcGE+jwh1C1TLDhxL1aCkjk9kQ35TMPNzUBjeyITTspCXqD
         vp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733132890; x=1733737690;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROh+ssRkigaZFqJs0rde83s3PLdGc63hrLp1rlTw+Eg=;
        b=q0w152kIvnwTr9Phsy1Q1Jnf3CWgiF/bKpVHZYm2xa7HTfcfymR3/jFL+IR9hKLtbA
         sale/n2ETHaIa1IIP5v43FC5viphBGgn/2SGL7VcOW2aeBqlc5yquHFtW/aP6cSuwdzq
         D/R5ZlG3X0tLavyYJY+vmxA7AHgymUa4ozW75QguyJq8hkMkNr/G/QbnWKaPOkQI0a9D
         DBfJSq98ydontxOeKTU0PrT7TA1z4mIWFIj1WI5II3CFvebp6nDGKhzu79ApcbDi6vs5
         Puoza+JdtX9B3cSb6zPk/frIyxU1UEUHNF+c2Hzl6tjo3buR9cGzbgrIkeRO7kq6JaU3
         Pm7A==
X-Forwarded-Encrypted: i=1; AJvYcCWGTeuMgeX9mMdk1UD3gKls5tG2ooQJe9OX2dNepDU1/N8GWL+1U/LEQ3f7eJyxpcRa+Zn9hrb2EZrOmeWy@vger.kernel.org, AJvYcCWJibu/Xg3R43ONU3ZDgvrzH0TGsCYpTwpupGRNI0GA7YvaTDPPsrA/wqWKfk6Aq7WkEMXeFVA4iPIMDA==@vger.kernel.org, AJvYcCX308EBmEubISn5y07pRmKNaYhIdlqyaoVUof0iEwdIFnEB4fHpEq6w33GLSU0SRMR7sY4LeYDvOodz@vger.kernel.org, AJvYcCXdKlKru5UkQyRlqxxImjlllTEOmlGzIGXjr6Y389QtGmg5ZxtBMSL9gZXu4EPsPv9IidyDkY88LbHMljE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy86lnq3koIRJeNOVqWmxy25e4hVIgEm0SBm8TnA1ivn9n4ZXuL
	w5Kpow1uTA2zFHGkEBydepmtNiaAf8B46h7SsGE8aIuStk9gFBvG
X-Gm-Gg: ASbGncveteE+oU1JnawbnusT5TojG3anvJjskN1APv+LPrnErFPNYV2761+D786EyTC
	hkwFMWZRQZ41SsFUKgUE5ptKc30C4An9u2fww2y3SUydgLYt+ZmupQ5vShvEH90dl4PqpGn56h0
	Pol6kKhLyKgIZN2FRqh7W/OGaCWas+7UEZ/XnM/U6glWiBkysLF718hcUTtoWLjLJD8PZmDaiPC
	XCKQMablWpuB/cWhR7ieQLxnHKbonMg6K6Yrh9T857bWQSQ
X-Google-Smtp-Source: AGHT+IG8Db/Agjn5e1HtabRO5f1TOXAQx/7QpO92hEeRm/dqL0aQHHy2kwrWGo5egZag+7w+i1K+bQ==
X-Received: by 2002:a17:906:9d2:b0:aa5:4104:4a8c with SMTP id a640c23a62f3a-aa581044168mr1788011766b.40.1733132889666;
        Mon, 02 Dec 2024 01:48:09 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa599957594sm487059766b.197.2024.12.02.01.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:48:09 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 02 Dec 2024 12:47:57 +0300
Subject: [PATCH v9 4/9] dt-bindings: mfd: add maxim,max77705
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-starqltechn_integration_upstream-v9-4-a1adc3bae2b8@gmail.com>
References: <20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com>
In-Reply-To: <20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733132883; l=5789;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=kSoIMsEyI5FQ+mbQvFip9d0Bq8H/VWKwGdAEJhaEXzU=;
 b=EjAneaGYwe7c+6qfiStq/18Xmwg3lgHXm/wVxX56HBfndpbD4B8AD3oGCYGn+dqShrvCa8NxN
 LySSX//jckcAqJb44Mj9e5zBNxYqIYU7D1Rdv3RjQt5QFmBdxMCn7hn
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add maxim,max77705 binding.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
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
 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                                               |   1 +
 2 files changed, 156 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
new file mode 100644
index 000000000000..fbc264cfc609
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
@@ -0,0 +1,155 @@
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
+  fuel-gauge:
+    $ref: /schemas/power/supply/maxim,max17042.yaml#
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
+        const: maxim,max77705-rgb
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
+                compatible = "maxim,max77705-rgb";
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
+                compatible = "maxim,max77705-battery";
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


