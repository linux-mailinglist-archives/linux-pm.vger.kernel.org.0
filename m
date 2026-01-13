Return-Path: <linux-pm+bounces-40706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF71D17AF6
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 10:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35A7130C04AB
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 09:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C3E38BF9C;
	Tue, 13 Jan 2026 09:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kySEflIu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EE338B7CD
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296426; cv=none; b=g8KmhFXvDVvLys479kS8xXWsEisEyHmSZR0ng/kAqNtBiLD9rLpfTxhiza4DY2SiQ0xYsgE68okxPHE39Lp8vWUrs2tAY9XsQh1MUUcRh6xr/oPUfjA1FHtcxUxaHTgYOlLQ1K1iK+dGl6i7Rz73dBqdyuqkraQPo+1ZgCrs4nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296426; c=relaxed/simple;
	bh=+L8oRv6c4uzxGnAOgO1ncLSet2u2lLn2QoYO/8E8mV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnYbyONVXwnOYIhjkValADXLZ12BQ7sWmRJUwEE0KxuNERS5J4On/Ktoxnxt3FBzuj1ubRpugNbheWGLKhmRl9iy7GOQPnGa3iwUCzEAmh9JypvKgfBifBJHf0ntTeqFFxR6+jjJ5vo2XOqIa4gn84pzyCUEcNXszboLamq9Drk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kySEflIu; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34f634dbfd6so5302992a91.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 01:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768296409; x=1768901209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aq61suyXUukebztJUE3K7EWOiO6kPR6U4DExpN7jb1o=;
        b=kySEflIuUilN0f+EMaydKBA+7sgyMwOtjXgaAgqis3XYlF8IEIrAIyWTXjmQ9vPspd
         qEfbh4uf7kSUOL45OkXUhCBp316mYLdJOJM3q4Q6o/sGcJ35XMyytep6RHqisQ7Whjo2
         4wqLZma26ll0xwmeRdVR1RzDW1aBP3twbXfbReM4SSW1lnyVrf1q1Rl9bhiPhF/Ltz56
         2FMco47ydttcGqeJLFTNQVcn021tvufj/XJbkJ8MJNsaW34/kGyz4M8jLma+wFDhfBxr
         wmlFndAULJe3xYfMhZDJS2jdxrhyWZVz6qU7cD5bT3PUVzAOiRkWL6a+2HKk3iU78oRC
         CtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768296409; x=1768901209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aq61suyXUukebztJUE3K7EWOiO6kPR6U4DExpN7jb1o=;
        b=ekTnF1di9XadloSkTBqnZVxydNd1ndd9MRynqXjhwS7ciDw1FNJQBPYdBHQJq+qSAa
         mysW1B8k1XqJgSXaLosN7C7CjDFZCBNR2Y3v1cKq2L+Vn4eGEQQxoO6Dt5YY7f0bOKLc
         RDirROQrDmqXr5X7x63oq7ZpjNO5EBmL/PCrSANmMr4ZELK2+QaLX9AfzmoET2M3gJbg
         ojaCr/2tdLMQTrkmaffCmMbJD7z9mSmKz8wnytFjY8HBdqZQBe4Xd8EDmArwavqGDpPJ
         aeanra2kZoNqcGzHQ2Tmpu9jIrbzYp20Zb7AWyZv8cjHAcfsb3xag4o+2lYPayxyzB2o
         Nm/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtR25hsfBlI9OTQ9A9s/um8R7K4BsDKOIfmLEvbSX6R1GxRzXqqt0x67eZ77TW3eA+M+ayYkVRqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEimr5G0zkgFRRpwvzgi+WJcXcYtCJi0aptyhmwp5mtKuEUYbI
	k+Q5puchrbxRV8Rk3PnYQXmiCnoVqchOLFdMYBIwbylqqe0S37eXPmTP
X-Gm-Gg: AY/fxX7tjB47kbx7tVb87VyoM48pP2GaCesNW0w6NhgH0XaOtKKVf4oiIFpowk1LU8n
	ZOOB7jVGMWpjMaz8bloS3+0S0hBcVCMoWioIllHM0V6pqBhoaPd9A0wIcW/0YSePOb+JndmFlJk
	K2wWvIUcIo94fN9r3EtLowaQD5mqMz4mvMK0vguTIeuCMzyx1CDjaCxHQvk4UvAfmGeB+hm4B4T
	FR64uvxamn2L0SuqS47KX7QqjenXN35+LQmokVRguX23b02QB1HY6Y3jHycmRaPqI6ASWrWNWDv
	JGVWKsn/Sy+fXA39/YiXVI4R4TQxzyZnzxHfmStn9gRks7PnmeO5iTOdNP3vjslo5zToFnzIjG3
	s/JuTVhKhfLqKsK3HPr/x0ik7IGwBljzAVMTqh1uAaKhzQI9jEcLcwSgoCz8XlhBwNt7alIM2eu
	9nfXrcYTIbHE7RrTceHrhsNAJCZYR71WeyuYJcHdWvtkM44H/qCZ4rNn/HAJNde7DdK0nhg9d8M
	FgdtfQ3hwAEZFcwJXTznw==
X-Google-Smtp-Source: AGHT+IFysOWrChXhSoJPQJFZ+6qYg/6GiILncbhIBk3UgY6IvdbI61uVn8gPqLHEqaP0DqKTMcvR7g==
X-Received: by 2002:a17:90b:2647:b0:340:dd2c:a3f5 with SMTP id 98e67ed59e1d1-34f68c30870mr18506943a91.3.1768296409472;
        Tue, 13 Jan 2026 01:26:49 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8b0f67sm19483200a91.15.2026.01.13.01.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:26:49 -0800 (PST)
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
Subject: [PATCH v4 6/6] dt-bindings: display: google,goldfish-fb: Convert to DT schema
Date: Tue, 13 Jan 2026 09:26:02 +0000
Message-ID: <20260113092602.3197681-7-visitorckw@gmail.com>
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
index 000000000000..36ed77cbbcd7
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
+        interrupts = <16>;
+    };
-- 
2.52.0.457.g6b5491de43-goog


