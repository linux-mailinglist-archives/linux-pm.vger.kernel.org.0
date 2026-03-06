Return-Path: <linux-pm+bounces-43785-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCDnF76sqmlTVQEAu9opvQ
	(envelope-from <linux-pm+bounces-43785-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:30:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6326021EBD3
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 11:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 292003004CB2
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 10:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF53B37E30E;
	Fri,  6 Mar 2026 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vCc/8i0T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3622A37CD2E
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793001; cv=none; b=As3KO2oA3s0HxwHzhugyPJx0dKjyHskRZ8xJtesbVAOs6Ye7Kx7vL0/AJyADDjUrQrYFAMYw2NOvgRMDJ3tAy9h7CnfLHd9zcZXIvhUfWC+O4JrucJxkNnhcHtYfld+nmA8KFw/OezfHHo3UMaKhgz2YzogWrQMvWS7x9xEumf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793001; c=relaxed/simple;
	bh=rQimVWIJS5wU+wNLCWMKgCOW5DPxO8PvrErq53XFv5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h1mAsHL7+N8zmWw5SOCH+qWvTJXZDCtn7T9ycehF9eP+VRe2D0Bm9a0h01IZAgS4qmw+cOdeK9my15ScTr4orJ4bSwmz35VFXEg7CYdbIM7qPs6rBMy7hC7iv1pDBxJA0FqkhvdIHOQ/qo/V7z7NNNG/FsSNCUv8fJbEGNIYRl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vCc/8i0T; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65f8c8c3a4aso16681759a12.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 02:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772792996; x=1773397796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=piJ92bCcZbzXtfYOaOOoHhs9Euyr6xn5G8q2SxoNOHc=;
        b=vCc/8i0T9FCtxsfB+aVfD2BwqXeKeRSjLJkVBjmFZg3+JMAyFMVhzNx4nsKqp09Gpn
         GDXq8fxd3Jj1rDAijc5h7xTGiNW0QUmROsLmtObZ8JzlMED3GQYB2LPl7Lfj0iE3B4c3
         htZSyPmGRGfWRWDLiR9/NFsCtUGemQiIN51MOzhalC+X8ys722ezvXKazDOk+sfSi6Wg
         3D4dEtWPn9ctVwRcmhSUUI79UTWQMmFR0jdTuHltHeGPOYpcoP07NBRdoDeHujT3KwaL
         AJaFsd84E/rdX0WYZ5SHAfrKtG6+6NMQZVdFHFVE3l7JCnAcoopc7iaIlTz+4Zrk4gP4
         s3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772792996; x=1773397796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=piJ92bCcZbzXtfYOaOOoHhs9Euyr6xn5G8q2SxoNOHc=;
        b=mLHfpUktoo0N/ruzTIrnIKmdYmPYIIhaglHPn9qVpRvyt3/Ajyob6Eujc1eUgohmye
         iBteEiONmjReUGzmUPzuMxIG3jid9uNJ3bajwwVeFoJQuQi5ozcqIGV0l25OHBujIOlY
         jDDSBgTvudCa6sfSoLgZ+wt0VHv1QxUBealJ+nOJEigXBgyTxtQOLVJjl+FNzf3MIYVq
         5p7kVpsVlvebFBulhbZmPnpIBsE7D33Ko3Os/xtOApuaL1uj78uoaqbo32WO2kwIzOkH
         rDxHQC1lcoBzlPh11Bm5rs5mDQNcwrXwQ6XdZgc14a18++ynNO8UltA2lxxFdNOMDzSR
         KwlA==
X-Forwarded-Encrypted: i=1; AJvYcCUqb7KWw4tLoUo+NVXHqXBto/Od0jVuvC+q8+FwQANuAyWHf0WIZSzrBFqdYIjewwTuUgfcbNHhJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtYa515VyQLhKndyWZ6ZFyfz21KBRWLuMHzv1A605hI8rzsC2J
	e/d4rzSSR3cTEH8me5qfIMDKRSMC4SI/bflhs0+mZ6b+F43T3B9c1XpuWNor7SXCOOE=
X-Gm-Gg: ATEYQzychNqm1RC/JRxZaLfH01W+gHZT3z2dnUPunIOBH9Zi97AgM26KNascR4fl75h
	q0+0625+tUu9qymjgvGg6TcLF47IP58rpfITlyOrqd+tMOsPAx3DWMiWNRJrs3bah5yYIj3flrl
	j6h339LbvjH0lJqxYzjdCliubVA7QxRMFIrAAg2/ZiFrUfrhA19U0Jm1O1Dv1t8YY09yC4CSb+m
	3pphJm/oFbN0ITPI1U+iahvYagwBUeWZtnxr8NjLWu+rqUlpOSnsxa2aVY/JfTz8RoxR2ztpCVU
	0CL0EtVfEVVASCrkEi28xFyTtQ1Ku1Ob+JrT0EWy4WXLzpG+Anxp0IrpWWq0DiaZTSKvjD+EkyR
	jwB02ESGLqUjbQyYXvHyuFb3OBDmj9qqpZjvljHP+KB/Ew9U6GPAZM38tco/vNiMg21sXooTRR5
	vRCgGbyOgTnuJoBgJjK/GpvA1HJTZfLGlA4P9BOr966rdU5grcT9ywwb6DVtiMO7P28HM39hlRf
	X0I6KfaQtqVZtQ8YcI8s8hO3Q==
X-Received: by 2002:a17:907:6d29:b0:b87:10fd:b590 with SMTP id a640c23a62f3a-b942e05ddbcmr87217966b.60.1772792996324;
        Fri, 06 Mar 2026 02:29:56 -0800 (PST)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942ef8c95csm42907266b.21.2026.03.06.02.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 02:29:56 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 06 Mar 2026 10:29:54 +0000
Subject: [PATCH v7 03/10] dt-bindings: soc: samsung: exynos-pmu: move
 gs101-pmu into separate binding
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-gs101-pd-v7-3-03f7c7965ba5@linaro.org>
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
X-Rspamd-Queue-Id: 6326021EBD3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,samsung.com,linaro.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-43785-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andre.draszik@linaro.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

The gs101-pmu binding is going to acquire various additional (pattern)
properties that don't apply to other PMUs supported by this binding.

To enable this, move google,gs101-pmu into a separate binding.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v7:
- drop invalid tested-by tag (Krzysztof)

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
index 000000000000..a06bd8ec3c20
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
index 76ce7e98c10f..09368dbb6de6 100644
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
index 611fa8fb9f8f..6a00d97ccd09 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10884,6 +10884,7 @@ C:	irc://irc.oftc.net/pixel6-kernel-dev
 F:	Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
 F:	Documentation/devicetree/bindings/phy/google,lga-usb-phy.yaml
 F:	Documentation/devicetree/bindings/soc/google/google,gs101-dtzpc.yaml
+F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu.yaml
 F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu-intr-gen.yaml
 F:	Documentation/devicetree/bindings/usb/google,lga-dwc3.yaml
 F:	arch/arm64/boot/dts/exynos/google/

-- 
2.53.0.473.g4a7958ca14-goog


