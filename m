Return-Path: <linux-pm+bounces-41624-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPMVC+w9emlB4wEAu9opvQ
	(envelope-from <linux-pm+bounces-41624-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 17:48:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D840A625B
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 17:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ACA530FCD2E
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 16:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD6231281D;
	Wed, 28 Jan 2026 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QCGdE3fl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2624230BF7D
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616658; cv=none; b=lsw6bQDHeOQzw085AjAwRG+S4A0R2fIkQVBVTfI2vhPowfaMz6hCWsMuwePPGNXWSDKtF9WuYynw3rhIFy4wau3/qvg8HSTUSDX4BQlKFEENory2LaQg/jNcWDfgbdZ01rSZ9dxgkwSFkA4uUhtny23kM8BWJ/5EiJbOyJZDedQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616658; c=relaxed/simple;
	bh=M1WMc4bY0aH9sS6wRakI3vA4XiZlzBJdIzFnhwIKKcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ba9w+rMVxTx1zZ3mAgn14HJb+lz3T+Ac5ItzdiI80WqyczS4cFDjAeUBGrN1yYBR2X25nAdLhWXYIgri4LD6oQGtQdDO9+d18+5vh48qwf1/m8MGxmV7lSEGacrv2QEElRTv1i7hHmgMInxDxbgZSa+vPBZtk7s10SMuSyzXXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QCGdE3fl; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b886fc047d5so890321966b.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 08:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769616654; x=1770221454; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gll/OtNLbOWiVZ7Gkg5CJPf2dV1v2rLa1U/xCUl6ltg=;
        b=QCGdE3flOmY5lA7z/CGTDgaVRgJJhCgvFzPhY+UUOLyluMevadnWBPAthao6Ob6fzt
         fM0ofd/t/u4DuJYNdu7J2CHa1tTjwksp0c6qr0bMC04JCUnZFdB/Ha8XsbeH722Dbgr8
         q8IuQtbHDDFTtYw9/4idzi3KOJeX6vpW+xGSgZbthE6D19rCJq6nHy8w9eyXcR5Gu1Qw
         8Zn/vDkz7t25RHFJAIL4JBlAE1ZZZq8UVlPJAV5yjrQT47ruwHEKE4v063h/eMKsaFoZ
         MoktD3oI0Lcw6pOrErNIba9U/Nj/sjQPzgJsgMkmhzwq7ca2uA1XOrEIsrEKjpwdPYQn
         Ugxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769616654; x=1770221454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gll/OtNLbOWiVZ7Gkg5CJPf2dV1v2rLa1U/xCUl6ltg=;
        b=plPCpFKfFcAtTzKYkWFRfttHikshTx0LSZ3LgY3zpbbUYY5mGGMEoBrplpeFJnKdlF
         7sEb/hv3w4PuL7FsP5uSXJRSPtXRIW35lNwZSsm69j309sINCOklAEmlQmMxJlZ9l6ST
         A+5dP/G8KUcrVoz5KxXRMKxdargJLwE3237RJ4wigBagHp6lqrq2A9naazrlrxElXyhB
         CGr9ZYupZ52OCGThOqihrwgJO4b6hFEEfGX3GRSOC8XcVQ7OILWgwyc0G4Uyb4w95Y6a
         uORmgs8P7jQA1tLaQ4Qs4Tgr4jW6r8G31R9PoVMiZxgqTJMIkUetef5iCv4RovA6Pne6
         zURg==
X-Forwarded-Encrypted: i=1; AJvYcCV4on7v6Rx2dWYJfvxcK/Hbf8H53oX27dsP8cYoZPzqdujqRjAxEMxFQe+KzmhWH6D90d0Eu/Ckmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUKRiQxOsNyJ/WX3xr/SbhuuGx/9JP9bOdmm1PZEQQq0vzRPyk
	p7TKhbMazUkB69roCR8aVyPtmwmd8Jhw67dPdltrKC9cIvNhs7+ihmpGk0Mf2NLvLbw=
X-Gm-Gg: AZuq6aLbCONI4W9o68YVKSHlrUtqqjoVGu0Rd4v/Kt+fQ5mrqR2a9h3k7ub3a0stT0s
	LMDu8Kv9frJJOMZwirgSmlC8r/V2l12fIknHe4UYDNBXcHj6rsYVfoknfn1WxOFoT/3wU2zFtc8
	H8WdwT4YVFiMXKAML44V9XDs13Z76ihCjo+abD7Y0qDuNbrv5PsJQfsE3qDGSj+WcbfCQCqxKF6
	ggAJnuY33d2W42ePomqBYt+GX9tQtEcY+KcyPgmwUnVdS+b+70+w5yoiveDM4vnnybyRnbdJrS3
	5i3+7U6T042zQoLjYa4iJIO6Im1LnedeQW7bytfIaDDIZLHB+KSFWGX81AuCean1hwbcxLGs7xK
	IJRvkYXOtR+QFkIV8esP1LT3eWTjjGhONDjZFC0P1EMtvKk6dVp9pqs/LkA57uC1zvtdMzMrQaR
	VGMBmVHFWo8h4AhbO34RkmKkEcV3UcznT2gbXN0jkYQ2drb3Ipvcvz9YnQiti7dN4olWPaeC3ji
	6pSYw==
X-Received: by 2002:a17:907:c28:b0:b72:70ad:b8f0 with SMTP id a640c23a62f3a-b8dab423008mr381662866b.36.1769616654219;
        Wed, 28 Jan 2026 08:10:54 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf1c021fsm148553366b.49.2026.01.28.08.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 08:10:53 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 28 Jan 2026 16:10:51 +0000
Subject: [PATCH v4 02/10] dt-bindings: power: samsung: add google,gs101-pd
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260128-gs101-pd-v4-2-cbe7bd5a4060@linaro.org>
References: <20260128-gs101-pd-v4-0-cbe7bd5a4060@linaro.org>
In-Reply-To: <20260128-gs101-pd-v4-0-cbe7bd5a4060@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41624-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid,0.0.8.32:email]
X-Rspamd-Queue-Id: 8D840A625B
X-Rspamd-Action: no action

