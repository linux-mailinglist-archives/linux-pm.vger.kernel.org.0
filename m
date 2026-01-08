Return-Path: <linux-pm+bounces-40439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2586D0214F
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 11:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05931304F145
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 10:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA043C26ED;
	Thu,  8 Jan 2026 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwjyoZJh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BFA3B52F7
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865248; cv=none; b=r26AcIQ9YH8o9qgsOp87JtJMAi08Z58rkk6KXKaRwmIogmiLhR0K+Da4sWgoNGDR+mpZJzy9A5ktdecEYIw4MHe++nVsLIkCJJE3VT4rbOOHDtPUzjC3h0Ovoh8CwXcyUGCdXb/kTYlSTFmyBzn9BX4bqbMJtX/JJNZbZOeQi2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865248; c=relaxed/simple;
	bh=1t0rpAxQeLHUoXH9EqV6OjuM5gq46cEpA0JagdgwR9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emVPw+NIjAHUfhAe49DYOiovIP56KhaHzmaEriloOflY/CYeLVyWg14RpdKLu8l2cD97R2bedE0ElpOpMyRHLI9nlnUYGp8MqisaLD2BEYYBqKFJ/SF8GdEzpEqzTYzs86pTOzpj0xVl8HGzVVisgziimoikBHRUzp0hEXFAZCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwjyoZJh; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4f1b212ba25so25151451cf.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 01:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767865236; x=1768470036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNDmxXp+I2DQQMGpjKHJPmnR6bZXLNX2CabD4SmBa4E=;
        b=EwjyoZJhm1UXYw0SxJeS6p6faLL3OgGfOKMDeNqPKJdcRveR10aA6rWnJmZlneDgNP
         E5A1XAyabkGFrKwAq9ZAR36LPntqTo+YS1595q/3cAAENuphVp8/cjgmc/K+BF1hnhEF
         nMASkTujkVPhhxm7I4RenKU0oS9e62Pbr1/DLrF9yyHVEzO6UXG7349gTC9PCEKDrBtY
         sY7yb7lNRbGuz6KlsvKAE93Codqce9mqo4qVSpeaFNAO9JrNjaUKcEOCp1wvfva7nBm0
         V6uEOut5TAFJk61rVWD40GUC1qUalx7/mhDEM9abHrOWr1Wv4ZIcyD5fCgZgm+Gv+UPW
         qJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767865236; x=1768470036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KNDmxXp+I2DQQMGpjKHJPmnR6bZXLNX2CabD4SmBa4E=;
        b=fUp+orKpbmVuvctwFrcPkiJEQ7xeMwxDGuDDgK1uf/hNIrhHFz35kZjf3x/Plwor6T
         j6GyMT5ObEtDsva+DE83BE5IOfgDXGQJfwYpEB3cW+ng3ngSJilX3Zn0M5Zu9dBVMLHd
         6XT6ItrxIQX/QEIqxKWHXbU86x6ijXQ/OBJ/j98sMyor5LOPMSdC3hC+WIYgJPJm6es3
         HhMpKyygu4qmTNslKIj5u9NsVrRZiGSARFZ1bOSTjBWK8IUJqXJ+3VKhk0kNmHwO+y/Q
         thf5lP/VTK0O6VZoyo9K1uWRQ3+8m4BZQeAECPZB4IfW5Gbs6rbpMkEyNXVYI6RnsJBo
         FpuA==
X-Forwarded-Encrypted: i=1; AJvYcCUJVTQUasLnl/ZWp0QfHZZ+ugLoNyZhxFFW1IS972zNhs8fKzVULwe68L/zZDgOyO6EEem6DCgXFg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7fvltKJMUEpW6L58v8Tpl1f30gQOnyOGVNlmz9LuVWjiEEHQd
	vmDf6TMidimujhFVQWG0jeMG6ygDCrrDceXl/stkotF7W9VCPlLWFI8XxkVmdw==
