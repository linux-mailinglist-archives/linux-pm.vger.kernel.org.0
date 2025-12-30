Return-Path: <linux-pm+bounces-40058-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF17CEA920
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 20:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D6FC300E47A
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 19:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBE531D75E;
	Tue, 30 Dec 2025 19:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYF3DcE+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C31F4CA9
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 19:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767124771; cv=none; b=K2PWO0x3qTFMKjN0Uvd7pofA47b9/WoABcdcibuCWIc/kjqP/3SbitM7jc9mqyZfgpYSbyOYart7+8ajA6rPZQoEql7KVb7Ex/LbwxO2ipLdtGwqfvSBsJ9mzYesMcMMyoxwlOJY36SCyMynw9wFbd5HgWzRsQA8IsbOtTZapgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767124771; c=relaxed/simple;
	bh=dBZA5ta8Wg18huaW0x593dUQGODH+A9HatruQgqiYAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQqhLiU+yESilgJvLuVNXHPPxOaK5rDfb/C1DWbr5CV0sDYOlY5fvmSs4ih9jato640q5DCd0i1Du5VeNQKxe6rRJtfMwSoG+DqCPLAwGw2OZ1ODM/+zFN1IblIw5Gmk3RSGQCAPZU3EQVLRQMAWtYKo95M+gyv4m+RxeiPoAf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYF3DcE+; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ed861eb98cso121082191cf.3
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 11:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767124768; x=1767729568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cweyuKIwKmSRdsl/r/hQ+dHMBlDfUCmP+2wWQS89QfI=;
        b=eYF3DcE+IHqkyjcB0PPYlcu/2tGzMKERQZIlaZhjMnD0cs65m29VpCBs+hTHBA8p7i
         aTNLe8O6Qh9Ca16DAMfl0rKiRQZvXOfaM3KW7oOaZnE5OWtRzC0HYeFYoeAo6WBbPvkJ
         Kfs1CZSwEeW6/cj13MdpSlM/gS3YYAJgVsCEm0UMx645wmI9e0UlCyfIXm5XvJ3a8sZO
         O1dqbcMk0yJy6NxHbiT8vb7rhs++ljLyhxXhCsZj/kjaPBpglLBpvVHI5boL1dp69fC1
         IaB7r8M5JYA6gkq2LEfOVVEGzPTpkZYgnLc0yCQgB2AD6vJe5uytLYOfSNke3UScEnjF
         TznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767124768; x=1767729568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cweyuKIwKmSRdsl/r/hQ+dHMBlDfUCmP+2wWQS89QfI=;
        b=APJdahdg9h5OMIcTFnTe4GvFxbMO8HWWAGh71BdqYogwzDR5YVxIuRML8aOOo5tx6l
         VNQhgh6jForhQ5RlPKoAiCzqoCKssURI7JyAa3XHDkoLSLStoOU3BseQuLPIEn+W5gVQ
         6GEEJw+AyU8olSOxRBgD3QM4pLPCaXMby3Hck8o4k3LwDheVZ4oLxB/xTNBKez9m8OvY
         17I9O2xlLK4at2kBdZ2Knr9afI9zdubfaPk5A/qWTT5iMfWIaJnQhV4tUG8Kcs0c/Z5O
         txlDUzXxgG4TQr+f0RSDTP8VnPftTDdPXnfsFoNcDuAOQTH+MXwi2gwWMks61DzxLT8L
         fcUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvMdqll71hIhwwh+Aayf9sr/Z5vj3cn/ZptCS1sE023woav2vEmoofw7BW4BhXiguDB75jmV0nZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKFImc777bU7uLe8Nsldlq4pcCwgpeZz1d9xeNUxok5oUUzBdI
	9mpNSX4GRD8w6bYnzLL1DVjfhE9M5quMPkLLitKXx/R2rZro9H2OMoDCTo3XCw==
