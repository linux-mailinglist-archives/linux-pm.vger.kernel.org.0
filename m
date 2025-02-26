Return-Path: <linux-pm+bounces-23001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB9BA461C5
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 15:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD383ACE46
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84447221579;
	Wed, 26 Feb 2025 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tiix1jWe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7927021D3C4
	for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578906; cv=none; b=dS5t11oCqkm1mCx3Ed/TtFX35SKow+RtGylmf8FqJe/fbtDVfnv9boiQRd2br8OZvc0WITqiw4cp1Pm6PoovA8AIvQPLJYxdG/3O5wxxK2Uldf/A50ioUZD68DkCMwBE8MUQ4QnNt7jgQKOmNHt5blAoReB2OgreD6gcNKRJfiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578906; c=relaxed/simple;
	bh=P4n2TUurAZ0QjjR+H15n7mDXmaltx5kef1Mee5VWzEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aWKqmRWQ1IJNwG0Ze6n1wd2Q9coYGjqIQbm0B8gUpbEqROqw8lIkk4+oDqjp0/jCdVvCXtNBFN3JPmXi18qGUsueaSLeuyWoyg0BZy6aNW5c0J0mtlYB3D06qqjxX7JM1EQDMfoRXH6R1DNAnlK2SK1lB9istxtrGarlUNkEIA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tiix1jWe; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abb9709b5b5so1242916766b.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 06:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740578903; x=1741183703; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptWMUTZMUOXDkynnwEpEC1SXLl/PZJE3+R5Z2ydqVns=;
        b=Tiix1jWemSfLe80DOWkD8QDtI0y59joeUEOZygHzgOYX63vDp7Q3cBvRTExqrPlKi5
         B8bKl29N+f27RouT0O14dYWmpP2Z8linkBw/j+WGO5AwrBm5eQYv3RRgK3nyejpSwJMc
         a3IWtYhjafz669eiv1ABEEkZfZhx0N1AMkLMdrDBZadkkLm6r0gFG9gz+qckY+Y5qidh
         cMAxU+cm4U/tjVyQuiqxq6sRSBV74EiHohH9SPQqz+mzpalwJ6JN9Hy7tZzjR6gSu0el
         8cvQOHBSAcFWjeYsAZAHGfI2M7xjLz50rf/sAB3Ui/YIn5D4FhSXGI1+j/OsYlIpBXOW
         +9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740578903; x=1741183703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptWMUTZMUOXDkynnwEpEC1SXLl/PZJE3+R5Z2ydqVns=;
        b=rIijr/nh+bkBON08B8n5awY/WWqysCV9CRLtl6zopxPaSBoIgxasOmfGeRTqncZVyy
         kB2V3UhIPFKgQ7TydB5eGMZ50mqxkqjjA8qhNQBtdI9o6kOu8Pt3xG0OxnR6zIlqQwE8
         NRG7eUXDJBhL9IMUK/SddzRnFt5ABy2jJgmnYNuC3kzEySxaJsS0txT2TevTlql4aZtx
         zM9KVmslCd0sS6sXl8VJ++WyaB5O4GodIC1A8N7lcBJz+GHH2ROF1eozDhao3V2QF5xE
         NKiRrSKIO8H1fmXcBM3act+lDBgrHkeLbhFCKIqjeKSwGwr5sqBV0GodU0l8WwjnpSs4
         34LA==
X-Forwarded-Encrypted: i=1; AJvYcCV6iXdUUURu1EJRPd6GeI2sBM9eadDIRjI9neehP1U+Q41UWLtirhkKifynCBXTxkObZo95a96npA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYobBmJVRihecunkeaGycUwGOVNalh6faV0i62EFzwko6Oormh
	gYI4ppj/w/KTALW9XPHj9F0XjJ1cR8XDkkQyJA72GwCP63lCR6ZxINl6pwLy9cM=
X-Gm-Gg: ASbGncvMhYwkee8SMcZvJwLHeKKFUCW3EV+ev7GTVVoI2CRE55WuBqb/FWw+2xPbN5x
	U/KE+DrnHqgcRQ3t70vgE7UX9BGR2Yc8qppMcuhDyEZq+vctXDmBGTiijGnWsRksbEJ7F54PXbJ
	MateYY5Vf6Ow8OzfwyEsHEBq0fT/taBUpbNO+XX1NdXVoQJXGpqRBOhYqGiOFaGRhSyR1IAqXPP
	COs4MUGqzYm7k+5ID003yzFQohBERDemGre3nr4StzP6kuttAZqte0jYWnELbdwSUdA1Hxxdrrl
	CKn6YCY2vHvgqcrLV/Re6A0F4ax2GIpxPuI8OJdPwaWZEpEzaxVSsYcfkJtWhgWCYNx9u1wz8Yc
	1lG+7jqlyoQ==
