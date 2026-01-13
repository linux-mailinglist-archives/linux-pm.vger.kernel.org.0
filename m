Return-Path: <linux-pm+bounces-40728-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8910D1868D
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 12:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 781CE30119B8
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 11:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AEF350A1E;
	Tue, 13 Jan 2026 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+TArND6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2AF320CD1
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768303034; cv=none; b=fpP6ZgUhqDydLOzLCzTMnWBwjMdEdLCO60QbqtVvM9mHbWm7e1ljCYdmfWtlzG9fYVBL87ZmuH+alzFkU5kYgTD5pu91QGJ084X0EVXVVXUbGbgC+Kai8+qo+4fmTWjP4Whl8MySo8+wkeLnkX8QF71TDayO49w6liPKIsJi954=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768303034; c=relaxed/simple;
	bh=6pLYfVuIQXu+6i9yGbsc8JllWJct6Sa1co6E2UbDaRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLfwiAk6kp739e+44r4uFuz5kM3gLbAHi6GMA1RFuQXmL2Xv8o7suz64Yw7U8TzfICCAKz04RtRrhca2RLxBN5HhaOLNCEF74RLC864dUkYUTmorymnyu4y2r/l9qC85d+Y2aO5fzVRIx98aG2IwfAJlUNbWTA6Apqinz8J9k5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+TArND6; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed82ee9e57so97910341cf.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 03:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768303032; x=1768907832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyUyxp8wAgf/XnChDYwKqc2QzM4UH8wRrO9JxGpfnDE=;
        b=C+TArND6GjoEECk9GpdRDapWJpagjY84rf04YjMd9S5dRGmZvMXGCKKAXyhBrvqOcL
         j1GDhVy+/PHg4n2uS7Exd7g/eIwoL5M6oDU3l0dZWZBJjr+jZcirOtE1DueEpBiverDp
         tQ2KShC+SzedJv8JD/ZZNTCIY2U5QIdgYg8Pjb/4vVWRV8CzgKfSpNxtsmSyoGxeBWi8
         XFwBcf9Ff31VSfK2TARHdJOVQ7VcTnBZc/M83TBVafWcUg9uwZasu4ZTJiUKsA8S0kX6
         8i6aukV3MIPvAMN43Uxj2Pb13OPwa/Y0uZpLLSMzMxKWSTflGFOGg3wlXE+AeRdi9nHC
         b21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768303032; x=1768907832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zyUyxp8wAgf/XnChDYwKqc2QzM4UH8wRrO9JxGpfnDE=;
        b=w4hccXWqNnurbo/oiXS0i7opChFR66EA3Cb3RyMS603gAsE6JVdqv+29iJVUEP1n2z
         XNgxqf2olEyOtf3myszZx67q+UOvOSxm9Mr4MsGmgn1iP3bsKTMYLwZeSQDs3XoiazRE
         NcergNcIjRnrRb6Ih0QxKztCN46mtM9TGrce6bndzwXo0LzFi56Js6RI4s+ZGzHuYTg6
         oW9tygFpFFtfPMGI4ihmuV/tn3kWetE36zVAJJhj04IZYObgvwCXXJheEDTy/FEcHtj1
         +BHbE81G3WbaGrp0PcZF0KLB7j0+STJLHwd32d9jde4LsCx1J86+RangF9QPR/AQjMt+
         QCdg==
X-Forwarded-Encrypted: i=1; AJvYcCV/kn8NwIn2IStZ3+hqF8odejKRDXe8i8yWPKA9gdjKwCVi+j2g7h+Gb4q94L2wN0ZqtecU9RcgJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzneuTF5YxPXJXV+3o1xPjVxEbFQWB4FgTbliAarbImw9OFxlai
	WyJluLqM8KLIpE1aRxGlpPfVheOfiiEy3oIGfBe+He3GpnKufbRTVdEWTxYdJg==
X-Gm-Gg: AY/fxX4AVMWkG2zQlH3RB4/NLTL0bpU6F/3BDC9yBV+4iO70y62fX1HE1FWyFaNjdwB
	COnoGvMRpc3kO/mL/oION7SRLs9goZ2kXiOluMufKfvpKajgmq1JrE7v8QULJ6jo+41FqEW+U9t
	Pof2kF8/TNgVm9u0V1ZLWMw3VSVueaLgLzkX4RF5xRDX+VN1603cLxXAPXF+njM3c7W7nzrL4ds
	ajsfQ9jt08zkQ1ZJvD/SgoJaX+FkIPNt0B+LA6DEd/JMNV0KoAJuqg1wkAaXh2VVhzpLhyD/ukY
	mC95Q3XTOMAnBaPVexd5Sl6mJP5x7JfLSDRGkOkgjZWBbjetTIMM7/kSEnGqPsE2yp6fegM2NGt
	yvJmYxgffgxptWE8g0m/fOdhH4EOJwZh6zg9b/AVGARbE6gAqDiZp36wKB1pI8jSMS+2evtUt+9
	2pNkr1iat2qBPi8EVgnPSr3aGZDqcKo1gykjCpWmXJqocA5ZalDQKhibX0g0PiysiWMYUT7JAmi
	bDkp7tSvc0PWTIcW2Buyw==
X-Google-Smtp-Source: AGHT+IEQYBKDIx5Gyb5nb9QDIlP5wjHoYpr1ATatTX3/LBRfDVJ6GHb1+HOoMcW7bBTYInLSSSdvlw==
X-Received: by 2002:a17:90b:1c07:b0:32e:1b1c:f8b8 with SMTP id 98e67ed59e1d1-34f68cdda94mr20382740a91.26.1768296395660;
        Tue, 13 Jan 2026 01:26:35 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8b0f67sm19483200a91.15.2026.01.13.01.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:26:35 -0800 (PST)
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
Subject: [PATCH v4 3/6] dt-bindings: input: google,goldfish-events-keypad: Convert to DT schema
Date: Tue, 13 Jan 2026 09:25:59 +0000
Message-ID: <20260113092602.3197681-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260113092602.3197681-1-visitorckw@gmail.com>
References: <20260113092602.3197681-1-visitorckw@gmail.com>
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
index 000000000000..4e3a010a70c5
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
+        interrupts = <5>;
+    };
-- 
2.52.0.457.g6b5491de43-goog


