Return-Path: <linux-pm+bounces-20879-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507E9A1A689
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 16:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937193A215E
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 15:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B019521323D;
	Thu, 23 Jan 2025 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrhDs/eK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7F7212FB4;
	Thu, 23 Jan 2025 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737644688; cv=none; b=BJKcvCqzuRqyBM7FHQ6yzupYqgBZcj/oZl1LnGS1/6bTpv+JQ52F6CRGMUCvvVvHILlitR7qxCN0xDB7UNIKToJVuCYX9cwOfL8KK9THtYzaZjv/jL8uPfz6vaaDD7sZEDdT6p2yyq1F8vKVeALvvVFVWBWDMmk9frGS4q+t6PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737644688; c=relaxed/simple;
	bh=s0/CVJn5Z6GB25apRpp3jyDUE+HEG3h8rcgOQY8LjaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XIHxzIM937/+OBO/ADgnGVkinCHhZlKJCtVwJCDLdzlRRPSJjYBdOsZ6QrbMhNicMvSnELbeGXxFVx4arvF9J4zoJrD0TlhmlqjwX3xuUyXB44IiNDoJpWkCCUvEyxKybEvyRQ5SwJx7aWr29FjQlUa6Fc3qJdAaIQofMriLmHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrhDs/eK; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaec61d0f65so229721866b.1;
        Thu, 23 Jan 2025 07:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737644685; x=1738249485; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udekqa5IGYQ6//30MEBfC3nhcQXiHzNdob8oRA9txmE=;
        b=QrhDs/eKmPPo0ASsx4nBFvzBxZPITo9CjCDbqyFgzYgAhPvbLgt5M99WkKZuS00DLH
         eJ/v1GvydEyd88EX+YObrX7SaPvAetABbox/LoSb55o6r9/m6yokOCb0UKyMb9JU/7Rn
         vQwn6fH7Rf7R9XsylRkQJRKByFyxPpFdFaVjDSt9q6lWbvxlppB+xnFKOVgnWYT/3pba
         UwwXI/pX4E30yuc82yQrUPrE4f3pCiZkYAxTwvUgWwruZhTCFsUZRgyRP9QH2aNl5vMz
         RTrxClFrU8JBdQqLJg83WrGKTkvL5MrK/LQ8s5akc3ZbSV/gXeDy6XbxiYZu7w815gnd
         JXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737644685; x=1738249485;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udekqa5IGYQ6//30MEBfC3nhcQXiHzNdob8oRA9txmE=;
        b=ucpOM9YkpXXp9wm8LjgM7sh7HuJ6Fi++Czzbsi+Gv/Ehz0sflR25d7EYRsbEwnLfQG
         +Wzr8upfDvf8KkPj+n7grFPwY7rF/O12FmLRbaksctY/ieCXDPQU3QaV5REMh7/NnMH4
         OK+rss/Yy9aB0qbNWOqOVsDaEeE6SCuHTGbWN/wpSKXJDUcs7lv86PmZmAJ4pTmVsKXi
         IOH1uAgTpVZ82Xd79mFAWs6IQwfuMi4Ng+7OXpq9S9aQIvMXX9vRraTBIzKVpqtKSinA
         ZBxHOJtpw4z7lOrzBIPOBbVZUv8aU/Ee3MwGNL6eW9eQlT54i3Gl95dItuzro4yZR6ur
         aQPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3N/7inkRpAGaC++d2acvpVUElkYKr0Y6bHFRk7yeeGAoD8dxb4m4gaPhbdb9ryLvMpvEYTrvHI9+lCzkH@vger.kernel.org, AJvYcCVpuXr0BdsX/+fyxQllny/mgC/kQ1uPsciERIKSeF3J0Jzo0jDVbp6QHkjdAn+LejuW4kzFCcnzo/iyMw==@vger.kernel.org, AJvYcCW83uIyx/BCKkAz48OGY3LCHweA6R84LHcu1ZsLP2BODAglDuJlPWR/wHGYYxqZTSaiuQv1MtAtnX3K@vger.kernel.org, AJvYcCWnNEozDvlxV+Wd1BdYWl3vtVOSkJXYnpo0+JUIQ9ialRTmQKnDbWHWzd8bwUVSECU4/Ls6j64Bv1wsO9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH6dojvDDpPQbCiWI52hCiugCT7lLZCr6qWLpZe9MZSzVnMA1i
	hHNKiWOlFCpLY9AqzngOqPJ0TsbpcPCl104Ltff6U4ZoKMzoh7tp
X-Gm-Gg: ASbGncswJ295S4XtrLjDemTyYeDfyQ9WXC0MUx3LLrqIp/9KYd3XG5oRDYIFZQrtiou
	Al3Di+Z3jj411pYDkIlBmAoowL42LLYykwhtfnfHOpbvbAZLA9xu8lfFuQvjrmru+y2G0mjVUD8
	Y9MBfAM3QJKHJBtE5v2nibct2d10SWbuLKGkxRqI/GiQ6zo+4uHZ04GXsaGev7cxIp1E+iujybC
	Rc+zaaPixjBtsu8dTnfJn20gwDi8XIsP0SSmuDSCd5tTZ4ntmSnduuevq1k4gefV08Vjh6o07rp
	ZBM=
X-Google-Smtp-Source: AGHT+IE54xDEBK5gw/fjGeq5+SCEtnjIs8NeWdZm3pI73W4egs5NCghzZ9blaVp3GpvFFs1FgBPEAg==
X-Received: by 2002:a17:907:1c95:b0:aae:8490:9429 with SMTP id a640c23a62f3a-ab38b1c4d26mr2581827766b.34.1737644681775;
        Thu, 23 Jan 2025 07:04:41 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.22])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384f2903esm1084727266b.109.2025.01.23.07.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 07:04:41 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 23 Jan 2025 18:04:27 +0300
Subject: [PATCH v17 2/7] dt-bindings: mfd: add maxim,max77705
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-starqltechn_integration_upstream-v17-2-8b06685b6612@gmail.com>
References: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>
In-Reply-To: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737644676; l=6790;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=s0/CVJn5Z6GB25apRpp3jyDUE+HEG3h8rcgOQY8LjaM=;
 b=BhTKiFxO9KcncQtppusHJmn01v8HIWLGf90OGonA+n+pmTfvBwCWJ+Yp+XBCIaHiU366cjEBm
 Bc25AoPXCprBOFBvRb6h1kZFqyNWRTJ8fKAEKCXvQZlKgXGbRnQh08V
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


