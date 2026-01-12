Return-Path: <linux-pm+bounces-40694-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 934AFD154C2
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 21:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0871A30081A5
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 20:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335143563F6;
	Mon, 12 Jan 2026 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/VP6/Vp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5633559CB
	for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 20:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768250440; cv=none; b=KrRhgVs8zJnKXf8Vuq8tkqM3UW0OKRZMyIbgaAQsIQjMNkvHLWAPYhU6Duz/yZP5fzaWkZrNiq+OYnKcdZ1LayhwQhrBLKxwEyaJM+RIsVpmDGAVeXyKptosPS22VNAL+sxYN34ItGg12Wsq3sRtaFjDwS9OuE5ukFXeLW44FOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768250440; c=relaxed/simple;
	bh=ymB4O87Tj8cdyAQ2Mbv88kf7il5FRPCeihIKxEZnuSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edgz3t7BKNjoVT4o4GTGTFvUjgz68dZ2JtKZxfGg474e8CMcQLgOJqSCSVa6yNpP6pTArtu9q4pGP/WmaWOVcg1b96GT8CiYti3BBKZfoKpdXR4oJgQVKi/MSzrc4H3HPeZbDztgiVkC1WjXx9ACegchOKUEv4tBhhIK0jlXUDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/VP6/Vp; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b2a4b6876fso1048282885a.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 12:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768250436; x=1768855236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IpW9E256hAdb5Kp0Yw/WkAtwWAPi3uXbVhccnFIi6E=;
        b=D/VP6/Vpwvvtynlc/nZDGMWxfBRV/Of4R4i3sTY3E5mUiT/bfovBPlM9gtZSAhVY1a
         7Hu3r+DaEr4OHAfBYZGQjFxK0fC4jTaQVjEES6SaGKBXaB/2WKtCwRPlf6YTA8ttIuwI
         hFsVyyPqBjDxmBa5I+d8KS25JvtxVIPypuD032VgRBQO0ZRnYE/jIMQ4hxpYF5fLfy2u
         dKzMfo033JnkfoL0f/xpZ4AJOKBIiwclZHX3goXSM1DiqOVKeXnlqOMuJ2Ar5zIWQTbL
         9nevx377JdTfk9WI6DmZqlsSMdJGKL5T8InmSw8cOq82u+cu2RqRyKpNcNPEVsJaQnht
         SV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768250436; x=1768855236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9IpW9E256hAdb5Kp0Yw/WkAtwWAPi3uXbVhccnFIi6E=;
        b=HY01Qotcp3w9v3wNvuncWI0mVf2pJRd0K6pc0CXPAOMVcJHmKWdj0saXuMYbk6lYRZ
         /yefFzzYj0V9aHJbJU0sT18TVIiKQQpOvbsiM+4E2DmW1HMmSj9BUSpZ9ztD5IRKlUuj
         myh6XiwCRKBCobx29D3vfhtzpWROjELHKv2dm8PZIqqSXbsu0LVYcUa7MB8eb8AM/l98
         0hhkk/1xRCl2tJrVoXVrPuu5Wyfj6L5TnwL4BngM5VDB3bt0s1lyOm/DBEhRdwMZmAml
         uVINzfE06D1YspUdUHBMocRFc5HterKlX0sPx90wcnUlBC0aCXNzv1f7HwOFIjTdfged
         OVOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaCw+OTOj2WwLE6Pb0c6KG1p8/oawIRlmXnxW6iMsnDJSHk5FlfF81YAHHfgueBCBjYJo3qRT/+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHNSelatOO4aDuxUqXfmNLP8w+fucZ3ChLQqylRe4VKOzXkdi/
	9Hlj0w465+yRCC3aPIJXkNaWtuO4XhPmH5EVSnH36DE+pT42MNMji1+F1FEHvw==
