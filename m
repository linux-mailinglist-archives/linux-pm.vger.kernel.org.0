Return-Path: <linux-pm+bounces-27608-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D343AC29C6
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 20:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B873BA2C9
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 18:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF0929B8FD;
	Fri, 23 May 2025 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FC3+3duZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3450929B235;
	Fri, 23 May 2025 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748025018; cv=none; b=tN6xM2izZ3BGiwhkXZ/Dh7xCTtsanLgLtXRArCptoRKcKbPrd5XigeWZvt/l3442KWSTIc/QWQwiM3leLCT7yNCUS3s5KjQ6tdwg2bchtR1zTHPnj4utgQF6ExjCQV7ZDKVt8snnQaDIPLcIxA5Bn7pTPRYdNkf5G7isEyR0Qag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748025018; c=relaxed/simple;
	bh=FLtBxNr1ox9ojf6yRUY/yBsCghOboZfJHHj47uEu/Do=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8cSUFKzwMUxtiyJXzvGd0rMCb8I4E3yfhPSn2WhgaEBR413nYlRf/GvBrc48lWaR3xGMsS8w0FGgJVexu7+AvyZpd3qKiIQz3qz3eEDLZjhP/lEA6Ay8d9TaoT1ndoEIu7+mHpV8Fv3EwZOQwC9n8tDb/2z5i127CU3je/Cb3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FC3+3duZ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a35c894313so155698f8f.2;
        Fri, 23 May 2025 11:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748025014; x=1748629814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=13JzDFAxV0mwWFnjAkxRyMC1mXnhBx1PDwFdeu7Nt1E=;
        b=FC3+3duZE/9Ljy5SyCMzO6VRf12obnJ6F/3GIKwd+5wx0Uj/kgTtoUZX1AsB0GnyLo
         paoVWcIKeDfsPnmzEWieJmy8UYbSGc5O2XEAZ+ZFllgUgHSkaVUOWf+3ogZ944rzZteL
         kkpXqr84gmhDJvcjoSUCQMRrUYGFfMBVWAc9dPqsc7e+xiw51MmN7ivQ24GOaVMHt+5s
         f2sJQkpeJXCwQ3Hj8lBlhoUU5hDRLVns3krftbqZR9dQh9gQUhKtYRlGVp53kBv4bKtu
         fbdyZPdZBIpwNjvHvJP1hUVBLVf5r9GdG5I7w66s8xqjSjG1S80nQzCvcbvN8GBiphSE
         4B4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748025014; x=1748629814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13JzDFAxV0mwWFnjAkxRyMC1mXnhBx1PDwFdeu7Nt1E=;
        b=w5VokZZcOJ9LzTyAyQ9pFivfBJpLQ6okwn37GK/L3WCdPUuIdp5lk/46bW5GkVaBNy
         Z0TtY1K0aERsGoryexxO3RKlOA4+mwQ8u/We5sMjhkJacMv0THrPEYnai0QEjQyyMbaO
         roSRWTJwdNyLS5UgNjLXmrgENTvwtynnuANAXvP4p1lqtBIcTnZo8PNfG+D/hlxlPLMo
         NOdOXq1Y9sQ54zqZjHAJxSa0Ote9QOiy+oR2bJ+Z7nLomvGEGqv7/AexMCoY/DmIFlXU
         LTe0fK8dCgkpqcbp6UhLhXgvHbFcPVHniGAObMT8uVI4p1OZWv04mrGtxoWpJH4ifjEd
         Hk0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDQTNCC8tGMJhvIr1HVYkru6g4Qn6pOCFk14TNCR7NenwmIx/gjSzSpbyInBz5BvMDk+q1ZTFYRyg=@vger.kernel.org, AJvYcCUGQgen3aetFpf+JRXM7p9xtIAevA6p04WstpHkApg0oyqpL7DIiSdiOo/VO+ANOAPB08Upy5dW2dghuXaA@vger.kernel.org, AJvYcCVc9HbYtavSE04n5WMwJDR1Dp3cHisAmzgb9f6xrq79Sb3UrQJcTNWIBfWTebY/6+qUNxzFo+ChhtbK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0y5MSzGREdaF/Sa01FwLJmP6t+RpKDctOohtX4ZhBsite+V8I
	QlojECdXd7TKT1jFFuQ68V0xT/oUdzoIqmiM0NCwCkB4KqNK4tahQ+K6
