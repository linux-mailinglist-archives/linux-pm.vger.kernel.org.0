Return-Path: <linux-pm+bounces-35848-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67042BC9BFA
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 17:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0BD5353A62
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 15:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E006D1F7586;
	Thu,  9 Oct 2025 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zp46Duvi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1981E51FB
	for <linux-pm@vger.kernel.org>; Thu,  9 Oct 2025 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023511; cv=none; b=PH/Gs0Yx+pL3Cyj/d3/jkZ0jDFZkIRav+pYviTk9po89t31rN2WCwmW2pBClfya4DTqeIwwTGiClAVl3yiZ1M5gH89fV82wTH7CwfKJnLG2LGbjzHtpjVJdXPGXK2oNqXWuzKaECbzV0MSDhlHJ4paW5dQmBtm0v8Vrn5xONW+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023511; c=relaxed/simple;
	bh=UpDpMfQpflET5V20J4n5YeVt8PTvypCmqoPo7NhX2qE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=imY81N9AY5XUhfsAp8b57U6mz0NcRJXLB1m6qhNb+J1u1jxSTqdvjPEHnpiDQazUnHNkasAQ1N8RUGxOmCyNQds/XFEL7oUzBYIZNr/gGNqwa9VdLbR5jXSVoZKAYu0bpmiGaCRoBjwnGq2myv7ZFgb5D8Us0XLN8yRABwih9iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zp46Duvi; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso186209666b.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Oct 2025 08:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760023506; x=1760628306; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnyuHEM+lsiHCfL6IDRN5IyrCB7LqRf5MK311Pq4COY=;
        b=Zp46DuviIM/YmcBGz9HgNDhelYZFWxZP2FpROp7MzDWNRG46ikPmK4ve3TFD2pzs5B
         3YFpbszvBgcChBmsbPozfxF9eeysnNB8vxpp3YUIL/hqFzKdsznLeDpOvv4/YP8F6JY0
         l+WGqB/nwkStIwLYUiBHl/WzyMaf/1GuRXi/GnFPmMa7FTLZqkahIWpgSw3HoeupC5Oh
         4kq9HI3sSPMCdNp9dviGXJutBy1z8UYklzqPeO8pauSp7a6A13LxJfYtRPMXNTj6uEFf
         O6/LiQp21u1+Tr0ekycKXMyzQANtRkH50FmDHXiSZwUi65NHiZZF4c1ia11VKS084cE3
         vK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023506; x=1760628306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnyuHEM+lsiHCfL6IDRN5IyrCB7LqRf5MK311Pq4COY=;
        b=gFK0bZxI9U+mQoORudw402Y7LF/2tL6STM6XYkoWLk0Ulo9cGxjA7NLAeSV2YngDe7
         JJw+/COGb4nyiYogFI94lGPGFcxIbKxSFpCkiT9UH0yj1YqJZc5iTdXTlwQIScnqysBz
         VS0t8kgNFY5uTNckDweNLR6wiw8CXsgnHXvGgjgVzpMqoF69OA+pfHdmiaj1JacRElTf
         qzW7K0HPOprQ8lkBOdTuI604gMtZpMr28dg9/eVukAg2ITtByaw3Ng+EkVbAUhwHvrmR
         jCkU98lqCW7PbTpz443ZlTzQ4ZGrlRoHlRVBxr0kWzLFJFG3Ml1gxNly/7uZyIMat2PR
         fyAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjG0AS5/Nle/Nrs2Rooq0HE3cXd/HLis2T95ShsG6Ou/e/+HHwYFkR+8cBpWwTml8VGKciAfDdkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCZ78L868DoLpmr1jeY7mu3e4POY0/9dbtdGjtlK/OTznFRlRL
	oi6+n8/TJ7nJv062wacDxlKTybaQkLHILDbM89WJXutJWASmQDC7ep8ev94wWo0pqGY=
X-Gm-Gg: ASbGnctOJlgTA1TbSPxfgFIMDg2+ZmkbFMNZ2MOmeyx+QkpX42G0M8aWBGBBLU7hEpI
	NJTm/U8ikkx1LmuuLxc/hzkIxguh2b1WG+9gLsC7eomfAahNHl8TYugI4dTBnl4Zqf3RNx4+Az9
	kZbTm5r1KgzuaPljXMJLaN8bOIyvvGyPoC0+Tqsl3JMYMnaQri8L5wTfW7SHoGDaLtjaupIPhuX
	nF6gfRQvMXwDeHrUxNN16YTZ0QkxlAh5gxaqfNTRZg7UgcnLb5PA8nxPRg1fDt1nCXuJtZE+wyn
	J+qWrQWw6McL5r1WuaEqLjIKBI7axwuH2IvCYtjncG9l5qGM7R9MEU97mgztFomEICMyXecNl1J
	u6YBcWWB0dx6NE95gIhCJlMPJzuaCJl/0bg0q+kIdaKF81toewrXzmNTHgH2qLi29YKK/NjyWeM
	qgvPXi6S71w9onrbx7FL8GBr7GPn+M3G061IZc/EVV
X-Google-Smtp-Source: AGHT+IH4Riik0fnXmeV/DELQ8JjDqdvmxMdv2ShW6jNS8r7k8K/9xDWa2qfNhUPNms6YJU3aaNnQ8w==
X-Received: by 2002:a17:906:d54e:b0:b3f:e1e9:22c1 with SMTP id a640c23a62f3a-b50ac8ebda2mr933717066b.53.1760023505945;
        Thu, 09 Oct 2025 08:25:05 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1908967566b.62.2025.10.09.08.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:25:05 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 09 Oct 2025 16:25:04 +0100
Subject: [PATCH v2 02/10] dt-bindings: soc: samsung: exynos-pmu: move
 gs101-pmu into separate binding
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251009-gs101-pd-v2-2-3f4a6db2af39@linaro.org>
References: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
In-Reply-To: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
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
 .../bindings/soc/google/google,gs101-pmu.yaml      | 67 ++++++++++++++++++++++
 .../bindings/soc/samsung/exynos-pmu.yaml           | 20 -------
 MAINTAINERS                                        |  1 +
 3 files changed, 68 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..209ee2f80d449c3eec568188898b3c6f7ae0ddd4
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/samsung/google,gs101-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google GS101 Power Management Unit (PMU)
+
+maintainers:
+  - André Draszik <andre.draszik@linaro.org>
+
+# Custom select to avoid matching all nodes with 'syscon'
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
+unevaluatedProperties: false
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
index 3439485437117aaffbe61b709468348231ca3cc4..9cf5b9300d4d96bfed8d1a75cc806925a884744b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10596,6 +10596,7 @@ S:	Maintained
 P:	Documentation/process/maintainer-soc-clean-dts.rst
 C:	irc://irc.oftc.net/pixel6-kernel-dev
 F:	Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
+F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
 F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu-intr-gen.yaml
 F:	arch/arm64/boot/dts/exynos/google/
 F:	drivers/clk/samsung/clk-gs101.c

-- 
2.51.0.710.ga91ca5db03-goog


