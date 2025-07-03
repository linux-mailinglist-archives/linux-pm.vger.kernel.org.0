Return-Path: <linux-pm+bounces-30064-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52569AF7AEA
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 17:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8DCE563F74
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 15:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1702F0C64;
	Thu,  3 Jul 2025 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkfIKfDD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC48D2EF672;
	Thu,  3 Jul 2025 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555566; cv=none; b=QngixXMA8Vxds1ncTZlSDO7qZtVJJotBOKdNXlnFprMLTxvdyk6rSFGmpeJUAGOBOXaxOLhsGkrOhQXbaDaxtHRsbAuNCH0V5/8PG9UCRv/xdQhAsXtjk2MWshsLkvlrocp2FWDKpDfFGQwIJfEcDUHWnCQjVtybND6eo8sY0hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555566; c=relaxed/simple;
	bh=+dyKOZdFK0jZ1XO+OBIaaB4l4t8HcKQncpEBdDjx5Cg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2hym78vj3PHMNq1eZi7qPu3PNaiLizT89+tw6S42V8Wqk+CosC5+WmZyAbvRgUaPz7NViHB7f/JkHReJoD5pobrfcO/fa7td7DzvwUfadgJufHAF+9ayX93LCN15lcs0qJ5wU8aZccTGJixkPyWF3bPTmVayyHAIjpBWl+XOnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkfIKfDD; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32b2f5d91c8so333361fa.0;
        Thu, 03 Jul 2025 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751555563; x=1752160363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lnk4S/ZRBOAWFeTLBV16c83HbawKBbnUkwVc1Pl3Jgw=;
        b=mkfIKfDDUqYl0lX5syrQHuPq3Pl0+a20c6NynXpWOA4cU0jmLGNS7CgJX64jmMg5pW
         NLoJ5LoaYxYbI+Qx8lMuBOtcgvvgqIeQUgUEvts77UolTLpbxLGIL61i9uBjdznXTuZc
         smSHX9l1kI87hfUuAZ0dIO4Wwo237mZoEioAyFtWrXoCe+6jDAtcr/v9IY59Zx9btq9k
         BJysAfx2d/OBFFNOLiDt019O58ghECE0Ku2V9Gw3U9njHBw70+E7Cs9+skOavBzyD84m
         5tUcFKD10L9GBakU5Y13CK24/v2dCQM85dv4R6hefXy6Xp7TGDsREaPSwYx91u5aeei1
         twNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751555563; x=1752160363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lnk4S/ZRBOAWFeTLBV16c83HbawKBbnUkwVc1Pl3Jgw=;
        b=HfWhHXKxZQS0we7pdEymL49eX6S9NacFLrUVHQ0pQblgN3AQQT2wu9ogSPZ1GxuMhw
         2tfAc0QUgM1C7jfkJCVuuTm0chRNb1niMAjke/JMdoBBKSwclfYDuzfbHVdvv25f1svn
         wtbVf32szAfurFEsrSDAGCzqkPi0piNRhR/NlJYRgYAWNAHeEUD10OsroNeEsaeV9IP2
         FA0Uyl2009PJ69p5ZOldCyuGvR9lpPBhCFItjL6d2Qnx1ZvgPdtmmQS/gGMFC38tBiMd
         Sc2W2EklZjQ0FGvCikjn/yBbFO09Q26aHAXf2yTBEMNf1mAYqabPYNbb0KccR4bEak+Q
         +aSw==
X-Forwarded-Encrypted: i=1; AJvYcCVf7JD29H64VSCUAnSwvhc3XLQgTSDd5sTrOh3SzqIk5/R5irpmjKJ/lmJwsS3jnxZTkUs+jAXEIqaEf6RJ@vger.kernel.org, AJvYcCVzDSEwILZ5ptXITaHoq5tBetLWfCiPJ8TcXTkZ/2/ACwfkKqLJ8vZVEueXBSpWrp/lBnykZtLhha2L@vger.kernel.org, AJvYcCXIFq4xqdQzVhqqK1RdmXR1KqSl18bIjvaPTsnK3w0EIQsIyvE9+7/n3mg8Ot1+F+RUEtNDA4hFOuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxKvAnkxZWbtIK2+19NYDQX55edrH/Erw4qNxPVWqzcDI0Gu0Z
	4Vk9qPHwY6uLjJ9jELWBzoXycMX4xWxNpkhgH+B5EqOaqOXfiwHxocLn
