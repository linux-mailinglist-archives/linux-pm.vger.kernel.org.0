Return-Path: <linux-pm+bounces-36284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCF8BE465D
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 17:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473E01A6476A
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5C2369962;
	Thu, 16 Oct 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KyoXlhe5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931413570B4
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630333; cv=none; b=GkM0OCb4oS3bnF6AUWle9gBfaTH6MnEQ8k+692GHKAXYLn5hsDZ6ayHhV1IZHk/HpW/SbwLeDQqHxmArAUdTDfR3QsmlTnGJYIZMbS4rE+7kNz4g1GYdI2GYatmHLuRG/FaMjYfPYMd1QYJHmzxrxMRoaaM6APMLySKSaZrZD1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630333; c=relaxed/simple;
	bh=wjOKCcfNVyYH/LNtGu2O1tFUuSoILDand+0vO7/BXUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=blkpa7KK7i5Ez1qgEt4F+ubiW1wOZwK2LqdZgRHVf1ET7dUJGgIWR7i6BTEX8hTmAXL0LR9tY9Mtag5MPtoCDhdLxq9VyQs2R7wk5fh0Edqwd+tsdmT4kWqP7MnHmi4VhRuz3zzkHH9ig8sBU6pIcPJgHNA8KiHtDo2c4Y/V8WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KyoXlhe5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b4aed12cea3so137181866b.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760630329; x=1761235129; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFbyyNjgnPle57Vb/hgplgnkdL2H4IawW/m15NrLQlQ=;
        b=KyoXlhe54A7Osr6g5jLUwsQXEWnWVHUNuq6Pdhn7wFb3RdqmFkkeB6PCpBGOSrKcK6
         2eZ95/pvP78szTIp+MNef8rNHFwFjydfBppbffaEG3RKLjZ/mJcnvyjV4z3IpMKx0Muz
         iXp5RywyEe0k5llljh02eWswdFc485E/LXFdCOcDH+os//n1lfrO3wPSLo/68P1NBPVs
         fbpQR7HfwECuL1+B5ldHfCLAwb1gNPd2+1ZGv+tcnzxZjDqQ6cEQ7DkVqmRklXv4hB3J
         R8/U4wzclNdNtPfXSC3K2Hs6sTcynQ8UpW7OdMCzzgEhC3qV5JVLolw35fKgKD/q/g5j
         k2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630329; x=1761235129;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFbyyNjgnPle57Vb/hgplgnkdL2H4IawW/m15NrLQlQ=;
        b=KXz2gaoo+y0FaRJloHfXWiMdh010FnkSUg9jqDOJZUvjeraj/VxnfJNegDoFB2jZ19
         I/NGcpPn6PXPqv2rP3r37Cpb92f6Q7I/Rc36shSHln6ehKH+p8MrK3/BKiey9QCC2JYw
         ZrPe+Z9S1w6m8Kz/ZK15M0eccym53yNip3FOv4K8C8IqthCFTdYKBfhzX41hFmQBN3S6
         5xRYN2sdTK60lBwG8NJngvEdET3/34Tlne2qIzqbYnRaKXd7rAfy3Le4LdEt0f/404sW
         DBxNFyKlO5+Kbmg1Ib/PGJIxYwD+UmtP5SvMk/ZzvbpKi+toCprR/5iNpPKeoUtJbZdD
         /mVw==
X-Forwarded-Encrypted: i=1; AJvYcCXSrzaF6YRV8SjgMmqQd4kleICSa3/or7CirrFooVmCDvgXuu4CTOj3m/K+btJJW9ETm0CHj/xfhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzB4W6HhmT1HxYTjO9LtYlmZJFDUZNJZYUwkFRqueKQiJ5ECBBj
	xPWrLHOosV96DuqLWKr3P86E9/M3TboxkRi1lBhB92MAxdlYIzcOADpuU6GHn4ghCIw=
X-Gm-Gg: ASbGncsKPzf/16JH7Y+F2cPS8t5D9eyfvRFbTrPbXV8DppPoyJav9bDyfyEM8OVvxdf
	NsP4qQ/LAbJngxK+DWNeyQEPSZ1wckH0NGvXLL0gUDW9nPKJCHIcpurJ4PchVYZ1ExOZA5lc8HB
	zC/BXIvUSJ9Oq502Td+lm1OmfoxavhyWZ1pgIeVD4iofvnexWq495EOXgxNxVjoGgS21dOhesij
	iuNUZSj3uNtojHT2y8oNV6fMMdY49IUeCzZbQrZ301KmMWGVGiqr2KngJt9BzUTGGbDpomhAwsn
	L15l2EH4n3SJL+SnAQ9w0VRh0RTOLXIl12/YnGimi+g7Snu7hCaLjlYcWbdUWrDVYDDSg7zq5dV
	4hjatLtJiaQ3ay3qnxwxvhRhEVBZUE02pGnZENm3+iauOlNU6UKZt1LXz8WsSRByXQsYo6z29oF
	I9follWuB/lGYD6RAYq6KGFuCvBJs0nl7YcJ+XLi9TtRjbF6mkz0+4QqH7ILunBxCWEp0P9VM=
