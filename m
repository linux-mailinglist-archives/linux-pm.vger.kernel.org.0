Return-Path: <linux-pm+bounces-33856-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE51BB4423D
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 18:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974BB16881E
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 16:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7496E2F3C34;
	Thu,  4 Sep 2025 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1CG1u5v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0942367DC;
	Thu,  4 Sep 2025 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002092; cv=none; b=XrqDvTLrMCaS5B6OQekvoIzAZ/SFVHCbUI2N0s4WmTNVMUHZ/hKC2EWNTAa9rR4HCOLI5OBobVDEPqzBFRae0Mm4tawDGVV7K3VqWSFgJUqxTAk4qOul3gvNFEOnYwQceubLYIbWWWe8B+4LSh1BLbeL04kQdA35ejHvWuA1A38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002092; c=relaxed/simple;
	bh=30AneE3GLPOCsop/jgx4q6DCQawTpvUtEEBBU4gYbo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kq/9cqsFca6rqR2gcR/ui0z4wGRp+bbICt+7pExijfmYxurNMq8EU7+CuiceeFIKJtShCKCZf+WANjRlv1ggig/G5oySD+I8//3RHnMkS8yFK88GyIhreGfIt025brD5ayqIJVvX9PIppDuP8qupFGHJnP6gYlct44tgBtxAizU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1CG1u5v; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30cce5cb708so839946fac.0;
        Thu, 04 Sep 2025 09:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757002090; x=1757606890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwhaNZ08bBHEsR9rXeumkyMkgjmU5QxiFqlW2m7YgJA=;
        b=i1CG1u5vCMmK6LmHbd2gvvf6x+gcYvq3uq/6Sj3V5DyyrF4yJCwiRTxsudLpR3T7V7
         pgRI1ASAPYbOZQc3epJXlZsqUgw7lVVnIeFqXT/FXxrELWzfLwwk84v5A0Aho8lY1DrI
         xpKynT3la5yYBBuz2gQ7//4+IiFf4AxJppD2JpuEeNFUN/555wsRkG4p2ZjXy1+lVi47
         s9zCCuL4WnTurCWoXzhgRzLyrVOyh8V0C8V+sYF1/3WHsPZnyXEhijpH5GupjkKV/r9V
         1QacvTMXBDWbxjatWaGkgrexT9k+h4dQ4+fw04Z1Y/zbvuPu0H44CieREgcw3/0UMHwv
         +HNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757002090; x=1757606890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwhaNZ08bBHEsR9rXeumkyMkgjmU5QxiFqlW2m7YgJA=;
        b=cqUrQIMTdjQn0x1xu9/QpapNC/ePdk18dXOzAXYwYFo0r+8ep1hxcxXfqQgJDBuAzu
         2/6HLER+fcQQTL6ykFfaqpbMtG4wxtCy+kbabGG7bROUIEB++CaWLx/lBAoCRAl1IB5p
         s4NNnBPBe2yrelAFXpGX/I0zgvaQMfhotrB2Nq4YKtWCNav3tiMfqR19agjCv0OmYtXP
         mR9ugZyeYyDBcedhou2vJpOl0N/K9jA3N9f5WY/E+ERiVHN76nqZiYx62u5Evr4FFVZm
         XUSDqXQImE7+UgK30reqsAHK1VoH44TbPnecgBwcKWBT3Awv1RFfwkUNb3PUwXnm5vDV
         lq7g==
X-Forwarded-Encrypted: i=1; AJvYcCWrqyIRLjIyyn7B8TRgiwzq8r/X5ESwVL5ziHSc+75kQ4NpvKJoD5PH20nI1AZu48SiPoHXjeXAsT1q@vger.kernel.org
X-Gm-Message-State: AOJu0YyOnWZFN3tfSroKJBisy7jBy25VeT3yMxhH/2wX/Ym2dxtXg+HL
	OnXktywxP/in1MEjh6TIqrco/9jYNbL+8pe9V973ElkoYQIlTbwg2r96Gpk11w==
X-Gm-Gg: ASbGncuGyrPl7uyfcZiWyKjqFhkPzAVdmKHTrYdq5V0HCddn9Oo/JIraJL1hsrQQNNz
	RkfNGoSDYFPe/6Akkjle+4PO0scP7z9mIWGcPqtwshrs+/FzoMY7d7e79G2B8KPVuj2Q16+iuhe
	t3RseOk1iasEf77kJM+s36UTYCvzJEUoYKzj8CMdTKKFbHsI4dPJY8NObB8iHLDWOmrwAA/f7lW
	y3b0GPdE0vyzOJxv2VZUneHNw7GtE3AsdDXqNNPknb2ceGdbIoKh3+anIOIOFb2GFUfNoRPJpGg
	oLPNpLz3Gg9TMGVdcFQYGtZKgjhFrZHP9bzfe9Kw9vr3iGPqsVlLyB1K4Dct3+j/qmu2/vPYgYE
	eSvFYl64kl7MyWvUcXY7sN+N5jOmgSKpZ2p01p4WEWAkmE9ORsTdD
X-Google-Smtp-Source: AGHT+IENuFTdThjy0C5PyNoJorQO0LITvjpC+z0vdRcLw4nPd9pMxYj4t6vj1Pai80yUZzJHVZlP7A==
X-Received: by 2002:a05:6871:8313:b0:314:9683:3758 with SMTP id 586e51a60fabf-31963480aa8mr9731532fac.49.1757002088822;
        Thu, 04 Sep 2025 09:08:08 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:c51e:64e3:dc5d:9652])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-319b5fcbf6asm2437593fac.20.2025.09.04.09.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:08:08 -0700 (PDT)
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
Subject: [PATCH v8 1/5] dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A Charger
Date: Thu,  4 Sep 2025 11:05:26 -0500
Message-ID: <20250904160530.66178-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904160530.66178-1-macroalpha82@gmail.com>
References: <20250904160530.66178-1-macroalpha82@gmail.com>
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


