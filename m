Return-Path: <linux-pm+bounces-40687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC89D14D61
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 20:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3ABD13026F1B
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 19:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78F43112B0;
	Mon, 12 Jan 2026 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItS2q+t8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0863101B2
	for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244436; cv=none; b=TReZ+LphN/IFQ/388bAMjb8RSpx4wQo7hvZEOMfLw72gb7Z57MYs3GclEUG9CMPTNYXZKUiPkXPZhxEDkJ3KYtObxMm6gTasaez1Vc75K8M1jOSdnTFCpExzejrRO4znzrZDp7xYEwsrt4DWgwhHeHkljQBUiZ86iV2OMjS18Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244436; c=relaxed/simple;
	bh=R975+6cFhZbxfj7AcmB2qCDxz2fjGpYeQFlJNfAlsrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=num4RCWUEug4XlEiPwEr+G9CLm5hsAh9+ImRHyydREfi7ubRyBKmmI6ygmBFKZ5024mssBQhPquXtyqBuStR4KIKfTY1ThvB7SD7/sjeGR64TkmoiDFkB0QCF/WuO2yxKgXTH/63nqAnLSul/suZVHtD7xPhzfq05tQFU0uBVRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItS2q+t8; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3f5aaa0c8d7so5107782fac.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 11:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768244434; x=1768849234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcjtfYLr/hzQ7i+u9m84wCmIOhDfx7TiS5rWTLTDi7o=;
        b=ItS2q+t8N194VHKIsQdU75+50hXv6eD242HBROgHCgphqBPF6SO9cFHGYWSPtmS8FL
         VEphjSnRoIthT9lnwdyQ741wEmpb/6ZyZZ/Dl2fhyObwpyy62grKYbPs5XqLj2SU/CwM
         PHhXVemAFNTeVUntHysPGSDh58v3tI4EgLZ8DybaUP37nUYcGjRdo790SRwPGZgFC9P0
         cFKX8uZl7Sh05jriLTmcPx6Xl+FABqANYgYPHAZEaa8AJlYZDMyY3yW1Ki3JW7aXzupD
         1aLHrKwxP+ZNMOxvqf7UeNaWUA2zufUj2bVMKtuEZUdjbyIAiTVLdXQldIWxfwyAvgzD
         2cVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768244434; x=1768849234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zcjtfYLr/hzQ7i+u9m84wCmIOhDfx7TiS5rWTLTDi7o=;
        b=M64tE6CSuQkEHYVldoaEoCPr+DGUu0DFL1YkD71KijtNfzoJ4RxMjYakNLwrtwA7eQ
         3J0d1Lv1XjSEhgD2T8HdppVlXtfXe4v05/TAl78W5jQ41uUD9HyoGrowdTc1Fv243lwC
         s2fwW1NOnIliVSRIyCDJqf/GiVMp6mh83CJukcZWbobYRvM6Y3rG7FJOYFETLk3iA8IA
         QXZfN8VRwDQm+NASuK7LwOU2fS+AYcdUcWYuhmFnpiew3fJJ7PKS9Od8k9jPtG2bDlWM
         KzI4bjwonRMbMbDh78tlArliE2jYS1jxRvr5Gxf1jpJfatsvkvMUFIo4qWNCKOnQ8X7e
         kINw==
X-Forwarded-Encrypted: i=1; AJvYcCXv0f/n+bY6tyLquM0tUk0liKVWtAORrnoNS+IVZpJjmYaitAUCCYRDY6m/ruY7MboieCB6rTgxXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpFFtaoO7dwW4g5VwCaDE8PdQ2lNWU7dsbZCWOTQc5R4ztaAb7
	qUgPXMdyjXRQHNSNE0PZ7dfpcMcVYTtdQE7lAazvjQeESYY2gqaqi1G6t+V/bg==
