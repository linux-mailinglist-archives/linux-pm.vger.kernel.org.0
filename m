Return-Path: <linux-pm+bounces-43829-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPRiKcHmqmlgYAEAu9opvQ
	(envelope-from <linux-pm+bounces-43829-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:37:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E54E222CEB
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 15:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E2E13155A47
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 14:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB333921E6;
	Fri,  6 Mar 2026 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="g0gDN96p"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467D9271A94
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807597; cv=none; b=HM7pdnfLw4lqjfmz0B9W1h6dmCX0ZwH3VUtryK/mmFDAN2laXaubwh7B7JXpEPnJk6mhn5XUzGZeGuMug2NCQ3M/q4grrnKFdbEfzh1mkJakntovAUh+7kSDIN4tBKKugyUPqgiI8XG8oEWZxjTnMYi3OIk6zu6i7qxFMwbaZNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807597; c=relaxed/simple;
	bh=58YP2dJRgAizAOikYaKjM/irmjn+e7RczszyYkhkS9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ItV5GL2gydtABjuZ9ipxcpyhRAPtdL2xmK8X0ZQPW2EM7+iJrg08gWjT7xR1DQbkbBt6bMPmJ0qbhT7hOtPwRdY2nHefzSpvSTvn8JZ7k3LRB458QFQjAKoPyV3WyIDqzKYVS1KW63UWcvjUtKZtOx5uuMCm2evuUsq1w02Ih1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=g0gDN96p; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439aeed8a5bso6421522f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 06:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1772807594; x=1773412394; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jt/bQE8Be9/7vIBUKX4+9xpaDCMMIJNvl2zw+VOvhnY=;
        b=g0gDN96pc3H1b+eveNBdoH6ko0Exh0Vn1npPf9W4gp+ELRvpKg6pIMmGbUc3X7JjZ8
         PUd9CFrCsL2D1BdjI1KvnlMSaePMUeGq1h4VWXXuWS7k+W6c1B6gSXNySjZEZBGOAjtN
         ZRaxYSybu3V/nf2NqC3/O3uR74HVGqRKh/uNF8ZjuhTBVOwZlj0s5fOifyAv/grLiP1D
         g0D3C4bqtQ3foTm9H0egWAXzxdqIrNv9VuUDrgLKezHTeyErzrxjmejTLB1cO3McGrn2
         CPWA9eun6iXBDRp7dmwuoHrb3zmbf8UMaysk381gur0JR7O2k+fSOm6fteSdMo2BdNA5
         ZDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807594; x=1773412394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jt/bQE8Be9/7vIBUKX4+9xpaDCMMIJNvl2zw+VOvhnY=;
        b=jk1mxDQu6dYfh20BlqdmC5Bql/mR2Ih5tmFKfLbbODx7TOV4kQOVPnMkalyoqtahzj
         lvLPd/XMHG3QlRE5HZI9e1TsyVuZs/h2ioPYFQM+Ag+VtMWAjE/x0p8RgP2/EzdSP9yK
         tYF9CV05z+dEudnjD0O8lf0wp1w7Hr2rysfKqKUmGumnBtBXCAlUvlwde9fbdY/eNqfr
         KKZpN1CHXbiRC7yC8y2X8ySBCVY9kqmOZMqH3sWGGd1n2oCGRIaBa8uNFAyll3KNuqRI
         ktN/zYNK2D/xtoM93X0pIGVXPXK1g68FS/CVsHSzk6W0emv5A3F35u3rKBrSahz2uNI5
         ilSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPFlYkLR8G2gBsHUMaOPU3oh+j4oyW/mhV/63/VZIT3qFfVIsqJw1mvzz0u7PyY54U8TSMZSPGkA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5HIhZgY0LJGvuEDt/1x4fKFrU3h7FcTnmLjEywuX08fXKhJOT
	pj6uymSpwZJxzAUERiv9NzDORczuf5/nQiO3FaBvlrH5n4ZhP0bTGbNOOSnTB2kwmnE=
X-Gm-Gg: ATEYQzxykERl5WycjAGCDAEg81TFFojoSe0N1/uTlhZXNKvMTMmIf8h7CHaTIUpS2ph
	hMSlEb6oB0W89o+JpXgLRtWVz7OnQGzPsqfUtw9oMtPgzfhUmhIjL0LLUL2DTsjbt1oSiAjaYTT
	G2XGtOgUkKsWUXwqrPJkzu778IyKBpPmTEpIx0A4uqbrtKWxB39sCaD3AYoD09+bT2ZLacWXnZI
	Mm65+MnyvQgela5YZIgZC31QCuXRAE1/RtB7mn1y0tc9fyAqzvdbnlye3rUZbQTLlAHlMCBmGb0
	gKwQVLw2Tz5jg2umU7Is5ygOd7JwujYoOSOc9bN0U366JII+7odH34XuWIwAzLJQ6Dqq2k0+MuJ
	cZcJ8AU87XYhpie8CX3YMOUW+Na47qmE7MMyCZxC5PhrVL5Yufucqe8irLN70SSgoFMGKp8tYmK
	anGSQVdFG+te005CjqbRNvWkk0XM5E0iVsNok2av99EX4RzGjp/eN4GzCXOTkd3jYYUEOd5er6g
	bTHbQ==
X-Received: by 2002:a5d:5c8a:0:b0:439:ac98:751f with SMTP id ffacd0b85a97d-439da65764cmr4107142f8f.23.1772807593609;
        Fri, 06 Mar 2026 06:33:13 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8daf2sm4635281f8f.2.2026.03.06.06.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:33:13 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 06 Mar 2026 18:33:01 +0400
Subject: [PATCH v2 01/11] dt-bindings: mfd: ti,bq25703a: Expand to include
 BQ25792
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-bq25792-v2-1-6595249d6e6f@flipper.net>
References: <20260306-bq25792-v2-0-6595249d6e6f@flipper.net>
In-Reply-To: <20260306-bq25792-v2-0-6595249d6e6f@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3798; i=alchark@flipper.net;
 h=from:subject:message-id; bh=58YP2dJRgAizAOikYaKjM/irmjn+e7RczszyYkhkS9E=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuero4VYovWf7P7kmhP2IWiaW2vvps0vCwm6f82eKKQ
 uYkqcovHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oaGOsY4RAxenAEx1gh4jw8TnCx92iPPs9ZaZef5tCBtXYwDT1NpztxyXhjwN7E47MZORYZNpoNW
 7XAFNk9Uypct+i9/+PH39h5uaF5pM1rzivmLBzgcA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Rspamd-Queue-Id: 0E54E222CEB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43829-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,hotmail.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,devicetree.org:url,flipper.net:dkim,flipper.net:email,flipper.net:mid]
