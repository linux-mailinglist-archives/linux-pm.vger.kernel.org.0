Return-Path: <linux-pm+bounces-23012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DB8A46718
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 17:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A045A16712A
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 16:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3834223302;
	Wed, 26 Feb 2025 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Od1xWWrx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5C0221F21
	for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588281; cv=none; b=E1kOsT02eHq4jP4ldx/CA+vW2CwxoI3/d0EqWiQigooKrCkopeIRs7OF8Y7mVuIPLSSmAk7GMkRpgLOChYBZ63rGKVVF1mtNWjCH7iiAHNAqI+GsB8r5fBCczIY5m/unYoA6/Itjwu7mfduwg40Vm14T44O8OR2kyWLzSvBMNEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588281; c=relaxed/simple;
	bh=YdhxqSQK6u09Yq+wcXxAOkCJ2NySw34/uEOXxH+/B+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iOPQd1r2U8VZ8SEbEyCosj5G+NbKOkFzH99FAjPsablIsbeS0iCoSyOjIUSJ2uh6G5EqtE5kjKWPNvOBOAhFISnH1zzsc3xabNhObcqZDKHFiAzddS/rWAuxW8xryBJQkv8nqC51HF/vusaWMDqnS2jni4jCU+McyKSpAQtuLRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Od1xWWrx; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so10268621a12.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 08:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740588278; x=1741193078; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0EZyn2TqObTe2UJw5yeyY3ZtpefcUDz56vkBzRoO/c=;
        b=Od1xWWrxe62uvOUWcmztsrxGTCS2AX2xm6rf2NtBx0guGzO7HfUHD60kEHhOiHcd5F
         vtauz3Agr7TRjqqAHWrTGdw+VbZeEG2OE33fwy8qyp4RS9h9JCd4wiZG1ejnzT4JZot6
         PjNetCHxY1iKJv9/XPZ+28pn8iLytEqytv2D/uDn7lK/bLEesojUAbx/LAg5/n/HWCdS
         KX+QVpALa/8W9zcO1AhI4s3bBCIE1kmY84h/QlTo28l75TXZDchUj9DkiYK2HIvVAXam
         kc+CT01SWHvyUn3njfNnKbjZWOguADuvr15QceT4VQQsiFEDW3/cRuzN0MmrhAo9063a
         ptOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740588278; x=1741193078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0EZyn2TqObTe2UJw5yeyY3ZtpefcUDz56vkBzRoO/c=;
        b=lFGIUvz3RngIzBe2WQtHjxM2ZgN2SGzTXPDyMGKI0OdNPGoak2wy8pJiQ7PrAMKVSm
         b9hm2pn/Pj5a4D4S4PDLFDppjcw7vnreBnuDAEMFOULcJmL65tLgnt1tSBfLM5SyZjFH
         l3GirRh0pfUPb7mt6Xum3J8ZeJaUre+93ZyUAasBTUbSJ2ndeD9B9TyUzX1EYilH6psf
         XZG1XWaL3a36YRNioY1SkPNix9U4dEZpf9JYXAJzG+tj8DZ6/L6jZGPZcCeIVsRWVDss
         hB8ONzuxkhYCQseEJayQ2k2EkXkC/NgTPJ3TFpYSztXgJmOQz0YkmcxOhuYqz18Txpuj
         5UeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl16yXJal5ku70O7Oa3pq+0mJ8tZ5UMVTP+bzp46SKGcX6PZpGEKj3DqKYQlOV+75JkqBSu4xjqg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+hdwGHVb9HWdjM6Z0uChYSq7HybRp/Y2Cq5rHppUTD+Dxo+4n
	DLXgBc3FaHkciax5gK3Eliy40L0CiOtQQEHqMYJHiUUPkoJmOdJ7W4Ool31tGQksGf47MEztIMO
	S3G8=
X-Gm-Gg: ASbGnctcrJJ/zSy6k2Fxf52/N2qpEHYPNHAGk8bxtOFLoFikkHwT+FV++btPJZwtKEJ
	8+MuMXujS1Tv8hGRh/RNgTlfG+xj0mMsXEFPgWiJSiakd4m1TJkjxUi9E60WjAn/trw3KQZNATx
	nc8iwAQ+FXnGTEWQCk5foqX4U7Y1HDY5nQX/D/uVf1jfTs40UYZyKDZ5Of5UGtXGL8CTowLVMYG
	Er2XviVudt3YEICEPZmZ7XEeDQiIUTWBokeh2FYOPJ4fFmJ46umnLYhjTUCrbbcwguBltnz5xUm
	PYkJN8ze80qRA2JQk1s8u6nfCLBHCubEzqpGPADpFyzW32fToGPWqNQ7Cw6zvB7f2Dct/cdZS3g
	kkKb8G4TXbg==
X-Google-Smtp-Source: AGHT+IH3s7ublc3lcebdSq3s/EcaHrrowWHk7bE8C5LSsDhgwFnc7kY/4pTIWqJdedCRg49Glwrm0A==
X-Received: by 2002:a05:6402:2683:b0:5e0:9ec6:12d1 with SMTP id 4fb4d7f45d1cf-5e4a0d88d99mr6275127a12.18.1740588278221;
        Wed, 26 Feb 2025 08:44:38 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e462032b00sm3058459a12.68.2025.02.26.08.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:44:37 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 26 Feb 2025 16:44:26 +0000
Subject: [PATCH v2 1/2] dt-bindings: reset: syscon-reboot: support reset
 modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-syscon-reboot-reset-mode-v2-1-f80886370bb7@linaro.org>
References: <20250226-syscon-reboot-reset-mode-v2-0-f80886370bb7@linaro.org>
In-Reply-To: <20250226-syscon-reboot-reset-mode-v2-0-f80886370bb7@linaro.org>
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
2.48.1.658.g4767266eb4-goog