X-Google-Smtp-Source: AGHT+IGalEUuTDwYDfunN57TQDxRb+0j8EpUzGDr7qDDi15A5nUiai0Xcy6PUoLEPI47zu9GGOn6VQ==
X-Received: by 2002:a17:907:6d27:b0:ab7:e567:4fe8 with SMTP id a640c23a62f3a-abed0d60b6fmr922741866b.25.1740578902612;
        Wed, 26 Feb 2025 06:08:22 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20b6024sm330157566b.181.2025.02.26.06.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:08:22 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 26 Feb 2025 14:08:20 +0000
Subject: [PATCH 1/2] dt-bindings: reset: syscon-reboot: support reset modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-syscon-reboot-reset-mode-v1-1-91c1b62166ae@linaro.org>
References: <20250226-syscon-reboot-reset-mode-v1-0-91c1b62166ae@linaro.org>
In-Reply-To: <20250226-syscon-reboot-reset-mode-v1-0-91c1b62166ae@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Add support for specifying different register/mask/value combinations
for different types of reset.

In particular, update the binding to allow platforms to specify the
following reset modes: soft, warm, cold, hard.

Linux can perform different types of reset using its reboot= kernel
command line argument, and some platforms also wish to reset
differently based on whether or not e.g. contents of RAM should be
retained across the reboot.

The new properties match the existing properties, just prefixed with
one of the reset modes mentioned above.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 .../bindings/power/reset/syscon-reboot.yaml        | 74 ++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
index 19d3093e6cd2f7e39d94c56636dc202a4427ffc3..a34b1c08b7e0f34574a0257e13c02fceac0243ae 100644
--- a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
@@ -18,6 +18,11 @@ description: |+
   parental dt-node. So the SYSCON reboot node should be represented as a
   sub-node of a "syscon", "simple-mfd" node. Though the regmap property
   pointing to the system controller node is also supported.
+  This also supports specification of separate sets of register/mask/value
+  pairs for different types of reset: cold, hard, soft and warm, using
+  the respective properties with the respective reset type prefix. If prefixed
+  properties are not specified for a reset type, the non-prefixed properties
+  will be used for that reset type.
 
 properties:
   compatible:
@@ -49,12 +54,41 @@ properties:
   priority:
     default: 192
 
+patternProperties:
+  "^(cold|hard|soft|warm)-(mask|offset|value)$":
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Optional alternative offset / mask / value combinations for specific
+      reboot modes. The mask is optional.
+
+  "^(cold|hard|soft|warm)-reg$":
+    description:
+      Optional alternative base address and size for the reboot register for
+      specific reboot modes.
+
 oneOf:
   - required:
       - offset
   - required:
       - reg
 
+dependencies:
+  cold-mask: [ cold-value ]
+  cold-offset: [ cold-value ]
+  cold-reg: [ cold-value ]
+
+  hard-mask: [ hard-value ]
+  hard-offset: [ hard-value ]
+  hard-reg: [ hard-value ]
+
+  soft-mask: [ soft-value ]
+  soft-offset: [ soft-value ]
+  soft-reg: [ soft-value ]
+
+  warm-mask: [ warm-value ]
+  warm-offset: [ warm-value ]
+  warm-reg: [ warm-value ]
+
 required:
   - compatible
 
@@ -70,6 +104,46 @@ allOf:
       required:
         - value
 
+  - if:
+      required:
+        - cold-value
+    then:
+      oneOf:
+        - required:
+          - cold-offset
+        - required:
+          - cold-reg
+
+  - if:
+      required:
+        - hard-value
+    then:
+      oneOf:
+        - required:
+          - hard-offset
+        - required:
+          - hard-reg
+
+  - if:
+      required:
+        - soft-value
+    then:
+      oneOf:
+        - required:
+          - soft-offset
+        - required:
+          - soft-reg
+
+  - if:
+      required:
+        - warm-value
+    then:
+      oneOf:
+        - required:
+          - warm-offset
+        - required:
+          - warm-reg
+
 examples:
   - |
     reboot {

-- 
2.48.1.658.g4767266eb4-goog


