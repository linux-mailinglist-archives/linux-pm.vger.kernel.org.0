Return-Path: <linux-pm+bounces-37974-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C48F9C59A5A
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 20:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F8534E838D
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 19:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9343191CD;
	Thu, 13 Nov 2025 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ISqtjWYc"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EA4318131;
	Thu, 13 Nov 2025 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060768; cv=none; b=n9G47VMFLzMFjSObaPAECwvxtRlkIlRD2T0z2SxwkkiLQkraWrQUD4UjtVgRTyvuRqho2mi80NgikG5hesWHZRNCnRflpvCs8LdfeKS3x6oI5u7b8LQFHWGvOzonTS3CpNhsNSRSXc22OlJ7S35qQD0eXWEry0jw6M3+PR13Nyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060768; c=relaxed/simple;
	bh=2A0vaYHCECUQ8MIA/pdIwcaIxh6KIsr0+Y/dQwxtdiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hh8Eu6mXDnuYDYpgq6wGKgtjmZdDzMjOV5VLeQ9xtGqQ7WCnlgCeUff+/2dGrL9Pp8azCCKeDK37+csmCeOvOmA/o7mKJk6TK2fDTIRvlOU94W4thEVzLiYz+htxYUFddS26DpFvRG1eLbaDfaZ9AC8EXfO22wNpNxhIs41SOzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ISqtjWYc; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id F093926774;
	Thu, 13 Nov 2025 20:06:04 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c989Gpoc3-Mv; Thu, 13 Nov 2025 20:06:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1763060764; bh=2A0vaYHCECUQ8MIA/pdIwcaIxh6KIsr0+Y/dQwxtdiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ISqtjWYcW5uA6iqahaqIwog/2uqJve+G8WgjVrYwTy2kCbARG+XK8x4pcwx4gy3Yq
	 qLh6tUeDhReY9He6wbkVGA8ng6+WUp6Uao78xX+xKVesU1UZ1tYJvLbgwKxfdYnFMg
	 PunRmIRU2bAsW3Bn0OVnDic313xbvtsfnn1jxZT5vuUdBERknQ+3ron2rLCBunWOUW
	 Cm0n7Wc+MXXtZ2aaWIt2++pdLtBG6aVZFnXFupHiFT8CLP8FX6eD9dP8KHLhQli1qd
	 vqhbSBtwUu3C4z8NY+wSciolchZa+EEeotAONS6DF+Fh2pI6GnRqtO2ulIDJlQkc8x
	 6JfvxBsyf0Kdg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 14 Nov 2025 00:35:04 +0530
Subject: [PATCH 03/13] dt-bindings: extcon: document Samsung S2M series
 PMIC extcon device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-s2mu005-pmic-v1-3-9e3184d3a0c9@disroot.org>
References: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
In-Reply-To: <20251114-s2mu005-pmic-v1-0-9e3184d3a0c9@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763060713; l=1764;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=2A0vaYHCECUQ8MIA/pdIwcaIxh6KIsr0+Y/dQwxtdiQ=;
 b=7vxIfbS2a86BEBcXUa8Q40B6lntie/YP9dyd6uLHB9SUBtSvOApAVyxC0kn0L350hUhQQpv9a
 clU35Nm9mL/DT/mETKMqYrFUJBzxU2XGgYmS8ENZ2+Zl+jpDtVKVNqD
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

Certain Samsung S2M series PMICs have a MUIC device which reports
various cable states by measuring the ID-GND resistance with an internal
ADC. Document the devicetree schema for this device.

The initial driver introduced has support for S2MU005, add its
compatible as well.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../bindings/extcon/samsung,s2mu005-muic.yaml      | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/extcon/samsung,s2mu005-muic.yaml b/Documentation/devicetree/bindings/extcon/samsung,s2mu005-muic.yaml
new file mode 100644
index 000000000000..8511bb96b47a
--- /dev/null
+++ b/Documentation/devicetree/bindings/extcon/samsung,s2mu005-muic.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/extcon/samsung,s2mu005-muic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Extcon Driver for Samsung S2M series PMICs
+
+maintainers:
+  - Kaustabh Chakraborty <kauschluss@disroot.org>
+
+description: |
+  The Samsung S2M series PMIC extcon device is a USB port accessory
+  detector. It reports multiple states depending on the ID-GND
+  resistance measured by an internal ADC.
+
+  This is a part of device tree bindings for S2M and S5M family of Power
+  Management IC (PMIC).
+
+  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml for
+  additional information and example.
+
+properties:
+  compatible:
+    enum:
+      - samsung,s2mu005-muic
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - port
+
+additionalProperties: false

-- 
2.51.2


