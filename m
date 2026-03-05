Return-Path: <linux-pm+bounces-43642-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPUNNLUeqWmL2QAAu9opvQ
	(envelope-from <linux-pm+bounces-43642-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 07:12:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AD120B2EC
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 07:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CE543043D44
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 06:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9AA29ACCD;
	Thu,  5 Mar 2026 06:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3Kz3SJr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1794926738C
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 06:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772691116; cv=none; b=NkDRxdINg/bSzIgLOmVK6h7/QnVEVg7QYjbnoVYWasFLhmHNJfJp8xj6o+B6wmm9YvpDxQIHvCA6Rkf0Rvb5wSZ7oPXj/FJpCmOBHWevxZ+oOzAbCG74tBi7IcRfVYA1GKhNSavxLW0POHnsR1VeAUCvqMF7+U6eRR++FLlIcy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772691116; c=relaxed/simple;
	bh=VXqNGlqX3hZoD8cv8P59wyGVL5FoVdrO7llV2dEVFW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ceh1pOe3A+iXfmSNaN2RVLOmK0rnI69oCX24P8ALWuYiyNRhgBRCN8hDI69l2GCSbfN2vE/PFTnVDmi4qYXxpVBVdjvVO7NWSPiMeZO9v+pgvx2JYVOYvbekqCNOvJA9zHMboe/KX0/O0b4/akCPiMvgNvmcpma9EDxLsi9VwzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C3Kz3SJr; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65baa72399fso10041480a12.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 22:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772691113; x=1773295913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gPeJxyuGY5/8F9b5AqNdyg2EFBWflmTDpqYPujzuFU=;
        b=C3Kz3SJrqqMDzFHma2oUYgsEw7i1exAQFHIJ19ZxXh/DPLmTNanpfy46sWA/llsLpf
         rbzwTG0BKjN19O9FTEnVJxai/eX8gS6tGLPsgdA49ihfa4dZ6L7ovdYONKW/uqKZS4Rj
         vLiZVqEK1WqwAJl4c5KY8WDPf5pCztb7BNaKu0eCVv81b2sOizm6MbP52mIiZWqUbe+7
         d9+pzsQRwj81nl8PYXJlCJmcyuLggsdZ+LSnih8KOXmYdsadsYzgo1DSAIy7taHEegdw
         /gTQGwbJuFTe0m/kJC9xhXrVgb4H0OQ9fxKS10RG10FRq8a64DmFZRWKEb37pvsHTz6g
         N1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772691113; x=1773295913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4gPeJxyuGY5/8F9b5AqNdyg2EFBWflmTDpqYPujzuFU=;
        b=oho3J3wiIj2XO+czqLh54BlvgvMInaBvwkqYMwhHqDXaH6vH0iw4qkrVje3lRzu/LF
         nHH5TEJNQjE7YTYOWFX04SJCnBx/S+AVvIPkep+nYZRWjPRazDk5dsLvRsRLrI9mtyBp
         hzaWTu3wRQNMiknfhe526+f7h/VyaRk5ZqDOTaDNkjzjTAB5CtdKI8tNP5krcX9xOJQz
         iVFrnSrfqLw8iWJhqt7N1JdcItBHJSh4zcSADwY9zlL6394rn1fQM2QFJ3GfDAQO3cYZ
         NcViq0cizfymCPJdosOyJl+pl4arA3uqkbYA5NzFI6pZCgiK+UQdXmgKQ6gaCer/gOZQ
         kS0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAURRHwS6pI09eHlUzhrhzT42unrkZ/UJoG1qixtUmgh5UIl8M5pWyyZ7pIuXKnfqTGLRBlpvEEg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkk/kiSi1TrbFbMjntE+F5RZm8me/Np2t1rqBgIbPjbV1h2d+k
	MEfY9W7y1+Lie2gqT848bt/gJerKMC8y6hCg5klHonh2bl54so72wVDpCHjFU19YE+8=
X-Gm-Gg: ATEYQzyEMj86sLv/1SDZ+s/i5uWs3xy6DVk+1ZjEpE7kq6ej3ZN4tghHDvgnXhSdZXA
	VEtlT1DK6k6WA3L0uQMqkHqqKd0X5qSBH8vguuOzQujnpx+9vr8fM/ORIALiferbSDnPHAp3IWf
	wjXvFPi0bc3i5eg1579ii7vLpz5F7LwWIv4moI9KAq+F+3nDzBLdHO78bn/r84lVN9tXPZuAqMt
	VdzYuPtgf3op8+5gZe8sCMtcDdc4Nlq1bxdREPZuVfZwnsI/+Wy2hjVbT/cgO0IiAXKbbESOKw4
	xTCSL9tEd1wHuKMpAkaPnkLs8ucjcB3PpCCU79XfvAFNsImYivKYQsJuWDMlSRFO4bdc8L5O0OO
	VRJO3i3s+TUVPORIeaWWyCLACLrH0dW/XM52ZgB3Rr6Ied6F2iL40mqHTcK0liI22sjehXBPXgK
	oHoLJgOFFzhuj/a+hMIshUD4kk8oeZK9hCgwup7OExUvMovBAaurvjZD8Oes4VjGYrnO9g88Nfp
	aFDKMqo28FUqW4=
X-Received: by 2002:a17:907:6d28:b0:b88:47b4:7626 with SMTP id a640c23a62f3a-b93f11c65e4mr280686866b.27.1772691113364;
        Wed, 04 Mar 2026 22:11:53 -0800 (PST)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935aec3243sm849355966b.53.2026.03.04.22.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:11:53 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 05 Mar 2026 06:11:50 +0000
Subject: [PATCH v6 01/10] dt-bindings: soc: google: add google,gs101-dtzpc
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260305-gs101-pd-v6-1-8cb953c1a723@linaro.org>
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
X-Rspamd-Queue-Id: 93AD120B2EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43642-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.167.255.208:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linaro.org:dkim,linaro.org:email,linaro.org:mid]
X-Rspamd-Action: no action

The Exynos Distributed TruztZone Protection Control (D_TZPC) provides
an interface to the protection bits that are included in the TrustZone
design in a secure system. It configures each area of the memory as
secure or non-secure.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 .../bindings/soc/google/google,gs101-dtzpc.yaml    | 42 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.yaml
new file mode 100644
index 000000000000..a8c61ce069d6
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
index f0b879760b6e..611fa8fb9f8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10883,6 +10883,7 @@ P:	Documentation/process/maintainer-soc-clean-dts.rst
 C:	irc://irc.oftc.net/pixel6-kernel-dev
 F:	Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
 F:	Documentation/devicetree/bindings/phy/google,lga-usb-phy.yaml
+F:	Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.yaml
 F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu-intr-gen.yaml
 F:	Documentation/devicetree/bindings/usb/google,lga-dwc3.yaml
 F:	arch/arm64/boot/dts/exynos/google/

-- 
2.53.0.473.g4a7958ca14-goog


