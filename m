Return-Path: <linux-pm+bounces-16325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0550C9AD503
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 21:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9951F2389B
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 19:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336181E5736;
	Wed, 23 Oct 2024 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJByTYQu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409C71E1322;
	Wed, 23 Oct 2024 19:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729712586; cv=none; b=McwS2lpMBn+fZfxQa4ScnnU3/qCsVY/HZaFg25C1bT426akvsYOcBHcgZbB5ND1D9FaEAqTPqt1kJoRcqn634tlK0r9QaFfLLvDBy1yX7owCYio54dydBcxAbXosalBKvR6nD2xl10JTlZ92YOF+2ofxHSsesy8jfoyvi/NK08M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729712586; c=relaxed/simple;
	bh=YFnNe+04ZW7T6FaMDt8f8dBNiHy+MpEDReCgmtW7/k4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YYyHF2YUps9t1Zro9u7/Xk3rlFs5skTemWstSXDYERVyX69EkgSB/tLopHi4vVQqEi39D25NrR61jMGPmTxvtCQcSKmLQE5feug/oSyMT/WQ3ElNCrQa+zHVQOpCZ3Wp5DSVZLTyymcz8fUZjVkCeNWbL5vCe28YhGt+dWhcEOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJByTYQu; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c94861ee25so82428a12.0;
        Wed, 23 Oct 2024 12:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729712582; x=1730317382; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOdPvgSZldfYAho7pM5Iu3076bZ8+xAOPGSdiV83Eps=;
        b=GJByTYQu8o0QfMEI3zS+pnMKXs/DKlMiZQ7J3769gIAXNcq4YrjKMLmntmfGi+Ea9Q
         LpQC5D8mBDZt9L2PQVlGw9FpibVouel/wvbGpjDGsrK/JksewO3mRmTWnIY4wbX15akW
         dHPvV0c0Oi6UMTPr0iey2hc2qzWagd+EE0QUENXSQaZ2Sboqw0Yij9beW0MzSbPQEsNV
         VFg9MnDxKMHRwTKhw7Tyb+8G5MukTI+nIB8oAiDs01KXfc208Aett25VQoC7xm2RnMfs
         20OU3ecILcOqBZ1Ztviw1E/OWrh1L0fO18WqpJll8YDUm+QbWSuOhBhBdEVfmHR/51vA
         Nb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729712582; x=1730317382;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOdPvgSZldfYAho7pM5Iu3076bZ8+xAOPGSdiV83Eps=;
        b=Rh4BXvGYKr1vym+R++OahYl+EGzoMotOBAzuP+pCxf5mwF/EWo0y5R+rKzU9juCB3H
         Qbdn5XZuk7eERCsruGyvaCUXLhX33KYujSnGHcHMANMyrESP+jROzxuWdDRX0S6acVSO
         kyj4VbP/xrv9/iwgGI11FFKi8eKCiccwhThQk9zjiqaWoLC15ZobfnGJIaN5nBfbUrUT
         RHOpz+8HUgrmm/rvouANXd2jRxdTCq2szkZRVJ1G75bXeNp/swnD+1AIeOO7wJb6JPKm
         FDqWBv0roFrdInLJYd0e5aaHU5uHqw4kLyxujydzs0N5gHKi1znfkh6Jir99AEvrFZI2
         Rfpw==
X-Forwarded-Encrypted: i=1; AJvYcCURK8ibsmpYzxsgs8+CNvu294YYpyxsdwqvxx0Jk7b6wi0fuLYZZYcRghaEQJyni56pmj8Reizu9Iwt@vger.kernel.org, AJvYcCUcaUkI8Ff64IauunGv2jVYplCbWJgb3sKHY+APTF6+kxNbP8O+/c/A9zJeMG0P5qenRLqZKHkZcxuyXCw=@vger.kernel.org, AJvYcCUtpRbx39HrPxztlhsZ2JowAsjBAGDZaRnvVKHOT0kz+9m5zyL1QunQvt6gDXfiI0qOZYuV05Kv1tvz+Q==@vger.kernel.org, AJvYcCWtIdRCeOo8PmdCyAXRa8w8HlIHQdXi0V83wvKYiA5Md2rwqMol8LbP9AquT+5CDr+ox+qIqZiBl5GLFq/S@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf/COZPb5m7tjCT5u31ENjrIx3smQh01RDDgGeh8laJ22CR5/Y
	aHCj15aBAJQXJNBBmWC6RGpimdRf+psQVNnBnxx8evWSqxZq4/kjGtPDew==
X-Google-Smtp-Source: AGHT+IG8zCkNAy6gj/LoO/ZO0JprTDhHy8Erjvxf7e+DQYAnQQNv38g6N+l7tODggE8QLzsX2kjfZQ==
X-Received: by 2002:a05:6402:5d3:b0:5c8:9529:1b59 with SMTP id 4fb4d7f45d1cf-5cb8b1e9c71mr3269433a12.20.1729712582085;
        Wed, 23 Oct 2024 12:43:02 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.244.166])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b1d8sm4803940a12.72.2024.10.23.12.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 12:43:01 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 23 Oct 2024 22:42:50 +0300
Subject: [PATCH v7 2/7] dt-bindings: mfd: add maxim,max77705
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-starqltechn_integration_upstream-v7-2-9bfaa3f4a1a0@gmail.com>
References: <20241023-starqltechn_integration_upstream-v7-0-9bfaa3f4a1a0@gmail.com>
In-Reply-To: <20241023-starqltechn_integration_upstream-v7-0-9bfaa3f4a1a0@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729712576; l=6162;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=YFnNe+04ZW7T6FaMDt8f8dBNiHy+MpEDReCgmtW7/k4=;
 b=RhtDnD0cyKNaFgUIEGji+/iKwfDzkihgmViS9omRQrx4J04RrhqfnuBvOcEZLtx4q2ZSUWT9m
 Auf7hDVUIEWCozWmehXJyWUdt8Ywc9D5tTcdPuZq7O5CxSFvOEM8dfY
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add maxim,max77705 core binding part.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
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
 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 174 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                                               |   1 +
 2 files changed, 175 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
new file mode 100644
index 000000000000..33dfc5b4fab7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
@@ -0,0 +1,174 @@
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
+    $ref: /schemas/power/supply/power-supply.yaml
+    type: object
+    unevaluatedProperties: false
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
index 2ce38c6c0e6f..5c3de689a93b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14116,6 +14116,7 @@ B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/*/maxim,max14577.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
+F:	Documentation/devicetree/bindings/*/maxim,max77705*.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77843.yaml
 F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
 F:	drivers/*/*max77843.c

-- 
2.39.2


