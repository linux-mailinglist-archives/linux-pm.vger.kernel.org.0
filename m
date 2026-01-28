Return-Path: <linux-pm+bounces-41623-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLz8GuY9emlB4wEAu9opvQ
	(envelope-from <linux-pm+bounces-41623-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 17:48:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C216DA6252
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 17:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5DD1318607B
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 16:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B759B30F819;
	Wed, 28 Jan 2026 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tq8UqCiS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3C01E3DE5
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616657; cv=none; b=ZfWCuKz6xFwoIw/LLWHAcURok8w5kW5W708o9Ds8dA5dnCptMn2fS4N8arDXmVjksjANQ8lP+iqzqIt+/W9E/SSPW3ye+NrIuDHnkKPlsDULK04nA8jI7QkVCvUwytNz+Yafok+3U8mcalvRyb/pvlybFBKs/dVrENte3//NBoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616657; c=relaxed/simple;
	bh=MsoVcEJe0MhQwSs/kIxrngmiJYPnulx6/TKC80irjeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hq9SD0KsNMHzhTGFaboxp3vitdV59sOXbRpLOrmvZqL0jKq3Ybbj25S6UTJLk57yvJRGv7rt32YHWj9CH1ilgikzu6iKt1sTT8NhMWCr3mGG5XsoXhny6fbu4+vPiBTPe9CHmEpm9NbpgXVvdvpQhI0iLXtRMuZnMmUifHt2px8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tq8UqCiS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b88455e6663so1314466b.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 08:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769616654; x=1770221454; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c1M488vXqKcrQj+Jd5yyT2ZpNnjcHsZKW7NNZqOuyYk=;
        b=Tq8UqCiSTkL6ZHa17gsf4E1qldJ32PNfHq/rgklwJ57hWzw0h4dnkpU0ysfBYjPKCJ
         xTg6C8GAemty4yI5SVfQ64UTVU/a/33xwtdOrUvforkezEkgC/53WjNkJkdfuMEjbKxe
         MEqc0k4I0+7ypvkqQiL4KW08LgeBEfgK+F15IB7z8wNqbq/Dm3/TvMZChsaov7IEMkNl
         lYFOrgIVlyaLDzaxF3KaH9lT7O9IDZFakRLPNXkW3vhnxAUeV42sblFeZQq78LcB+o0x
         RUdaFitBsp827GANNJqn+CAjuFhrNeK6mRJc9eyFVYBPbx94sdsigs/ZBLPbL+oEfiyO
         n+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769616654; x=1770221454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c1M488vXqKcrQj+Jd5yyT2ZpNnjcHsZKW7NNZqOuyYk=;
        b=ojM89dLtQ3V4per6T6w1h+xKj1XQMKUmbnl7lXKHgITAQhcbUrnlqHd7bZva1hthHb
         kePty1aT1nHZ2h6uiU2pIKUJ4p5exzPkVCy+fiJa5f6vwpe+yYQT+qHsBQEFb7M0RxsG
         zjanqe+TTY8xEbc7xPdF+7XJANjp3UkVIxNhcqgixQduB5hwQZ2YE3UF/7x0SZM6TXjZ
         sdJ5z/RWR9ZMKQu3ks12RVscShO9GMMsYk9tzHyTD3lx0TYomCbXuUmE9Pan8aeuR7sM
         SYTzxQGWSyzADFTCHic3+56mMRXHHM6uG/zwzwmr2koLk8Y9o6tNjoYj0MAx7CED9HNb
         ZSZA==
X-Forwarded-Encrypted: i=1; AJvYcCVXWgtsbdK3H9fEm/aZaksBTQec9gNgTl+LrQCkedMWmCqD11aSFVdCMi462+0GGInM192nHmKt1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwX+nriP7HaD55AWKBRLIrWohP9/rZOnsyrLrWV3FS+WmksiqmJ
	YpO/TtKMHd7I92i6956lx1UOHFgwhHj7QkKxMXNmhGILEQrOF2FrQQ+OGAxfyYfN1jY=
X-Gm-Gg: AZuq6aJRBCg+2//Q7cX09eAnwTVIWA0Q/wIXjceAtZ6+rqI/yOUhY3jLOsGv4Kdo0Cl
	0gK1WLXRXAyPNoYggNAfzY2GELmddxG52pHnUlM9YMvkyxy493Vw/Vl8lhKsNX0z6clIyQMeIh4
	G67F5nSQEIhPM7Zq3oJsTh+oRMcqg2C2zKA7Kbpjjjj/pGQnatlQc2nCN0J1WHPe4MeTf56cAjO
	RoTtm5ZwsIHCiSR8Gv1HlEYL0UUCCksnBz3RlDTks77ain9K21YtdBGpA++QRWFTF5tZXQ3a9tM
	wQwCjvwe6oJ3AJ8THmSKN0gYiGHMt1wSnzEiH1VU2BvnK15rDrE3pB3fcX3pbIE6wlhAoHOKq07
	/eZodZCoiFh68YkY5iGnfSu8mzoOU2mIiFPDvHgKmP+lbKttrjO/PX1QlmKr7E8gqdxbCYj7FqU
	9pC47oMIAX8uhe0qkev7nQLB6MrjLl3+BC7/dYdmeb/M1crnvmKh4APpXsNJZs2gLxq+Gh6yaTf
	aZFDw==
X-Received: by 2002:a17:907:7f8f:b0:b8a:fae9:5c60 with SMTP id a640c23a62f3a-b8dab3aa7a1mr404537966b.51.1769616653505;
        Wed, 28 Jan 2026 08:10:53 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf1c021fsm148553366b.49.2026.01.28.08.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 08:10:53 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 28 Jan 2026 16:10:50 +0000
Subject: [PATCH v4 01/10] dt-bindings: soc: google: add google,gs101-dtzpc
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260128-gs101-pd-v4-1-cbe7bd5a4060@linaro.org>
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
	TAGGED_FROM(0.00)[bounces-41623-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.167.255.208:email,devicetree.org:url,linaro.org:email,linaro.org:dkim,linaro.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C216DA6252
X-Rspamd-Action: no action

The Exynos Distributed TruztZone Protection Control (D_TZPC) provides
an interface to the protection bits that are included in the TrustZone
design in a secure system. It configures each area of the memory as
secure or non-secure.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 .../bindings/soc/google/google,gs101-dtzpc.yaml    | 42 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..a8c61ce069d6910c47753bf14a792eb58e6ae182
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/google/google,gs101-dtzpc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos Distributed TruztZone Protection Control.
+
+description:
+  Distributed TrustZone Protection Control (D_TZPC) provides an interface to the
+  protection bits that are included in the TrustZone design in a secure system.
+  It configures each area of the memory as secure or non-secure.
+
+maintainers:
+  - André Draszik <andre.draszik@linaro.org>
+
+properties:
+  compatible:
+    const: google,gs101-dtzpc
+
+  clocks:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/google,gs101.h>
+
+    dtzpc_hsi0: dtzpc@11010000 {
+      compatible = "google,gs101-dtzpc";
+      reg = <0x11010000 0x10000>;
+      clocks = <&cmu_hsi0 CLK_GOUT_HSI0_D_TZPC_HSI0_PCLK>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index a56f8f00aebb938aa765a8a6d66dfeb7f062dac8..98b2ef47c809ac0232e6941c9483b19d7c798bb4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10833,6 +10833,7 @@ P:	Documentation/process/maintainer-soc-clean-dts.rst
 C:	irc://irc.oftc.net/pixel6-kernel-dev
 F:	Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
 F:	Documentation/devicetree/bindings/phy/google,lga-usb-phy.yaml
+F:	Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.yaml
 F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu-intr-gen.yaml
 F:	Documentation/devicetree/bindings/usb/google,lga-dwc3.yaml
 F:	arch/arm64/boot/dts/exynos/google/

-- 
2.52.0.457.g6b5491de43-goog


