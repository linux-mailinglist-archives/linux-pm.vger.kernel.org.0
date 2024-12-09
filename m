Return-Path: <linux-pm+bounces-18818-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CBD9E924B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 12:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416B3164B78
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 11:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD58F21E0AE;
	Mon,  9 Dec 2024 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsoCd4GY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0BC21E081;
	Mon,  9 Dec 2024 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743770; cv=none; b=t9hXqcVGZ7BjJpkLMvxnDqs0dUaYQ0exKc1nQnzEJRP/I6vkTetDDPLnh1CfBfEqcpve0akCbuDw/BE/HpTIO6MZ7iePGXS+cWCyuxM7WFx7sEtbUDwgKc4jar/22TzGzut7esx8qKr+8uY5CwBzrfi7hHK1EhQcRxkvOV0sHg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743770; c=relaxed/simple;
	bh=vFeQHkYSxuAZeTAwrYPzxxx9evHLZtMuXvBsR0hAdeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ku6ET1trA6NVI87VOXFm2xdeHbYC/KV8toRVnPpl2tpdKMxvsi+XF3W8UTXZeMo5c+5IWFk4Mi1Xcz2/aqFaxDZVlkcwa4TvDRt5HTGs8O+B2QZXx48BtknU/peaPzGdtX2iiGv34EeGzHMeozW0lqk9glGBjbvB0Hy47+hhIlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsoCd4GY; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3e8f64d5dso2335696a12.3;
        Mon, 09 Dec 2024 03:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733743765; x=1734348565; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAwZbwTlkZ996+qccsIMu6qIR18JftNBDn0G8yU/QvA=;
        b=GsoCd4GYQoJk86Ej8mho1DUP0HH+RGNeWknKpF4cEow/qm9wONUTnoWttPLPl8+CQ9
         mpZSBHS1xCrlCKBTIoSwREMyXw2fz1nN4rWzOx7hnGNl1Z8kRkqwkdOABpTebMaaAubv
         v/bBhKNY04/N7QjNuEmVS7pfHRZHzHo7EwnFvptaZSw3uUFgxB5SZBYHVUvR5COJOE/S
         EpYJxUabV2eWLixdBjF/EH5fqpppzoVjA02Bm7RRB86S/PHzlNUF+lIt3MymzO5YpvGH
         KKOceijWBr9QjBq6fImCw449rEjsUeJ++n+IdwX/bnyuZtbKGgnscXB2SKAtpfccuOeF
         ZBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733743765; x=1734348565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAwZbwTlkZ996+qccsIMu6qIR18JftNBDn0G8yU/QvA=;
        b=G4/2jwMPrt5/Lw1S7Cnxur+h53rucKGaH6TsuZvGpeeO1fVi4V0WT6eVuC/CDb/f7V
         gXQgDj2XJCImbahvLV5lsNzvGYhpwSbUola9MnZun5LtFg4HxRphTxwwZUi7uL1jLicz
         YH0B72c/ppodTh8pMO1PMpODBJp90hwlnBMXFgq8qx0HpXkTmsX/m6CHSnydcvnRNsMY
         3LfBbmg3gSZOMCUu7Ku0NokynCsmaPpbBcF7YJTEiiWHwg4b5Zx1rP1oT9Iu32uHIax8
         v+X+J4D4R/9eSF7SAXwN35VeTSeJWjpsyH3nDUIM+KkxApt0Va+uRU3is4dYH2WlLSIO
         HcJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD4Fbkt4J0zyCmHVLJcXYm/LSKNZSFnJxx5oVipNb+3HgTg/vQHgfrUwY4ou/9+aoAh0S61DRwE6TWgj6s@vger.kernel.org, AJvYcCVvv2TF46g3aUdz97XcOVbJaz3+sHSrmVJTgKPjxvJ+vqEcn2IB4zvyB7C/s42D8vra+k6BJNHpcWmL3A==@vger.kernel.org, AJvYcCXCSl5bu5pXddvAyRDhhepzCmCFJOencVPP3YuKGg+4sLXa1eUwK6GarS3Pbz1ozlcD5LYqXh2+K5mrZcE=@vger.kernel.org, AJvYcCXNc1InbhGhd2zXHqX5pHZ/0mcs580d0zBnaakILPAVhZr9i3mMSb9srMFACUrULKXmD6ONVN/4Xj1H@vger.kernel.org
X-Gm-Message-State: AOJu0YxuOsgfOHymDXPgxibrAwsFtm+ouIDwlE5wzP5sX/zyhwOoP+J9
	YQyLVzL4e68mOuzi/HUlodzH/bANP6thU7BAIDW7NdfR+CglPSdb
X-Gm-Gg: ASbGncspUBTR6Op7EbtjQqS7KOK+BINnlNxLnNcM0hIylgOO+uLWGujwMC7ldrrzaZ+
	8pZuL45UyfKKBfmDeJEtOHjpTWnQMAy7YJGoS3b2NNf5e0LrUnfa6Bm2pTyib1tgTKs2oS2Tdk2
	SjX8K/dsXBbdeXcNQa7oCYSHzOLDu2C4XrtZPbOW3ZRUtXuQGUSy5t0EE74hbbBsHpCzDguweSk
	D8Auk+apbJYJQraqz9+PyMrRQ7hSQfkT0FF0SidfhvlubKydRF5
X-Google-Smtp-Source: AGHT+IHQFtdxjxI2mCjsVT5GXlJXZ1kiuNBjqf98ccSvwGt7iXJld0dI3ecWeVtmVw555f8DLumhJA==
X-Received: by 2002:a05:6402:3715:b0:5d0:c9e6:30b9 with SMTP id 4fb4d7f45d1cf-5d3be65d5f6mr12282377a12.3.1733743765324;
        Mon, 09 Dec 2024 03:29:25 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b608faesm5980350a12.44.2024.12.09.03.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:29:24 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 09 Dec 2024 14:26:28 +0300
Subject: [PATCH v11 4/9] dt-bindings: mfd: add maxim,max77705
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-starqltechn_integration_upstream-v11-4-dc0598828e01@gmail.com>
References: <20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com>
In-Reply-To: <20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733743755; l=6967;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=vFeQHkYSxuAZeTAwrYPzxxx9evHLZtMuXvBsR0hAdeU=;
 b=ffu9QcdDqkWOfSH+Mb4Ojsx2Lu1RjVn8VgTKhfcVMnxXLtyr8MgdZIoNNhXz5zz3hFUQIbC/r
 rOAGovaXBshACY7zLVsaKXSyvtYVJnjDOG/j+1Jh/4CZq1+KH6q7sIe
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add maxim,max77705 binding.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
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
 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 190 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                                               |   1 +
 2 files changed, 191 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
new file mode 100644
index 000000000000..78d177211205
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
@@ -0,0 +1,190 @@
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
+  fuel-gauge:
+    $ref: /schemas/power/supply/maxim,max17042-base.yaml#
+    unevaluatedProperties: false
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
index cd5532afbfe4..9b656d57ed1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14227,6 +14227,7 @@ B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/*/maxim,max14577.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
+F:	Documentation/devicetree/bindings/*/maxim,max77705*.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77843.yaml
 F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
 F:	drivers/*/*max77843.c

-- 
2.39.5


