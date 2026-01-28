Return-Path: <linux-pm+bounces-41626-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG4tAzg2eml+4gEAu9opvQ
	(envelope-from <linux-pm+bounces-41626-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 17:15:52 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCF7A558C
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 17:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58E8A3087222
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 16:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AD3314D0D;
	Wed, 28 Jan 2026 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z4piCGdm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F123630F52F
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616660; cv=none; b=SzV+1r8n0v4ghZix1KC/SKnoP98XlQGZuNOYIIHelmJuaeKezVb1OIBGuNxc5gHMzl1PJAsx1Qv3GG5P9NuklvcxNTHHYO8L9J9hdRJ9sx8LhThGa1cbiL/xvP5mzYXQnP6J8dBCVH63sa4CdJCpEZUNXFEhQRQypx6lTVWLk44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616660; c=relaxed/simple;
	bh=wjPITGHpFGOjs4GBxlDoptuom/l/Q78c7MNS9UVGVac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nUTpnWL2Z3tlHdUaBmwZG+VE2+pQBtAcLihFwNr8pn4tka6h0nSJ9B5EFwakUl0a3qN5ggOYfl9u/1JmOcS4e1xK6ZcUxwR4LOZLOK2h68z84EANDDPtkCMxjwYyHA/N/N26EmM7g4rWyw6ojNXmjqEmAeMN3+uFeszBnoJIBVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z4piCGdm; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64b9dfc146fso42765a12.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 08:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769616655; x=1770221455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYVOKvbh+cV5QpKAWjih0XGIXXiGAQB69mHgAD7pq/8=;
        b=z4piCGdm8kMXQje7iWnuiESnv1MNEkLN6vKf/Z6CJxP2q1h/ziIPp1b93mvG0sxwYh
         CXUhtJwMKVFOlOO7ZiMfWRZjQT734pAiquV1jK52NyFGP2gsSKScX5FSp0K0JrgFYkmD
         w0VHaD2cCvPzKD4J7Essgt+UcHKbirud69CRSIUeUoP4Z0qiYK8ZD8HaPDcaDq3laa4h
         TGDZZP0kw7b/DPf432YoxfKFE7lUE4/kQn9mFgjdaV3UQ34sT4shPlpjUgBMfMl5Etzk
         KnBKYZiz9wHdH4idzKJZiS9/uwlPOSWUvWDtk0frKy8NFg41IaedeKXeKXGQPYxueHnQ
         rr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769616655; x=1770221455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CYVOKvbh+cV5QpKAWjih0XGIXXiGAQB69mHgAD7pq/8=;
        b=k2/9eqQfBfP+IwCU/d7RRqtIxppJ4b8O8hdjgcvd9QAQfq4iEyngveVJCAk54CAlyy
         cjQ59HAj8mb+EyqZ9JFEmVwqqfMTZBs4SZ1X97M7gsSptSW7PoqMeAwSDoghPLb3EVGw
         eDscDcU9mukILb6LuzFVrej/UdKCIFBe2Aa5bqOgGzBqDT75dG1YFgaT1mEEPe9dOnCO
         keJSbdfgh1qXgkGwB8hTw/LLE8fJkG0XCpY8knK8V8mDTEpteW/kKSpH4mvOsxUFIa5f
         okZGZ4K7YLI+eb1PCe+ZNx1BquDk1nCOuYTIq3Oqreu19p6y/QwzXKzEl55XaV6MXjae
         JCKg==
X-Forwarded-Encrypted: i=1; AJvYcCVJBD6oB9zXhWvy0IT/XIJ2izp+uCmLXpAmbMr6D/z5kH7zPBuflZJ5QKC9yqdo57xn84cjfvAHiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOim40u94+ugZ4WPASuvfZ3spG7cd3EHpMYNYA1BlohdXByf5e
	3x8y8etBNeozOUr7a7eJKVIR7SyMiDMIBuY49dhpca5COpfXLw8Gs8i4oePLvlebnic=
X-Gm-Gg: AZuq6aKF2aBIrFFAq6m82A87d177tLkqcmAYB4PP4n29zUJ9eJNRotTsTVvKB40ClqR
	9ntZD7/ZtfX6GHkEZ5Kxt74Eo/2eNTjmj64RoN0ST/6oiPtEIPf8R8KxTqUaf/Oo0v9/urKyTeM
	RGtA9QoJRhC8S2TnAaWFNlIizMGpAxnaKzuqGA8GlXKP/Ju+30OqPO2EuGVArG73c/lQO3S/v+E
	ACW89nW/QdfDrHSNAyDGdgbUeY9qOdM4lSJks4RwE6gZmtkc9EPQmrCUefXt0Cr+Nfaq+/oy6OU
	t//v5xxW1anhWDCWaZVFWw8m1N8fYFbUIY+f0cv06aTFwhSdXpldaBiSsME/pOBPdlIHehTDiLd
	IOStHBqPthNnU4fHQ27PtoOFapUsIY5CYUodR3B/LEMwvylJpKY9n+6yoOoPRPbhqdGUxkM43pq
	jkQD6s7kDUl1j/MMxE/UJM0v7iVPbdEvsCfY6mW5LwpTCgcDXUEqXMuCGUbuFFCCl4BdReH52Ml
	rBrHPtuyEbZ8L3W
X-Received: by 2002:a17:907:3f21:b0:b88:20c0:d37f with SMTP id a640c23a62f3a-b8dac9aacf6mr387798666b.9.1769616655313;
        Wed, 28 Jan 2026 08:10:55 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf1c021fsm148553366b.49.2026.01.28.08.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 08:10:55 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 28 Jan 2026 16:10:53 +0000
Subject: [PATCH v4 04/10] dt-bindings: soc: google: gs101-pmu: allow power
 domains as children
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260128-gs101-pd-v4-4-cbe7bd5a4060@linaro.org>
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
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41626-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_PROHIBIT(0.00)[0.0.7.208:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1.10.107.32:email,linaro.org:email,linaro.org:dkim,linaro.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:email,1e00:email]
X-Rspamd-Queue-Id: 8DCF7A558C
X-Rspamd-Action: no action

The power domains are a property of / implemented in the PMU. As such,
they should be modelled as child nodes of the PMU.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v4:
- consistent quoting using " (Krzysztof)
- add samsung,dtzpc to example

Note: Ideally, the newly added properties (ranges, etc.) should only be
'required' if "^power-domain@[0-9a-f]+$" exists as a patternProperty,
as they're needed only in that case. As-is, this patch now causes
warnings for existing DTs as they don't specify the new properties (and
they shouldn't need to). Only if DTs are updated to include
power-domains, such an update should also add the new properties.

I've not been able to come up with the correct schema syntax to achieve
that. dependencies, dependentRequired, and dependentSchemas don't seem
to support patterns. Similarly,
  - if:
      required:
        - ...
    then:
      required:
        - ...

doesn't allow patterns in the 'if' block (or I didn't get the syntax
right).

