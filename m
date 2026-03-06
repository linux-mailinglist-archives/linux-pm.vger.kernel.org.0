Return-Path: <linux-pm+bounces-43783-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J7qIIOtqmnjVAEAu9opvQ
	(envelope-from <linux-pm+bounces-43783-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:33:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D2721ECDF
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCECC31214FF
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 10:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C4E37CD21;
	Fri,  6 Mar 2026 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f1LOJGs5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA4F37C925
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792999; cv=none; b=B87C3WU8qbDlktgjlhDzXUNvqHhwsUVoW0xJrz1veLiBY5TLvCxVEL08POmryuVkO5iUG8xhinc2xMZce3mlnj1xdPL5UzBENQD2MxbZNzht9ceM6aj2YArurVquIZsuRho47Q/OSIMCTbs9fseBXbGly9BpwIV+0LNmAhhtLKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792999; c=relaxed/simple;
	bh=iALQKe1s8XYCZQRBPu9whaNUYAS1mnLDVYkgTcpyPr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=md0gW9+gSNQ9sHzAMPjIfgKOm7Bspi+X5L1PsgaGe+g46mNajAWSXV+pm/xQ9ivWo0JovIVNb5MR+4yh/U5qgg9vfHV5/V8QwTlLe+8GNSgWfozhOd+BK/AGXU1NnkwiTh3GNgh652KHsgZVvz4c4YrlbRj/D5Zo3esEd1RD0Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f1LOJGs5; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66132b2219aso2243940a12.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 02:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772792996; x=1773397796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FUcP5CBZJQtkRrAcWORzv320QMtIf9elaWuqQIxzig=;
        b=f1LOJGs5pWlcY+l4VxBI8Y0dKRfKoW7du+4GwEHr6qT7q8+ZqsvivPWlvLv3tD78A8
         VtZAI7AWRpbV14e98AOmNugaqRV8ol5CA6ra2pZAxZ4Jdc8Hb1SBeHOgRoGT1ZAVBYdo
         8GSaJ0euTsPJzOeXLL0I/Ur6bJvrggtybohvjWp/Lb0kGFXUV7m6rsa1MmFVuGaDwIMJ
         UlEtzVSClyeAroG6Rfxd3Gue6xG3P2KYDKdBZH3i6OWuOPoBpMk14WP/+nYYb2TQLfAg
         r0QsRzk43SfRjl45DP+iPiMgJpkfgV39VgasEqkuCE4MEU7Evo/mGAjFAPtUrYKt1qvs
         rF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772792996; x=1773397796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3FUcP5CBZJQtkRrAcWORzv320QMtIf9elaWuqQIxzig=;
        b=atiEhGFX05jDb91dTyvWV2I+MB1eQix86SV+vmkoEwQNa2Zxs/bTWkSuZn866L9FKs
         HbQ7zh3rHSLdKQ9RGl/UXIj8v0++6OzHYszPAuZIiSI6WECJ6PLNTPqumwMpUzXHv0ru
         PIbKQzj1/0xE4/pmsHmGlrrsDRR7hLD1ZnL/u1tmEjimHMl95qgtaQB0XMjM/W9YPGb9
         yrpMUwMheVVbD694JkH8nluHL5HlQUKSviHZ9PKNCQsA1gDQPQ2TUgFS+UpLYNWal7t4
         fIs5og/NK5Hs8SbH+eF4NfHw0tNAjzJj3cQ5nnC7yW5EW9r2k2s61ExZxKQRa4ni09M/
         WVIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnfU0R66YiMwTxe+lfO2FUkF/RXzmG78iQfUgUaIfON1Aj5sg70rUww+estMa/u3QY6eDtuSsQMw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4TV2pcrWkLIpTOXUy9JueJkzJNnd2wKaLCTh2A8AJ7CsoxHMn
	FdS5DL4UT9MtfqmzSjJbMLaf3SObiQJ2nCaH8CeWuzBzXfhcB26ASy48Y+vtECoot0w=
X-Gm-Gg: ATEYQzyuaRrKoqbd5wWMZPgIS4KrFY6ZD2PgiO0q+b4wFTJualcxxDXwx8vijNRlKGe
	jv0jrGdJi7+B/EL/GQr7u6etI1SQJPHMZSK8UlCal+EYYEYT6kDQfLfdjnOG8SvtII17ZWOMZOq
	nxN95he2GLz+0DPaBo22Bdk54pGmY5H6b5/wbJqRTd+DS7gensBnXyWUVnSaJYkKyLI0rQZezdM
	yV9ZvVq9VXPxuL6O2Zi9jmHHO2mJm1w017+EMeUvY5cUQZkkWRivCfK1/MkabCjbJTz+CYFNxBD
	JaIMYpGzOcp3EVCrQ5T+pPSWvOJPq4EkIYAROimUtc8ob2A/wu1mXi/QDgrya9GGGje4aCUtOXY
	B0ZN1dlW1qTIKYRAtYK95Uz8RHyyPScI19C/l98bK7T6tyPC1AXU1Pyar9WGln71HI4Wj74oTBc
	65QYiNWzMg2q/t+R5+GiK2w1a1bfChsbnCLCq0JuS8TJV5W5n7Bhban+23P/klMsODEWX3c1ZxY
	8EUe/b0qoolVVc=
X-Received: by 2002:a17:907:f816:b0:b83:b7c5:de2c with SMTP id a640c23a62f3a-b942dbcd35dmr93807866b.10.1772792995758;
        Fri, 06 Mar 2026 02:29:55 -0800 (PST)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942ef8c95csm42907266b.21.2026.03.06.02.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 02:29:55 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 06 Mar 2026 10:29:53 +0000
Subject: [PATCH v7 02/10] dt-bindings: power: samsung: add google,gs101-pd
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-gs101-pd-v7-2-03f7c7965ba5@linaro.org>
References: <20260306-gs101-pd-v7-0-03f7c7965ba5@linaro.org>
In-Reply-To: <20260306-gs101-pd-v7-0-03f7c7965ba5@linaro.org>
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
X-Rspamd-Queue-Id: E0D2721ECDF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-43783-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
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


