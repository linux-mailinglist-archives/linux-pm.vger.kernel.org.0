Return-Path: <linux-pm+bounces-19382-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A85359F53FC
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 18:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B6E188FCD4
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 17:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E11F1F8F15;
	Tue, 17 Dec 2024 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdeRJR5h"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA081F8ADF;
	Tue, 17 Dec 2024 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456643; cv=none; b=TUiHlU6hEB5mqnLQdyXeI2gxZr5dwF+Dj3f4aDAHk+PZI4Jpap+wo2m7JJHhw2/iFonhdbyzKYt7VJesbjAMdXfgj3tCLVfsATyH5bywKUgfDnWRlIYHfOl2zuw+UVMrXz3RQL309/r1OB83esVynBHWEtZ1jtU1j2jaT4MzdIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456643; c=relaxed/simple;
	bh=m/prkZca79DAlfiiiu1BVx+1KofCiOIkNU49AA2iruk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H7yrWY95LDrWk3x/5HqspWFVH4ew4Soizi/+nta91UdDJeYIWolf2sQ3WNpknBqzfNMN6KaDjQ7scj/igdgUv42oObulcmWsc75BJ/lkp1ts2jwl5Odsw7qSkbXGiFBsHzs0pDLCNCEOcPxsyjtpnJtPLwpxXNaVAg0b6L7lcB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdeRJR5h; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aab6fa3e20eso795986566b.2;
        Tue, 17 Dec 2024 09:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734456640; x=1735061440; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZuCH1LtCnuis9NiU0vyHp/qhWwCsXWkEnPZSwSkxTA=;
        b=fdeRJR5hi+0bMgrh7ecuhKPXQyp9e13wFYciFUBLJV30FbGaQpd5fMhUOFhbqxuNAe
         1vfORLUN1Czub53rXCyrWeWoQXgqaQIBfENtsL1MkJOIHLPblMFf2184Idru4bc2UyOt
         1vJsN4FafeYuXMbp043ndA9pO2se3CP8ELgeMnTCmgZkIlRunPvQkHUP9JJpFJywuWq0
         SXNObQV++9V26SShyN3Ca6JWyNgBEJ5eSsNQ1S9Rrv7zTbRUe9KGYxn5Ky5Pu5fGPYHY
         jkFqr0LR5uegCw1wrplxp8cCMLMN48xKzQN5LVi0Zr2K6QxvhmMxAZ0bnOV2+VxirfEB
         h1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456640; x=1735061440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZuCH1LtCnuis9NiU0vyHp/qhWwCsXWkEnPZSwSkxTA=;
        b=RWlv0WqXCqMJIJ2MXGvPePmMqOK+V08IcGh1ixyaZtEkUOX3NC2oO5ivh7r8hji4Yd
         dM39/ghPfM2cE0LbuQsxLrkh60lsi0UlfK88Ifu269YLMi12OtUdiwtRP0aeH2kMDLDy
         gFHPRcFxSINK2VZh/yXeb695eGhCMOOfcw3k0AtZcF+3JheAKHNTyViqn/qxufNYB+aX
         jHqFr3fEsU2C+JFlWdweqWEvxe5hyGm+czWK4Kdfc+Vy4s9TRzSPMUwMw4q5cZwwkGOX
         jEdTcU411+ZFy1nupgVTOBMrw8P972Vkj+O+1kV6gWO0S8madtRepRCWdNZGqqgijCIq
         l+aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYf3j1PkzfmTbl2g3SlmBSW4UiO5gSi9osI11d0pUevAC0LvMMiefbDZAB2E3qK9f66kWzSLZemJB+Jw==@vger.kernel.org, AJvYcCW/Ae0tZXu6M6D8PHr8ZSpJR+icP51uEbTzQTHM0cOX94Ka/aBixcT9Jg75paPksP4wH7izXds1w2tg@vger.kernel.org, AJvYcCWfRHugH8JaCQ5gSc44ILEnz6X0fQ6bOziJHWSvhElA/FJC/Iu0FtguTFQsiU+jyZLz5jmxGC9DhDPZsa2n@vger.kernel.org, AJvYcCXXsUUV10MD6v9OonPAIwl5TdkdHAkaHckkGteZFzStmTn39zOVMX/YIG5d0mBW7zteioGEkkmVYVXp2XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdgXMu7kS4Psk9UA5tT5si4kMTNkwyNHcsX+SkYVXA99fZyu5M
	Od6YW9zeTxJfX6UGAdhLaEXlVLoX60QsmBtHc8FcfBdrklw3DCRf
X-Gm-Gg: ASbGncvRqO6sAP+JLUsLgXW61N5PLciQFpGzo4qeUUJK0nVJqxieQsA0LY7w/sKMa/V
	bt9swSh76wHGcIsQWr/xS/1pzejCGQ3Xa8U958oqAtspLbCAE8S0LqU/SJVqZtOLdMLqJXnOgm9
	zSeCUZIexl6gI+MzXf4PjgB0U4ScweX3RqHcDPXoNjryNjAGYoPta72yFlb9/K++0+5d4oT6c/A
	Qr3wvLpgj5b6fCUn8Ma/pvRL+TlH1thKwSwIlKpcm0SeALvGFafms4=
X-Google-Smtp-Source: AGHT+IFbl1t6QkoO2tti1kssbTrzYKE4NxkeremULCMcMWnAIQQfH3roCqYU8OtSTTYLiNccjJgh4w==
X-Received: by 2002:a17:907:1c0b:b0:aa6:7c36:3423 with SMTP id a640c23a62f3a-aab778bf059mr1355828366b.1.1734456639330;
        Tue, 17 Dec 2024 09:30:39 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aab95d813afsm470444166b.0.2024.12.17.09.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:30:39 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 17 Dec 2024 20:30:02 +0300
Subject: [PATCH v12 04/11] dt-bindings: mfd: add maxim,max77705 core
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-starqltechn_integration_upstream-v12-4-ed840944f948@gmail.com>
References: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
In-Reply-To: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734456632; l=6563;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=m/prkZca79DAlfiiiu1BVx+1KofCiOIkNU49AA2iruk=;
 b=vMVMTIUoA2A2hyCzw5De4IiuHs7+/OARq0jHwyt58g9WargsGCuAcJhmn1m8LAru4/LXhFkIF
 bT+t72wVmXEBkenRciWnWDaQqkaz78qOaNmUDP/9o/DzWAuXNQ1VXn/
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add maxim,max77705 binding part, containing leds controller and haptics.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
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
 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 166 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                                               |   1 +
 2 files changed, 167 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
new file mode 100644
index 000000000000..c1db861a2d38
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
@@ -0,0 +1,166 @@
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
+            haptic {
+                compatible = "maxim,max77705-haptic";
+                haptic-supply = <&vib_regulator>;
+                pwms = <&vib_pwm 0 50000>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 0816fe0f3c80..75e4e122bb44 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14234,6 +14234,7 @@ B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/*/maxim,max14577.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
+F:	Documentation/devicetree/bindings/*/maxim,max77705*.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77843.yaml
 F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
 F:	drivers/*/*max77843.c

-- 
2.39.5