X-Gm-Gg: AY/fxX6Mrwd5fHtcF4kbCqhGirvi6XnqvA3SpIVamL+5nQS3dbmEWFyimJwM1X9PUHI
	A/A+mZwhPSnqqMkstfBQrs141qmdKrn0jygs2YrDIrg6fIagm2i1JHH6DKwvFzZ1soFtnrcuLRh
	O1RbcsZToswb6vhqRoERNQTes9HaoXqQCM9gV5jafdubl8bioFtGseJAeqsI3VRT3cQ4A3XNU4i
	WwfhxRrHmzpK+h/GrszyPZjovqSWG2lPfWPSaMHVIZ8wYkuNlWOMS8fgq1rjjkMjI/OmmiBh+4z
	E/80X3GVDmzXnDGfDqaVV2CWRDZoi3YaZkdEEb7ovfxw5ClY9Y8hnOIp+MUUd3Vq24cyEoT2nGy
	OKEfDtE4lyclhA6MiV7HUFkxdIpymy2bkCiXHNh3VXdO2Y3kX2H3Wf49t9DPJoYVHCU1y1/ypuD
	cniice3ZPrCB1qF09DA91stSebDqj4CllZnWuD9J3nUlKAjROkEJe+xF0AEwQguXavWvn8zQs77
	NM3izGl6pPs26FlwpMGFUCgqLIqSnsI
X-Google-Smtp-Source: AGHT+IEtkI6q/xm4mTDrq1zwIoRGWeEmLimQWTPdv0cxMzV+X4wwZ1AH39dUZF1XLibUlHDhrrF/7Q==
X-Received: by 2002:a17:90b:1d01:b0:34c:a35d:de1b with SMTP id 98e67ed59e1d1-34f68c48346mr5296424a91.37.1767859752118;
        Thu, 08 Jan 2026 00:09:12 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bafe991dsm6900582b3a.16.2026.01.08.00.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:09:11 -0800 (PST)
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
Subject: [PATCH v2 1/6] dt-bindings: serial: google,goldfish-tty: Convert to DT schema
Date: Thu,  8 Jan 2026 08:08:31 +0000
Message-ID: <20260108080836.3777829-2-visitorckw@gmail.com>
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

Convert the Google Goldfish TTY binding to DT schema format.
Move the file to the serial directory to match the subsystem.
Update the example node name to 'serial' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v2:
- Add reference to serial.yaml schema.
- Change additionalProperties to unevaluatedProperties: false.

 .../devicetree/bindings/goldfish/tty.txt      | 17 --------
 .../bindings/serial/google,goldfish-tty.yaml  | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/goldfish/tty.txt
 create mode 100644 Documentation/devicetree/bindings/serial/google,goldfish-tty.yaml

diff --git a/Documentation/devicetree/bindings/goldfish/tty.txt b/Documentation/devicetree/bindings/goldfish/tty.txt
deleted file mode 100644
index 82648278da77..000000000000
--- a/Documentation/devicetree/bindings/goldfish/tty.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Android Goldfish TTY
-
-Android goldfish tty device generated by android emulator.
-
-Required properties:
-
-- compatible : should contain "google,goldfish-tty" to match emulator
-- reg        : <registers mapping>
-- interrupts : <interrupt mapping>
-
-Example:
-
-	goldfish_tty@1f004000 {
-		compatible = "google,goldfish-tty";
-		reg = <0x1f004000 0x1000>;
-		interrupts = <0xc>;
-	};
diff --git a/Documentation/devicetree/bindings/serial/google,goldfish-tty.yaml b/Documentation/devicetree/bindings/serial/google,goldfish-tty.yaml
new file mode 100644
index 000000000000..0b702c8657c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/google,goldfish-tty.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/google,goldfish-tty.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Goldfish TTY
+
+maintainers:
+  - Kuan-Wei Chiu <visitorckw@gmail.com>
+
+allOf:
+  - $ref: /schemas/serial/serial.yaml#
+
+description:
+  Android goldfish TTY device generated by Android emulator.
+
+properties:
+  compatible:
+    const: google,goldfish-tty
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
+    serial@1f004000 {
+        compatible = "google,goldfish-tty";
+        reg = <0x1f004000 0x1000>;
+        interrupts = <0xc>;
+    };
-- 
2.52.0.457.g6b5491de43-goog


