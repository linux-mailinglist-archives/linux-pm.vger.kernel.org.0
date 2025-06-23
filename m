Return-Path: <linux-pm+bounces-29390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36888AE4B22
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 18:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637571885149
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 16:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73CF2BDC21;
	Mon, 23 Jun 2025 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbXMHe38"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A6A29B775;
	Mon, 23 Jun 2025 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695897; cv=none; b=mrOGBaoJHtOtwxCb8YeE7PwqjZlGLe7rhudcb9tENSMhD0gLoUEsH8HewoEwhGf6oDEUSHX/hOkU6IQx11FL6S7qfAbTnoPkds+pX4zGi4AoP+f1FsG1Ao5G1vka1TlH/cK35xZEqfFFDkE0G8UT9CbSVNBOgGmy+LTx9eqQtjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695897; c=relaxed/simple;
	bh=ft7NbL3+SgYknpVg02EJv2BM12d1RWzvH/nYxg8/bf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWd0Ik7s71tkLMneK24gpKQeG6Lvd8VII0H1OjgbLWwnzrJ1q1lKW/0ob7xL8ZBJ1RuRclUgTZLDpT24TigQRVqbawTDDD1eB9cGq6WATjLGMm/VFZkoi4NFA7EfPkkyjE0JjgPK0Mdg0DmCVZFgWn4EPIMX9OGBsuFRwFsk240=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbXMHe38; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-40a8013d961so985421b6e.0;
        Mon, 23 Jun 2025 09:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750695895; x=1751300695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HSC3tTGPVXUONttMHd7HqYNURks/BinMnUKVCe11+E=;
        b=BbXMHe38LeIT9ePwpI5XwHf9b9wa1j98WbVaycgw0hJSE34+wO5yICjAnMvIO+k9gh
         FopmVwCFpa9Fl5I8Gglj2TPzm2xRcxGmc4yUxmkYxGKe8BN/BMOE6XF6rLm3+1kFdIMd
         FJE+NPQWEGhHLkcopR3h0GTMC135gxJtDSSQNRfXx4RLRSIOULrfk2LpSjyhJRtjZzn1
         YNEH/jyVrGHBCfUFyy1m9SdQ6smaCELmvDfrLUDR0avXyve4tk2qSz4wBmtouJtBrbeF
         /VoPqQH+4nfyasByd04c7bRfVxm0wZ5eWXTE4bl4xfNvdeBzTPmRCWLw1zZ8LVwZAyak
         g2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750695895; x=1751300695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HSC3tTGPVXUONttMHd7HqYNURks/BinMnUKVCe11+E=;
        b=cMS+4BVvAzHABDOL19bQHq0q0OU4eIZDfhA4IYPyl/HEskqsylDTWwW6wrd7/cky08
         jYhedwoYNx1bfQQ6Mk+bBOMsuQyyA2DRBS2TswGcCMFEIc8PVvMhQdkYwtvzRsGa2kJ3
         9b5AT87RdB4ZYSGVrbiErKw0sIpZCZwQ95azOjf34M6QquArUh5MOy/UmhHaedcyR2KH
         4IVNL3V6Fx3LhRgt8iUk+rNcPUPOVJpMYyoZQjtja2gakshlnqe3UUpcnY0QB83SAJN5
         pT/lMC7xRVe+bjH9ps7QO721VLxj9bVjfXrqibqSL1m3pr3PipF4ouxsGJ3Qs+ohrmbp
         h3QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwVbXrww1ezV+mgrz5Uv09Udgx8oVWnux5pexr6MOeQNEsWyGmSRgUvOZlAe5fI6ttGAitJPRrlHKf@vger.kernel.org
X-Gm-Message-State: AOJu0YweGbwBjcfErcGIdiEMbZQCNBICgFH9q6IL6d7gibhQP3fHHiRf
	rhbSxrM49cpC4FKnLoP5g/yHyyueBv5MeDsrTueZz7KA/+6ugoIoImUHJJDVSw==
