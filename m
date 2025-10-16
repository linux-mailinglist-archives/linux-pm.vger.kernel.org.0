Return-Path: <linux-pm+bounces-36285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63384BE4688
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 18:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 763FF4F2677
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 15:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C036E36998B;
	Thu, 16 Oct 2025 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j3Bvuzdn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2AC3570C2
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630334; cv=none; b=l0CML638OYbz65QMEMntxSBmeYvjzmY1J0O+4+mvlu8X9sNHvO2O6JzxrQG8swlOL1pUfVDDYrmycC06UWEZcY5IjUdDTRESXIf+BAm/xptbIYhSLmUybSRpMoBJ7/bzybu0qDrtnWch7IiFjC+MR5xsCIZlrCI3lz2NJ1yq+bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630334; c=relaxed/simple;
	bh=yje7DjsIFhOq220Z+6NhYIgkw1TYq5z3ouqumPOvySU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EpLcNM/LMXBKl8zn99+0cxhaTSx+i2gKEuGcfc2ssm22BKUpla3gLaP6S6H4fXCrp+2VwmNs0Nzy02JwYTEJn2kXDFAKjtyS31HHADsgy3DweI5fPKflkbFaMPSYOVV3MTHFBT+MrARJFCwXCbp10KnKLCVSjld28E9hsepVMRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j3Bvuzdn; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63bdfd73e6eso4043013a12.0
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760630329; x=1761235129; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAQW91aNDUliYu6xIPIKkGd7wbQwulcJzXF5XdkzCOM=;
        b=j3BvuzdnvqWPDd8yiA4m+Xl8pwsEGv7TBxTlF8kTdCz4eJ2JKAVlTP64L6Zpn5GVG3
         H1fCqEkntxCHhxifXISG3cOgr2g0MMARG7XB71EhAlyvWoy+vcJL8Y8qXYGs3tPciBt0
         YX4xu1aPailT2yBtOWvsedv+WtNkXuS0yDGUgk2EMVCUOMVG1qgf0zdvIsaVVGO2qJoH
         7lNOYNNkU4ArugsujC95C6R8fxUMWJKu/WXXQIYgs2ephTgYu6jpUGsUsiJyNG8TdoWs
         5jLW3L+zig18HP827ZUirg1aCtr8VEuGJ++oFKzuKQDK0/XQRXaa60eNkoZyCu0OLJ0A
         4GGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630329; x=1761235129;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAQW91aNDUliYu6xIPIKkGd7wbQwulcJzXF5XdkzCOM=;
        b=fYYrTFcCsWs+pzXuDa6sBZ5btJT/nwUD6HFxC8izzJGmfA6m+HK5TQ4ZBrdhcKVpiG
         3wDZJb7qUgVA7by4INpMQ370kgRCvLXxk8sgfkZ5LmfBJqE2QhlwZUpoQ4eISJgkHbiV
         dQrvi4bWShuBZRqe04b748e/+RDNMyWswLuGYFEXEWtzIIk4Jqq8OB/vWyQM6Q/5Tu/K
         W7u2/WAKQKqffePB2HS8R3Fwjvrf6GDARkvphdr6aXDF6HB7U/6rdmly08PPFKu9vxTh
         nVnD1SpSUqXubsfFtaSYuA+HIQC5upCl9pP70kM48vpHMPv5+mrlWNAPiaYf9FrIZj9S
         OaCg==
X-Forwarded-Encrypted: i=1; AJvYcCXbmc1I7G9iV+8pDOAbvIAmVSpD8NlGLp82uTLAEfTmYh3JMlWBc4t/ELr1mS8lviatVC5N9ALn3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFkiMPMMX9ig7kIC5V0nc9I1ZGwxBtN8ev8IvlI8+JWtFPENfx
	Bm01UWRLTsNxhcM3taZKz68fTxc6B7XjWzFvncmpD5DI3V2uMPjl2o+y09jpoUVnAbY=
X-Gm-Gg: ASbGncujnKA/Md1KZNBPy92lXX3B+gWUcweq018y+GRj+Ub5NULhXLBPIGwxxsjG+MC
	SI3pCVv628L3NwAanKs7MVUaThHVLb9NYxk6Iy6eOs56FXTU5R2L/7wPZnZ0jpwf1UzV+V7bsxA
	RNm4bB6vzA990d5mSgOrhjRTUfCSZnvNHL85jwWDONGWA77sRUrJYJzM5O+/M+yifXU+tKSrCNI
	z1bNQJf7IS/BOxiH0m+c9ZTNywesbZy+o+sdWUpE21dJvCjjYKfaA+zVH9kxn8WWSjX1KhtZxE3
	GF9P41hE+83P/pw6+LbHE+X+93yZzkRPy8QSogSQiTQrx88n7ABV+IxIiu3jm4eF47RGvO6JdyS
	4S5+6hWV6wksYoc46vDgcWyku1p6UmwptEu+CgnNpsP+/V5in4HeVqQ7ILDyvzx915MUPDEXGI1
	U8fSZE6bTnsLaYXb5fgc6ziWqd1XtirYYJ/1orPMQmin22XETqlTgLLESJ2oxnvpEcj3rBDMs=
X-Google-Smtp-Source: AGHT+IFwFoVlzrd3EzfRgwjFNULDxybArmFxvRw3PQFLU4BEOlEa5CBeY9fanhhp1MvTHV/cP8fhDg==
X-Received: by 2002:a17:907:3992:b0:b40:c49b:709 with SMTP id a640c23a62f3a-b605249d84dmr571454166b.8.1760630324759;
        Thu, 16 Oct 2025 08:58:44 -0700 (PDT)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb4811sm549021666b.56.2025.10.16.08.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:58:44 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 16 Oct 2025 16:58:36 +0100
Subject: [PATCH v3 03/10] dt-bindings: soc: samsung: gs101-pmu: allow power
 domains as children
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251016-gs101-pd-v3-3-7b30797396e7@linaro.org>
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

The power domains are a property of / implemented in the PMU. As such,
they should be modelled as child nodes of the PMU.

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

Rob said in
https://lore.kernel.org/all/20251010141357.GA219719-robh@kernel.org/
that this is a known limitation in json-schema.
---
 .../bindings/soc/google/google,gs101-pmu.yaml      | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
index f7119e7a39a3fe0a0a23d1faa251d356f83ba501..a24390f6d2a54afe1aa84935e03f719a62f4fc8e 100644
--- a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
+++ b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
@@ -26,6 +26,14 @@ properties:
   reg:
     maxItems: 1
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  ranges: true
+
   reboot-mode:
     $ref: /schemas/power/reset/syscon-reboot-mode.yaml
     type: object
@@ -49,9 +57,23 @@ properties:
     description:
       Phandle to PMU interrupt generation interface.
 
+patternProperties:
+  "^power-domain@[0-9a-f]+$":
+    type: object
+    description: Child node describing one power domain within the PMU
+
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: google,gs101-pd
+
 required:
   - compatible
   - reg
+  - '#address-cells'
+  - '#size-cells'
+  - ranges
   - google,pmu-intr-gen-syscon
 
 additionalProperties: false
@@ -61,6 +83,24 @@ examples:
     system-controller@17460000 {
         compatible = "google,gs101-pmu", "syscon";
         reg = <0x17460000 0x10000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
 
         google,pmu-intr-gen-syscon = <&pmu_intr_gen>;
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
     };

-- 
2.51.0.788.g6d19910ace-goog


