Return-Path: <linux-pm+bounces-37973-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 39013C599BE
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 20:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 01AB5350468
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 19:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC3F3195F8;
	Thu, 13 Nov 2025 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="OBvj3r/f"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6346B7262D;
	Thu, 13 Nov 2025 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060754; cv=none; b=SlGib0J+HPXb/OCe3oB3VopCi7nxP5IGmqmL6w1OyOiYhD9CvrsOniiXPg5F/ht/SjCAEVieOMBzYcXYtPWMIzklD6Iz8tqtXTmhsR0Q+LcQl9Vwb9cjOjioJeKYitnFTfEA7KrKhWWAx/8Zc77WlieyookWg0paBg8QBDvP5F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060754; c=relaxed/simple;
	bh=ffOLkRZ/7cBjGhLuCW214Ny9asZLrXHQNlgnuSxjMlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e5jDUPlPFEb19ejBF+/d9LL2ycz7HaRngM+stgvWxt0PBaFesl6tE9IBHdquP7E2yXZRyVfi2aJEJVif/EHoVlkCf6h879/HLKERzXVbOL0OFOEuEq1Ui2FGEwmW/ehHvC0fGbkWrlUAD6tjWXkBCWsxOP541XIaj4F9kIY7FBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=OBvj3r/f; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B8AF526746;
	Thu, 13 Nov 2025 20:05:51 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ZPF9h_X-kO2; Thu, 13 Nov 2025 20:05:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1763060750; bh=ffOLkRZ/7cBjGhLuCW214Ny9asZLrXHQNlgnuSxjMlo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OBvj3r/fDZ5EaCfelzXeavzDRersu5GlRjMZEcWCrT8C6e7f0SRgEoiAOQBB1Ry4A
	 TWS1pbBM6fjFBEnatYpRGCqKsBVpOF4qqS0U3a2d9qXvrxgAdQZrguF2LWqweJyZCn
	 1JzJ0M2XgubK9o8OO7LMScL03mqScX3DZ5ZbwNq/uoyO4Zg07UON4mhAhSG8NTWKOa
	 TI3kUWgjDTmCwt56kNNBK0qiY9W/+7HcuL2SMR+1QSwaKMP/vFmvsJgHJAQ04GZgJA
	 FmNSc2hpBLqVdGi1UsuJ91uTmhuwkbA9+iclGS6boD8VBUkPSUiM8g2pRkM+tIYY1h
	 n80EJrN0JhDSg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 14 Nov 2025 00:35:03 +0530
Subject: [PATCH 02/13] dt-bindings: leds: document Samsung S2M series PMIC
 RGB LED device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-s2mu005-pmic-v1-2-9e3184d3a0c9@disroot.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763060713; l=1749;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=ffOLkRZ/7cBjGhLuCW214Ny9asZLrXHQNlgnuSxjMlo=;
 b=m+avgylS0Nhr4hfYEuWiKa1iNJQ6hvPlfRnRGB8PsaA/MhjWpksbtv3DXqmt6Jx52fHn8OmtX
 F8YTmVl/TV0A2wU2Ntyh6Gt5d6/O3LNJ8/qoyP5gZGfl7y2L0Fo1yAM
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=

Certain Samsung S2M series PMICs have a three-channel LED device with
independent brightness control for each channel, typically used as
status indicators in mobile phones. Document the devicetree schema from
this driver.

The initial driver introduced has support for S2MU005, add its
compatible as well.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../bindings/leds/samsung,s2mu005-rgb.yaml         | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/samsung,s2mu005-rgb.yaml b/Documentation/devicetree/bindings/leds/samsung,s2mu005-rgb.yaml
new file mode 100644
index 000000000000..bad7080ff8f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/samsung,s2mu005-rgb.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/samsung,s2mu005-rgb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RGB LED Driver for Samsung S2M series PMICs
+
+maintainers:
+  - Kaustabh Chakraborty <kauschluss@disroot.org>
+
+description: |
+  The Samsung S2M series PMIC RGB LED is a three-channel LED device with
+  8-bit brightness control for each channel, typically used as status
+  indicators in mobile phones.
+
+  This is a part of device tree bindings for S2M and S5M family of Power
+  Management IC (PMIC).
+
+  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml for
+  additional information and example.
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - samsung,s2mu005-rgb
+
+required:
+  - compatible
+
+unevaluatedProperties: false

-- 
2.51.2


