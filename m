Return-Path: <linux-pm+bounces-41625-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCFYFBo2emnn4gEAu9opvQ
	(envelope-from <linux-pm+bounces-41625-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 17:15:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC08A5555
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 17:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB68C307B808
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 16:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0C33148D3;
	Wed, 28 Jan 2026 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gozXOmlR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6C30EF92
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616660; cv=none; b=Y5mEuJncEJVNwi/R3lZA/W2gwCJqtg8Q0/7dDeUsj98S4ADuyuDYyu3bJuXNzsNPYi3u8cF3E/HckD5ZBKhNQ+yQirkArz6S1AfSGQRwvTJNxlT0C2tmzEPewZgRSxClvgBkRoCespVFw3+9Jfm3Xu3A9BAKJSvjEBGqrZASvT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616660; c=relaxed/simple;
	bh=nWdbadZb9pkjwxX80QRMaZ4rSW9P2s4Vs9D1Jbg0i6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MDTL51k9Ta5rLbKyc3Mx+b8/dAVqlJa0znEdkchkVpHye0Jwc1qqt/RMpewdkeQyjCXjfNsAWQA2g2TCC13oA5QracKHWEUYUTG/X/aEyiRtWTMzwz7FGPTGYgApiDG3OIiq4xNc+gYOz/QWzYJksQVjyphmt8zvbmG084a7n5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gozXOmlR; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b883c8dfb00so2075366b.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 08:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769616655; x=1770221455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdKVOkYHieKbKrsTLXtUc+V5Iw2Y7K5R7/tW5O3XgDo=;
        b=gozXOmlR4xVEnVrXqvfNihE1DtNZa0F91k18eeMERqf1kaLoYuCa7iJ8eIH7foHFJr
         JzG/QIVdRys10C+iNrn1yvqd9s3c7uBA+SgV1cWfwynNser0ABaMJW6MTZ0Q2jodBwF1
         wS6/8IsgDx4Mzlqhhzm8NoA44tLoRDoPrTdKUuSiHfcwtA3p3yjROMJpAviGLpqAbn2/
         M2M+xqmMVfr/N7fxf7o0QsdKGqwjqvGwAOp1w9cVL+8dvn1g+/T8khOulEgpb3b3s7ls
         EXTUxxuS3Gcp3NEB/A+cSWt3jgazSC8LA8hznHYlOn/gLR5WbQKeIVyuR4s3LrL2FDnS
         B7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769616655; x=1770221455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wdKVOkYHieKbKrsTLXtUc+V5Iw2Y7K5R7/tW5O3XgDo=;
        b=IH70cGOS5dAkQhmHPrOU384IdHhV95/Ra0B/hW1UlNEpMZRX74cVKpPXHq7X9mv23Z
         zHcmYSlqUiQH8ws5dnwVr0P4LytsgVreZy7pVMVHk+nnIgQ0vtCsk17CPwt6X9iHUAKQ
         DgJ2A3+kp/uuza8imwLFVWHXI1VuUU3MuYoH+EuD5BlSj4vZ0GoH5hqQ1RnjTqW4TK+K
         if7vqcpoJymGXsz5MQTbNeV/C+EBvAn6VL27t5ugMimr+XC1HJnL5Pa6x812N1hXEb7U
         PH0JqV0vWxxDoHN3LqmZ98Od9vGhVghZAkCEw7XU/Sv0W5i/+3+CPNxK+UDTB86RoEOh
         6FwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVboTyLVKoWx/U5lBHYo9/H81Ae2QWRdlXaooa0SQSj4JpssCrw55D8uk2fBQYjsyq/a0BPk7nvdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpMGDEXFENtcofDRBox1uPo+Y1QQmqgUJolSeNRxtw4mEiEDOu
	5W8ww7TCPcFQ63UMKS0udRiiZ5DERpcmjTvmdUs+GLaeb9gF1AJS8PFuGPxFG7d23XY=
X-Gm-Gg: AZuq6aL0xiMY2TjOJoQb+Ya9onFHc8OsUIs7uh7BLqQr3s4s0QgDwwNeiX40xjQ4yOV
	xH4QJcqzC+zNYWfdW94F/hizsg11ukhq/Zy2290mNHr3JgVGiYRkqMIObclMZPBWCdgVT52pG+g
	vGvUVVT4pQkUdQgzB4QmhnucMluC7bE7JeGZVvYOxX2Sfha5pGWixGcl9yRUBNftIRlSu8naOED
	YiKJHqA16Bzv150Fq6C8I6aTQO2p2vCABupEUHrrKMXS59df5D7phI6gJvaxx11Eoe6dDUcK+6W
	aKV38/RFGrJuWuQi5qXTy4sQEdmfzu3Lo07R4cS0mdjd4rC1AXmi5+tNRcC7S+P4UVhAp6+YwGZ
	u5pnCnFNfoAyTunve/kCw7gRFshft2jZ6whGDfW1VuOS58tSmqN2FRyD1FPpIhL5E7IVoetFlyy
	5ei+KWxob69q95NVgLEzu/g9FFFliSECSh9Kq3DOWIEfJnPQGhFbWHpP8xLmh+wSDqyZjYHtOBg
	VYXbA==
X-Received: by 2002:a17:906:2083:b0:b8d:c595:828 with SMTP id a640c23a62f3a-b8dc59517edmr136595666b.14.1769616654759;
        Wed, 28 Jan 2026 08:10:54 -0800 (PST)
Received: from puffmais2.c.googlers.com (244.175.141.34.bc.googleusercontent.com. [34.141.175.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf1c021fsm148553366b.49.2026.01.28.08.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 08:10:54 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 28 Jan 2026 16:10:52 +0000
Subject: [PATCH v4 03/10] dt-bindings: soc: samsung: exynos-pmu: move
 gs101-pmu into separate binding
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260128-gs101-pd-v4-3-cbe7bd5a4060@linaro.org>
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
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41625-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1.10.107.32:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid]
X-Rspamd-Queue-Id: 0FC08A5555
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
index 98b2ef47c809ac0232e6941c9483b19d7c798bb4..79a58769e9cb33d9bd6190c74d55461e77965af5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10834,6 +10834,7 @@ C:	irc://irc.oftc.net/pixel6-kernel-dev
 F:	Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
 F:	Documentation/devicetree/bindings/phy/google,lga-usb-phy.yaml
 F:	Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.yaml
+F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
 F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu-intr-gen.yaml
 F:	Documentation/devicetree/bindings/usb/google,lga-dwc3.yaml
 F:	arch/arm64/boot/dts/exynos/google/

-- 
2.52.0.457.g6b5491de43-goog