X-Gm-Gg: ASbGncsORKGCsVFxm12BxBJ+whrwtMc62JIDxSq3QrVmUBQZd9rgscRFGo/6jund5S2
	PkHuJBHXMRD4FetvQuXJsK47iyWlnlyWc2nucfv5kCigz14YFpR5Crbz3n8QADmtab1h9MpqbnK
	Dhap16ZtQwzC/orVU8HOZdIXk7uBpM18b48oDZ3zPSZpgrmVHtuGpVyedfGc8xQPc1FDYdcGySc
	Nr3PkdykSQtAvnd7V7u5glLmR9KISJnxo+Y3jXthFegX47XVogqC93gO8bM5mz+tBYqCxMCEm8T
	aynvAr8k/m2XluYTyBEAdb+KcjSlGaO4RymPcDyqe3R4wS+Y3dDXKM6zyLe7U9gg2ucsdTf61Do
	6YWhsJw==
X-Google-Smtp-Source: AGHT+IGifQrV3aIV7Nvo31pCmRa5jhQWQl51Xt5Ty7Lm01Ni3Azz67vgkxbnQNjKMzes9DfvIHJaOA==
X-Received: by 2002:a05:6808:4f09:b0:402:a5c:906 with SMTP id 5614622812f47-40ac6f1f615mr11028079b6e.34.1750695894753;
        Mon, 23 Jun 2025 09:24:54 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:61a2:e42d:d809:3616])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40ac6ced44esm1427308b6e.24.2025.06.23.09.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 09:24:54 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	sre@kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lee@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 1/5] dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A Charger
Date: Mon, 23 Jun 2025 11:22:19 -0500
Message-ID: <20250623162223.184304-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623162223.184304-1-macroalpha82@gmail.com>
References: <20250623162223.184304-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Document the Texas instruments BQ25703A series of charger managers/
buck/boost regulators.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../devicetree/bindings/mfd/ti,bq25703a.yaml  | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
new file mode 100644
index 000000000000..0727f24b8e54
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,bq25703a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BQ25703A Charger Manager/Buck/Boost Converter
+
+maintainers:
+  - Chris Morgan <macromorgan@hotmail.com>
+
+allOf:
+  - $ref: /schemas/power/supply/power-supply.yaml#
+
+properties:
+  compatible:
+    const: ti,bq25703a
+
+  reg:
+    const: 0x6b
+
+  interrupts:
+    maxItems: 1
+
+  power-supplies: true
+
+  monitored-battery:
+    description:
+      The phandle for a simple-battery connected to this gauge.
+      A minimum of constant-charge-current-max-microamp,
+      constant-charge-voltage-max-microvolt, and
+      voltage-min-design-microvolt are required.
+
+  input-current-limit-microamp:
+    description:
+      Maximum total input current allowed used for both charging and
+      powering the device.
+    minimum: 50000
+    maximum: 6400000
+    default: 3250000
+
+  regulators:
+    type: object
+    additionalProperties: false
+    description:
+      Boost converter regulator output of bq257xx.
+
+    properties:
+      "usb-otg-vbus":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml
+
+        properties:
+          regulator-name: true
+          regulator-min-microamp:
+            minimum: 0
+            maximum: 6350000
+          regulator-max-microamp:
+            minimum: 0
+            maximum: 6350000
+          regulator-min-microvolt:
+            minimum: 4480000
+            maximum: 20800000
+          regulator-max-microvolt:
+            minimum: 4480000
+            maximum: 20800000
+          enable-gpios:
+            description:
+              The BQ25703 may require both a register write and a GPIO
+              toggle to enable the boost regulator.
+
+        additionalProperties: false
+
+        required:
+          - regulator-name
+          - regulator-min-microamp
+          - regulator-max-microamp
+          - regulator-min-microvolt
+          - regulator-max-microvolt
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - input-current-limit-microamp
+  - monitored-battery
+  - power-supplies
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/pinctrl/rockchip.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        bq25703: charger@6b {
+            compatible = "ti,bq25703a";
+            reg = <0x6b>;
+            input-current-limit-microamp = <5000000>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <RK_PD5 IRQ_TYPE_LEVEL_LOW>;
+            monitored-battery = <&battery>;
+            power-supplies = <&fusb302>;
+
+            regulators {
+                usb_otg_vbus: usb-otg-vbus {
+                    enable-gpios = <&gpio4 RK_PA6 GPIO_ACTIVE_HIGH>;
+                    regulator-max-microamp = <960000>;
+                    regulator-max-microvolt = <5088000>;
+                    regulator-min-microamp = <512000>;
+                    regulator-min-microvolt = <4992000>;
+                    regulator-name = "usb_otg_vbus";
+                };
+            };
+        };
+    };
+
+...
-- 
2.43.0


