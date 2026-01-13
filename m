Return-Path: <linux-pm+bounces-40711-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2772CD1844B
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 11:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 600453003865
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 10:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAD0325702;
	Tue, 13 Jan 2026 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7m3s04a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965624397A
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301824; cv=none; b=UlDq6vRKAoMyo4bKI9ttgiTSQupuwPLIY5+aGXNlVYkw+EfI7IbcHIlk8JUPHCTMkqJ+Zop0QDITRlf2JkKsc8MsyUN+wQ1xQ8wjwKooNk7L9Ge3Saq2/sGiZHarJHGErlTkYzTw5FVEGP76G2xGvfuQUQ+/ZH4dwZM1ARET27s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301824; c=relaxed/simple;
	bh=zdNFAH0iTWr7CYfBHRXif+JE5op8kPFWmv5y6FI3muw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0tMq5aqJo8mM7z0JIY0voggcRlUUaeJUgIky5V1Rap7TalCtn6lRBY4MF/c1/eLS51xr8y9dieOgfDdhElq2t6c4p79wYPPB4GfoqUyDDut0W9b8c3tTAYNgUpy83Fbqc2AHmAulejoNyXmFD1AeD1RVJl9mxV7etRf9SqO458=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7m3s04a; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c2a9a9b43b1so4964925a12.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 02:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768301822; x=1768906622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4hgjP3w88kDagdzWx8wSWq+XQR1e0+zfKSduukvDaU=;
        b=m7m3s04attUbSTtuZsGqhwQMoiUHI61EJ28RoOvWnMo3vRRzc7xblXlhuvioACpBt0
         jveEG+OWUn4F22Jpz/MtshpAogfI9wVTUEFbCjLM0u+EPighT64oEVzdWLMAHjZGy7OP
         nxLDgt1xti8SgkLGqAlqplnZ3dmTFMBwsu9XqC9b6OKpRTItnQJ6fAdK9WpIrypo5G6T
         8SsXsDziHNToplYhPonk/3imiFWUPlUD+X8uEGlx6zgEPuysbllIlgZz+f32PfykGyrt
         JRH3ptui1n/BhQr6I2YgGB4wXO5+PBiKvP8PJZq+RJU3U0H54neG/d7l3mIzYr+afnR2
         f8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768301822; x=1768906622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d4hgjP3w88kDagdzWx8wSWq+XQR1e0+zfKSduukvDaU=;
        b=j35D6Fe8HmM1XDg5qfIlMoHdNh+XfDq70ve+bwmTKMLbjnnUaEqGCS3+SGhWx0BdCc
         hofInzAEdmfPpHHaiRdwKe9gpUuB8NRBhM9tnWJ3AffefTaKh95I3SHXFRTAnw9WiShX
         2oGN89QFUZvb3/pbZlJ/HRUWkvNdb6k26KGy2bWws/IyJdhfQ4NApe5LB+dOvPbENn64
         hWzA5/13GwaEf0eR9T58/8CbgwNZG4PSCBWTTloJllAs7+4ec/lGtXbREPOukJqHTt4X
         vwIkmdPDadLb+THB+ggA2cY4N8IR8veTGunBWokPZgqwt3ePJ2cFOsS9JvXZe+ItZqP5
         bnHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoLBOALHF5qQYYfzMI5ggROoOfeiBCBcOnKhBprnE7wjK4I81INOmpx/aeQUNjpelPda5XPInm1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YymAUguBC+m24e5CX8i9ixCyZxtFnaKg8mcEfeFX1n0MaeLOjFr
	IAK3T456hYu8q11Ybr4/Z/vsAAp/5go5p5IJtBCjwMeqd12nG/XM/qLI80oB2w==
X-Gm-Gg: AY/fxX4iBczvVlD+ljJg6ZT6gwElmr3hlcTXDmr4UCcUOqIH9hOh0NdtlMbR/cKteSv
	YqJvqgwb0jjFQMnNepjIVSxJlTgHMJa5TpRVLHU2Eh6yunEpMyDqfcak6y82YrH2Yt8MmaIvXmH
	uP9vJ+7Qwc9S8S2XC1YCGFY4hRllg3ptoe6X/JSQ/i3263joGbDhPJMgHuPG8dmKzgmBEPC6u6P
	m7k9vLwH+b3XkE/x5zQFYtX1N1vfOOMZNZihFsxiuOyA+gwMK9lQaWPAvuWy/UNUR6uTLuqWslS
	jAzgoGeZTCk/jr9Wt88cnlCjOmyMBtrJlG+CyvumwlFx7JdhEV807jmxzzXfXtUDVG9DZCLDeDV
	mxEfdt7WZb+xOi8tP57T4pOaK1WhT08qY8rIGJs9t55e1O+ea4UKmMVTPllfduxeHzNq9e/ZoFy
	ZLjB/ATSNQyO78AglL+m74hKRhKpFPkkgZ0zkSCwt08jAGBwN7ziFUEbfR8tGLq7xNgJwjDDVJs
	T2YXQFnRix+Q4w6YEMPOA==
X-Google-Smtp-Source: AGHT+IERyXXRObriIfp3G5vGgqAQ938C3mDCOXYLyt4LrW1z/WW3eq0L+wGB0uC11elqp7ivzib0lQ==
X-Received: by 2002:a17:90b:38c4:b0:340:fb6a:cb4c with SMTP id 98e67ed59e1d1-34f68d231bamr19378825a91.30.1768296384398;
        Tue, 13 Jan 2026 01:26:24 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8b0f67sm19483200a91.15.2026.01.13.01.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:26:24 -0800 (PST)
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
Subject: [PATCH v4 1/6] dt-bindings: serial: google,goldfish-tty: Convert to DT schema
Date: Tue, 13 Jan 2026 09:25:57 +0000
Message-ID: <20260113092602.3197681-2-visitorckw@gmail.com>
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

Convert the Google Goldfish TTY binding to DT schema format.
Move the file to the serial directory to match the subsystem.
Update the example node name to 'serial' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v4:
- Use decimal format for interrupts in the example.

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
index 000000000000..0626ce58740c
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
+        interrupts = <12>;
+    };
-- 
2.52.0.457.g6b5491de43-goog


