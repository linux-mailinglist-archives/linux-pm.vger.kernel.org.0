Return-Path: <linux-pm+bounces-3675-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4662584F006
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 06:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0CFB28B1EB
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 05:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56FB56B7C;
	Fri,  9 Feb 2024 05:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkhiOva3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E554656B86;
	Fri,  9 Feb 2024 05:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707457945; cv=none; b=BL51hmcFqm5vLu49Wg+FIeuaLaoXV43B+Wqa8Tr4YUbCFiE44bMgSHRRgWWmLlu4YPXA7NWz4gWaf+ZRZb0NLqueyBTg6AwYtplZRea4MlRz2vOqgVjFJAN1aFzS4UZ3Da/AWkCx+lNhqesPi5jd9PYT6vApbbpoUi8YeY2GNwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707457945; c=relaxed/simple;
	bh=gHFWdGJb33J6+jC1gRs0+QcHVDLwUVfle/UXEO8MmAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=M6kcQp2pYtogcVZYjDE/n7tucmerrJ5dCaLWqP9iBXqsY1qxXNGp+Rs3CaYMkoiuB7mLF7smAr1zNtOP4wqnYc0net4XSV3ACqWmHtCiUWgAOIxL8/58l8lhVKv7be9HbNjv89xq2QlYFOfRnKfNku75D4x8VmLhak1MVazDxg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkhiOva3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so69087666b.2;
        Thu, 08 Feb 2024 21:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707457942; x=1708062742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mf57nKobtsp78hnGcDhJlA31IVpSkcv337k1qnzv71g=;
        b=YkhiOva3FComFg8AOOwiL6DJim1olIMcovLhOYGqqMIAcCLHF27hGbgcX8qhpKA5Fw
         04eo92bjsHSYFwRWkw6tIpaQqDYteN8S4CZoySeRjtjCyDiwPa/eh3f5y4p/+K7ytoDt
         OwhofenBVqwEUrtLRsHJTXrK9XEovEG9l3ml6C/zc4efapzKCtxqaHuhup8Bm81C1Qm2
         RNgPZDkwnsTvJZw0dcynEy2SX1egRvr0BXybv/NqasuYlrNMkItSihgkdM4KsRjiP2+S
         hJTHQaH/C24QP++FEn9SARDwaHiPMEsP0oOQASlw8GdGh9L2co/0+lTgEEPegvXTgbvl
         /Efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707457942; x=1708062742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mf57nKobtsp78hnGcDhJlA31IVpSkcv337k1qnzv71g=;
        b=sUA/FpE5xx2rvl2r+V5ArEoQ9TWHShGiupDqLxPiK3HZIpx2majhoVckaUc8ttBS8v
         GHZ+ynVzkxkWBGDphmrP+geeo8Qbs95ig8Mj3OZGapXro3jRToYPeepn7FJFgN0hIWvG
         KgV5fXKjJZ8TEydNMR1MCxe5SnDRixQG3IB0PKfB21zE/YMoS9M6//AyVR6CGMYAEdUR
         xkT9w/2+ZwkAtFo7JLKMIkg+Xb/bFKuMq6dxBJ29T4/M61C/XJMFhGb1pgyrjj+o4rBy
         +DVB7IfDqhZ7ZiWPx1kS2FXklz3t+ixnQID4+YjJlwe4ZzGkWFKYYXXDoP0fqXT2jp0e
         1x9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDYc1ovENkyPOU0mMlTQNNDQJSePe6mQEF/0Ogq0tKOabraBQl/lB5g12wHpXntovYbmBGDwieXU3ugrmtTDS0Sz9F3MMiWuZw62QcD03HWmBZNg46q19NkgXhmg7m0L4oVlpx
X-Gm-Message-State: AOJu0YzGfQd9ahiRun30fucljOlMQeO30uB4M3tGLNG05VjjK4D27Bxu
	HE5qVOZrRSBDjDvR1c+hQ5ZPuSYKujW9xDiU+w5lllLODgFQyGZ3
