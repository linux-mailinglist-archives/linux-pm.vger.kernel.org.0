Return-Path: <linux-pm+bounces-19381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 316379F53F5
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 18:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7E4188B581
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2024 17:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBC81F8EE1;
	Tue, 17 Dec 2024 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPewXTM3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038031F8933;
	Tue, 17 Dec 2024 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456641; cv=none; b=RFDMTPHcohTsgQ4vQW9I7+zNLPsXwHAt2aphLNTs0R71MNWt0KTdJdcBLA7kqeiwbZlAdzfgR2hIWy8vXKLXirxlDvGPQmR76j4u8Kmg7M9Mkuq5hNdf2f+k77xugk8qprxT0ECVJu+3M683Ipbj+o8yyAx+T54tI30AVtqiB6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456641; c=relaxed/simple;
	bh=W3R0sAEsh89KI9k2TtMER4sOCc8bejuu1Gu7C+v3ml0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cLYiUywwhRzW8B8iRtwnxgeA5RS6ewHTKpY6A9MaZxRHO4fyzvCewXnS6iY+p/tDg4ff1mWM1xr4k+Cf5+mxVXf7r1+EHcwj6cwBI2GYXLQkX4D6xplKA3ofOew5dQuQJcw3Ko0CNRZTLfE5vo99rdsLaD/TpX3BoyfyJXzVIyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPewXTM3; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa67f31a858so1027969566b.2;
        Tue, 17 Dec 2024 09:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734456638; x=1735061438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LyNrH/v1nn6Cpsrp8y8ejskaGapYhbwc7aBDhXiWAeU=;
        b=fPewXTM3bWZciTUnFPeI1RBiaEqUdYupV0tIAA7WmNKQcO3A+AsYMiZl9Uo/sa8dT4
         gwQK+i0LqlVHSMTpBTVLAyVBuj6wr5olfLsMsIi6Y5fxIpjundAXY2a3HULO3yQWxuKi
         gIY86bd1reH8gyaAvvcLlNbAXkRNWSt3HkZiqXWgWAMmNnyYPejLZB+8OysMHhuIP2ik
         8kUWPItOXYvYDWFpx85TOZhXzETTdCX53msmaC6VO4BMj2LPxH0GCIUcwaaBiZN31Gru
         aGFdEUJ5w+7jpd6VVptvW70qAbff8GgHc3ohZ/401OwSR/Lsi7bjhp+mNL3TjxdShw6d
         i60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456638; x=1735061438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyNrH/v1nn6Cpsrp8y8ejskaGapYhbwc7aBDhXiWAeU=;
        b=gwijbkq7zHjAsA6DnHircDhSXVCCeJ1UIgx87x6bdU7q5xlYLAWcgSprK2yK0NA2+M
         Xox4wSHjETaQwv5Ot+gUSiXiXRI9pIk1zT2ab8O/WoGczIm61jbYaJNYn33n8eoS8547
         rFx+AkrvmAjQZsDSoWgGnhV0YemPxuTaA/IsjemcD3LCKuqh9qO9u3L1yWKfJ7t8H5vN
         ZXDFt4YBVWrnjflITBJDWcC9l4kc2KayDC5tlCKRHS7QRm1sUeF54U8+dQQQwl9Qct/V
         16TVtA/RqGelehJWckijMBWzQ63YkJgkATqN80daeohiuryCegg1di+35ZhAJKQLkFCl
         iN+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUV5pI9qV/5yhVKxdCH8gthAA1mhcn599M18EciVIRxbyj5MP0Wgtp4/AZdyHs90nODxuYTERoujBXCFQUa@vger.kernel.org, AJvYcCUXawXKTqSkCUzbOjTMVQn0PBm0Jfyme+BTu6M6t7yD7lrNjjUOk28mch2d8HJQg1L8cbHwHHEJLlTG2RY=@vger.kernel.org, AJvYcCXaDe4nnq67KE3Wj6G1198Ct6lPH2t7i3/3bIdgQLaKPmLO5qEOKkPahv+VHTtECIWtmcqLUYDDiD8H@vger.kernel.org, AJvYcCXdqt6aYCk1zUq4YZ89n1ley+DbRBfNryLapzO0psTwl5vEjKhLUhtZfRi+xPtnGh/pTbeL0jJCPkpMzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSDb/jkng9n6YKZHj3SnTiPQG3mSZXaVA7/Yz6nooJiuFBxkcR
	Y3Hst1oropONztzaaYaYKy5vcJ6llvkw33dIDfftbs9D64sGESB3
X-Gm-Gg: ASbGncu5ywXR4tpbkbDGJqsXTQpUD6hMYwdo8oUeCAyVPQKMDAh4UVW/zMcEhOIKhLy
	yTaxQ8MNUrgy5Sy4yppXNGltt5kXbKhiMgWKhBIx9n0jdfdlZfKM2viceIUU0XpYEzFo0863iVK
	KD/Ihf84hGqAi2S2xnF86/OETYbdcRhLiPfmYkVsjm5TWxj7hO708BYXDPu3i10wOO/hV2WC9cT
	p1M6BT0sZ7T/pxm8rIF2X9A7u3YEYcInL6QAIMg74RBun4FrA6Ohyo=
X-Google-Smtp-Source: AGHT+IEX5DsX3uuQNAGWOJWqSwoA/U/+l9Wt+lhs4egjIHxsEhiy2iP8f53/VTVpKThB/vwSVrgqfQ==
X-Received: by 2002:a17:907:7809:b0:aa6:6a52:974 with SMTP id a640c23a62f3a-aab779cead3mr1427429766b.35.1734456637970;
        Tue, 17 Dec 2024 09:30:37 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aab95d813afsm470444166b.0.2024.12.17.09.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:30:37 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 17 Dec 2024 20:30:01 +0300
Subject: [PATCH v12 03/11] dt-bindings: power: supply: add maxim,max77705
 charger
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-starqltechn_integration_upstream-v12-3-ed840944f948@gmail.com>
References: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
In-Reply-To: <20241217-starqltechn_integration_upstream-v12-0-ed840944f948@gmail.com>
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
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734456632; l=1700;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=W3R0sAEsh89KI9k2TtMER4sOCc8bejuu1Gu7C+v3ml0=;
 b=SM5St0LyO+ja3lX8zb58WPKKdXoze8dzgIQ3PU9IyvnkWFBb5NgDdhQKwOMrcj9Xf4feleha3
 uAmxJFpfB0IDidFXRkR2gTFRy7zCP3thrB8kFgRIksQvR1Jz+00PWJT
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add maxim,max77705 charger binding.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77705.yaml
new file mode 100644
index 000000000000..e42dbd48d838
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
+  - reg
+  - compatible
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


