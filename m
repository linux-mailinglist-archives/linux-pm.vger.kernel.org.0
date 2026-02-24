Return-Path: <linux-pm+bounces-43167-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHpqLlH5nWmeSwQAu9opvQ
	(envelope-from <linux-pm+bounces-43167-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 20:17:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A9A18BD62
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 20:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2FD830F8C0E
	for <lists+linux-pm@lfdr.de>; Tue, 24 Feb 2026 19:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFAC3AA1B2;
	Tue, 24 Feb 2026 19:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="hY1++PeE"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BE529DB64;
	Tue, 24 Feb 2026 19:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960554; cv=none; b=du8EcecasiN1XPxG/qFD3eA8YrmgN7DdlbwEp+Nh3mUJ2B9RMTOQhdruHF7vV7BvbwriULvuzC4Yc/urws/eb3Z73US4NMf3awBSLEvZr2E0EoYZXGgI0f0EyfUsvH0KkqObQIUhSbZY0Dk8eLoWbsZFN4wXH+qCIoLRJRMKkho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960554; c=relaxed/simple;
	bh=W2TMWpdaXNdFtTqmW1M7D2C4Tfhyui+TH0Jz83rN+gM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UpkMTY5jl/e2+Oqmt717J16w6yciDC94QvLTfHmDuNdLhnAWG2F4yKWma3U1abVd6thrxNNzQmOlxK+vtur3HkprxHOmihaRFqhEv9oTBIRjgZ4siQECdW5DB+fM1nvevUh3S7sRbtHq3wIkFqu3AlSN70l6CKdL+PEO/urw7rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=hY1++PeE; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 51FE226F73;
	Tue, 24 Feb 2026 20:15:51 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2TG1elNoV_LT; Tue, 24 Feb 2026 20:15:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1771960550; bh=W2TMWpdaXNdFtTqmW1M7D2C4Tfhyui+TH0Jz83rN+gM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hY1++PeE6xgOVxbNSr8RWB5PN8QVYkj4ci7AxBTkoUe2n2QbDpuZ4rgHzOr0DSoWQ
	 VpVUUAlUFatt7YJiOoUBanXLt+32Yde1fegg7I7f/QDl8pTTZcZs/u5UTYzWfeCxNX
	 gTXjDtKzRieRVMdzIX4ywQk6NmzzpqwmgETybNiCxbBz6a+rzNADkqJS4Yel/x7PvN
	 UuUIQrij9Q4T1Ak3kvxZMbsEhjugg4Z7HPgMdWGR9DDErmLAhbwpNqZiPH9oSDbv4n
	 5y9svEF3vTFN4pg3xZyGkO842YHC5J6j+QoA8bdzPf/uPtpHQzfn6oBJDZ+6b02tcU
	 q2C3PqAzLQ6ag==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Wed, 25 Feb 2026 00:45:07 +0530
Subject: [PATCH v3 05/13] dt-bindings: mfd: s2mps11: add documentation for
 S2MU005 PMIC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-s2mu005-pmic-v3-5-b4afee947603@disroot.org>
References: <20260225-s2mu005-pmic-v3-0-b4afee947603@disroot.org>
In-Reply-To: <20260225-s2mu005-pmic-v3-0-b4afee947603@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Nam Tran <trannamatk@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43167-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,bootlin.com,lwn.net,linuxfoundation.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[disroot.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,disroot.org:mid,disroot.org:dkim,disroot.org:email,0.0.0.1:email,3d:email,0.0.0.0:email]
X-Rspamd-Queue-Id: 77A9A18BD62
X-Rspamd-Action: no action

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
 .../devicetree/bindings/mfd/samsung,s2mps11.yaml   | 109 ++++++++++++++++++++-
 1 file changed, 108 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml b/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml
index ac5d0c149796b..684409e26273a 100644
--- a/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml
+++ b/Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml
@@ -26,12 +26,28 @@ properties:
       - samsung,s2mps15-pmic
       - samsung,s2mpu02-pmic
       - samsung,s2mpu05-pmic
+      - samsung,s2mu005-pmic
 
   clocks:
     $ref: /schemas/clock/samsung,s2mps11.yaml
     description:
       Child node describing clock provider.
 
+  charger:
+    $ref: /schemas/power/supply/samsung,s2mu005-charger.yaml
+    description:
+      Child node describing battery charger device.
+
+  extcon:
+    $ref: /schemas/extcon/samsung,s2mu005-muic.yaml
+    description:
+      Child node describing extcon device.
+
+  flash:
+    $ref: /schemas/leds/samsung,s2mu005-flash.yaml
+    description:
+      Child node describing flash LEDs.
+
   interrupts:
     maxItems: 1
 
@@ -43,6 +59,11 @@ properties:
     description:
       List of child nodes that specify the regulators.
 
+  rgb:
+    $ref: /schemas/leds/samsung,s2mu005-rgb.yaml
+    description:
+      Child node describing RGB LEDs.
+
   samsung,s2mps11-acokb-ground:
     description: |
       Indicates that ACOKB pin of S2MPS11 PMIC is connected to the ground so
@@ -63,7 +84,6 @@ properties:
 required:
   - compatible
   - reg
-  - regulators
 
 additionalProperties: false
 
@@ -78,6 +98,8 @@ allOf:
         regulators:
           $ref: /schemas/regulator/samsung,s2mps11.yaml
         samsung,s2mps11-wrstbi-ground: false
+      required:
+        - regulators
 
   - if:
       properties:
@@ -89,6 +111,8 @@ allOf:
         regulators:
           $ref: /schemas/regulator/samsung,s2mps13.yaml
         samsung,s2mps11-acokb-ground: false
+      required:
+        - regulators
 
   - if:
       properties:
@@ -101,6 +125,8 @@ allOf:
           $ref: /schemas/regulator/samsung,s2mps14.yaml
         samsung,s2mps11-acokb-ground: false
         samsung,s2mps11-wrstbi-ground: false
+      required:
+        - regulators
 
   - if:
       properties:
@@ -113,6 +139,8 @@ allOf:
           $ref: /schemas/regulator/samsung,s2mps15.yaml
         samsung,s2mps11-acokb-ground: false
         samsung,s2mps11-wrstbi-ground: false
+      required:
+        - regulators
 
   - if:
       properties:
@@ -125,6 +153,8 @@ allOf:
           $ref: /schemas/regulator/samsung,s2mpu02.yaml
         samsung,s2mps11-acokb-ground: false
         samsung,s2mps11-wrstbi-ground: false
+      required:
+        - regulators
 
   - if:
       properties:
@@ -137,6 +167,18 @@ allOf:
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
@@ -278,3 +320,68 @@ examples:
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
+                connector {
+                    compatible = "usb-b-connector";
+                    label = "micro-USB";
+                    type = "micro";
+                };
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
2.52.0