X-Google-Smtp-Source: AGHT+IED/FvFffti0T0jCYr1x6YRSUGnajOXW2cxPyV/0xQA94FV6cSMBe/igTzVHYhYkjAYJA2B3w==
X-Received: by 2002:a17:906:ef05:b0:b41:e675:95cd with SMTP id a640c23a62f3a-b6472d5bb90mr52421266b.13.1760630324239;
        Thu, 16 Oct 2025 08:58:44 -0700 (PDT)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb4811sm549021666b.56.2025.10.16.08.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:58:43 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 16 Oct 2025 16:58:35 +0100
Subject: [PATCH v3 02/10] dt-bindings: soc: samsung: exynos-pmu: move
 gs101-pmu into separate binding
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251016-gs101-pd-v3-2-7b30797396e7@linaro.org>
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
In-Reply-To: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The gs101-pmu binding is going to acquire various additional (pattern)
properties that don't apply to other PMUs supported by this binding.

To enable this, move google,gs101-pmu into a separate binding.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v3:
- use additionalProperties, not unevaluatedProperties
- fix path in $id (Rob)
- drop comment around 'select' (Rob)
---
 .../bindings/soc/google/google,gs101-pmu.yaml      | 66 ++++++++++++++++++++++
 .../bindings/soc/samsung/exynos-pmu.yaml           | 20 -------
 MAINTAINERS                                        |  1 +
 3 files changed, 67 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..f7119e7a39a3fe0a0a23d1faa251d356f83ba501
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/google/google,gs101-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google GS101 Power Management Unit (PMU)
+
+maintainers:
+  - André Draszik <andre.draszik@linaro.org>
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: google,gs101-pmu
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: google,gs101-pmu
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  reboot-mode:
+    $ref: /schemas/power/reset/syscon-reboot-mode.yaml
+    type: object
+    description:
+      Reboot mode to alter bootloader behavior for the next boot
+
+  syscon-poweroff:
+    $ref: /schemas/power/reset/syscon-poweroff.yaml#
+    type: object
+    description:
+      Node for power off method
+
+  syscon-reboot:
+    $ref: /schemas/power/reset/syscon-reboot.yaml#
+    type: object
+    description:
+      Node for reboot method
+
+  google,pmu-intr-gen-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to PMU interrupt generation interface.
+
+required:
+  - compatible
+  - reg
+  - google,pmu-intr-gen-syscon
+
+additionalProperties: false
+
+examples:
+  - |
+    system-controller@17460000 {
+        compatible = "google,gs101-pmu", "syscon";
+        reg = <0x17460000 0x10000>;
+
+        google,pmu-intr-gen-syscon = <&pmu_intr_gen>;
+    };
diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
index f0fb24156da9b8980dcfd5339ae75f12a71cf6d6..83f18a92fa1c4de75a90f00475cf17d5f0b652e4 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
@@ -15,7 +15,6 @@ select:
     compatible:
       contains:
         enum:
-          - google,gs101-pmu
           - samsung,exynos3250-pmu
           - samsung,exynos4210-pmu
           - samsung,exynos4212-pmu
@@ -36,7 +35,6 @@ properties:
     oneOf:
       - items:
           - enum:
-              - google,gs101-pmu
               - samsung,exynos3250-pmu
               - samsung,exynos4210-pmu
               - samsung,exynos4212-pmu
@@ -129,11 +127,6 @@ properties:
     description:
       Node for reboot method
 
-  google,pmu-intr-gen-syscon:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description:
-      Phandle to PMU interrupt generation interface.
-
 required:
   - compatible
   - reg
@@ -194,19 +187,6 @@ allOf:
       properties:
         dp-phy: false
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - google,gs101-pmu
-    then:
-      required:
-        - google,pmu-intr-gen-syscon
-    else:
-      properties:
-        google,pmu-intr-gen-syscon: false
-
 examples:
   - |
     #include <dt-bindings/clock/exynos5250.h>
diff --git a/MAINTAINERS b/MAINTAINERS
index 8cb7a124f6e81372060c38ac2b3c9a11505ae004..22573869586eacdac0d0a075d4a691849272442e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10597,6 +10597,7 @@ S:	Maintained
 P:	Documentation/process/maintainer-soc-clean-dts.rst
 C:	irc://irc.oftc.net/pixel6-kernel-dev
 F:	Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
+F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
 F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu-intr-gen.yaml
 F:	arch/arm64/boot/dts/exynos/google/
 F:	drivers/clk/samsung/clk-gs101.c

-- 
2.51.0.788.g6d19910ace-goog