X-Gm-Gg: AY/fxX6BNP8uWTkxRBHgmgxtkIdahRRGtpdt4AoKXkx0uMOJftUwcgFbqbon/Mb3xG0
	kxITADlmEykdGPaaituIbAeex1eeLrxWxxa3c9y+Z3s6VrAOcyj4j6mT3RU8xdsbS4nQCNKnJFq
	gRb8VVe1eAwvzZo3dNWk1MPxsXDa+JpLuoQENnt/0RMWiyaC0SoggDaI+rPchJo0k57vEXACrwd
	iQMDdCWhkmGWCzf0YwvVucX1EtJN1bCY/DE+X4MMEDF1yZUY0VwzImp8zRLGppQjENIMyWAlkyg
	LxsKqfMPbhtvlSG0xpuV2KIN0a+os0YJklerusqSDjp74fKWbuC7bo7r+L9ZsCjL1gyhzewFYns
	lZYNLfdTud4G/KSm/wdS9H0xab2ucyH1nAYwwjCaw7Pw4RUEosjiIKu0qm5ZX060ARaDLCRNBmD
	SaoADp9yd5XvnQYfz9Jqbbx2LZi0gXW5JUnpr2eQ6HGXhXyZlgf+RN6BIfNzQWMaQnjiGaV71jH
	G+/SpjlT/GevzwCu929kkYhOIjQ12pO
X-Google-Smtp-Source: AGHT+IEV2tPzXOwPHApBAgjAbkeJhyeb+ZtfRECHHa+IQaEP0X/+BdIgcNvcf3mgMft3lyGdkE/kaA==
X-Received: by 2002:a17:90b:2584:b0:32e:7c34:70cf with SMTP id 98e67ed59e1d1-34e9220204dmr25951440a91.36.1767118265942;
        Tue, 30 Dec 2025 10:11:05 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7bc69728sm29598278a12.19.2025.12.30.10.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 10:11:05 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmitry.torokhov@gmail.com,
	sre@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 3/6] dt-bindings: input: google,goldfish-events-keypad: Convert to DT schema
Date: Tue, 30 Dec 2025 18:10:28 +0000
Message-ID: <20251230181031.3191565-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
In-Reply-To: <20251230181031.3191565-1-visitorckw@gmail.com>
References: <20251230181031.3191565-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Android Goldfish Events Keypad binding to DT schema format.
Move the file to the input directory to match the subsystem.
Update the example node name to 'keypad' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 .../devicetree/bindings/goldfish/events.txt   | 17 ---------
 .../input/google,goldfish-events-keypad.yaml  | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/goldfish/events.txt
 create mode 100644 Documentation/devicetree/bindings/input/google,goldfish-events-keypad.yaml

diff --git a/Documentation/devicetree/bindings/goldfish/events.txt b/Documentation/devicetree/bindings/goldfish/events.txt
deleted file mode 100644
index 5babf46317a4..000000000000
--- a/Documentation/devicetree/bindings/goldfish/events.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Android Goldfish Events Keypad
-
-Android goldfish events keypad device generated by android emulator.
-
-Required properties:
-
-- compatible : should contain "google,goldfish-events-keypad" to match emulator
-- reg        : <registers mapping>
-- interrupts : <interrupt mapping>
-
-Example:
-
-	goldfish-events@9040000 {
-		compatible = "google,goldfish-events-keypad";
-		reg = <0x9040000 0x1000>;
-		interrupts = <0x5>;
-	};
diff --git a/Documentation/devicetree/bindings/input/google,goldfish-events-keypad.yaml b/Documentation/devicetree/bindings/input/google,goldfish-events-keypad.yaml
new file mode 100644
index 000000000000..348cf18d3d24
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/google,goldfish-events-keypad.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/google,goldfish-events-keypad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Android Goldfish Events Keypad
+
+maintainers:
+  - Kuan-Wei Chiu <visitorckw@gmail.com>
+
+description:
+  Android goldfish events keypad device generated by android emulator.
+
+properties:
+  compatible:
+    const: google,goldfish-events-keypad
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    keypad@9040000 {
+        compatible = "google,goldfish-events-keypad";
+        reg = <0x9040000 0x1000>;
+        interrupts = <0x5>;
+    };
-- 
2.52.0.358.g0dd7633a29-goog


