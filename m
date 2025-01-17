Return-Path: <linux-pm+bounces-20621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B624EA14FDE
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 14:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCEFA18833CA
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 13:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED92A1FF7C4;
	Fri, 17 Jan 2025 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUA4V6Qy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2647C1FF1AA;
	Fri, 17 Jan 2025 13:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118899; cv=none; b=AJ79bAZaPcwpSyZCrThWuM2SmP9Zrj+HOk05x3zvzWcIorErwYmZnmKZ9so3Kom40orzi+pY5Kw7afEVi8HGCJhQ5idgcZ9PzRbZsW6wAyTjNn4Flhxh+N/3LoTM082BNEhNmLV6+y5VsXVIHXJWn4ywmeMLYl9/L2P2oG20/Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118899; c=relaxed/simple;
	bh=ZWC4hTW8OX+rf9YyrITr/fbrivvcEKd/ZFRltutvR5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WX299Tkk5ugfQeNZ9JkglGmoBNdeLEAvvtcYBzuCPZxW+WaW7WYRP+z9Dwmj5Zu/h1cZB22748ukNc3ZoFJNKv1tLbpzprYkoNGftDLQXExROEOpfTEvgKSPSgJfVLARFuRCI7tw4/FnOP1+AcOhx0x4M06at/vXtN6T01UPcCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUA4V6Qy; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso402784166b.1;
        Fri, 17 Jan 2025 05:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737118896; x=1737723696; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXFt2Epd/aqgYjad/PpLtB0pMU+3tYAiirkAkrUh6A4=;
        b=NUA4V6Qysb9rjRXKIqOSNOJNy6gP3FbkjmqnDbyVLSocRRcpKQc8U1RbxOVXj2Qyuw
         tXUruoPbukP3WzhvoD1D2JRUmDfTBJxvOpHVbgha3KzU0yfurKH/aCY0xpRhzzjmcC/8
         fi5T3p86zdXvhI6UXf9GgCaQcfyot9+r0LdBdAz2+LSurB5TX0qUyOAxbBuXNYUIQOB4
         N3Vq9WAnftKPCq+lIVcA3AJk56KyiAPMCVLFjGpsJ01+GM5BlKWBQzOJldCRkWncb/Mr
         7QyiizrSerVP2/JkWvLiKqxNUsYcNgW03LnmctbpgdjCnlstP5zmDEEpjnalCN3vs+E2
         zv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737118896; x=1737723696;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXFt2Epd/aqgYjad/PpLtB0pMU+3tYAiirkAkrUh6A4=;
        b=mlM8vMzquvuW7qsdFITVGfNJMC+AoGC6Kj/x2YNG04naclaN/Ph9JikAIjDlcwCbva
         Mwry8aSeUd5+8kuuZzgXnyIKzRdJyExyA8D2bIMYnM9E29tDGl4bRKl/tdhKu+rvZJEQ
         ARu2n/teIRO4EnP+WVGAVC/LRacndqam/BzAd+nKj/aYw71ZBtn3dPNkO+KTngkQR0jp
         Wh27CvoyI7RoSQCdoYdz3nuTTv8cmLKs008FmDAUrfX+TMOV0P6O2Xuv9uRXQxmeL/zi
         87rWVyb7Ow0jLG2gRTusC5JBp6OZJABWLoTc/n5wg9fOvDIf+ACBiTdHjMe3RNx8pGV0
         lhhA==
