Return-Path: <linux-pm+bounces-9239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA089099E2
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 22:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19041F21958
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 20:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EC161FFF;
	Sat, 15 Jun 2024 20:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFbFaq0U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7D661FDA;
	Sat, 15 Jun 2024 20:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718483652; cv=none; b=HIHdzTt+IFMueAsFhMi5FzQI0sz4HnxcTChAaeOUdAn33WseoFJr32NaRyKwJf4RUGy8sO+TA3d9xjHvVy/9VQsFIGb8sg81ecR8eXe1P3i3QIvWax96JDD0wf2kmZ8wocF8IBi2O01andM3vzUpeLmHbHVjH8FK+ibjnC32O5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718483652; c=relaxed/simple;
	bh=+ZCC1LjssyKOXgoyALPO/y5fpHApzr2s/7Sn8j4wp9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YtJqjIblN8i3z71x8MBZo+VaYTVK9T+KPOZVGdUjqhTHMrKNpAXlQmRW6mI/UQSBc0Bhm3LQfSyHHs8+Uh+ovNjaLXf5XKKugq53fR2rtTkXPgYrQ0sBPDaUd2ZKl2PYSLZGSG5Cl39rBjzdoJwI3ZkoXsYcJStsegeR01bbrAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFbFaq0U; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35f2c9e23d3so2834599f8f.0;
        Sat, 15 Jun 2024 13:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718483649; x=1719088449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEsbeDNGK/vB8KJ4o8p9x15wpBpC+5Utf0VzUSNFjJE=;
        b=AFbFaq0UkAcXfDS3mEfyQcpYDK5prEo4kHmDnf5e8tPQ6yP7N6L+KIt07iVY0zldfM
         eSon3jsw1M8HigzrCHaclOMMJPX/9LEmGrzsUTv5RI+pWvN6a5CvoBvMtKwYQu+L+Iwy
         +7ih8PAE65/04Hx90U8K1E0G6rPs2cOi9siOaWii/saXBUrqzpXyPeMhbU/G6kiQtgQ0
         N6KQwm80ZiYK9AGg0IDzHl9utM9z6aT6Oln8kAz5842V47l3egn9HnBOHE47Z2N8AxoA
         SANAe1FIfC9SMvBD7jZPcSB0ItCtf5AD564mOw8Rq7kmLB3Z7iMX5cUkIwi1ljdc3Dnf
         uNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718483649; x=1719088449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEsbeDNGK/vB8KJ4o8p9x15wpBpC+5Utf0VzUSNFjJE=;
        b=pwzEu7ADr31OE846dR7pAtSEdk2qFD+oQj+oZoBF5zAhq07CbSnPHzMpfhisuqBWHW
         GuQcFY3I1pnSc4WFH+8IRxrIS6JNF1vClbeVQZGQFCT2DETcYPuT2thdVhiwpGxUUucQ
         NtFn5maeioHc+Mh0a6mFmGUZ8TvTPiDsf+sNSV/QryTnNWMKrh9F5EzEBKwF+sdpjt4s
         acEfGcZCdojyQL1UlM6Y7wolXlDXVAcG6engr4qJW3mwb+keCSzSFI7//CFpKkfjt/r2
         uvcJdsGeVuJ6zSzyJlnFK2HYEHGjIWXVFRYtZATjwDcO/PRu9XGTQL0tW4E929UwzxVr
         On5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhmfBO3BZbz7Pfy5996190Tu1vpH9pKTPNC1QM74MxwrABDShCsRB3dGMDlq1ztMjmuGm0jb6ShU4A1eLGn2wvYE0fT1WeR0Sac79K/tQiIzzDLzf0Pan6klVYeyCo6QBTJfeVUDgPzFdcxmapI9SYxDLAKuRFX2WMen15jUGxEe2E
X-Gm-Message-State: AOJu0YzJNXLjqL6YWENV/xeCJ4vwMDPg3d3QNY6mf2x37B1SPKk61Y8i
	1KhG1BvSv2Zwgp9x920eFFGIcioWpOQsYtXHuojVqSgW9kYfy6oeFSXHYg==
X-Google-Smtp-Source: AGHT+IF1FUeCyX73SY1ytkcv+imuxlAEHb945JwQxCHNHmNQKto1WTOHOuI8Fl0siDy0+PPhv5F8sw==
X-Received: by 2002:adf:f705:0:b0:35f:32af:d79 with SMTP id ffacd0b85a97d-36071901363mr8026686f8f.27.1718483649414;
        Sat, 15 Jun 2024 13:34:09 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750935f8sm7973510f8f.11.2024.06.15.13.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 13:34:08 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: power: supply: add support for MAX17201/MAX17205 fuel gauge
Date: Sat, 15 Jun 2024 22:33:49 +0200
Message-Id: <20240615203352.164234-2-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240615203352.164234-1-dima.fedrau@gmail.com>
References: <20240615203352.164234-1-dima.fedrau@gmail.com>
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


