Return-Path: <linux-pm+bounces-40696-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6FAD154D4
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 21:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98D77300874F
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 20:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80E134B40F;
	Mon, 12 Jan 2026 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3SsIwkP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3176C280324
	for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 20:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768250591; cv=none; b=Qc0TY7QJz6fUwVOSH/Gx9rVHH1+t1ItxlEDdrejfJICX9i6JfwvANjuii00NAW/jUns/hLhNQPP+Z33tnndSgKDzxmomLYl8edCLosmABiGwHuwPC7HUmLY2Y5edApyhjB+sAZUS9BF8yYcp6YrsMfS7DxgOWis11xiLpO2lJL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768250591; c=relaxed/simple;
	bh=FJzcSHDXluO4dUb76g2nKqIIglQO2UJtt5G2NIwIGRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixYf1a5+4hOo+9elOBg9k1tzrN6eUlLxW94KXwkWVvs6yHiD3KPor4KFS1j2QL4wOdAwdWJSeeJynrZBSj1A12t0/mpSXHtWOxul/WYUK+DOti6RUx6Nt5T5Y5JKe3rOpyVZ342Uh6aHWbbNt4xT0G+LNiKxSQQd1LbLrdQcKqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3SsIwkP; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3ffc3d389a8so3482385fac.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 12:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768250589; x=1768855389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcdvqbOz52LfBLxCMSffSYUjax3JQUZoLUuen8kKWUc=;
        b=D3SsIwkPfWFloRI3hLGGY89BITeShNmDbiT+/82sy9Q542ieaZppmXaWOX+bm1zqwJ
         mXuyRQIPRvUWq37k9mOpsajPJRPWChm6qdfHFt9zC10yyCdBB1m8jFWR88jW4X4M45Rx
         /zgj9JSWnRd6s9Hnp5LJdSt77qNoQafw6TnWExWIeddq1oextBG14tzqxc4OwaAiTfkR
         bplvOYHoeMMM4yBEsvXkaEy5E7LhyNljq//1ZzrYJn+uL8Y4Ea7IGkg6DFNkqV9E5kET
         zYjSSwYeg+qu88z1QYYqUArISzccTuVHz+0wwkl7H2Uj08xomEQz6wAc5yGzj7wKXh8m
         pB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768250589; x=1768855389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HcdvqbOz52LfBLxCMSffSYUjax3JQUZoLUuen8kKWUc=;
        b=Eqo4GlCwLq2jhIGVC3g13Iw6SeeHLaMroFbwCl3MPFYELLvfM3/csDjln3vCI6MwL0
         pnrWDZ6MkKgpDSfZ64svSqld8RIWmXoPBHKxu1HbN0fVNVmgILJylxNcrv4Gp9/kZvCW
         HzZsb381h9cyObTthj5HwcAhxirK2iZvLpKMVbYnyVG4+KGRVoJQZ1AP3KZI/XWR88lA
         fdh4x2/jSmgRRwVfJaFhXBGuk0+QT9HwWK7rLvsWQuWFQtpvdCTxhdCPj59Ek5/GrIde
         NMYC1GrFp9obiap4zDzuecRnL+hb2rQEcYowmHAML6lsHp3jMvB0qCXAYI91nZwzUBBt
         ELQg==
X-Forwarded-Encrypted: i=1; AJvYcCUvcdMCYARmPDg7R5CVcUoeBHK5/K8DoDQ61HNzrjLrDV6/fX7MefKMsG1mQOaLBkooq3+HFpSpkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFBJ5lbgKCU9WO7fG0+JXBZvoRUSe7K+0BWYL168iJ071OU9XR
	y7UbcEQadJYJngb0+4Hju19PnR36Af+6nnKCqD7TWi83DcJ3yiwnvlFBg/YvCA==
