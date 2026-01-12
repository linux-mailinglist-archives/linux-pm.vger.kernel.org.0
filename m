Return-Path: <linux-pm+bounces-40693-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 41380D153B7
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 21:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E13FC30074A5
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 20:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8308933C191;
	Mon, 12 Jan 2026 20:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPGMaK4p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FD43019B2
	for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249985; cv=none; b=Hg8MfjHyMI99Fa3lMNmjIOKNAaWOtQHW5rj3/h5LQBtPpc68WZETpMd+JMBSNbPYzLyHfv6Pzr3/F+rbFVCRSZwSeMeXpVTxcXvi/cAVI24XLpTWHhojdvDgFIzoiy9nmtbALJ3jGshZr5aOdbHtM6ruR5UQl9sEOUiJA6hg9Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249985; c=relaxed/simple;
	bh=GTLyrTF/q6Eyc9fZ3Fa8bSl/4UWeB/Vses9dYwQVfyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgT/jaxgwBq4gcMChy1XeyjVHtqOXbh7qiKrOmlnE8MYu2+RIadhJZXCUP801TuQpo7e6XPgJUJKnQuHjWnhaNGaeuiDI5cjmfUU147ESP2Fz3RjuFY9ZcokNoICbsspTnVj0tfTitqQnKd9Ivgw3Up69kws0WAn0uRk8i2WMBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPGMaK4p; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4558f9682efso4333316b6e.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 12:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768249983; x=1768854783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oL3a/4UaA+a8Zff5y8gdtJeilEUr13wkA6OARJeIofo=;
        b=PPGMaK4pwoCwV8NvO5IOEOog4wvldFwsrPpVcLNyWVg9tuCCm89zhAJC8DbloKxh1G
         WInIcmyHdIruA3bW5q7MRwloM35ymWDnQ6uewpiAeJltY5lb3mkrrbS49mC79ZRb0Yfl
         L3EnOiu/q90MgKF3oQBnnxj6qjeET963vMh39ZeBjncHstfkvLmfzamL5cwnN6DqXDBa
         qxq+rRAemwT4O/wfDamDkIGY50gSr1gJX9a4bBRUqcXrSGQyeOPgVK3DtzQgeAUtnOxU
         8ULW6REhuSS82UiGdHZTkVxFiZ96SwPxaslB8w2Kav6bld4RQQFN+hRBUq+wqPXq1jJI
         41NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768249983; x=1768854783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oL3a/4UaA+a8Zff5y8gdtJeilEUr13wkA6OARJeIofo=;
        b=W4wJBX9g47GM8w/TNlB3wQfw1NlSq+Q1Wrx4R/esc8tSAf7OGRNuc5LKPFidoMmR87
         xf/ltfCfPmy8leGhwtzY+SSBNLzDcVxJGbr5shrMHwHUKQGeDeEZk87Qu9KEmmBFPtvC
         GZ0RB3jF4Y2j61CqiE0CMWzIgnsPWQsXFyYo2qISl2tbNfsThe5J4eERrtDd5I/+NGTa
         sfdDZSmNARkJJvFEeirqQsFDo9p6nSLC7hwNP2ls71sSdtIys/NtK/20D+31VJdYTz2H
         2kV1qU9JBw7wApbevgylFy0hK4jmLmNuaYUGqEnnKV40m55uJY4CtE5DheFoukYhJq5D
         eNPw==
X-Forwarded-Encrypted: i=1; AJvYcCX5Wkt+6r5W1uu9kiiJ9ppROyrQnHYI0x4H9B8iu5ejbK5X/Gn/1sXWxT/JhiCHLXGeZfLyc+0tOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoR3dqLMyoyTRbAcbOLikXMXPcYNN7saSDhgnMmMr1ztFqmJD4
	VOxoR/H5zE4rxuvKGb5NUxfq6wZWbgsm8aDWqe36z2beX6f/Sr9vsORS
X-Gm-Gg: AY/fxX7tQyN54qn6q3DlyLOQTR73ah6nbAfU6vyS/0UnaBWY4iYKCgzOL7rKQmPp2U8
	ec3T3THPXRo4Q56MAA1X35cmYy5s5O8Fy4Y9tTdBjyXC1Uvtxzc/cGhbjwNozfLK8irmd1dGjpn
	IBcl4J6zExhCEkLyC2/algVP+OZ9Z2WFlhOrayMQq1mdoS0enaix7Kpp8Xe0auZPQXyt69PjaO6
	sFoZSo/I/qsakDav+VNnaUgG24nm3yLF1UkP1MRXgcIy/WQHP1yY7vruZz64w00uK0D0mUxgnHb
	Wq5v6zIOz/jGYdbpqjyp8hiIizWu3ALPmTi3I9VbZqbXxcm3l0rofOCpwZVF+9A7PaB7zIFjAiy
	X25h5fhPf6+SlQ+lVmD8ODn3GuQyJZrEtSqaBMwIvrJM9QMDfRHDR1JpSIeB6fpm59UclcM/WM5
	aOydasS75wFWbyscK2V5NIRzwpX0EoudNU9GD9XVC79C/e+ZuAQ+DaAPO0y7tIHarxIDQ9uGALG
	FoZ7WSE12h0IX4IpqPzLA==
X-Google-Smtp-Source: AGHT+IFAodgf1HCpii8yqntRagZFeymJlZlYuy8XB+cGQHdG7vRM/mtdZt981BYzjdhg5eNahHLaYQ==
X-Received: by 2002:a05:6a21:6d8c:b0:35f:6e12:1862 with SMTP id adf61e73a8af0-3898f94c400mr17035763637.19.1768243912001;
        Mon, 12 Jan 2026 10:51:52 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b16fsm18874197a12.31.2026.01.12.10.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:51:51 -0800 (PST)
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
Subject: [PATCH v3 1/6] dt-bindings: serial: google,goldfish-tty: Convert to DT schema
Date: Mon, 12 Jan 2026 18:50:39 +0000
Message-ID: <20260112185044.1865605-2-visitorckw@gmail.com>
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

Convert the Google Goldfish TTY binding to DT schema format.
Move the file to the serial directory to match the subsystem.
Update the example node name to 'serial' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v3:
- None.

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


