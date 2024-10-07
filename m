Return-Path: <linux-pm+bounces-15281-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB98993224
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 17:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B17F280478
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 15:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CD21DB367;
	Mon,  7 Oct 2024 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imUmUmty"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379111DB34B;
	Mon,  7 Oct 2024 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316571; cv=none; b=bIXew8nN51LRLhi9ZH8IPEbN/zkpnuusl7JhSAgFz4hpB7grW8GmEGUV33U6uNtPJg2OKpfyetYsGbkjClVzIRndUpKaB8h9bHfb4t8zp/u6SxEMRvC4fWP8ZZhxe1rQ5Kg9JI9PRmEk94khZiBFA6g+CtDwl95ICWLQMsjgAv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316571; c=relaxed/simple;
	bh=z2WTr+Bt8wM02vPQmwvbKcp592qJO7L+5ojYUeJ4uAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uR7qNPnp3bjTgp4KaBoIzkTnpNko2OfU3EcdhH4ZwxjDa4wD5aZbJ3HXxsFFt7ctgDHuKzHKEFTIqQz8B2Zi9TZ07bIG4jMbFCgPMh22VGj+c+DX+byCpxQbm/qMbvugz8i7RKpeWfd4NLyMOzRiO93upXMjWesjl+EZkUImFXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imUmUmty; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fabc9bc5dfso52447401fa.0;
        Mon, 07 Oct 2024 08:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728316567; x=1728921367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Y3OCYaD3T1rSqQI52mpHmgrDGw1QbrKpsmtnf3iNxQ=;
        b=imUmUmtyZFu9bydWtSxj/MbPv3HdvzSsS7vEwryhNmOCM8Cs9w9a1nKGg50U39idJm
         Xxy8aOeXR7VjOojeK4lalkTPjbM848649f4gOH1yWm4+5OLIO/tNVOrQqbMt2TGLzM/U
         RnE2B0x4KaiAsg3JGIfZEP3MruVuENBoID1+OmnDSrM3TRustUwUCTcJSMoZI3y3TshC
         z4n0ILUrerHsDXVCW6EQOoU2raBzEjWwkNEXdds2noU0VYNki3n+Cj1VGHJlYf9adj33
         0FJ1owjJ1BtuHeOkRzBvMFo1xDyCWk9udFIGqfdIQRYBln1MS65n8erqQBRithXqOBsi
         eSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728316567; x=1728921367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Y3OCYaD3T1rSqQI52mpHmgrDGw1QbrKpsmtnf3iNxQ=;
        b=FowvXul4f8GHugAyxf1Bmfg+CejCnuXSPFKhQj1A6HMtbK6e+vaes0YqMrnSm6Fenl
         WFq1BIG/kBEfoZjavPN6litaT0REt5HUzQd0NGUaEa+WQG63oJlJY4xvIJ+JVVKGjeRl
         anbgMfLF0Zb5XmX4W/t9KTVrg8VRyoKVtqh6gYw+uAjqcfaL35LcjG6kgEGbIVJyYNp4
         PWZgmqaGtU7SVG2INv/yb8bxyMXbV081SDNRpeNZJ1hQecEXzsrHAaLkWbY0R5e/y9Lm
         Utj8+2MzLjLqXnmKH9pwJV5RAR4QMSslhzANT3kTFjllp2c0gQt1CU4Ou9zi5lkcCmP0
         RxHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4LAJOottmQD+3LT1WZu0m38YPaxrB7CvDD8DSh44lNM2l7RGH88g5hDOQ+0Q5m2NemYrAEo69C4wXjc8=@vger.kernel.org, AJvYcCVXRHRKbLm8zF1bMTkcRhQxVmeYNpF3lITnLkEXi51QqoEoDjNMymlwruHiCpJ1lAD+J2xjJZgE9pZVvpWr@vger.kernel.org, AJvYcCWLOVu0AwjynwMdQZuhuAsL/AQ0EKaxFQHkczfZp9DJXEOfrovril9koKFLeNvNPXzKda43UvAUFcXM@vger.kernel.org, AJvYcCXv3gP16GyrsTJxfmPRoRAk4bkTC9v5BkEaljC0hrTE4x2m82ePJQg+X9BHin2Mv5UHwRjxZKc04aLn7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHuyHFKEf2wTWWeCfp7tZIsVNS4lygjQRVcW4Nj0ZY6QKdZUAf
	gi6ZYQumhufUZ6yGqHhmg/ixBA9UoEvE1+4ipoPTMPiQPamaMi327bsSYQ==
X-Google-Smtp-Source: AGHT+IHnxJVpOdLgZHBhniBQKZQ2lTLpk41RtriERncG44Mlnm4MawJIx+GZqsVJjI0jEieF3f8TBA==
X-Received: by 2002:a05:651c:b22:b0:2fa:be5c:8ae8 with SMTP id 38308e7fff4ca-2faf3d89badmr50137661fa.41.1728316566720;
        Mon, 07 Oct 2024 08:56:06 -0700 (PDT)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-75.telecom.by. [46.53.210.75])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-2faf9b24a22sm8552461fa.93.2024.10.07.08.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:56:05 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 07 Oct 2024 18:55:50 +0300
Subject: [PATCH v6 2/7] dt-bindings: mfd: add maxim,max77705
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-starqltechn_integration_upstream-v6-2-0d38b5090c57@gmail.com>
References: <20241007-starqltechn_integration_upstream-v6-0-0d38b5090c57@gmail.com>
In-Reply-To: <20241007-starqltechn_integration_upstream-v6-0-0d38b5090c57@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728316556; l=6049;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=z2WTr+Bt8wM02vPQmwvbKcp592qJO7L+5ojYUeJ4uAo=;
 b=6UsgLegICk0e1LVp8zmf67Nv8yuIG9oHywtIdkDeVDA9z46kj233zczWYNGbI/V5t7H5zlZ9S
 FmV525d2MaPCodzXpSaaRAD8mg2Lvr1i5a3xYy/v2YqZMo3GfxhT6ze
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add maxim,max77705 core binding part.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
Changes in v6:
- unevaluatedProperties must be false
- drop excessive sentence from description,
  just describe the device

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
 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 174 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                                               |   1 +
 2 files changed, 175 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
new file mode 100644
index 000000000000..078080b290cc
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
index 84086d47db69..9ed8bdaaaca9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14071,6 +14071,7 @@ B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/*/maxim,max14577.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
+F:	Documentation/devicetree/bindings/*/maxim,max77705*.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77843.yaml
 F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
 F:	drivers/*/*max77843.c

-- 
2.39.2


