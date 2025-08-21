Return-Path: <linux-pm+bounces-32816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 929DCB30024
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 18:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A548A1883F7A
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 16:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86312DE6F8;
	Thu, 21 Aug 2025 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCRII4F4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BAB2E1F1B;
	Thu, 21 Aug 2025 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793633; cv=none; b=V+8XTqCT2gMJtKgN4lzTQXOQ07TCqJiNC3w3bWhIcnScfwlue2qrMq47eLE1oEtzNaHn7BtmaeO2bAk1fOHPPm7tkY919DUuK6EOgIyE22E+f+iOetrDh6eCvNbouqhQTQ3Q/A0/dSj0oioDHwtJmmBLFbxZ1Xos/Pz+82SR/Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793633; c=relaxed/simple;
	bh=30AneE3GLPOCsop/jgx4q6DCQawTpvUtEEBBU4gYbo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yva0VVidqvA8vkGCwq5TlbYSCKeGFIlRbyhgUwP0f39uJzbC6uXS0YWunpiH7oLTAkWY+FdNFVO/TpwHI+8B3m0PnfKR2vuYZkxb6cnJnARC0aKl/rfVISpycbGIFwtH5gRxVhNtPfiKboygKTsr3TOT2rAne/PxsoYBBWRDtTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCRII4F4; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74381efd643so314146a34.1;
        Thu, 21 Aug 2025 09:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755793631; x=1756398431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwhaNZ08bBHEsR9rXeumkyMkgjmU5QxiFqlW2m7YgJA=;
        b=HCRII4F4ig6GUrdPCoxP4a+AS83nO1Q8QvZRWZU7BeJAXGj9cb7ZXgQCeLY0Ir46Ar
         2ADeyyPrS+V6PvsYgCn3ZQTaxCDhauW0SFWojmCSiMk8/Gpra9e4RFOT+gwJWwN1nkjL
         fMo2esyDxFVkQ0i2Mi56XhWcexp4bymkGeFUyuAtSk3rHYk5m566G+/+Hp/k27Y212RM
         xyfZG2BFNJxDyA2e827GQLsJNwjB5m0SXnHfzXFhGZgSWdUKxQDv6hwIMjEO7C2IbyBz
         nAKPXVe0rojICBr4NlgACW/T4wXZbW9zUzFRsvdut1b91vP7J0iQc9hRiA+tfc8K3APj
         BXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755793631; x=1756398431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwhaNZ08bBHEsR9rXeumkyMkgjmU5QxiFqlW2m7YgJA=;
        b=s5Ir2YxG3QkTsnGLclEt1XS9Lt6pt2cJV8uGbAFIji3LZL0NtGk3Abv8lildGiOxiT
         7krEgD7EYyKBpy+6iExd1iscJD0n5a3iXByBUQH2g4J9a3p3LaolhHPS8Pc3sFzmi3rR
         Mt67U3BfPC79dXrFhC1y6zoeT+PpWlJXjC4+WEPVsfT/KjwQolze9jXp381cSJE6TPwX
         6Gvs0gu2APxyStCrI0KpCeo8hdoUY3NggeWZEREciNltHlAPVLsnmcXZYKCemc1QF41Z
         aJTtCZkOr9Jqss6oQ4JaEkcpKCnhnMyuttpjAUOMGWE3jU4zLW71+aqSeIdIv3iZFuGQ
         mJEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcUM6X1TrLTQV56zzpjE9VoIZgNIvoTM+5QS+G9rYqtSPzj001B1TyQLwjTWckGzoWnx0jih4hc+ap@vger.kernel.org
X-Gm-Message-State: AOJu0Yws3FtINIAadBmcow5+t2fn89TGl0moy/wVAdX/1uriwGkc0Hor
	0VotLhJvJQ1X6SHiH5UzMHbOvwOBRXE+uWFBu96GoIV05t3YpuEMy0KW
X-Gm-Gg: ASbGncsuUHobAvqfsrh2ih6CYp4nP3W0T4um64hUGEYSY011lCK2BG63GufdCxdv9Qn
	pU/B05lo80wng/jQFDewLlxwltIVf9eAx0jyqMNm3eTMP9wduCQPS4VZZ7838EZ8DfR7tCWy6eB
	Gn3INFyiGQjTkgK8/0o3uhbE7TEWwNXvQ+332VuUhkvOldwx556UrkvvLv4jTJ0o7t1w7u1xYdJ
	/m1HwuoCxWJ+iskUh/6YC+9j4yC1uys8OCfqApecVrreVmPFWJsJoa5oip0ZNZYvIiOd3/xyk5K
	IgR55j0RtxnyYhkJqPGFQrbMRxEHRus8nex6FsIONd5y1CuIF/65E/RJLmAEwo4vK2Qsn5ucs/E
	3wJ4F2agAB7Oz2KKaOJTRgnPh5QbJ8dIXi+3BmzRb1/2ulIpi6U3H
X-Google-Smtp-Source: AGHT+IGyUMANTlMdGPp+4RTF12Sthavabp2GSYDKoVzkB4ZEPnN+pPNdX5eKmlwrPgD+E87kywiFaA==
X-Received: by 2002:a05:6830:7101:b0:742:fc4d:6615 with SMTP id 46e09a7af769-74500ab159emr66751a34.18.1755793631127;
        Thu, 21 Aug 2025 09:27:11 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:b19a:18c8:26b9:21c7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61bec14b3cesm1674706eaf.27.2025.08.21.09.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 09:27:10 -0700 (PDT)
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
Subject: [PATCH V7 1/5] dt-bindings: mfd: ti,bq25703a: Add TI BQ25703A Charger
Date: Thu, 21 Aug 2025 11:24:44 -0500
Message-ID: <20250821162448.117621-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821162448.117621-1-macroalpha82@gmail.com>
References: <20250821162448.117621-1-macroalpha82@gmail.com>
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


