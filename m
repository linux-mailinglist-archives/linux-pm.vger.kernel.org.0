Return-Path: <linux-pm+bounces-43643-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHePFuceqWmg2QAAu9opvQ
	(envelope-from <linux-pm+bounces-43643-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 07:12:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAB220B37E
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 07:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE8D33017A89
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 06:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3922C158E;
	Thu,  5 Mar 2026 06:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V61lqGK9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343B629827E
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 06:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772691119; cv=none; b=GBBaJmsqJAyGJujz4ZpYziid5eiGOWRCiS93WdIi94x+MUp1U1oVL9wUuxlzMsbU7R/Xy3okDTaM0OnGm4ujLUp10uKwU5YY7ARyAhjDdGoFxyguKVyN6JLe8CkjX6hPYyB+ZDtBHW26UEFlZA39xiq/4zrkBoiolckPdKphx6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772691119; c=relaxed/simple;
	bh=iALQKe1s8XYCZQRBPu9whaNUYAS1mnLDVYkgTcpyPr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=imEz83Ifpk1eORqvCZsc1NdzHjSHJXW2yokSrBinAHMTe4ks4ahTLZE+76HcAmAK9jUaXbE1SUIyUwzN1YThW2gGvRnrbo4bYXv0bYTQICc8OwrnbX2FDizt2O4ULjPMzqlKbzz/v/VG2F5yZ4wbwMzPIHi8zGNy8Psw2hcHqD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V61lqGK9; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b936505e7a0so571133766b.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 22:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772691115; x=1773295915; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FUcP5CBZJQtkRrAcWORzv320QMtIf9elaWuqQIxzig=;
        b=V61lqGK9WTWnm29tSJDXxDUta9HQFJN1mC4P88K541f4zwmN/huESi8fzi7oiuSftM
         uQvQncjvWZzd/U7odh3wc3Zt4vZsIyb0dkHhkkCt141K5aQJBNgmBjErmXJtjwPn3ioE
         /mkQc2o0Kj5mMP82UyEC6XESEYlNkQSV38rlAkzztSrTrCUi0cCpJb5wDMEZvaaMwA1S
         qCjsfq5RD46hmlajAcmW3VijtPvrZCFAqqHiBx1ilQ0N0StHsQqGIuTypTjKA7mcZzYA
         jjYnBbX/oR7/iPL61eI9DtZloQdEQ4dd/aNFN7/HUunsp7FX2fmAl0UJcePvNN+bvTrj
         WFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772691115; x=1773295915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3FUcP5CBZJQtkRrAcWORzv320QMtIf9elaWuqQIxzig=;
        b=SSGSloT0a+18YLYlnNaIDuYGzK6qgJGcrc8vwY6gC9Ep82yhTVOz5XHO2mpJualyLZ
         zFG9ZDbNH4dMAtPIMtfbm/UiRNwF+ho4QyKmHI90ZmL57wP0jhvO1Of+2v7MSJMNktcx
         jPwGxeS/NVkncPg9jZTUxOFmMsG6zpdc11BcP/qZCHsJHyfaqJS1w9isHuoKgR1IjntB
         Rkzm9M5kZmb5+m6CoNfi0zNKxqveVaJHdDQChuqHlC5bEMks6LZYifcsXIYeY2c4XaoN
         anLX61q1uDf3ofXYyKJTdSx/ZvanBzwvsXaxr1CGt5gUSzWAMx+Fk98b/K1rYOa1NUU8
         uiIg==
X-Forwarded-Encrypted: i=1; AJvYcCWuN/CWvE9wdHxtZLq59wAmFSBIDns/QddzLDVmFo8UxuTc0W8rduPtN9DDTHPNJTjfKHIZSF7ZLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/e8syH8RhtjcTrghFwi/ItQQ83QctI3i643e3FMVeiZydpRek
	987Cw70bEUmqhNrCBItE7DOg0M/iy8HFHrIpBxyOxsmwHo3cHAiHgmG4EV9omnF86ec=
X-Gm-Gg: ATEYQzwj3OCsyZG5bRtRiVyLBlwoxZfkHfeHWf7f7q7BGgY6eKoj/25o3c1e94BxwC0
	09yoyQa5PeY2DpEXWPOizGabvRBR36muqIgIn9/TVRPh5BpoZYrPuKWG7Y8FQQIxVCwiHLNiiHA
	uFrMF7E2PdWbcY0BHJyRJ6ipeHbZa3+GhmFDVzkEGriH9o+67adbTWP0jpV1YdHhEYrLibO4N3/
	PVip4llpdALHKrBOnl1ou6PlaMl+RQ0jRgrK9/FLAUrd/crISudDgYGIx5iFYY754aWHd4gBuYQ
	kBb0XgVsmZo3rVHPQAy3phNI1quHIWhfNQJn2/cfJtIHSTHoaFt1XhA0ZtLGFlfUUJ95ZHYbjOW
	HC3UIge74GjZNSvq+1j8w4meA2cVv6RA/YVhXIBePFYW8lX8Q5V6RmBZxM+tLi1JpONe22RMzsX
	wBJ6PP866SBwRJZMoVm1uVmMTV8ev99Ljj+U7NClrOBYX7anp+nA7ulCaG3LgFX3Ladc4nfL3UZ
	0qC0SoTZ5V03os=
X-Received: by 2002:a17:907:7f93:b0:b93:5a2b:bcda with SMTP id a640c23a62f3a-b9409ef2b9cmr62071366b.29.1772691114572;
        Wed, 04 Mar 2026 22:11:54 -0800 (PST)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aec3243sm849355966b.53.2026.03.04.22.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:11:53 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 05 Mar 2026 06:11:51 +0000
Subject: [PATCH v6 02/10] dt-bindings: power: samsung: add google,gs101-pd
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-gs101-pd-v6-2-8cb953c1a723@linaro.org>
References: <20260305-gs101-pd-v6-0-8cb953c1a723@linaro.org>
In-Reply-To: <20260305-gs101-pd-v6-0-8cb953c1a723@linaro.org>
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
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 6CAB220B37E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43643-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,0.0.8.32:email,linaro.org:dkim,linaro.org:email,linaro.org:mid]
X-Rspamd-Action: no action

