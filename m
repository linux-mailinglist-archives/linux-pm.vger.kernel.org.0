Return-Path: <linux-pm+bounces-40444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D049D0234D
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 11:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5C133002D3C
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 10:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980F22F39A9;
	Thu,  8 Jan 2026 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCSFNWtP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D8623AB95
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767866826; cv=none; b=LBY7dAXydis5ux/bCInVNiE51v1UQe8+pY730CbzriNeNh6Vd32p3Qttt5qGwIFx88ExJ2FMjqoE8msWaB1iE9Gv4i7LBeNdCPJuIZrWRH3zyUDtuZ8Ktlj1y95/Zk1tX5EqFPChmmqsSQRB1JwnLqQrZEzlzY8qaKt0SHoVO/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767866826; c=relaxed/simple;
	bh=Hgv7QBj2VJ/Dph4tylg9AUwEbK+W2yWO3bKu+SnomLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfAZszJc5TSwmvD1GHpJ/eDSZjepgO249fCU8S0RFJBDZQZ/P6emHPU9uNTkUgA+5W7AfEXDYFEs/99XctRetuezJi4kha+uyFcUHatsQCaiaieA2mNBZoV+Ws3EfF9k7k5SJp89LwrHe8Drs+pkbFgWxaxLGF+qnKlyaohlkz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCSFNWtP; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-93f4f04d9f6so1044300241.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 02:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767866820; x=1768471620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0UMQNQize8y0H61kPqmNx/nuhGzGL/JdEumTcbx0Oc=;
        b=GCSFNWtP84bmS+Nkq6DZf6NsSXH+G45wLZIDQcqJYSBOxKJ4ahY7C6J4snkRnVUAE2
         ZGy/DlIHnDTwiTWT9ITmbhNuL91bSc864AGviecH/kyJo/GOe2kPCAoQWSc1s0lfgTjg
         DcMqzoHoXRlsiG7dTdQAQJquzgWAsyIQAsSFJgkRrppht8il05vCl4R7GPmkj1We24Qi
         m7s76GPPEUPb/ddAgTAUcQLseQrSH6oX+YMy0KECvvdMgcIIAgBjH/jPgB4+hWuwPSuI
         XllyWUxcz1AHr47OLoRA2itUhf0yVy1npfkiVZ6BdZsN0Jihvp+ZeJEY6C8IYTGvNeSU
         OvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767866820; x=1768471620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l0UMQNQize8y0H61kPqmNx/nuhGzGL/JdEumTcbx0Oc=;
        b=NI4/85yeCFBo3v0/QF+zUiKPLXt70pIsYXOmodj94KtGvJ3/4FARrn7ybqQ5HSac+k
         hDc4fEm1gjeS7VOKVr1Go7XLpd9KVAjXV4UUKxkwrRvW4HeE2VfvraFWtfCSAz27BtDc
         Px8bMEvEYGTUPjOfuralwz3pkyKwzUz77B/LPeka+5mOOlNBZSBFjWLQ4j7W7EUQSa/4
         Ug/JOK/xFp+m6h3nwFcrxtb++jva7+B6qlXEo53uNRH43k0hfl+dR4NZY4t9xK7kHkhf
         cMNZaqLUxKms6RyCXOhf3WMbxXqs6pP7sccAGwpF8GctR4JbKtWhYYqbXM/kZcIQLY6a
         gn4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWf/mcqOi+uyIsiKVFqfFcewS3eapoPHSBWy/FJWWs/b59wnAuPxDUm4Ln5Bk9QrnkLDEt8YidUIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxD8m2MmmIkR5yJ5fxX4bRlI/ntoaz6m9PjPVRQ8ySgvFOJfu9g
	7uNwGmXSLrJkTXrdZXq7BCIbc+m9rA+fFpAqng3Fv3cu9F5prdOaVSkc4w9/hw==
X-Gm-Gg: AY/fxX7lwQ4i1lLdV7vxRbOo6xCadJiN50Vvc/RHT1SMDEjR6EeKkI9W2RpJQuvF1GU
	ERWs30PAtypUwexu9vnFDUxhHHCmvwPjOzV7bVqlH8r++UtDd+yAkpJH8ymGBGBJygedcR4VA7x
	0DTU9RfXgwbAlLKh4iexoqdhvsDMvbclnhRSeWe8PSamD8DFkf5O2koiE4naNtr7IB1g29FAnKE
	G+OEBU9lJolcQ5qP4sYM2/XKtdKfInNoi7+GVZDR4gXf6ggzG6PlRQAKn2hKHVZCnPnAmJWcV0+
	KtNunYPf9TjSonPXVv0yZi5K06G0nVz7V6ObbYF0/49i4KAnGmApxpbwk/gmDKrkRlbn14rnpv8
	xzKnpc7hKZbBilk/Cc7vpQ9pHupQ5rzc6cQn1iLfMAecmHEMayfzu1Nukti68ylp6PFCzD39/UO
	shu2lVhvXluio27QEhA0uah+q0/trowdEiNWaP8vNfxyOUVrRVmexQKmVmY8tjLHqdXyq6GBK0Q
	2XGbD//+xNRgIaUzVhnnA==
X-Google-Smtp-Source: AGHT+IHZ2UUjx42RRlWVNMw3b1W04C9piTrC4WnPU6SDQCVTlKuzNskyckz41dtty4xhtSX8347Scw==
X-Received: by 2002:a17:90b:53d0:b0:34a:c671:50df with SMTP id 98e67ed59e1d1-34f5f95c745mr7519717a91.17.1767859772019;
        Thu, 08 Jan 2026 00:09:32 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bafe991dsm6900582b3a.16.2026.01.08.00.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:09:31 -0800 (PST)
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
Subject: [PATCH v2 5/6] dt-bindings: sound: google,goldfish-audio: Convert to DT schema
Date: Thu,  8 Jan 2026 08:08:35 +0000
Message-ID: <20260108080836.3777829-6-visitorckw@gmail.com>
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

Convert the Android Goldfish Audio binding to DT schema format.
Move the file to the sound directory to match the subsystem.
Update the example node name to 'sound' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v2:
- None.

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
2.52.0.457.g6b5491de43-goog


