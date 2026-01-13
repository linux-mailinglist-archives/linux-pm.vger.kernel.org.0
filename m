Return-Path: <linux-pm+bounces-40713-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFC8D184A9
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 12:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39916306117F
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 10:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B59C38A729;
	Tue, 13 Jan 2026 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7SUDUxb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0563803CD
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301980; cv=none; b=GLtXhTqm1WFaEfbRUmLiMdhheTArI4NHb5qmyCIGD4m8zKI12RD1jEtuyM7vJKxR8pEcTXmxwUQ5FqJBPYBEWBoplL6JPK0FN3ukH1j+82/CmeId26cLGLLeihk6+nXYna0zP3Sk0y4DGSd8QGNDj7aaRc5Ht85F3c8VE/xO+fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301980; c=relaxed/simple;
	bh=HDUKH+I7Fa+PmeSfYZXj+pEr7M14pExXySUjkX85juE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpqIbeL9Xqym5Rm9Dq6GV4EgWByO09+cxkNie12tFiF2T3wtLkGX/e2DnWhhki9/Nuo3NpphsEduNxdaBtWGjje6xwsce8WWXQe/CVnAaY1+ti6/tG2VrMEmRFk2jiTuFaKEVr1FNmu8qgHMEx52YrrpVF6rPAboMke6Sif1Rjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7SUDUxb; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88888d80590so95270176d6.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 02:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768301974; x=1768906774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DtPGFQHFju1IO/Degf1/ys2a0tv707U6qKEmBe4+A8=;
        b=f7SUDUxb9j5st3LaLZoZIVIxMyLIwS8gyUaimwo8S4hSrePBGj1cxUi55nBwLJ6uzt
         CHycq4qC9JLrgZhv/aiYBCIRgutOxtcEnNIlxKe8QZhjHU1Ocriz5WjGZvr9A50iuivr
         tUIaOSH+4J7Ab1Z5SqQMISpO/8UouY+85+hJ5PJ5svf9ZMaH6pc/fyyMCB46hIhh6Zw3
         Zdbd5Vt+srSJrW+PxuwsJmYWdegrtVpGWlaSFkhpCC2qd7OA6z8kFuijoIX2jfWCzUHu
         aYzLA4dRv2QuUBORuoNtJD3M4Eeyqyecl4YfzpsY0NRBUM/QuhMMcGyWZY6zTksc95vn
         PIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768301974; x=1768906774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/DtPGFQHFju1IO/Degf1/ys2a0tv707U6qKEmBe4+A8=;
        b=WsAsKFuF43iCjMgg2Va3neNYNw9MNgjnNw/sfQ6ewvFIrqsONJGVYqMYKCxPrf8gb6
         6gLJhRGy5PG10v315mbI7lMxNo64xrued7I1NeqOpqkhzVJGNwIR27GyO4tn2LXoxwyL
         tOrAHr6vuZ+eHcKB2JnFOJDT3ClXqskswL/pL0laD5ks//2IUpElv42KZG3Aq5BRCkMb
         lghdEP3shHq20ERrE9wPAXQ0knd1XrPkBXb9XZdRkvKLPmKc93F6h41d0jsseMKQT4uL
         i/8jDPdjbzSUcncd+5SCNh7h3S4NDPHFYXkWiSF35P6EKcp+ON9dTWiJTgTX0Y48j3O4
         ++hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLRAR1WQQjHIGUg8zqrgpEjZkzIj6BEoAA3Z9JfSu/yc3PKB4jwGj8QXpbVvtRzcz4jfwG1yu+zg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc/I050XtX8pANpzXHjL380pSHkvFkdA6ppjreXTZP5VdTRPX/
	JQQnImLE1Vvg5/3WFedQ3pK01jjFpY8DWXEUgO6RU/W56H0AE6gsqnvplyzbdQ==
X-Gm-Gg: AY/fxX6y0KuB/vey9CisjD25PRGeeErREKK8c7cs5UTIiIDykQPqMlp6vTnGCV8fYqY
	TmLBN2Gk3lKHPjD4OEMakcQOG/3VRrCaXZSkNeEItgUAwX36qNmVTzy70/CCJ66/zxGUVeUSY/y
	jf86I40dhxZDhYzzWbPGGMB7AmRMnE2jDtcM48vGao3JfGk3y5ewNn4u9K3IL+Ft0gnrjOpQ1iL
	e4PksKA8p/nRGqbECGUSEc+YmWPsj5QvCMDCdfBCXXtS8DtWMU/0LhbJXmi16Z5+ehDvzaObEt6
	OWqaZBTs3r2JGNYAc32vdT960KCpwu5fsSo4TqfXDchVVLI44QA5zQqtyVQ5exJq2DpdjAfA3Hk
	31e5ew4PW8+RY7ggrExFaNHyCu7MLzi2SuTzZQ3kmcQj5m5C5S4cEDSGTenxN5pfR0sTrQIZVW5
	s773mQnqezIO7+VppCvVrJ3LRHhn4TVEATtW6jm56piwyofMkXvymRm94YmafbUe1D2JWgEfW4W
	gxjsHY+4J8lqcrCEx0mJA==
X-Google-Smtp-Source: AGHT+IGN7YtptJAvyBxGsryFp/ZVQ3AtqkPm+d6Uo/gUGIm0zr03kGaJ57Syx71qzIqCdd6goycVuA==
X-Received: by 2002:a17:90b:4b0b:b0:330:6d5e:f174 with SMTP id 98e67ed59e1d1-34f68d0bc5fmr21176395a91.20.1768296400127;
        Tue, 13 Jan 2026 01:26:40 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8b0f67sm19483200a91.15.2026.01.13.01.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:26:39 -0800 (PST)
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
Subject: [PATCH v4 4/6] dt-bindings: power: supply: google,goldfish-battery: Convert to DT schema
Date: Tue, 13 Jan 2026 09:26:00 +0000
Message-ID: <20260113092602.3197681-5-visitorckw@gmail.com>
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

Convert the Android Goldfish Battery binding to DT schema format.
Move the file to the power/supply directory to match the subsystem.
Update the example node name to 'battery' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
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


