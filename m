Return-Path: <linux-pm+bounces-37976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6B2C59A00
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 20:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C3513498F6
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 19:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C08319610;
	Thu, 13 Nov 2025 19:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="A7kde7cw"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F9E3195E7;
	Thu, 13 Nov 2025 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060789; cv=none; b=Zqw0JTVKgGD2SukOyMeE2o/Bb4UiXq910JjSWaoy8NPMEvkoIzFCrMZ/e96+ku+uiczFQeqlqz08MT7pfONzxMarG22g2N0ycMMgt3XyVkTPoBQ7HHGqrYnGShIH4dRxoIs/AgB9SJl3Oi1qFZkwJKHcGEj1NcGlfk9pEsdSkZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060789; c=relaxed/simple;
	bh=EJ/+SlcFBg6eyfXaWGPrB6FJ2pXIZRWt1+9hWtofYIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ffIOG2SkjD1ySeswaRJbaun8aUS/z4cmlPcmwRHHh+6YpwwPmWr+NytBgiz7lEJm+BoAGTeOQ1m2uEK0P1dFInmx0Isput1Uzr+Esz13SpWnGUHxk79n4/TrrY9zv6pOcXq5Y58Ly14pyMwy6iUzhC7GQNmiVgrUtVaqbtnWTg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=A7kde7cw; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 546C72674D;
	Thu, 13 Nov 2025 20:06:26 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p0J_MNiE_R_g; Thu, 13 Nov 2025 20:06:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1763060785; bh=EJ/+SlcFBg6eyfXaWGPrB6FJ2pXIZRWt1+9hWtofYIo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=A7kde7cwyPuSm0upZMlmzgi0J6+xQ8jeKODbPzzcjDS0bl69x3Z+G3kfFiJXA7fhf
	 Np7mhkBgcqfru7CDuLYH6ZUO3AgqwclhoGjRZ6mzWTFnEQhM6q8qbqlutM1UlE8h2k
	 PueoF2usqvRKCmyUQVj8LNWSifiTw5sWjGcwzcNkmrpTMbJnaJe/YYak4vCVbNdHsy
	 decltP0oTE1YKVzs2yFLfZP4LkOjYlF5yhJcVaBrc28Jj9nQHPiE88kqYCWykfdAwY
	 Z1jk6uWBXLcSCRLO/KVZa2oo9wkwobMIawqSI3s3g7h1TFId6dt0BVW60+bhnE8ZgV
	 Vec223S8Hk9dQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 14 Nov 2025 00:35:06 +0530
Subject: [PATCH 05/13] dt-bindings: mfd: s2mps11: add documentation for
 S2MU005 PMIC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-s2mu005-pmic-v1-5-9e3184d3a0c9@disroot.org>
References: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
In-Reply-To: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763060713; l=5753;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=EJ/+SlcFBg6eyfXaWGPrB6FJ2pXIZRWt1+9hWtofYIo=;
 b=WduHYbWTepjUPsCxB38vQmxEE9ggCzi15TEDxWsURB/GcxQ6ZjzXOeV/WXbeiccbemNej1LUd
 JricGDBHpSlBMOPUGKZYwdeJCoOsogeTpVK/j6E6iGDfNJ1bkn+DGtw
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

Samsung's S2MU005 PMIC includes subdevices for a charger, an MUIC (Micro
USB Interface Controller), and flash and RGB LED controllers.

Since regulators are not supported by this device, unmark this property
as required and instead set this in a per-device basis for ones which
need it.

Add the compatible and documentation for the S2MU005 PMIC. Also, add an
example for nodes for supported sub-devices, i.e. charger, extcon,
flash, and rgb.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../devicetree/bindings/mfd/samsung,s2mps11.yaml   | 103 ++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml b/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml
index 31d544a9c05c..aef634ca2e36 100644
--- a/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml
+++ b/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml
@@ -27,12 +27,28 @@ properties:
       - samsung,s2mps15-pmic
       - samsung,s2mpu02-pmic
       - samsung,s2mpu05-pmic
+      - samsung,s2mu005-pmic
 
   clocks:
     $ref: /schemas/clock/samsung,s2mps11.yaml
     description:
       Child node describing clock provider.
 