X-Forwarded-Encrypted: i=1; AJvYcCUcptbqayh1VsMyMdyKdNlZ4fdcc2msrwL5IbRFMZgoRezExtOcQ+8ioSo2XxDLTfeg3ImBkVdQCvZ0mw==@vger.kernel.org, AJvYcCVQGhKCyt0ufllxNOsF7JYw14oZ90M4myVyYTuRM0UvfzWbvtK4kx5fOgqqfn4WpwLJxUThFRTqThvtPcI=@vger.kernel.org, AJvYcCW5EZMsozvL18sWrzutKcUQ13wVmvIw4/NQsHXrptMOZaDIWW9OJfroqrFDMf+BeiW8PxC1dyO6vxK8@vger.kernel.org, AJvYcCW8z8+TO4toxFH4kJcRshIbBIch9nnuURn+SlXP4gg8F77+B1NUKb2xaZiKLgixGeJJAxqGB+/eG3Zh4zsC@vger.kernel.org
X-Gm-Message-State: AOJu0YwXMKecuG04I2SeIt1Zudw9+UqdJhPPApg1CaS8QP3CiCAnhUt5
	bhBEI/ca4/O3l2lWFsIyYawf3oeETN3oksUzg7uVRL1jZPDMf8U8
X-Gm-Gg: ASbGnctK58msGhxgvGyQbYpcFoLhdP+s44dluA+XYTNzfpmidTb+eyOUzrYfNuXTil+
	TuoEc2UUjv4t9TvZaNn650f7Bh0HL4wX7xSqTpyXLURpfvl/1ZwJYYpYPVfy6iZSJ8FmucWWcSR
	OELzrPd6T+IhVMJmsKCVkq1zGuImWuTvvKjjryaMbLlbXVstNQ/fruMd2VItr43CdZo73QAKiQD
	SWaUslgjjh4FAjrs2tTzTGgRKZZCk5Ub7v2iOZEZx4wPKWCS6EPD/0/FMr+1C7lhUGgXfYkGex2
	35tLWWOtnZMH1GZZGST32j5Jag==
X-Google-Smtp-Source: AGHT+IFuxJHn8Hdx+fZq4w0A7yUUyQKN8llsHOTjd+YrJC/QkSKfmI1lQ5EGzWsF5d/tmcjuv8UsFg==
X-Received: by 2002:a17:907:da1:b0:aa6:2a17:b54c with SMTP id a640c23a62f3a-ab38b0b90cemr205523366b.6.1737118895838;
        Fri, 17 Jan 2025 05:01:35 -0800 (PST)
Received: from [127.0.1.1] (nat6-minsk-pool-46-53-210-232.telecom.by. [46.53.210.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384d2d69fsm166289166b.79.2025.01.17.05.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 05:01:35 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 17 Jan 2025 16:01:28 +0300
Subject: [PATCH v16 1/7] dt-bindings: power: supply: add maxim,max77705
 charger
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-starqltechn_integration_upstream-v16-1-11afa877276c@gmail.com>
References: <20250117-starqltechn_integration_upstream-v16-0-11afa877276c@gmail.com>
In-Reply-To: <20250117-starqltechn_integration_upstream-v16-0-11afa877276c@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737118892; l=1879;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=ZWC4hTW8OX+rf9YyrITr/fbrivvcEKd/ZFRltutvR5I=;
 b=c/uiPiAxZNyM96yZI08HPxUovO8lOYeHN1mn/UacwSnaTxnwzZeEG3dhZbK5e5MvVXdL4E+Sh
 rjVmS31VflXDgqxKc0m2woolglZbC2nIfBKCZQRItoGz3zoa1xxl8I3
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add maxim,max77705 charger binding.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes in v14:
- fix required children nodes order: reverse reg and compatible
- add reviewed trailers
---
 Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml
new file mode 100644
index 000000000000..bce7fabbd9d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/maxim,max77705.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX777705 charger
+
+maintainers:
+  - Dzmitry Sankouski <dsankouski@gmail.com>
+
+description: |
+  This is a device tree bindings for charger found in Maxim MAX77705 chip.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: maxim,max77705-charger
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - monitored-battery
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+        charger@69 {
+            compatible = "maxim,max77705-charger";
+            reg = <0x69>;
+            monitored-battery = <&battery>;
+            interrupt-parent = <&pm8998_gpios>;
+            interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };

-- 
2.39.5


