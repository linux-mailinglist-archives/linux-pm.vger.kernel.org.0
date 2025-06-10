Return-Path: <linux-pm+bounces-28395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC791AD3E68
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 18:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6E0188F72D
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 16:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FDA23E346;
	Tue, 10 Jun 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9NnCBsX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C721A23C4F9;
	Tue, 10 Jun 2025 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571839; cv=none; b=Kl+yLjaG4TUbLjz7RbRRhwrQex93D6PLjvBe265ddo7lRLRdbHZoUHho7yxdTpAp8UxuBq4t+2bs6eBjATV1+rnReB3IE6NCEcdZB1B6T47DYZtM0jWBT2hRjXNiwy6yWkx7JIKKUn0cUWGPSUwG9dbDZBF9X4TMHGhDzC4llVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571839; c=relaxed/simple;
	bh=MpKAKeLwqqtr6InWSxHm2yFP1y7V+wBCfr1eih7q5s0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AtUHwWbIhvniRZMjH7g3+NLSY4E8ZP7i5C+RpGQW/ZyM+K4GuGGvObOAbrk1z0JLwSoK4BiTO3UvxfgL79KWOEq2shD9HWJeF5CafNu9CvORELO8i7lJ79RQu6mtWjUhy0voKNWNeT1cGBWvY3dMMP5IimayZeIxNrpYJFyymoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9NnCBsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7497DC4CEF5;
	Tue, 10 Jun 2025 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749571839;
	bh=MpKAKeLwqqtr6InWSxHm2yFP1y7V+wBCfr1eih7q5s0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G9NnCBsXt8kGCC4P2yV1eTkrcVdOd6slx53CgMZAGS/LwkaHgRpTU8sj9wqOSyP/5
	 l8gproc3g9WHGAT0m/AODgwchs1E6Tfu81klURZtvPjRw7JZEsJRzNbwsERFQFb1+C
	 B0QQoRcDDOU/6m3+uS/IBPegLuun/WtH8l7yZL6EFryazy9Qe6dfgjtlL8TKGYQkgW
	 PrOHxE2QD9bb4UVqlQgDZguX9ZAAf36hev8rlNz6KA0XgOuMHNVQtRU57LkU999g6P
	 kFy9gRWBdAK4rKH6FhqjVmIIv6ZuU0QClpxVNoGtgPEfE5MFylhUFJ101LmyzMWDyy
	 Z+4wwZl2EyoxA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AAFC71132;
	Tue, 10 Jun 2025 16:10:39 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Tue, 10 Jun 2025 15:29:44 +0000
Subject: [PATCH v7 03/10] dt-bindings: mfd: Add Apple Mac System Management
 Controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-smc-6-15-v7-3-556cafd771d3@kernel.org>
References: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
In-Reply-To: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Hector Martin <marcan@marcan.st>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Lee Jones <lee@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3512; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=MBhTLFSa+MA8vJScnTlr0fsDm4OGdrB/SyplsXOEjuQ=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ4aHf3FjV13HK+arrw96pNce/r7x/cGsvjkNtx8+Uhadv
 C//ftfSjlIWBjEOBlkxRZbt++1Nnzx8I7h006X3MHNYmUCGMHBxCsBE7B4x/Pdgd2xU5+ll2ytw
 bi6L02P2DtejZy2WvgieKndy2jo77i2MDCe+LGPj3LOmoH0e//eDD1Qni87zyQ3JSo83eaFZXnW
 5kBEA
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

Add a DT binding for the Apple Mac System Management Controller.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Sven Peter <sven@kernel.org>
---
 .../devicetree/bindings/mfd/apple,smc.yaml         | 79 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 80 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/apple,smc.yaml b/Documentation/devicetree/bindings/mfd/apple,smc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..8a10e270d421ecd703848f64af597de351fcfd74
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/apple,smc.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/apple,smc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple Mac System Management Controller
+
+maintainers:
+  - Sven Peter <sven@kernel.org>
+
+description:
+  Apple Mac System Management Controller implements various functions
+  such as GPIO, RTC, power, reboot.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t6000-smc
+          - apple,t8103-smc
+          - apple,t8112-smc
+      - const: apple,smc
+
+  reg:
+    items:
+      - description: SMC area
+      - description: SRAM area
+
+  reg-names:
+    items:
+      - const: smc
+      - const: sram
+
+  mboxes:
+    maxItems: 1
+
+  gpio:
+    $ref: /schemas/gpio/apple,smc-gpio.yaml
+
+  reboot:
+    $ref: /schemas/power/reset/apple,smc-reboot.yaml
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - mboxes
+
+examples:
+  - |
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      smc@23e400000 {
+        compatible = "apple,t8103-smc", "apple,smc";
+        reg = <0x2 0x3e400000 0x0 0x4000>,
+               <0x2 0x3fe00000 0x0 0x100000>;
+        reg-names = "smc", "sram";
+        mboxes = <&smc_mbox>;
+
+        smc_gpio: gpio {
+          compatible = "apple,smc-gpio";
+          gpio-controller;
+          #gpio-cells = <2>;
+        };
+
+        reboot {
+          compatible = "apple,smc-reboot";
+          nvmem-cells = <&shutdown_flag>, <&boot_stage>,
+                        <&boot_error_count>, <&panic_count>;
+          nvmem-cell-names = "shutdown_flag", "boot_stage",
+                             "boot_error_count", "panic_count";
+        };
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 1dd004f7dff669e3a3609e5f1702887129d8ff35..329b2df08d4b1039948e54353c5815e23ae65e77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2339,6 +2339,7 @@ F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
 F:	Documentation/devicetree/bindings/iommu/apple,sart.yaml
 F:	Documentation/devicetree/bindings/leds/backlight/apple,dwi-bl.yaml
 F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+F:	Documentation/devicetree/bindings/mfd/apple,smc.yaml
 F:	Documentation/devicetree/bindings/net/bluetooth/brcm,bcm4377-bluetooth.yaml
 F:	Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
 F:	Documentation/devicetree/bindings/nvmem/apple,efuses.yaml

-- 
2.34.1



