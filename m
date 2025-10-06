Return-Path: <linux-pm+bounces-35743-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03275BBEB17
	for <lists+linux-pm@lfdr.de>; Mon, 06 Oct 2025 18:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E83F84E278C
	for <lists+linux-pm@lfdr.de>; Mon,  6 Oct 2025 16:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28D62DEA74;
	Mon,  6 Oct 2025 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eORaqWC6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359F52DCF6E
	for <linux-pm@vger.kernel.org>; Mon,  6 Oct 2025 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769013; cv=none; b=D+UYdY7q7mmPgAxYAwcz9dXNJJ/Re/AE1uJOAXLseN1tb7jjZUHimv0fSBPJ5r7U5f2IoKjTF7GpXxpudaYEtJCer2XLGLoXXx0NNIvslJ/QSIf2jiBHNYZIkVI90x/YXdZo9X6j35Hnp2G7u1OIwep4ehY/M7JqHMMZcxnHgeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769013; c=relaxed/simple;
	bh=wLNu+/DsN5vQuzcNh6XEOEj8a//dvPEfokNHLsVRk/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GbhNwAuQOkjm/iybmoc/TpG+tK4E1IYqph3P9reE44wzxlLMS+aPwfZ90cFxDYG7mFoYCThHuxtknDUl4Q8PEFdpzXZYJ7KxouKau0wgRJat5fTUUBSfzIz7l7tmYCA5FtPDrxdFy2qW1N7kHtQU108ADCMAZswX8taiFvRfBJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eORaqWC6; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so755325666b.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Oct 2025 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759769009; x=1760373809; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRXbXMcdQaybVyL41swV860lNNbaXOzw6nia42KxTE0=;
        b=eORaqWC6L/7zu+5Qkr2CnVg9Hjc39/nT5r4jLMYGoKL4VpzOAMWtZoEQJZf2CJOUbj
         OMXv725KUHuNDI8da4Gze4W1KAoYgE9sqldwLxJg6RGtSf7SHqRy7hZPAsCeKFFo8gpb
         Qwp5JQ+cUIZxAiqWLovkrs7n8Zj3ZvKQrl5s1QtOiXyblh7KQLOMA/fe6dLpjuSuppGh
         6Zi2y7xcEQ3RVy0cmaiE0HSHHnyvo/OqBSA3X8xDTVgFfRrl3Dkx+xUrU1kZ4Yl8tNWe
         y6VCC6kTYteCtjfP6rawCuv2o+JbsP0NdazrbS8/72UUZO08+irLYKeld6OtBQfg+6BA
         10hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759769009; x=1760373809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRXbXMcdQaybVyL41swV860lNNbaXOzw6nia42KxTE0=;
        b=qP6/aFf5dv60K6rSputp1eucyIHJ21uY6JYgcA3YEdh4AYo7PZZMsIialD1kN2vuvV
         +llbvjsRPSVTFEqGjzS2v1XZugweZEYoqKO+JWBU0adXJMTeIW4/kPqbEozTrMgjraZq
         AoWbqi7PIEO8gi933UYoUimBh9lROnWzi33qPNwsUGMN+k8e9JiREdSgWSPsoTPobYpa
         kz0YFPUpSwpI84AX26Bh8SgGLrxn371TP0PHeIm4tCvIv/rRjuwTVd9fLadKwnC0G/+5
         6FM0Bs6lqzMwF7Aijr63Vi0EG90Jo7P3oqtK4Fcu89ltJ0Subtv6G1efjV56eJiA3Xhc
         eWmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtL9idAw/Gbkt6qNM0p8g+3gBS/X43GQAWqtLmv+KvX3frL8MBvbaeup8QERyA5zshM8LwDALrDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7t1NYZZBzknEuHGTb4sxnO9ZIIeoyjBeK0TaoZkOIz4YSCsVA
	C1F7xaN4cmTYNlLH6zNs/fRGiugpn6kvertqmk/Q4/K1tQQhFSA2o4ifC563Yckw9Mw=