Add support for the Google gs101 version of the Exynos power domains. A
new compatible is needed because register fields have changed and
because power domain operations involve interfacing with the TrustZone
protection control on newer Exynos SoCs.

Power domains can also have a power supply linked to them, so add
optional support for that, too. It is believed that all (existing)
platforms could benefit from this, hence it's not being limited to
gs101-pd.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v5:
- add domain-supply and update commit message

v4:
- add new vendor property samsung,dtzpc
- drop previous tags due to that
---
 .../devicetree/bindings/power/pd-samsung.yaml      | 33 ++++++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/pd-samsung.yaml b/Documentation/devicetree/bindings/power/pd-samsung.yaml
index 9c2c51133457..3f1a2dc17862 100644
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
 
@@ -33,6 +31,9 @@ properties:
     deprecated: true
     maxItems: 1
 
+  domain-supply:
+    description: domain regulator supply.
+
   label:
     description:
       Human readable string with domain name. Will be visible in userspace
@@ -44,11 +45,28 @@ properties:
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
@@ -66,3 +84,12 @@ examples:
         #power-domain-cells = <0>;
         label = "MFC";
     };
+
+    power-domain@2080 {
+        compatible = "google,gs101-pd";
+        reg = <0x2080 0x80>;
+        #power-domain-cells = <0>;
+        label = "hsi0";
+        domain-supply = <&ldo7m>;
+        samsung,dtzpc = <&dtzpc_hsi0>;
+    };

-- 
2.53.0.473.g4a7958ca14-goog