X-Gm-Gg: ASbGncvX62gicT1DGbOQ53oHqGXQz4BYIlK1x2qbTxlXjVea3k+6HZUJEz0FQMf2z9A
	/mEWFMEjAnVAD1cvko6tf1s18CDH732m9xOoFFkxT2ggv6HlV4SvqYGqo/wxPqCkRWoys5IJD8K
	rYSrhTZl5Ob5Gl9oxgcLaOrTomuJ+0tzynM+1wXJpybg9sCAi1Dd81y9NU+O438MmG9mxyYVO1m
	l1dnGPU/9k1FklIKju64Zlna7eAEClVxMfx5CL6A4bAtP7xSDzHbmoj70r0H9MCkWM5XE56lwb1
	UhYjzam8WgV5Jzc+T2sgPpU63eGuz4XKvuZP78o1B922SK7GqtbdSGkZiMTx2R7NnEuBJ3T5Ih8
	ltQtWPKE2dKvfYzkuAGnj
X-Google-Smtp-Source: AGHT+IHcq5HBYMJjQGd2qkJkDWuaQYDC+rdEmaeEEgHWkBX8Y7pnBfoUlPsXAfPOJ4M0zrmqawdjlw==
X-Received: by 2002:a05:6000:4282:b0:3a0:b4a7:6e56 with SMTP id ffacd0b85a97d-3a4cb4c59b7mr341434f8f.56.1748025014331;
        Fri, 23 May 2025 11:30:14 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d2d1sm28180695f8f.19.2025.05.23.11.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 11:30:14 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] dt-bindings: thermal: airoha: Rename and Document AN7583 support
Date: Fri, 23 May 2025 20:29:32 +0200
Message-ID: <20250523182939.30489-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250523182939.30489-1-ansuelsmth@gmail.com>
References: <20250523182939.30489-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename .yaml to a more generic airoha-thermal and Document support for
Airoha AN7583 thermal driver.

Airoha AN7583 follow the same logic of Airoha EN7581 to read the
temperature but lack all the support for the PTP_THERMAL used to monitor
and react when trip point are triggered.

Also the Airoha AN7583 lives entirely under the Chip SCU SoC register
space.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 ...n7581-thermal.yaml => airoha-thermal.yaml} | 42 ++++++++++++++++---
 1 file changed, 36 insertions(+), 6 deletions(-)
 rename Documentation/devicetree/bindings/thermal/{airoha,en7581-thermal.yaml => airoha-thermal.yaml} (52%)

diff --git a/Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml b/Documentation/devicetree/bindings/thermal/airoha-thermal.yaml
similarity index 52%
rename from Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml
rename to Documentation/devicetree/bindings/thermal/airoha-thermal.yaml
index ca0242ef0378..42f93b095783 100644
--- a/Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/airoha-thermal.yaml
@@ -1,17 +1,19 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/thermal/airoha,en7581-thermal.yaml#
+$id: http://devicetree.org/schemas/thermal/airoha-thermal.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Airoha EN7581 Thermal Sensor and Monitor
+title: Airoha Thermal Sensor and Monitor
 
 maintainers:
   - Christian Marangi <ansuelsmth@gmail.com>
 
 properties:
   compatible:
-    const: airoha,en7581-thermal
+    enum:
+      - airoha,en7581-thermal
+      - airoha,an7583-thermal
 
   reg:
     maxItems: 1
@@ -28,9 +30,30 @@ properties:
 
 required:
   - compatible
-  - reg
-  - interrupts
-  - airoha,chip-scu
+  - '#thermal-sensor-cells'
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: airoha,en7581-thermal
+    then:
+      required:
+        - reg
+        - interrupts
+        - airoha,chip-scu
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: airoha,an7583-thermal
+    then:
+      properties:
+        reg: false
+        interrupts: false
+        airoha,chip-scu: false
 
 additionalProperties: false
 
@@ -46,3 +69,10 @@ examples:
 
         #thermal-sensor-cells = <0>;
     };
+
+  - |
+    thermal-sensor {
+        compatible = "airoha,an7583-thermal";
+
+        #thermal-sensor-cells = <0>;
+    };
-- 
2.48.1


