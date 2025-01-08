Return-Path: <linux-pm+bounces-20095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D764BA05E41
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 15:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A851886271
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 14:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E271FCFF0;
	Wed,  8 Jan 2025 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGARD5D7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FCF1FDE1E;
	Wed,  8 Jan 2025 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736345656; cv=none; b=rxdOha5Hd+ilwdlQHyrd2HyPRck6tsUtd5hisJV2eddyBshN4IrAvCGDb2MxhjyhouLJJeBZzkqqcZUfEwv7tA8ye3Xz2rpjwwN8/HhtES0NARGBrZILVsJHyqQQJWL0HTRJAyQ2nNY0ufPcvdyGYcY2BrmeWPjYoAcknlm7X5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736345656; c=relaxed/simple;
	bh=mXulzNx4i224RQ8aQPPgZBPHi1e9Kt7QhQnDuW8jmXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ESynRbc2sXs480Ho+IFSVuarM1Bj+lOqa9MEfQW85KPXv9Miw+pFAORBGPlK3pMlSe0bxbF47rsXxytgN/Qq6ED3InH4nd1UTz1CaY14I9tBPaxQgfN9ltf46uhua7KSTZj/+ck88PXNrTiwk/XwPbCR/dKu8KPdvzNyz/6mEh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGARD5D7; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab2bb0822a4so78540466b.3;
        Wed, 08 Jan 2025 06:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736345649; x=1736950449; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQSiT5dvcU6OhgUSCqKULAtjaZ5NEb8Wz7CRSD9s8+k=;
        b=TGARD5D7UTlj8z0ZaFfciFQNFSu1QtKFxvhra9y1K5g2rzFrqb6vpWHEMbOK8oG7wB
         XZ05MHJQ6AEXs+lp1mb6WhStuZZQfMVz6MeeULojTt/m6bqFOXDLp0U10axcd/HDznHY
         PlQf34D+pOcaJt+YH03b15If6hKzQMCDQDBRDHUUBkbpiRFg3cn5apVl0mBwl5ODLK6n
         mYadiGKlF0xxiup/TPSZhB+Vc5MvfYiip6dEFzyBxg1Afy7CKh4FyFZsQ/jgD34AvSUV
         OL9oUTSbalcmVUUG3Bz5sllCyyHQGOsxFdoTZtWuv90zrv/ZV0uhwGgl2K4gpfDPFaUP
         MXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736345649; x=1736950449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQSiT5dvcU6OhgUSCqKULAtjaZ5NEb8Wz7CRSD9s8+k=;
        b=tvr/U4UIud5+jrPVq8H0IdflebwKSq/t8/vfTCchnIDoQ1ZSrPd3v0VjKZqfiXaKXT
         2XmHUhczvmqztLHzij/Uo1UUQ40TuruZwBwlyIvZ7qwBPWQNsvSgeqky5WOZCE89PAAZ
         mKZhVGFrLWIWwt+vqZ1R8WMoj0LlaLrMwvaexEfqIm1TfPB05zSuJps9JN0Lc+GCZrOD
         yD0dvv9PQW73cpd7YKQVwboPLof3QOrl+5QpuKbftwgNdHyfgyEl23yphrhl+rst8wKm
         U53/szWPz8cETCEvz+kz8ijV5F6IUUAL4zj+WKTlWhoUGUiuBln2ABiCagAxjavC9AQC
         xOWw==
X-Forwarded-Encrypted: i=1; AJvYcCU6ZfbjpIGgiqAIe4JZfuhta5UZjODLROS6FXerCMCMW2EXXU7A0/w79gbK1kK3v2dmAovNy6ZImgWtUK8=@vger.kernel.org, AJvYcCV1T5pndfD5+qMBOT/+kQu4yCXiEc6Qprzix8DjQkZsKAxQ/P9sGBOPZxCLepAC7iyqeowgz36wtJelFw==@vger.kernel.org, AJvYcCV1qgVsGP/HitQ5U9ebG87PofW5+Kki4bgbWrbCx/dI4x5kdS6SPMFZFESAG+jRNbq12dvKDyLdpU0q@vger.kernel.org, AJvYcCVbAaJftVrMpnWa5WPnph0cS9r7STifCQ2AQugHLPkIyvS1uNeXfwqUv3z8BPiHZU5pS3z7wO4tA08mwixD@vger.kernel.org
X-Gm-Message-State: AOJu0YxsodcgT0H6QHqJTrqkK7j/vdlv9BcyzU7UeSE0uMl9speeGHYP
	VsuGXa8i6EVYeHS01qvDkF2ShpOhRW8tV5IH5fSCizG8Q74A9vSn
X-Gm-Gg: ASbGnct7VUWu/RoApIv8r7eqYPk7DzZrwt/g2jrflmkEvYFvwQBECihKT4TKbfeuVKF
	qI3Lfx7ETBNFIFqhXjcTTiVMVRdTsHMrb9PQ5s1vryL3aoiHGTa4NQEQryphxjJdiUQF3ia9XwJ
	mLBXsW2s4msqQFxxdx3fxJ3025PGc2CwaX4LEa8usYrU1ZF9/T+V2dtoJRglkixRGWI/g/biMj8
	I/ce2IFOWduM0LMPp6RWK/9xjFQdQ7j4XJeShSfh+qZItMxWI+0Bpmcj+xuXJQy28DW/+j8bTjg
	SD2A5ly4m5Mpy8DUyyMo8UVPWA==
X-Google-Smtp-Source: AGHT+IEc+YyQrhZo9f7zyYG8/lmiMoe+tUfXq3VmdJX3/6HmzM7qshAy0MO9tQGfbVXaMLrD5NNjKQ==
X-Received: by 2002:a17:907:d1b:b0:aa6:b63a:4521 with SMTP id a640c23a62f3a-ab2ab558881mr329670366b.15.1736345649227;
        Wed, 08 Jan 2025 06:14:09 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0efe4941sm2500562666b.95.2025.01.08.06.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:14:08 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 08 Jan 2025 17:13:48 +0300
Subject: [PATCH v14 04/10] dt-bindings: mfd: add maxim,max77705
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-starqltechn_integration_upstream-v14-4-f6e84ec20d96@gmail.com>
References: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
In-Reply-To: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736345640; l=6754;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=mXulzNx4i224RQ8aQPPgZBPHi1e9Kt7QhQnDuW8jmXc=;
 b=K04FYt3FGPc6OSfA9ut5bj99NTfM8qLd1SS1ClVmYHAs3HFNKY89cxcqwGSFefhhQ5N1P0ueb
 mKXWVMX9qO8BJC6EyoswMs95eFzzmRL9YD/mSuxGmot5Uxv5CHdKKuH
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
 Documentation/devicetree/bindings/mfd/maxim,max77705.yaml | 158 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
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
index f8922b37489d..98a77dece2f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14287,6 +14287,7 @@ B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/*/maxim,max14577.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
+F:	Documentation/devicetree/bindings/*/maxim,max77705*.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77843.yaml
 F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
 F:	drivers/*/*max77843.c

-- 
2.39.5