X-Gm-Gg: ASbGncuH+0hu2gvraG5h1Tw0Zkf94MHxg3UMEYYEkWl6HvZaZ4953ip/RQ/gYLFytsI
	9oT0733wwS+9mI71vJj6iu6/D/RDsQyollLzz9OStIyWCdwLkyq8BCTbsuBNtXJ92L1KBqyhwgD
	NZ/fqKDr7sfVjcF2Oms69P9vmwvP4+9n6pDRNcsMmErRmvy/HgSoDzCrrtyVqZwJRkxp7EvrUOb
	/lyMF4h4gPSBvUxCWfbp2uNWgt6dtpBo5LG8j74x+joyc3GyMroHpV8vGWpGOW2HgMAuTVvF3ra
	z6dwLWtuo1AyHQoru4iALXV3WietZhJDRW4gosTkXEbc6OUHGts4qMu2mTHfZW3J1q3TsWov3ZV
	GbVvTh0BkJHnmaM1zc/Zd/4TBsatwkqFvGZXrEwMxQMQX64AsoU/S69zg27VT7/GsQQ97t8XMNN
	IuTZtRQl3wS5Akeyw9T4JVO4D+6I31BBoO6QWd1P5/aDidowiRqHg=
X-Google-Smtp-Source: AGHT+IFevyytLGxXOVyUvp2iRJsBS5AIBa1K8SbZl4T99bvaj+wJPujm9cyg6wpDoYz18ydBH9OBMQ==
X-Received: by 2002:a17:906:c108:b0:b45:66f6:6a17 with SMTP id a640c23a62f3a-b49c429cf5emr1502398466b.45.1759769009323;
        Mon, 06 Oct 2025 09:43:29 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa01esm1193841866b.2.2025.10.06.09.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 09:43:28 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 06 Oct 2025 17:43:28 +0100
Subject: [PATCH 02/10] dt-bindings: soc: samsung: exynos-pmu: allow power
 domains as child on g101
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251006-gs101-pd-v1-2-f0cb0c01ea7b@linaro.org>
References: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
In-Reply-To: <20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The power domains are a property of / implemented in the PMU. As such,
they should be modelled as child nodes of the PMU.

Update the example while at it.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
Note: Ideally, the newly added properties (ranges, etc.) should only be
'required' if "^power-domain@[0-9a-f]+$" exists as a patternProperty,
as they're needed only in that case. As-is, this patch now causes
warnings for existing DTs as they don't specify the new properties (and
they shouldn't need to). Only if DTs are updated to include
power-domains, such an update should also add the new properties.

I've not been able to come up with the correct schema syntax to achieve
that. dependencies, dependentRequired, and dependentSchemas don't seem
to support patterns. Similarly,
  - if:
      required:
        - ...
    then:
      required:
        - ...

doesn't allow patterns in the 'if' block (or I didn't get the syntax
right).
---
 .../bindings/soc/samsung/exynos-pmu.yaml           | 53 +++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
index f0fb24156da9b8980dcfd5339ae75f12a71cf6d6..c2db1cbb969a9a6fea5208dc2990f2144fa480e6 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
@@ -93,6 +93,14 @@ properties:
     minItems: 1
     maxItems: 32
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
+
   dp-phy:
     $ref: /schemas/phy/samsung,dp-video-phy.yaml
     unevaluatedProperties: false
@@ -138,7 +146,7 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 allOf:
   - if:
@@ -201,10 +209,27 @@ allOf:
             enum:
               - google,gs101-pmu
     then:
+      patternProperties:
+        "^power-domain@[0-9a-f]+$":
+          type: object
+          description: Child node describing one power domain within the PMU
+
+          additionalProperties: true
+
+          properties:
+            compatible:
+              const: google,gs101-pd
+
       required:
+        - '#address-cells'
+        - '#size-cells'
+        - ranges
         - google,pmu-intr-gen-syscon
     else:
       properties:
+        '#address-cells': false
+        '#size-cells': false
+        ranges: false
         google,pmu-intr-gen-syscon: false
 
 examples:
@@ -231,3 +256,29 @@ examples:
             #phy-cells = <1>;
         };
     };
+
+  - |
+    system-controller@17460000 {
+        compatible = "google,gs101-pmu", "syscon";
+        reg = <0x17460000 0x10000>;
+        ranges;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        google,pmu-intr-gen-syscon = <&pmu_intr_gen>;
+
+        pd_g3d: power-domain@1e00 {
+            compatible = "google,gs101-pd";
+            reg = <0x1e00 0x80>;
+            #power-domain-cells = <0>;
+            label = "g3d";
+        };
+
+        power-domain@2000 {
+            compatible = "google,gs101-pd";
+            reg = <0x2000 0x80>;
+            #power-domain-cells = <0>;
+            power-domains = <&pd_g3d>;
+            label = "embedded_g3d";
+        };
+    };

-- 
2.51.0.618.g983fd99d29-goog


