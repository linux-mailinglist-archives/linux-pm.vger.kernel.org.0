Return-Path: <linux-pm+bounces-43645-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MARdBQcfqWmL2QAAu9opvQ
	(envelope-from <linux-pm+bounces-43645-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 07:13:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0A120B3CF
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 07:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F6543041B5D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 06:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92A02D8DD6;
	Thu,  5 Mar 2026 06:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zbHwmyTb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AC42C08BB
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 06:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772691120; cv=none; b=c7v1bkY/2KjpZeL+0HW/t+hDBZUwSnpPZy+7TLEVcPQ28e4h/MBdN8WKjd6ATN173oyh1q4cqFOkwlgA0VY9Zp4JT4TCpwfeXf0LWZPN5lrlheAYujq8X+qBrdC4mKDEywM8cl5ctV6nYEh43jEdbZU0Isod2r4gx+iL0kfWae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772691120; c=relaxed/simple;
	bh=tJrLoF1/TtxkwElfBX3P0k+hH3QFKNVAem9XW3Pf0N0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WF7LLDjfjw18hh+QYo2Eq3GF3iQbKfsuIjpvLKW7Rc3KhW/ZyeQNT9LBzrwuyP0EvxPBXjsENBKZRR2y69CFtwE4A+zj6A25XC5TEVO4YmVF9tNI1dxA2vympp92pEaf7FKfU80/OeHOrqP/oBmVoMX9Ij4KJ/hRp+W3ybicfX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zbHwmyTb; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b939cfc1e83so610652866b.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 22:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772691117; x=1773295917; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQtOQFVrniTIH/jIOVZYrUmJOb+M7nuCmtE/30pbV54=;
        b=zbHwmyTbDIJGeCa3KvuWsUDVZMahmgye5OBC2/axSu668t7/ZbhSpFiO4y2MCbLVy4
         yHjV3weD0hw47Z+oZkb85jTHyS8fY4j8EM0EaFwbybpSSHzlXvP/hrFUfSCBrx38MHcL
         iiiBqnlID46aCGFBlv+KLUPLsTGp0WnyRutJHU6AXOxnz0tOR6wyPzVM9U+q6YGIjwif
         3l1a8vW/UzLRJ1KD1ZXF8K5yYkPmTmVvmL3nP82BJ93CTW2ZE2+gKbzjFgzJ8D3+Ibw4
         S4weKwr+buVdiKrATaiGFFBvoDFt9bUiy3aoJDSMlMOgnse27sQohnWFGPLS4Qkxwp2K
         7czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772691117; x=1773295917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZQtOQFVrniTIH/jIOVZYrUmJOb+M7nuCmtE/30pbV54=;
        b=f/Gj3ERO4Uyz18PaeCNadFy72z9m2RGwg5/E31E3oQgSmdafcpWvPK6MXwLUaqVj/p
         x+tiW4boUG4tsfBr9vkjHNOxG6rfr7/YtVDQhEGeasMSo/EkIcZsVj6swsi8q0KSjDEd
         Ke7dby+46Oo8qrMyzmGP7YX1xDCZi7K2+AiTghWTztifqq95Isua+tUwlVtzFx9d7mxq
         rbNXoC1seIpWaGj+AxKygf2YPIN73mi7VOIqvFBYZYDPUQY61pWj1ghYXIsc8WIXRSqk
         cSWJKfPWexA2kuqOd6y1HdijrNVfQ3EmHx7vamBdXiM4DP1zrsIfRls2JSnPWhix4YPe
         hO+g==
X-Forwarded-Encrypted: i=1; AJvYcCWo2oNMmj5aGigJmmvYBASs7ZibPK08cuqyXCGOucrh0q+h2eRTXwO2fnHiqcohWH/rmZWazU1fUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxL15BVDQjwyIElfpHxDvQEHq1+pppdGnce8TYGC5cy9hM2Vl+4
	wiu8OV3HlUzOFFaRvIXDBDUlrKlBWGWcHzIYZPlDpD+ey3NoPWH0DXOL2t070/iY69A=
X-Gm-Gg: ATEYQzwbSLTagK1vvioDn7A+YkEPbQeuRSEY1GGvUtpQ7n0QTrWUYhKoWcB3A+J0Lxk
	9OPcXagp7prdCgPIQgtFHzcgwM4HNSHY7gkect2wToHwruriCH90uz2Vuk6/Fx1qulkcUbCstrH
	XjP3CnSLECus4OCR/qnwjcrQR8bJwc3bVY5/pHwPVbvw1hM1+rstBOFEQbbE0pDhctZTip8+Yfo
	U1wm9kjMJLyaCGl5Ii1U85YneN0JkPEkNv0o72UMjE5+F4LgQ97y7Rzxd5vJlcEhsn/qciMc6Q/
	WL9W82KCfMA55Ivn91k7HjJidwIwUBGPZJCXGKWjkdg/wm4GnY/SkItWz4oynf59QCD0VJV2HHN
	FyXeTDXioWFUQudWll/d5qTrEOx/7OJ706HN5mGP97jZnIqRyVG1Fq52Vu9lQ9olKmTrBga8TeT
	485bmrc4DusyCvr14+akoCA9xQ0ysscmjJcqW0+1v3vp67nqTmpNGf3tUHcNZjjYfr1FF9pwL6G
	hjuDFVjc1uFRBc=
X-Received: by 2002:a17:907:c11:b0:b87:fad:442f with SMTP id a640c23a62f3a-b93f1467ffbmr287511466b.42.1772691117024;
        Wed, 04 Mar 2026 22:11:57 -0800 (PST)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aec3243sm849355966b.53.2026.03.04.22.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:11:56 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 05 Mar 2026 06:11:53 +0000
Subject: [PATCH v6 04/10] dt-bindings: soc: google: gs101-pmu: allow power
 domains as children
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-gs101-pd-v6-4-8cb953c1a723@linaro.org>
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
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: EC0A120B3CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43645-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,0.0.7.208:email,samsung.com:email,1.10.107.32:email,1e00:email,linaro.org:dkim,linaro.org:email,linaro.org:mid]
X-Rspamd-Action: no action

The power domains are a property of / implemented in the PMU. As such,
they should be modelled as child nodes of the PMU.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v4:
- consistent quoting using " (Krzysztof)
- add samsung,dtzpc to example

Note:
Because the properties added are 'required', this commit breaks DT
validation of the existing DT for Pixel 6, but a) that's simply because
the DT is incomplete and b) a DT update will be posted once the binding
is accepted.
It is not possible to write the binding such that it supports old
(incomplete) DTs in addition to the full version, but as per above
it's not required to keep supporting old DTs.
---
 .../bindings/soc/google/google,gs101-pmu.yaml      | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
index a06bd8ec3c20..c1ee9575092a 100644
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
2.53.0.473.g4a7958ca14-goog


