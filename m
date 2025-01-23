Return-Path: <linux-pm+bounces-20878-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A555CA1A687
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 16:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ABD17A1C96
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 15:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6B6212B34;
	Thu, 23 Jan 2025 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COfVXYrS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6204F20F994;
	Thu, 23 Jan 2025 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737644684; cv=none; b=f4yoHDNK7AXc9oe0dGUexpGDcFXZ19mEZ1GpUiXQ8ILRDBlFV7iMKPUCE9rPyoKIyTfXO/ioSK3BcLj2w2sJ3qIwuB/YNH/EIk8M4Qlrzu+bNNsfFiYn4XDodEsS2JA+t1sfoYT5o+AIJ/DJpxhdOJdbXGmoexoZ44H3x9bEwXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737644684; c=relaxed/simple;
	bh=ZWC4hTW8OX+rf9YyrITr/fbrivvcEKd/ZFRltutvR5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bgyJnq8zgDMp2nqXS3s6tXQ1tn3ATaNjjZ2GN2SmYJXbFLAP60azfRtOm5dMrlo5C+IYH9BySrhIZg//vi21XbQnA/OzXaMp4/o93s+8++ZgcHBu8zu5aCGHdHlsorWedG2ZSp2iMTmzPklw6/oJ92fbXRUShvhf8U0/qeff5uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COfVXYrS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9e44654ae3so171121466b.1;
        Thu, 23 Jan 2025 07:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737644681; x=1738249481; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXFt2Epd/aqgYjad/PpLtB0pMU+3tYAiirkAkrUh6A4=;
        b=COfVXYrSVs6KCDZYbpsRRGmo+/uoUxXwlv1U6MM2TTzW8bF0lBrzVhR1AUA4SMACj0
         d+hW4vnDkKGamcSZKK1RPP6+hEPzkJchhhRsyXO8kLdQMertsWXxt8LtD62zt+k/Lc+J
         7BTG56EMB65JL1smyflNoxhLbBKY0uUChA80kTtIEB/FxTSme5PDN3rcDF49+yNcT3bc
         Bpnt70p8JTxvhaKVQoWc5+NPBCiGBAE7uTCi5qciyyxYXKUXZER+9IBjPmHTk93rJeqd
         C+bB9WvSM+arVeqb6FXpKrr3Hx1DgDusdLlSj+sFSQlwsfR99SqgMk2apBr3IdqnuUK4
         OZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737644681; x=1738249481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXFt2Epd/aqgYjad/PpLtB0pMU+3tYAiirkAkrUh6A4=;
        b=nJU5SeSI0CSyYmSbEgcJJsl+FsYA0zTm+SkUMsxPVJyrOhKXbleaD8+GzMbY9v6Y4E
         ditu2/lDy2/sVS0TYYx3V3DBsQlpCz7ROplFlX9HA9VDMwx+0ZhsjYLWEowVRWi0jy52
         RiDK3eu5dypepqBZsP4TVGjGrP8vnsrqI75qmh3TrFrMpFszwusNho4HTfWWIJpHXbus
         6XH+ddF5KTSHmbVKonApyZzmExTGQhB8wgZeuGzlETybKS6Xa6beBqQaHLY3qimLrHPD
         363qlabdICaZC1cElkXMCMovuz6MdOsr0fqd0zDLzgORTXf4tVSmbPjBpcY7Qe7F3b5n
         0Tiw==
X-Forwarded-Encrypted: i=1; AJvYcCU0Yurtt17xzpLfWNKrzVG7rfLnxugkGSE58D9GinUci3L4zuRlmlB7Yr15HbGKYBHvCsdaWmrlpAuHTQ==@vger.kernel.org, AJvYcCVO+NMA44pZxp2svFWHnyotrCtbSEXADYA3iuXYMEFbus+uQMyLRdaYtxVixjqKjY9QUHzH5ZZz//Fm@vger.kernel.org, AJvYcCVmBdTNn3b3PYIj9WbcGmN7UpV/8C4AS05luwU3NOAYpNVWdO1NE+Cea7BjtU463kenqCF9NRIY7Q3vCfX4@vger.kernel.org, AJvYcCXXhFLf1MQL3eVKf5O13pZvLg+HhnrAYDT5SsWeqQcRApl2qIbDk34wP2XmUf1SQ9MZvyUhYvCMV8u+KkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqbLm1+kICWyXOxc5/CI+w5CqLSQNHK9OxH1gWMzqf9ogIrdLj
	znqfbn43qaoObgnvP1e4UVbV1HmYnSmUACHWvhZ3NqTOoKPfo0HU
X-Gm-Gg: ASbGncskV4hDgWnOTfLlybgNUj4u2S34fcYgejzgbxlPcwpm2rQXrClpZ2A79oILm2U
	ica5c53cfIx/G9hSailogka5BvlhikgWEDNHoYlx21aQ0g6cchMVV9CYxsI6TuUpyADM1fdHBHU
	pTyt+PdwcyIOFN57CoPVZmOyaX+yA4WWZC3ZnpVJyjhIQzwQjcxpAhnycKD02DQyniTmx9anPGX
	mp1hOxRtlNfQHtuR1vhJKzMPO+En7Awsnkd1mjzuut+PDlczmNZ5ZOsa/W4RipR4CaPimqyPZhV
	3ZM=
X-Google-Smtp-Source: AGHT+IEk7No0C2C257l/6+eJKi2m0W6M8Xd8eHQQPnxFYy3DeD7l4WyYo8PtmlnhzB5nDbFRqQdhmw==
X-Received: by 2002:a17:907:1c11:b0:ab3:7720:d87c with SMTP id a640c23a62f3a-ab38b384218mr2708956366b.35.1737644680187;
        Thu, 23 Jan 2025 07:04:40 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.22])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab384f2903esm1084727266b.109.2025.01.23.07.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 07:04:39 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 23 Jan 2025 18:04:26 +0300
Subject: [PATCH v17 1/7] dt-bindings: power: supply: add maxim,max77705
 charger
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250123-starqltechn_integration_upstream-v17-1-8b06685b6612@gmail.com>
References: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>
In-Reply-To: <20250123-starqltechn_integration_upstream-v17-0-8b06685b6612@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737644676; l=1879;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=ZWC4hTW8OX+rf9YyrITr/fbrivvcEKd/ZFRltutvR5I=;
 b=84695wMblJRcuEiNFWCSDzF8/Jr+mgqy5NQpfZwywnjcBbQwIUbBxFmSaeDGv0exfDXZoG44W
 VAGY3PoaPRsA/a8f8tzWrEbq6AM6LyCtECMt0e2nDsO815VLqCsKpyd
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


