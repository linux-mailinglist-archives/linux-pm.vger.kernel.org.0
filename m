Return-Path: <linux-pm+bounces-40705-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFE2D17C65
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 10:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C87533054F0E
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 09:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0512038BF6A;
	Tue, 13 Jan 2026 09:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdHFDrGq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A465638B9A1
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296414; cv=none; b=LgE54DNYAr1HOuMv65D45W4+lN1HuXtZLlNHRH2p0KMoO1P54LubZcpRJrxjTeeQWt5mPIaRStVxhVfFflMPaA6yvoJOnLO/J1fw/IHUHpEoL8y69V2c/BBrxZeKIe5k/20nPKZnPg3KP1BBs3SvAfqdtGxyMuSsCYAhbFXTZA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296414; c=relaxed/simple;
	bh=ws1p+puMOcBf/qfb0sFtnVfbyocdGIjo6AESCEhizgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVDFXVro82gn+YZGpMFYic1fRETyHezT3w/NJvt9vbdjqpGchKmv+ktYE00AWZFkl0i9LXPvoP0gj/xLs876BnrmrssDIZOsVwl3SSCJFPjULyAowLGH6F90uWSkVlwbtonNJcYed5kGo8mRQ8+TQ2Yzyi6tZ2TIhGlty+GfK3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdHFDrGq; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-350fe1f8ea3so300379a91.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 01:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768296405; x=1768901205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7EWk7TuRK54To9ZAGQlu+fCN9Q9oadA9Ns4P4AvNGA=;
        b=QdHFDrGqqCR+WcxB146DlBBMKwfRMeXhb3Dpy1o7T8ppDIfxBKmGwj7y/CQHmtc4ft
         IEE4KePrThXEN3XugJJqPbtwPf9TVio+dRxTs7lNju5a6Li7K77eKd6CnsKaQu2u7a4e
         8GW0u7Agubdx4ucIMvZD0C+dgA6pCD7evlOHQqTBJGUIcRwfkijMghBW8SUBY24Q8BDc
         LZ5YAqgKJNMQ601PWds66a7YxKBgc5AUtWKH99EI+EY+OcvXPZiFkmYPnOR7o3Ey4jKk
         FbJ7/p2Sc1oC7v75Z/mL6cUY+fvKjrHzQ+6bdVO8m3GCYeclikBq0a2qvyhzMxWfkJic
         DpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768296405; x=1768901205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U7EWk7TuRK54To9ZAGQlu+fCN9Q9oadA9Ns4P4AvNGA=;
        b=hmVSdTRcLRoU9K0kJUQcQmwNqE6ZEbVCj2M3VXHLZvWn5PolT11bpr4+Lf+qypsCtp
         HKvlY18He2u6xeZu4CT71vr/fLNPX8ZDVseaPDkWmRhc81vYyrTL96Za+SpUVss0fwhm
         Vlaq0G4DfSSNFe7hkRvFoqmWtH+REo49HedGQEhpx1b/7Pv/tDSKXH33l7iTgYafiSkR
         uuyNI5ane+k+kKSPv6ni5MH6Te9Xp4Y3cyCd42rDe0R89tHjlXCboDxRrjq2mcZ37kec
         OlFex8uNz8YwDtgHo9BHk4ggYCCHCj4IHPfqo1td+noB/rs1JzPZ6NxQp/57EDrgrMA5
         cA+g==
X-Forwarded-Encrypted: i=1; AJvYcCUEb/lNNW9bomSilhZtErqTRgk5awCyS1WjtKprIWc8QEMYBLFybJ+kJfOzu8JwTxsuJBuZANu5Xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMPHxnjZtt23LeFGTNQ9wMDffyRTfnAN8luYWQL7pvqbVJVKin
	GZw80jRPHBuZJFYgB/3HYef2CLj2CeuGtB5opH2QE85Br7sZfKzR7x3G
X-Gm-Gg: AY/fxX4AJ8ikL3AOJsC52b/2gHDRuIM1oMB8OQUb9heeyqKnx4M6SopDyOqVCCmKFsK
	aAxli3VoDzeDbfVk08jLtLJ/sVGwSXPwyYzaDIi0j84nEx8E7rffmninu5EkqxpT4QtjwntR1ao
	DIVAlLu4IeAwn/+l7WtgvxEuHsA04CcTEBr/9TIhIToNstpGvVodGiy7VhhJjrvnVxyR6G94duG
	3Z+CRBqfV63v/Xe7hxoyduX43aEFH+TfsEiijPhGkaOXEZ4JD+TBr6F5vFqmMTT33XMpGP0dPqT
	vWe6UptZM5fvXS0dkyj0WE16xRKa6mBtrGuU3WO+HL6uIURUUkY/lheaDUKPAhahtQ3PMJpPhZq
	+HwX25DZvm6YeXHlgFM0yiXno5aYUrCozpbh43wJbbI0K6B4/KeRro8ViT91r9BA0RAin8+U1E5
	1YIyTtx8F/CEJKLj+9+gAmYk7Fnx3+5rYGf6Ws681ETh+V0hxwUyowjEyLMY1k7gMV1HSJB4+li
	ESmVsEVUocWJy1fD88OQw==
X-Google-Smtp-Source: AGHT+IEUC0KJ50PkwzVSwPCDoxMcw68KkQ+8iOouE/4n+Sa2Bhle44HLNHQWtPdhk/bI7tQ9NQN1XA==
X-Received: by 2002:a17:90b:5823:b0:34e:6b7b:ded4 with SMTP id 98e67ed59e1d1-34f68ccceb1mr17985068a91.36.1768296404680;
        Tue, 13 Jan 2026 01:26:44 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8b0f67sm19483200a91.15.2026.01.13.01.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:26:44 -0800 (PST)
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
Subject: [PATCH v4 5/6] dt-bindings: sound: google,goldfish-audio: Convert to DT schema
Date: Tue, 13 Jan 2026 09:26:01 +0000
Message-ID: <20260113092602.3197681-6-visitorckw@gmail.com>
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


