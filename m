Return-Path: <linux-pm+bounces-9237-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05299099DD
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 22:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB13282255
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 20:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E891161FD4;
	Sat, 15 Jun 2024 20:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qz0fCr7q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C334964C;
	Sat, 15 Jun 2024 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718483156; cv=none; b=sDdxNHOu13DTnLspORcSpmHumE7XBcSCBcDbKKQJyLqOlEkDW+RBzPmDZF3R2OsntsKA+r7IFq+KC801QieuzK8k0uThQMU6/HtXMQmeRz63mAH0/wQL5AC0tzvtOg/26lETvE6YOs3sE6lw3A/FBp/TSIy79EUkmpIkxcZPAF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718483156; c=relaxed/simple;
	bh=+ZCC1LjssyKOXgoyALPO/y5fpHApzr2s/7Sn8j4wp9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rRsbajNo9ieSfWVAeLBbVks99eJg0PRR1XwKww1CCkvW5uiWgTIQV15AEDVOReYxb8yNHVrFxOydvxeeO/asMZq4KybIk1oadjvxHKZtOuFy2IaxmJc51nQtMUtrqIwBiz2py/mmjXET4A0tUFWZsCpx1+drVz1OgTTwXUtDrxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qz0fCr7q; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4217a96de38so24539635e9.1;
        Sat, 15 Jun 2024 13:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718483153; x=1719087953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEsbeDNGK/vB8KJ4o8p9x15wpBpC+5Utf0VzUSNFjJE=;
        b=Qz0fCr7qJ/zWCzQflHJxb8mEZmlb8lHeYLf89z6ppR/ETvd4v7Bi0GNz/vGEmaijC1
         Zva9A1dytN8lZi0Ooi08Hc+FNHObtsmL9fa7Ujw7XaVq9vdELsH91jsdOEOKuom+2mwX
         7Jw+95o3CqBnt99aWewnUUC9UzNl6LXhbw2If/XnYS1Ghzi4qWKWU0Rkd3juOkFapMIJ
         gaju2za1uLu3T2saG7lBhthq6OrhNL1RoR1gLXKX20/ZXw6s+X7rbMasGBqvd0fgKkPo
         Hy1eWgH2NxSQFP0CUPwvecpyfzxZ3f20+Mx7/XVnIo8ZgSTsNO0vaq0koWbO841sITbk
         U+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718483153; x=1719087953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEsbeDNGK/vB8KJ4o8p9x15wpBpC+5Utf0VzUSNFjJE=;
        b=AtbP/xr2ctjAdT2WHxq6aR2PP2h3OvrkAnUMj9aHYGFKBNY5s3C+ECO7PrlR9QSesv
         WQrVuW2/iCqJfplbFjwy0lVEVkgYtjG4bna0XHftW+27GDfB0dS5mdbvuo0Xyn4jgPM6
         +SlsBoC62kHbYQOgEy4xm5ZCgPhnju7qZDW/HayHDimHGJkv6lnov9u7xxLrCOBbpJvk
         3u7mC8awzltYKoztFx6RRfk7oisxnjuhm5y+r3PpLdgfByEVe896Bg4w71D+eKZO1Cyg
         Dtl1ci1NpKtvetuW5w81pgu4QC2KRJNLUBGnBtM4+IrTHvj9d48Lci9F+DbqQh/jPs14
         VL1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9h+LjtcJ4jFXxvwfe//1RKxXkK+aUS7LsQPXVI21ehshmTDTo0ztV0KLkJ6j/VKm3s/rX+yayq+N3UOcYhBwRq5IJif9dnIzOgFUCHwgqyTjte70GOrCk7+oPJ8SFdllp3QqEDy77I7JPfYktq2mQ5qC931/pmxxalyETTALlyejx
X-Gm-Message-State: AOJu0YwItsmpaqu+W92CLMhXhAXv3HV2Tw8p1X68iX3oaDmSbubl3ueZ
	MSSpRjJmGpE8j2tGpyml52o4E4s6qoPdvjpphldEdWBrcU2Oncoa
X-Google-Smtp-Source: AGHT+IFFV84CrojRj0kGaQi5CCMYgYtaeB+YH1tnpCF3ncJkMa4FkbRlgoS80C1a9ntr0J4wWDGd9w==
X-Received: by 2002:a05:600c:982:b0:422:6993:57d2 with SMTP id 5b1f17b1804b1-42304824993mr40487705e9.18.1718483153490;
        Sat, 15 Jun 2024 13:25:53 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42306049f1asm70289275e9.22.2024.06.15.13.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 13:25:52 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: power: supply: add support for MAX17201/MAX17205 fuel gauge
Date: Sat, 15 Jun 2024 22:25:24 +0200
Message-Id: <20240615202527.163641-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240615202527.163641-1-dima.fedrau@gmail.com>
References: <20240615202527.163641-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding documentation for MAXIMs MAX17201/MAX17205 fuel gauge.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 .../bindings/power/supply/maxim,max1720x.yaml | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml
new file mode 100644
index 000000000000..4414bc6f214f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max1720x.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/maxim,max1720x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX1720x fuel gauge
+
+maintainers:
+  - Dimitri Fedrau <dima.fedrau@gmail.com>
+
+properties:
+  compatible:
+    const: maxim,max1720x
+
+  reg:
+    items:
+      - description: ModelGauge m5 registers
+      - description: Nonvolatile registers
+
+  reg-names:
+    items:
+      - const: m5
+      - const: nvmem
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      max17201@36 {
+        compatible = "maxim,max1720x";
+        reg = <0x36>, <0xb>;
+        reg-names = "m5", "nvmem";
+        interrupt-parent = <&gpio0>;
+        interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
+        status = "okay";
+      };
+    };
-- 
2.39.2


