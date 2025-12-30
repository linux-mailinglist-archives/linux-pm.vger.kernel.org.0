Return-Path: <linux-pm+bounces-40055-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CCBCEA8CE
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 20:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A62443016700
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 19:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1A021ABAC;
	Tue, 30 Dec 2025 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO4wAEya"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43446EEBB
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767124093; cv=none; b=jyuQfVw5hWcOCJxQRX0DQi74iZdQiNvz3Aio3n852RIPXcOb2UKfsbRLnIQrMdcK00It6zVUf15VWUscgk7zd5nEh23VmZWHA0z1E9SChLFiAAcq37wYJJOFHYXEQhbmmAKv9fpg4Ux7+y1CceZV8KPpdcP2JLbxWmYdHvpvuAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767124093; c=relaxed/simple;
	bh=wuouABNtno/my3xxB41xPlJVygP/E24Aj/Ddg3O+3RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1GbNMyxiyHTgEmfHG6fVJ24KKki0o8g+Vh18MZM/z5Q14ppHHRRBO6GtyIjH3L6omOd6XTHDzJo5j8nNhX4B+gedf6CwWPlcV3aRF13/a9QEDGEdivWgZ5JvrmHIpW5Hd00jxxILwP0btjf6HgP6ptBX7slS4LqLg5EGbcjM+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kO4wAEya; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5deb0b2f685so7863513137.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 11:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767124091; x=1767728891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eY9DKWu7ggurjBP9bHM5tPTMCGUI+TAaWzZpacbdf+Y=;
        b=kO4wAEyam1SzsyorSF5EqIhv0nI432EI+/uj85w0tkhwyc9NqHRcjlqLvKgJgturwN
         lWvKQekWUIMxLZ6EzcVjYW3d+eS9pDS62wqD/h4qOFcPmxOSgek/SuvdI8/udHkFMVsE
         1R3p6LyclAmjwb9GMIvSPzyxwanDZkjmwMpcF5mEFLwN7NWEtWEgD0a4Yerzp1NDUrqU
         cs7U3HW4uJzegbhjynNqh0YG41KT29EznxIwo87mWOMtJsf42arB+Ay1Jyj8zBF8j9bP
         xp2VfOIAkgH12NqXquPOSJeoXF4ZZedtaHODbgBUmoA7zRCKx6lMRigB0X3kmj7zaEpQ
         MAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767124091; x=1767728891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eY9DKWu7ggurjBP9bHM5tPTMCGUI+TAaWzZpacbdf+Y=;
        b=gZZ+NheXCTMg30lDSx/4SDgvC36L36/2Qn1ABsRsGP0or83JJTkQoOtRTuo0Rbaeti
         h5mbNg3aewIVo/Quhfjo9OVZNJGUYXeATVA9DmSHvGho4cfMfHYGOGaEwHBOix0hPzrv
         23BbGEuOG/yhKKznB8YFSiHgp+SofzlLpE9y1hebK59Habd8pMk/RArqZCIbRKBhm5nB
         H3epxWUVTgTdRJ3W0zjml/5VTcIbhe7cjaDSEHLoltVGESeVp1bX77aMyJPltbh/c0S9
         pJUuQCrt25o8gFkSG60jcs+/kC28UF9L5F15tf9t1Ao0SS7T7fJV+H8OXS0yeCQgwXz+
         tlMA==
X-Forwarded-Encrypted: i=1; AJvYcCU891O93iGKHeZyxKwBl7uR8NXq0X9I3zJHwvMcLG5IP3gHOyFmkLkCs+iqkB4aSh8A+VOvs52vqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBKQ7z5/0EfUZ6L/sV/S1fpW4y5XJzkJa5mikLeBMhaHv6dJWR
	XS/t1xXg/j1AMf15MnmwfMOUc2oPWn0831/cTnmQNMFQzaMHUUVjFDpn/GlIuA==
X-Gm-Gg: AY/fxX6Pkil9+7pSoY+Sg2Gl5lehWZVaQYkdS6CKjhUWOudyW3e8K84tq2IBRBITMXu
	aVYkm93gcbdpMR6btbUEyIvZDz/AofktvmFC1kUhl4okYtZ11t8MKJNvXeRpzLg8inen2TPOdj4
	fxgn8UrrIhqv7A1x5QZWLAezjSYid8wD6690/tBlLUTEi2K5SE+IxZBma96VpmnRoaN5ysPTQe2
	sL+ITM7oSSxR5/2XftJqMFWJytK9vJuVPAKKG+/A78Kkv7/E4qTjO0zXnv3uAdd1gQhARpj77JJ
	R06ouehuKuaK13/jEzzjCp0OnGqFtrlAr9mjUNACTkxCjkhF+IHkyQYQVzOgLsJv3nok7Dr49XB
	w2jKWozeZp8sz1r77EbfQ8NOGrNcZs5GzXfWfk1PLATh5xNdG3zlBuPavWTIpaahLcn8zmsdi7M
	ujtTP6thIj34AX2poH/DOk1ZN9l0DyH3YDAqo8qX9w04L56WG7iXf1v7g1fNI9uhULF7YEFSQ+p
	ZTq1mBgWOpABtuowiJUQw==
X-Google-Smtp-Source: AGHT+IHNSjL6XO/9GG+VQ4LJ4CyetXEzcsFuGnG9Kdw0+OI361O47497s5aMUrTFKuua6BqPpBWyVQ==
X-Received: by 2002:a05:6a20:549d:b0:35f:84c7:4012 with SMTP id adf61e73a8af0-3769f92fca1mr31561858637.29.1767118275492;
        Tue, 30 Dec 2025 10:11:15 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7bc69728sm29598278a12.19.2025.12.30.10.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 10:11:15 -0800 (PST)
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
Subject: [PATCH 5/6] dt-bindings: sound: google,goldfish-audio: Convert to DT schema
Date: Tue, 30 Dec 2025 18:10:30 +0000
Message-ID: <20251230181031.3191565-6-visitorckw@gmail.com>
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

Convert the Android Goldfish Audio binding to DT schema format.
Move the file to the sound directory to match the subsystem.
Update the example node name to 'sound' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
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
index 000000000000..e0b26c1f7b8e
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
+        interrupts = <0x4>;
+    };
-- 
2.52.0.358.g0dd7633a29-goog


