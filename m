Return-Path: <linux-pm+bounces-26358-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F009AA0307
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 08:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4CC1884113
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 06:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67D127A118;
	Tue, 29 Apr 2025 06:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqxbHjvy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26651D6AA;
	Tue, 29 Apr 2025 06:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907515; cv=none; b=V+zdviTNZwJwEVp51V4+eTjHgs3FDB+i8UGUSYmRaq7WBEyZ+C4uAg8ECrN5YU8kh2/rfUJ3NRhMJOjPwavxoEAJUVZV40lrJnaxsLof5FSxKD1kjwgzawwv6VjM+ids2AQIiLrFV9UfNMkTFiZhEhDpfzj4xI4Jv6h+LJKLCNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907515; c=relaxed/simple;
	bh=KaLGUSL2ns68bOn7jYHx1i7zaLbPTqrmuj3yr29wPu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2/JtEXtr4S0Ayfoyn6JylMrgJhjFB6wxIfDXPSQpqxVVBra9I7fKmNlt1uzgD0eTC1r1WJ8KGesZHKnWcznhFmoSFGSuC2ZFxIxi12nlv1wWhHTS2uh/KzgeWLEe8UtShfze0nIRDpC620Re4mieViz/eoV3FJnyZrRbBdVCis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqxbHjvy; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so10484578a12.0;
        Mon, 28 Apr 2025 23:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745907512; x=1746512312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0taj7EEi6YdEMdqw9Lh0RcEhtG1lBXd/l5Cnx6OcLo=;
        b=MqxbHjvypAPPVgfGdQmcCzb7xMz5MXhU1QoMgyXldxgiTgnnRJNyx44tCM7PMihG+i
         1O/jAKMzNigpELqO7oHPPvMew3NKHgjHhty7HNDBkdYpAP9yissKgvmndHg3USaYKP6r
         PnpMT7I2gDuuRzCiMSjYddQwVsVz36KOW9OQ5tJQElporKYLmkttKPv5b916S2gml+aK
         HY9Z0ZkTXiNIXXEW4rmLpIsADNT5DzZpxB3HbIK3t5XZOUJ0QnlmEhOioRP3SLL8btC/
         Yus/pnt/ML1kvZiVaRTgShikYxRMzeka2WVwDjCCR95sGE8VOaBpsi+Ac5Gj57ZAmbIX
         5qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745907512; x=1746512312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0taj7EEi6YdEMdqw9Lh0RcEhtG1lBXd/l5Cnx6OcLo=;
        b=qpu78dkeyarU23A63yB1rLHO0CqPiZe/3t5p0Rt+F8j5kCu3HouafNsiE7O3ie7JqW
         dTRZ821EGIKgCq221TqzMclyJksq5sw2qTZBLx07tMFKMTy6t+Hn9R8NjJAhk1nRSeFA
         KfTQDa7ZmfyEaXEDCKAipWQ3Wc1+547m154B4IuTwSEjpzef0x7lotNeQB6cBFJwadML
         c6E+JLrWvdOcfpIipvR3HGdtwVoaL+8EoAa3Ejqj/pOA/+qRAKyXVJlL0SOD6eoaQcl5
         puDRi8kPXAL4vtS0WPcPZFajXZIytaCLsVvYebh2nCkXZqT8D0nLBK79JQwA/jpUbPbQ
         T8RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPKvV3s4hDQjSfA2MLzPQJTf1fyhYd/+xwmAIkdIbG2SXsv4QEV7JtBd4kvaRy3YbJFHyMLYTO4ZD1hl1S@vger.kernel.org, AJvYcCUYmRKzG3TYTRcE93O72Tn0Q87chmqo0nJ+ymXJLr77JNPYQzXp8PwsAYS0WZcgvNG4NiWOVEqcE5ONtYs=@vger.kernel.org, AJvYcCWAX9ioBPJ/VNapIbnde5jnJlDL0gcwv6jKwCKupnRS4x1RHSPQ8SMUclPoFphzaYscAAe3w0u8TF1g@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7bxWHV57ApfN1XUpWGbloKNufzeQPXPq+b52/BG9Dkpj4du79
	JyeqvxghVf7IISwD9hzQ/B9he2/ibxmE6Hwrtor1XojczPcL9D13
X-Gm-Gg: ASbGncsTtX8w9tdwESgp9rxgWE6XZLjXQbvBKJ46ajWcRRKs8Ty0ZeWY8SP7O++EzVa
	QqrlGBNNO3AXPPz3SU+efXk+FOIs38EoQjtLaoJPCwuulAdR30RzK9cH+nXTaF4bDV4jySU/TxC
	+B50Jw/Dn61zOVDbQPfNBb4NqQkiHaJl+YycM0ZzQc5eb5i/ivzPKrK6ehl8WKUUVJQ698WBS5U
	+VgFYGUwC0rRQyOqhv/cn66DIxJ2cdsDudXeoUHIamxLipuKbrc8fwCWveFr6IcdlcX5HO3pRE0
	bzZSiNpsl0x97hHZXMnC8jgPM7+U5jJF
X-Google-Smtp-Source: AGHT+IHPA2VrWAZ8sp73pVGzCjpj3puac5pXYMO1Ns161pLMRthS8f7ErfcmAL6AcQ3F9jA4sYTssQ==
X-Received: by 2002:a05:6402:84d:b0:5f7:2852:2046 with SMTP id 4fb4d7f45d1cf-5f83884fa1bmr1874106a12.12.1745907512082;
        Mon, 28 Apr 2025 23:18:32 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7013ff9c5sm6996570a12.28.2025.04.28.23.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 23:18:31 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v3 2/4] dt-bindings: power: supply: Document Pegatron Chagall fuel gauge
Date: Tue, 29 Apr 2025 09:18:00 +0300
Message-ID: <20250429061803.9581-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429061803.9581-1-clamor95@gmail.com>
References: <20250429061803.9581-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding for Pegatron Chagall tablets battery monitor.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../power/supply/pegatron,chagall-ec.yaml     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/pegatron,chagall-ec.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/pegatron,chagall-ec.yaml b/Documentation/devicetree/bindings/power/supply/pegatron,chagall-ec.yaml
new file mode 100644
index 000000000000..defb0861e268
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/pegatron,chagall-ec.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/pegatron,chagall-ec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Pegatron Chagall EC
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description:
+  Pegatron Chagall EC is based on an 8-bit programmable microcontroller from
+  Infineon/Cypress Semiconductor, it communicates over I2C and is used in the
+  Pegatron Chagall tablet for fuel gauge and battery control functions.
+
+$ref: /schemas/power/supply/power-supply.yaml
+
+properties:
+  compatible:
+    const: pegatron,chagall-ec
+
+  reg:
+    maxItems: 1
+
+  monitored-battery: true
+  power-supplies: true
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        embedded-controller@10 {
+            compatible = "pegatron,chagall-ec";
+            reg = <0x10>;
+
+            monitored-battery = <&battery>;
+            power-supplies = <&mains>;
+        };
+    };
+...
-- 
2.48.1


