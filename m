Return-Path: <linux-pm+bounces-18816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2219E923F
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 12:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D898162463
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 11:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A634121D011;
	Mon,  9 Dec 2024 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQaEQ5E/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9957E21CFE3;
	Mon,  9 Dec 2024 11:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743767; cv=none; b=isSOH6yPbSK0Ppe8aNpxiSXaMZo/nvM7cyZbi/LfAyrz/eCEN2AYud1hLb0xeSrBdtzW/NE7S+BtFp3clR0aTzDiVyQKtDBQV/y2tbguPOYI/2n5KqIEykcJWUfs6If+Da4Y9DOoGhfY7mLSVDhSCxsTih9Wms19eLI+IxybkSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743767; c=relaxed/simple;
	bh=yJnAUnOBisZ3dhz3HnsbKm2/RZKkA9XAwjdJuK7c2Mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qwtKRrGJZcwjwC04YsDRUA1oWYWWxllVnkpgTcWYqidPBl4z+AE+rG/aVOPc9ploGptwkBmVr+evK46bQsXnnQQa38Ru0CiaeS4f0N16KHVJ23PlATD51sWlkD7BplKtp8/V5WiyFdRQcUEYG/ne3fSKkHcb8NEsleQHrsuUKCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQaEQ5E/; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so684806466b.1;
        Mon, 09 Dec 2024 03:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733743764; x=1734348564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXzm1cjWJaSGl7IBhydp6k3erZJuc8jy+xEzIOAkkH4=;
        b=YQaEQ5E/ujb48MkBDV/u+CEhL8WNZPHPreiTTD6Aei81eCWNR6x2/pm7x8WP8XdLKo
         mrHjLEeyNrI77DauIk0Ok3klfZ0i9DyYedUZl+UFhy5MAU16qOmiiGaORHKubOEiRE0+
         tCejGuWMBTArR9yBBYAcpbuh0JkPDId4c3huIHHM7kdX1flmEHnTCjSCGI8QrlOC4PBa
         DqEczRhftlJECCsnkphhbtVklM6FiWBj4WQuqP4a7ONRwxH0OUjDL9qi5sxbf1Gvzvuf
         MCN0oMNvwewiQDGzusyXKEM0GfxppOvXP5+RqZq9uHI7erkEyABZbzUmN2+YHAE7O9F5
         3DjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733743764; x=1734348564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXzm1cjWJaSGl7IBhydp6k3erZJuc8jy+xEzIOAkkH4=;
        b=V0nL7sXr8jtyeQA7Ppys1hU/uhucUILIyC98krxZL9qOmjhQJztxphtKJv29TistxO
         0LBs2gmNJztC6OHnZs67tPyvdE2OFZk7kTfvSY8ac/g7z4FnfU+cUrQf6PWLh3NGiF7u
         EScziuSM4ktCfoeffnG+R3PLIJ5t3Yqokk8aO4gdpKL1mkEl4IzQlFQA/xY61tfXJcNs
         Nzj7FkXcg8sbXlrAc2U68c6gD3jjZeTHWTxhxOJJ98OqDsXfK+FWJVue7Sux/aVXgrhl
         WrgOlXy0WNEXGgbeZzSwLdizui0nmjbSv1PI5QlcDq32Lsq9alBDTVv4kIpXgnWCXpKI
         LqRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+ioE68VxYWB4cA0b0mDtckUuMPKcoU82IamWPirf0K9gWe4gvzawUUwcoDpiqVMu7k42pXhQl8JSm4Q==@vger.kernel.org, AJvYcCWcmTHCEagBHay5Tnm1G3YcyNzQR6MdkDUDSAvby9ynu9GtcWUlEbD0LRtFmDkJc/Qf+si7mh5+6kww@vger.kernel.org, AJvYcCWgjwhSXrOeXHPXlEWaYuXaqtAAnmOv0KxHqKMH3hrLmA7c6ffCJaAbjVmCVNV+fW4O27andV5w9s9u2d0=@vger.kernel.org, AJvYcCXNLDf/qm697k8rUzSMN1UJLQWdSBjgupv7PcdkUOJo+KaqKyHMbp9xlaBTV0CfCbwQ9rLJWT90YGLKUhLq@vger.kernel.org
X-Gm-Message-State: AOJu0YycfNuw0B7cmCY1eKosP7v3033c2LWfku+Fitl0DHzkDAR9fUrt
	AGVQBIJanJJhhNlt0Zw4EDR1xVXwMAZ+UBvTHIvzPuSnGqKU/8xw
X-Gm-Gg: ASbGncvojhH6RBiFPGrE0A5bpDOmnjG/jCe9KINGIVi/04eTF/OUD3uHRe+iPRh2fxJ
	BVX62iXzSr7t/Cnlq0ADCbC5vEe8rdW7P/GFIXhcu833YZoda5hVTJwuAicYW4ceo/FCtGELoGF
	OlDyS69BZtCBgGuJpfV3a9JgZp9tsQj5SbHe5Kq8zMA8o6eujpyGcJ9bcBwE7P5rcsGLfFuf6Bf
	bn/rQb3WBhoHYpZ1VAVKDYbHY56121qwjZZZM9EzLntJbp0
