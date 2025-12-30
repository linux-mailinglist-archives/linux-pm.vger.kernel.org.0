Return-Path: <linux-pm+bounces-40056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E2CCEA8FB
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 20:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8977300942D
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 19:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF452F6199;
	Tue, 30 Dec 2025 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLVZtG5V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303602E8DEA
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767124383; cv=none; b=l5/kLvZz9FHu3boj/Vr7PnQBZf24IuHBAloxtyscjDhrgMIllk+NQebGEa0TANIQgYOxqXRKkYDdYcYmpXPeI72/vz4uIBbuV+AimQzfbcoJC3h4YtpbGjAI4ZDpFLgpLRCEf1NKr6h6aaGQrcFZjGYOe1qDKH7Bf28D/67+c9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767124383; c=relaxed/simple;
	bh=4Uq/LuMFJ/bKwMeSTNcN1XmhonxlOFuHeuhk/6pGReA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYO2NwnMqtGgm8VHKxXlIAewpXpgADcaflIZox56yyAphZg0ZCqiNkl6LIax9X/m+ki0Ss+EIFFNkIfGGRbF9RcyBftLdEg0FVIJuF1p7fXk8q5dJnFaipLznsj5yTn89KN6NJ0+o+h8axo2FhT/GKUEv6SHqHYDqxmS21VdFYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLVZtG5V; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3e7f68df436so7520455fac.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 11:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767124381; x=1767729181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQ2qeV8/CMzii4Cc7pVXwWXbCg7/CDjibpfP3lPkew8=;
        b=MLVZtG5VIYQKBKmnw5n2bcnR1N9R+v/VsnAnwexNlTSGgAE2qoH/hP+ewFk3lX0Utr
         J+9ZiuI1/R4OqR07Ykso46wue8/ZY/B9PSL9rkELDSiGOIEl0IFo2f1HTwA25lNfQjR2
         gNwHSnKtoPAgEcHdPfLxfgIY4/1TeuylE3WI6/5kUyxUyao88BscNENIahTIAgVTv3V0
         XNhd+FBZ8oZMwyXu9AVvpybcmVwYaMe0UaN1+7v2yco3F4LUiOwSK4EhaLEhGO78nPOY
         uUBhszaXzdHcmbkqX5qyZG+6Im+W2FDr54SB8GUlvjAeatnwAv6EJZ7mBMcIg0V4lQQ0
         XdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767124381; x=1767729181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SQ2qeV8/CMzii4Cc7pVXwWXbCg7/CDjibpfP3lPkew8=;
        b=GATIkJ549S8XhmQbRa/6RNbZ8GG3dJL4KgvG/J5ujHavRESAKubQgSoCuAaJQBjLda
         gRxuiM4jdKNFH/wDTWgBnQBDQ8HuBtumHFGTnQY+KShSJRUw7URBV8GvDa9PQHe93zyI
         xXBzU7xGMJcpO9wapy/pZTqp6wgPIyS5P6sLh0nFCpT9EpEz0pyAfyx6ZQ9kOaEM6VDL
         /aHZ2beL90K7L0w/kMw4VeeGBpuUdtaauBFSi7itvHVSAXIW6V5c6IfgF6nHapx3PemM
         WfvAF31++3NMk9Q+h6R7Xpqj1hD4dgudQMhK/mHMldFzWoJJ2mfvUfkVh8BPk/aPcfXb
         V/2w==
X-Forwarded-Encrypted: i=1; AJvYcCVcoFoGDEYWcT4UdYD0+Yn9GPTJ7P8aoZERr+3Rshm8VC6PYoto7NEf2wa5ybvdJyGdfLgrxS8CZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTvGZleg9+UZvpQ0F/v3hzsYxWlsKx3VRHOaOX1urzftn3Pm9C
	XIxJj4YRrf8JWqY5zoSWVsWwAjLXAwZCFxC6ZqVw42iVpnXpIjI5bS7e+bhh5g==
