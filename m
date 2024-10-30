Return-Path: <linux-pm+bounces-16773-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2819B6EE7
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 22:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17DF1C21A8D
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 21:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3C8218931;
	Wed, 30 Oct 2024 21:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7y4/E0I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135FA1CF287;
	Wed, 30 Oct 2024 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323854; cv=none; b=f664JVhIVfScJ/vzZ80ikkROtYvxp1mYzEI2E3gEguZcaVyaF01hpEE7izGs45Q3X21r8gGqRBzcvP3BuBumBGcWFW1M+Iz68SIP+704jbn9l9qokaa4UwGLeHt4Q49xkfqde0+fiOW26fQTKkf4lNFTX7Q0T0NIJr10JuVITBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323854; c=relaxed/simple;
	bh=9UW1cvl5fc/o0lPUsMCSThR3Opb7ot8+tEk54fve0oI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ni/aha+dVG+/sZ+ww/hYBGvb4it0zngCcciB5Kv3OMauovMzP/wejpZBgF/uNSSwdPmaMzpIZom8KNXww0c0Si8H8aGXrtZn1sA43n6de439a4JbOlXSpNSQGsvFkxNVX2FEeG+49jhwJOaY4KZIGR38z0B6UFScZpJFQjcTfkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7y4/E0I; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso34703266b.1;
        Wed, 30 Oct 2024 14:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730323850; x=1730928650; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzYPPNmwMAOnmhVBWnuCcEPg8fi588V+f5ZFW+F4qNc=;
        b=U7y4/E0IhtU2eqzcbuMpY4g2/2TTwQWRa0X+9oikxYWMnB8BgvAUuTsELuvMWoSiBG
         +9VyaxCO5zOdgLt5UfphIHpxkN0lq3cVwnIbszz876I42cpcoEh5Lv6YmIE46qOzFHiX
         aOSpN9rrJee5ux/Tc4BEexQs4PAJ4frUmCF7Z9daxTXZXlpra2Cv5gbHFX+v7qh7hevZ
         hMpXYBio2Nmv/1lZjDNR64Y7PaTHPOmknh75JSOpebE7BjIep2JHcqJTYaVBpZAibhNP
         kP1LoK2FF3BfcE9YFHAg1ROaXa0xsiTlEMGXO6dYd57nDaIjw/MmqcF5cuf264xXTNet
         PVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323850; x=1730928650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzYPPNmwMAOnmhVBWnuCcEPg8fi588V+f5ZFW+F4qNc=;
        b=XaQvHUKUaHJIpEDK66UPsKSCj+IP5xVPdKvMiU+LCXaOqpLzFdJUSIfIaET4p0kJEC
         rdPALLSfBcc1/ArzINvHlfFRKfyO4+u09L7i4JbVsblBLRNubm4TE/oR6jSrCuw6vuIj
         c3ypIBVmMOPO4L+qQQsFIaIk3SoRuXaMD4rOgQGKXcutOrdBblfbMNYBarfTrGUAVpfW
         ++nlEZzfnHqLt9VNA9RhHpMlUiMKAhmQPUQEs2FQ2Wng7oWybrcZktK0psG3q/IC9avT
         Ibi98F/12yjZkB2P0BMqR1W1yEr28R54e8ma5l03nlPhmBcMeepKFCbrF9pnMte4yNx9
         A24Q==
X-Forwarded-Encrypted: i=1; AJvYcCVA+egQhrx/6p9gzyLcNWkHqF/76sxOzMyCEXGu4wZQG25kd9V+fd/f8W2UQ860qcfZldG8r0DRR10d3aw=@vger.kernel.org, AJvYcCVT2JQZmV/2Rh4b9hWoHWgL2MQ1SEdHTvfaSIkgXx/XQmFVubHw+uk6B1OuwXx155/umn04m5I5pFJtesVQ@vger.kernel.org, AJvYcCVssaPEfJZj1ao21mp9Iv2vEZOCIe78jVCqcMyWkLKfljzsO1zpO4SL+2c1bH11EvHx8IGwJ7NAaqTP@vger.kernel.org, AJvYcCWipGh/sBH2qTVHmjvMI6fmvXb9rZYLS7h8f93rARNLIz1zGOIuBj04nU+0HMeiTvZbIJXfxgy6D5qlTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZBt9tlrBJQptEzlCOzCEPdCpmH/JPjf13p0Gs/Oxy/AvWukqp
	f458HTqsuk+vjDKbfnqQCOgxxxZi0xim7jwk4lMfdhziGyvxKDdf
X-Google-Smtp-Source: AGHT+IFq4SG6PXsFx3QnMuWXPit6YWiHOW9v7DLV2g/eAVpAm/FkBvlCK81Zh4suocXEfzpW+heY2g==
X-Received: by 2002:a17:907:970e:b0:a9a:2a56:91e with SMTP id a640c23a62f3a-a9e3a574f2cmr424880566b.6.1730323848651;
        Wed, 30 Oct 2024 14:30:48 -0700 (PDT)
Received: from [127.0.1.1] (leased-line-46-53-189-50.telecom.by. [46.53.189.50])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9e564c5410sm687266b.57.2024.10.30.14.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 14:30:47 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 31 Oct 2024 00:30:37 +0300
Subject: [PATCH v8 2/7] dt-bindings: mfd: add maxim,max77705
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-starqltechn_integration_upstream-v8-2-2fa666c2330e@gmail.com>
References: <20241031-starqltechn_integration_upstream-v8-0-2fa666c2330e@gmail.com>
In-Reply-To: <20241031-starqltechn_integration_upstream-v8-0-2fa666c2330e@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730323840; l=6203;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=9UW1cvl5fc/o0lPUsMCSThR3Opb7ot8+tEk54fve0oI=;
 b=RV9JQ+lf9eyZw5zWYUDiJjQep7yPnHDgE78IGjZciUN5XwJraAIpO8CojM2GTERfEdH1z/CwE
 33LqJutctzQDooVh/PNyi573zzZnJuhFvoBwNATjKpb2l6An/YpxqTR
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add maxim,max77705 core binding part.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
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
 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 174 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                                               |   1 +
 2 files changed, 175 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
new file mode 100644
index 000000000000..5e7bb837c9f3
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
index 3b9c6763f679..e92160703880 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14131,6 +14131,7 @@ B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/*/maxim,max14577.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
+F:	Documentation/devicetree/bindings/*/maxim,max77705*.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77843.yaml
 F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
 F:	drivers/*/*max77843.c

-- 
2.39.2