X-Google-Smtp-Source: AGHT+IFIVAHf1m/IHG+sqVnl4++noMovd2qOxnl5VkzWewM/f+8vOhFT49UajQMFDxAaTO4bUgfyIQ==
X-Received: by 2002:a05:6402:541a:b0:5d0:c7a7:ac13 with SMTP id 4fb4d7f45d1cf-5d418604dbbmr418021a12.34.1733743763722;
        Mon, 09 Dec 2024 03:29:23 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d14b608faesm5980350a12.44.2024.12.09.03.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:29:22 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 09 Dec 2024 14:26:27 +0300
Subject: [PATCH v11 3/9] dt-bindings: power: supply: max17042: split on 2
 files
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-starqltechn_integration_upstream-v11-3-dc0598828e01@gmail.com>
References: <20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com>
In-Reply-To: <20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733743755; l=5484;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=yJnAUnOBisZ3dhz3HnsbKm2/RZKkA9XAwjdJuK7c2Mc=;
 b=r1Onup4zVHBfmvpzuY/NZ5gfdH7I4VJyKGDYKGrdG1RPJBJBb6XvNBhpu6jfih9rk/6WIW/an
 TnJvBFqAxNhCt55v5So7Ct7zVz3YFNGiSHYdJtMafMLMGmK9XircOdr
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Move max17042 common binding part to separate file, to
reuse it for MFDs with platform driver version.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 Documentation/devicetree/bindings/power/supply/maxim,max17042-base.yaml | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml      | 49 +------------------------------------------------
 MAINTAINERS                                                             |  2 +-
 3 files changed, 68 insertions(+), 49 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042-base.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042-base.yaml
new file mode 100644
index 000000000000..1653f8ae11f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042-base.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/maxim,max17042-base.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim 17042 fuel gauge series
+
+maintainers:
+  - Sebastian Reichel <sre@kernel.org>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    enum:
+      - maxim,max17042
+      - maxim,max17047
+      - maxim,max17050
+      - maxim,max17055
+      - maxim,max77705-battery
+      - maxim,max77849-battery
+
+  interrupts:
+    maxItems: 1
+    description: |
+      The ALRT pin, an open-drain interrupt.
+
+  maxim,rsns-microohm:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Resistance of rsns resistor in micro Ohms (datasheet-recommended value is 10000).
+      Defining this property enables current-sense functionality.
+
+  maxim,cold-temp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Temperature threshold to report battery as cold (in tenths of degree Celsius).
+      Default is not to report cold events.
+
+  maxim,over-heat-temp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Temperature threshold to report battery as over heated (in tenths of degree Celsius).
+      Default is not to report over heating events.
+
+  maxim,dead-volt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Voltage threshold to report battery as dead (in mV).
+      Default is not to report dead battery events.
+
+  maxim,over-volt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Voltage threshold to report battery as over voltage (in mV).
+      Default is not to report over-voltage events.
+
+  power-supplies: true
+
+required:
+  - compatible
+
+additionalProperties: false
+
diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
index 14242de7fc08..b7fd714cc72e 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
@@ -10,60 +10,13 @@ maintainers:
   - Sebastian Reichel <sre@kernel.org>
 
 allOf:
-  - $ref: power-supply.yaml#
+  - $ref: maxim,max17042-base.yaml#
 
 properties:
-  compatible:
-    enum:
-      - maxim,max17042
-      - maxim,max17047
-      - maxim,max17050
-      - maxim,max17055
-      - maxim,max77705-battery
-      - maxim,max77849-battery
-
   reg:
     maxItems: 1
 
-  interrupts:
-    maxItems: 1
-    description: |
-      The ALRT pin, an open-drain interrupt.
-
-  maxim,rsns-microohm:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      Resistance of rsns resistor in micro Ohms (datasheet-recommended value is 10000).
-      Defining this property enables current-sense functionality.
-
-  maxim,cold-temp:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      Temperature threshold to report battery as cold (in tenths of degree Celsius).
-      Default is not to report cold events.
-
-  maxim,over-heat-temp:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      Temperature threshold to report battery as over heated (in tenths of degree Celsius).
-      Default is not to report over heating events.
-
-  maxim,dead-volt:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      Voltage threshold to report battery as dead (in mV).
-      Default is not to report dead battery events.
-
-  maxim,over-volt:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      Voltage threshold to report battery as over voltage (in mV).
-      Default is not to report over-voltage events.
-
-  power-supplies: true
-
 required:
-  - compatible
   - reg
 
 additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index 7700208f6ccf..cd5532afbfe4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14157,7 +14157,7 @@ R:	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
 R:	Purism Kernel Team <kernel@puri.sm>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+F:	Documentation/devicetree/bindings/power/supply/maxim,max17042*.yaml
 F:	drivers/power/supply/max17042_battery.c
 
 MAXIM MAX20086 CAMERA POWER PROTECTOR DRIVER

-- 
2.39.5


