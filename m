Return-Path: <linux-pm+bounces-32229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 836E3B23ADD
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 23:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF191AA5B69
	for <lists+linux-pm@lfdr.de>; Tue, 12 Aug 2025 21:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE222D0C75;
	Tue, 12 Aug 2025 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFyrvVDZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65F21DD543;
	Tue, 12 Aug 2025 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755035130; cv=none; b=q5IG09oKNC/G5s3+nYE1W40EFba9I9MR3a2ZzCTWlCopaGtlZiBm395X6PCdD9M/7Vl7Pi1/rtJQ5uc7fwye5PTowjs5X4CAlrkLg6K5a7EAXqX/DU6zjjzfxi0oNn5RnfjkFZNd2y+COpAqWZagmvlyvEORQQhSnmuAgpmZeGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755035130; c=relaxed/simple;
	bh=30AneE3GLPOCsop/jgx4q6DCQawTpvUtEEBBU4gYbo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M11WapVvf9cUR+F5Pcbsov0z9B4y3KQHp+QO02ALbU5B9W0RVNW0h3yUAh1RQ6nNJXQNc7jIddQKzFhr1QDqH+1QmVeZulx/mwjetPO5WK+KTeTE65WWwSf5UkR42pWLe4Kk/I8Du75AqUhw/l3ZGNdQGEazcATwmkN9xiNxI6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFyrvVDZ; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-30b6bd0a352so3735989fac.1;
        Tue, 12 Aug 2025 14:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755035128; x=1755639928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwhaNZ08bBHEsR9rXeumkyMkgjmU5QxiFqlW2m7YgJA=;
        b=YFyrvVDZnSFQWSBfejqSHGdxF8nPe96f5cOXs5RJ3iQ0P6bvhxgiAxDZiy5Gen9WjT
         BgdS3Yl9UhgtmHe2TL1BiVGtnJURXnOJERANkkyP8khXtEmNMQnkS6k8+lx/gaFEL/Rq
         y01bfOv75mEIHk+wdz5w6sTryXyyKSwHzVwmvOJ0+hO8uoiRJGdGnPn/6i656FfRmU7e
         YpPymsVYIvKYVVdN7IbIxKR9xMEKvTRb7LHN/PVm8NzZIq8WsZRM6PYvu5fYtH4s4QqV
         ekYBJpZoP90G4Gq+/NpZRsm8GE4/3RVuzlMf9I2M0n7DRxSxWBde1UQ/5DD3hRPgxmOV
         dPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755035128; x=1755639928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwhaNZ08bBHEsR9rXeumkyMkgjmU5QxiFqlW2m7YgJA=;
        b=GQMZ3p2x17TBkHPvWm5z7h8R0iolVcSsi01R0Km1ymyE1P+ldthppnIhhf6CEFTTDQ
         kjQ7C93BJvET3WyoTDZasmFVYUelAanL3zKTI6Y5MfHr4D3nKtd+o6xL3CaaTfu9IYZ+
         sDBwgL+vgflkuOSsm25MylWSH16XOtRD1CEtPAKVnIl7/c5hJaP6Ie8BfISf+bxgVQr7
         3XLSS0XEHFqSK/D2h5s4XuhuDCc+u9Kmdy6E7h5ZvCKqwF0fl0AUIp0ldoytgPc9yvUg
         l78LpNe5odN+rUQgNsz72QU8Bc35/k0Ki1I18aYKnjNHDRCm5FuaRUYJJzcg4Z1D6BU8
         P73g==
X-Forwarded-Encrypted: i=1; AJvYcCUdERCliBFqQRsA2/ThuB3hivMAKdITWEOo5KQyCv6XiPOkANb+n2QGsdSk5TuVS77/4V8/R5XWYoks@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1lcxHF04XHiCewp4dJ7PrQCgfZpE4MldCz7yCvnMUyCE9VwxX
	dYWjIb+qLxxOU6p8iJatVZyFwUwlcYpco1pFFoFVPBtqu5JBCHm3fJMV
X-Gm-Gg: ASbGncuvjIsbpieiPGYc9JjQBAyWOLc3wkrcE3eFVxg9z/53Dw1ynZaPj4U2kqNCOCD
	iK+Iuv0rZQMXKOe/higkbe7XNg2JLyof/X6F/zwzdKrKuoQ9vsos+K0TNJ4JJa4nWDcdZh2UpfE
	Gy3YN9dKjw+Czu9gn0nxxd5KT0LkoJn7NAAsKo5XXFb+UiXbtXPUpiA+oCJuSQJCuYX3ETof8VO
	1PBa7piqZCFgARIkeG8NMkugYTovimLAOlp4AbjsiUJrATD5wDmu7ODUHn/w4mmzIgwEsewtKAj
	zn+jIhqveFLF+w2UYfibiRehmhaTvIL5YIpfHRhNqUNEJipdrYrjlfOpttCNOV6KAow+abnyFZl
	0xf+bRmU29TQ9/Vf+xVb/1Cdfo8sC6RDJElMiVHs17w==
X-Google-Smtp-Source: AGHT+IFRd92U7K+eHEZdgRM8AARsngHyRg2/qFWS4mv5fzIbnsYlOoWoHuQ/KlUZysXRqhYqbUFjgw==
X-Received: by 2002:a05:6871:72c:b0:30c:9385:bf11 with SMTP id 586e51a60fabf-30cb59ab9a3mr511880fac.3.1755035127654;
        Tue, 12 Aug 2025 14:45:27 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:d904:cea9:a76b:d0a3])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30c10c7a694sm4092741fac.9.2025.08.12.14.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 14:45:27 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	broonie@kernel.org,
	lee@kernel.org,
	lgirdwood@gmail.com,
	sre@kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V6 1/5] dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A Charger
Date: Tue, 12 Aug 2025 16:42:56 -0500
Message-ID: <20250812214300.123129-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812214300.123129-1-macroalpha82@gmail.com>
References: <20250812214300.123129-1-macroalpha82@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mfd/ti,bq25703a.yaml  | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
new file mode 100644
index 000000000000..ba14663c9266
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
@@ -0,0 +1,117 @@
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
+  input-current-limit-microamp:
+    description:
+      Maximum total input current allowed used for both charging and
+      powering the device.
+    minimum: 50000
+    maximum: 6400000
+    default: 3250000
+
+  interrupts:
+    maxItems: 1
+
+  monitored-battery:
+    description:
+      A minimum of constant-charge-current-max-microamp,
+      constant-charge-voltage-max-microvolt, and
+      voltage-min-design-microvolt are required.
+
+  regulators:
+    type: object
+    additionalProperties: false
+    description:
+      Boost converter regulator output of bq257xx.
+
+    properties:
+      vbus:
+        type: object
+        $ref: /schemas/regulator/regulator.yaml
+        additionalProperties: false
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
+                usb_otg_vbus: vbus {
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