X-Gm-Gg: AY/fxX5ukORDT+PKP7avwaXiZQihTGOafmtCJ/jdR/1kzF4zp01YzIoMLMo58x3E8L5
	1u7UqvT+t8ZU8dRDXy6wYajkW7zRElO8r+BUaP2GSLCOOo+FXkFrOLK8YAOjoIzv8cWBbdhfxaG
	jxBJcKggHjb6lwlEZraQ5qudzWIFrj5aAfImxxz+oXxLlhSuGBB6fCGgqcOjc10pRXXG2N+9Zlu
	MXsIn1otoaz24b70nJKZiTmw/TFu9iBfbNbkid5CtgP5WxEzrLZj73tCkCmtX86QL3cJ7IzWu1i
	bQGIyBCnfHdPFhJGRFfJxLLrqavhkFBhyaz0QGaUNEG8OixeTjsllKYNHwkUWprtR0BfMRBwL5J
	7TDj/IxWdlhYHCYDzggZ4/0GBhZgkWU4P+LaEpPA/gX8SEH6Nd6AKfmOFKvVyqIN31M8lqPRT4R
	O5DkF8pP515if7DYESUmsYGyUIRDpFHTltW196Nm0KB8A4AlTd4YhwlvwME4g1acXmvw1I09nC7
	wlyscFKgiqZ2N6xOkGU4A==
X-Google-Smtp-Source: AGHT+IEhhjkMRhLtfe06HmVUiVLdJt4MdPUnRHhK5mx9O/EoN/yul2X9MrifSFUaAnpKZe76DRHW3A==
X-Received: by 2002:a05:6a20:430f:b0:366:14ac:8c72 with SMTP id adf61e73a8af0-3898f9db825mr17301674637.72.1768243931042;
        Mon, 12 Jan 2026 10:52:11 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b16fsm18874197a12.31.2026.01.12.10.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:52:10 -0800 (PST)
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
Subject: [PATCH v3 5/6] dt-bindings: sound: google,goldfish-audio: Convert to DT schema
Date: Mon, 12 Jan 2026 18:50:43 +0000
Message-ID: <20260112185044.1865605-6-visitorckw@gmail.com>
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

Convert the Android Goldfish Audio binding to DT schema format.
Move the file to the sound directory to match the subsystem.
Update the example node name to 'sound' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v3:
- Use decimal format for interrupts in the example.

 .../devicetree/bindings/goldfish/audio.txt    | 17 ---------
 .../bindings/sound/google,goldfish-audio.yaml | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/goldfish/audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/google,goldfish-audio.yaml

diff --git a/Documentation/devicetree/bindings/goldfish/audio.txt b/Documentation/devicetree/bindings/goldfish/audio.txt
deleted file mode 100644
index d043fda433ba..000000000000
--- a/Documentation/devicetree/bindings/goldfish/audio.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Android Goldfish Audio
-
-Android goldfish audio device generated by android emulator.
-
-Required properties:
-
-- compatible : should contain "google,goldfish-audio" to match emulator
-- reg        : <registers mapping>
-- interrupts : <interrupt mapping>
-
-Example:
-
-	goldfish_audio@9030000 {
-		compatible = "google,goldfish-audio";
-		reg = <0x9030000 0x100>;
-		interrupts = <0x4>;
-	};
diff --git a/Documentation/devicetree/bindings/sound/google,goldfish-audio.yaml b/Documentation/devicetree/bindings/sound/google,goldfish-audio.yaml
new file mode 100644
index 000000000000..d395a5cbc945
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/google,goldfish-audio.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/google,goldfish-audio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Android Goldfish Audio
+
+maintainers:
+  - Kuan-Wei Chiu <visitorckw@gmail.com>
+
+description:
+  Android goldfish audio device generated by Android emulator.
+
+properties:
+  compatible:
+    const: google,goldfish-audio
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
+    sound@9030000 {
+        compatible = "google,goldfish-audio";
+        reg = <0x9030000 0x100>;
+        interrupts = <4>;
+    };
-- 
2.52.0.457.g6b5491de43-goog


