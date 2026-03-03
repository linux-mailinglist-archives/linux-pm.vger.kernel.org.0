Return-Path: <linux-pm+bounces-43505-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELc7B+kAp2k7bgAAu9opvQ
	(envelope-from <linux-pm+bounces-43505-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 16:40:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A031F2CFB
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 16:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 041F63185C0B
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 15:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAB148C8BD;
	Tue,  3 Mar 2026 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="oqkLLGo2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD1948C403
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772551983; cv=none; b=Je0aB3zTjGvTYpBqXa1hZWioLr2Mufykt7EsXVkt0YYGk7hHIBqyI2r4HTCLL/CYi4p2t3EFDgkPr+6sawWFyDu856bQQrIXcCPNXCbGhq3NUByk/4eatW5ZkMo10cdO5YDePLCcrNTGN1aKgv+3/4QnkvOx9Py8btz6nuurEMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772551983; c=relaxed/simple;
	bh=gbAU4zrwrEG67lPkWkojKT2Pi1hPLMXLErFJjWvmqxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r0+1lutZXJ80Jclpl1jUh7vxucnObcnFnZqRDIqQ0tDZGWLpsdWcPmdqKdmhfATS3NMZPI9qEXz9Hza++fK53Zkl73jYN+eqZUT452lEpj5atavRkBwq7oYTYf1WKJ/3As0NjyJ9aZlExl29Sw9DKYl1RrJgYh+FYrXvS/u/Ric=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=oqkLLGo2; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b7a87fb5so1426701f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 07:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772551981; x=1773156781; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0oaDOn0WoQIww/ZnO38d/qe82lVLUA14KTAKUsdavPQ=;
        b=oqkLLGo2zzmpXiRfHiNgvtcXzOijpZarRBOT9Z+G5/LhJ0ylVoSbRcXZEpcI6hE7Do
         +MZnhzf1rmKdat6ZKVdoICSOiy/6V2wfLvxaFlF6KdAZAs0y80Sq3DKMScYsWwek9KEY
         SpGRl1SaT2VSpS3qZX6r1snTAVBw7mpPdpgS7kF1Ywr8AEybLfqC8g/+c6GHBRQeix/y
         zDmb/oA4yxXvpbkCj8eLbzngnvsc4COZanNiHMT7wjqcFymFulu2LRhI0Pueph2y3Vy6
         7MwZDoQnWVy2HGGxus6f6HtRfxU5yUgJMQiEpm1DJQ0oToVhdxuQmbrjOfFRQwg7Y3Jc
         uBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772551981; x=1773156781;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0oaDOn0WoQIww/ZnO38d/qe82lVLUA14KTAKUsdavPQ=;
        b=LaXcMs1npExHUt4Txea3sCbKTSH9QqsNObYswSWsV3tvMC3z9xXSTV/KHsO0xv6yAR
         A/TD3cd9/4cGZ5L9VkRT5A+MIsKxhwm/Uktfwp3BzF8GdYYkWnBEKMO6z29C8R1ZHXfy
         RTSPXbZefxT7e+4IlGrG7vXdTKmh2irdTcaSGloWuWao99qzl64zzB8Qxcsqc8Ky5c7z
         YUb5GhBlvMe6TFrr7fZRh42ma6SzXZ9WiFsbxeXQJH0iPD+SVKfNxPdkjilbdvD1YwNg
         wL8Kll6JHJldRVOdm+omFtPyaRnHz6uB8l2PSdyOVIsoSyxt3eLTtFToEzwbj20vgeLx
         sRqg==
X-Forwarded-Encrypted: i=1; AJvYcCUIyWDPZbS1Mv/11PdsYLfFXrMhgGMYdwHu4/zXlIwo4fhYD5pjN4h8ciCMcNiEdGFknw8rLHzcug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6NfnLDR5YPjmwmwvwA8pLAEfc5lqfnnN//WIG8+1GB8MjAU/C
	DrD/4uDfPWh4SzxmculqtrNg1IfzHWrmCHurD6UDtvjMuljYDZXmbD3sfWfuThAMXls=
X-Gm-Gg: ATEYQzwHZoL17q+nu+KT2SnxsFuQHOGZDok/rgp3aTf5ETdXC6ecBmmjonT1IRyLVxj
	C/mNSWz7ZbgDOf7NY3ZLTTjWTftYIgIHa30h/UlI875kO4CO0F757zSi8F5BbSVGVMQjLcZCXM5
	nKhY+F9tAbytUoPwakTFj2HmRRiJuEevosBXXRzqHsjquLE3crGJocry0la4zC9IjN4C63uUCna
	4eMLy50SgSCGGjkWNDU/RCOyY/hHFrOCeEezjGPGQROKWowz8SnwNFbngFJpqGclzEKR77xh+eU
	T73/MEicOAUSaeNVkbd+V3GuT2u0E4o5hKxwYiedd0wdoGmZC2LU+HzDIDEtKl+RC0V9u6pslxW
	anDFwKPz3+JwpR8VD6xUBUarVMSZ9xHvrs2O+VkkKKFJ2TXBRADl84MYNeDOP5+AOg2+/6znOKt
	pRNzh6uhUynpWKJTUHq0xDAWw7vw54K2W2iVV8A1evAxXfX03af9nzdVmZjtP50XEiOGnD+wQmI
	ys=
X-Received: by 2002:a05:6000:22c1:b0:439:c018:60f2 with SMTP id ffacd0b85a97d-439c0186351mr5563064f8f.12.1772551979971;
        Tue, 03 Mar 2026 07:32:59 -0800 (PST)
Received: from alchark-surface.localdomain (bba-94-59-44-101.alshamil.net.ae. [94.59.44.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b55d15besm19799447f8f.30.2026.03.03.07.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 07:32:59 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 03 Mar 2026 19:32:46 +0400
Subject: [PATCH 01/11] dt-bindings: mfd: ti,bq25703a: Expand to include
 BQ25792
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-bq25792-v1-1-e6e5e0033458@flipper.net>
References: <20260303-bq25792-v1-0-e6e5e0033458@flipper.net>
In-Reply-To: <20260303-bq25792-v1-0-e6e5e0033458@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4128; i=alchark@flipper.net;
 h=from:subject:message-id; bh=gbAU4zrwrEG67lPkWkojKT2Pi1hPLMXLErFJjWvmqxE=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQu+6+m/jp+k5yUXuG982Z5fbkB6av9PFj4MhN5Trb1f
 FLI+mvYMZGFQYyLwVJMkWXutyW2U434Zu3y8PgKM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GuoY6xgxcHEKwFT/r2D47+DMreW4sfehk+e1Po8gri9zP5+ckFD5sabBrNhCUfbJOoZ/ikvnSz3
 ruXcxPqyINTt1YVNNR0y+7oeP6um/2+RiWx4xAwA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: 79A031F2CFB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43505-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hotmail.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flipper.net:dkim,flipper.net:email,flipper.net:mid,devicetree.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

TI BQ25792 is similar in operation to BQ25703A, but has a different
register layout and different current/voltage capabilities.

Expand the existing BQ25703A binding to include BQ25792, and move the
voltage and current limits into per-variant conditional statements.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 .../devicetree/bindings/mfd/ti,bq25703a.yaml       | 79 +++++++++++++++++-----
 1 file changed, 62 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
index ba14663c9266..99b4fba7c1d4 100644
--- a/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/mfd/ti,bq25703a.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: BQ25703A Charger Manager/Buck/Boost Converter
+title: BQ257xx Charger Manager/Buck/Boost Converter
 
 maintainers:
   - Chris Morgan <macromorgan@hotmail.com>
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: ti,bq25703a
+    enum:
+      - ti,bq25703a
+      - ti,bq25792
 
   reg:
     const: 0x6b
@@ -23,9 +25,6 @@ properties:
     description:
       Maximum total input current allowed used for both charging and
       powering the device.
-    minimum: 50000
-    maximum: 6400000
-    default: 3250000
 
   interrupts:
     maxItems: 1
@@ -50,18 +49,10 @@ properties:
 
         properties:
           regulator-name: true
-          regulator-min-microamp:
-            minimum: 0
-            maximum: 6350000
-          regulator-max-microamp:
-            minimum: 0
-            maximum: 6350000
-          regulator-min-microvolt:
-            minimum: 4480000
-            maximum: 20800000
-          regulator-max-microvolt:
-            minimum: 4480000
-            maximum: 20800000
+          regulator-min-microamp: true
+          regulator-max-microamp: true
+          regulator-min-microvolt: true
+          regulator-max-microvolt: true
           enable-gpios:
             description:
               The BQ25703 may require both a register write and a GPIO
@@ -74,6 +65,60 @@ properties:
           - regulator-min-microvolt
           - regulator-max-microvolt
 
+  allOf:
+    - if:
+        properties:
+          compatible:
+            const: ti,bq25703a
+      then:
+        properties:
+          input-current-limit-microamp:
+            minimum: 500000
+            maximum: 6350000
+            default: 5000000
+          regulators:
+            properties:
+              vbus:
+                properties:
+                  regulator-min-microamp:
+                    minimum: 0
+                    maximum: 6350000
+                  regulator-max-microamp:
+                    minimum: 0
+                    maximum: 6350000
+                  regulator-min-microvolt:
+                    minimum: 4480000
+                    maximum: 20800000
+                  regulator-max-microvolt:
+                    minimum: 4480000
+                    maximum: 20800000
+    - if:
+        properties:
+          compatible:
+            const: ti,bq25792
+      then:
+        properties:
+          input-current-limit-microamp:
+            minimum: 1000000
+            maximum: 3300000
+            default: 3000000
+          regulators:
+            properties:
+              vbus:
+                properties:
+                  regulator-min-microamp:
+                    minimum: 0
+                    maximum: 3320000
+                  regulator-max-microamp:
+                    minimum: 0
+                    maximum: 3320000
+                  regulator-min-microvolt:
+                    minimum: 2800000
+                    maximum: 22000000
+                  regulator-max-microvolt:
+                    minimum: 2800000
+                    maximum: 22000000
+
 unevaluatedProperties: false
 
 required:

-- 
2.52.0


