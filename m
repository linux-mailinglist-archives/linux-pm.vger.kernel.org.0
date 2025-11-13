Return-Path: <linux-pm+bounces-37972-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 067CFC599A3
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 20:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D0C93442E4
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 19:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BF93191A1;
	Thu, 13 Nov 2025 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="RKNIdMQv"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D4722A7F1;
	Thu, 13 Nov 2025 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060744; cv=none; b=BA6Q/XpJ+pXV3qcck1wLaTXSR1rh/hKXNdRwwj4Tyi8VpFpxhPYS790skZzL3zCwO9G0tgR3TzPzLNjry88RCNT+q2KFyWgER6IPewM/RLaARALpdXSuEODYHz2abOlRs3fUTnHf+t37mQZpSaXsEpGOu8R28viweycMmpH4+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060744; c=relaxed/simple;
	bh=p35Wpg53HadVAf/y3gORD2Wvr0ntA3gYZifzBDsKZRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GEg3stG5Lw8OjvVukagaj0l4dmmpuCUc1cDfNjGzwlxdtCdiWcDlPujVtZBWQcZsR3PEy7vig1CuLB10B587vABTLl8JmGM60pxBsObYf1AwHp1dKvYxQlNZ0zj27sEOt0XRXenXYRvqWO5AgFQzeC7ActizJEvxZ8qa6Mcr7Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=RKNIdMQv; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1756925F29;
	Thu, 13 Nov 2025 20:05:41 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tdMi48DZ0KF8; Thu, 13 Nov 2025 20:05:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1763060740; bh=p35Wpg53HadVAf/y3gORD2Wvr0ntA3gYZifzBDsKZRc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RKNIdMQvhtURGElGtYn+QIQGaxcx0bfR5moiL4+dC6QE0ZpnqWLil8W4s5WCyozz3
	 /7XXl27TLQmQ9nNUfWZVsWhp/YO7z/1doX8ZJSPiuOfZw4nxlVwJzsSW/zdMNDyUZY
	 e7CiH6GMd46UnIWO2yoCU0wL8ZDAEZUAhfd6X+6UCtQNcdQoRTqxt6C7C2NULC054c
	 RMQ1FUVeu8qeDQnsoze2uYTu0fGb478Uv4vBYs55pB898zcFM5BhEVCy01UTAZ7ybT
	 KiZn7D71KhR9MhdsN/4O55S5Nf6VmeUcg/dVBKAjigjP7CJgRBHizwaMir5RKFBgQ0
	 yCtF+HhWd5sOg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 14 Nov 2025 00:35:02 +0530
Subject: [PATCH 01/13] dt-bindings: leds: document Samsung S2M series PMIC
 flash LED device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-s2mu005-pmic-v1-1-9e3184d3a0c9@disroot.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763060713; l=1995;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=p35Wpg53HadVAf/y3gORD2Wvr0ntA3gYZifzBDsKZRc=;
 b=1duKGgGqKcJx6gWqR+AJaF02HwFjpvL9yDs1tQn+cuXFNxjBYbsbvlDtYSVU+vuwVMoHvUJy3
 jrerHm1z1XLAIFrG638FiGviyyKWTAtHo5S4SVgj/i2wtCOlw108cWJ
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

Certain Samsung S2M series PMICs have a flash LED controller with
two LED channels, and with torch and flash control modes. Document the
devicetree schema for the device.

The initial driver introduced has support for S2MU005, add its
compatible as well.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../bindings/leds/samsung,s2mu005-flash.yaml       | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/samsung,s2mu005-flash.yaml b/Documentation/devicetree/bindings/leds/samsung,s2mu005-flash.yaml
new file mode 100644
index 000000000000..496385003a03
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/samsung,s2mu005-flash.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/samsung,s2mu005-flash.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Flash and Torch LED Driver for Samsung S2M series PMICs
+
+maintainers:
+  - Kaustabh Chakraborty <kauschluss@disroot.org>
+
+description: |
+  The Samsung S2M series PMIC flash LED has two led channels (typically
+  as back and front camera flashes), with support for both torch and
+  flash modes.
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
+      - samsung,s2mu005-flash
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^led@[0-1]$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        enum: [0, 1]
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false

-- 
2.51.2


