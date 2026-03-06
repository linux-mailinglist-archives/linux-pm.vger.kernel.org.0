Return-Path: <linux-pm+bounces-43784-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAvBLYStqmnjVAEAu9opvQ
	(envelope-from <linux-pm+bounces-43784-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:33:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 243CD21ECE7
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D9683121ED2
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 10:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1A437DE82;
	Fri,  6 Mar 2026 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aycb3yD5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FD537C0F6
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793000; cv=none; b=NLFwJuvfmg3vQEyOt4xVen916tdKAUD9uHKUMktkVDPRjjJXzd9DuGMb7hVKpzqDzOzcH26enpc8ESh4+V2z9mD3DF0uhFJ97+07lNpbg/qfQh8Qk+KfVHJ66aPToxP0Xr0JYU5VbRHvxq7Xk+JFYRtlw7PkHERLy8lSt/ww8Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793000; c=relaxed/simple;
	bh=VXqNGlqX3hZoD8cv8P59wyGVL5FoVdrO7llV2dEVFW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qebTjk4OUqV8mtltHAFBtiJ4qq/6t5AsOMt5FjDvfUTeAiH/80GIL6xnOu5lhwqVwazUNSnhaPAoHSbBkZyAqw0c1eW0HrmD2Bwfxk3EoO/BSpuDEZrIl5q5JFPp8hrqDdyYF7HCQVFLf8CSh+yXyZnjM+7yafM583nStgQwiJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Aycb3yD5; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-660dcafc85aso5417637a12.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 02:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772792995; x=1773397795; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gPeJxyuGY5/8F9b5AqNdyg2EFBWflmTDpqYPujzuFU=;
        b=Aycb3yD5XIvxzGgghnjxETlzPRDnEKrqZc9X9CHGhewxeFsVVNUv9mTWZzB+u6Rmb3
         /q9o21jyb9akjFBlv+2ouG9AQHwLZwehQFeBmLj+CdtCjSSrXeM+CHOPLXMZ0xWNU0h6
         Etia5m4dywRX+lmWpxMmhfsvQG2WSXI4mzflHoLJ5fDnwpHRIzygPta5IYr7k9xY9Q3u
         bos6wGrb5eZqN/Djxoq4ewVx3QmnpzM8bVv8H6CfCuhPX87FlpKwyQBD2eIAJuqVCk4/
         v04b/vumoDigrgQDQ6XonFSLgrxBdm+ifWmd2Rv4QLB6T1MAVAPaP3nxXeKihM9KIo/1
         GrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772792995; x=1773397795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4gPeJxyuGY5/8F9b5AqNdyg2EFBWflmTDpqYPujzuFU=;
        b=Aqs7y8ChMVXojmgq1e+24gTCtYsGrpylPV5EKCWKef5nxfqrLnuoasvYCPGSGBvK1/
         1mV+E/DYsLrvlgtsHlTMQQ5iw0qJXSywpcjg78eMqXSJR7oyNil3yi4cludno084kefG
         lW2GxVu1k+G7RXSRBikqsBArAB1k59uVzOSFzecz43UAGbdolQRoNqfpnjJkOgSOCjLh
         lwk/OaZ0KIZSHfE8bCf1i7yo6O2mp24NiY9LzK04lnBuHqWKJRhLu1ZG2zuUsLRWqNXX
         qkv1p05+DFbt0BQQ3Wj+kGimLbdXSXUKVDZLrHgaJ+wophtdG5O+lJ0a9x+/zznLJZrI
         529A==
X-Forwarded-Encrypted: i=1; AJvYcCWDrzSg1gmXr1syVhtP3TkfpXSKdSIyKuuGXyt5xEEsR/pVdgPSgr+XUU9z9zqjvqfh9pq+VMk9Bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgcwX681G3x3WhTbdaX2wSqHfxnv1C9tbqAQeWwEDzatFNbMiT
	rbDSIap3S7XIrBBROQjjAGVBmjLYiqdrWfdibtzZ6kNY9vt8/hQmrbHWnDcFJi8CfGE=
X-Gm-Gg: ATEYQzzndklvBKCVc+cLJjaDcFRnAFqb7M9OqySSn7rOeM4fSHPm65VqEne344mrzLw
	m4iZvZr2rQ+tb67uLchYe8+bovt54j48hjY6UUfXxCACgjHPBMfeIfmicr78z9UQssNDmFhNR6+
	bqQw2GnWoiFFaMaFBXBn/PmMP8sVSzqoxN+VPnyGFfZCh0q6tJ13F9dOOe4nT4VWklOqQgXGstI
	WjVzI5WkhM/vf9cELR3rrXozGjqWa0lhH96ZJgEdDddws9xp06YcrSvWDeYyA/V4YAEoD3xpbXz
	5t8xALl9IG7dDBUJgXmINVung4sbeoxI3QdmzSIS+4gbbQZbl9AXYHq1L+ySQrHPux3B8vfh++O
	gpRGgJoPJQP/KljQnOdikYt70p8LOiydKXjPFvITqKaxrlqosSpxmZ1ZkVyZOiaddviItFGrlvw
	bSeRhhyC4tc+M3bnV9U/8kQdo215ORrkwRt3tQUVmkeA/y0DOtptdQuUMHyb0y8HM39AaNu5HrF
	pa6pvXxobEmFtg2wPRn9HcYCg==
X-Received: by 2002:a17:907:3d8b:b0:b43:b7ec:b8a1 with SMTP id a640c23a62f3a-b942dcee05cmr89065966b.24.1772792995144;
        Fri, 06 Mar 2026 02:29:55 -0800 (PST)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942ef8c95csm42907266b.21.2026.03.06.02.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 02:29:54 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 06 Mar 2026 10:29:52 +0000
Subject: [PATCH v7 01/10] dt-bindings: soc: google: add google,gs101-dtzpc
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-gs101-pd-v7-1-03f7c7965ba5@linaro.org>
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
X-Rspamd-Queue-Id: 243CD21ECE7
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
	TAGGED_FROM(0.00)[bounces-43784-lists,linux-pm=lfdr.de];
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


