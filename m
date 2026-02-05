Return-Path: <linux-pm+bounces-42177-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L7OHwIPhWms7wMAu9opvQ
	(envelope-from <linux-pm+bounces-42177-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 22:43:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EA8F7C4B
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 22:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34F033032F79
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 21:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B08A33468C;
	Thu,  5 Feb 2026 21:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jePl5ywC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861B6333446
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770327755; cv=none; b=q5nMRYJIEfpKH7fK/iqIFWfiJfk66sIlb7mVmLxxumXEue/X703bTU8PwwpfIkNtGoXm2LwGvmgyCOCAQ/lJlk9qnQ403IwCaPVwpJtk0Afu4dwjxiw0whzBil/Lm2Ea9uXqBL5kr8DK79OG5j5DqPyi64y/giNLY+Z3GqPPHaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770327755; c=relaxed/simple;
	bh=+s2aNo3COCK2NPb+ZjVB11wJJOsDzuBBCb7/nlROuEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gZegIpgcktP+mxFmWCMKJVtcanFEBeZEu46hmG9dgOd08Ty1lm5S9CBQftmUYwgi8u3Fp9xJ17nQ3Je4oR767Lwb4eyMT7wWN1NAQ+ZNKAEtc1YXF2dB34oP0R1J6LNEGilkPzY+Oi82jrobx5rCc7YNwT7xJCUnC8otWIb31Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jePl5ywC; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-64bea6c5819so2145560a12.3
        for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 13:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770327754; x=1770932554; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i16W+jMqGdPhRLNJH4hwpWkbVoIp/hK7lVmz3Ju6fWY=;
        b=jePl5ywCA7fgyGbq6JtiN/ewGnrkSfhWDw32BblO9o0d4jtIhIpRQyLN3YEjlnXLkj
         bY+QKmz9o8y4LxkuGqAhIhcLwLtmyqJKFlYlaRsj72hObdZb2/GK8wUHNRIDunw3bwdi
         9MeO/xkbSPfSedbcftUI8A/9hldhVofuT7rBc7YF9ZXqzr3sYKCsOzVnQqt5qYIRBtbX
         qtZjVTdOf81jQaboLUJuvoy1/aOmoKDIZvJYs0xQfljbrR9oUyKs0l3Bf6KT9wLUYRFs
         /Ju01NoAW0Ag/AhVQUq7/A0qG7s8KQdH8wboVknv65LmgKvfGqjzrMJtWL1WT5YwsoqN
         NCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770327754; x=1770932554;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i16W+jMqGdPhRLNJH4hwpWkbVoIp/hK7lVmz3Ju6fWY=;
        b=P39QvMEc2fFBj/ENt2Dnndvx+aQleacbrmK1L521ISkOShWU2ljPKg76KSqrklMWIs
         Afe6UOkLFsiIiVL2pH96kOzrXBX3xuq2lTIg5lvRpOAWo2AkBNZGR3HU5wUm45J86i27
         zRlGlbiqiHK/E3UvtKvkO2wxMwm9URJob/BYiT/KFFoEQRuHPC9ZsJq1+Jb58nVB4rzN
         kzk+0WsK73RaeL6pAiHQkAuGCuHAZLjWO9SgYbaJILQyl0xp3bCUb9FElVfgEdOa/9Yt
         3V6oNcgZ1q7ioxlpML+rp3gxdDXBhVofOMQkanXhmOp2rOhp/mLO2r+NqhQkUR2tNvNl
         JVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHzchsBSQl3qAGntJ7BnJuKw6N8ZKSerCPe+bgWuizTkkASISoaVOCZTyttUfLtd5OY9uZBJ5qew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg91dJCdplF7AyzdTEAd81aU4F1musfjmf2ZMUL6M2PmViWLlo
	6Y4OvpeK7XAT7hoVAUe/AUXGmEIFbG8xOBzFd1sgL5Js5VMUs1an3lLovB/6WVem1rs=
X-Gm-Gg: AZuq6aJaH5gUg0CfacgcRyMfuqknm9f+zAlHhcPwPV5zA5+fy7k+XjEvy6F4J0syHhQ
	5nRu9yBo6wNkvcjQE1nAY9DCVFl3puMjVNKhKJLc1JhkBq8ntn/Y3qyrVycQ3Z/hTJk9V1m1Dgs
	MlrirtVjedhbwNXwy/lFcO2qwQRpDOrbcDuPzQL3HpvV2PwXixQDZGsA2TCmwJs8XdtsAyZyoPF
	R3s47I8MM4tlrXPpwpiATcE1egL98DKw8nzMNrWBAYG1mU4IliCYtQitta/+/CRL6LCrWsX6MR0
	rzVxsOZLgLOYWAm8ExPwwsedauEtNH06ZVvrAkZTfb20V+sBdYUSVRyAe4WWrvaCw5j/bEJT97I
	JjxUUTf6cSOmhoIZ7R11dsrLnsjgEI5q64mRm7NEhbx1QRvbM+h5uURbBPdVKNsPx4yUX6/Ohc5
	PCboioUOXcwvQ/Qd1bRlx/8cXLyvp4Id4F5oU/2O8+SIN+D877W1ryfY1/uirOWEtYzqgMm3c1Q
	ZX0lw==
X-Received: by 2002:a17:907:9486:b0:b87:115c:4a2b with SMTP id a640c23a62f3a-b8edf23ea6amr25429766b.25.1770327753822;
        Thu, 05 Feb 2026 13:42:33 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda7a0074sm21859966b.18.2026.02.05.13.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 13:42:33 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 05 Feb 2026 21:42:31 +0000
Subject: [PATCH v5 03/10] dt-bindings: soc: samsung: exynos-pmu: move
 gs101-pmu into separate binding
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260205-gs101-pd-v5-3-ede49cdb57a6@linaro.org>
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
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
X-Mailer: b4 0.14.2
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42177-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_PROHIBIT(0.00)[1.10.107.32:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,linaro.org:mid,samsung.com:email,devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D8EA8F7C4B
X-Rspamd-Action: no action

The gs101-pmu binding is going to acquire various additional (pattern)
properties that don't apply to other PMUs supported by this binding.

To enable this, move google,gs101-pmu into a separate binding.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v4:
- update since 'syscon' was removed from gs101-pmu compatibles
- update since 'select:' was removed from google,gs101-pmu.yaml

v3:
- use additionalProperties, not unevaluatedProperties
- fix path in $id (Rob)
- drop comment around 'select' (Rob)
---
 .../bindings/soc/google/google,gs101-pmu.yaml      | 56 ++++++++++++++++++++++
 .../bindings/soc/samsung/exynos-pmu.yaml           | 20 --------
 MAINTAINERS                                        |  1 +
 3 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..a06bd8ec3c20faf0b364d3d3ef1763502c2b09cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/google/google,gs101-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google GS101 Power Management Unit (PMU)
+
+maintainers:
+  - André Draszik <andre.draszik@linaro.org>
+
+properties:
+  compatible:
+    const: google,gs101-pmu
+
+  reg:
+    maxItems: 1
+
+  reboot-mode:
+    $ref: /schemas/power/reset/syscon-reboot-mode.yaml
+    type: object
+    description:
+      Reboot mode to alter bootloader behavior for the next boot
+
+  syscon-poweroff:
+    $ref: /schemas/power/reset/syscon-poweroff.yaml#
+    type: object
+    description:
+      Node for power off method
+
+  syscon-reboot:
+    $ref: /schemas/power/reset/syscon-reboot.yaml#
+    type: object
+    description:
+      Node for reboot method
+
+  google,pmu-intr-gen-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to PMU interrupt generation interface.
+
+required:
+  - compatible
+  - reg
+  - google,pmu-intr-gen-syscon
+
+additionalProperties: false
+
+examples:
+  - |
+    system-controller@17460000 {
+        compatible = "google,gs101-pmu";
+        reg = <0x17460000 0x10000>;
+
+        google,pmu-intr-gen-syscon = <&pmu_intr_gen>;
+    };
diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
index 76ce7e98c10f3738e7de5579904260dd906507c9..09368dbb6de6898e2988c398b2506f2c2b4e73bc 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
@@ -12,8 +12,6 @@ maintainers:
 properties:
   compatible:
     oneOf:
-      - enum:
-          - google,gs101-pmu
       - items:
           - enum:
               - samsung,exynos3250-pmu
@@ -110,11 +108,6 @@ properties:
     description:
       Node for reboot method
 
-  google,pmu-intr-gen-syscon:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description:
-      Phandle to PMU interrupt generation interface.
-
 required:
   - compatible
   - reg
@@ -176,19 +169,6 @@ allOf:
       properties:
         dp-phy: false
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - google,gs101-pmu
-    then:
-      required:
-        - google,pmu-intr-gen-syscon
-    else:
-      properties:
-        google,pmu-intr-gen-syscon: false
-
 examples:
   - |
     #include <dt-bindings/clock/exynos5250.h>
diff --git a/MAINTAINERS b/MAINTAINERS
index 7fc1964b6beaf835a398a9bcee4ded191034d2e3..212fa7ca48b8272ebf189fa1d105b319a849c5c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10856,6 +10856,7 @@ C:	irc://irc.oftc.net/pixel6-kernel-dev
 F:	Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
 F:	Documentation/devicetree/bindings/phy/google,lga-usb-phy.yaml
 F:	Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.yaml
+F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
 F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu-intr-gen.yaml
 F:	Documentation/devicetree/bindings/usb/google,lga-dwc3.yaml
 F:	arch/arm64/boot/dts/exynos/google/

-- 
2.53.0.rc2.204.g2597b5adb4-goog


