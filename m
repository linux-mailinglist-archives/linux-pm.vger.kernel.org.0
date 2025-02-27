Return-Path: <linux-pm+bounces-23043-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB3BA47AB4
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 11:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C163B1EF2
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 10:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA4922A7E7;
	Thu, 27 Feb 2025 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z5LfcoJn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B384122A4C6
	for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2025 10:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653201; cv=none; b=fm99lKwZLu7JTz7kfudN70V70i3bKzm0glNU39SbV4Ren8mcLrPfXqgm40+B1IdlbwmLS08vo0PjVPRUI5E489vQ81DcSaCp7AWR27VJFy3jk2I21WHywY6TJZ+JasBAB3/lY6a+BfCR3is2k+p6RPRH2M37xsiaTFjZEY6EM2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653201; c=relaxed/simple;
	bh=Fv+Vqu4aLmTdNPILdT13ma7EJcUK4NwGz9D26gQo45Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KLkXNIxt7hTYMa+UwDx2zpfTPN4ZyRqBBg1F7/YoUQ6nhcylCOhpGd9nA1KkszZOCMFbzmYVQPiFIPwy+w3DtloM91A2IA9762EOvEmXy0KeXpXl65SUS5t4TqXqlVIa2CTGiH1hNVmln7VQIUl/FLkdbGOyxlqOvMT5IS1u2ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z5LfcoJn; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e0505275b7so1119654a12.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2025 02:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740653198; x=1741257998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8k4UeAxgXPxbM8uTLcaaHeF7Iy7tq78qIdeyogxmduc=;
        b=z5LfcoJnf7eQcCuUhLj8zVyU28bV1z4K1zRdG4ZGt9h05sJvq26TBBZiL68WFFkT5X
         G+ZAQW+jiXqswyDQwi6AGPJc4ILM11gdPvh+FsDbBSnwhXMQZymoUhe2IIu4InqIij8+
         34fVLJoLhYgcKoz9CJj4JkDbS5akLHrZF9NDRz/d0CWVxK+dwQ5HIK81upuwOkz3RsrR
         /nKQ5Ud4iAImQIRUnqzjtxL5hmKD53JPydm4POLyye7u5/Y3zZWxx76cUuYBuv+NwcNM
         tEXzxusepb7Upqu0vSq6vXwBflNQ2FzthjPBV/97NoN1ngscKi6HHWl55/Qb/qB77enG
         ldRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740653198; x=1741257998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8k4UeAxgXPxbM8uTLcaaHeF7Iy7tq78qIdeyogxmduc=;
        b=HwOJj7HmvPEQxmGPPpzjqQR7JPbQ1sUSQbREhRDRD+i5zu5/9Mc76O98Lm7a2xLfsC
         2qqj8xFHbWFcYCCoTn4JWY8O/4qcJQ+Zzk0bH3Da5aSSp+ASOCnUfFjc7lwVoigo5QDY
         B/XMB4PktVLyt4AJV33PhL7oSoHuLYfPHagQj7sXT61l3CUqywVux18jCXTXFdXQBpqx
         iox2sFH8qaSkdnMIu+B/Glt4veyaNRvRsQvcjhzmvYkrIbmoTCoc6S2mj8QY14Kz78Xc
         UNssFImDQOtDY12jlxvDzSJw64Bpvc5SGf0Y80YyX86DZBUp/q5iw/LVa1H+4HkwWyVv
         aLeA==
X-Forwarded-Encrypted: i=1; AJvYcCXRJe+no/7+fjfyFvbgpiTL4jtPE0Ap9d9OzIlIbzQ7lD2YvKnFjJkqf2Y348CHndY4M/D8NsMzvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuNzfW2H+YkCDRb/8zvh20grNoMegJm566F1/1Gfb6DjVAAfyH
	WDU5K9MP+03MvSK/C+UlMbjz3bLuOWzeQ9lpZtPsJuIWaHLNEnXWGoMs4Gvv248=
X-Gm-Gg: ASbGncsriFffAHuQssnsgDlWy1yD1lqgsuRA2nb1pdQjPo7DBnzwjbvghua7r847g7R
	O8Fv2wy/bGLBtq4r1SMVKwBrBFfq1mpaF6m/2MYY2RMRUg6Cz5VOeSsMeAnZyI0arRcn64qI469
	F7s2EvDpXLlTb2DfikwOiwYM1MoyR6vCbkAv+1ZDS2ogWF0e68R8At6xinvvysfy3PZrdDdFYBn
	Mly97k3QjOOcgPhOfTlmeUuF4g0aMwR0nGJdsmWjen+Jsajo0KdXdsdIQ0iasAM2GjeNdRZ5SjY
	Mos3/7pOu/r3jpcGxepS8vHqiALG36m3/yOhhs03YVwy1r+nQFoU4diO3KJNZ8slXGIzI0JZYst
	ibIPYZAjIZg==
X-Google-Smtp-Source: AGHT+IFo+oKuun2HuLc+8veX5xMjZbpzxtHRPbWgeY3acHUg0egOWClYav/m4dncD6RgXkaOD/3PgQ==
X-Received: by 2002:a05:6402:5208:b0:5da:105b:86c1 with SMTP id 4fb4d7f45d1cf-5e4a0e01567mr8727100a12.23.1740653198027;
        Thu, 27 Feb 2025 02:46:38 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3bb5ad8sm901032a12.34.2025.02.27.02.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 02:46:37 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 27 Feb 2025 10:46:13 +0000
Subject: [PATCH v3 1/2] dt-bindings: reset: syscon-reboot: support reset
 modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250227-syscon-reboot-reset-mode-v3-1-959ac53c338a@linaro.org>
References: <20250227-syscon-reboot-reset-mode-v3-0-959ac53c338a@linaro.org>
In-Reply-To: <20250227-syscon-reboot-reset-mode-v3-0-959ac53c338a@linaro.org>
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
index 19d3093e6cd2f7e39d94c56636dc202a4427ffc3..1bd821877a16b274ac78a80017d003f1aa9fd471 100644
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
+            - cold-offset
+        - required:
+            - cold-reg
+
+  - if:
+      required:
+        - hard-value
+    then:
+      oneOf:
+        - required:
+            - hard-offset
+        - required:
+            - hard-reg
+
+  - if:
+      required:
+        - soft-value
+    then:
+      oneOf:
+        - required:
+            - soft-offset
+        - required:
+            - soft-reg
+
+  - if:
+      required:
+        - warm-value
+    then:
+      oneOf:
+        - required:
+            - warm-offset
+        - required:
+            - warm-reg
+
 examples:
   - |
     reboot {

-- 
2.48.1.711.g2feabab25a-goog


