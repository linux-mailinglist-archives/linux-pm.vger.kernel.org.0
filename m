Return-Path: <linux-pm+bounces-40727-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB34D185E4
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 12:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A47430383F5
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 11:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7AA310636;
	Tue, 13 Jan 2026 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHjVzxwR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B139325702
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302079; cv=none; b=niCEmfj1vvRBL7QhLKYwUwCgvA+oBTK7gxOTW5nOqPMLZTKiJt9ox9DU0MJEn5qu28OSB7b0zxvH+/p+XfWvoXdIcR0lGcakOTZwHwYJnuYUWiJeEQz112HeCvIvQ9LuO2sn7pZhw98t9GyUkKs8hwE4lfnElnNJ5MwXUD8D17c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302079; c=relaxed/simple;
	bh=H/DtsJ2E/56brWT90bF0TB1znfavml5P75EoVlijniE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fizzI5j3fofQQsI3bkAkYnn0BVX1YSAbCySoSaNc0RyP/tfJ9uM1O3wFYcNyFDghod958r8UJqfWa7X0fXgqc22g4VN6JbHxHp7C9lIix+dExtg8jhhXhrApU0v24DNJQgAt4NmYE4I/wxmZKZiUJ5ct7GNENfCyH9k68mLqs7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHjVzxwR; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7cae2330765so4278024a34.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 03:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768302077; x=1768906877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XLlcSDrZxQliY6Jsns4WsjKtz/A9etiQH4EFHPP5z8=;
        b=bHjVzxwRaisqgtoxXqnbUU1KaQ5gHwu2SZKdZ6/5dGQeM6TK7HTnmZgKklufWbvP1Q
         PIsJGTuVT+1YTYYCrTKJvz3c7K4mOJfz89Hkr82opKTKkEcBQVEqz1HdPp6V2DI8iqD2
         TJvaU2/rEC2fx7JLsufXeQ+pzIFeSgMBQ5ZkwryCe9p0J0KRR4oAvtlwug1mv+PS4ebZ
         4ZM5Cl8aeoHJGIPwr+Rjq7Mi5lG+2kzmR6pWGxtJc6zOmkdVTF91IsdKTKPKfFGZ6DAn
         GPmIBCgSgTL3H2DX5/t2c4mPsMaPy8lemUWZ3M98xK8LKdSGbG4gM52nnm3ESGcSmuj7
         c6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768302077; x=1768906877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4XLlcSDrZxQliY6Jsns4WsjKtz/A9etiQH4EFHPP5z8=;
        b=lG6PnSn7/TWkgKNPw6MUzS4bV4hZXJEzeXPDJ0a5gBWoT+KtNkUSgu/kcPhWnbLGUq
         hEEcoEKILQDmfEE42/aAKa3TdeeM/CfKy8GcJX6yoDu/O9DanTbaF/Mvbu1M/LSgwKUc
         slzH1RkitNPQzH+54gfq0UjDKQh2CaGNeDvqYfpfauNDdn0j3zp3Ert82zbsTUs2uks5
         4xaOh+fI1EjnUmb0EQNA6IYHRV6Ffnvr9d19KFSItXugxXVnCxLdPkErIgqqAxP3Fq4j
         VO8Kzj8BCZEuw++hVjCQw4f+1Rb4gbSGMqA156zMvP7OBNph+d7mb4AWCvmSngezSPcT
         lwwg==
X-Forwarded-Encrypted: i=1; AJvYcCWY1yGg2ygUGn1HiOTlD80L8pGTZmkfCYct6wln5EoaUwBjL0wCpvbw7jPYRImkrZ/qfVPeUfKXaA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9DzazFVfu3At4QqyCjV82fAYT5BGFeYq/XSMoF4JEoZ3EuVjD
	mCHA3aUrhhP3hvifLCl1SvhRdHs4tlKDvXBA9KByM2bWhNW508ljDnhojXBugw==
X-Gm-Gg: AY/fxX7vc9I/5ff9BmBeqEEGGF3WcGseiq5QsNsthEpEu6DdmdfcszlLvjFl/5icDx4
	YcKBNZVR4clzYNQYRnijTlausSk2RlSwH1EItOB16DZ/V+6IhiC+U4onvWIpghWv161ZeLXiFgA
	WbY99PL65g0xCNaMFFI4OlHkCs4rkNtOmqCjCQSLbydR8BxMis33AHEtDBUB/TXv2aOOsoGIynL
	evIHObxjRM8WCzBzVMmX/BFt/qekhbn4lY2MdRK77CQuGMTFGeN2enFCuMD09IzT5lRfhYxJZ6p
	sUh+oeyvzIz/vw/d21Z3BS3TqZUEQNV1TxkBAigsznTyEbTYW56SKSO0vwPhAsY+VXx2F7n20im
	1RuBy3iLK2HapEj9+INyViPiciRoUCbpWyewqkxQZkWtr7+SMUWdCg2R+O6UqWyCOYG5TqpRt3h
	vSZ585RsFCrohBhK9gdYXhnkzFFLEtLI/wroDGOGcAWiZ+51J/KHHnHUfh+1bmkTDJaMChtNYzU
	R84IkbjESe8m+LnAoYOGw==
X-Google-Smtp-Source: AGHT+IHoetKCTy/pEDc32+prvwD2Q1RnoCrCBHHEv/M6mDpq1Oqnx5ryJch1QdsdD39c7PlRb7aCxQ==
X-Received: by 2002:a05:6a21:c154:10b0:38b:dd94:936a with SMTP id adf61e73a8af0-38bdd949736mr1217364637.24.1768296389614;
        Tue, 13 Jan 2026 01:26:29 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8b0f67sm19483200a91.15.2026.01.13.01.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:26:29 -0800 (PST)
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
Subject: [PATCH v4 2/6] dt-bindings: misc: google,android-pipe: Convert to DT schema
Date: Tue, 13 Jan 2026 09:25:58 +0000
Message-ID: <20260113092602.3197681-3-visitorckw@gmail.com>
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

Convert the Android Goldfish QEMU Pipe binding to DT schema format.
Move the file to the misc directory as it represents a miscellaneous
communication device.
Update the example node name to 'pipe' to comply with generic node
naming standards and fix the mismatch between unit address and reg
property in the original example.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v4:
- Use decimal format for interrupts in the example.

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
index 000000000000..9e8046fd358d
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
+        interrupts = <18>;
+    };
-- 
2.52.0.457.g6b5491de43-goog