+  charger:
+    $ref: /schemas/power/supply/samsung,s2m-charger.yaml
+    description:
+      Child node describing battery charger device.
+
+  extcon:
+    $ref: /schemas/extcon/samsung,s2m-muic.yaml
+    description:
+      Child node describing extcon device.
+
+  flash:
+    $ref: /schemas/leds/samsung,s2m-flash.yaml
+    description:
+      Child node describing flash LEDs.
+
   interrupts:
     maxItems: 1
 
@@ -44,6 +60,11 @@ properties:
     description:
       List of child nodes that specify the regulators.
 
+  rgb:
+    $ref: /schemas/leds/samsung,s2m-rgb.yaml
+    description:
+      Child node describing RGB LEDs.
+
   samsung,s2mps11-acokb-ground:
     description: |
       Indicates that ACOKB pin of S2MPS11 PMIC is connected to the ground so
@@ -65,7 +86,6 @@ properties:
 
 required:
   - compatible
-  - regulators
 
 additionalProperties: false
 
@@ -105,6 +125,8 @@ allOf:
         regulators:
           $ref: /schemas/regulator/samsung,s2mps11.yaml
         samsung,s2mps11-wrstbi-ground: false
+      required:
+        - regulators
 
   - if:
       properties:
@@ -116,6 +138,8 @@ allOf:
         regulators:
           $ref: /schemas/regulator/samsung,s2mps13.yaml
         samsung,s2mps11-acokb-ground: false
+      required:
+        - regulators
 
   - if:
       properties:
@@ -128,6 +152,8 @@ allOf:
           $ref: /schemas/regulator/samsung,s2mps14.yaml
         samsung,s2mps11-acokb-ground: false
         samsung,s2mps11-wrstbi-ground: false
+      required:
+        - regulators
 
   - if:
       properties:
@@ -140,6 +166,8 @@ allOf:
           $ref: /schemas/regulator/samsung,s2mps15.yaml
         samsung,s2mps11-acokb-ground: false
         samsung,s2mps11-wrstbi-ground: false
+      required:
+        - regulators
 
   - if:
       properties:
@@ -152,6 +180,8 @@ allOf:
           $ref: /schemas/regulator/samsung,s2mpu02.yaml
         samsung,s2mps11-acokb-ground: false
         samsung,s2mps11-wrstbi-ground: false
+      required:
+        - regulators
 
   - if:
       properties:
@@ -164,6 +194,18 @@ allOf:
           $ref: /schemas/regulator/samsung,s2mpu05.yaml
         samsung,s2mps11-acokb-ground: false
         samsung,s2mps11-wrstbi-ground: false
+      required:
+        - regulators
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,s2mu005-pmic
+    then:
+      properties:
+        samsung,s2mps11-acokb-ground: false
+        samsung,s2mps11-wrstbi-ground: false
 
 examples:
   - |
@@ -305,3 +347,62 @@ examples:
             };
         };
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@3d {
+            compatible = "samsung,s2mu005-pmic";
+            reg = <0x3d>;
+            interrupt-parent = <&gpa2>;
+            interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+
+            charger {
+                compatible = "samsung,s2mu005-charger";
+                monitored-battery = <&battery>;
+            };
+
+            extcon {
+                compatible = "samsung,s2mu005-muic";
+
+                port {
+                    muic_to_usb: endpoint {
+                        remote-endpoint = <&usb_to_muic>;
+                    };
+                };
+            };
+
+            flash {
+                compatible = "samsung,s2mu005-flash";
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                    reg = <0>;
+                    label = "back-cam:white:flash";
+                    color = <LED_COLOR_ID_WHITE>;
+                    function = LED_FUNCTION_FLASH;
+                };
+
+                led@1 {
+                    reg = <1>;
+                    label = "front-cam:white:flash";
+                    color = <LED_COLOR_ID_WHITE>;
+                    function = LED_FUNCTION_FLASH;
+                };
+            };
+
+            rgb {
+                compatible = "samsung,s2mu005-rgb";
+                label = "notification:rgb:indicator";
+                color = <LED_COLOR_ID_RGB>;
+                function = LED_FUNCTION_INDICATOR;
+                linux,default-trigger = "pattern";
+            };
+        };
+    };

-- 
2.51.2


