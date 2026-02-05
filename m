Return-Path: <linux-pm+bounces-42175-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YG1AH9AOhWms7wMAu9opvQ
	(envelope-from <linux-pm+bounces-42175-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 22:42:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD70F7BCA
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 22:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9DDF30219B7
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 21:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79BB332EB3;
	Thu,  5 Feb 2026 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uqa5GMcC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDB633290F
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770327754; cv=none; b=SeZH6BKPZd0y9Fege8XKWJd+4GhH+RJPgq7EZCloAgQjUz16MVFuibtNNrsZWG5O5k5iYrzn7lAoWEjb11ledSrz5m5vfhKFcAa5K7JhwJNfW08/JPxTdCi6CJlkijYPgP4S0vDm/Jx0c7vj3fUwLz7Xyr/wBonCzjtepR5TIFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770327754; c=relaxed/simple;
	bh=8zHh24Y4fV58aGGijAkWV1Y30FrSoWjyJKGi5X71ITA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mElnZ1Jp+tkiXlwM3P1/oDXtwOEApFGSLv3KI0gmG7dB4lZip1BUwIncphHi56zwLnGXZ/7y4Jk7JrZOsCNnLKHTC+T0LdYqYFe+qDTVEM3HApEaSpw9S7rM5Nh3ExrPtbjUDThLOG+LORloaNNROdnY8OKGSQHx8yBuV0IFBEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uqa5GMcC; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6594382a264so2929071a12.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 13:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770327753; x=1770932553; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=82wBgeiecw8diioZs9d1L/8/7KXtnNKqceYMhdMY7vA=;
        b=uqa5GMcC9a9gG6XSFYDOpv/E61h8KL2rFnfGC6gNGNJoodFEojfsY3JjtECewJfJK4
         Ton5rOMwrH0g1fMN7tm6maIrSiWlCxSnq2cyeDvZ5Ye5GNYMntmKfqkhsVZosejsNwdk
         8+SsIzPcbQMClLRkEeV/p3ZCCCKqn/8reaus5C/3R6m0p0KqFIl5i/5bGYLOK7KN7E4D
         cotUcaivP7XekcpUCmMC76wNiIwemtvtoN1PtsdZFov6Ho/7vRHIYGMvdZLNkTm/O/AN
         Z/m2jxOHwjxS+/ghVYdrJuoq/3uJJWi2H4Tn1Shw79TDqCQGT5L8Iy5ZEj4aZctjyIu6
         mhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770327753; x=1770932553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=82wBgeiecw8diioZs9d1L/8/7KXtnNKqceYMhdMY7vA=;
        b=qBNFG3TVfz9jbMDQ4D3lDdBNjE4txPpeTOIORhD0TbzZeJ6yYgVrWhYYkzdxSGMXWA
         QHekSlXy/ERKgt49TPB5idpA5drNlGxpEsNDhoO81rJKoIuCCSh9pIwrSkV2rNwYsvmj
         rM21kZb0j0AMuarKd4XPNJHrNBz6uZCDfvF+RMWJzguhiAjNRzqHYdr6CTgznvzZVP2V
         diS9TmxThkhJg/Y9zfzyUixPnI5zsBEyRM5mqBM2u8g4lHAV8BlDp4+NVKpYwidrUGtb
         p/t4+ru8lJpAX4qf9qIZnY/mvnP1eEUgeDcCDoVScetA+Rwgc8D/0rzDjexiIBzQ7Vtr
         YxNg==
X-Forwarded-Encrypted: i=1; AJvYcCUk4iM4ik3G3caOo7Xm30/4bWGLO4n8DhNcHW6jt8BxYF6g8kasZd6+Fs4HMfdzKr3dIOhyThLH5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8QJL6XUgKNmUiKmPHe5N5Z7ujEIinopEIEopg8vsyQYM7fzxf
	dIIcYzrsIzOGL6L4mhY00NJiP81ZmS8Hh4T6RgTgLdYillb4FwMwZt7VA0CXNIPrJjI=
X-Gm-Gg: AZuq6aJ32RzxGOhYGoUF7f23tJP/ov3blL18aWsb1IQvTh7tO5PEv95qTCPVH2N9/My
	t4kNvLcBVYCYO7jqFE5Z0vFkQTjQuqazjsO+LULjzrsO8UD/EyLc8e/wYvjWcalEHp7q2naQwfy
	erT1nzkNnHpLmFbdqYLTPYy7ucYuOC51WV8lrV5KYofdl3PV3wSuiTvkpfebqOpW2NYoSwEk7Tr
	FJh2uJwX6ZPm+/vgDTC5we9kM3hKer6lqm/9GAif5DgJeRzYAIefJgTazImHmqyzgVB8Wl4UI7a
	k578XNA8jIQePR0fOoHiNwdPoinJPPW0afd2QjzJI+eiFixiHm/n7C5mrs+mOPFlHA1rae9KGBi
	S5LvKT96GZzmxI7t6mR/47dSpgNN5rSiiEidPz7XUCzV4IQDzhQNuxoZcqedOrhZH1vqq5pZNlW
	0RPtEnnEVh6pqtdUfLxwj+LQOfy0UrJdLETkPSeMUXhB5AY4g+vo0QU+xe8m1vWjuk/Ke4rxMBJ
	P6upw==
X-Received: by 2002:a17:907:3d4b:b0:b88:6542:86a0 with SMTP id a640c23a62f3a-b8edf36813amr26650466b.54.1770327752702;
        Thu, 05 Feb 2026 13:42:32 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda7a0074sm21859966b.18.2026.02.05.13.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 13:42:32 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 05 Feb 2026 21:42:29 +0000
Subject: [PATCH v5 01/10] dt-bindings: soc: google: add google,gs101-dtzpc
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260205-gs101-pd-v5-1-ede49cdb57a6@linaro.org>
References: <20260205-gs101-pd-v5-0-ede49cdb57a6@linaro.org>
In-Reply-To: <20260205-gs101-pd-v5-0-ede49cdb57a6@linaro.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42175-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_PROHIBIT(0.00)[0.167.255.208:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid,devicetree.org:url]
X-Rspamd-Queue-Id: EAD70F7BCA
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
index 900fc00b73e6d17443f7cee12fa7589b56facaaa..7fc1964b6beaf835a398a9bcee4ded191034d2e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10855,6 +10855,7 @@ P:	Documentation/process/maintainer-soc-clean-dts.rst
 C:	irc://irc.oftc.net/pixel6-kernel-dev
 F:	Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
 F:	Documentation/devicetree/bindings/phy/google,lga-usb-phy.yaml
+F:	Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.yaml
 F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu-intr-gen.yaml
 F:	Documentation/devicetree/bindings/usb/google,lga-dwc3.yaml
 F:	arch/arm64/boot/dts/exynos/google/

-- 
2.53.0.rc2.204.g2597b5adb4-goog