X-Rspamd-Action: no action

TI BQ25792 is similar in operation to BQ25703A, but has a different
register layout and different current/voltage capabilities.

Expand the existing BQ25703A binding to include BQ25792, and move the
voltage and current limits into per-variant conditional statements.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 .../devicetree/bindings/mfd/ti,bq25703a.yaml       | 73 +++++++++++++++++++---
 1 file changed, 63 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
index ba14663c9266..cdce83f05804 100644
--- a/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,bq25703a.yaml
@@ -4,17 +4,16 @@
 $id: http://devicetree.org/schemas/mfd/ti,bq25703a.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: BQ25703A Charger Manager/Buck/Boost Converter
+title: BQ257xx Charger Manager/Buck/Boost Converter
 
 maintainers:
   - Chris Morgan <macromorgan@hotmail.com>
 
-allOf:
-  - $ref: /schemas/power/supply/power-supply.yaml#
-
 properties:
   compatible:
-    const: ti,bq25703a
+    enum:
+      - ti,bq25703a
+      - ti,bq25792
 
   reg:
     const: 0x6b
@@ -25,7 +24,6 @@ properties:
       powering the device.
     minimum: 50000
     maximum: 6400000
-    default: 3250000
 
   interrupts:
     maxItems: 1
@@ -57,11 +55,11 @@ properties:
             minimum: 0
             maximum: 6350000
           regulator-min-microvolt:
-            minimum: 4480000
-            maximum: 20800000
+            minimum: 2800000
+            maximum: 22000000
           regulator-max-microvolt:
-            minimum: 4480000
-            maximum: 20800000
+            minimum: 2800000
+            maximum: 22000000
           enable-gpios:
             description:
               The BQ25703 may require both a register write and a GPIO
@@ -74,6 +72,61 @@ properties:
           - regulator-min-microvolt
           - regulator-max-microvolt
 
+allOf:
+  - $ref: /schemas/power/supply/power-supply.yaml#
+  - if:
+      properties:
+        compatible:
+          const: ti,bq25703a
+    then:
+      properties:
+        input-current-limit-microamp:
+          minimum: 50000
+          maximum: 6400000
+          default: 3250000
+        regulators:
+          properties:
+            vbus:
+              properties:
+                regulator-min-microamp:
+                  minimum: 0
+                  maximum: 6350000
+                regulator-max-microamp:
+                  minimum: 0
+                  maximum: 6350000
+                regulator-min-microvolt:
+                  minimum: 4480000
+                  maximum: 20800000
+                regulator-max-microvolt:
+                  minimum: 4480000
+                  maximum: 20800000
+  - if:
+      properties:
+        compatible:
+          const: ti,bq25792
+    then:
+      properties:
+        input-current-limit-microamp:
+          minimum: 100000
+          maximum: 3300000
+          default: 3000000
+        regulators:
+          properties:
+            vbus:
+              properties:
+                regulator-min-microamp:
+                  minimum: 0
+                  maximum: 3320000
+                regulator-max-microamp:
+                  minimum: 0
+                  maximum: 3320000
+                regulator-min-microvolt:
+                  minimum: 2800000
+                  maximum: 22000000
+                regulator-max-microvolt:
+                  minimum: 2800000
+                  maximum: 22000000
+
 unevaluatedProperties: false
 
 required:

-- 
2.52.0


