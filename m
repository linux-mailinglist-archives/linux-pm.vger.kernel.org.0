Return-Path: <linux-pm+bounces-40860-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BC9D1F5CB
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 15:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F33B30605A6
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 14:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4E135E551;
	Wed, 14 Jan 2026 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZtTTkase"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70419322C6D
	for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400238; cv=none; b=KBz1VAcPeTrlE0wrvf36cNj5ch2D8KOvLvmypaSl87CuW1kE0lJmPdseJ04RKk0HrbNU+3eoJ/a48A2sisfbccZuUxUb/B4JCkFHPE0Gw3NFV6QMfQGc2QxT8a40PO/7lyxd3N0lwNCTkU8rJBl+KgSL2zBqCdoj7z2ZMmGJnZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400238; c=relaxed/simple;
	bh=8UojV7uTS3mheivu+7sw0eF9oi43bOc4wBfGZPuFRE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RWSb8ijMMw9SuqZ+no8rk+cqyLDg1NemEYj2c36U+jjdhJs/r7AkdMPJ9HoJ5Zgd+84ZYC/rj3U9exKutNHKcy/2RQ03J/xxDgW4k9D5YGVfpZp89E8WZD3IkdGoO6ipMY1h+pK1+TSw8TSGlZmguCd3KBElsFe4jSLlRCODBII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZtTTkase; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47d493a9b96so50290685e9.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 06:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768400235; x=1769005035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8IE45J8JgDPeyrAViCtUZj6ANewtTif+SN8oHgJqm5M=;
        b=ZtTTkaseGF19K834bA9MikuJmnfqLf6kXP3mVI8ToVxvAQSAvgXPQBdt/GnDtnh6QB
         WuOaGdJ46qgl1KThc/NddU3VTFW9/IrYShV5uH/UVemzft6Ad/VNCEFwMJoQ/D9wOrQS
         qLi5Aggvxm6CJzNW1ZNKr8KrWNlKO9xjBZnHUcFYHlLFs2/zi0nfO3+okyCarBghbnGJ
         yBt4LntmOjNgr4wkpFUJWtTB6gcoBjVOZSUmTcutGH/It5VjjXNp56MhBQV7cGAZudju
         DAem5jicips8WpHG+nCblw9+SwHJhyPsXckoeZ8+EUkuIGarniY6QWLQYSIM/hmFshs2
         fTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768400235; x=1769005035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8IE45J8JgDPeyrAViCtUZj6ANewtTif+SN8oHgJqm5M=;
        b=odpDTR1pNlEysvLPZD9fjvHT6Y1cPciro4vmSy515QooVFadQi14bf0LlD4BTWVx9h
         k5pbb53b8LloWZzMojKF8XfBHPhrFhBlBQ6UJABDwf2cKtsrfwUWiuEHb7BvO3E6oRPm
         QhXcGvIyxiaxMVABwQb9ARkUiYQ6mQP6MBYuSxV7BfKE+pF5CmPdhY8IXaJd1l//1GrG
         0I2H5Conn7GbrXoAqGzuEbY5THTow9jkTPWXFAKdabIUBavGawWMPZDx7MSAy5+GuDOl
         rag3X6kY0r/0HpfLIfoh68evBBGAOTmGPhN+ODPNDw0/5qs3t1gOiPx+F0FXR/JMrFsV
         qHJw==
X-Forwarded-Encrypted: i=1; AJvYcCWq2MISizK5Uyqz8zmnykSGphPayDgVHDagklb/chEpq3QZpkWBKp5/K47QgF9/+0MQh7wlGQCmuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzI0jzQwOzPdtXrv/nvfABOLTKUaJY/Z2AXitDrS+yK5IcuNUun
	17WywsGUX0bjUYIa/v3+ebGBTfZSxYQn3VWNGRu8F1y1FhjTfOhEKYScd6cht942jJY=