X-Gm-Gg: ASbGncv4lAD/NjJsS4fm45GVha9VoRk+Zf03F0c9VVlhsg9JcfUrh5c0CyIf/i1WYzI
	/kU/fEKeONXURPI/uHFEXOrHMfonZxpDEyXMq6wvSbyhpNrHicRywEG7Ayh6jSvr4ei+mQmqsmb
	bDletZGA1IZwDrcz2NXl4VzscMdzu8Z7HLC/68IfgMbSbrBxOzxsWBnZdl+YT+ZNSqwF7Xx+8uu
	OLvjYVoot0IwWRxRsRZfPyYITIekjqmqE0tOXs0EzChpFkTKDTlRsXdN4FaS3HHZrcjgZatvqM1
	pmDliov/MyWQ6I//0KoE8jQvqSdgEbeLILzQ+xejGRy+QTmj+grSdZ86/6FGnr2Jwkp5FDI=
X-Google-Smtp-Source: AGHT+IE4N9EPjYoVrJU71eRGRvfZjYij50QTT9ow8waF9KaIqcuDsIxMjitoZssy/2WBO9PRt9Qedg==
X-Received: by 2002:a05:6512:3d89:b0:553:2bf7:77ac with SMTP id 2adb3069b0e04-5562837286fmr2805513e87.41.1751555562586;
        Thu, 03 Jul 2025 08:12:42 -0700 (PDT)
Received: from localhost.localdomain ([212.192.12.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384ae15esm725e87.178.2025.07.03.08.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 08:12:42 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 2/8] dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers
Date: Thu,  3 Jul 2025 23:11:26 +0800
Message-ID: <20250703151132.2642378-3-iuncuim@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703151132.2642378-1-iuncuim@gmail.com>
References: <20250703151132.2642378-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

Add a binding for D1/T113s thermal sensor controller. Add dt-bindings
description of the thermal sensors in the A523 processor.
The controllers require activation of the additional frequency of the
associated gpadc controller, so a new clock property has been added.

The calibration data is split into two cells that are in different areas
of nvmem. Both controllers require access to both memory cell, so a new
property nvmem-cells has been added. To maintain backward compatibility,
the name of the old cell remains the same and the new nvmem-cell-names is
called calibration-second-part

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 .../thermal/allwinner,sun8i-a83t-ths.yaml     | 49 +++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
index 3e61689f6..80657435a 100644
--- a/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
+++ b/Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
@@ -24,18 +24,22 @@ properties:
       - allwinner,sun50i-h5-ths
       - allwinner,sun50i-h6-ths
       - allwinner,sun50i-h616-ths
+      - allwinner,sun55i-a523-ths0
+      - allwinner,sun55i-a523-ths1
 
   clocks:
     minItems: 1
     items:
       - description: Bus Clock
       - description: Module Clock
+      - description: GPADC Clock
 
   clock-names:
     minItems: 1
     items:
       - const: bus
       - const: mod
+      - const: gpadc
 
   reg:
     maxItems: 1
@@ -47,11 +51,16 @@ properties:
     maxItems: 1
 
   nvmem-cells:
-    maxItems: 1
-    description: Calibration data for thermal sensors
+    minItems: 1
+    items:
+      - description: Calibration data for thermal sensors
+      - description: Additional cell in case of separate calibration data
 
   nvmem-cell-names:
-    const: calibration
+    minItems: 1
+    items:
+      - const: calibration
+      - const: calibration-second-part
 
   allwinner,sram:
     maxItems: 1
@@ -107,6 +116,7 @@ allOf:
             enum:
               - allwinner,sun8i-h3-ths
               - allwinner,sun20i-d1-ths
+              - allwinner,sun55i-a523-ths0
 
     then:
       properties:
@@ -132,6 +142,26 @@ allOf:
         - clock-names
         - resets
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - allwinner,sun55i-a523-ths0
+              - allwinner,sun55i-a523-ths1
+    then:
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          items:
+            - const: bus
+            - const: gpadc
+        nvmem-cells:
+          minItems: 2
+        nvmem-cell-names:
+          minItems: 2
+
 required:
   - compatible
   - reg
@@ -176,4 +206,17 @@ examples:
         #thermal-sensor-cells = <1>;
     };
 
+  - |
+    thermal-sensor@2009400 {
+      compatible = "allwinner,sun55i-a523-ths1";
+      reg = <0x02009400 0x400>;
+      interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_GPADC1>;
+      clock-names = "bus", "gpadc";
+      resets = <&ccu RST_BUS_THS>;
+      nvmem-cells = <&ths_calibration0>, <&ths_calibration1>;
+      nvmem-cell-names = "calibration",
+             "calibration-second-part";
+      #thermal-sensor-cells = <1>;
+    };
 ...
-- 
2.49.0


