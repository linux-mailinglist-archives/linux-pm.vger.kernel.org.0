Return-Path: <linux-pm+bounces-40443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD893D0238F
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 11:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52E4D304862B
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 10:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDCB39B4B5;
	Thu,  8 Jan 2026 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XS/VROUx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78064389E08
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767866721; cv=none; b=dBZceAhmXv53DoGV+10GO6lUNPWC42zjnn1btTWL+CjelZuKk1waggyNZo0kOaXbwOqugQKPIh0bZzWqfiE/3bD28gw4V+iVY2ykjVfDYfppbgv5FpwHmQbcXB5NGnzB9uKkdExqARkHhAwkoy8AAmh88/3RIcDeSD+/5yFp96I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767866721; c=relaxed/simple;
	bh=3n90BbXpZmo7/97SyvwdOM2dgbMwLekUvvzKLPzma1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0Zmc6kQfMrLZDPNcJvb+AvRbDkNF4Yws6Lzdiyv5UlQLctKpIaHlvNF5mCgLbnhqmIUiYaCNt4Qezj1kXKpSav5J8MVTc4TTOfqU1gHIg/zAnvVCcveKL7gZFjzHJsthonL24kNrxFxiSvIY9NHgftzO7AVHeVCPtl+W0GFxwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XS/VROUx; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8907f0b447aso28733726d6.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 02:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767866716; x=1768471516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jVrer7foxeDXiFbFRi4WTYBqb7mxG96n3TZ489PhHs=;
        b=XS/VROUxZElZJ3ebN6qf+Ntycs7/AiuXAN0hakuTh1gL73B75IuAkiH52q0aVwJthA
         REKnazeQf+tf8Qw3omUeJXvkofC4UTmipDawgz5xLekswd1bnPi7h9f4ZaPRhZ/NeCrj
         7diDowkkOitHTKRZXkdBJE/hy7r+N7f4EXzSFha/VsSi4AcXx7P+77S/gjz12ieBQzjr
         bY76YAkpuH8Zkf0Z/UVutwONBiwY796xK20gAmslPc1KuuQr8mkW5E4DZNbm0jPU+mkR
         FCiLDaa16ygAFXFrGEY1HfxlhGLYAYdwkqHRyqxeNqlJ3Fo2GoPzVxhMu4gDeE7FRMND
         +DjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767866716; x=1768471516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3jVrer7foxeDXiFbFRi4WTYBqb7mxG96n3TZ489PhHs=;
        b=J0o1rgj1RLBzq/nQEHBapdJZY5iVaH7N4o5nb0N97uha6Stecyvk5uVNVMyOGN1N8G
         448OARsv+DtjNFE9tuZ4IsVYW4SwgvGbsoNoKlkbrOdmSUm0XkVVOntgYT6fQuXEoo7t
         LemMSSggKf7ImDvtH26/Uy8cRqBkF78Y5sP7Tm4ftWuGX0lo2h9OcMwQZg0FvZQSjSW2
         3KBrbsd841F0ntQ9vL8/aBNI9UN6UjotVn6sxBMQrGYmgwqeFXknPeg6P6rlNOLGOE8J
         Cy0Y85Aq8MMKCKzHiBh7PCywv7xO2+6IJcMfkF+/7deADxjyyZjGzg3vZkqZDi4EF8Z5
         L2mA==
X-Forwarded-Encrypted: i=1; AJvYcCXHKp/yTxKJnNn9vWrOvMDGH0C6DcAyslcrvSEZLqo6f8HlYqkeWXdYQgWxe1i4AnXrLWLfAX1f7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzTyRR7EEVmnxpc4UrxFMwAWKWtRGONNkjq8TygLGpsNMLPxP1
	+akVrmUzp0rGYNPNKpS/B9hD0o0GdaNaA6CMtfLmTwksrjrDt5SVd/jK
X-Gm-Gg: AY/fxX4QD1E5KGde9EJYOj/X8SOTxZZdWG/OUZPC0kkWcxHuDriSmKSzgp3JClA6kYM
	dEZSbZY2bWBfZGxx/O7aAlYanvqUwW3ELdOT3IKvOT5vUfCe9b4sPwYM6S4axRA+Q+KcA0VXEAQ
	oAIZThbRs8h0zqZ3yVmBC0LclbjAYgHpUf0VJXs6sj/nBoqikzn1/aC6a/1vzLMQvya04E5Fm12
	hrosq5j3qcLe+NOTqLF1yu4MBunbczhfaHjavhs/aCY2HHPNEydznG4TPKMhUDaMwv/PCct1unW
	eaP9ZXnmpon1XuTv4GACpJpKr6T039ABFuRvHH3vexBznjM1kpZd8f+YAPxkjajXCrRiKM35k5O
	htUV3PmeDXAG0kLcikutarsOPhokE45UG0vxk4qnt5yPPn2i3fgZRej6KHrdkFl6LFHDMOQB0b5
	BhHnjcTJozLp+iE/k0RnnnctVPMfd3+gmG4CUP6QJ9c+fs4I/UA8xYjyHTlwgkqM5M6yb+NSq7N
	rQeEm2gk/ADnoDxbBuLLQ==
X-Google-Smtp-Source: AGHT+IHrWmrWZovQhYEcCj3OW2qe/OMr35yE9xC18wSEU8hxPlfPFqonbAeAYlH/zyT0y2ccrqO9lw==
X-Received: by 2002:a05:6a00:9085:b0:7e8:4471:8de with SMTP id d2e1a72fcca58-81b7fbc91b7mr5136728b3a.63.1767859762235;
        Thu, 08 Jan 2026 00:09:22 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bafe991dsm6900582b3a.16.2026.01.08.00.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:09:21 -0800 (PST)
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
	krzysztof.kozlowski@oss.qualcomm.com,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 3/6] dt-bindings: input: google,goldfish-events-keypad: Convert to DT schema
Date: Thu,  8 Jan 2026 08:08:33 +0000
Message-ID: <20260108080836.3777829-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260108080836.3777829-1-visitorckw@gmail.com>
References: <20260108080836.3777829-1-visitorckw@gmail.com>
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
Changes in v2:
- Add reference to input.yaml schema.
- Change additionalProperties to unevaluatedProperties: false.

 .../devicetree/bindings/goldfish/events.txt   | 17 --------
 .../input/google,goldfish-events-keypad.yaml  | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 17 deletions(-)
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
index 000000000000..4d359c9be600
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/google,goldfish-events-keypad.yaml
@@ -0,0 +1,41 @@
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
+allOf:
+  - $ref: input.yaml#
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
+unevaluatedProperties: false
+
+examples:
+  - |
+    keypad@9040000 {
+        compatible = "google,goldfish-events-keypad";
+        reg = <0x9040000 0x1000>;
+        interrupts = <0x5>;
+    };
-- 
2.52.0.457.g6b5491de43-goog


