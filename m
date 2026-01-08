Return-Path: <linux-pm+bounces-40440-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ADDD02326
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 11:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A630530C924C
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 10:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2C74383A2;
	Thu,  8 Jan 2026 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1rIOeku"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF0442B72A
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767866140; cv=none; b=JMvhscYbA/enyNdjL4eGFC09z0pMCMxWdSYwFogxAkUvZhhw19SlbFgCiz20SU9LgdXAeQaiYBEk1oEjZhVhCk0YQfbkqmT5ZBtH4YuRWMFt193HIBxm9yKR4aoUygvcLgM+Ok9dj7Wheo/0aSwMNC57rOkBQGIMcEyCGoseU5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767866140; c=relaxed/simple;
	bh=v6KD22Dyx3+5ck20H0pl2sYgGNxEEsrVPo7bCwCkiBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dboFJ/sSzZzL/SLhTkAJi0edl8rw0d6yjOo6b9O0ENdl/CSAqwQ6evfr9q4es65b5F80mvMQKMNODR5WNOcCVIgmrVO3Ti0HlhPtob9HzR7jqaK+ht1auUORW7nIsRgFz5EKHDNouS6gJpu/mjoFZOLJ6KDVx0vwMlfqk5CMQbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1rIOeku; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5ec96028b32so1278634137.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 01:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767866129; x=1768470929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHhAP8tHFGp6R15hZZObJ523oYtuLJJxIs+qZwxX3g0=;
        b=g1rIOekuhKi6yHXZr12qqsIGPLfZ0XksW6daPUklKNEEiXaCB78TcKd44A+ezl81fK
         voAoK7tpob5Spulaz5aUcG42XNyBoIK90wVqqAM3OqnnzZGvo/O582lXdIH696CZiL2Y
         fTccmLuKqYIejiVPP7XQWThQM9zXUBvvzEu1fCLzkn/0rCX8dN2/dEGISI6DYsjGTbTj
         krM7oH55D2Hw58kQO+CwHEdwHi0YjH7srY4C2O5ywVuLJ0xGrHH0F+kwvsgZWT8eDR+e
         l6jbz9Qj7gqswz1+ptmRUeoXSx8Uk4C6r6rDf9cgTt/cjVW4zcegz/SODLqV6YZUyOwf
         ju6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767866129; x=1768470929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kHhAP8tHFGp6R15hZZObJ523oYtuLJJxIs+qZwxX3g0=;
        b=TYKB/cOxX8tJcyk4lVDwxgkVeJmArprjNTULhE2nQTMxZOzh2nSd8photkm2rULX68
         iLKPv0pp61OHLcAbP8bqtA+anX/LDz6xPAiVOhFRjmzaLPLFDZZoC/kjODJr39S+2Pqf
         tnJfVh/NdeMHAt0Py6CzuqZEmHXL4EdJS5zYnieuNmNGizOuw65eqTFJuUinlQtJP+OV
         WkW4q+knEUUH+hhNRAZto9zZnVqPoZIZg5ePKH3hxdCNQo2JJWZXfZhY9HXDTXmNEFs3
         RwVCW8YlMWDr/7Gp5waxHs3oT/94gVW01kLe2SS6TOU+pM0YmvGgg2bQ133i4zrqc6y/
         TT1A==
X-Forwarded-Encrypted: i=1; AJvYcCW18bCFU/FyOPbcVFwA8/VREO4bB2Zvcfn2drZDE5Q4aVMYBXvzUPmlqGf79O2X9207ICE6JLXzXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLIJ4pPH6ijdYsQo5Un+a0ug+AUChrBmksRf0ycHwYA8qLJjf6
	mg0gGBFN5/zYq19wFvfLMNxe2QjrHpl84fAav1xQWdBJ33QqadFuEBjcIXiMiw==
X-Gm-Gg: AY/fxX7SPbsZfOmJl84WVDJqRd0IV6MRIxDa944xe39rmSDFcp3JEGilaNPbt+hRdPu
	isQqZ3JlM5t0XAROAxzdaZfLPIw0hPRn/jtkSwYOM7KR4TtRwqWBeSN52ufiL4ZWB6d6iL+9s2Q
	lvlYxycedN4xb8BzSINkySyncoBPvzaJ/bdITSf9N4twPCqt5vLzi7LHSf+NDB0eaWZ9upl4xsc
	UtiuPfnX1KGMBBOdqKwDiZkYPO/aZU8oF7eAJrNW1HM+qNqSHHdmQssHdJbKOjMEikC3dzKxpCx
	AzoMQBw+QPIhIz7J8fdsU6hVCV8A7ZFzsxQj4Af6mi7nmQiidb0OYGhBZZyjZ4DavB8mZxFp/3W
	42TF4h6xQ1oAN1W7y9gEEIVbQw/4dyPoQLdOsciZ7jpEd56NmKAm4VWVtQyM9JrH/aokxSPPrCB
	4gK8AtgrTC9z8Um2uLRt+v7HuqbBSf2gL0eavK8xKo9Oub9/SHC0pmKEH6xpjea1GfxKss7Gt+V
	/oJW7QLxdk6kUEmhKvfaw==
X-Google-Smtp-Source: AGHT+IExPvCC8KraIjBsVHGHYTjET3yJHc/BTBjFTEdV/VDXcghpuxPJ+uczZtlqCGmQQNa17ulZcQ==
X-Received: by 2002:a05:6a00:288f:b0:81c:9f57:3090 with SMTP id d2e1a72fcca58-81c9f5766a8mr2451909b3a.24.1767859757241;
        Thu, 08 Jan 2026 00:09:17 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bafe991dsm6900582b3a.16.2026.01.08.00.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:09:16 -0800 (PST)
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
Subject: [PATCH v2 2/6] dt-bindings: misc: google,android-pipe: Convert to DT schema
Date: Thu,  8 Jan 2026 08:08:32 +0000
Message-ID: <20260108080836.3777829-3-visitorckw@gmail.com>
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

Convert the Android Goldfish QEMU Pipe binding to DT schema format.
Move the file to the misc directory as it represents a miscellaneous
communication device.
Update the example node name to 'pipe' to comply with generic node
naming standards and fix the mismatch between unit address and reg
property in the original example.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v2:
- None.

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
index 000000000000..12b0cfc815e4
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
+        interrupts = <0x12>;
+    };
-- 
2.52.0.457.g6b5491de43-goog