Rob said in
https://lore.kernel.org/all/20251010141357.GA219719-robh@kernel.org/
that this is a known limitation in json-schema.
---
 .../bindings/soc/google/google,gs101-pmu.yaml      | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
index a06bd8ec3c20faf0b364d3d3ef1763502c2b09cf..c1ee9575092a3ab17873d228a88468addb62d838 100644
--- a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
+++ b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
@@ -16,6 +16,14 @@ properties:
   reg:
     maxItems: 1
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
   reboot-mode:
     $ref: /schemas/power/reset/syscon-reboot-mode.yaml
     type: object
@@ -39,9 +47,23 @@ properties:
     description:
       Phandle to PMU interrupt generation interface.
 
+patternProperties:
+  "^power-domain@[0-9a-f]+$":
+    type: object
+    description: Child node describing one power domain within the PMU
+
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: google,gs101-pd
+
 required:
   - compatible
   - reg
+  - '#address-cells'
+  - '#size-cells'
+  - ranges
   - google,pmu-intr-gen-syscon
 
 additionalProperties: false
@@ -51,6 +73,25 @@ examples:
     system-controller@17460000 {
         compatible = "google,gs101-pmu";
         reg = <0x17460000 0x10000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
 
         google,pmu-intr-gen-syscon = <&pmu_intr_gen>;
+
+        pd_g3d: power-domain@1e00 {
+            compatible = "google,gs101-pd";
+            reg = <0x1e00 0x80>;
+            #power-domain-cells = <0>;
+            label = "g3d";
+            samsung,dtzpc = <&pd_g3d>;
+        };
+
+        power-domain@2000 {
+            compatible = "google,gs101-pd";
+            reg = <0x2000 0x80>;
+            #power-domain-cells = <0>;
+            power-domains = <&pd_g3d>;
+            label = "embedded_g3d";
+        };
     };

-- 
2.52.0.457.g6b5491de43-goog


