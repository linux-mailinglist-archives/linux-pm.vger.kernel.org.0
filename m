Return-Path: <linux-pm+bounces-40695-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF192D154C8
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 21:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7222301339B
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 20:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A31230BF70;
	Mon, 12 Jan 2026 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqRgaRrn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFAF32F757
	for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 20:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768250456; cv=none; b=MzD50KadhchA9i3x2w/KejEJShi1YZcFxsSQ6CsoyMueLkIgmpyqDrBq2hQi8Kh/D1CaYnAc/fE4yPuZAVpfulCHLrgCxQ2y+9i3E0/1dY2G5YDGdX2fS2lweK7gwtfsVKvWteAdKjmFdAIUX77nWvLFPmvDurHeLs9CWNJM5EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768250456; c=relaxed/simple;
	bh=1cgc9CyPLdaamTqWSH/prcaGYr4QsO4nAqSVaUroafU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsGyKwwECpyqIJIOYSXA2wypNiSB0Bkp8g6gO9QJgmQDoMbuCuYdr20CqljgFtF9bjQ8tYbTMRpVUsT5OmXRzTDenOhYXPRGY9A4dRKwEV9NWjS/a2R6hcssRCtNo8ooArxOBp0t++bfKIGnwJ45Nb0t0wPecyWhsVaiSju1E+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqRgaRrn; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3ed151e8fc3so4204093fac.2
        for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 12:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768250453; x=1768855253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0PErH3A+TCXfgL5PR8asxXBIGBytLNSMzZeGmnD/jY=;
        b=CqRgaRrny86PNicf9ORDMvYcdUY/s9AM1piXJV9YeaVNzpiEjxXq7bbvvnUs47yZX/
         2N0lLlpRbtqxDX85L14puMLb4Isd1C1fS2x18xQBnsvZN01jkwcoGDBoFSsa2LMGiNOg
         N9kRll9aSgTdiw7RuFJJvfPekJSybIm7vnbPzUNtoHFlpJJi6Xn0e4NDt2aSEM09xjWB
         4LR4sPN696JtISLY0Mje4ToOaCqf2Uh+QVK5gCUdOqZufRuTLmP1sKl2PC6DUocdWjLl
         ySDmeMXiTG8weGVC4W3GnCumkdbiRxfw4JiyDcpPFvgLRK71d3QmmzH1J6dgWDRda7ij
         Iu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768250453; x=1768855253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A0PErH3A+TCXfgL5PR8asxXBIGBytLNSMzZeGmnD/jY=;
        b=tfxa/uAB1Zdkd/w4tYlkYIPHJTe6pAOivXO61wLBgGcZbIqMVMhSl3lLzJ4Xs4xzFA
         2F5M6vBlNmo/oUL0wQzEZiJucry6jbegYauYVF1U1Dq4eyE6pY5t+0OsnF9x5ADCjTrX
         vAjBl5PmP7yhjYB045WB9jDGdYc5AcWQHd4ghe1BbGvnuFc2ErS3NosrSDjpa56KaJN+
         BVsHLqIc2kEjwtYi2aMbBJfW+ANn7QjOHlFAKb7mm+zRwCf0V8Dvp3tFLjcPv5UuDT1h
         A3Z0bFyUzonhN2hOrald4UmNsWu9CLqiTm91jb+GIJpujKEPihgkO48RrfPhtmifmugL
         CxWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXggQCKlEBJNrpaYxzBS8J403p941uDpB6X85VDcrVPEcR+c6bxNvFo3oo5md9s8Hx0D+0GQEfHPA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo6hnU5YVqCjQDDSh/rpExzu7vvC5fYxeytU4Wm7lLgilohmrU
	r2miq1bXcJARrdVn/kFc+L+HrRBj+dVGarg9ulvdN17TwzmqZBiaFJ3D7Ku5TA==
X-Gm-Gg: AY/fxX6+T5XJwioHkCeDjAILb3d/96xqO4NvvsHeKxWmumMtTSPwa26rHep1uiOxVmM
	nYclUvtuTpcoVZHwOvJScIAhePFPZMZ97SLQK4HpoXZgJo51mOt8v1HxU5rJuK5ANld97ZaQmSm
	SdZ1C7niglSozeQOgutcUChKe4NRBjgq9+u8yGhaF7ICB8AEjkkxFCBRSHzIgFJ9D1TaB1AAmVh
	7qLs/qPilEF/RI0RdYxi857b1V4Np5HjSSKTvh/tafNgBhJwVO+2NEywU2IX3skLDu9LyGh1ZHK
	TLJ/XRl3u2yPhFtfXRUbesYW2xaS681Qeg2aU+fm+LjxL13TW0HeUYdKSDkQBGbMPHAq2egWA6s
	mhmpkvSYznVHWYyl/H0/qtylGbPSbM3c4OKYngkZI/OuSqLQj+bWf9v9/fpRuT657EYoD/ZIKAQ
	SKZ09QUCqD25CXFuSzA3rqpXg53cpZlwN1Elac7pIMQxi0OWp9rZ/kOGpOifpkZIIjoPDwhfC5F
	XIMyBKeXysyw/Wvx387ew==
X-Google-Smtp-Source: AGHT+IGZVQoYbx2iilZrdLG2Ztf307Z50A6C9NTY1Qg4UTlyKWI05nICHsHwet4uo+a7zycAJ/JW+Q==
X-Received: by 2002:a05:6a21:3291:b0:35f:5fc4:d896 with SMTP id adf61e73a8af0-3898f906a35mr17214236637.20.1768243921460;
        Mon, 12 Jan 2026 10:52:01 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b16fsm18874197a12.31.2026.01.12.10.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:52:01 -0800 (PST)
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
Subject: [PATCH v3 3/6] dt-bindings: input: google,goldfish-events-keypad: Convert to DT schema
Date: Mon, 12 Jan 2026 18:50:41 +0000
Message-ID: <20260112185044.1865605-4-visitorckw@gmail.com>
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

Convert the Android Goldfish Events Keypad binding to DT schema format.
Move the file to the input directory to match the subsystem.
Update the example node name to 'keypad' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v3:
- Use decimal format for interrupts in the example.

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