X-Gm-Gg: AY/fxX70Qwlc6lGpNtt8r/CQvMf5B25uiPA3R/Rgj6el0XG4Zb7ejUWwETP6WYkIpSU
	1BJyvd0EjSzFCovMWL5Jh3QCwYVhfM4OZIZCoN/HnD7NOygvBbG2D0iBSMZXj/EQjl3HTE6YHyQ
	ckYpK9cTbAOyKBE9sEkNoUc2DutkOS2iPr4day1accrh0bQngD7EoPD+EZsv3e+WFjdxBzg5FDZ
	xZmiyOKISecQJ722dhGSH9uC3qbtl70QRaBVuXCuOGh3BF/k75xtdZYQ1N+6At4R6zsjjtEf7UW
	IB66/1pEQ50GLzGafTIhMePZ0QvNiXIv3YUaR/aaPY9jqTrEsHsG0NuM2eb9BaLEy4Am5KXH2BY
	PU6+o0ZAEPJIKSynEI7cYb2llLXIhJL58zu0+oWKQrB5uD9EAXHbMqSx8Mf7awgEaqJXVjyGY6g
	y2ggMp6pa2g/apalYSGu0j051xdprNrWxAnlJnL9VxDHpT6iswVIZjmjFlUBKHpFv8NPDLBV5Oj
	Zih8Oxj
X-Received: by 2002:a05:600c:870b:b0:471:9da:5232 with SMTP id 5b1f17b1804b1-47ee3349d27mr34820035e9.15.1768400234736;
        Wed, 14 Jan 2026 06:17:14 -0800 (PST)
Received: from ta2.c.googlers.com (164.102.240.35.bc.googleusercontent.com. [35.240.102.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee57a2613sm29595445e9.6.2026.01.14.06.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:17:08 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 14 Jan 2026 14:16:31 +0000
Subject: [PATCH 3/8] dt-bindings: mfd: Add Google GS101 TMU Syscon
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-acpm-tmu-v1-3-cfe56d93e90f@linaro.org>
References: <20260114-acpm-tmu-v1-0-cfe56d93e90f@linaro.org>
In-Reply-To: <20260114-acpm-tmu-v1-0-cfe56d93e90f@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768400224; l=1858;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=8UojV7uTS3mheivu+7sw0eF9oi43bOc4wBfGZPuFRE4=;
 b=L7ka53Pavk7o7iv9buy1Uk9Hui9JJggaZxvrQ3ziB2ZiI1QLIDOWA/yKh7O8c0KHhKHL9SBVE
 ZcmvuXqrAbVA3WmMGUQlhnK9rs6sZ/WjzLR5VHO/HfFM7tqZ8VIaPf2
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Document the bindings for the Thermal Management Unit (TMU) System
Controller found on Google GS101 SoCs.

This memory-mapped block exposes the registers required for reading
thermal interrupt status bits. It functions as a syscon provider,
allowing the main thermal driver to access these registers while
the firmware manages the core thermal logic.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 .../bindings/mfd/google,gs101-tmu-syscon.yaml      | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/google,gs101-tmu-syscon.yaml b/Documentation/devicetree/bindings/mfd/google,gs101-tmu-syscon.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..6a11e43abeaa23ee473be2153478436856277714
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/google,gs101-tmu-syscon.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/google,gs101-tmu-syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google GS101 TMU System Controller
+
+maintainers:
+  - Tudor Ambarus <tudor.ambarus@linaro.org>
+
+description: |
+  The TMU System Controller provides a memory-mapped interface for
+  accessing the interrupt status registers of the Thermal Management
+  Unit. It is used as a syscon provider for the main TMU driver.
+
+properties:
+  compatible:
+    items:
+      - const: google,gs101-tmu-syscon
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@100a0000 {
+        compatible = "google,gs101-tmu-syscon", "syscon";
+        reg = <0x100a0000 0x800>;
+    };

-- 
2.52.0.457.g6b5491de43-goog