Add support for the Google gs101 version of the Exynos power domains. A
new compatible is needed because register fields have changed and
because power domain operations involve interfacing with the TrustZone
protection control on newer Exynos SoCs.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v4:
- add new vendor property samsung,dtzpc
- drop previous tags due to that
---
 .../devicetree/bindings/power/pd-samsung.yaml      | 29 +++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/pd-samsung.yaml b/Documentation/devicetree/bindings/power/pd-samsung.yaml
index 9c2c51133457112ca0098c043e123f0a02fa1291..4ba555e11b30e6a9aaed457bcb57765bf5b481e3 100644
--- a/Documentation/devicetree/bindings/power/pd-samsung.yaml
+++ b/Documentation/devicetree/bindings/power/pd-samsung.yaml
@@ -13,12 +13,10 @@ description: |+
   Exynos processors include support for multiple power domains which are used
   to gate power to one or more peripherals on the processor.
 
-allOf:
-  - $ref: power-domain.yaml#
-
 properties:
   compatible:
     enum:
+      - google,gs101-pd
       - samsung,exynos4210-pd
       - samsung,exynos5433-pd
 
@@ -44,11 +42,28 @@ properties:
   power-domains:
     maxItems: 1
 
+  samsung,dtzpc:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Distributed TrustZone Protection Control (DTZPC) node.
+
 required:
   - compatible
   - "#power-domain-cells"
   - reg
 
+allOf:
+  - $ref: power-domain.yaml#
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: google,gs101-pd
+    then:
+      properties:
+        samsung,dtzpc: false
+
 unevaluatedProperties: false
 
 examples:
@@ -66,3 +81,11 @@ examples:
         #power-domain-cells = <0>;
         label = "MFC";
     };
+
+    power-domain@2080 {
+        compatible = "google,gs101-pd";
+        reg = <0x2080 0x80>;
+        #power-domain-cells = <0>;
+        label = "hsi0";
+        samsung,dtzpc = <&dtzpc_hsi0>;
+    };

-- 
2.52.0.457.g6b5491de43-goog