X-Gm-Gg: AY/fxX7SaHjXemxYBX6mt+qGr8jGeXlmzO0HtPVjxGMTOV7mbGh+h8Go5aQMkNtWL1i
	Yhks0b5pAP4V98C5NyYOozbnuTM04dp/fvgFZKBPetuUA5aOiNkSgM3rEc1h/ZtHuBActtHRsBr
	JKtXig27bCVja1CtEKr8hSRiLtOzyBPGbJ2iOZ2J1/GRBG6EdRmRFbKXj8WffzfwPSceQBaYkma
	i2ilmACTq0hQGBdwPMUwIOrKP04JjsRcSdmy95LB5AZYKg+Rc1Hc8snwe8QR58/13T5wCy7srGY
	38bqbkSP2TYl2lbIGf1cAfj3I6pt0QyePwyhsAFEg9r1o2R/Y3lx9rC0BOnonZ7gWd9SybIYHWj
	hY4G//MXzUtzW/aEFZvKJPTRqCyGHyFccseXoh8+VvTj8zYFgzzTP6iVzkFunDOIcVwLa4G/IQh
	Z6i4jWZasLWBDm3DtoX7eLR9S4sBFjFCSiqz3Rd/5sH/rC7FqzAq5IJ1GH1EQca8kGtKIkKCBSt
	4AKWwoKlMl0fvbe+UQXOg==
X-Google-Smtp-Source: AGHT+IE0iF957v0dhX+oh2JuRctvQjKaodi99ci7bX97j30HxAiXsxhGrr+rNQNYdsy9DMkXs0FDHQ==
X-Received: by 2002:a05:6a20:4322:b0:366:19fd:dbe4 with SMTP id adf61e73a8af0-3898f88eb3emr18090615637.4.1768243916723;
        Mon, 12 Jan 2026 10:51:56 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b16fsm18874197a12.31.2026.01.12.10.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:51:56 -0800 (PST)
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
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 2/6] dt-bindings: misc: google,android-pipe: Convert to DT schema
Date: Mon, 12 Jan 2026 18:50:40 +0000
Message-ID: <20260112185044.1865605-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260112185044.1865605-1-visitorckw@gmail.com>
References: <20260112185044.1865605-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Android Goldfish QEMU Pipe binding to DT schema format.
Move the file to the misc directory as it represents a miscellaneous
communication device.
Update the example node name to 'pipe' to comply with generic node
naming standards and fix the mismatch between unit address and reg
property in the original example.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v3:
- None.

 .../devicetree/bindings/goldfish/pipe.txt     | 17 ---------
 .../bindings/misc/google,android-pipe.yaml    | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/goldfish/pipe.txt
 create mode 100644 Documentation/devicetree/bindings/misc/google,android-pipe.yaml

diff --git a/Documentation/devicetree/bindings/goldfish/pipe.txt b/Documentation/devicetree/bindings/goldfish/pipe.txt
deleted file mode 100644
index 5637ce701788..000000000000
--- a/Documentation/devicetree/bindings/goldfish/pipe.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Android Goldfish QEMU Pipe
-
-Android pipe virtual device generated by android emulator.
-
-Required properties:
-
-- compatible : should contain "google,android-pipe" to match emulator
-- reg        : <registers mapping>
-- interrupts : <interrupt mapping>
-
-Example:
-
-	android_pipe@a010000 {
-		compatible = "google,android-pipe";
-		reg = <ff018000 0x2000>;
-		interrupts = <0x12>;
-	};
diff --git a/Documentation/devicetree/bindings/misc/google,android-pipe.yaml b/Documentation/devicetree/bindings/misc/google,android-pipe.yaml
new file mode 100644
index 000000000000..12b0cfc815e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/google,android-pipe.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/google,android-pipe.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Android Goldfish QEMU Pipe
+
+maintainers:
+  - Kuan-Wei Chiu <visitorckw@gmail.com>
+
+description:
+  Android QEMU pipe virtual device generated by Android emulator.
+
+properties:
+  compatible:
+    const: google,android-pipe
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
+    pipe@ff018000 {
+        compatible = "google,android-pipe";
+        reg = <0xff018000 0x2000>;
+        interrupts = <0x12>;
+    };
-- 
2.52.0.457.g6b5491de43-goog


