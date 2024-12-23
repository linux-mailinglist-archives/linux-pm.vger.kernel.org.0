Return-Path: <linux-pm+bounces-19690-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD749FAF24
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 15:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4001B7A2AF6
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 14:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2D61B6CE9;
	Mon, 23 Dec 2024 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hjo8MBGm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC1D1B414B;
	Mon, 23 Dec 2024 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734962405; cv=none; b=ddet3+WsXgF/j3pwqQu5QRlg0H2tGeZc+96gGS8jpbXqugkQIP+5/+eOEFml+78j+JrxklES4ExJyuxe5i3rxu4NavA2F6wsguViV2rYl1tYES2crJbsFmw79IFwhSWUHiQbKS/Lj6gu2EgXGAq5KPKmS3w/5zMT3SYm0CCFSKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734962405; c=relaxed/simple;
	bh=++FqWduQtiYqIZJfFFYN58AQ4bYjWg2hDGDCZOV7O40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JDSFmOF3hq3Sex+gWDh03RVI6d55G79WNohxa1wM9lRaM163lttKq3IJf4K/ELxFG4k15bp7SHeJBqQq9Ky2mMLEq9ug4XPmYwTJnZsjtJ1lORFnoLkOcRmXGjcL5wFRt6+bKaQ7ChI0+G+UROyL/G2rVSPVQ3mOXEQ1MREnzPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hjo8MBGm; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso5040120a12.0;
        Mon, 23 Dec 2024 06:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734962402; x=1735567202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8X9Jrp2ekeRKT58+p8rV9JAnlJ7wlIh9J/UZBXn68bo=;
        b=Hjo8MBGmxJVpn1ep+s9mp3F9ocVvSOMTCErUKAt/fo0EiA1aWuJDXbrSsZOxIIPzup
         LK9KLsVUdeXvLvUKcqoCk4EtUewPtXXLpznfbXHdADEEYFmjaRfvUHWqHMzmtr09IknN
         u4+9kwfF3q8xY0GNqmdvRsMBnOxZ5ocxDGMXlX1d9+EXbKl5BXpeZhP/ysXw1yJmCgC4
         WxIwrric5yDKgtnUu+DaJsNQkgLItplR48f400FdsV54txjOitq7DFsiaw/KlezL5CY+
         heEM2ZBliIQH4rPN+Fo5p61KWgqEvvsfa9jIoPdpn3CWPpEbONCXlZBYf4kw90hnhrHe
         XrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734962402; x=1735567202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8X9Jrp2ekeRKT58+p8rV9JAnlJ7wlIh9J/UZBXn68bo=;
        b=Cktk+eoSbQfpuxNhztT7DJxOFDI5bRE0+zmm7fGHOVdTe+BkLq0iwPX5yp07b9A6nW
         zOWSJ5zo+aasAvzkTjZFTDMfhAKFThGMp73MmGc/aXLicUOoMFGrMuXQ0Hrcuz0n0XFy
         UY22XSvuXiy05JhgivSqjLXvGtSxS4d1RTiW6JMH34w6ekBst+zbqCPs+JplJ7pjrIGh
         vyvLwm2iCK3m1L2tnOmIjl7dUbPJFEyirWA7rIUgyXzDH9brn7+i4E0cUd2GSeW8upg3
         AhjnckyUmF/64/9qcKnZY7eF4cTNUgFw+aT9tZZgmHQAZObY6J4QmevArPeng2CNhoTH
         FGPA==
X-Forwarded-Encrypted: i=1; AJvYcCVAdIOCeYp1TeZdwiX+7bhdDG84X/aa3wzWyA+piZa83fxNgDg1KvPdWfYjY0dkUhnQZ6I4sGWwj0QlKCSE@vger.kernel.org, AJvYcCW7bKXeYhkIs3+LE4V9TrWgLWU89alXsyFTd6lIGZao6bOBFEn0/VYofg5lNLAVDBQIz3GJZoD6Zw9D@vger.kernel.org, AJvYcCXaoE47QDydC2oaHLJnDZG0LofQpaozgfVCcC8W/RzbMI5aNkf6Z49qcnWuO4Q0ol/zldOuM083JgnnIw==@vger.kernel.org, AJvYcCXhmbd9JI8IrzRQYwaigchZdWFNaOMk0JgKzbdP/1tSetWwraWEb9x/SM+v3OlVtVBRob+Dnnp9x0he8dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsIXwCukCwb5g2FZOxpHD0j41rKZr6ywW1QIiJzi5Ha0tzIN8L
	YBD1TBh3i1cOUSJNqNUjFDp+ctN7gzSfAig5F2xYHXN6IMrGFLfNWPW3EA==
X-Gm-Gg: ASbGncuFqfblD92+I5Pzefv5zx1ynm6uwJzuUl71okcuBM7hU5cI7sR6SG6t+c5muSY
	EG9DzsTPygQtVsIB37+w59emi0kFF1N2jzLoF1VLQvcBSwODgbSOiwGoioDYZo1X4SFAstpe7b8
	5pkGjInak7sWG/eKMlgnFYAEuXOEIFIhZBCoso8+5vEbaoxjtcsLocHKZ9Gpc5uwLBHktQhQ2Qx
	e+o2ggsxdvw/ZoJTxC0oLXc51x3Ob3SAUfm/aG5+tI6ZPycpsmV0Gj0+8IBb37F3EoXC+GXUf6q
	gZynhjm48IGmY4FUxymlJ8hKkA==
X-Google-Smtp-Source: AGHT+IHwsERKIFwbiG5DYEEF/Sdt/c+mRr3/iVgL/SfK48DnQPRmJeselo9iLQWUUPtOjES8VGX+Tw==
X-Received: by 2002:a05:6402:2109:b0:5cf:e66f:678d with SMTP id 4fb4d7f45d1cf-5d81de083bamr11948111a12.28.1734962401480;
        Mon, 23 Dec 2024 06:00:01 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701ca31sm4911485a12.88.2024.12.23.05.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 06:00:01 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 23 Dec 2024 16:59:41 +0300
Subject: [PATCH v13 04/10] dt-bindings: mfd: add maxim,max77705
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241223-starqltechn_integration_upstream-v13-4-fbc610c70832@gmail.com>
References: <20241223-starqltechn_integration_upstream-v13-0-fbc610c70832@gmail.com>
In-Reply-To: <20241223-starqltechn_integration_upstream-v13-0-fbc610c70832@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734962389; l=6718;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=++FqWduQtiYqIZJfFFYN58AQ4bYjWg2hDGDCZOV7O40=;
 b=K4DDeS9alSFr9oOiNcPPnHScJ9o+ppz7tjZe3ZfskqViNqNrw6mvV0C4ltpnISlmbyELezenr
 YHDdvLMZGx8BZdHsdX3pqkbw3Y1JoQ9ewOha+vGql9zn6YP+JAG9SZJ
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add maxim,max77705 binding part, containing leds controller and haptics.
Charger and fuel gauge are separate device, thus not included.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
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
index d2ab799a0659..f0ad532b82f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14260,6 +14260,7 @@ B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/*/maxim,max14577.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
+F:	Documentation/devicetree/bindings/*/maxim,max77705*.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77843.yaml
 F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
 F:	drivers/*/*max77843.c

-- 
2.39.5