X-Google-Smtp-Source: AGHT+IExdn4j3WLpPkGZHSKFJQSuFHiN82pOOTC6WPoYbiqwyvGkAeQonPfG93G/w/yBTpMA0QcwdA==
X-Received: by 2002:a17:906:1156:b0:a38:66ef:14d3 with SMTP id i22-20020a170906115600b00a3866ef14d3mr334720eja.13.1707457941890;
        Thu, 08 Feb 2024 21:52:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWjiSfPNrT9WvFt7lXwMCztpAG3PneMTXFgXSZNJO0QyErCoFzz8jHQ97qwEZQzOmh1KGcAgD0kijIEZVJlzrwCHTY1cJan8Z6xfHt2mUHit0t+usAqd3KUFEmaTQOwANRE/62yreyyvM7cOEaIlM6kJ92U2MEDPRe6ChZ3tIxvEYDqI7wMir0jIGjVStl5TusC+nLm1bYM8kcBj4776kpqnsiXeSOcdVpv+AsSezDDFdnMPF/iRgAg9dqdlumnOObL1KP3MRzlLtsYf1R1B0BloXTngqvAtKn/2S+7aC359odNoT1wZe3XCWTItO9WG7R+U91vXs7x/XH/TlyoXPSqbrXxNqb5HTZbtBTFAQKVTzXBrCOo/ZgqTuxnwztu+1fdXRuXEgdQfjDm5ugcsTNEkxMFjXdO/kNcn3tQK/VY0iNtaI5Tun4dE7XFqrdgzRxYxy2liKG6JxhsIix4JMeSS4Fn5v2aieEkWm2q3odDFPcmBAX6e8ZapFSUx4tKsx7nZiZr61zoDh9+Eg2fyfBlKH65lzpcRcQWQ/d/QJ4D/MTHsZe0pOtkliA9Rx/KBjJtEsgOGoVrsjk0GR/LxjChgAap
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id vk3-20020a170907cbc300b00a37fbee48f8sm404551ejc.133.2024.02.08.21.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 21:52:21 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Daniel Golle <daniel@makrotopia.org>,
	Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH V2] dt-bindings: thermal: mediatek,thermal: document AUXADC 32k clock
Date: Fri,  9 Feb 2024 06:52:03 +0100
Message-Id: <20240209055203.17144-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

SoCs MT7981 and MT7986 include a newer thermal block (V3) that requires
enabling one more clock called AUXADC 32k. Require it in binding.

Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Disallow "adc_32k" on other chipsets (maxItems: 2)

 .../bindings/thermal/mediatek,thermal.yaml    | 31 +++++++++++++++++--
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
index d96a2e32bd8f..e7373d78618c 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
@@ -15,9 +15,6 @@ description:
   controls a mux in the apmixedsys register space via AHB bus accesses, so a
   phandle to the APMIXEDSYS is also needed.
 
-allOf:
-  - $ref: thermal-sensor.yaml#
-
 properties:
   compatible:
     enum:
@@ -38,14 +35,18 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 2
     items:
       - description: Main clock needed for register access
       - description: The AUXADC clock
+      - description: AUXADC 32k clock
 
   clock-names:
+    minItems: 2
     items:
       - const: therm
       - const: auxadc
+      - const: adc_32k
 
   mediatek,auxadc:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -76,6 +77,30 @@ required:
   - mediatek,auxadc
   - mediatek,apmixedsys
 
+allOf:
+  - $ref: thermal-sensor.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt7981-thermal
+              - mediatek,mt7986-thermal
+    then:
+      properties:
+        clocks:
+          minItems: 3
+
+        clock-names:
+          minItems: 3
+    else:
+      properties:
+        clocks:
+          maxItems: 2
+
+        clock-names:
+          maxItems: 2
+
 unevaluatedProperties: false
 
 examples:
-- 
2.35.3