X-Gm-Gg: AY/fxX5iN0NFM4tdrZHKv6RPF9ZVV2pRMHtMlVA49ClmQkm1unRhboUTlp4dYQM3Kj0
	wwB3O3QP2N+uL7Sz0LAjr5Fu6pZK8cSpL4GE/gn5FSNeQZQtaSqZO0eJE6JYPnIBcHUqa3IN4u7
	fpbaGgAngqs65wSH9Yd1tOlK8ENPvaZlo/j/eAT6fFgSuwS5lQjaG1hKOso/qz5BIHHwJlIp2WU
	YT1kjrrvQ951fgT3lLkkT1ssOxlX5T9qk94U9dpwyFrDZE9j0K9llTlErjKWIT6TPWz/ZAnn+5v
	Z2DhiXtAealWYEi1IvpqrmMZxZ1K6fRFcR+GblC1TSmwtEwgD8Wn5FRSUfPVsIAO7ql2WXARnGt
	1nIJFQaRX4hBpX3JDoR2U1jmsq+QcfIQkRcxNKQqYFZbt009VSAfJAYdVu64mPL9HLkfqwOh2Zh
	GD4Oj2h1X2OiJCzbQDhUeF7WRhE3KnurMVbGvZpUzqZ6syjczh3VD8qYyUZs9TmAcuE+iE5uIOU
	J5rfzINHh3/4X1pRzEatw==
X-Google-Smtp-Source: AGHT+IESyaAQ5T3YAYk5oG3HpiGG3dgsPGYC0NsIxOY31vJ9VG1hZq4KkWvGFlOWl7CULDPAileC8w==
X-Received: by 2002:a17:90b:3843:b0:32e:4716:d551 with SMTP id 98e67ed59e1d1-34e90d6a42cmr29651001a91.6.1767118281443;
        Tue, 30 Dec 2025 10:11:21 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7bc69728sm29598278a12.19.2025.12.30.10.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 10:11:21 -0800 (PST)
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
Subject: [PATCH 6/6] dt-bindings: display: google,goldfish-fb: Convert to DT schema
Date: Tue, 30 Dec 2025 18:10:31 +0000
Message-ID: <20251230181031.3191565-7-visitorckw@gmail.com>
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

Convert the Android Goldfish Framebuffer binding to DT schema format.
Update the example node name to 'display' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 .../bindings/display/google,goldfish-fb.txt   | 17 ---------
 .../bindings/display/google,goldfish-fb.yaml  | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/google,goldfish-fb.txt
 create mode 100644 Documentation/devicetree/bindings/display/google,goldfish-fb.yaml

diff --git a/Documentation/devicetree/bindings/display/google,goldfish-fb.txt b/Documentation/devicetree/bindings/display/google,goldfish-fb.txt
deleted file mode 100644
index 751fa9f51e5d..000000000000
--- a/Documentation/devicetree/bindings/display/google,goldfish-fb.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Android Goldfish framebuffer
-
-Android Goldfish framebuffer device used by Android emulator.
-
-Required properties:
-
-- compatible : should contain "google,goldfish-fb"
-- reg        : <registers mapping>
-- interrupts : <interrupt mapping>
-
-Example:
-
-	display-controller@1f008000 {
-		compatible = "google,goldfish-fb";
-		interrupts = <0x10>;
-		reg = <0x1f008000 0x100>;
-	};
diff --git a/Documentation/devicetree/bindings/display/google,goldfish-fb.yaml b/Documentation/devicetree/bindings/display/google,goldfish-fb.yaml
new file mode 100644
index 000000000000..48b9c056d9ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/google,goldfish-fb.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/google,goldfish-fb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Android Goldfish Framebuffer
+
+maintainers:
+  - Kuan-Wei Chiu <visitorckw@gmail.com>
+
+description:
+  Android Goldfish framebuffer device used by Android emulator.
+
+properties:
+  compatible:
+    const: google,goldfish-fb
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
+    display@1f008000 {
+        compatible = "google,goldfish-fb";
+        reg = <0x1f008000 0x100>;
+        interrupts = <0x10>;
+    };
-- 
2.52.0.358.g0dd7633a29-goog