X-Gm-Gg: AY/fxX6aEkRU9P642TUvU7u3eRG+TJkh7U/zpOd9Uie4N9lmHqf2Qvkb2Z8mMZMQbWO
	bWr+5vbqkP9Y0MLMcYc/xoqQr4Vy20S9U/XpegJG4psTFrFazpAljEGVmTD65IheV5u1+cE2kac
	JZ/rkGPAbw1mvsGPW4N5VX3b/rCPMnkhP/SX9eTMtxbnppfKEszvZ6St8wpGP++OOmmhddEpg7u
	Nx/VTVTsEIEMUBp22P/ighXPoPQdH7AuL8x2CZPKlrOVRsh9pagc44IjjMQq1NJPgvmeGoHT7/o
	/RGVBsKd+9GSV33fOZgchpx6SEKhu3nqOhRrmHkCLNg43YhohS2bq491ZMdBdbm2E1hstU3B4ec
	l/IUlQ11e4iutxkCKVpiSsimje+KU1W8RG+5lOOIAgUXcK5YPBU3Gm+CZ03nDeg2/JT+toPK0Mr
	XV+FZwfyVj4aLolvohmWKarhxfAmoRF8TI+GRh4KmwybEFj89XSBOvDfHuMWYeQQAAV+fkAj2MP
	bNWket4GDeTIJckC68VsQ==
X-Google-Smtp-Source: AGHT+IFk1Dr6wslFyNgQa2xGPUDljm9kHZ7BOgUopSMDiNk3ke91/OiF9CCfER+TuAOFwDhwgffkQA==
X-Received: by 2002:a05:6a20:9389:b0:364:13ca:3702 with SMTP id adf61e73a8af0-3898f987e4dmr16296668637.42.1768243926226;
        Mon, 12 Jan 2026 10:52:06 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b16fsm18874197a12.31.2026.01.12.10.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:52:05 -0800 (PST)
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
Subject: [PATCH v3 4/6] dt-bindings: power: supply: google,goldfish-battery: Convert to DT schema
Date: Mon, 12 Jan 2026 18:50:42 +0000
Message-ID: <20260112185044.1865605-5-visitorckw@gmail.com>
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

Convert the Android Goldfish Battery binding to DT schema format.
Move the file to the power/supply directory to match the subsystem.
Update the example node name to 'battery' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v3:
- Use decimal format for interrupts in the example.

 .../devicetree/bindings/goldfish/battery.txt  | 17 --------
 .../power/supply/google,goldfish-battery.yaml | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/goldfish/battery.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/google,goldfish-battery.yaml

diff --git a/Documentation/devicetree/bindings/goldfish/battery.txt b/Documentation/devicetree/bindings/goldfish/battery.txt
deleted file mode 100644
index 4fb613933214..000000000000
--- a/Documentation/devicetree/bindings/goldfish/battery.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Android Goldfish Battery
-
-Android goldfish battery device generated by android emulator.
-
-Required properties:
-
-- compatible : should contain "google,goldfish-battery" to match emulator
-- reg        : <registers mapping>
-- interrupts : <interrupt mapping>
-
-Example:
-
-	goldfish_battery@9020000 {
-		compatible = "google,goldfish-battery";
-		reg = <0x9020000 0x1000>;
-		interrupts = <0x3>;
-	};
diff --git a/Documentation/devicetree/bindings/power/supply/google,goldfish-battery.yaml b/Documentation/devicetree/bindings/power/supply/google,goldfish-battery.yaml
new file mode 100644
index 000000000000..634327c89c88
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/google,goldfish-battery.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/google,goldfish-battery.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Android Goldfish Battery
+
+maintainers:
+  - Kuan-Wei Chiu <visitorckw@gmail.com>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+description:
+  Android goldfish battery device generated by Android emulator.
+
+properties:
+  compatible:
+    const: google,goldfish-battery
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
+    battery@9020000 {
+        compatible = "google,goldfish-battery";
+        reg = <0x9020000 0x1000>;
+        interrupts = <3>;
+    };
-- 
2.52.0.457.g6b5491de43-goog


